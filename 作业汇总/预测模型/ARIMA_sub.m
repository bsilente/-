function [pre_res_high,pre_res_precision,reli_juzhen,data_pre2,L] = ARIMA_sub(Violent_order,lim,pre_res_high,pre_res_precision,train_data,test_data);
%% ARIMA预测代码子函数
%%  看数据是否平稳，不平稳进行差分处理
pingwen=adftest(train_data); %1代表平稳，0代表不平稳
if pingwen==1
    disp('平稳序列')
    train_data1=train_data;
else
    disp('不平稳序列')
    train_data1=diff(train_data);
end
%% 利用自相关图和偏相关图判断模型类型和阶次
train_data2=iddata(train_data1);
save_data=[];
for p=1:lim
    for q=1:lim
        num=armax(train_data2,[p,q]);%armax对应FPE最小
        AIC=aic(num);
        save_data=[save_data;p q AIC];
        reli_juzhen(p,q)=AIC;%求出AIC矩阵，AIC越小越好即对应求出p和q。
    end
end
%% 利用阶数得到模型
min_index=find(save_data(:,3)==min(save_data(:,3)));%三维矩阵p,q和数值大小，此处为检索第三列数值的最小值。
p_best=save_data(min_index,1);%p的最优阶数
q_best=save_data(min_index,2);%q的最优阶数
model=armax(train_data2,[p_best,q_best]);%构建ARIMA模型
%% 利用模型预测
L=length(test_data);
pre_data=[train_data1;zeros(L,1)];%待预测的数据补齐为0
pre_data1=iddata(pre_data);
pre_data2=predict(model,pre_data1,L);
pre_data3=get(pre_data2);%得到结构体
pre_data4=pre_data3.OutputData{1,1}(length(train_data1)+1:length(train_data1)+L);%从结构体里面得到预测的未差分还原的数据
data_show=[train_data1;pre_data4];%显示全部的差分值
if pingwen==0 %非平稳时进行差分还原
    data_pre1=cumsum([train_data(1);data_show]);%还原差分值
elseif pingwen==1
    data_pre1=data_show;
end
data_pre2=data_pre1(length(train_data)+1:end);%最终预测值
%% 预测与实测的结果
pre_C=corrcoef(test_data,data_pre2);%相关系数。
pre_delthigh=data_pre2-test_data;%预测值-真实值
pre_RMSE=(sum((pre_delthigh).^2)/length(pre_delthigh)).^0.5;%均方根误差
pre_M=mean(pre_delthigh);%平均偏差
fprintf('ARIMA预测\n');
fprintf('the value of C is%6.3f\n',pre_C(1,2));
fprintf('the value of R is%6.3f\n',pre_RMSE);
fprintf('the value of M is%6.3f\n',pre_M);
%% 保存循环lim的各次预测精度的结果
pre_res1_precision=[pre_C(1,2),pre_RMSE,pre_M,lim];
pre_res_precision=[pre_res_precision;pre_res1_precision];
%% 保存循环lim的各次预测的结果
pre_res1_high=[data_pre2];
pre_res_high=[pre_res_high,pre_res1_high];
end