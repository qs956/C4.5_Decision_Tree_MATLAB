function []=decisionTreeTrain(data)
%������ѵ������
%   ���룺��������data,ÿһ��Ϊһ������,ÿһ��Ϊһ������(���һ��Ϊ��ǩ��)
%%

%���Ѿ�����Ϊȫ�ֱ���
global Tree;
global type;
%������ʾѵ������
type
%�����ǰ��������ȫ����ͬһ����,��ô���ؿ�ֵ,ͬʱ���ΪҶ�ڵ�
%bestvalue����ΪInf,bestattribute����Ϊ��ǰ���ݼ�������������y
if size(unique(data(:,end)),1)==1
    temp=table('leaf',size(type,2),data(1,end),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
    return;
end

%%
%����ʼ����
%������ѻ��������Լ���ѻ���ֵ
[bestvalue,bestattribute]=BestAttribute(data);
%���ݽ��,����ԭ������Ϊ��������set1,set2
[set1,set2]=divideset(data,bestattribute,bestvalue);

%�����һ������Ϊ��,��ζ���Ѿ��޷�����
%���ΪҶ�ڵ�
if  isempty(set1)||isempty(set2)
    temp=table('leaf',size(type,2),mode([set1(:,end);set2(:,end)]),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
    return;
end

%����Ļ��Ѹû��ֽڵ�д�����
temp=table('node',size(type,2),bestattribute,bestvalue,{set1},{set2},'RowNames',{type});
temp.Properties.VariableNames = ...
{'Type','depth','bestattribute','bestvalue','set1','set2'};
Tree=[Tree;temp];

%���±�ʶ��
type=[type,'l'];
%���ֻ��һ��,���ΪҶ�ڵ�
if size(set1,1)==1
%     temp=table('leaf',size([type,'l'],2),set1(end),inf,{0},{0},'RowNames',{[type,'l']});
    temp=table('leaf',size([type],2),set1(end),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
else
    decisionTreeTrain(set1);
%     type=type(1:end-1);
end


%����ݹ�
% decisionTreeTrain(set1);


type=[type,'r'];
if size(set2,1)==1
    temp=table('leaf',size([type],2),set2(end),inf,{0},{0},'RowNames',{type});
    temp.Properties.VariableNames = ...
    {'Type','depth','bestattribute','bestvalue','set1','set2'};
    Tree=[Tree;temp];
    type=type(1,1:end-1);
else
    decisionTreeTrain(set2);
%     type=type(1:end-1);
end


%������ɺ���ı�ʶ��
type=type(1:end-1);
return;
end

