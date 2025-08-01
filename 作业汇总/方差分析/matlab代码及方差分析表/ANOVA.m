%% 清理工作区
clc;
clear all;
close all;

%% 导入数据
A = [40, 48, 38, 42, 45, 46];
B = [26, 34, 30, 28, 32, 33];
C = [39, 40, 48, 50, 50, 52];
data = [A, B, C];
group = [repmat({'A'}, 1, 6), repmat({'B'}, 1, 6), repmat({'C'}, 1, 6)];

%% 进行方差分析
[p, tbl, stats] = anova1(data, group);

%% 进行多重比较
[c, m, h, gnames] = multcompare(stats, 'Alpha', 0.05);

%% 显示结果
fprintf('ANOVA p-value: %f\n', p);
if p<0.05
    fprintf('三厂生产的电池平均寿命存在显著性差异。\n');
else
    fprintf('三厂生产的电池平均寿命无显著性差异。\n');
end
disp('多重比较结果：');
disp(c);

%% 计算均值差的置信区间
mean_diff_A_B = c(1, 3:5);
mean_diff_A_C = c(2, 3:5);
mean_diff_B_C = c(3, 3:5);

fprintf('A和B的均值差: %f, 95%%置信区间: [%f, %f]\n', mean_diff_A_B);
fprintf('A和C的均值差: %f, 95%%置信区间: [%f, %f]\n', mean_diff_A_C);
fprintf('B和C的均值差: %f, 95%%置信区间: [%f, %f]\n', mean_diff_B_C);
