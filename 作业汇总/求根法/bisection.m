function [root, errors] = bisection(f, a, b, tol, max_times)
    errors = [];
    for iter = 1:max_times
        c = (a + b) / 2;
        if f(c) == 0 || (b - a) / 2 < tol
            root = c;
            break;
        end
        if sign(f(c)) == sign(f(a))
            a = c;
        else
            b = c;
        end
        root = (a + b) / 2;
        err = abs(f(root));
        errors = [errors, err];
        if err < tol
            break;
        end
    end
end