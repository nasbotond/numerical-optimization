% Implement a modified multivariable Newton method (based on Newton.m), which corrects the
% non positive definite Hessian by computing its LDLT decomposition and changing negative
% and very small diagonal entries to some fixed positive  value.
function [x] = Modified_Newton(f,df,ddf,x0,iter)
% f: vector->scalar objective function; only used for linesearch!
% df: gradient function
% ddf: Hessian
% x0: starting point
% iter: number of iterations

    rho=0.5; %For the Armijo LS; usually 0.5 or 0.9
    c=0.2; %For the Armijo LS; usually 0.01 or 0.2
    
    delta = 0.00000001; %Correction constant to ensure p is a descent direction
    
    x=x0;
    for k=1:iter
        H = ddf(x);
        % Create spectral decomposition H = L*D*L'
        [Dv,L] = LDLT(H);
        %[X,Y]=ldl(H);
        % Use the vector D to create a matrix D1 where diagonal values are
        % values of D
        D = diag(Dv);
        % Now we 'correct' H to enforce positive definiteness
        for i=1:size(D(:,1))
            if D(i,i)<delta
                D(i,i)=delta;
            end
        end
        
        % We avoid recreating H, directly solving system of linear
        % equations Hp=-g
        p = -(L'\(D\(L\df(x))));
        alpha = norm(p);
        p = p/norm(p);
        % Check somehow if p is numerically feasible
        if sum(isnan(p)) > 0
            break;
        end
        gamma = Armijo_LS(f,df,p,x,alpha,rho,c); %Compute step length
        x = x+gamma*p;
    end

end

function [Dv,L] = LDLT(A)
    [n,m] = size(A);
    if n~=m || n < 0
        error('A must be a square matrix!');
    end
    L = zeros(n,n);
    for i = 1:n
        L(i,i)=1;
    end
    Dv = zeros(n,1);
    for i = 1:n
        Dv(i)=A(i,i)-L(i,1:i-1).^2*Dv(1:i-1);
        for j = i+1:n
            L(j,i)=(A(j,i)-L(j,1:i-1).*L(i,1:i-1)*Dv(1:i-1))/Dv(i);
        end
    end
end
