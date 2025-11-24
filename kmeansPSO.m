function [data,x,gbestraw1,gbestraw2,gbestraw3,fitnessbest]=kmeansPSO(ss,N,s1,c1,c2)    %种群规模，分类数，迭代次数，学习因子1，2
%%原始数据 m为数据数，n为维度
x1=[6.885 11.350];
x2=[2.195 4.150];
x3=[3.820 8.425];
x4=[5.370 8.150];
x5=[1.845 3.675];
x6=[4.770 7.525];
x7=[2.930 5.650];
x8=[2.10 4.84];
x9=[0.14 4.32];
x10=[4.56 7.95];
x11=[4.8 8.21];
x12=[5.2 7.8];
x13=[1.3 4.23];
x14=[1.1 3.98];
x15=[2.0 3.55];
x16=[6.4 9.94];
x17=[6.2 10.4];
x18=[5.8 9.5];
x19=[4.9 8.31];
x20=[4.3 8.05];
x21=[6.74 10.77];
x22=[6.27 11.02];
x23=[6.91 11.14];
x24=[6.69 10.95];
x25=[6.81 10.47];
data0=[x1;x2;x3;x4;x5;x6;x7;x8;x9;x10;x11;x12;x13;x14;x15;x16;x17;x18;x19;x20;x21;x22;x23;x24;x25];   %data0 7*8double data
[m,n]=size(data0);              %m*n data
data1=zeros(size(data0));       %m*n zeros data

%归一化处理（无量纲处理）   %data1's all data is between 0~1
for i=1:n
    for j=1:m
        data1(j,i)=data0(j,i)/max(data0(:,i));
    end
end

%%随机生成100个初始聚类中心，也就是粒子的分布
center=zeros(N,n,ss);   %N为类数，ss为种群规模，n为数据维度
for s=1:ss              %为ss个中心组随机挑选N个粒子作为N个聚类中心
    data=data1;
    [m,~]=size(data);
    for r=1:N
        rand01=randi(m,1);%creat random number 1~m
        center(r,:,s)=data(rand01,:); %第一次随机产生聚类中心
        data(rand01,:)=[];
        m=m-1;
    end
    data=data1;
end

%%预设参数
wmax=0.9;
wmin=0.3;

%粒子初始位置x与初始速度v
x = zeros(N,n,ss,s1+1);
x(:,:,:,1)=center;
v=-0.05+0.10*rand(N,n,ss);

%计算适应度
fit=zeros(ss,1);    %每个聚类组的适应度
for s=1:ss
    fit(s)=test00(data,center(:,:,s));
    test00(data,center(:,:,s));
end

%计算个体极值和全局最好值
pbest=x(:,:,:,1);
gbest = zeros(N,n,s1+1);
ind1=find(min(fit)==fit);
gbest(:,:,1)=x(:,:,ind1(1),1);

%计算全局最差值
ind2=find(max(fit)==fit);
gbad=x(:,:,ind2(1),1);

fitnessbest = zeros(1,s1);

for k=1:s1
    for s=1:ss
        %%更新速度与位置
        if gbest(:,:,k)==gbad
            wc=wmin;
        else
            wc=wmin + (wmax-wmin)*(1-((fit(s)-test00(data,gbest(:,:,k)))/(test00(data,gbad)-test00(data,gbest(:,:,k))))^3)^5;%非线性权重调整
        end
        v(:,:,s)=wc.*v(:,:,s)+c1*rand.*(pbest(:,:,s)-x(:,:,s,k)) + c2*rand.*(gbest(:,:,k)-x(:,:,s,k));%自我与全局学习

        %设定粒子群的移动速度，使之在[-0.05,0.05]之内
        [g1,h1]=find(v(:,:,s)<-0.05);
        [g2,h2]=find(v(:,:,s)>0.05);
        v(g1,h1,s)=-0.05;
        v(g2,h2,s)=0.05;

       %设定粒子群的位置，使之在[0.02,1]之内
        x(:,:,s,k+1)=x(:,:,s,k)+0.5.*v(:,:,s);    %更新粒子群位置,更新至下一代
        [g3,h3]=find(x(:,:,s,k+1)<0.02);
        [g4,h4]=find(x(:,:,s,k+1)>1);
        x(g3,h3,s,k+1)=0.02;
        x(g4,h4,s,k+1)=1;

        %重新计算适应度
        fit(s)=test00(data,x(:,:,s,k+1));
        if fit(s)<test00(data,pbest(:,:,s))
            pbest(:,:,s)=x(:,:,s,k+1);
        end
        if test00(data,pbest(:,:,s))<test00(data,gbest(:,:,k+1))
            gbest(:,:,k+1)=pbest(:,:,s);
        end
    end
    id=kmeans(data,N,'distance','sqEuclidean','start',gbest(:,:,k)); %每完成一次迭代，用K_mean函数更新一次聚类中心
    fitnessbest(k)=test00(data,gbest(:,:,k));
end

%聚类结果及聚类效果评估
%figure;
%[S,~]=silhouette(data,id);
%si=mean(S);
%disp('si=');
%disp(si);

gbestraw1 = zeros(s1+1,3);
gbestraw2 = zeros(s1+1,3);
gbestraw3 = zeros(s1+1,3);
for i = 1:s1+1
    gbestraw1(i,1:2) = gbest(1,:,i);
    gbestraw2(i,1:2) = gbest(2,:,i);
    gbestraw3(i,1:2) = gbest(3,:,i);
    gbestraw1(i,3) = i;
    gbestraw2(i,3) = i;
    gbestraw3(i,3) = i;
end

function minJ=test00(data0,center0)
    [mm,nn]=size(data0);
    NN=size(center0,1);
    d0=zeros(1,NN);
    wcomb=zeros(mm,NN);

    for i0=1:mm
        for j0=1:NN
            dd=(data0(i0,:)-center0(j0,:)).^2;
            d0(1,j0)=sum(dd);
        end
        distance=min(d0);   %距离最小的分组的距离
        for z0=1:NN     %标记分组 w(每个粒子,每个类别)
            if distance == d0(z0)
                wcomb(i0,z0)=1;
            else
                wcomb(i0,z0)=0;
            end
        end
    end

    %构建函数
    a0=zeros(1,nn);
    a1=zeros(1,NN);
    a2=zeros(mm,1);
    for i1=1:mm
        for j1=1:NN
          for p=1:nn
             a0(1,p)=(data0(i1,p)-center0(j1,p)).^2;
          end
          a1(1,j1)=wcomb(i1,j1)*sum(a0);    %original code incorrect, the j1 debug from NN
       end
       a2(i1,1)=sum(a1);
    end
    minJ=sum(a2);
end
end
