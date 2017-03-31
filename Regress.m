clc
clear
close all

% �ýű��ûع�������о���������֮�����ع�ϵ�����Ƚ����ع鷽�̣�Ȼ��Իع�ϵ������
% �����Լ�����ȷ����Щ������ģ�ͽ��������Ӱ�죻��Σ�ͨ���ع�������ҳ��쳣���ǿӰ���
% ���Ľ�ģ�ͣ����ͨ���в����������ģ���Ƿ���ʣ�����Ƚ��ع���Ϻͷ��Ƚ��ع�������Ƚϣ�
% ���ж�����ģ��Ч�����ѡ�
% Zhubinbin 2016/5/5

%% ���ݶ���
Data=xlsread('examp08_01.xls');
x=Data(:,1);
y=Data(:,5);
%% ���ݿ��ӻ�
figure
plot(x,y,'k.','markersize',9) % scatter diagram of data
xlabel('temperature')
ylabel('sunshine time')
grid
title('Scatter Diagram')
mdl=LinearModel.fit(x,y) % slove the regression model
figure
mdl.plot; % ����ģ�����Ч��ͼ
xlabel('��ƽ������')
ylabel('ȫ������ʱ��')
title('ģ�����Ч��ͼ')
legend('ԭʼɢ��ͼ','�ع�ֱ��','��������')
%% ģ��Ԥ��
xnew=[5,25]';
ynew=mdl.predict(xnew)
%% �ع����
Res=mdl.Residuals; % ��ѯ�в�ֵ
Res_Stu=Res.Studentized; % ѧ�����в�
Res_Stan=Res.Standardized; %��׼���в�
figure
subplot(2,3,1);
plot(Res_Stu,'kx'); %����ѧ�����в�ͼ
refline(0,2);
refline(0,-2);
title('(a) ѧ�����в�ͼ')
xlabel('�۲����')
ylabel('ѧ�����в�')
subplot(2,3,2)
mdl.plotDiagnostics('cookd'); % ����Cook����ͼ
title('(b) Cook����ͼ')
xlabel('�۲����')
ylabel('Cook����')
subplot(2,3,3)
mdl.plotDiagnostics('covratio'); % ����Covratioͳ����ͼ
title('(c) Covratioͳ����ͼ')
xlabel('�۲����')
ylabel('Covratioͳ����')
subplot(2,3,4)
plot(Res_Stan,'kx'); % ���Ʊ�׼���в�ͼ
refline(0,-2);
refline(0,2);
title('(d) ��׼���в�ͼ')
xlabel('�۲����')
ylabel('��׼���в�')
subplot(2,3,5)
mdl.plotDiagnostics('dffits'); % ����Dffitsͳ����ͼ
title('(e) Dffitsͳ����ͼ');
xlabel('�۲����')
ylabel('Dffitsͳ����')
subplot(2,3,6)
mdl.plotDiagnostics('leverage'); % ���Ƹܸ�ֵͼ
title('(f) �ܸ�ֵͼ')
xlabel('�۲����')
ylabel('�ܸ�ֵ')
%% ģ�͸Ľ�
id=find(abs(Res_Stu)>2); % �����쳣ֵ���
mdl1=LinearModel.fit(x,y,'exclude',id)
figure
mdl1.plot; %����ģ��Ч��ͼ
xlabel('��ƽ������')
ylabel('ȫ������ʱ��')
title('�Ľ�ģ�����Ч��ͼ')
legend('�޳��쳣���ݺ�ɢ��ͼ','�ع�ֱ��','��������')
%% ģ�͸Ľ�ǰ��Ƚ�
figure
plot(x,y,'ko');
hold on
grid
x_new=sort(x);
yhat1=mdl.predict(x_new);
yhat2=mdl1.predict(x_new);
plot(x_new,yhat1,'r--','linewidth',2);
plot(x_new,yhat2,'b','linewidth',2);
legend('ԭʼ����ɢ��','ԭʼ���ݻع�ֱ��','�޳��쳣���ݺ�ع�ֱ��')
xlabel('��ƽ������')
ylabel('ȫ������ʱ��')
%% ģ�͸Ľ���в����
figure
subplot(2,3,1)
mdl1.plotResiduals('caseorder') % ���Ʋв�����ͼ
title('(a) �в�ֵ����ͼ')
xlabel('�۲����')
ylabel('�в�')
subplot(2,3,2)
mdl1.plotResiduals('fitted'); % ���Ʋв������ֵͼ
title('(b) �в������ֵͼ')
xlabel('���ֵ')
ylabel('�в�')
subplot(2,3,3)
plot(x,mdl1.Residuals.Raw,'kx'); % ���Ʋв����Ա���ͼ
line([0,25],[0,0],'color','k','linestyle',':');
title('(c) �в����Ա���ͼ')
xlabel('�Ա���ֵ')
ylabel('�в�')
subplot(2,3,4)
mdl1.plotResiduals('histogram'); % ����ֱ��ͼ
title('(d) �в�ֱ��ͼ')
xlabel('�в�R')
ylabel('Ƶ��')
subplot(2,3,5)
mdl1.plotResiduals('probability'); % ���Ʋв���̬����ͼ
title('(e) �в���̬����ͼ');
xlabel('�в� ')
ylabel('����')
subplot(2,3,6)
mdl1.plotResiduals('lagged'); % ���Ʋв����ͺ�в�ͼ
title('(f) �в����ͺ�в�ͼ')
xlabel('�ͺ�в�')
ylabel('�в�')
%% Robust Regression
mdl2=LinearModel.fit(x,y,'Robustopts','on')
yhat3=mdl2.predict(x_new);
figure
plot(x,y,'ko');
hold on
plot(x_new,yhat1,'r--','linewidth',2);
plot(x_new,yhat3,'b','linewidth',2);
legend('ԭʼ����ɢ��ͼ','���Ƚ���ϻع�ֱ��','�Ƚ���ϻع�ֱ��');
xlabel('��ƽ������')
ylabel('ȫ������ʱ��')
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


