function [p] = find_corner(v,rx,ry,limitx,limity)
%% Findet den Schnittpunkt der Geraden durch Fluchtpunkt v und Eckpunkt (rx,ry) mit Bildrand (limitx,limity)

% Schnittpunkt  mit oberem/unterem Bildrand
y1 = limity;
x1 = line_x(v(1),v(2),rx,ry,limity);
% Schnittpunkt mit linkem/rechtem Bildrand
x2 = limitx;
y2 = line_y(v(1),v(2),rx,ry,limitx);
% Schnittpunkt, der weiter vom Fluchtpunkt entfernt ist wird gesucht
if (sum((v-[x1 y1]).^2) > sum((v-[x2 y2]).^2))
    p = [x1,y1];
else
    p = [x2,y2];
end