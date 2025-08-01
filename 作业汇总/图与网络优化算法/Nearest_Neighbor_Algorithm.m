%% 清理工作区
clc;
clear all;
close all;
%% 给定城市坐标并初始化
cities = [0 0; 1 5; 5 2; 6 6; 8 3];
n = size(cities, 1); % 计算城市数量
visited = false(1, n); % 访问标记
path = zeros(1, n); % 存储路径
path(1) = 1; % 从第一个城市开始
visited(1) = true;

%% 计算最短路径
for i = 2:n
    last_city = path(i-1);
    min_dist = inf;
    next_city = -1;
    for j = 1:n
        if ~visited(j)
            distance = pdist2(cities(last_city, :), cities(j, :));
            if distance < min_dist
                min_dist = distance;
                next_city = j;
            end
        end
    end
    path(i) = next_city;
    visited(next_city) = true;
end

%% 输出路径
disp('最短路径:');
disp(path);

