function [obj3d] = Points3D_Obj(big_image, plane2d, v, obj2d)
%% Berechnet die 3D-Punkte der Foreground-Objekte
%VARIABELN:
% plane2d(:,:,1)=[x_back;y_back]  --> [2x4x5]   (5 Planes)
% obj2d(:,:,1)=[x_obj1;y_obj1]  --> [2x4xN]     (N=#Objects)
% obj3d(:,:,1)=[x_obj1;y_obj1;z_obj1]  --> [3x4xN]

%% Vorbereitung
% Brennweite empirisch bestimmt
fh=700*(max(plane2d(2,:,1))-min(plane2d(2,:,1)))/size(big_image,1);
fb=700*(max(plane2d(1,:,1))-min(plane2d(1,:,1)))/size(big_image,2);
f=max(fh,fb);

% Offset: der neue Ursprung befindet sich in der oberen linken Ecke des Hintergrundbildes
x_offset=min(plane2d(1,:,1));               %X-offset
y_offset=min(plane2d(2,:,1));               %Y-offset
back_height=max(plane2d(2,:,1))-y_offset;   %-Wert der Unterkante / Höhe des inneren Rechtecks

%% Berechnung der 3D Koordinaten
% Funktioniert nur für Objekte die senkrecht am Boden stehen (parallel zu Hintergrundbild)

if isempty(obj2d)
    obj3d=[];               %Falls keine Objekte gewählt wurden
else
    for i=1:size(obj2d,3)

        % Breite
        %Die Berechnung der oberen Objektpunkte weist einige Sonderfälle auf --> bisher nicht umgesetzt
        %Berechnug basiert auf dem Schnittpunkt zwischen der Fluchtline und dem unteren Rand des Hintergundbildes

        %x_oL = line_x(v(1),v(2),obj2d(1,1,i),obj2d(2,1,i),max(plane2d(2,:,1)));        %obere linke Ecke
        %x_oR = line_x(v(1),v(2),obj2d(1,2,i),obj2d(2,2,i),max(plane2d(2,:,1)));        %obere rechte Ecke
        x_uR = line_x(v(1),v(2),obj2d(1,3,i),obj2d(2,3,i),max(plane2d(2,:,1)));         %untere rechte Ecke
        x_uL = line_x(v(1),v(2),obj2d(1,4,i),obj2d(2,4,i),max(plane2d(2,:,1)));         %untere linke Ecke


        % Höhe
        %Objekthöhe wird durch Projektion suf die Linke Bildseite bestimmt:
        %Berechnug basiert auf dem Schnittpunkt zwischen der Fluchtline und dem linken Rand des Hintergundbildes

        x_left = line_x(plane2d(1,1,3),plane2d(2,1,3),plane2d(1,4,3),plane2d(2,4,3),obj2d(2,4,i));
        y_Left = obj2d(2,1,i);
        obj_height = plane2d(2,4,1)-line_y(v(1),v(2),x_left,y_Left,min(plane2d(1,:,1)));

        % Tiefe
        %Berechnung basiert auf den Ähnlichkeitssätzen für Dreiecke
        %Einheitliche Tiefe
        b_L = v(1)-obj2d(1,4,i);                                        %untere linke Ecke
        d = v(1)-x_uL;
        d = (b_L*f/d)-f;

        %% Koordinaten mit neuem Ursprung im Hintergrundbild
        X=[x_uL x_uR x_uR x_uL]-x_offset;
        Y=[(back_height-obj_height) (back_height-obj_height) back_height back_height];
        obj3d(:,:,i)=[X;Y;ones(1,4)*d];
    end

end

end