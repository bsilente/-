function [root, errors] = newton_method(f, x0, tol, max_times)
    errors = [];
    df = @(x) (f(x + 1e-6) - f(x)) / 1e-6; 
    for iter = 1:max_times
        x1 = x0 - f(x0) / df(x0);
        root = x1;
        err = abs(f(root));
        errors = [errors, err];
        if err < tol
            break;
        end
        x0 = x1;
    end
end