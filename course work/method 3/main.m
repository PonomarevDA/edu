clc; clear; close all;

% ����� 1. ������ �����. ������������ ��������������.
%do_maximum_speed_method()

% ����� 3. ��������� �����. ����������� �������.
w0 = 0.3;
[w, time] = fminsearch('fminearch_function', w0)