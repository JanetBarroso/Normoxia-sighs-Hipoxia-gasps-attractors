%Extracci�n de vecores

%... Este programa hace una matriz de n x m (n�mero de neuronas X vectores)
% del experimento que se est� analizando. La extracci�n de
% inspiraciones/expiraciones se debe hacer previamente con el programa de
% Josu�


%   Aseg�rate de que el MATLAB est� en la carpeta donde est� el experimento
%  'C:\Users\JanetBarroso\Documents\ArchivosMatlab\JoseJuarez\';

% FileName='DatosParaAnalizarInspiraciones';
% Variables={'jInspiracionIniciosVector2','jInspiracionFinVector2',...
%'rast', 'data1', 'jInspiracionIniciosVector','jInspiracionFinVector'};
%
% for i=1:length(Variables)
%     load(FileName,Variables{1,i})
% end

load('rast.mat')
load('IniciosInspiracionesNormoxia.mat');
load('FinalesInspiracionesNormoxia.mat');

% ... Si quieres que cada inspiraci�n sea un vector corre esta parte 
% (selecciona el texto del c�digo y oprime F9)
MatrizInspiracionesNormoxia=[]; %nombre matriz de vectores
for i=1:length(IniciosInspiracionesNormoxia)
    v = sum(rast(:,IniciosInspiracionesNormoxia(i,1):FinalesInspiracionesNormoxia(i,1)),2);
    MatrizInspiracionesNormoxia=[MatrizInspiracionesNormoxia, v];
end
save('VectoresInspiracionCompleta')






%Vectorizacion en bines de x ms
 Bin=170;%las unidades son en ms
 VectoresInspiracionBIN=[];
for i = 1 : length(IniciosInspiracionesNormoxia)
    jPosicionActual = IniciosInspiracionesNormoxia(i);
    while (jPosicionActual <= (FinalesInspiracionesNormoxia(i)-Bin + 1))
        VectoresInspiracionBIN = [ VectoresInspiracionBIN, sum(rast(:, jPosicionActual : jPosicionActual + Bin),2)]; % suma por renglones de la columna
        jPosicionActual = jPosicionActual + Bin;
    end
end

 save('NOMBRE ARCHIVO', 'VectoresInspiracionBIN', 'Bin');
 Del
%programa de Josu� se determinan cu�les inspiraciones son ruido y quitar
%esas columnas de la matriz de rast 

%InspiracionesRuido={71,72,76,85,101,106,107,123,128,179};



Senhal_InspNormoxia={SenhalFiltradaRectificadaInspiraciones{1:101}};
Raster_InspNormoxia={MatrizInspiracionesNormoxia{1:101}};

Senhal_InspHipoxia={SenhalFiltradaRectificadaInspiraciones{102:end}};
Raster_InspHipoxia={MatrizInspiracionesNormoxia{102:end}};


save('InspHipoxiaSenhalYRaster', 'Senhal_InspHipoxia', 'Raster_InspHipoxia')
save('InspNormoxiaSenhalYRaster', 'Senhal_InspNormoxia','Raster_InspNormoxia')

