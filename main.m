%��ͨC4.5������������
%%
clear all;
clc;
global tree;
l=75;
r=85;

%��������
load('SpectralClassificationTest.mat')
load('SpectralClassificationTrain.mat')

%% ����Ԥ����
[train_x,mu1,xita]=zscore(train_x);
train_y=train_y(:,1);

%% PCA��ά
[coeff,score,~,~,explained,mu2] = pca(train_x);
explained=cumsum(explained);
low=sum((l<explained)==0)+1;
up=sum((r<explained)==0);

%% ������ѵ��
%treeΪ���ɵľ�����,P0Ϊѵ����Ԥ�⾫ȷ��
[tree,P0]=tree_train_main(train_x,train_y);
disp('ѵ����ʱ��')

%% ����������
test_x=normalize(test_x,mu,xita);
test_y=test_y(:,1);
tic;
[decision_y,P1]=tree_test_main(tree,test_x,test_y);
disp('������ʱ��')
toc;

%% ���Ʋ��Լ�Ԥ����ͼ
plot(test_y,'.');
hold on
plot(decision_y,'*');

%% δ��֦���ͳ��
fprintf('δ��֦ģ��ѵ����׼ȷ�ʣ�%f \r',P0);
fprintf('δ��֦ģ�Ͳ��Լ�׼ȷ�ʣ�%f \r',P1);
