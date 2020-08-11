%Programa para calcular el PCA de los vectores y determinar el número de
%clusters validados con diferentes metricas. El cluster análisis se hace
%utilizando kmeans como Ikegaya y todos los demás

%load('VectoresInspiracionCompleta');
%load('VectoresInspiracionBIN');

%princomp('matriz a la cual se les hará el PCA')

[VecProp,Componentes,ValProp, VectorEigenValues]= princomp(VectoresExpiracionBIN);
AportedeVariabilidad=cumsum(VectorEigenValues')./sum(VectorEigenValues');

figure()
plot(Componentes(:,1), Componentes(:,2), 'ko', 'Markersize',4)
grid on
xlabel('PCA 1')
ylabel('PCA 2')

DunnsIndex=[]; %Buscar MAXIMO
Silhouette=[]; %Buscar 1 (parecen escalactitas, busca que la mayor parte esté en 1)
DaviesBouldin=[]; %Buscar MINIMO
CalinskiHarabasz=[]; %Buscar MAXIMO

colores=[1 0 0; 0 1 0; 0 0 1; 1 0.5 0; 1 1 0.5; 0.5 0.5 1; 1 0.5 1];

for i=1:6
    Groups = i;
    [idx_vector,C,sumd] = (kmeans(Componentes(:,1:2),Groups));
    %evaluacion de clusters
    s=silhouette(Componentes(:,1:2),idx_vector);
    Silhouette=[Silhouette;s];
    DI=dunns(i,Componentes,idx_vector);
    DunnsIndex=[DunnsIndex,DI];
    d=evalclusters(Componentes(:,1:2),idx_vector,'DaviesBouldin');
    DaviesBouldin=[DaviesBouldin; d.CriterionValues];
    c=evalclusters(Componentes(:,1:2),idx_vector,'CalinskiHarabasz')
    CalinskiHarabasz=[CalinskiHarabasz,c.CriterionValues];
    
    figure(i+1)
    subplot(3,2,3)
    plot(DunnsIndex,'o','markersize',4,'Markerface','b')
    ylabel('Dunn Index')
    subplot(3,2,4)
    plot(s)
    ylabel('Silhouette Index')
    subplot(3,2,5)
    plot(DaviesBouldin,'o','markersize', 4, 'markerface','b')
    xlabel('Number of Clusters')
    ylabel('DaviesBouldin Index')
    subplot(3,2,6)
    plot(CalinskiHarabasz(1:4),'o','markersize', 4, 'markerface','b')
    xlabel('Number of Clusters')
    ylabel('CalinskiHarabas Index')
    idxi=find(idx_vector==i);
    %idx(i,:)=idxi;
    figure(i+1)
    subplot(3,2,[1 2])
    m = plot(Componentes(idxi,1),Componentes(idxi,2),'o','color',colores(i,:))
    hold on
    plot(Componentes(:,1),Componentes(:,2), 'ko')
    axis([-100 350 -50 50])
    xlabel('PCA 1')
    ylabel('PCA 2')
    set(m,'markerface',colores(i,:), 'markersize', 4);

end

% Una vez tomada la desición de cuántos cluster tomar hacer Groups = 'n'
%Groups = 3;


