%% 清理工作区
clc;
clear all;
close all;
%% 定义天花的基本传染数范围
R0_min = 5;
R0_max = 7;

%% 计算群体免疫阈值
Pc_min = 1 - 1/R0_max;
Pc_max = 1 - 1/R0_min;

%% 输出结果
fprintf('天花的基本传染数范围: %.1f - %.1f\n', R0_min, R0_max);
fprintf('天花的最低免疫率范围: %.2f%% - %.2f%%\n', Pc_min*100, Pc_max*100);