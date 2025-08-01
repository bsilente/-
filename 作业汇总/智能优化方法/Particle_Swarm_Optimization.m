%% 清理工作区
clc;
clear all;
close all;

%% 初始化粒子群模型参数
num_particles = 30; % 粒子数量
max_iterations = 100; % 最大迭代次数
w = 0.5; % 惯性权重
c1 = 1.5; % 个体学习因子
c2 = 1.5; % 群体学习因子
precision = 0.0001; % 精度

%% 初始化粒子位置和速度
x = -1 + 3 * rand(num_particles, 1); % 规定[-1, 2]作为初始位置
v = zeros(num_particles, 1); % 给定初始速度

%% 初始化个体最优位置和全局最优位置
p_best = x; % 个体最优位置
g_best = x(1); % 全局最优位置
for i = 2:num_particles
    if (p_best(i)^2 > g_best^2)
        g_best = p_best(i);
    end
end

%% 存储每次迭代的最优解
best_values = zeros(max_iterations, 1);

%% 粒子群算法迭代
for iter = 1:max_iterations
    for i = 1:num_particles
        % 更新速度和位置
        v(i) = w * v(i) + c1 * rand * (p_best(i) - x(i)) + c2 * rand * (g_best - x(i));
        x(i) = x(i) + v(i);
        
        % 检查位置是否在边界内
        if x(i) < -1
            x(i) = -1;
        elseif x(i) > 2
            x(i) = 2;
        end
        
        % 更新个体最优位置
        if (x(i)^2 > p_best(i)^2)
            p_best(i) = x(i);
        end
        
        % 更新全局最优位置
        if (p_best(i)^2 > g_best^2)
            g_best = p_best(i);
        end
    end
    best_values(iter) = g_best^2; % 记录当前迭代的全局最优值
    if iter > 1 && abs(best_values(iter) - best_values(iter-1)) < precision
        break;
    end
end

%% 输出最优解与最优值
disp(['最优解: ', num2str(g_best)]);
disp(['最优值: ', num2str(g_best^2)]);

%% 绘制图像
figure;
plot(1:iter, best_values(1:iter), 'LineWidth', 2);
xlabel('迭代次数');
ylabel('最优值');
title('粒子群算法优化过程');
grid on;
