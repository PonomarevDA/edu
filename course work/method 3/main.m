clc; clear; close all;

% ����� 3. ��������� �����. ����������� �������.
w0 = 0.3;
[w, time] = fminsearch('fminearch_function', w0)