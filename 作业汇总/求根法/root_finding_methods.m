function root_finding_methods()
    %% 输入函数
    func = input('请输入函数（注意：输入的函数前面要加@(x)）');
    %% 输入预估值和最大迭代次数
    x0 = input('请输入预估值 ');
    x1 = x0 + 10; 
    tol = 1e-6;
    max_times = 100;
    %% 逐步搜索法
    [root_gs, err_gs] = gra_search(func, x0, tol, max_times);
    fprintf('逐步搜索法找到的根: %f\n', root_gs);

    %% 二分法
    [root_bs, err_bs] = bisection(func, x0, x1, tol, max_times);
    fprintf('二分法找到的根: %f\n', root_bs);

    %% 比例求根法
    [root_sm, err_sm] = secant_method(func, x0, x1, tol, max_times);
    fprintf('比例求根法找到的根: %f\n', root_sm);

    %% 牛顿法
    [root_nm, err_nm] = newton_method(func, x0, tol, max_times);
    fprintf('牛顿法找到的根: %f\n', root_nm);

    %% 弦截法
    [root_rf, err_rf] = regula_falsi(func, x0, x1, tol, max_times);
    fprintf('弦截法找到的根: %f\n', root_rf);
    
    %% 画图
    figure;
    semilogy(err_gs, 'r', 'DisplayName', 'Gra Section');
    hold on;
    semilogy(err_bs, 'g', 'DisplayName', 'Bisection');
    semilogy(err_sm, 'b', 'DisplayName', 'Secant Method');
    semilogy(err_nm, 'm', 'DisplayName', 'Newton Method');
    semilogy(err_rf, 'k', 'DisplayName', 'Regula Falsi');
    xlabel('迭代步数');
    ylabel('相对误差');
    legend show;
    title('相对误差随迭代步数的变化趋势');
    grid on;
end
