%% 清空
clc;clear;

%% 参数与变量的初始化
n = 1/2;
x0 = pi/2;
y0 = 2;
yp0 = -2/pi;
h = 0.01; % 步长
x_end = 2*pi;
x_eu = x0:h:x_end;
y_eu = zeros(1, length(x_eu));
yp_eu = zeros(1, length(x_eu));
y_eu(1) = y0;
yp_eu(1) = yp0;

%% 定义微分方程为一阶常微分方程组
dydx = @(x, y) [y(2); -(1/x)*y(2) - (1/x^2)*(x^2 - n^2)*y(1)];

%% Runge-Kutta 方法
% 定义 x 的范围
xspan = [x0 2*pi];
% 定义初始条件
y_init = [y0; yp0];
% 使用 ode45 求解
[x_sol, y_sol] = ode45(dydx, xspan, y_init);

%% Euler 方法
for i = 1:length(x_eu)-1
    y_eu(i+1) = y_eu(i) + h * yp_eu(i);
    yp_eu(i+1) = yp_eu(i) + h * (-(1/x_eu(i))*yp_eu(i) - (1/x_eu(i)^2)*(x_eu(i)^2 - n^2)*y_eu(i));
end

%% 计算精确解
y_exact = @(x) sin(x.*sqrt(2*pi./x));

%% 绘制比较图像
figure;
hold on;
plot(x_sol, y_sol(:,1), 'b', 'DisplayName', '数值解 (Runge-Kutta)');
plot(x_eu, y_eu, 'g', 'DisplayName', '数值解 (Euler)');
fplot(y_exact, xspan, 'r--', 'DisplayName', '精确解');
xlabel('x');
ylabel('y');
title('数值解与精确解的比较');
legend('show');
grid on;
hold off;
