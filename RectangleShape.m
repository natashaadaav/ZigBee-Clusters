close all
% Interval:
a=0;
b1=5;
b2=20;
% Number of nodes:
NRange=[10 25 100 1000];
k=1;
d_mean_g=zeros(length(NRange),1);
d_min_g=d_mean_g;
for N=NRange
    % Coordinate vectors:
    x=zeros(N,1);
    y=zeros(N,1);
    for i=1: N
        x(i)=a+(b1-a)*rand;
        y(i)=a+(b2-a)*rand;
    end
    
    % Image of the resulting rectangle:
    figure
    plot(x,y,'o','MarkerEdgeColor',[0 0 1],...
        'MarkerFaceColor',[0 0 0])
    grid on
    xlim([a max(b2,b1)])
    ylim([a max(b2,b1)])
    figure
    %% Average Distance Calculation
    d=zeros(N,N); % Distance matrix between all nodes
    d_sum=zeros(N,1); % The vector of sums of distances between all nodes
    d_sum_mean=zeros(N,1); % Vector sum of distances for one node
    d_mean=0; % Average distance between nodes
    for i=1:N
        n_1=0;
        for j=1:N
            if j<=i
                d(i,j)=0;
            else
                d(i,j)=sqrt((x(j)-x(i))^2+(y(j)-y(i))^2);
                n_1=n_1+1;
            end
            d_sum(i)=d_sum(i)+d(i,j);
        end
        if n_1==0
            continue
        end
        d_sum_mean(i)=d_sum(i)/n_1;
        d_mean=d_mean+d_sum_mean(i);
    end
    d_mean=d_mean/(N-1);
    
    % Constructing a circle with a radius equal to the average distance between nodes
    for i=1:N
        viscircles([x(i) y(i)],d_mean,'LineStyle','--','LineWidth',1);
    end
    grid on
    hold on
    xlim([a max(b2,b1)])
    ylim([a max(b2,b1)])
    
    %% Calculating the minimum average distance between nodes
    d(d==0)=NaN;
    d_min=min(d);
    d_min=sum(d_min(2:length(d_min)))/(length(d_min)-1);
    
    for i=1:N
        viscircles([x(i) y(i)],d_min,'LineStyle','-','EdgeColor',...
            [0 1 0],'LineWidth',1);
    end
    d_mean_g(k)=d_mean;
    d_min_g(k)=d_min;
    k=k+1;
    display('Ñðåäíåå ðàññòîÿíèå ìåæäó ñëó÷àéíûìè óçëàìè:')
    display(d_mean)
    display('Ñðåäíåå ìèíèìàëüíîå ðàññòîÿíèå ìåæäó ñëó÷àéíûìè óçëàìè:')
    display(d_min)
    
    plot(x,y,'o','MarkerEdgeColor',[0 0 1],...
        'MarkerFaceColor',[0 0 0])
    figure
    plot(x,y,'o','MarkerEdgeColor',[0 0 1])
    xlim([a max(b2,b1)])
    ylim([a max(b2,b1)])
    hold on
    grid on
    
    x_c=(a+b1)/2;
    y_c=(a+b2)/2;
    min_c=abs(b1-a);
    for i=1:N
        d_c=(x_c-x(i))^2+(y_c-y(i))^2;
        if d_c<min_c
            min_c=d_c;
            min_index=i;
        end
    end
    
    plot(x(min_index),y(min_index),'o',...
        'MarkerFaceColor',[0 0 0])
    viscircles([x(min_index) y(min_index)],d_min,'LineStyle','-',...
        'EdgeColor',[0 1 0],'LineWidth',1);
    viscircles([x(min_index) y(min_index)],d_mean,'LineStyle','--',...
        'LineWidth',1);
end

