%% 清理变量及工作区
clc;
close all;
clear all;

%% 导入数据
load glass;
A=glass;
n = length(A(:,1));
NF = 9; %定义9个变量
Ntrs = 180; %设定180个数据为训练集

%% 数据随机排列
flag = randperm(n);
AA = A(flag,:);
AF = AA';
B = AF(1:NF,:);

%% 数据归一化并标签化
Bn = mapminmax(B, -1, 1);
iitr = 1:Ntrs;
iitest = Ntrs+1:n;
Atrain = Bn(:,iitr);
y_labels = AF(NF+1, iitr);
dd = full(ind2vec(y_labels));
TAtrain = Bn(:,iitest);
x = Atrain;
y = dd;

%% 神经网络的构建及训练
net = feedforwardnet([40, 35, 7], 'trainscg'); % 初始化网络，输出层有7个节点
net.trainParam.epochs = 1000; % 设定迭代次数为1000次
net.trainParam.lr = 0.1; % 设置学习率
net.trainParam.showWindow = false;
[net, tr] = train(net, x, y); % 进行网络训练

%% 数据仿真
x1 = TAtrain; % 待分样本
y1 = net(x1); % 数据仿真

%% 找到每列中的最大值索引，即预测类别
[~, Lable] = max(y1, [], 1);

%% 原始测试标签
La = AF(NF+1, iitest);

%% 计算准确率
num = Lable == La;
Accuracy = sum(num) / length(iitest)

%% 绘制图像
m = length(Lable);
OL = zeros(7, m);
TL = zeros(7, m);

for i = 1:m
    OL(Lable(i), i) = 1;
    TL(La(i), i) = 1;
end

figure, plotperform(tr);
figure, plottrainstate(tr);
figure, plotconfusion(TL, OL);
figure, plotroc(TL, OL);