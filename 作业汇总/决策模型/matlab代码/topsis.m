%% 清理工作区
clc;
clear all;

%% 导入数据
load topsis_data;

%% 判断是否需要正向化
[n,m] = size(X);
disp(['共有' num2str(n) '个评价对象, ' num2str(m) '个评价指标']) 
Judge = input(['这' num2str(m) '个指标是否需要经过正向化处理，需要请输入1 ，不需要输入0：  ']);

if Judge == 1
    Position = input('请输入需要正向化处理的指标所在的列，例如第2、3、6三列需要处理，那么你需要输入[2,3,6]： '); 
    disp('请输入需要处理的这些列的指标类型（1：极小型， 2：中间型， 3：区间型） ')
    Type = input();
    for i = 1 : size(Position,2)
        X(:,Position(i)) = Positivization(X(:,Position(i)),Type(i),Position(i));
    end
    disp('正向化后的矩阵 X =  ')
    disp(X)
end

%% 判断是否需要增加权重
disp('请输入是否需要增加权重向量，需要输入1，不需要输入0')
Judge = input('请输入是否需要增加权重： ');
if Judge == 1
    weigh = input(['你需要输入' num2str(m) '个权数。' '请以行向量的形式输入这' num2str(m) '个权重: ']);
    OK = 0;
    while OK == 0 
        if abs(sum(weigh) - 1)<0.000001 && size(weigh,1) == 1 && size(weigh,2) == m
             OK =1;
        else
            weigh = input('你输入的有误，请重新输入权重行向量: ');
        end
    end
else
    weigh = ones(1,m) ./ m ;
end


%% 对正向化后的矩阵进行标准化
Z = X ./ repmat(sum(X.*X) .^ 0.5, n, 1);
disp('标准化矩阵 Z = ')
disp(Z)

%% 计算与最大值的距离和最小值的距离，并算出得分
D_P = sum([(Z - repmat(max(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D+ 与最大值的距离向量
D_N = sum([(Z - repmat(min(Z),n,1)) .^ 2 ] .* repmat(weigh,n,1) ,2) .^ 0.5;   % D- 与最小值的距离向量
S = D_N ./ (D_P+D_N);    % 未归一化的得分
disp('最后的得分为：')
stand_S = S / sum(S)
[sorted_S,index] = sort(stand_S ,'descend')
