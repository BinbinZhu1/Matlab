clc
clear
close all
tic

%% ����fisher�б𷨶�Iris��β���������б����
% Zhubinbin 2016/6/9

S=load('fisheriris.mat'); %������������
X=[5.8 2.7 1.8 0.73
   5.6 3.1 3.8 1.8
   6.1 2.5 4.7 1.1
   6.1 2.6 5.7 1.9
   5.1 3.1 6.5 0.62
   5.8 3.7 3.9 0.13
   5.7 2.7 1.1 0.12
   6.4 3.2 2.4 1.6
   6.7 3 1.9 1.1
   6.8 3.5 7.9 1]; %����δ�б���Ʒ�Ĺ۲����X
[Outclass,TabCoef,TabL,TabConfu,TabErrMat,TabG,TrainScore] = Class_fisher(X,S.meas,S.species) % ����fisher
% ���������б���࣬�����б���Outclass���б�ʽ��ϵ������TabCoef,��������ֵ�������ʡ��ۻ������ʵ�TabL��
% ��������TabConfu,���о���TabErrMat,ͶӰ����TabG���Լ��б�ʽ�÷�����
TS=TrainScore;
TS1=TS(TS(:,1)==1,:); % ��һ����б�ʽ�÷�
TS2=TS(TS(:,1)==2,:); % �ڶ�����б�ʽ�÷�
TS3=TS(TS(:,1)==3,:); % ��������б�ʽ�÷�
plot(TS1(:,2),TS1(:,3),'mo')
hold on
plot(TS2(:,2),TS2(:,3),'b*')
hold on
plot(TS3(:,2),TS3(:,3),'r+')
legend('setosa��','versicolor��','virginica��','location','southeast');
grid
xlabel('��һ�б�ʽ�÷�')
ylabel('�ڶ��б�ʽ�÷�')
[Outclass,TabCoef,TabL,TabConfu,TabErrMat,TabG,TrainScore1] = Class_fisher(X,S.meas,S.species,0.5)
% ���ݹ���������������������0.9��ȷ���б�ʽ����
figure
TS_new=TrainScore1;
TS_new1=TS_new(TS_new(:,1)==1,:); % ��һ����б�ʽ�÷�
TS_new2=TS_new(TS_new(:,1)==2,:); % �ڶ�����б�ʽ�÷�
TS_new3=TS_new(TS_new(:,1)==3,:); % ��������б�ʽ�÷�
plot(TS_new1(:,2),'mo')
hold on
plot(TS_new2(:,2),'b*')
plot(TS_new3(:,2),'r+')
legend('setosa��','versicolor��','virginica��','Location','northoutside','Orientation','horizontal');
grid
xlabel('��Ʒ����')
ylabel('��һ�б�ʽ�÷�') 

% Elapsed time
toc


