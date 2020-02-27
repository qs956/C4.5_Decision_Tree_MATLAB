function [] = cut(data,y)
%决策树剪枝函数
%	输入：验证集data(一行为一个样本,一列为一个属性)
%             验证集对应的标签类型y
%%

%先把树复制一份
global Tree;
global type;
test_Tree=Tree;

%%
%计算验证集预测准确率
attribute=Tree{'root','bestattribute'};
value=Tree{'root','bestvalue'};

for j=1:1:size(data,1)
    %先判断每个属性是哪个子树
    if data(j,attribute)>value
        type='l';
    else
        type='r';
    end
    decision_y(j,1)=decisionTreeTest(data(j,:));
end

%模型准确率
P=nnz(decision_y==y)/size(data,1);

%提取表中类型为'node'而且深度不唯0的行
index=string(test_Tree.Type)=="node"&test_Tree.depth~=0;
for j=1:1:size(index,1)
%     if index(j,1)==1
        test_Tree=Tree;
        test_Tree{j,'Type'}='leaf';
        temp=cell2mat([test_Tree{j,'set1'};test_Tree{j,'set2'}]);
        test_Tree{j,'bestattribute'}=mode(temp(:,end));
        save=Tree;
        Tree=test_Tree;
        for i=1:1:size(data,1)
            if data(i,attribute)>value
                type='l';
            else
                type='r';
            end
            decision_y(i,1)=decisionTreeTest(data(i,:));
        end
        P1=nnz(decision_y==y)/size(data,1);
        if P1<P
            Tree=save;
        end
%     else
%     end
end

end

