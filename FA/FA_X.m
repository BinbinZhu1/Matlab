clc
clear
close all
warning off
tic

% �ýű��ļ��������ӷ�����(Factor Analysis)���������ݽ��з������Ӷ��ҳ����ɸ�
% �������������õؽ��ͱ���


%% ��ȡ����
[X,textdata]=xlsread('examp12_02.xls');
X=X(:,3:end); % ��ȡҪ����������
Varname=textdata(4,3:end); % ��ȡ������
Country=textdata(5:end,2); % ��ȡ��������
%% Factor Analysis
[m,n]=size(X);
[Lambda,Psi,T,Stats]=factoran(X,4) % ����󷽲���ת�������ӷ��������������غɾ���Lambda��
% ���ⷽ������Psi����ת����T��ģ�ͼ���ṹ�����Stats
Countri=100*sum(Lambda.^2)/n; % ������
CumContri=cumsum(Countri); % �����ۻ�������
%% Factor Analysis(Two factors)
[Lambda1,Psi1,T1,Stats1,Fscore]=factoran(X,2)
Countri1=100*sum(Lambda1.^2)/n;
CumCountri=cumsum(Countri1);
head={'����','����1','����2'};
Disp=[head;Varname',num2cell(Lambda1)]
%% �������ӵ÷�
ObjF=[Country num2cell(Fscore)]; % ���������ƺ����ӵ÷ַ���һ��ϸ����Ԫ������
F1=sortrows(ObjF,2) % ����һ�����ӵ÷�����
F2=sortrows(ObjF,3) % ���ڶ������ӵ÷�����
head1={'����/����','��һ����','�ڶ�����'};
Disp1=[head1;F1]
Disp2=[head1;F2] % �������Կ���ĳ����������Խ���ԣ����ӵ÷�ԽС
%% ���ӵ÷ֿ��ӻ�
figure
plot(-Fscore(:,1),-Fscore(:,2),'ro')
grid
xlabel('��һ���ӵ÷ָ�ֵ')
ylabel('�ڶ����ӵ÷ָ�ֵ')
title('���ӵ÷�ɢ��ͼ')
box off % ȥ������ϵ���ϵı߿�
gname(Country)
