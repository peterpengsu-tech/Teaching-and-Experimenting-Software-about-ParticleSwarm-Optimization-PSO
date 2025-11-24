% 新建界面
clear;
clc;
f = figure('Units','pixels','Position',[10 60 432 768],'menu','none');

%界面
homepanel = uipanel('Parent',f,'Visible','on','Units','normalized','Position',[0 0.05 1 0.95]); %键值1
conpanel = uipanel('Parent',f,'Visible','off','Units','normalized','Position',[0 0.05 1 0.95]); %键值2
apppanel = uipanel('Parent',f,'Visible','off','Units','normalized','Position',[0 0.05 1 0.95]); %键值3
exerpanel = uipanel('Parent',f,'Visible','off','Units','normalized','Position',[0 0.05 1 0.95]);%键值4

combpanel = uipanel('Parent',f,'Visible','off','Units','normalized','Position',[0 0.05 1 0.95]);%键值5
numpanel = uipanel('Parent',f,'Visible','off','Units','normalized','Position',[0 0.05 1 0.95]);%键值6

conshowpanel = uipanel('Parent',conpanel,'Units','normalized','position',[0 -0.8 1 0.7]);
conrespanel = uipanel('Parent',conpanel,'Units','normalized','position',[0 -1.68 1 0.6]);

%界面子坐标
context = axes('Parent',conpanel,'Units','normalized','position',[0 0.5 1 0.5]);
set(context,'visible','off');

%当前界面
global cpanel;
cpanel = 1;

%界面关系
global selfp parent parentpanel;
selfp = [homepanel,conpanel,apppanel,exerpanel,combpanel,numpanel];
parent = [homepanel,homepanel,homepanel,homepanel,apppanel,apppanel];
parentpanel = [1 1 1 1 3 3];

%导航按钮外观
bback = uicontrol('Parent',f,'style','pushbutton','units','normalized','string','back','Position',[0 0 0.333 0.05]);
bhome = uicontrol('Parent',f,'style','pushbutton','units','normalized','string','home','Position',[0.334 0 0.333 0.05]);
bprocess = uicontrol('Parent',f,'style','pushbutton','units','normalized','string','process','Position',[0.667 0 0.333 0.05]);

%主题按钮外观
concepts = uicontrol('Parent',homepanel,'style','pushbutton','units','normalized','string','基本介绍','FontSize',17,'Position',[0 0.92 1 0.08]);
classicapps = uicontrol('Parent',homepanel,'style','pushbutton','units','normalized','string','经典应用','FontSize',17,'Position',[0 0.84 1 0.08]);
exercise = uicontrol('Parent',homepanel,'style','pushbutton','units','normalized','string','课后练习','FontSize',17,'Position',[0 0.76 1 0.08]);

%导航按钮功能
bback.Callback = {@backF};
bhome.Callback = {@homeF};

%主题按钮功能
concepts.Callback = {@conF,conpanel,context,conshowpanel,conrespanel};
classicapps.Callback = {@appF,apppanel};
exercise.Callback = {@exerF,exerpanel};

