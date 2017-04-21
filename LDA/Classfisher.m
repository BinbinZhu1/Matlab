clc
clear
close all
tic

%% 利用fisher判别法对Iris（尾花）进行判别分类
% Zhubinbin 2016/6/9

S=load('fisheriris.mat'); %导入样例数据
X=[5.8 2.7 1.8 0.73
   5.6 3.1 3.8 1.8
   6.1 2.5 4.7 1.1
   6.1 2.6 5.7 1.9
   5.1 3.1 6.5 0.62
   5.8 3.7 3.9 0.13
   5.7 2.7 1.1 0.12
   6.4 3.2 2.4 1.6
   6.7 3 1.9 1.1
   6.8 3.5 7.9 1]; %定义未判别样品的观测矩阵X
[Outclass,TabCoef,TabL,TabConfu,TabErrMat,TabG,TrainScore] = Class_fisher(X,S.meas,S.species) % 利用fisher
% 函数进行判别分类，返回判别结果Outclass，判别式的系数向量TabCoef,包含特征值、贡献率、累积贡献率的TabL，
% 混淆矩阵TabConfu,误判矩阵TabErrMat,投影矩阵TabG，以及判别式得分向量
TS=TrainScore;
TS1=TS(TS(:,1)==1,:); % 第一类的判别式得分
TS2=TS(TS(:,1)==2,:); % 第二类的判别式得分
TS3=TS(TS(:,1)==3,:); % 第三类的判别式得分
plot(TS1(:,2),TS1(:,3),'mo')
hold on
plot(TS2(:,2),TS2(:,3),'b*')
hold on
plot(TS3(:,2),TS3(:,3),'r+')
legend('setosa类','versicolor类','virginica类','location','southeast');
grid
xlabel('第一判别式得分')
ylabel('第二判别式得分')
[Outclass,TabCoef,TabL,TabConfu,TabErrMat,TabG,TrainScore1] = Class_fisher(X,S.meas,S.species,0.5)
% 根据贡献率这个输入参数不低于0.9，确定判别式个数
figure
TS_new=TrainScore1;
TS_new1=TS_new(TS_new(:,1)==1,:); % 第一类的判别式得分
TS_new2=TS_new(TS_new(:,1)==2,:); % 第二类的判别式得分
TS_new3=TS_new(TS_new(:,1)==3,:); % 第三类的判别式得分
plot(TS_new1(:,2),'mo')
hold on
plot(TS_new2(:,2),'b*')
plot(TS_new3(:,2),'r+')
legend('setosa类','versicolor类','virginica类','Location','northoutside','Orientation','horizontal');
grid
xlabel('样品组数')
ylabel('第一判别式得分') 

% Elapsed time
toc


