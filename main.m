%普通C4.5决策树主程序
%%
clear all;
clc;
global tree;
l=75;
r=85;

%加载数据
load('SpectralClassificationTest.mat')
load('SpectralClassificationTrain.mat')

%% 数据预处理
[train_x,mu1,xita]=zscore(train_x);
train_y=train_y(:,1);

%% PCA降维
[coeff,score,~,~,explained,mu2] = pca(train_x);
explained=cumsum(explained);
low=sum((l<explained)==0)+1;
up=sum((r<explained)==0);

%% 决策树训练
%tree为生成的决策树,P0为训练集预测精确度
[tree,P0]=tree_train_main(train_x,train_y);
disp('训练用时：')

%% 决策树测试
test_x=normalize(test_x,mu,xita);
test_y=test_y(:,1);
tic;
[decision_y,P1]=tree_test_main(tree,test_x,test_y);
disp('测试用时：')
toc;

%% 绘制测试集预测结果图
plot(test_y,'.');
hold on
plot(decision_y,'*');

%% 未剪枝结果统计
fprintf('未剪枝模型训练集准确率：%f \r',P0);
fprintf('未剪枝模型测试集准确率：%f \r',P1);
