function [Outclass,TabCoef,TabL,TabConfu,TabErrMat,TabG,TrainScore] =...
    Class_fisher(Sampledata,Training,group,contri)
%   LDA(linear discriminant analysis),��Fisher �б����
%   class = Class_fisher(Sampledata,Training,group) ����ѵ������Training�����б�ʽ��
%   ���������б�ʽ�Դ�����ƷSampledata�����б�. Sampledata��Training�Ǿ�����ͬ
%   �����ľ������ǵ�ÿһ�ж�Ӧһ���۲⣬ÿһ�ж�Ӧһ������. group��Training��
%   Ӧ�ķ������������ÿһ��Ԫ�ض�����Training����Ӧ�۲���������. group������һ
%   �������������ֵ�������ַ���������ַ���Ԫ������. Training��group���������
%   ͬ������. Class_fisher������group�е�NaN����ַ�����Ϊȱʧ���ݣ��Ӷ�����Training
%   ����Ӧ�Ĺ۲�. class�е�ÿ��Ԫ��ָ����Sampledata�е���Ӧ�۲����й����,����
%   group������ͬ����������. 
%
%   class = Class_fisher(Sampledata,Training,group,contri) �����ۻ������ʲ�����
%   contri��ȷ����Ҫʹ�õ��б�ʽ������Ĭ������£�ʹ�������б�ʽ�����б�. contri
%   ��һ����(0, 1]������ȡֵ�ı���������ָ���ۻ������ʵ�����. 
%
%   [class, TabCoef] = Class_fisher(...)�Ա����ʽ���������б�ʽ��ϵ����������contri
%   ȡֵΪ1���򷵻������б�ʽ��ϵ������. TabCoef��һ��Ԫ�����飬����
%       'Variable'    'can1'       'can2'   
%       'x1'          [-0.2087]    [ 0.0065]
%       'x2'          [-0.3862]    [ 0.5866]
%       'x3'          [ 0.5540]    [-0.2526]
%       'x4'          [ 0.7074]    [ 0.7695]

%   [class, TabCoef, TabL] = Class_fisher(...)�Ա����ʽ������������ֵ�������ʣ��ۻ�
%   �����ʵ�. TabL��һ��Ԫ�����飬����
%       'Eigenvalue'    'Difference'    'Proportion'    'Cumulative'
%       [   32.1919]    [   31.9065]    [    0.9912]    [    0.9912]
%       [    0.2854]              []    [    0.0088]    [         1]
%
%   [class, TabCoef, TabL, TabConf] = Class_fisher(...)�Ա����ʽ���ػ������󣨰�����
%   �ķ�����Ϣ�ľ���. TabConf��һ��Ԫ�����飬����
%       'From/To'       'setosa'    'versicolor'    'virginica'
%       'setosa'        [    50]    [         0]    [        0]
%       'versicolor'    [     0]    [        48]    [        2]
%       'virginica'     [     0]    [         1]    [       49]
%
%   [class, TabCoef, TabL, TabConf, TabErrMat] = Class_fisher(...)�Ա����ʽ�������о���. 
%   TabErrMat��һ��Ԫ�����飬����
%       'Obj'    'From'          'To'        
%       [ 71]    'versicolor'    'virginica' 
%       [ 84]    'versicolor'    'virginica' 
%       [134]    'virginica'     'versicolor'
%
%   [class, TabCoef, TabL, TabConf, TabErrMat, TabG] = Class_fisher(...)�������б�ʽ����
%   �ڸ�������ֵ�ϣ��õ����ֵͶӰ�����Ա����ʽ�����������. TabG��һ��Ԫ��
%   ���飬����
%       'Group'         'can1'       'can2'  
%       'setosa'        [-1.3849]    [1.8636]
%       'versicolor'    [ 0.9892]    [1.6081]
%       'virginica'     [ 1.9852]    [1.9443]

%   [class, TabCan, TabL, TabCon, TabM, TabG, TrainScore] = Class_fisher(...)����
%   ѵ����Ʒ����Ӧ���б�ʽ�÷�TrainScore. TrainScore�ĵ�һ��Ϊ��ѵ����Ʒԭ����
%   ���������ţ���i+1��Ϊ��i���б�ʽ�÷�.
%   Zhubinbin 2016/6/8
%   


if nargin < 3
    error('�����������̫�٣�������Ҫ3������.');
end

% ���ݷ������������������gindex������Ԫ������groups����ˮƽ����glevels
[gindex,groups,glevels] = grp2idx(group);
% ����ȱʧ����
nans = find(isnan(gindex));
if ~isempty(nans)
    Training(nans,:) = [];
    gindex(nans) = [];
end
ngroups = length(groups);
gsize = hist(gindex,1:ngroups);
nonemptygroups = find(gsize>0);
nusedgroups = length(nonemptygroups);

% �ж��Ƿ��пյ���
if ngroups > nusedgroups
    warning('����: �пյ���.');
end

[n,d] = size(Training);
if size(gindex,1) ~= n
    error('����: ���������С��ƥ�䣬GROUP��TRAINING���������ͬ������.');
elseif isempty(Sampledata)
    Sampledata = zeros(0,d,class(Sampledata));
elseif size(Sampledata,2) ~= d
    error('����: ���������С��ƥ�䣬SAMPLEDATA��TRAINING���������ͬ������.');
end

% ����contri��Ĭ��ֵΪ1�����޶�contri��(0, 1]��ȡֵ
if nargin < 4 || isempty(contri)
    contri = 1;
