function y = line_y(x1,y1,x2,y2,x)
%% Findet y-Wert der zu einem x-Wert auf der Gerade durch (x1,y1) und (x2,y2) gehört

m = (y2-y1)./(x2-x1);       %Steigung
b = y2 - m*x2;              %Achsenabschnitt 
y = m*x + b;                %Auflösung

end