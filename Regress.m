clc
clear
close all

% 该脚本用回归分析来研究两个变量之间的相关关系，首先建立回归方程，然后对回归系数进行
% 显著性检验以确定哪些变量对模型结果有显著影响；其次，通过回归诊断来找出异常点和强影响点
% 来改进模型，最后通过残差分析来检验模型是否合适，最后将稳健回归拟合和非稳健回归拟合作比较，
% 来判断哪种模型效果更佳。
% Zhubinbin 2016/5/5

%% 数据读入
Data=xlsread('examp08_01.xls');
x=Data(:,1);
y=Data(:,5);
%% 数据可视化
figure
plot(x,y,'k.','markersize',9) % scatter diagram of data
xlabel('temperature')
ylabel('sunshine time')
grid
title('Scatter Diagram')
mdl=LinearModel.fit(x,y) % slove the regression model
figure
mdl.plot; % 绘制模型拟合效果图
xlabel('年平均气温')
ylabel('全年日照时数')
title('模型拟合效果图')
legend('原始散点图','回归直线','置信区间')
%% 模型预测
xnew=[5,25]';
ynew=mdl.predict(xnew)
%% 回归诊断
Res=mdl.Residuals; % 查询残差值
Res_Stu=Res.Studentized; % 学生化残差
Res_Stan=Res.Standardized; %标准化残差
figure
subplot(2,3,1);
plot(Res_Stu,'kx'); %绘制学生化残差图
refline(0,2);
refline(0,-2);
title('(a) 学生化残差图')
xlabel('观测序号')
ylabel('学生化残差')
subplot(2,3,2)
mdl.plotDiagnostics('cookd'); % 绘制Cook距离图
title('(b) Cook距离图')
xlabel('观测序号')
ylabel('Cook距离')
subplot(2,3,3)
mdl.plotDiagnostics('covratio'); % 绘制Covratio统计量图
title('(c) Covratio统计量图')
xlabel('观测序号')
ylabel('Covratio统计量')
subplot(2,3,4)
plot(Res_Stan,'kx'); % 绘制标准化残差图
refline(0,-2);
refline(0,2);
title('(d) 标准化残差图')
xlabel('观测序号')
ylabel('标准化残差')
subplot(2,3,5)
mdl.plotDiagnostics('dffits'); % 绘制Dffits统计量图
title('(e) Dffits统计量图');
xlabel('观测序号')
ylabel('Dffits统计量')
subplot(2,3,6)
mdl.plotDiagnostics('leverage'); % 绘制杠杆值图
title('(f) 杠杆值图')
xlabel('观测序号')
ylabel('杠杆值')
%% 模型改进
id=find(abs(Res_Stu)>2); % 查找异常值序号
mdl1=LinearModel.fit(x,y,'exclude',id)
figure
mdl1.plot; %绘制模拟效果图
xlabel('年平均气温')
ylabel('全年日照时数')
title('改进模型拟合效果图')
legend('剔除异常数据后散点图','回归直线','置信区间')
%% 模型改进前后比较
figure
plot(x,y,'ko');
hold on
grid
x_new=sort(x);
yhat1=mdl.predict(x_new);
yhat2=mdl1.predict(x_new);
plot(x_new,yhat1,'r--','linewidth',2);
plot(x_new,yhat2,'b','linewidth',2);
legend('原始数据散点','原始数据回归直线','剔除异常数据后回归直线')
xlabel('年平均气温')
ylabel('全年日照时数')
%% 模型改进后残差分析
figure
subplot(2,3,1)
mdl1.plotResiduals('caseorder') % 绘制残差序列图
title('(a) 残差值序列图')
xlabel('观测序号')
ylabel('残差')
subplot(2,3,2)
mdl1.plotResiduals('fitted'); % 绘制残差与拟合值图
title('(b) 残差与拟合值图')
xlabel('拟合值')
ylabel('残差')
subplot(2,3,3)
plot(x,mdl1.Residuals.Raw,'kx'); % 绘制残差与自变量图
line([0,25],[0,0],'color','k','linestyle',':');
title('(c) 残差与自变量图')
xlabel('自变量值')
ylabel('残差')
subplot(2,3,4)
mdl1.plotResiduals('histogram'); % 绘制直方图
title('(d) 残差直方图')
xlabel('残差R')
ylabel('频率')
subplot(2,3,5)
mdl1.plotResiduals('probability'); % 绘制残差正态概率图
title('(e) 残差正态概率图');
xlabel('残差 ')
ylabel('概率')
subplot(2,3,6)
mdl1.plotResiduals('lagged'); % 绘制残差与滞后残差图
title('(f) 残差与滞后残差图')
xlabel('滞后残差')
ylabel('残差')
%% Robust Regression
mdl2=LinearModel.fit(x,y,'Robustopts','on')
yhat3=mdl2.predict(x_new);
figure
plot(x,y,'ko');
hold on
plot(x_new,yhat1,'r--','linewidth',2);
plot(x_new,yhat3,'b','linewidth',2);
legend('原始数据散点图','非稳健拟合回归直线','稳健拟合回归直线');
xlabel('年平均气温')
ylabel('全年日照时数')
Mse_Comp=[mdl.MSE mdl1.MSE mdl2.MSE]
field1='Mdl';
value1=mdl.ModelCriterion;
field2='Mdl1';
value2=mdl1.ModelCriterion;
field3='Mdl2';
value3=mdl2.ModelCriterion;
s=struct(field1,value1,field2,value2,field3,value3);
s.Mdl
s.Mdl1
s.Mdl2


