%% 清理工作区
clc;
clear all;
close all;

%% 导入样本裂纹尺寸数据
load data;
time = [10000, 15000, 20000, 25000, 30000, 35000, 40000];

%% 绘制轨迹图
figure;
hold on;
for i = 1:size(data, 1)
    plot(time, data(i, :), '-o');
end
xlabel('时间周期');
ylabel('裂纹长度（mm）');
title('合金裂纹扩展轨迹');
hold off;

%% 计算每个样本的均值和方差
increments = diff(data, 1, 2);
mu = mean(mean(increments)) / 5000;
sigma = std(increments(:)) / sqrt(5000);

%% 设定损坏阈值
threshold = 30;

%% 计算剩余寿命及其分布
remaining_lifetimes = (threshold - data(:, end)) / mu;
fprintf('估计的模型参数：\n');
fprintf('平均扩展速率 μ = %.4f mm/周期\n', mu);
fprintf('波动强度 σ = %.4f mm/sqrt(周期)\n', sigma);

%% 绘制剩余寿命分布直方图
figure;
histogram(remaining_lifetimes, 'Normalization', 'pdf');
xlabel('剩余寿命（周期）');
ylabel('概率密度');
title('合金裂纹剩余寿命分布');
%% 输出剩余寿命
fprintf('剩余寿命：\n');
disp(remaining_lifetimes);