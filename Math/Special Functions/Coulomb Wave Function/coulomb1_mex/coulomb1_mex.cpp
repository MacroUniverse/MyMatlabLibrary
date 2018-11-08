// calculate the coulomb (radial) function of the first kind
// default is Z = -1.
// F = coulomb1_mex(l,k,r,Z,scaled);
// 'l', 'Z', k' are a scalars and and 'r' is any shape
// 'Z' has default value '-1'.
// 'scaled' default is 'true'
// for compile instruction, see https://www.mathworks.com/help/matlab/matlab_external/c-mex-source-file.html

// TODO: implement [F, dF] = coulommb1_mex(l,k,r,Z,scaled)

#include <string>
#include "mex.hpp"
#include "mexAdapter.hpp"
#include "cwfcomp/cwfcomp.h"
using cwfcomp::Coulomb_wave_functions;
using cwfcomp::Comp;

using std::to_string; using std::string; using std::abs;
using namespace matlab::data;
using matlab::mex::ArgumentList;

class MexFunction : public matlab::mex::Function {
public:
    void operator()(ArgumentList outputs, ArgumentList inputs) {
        double Z;
		bool scaled;
		checkArguments(Z, scaled, outputs, inputs);
		const double l = inputs[0][0];
		const double k = inputs[1][0];
		
		Coulomb_wave_functions f(true, l, Z/k);
		Comp F, dF;
        TypedArray<double> r = std::move(inputs[2]);

		if (scaled) // scaled wave function (default)
			for (auto& r1 : r) {
				f.F_dF(k*r1, F, dF);
				r1 = real(F);
			}
		else // unscaled wave function
			for (auto& r1 : r) {
				f.F_dF(k*r1, F, dF);
				if (abs(r1) > 2e-16)
					r1 = real(F)/r1;
				else
					r1 = real(dF)*k; // use L'Hospital
			}
        outputs[0] = r;
    }

    void checkArguments(double &Z, bool &scaled, ArgumentList &outputs, ArgumentList &inputs)
	{
        // Get pointer to engine
        std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

        // Get array factory
        ArrayFactory factory;

		if (inputs.size() < 3) {
            matlabPtr->feval(u"error",
                0,
                std::vector<Array>({ factory.createScalar("At least 3 inputs are required!") }));
        }

		if (inputs.size() == 4 && inputs[3].getNumberOfElements() > 0)
			Z = inputs[3][0];
		else
			Z = -1.;

		if (inputs.size() == 5 && inputs[4].getNumberOfElements() > 0)
			scaled = inputs[4][0];
		else
			scaled = true;

        // Check first input argument
        if (!(inputs[0].getType() == ArrayType::DOUBLE ||
             inputs[0].getType() == ArrayType::COMPLEX_DOUBLE) || inputs[0].getNumberOfElements() != 1)
        {
            matlabPtr->feval(u"error",
                0,
                std::vector<Array>({ factory.createScalar("Second input (k) must be double or complex scalar!") }));
        }

        // Check second input argument
        if (!(inputs[0].getType() == ArrayType::DOUBLE ||
             inputs[0].getType() == ArrayType::COMPLEX_DOUBLE) || inputs[0].getNumberOfElements() != 1)
        {
            matlabPtr->feval(u"error",
                0,
                std::vector<Array>({ factory.createScalar("Second input (k) must be double or complex scalar!") }));
        }

		// Check third input argument
        if (!(inputs[0].getType() == ArrayType::DOUBLE ||
             inputs[0].getType() == ArrayType::COMPLEX_DOUBLE))
        {
            matlabPtr->feval(u"error",
                0,
                std::vector<Array>({ factory.createScalar("Third input (k) must be double or complex!") }));
        }

        // Check number of outputs
        if (outputs.size() > 1) {
            matlabPtr->feval(u"error",
                0,
                std::vector<Array>({ factory.createScalar("Only one output is returned") }));
        }
    }
};
