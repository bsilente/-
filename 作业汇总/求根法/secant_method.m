function [root, errors] = secant_method(f, x0, x1, tol, max_times)
    errors = [];
    for iter = 1:max_times
        if abs(f(x1) - f(x0)) < 1e-6
            break;
        end
        x2 = x1 - f(x1) * (x1 - x0) / (f(x1) - f(x0));
        x0 = x1;
        x1 = x2;
        root = x1;
        err = abs(f(root));
        errors = [errors, err];
        if err < tol
            break;
        end
    end
end