%寻找e^(-x^2/200)*cos(x)的最大值
%返回每一代的n点（一维）
%N      点的个数
%a      自适应系数
%b      邻域适应系数
%c      全域适应系数
%M      迭代次数

%邻域大小应大于50/8=6.25

function [xtotal,ptotal,pgtotal,pntotal] = function2(N,a,b,c,M)

% 初始化种群的个体（可以在这里限定位置和速度的范围）
format long;
x = zeros(1,N);
for i = 1:N
    x(i) = (rand-0.5)*50;
end

% 初始化p和pg和pn
p = x;      %一代的自我历史最佳位置点

pg = x(N);  % pg为一代的全局最优点
for i=1:(N-1)
    if(fitness(x(i))>fitness(pg))
        pg = x(i);
    end
end

pn = x;     %pn为一代的邻域最优点
for i = 1:N
    for j = 1:N
        if x(j)-x(i)<=6.25 && fitness(x(j))>fitness(pn(i))
            pn(i) = x(i);
        end
    end
end

% 进入主要循环，按照公式依次迭代，直到满足精度要求
thex = zeros(M,N);  %每一代点的位置
thept = zeros(M,N); %每一代点的最优解
thepn = zeros(M,N); %每一代邻域最优点的位置
thepg = zeros(1,M);   %每一代全局最优点的位置
for t=1:M
    thex(t,:) = x;
    thept(t,:) = p;
    thepg(t) = pg;
    thepn(t,:) = pn;
    for i=1:N
        x(i)=x(i)+a*(p(i)-x(i))+b*(pn(i)-x(i))+c*(pg-x(i));     % 更新位移
        if fitness(x(i)) > fitness(p(i))             %更新自我最优解
            p(i)=x(i);
        end
        if fitness(x(i)) > fitness(pg)       %更新全局最优解
            pg=x(i);
        end
        for j = 1:N                     %更新邻域最优解
            if x(j)-x(i)<=7.5 && fitness(x(j))>fitness(pn(i))
                pn(i) = x(j);
            end
        end
    end
end

%输出结果
xtotal = thex;
ptotal = thept;
pgtotal = thepg;
pntotal = thepn;
end

function y = fitness(x)
    y = exp(-(x*x)/200)*cos(x);
end
