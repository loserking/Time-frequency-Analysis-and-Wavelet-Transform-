clc
clear all
close all
t = [0: 0.01: 10];
x = 0.2*t + cos(2*pi*t) + 0.4*cos(10*pi*t);
thr = 0.2;
y = hht(x, t, thr);