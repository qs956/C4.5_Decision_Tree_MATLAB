function [] = cut(data,y)
%��������֦����
%	���룺��֤��data(һ��Ϊһ������,һ��Ϊһ������)
%             ��֤����Ӧ�ı�ǩ����y
%%

%�Ȱ�������һ��
global Tree;
global type;
test_Tree=Tree;

%%
%������֤��Ԥ��׼ȷ��
attribute=Tree{'root','bestattribute'};
value=Tree{'root','bestvalue'};

for j=1:1:size(data,1)
    %���ж�ÿ���������ĸ�����
    if data(j,attribute)>value
        type='l';
    else
        type='r';
    end
    decision_y(j,1)=decisionTreeTest(data(j,:));
end

%ģ��׼ȷ��
P=nnz(decision_y==y)/size(data,1);

%��ȡ��������Ϊ'node'������Ȳ�Ψ0����
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

