%% 清理工作区
clc;
clear all;
close all;

%% 定义模型参数
A = [0.5 0.2 0.3; 0.3 0.5 0.2; 0.2 0.3 0.5]; % 状态转移矩阵
B = [0.5 0.5; 0.4 0.6; 0.7 0.3]; % 观测概率矩阵
pi = [0.2 0.4 0.4]; % 初始状态概率向量

%% 定义观测序列 (红=1, 白=2)
O = [1 2 1 2];

%% 前向算法
T = length(O); % 观测序列的长度
N = size(A, 1); % 状态数

%% 初始化alpha矩阵
alpha = zeros(T, N);

%% 初始步骤
for i = 1:N
    alpha(1, i) = pi(i) * B(i, O(1));
end

%% 递归步骤
for t = 2:T
    for j = 1:N
        sum_alpha = 0;
        for i = 1:N
            sum_alpha = sum_alpha + alpha(t-1, i) * A(i, j);
        end
        alpha(t, j) = sum_alpha * B(j, O(t));
    end
end

%% 终止步骤
P_O_given_lambda = sum(alpha(T, :));

%% 输出结果
disp('观测序列的概率 P(O|lambda):');
disp(P_O_given_lambda);
