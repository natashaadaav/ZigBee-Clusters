close all
% »нтервал:
a=0;
b1=5;
b2=20;
% „исло узлов:
NRange=[10 25 100 1000];
k=1;
d_mean_g=zeros(length(NRange),1);
d_min_g=d_mean_g;
for N=NRange
    % ¬екторы координат:
    x=zeros(N,1);
    y=zeros(N,1);
    for i=1: N
        x(i)=a+(b1-a)*rand;
        y(i)=a+(b2-a)*rand;
    end
    
    % »зображение полученного пр€моугольника:
    figure
    plot(x,y,'o','MarkerEdgeColor',[0 0 1],...
        'MarkerFaceColor',[0 0 0])
    grid on
    xlim([a max(b2,b1)])
    ylim([a max(b2,b1)])
    figure
    %% ¬ычисление среднего рассто€ни€
    d=zeros(N,N); % ћатрица рассто€ний между всеми узлами
    d_sum=zeros(N,1); % ¬ектор сумм рассто€ний дл€ одного узла
    d_sum_mean=zeros(N,1); % ¬ектор средних значений рассто€ний между узлами
    d_mean=0; % —реднее рассто€ние между узлами
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
    
    % ѕостроение окружности с радиусом, равным среднему рассто€нию м/ду
    % узлами
    for i=1:N
        viscircles([x(i) y(i)],d_mean,'LineStyle','--','LineWidth',1);
    end
    grid on
    hold on
    xlim([a max(b2,b1)])
    ylim([a max(b2,b1)])
    
    %% ¬ычисление минимального среднего рассто€ни€ между узлами
    % «аменим нули в матрице рассто€ний значени€ми NaN:
    d(d==0)=NaN;
    % Ќайдем минимальные рассто€ни€ между узлами дл€ каждого узла:
    d_min=min(d);
    % Ќайдем среднее минимальное рассто€ние между узлами
    d_min=sum(d_min(2:length(d_min)))/(length(d_min)-1);
    
    % ѕостроим окружности, показывающие среднее минимальное рассто€ние между
    % узлами:
    for i=1:N
        viscircles([x(i) y(i)],d_min,'LineStyle','-','EdgeColor',...
            [0 1 0],'LineWidth',1);
    end
    d_mean_g(k)=d_mean;
    d_min_g(k)=d_min;
    k=k+1;
    display('—реднее рассто€ние между случайными узлами:')
    display(d_mean)
    display('—реднее минимальное рассто€ние между случайными узлами:')
    display(d_min)
    
    plot(x,y,'o','MarkerEdgeColor',[0 0 1],...
        'MarkerFaceColor',[0 0 0]) % .. в результате получим изображение
    
    %% ѕокажем дл€ одного узла, который ближе всего к центру
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

