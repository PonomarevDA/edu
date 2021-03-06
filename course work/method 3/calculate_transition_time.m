function transitionTime = calculate_transition_time(t, x)
%@brief Calculate transition time
%@param t - time vector with size (pointsAmount, 1)
%@param x - state variables matrix with size(pointsAmount, stateVariabelsAmount)
%@return transition time scalar 

pointsAmount = length(t);
transitionTime = 0;
initialDeviation = 10;
for i = pointsAmount : -1 : 1
	if abs(x(i, 3)) > 0.05*initialDeviation
        transitionTime = t(i);
        break;
	end
end
end

