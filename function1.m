%N = 50;
%c1 = 1.5;
%c2 = 2.5;
%w = 0.5;
%M = 500;

function [xm,fv,Pbest] = function1(N,c1,c2,w,M)
    [xm,fv,Pbest] = PSO(@fitness1,N,c1,c2,w,M,30);
end

function F=fitness1(x)
    F = 0;
    for i = 1:30
        F = F+x(i)^2+x(i)-6;
    end
end