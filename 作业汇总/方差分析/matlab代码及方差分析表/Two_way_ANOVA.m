%% 清理工作区
clc;
clear all;
close all;

%% 提取数据并转换数据格式
yield = [
    14.10, 11.11, 13.19, 10.12;
     9.70, 10.80,  7.11,  6.10;
     5.11, 13.14, 12.13, 14.10
];
%% 进行双因素方差分析
[p, tbl, stats] = anova2(yield);

%% 输出分析结果
disp('ANOVA 表：');
disp(tbl);

%% 显示显著性水平
fprintf('浓度的p值：%f\n', p(1));
fprintf('温度的p值：%f\n', p(2));

if p(1)>0.05
  fprintf('浓度对产品得率的影响无显著差异\n');  
else
    fprintf('浓度对产品得率的影响有显著差异\n');
end
if p(2)>0.05
  fprintf('温度对产品得率的影响无显著差异\n');  
else
    fprintf('温度对产品得率的影响有显著差异\n');
end