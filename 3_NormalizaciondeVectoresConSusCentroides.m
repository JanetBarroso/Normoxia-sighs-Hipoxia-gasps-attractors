% Normalizacion de los vectores con su centroide
Groups=3
%Cluster análisis utilizando kmeans
[idx_vector,C,sumd, Distances2Centroids] = (kmeans(Componentes(:,1:2),Groups));
%   idx_vector =  es un vector que dice en qué grupo está cada elemento de la
%matriz a la que se le hizo el cluster
%   C =  coordenadas de cada centroide
%   sumd = suma de
%   Distances2Centroids = Distancia de cada elemento de la matriz a cada
%   uno de los centroides

figure()
colores=[1 0 0; 0 0 1; 0 1 0; 1 0.5 0];
for i=1:Groups
    idxi=find(idx_vector==i);
    m = plot(Componentes(idxi,1),Componentes(idxi,2),'ko')
    hold on
    axis([-3000 3000 -1000 1000])
    xlabel('PCA 1')
    ylabel('PCA 2') 
    set(m,'markerface',colores(i,:), 'markersize', 5);
    plot(C(i,1),C(i,2), 'k*','markersize', 5)
end

%Distancias de cada elemento de un estado a su centroide
DistC1=Distances2Centroids(find(idx_vector==1),1);
DistC2=Distances2Centroids(find(idx_vector==2),2);
DistC3=Distances2Centroids(find(idx_vector==3),3);

%normalizacion de las distancias de cada cluster con su centroide
VectoresNormCi={};
for j=1:Groups
    Ci=Componentes(idx_vector==j,1:2);
    DistanciasNormalizadas=[];
    for i= 1: length(Ci)
        stddev =(sum(Componentes(i,1:2)-C(j,:))^2./length(Ci))^0.5;
        disnorm = (Ci(i,1:2)-C(j,:))./stddev;
        DistanciasNormalizadas=[DistanciasNormalizadas;disnorm];
        VectoresNormCi{j}=DistanciasNormalizadas;
    end
end

%angulos de los vectores normalizados de cada grupo con su centroide
AngulosVectNormaCentroides={};
for j = 1:Groups
    Ci=Componentes(idx_vector==j,1:2);
    angulos=[];
    for i=1:length(Ci)
        angulo=acos(dot(VectoresNormCi{1,j}(i,:),C(j,:))./(norm(VectoresNormCi{1,j}(i,:)).*norm(C(j,:))));
        angulos=[angulos;angulo];
        AngulosVectNormaCentroides{j}=angulos;
    end
end

AngulosConcatenados=[AngulosVectNormaCentroides{1,1}(:,1);AngulosVectNormaCentroides{1,2}(:,1);AngulosVectNormaCentroides{1,3}(:,1)];

figure()
hist(AngulosConcatenados, 30)
xlabel('theta(rad)')
ylabel('cuenta')
title('Distribución de ángulos de riCi')

rx=[];
ry=[];
for i= 1:1
    x= VectoresNormCi{1,i}(:,1);
    y= VectoresNormCi{1,i}(:,2); 
    rx=[rx;x];
    ry=[ry;y];
end
[countx, centerx]=hist(rx,25);
[county, centery]=hist(ry,25);

figure()
subplot(2,1,1)
histogram(rx,25)
xlabel('Rx')
subplot(2,1,2)
histogram(ry,25)
xlabel('Ry')

figure()
subplot(3,2,1)
plot(rx(idx_vector==1),ry(idx_vector==1), 'ko', 'markerface', 'r')
subplot(3,2,3)
plot(rx(idx_vector==2),ry(idx_vector==2), 'ko', 'markerface', 'b')
subplot(3,2,5)
plot(rx(idx_vector==3),ry(idx_vector==3), 'ko', 'markerface', 'g')
subplot(3,2,[2:2:6])
plot(rx,ry, 'ko', 'markerface', 'k')


x=-40:50;
xx=-50:30;

figure()
subplot(2,2,1)
%histogram(ry,25)
bar(centery,county)
hold on
plot(xx,44.*exp(-((xx-0.6)./2.5).^2),'r', 'linewidth', 1)
hold off
subplot(2,2,2)
plot(rx,ry,'.')
xlabel('rx')
ylabel('ry')
subplot(2,2,4)
%histogram(rx,25)
bar(centerx,countx)
hold on
plot(x,46.*exp(-((x+5.8)./20).^2),'r', 'linewidth', 1)
hold off
subplot(2,2,3)
rose(AngulosConcatenados, 25)

%Grafica de la intensidad del atractor

colormap=[...   
   0.00000   0.00000   0.50000
   0.00000   0.00000   0.94444
   0.00000   0.38889   1.00000
   0.00000   0.83333   1.00000
   0.27778   1.00000   0.72222
   0.72222   1.00000   0.27778
   1.00000   0.83333   0.00000
   1.00000   0.38889   0.00000
   0.94444   0.00000   0.00000
   0.97777   0.00000   0.00000
   0.50000   0.00000   0.00000
   ];

figure()

plot(rx,ry,'ko', 'markersize', 8)
xlabel('rx')
ylabel('ry')
xlim([-110 152])
ylim([-110 152])
hold on
x=-52:52;
Px = 32.*exp(-((x-2)./20).^2);
Py = 37.6.*exp(-((x+0.54)./4.6).^2);

figure()
for i=1:1
    a= i.*log(Px); % horizontal radius
    b= i.*log(Py); % vertical radius
    %a=i.*Invx;
    %b=i.*Invy;
    x0=0; % x0,y0 ellipse centre coordinates
    y0=0;
    t=-pi:0.06:pi;
    xx=x0+a.*cos(t);
    yy=y0+b.*sin(t);
    %[aa,bb]=meshgrid(x,y);
    %z=aa.^2+bb.^2 + 1;
    %surf(z)
    plot(xx,yy, '-', 'linewidth',3,'Color',colormap(i,:))
    hold on
end

[r,theta] = meshgrid(linspace(0,75,20),linspace(0,2*pi,20));
elipse=r.^2+1;
surf(r.*cos(theta),r.*sin(theta),elipse);
hold on
imagesc(r.*cos(theta),r.*sin(theta))%elipse)
%Transiciones entre estados
figure()
for i=1:length(idx_vector)
    plot(Componentes(idx_vector(i),1), C(idx_vector(i),2),'o')
    hold on
    pause(1)
    %ylim([0 5])
end
figure()
for i=1:length(Px)
    plot(xx(i),yy(i), 'bo', 'markerface', 'b','markersize', 4)
    xlim([-5 40])
    ylim([-600 600])
    hold on
    pause(1)
end