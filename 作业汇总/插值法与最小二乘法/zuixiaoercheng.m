% 输入数据
x = [-3, -2, -1, 0, 1, 2, 3];
y = [4, 2, 3, 0, -1, -2, -5];

% 初始化矩阵 A
A = [ones(length(x), 1), x(:), x(:).^2];

% 初始化权重矩阵
W = eye(length(x));
W(1, 1) = 1; 

% 使用加权最小二乘法计算拟合参数
params = (A' * W * A) \ (A' * W * y(:));

% 提取拟合参数
a0 = params(1);
a1 = params(2);
a2 = params(3);

% 显示拟合结果
fprintf('拟合二次曲线方程：y = %.4f + %.4fx + %.4fx^2\n', a0, a1, a2);

% 绘制原始数据点和拟合曲线
x_fit = linspace(min(x), max(x), 100);
y_fit = a0 + a1 * x_fit + a2 * x_fit.^2;

figure;
plot(x, y, 'bo', 'MarkerFaceColor', 'b'); % 原始数据点
hold on;
plot(x_fit, y_fit, 'r-'); % 拟合曲线
xlabel('x');
ylabel('y');
title('二次曲线拟合');
legend('原始数据', '拟合曲线');
grid on;
hold off;
