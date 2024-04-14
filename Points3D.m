function [plane3d] = Points3D(big_image, v, plane2d)
%% Berechnet die 3D-Punkte der fünf Hauptflächen
% Reihenfolge der Punkte: beginnend oben links --> im Uhrzeigersinn
%VARIABELN:
% plane2d(:,:,1)=[x_back;y_back]  --> [2x4x5]     (5 Planes)
% plane3d(:,:,1)=[x_back;y_back;z_back]  --> [3x4x5]     (5 Planes)
%margin=[tmargin;fmargin;lmargin;rmargin];     %ursprüngliche Idee

%% Vorbereitung
%Brennweite empirische bestimmt 
fh=700*(max(plane2d(2,:,1))-min(plane2d(2,:,1)))/size(big_image,1);
fb=700*(max(plane2d(1,:,1))-min(plane2d(1,:,1)))/size(big_image,2);
f=max(fh,fb);

%Offset: der neue Ursprung befindet sich in der oberen linken Ecke des Hintergrundbildes
x_offset=min(plane2d(1,:,1));               %X-offset
y_offset=min(plane2d(2,:,1));               %Y-offset

%% Berechnung der jeweiligen Seitentiefe
% Hierfür wurden die Ähnlichkeitssätze für Dreiecke genutzt

%Decke
h_top=v(2);                 
b=v(2)-min(plane2d(2,:,1));
d_top=(h_top*f/b)-f;

%Boden
h_floor=max(plane2d(2,:,3))-v(2);
a=max(plane2d(2,:,1))-v(2);
d_floor=(h_floor*f/a)-f;

%Links
b_L=v(1);                  
l=v(1)-min(plane2d(1,:,1));
d_L=(b_L*f/l)-f;

%Rechts
b_R=max(plane2d(1,:,5))-v(1);
r=max(plane2d(1,:,1))-v(1);
d_R=(b_R*f/r)-f;

depth = min([d_top,d_floor,d_L,d_R]); %kleinste Tiefe wird verwendet

%% Koordinaten mit neuem Ursprung im Hintergrundbild
X_back=plane2d(1,:,1)-x_offset;
Y_back=plane2d(2,:,1)-y_offset;
plane3d(:,:,1) = [X_back; Y_back; 0 0 0 0];                                  %back    (XY)    
plane3d(:,:,2) = [X_back; min(Y_back)*ones(1,4); 0 0 d_top d_top ];          %ceiling (XZ)
plane3d(:,:,3) = [X_back; max(Y_back)*ones(1,4); 0 0 d_floor d_floor ];      %floor  (XZ)*
plane3d(:,:,4) = [min(X_back)*ones(1,4); Y_back; 0 d_L d_L 0];               %left    (YZ) 
plane3d(:,:,5) = [max(X_back)*ones(1,4); Y_back; 0 d_R d_R 0];               %reight  (YZ)* 
end
