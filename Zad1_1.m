close all
% Интервал:
a=0;
S=1;
%b1=100;
%b2=10;
%NRange=2:5:1000;
b1Range=0.001:0.01:1000;
b2Range=S./b1Range;
% Число узлов:
N=100;
d_mean_g=zeros(length(b1Range),1);
d_min_g=d_mean_g;
for k=1:length(b1Range)
    % Векторы координат:
    x=zeros(N,1);
    y=zeros(N,1);
    for i=1: N
        x(i)=a+(b1Range(k)-a)*rand;
        y(i)=a+(b2Range(k)-a)*rand;
    end
    
    %% Вычисление среднего расстояния
    d=zeros(N,N); % Матрица расстояний между всеми узлами
    d_sum=zeros(N,1); % Вектор сумм расстояний для одного узла
    d_sum_mean=zeros(N,1); % Вектор средних значений расстояний между узлами
    d_mean=0; % Среднее расстояние между узлами
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
    
    %% Вычисление минимального среднего расстояния между узлами
    % Заменим нули в матрице расстояний значениями NaN:
    d(d==0)=NaN;
    % Найдем минимальные расстояния между узлами для каждой точки:
    d_min=min(d);
    % Найдем среднее минимальное расстояние между узлами:
    d_min=sum(d_min(2:length(d_min)))/(length(d_min)-1);
    
    d_mean_g(k)=d_mean;
    d_min_g(k)=d_min;
    display(k)
end
%% Построение полученных зависимостей (при нормировании на сторону квадрата)
% mean_mean=ones(length(NRange),1);
%mean_mean=ones(length(BRange),1);
d_mean_max=ones(length(b1Range),1).*max(d_mean_g);
d_min_max=ones(length(b1Range),1).*max(d_min_g);
d_mean_min=ones(length(b1Range),1).*min(d_mean_g);
d_min_min=ones(length(b1Range),1).*min(d_min_g);
figure
p=plot(b1Range./b2Range,d_mean_g,b1Range./b2Range,d_min_g,...%BRange./b2,mean_mean.*mean(d_mean_g),'--r');
    b1Range./b2Range,d_mean_max,'--m',...
    b1Range./b2Range,d_mean_min,'-.m',...
    b1Range./b2Range,d_min_max,'--m',...
    b1Range./b2Range,d_min_min,'-.m');
p(1).LineWidth=2;
p(2).LineWidth=2;
hold on;
legend('Среднее расстояние между узлами',...
    'Среднее расстояние между ближайшими узлами',...
    'Максимум среднего расстояния',...
    'Минимум среднего расстояния')
xlabel('b1/b2')
ylabel('d')
grid on;





