%% 清理工作区
clc;
clear all;
close all;

%% 设定城市坐标
cities = [0 0; 1 5; 5 2; 6 6; 8 3];

%% 初始化蚁群参数
num_ants = 50; % 设定蚂蚁数量
iterations = 100; % 规定最大迭代次数
alpha = 1; % 信息素重要性因子
beta = 5; % 启发因子
rho = 0.5; % 信息素挥发系数

%% 计算最短路径与成本
n = size(cities, 1);
pheromone = ones(n);
best_path = [];
best_cost = inf;

for it = 1:iterations
    paths = zeros(num_ants, n);
    costs = zeros(1, num_ants);

    for k = 1:num_ants
        path = zeros(1, n);
        path(1) = randi(n);
        for i = 2:n
            probabilities = zeros(1, n);
            for j = 1:n
                if ~ismember(j, path(1:i-1))
                    probabilities(j) = (pheromone(path(i-1), j)^alpha) * (1/pdist2(cities(path(i-1), :), cities(j, :))^beta);
                end
            end
            probabilities = probabilities / sum(probabilities);
            path(i) = randsample(1:n, 1, true, probabilities);
        end
        paths(k, :) = path;
        cost = 0;
        for i = 2:n
            cost = cost + pdist2(cities(path(i-1), :), cities(path(i), :));
        end
        cost = cost + pdist2(cities(path(end), :), cities(path(1), :));
        costs(k) = cost;
        if cost < best_cost
            best_cost = cost;
            best_path = path;
        end
    end

    pheromone = (1 - rho) * pheromone;
    for k = 1:num_ants
        for i = 2:n
            pheromone(paths(k, i-1), paths(k, i)) = pheromone(paths(k, i-1), paths(k, i)) + 1 / costs(k);
        end
        pheromone(paths(k, n), paths(k, 1)) = pheromone(paths(k, n), paths(k, 1)) + 1 / costs(k);
    end
end

%% 输出路径与成本
disp('最佳路径:');
disp(best_path);
disp('最佳路径的成本:');
disp(best_cost);
