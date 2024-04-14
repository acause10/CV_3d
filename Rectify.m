function [crop_image] = Rectify (exp_image, points2d, points3d, plane)
%% Maskieren, entzerren und zuschneiden eines gegebenen Bildes
% 1. Maskieren eines Bildes durch gegebene x- und y-2D-Punkte
% 2. Bild durch Zuordnen von 4 Punkten (Bildkanten & Koordinaten der 3D-Ebene) entzerren
% 3. Bild auf gewünschte Größe zuschneiden
%VARIABLES:
% exp_image: extended image (complete vanishing lines)    [rgb image]
% points2d=[x;y] 2D points of the image segment           [2x4 vektor]
% points3=[x;y;z]: 3D points of image plane               [3x4 vektor]

%% Vorbereitung
[m,n] = size(exp_image(:,:,1));

%% Maskieren
BM = poly2mask(points2d(1,:),points2d(2,:),m,n);        %Convert ROI polygon to region mask
BM(:,:,2) = BM;                                         %apply mask for every RGB color
BM(:,:,3) = BM(:,:,1);
mask_image = exp_image;
mask_image(BM == 0) = 0;                      %0 for black

%% Ebenen-Wahl
if plane == 'XY'            %Back
    P1=1; %X
    P2=2; %Y
elseif plane == 'XZ'        %Ceiling / Floor
    P1=1; %X
    P2=3; %Z
elseif plane == 'ZY'        %Left/Right
    P1=3; %Z
    P2=2; %Y
else
    error('Choose XY, XZ or YZ!')
end

%% Geometrische Transformation
tform = fitgeotrans([points2d(1,:);points2d(2,:)]',[points3d(P1,:);points3d(P2,:)]','projective');
R = imref2d([m,n]);
rec_image = imwarp(mask_image,tform,'OutputView',R);

%% Zuschnitt
width = (max(points3d(P1,:))-min(points3d(P1,:)));
height = (max(points3d(P2,:))-min(points3d(P2,:)));
crop_image = imcrop(rec_image,[min(points3d(P1,:)) min(points3d(P2,:)) width height]);       %Cropping using upper left point, width and hight of area


end