end
if ~isscalar(contri) || contri > 1 || contri <= 0
    error('����: contri ������һ����(0, 1]��ȡֵ�ı���.');
end

if any(gsize == 1)
    error('����: TRAINING�е�ÿ��������Ӧ�������۲�.');
end

% �����������ֵ
gmeans = NaN(ngroups, d); 
for k = nonemptygroups
    gmeans(k,:) = mean(Training(gindex==k,:),1);
end
% �����ܾ�ֵ
totalmean = mean(Training,1);

% �����������ƽ���;���E��������ƽ���;���B
E = zeros(d); % d������
B = E;
for k = nonemptygroups
    % �ֱ���Ƹ�����������ƽ���;���. 
%     [Q,Rk] = qr(bsxfun(@minus,Training(gindex==k,:),gmeans(k,:)), 0);
%     % ������������ƽ���;���AkHat = Rk'*Rk
%     % �жϸ�����������ƽ���;����������
%     s = svd(Rk);
%     if any(s <= max(gsize(k),d) * eps(max(s)))
%         error('����: TRAINING�и�����������ƽ���;����������������.');
%     end
%     E = E + Rk'*Rk;    % �����ܵ��������ƽ���;���E
    for j=1:gsize(k)
        Train=Training(gindex==k,:);
        E=E+(Training(j)-gmeans(k,:))'*(Training(j)-gmeans(k,:));
    end
    % ����������ƽ���;���B
    B = B + (gmeans(k,:) - totalmean)'*(gmeans(k,:) - totalmean)*gsize(k);
end

%  ��inv(E)*B��������ֵ����Ӧ����������
EB = E\B;
[V, D] = eig(EB);
D = diag(D);
[D, idD] = sort(D,'descend');  %������ֵ����������
V = V(:,idD);
NumPosi = min(ngroups-1, d);  %ȷ��������ֵ����
D = D(1:NumPosi, :);
CumCont = cumsum(D)/sum(D);  %�����ۻ�������

% �Ա����ʽ������������ֵ�������ʣ��ۻ������ʵ�. TabL��һ��Ԫ������
head = {'Eigenvalue', 'Difference', 'Proportion', 'Cumulative'};
TabL = cell(NumPosi+1, 4);
TabL(1,:) = head;
TabL(2:end,1) = num2cell(D);
if NumPosi == 1
    TabL(2:end-1,2) = {0};
else
    TabL(2:end-1,2) = num2cell(-diff(D));
end
TabL(2:end,3) = num2cell(D/sum(D));
TabL(2:end,4) = num2cell(CumCont);

% �����ۻ������ʵ�����contriȷ����Ҫʹ�õ��б�ʽ����CumContGeCon
CumContGeCon = find(CumCont >= contri);
CumContGeCon = CumContGeCon(1);
V = V(:, 1:CumContGeCon);  %��Ҫʹ�õ��б�ʽϵ������

% �Ա����ʽ���������б�ʽ��ϵ����������contriȡֵΪ1��
% �򷵻������б�ʽ��ϵ������. TabCan��һ��Ԫ������
TabCoef = cell(d+1, CumContGeCon+1);
TabCoef(1,1) = {'Variable'};
TabCoef(2:end,1) = strcat('x',cellstr(num2str((1:d)')));
TabCoef(1,2:end) = strcat('can',cellstr(num2str((1:CumContGeCon)')));
TabCoef(2:end,2:end) = num2cell(V);

% ��ѵ����Ʒ�������Ʒ����һ������б�
m = size(Sampledata,1);
gv = gmeans*V;
stv = [Sampledata; Training]*V;
nstv = size(stv, 1);
message = '';
Outclass = NaN(nstv, 1);
for i = 1:nstv
    obji = bsxfun(@minus,stv(i,:),gv);
    obji = sum(obji.^2, 2);
    idclass = find(obji == min(obji));
    if length(idclass) > 1
        idclass = idclass(1);
        message = '����: ������һ��������';
    end
    Outclass(i) = idclass;
end
warning(message);
trclass = Outclass(m+(1:n));  %ѵ����Ʒ���б�����������Ź��ɵ�������
Outclass = Outclass(1:m);  %������Ʒ���б�����������Ź��ɵ�������
Outclass = glevels(Outclass,:);  %��������Ʒ���б�������һ������ת��

trg1 = groups(gindex);  %ѵ����Ʒ�ĳ�ʼ������
trg2 = groups(trclass);  %ѵ����Ʒ���б���������
% �Ա����ʽ���ػ������󣨰����ܵķ�����Ϣ�ľ���. TabCon��һ��Ԫ������
[CLMat, order] = confusionmat(trg1,trg2);
TabConfu = [[{'From/To'},order'];order, num2cell(CLMat)];

% �Ա����ʽ�������о���. TabM��һ��Ԫ������
miss = find(gindex ~= trclass);  %ѵ����Ʒ��������Ʒ�ı��
head1 = {'Obj', 'From', 'To'};
TabErrMat = [head1; num2cell(miss), trg1(miss), trg2(miss)];

% �������б�ʽ�����ڸ�������ֵ�ϣ��õ����ֵͶӰ�����Ա����ʽ�����������. 
% TabG��һ��Ԫ������
TabG = cell(ngroups+1,CumContGeCon+1);
TabG(:,1) = [{'Group'};groups];
TabG(1,2:end) = strcat('can',cellstr(num2str((1:CumContGeCon)')));
TabG(2:end,2:end) = num2cell(gv);

% ����ѵ����Ʒ����Ӧ���б�ʽ�÷�
TrainScore = Training*V;
TrainScore = [gindex, TrainScore];

