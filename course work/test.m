clc; clear; close all;
syms a11 a12 a21 a22 b11 b21 k1 k2 k3 k4 s w0
A = [a11	a12     0       b11;	% ������� �������� �������� �����_�
     a21	a22     0       b21;	% ���� ������ �����
     1      0       0       0;      % ���� �������� ��
     -k1	-k2     -k3     -k4]	% ���� ���������� ���� ������_� (�� ������ 35 ��������)
I = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
A - s*I
det(A - s*I)
binomialPolynomial = 1*w0^0*s^4 + 4*w0^1*s^3 + 6*w0^2*s^2 + 4*w0^3*s^1 + 1*w0^4*s^0






clear; close all;
V0 = 6.17;
L = 39;
r21 = -0.69;
r31 = 6.14;
q21 = 1.22;
q31 = -3.12;
s21 = -0.44;
s31 = -3.1;

W = V0/L;
a11 = -r31*W;
a12 = -q31*W^2;
a21 = -r21;
a22 = -q21*W;
b11 = -s31*W^2;
b21 = -s21*W;
w0 = 2;

syms k1 k2 k3 k4
characteristicPolynomial = [1; ... %s^4
                            k4 - a22 - a11; ... %s^3
                            a11*a22 - a12*a21 - a11*k4 - a22*k4 + b11*k1 + b21*k2; ... %s^2
                            b11*k3 - a11*b21*k2 + a12*b21*k1 + a21*b11*k2 - a22*b11*k1 + a11*a22*k4 - a12*a21*k4; ... %s^1
                            a12*b21*k3 - a22*b11*k3];
binomialPolynomial = [1*w0^0; ... %s^4
                      4*w0^1; ... %s^3
                      6*w0^2; ... %s^2
                      4*w0^3; ... %s^1
                      1*w0^4]     %s^0
[sk1, sk2, sk3, sk4] = solve(characteristicPolynomial(1) == binomialPolynomial(1), ...
                             characteristicPolynomial(2) == binomialPolynomial(2), ...
                             characteristicPolynomial(3) == binomialPolynomial(3), ...
                             characteristicPolynomial(4) == binomialPolynomial(4), ...
                             characteristicPolynomial(5) == binomialPolynomial(5));
                         
k_root = [double(sk1), double(sk2), double(sk3), double(sk4)]

A = [a11        a12         0           b11;
     a21        a22         0           b21;
     1          0           0           0;
     -k_root(1)	-k_root(2)	-k_root(3)	-k_root(4)]
roots(poly(A))