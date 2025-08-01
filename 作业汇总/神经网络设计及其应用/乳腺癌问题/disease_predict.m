%% 清理变量及工作区
clc;
close all;
clear all;

%% 导入数据
load disease_predict;
A=A;
n = length(A(:,1));
NF = 9; %定义9个变量
Ntrs = 500; %设定500个数据为训练集

%% 数据随机排列
flag = randperm(n);
AA = A(flag,:);
AF = AA';
B = AF(1:NF,:);

%% 数据归一化并标签化
Bn = mapminmax(B,-1,1);
iitr = 1:Ntrs;
iitest = Ntrs+1:n;
Atrain = Bn(:,iitr);
y_be = AF(NF+1,iitr)==2;
y_ma = AF(NF+1,iitr)==4;
dd = [y_be',y_ma']';
TAtrain = Bn(:,iitest);
x = Atrain;
y=dd;

%% 神经网络的构建及训练
net = feedforwardnet([20,15],'trainscg');   %初始化网络
[net,tr] = train(net,x,y);  %进行网络训练
net.trainParam.epochs = 1000;   %设定迭代次数为1000次
net.trainParam.lr = 0.01;   %设置学习率
net.trainParam.showWindow = false;
x1 = TAtrain;   %待分样本 分样本
y1 = sim(net,x1);   %数据仿真

%% 计算准确率
[~,Lable] = max(y1,[],1);
Lable = Lable*2;
La = AF(NF+1,iitest);
num = Lable == AF(NF+1,iitest);
Accuracy = sum(num)/length(iitest)  %计算准确率

%% 绘制图像
m = length(Lable);
for i=1:m
    if Lable(i)==2
        OL(:,i)=[1;0];
    elseif Lable(i)==4
        OL(:,i)=[0;1];
    end
    if La(i)==2
        TL(:,i)=[1;0];
    elseif La(i)==4
        TL(:,i)=[0;1]; 
    end
end
figure,plotperform(tr)
figure,plottrainstate(tr)
figure,plotconfusion(TL,OL)
figure,plotroc(TL,OL)