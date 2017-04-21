clc
clear
close all
warning off
tic

% 该脚本利用因子分析法(Factor Analysis)从样本的相关系数矩阵出发对128名成年男子
% 身材的六项指标进行主成分分析,从中找出若干个具有明显特征的公共因子，该方法
% 可以应用在服装标准的制定过程中


%% 数据读入
Mcoef=[1     0.79    0.36    0.76    0.25    0.51
      0.79  1       0.31    0.55    0.17    0.35
      0.36  0.31    1       0.35    0.64    0.58
      0.76  0.55    0.35    1       0.16    0.38
      0.25  0.17    0.64    0.16    1       0.63
      0.51  0.35    0.58    0.38    0.63    1  ]; %定义相关系数矩阵
[m,n]=size(Mcoef);
%% Factor Analysis
[Lambda,Psi,T]=factoran(Mcoef,2,'xtype','covariance','delta',0,'rotate','none') % 从
% 相关系数矩阵出发，进行因子分析，选用公共因子个数为2，设置特殊方差下限为0，不进行旋转
head={'变量','因子1','因子2'}; %定义表头
Varname={'身高','坐高','胸围','臂长','肋围','腰围','贡献率','累积贡献率'};
Contri=100*sum(Lambda.^2)/n; %贡献率
Cumcontri=cumsum(Contri); % 累积贡献率
Temp=num2cell([Lambda;Contri;Cumcontri]);
Disp=[head;Varname',Temp]
%% 利用最大方差旋转法进行因子分析
[Lambda1,Psi1,T1]=factoran(Mcoef,2,'xtype','covariance','delta',0)
Contri1=100*sum(Lambda1.^2)/n
Cumcontri1=cumsum(Contri1)
%% 改变公共因子个数
[Lambda2,Psi2,T2]=factoran(Mcoef,3,'xtype','covariance','delta',0)
Contri2=100*sum(Lambda2.^2)/n;
Cumcontri2=cumsum(Contri2)
%% Elapsed time
toc
  