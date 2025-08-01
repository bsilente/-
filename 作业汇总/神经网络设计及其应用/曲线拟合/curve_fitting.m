%% 清理工作区
clc;
clear;
close all;

%% 生成数据
x = linspace(-2*pi, 2*pi, 100); % 生成-2π到2π之间的1000个点
y = 2*sin(3*x) + 3*cos(2*x); % 计算对应的y值

%% 分割数据为训练集和测试集
train_ratio = 0.76; % 80%的数据作为训练集
n_train = round(train_ratio * length(x));
x_train = x(1:n_train);
y_train = y(1:n_train);
x_test = x(n_train+1:end);
y_test = y(n_train+1:end);

%% 神经网络的构建与训练
hidden_layer_size = [10, 10]; % 隐藏层的大小
net = feedforwardnet(hidden_layer_size);
[net, tr] = train(net, x_train, y_train);

%% 对后续函数的预测
y_pred_train = net(x_train);
y_pred_test = net(x_test);

%% 计算训练集和测试集的均方误差
mse_train = immse(y_train, y_pred_train)
mse_test = immse(y_test, y_pred_test)

%% 绘制图像
figure;
subplot(2,1,1);
plot(x_train, y_train, 'b', 'DisplayName', '真实值');
hold on;
plot(x_train, y_pred_train, 'r--', 'DisplayName', '预测值');
title('训练集');
legend;

subplot(2,1,2);
plot(x_test, y_test, 'b', 'DisplayName', '真实值');
hold on;
plot(x_test, y_pred_test, 'r--', 'DisplayName', '预测值');
title('测试集');
legend;

