function [background, object_img, obj2d] = Foreground(exp_image,plane2d)
%% Berechnet 2D-Punkte und Bildauschnitte der Foreground-Objekte
% VARIABLEN:
% obj2d(:,:,1)=[x_obj1;y_obj1]  --> [2x4xN]  (N=#Objects)
% object_img: struct for saving images

%% VORBEREITUNG
% Zeige das erweiterte Bild mit der Unterteilung
f2 = figure('Name', 'Berechnung der Wände und Auswahl der Vordergrundobjekte','NumberTitle','off');
figure(f2);


imshow(exp_image);
hold on;

plot([plane2d(1,:,2) plane2d(1,1,2)], [plane2d(2,:,2) plane2d(2,1,2)], 'b-.');
plot([plane2d(1,:,3) plane2d(1,1,3)], [plane2d(2,:,3) plane2d(2,1,3)], 'r-','LineWidth',3);
plot([plane2d(1,:,4) plane2d(1,1,4)], [plane2d(2,:,4) plane2d(2,1,4)], 'b-.');
plot([plane2d(1,:,5) plane2d(1,1,5)], [plane2d(2,:,5) plane2d(2,1,5)], 'b-.');

%Bild Beschränken auf wichtigen Bereich 
ylim([find(exp_image(:,plane2d(1,1,1),1),1) find(exp_image(:,plane2d(1,1,1),1),1,'last')])      %X->Y
xlim([find(exp_image(plane2d(2,1,1),:,1),1) find(exp_image(plane2d(2,1,1),:,1),1,'last')])      %Y->X

%Variablen
mask = false(size(exp_image,[1 2]));
i=0;
pos_obj=[];
object_img={};

%% Zeichnen und speichern der ROI (= Auschnitte)
while 1
    if i==0
        %Abfrage für erstes Rechteck   -- >GUI?
        choice = menu('Vordergrundobjekte auf dem Boden auswählen?','Ja','Nein');
    elseif choice==1
        %ROI zeichnen und speichern
        obj(i) = drawrectangle('Label',['Obj', num2str(i)],'Color',[rand(1,3)]);

        %Abfrage für weiteres Rechteck  -- >GUI?
        choice = menu('Weitere Vordergrundobjekte auf dem Boden auswählen?','Ja','Nein');
    else
        break
    end
    i=i+1;
end


% Abfrage der Position erst im Nachhinein um Änderung zu erlauben
for n=1:(i-1)
    %Abspeichern der Positionen
    pos_obj(n,:) = obj(n).Position;                                 %[Xmin Ymin Width Height ]  -->[Nx4]

    %Erweiterung der Maske und ausschneiden
    mask = mask | createMask(obj(n));
    object_img(n)={imcrop(exp_image,pos_obj(n,:))};
end

%% Inpaiting
%Je nach Bildgröße und Anzahl gewählter Bildauschnitte besseres oder schnelleres Inpainting
res=size(exp_image,1)*size(exp_image,2);

if res > 2*10^6 || i > 3
    background = inpaintCoherent(exp_image,mask);                 %doppelt so schnell, aber Ergebnis schlechter
else
    background = inpaintExemplar(exp_image,mask);
end

close(f2);
%% Handeling fürs Rendering
%   obj2d(:,:,1)=[x_obj1;y_obj1]  --> [2x4xN]
%   pos_obj = [Xmin Ymin Width Height]

obj2d=zeros(2,4,size(pos_obj,1));   %Preallocation
for i=1:size(pos_obj,1)
    obj2d(1,:,i)=[pos_obj(i,1);pos_obj(i,1)+pos_obj(i,3);pos_obj(i,1)+pos_obj(i,3);pos_obj(i,1)];  %upper left --> clockwise
    obj2d(2,:,i)=[pos_obj(i,2);pos_obj(i,2);pos_obj(i,2)+pos_obj(i,4);pos_obj(i,2)+pos_obj(i,4)];
end

end
