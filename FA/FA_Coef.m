clc
clear
close all
warning off
tic

% �ýű��������ӷ�����(Factor Analysis)�����������ϵ�����������128����������
% ��ĵ�����ָ��������ɷַ���,�����ҳ����ɸ��������������Ĺ������ӣ��÷���
% ����Ӧ���ڷ�װ��׼���ƶ�������


%% ���ݶ���
Mcoef=[1     0.79    0.36    0.76    0.25    0.51
      0.79  1       0.31    0.55    0.17    0.35
      0.36  0.31    1       0.35    0.64    0.58
      0.76  0.55    0.35    1       0.16    0.38
      0.25  0.17    0.64    0.16    1       0.63
      0.51  0.35    0.58    0.38    0.63    1  ]; %�������ϵ������
[m,n]=size(Mcoef);
%% Factor Analysis
[Lambda,Psi,T]=factoran(Mcoef,2,'xtype','covariance','delta',0,'rotate','none') % ��
% ���ϵ������������������ӷ�����ѡ�ù������Ӹ���Ϊ2���������ⷽ������Ϊ0����������ת
head={'����','����1','����2'}; %�����ͷ
Varname={'���','����','��Χ','�۳�','��Χ','��Χ','������','�ۻ�������'};
Contri=100*sum(Lambda.^2)/n; %������
Cumcontri=cumsum(Contri); % �ۻ�������
Temp=num2cell([Lambda;Contri;Cumcontri]);
Disp=[head;Varname',Temp]
%% ������󷽲���ת���������ӷ���
[Lambda1,Psi1,T1]=factoran(Mcoef,2,'xtype','covariance','delta',0)
Contri1=100*sum(Lambda1.^2)/n
Cumcontri1=cumsum(Contri1)
%% �ı乫�����Ӹ���
[Lambda2,Psi2,T2]=factoran(Mcoef,3,'xtype','covariance','delta',0)
Contri2=100*sum(Lambda2.^2)/n;
Cumcontri2=cumsum(Contri2)
%% Elapsed time
toc
  