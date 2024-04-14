function x = line_x(x1,y1,x2,y2,y)
%% Findet x-Wert der zu einem y-Wert auf der Gerade durch (x1,y1) und (x2,y2) gehört

m = (y2-y1)./(x2-x1);   %Steigung
b = y2 - m*x2;          %Achsenabschnitt 
x = (y-b)/m;            %Auflösung

end
