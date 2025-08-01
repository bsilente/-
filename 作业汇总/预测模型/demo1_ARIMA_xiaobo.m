%% 信号分解+ARIMA时序预测算法
%% 清除环境变量
clear all;close all;clc
%% 定义字体字号和线宽
LW         = 1;          % 定义画图线宽
fontnamed  = '华文中宋';  % 定义画图字体名字'Arial'
ssize      = 10;         % 定义画图字体大小
%% 给定绘图颜色
C1 = chinesecolors(201);%孔雀蓝
C2 = chinesecolors(12);%合欢红
%% 一、信号分解并出图
load data              % 加载数据
x=data(:,1);
y=data(:,2);
%% 定义整幅图出现的在电脑屏幕上的位置以及长和宽
figureHandle = figure;
figureUnits  = 'centimeters';
figureWidth  = 8.5;
figureHeight = 14;
set(gcf, 'Units', figureUnits, 'Position', [20 12 figureWidth figureHeight]);
%% 展开信号分解（小波能控制分解层数）
wavename     = 'db6';%dmey;haar;db4;bior4.4;rbio4.4;coif4;sym4;%%morl;mexh;meyr
[d,a]        = wavedec(y,8,wavename);%分解8层+1层残差
%信号分解
a8=wrcoef('a',d,a,wavename,8);%残差
d8=wrcoef('d',d,a,wavename,8);
d7=wrcoef('d',d,a,wavename,7);
d6=wrcoef('d',d,a,wavename,6);
d5=wrcoef('d',d,a,wavename,5);
d4=wrcoef('d',d,a,wavename,4);
d3=wrcoef('d',d,a,wavename,3);
d2=wrcoef('d',d,a,wavename,2);
d1=wrcoef('d',d,a,wavename,1);
modes        = [d1,d2,d3,d4,d5,d6,d7,d8,a8]';

d1           = modes(1,:);
d2           = modes(2,:);
d3           = modes(3,:);
d4           = modes(4,:);
d5           = modes(5,:);
d6           = modes(6,:);
d7           = modes(7,:);
d8           = modes(8,:);
d9           = modes(9,:);
%% 画图
subplot(10,1,1)
plot(x,y);
ylabel('原信号');hold on;
subplot(10,1,2)
plot(x,d1);
ylabel('d1');hold on;
subplot(10,1,3)
plot(x,d2);
ylabel('d2');hold on;
subplot(10,1,4)
plot(x,d3);
ylabel('d3');hold on;
subplot(10,1,5)
plot(x,d4);
ylabel('d4');hold on;
subplot(10,1,6)
plot(x,d5);
ylabel('d5');hold on;
subplot(10,1,7)
plot(x,d6);
ylabel('d6');hold on;
subplot(10,1,8)
plot(x,d7);
ylabel('d7');hold on;
subplot(10,1,9)
plot(x,d8);
ylabel('d8');hold on;
subplot(10,1,10)
plot(x,d9);
ylabel('d9');hold on;
xlabel('X-axis');
%% 背景颜色
set(gcf,'Color',[1 1 1])
%% 图片输出
figW    = figureWidth;
figH    = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '原始数据分解各分量';
print(figureHandle,[fileout,'.png'],'-r600','-dpng');
%% 二、ARIMA预测
modes        = modes';
[m,n]        = size(modes);
d_pre        = [];
for j=1:n
    tra_data=modes(:,j);
    %% imf分量逐分量展开预测
    train_data        = tra_data(1:150,1);  % 训练数据
    test_data         = y(151:177,1);      % 检验数据
    pre_res_precision = [];                  % 用于存储精度[pre_R,pre_RMSE,pre_M];
    pre_res_high      = [];                  % 用于存储预测的高度
    %% 预测
    Violent_order     = 'isaic'; % 选阶AIC='isaic'
    for lim=8                    % AIC准则中p和q的最大值
        [pre_res_high,pre_res_precision,reli_juzhen,data_pre2,L] = ARIMA_sub(Violent_order,lim,pre_res_high,pre_res_precision,train_data,test_data);
    end
    d_pre             = [d_pre,pre_res_high]; % imf分量逐分量展开预测的结果都保存在当前这个矩阵中
