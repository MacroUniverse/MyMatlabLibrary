%% Wave Equation on a Square Domain
% This example shows how to solve the wave equation using the |hyperbolic|
% function in the Partial Differential Equation Toolbox(TM).
%
% We solve the standard second-order wave equation
%
% $$ \frac{\partial^2 u}{\partial t^2} - \Delta u = 0$$
%
% on a square domain with zero Dirichlet boundary conditions on left and
% right and zero Neumann boundary conditions on the top and bottom.

% Copyright 1994-2012 The MathWorks, Inc.
% $Revision: 1.1.6.3 $ $Date: 2012/02/06 17:27:48 $

%% Problem Definition
% The following variables will define our problem:
%%
% * |g|: A specification function that is used by |initmesh|. For more
% information, please see the documentation page for |squarereg| and |pdegeom|.
% * |b|: A boundary file used by |assempde|. For more
% information, please see the documentation pages for
% |squareb3| and |pdebound|.
% * |c|, |a|, |f|, |d|: The coefficients of the PDE.
g='squareg';
b='squareb3';
c=1;
a=0;
f=0;
d=1;
%% Generate Mesh
[p,e,t]=initmesh('squareg');
figure;
pdemesh(p,e,t); axis equal
%% Generate Initial Conditions
% The initial conditions:
%%
% * $u(x,0)=\arctan\left(\cos\left(\frac{\pi x}{2}\right)\right)$.
% * $\left.\frac{\partial u}{\partial t}\right|_{t=0} = 3\sin(\pi x)
% \exp\left(\sin\left(\frac{\pi y}{2}\right)\right)$.
%%
% This choice avoids putting energy into the higher vibration modes
% and permits a reasonable time step size.
x=p(1,:)';
y=p(2,:)';
u0=atan(cos(pi/2*x));
ut0=3*sin(pi*x).*exp(sin(pi/2*y));
%% Define Time-Discretization
% We want the solution at 31 points in time between 0 and 5.
n=31;
tlist=linspace(0,5,n);
%% Find FEM Solution
uu=hyperbolic(u0,ut0,tlist,b,p,e,t,c,a,f,d);
%% Animate FEM Solution
% To speed up the plotting, we interpolate to a rectangular grid.
figure; set(gcf,'renderer','zbuffer');
delta=-1:0.1:1;
[uxy,tn,a2,a3]=tri2grid(p,t,uu(:,1),delta,delta);
gp=[tn;a2;a3];
newplot;
umax=max(max(uu));
umin=min(min(uu));
for i=1:n
    pdeplot(p,e,t,'xydata',uu(:,i),'zdata',uu(:,i),'zstyle','continuous',...
                  'mesh','off','xygrid','on','gridparam',gp,'colorbar','off');
    axis([-1 1 -1 1 umin umax]); caxis([umin umax]);
    M(i)=getframe;
end
movie(M,1);


displayEndOfDemoMessage(mfilename)