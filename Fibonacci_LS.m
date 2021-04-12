% 7. * Implement the unimodal Fibonacci line search algorithm, an improvement to the zero-order
% unimodal line search algorithm (zero_unimodal.m).
function x = Fibonacci_LS(f,~,~,~,a,b,iter)
% f: real->real objective function
% [a,b]: search interval
% iter: number of iterations
% x: estimated minimizer (midpoint of the last interval)
    % N > 2
    iter = iter +1;
    % find Fibonacci sequence of N+1 values
    A = fibonacci(iter);
    ak = a;
    bk = b;
    d0 = bk - ak;
    dk = (A(iter-1)/A(iter))*d0;
    xl=bk-dk;
    xh=ak + dk;
    fl = f(xl);
    fh = f(xh);
    for k=2:iter-2
        dk = (A(iter-k)/A(iter))*d0;
        if fl<=fh
            bk = xh;
            fh = fl;
            xl=bk-dk;
            xh = ak+dk;
            fl = f(xl);
        else
            ak = xl;
            fl = fh;
            xh=ak + dk;
            xl = bk-dk;
            fh = f(xh);
        end
    end

    x=(ak+bk)/2;

end


function A = fibonacci(N)
    A = zeros(1, N);
    if N==1
        A(1)=1;
    else
        A(1) = 1;
        A(2) = 1;
        for k=3:N
            A(k) = A(k-1) + A(k-2);
        end
    end
end