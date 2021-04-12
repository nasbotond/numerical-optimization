% sample 1
f=@(x) x.^3-3*x.^2+4;
df=@(x) 3*x.^2-6*x;

% sample 2


f=@(x) x.^2 + 2.*x - 1;
df = @(x)2.*x + 2;

f = @(x) x^(2/3);
df = @(x) 2/(3*x^(1/3));

f = @(x) x./(x.^2 + 1);
df = @(x) (1-x.^2)/((x.^2 +1).^2);

% sample 3 - gradient descent, newton
% recommended region: [-2,2]x[-2,2]
f = @(x) x(1)^4 + x(2)^4-4*x(1)^2;
df = @(x) [4*x(1)^3-8*x(1);4*x(2)^3];
ddf = @(x) [12*x(1)^2-8 0;0 12*x(2)^2];

% sample 4 - rosenbrock function for gradient descent, multivariable newton
% recommmended region: [-1.0, 1.2]x[-0.2,1.2]
f = @(x) 100*(x(2)-x(1)^2)^2+(1-x(1))^2;
df = @(x) [400*x(1)^3-400*x(1)*x(2)+2*x(1)-2;200*(x(2)-x(1)^2)];
ddf = @(x) [1200*x(1)^2-400*x(2)+2 -400*x(1);-400*x(1) 200];


%% Sample functions for Armijo_LS_visualizer

% Sample 1
% suggested starting point: any real number
f=@(x) (x+pi).^2;
df=@(x) 2*(x+pi);

% Sample 2
% suggested starting point: x0 > 0.3
f=@(x) x.^3-2.1*x.^2+x+3;
df=@(x) 3*x.^2 - 4.2*x + 1;

% Sample 3
% suggested starting point: any real number
f=@(x) 3*x.^2 + 2*x + 7;
df=@(x) 6*x + 2;

% Sample 4
% suggested starting point: any real number
f=@(x) x.^4-x.^3;
df=@(x) 4*x.^3-3*x.^2;

%% Function for Exercise 3 (Vitamins)
% suggested range: [0,1]x[0,1]
% suggested starting point: [0,0]

f =@(x)(4*(x(1)+((4*x(2))-2).^2)+4*((6*x(1)-2).^2)+(((5*x(1))-(4*x(2))).^2));
df = @(x) [346*x(1)-8*x(2)-112;-8*x(1)+160*x(2)-64];
ddf = @(x) [346 -8;-8 160];
