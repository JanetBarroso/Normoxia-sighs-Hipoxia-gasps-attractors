%prueba de elipses

colores=[1 0 0;0 0 1;0 1 0];
[row cols]= size(Componentes);
n = 10;
r = (0:n)'/n;
[file,path] = uiputfile('*.mp4','Save Data');
%if isequal(file,0) || isequal(path,0)
%    disp('User selected Cancel')
%else

writerObj=VideoWriter(fullfile(path,file), 'MPEG-4');
writerObj.FrameRate = 4;
writerObj.Quality = 100;
open(writerObj);

figure()
set(gca, 'color',[0.5 0 0])
axis ([-150 400 -100 100]) %checar coincidencia de ejes con los de abajo 


RadiosHorizontales=[];
RadiosVerticales=[];

for i=1:row
    %plot(Componentes(i,1), Componentes(i,2),'ko', 'markerface', colores(idx_vector(i),:))
    ImInCluster = idx_vector(i);
    a = abs(Componentes(i,1)-C(ImInCluster,1)); % radio horizontal 
    b = abs(Componentes(i,2)-C(ImInCluster,1)); % radio vertical 
    x0 = Componentes(i,1); % x0,y0 coordenadas del centro de la elipse
    y0 = Componentes(i,2);
    theta = pi*(-n:n)/n;
    radioA = (0:a./10:a)';
    radioB = (0:b./10:b)';
    xx = x0 + radioA*cos(theta); 
    yy = y0 + radioB*sin(theta);
    Circ = r*(cos(theta)).^2 +r*(sin(theta)).^2;
    pcolor(xx,yy,Circ)
    colormap(jet)
    %colormap(jet)
    hold on
    shading interp
    plot(Componentes(i,1), Componentes(i,2),'ko', 'markerface', colores(idx_vector(i),:))
    xlim([-150 400]) %checar coincidencia de ejes con los de arriba 
    ylim([-100 100])
    %Iframe = getframe(gcf);
    %writeVideo(writerObj,Iframe);
    set(gca, 'color',[0.5 0 0]) %
    pause(0.3)
    hold off
    RadiosHorizontales=[RadiosHorizontales,a];
    RadiosVerticales=[RadiosVerticales,b];
end
close(writerObj); 
%end
