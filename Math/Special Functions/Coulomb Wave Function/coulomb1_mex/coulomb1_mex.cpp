// calculate the coulomb (radial) function of the first kind
// default is Z = -1.
// F = coulomb1_mex(l,k,r,Z);
// 'l', 'Z', k' are a scalars and and 'r' is any shape
// 'Z' has default value '-1'.
// for compile instruction, see https://www.mathworks.com/help/matlab/matlab_external/c-mex-source-file.html

// TODO: implement [F, dF] = coulommb1_mex(l,k,r,Z,scaled)

#include <string>
#include "mex.hpp"
#include "mexAdapter.hpp"
#include "cwfcomp/cwfcomp.h"
using cwfcomp::Coulomb_wave_functions;
using cwfcomp::Comp;

using std::to_string; using std::string;
using namespace matlab::data;
using matlab::mex::ArgumentList;

class MexFunction : public matlab::mex::Function {
public:
    void operator()(ArgumentList outputs, ArgumentList inputs) {
        const double Z = checkArguments(outputs, inputs);
		const double l = inputs[0][0];
		const double k = inputs[1][0];
		
		Coulomb_wave_functions f(true, l, Z/k);
		Comp F, dF;
        TypedArray<double> doubleArray = std::move(inputs[2]);
        for (auto& elem : doubleArray) {
            f.F_dF(k*elem, F, dF);
			elem = real(F);
        }
        outputs[0] = doubleArray;
    }

    double checkArguments(ArgumentList outputs, ArgumentList inputs)
	{
        // Get pointer to engine
        std::shared_ptr<matlab::engine::MATLABEngine> matlabPtr = getEngine();

        // Get array factory
        ArrayFactory factory;

		double Z;
		if (inputs.size() < 3) {
            matlabPtr->feval(u"error",
                0,
                std::vector<Array>({ factory.createScalar("At least 3 inputs are required!") }));
        }

		if (inputs.size() == 4)
			Z = inputs[3][0];
		else
			Z = -1.;

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
		return Z;
    }
};
