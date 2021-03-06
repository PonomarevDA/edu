function transitionTime = fminearch_function(w0)
%@brief This function is used by fminsearch()
%@param w0 - base frequency
%@return transition time

% Step 1. Define global variable and some constans:
global K
x0 = [0 0 10 0];
maxTransitionTime = 40;

% Step 2. Calculate data for system and graph:
calculate_system_parameters(w0);
[t, x] = ode45('odefun', [0 maxTransitionTime], x0);
transitionTime = calculate_transition_time(t, x);

% Step 3. Show data:
fprintf("w0 = %f, t = %f, k = [%f, %f, %f, %f]\n", w0, transitionTime, K);

% Step 4. Show graphs:
subplot(3, 1, 1); plot(t, x(:, 1:4)); grid on;
legend('����� - ������� �������� ��������', ...
       '����� - ���� ������', ...
       '�� - ���� ��������', ...
       '������ - ���� ���������� ����')
title('�� ������� �������� ��������, ���� ������, ���� �������� � ���� ���������� ����')
subplot(3, 1, 2); plot(t, control_impact(x')); grid on;
title('���������� �������� ������������ �����������')
subplot(3, 1, 3); plot(t, x(:,4)); grid on;
title('���������� �������� ���� ����')

pause(0.1)
end

