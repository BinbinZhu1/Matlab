% ��ջ�������
clc
clear
close all
tic

% �ýű��������ɷַ�������PCA���������۲�ֵ���������2007���ҹ�31��ʡ���С�������
% ��ֱϽ�е�ũ������ͥƽ��ÿ��ȫ��������֧����8����Ҫ�����������ɷַ���
% Zhubinbin 2016/6/10

[X,textdata]=xlsread('examp11_02.xls');
XZ=zscore(X); % ���ݱ�׼��
[Coef,Score,Cval,Tsquare]=princomp(XZ) % ����princomp�������ݱ�׼���������۲�������
% �������ɷַ������������ɷֱ��ʽ��ϵ������Coef�����ɷֵ÷�����Score���������ϵ��
% �������������Cval��ÿ���۲�������ݼ��������۲�������ĵĻ����֣�Hotelling��T^2
% ͳ����
Expl=100*Cval/sum(Cval); % ���㹱����
[m,n]=size(X);
Result1=cell(n+1,4); % ����һ���յ�Ԫ������
Result1(1,:)={'����ֵ','��ֵ','�����ʣ�%��','�ۻ������ʣ�%��'};
Result1(2:end,1)=num2cell(Cval);
Result1(2:end-1,2)=num2cell(-diff(Cval));
Result1(2:end,3:4)=num2cell([Expl,cumsum(Expl)]);
Result1 % ��Ԫ��������ʽ��ʾ����ֵ�������ʺ��ۻ�������
Varname=textdata(3,2:end); % ��ȡ��������
Result2=cell(n+1,3);
Result2(1,:)={'��׼������','���ɷ�Prin1','���ɷ�Prin2'};
Result2(2:end,1)=Varname;
Result2(2:end,2:3)=num2cell(Coef(:,[1,2]));
Result2 % ��Ԫ��������ʽ��ʾǰ�������ɷֱ��ʽ��ϵ������
Cityname=textdata(4:end,1); 
SumXZ=sum(XZ,2);
[S1,Id1]=sortrows(Score,1); % �����ɷֵ÷����ݰ���һ���ɷֵ÷ִ�С��������
Result3=cell(m+1,4);
Result3(1,:)={'����','��֧��','��һ���ɷֵ�y1','�ڶ����ɷֵ÷�y2'};
Result3(2:end,1)=Cityname(Id1);
Result3(2:end,2:end)=num2cell([SumXZ(Id1),S1(:,1:2)]);
Result3 % ��Ԫ��������ʽ������֧������һ���ֵ÷ֺ͵ڶ����ɷֵ÷�
food=sum(XZ(:,[1,8]),2)-sum(XZ(:,[2,7]),2);
[S2,Id2]=sortrows(Score,2);% �����ɷ����ݰ��ڶ����ɷֵ÷ִ�С��������
Result4=cell(m+1,4);
Result4(1,:)={'����','��һ���ɷֵ÷�y1','�ڶ����ɷֵ÷�y2','��ʳƷ+������-������+ҽ����'};
Result4(2:end,1)=Cityname(Id2);
Result4(2:end,2:end)=num2cell([S2(:,1:2),food(Id2)]);
Result4 % ��Ԫ��������ʽ����ǰ�������ɷֵĵ÷����ݺͣ�ʳƷ+������-������+ҽ����
%% ���ɷֵ÷�ɢ��ͼ
plot(Score(:,1),Score(:,2),'ro')
grid
xlabel('��һ���ɷֵ÷�')
ylabel('�ڶ����ɷֵ÷�')
title('ǰ�������ɷֵ÷�ɢ��ͼ')
%gname(Cityname) % ����ʽ��עÿ������������
%% ���ݻ�����(Hotelling)T^2ͳ����Ѱ�Ҽ�������
Result5=sortrows([Cityname,num2cell(Tsquare)],2); % ���ڶ��е����ݴ�С�����������
Dist=[{'����','������T^2ͳ����'};Result5]
%% ����pcare�����ؽ��۲�������������Ϣ��ʧ��
for k=1:n
    Residuals=pcares(X,k); %����k����ָ���������ɷֵĸ���,�����زв�
    MSE(k)=sqrt(mean(Residuals(:).^2));% Mean square of error
    Rate=Residuals./X;
    RMSE(k)=sqrt(mean(Rate(:)).^2);% Relatively mean square of error
end
MSE % ��ʾ�в������
RMSE % ��ʾ������ľ�����
%% Elapsed time
toc
    