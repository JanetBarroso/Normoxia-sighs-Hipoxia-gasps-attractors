function indfxF = HiechClust_PaperTest(X, Labels, Orient, GSize,iters)


indfxF = double.empty;

Y = pdist(X,'euclidean'); % (J) \/
%Y = pdist(X,'cityblock');
Z = linkage(Y,'complete'); 
%Z = linkage(Y,'weighted');

%close all
cab(10,100,500);

%f = figure; % yo (J) \/
f = figure (iters);


xx = dendrogram(Z, 0, 'Labels',Labels,'Orientation',Orient);
set(gca,'fontsize',10);

% saveas(f,['GridSize_',num2str(GSize),'.png']);
c = cophenet(Z,Y)

% 
% 
% tmp = ones(size(X,1));
% tmp = tril(tmp,-1); %# creates a matrix that has 1's below the diagonal
% 
% %# get the indices of the 1's
% [rowIdx,colIdx ] = find(tmp);
% 
% %# create the output
% out = [Y',X(colIdx,:),X(rowIdx,:)];

%%Inconsistence coefficient:

% Inconsistent function to calculate the inconsistency values for the links
% created previously.

        % Results Description
        % 1.- Mean of the heights of all the links included in the calculation
        % 2.- Standard deviation of all the links included in the calculation
        % 3.- Number of links included in the calculation
        % 4.- Inconsistency coefficient

I = inconsistent(Z)

vals = I(:,4);
vals(vals < 1) = [];
Val2Cut = max(vals);
% Find Natural Divisions

T = cluster(Z,'cutoff',Val2Cut); %% Here data is separated into 3 divisions... groups

%descpCat = {'-R','-B','-G','-K','.-M','.-B','.-G','.-K'}; % (J) para extender \/
descpCat = {'-R','-B','-G','-K','.-M','.-B','.-G','.-K','o:R','o:B','o:G','o:K','x:M','x:B','x:G','x:K'};

% for i = 1:max(T)
%    
%     indx = find(T == i);
%     Data2Plot(i,:) = mean(X(indx,:));
%     plot(Data2Plot(i,:),descpCat{i});
%     
% end


% Specify Arbitrary Clusters with Validity Functions

% answer = inputdlg('Max K size?');
answer = 15;
for i = 1:(answer)

    classlabel(:,i) = cluster(Z,'maxclust',i);
    
end

data = X;
N = answer;
validity_Index
%pause();


in = 0;
answer = inputdlg('Max K size?');
in = str2num(answer{1});

figure(500), subplot(2,1,iters);hold on
% while in > 0
    

    T = cluster(Z,'maxclust',in);
    
    
    for i = 1:max(T)
        
        indx = find(T == i);
        if(length(indx) > 1)
            Data2Plot(i,:) = mean(X(indx,:)); % promediar actividad (número de pulsos de la neurona durante la inspiracion)
        else                                  % de todas las neuronas por ciclo I o E, (J)
            Data2Plot(i,:) = X(indx,:);
        end
        % grafica de la actividad promediada de las neuronas en los
        % distintos ciclos inpiratorios I o expiratorios E, (J)
        plot(Data2Plot(i,:),descpCat{i}); 
        indfxF(indx) = i;                       % (J) ESTA VARIABLE TIENE LA INTERACCIÓN DE LOS ESTADOS
    end
    

%     figure, hold on
%     title(['k=', answer{1}]);
%     answer = inputdlg('Max K size?');
%     in = str2num(answer{1});
%     
% % end
    
