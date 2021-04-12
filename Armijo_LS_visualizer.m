%%4. Implement a program for the visualization of the Armijo line search method in case of R ! R
%%functions. Show the effect of the parameters c and %, plot the objective function, the line
%%corresponding to c and the points examined by the algorithm. Find some nice test functions.

function Armijo_LS_visualizer(f, df, x, iter)

    S.fh = figure;
    S.ax = axes('Parent',S.fh,'position',[0.13 0.39  0.77 0.54]);
    
    S.x0 = x;
    S.iter = iter;
    
    fplot(f);
    hold on
    S.y = @(x) f(S.x0)+0.2*df(S.x0)*(x-S.x0);
    S.cLine = fplot(S.y, '--b');
    %plot(X,y);
    hold on
    
    S.f = f;
    S.df = df;
    S.r   = 0.5;
    S.c   = 0.2;
    S.A = findPoints(S.f, S.df, S.x0, S.r, S.c, S.iter);   
    S.LN = plot(S.A(:,1),S.A(:,2),'o');
    update(S);
    
    % Slider for rho parameter:
    S.rSlider = uicontrol('Parent',S.fh,'Style','slider','Position',[81,90,419,23],...
                    'min',0.5,'max',0.9,'value', S.r,...
                    'sliderstep',[1/20 1/20],...
                    'callback', {@SliderCB, 'r'});
    bgcolor = S.fh.Color;
    bl1 = uicontrol('Parent',S.fh,'Style','text','Position',[50,90,23,23],...
                    'String','0.5','BackgroundColor',bgcolor);
    bl2 = uicontrol('Parent',S.fh,'Style','text','Position',[500,90,23,23],...
                    'String','0.9','BackgroundColor',bgcolor);
    bl3 = uicontrol('Parent',S.fh,'Style','text','Position',[240,61,100,23],...
                    'String','rho','BackgroundColor',bgcolor);
    % Slider for c parameter:
    S.cSlider = uicontrol('Parent',S.fh,'Style','slider','Position',[81,40,419,23],...
                     'min',0.01,'max',0.2,'value', S.c,...
                     'sliderstep',[1/20 1/20],...
                     'callback', {@SliderCB, 'c'}); 
                 
    bl4 = uicontrol('Parent',S.fh,'Style','text','Position',[50,40,23,23],...
                    'String','0.01','BackgroundColor',bgcolor);
    bl5 = uicontrol('Parent',S.fh,'Style','text','Position',[500,40,23,23],...
                    'String','0.2','BackgroundColor',bgcolor);
    bl6 = uicontrol('Parent',S.fh,'Style','text','Position',[240,11,100,23],...
                    'String','c','BackgroundColor',bgcolor);
    guidata(S.fh, S);  % Store S struct in the figure
end

function SliderCB(rSlider, EventData, Param)
    % Callback for both sliders
    S = guidata(rSlider);  % Get S struct from the figure
    S.(Param) = get(rSlider, 'Value');
    update(S);
    guidata(rSlider, S);  % Store modified S in figure
end
function update(S)
    B = findPoints(S.f, S.df, S.x0, S.r, S.c, S.iter);
    set(S.LN, 'XData', B(:,1));
    set(S.LN, 'YData', B(:,2));
    set(S.cLine, 'Function',@(x) S.f(S.x0)+S.c*S.df(S.x0)*(x-S.x0)); 
end
 
function [A]=findPoints(f, df, x0, rho, c, iter)
    A = zeros(iter, 2);
    init_alpha = 1; % initial step length
    for k=1:iter
        alpha = init_alpha;
        f0 = f(x0);
        df0 = df(x0);
        if df0 > 0
            alpha = -alpha;
        end
        x = x0+alpha;
        fx = f(x);
    
        while fx > f0 + c*alpha*df0
            alpha = rho*alpha;
            x = x0+alpha;
            fx = f(x);
        end
        x0 = x;
        A(k, 1) = x0;
        A(k, 2) = f(x0);
    end
end