%conpanel显示
text1 = text('Parent',context,'string','粒子群算法的基础知识','horizontalalignment','center','fontsize',20,'Units','normalized','position',[0.5 0.92]);
text2 = text('Parent',context,'string','\diamondsuit提出者','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.8]);
text3 = text('Parent',context,'string',{'    1995年，美国社会心理学家James Kennedy和电气工';
                                        '程师Russell Eberhart共同提出了粒子群算法，模拟成群';
                                        '的鸟、鱼或者浮游生物的觅食和逃避捕食者的行为。'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.05 0.65]);
text4 = text('Parent',context,'string','\diamondsuit个体的学习行为','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.5]);
text5 = text('Parent',context,'string',{'\bullet自我学习：总结自己历史经验';
                                        '\bullet邻域学习：观察周边同伴行为';
                                        '\bullet全域学习：向全局最优者看齐'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.07 0.35]);
text6 = text('Parent',context,'string','\diamondsuit简化的个体学习过程','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.2]);
text7 = text('Parent',context,'string',{'\bullet每个个体都代表问题的一个可行解';
                                        '\bullet个体会记忆自己历史上所曾经找到的最好解';
                                        '\bullet根据个体之间在解空解中的距离（不同的问题可以有';
                                        '  不同的距离定义），将所有个体聚类分成若干邻域';
                                        '\bullet当代的所有个体构成当代的全域'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.07 -0.01]);
text8 = text('Parent',context,'string','\diamondsuit简化的个体学习行为','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 -0.22]);
text9 = text('Parent',context,'string',{'\bullet自我学习：试图缩小与自己历史最好解的解空解距离';
                                        '\bullet邻域学习：试图缩小与当前邻域最好解的解空解距离';
                                        '\bullet全域学习：试图缩小与当前全域最好解的解空解距离'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.07 -0.36]);
text10 = text('Parent',context,'string','\diamondsuit粒子群算法的设计','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 -0.5]);
text11 = text('Parent',context,'string',{'\bullet自我学习后的解 = 个体当前解 + a×';
                                        '                               (个体历史最好解 - 个体当前解)';
                                        '\bullet邻域学习后的解 = 个体当前解 + b×';
                                        '                               (邻域当前最好解 - 个体当前解)';
                                        '\bullet全域学习后的解 = 个体当前解 + c×';
                                        '                               (全域当前最好解 - 个体当前解)'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.07 -0.73]);
textnew1 = text('Parent',context,'string','\diamondsuit粒子群算法的运行过程演示','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 -0.95]);
textnew2 = text('Parent',context,'string',{'    下面是粒子群算法的动态演示，其中横坐标代表每一';
                                        '个粒子的位置，纵坐标代表每一个粒子的值（适应度），';
                                        '每一个粒子的运动目标是寻找自身适应度最大值。'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.05 -1.08]);
textnew3 = text('Parent',context,'string','\diamondsuit粒子群算法的运行结果分析','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 -2.66]);
textnew4 = text('Parent',context,'string',{'    上面的每一群粒子最后找到的最佳值都会被记录下来，';
                                           '与等算量的随机查找找到的最大值进行比较。每一粒子群';
                                           '在运动中得到的随时间变化的最大值以折线图的形式画出';
                                           '来，不同颜色为不同粒子群的折线图。'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 -2.82]);

conshow = axes('Parent',conshowpanel,'Units','normalized','position',[0.1 0.45 0.8 0.47],'nextplot','add','xlim',[-25 24.9]);
x = -25:0.1:24.9;
plot(conshow,x,exp(-(x.*x)/200).*cos(x));
text12 =  uicontrol('Parent',conshowpanel,'style','text','units','normalized','string','粒子群算法的基础演示','FontSize',17,'Position',[0 0.95 1 0.05]);
f2Ntext = uicontrol('Parent',conshowpanel,'style','text','units','normalized','string','种群数量','FontSize',16,'Position',[0 0.28 0.4 0.06]);
f2atext = uicontrol('Parent',conshowpanel,'style','text','units','normalized','string','自我学习系数a','FontSize',16,'Position',[0 0.22 0.4 0.06]);
f2btext = uicontrol('Parent',conshowpanel,'style','text','units','normalized','string','邻域学习系数b','FontSize',16,'Position',[0 0.16 0.4 0.06]);
f2ctext = uicontrol('Parent',conshowpanel,'style','text','units','normalized','string','全域学习系数c','FontSize',16,'Position',[0 0.1 0.4 0.06]);
f2Mtext = uicontrol('Parent',conshowpanel,'style','text','units','normalized','string','最大迭代次数','FontSize',16,'Position',[0 0.04 0.4 0.06]);
f2N = uicontrol('Parent',conshowpanel,'style','edit','units','normalized','string','20','FontSize',17,'Position',[0.4 0.28 0.15 0.06]);
f2a = uicontrol('Parent',conshowpanel,'style','edit','units','normalized','string','0.01','FontSize',17,'Position',[0.4 0.22 0.15 0.06]);
f2b = uicontrol('Parent',conshowpanel,'style','edit','units','normalized','string','0.01','FontSize',17,'Position',[0.4 0.16 0.15 0.06]);
f2c = uicontrol('Parent',conshowpanel,'style','edit','units','normalized','string','0.01','FontSize',17,'Position',[0.4 0.1 0.15 0.06]);
f2M = uicontrol('Parent',conshowpanel,'style','edit','units','normalized','string','200','FontSize',17,'Position',[0.4 0.04 0.15 0.06]);
f2manual = uicontrol('Parent',conshowpanel,'style','pushbutton','units','normalized','string','手动迭代','FontSize',15,'Position',[0.57 0.34 0.2 0.05],'backgroundcolor',[0.8 0.8 0.8]);
f2auto = uicontrol('Parent',conshowpanel,'style','pushbutton','units','normalized','string','自动迭代','FontSize',10,'Position',[0.77 0.34 0.2 0.05],'backgroundcolor',[1 1 1]);
f2manpanel = uipanel('Parent',conshowpanel,'Units','normalized','position',[0.56 0.03 0.43 0.32],'visible','on');
f2autopanel = uipanel('Parent',conshowpanel,'Units','normalized','position',[0.56 0.03 0.43 0.32],'visible','off');
f2conti1 = uicontrol('Parent',f2manpanel,'style','pushbutton','units','normalized','string','迭代1代','FontSize',14,'Position',[0.02 0.75 0.45 0.2]);
f2conti5 = uicontrol('Parent',f2manpanel,'style','pushbutton','units','normalized','string','迭代10代','FontSize',14,'Position',[0.52 0.75 0.45 0.2]);
f2back1 = uicontrol('Parent',f2manpanel,'style','pushbutton','units','normalized','string','返回前1代','FontSize',12,'Position',[0.02 0.5 0.45 0.2]);
f2back5 = uicontrol('Parent',f2manpanel,'style','pushbutton','units','normalized','string','返回前10代','FontSize',11,'Position',[0.52 0.5 0.45 0.2]);
f2currtext = uicontrol('Parent',f2manpanel,'style','text','units','normalized','string','当前代数','FontSize',14,'Position',[0.02 0.26 0.45 0.16]);
f2curr = uicontrol('Parent',f2manpanel,'style','text','units','normalized','string','1','FontSize',14,'Position',[0.52 0.26 0.45 0.16],'backgroundcolor',[0.85 0.85 0.85]);
f2reset = uicontrol('Parent',f2manpanel,'style','pushbutton','units','normalized','string','换一群粒子','FontSize',14,'Position',[0.02 0.02 0.96 0.2]);
f2autoconti = uicontrol('Parent',f2autopanel,'style','pushbutton','units','normalized','string','开始/继续','FontSize',14,'Position',[0.2 0.75 0.6 0.2]);
f2autopause = uicontrol('Parent',f2autopanel,'style','pushbutton','units','normalized','string','暂停','FontSize',14,'Position',[0.2 0.5 0.6 0.2]);
f2autocurrtext = uicontrol('Parent',f2autopanel,'style','text','units','normalized','string','当前代数','FontSize',14,'Position',[0.02 0.26 0.45 0.16]);
f2autocurr = uicontrol('Parent',f2autopanel,'style','text','units','normalized','string','1','FontSize',14,'Position',[0.52 0.26 0.45 0.16],'backgroundcolor',[0.85 0.85 0.85]);
f2autoreset = uicontrol('Parent',f2autopanel,'style','pushbutton','units','normalized','string','换一群粒子','FontSize',14,'Position',[0.02 0.02 0.96 0.2]);

global xtotal ptotal pgtotal pntotal;
[xtotal,ptotal,pgtotal,pntotal] = function2(20,0.01,0.01,0.01,200);
a = str2double(f2curr.String);
f2swarm = plot(conshow,xtotal(a,:),exp(-(xtotal(a,:).*xtotal(a,:))/200).*cos(xtotal(a,:)),'ro');
f2pg = plot(conshow,pgtotal(a),exp(-(pgtotal(a)*pgtotal(a))/200)*cos(pgtotal(a)),'go');

conres = axes('Parent',conrespanel,'Units','normalized','position',[0.15 0.5 0.8 0.47],'nextplot','add');
xlabel(conres,'迭代次数');
ylabel(conres,'最大适应值');
connumtext = uicontrol('Parent',conrespanel,'style','text','units','normalized','string','实验次数','FontSize',14,'Position',[0.2 0.35 0.3 0.05]);
connum = uicontrol('Parent',conrespanel,'style','text','units','normalized','string','0','FontSize',14,'Position',[0.2 0.3 0.3 0.05],'backgroundcolor',[0.85 0.85 0.85]);
conevtext = uicontrol('Parent',conrespanel,'style','text','units','normalized','string','平均最大值','FontSize',14,'Position',[0.5 0.35 0.3 0.05]);
conev = uicontrol('Parent',conrespanel,'style','text','units','normalized','string','0','FontSize',14,'Position',[0.5 0.3 0.3 0.05],'backgroundcolor',[0.85 0.85 0.85]);
conthistext = uicontrol('Parent',conrespanel,'style','text','units','normalized','string','本次实验最大值','FontSize',14,'Position',[0.1 0.2 0.4 0.05],'backgroundcolor',[0.85 0.85 0.85]);
conthis = uicontrol('Parent',conrespanel,'style','text','units','normalized','string','0','FontSize',14,'Position',[0.5 0.2 0.4 0.05],'backgroundcolor',[0.85 0.85 0.85]);
conclear = uicontrol('Parent',conrespanel,'style','pushbutton','units','normalized','string','清空统计','FontSize',14,'Position',[0.4 0.05 0.2 0.1]);

%conpanel按钮功能
f2manual.Callback = {@f2manualFun,f2manpanel,f2autopanel,f2manual,f2auto};
f2auto.Callback = {@f2autoFun,f2manpanel,f2autopanel,f2manual,f2auto};
f2conti1.Callback = {@f2conFun,f2curr,f2autocurr,f2M,f2swarm,f2pg};   %输入为f2返回值，以及代数
f2back1.Callback = {@f2backFun,f2curr,f2autocurr,f2swarm,f2pg};
f2reset.Callback = {@f2resFun,@function2,f2swarm,f2pg,f2curr,f2autocurr,f2N,f2a,f2b,f2c,f2M,conres,connum,conev,conthis};  %！！！此处不能先将string转化为num传入，不会随着更新
f2autoreset.Callback = {@f2resFun,@function2,f2swarm,f2pg,f2curr,f2autocurr,f2N,f2a,f2b,f2c,f2M,conres,connum,conev,conthis};
f2conti5.Callback = {@f2con10Fun,f2curr,f2autocurr,f2M,f2swarm,f2pg};
f2back5.Callback = {@f2back5Fun,f2curr,f2autocurr,f2swarm,f2pg};
f2autoconti.Callback = {@f2autoconFun,f2curr,f2autocurr,f2M,f2swarm,f2pg};
f2autopause.Callback = {@f2autopauFun};
conclear.Callback = {@conclearFun,connum,conev,conthis,conres};

%apppanel显示
combentry = uicontrol('Parent',apppanel,'style','pushbutton','units','normalized','string','组合优化应用','FontSize',17,'Position',[0 0.92 1 0.08]);
numentry = uicontrol('Parent',apppanel,'style','pushbutton','units','normalized','string','数值优化应用','FontSize',17,'Position',[0 0.84 1 0.08]);

%combpanel显示
introbtn = uicontrol('Parent',combpanel,'style','pushbutton','units','normalized','string','简介','FontSize',12,'FontWeight','bold','BackgroundColor',[0.8 0.8 0.8],'Position',[0 0.94 0.25 0.06]);
setbtn = uicontrol('Parent',combpanel,'style','pushbutton','units','normalized','string','参数设置','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.25 0.94 0.25 0.06]);
showbtn = uicontrol('Parent',combpanel,'style','pushbutton','units','normalized','string','过程展示','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.5 0.94 0.25 0.06]);
resbtn = uicontrol('Parent',combpanel,'style','pushbutton','units','normalized','string','结果展示','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.75 0.94 0.25 0.06]);
intropanel = uipanel('Parent',combpanel,'Visible','on','Units','normalized','Position',[0 0 1 0.95]);
setpanel = uipanel('Parent',combpanel,'Visible','off','Units','normalized','Position',[0 0 1 0.95]);
showpanel = uipanel('Parent',combpanel,'Visible','off','Units','normalized','Position',[0 0 1 0.95]);
respanel = uipanel('Parent',combpanel,'Visible','off','Units','normalized','Position',[0 0 1 0.95]);

%intropanel显示
introtext = axes('Parent',intropanel,'Units','normalized','position',[0 0.5 1 0.5],'nextplot','add');
set(introtext,'visible','off');
introtext1 = text('Parent',introtext,'string','\diamondsuit用PSO算法进行k均值聚类','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.92]);
introtext2 = text('Parent',introtext,'string',{'    k均值聚类问题是一种组合优化问题，可以运用PSO算';
                                                '法来解决。这个实验的内容是将25个二维个体分为3组。';
                                                '每个分组都有一个中心，中心的位置可以用二维的点表示。';
                                                '将三个分组的三个点看作一个解，每一个解对应PSO算法';
                                                '中的一个粒子，则可以运用粒子群算法移动这些粒子，搜';
                                                '寻目标函数的最优解。'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 0.6]);
introtext3 = text('Parent',introtext,'string','\diamondsuit适应值函数','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.3]);
introtext4 = text('Parent',introtext,'string',{'    适应值函数所代表的意义是每一个二维个体到所属类中';
                                                '心的距离的和距离用欧式距离的开方计算，算式如下：'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 0.15]);
intropicaxes = axes('Parent',intropanel,'Units','normalized','position',[0.2 0.45 0.6 0.1],'nextplot','add');
intropic = imread('combintro.png');
imshow(intropic,'parent',intropicaxes);
introtext5 = text('Parent',introtext,'string',{'其中'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 -0.13]);
intropicaxes2 = axes('Parent',intropanel,'Units','normalized','position',[0.2 0.3 0.6 0.13],'nextplot','add');
intropic2 = imread('pic2.png');
imshow(intropic2,'parent',intropicaxes2);
introtext6 = text('Parent',introtext,'string',{'K代表的是聚类数量，此例中为3。N代表的是样本个体数，';
                                                '此例中为25。X为个体位置，C为聚类中心的位置，n为每';
                                                '类个体数。'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 -0.51]);
introtext7 = text('Parent',introtext,'string','\diamondsuit参数','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 -0.7]);
introtext8 = text('Parent',introtext,'string',{'    在此次实验中，可调的参数有粒子群的数量，迭代次';
                                                '数，自我学习因子，全局学习因子。'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 -0.84]);

%setpanel显示
setsstext = uicontrol('Parent',setpanel,'style','text','units','normalized','string','种群数量','FontSize',16,'Position',[0.05 0.8 0.4 0.06]);
setc1text = uicontrol('Parent',setpanel,'style','text','units','normalized','string','自我学习因子','FontSize',16,'Position',[0.05 0.7 0.4 0.06]);
setc2text = uicontrol('Parent',setpanel,'style','text','units','normalized','string','全局学习因子','FontSize',16,'Position',[0.05 0.6 0.4 0.06]);
sets1text = uicontrol('Parent',setpanel,'style','text','units','normalized','string','迭代次数','FontSize',16,'Position',[0.05 0.5 0.4 0.06]);
setss = uicontrol('Parent',setpanel,'style','edit','units','normalized','string','5','FontSize',17,'Position',[0.6 0.8 0.3 0.06]);
setc1 = uicontrol('Parent',setpanel,'style','edit','units','normalized','string','2','FontSize',17,'Position',[0.6 0.7 0.3 0.06]);
setc2 = uicontrol('Parent',setpanel,'style','edit','units','normalized','string','2','FontSize',17,'Position',[0.6 0.6 0.3 0.06]);
sets1= uicontrol('Parent',setpanel,'style','edit','units','normalized','string','50','FontSize',17,'Position',[0.6 0.5 0.3 0.06]);
setenter = uicontrol('Parent',setpanel,'style','pushbutton','units','normalized','string','确定','FontSize',17,'Position',[0.25 0.2 0.5 0.1]);

global data center gbestraw1 gbestraw2 gbestraw3 fitnessbest;
[data,center,gbestraw1,gbestraw2,gbestraw3,fitnessbest]=kmeansPSO(5,3,50,2,2);    %种群规模，分类数，迭代次数，学习因子1，2

%showpanel显示
combstart = uicontrol('Parent',showpanel,'style','pushbutton','units','normalized','string','开始迭代','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0 0.94 0.166 0.06]);
combpause = uicontrol('Parent',showpanel,'style','pushbutton','units','normalized','string','暂停','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.166 0.94 0.166 0.06]);
combback = uicontrol('Parent',showpanel,'style','pushbutton','units','normalized','string','向上一代','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.333 0.94 0.166 0.06]);
combconti = uicontrol('Parent',showpanel,'style','pushbutton','units','normalized','string','向下一代','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.5 0.94 0.166 0.06]);
combfirst = uicontrol('Parent',showpanel,'style','pushbutton','units','normalized','string','第一代','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.666 0.94 0.166 0.06]);
comblast = uicontrol('Parent',showpanel,'style','pushbutton','units','normalized','string','最后一代','FontSize',10,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.833 0.94 0.166 0.06]);
combcurrtext = uicontrol('Parent',showpanel,'style','text','units','normalized','string','当前代数','FontSize',11,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.333 0.9 0.166 0.03]);
combcurr = uicontrol('Parent',showpanel,'style','text','units','normalized','string','1','FontSize',11,'BackgroundColor',[0.85 0.85 0.85],'Position',[0.5 0.9 0.166 0.03]);

showtext = axes('Parent',showpanel,'Units','normalized','position',[0 0.5 1 0.5]);
set(showtext,'visible','off');
showtext1 = text('Parent',showtext,'string','\diamondsuit样本个体位置和聚类中心位置','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.7]);
showtext2 = text('Parent',showtext,'string','\diamondsuitx维度粒子群的位置','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 -0.3]);
showtext3 = text('Parent',showtext,'string','\diamondsuity维度粒子群的位置','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 -1.3]);

dotshow = axes('Parent',showpanel,'Units','normalized','position',[0.2 0.5 0.7 0.32],'nextplot','add');
xlabel(dotshow,'x维度');
ylabel(dotshow,'y维度');
plot(dotshow,data(:,1),data(:,2),'ro');
center1 = plot(dotshow,gbestraw1(1,1),gbestraw1(1,2),'bo');
center2 = plot(dotshow,gbestraw2(1,1),gbestraw2(1,2),'bo');
center3 = plot(dotshow,gbestraw3(1,1),gbestraw3(1,2),'bo');

centershowx = axes('Parent',showpanel,'Units','normalized','position',[0.2 0 0.7 0.32]);
x1 = center(1,1,:,1);
x2 = center(2,1,:,1);
x3 = center(3,1,:,1);
x1 = x1(:);
x2 = x2(:);
x3 = x3(:);
xshow = plot3(centershowx,x1,x2,x3,'mo');
grid(centershowx,'on');
xlabeltext = xlabel(centershowx,'第一类');
ylabeltext = ylabel(centershowx,'第二类');
zlabel(centershowx,'第三类');
set(xlabeltext,'Rotation',20);
set(ylabeltext,'Rotation',-26);

centershowy = axes('Parent',showpanel,'Units','normalized','position',[0.2 -0.5 0.7 0.32]);
y1 = center(1,2,:,1);
y2 = center(2,2,:,1);
y3 = center(3,2,:,1);
y1 = y1(:);
y2 = y2(:);
y3 = y3(:);
yshow = plot3(centershowy,y1,y2,y3,'mo');
grid(centershowy,'on');
xlabeltexty = xlabel(centershowy,'第一类');
ylabeltexty = ylabel(centershowy,'第二类');
zlabel(centershowy,'第三类');
set(xlabeltexty,'Rotation',20);
set(ylabeltexty,'Rotation',-26);

%respanel显示
restext = axes('Parent',respanel,'Units','normalized','position',[0 0.5 1 0.5]);
set(restext,'visible','off');
restext1 = text('Parent',restext,'string','\diamondsuit每次迭代最佳值的位置','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.92]);
restext2 = text('Parent',restext,'string','\diamondsuit每次迭代最佳适应值','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.03]);

resshow = axes('Parent',respanel,'Units','normalized','position',[0.15 0.58 0.75 0.35]);
g1show = plot3(resshow,gbestraw1(:,1),gbestraw1(:,2),gbestraw1(:,3),'bo');
hold(resshow,'on');
g2show = plot3(resshow,gbestraw2(:,1),gbestraw2(:,2),gbestraw2(:,3),'ro');
g3show = plot3(resshow,gbestraw3(:,1),gbestraw3(:,2),gbestraw3(:,3),'go');
grid(resshow,'on');
xlabelres = xlabel(resshow,'x维度');
ylabelres = ylabel(resshow,'y维度');
zlabel(resshow,'迭代次数');
set(xlabelres,'Rotation',20);
set(ylabelres,'Rotation',-26);
fitbestshow = axes('Parent',respanel,'Units','normalized','position',[0.15 0.17 0.75 0.3],'nextplot','add');
xlabel(fitbestshow,'迭代次数');
ylabel(fitbestshow,'适应值');
fitshow = plot(fitbestshow,fitnessbest);
combclear = uicontrol('Parent',respanel,'style','pushbutton','units','normalized','string','清空统计','FontSize',10,'Position',[0.4 0.01 0.2 0.06]);
combstatext = uicontrol('Parent',respanel,'style','text','units','normalized','string','历史均值','FontSize',12,'Position',[0.2 0.08 0.3 0.03],'BackgroundColor',[0.85 0.85 0.85]);
combsta = uicontrol('Parent',respanel,'style','text','units','normalized','string',num2str(fitnessbest(str2double(sets1.String))),'FontSize',12,'Position',[0.5 0.08 0.3 0.03],'BackgroundColor',[0.85 0.85 0.85]);

%exerpanel显示
exertext = axes('Parent',exerpanel,'Units','normalized','position',[0 0.5 1 0.5]);
set(exertext,'visible','off');
exertext1 = text('Parent',exertext,'string','\diamondsuit题目一','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.92]);
exertext2 = text('Parent',exertext,'string',{'    在概念讲解与经典应用部分中，求出算法在不同参数时';
                                             '所得到的最佳值的平均值与方差。（建议每个参数实验次';
                                             '数不小于10次）'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 0.78]);
exertext3 = text('Parent',exertext,'string','\diamondsuit题目二','horizontalalignment','left','fontsize',15,'Units','normalized','position',[0.03 0.6]);
exertext4 = text('Parent',exertext,'string',{'    将PSO算法与等算量的随机搜索做对比，并找到PSO算';
                                             '法的最佳参数以达到最大的效率。'},'horizontalalignment','left','fontsize',12,'Units','normalized','position',[0.03 0.48]);

%combpanel按钮功能
introbtn.Callback = {@introFun,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel};
setbtn.Callback = {@setFun,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel};
resbtn.Callback = {@resFun,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel};

%apppanel按钮功能
combentry.Callback = {@combenFun,combpanel,intropanel,setpanel,showpanel,respanel,introbtn,setbtn,showbtn,resbtn};
numentry.Callback = {@numenFun,numpanel};

%setpanel按钮功能
setenter.Callback = {@combsetFun,@kmeansPSO,setss,setc1,setc2,sets1,resshow,fitbestshow,combsta};

%showpanel按钮功能
showbtn.Callback = {@showFun,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel,dotshow,centershowx,centershowy,combcurr,center1,center2,center3,xshow,yshow,showtext};
combstart.Callback = {@combstartFun,combcurr,center1,center2,center3,xshow,yshow,sets1};
combpause.Callback = {@combpauseFun};
combback.Callback = {@combbackFun,combcurr,center1,center2,center3,xshow,yshow};
combconti.Callback = {@combcontiFun,combcurr,center1,center2,center3,xshow,yshow,sets1};
combfirst.Callback = {@combfirstFun,combcurr,center1,center2,center3,xshow,yshow};
comblast.Callback = {@comblastFun,combcurr,center1,center2,center3,xshow,yshow,sets1};

%respanel按钮功能
combclear.Callback = {@combclearFun,fitbestshow,combsta};

%numpanel显示
funtext = axes('Parent',numpanel,'Units','normalized','position',[0 0.925 1 0.075]);
set(funtext,'visible','off');
testtext = text('Parent',funtext,'string',{'用PSO寻找下列函数的最小值：','F = \Sigma_{i=1}^{30} x_i^2+x_i-6 (i为维度)'},'Interpreter','tex','horizontalalignment','center','fontsize',13,'Units','normalized','position',[0.5 0.3]);
h = axes('Parent',numpanel,'Units','normalized','position',[0.1 0.5 0.8 0.4],'nextplot','add');
Ntext = uicontrol('Parent',numpanel,'style','text','units','normalized','string','种群数量','FontSize',16,'Position',[0 0.36 0.4 0.04]);
c1text = uicontrol('Parent',numpanel,'style','text','units','normalized','string','自我学习因子','FontSize',16,'Position',[0 0.32 0.4 0.04]);
c2text = uicontrol('Parent',numpanel,'style','text','units','normalized','string','全局学习因子','FontSize',16,'Position',[0 0.28 0.4 0.04]);
wtext = uicontrol('Parent',numpanel,'style','text','units','normalized','string','惯性因子','FontSize',16,'Position',[0 0.24 0.4 0.04]);
Mtext = uicontrol('Parent',numpanel,'style','text','units','normalized','string','迭代次数','FontSize',16,'Position',[0 0.20 0.4 0.04]);
N = uicontrol('Parent',numpanel,'style','edit','units','normalized','string','50','FontSize',17,'Position',[0.4 0.36 0.15 0.04]);
c1 = uicontrol('Parent',numpanel,'style','edit','units','normalized','string','1.5','FontSize',17,'Position',[0.4 0.32 0.15 0.04]);
c2 = uicontrol('Parent',numpanel,'style','edit','units','normalized','string','2.5','FontSize',17,'Position',[0.4 0.28 0.15 0.04]);
w = uicontrol('Parent',numpanel,'style','edit','units','normalized','string','0.5','FontSize',17,'Position',[0.4 0.24 0.15 0.04]);
M = uicontrol('Parent',numpanel,'style','edit','units','normalized','string','300','FontSize',17,'Position',[0.4 0.20 0.15 0.04]);
enter = uicontrol('Parent',numpanel,'style','pushbutton','units','normalized','string','确定','FontSize',17,'Position',[0.7 0.32 0.2 0.04]);
clearbutton = uicontrol('Parent',numpanel,'style','pushbutton','units','normalized','string','清空','FontSize',17,'Position',[0.7 0.24 0.2 0.04]);
numtext1 = uicontrol('Parent',numpanel,'style','text','units','normalized','string','最小值','FontSize',12,'Position',[0.2 0.42 0.3 0.03],'BackgroundColor',[0.85 0.85 0.85]);
numtext2 = uicontrol('Parent',numpanel,'style','text','units','normalized','string','0','FontSize',12,'Position',[0.5 0.42 0.3 0.03],'BackgroundColor',[0.85 0.85 0.85]);

%numpanel按钮功能
enter.Callback = {@enterFun,N,c1,c2,w,M,h,numtext2};
clearbutton.Callback = {@clearFun,h,numtext2};

%导航按钮
function backF(~,~)
    global cpanel selfp parent parentpanel;
    set(selfp(cpanel),'Visible','off');
    set(parent(cpanel),'Visible','on');
    cpanel = parentpanel(cpanel);
end

function homeF(~,~)
    global cpanel selfp parent;
    set(selfp(cpanel),'Visible','off');
    set(parent(1),'Visible','on');
    cpanel = 1;
end

%主题按钮
function conF(h,~,nextpanel,context,conshow,conrespanel)
    global cpanel;
    set(h.Parent,'Visible','off');
    set(nextpanel,'Visible','on');
    cpanel = 2; %当前为conpanel
    set(context,'units','normalized','Position',[0 0.5 1 0.5]);
    set(conshow,'units','normalized','Position',[0 -0.8 1 0.7]);
    set(conrespanel,'units','normalized','Position',[0 -1.68 1 0.7]);
    set(gcf,'WindowScrollWheelFcn',{@conwheel,context,conshow,conrespanel});
end

function conwheel(~,event,context,conshow,conrespanel)
    a = context.Position(2);
    if event.VerticalScrollCount > 0
        a = a + 0.1;
    elseif event.VerticalScrollCount < 0 && a > 0.5
        a = a - 0.1;
    end
    set(context,'units','normalized','Position',[0 a 1 0.5]);
    set(conshow,'units','normalized','Position',[0 a-1.3 1 0.7]);
    set(conrespanel,'units','normalized','Position',[0 a-2.18 1 0.7]);
end

function conclearFun(~,~,connum,conev,conthis,conres)
    cla(conres);
    connum.String = '0';
    conev.String = '0';
    conthis.String = '0';
end

function appF(h,~,nextpanel)
    global cpanel;
    set(h.Parent,'Visible','off');
    set(nextpanel,'Visible','on');
    cpanel = 3; %当前为apppanel
end

function combenFun(h,~,combpanel,intropanel,setpanel,showpanel,respanel,introbtn,setbtn,showbtn,resbtn)
    global cpanel;
    set(h.Parent,'Visible','off');
    set(combpanel,'Visible','on');
    set(intropanel,'Visible','on');
    set(setpanel,'Visible','off');
    set(showpanel,'Visible','off');
    set(respanel,'Visible','off');
    set(introbtn,'FontSize',12,'FontWeight','bold','BackgroundColor',[0.8 0.8 0.8]);
    set(setbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(showbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(resbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    cpanel = 5; %当前为apppanel
end

function combsetFun(~,~,kmeansPSO,setss,setc1,setc2,sets1,resshow,fitbestshow,combsta)
    global data center gbestraw1 gbestraw2 gbestraw3 fitnessbest;
    [data,center,gbestraw1,gbestraw2,gbestraw3,fitnessbest]=kmeansPSO(str2double(setss.String),3,str2double(sets1.String),str2double(setc1.String),str2double(setc2.String));    %种群规模，分类数，迭代次数，学习因子1，2
    hold(resshow,'off');
    plot3(resshow,gbestraw1(:,1),gbestraw1(:,2),gbestraw1(:,3),'bo');
    hold(resshow,'on');
    plot3(resshow,gbestraw2(:,1),gbestraw2(:,2),gbestraw2(:,3),'ro');
    plot3(resshow,gbestraw3(:,1),gbestraw3(:,2),gbestraw3(:,3),'go');
    grid(resshow,'on');
    plot(fitbestshow,fitnessbest);
    xlabelres = xlabel(resshow,'x维度');
    ylabelres = ylabel(resshow,'y维度');
    zlabel(resshow,'迭代次数');
    set(xlabelres,'Rotation',20);
    set(ylabelres,'Rotation',-26);
    a = str2double(combsta.String);
    if a
        a = (a+fitnessbest(str2double(sets1.String)))/2;
    else
        a = fitnessbest(str2double(sets1.String));
    end
    combsta.String = num2str(a);
end

function combstartFun(~,~,combcurr,center1,center2,center3,xshow,yshow,sets1)
    global center gbestraw1 gbestraw2 gbestraw3 combpauseflag;
    combpauseflag = 0;
    a = str2double(combcurr.String);      %！！！！！String大写
    while a<str2double(sets1.String)
        if combpauseflag
            break;
        else
            a = a+1;
            combcurr.String = num2str(a);
            set(center1,'XData',gbestraw1(a,1),'YData',gbestraw1(a,2));
            set(center2,'XData',gbestraw2(a,1),'YData',gbestraw2(a,2));
            set(center3,'XData',gbestraw3(a,1),'YData',gbestraw3(a,2));
            x1 = center(1,1,:,a);
            x2 = center(2,1,:,a);
            x3 = center(3,1,:,a);
            x1 = x1(:);
            x2 = x2(:);
            x3 = x3(:);
            set(xshow,'XData',x1,'YData',x2,'ZData',x3);
            y1 = center(1,2,:,a);
            y2 = center(2,2,:,a);
            y3 = center(3,2,:,a);
            y1 = y1(:);
            y2 = y2(:);
            y3 = y3(:);
            set(yshow,'XData',y1,'YData',y2,'ZData',y3);
            pause(0.05);
        end
    end
end

function combpauseFun(~,~)
    global combpauseflag;
    combpauseflag = 1;
end

function combbackFun(~,~,combcurr,center1,center2,center3,xshow,yshow)
    global center gbestraw1 gbestraw2 gbestraw3;
    a = str2double(combcurr.String);      %！！！！！String大写
    if a>1
        a = a-1;
        combcurr.String = num2str(a);
        set(center1,'XData',gbestraw1(a,1),'YData',gbestraw1(a,2));
        set(center2,'XData',gbestraw2(a,1),'YData',gbestraw2(a,2));
        set(center3,'XData',gbestraw3(a,1),'YData',gbestraw3(a,2));
        x1 = center(1,1,:,a);
        x2 = center(2,1,:,a);
        x3 = center(3,1,:,a);
        x1 = x1(:);
        x2 = x2(:);
        x3 = x3(:);
        set(xshow,'XData',x1,'YData',x2,'ZData',x3);
        y1 = center(1,2,:,a);
        y2 = center(2,2,:,a);
        y3 = center(3,2,:,a);
        y1 = y1(:);
        y2 = y2(:);
        y3 = y3(:);
        set(yshow,'XData',y1,'YData',y2,'ZData',y3);
    end
end

function combcontiFun(~,~,combcurr,center1,center2,center3,xshow,yshow,sets1)
    global center gbestraw1 gbestraw2 gbestraw3;
    a = str2double(combcurr.String);      %！！！！！String大写
    if a<str2double(sets1.String)
        a = a+1;
        combcurr.String = num2str(a);
        set(center1,'XData',gbestraw1(a,1),'YData',gbestraw1(a,2));
        set(center2,'XData',gbestraw2(a,1),'YData',gbestraw2(a,2));
        set(center3,'XData',gbestraw3(a,1),'YData',gbestraw3(a,2));
        x1 = center(1,1,:,a);
        x2 = center(2,1,:,a);
        x3 = center(3,1,:,a);
        x1 = x1(:);
        x2 = x2(:);
        x3 = x3(:);
        set(xshow,'XData',x1,'YData',x2,'ZData',x3);
        y1 = center(1,2,:,a);
        y2 = center(2,2,:,a);
        y3 = center(3,2,:,a);
        y1 = y1(:);
        y2 = y2(:);
        y3 = y3(:);
        set(yshow,'XData',y1,'YData',y2,'ZData',y3);
    end
end

function combfirstFun(~,~,combcurr,center1,center2,center3,xshow,yshow)
    global center gbestraw1 gbestraw2 gbestraw3;
    a = 1;
    combcurr.String = num2str(a);
    set(center1,'XData',gbestraw1(a,1),'YData',gbestraw1(a,2));
    set(center2,'XData',gbestraw2(a,1),'YData',gbestraw2(a,2));
    set(center3,'XData',gbestraw3(a,1),'YData',gbestraw3(a,2));
    x1 = center(1,1,:,a);
    x2 = center(2,1,:,a);
    x3 = center(3,1,:,a);
    x1 = x1(:);
    x2 = x2(:);
    x3 = x3(:);
    set(xshow,'XData',x1,'YData',x2,'ZData',x3);
    y1 = center(1,2,:,a);
    y2 = center(2,2,:,a);
    y3 = center(3,2,:,a);
    y1 = y1(:);
    y2 = y2(:);
    y3 = y3(:);
    set(yshow,'XData',y1,'YData',y2,'ZData',y3);
end

function comblastFun(~,~,combcurr,center1,center2,center3,xshow,yshow,sets1)
    global center gbestraw1 gbestraw2 gbestraw3;
    a = str2double(sets1.String);
    combcurr.String = num2str(a);
    set(center1,'XData',gbestraw1(a,1),'YData',gbestraw1(a,2));
    set(center2,'XData',gbestraw2(a,1),'YData',gbestraw2(a,2));
    set(center3,'XData',gbestraw3(a,1),'YData',gbestraw3(a,2));
    x1 = center(1,1,:,a);
    x2 = center(2,1,:,a);
    x3 = center(3,1,:,a);
    x1 = x1(:);
    x2 = x2(:);
    x3 = x3(:);
    set(xshow,'XData',x1,'YData',x2,'ZData',x3);
    y1 = center(1,2,:,a);
    y2 = center(2,2,:,a);
    y3 = center(3,2,:,a);
    y1 = y1(:);
    y2 = y2(:);
    y3 = y3(:);
    set(yshow,'XData',y1,'YData',y2,'ZData',y3);
end

function numenFun(h,~,numpanel)
    global cpanel;
    set(h.Parent,'Visible','off');
    set(numpanel,'Visible','on');
    cpanel = 6; %当前为apppanel
end

function introFun(~,~,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel)
    set(introbtn,'FontSize',12,'FontWeight','bold','BackgroundColor',[0.8 0.8 0.8]);
    set(setbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(showbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(resbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(intropanel,'Visible','on');
    set(setpanel,'Visible','off');
    set(showpanel,'Visible','off');
    set(respanel,'Visible','off');
end

function setFun(~,~,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel)
    set(introbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(setbtn,'FontSize',12,'FontWeight','bold','BackgroundColor',[0.8 0.8 0.8]);
    set(showbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(resbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(intropanel,'Visible','off');
    set(setpanel,'Visible','on');
    set(showpanel,'Visible','off');
    set(respanel,'Visible','off');
end

function showFun(~,~,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel,dotshow,centershowx,centershowy,combcurr,center1,center2,center3,xshow,yshow,showtext)
    set(introbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(setbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(showbtn,'FontSize',12,'FontWeight','bold','BackgroundColor',[0.8 0.8 0.8]);
    set(resbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(intropanel,'Visible','off');
    set(setpanel,'Visible','off');
    set(showpanel,'Visible','on');
    set(respanel,'Visible','off');
    set(showtext,'units','normalized','Position',[0 0.5 1 0.5]);
    set(dotshow,'units','normalized','Position',[0.2 0.5 0.7 0.32]);
    set(centershowx,'units','normalized','Position',[0.2 0 0.7 0.32]);
    set(centershowy,'units','normalized','Position',[0.2 -0.5 0.7 0.32]);
    set(gcf,'WindowScrollWheelFcn',{@combshowwheel,dotshow,centershowx,centershowy,showtext});
    global center gbestraw1 gbestraw2 gbestraw3;
    a = 1;
    combcurr.String = num2str(a);
    set(center1,'XData',gbestraw1(a,1),'YData',gbestraw1(a,2));
    set(center2,'XData',gbestraw2(a,1),'YData',gbestraw2(a,2));
    set(center3,'XData',gbestraw3(a,1),'YData',gbestraw3(a,2));
    x1 = center(1,1,:,a);
    x2 = center(2,1,:,a);
    x3 = center(3,1,:,a);
    x1 = x1(:);
    x2 = x2(:);
    x3 = x3(:);
    set(xshow,'XData',x1,'YData',x2,'ZData',x3);
    y1 = center(1,2,:,a);
    y2 = center(2,2,:,a);
    y3 = center(3,2,:,a);
    y1 = y1(:);
    y2 = y2(:);
    y3 = y3(:);
    set(yshow,'XData',y1,'YData',y2,'ZData',y3);
end

function combshowwheel(~,event,dotshow,centershowx,centershowy,showtext)
    a = dotshow.Position(2);
    if event.VerticalScrollCount > 0
        a = a + 0.05;
    elseif event.VerticalScrollCount < 0 && a > 0.5
        a = a - 0.05;
    end
    set(showtext,'units','normalized','Position',[0 a 1 0.5]);
    set(dotshow,'units','normalized','Position',[0.2 a 0.7 0.32]);
    set(centershowx,'units','normalized','Position',[0.2 a-0.5 0.7 0.32]);
    set(centershowy,'units','normalized','Position',[0.2 a-1 0.7 0.32]);
end

function resFun(~,~,introbtn,setbtn,showbtn,resbtn,intropanel,setpanel,showpanel,respanel)
    set(introbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(setbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(showbtn,'FontSize',10,'FontWeight','normal','BackgroundColor',[0.85 0.85 0.85]);
    set(resbtn,'FontSize',12,'FontWeight','bold','BackgroundColor',[0.8 0.8 0.8]);
    set(intropanel,'Visible','off');
    set(setpanel,'Visible','off');
    set(showpanel,'Visible','off');
    set(respanel,'Visible','on');
end

function combclearFun(~,~,fitbestshow,combsta)
    cla(fitbestshow);
    combsta.String = '0';
end

function exerF(h,~,nextpanel)
    global cpanel;
    set(h.Parent,'Visible','off');
    set(nextpanel,'Visible','on');
    cpanel = 4; %当前为exerpanel
end

function enterFun(~,~,N,c1,c2,w,M,h,numtext2)
    [~,~,Pbest] = function1(str2double(N.String),str2double(c1.String),str2double(c2.String),str2double(w.String),str2double(M.String));
    plot(h,Pbest);
    numtext2.String = num2str(Pbest(str2double(M.String)));
end

function clearFun(~,~,h,numtext2)
    cla(h);
    numtext2.String = '0';
end

function f2manualFun(~,~,f2manpanel,f2autopanel,f2manual,f2auto)
    set(f2manpanel,'visible','on');
    set(f2manual,'backgroundcolor',[0.8 0.8 0.8],'FontSize',15);
    set(f2autopanel,'visible','off');
    set(f2auto,'backgroundcolor',[1 1 1],'FontSize',10);
    global pauseflag;
    pauseflag = 1;
end

function f2autoFun(~,~,f2manpanel,f2autopanel,f2manual,f2auto)
    set(f2manpanel,'visible','off');
    set(f2manual,'backgroundcolor',[1 1 1],'FontSize',10);
    set(f2autopanel,'visible','on');
    set(f2auto,'backgroundcolor',[0.8 0.8 0.8],'FontSize',15);
end

function f2conFun(~,~,f2curr,f2autocurr,f2M,f2swarm,f2pg)     %！！！！前面两个参数
    global xtotal pgtotal;
    a = str2double(f2curr.String);      %！！！！！String大写
    if a<str2double(f2M.String)
        a = a+1;
        f2curr.String = num2str(a);
        f2autocurr.String = num2str(a);
        set(f2swarm,'XData',xtotal(a,:),'YData',exp(-(xtotal(a,:).*xtotal(a,:))/200).*cos(xtotal(a,:)));
        set(f2pg,'XData',pgtotal(a),'YData',exp(-(pgtotal(a)*pgtotal(a))/200)*cos(pgtotal(a)));
    end
end

function f2con10Fun(~,~,f2curr,f2autocurr,f2M,f2swarm,f2pg)
    global xtotal pgtotal;
    a = str2double(f2curr.String);
    if a<str2double(f2M.String)
        if a>str2double(f2M.String)-10
            a = str2double(f2M.String);
        else
            a = a+10;
        end
        f2curr.String = num2str(a);
        f2autocurr.String = num2str(a);
        set(f2swarm,'XData',xtotal(a,:),'YData',exp(-(xtotal(a,:).*xtotal(a,:))/200).*cos(xtotal(a,:)));
        set(f2pg,'XData',pgtotal(a),'YData',exp(-(pgtotal(a)*pgtotal(a))/200)*cos(pgtotal(a)));
    end
end

function f2backFun(~,~,f2curr,f2autocurr,f2swarm,f2pg)
    global xtotal pgtotal ;
    a = str2double(f2curr.String);
    if a>1
        a = a-1;
        f2curr.String = num2str(a);
        f2autocurr.String = num2str(a);
        set(f2swarm,'XData',xtotal(a,:),'YData',exp(-(xtotal(a,:).*xtotal(a,:))/200).*cos(xtotal(a,:)));
        set(f2pg,'XData',pgtotal(a),'YData',exp(-(pgtotal(a)*pgtotal(a))/200)*cos(pgtotal(a)));
    end
end

function f2back5Fun(~,~,f2curr,f2autocurr,f2swarm,f2pg)
    global xtotal pgtotal ;
    a = str2double(f2curr.String);
    if a>1
        if a>10
            a = a-10;
        else
            a = 1;
        end
        f2curr.String = num2str(a);
        f2autocurr.String = num2str(a);
        set(f2swarm,'XData',xtotal(a,:),'YData',exp(-(xtotal(a,:).*xtotal(a,:))/200).*cos(xtotal(a,:)));
        set(f2pg,'XData',pgtotal(a),'YData',exp(-(pgtotal(a)*pgtotal(a))/200)*cos(pgtotal(a)));
    end
end

function f2resFun(~,~,function2,f2swarm,f2pg,f2curr,f2autocurr,f2n,f2a,f2b,f2c,f2m,conres,connum,conev,conthis)
    global xtotal ptotal pgtotal pntotal pauseflag;
    pauseflag = 1;
    [xtotal,ptotal,pgtotal,pntotal] = function2(str2double(f2n.String),str2double(f2a.String),str2double(f2b.String),str2double(f2c.String),str2double(f2m.String));
    f2curr.String = '1';
    f2autocurr.String = '1';
    set(f2swarm,'XData',xtotal(1,:),'YData',exp(-(xtotal(1,:).*xtotal(1,:))/200).*cos(xtotal(1,:)));
    set(f2pg,'XData',pgtotal(1),'YData',exp(-(pgtotal(1)*pgtotal(1))/200)*cos(pgtotal(1)));
    plot(conres,exp(-(pgtotal.*pgtotal)/200).*cos(pgtotal));
    a = str2double(connum.String);
    a = a+1;
    connum.String = (num2str(a));
    b = str2double(conev.String);
    pglast = exp(-(pgtotal(str2double(f2m.String))*pgtotal(str2double(f2m.String)))/200)*cos(pgtotal(str2double(f2m.String)));
    b = ((a-1)*b+pglast)/a;
    conev.String = (num2str(b));
    conthis.String = num2str(pglast);
end

function f2autoconFun(~,~,f2curr,f2autocurr,f2M,f2swarm,f2pg)
    n = str2double(f2M.String);
    global xtotal pgtotal pauseflag;
    pauseflag = 0;
    a = str2double(f2curr.String);
    while a<n
        if pauseflag
            break;
        else
            a = a+1;
            f2curr.String = num2str(a);
            f2autocurr.String = num2str(a);
            set(f2swarm,'XData',xtotal(a,:),'YData',exp(-(xtotal(a,:).*xtotal(a,:))/200).*cos(xtotal(a,:)));
            set(f2pg,'XData',pgtotal(a),'YData',exp(-(pgtotal(a)*pgtotal(a))/200)*cos(pgtotal(a)));
            pause(0.05);
        end
    end
end

function f2autopauFun(~,~)
    global pauseflag;
    pauseflag = 1;
end