function [exp_image,v,plane2d] = poly_decomp(im,v,irx,iry,orx,ory)
% In dieser Funktion wird das Bild in 5 Vierecke zerlegt, welche den
% Seitenwänden, der Rückwand, dem Boden und der Decke der 3D-Szene
% entsprechen. Hierfür müssen die Eckpunkte dieser Vierecke bestimmt, und 
% dann das Bild so weit vergrößert werden, bis alle Vierecke draufpassen.
% Anschließend werden die Vierecke nocheinmal auf die Größe der Bildseite
% angepasst, an die kein schwarzer Bildrand hinzugefügt wurde. Zum Schluss
% wird das Bild ein zweites Mal vergrößert. 

%% Bildgröße anpassen
% Abstände des Bildes zum äußeren Rand bestimmen
[ymax,xmax,col] = size(im);
lmargin = -min(orx);
rmargin = max(orx) - xmax;
tmargin = -min(ory);
bmargin = max(ory) - ymax;

% Leeres, größeres Bild erstellen
exp_image_pre = zeros(ymax+tmargin+bmargin,xmax+lmargin+rmargin,col);
% Bild darin einfügen  
exp_image_pre(tmargin+1:end-bmargin,lmargin+1:end-rmargin,:) = im2double(im);

% Variablen anpassen --> Verschiebung des Nullpunkt
v = v + [lmargin;tmargin];
irx = irx + lmargin;
iry = iry + tmargin;
orx = orx + lmargin;
ory = ory + tmargin;

%% Eckpunkte der Vierecke bestimmen
% Schnittpunkte der Gerade durch Fluchtpunkt und Eckpunkte des inneren 
% Rechtecks mit Bildrändern und Eckpunkte des inneren Rechtecks.
% Die Eckpunkte werden, beginnend bei der linken oberen Ecke, im
% Uhrzeigersinn von 1 bis 4 nummeriert.

% Variablen initialisieren
plane2d = zeros(2,4,5);

% Eckpunkte der Rückwand
plane2d(:,:,1) = [irx(1:4);iry(1:4)];

% Eckpunkte der Decke
if bmargin == 0
    d=0;
else
    d=1;
end

plane2d(:,1,2) = corners_polygons(v,irx(1),iry(1),0,0,d);             %oben links
plane2d(:,2,2) = corners_polygons(v,irx(2),iry(2),xmax+lmargin+rmargin,0,d);        %oben rechts
plane2d(:,[3,4],2) = [irx(2),irx(1);iry(2),iry(1)];


% Eckpunkte des Bodens
if tmargin == 0
    d=0;
else
    d=1;
end

plane2d(:,[1,2],3) = [irx(4),irx(3);iry(4),iry(3)];
plane2d(:,3,3) = corners_polygons(v,irx(3),iry(3),xmax+lmargin+rmargin,ymax+tmargin+bmargin,d);
plane2d(:,4,3) = corners_polygons(v,irx(4),iry(4),0,ymax+tmargin+bmargin,d);


% Eckpunkte der linken Wand
if rmargin == 0
    d=1;
else
    d=0;
end

plane2d(:,1,4) = corners_polygons(v,irx(1),iry(1),0,0,d);
plane2d(:,[2,3],4) = [irx(1),irx(4);iry(1),iry(4)];
plane2d(:,4,4) = corners_polygons(v,irx(4),iry(4),0,ymax+tmargin+bmargin,d);


% Eckpunkte der rechten Wand
if lmargin == 0
    d=1;
else
    d=0;
end

plane2d(:,[1,4],5) = [irx(2),irx(3);iry(2),iry(3)];
plane2d(:,2,5) = corners_polygons(v,irx(2),iry(2),xmax+lmargin+rmargin,0,d);
plane2d(:,3,5) = corners_polygons(v,irx(3),iry(3),xmax+lmargin+rmargin,ymax+tmargin+bmargin,d);



%% Bildgröße anpassen 2
% Abstände des Bildes zum äußeren Rand bestimmen
[ymax,xmax,col] = size(exp_image_pre);
lmargin = abs(min(plane2d(1,:,:),[],'all'));
rmargin = abs(max(plane2d(1,:,:),[],'all')) - xmax;
tmargin = abs(min(plane2d(2,:,:),[],'all'));
bmargin = abs(max(plane2d(2,:,:),[],'all')) - ymax;

% Leeres, größeres Bild erstellen
exp_image = zeros(ymax+tmargin+bmargin,xmax+lmargin+rmargin,col);
% Bild darin einfügen  
exp_image(tmargin+1:end-bmargin,lmargin+1:end-rmargin,:) = im2double(exp_image_pre);

% Variablen anpassen --> Verschiebung des Nullpunkt
v = v + [lmargin;tmargin];
plane2d(1,:,:) = plane2d(1,:,:) + lmargin;
plane2d(2,:,:) = plane2d(2,:,:) + tmargin;

end
