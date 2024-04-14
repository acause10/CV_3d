function [] = Rendering(exp_image, object_img, plane2d, plane3d, obj2d, obj3d)
%% Zuschnitt, Korrektur und Montage der fünf Hauptflächen und der Foreground-Objekte 
%VARIABLEN:
%2D Koordinaten im Bild
%   plane2d(:,:,1)=[x_back;y_back]  --> [2x4x5]     (5 Planes)
%   obj2d(:,:,1)=[x_obj1;y_obj1]  --> [2x4xN]
%3D Koordinaten --> Ursprung im Hintergrundbild
%   plane3d(:,:,1)=[x_back;y_back;z_back]  --> [3x4x5]     (5 Planes)
%   obj3d(:,:,1)=[x_obj1;y_obj1;z_obj1]  --> [3x4xN] (N=#Objects)

%% Vorbereitung
%Preallocation of Figure
f3 = figure('Name', 'Ergebnis', 'NumberTitle', 'off');
figure(f3);

str(1) = {'Über die Cameratoolbar kann die Ansicht auf folgenede Arten gesteuert werden:'};
str(2) = {'1. Icon: Rotation der Kamera um die Hauptachse'};
str(3) = {'3. Icon: Horizontale und Vertikale Bewegung der Kamera'};
str(4) = {'4. Icon: Abstand der Kamera zur Scene'};
str(5) = {'8.-10. Icon: Auswahl der Hauptachse'};

%% Korrektur der fünf Hauptflächen und Positionierung
%Back
[back_img] = Rectify (exp_image, plane2d(:,:,1), plane3d(:,:,1), 'XY');     %actually no Transformation needed
[X,Y] = meshgrid(plane3d(1,1,1):plane3d(1,2,1), plane3d(2,1,1):plane3d(2,3,1));
warp(X,Y,zeros(size(X)),back_img);
hold on;

%Ceiling
[ceil_img] = Rectify (exp_image, plane2d(:,:,2), plane3d(:,:,2), 'XZ');
[X,Z] = meshgrid(plane3d(1,1,2):plane3d(1,2,2), plane3d(3,1,2):plane3d(3,3,2));
ceil_img = flip(ceil_img,1);                                                %gespiegelt weil von unten betrachtet
warp(X,zeros(size(X)),Z,ceil_img);

%Floor
[floor_img] = Rectify (exp_image, plane2d(:,:,3), plane3d(:,:,3), 'XZ');
[X,Z] = meshgrid(plane3d(1,1,3):plane3d(1,2,3), plane3d(3,1,3):plane3d(3,3,3));
warp(X,ones(size(X))*max(plane3d(2,:,1)),Z,floor_img);

%Left
[left_img] = Rectify (exp_image, plane2d(:,:,4), plane3d(:,:,4), 'ZY');
[Z,Y] = meshgrid(plane3d(3,1,4):plane3d(3,2,4), plane3d(2,1,4):plane3d(2,3,4));
left_img = flip(left_img,2);
warp(zeros(size(Y)),Y,Z,left_img);

%Right
[right_img] = Rectify (exp_image, plane2d(:,:,5), plane3d(:,:,5), 'ZY');
[Z,Y] = meshgrid(plane3d(3,1,5):plane3d(3,2,5), plane3d(2,1,5):plane3d(2,3,5));
warp(ones(size(Y))*max(plane3d(1,:,1)),Y,Z,right_img);

%%  Positionierung der Foreground-Objekte
if isempty(obj2d) == 0
    for i=1:size(obj2d,3)
        object=cell2mat(object_img(i));     
        
        %Theoretisch müsste man die Foreground Objekte auch noch Berichtigen --> Viele Sonderfälle
        %tform = fitgeotrans([obj2d(1,:,i)-min(obj2d(1,:,i));obj2d(2,:,i)-min(obj2d(2,:,i))]',[obj3d(1,:,i)-min(obj3d(1,:,i));obj3d(2,:,i)-min(obj3d(2,:,i))]','projective');
        %object = imwarp(object,tform);

        [X,Y] = meshgrid(obj3d(1,1,i):obj3d(1,2,i),obj3d(2,1,i):obj3d(2,4,i));
        warp(X,Y,ones(size(X))*obj3d(3,1,i),object);
    end
end

axis equal;                 %X,Y,Z-Abmessungen angleichen
axis vis3d;                 %Einfrieren der Skala für bessere Drehungen
axis off;                   %Markierungen ausschalten
camproj('perspective');     %perspektivische Ansicht
set(gcf,'color','k');       %Hintergund Schwarz

camup([0 -1 0]);            %Output richtig drehen
camva(75);                  %FoV so weit wie möglich für gute Ansichten
campos([plane3d(1,2,1)/2, plane3d(2,4,1)/2, plane3d(3,4,2)+plane3d(1,2,1)/3]);        %Kamera mittig vor Bild positionieren
cameratoolbar(f3);
cameratoolbar(f3, 'SetMode','orbit');
cameratoolbar(f3, 'SetCoordSys','y');

hold off;

f = msgbox(str, 'Hinweis zur Steuerung');

end