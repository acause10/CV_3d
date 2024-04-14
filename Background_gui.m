% Tour Into The Picture Matlab
%
% Der Benutzer wählt den "inneren Rechteck" und den Fluchtpunkt aus. Der Benutzer
% zieht den Rechteck soweit aus bis er zufrieden ist. Möglichkeit zur Verbesserung
% gibt es bis man die "ENTER" Taste drückt und damit den Rechteck speichert.
% Danach drückt man auf den Fluchtpunkt bis er mit der Auswahl
% zufrieden ist. Wenn fertig, drück die "ENTER" Taste.
% Die Funktion gibt den Fluchtpunkt (v), die Koordinaten des inneren
% Rechtecks und des außeren Polygons zurück.
function [v, irx, iry, orx, ory] = Background_gui(im)

% Größe des Bildes (Breite und Höhe) in Variablen ymax und xmax speichern
[ymax,xmax,~] = size(im);

% Bild zeigen
axis_text = axes('Position',[0 0 1 1],'Visible','off');
axis_image = axes('Position',[.1 .1 .8 .7]);

imshow(im, 'Parent', axis_image);

str(1) = {'Erster Schritt: Aufspannen des Hintergrundes, mit Enter-Taste bestätigen'};
str(2) = {'Zweiter Schritt: Auswahl des Fluchtpunktes, mit Enter-Taste bestätigen'};
set(gcf,'CurrentAxes',axis_text)
text(.1,.9,str,'FontSize',14)
set(gcf,'CurrentAxes',axis_image)

% Variante: mit ginput wählt man die obere linke und untere rechte Ecke
% und speichert die in Variablen rx und ry
% Hierbei werden x-Koordinaten in rx, und y-Koordinaten in ry gespeichert
% [rx,ry] = ginput(2);

% Rechteck zeichnen
% Idee: Koordinaten der 4 Eckpunkte im Rechteck plotten mit der 5.
% als Anfangspunkt
%      .------>.
%      ^       |
%      |       |
%      .<------.
%Code für die Rechteckzeichnung:
%hold on;
%irx = round([rx(1) rx(2) rx(2) rx(1) rx(1)]);
%iry = round([ry(1) ry(1) ry(2) ry(2) ry(1)]);
%plot(irx,iry,'b'); 
%hold off;

%Benutzer kann ohne Hindernisse blauen Rechteck auswählen;
%Rechteck würde "Background" bennant
rect = drawrectangle('Label','Background','Color','blue');
%Position der linke obere Ecke holen mit Breite und Höhe d. Rechtecks
% pos = rect.Position;
% %Berechnen Koordinaten für die rechte untere Ecke
% x_lr = pos(1) + pos(3);
% y_lr = pos(2) + pos(4);


while 1
    
    %Schleife damit man den Rechteck freiwillig ziehen kann
    %bis man die Taste auf der Tastatur drückt (kann beliebige sein)
    w = waitforbuttonpress;
    % w = 0 click
    % w = 1 keypress
    
    %Im Fall dass die Taste gedrückt wird, stationiert man den Rechteck
    %plottet den Rand; dabei kommt man raus aus der Schleife und geht fort
    %mit der Auswahl d. Fluchtpunktes
    if w == 1
        rect.InteractionsAllowed = 'none';
        pos = rect.Position;
        x_lr = pos(1) + pos(3);
        y_lr = pos(2) + pos(4);
        hold on;
        irx = round([pos(1) x_lr x_lr pos(1) pos(1)]);
        iry = round([pos(2) pos(2) y_lr y_lr pos(2)]);
        plot(irx,iry,'b');
        hold off;
        break;
    else
        continue;

    end

end

% Prompt den Benutzer den Fluchtpunkt auszuwählen bis er die "ENTER" Taste
% drückt
while 1
  
  % Mit ginput den Fluchtpunkt auswählen
  [vxnew,vynew,button] = ginput(1);

  % Die Schleife ist beendet wenn man die "ENTER" Taste drückt
  if (isempty(button))
    break;
  end

  % v ist die Variable in der der Fluchtpunkt gespeichert ist
  v = [vxnew; vynew];
  
  % Finde wo die Linie vom Fluchtpunkt durch den inneren Rechteck den
  % Bildrand trifft
  [p] = find_corner(v,irx(1),iry(1),0,0);
  orx(1) = p(1);  ory(1) = p(2);
  [p] = find_corner(v,irx(2),iry(2),xmax,0);
  orx(2) = p(1);  ory(2) = p(2);
  [p] = find_corner(v,irx(3),iry(3),xmax,ymax);
  orx(3) = p(1);  ory(3) = p(2);
  [p] = find_corner(v,irx(4),iry(4),0,ymax);
  orx(4) = p(1);  ory(4) = p(2);
  orx = round(orx);
  ory = round(ory);
 
  % Rechteck und die gefundene Geraden werden gezeichnet
  imshow(im);
  hold on;
  irx = round([pos(1) x_lr x_lr pos(1) pos(1)]);
  iry = round([pos(2) pos(2) y_lr y_lr pos(2)]);
  plot(irx,iry,'b'); 
  plot([v(1) irx(1)], [v(2) iry(1)], 'r-.');
  plot([orx(1) irx(1)], [ory(1) iry(1)], 'r');
  plot([v(1) irx(2)], [v(2) iry(2)], 'r-.');
  plot([orx(2) irx(2)], [ory(2) iry(2)], 'r');
  plot([v(1) irx(3)], [v(2) iry(3)], 'r-.');
  plot([orx(3) irx(3)], [ory(3) iry(3)], 'r');
  plot([v(1) irx(4)], [v(2) iry(4)], 'r-.');
  plot([orx(4) irx(4)], [ory(4) iry(4)], 'r');
  hold off;
  drawnow;
end

