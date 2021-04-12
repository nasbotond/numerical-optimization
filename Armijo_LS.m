function [ alpha ] = Armijo_LS(f, df, p, x, alpha, rho, c)
% f: vector->scalar function -- the objective
% df: gradient function
% p: search direction; must satisfy that A) it is a descent direction at starting point x and B) norm(p)=1
% x: starting point
% alpha: initial (maximal) step length
% rho: step lenght multiplier
% c: descent condition multiplier
% This method performs a single linesearch on f in the descent direction p and returns the chosen step length;
%		terminates when the Armijo condition is first satisfied w.r.t. input parameters alpha, rho and c.

    f0 = f(x);
    g0 = df(x);
    x0 = x;
    x = x0 + alpha * p;
    fk = f(x);
    
    % repeat until the Armijo condition is satisfied
    while fk > f0 + c * alpha * (g0'*p)
      alpha = rho * alpha;
      x = x0 + alpha * p;
      fk = f(x);
    end
end
