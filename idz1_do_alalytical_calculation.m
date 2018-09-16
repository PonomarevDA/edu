function idz1_do_alalytical_calculation(delta_add, delta)
% Create plot and display calculated data
% ��������������, ��� ������� ��������� ��������� � ����������� <= 3

global A;
t = 0:0.01:5;

disp('1. �������� x(s):')
if length(delta_add) == 3
    fprintf('%d*s^2 + %d*s + %d\n', delta_add)
else
    fprintf('%d*s + %d\n', delta_add)
end
fprintf('---------------------------\n')
fprintf('%d*s^3 + %d*s^2 + %d*s + %d\n\n', delta)

disp('2. ����� ��:')
disp(roots(delta))

disp('3. ����������� ����������� x(s)')
disp('��������')
disp(' ')

disp('4. ����� ����� ������� �������������� �������, ����� ��������� �� ���������� �����:')
[r, p, k] = residue(delta_add, delta);

disp('����������� �� ���������� ����� x(s):')
fprintf('%f + %fj              %f + %fj               %f + %fj\n', real(r(1)), imag(r(1)), real(r(2)), imag(r(2)), real(r(3)), imag(r(3)))
fprintf('---------------------------  +  ---------------------------  +  ---------------------------\n')
fprintf('s - (%f + %fj)      s - (%f + %fj)      s - (%f + %fj)\n', real(p(1)), imag(p(1)), real(p(2)), imag(p(2)), real(p(3)), imag(p(3)))
disp('���������� �����-�� ����, ��� ��-�� ���������� �����.')
disp(' ')

disp('5. ���������� ������ ��� ���������� ����� � ����:')
num = conv(r(1), [1 -p(2)]) + conv(r(2), [1 -p(1)]);
den = conv([1 -p(1)], [1 -p(2)]);
fprintf('%f*s + %f\n', num)
fprintf('---------------------------\n')
fprintf('%f*s^2 + %f*s + %f\n', den)
disp('��� ���-�� �����.')
disp(' ')

disp('6. "������" ��������������:')
disp('� ������ ����� �������� "���������" �����:')
fprintf('     Ai*(s-L)                   Bi*w              Ci\n')
fprintf('------------------  +  ------------------  +  --------\n')
fprintf('(s-lambda)^2 + w^2     (s-lambda)^2 + w^2     s-lambda\n\n')
disp('�� ������� ����� (��� ��� �������) �������� "�������������" �����:')
fprintf('     Ai*s + Bi             Ci\n')
fprintf('------------------  +  --------\n')
fprintf('(s-lambda)^2 + w^2     s-lambda\n\n')
disp('� � ��� ���:')
if length(delta_add) == 3
    fprintf('%d*s^2 + %d*s + %d\n', delta_add)
else
    fprintf('%d*s + %d\n', delta_add)
end
fprintf('--------------------------------\n')
fprintf('((s-lambda)^2 + w^2) * (s-lambda)\n\n')
disp('�����:')
disp('(As+B)(s-L) + C[(s-L)^2 + w^2] = !num!')
disp('As^2 - AsL + Bs - BL + Cs^2 - 2*s*L*C + CL^2 + C*w^2 = !num!')
disp('������ ������� ���������:')
disp(' ')

lambda1 = real(p(1));
lambda2 = real(p(3));
w = abs(imag(p(2)));
A1 = num(1);
B1 = (A1*lambda1 + num(2))/w;
C1 = r(3);

matrix = zeros(3);
matrix(1, 1) = 1;           % A*s^2
matrix(1, 3) = 1;           % C*s^2
matrix(2, 1) = -lambda2;     % -A*s*L2
matrix(2, 2) = 1;           % B*s
matrix(2, 3) = -2*lambda1;   % - 2*s*L1*C
matrix(3, 2) = -lambda2;     % - B*L2
matrix(3, 3) = lambda1^2+w^2;% C*L1^2 + C*w^2
if length(delta_add) == 3
    delta_add = delta_add';
    rootsABC = matrix\(delta_add);
elseif length(delta_add) == 2
    delta_add = [0; delta_add'];
    rootsABC = matrix\delta_add;
else 
    delta_add = [0; 0; delta_add];
    rootsABC = matrix\delta_add;
end

for count = 1:length(delta_add)
    fprintf('%f*A + %f*B + %f*C = %f\n', matrix(count, 1:3), delta_add(count))
end
fprintf('\n�������� ������������:\n')
fprintf('Ai = %f, Bi = %f, Ci = %f\n\n', rootsABC)

fprintf('�������� ������������� �����:\n')
fprintf('%f*s + %f      %f\n', rootsABC)
fprintf('-----------------------  +  -----------\n')
fprintf('(s-lambda)^2 + w^2            s-lambda\n\n')

fprintf('�������� (���������) �����:\n')
fprintf('     Ai*(s-L1)                   Bi*w              Ci\n')
fprintf('------------------  +  ------------------  +  --------\n')
fprintf('(s-lambda1)^2 + w^2     (s-lambda1)^2 + w^2     s-lambda2\n\n')
fprintf('%f*(s-L1)          %f*w           %fi\n', rootsABC(1), (rootsABC(2) + rootsABC(1)*lambda1)/w, rootsABC(3))
fprintf('------------------  +  ------------------  +  --------\n')
fprintf('(s-lambda1)^2 + w^2     (s-lambda1)^2 + w^2     s-lambda2\n\n')

disp('7. ������������� ������:')
fprintf('x(t) = \n')
fprintf('%f * cos(%f*t) * e^(%f*t) +\n%f * sin(%f*t) * e^(%f*t)\n\n', A1, w, lambda1);
fprintf('%f * sin(%f*t) * e^(%f*t)\n', B1, w, lambda1);
fprintf('%f * e^(%f*t) +\n\n', r(3), p(3));

disp('8. For fun ����������� ����� ������:')
fprintf('x(t) = \n')
fprintf('(%f+ %fj) * e^(t*(%f+ %fj)) + ', real(r(2)), imag(r(2)), real(p(2)), imag(p(2)))
fprintf('(%f+ %fj)*e^(t*(%f+ %fj))\n\n', real(r(1)), imag(r(1)), real(p(1)), imag(p(1)))

%plot(t, r(3)*exp(t*p(3)) + r(2)*exp(t*p(2)) + r(1)*exp(t*p(1))) % accuraty
plot(t, C1*exp(t*lambda2) + A1*cos(w*t).*exp(lambda1*t) + B1*sin(w*t).*exp(lambda1*t)) % analytical

end

