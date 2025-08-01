%% 清理工作区
clc;
clear all;
close all;

%% 导入数据并标准化
load data;
for i = 2:31
    data(:, i) = (data(:, i) - mean(data(:, i))) / std(data(:, i));
end

%% 提取属性和决策列
attributes = data(:, 2:31);
decision = data(:,1);

%% 定义隶属函数
membership = @(x, y) sum(x == y) / length(x);

%% 计算下近似和上近似
lower_approximation = zeros(size(attributes, 1), 1);
upper_approximation = zeros(size(attributes, 1), 1);

for i = 1:size(attributes, 1)
    for j = 1:size(attributes, 1)
        if membership(attributes(i, :), attributes(j, :)) == 1
            if decision(i) == decision(j)
                lower_approximation(i) = 1;
            end
            upper_approximation(i) = 1;
        end
    end
end

%% 输出结果
disp('Lower Approximation:');
disp(lower_approximation);
disp('Upper Approximation:');
disp(upper_approximation);

%% 输出正域、负域和边界域结果
% 正域
positive_region = lower_approximation == 1;

% 负域
negative_region = (upper_approximation == 0) & (lower_approximation == 0);

% 边界域
boundary_region = (upper_approximation == 1) & (lower_approximation == 0);
disp('正域:');
disp(positive_region);
disp('负域:');
disp(negative_region);
disp('边界域:');
disp(boundary_region);

%% 计算准确率与召回率
accuracy = sum(lower_approximation == decision) / length(decision);
recall = sum((lower_approximation == 1) & (decision == 1)) / sum(decision == 1);
fprintf('Accuracy: %.2f%%\n', accuracy * 100);
fprintf('Recall: %.2f%%\n', recall * 100);
