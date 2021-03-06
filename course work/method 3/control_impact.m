function u = control_impact(x)
%@brief Calculate control impact u = -K1*x1 - K2*x2 - K3*x3 - K4*x4
%@param x - state variables with size (pointsAmount, stateVariablesAmount)
%@return control impact with size(pointsAmount, 1)
%@note u <= |Umax|
global K
Umax = 1;
u = -K(1).*x(1, :) - K(2).*x(2, :) - K(3).*x(3, :) - K(4).*x(4, :);
for i = 1:length(u)
    if u(i) > Umax
        u(i) = Umax;
    elseif u(i) < -Umax
        u(i) = -Umax;
    end
end
end
