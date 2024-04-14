function [p] = corners_polygons(v,rx,ry,limitx,limity,decider)
%% Findet den Schnittpunkt der Geraden durch den Fluchtpunkt v und Eckpunkt (rx,ry) mit Bildrand (limitx,limity)
% Je nach Fläche wird der Schnittpunkt mit dem oberen/unteren oder
% linken/rechten Bildrand benötigt -> Unterscheidung über Variable
% "decider"

if decider
    % Schnittpunkt mit oberem/unterem Bildrand
    p(2) = limity;
    p(1) = round(line_x(v(1),v(2),rx,ry,limity));
else
    % Schnittpunkt mit linkem/rechtem Bildrand
    p(1) = limitx;
    p(2) = round(line_y(v(1),v(2),rx,ry,limitx));
end

end