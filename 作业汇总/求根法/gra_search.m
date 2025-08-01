function [root, errors] = gra_search(f, x0, tol, max_times)
    errors = [];
    x = x0;
    for iter = 1:max_times
        if abs(f(x)) < 0.1
            root = x;
            break;
        end
        x = x + 0.05;
        err = abs(f(x));
        errors = [errors, err];
        if err < tol
            break;
        end
    end
    root = x;
end