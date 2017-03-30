% 清空环境变量
clc
clear
close all
tic

% 该脚本利用主成分分析法（PCA）从样本观测值矩阵出发对2007年我国31个省、市、自治区
% 和直辖市的农村居民家庭平均每人全年消费性支出的8个主要变量进行主成分分析
% Zhubinbin 2016/6/10

[X,textdata]=xlsread('examp11_02.xls');
XZ=zscore(X); % 数据标准化
[Coef,Score,Cval,Tsquare]=princomp(XZ) % 利用princomp函数根据标准化后样本观测中心数
% 据做主成分分析，返回主成分表达式的系数矩阵Coef，主成分得分数据Score，样本相关系数
% 矩阵的特征向量Cval和每个观测距离数据集（样本观测矩阵）中心的霍特林（Hotelling）T^2
% 统计量
Expl=100*Cval/sum(Cval); % 计算贡献率
[m,n]=size(X);
Result1=cell(n+1,4); % 定义一个空的元胞数组
Result1(1,:)={'特征值','差值','贡献率（%）','累积贡献率（%）'};
Result1(2:end,1)=num2cell(Cval);
Result1(2:end-1,2)=num2cell(-diff(Cval));
Result1(2:end,3:4)=num2cell([Expl,cumsum(Expl)]);
Result1 % 以元胞数组形式显示特征值、贡献率和累积贡献率
Varname=textdata(3,2:end); % 提取变量名称
Result2=cell(n+1,3);
Result2(1,:)={'标准化变量','主成分Prin1','主成分Prin2'};
Result2(2:end,1)=Varname;
Result2(2:end,2:3)=num2cell(Coef(:,[1,2]));
Result2 % 以元胞数组形式显示前两个主成分表达式的系数向量
Cityname=textdata(4:end,1); 
SumXZ=sum(XZ,2);
[S1,Id1]=sortrows(Score,1); % 将主成分得分数据按第一主成分得分从小到大排列
Result3=cell(m+1,4);
Result3(1,:)={'地区','总支出','第一主成分得y1','第二主成分得分y2'};
Result3(2:end,1)=Cityname(Id1);
Result3(2:end,2:end)=num2cell([SumXZ(Id1),S1(:,1:2)]);
Result3 % 以元胞数组形式给出总支出、第一主分得分和第二主成分得分
food=sum(XZ(:,[1,8]),2)-sum(XZ(:,[2,7]),2);
[S2,Id2]=sortrows(Score,2);% 将主成分数据按第二主成分得分从小到大排列
Result4=cell(m+1,4);
Result4(1,:)={'地区','第一主成分得分y1','第二主成分得分y2','（食品+其他）-（衣着+医保）'};
Result4(2:end,1)=Cityname(Id2);
Result4(2:end,2:end)=num2cell([S2(:,1:2),food(Id2)]);
Result4 % 以元胞数组形式给出前两个主成分的得分数据和（食品+其他）-（衣着+医保）
%% 主成分得分散点图
plot(Score(:,1),Score(:,2),'ro')
grid
xlabel('第一主成分得分')
ylabel('第二主成分得分')
title('前两个主成分得分散点图')
%gname(Cityname) % 交互式标注每个地区的名称
%% 根据霍特林(Hotelling)T^2统计量寻找极端数据
Result5=sortrows([Cityname,num2cell(Tsquare)],2); % 按第二列的数据从小到大进行排列
Dist=[{'地区','霍特林T^2统计量'};Result5]
%% 调用pcare函数重建观测数据来评价信息损失量
for k=1:n
    Residuals=pcares(X,k); %参数k用来指定所用主成分的个数,并返回残差
    MSE(k)=sqrt(mean(Residuals(:).^2));% Mean square of error
    Rate=Residuals./X;
    RMSE(k)=sqrt(mean(Rate(:)).^2);% Relatively mean square of error
end
MSE % 显示残差均方根
RMSE % 显示相对误差的均方根
%% Elapsed time
toc
    