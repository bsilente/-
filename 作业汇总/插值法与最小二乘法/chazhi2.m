% 给定数据
x_data = [0.2, 0.4, 0.6];
s_data = [0.19956, 0.39616, 0.58813];

% 使用多项式插值
p = polyfit(x_data, s_data, 2);

% 显示拟合的多项式
disp('拟合的多项式系数：');
disp(p);

% 定义目标值
s_target = 0.44;

% 多项式方程的系数
a = p(1);
b = p(2);
c = p(3) - s_target;

% 解二次方程 ax^2 + bx + (c - s_target) = 0
roots_x = roots([a, b, c]);

% 选择在数据范围内的解
x_solution = roots_x(roots_x >= min(x_data) & roots_x <= max(x_data));

% 显示结果
fprintf('当 s(x) = %.2f 时，x = %.4f\n', s_target, x_solution);

% 绘制原始数据点和拟合曲线
x_fit = linspace(min(x_data), max(x_data), 100);
s_fit = polyval(p, x_fit);

figure;
plot(x_data, s_data, 'bo', 'MarkerFaceColor', 'b'); % 原始数据点
hold on;
plot(x_fit, s_fit, 'r-'); % 拟合曲线
plot(x_solution, s_target, 'gs', 'MarkerFaceColor', 'g'); % 解点
xlabel('x');
ylabel('s(x)');
title('多项式插值');
legend('原始数据', '拟合曲线', '解点');
grid on;
hold off;
