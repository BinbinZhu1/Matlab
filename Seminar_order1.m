%% ����������۰�Ľ���˳�������������£�

% ����1��ѧ˶��ר˶һ�������۰࣬���۰�ÿ�ܰ������Σ�
% ����2�������۰࿪ʼ��ר˶ÿ�����ٰ���һ�ˣ��ڲ�����ѧ˶����һ��֮�ڰ�������ר˶
%        ͬѧ���Ρ�ѧ˶���Ǵӵ�һ�ܿ�ʼ�������������ܺ󣬸�һ���ٰ��ţ�������������
%        ֮��ÿ�ΰ���һ��ѧ˶��һ��ר˶��
% ����3��ѧ˶���꼶ͬѧ�������������򣩺͸��꼶ͬѧ�������ȡ����������뱻���������������ڡ�

% Ŀ����ʵ����������Ľ��ι���
% ��һ�����۰�˳�� ��һ�ܣ� ����  �������ȣ� �ڶ��ܣ� �ն��� �������� 
% �����ܣ�����  ��ƺ�  �����ܣ���ٻٻ �������ȣ�
% �����ܣ� �ײ���  �������� �����ܣ�������  ����
% �����ܣ���־�� �������� �ڰ��ܣ� �����ã�������
% zhubinbin 2016/12/7 

% ��ջ�������

clc
clear
close all 

% ʦ�����۰�ѧ������
name_list={'����','������','�ն���','����','����','��ƺ�','�ײ���'...
    '����','������','��־��','����','������'};
list_len=numel(name_list);

% δ�����������ǰ��ѧ������ͬѧ�����ļ���
academic_set={'������','����','����','������'};
academic_index=[];
prof_index=[];

% ����ʦ������ͬѧ������ѧ˶��ר˶�������������
seminar_order=name_list(randperm(list_len));

for i=1:length(academic_set)
        academic_index(i)=find(strcmp(academic_set(i),seminar_order)==1);       
end

while abs(academic_index(1)-academic_index(2)) ~=1 | abs(academic_index(3)-academic_index(4)) ~=1
    
    % ����ʦ������ͬѧ������ѧ˶��ר˶�������������
    seminar_order=name_list(randperm(list_len));
    temp=seminar_order;
    display(seminar_order);

    for i=1:length(academic_set)
        academic_index(i)=find(strcmp(academic_set(i),seminar_order)==1);       
    end

end
academic_index=sort(academic_index);

% �������ѧ������ͬѧ�����۰��˳��
academic_order=temp(academic_index);
academic_order={academic_order{:}};
display(academic_order);

seminar_order(academic_index)=[];
for k=1:list_len-numel(academic_set)
    prof_index(k)=find(strcmp(temp,seminar_order(k))==1);
end
prof_index;

% ���������ר˶����ͬѧ�����۰��˳��
prof_order=temp(prof_index);
prof_order={prof_order{:}};
display(prof_order);

sequence={};
time=7; % ÿ�����۰����
counter=1;
% for k=1:time
%     senquence(k,1:2)=prof_order(k:k+1);
% end
for i=1:time
    if rem(i,3)~=0
       for j=1:length(academic_order)
        sequence(counter,:)={prof_order(j),academic_order(j)};
            prof_order(j)=[];
            academic_order(j)=[];
            counter=counter+1;
            %if numel(sequence)==length(sequence(:))+2
                break;
            %end
       end
    else 
        %counter=counter+1;
        sequence(counter,:)={prof_order(1),prof_order(2)};
        counter=counter+1;
        prof_order(1:2)=[];
    end
end
        
%  academic_order={'','',academic{:}};
            
% ��Ԫ��������ʽ��ʾ���۰ི��˳������ս��
s={'�ڶ������۰ི��˳��';'��һ��';'�ڶ���';'������';'���Ĵ�';'�����'; ...
    '������'};
myresult(:,1)=s;
myresult(1,2:3)={'�ܶ�����ͬѧ����','��������ͬѧ����'};
% result(2:8,2:3)={sequence{1,1},sequence{1,2};sequence{2,1},sequence{2,2};sequence{3,1},sequence{3,2};...
%     sequence{4,1},sequence{4,2};sequence{5,1},sequence{5,2};sequence{6,1},sequence{6,2};...
%     sequence{7,1},sequence{7,2}}
myresult(2:7,2:3)=sequence





