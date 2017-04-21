clc
clear
close all
warning off
tic

% 该脚本文件利用因子分析法(Factor Analysis)对样本数据进行分析，从而找出若干个
% 公共因子来更好地解释变量


%% 读取数据
[X,textdata]=xlsread('examp12_02.xls');
X=X(:,3:end); % 提取要分析的数据
Varname=textdata(4,3:end); % 提取变量名
Country=textdata(5:end,2); % 提取国家名称
%% Factor Analysis
[m,n]=size(X);
[Lambda,Psi,T,Stats]=factoran(X,4) % （最大方差旋转法）因子分析，返回因子载荷矩阵Lambda，
% 特殊方差向量Psi，旋转矩阵T，模型检验结构体变量Stats
Countri=100*sum(Lambda.^2)/n; % 贡献率
CumContri=cumsum(Countri); % 计算累积贡献率
%% Factor Analysis(Two factors)
[Lambda1,Psi1,T1,Stats1,Fscore]=factoran(X,2)
Countri1=100*sum(Lambda1.^2)/n;
CumCountri=cumsum(Countri1);
head={'变量','因子1','因子2'};
Disp=[head;Varname',num2cell(Lambda1)]
%% 估算因子得分
ObjF=[Country num2cell(Fscore)]; % 将国家名称和因子得分放在一个细胞单元数组中
F1=sortrows(ObjF,2) % 按第一个因子得分排序
F2=sortrows(ObjF,3) % 按第二个因子得分排序
head1={'国家/地区','第一因子','第二因子'};
Disp1=[head1;F1]
Disp2=[head1;F2] % 分析可以看出某个因子优势越明显，因子得分越小
%% 因子得分可视化
figure
plot(-Fscore(:,1),-Fscore(:,2),'ro')
grid
xlabel('第一因子得分负值')
ylabel('第二因子得分负值')
title('因子得分散点图')
box off % 去掉坐标系右上的边框
gname(Country)
