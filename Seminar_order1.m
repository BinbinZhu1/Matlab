%% 随机产生讨论班的讲课顺序（满足条件如下）

% 条件1：学硕和专硕一起上讨论班，讨论班每周安排两次；
% 条件2：自讨论班开始起专硕每周至少安排一人，在不安排学硕的那一周之内安排两名专硕
%        同学讲课。学硕则是从第一周开始，连续安排两周后，隔一周再安排，且那连续两周
%        之内每次安排一个学硕和一个专硕；
% 条件3：学硕低年级同学（高阳、陈晓莉）和高年级同学（赵玉稳、吴琪）必须被安排在相邻两周内。

% 目标是实现形如下面的讲课规则：
% 第一轮讨论班顺序： 第一周： 朱彬彬  （赵玉稳） 第二周： 颜定勇 （吴琪） 
% 第三周：王瑞  杨浩浩  第四周：甘倩倩 （赵玉稳）
% 第五周： 雷昌宁  （吴琪） 第六周：刘云巧  李响
% 第七周：郭志春 （高阳） 第八周： 韩玉婷（陈晓莉）
% zhubinbin 2016/12/7 

% 清空环境变量

clc
clear
close all 

% 师门讨论班学生名单
name_list={'朱彬彬','赵玉稳','颜定勇','吴琪','王瑞','杨浩浩','雷昌宁'...
    '李响','刘云巧','郭志春','高阳','陈晓莉'};
list_len=numel(name_list);

% 未进行随机排序前，学术所有同学姓名的集合
academic_set={'赵玉稳','吴琪','高阳','陈晓莉'};
academic_index=[];
prof_index=[];

% 对我师门所有同学（包括学硕和专硕）进行随机排序
seminar_order=name_list(randperm(list_len));

for i=1:length(academic_set)
        academic_index(i)=find(strcmp(academic_set(i),seminar_order)==1);       
end

while abs(academic_index(1)-academic_index(2)) ~=1 | abs(academic_index(3)-academic_index(4)) ~=1
    
    % 对我师门所有同学（包括学硕和专硕）进行随机排序
    seminar_order=name_list(randperm(list_len));
    temp=seminar_order;
    display(seminar_order);

    for i=1:length(academic_set)
        academic_index(i)=find(strcmp(academic_set(i),seminar_order)==1);       
    end

end
academic_index=sort(academic_index);

% 随机产生学术所有同学讲讨论班的顺序
academic_order=temp(academic_index);
academic_order={academic_order{:}};
display(academic_order);

seminar_order(academic_index)=[];
for k=1:list_len-numel(academic_set)
    prof_index(k)=find(strcmp(temp,seminar_order(k))==1);
end
prof_index;

% 随机产生的专硕所有同学讲讨论班的顺序
prof_order=temp(prof_index);
prof_order={prof_order{:}};
display(prof_order);

sequence={};
time=7; % 每轮讨论班次数
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
            
% 以元胞数组形式显示讨论班讲课顺序的最终结果
s={'第二轮讨论班讲课顺序';'第一次';'第二次';'第三次';'第四次';'第五次'; ...
    '第六次'};
myresult(:,1)=s;
myresult(1,2:3)={'周二讲课同学姓名','周三讲课同学姓名'};
% result(2:8,2:3)={sequence{1,1},sequence{1,2};sequence{2,1},sequence{2,2};sequence{3,1},sequence{3,2};...
%     sequence{4,1},sequence{4,2};sequence{5,1},sequence{5,2};sequence{6,1},sequence{6,2};...
%     sequence{7,1},sequence{7,2}}
myresult(2:7,2:3)=sequence