end
%% 三、imf分量逐分量展开预测的结果展示及信号分量重构
if n==7
    d_pre_hebing=d_pre(:,1)+d_pre(:,2)+d_pre(:,3)+d_pre(:,4)+d_pre(:,5)+d_pre(:,6)+d_pre(:,7);
end
if n==8
    d_pre_hebing=d_pre(:,1)+d_pre(:,2)+d_pre(:,3)+d_pre(:,4)+d_pre(:,5)+d_pre(:,6)+d_pre(:,7)+d_pre(:,8);
end
if n==9
    d_pre_hebing=d_pre(:,1)+d_pre(:,2)+d_pre(:,3)+d_pre(:,4)+d_pre(:,5)+d_pre(:,6)+d_pre(:,7)+d_pre(:,8)+d_pre(:,9);
end
if n==10
    d_pre_hebing=d_pre(:,1)+d_pre(:,2)+d_pre(:,3)+d_pre(:,4)+d_pre(:,5)+d_pre(:,6)+d_pre(:,7)+d_pre(:,8)+d_pre(:,9)+d_pre(:,10);
end
if n==11
    d_pre_hebing=d_pre(:,1)+d_pre(:,2)+d_pre(:,3)+d_pre(:,4)+d_pre(:,5)+d_pre(:,6)+d_pre(:,7)+d_pre(:,8)+d_pre(:,9)+d_pre(:,10)+d_pre(:,11);
end
if n==12
    d_pre_hebing=d_pre(:,1)+d_pre(:,2)+d_pre(:,3)+d_pre(:,4)+d_pre(:,5)+d_pre(:,6)+d_pre(:,7)+d_pre(:,8)+d_pre(:,9)+d_pre(:,10)+d_pre(:,11)+d_pre(:,12);
end
if n==13
    d_pre_hebing=d_pre(:,1)+d_pre(:,2)+d_pre(:,3)+d_pre(:,4)+d_pre(:,5)+d_pre(:,6)+d_pre(:,7)+d_pre(:,8)+d_pre(:,9)+d_pre(:,10)+d_pre(:,11)+d_pre(:,12)+d_pre(:,13);
end
save ARIMA_fenjie d_pre_hebing

%% 定义整幅图出现的在电脑屏幕上的位置以及长和宽
figureHandle = figure;
figureUnits  = 'centimeters';
figureWidth  = 8.5;
figureHeight = 14;
set(gcf, 'Units', figureUnits, 'Position', [40 12 figureWidth figureHeight]);

%% 画图
subplot(10,1,1)
plot(d_pre_hebing(:));
ylabel('预测数据');hold on;
subplot(10,1,1)
plot(data(151:177,2));
ylabel('真实数据');hold on;
subplot(10,1,2)
plot(d_pre(:,1));
subplot(10,1,3)
plot(d_pre(:,2));
ylabel('d2');hold on;
subplot(10,1,4)
plot(d_pre(:,3));
ylabel('d3');hold on;
subplot(10,1,5)
plot(d_pre(:,4));
ylabel('d4');hold on;
subplot(10,1,6)
plot(d_pre(:,5));
ylabel('d5');hold on;
subplot(10,1,7)
plot(d_pre(:,6));
ylabel('d6');hold on;
subplot(10,1,8)
plot(d_pre(:,7));
ylabel('d7');hold on;
subplot(10,1,9)
plot(d_pre(:,8));
ylabel('d8');hold on;
subplot(10,1,10)
plot(d_pre(:,9));
ylabel('d9');hold on;
xlabel('X-axis');
%% 背景颜色
set(gcf,'Color',[1 1 1])
%% 图片输出
figW    = figureWidth;
figH    = figureHeight;
set(figureHandle,'PaperUnits',figureUnits);
set(figureHandle,'PaperPosition',[0 0 figW figH]);
fileout = '预测的数据各分量';
print(figureHandle,[fileout,'.png'],'-r600','-dpng');