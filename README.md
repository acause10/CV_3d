# CV Gruppe 39
Team: Azur Čaušević, Felix Ferle, Lukas Guggeis, Roman Neuroth, Sichen Zhou

## Projektnote:
**1.3** (Deutsche Skala: 1-beste, 5-schlechteste)

## Anleitung:
1. main.m Datei öffnen und 'Run'-Taste betätigen.

2. Eines der sechs Standardbilder auswählen, oder eigenes Bild hochladen. Anschließend die Applikation mit dem Button 'Tour' starten oder anderes Bild auswählen.

3. Im Fenster 'Auswahl Hintergrund und Fluchtpunkt' kann durch ziehen bei gedrückter linker Maustaste ein Hintergrund aufgespannt werden. Dieser kann nach Auswahl durch Verschieben der Eckpunkte oder Seiten angepasst werden. Die Auswahl muss mit der 'Enter'-Taste bestätigt werden.

4. Per Mausklick kann der Fluchtpunkt der 2D-Scene gewählt werden. Durch erneutes Klicken kann der Fluchtpunkt neu gewählt werden. Die Auswahl muss mit der 'Enter'-Taste bestätigt werden.

5. Im Fenster 'Berechnung der Wände und Auswahl der Vordergrundobjekte' wird die Einteilung der Scene in die verschiedenen Teilbereiche dargestellt. In der sich öffnenden Dialogbox kann ausgewählt werden, ob Vordergrundobjekte ausgewählt werden sollen. Wird der Button 'Ja' betätigt, können Vordergrundobjekte auf die selbe Art wie der Hintergrund durch aufspannen ausgewählt werden. Dieser Vorgang ist beliebig oft wiederholbar. Eine Bestätigung mittels 'Enter'-Taste ist hier nicht notwendig.
Sobald der Button 'Nein' ausgewählt wird, führt das Programm die Berechnung der 3D-Scene durch.

6. Im letzen Fenster 'Ergebnis' wird die errechnete 3D-Scene visualisiert. Die Steuerung der Ansicht ist über die Cameratoolbar am oberen Bildrand möglich. Eine Hilfestellung zur Verwendung der Toolbox wird per Popup-Fenster zur Verfügung gestellt.
	
## Verwendete Toolboxen:
- Image Toolbox

## Quellen
**Grundidee**
- Horry, Y., Anjyo, K. I., & Arai, K. (1997, August). Tour into the picture: using a spidery mesh interface to make animation from a single image.
- https://github.com/yli262/tour-into-the-picture
- https://inst.eecs.berkeley.edu/~cs194-26/fa15/hw/proj7-stitch/proj7g/index.html

**2D und 3D Koordinaten**
- 2D Koordinaten
    - Horry, Y., Anjyo, K. I., & Arai, K. (1997, August). Tour into the picture: using a spidery mesh interface to make animation from a single image
    - https://inst.eecs.berkeley.edu/~cs194-26/fa15/hw/proj7-stitch/proj7g/index.html
- 3D Koordinaten
    - https://github.com/yli262/tour-into-the-picture
    - https://piazza.com/class_profile/get_resource/hz5ykuetdmr53k/i2c8gy2d84d3q4
    - zweistufige Bild-Expansion durch Try and Error 

**Vordergrund-Objekte**
- Auswahl der Vordergrund-Objekte
    - https://de.mathworks.com/help/images/ref/inpaintexemplar.html
    - https://de.mathworks.com/help/images/ref/drawrectangle.html
    - https://de.mathworks.com/help/images/ref/imroi.getposition.html
- Inpainting
    - https://de.mathworks.com/help/images/ref/inpaintexemplar.html
    - https://de.mathworks.com/help/images/ref/inpaintcoherent.html
- 3D Koordinaten
    - https://github.com/yli262/tour-into-the-picture
    - https://piazza.com/class_profile/get_resource/hz5ykuetdmr53k/i2c8gy2d84d3q4

**Rendering**
- Ausscheiden der Flächen
    - https://de.mathworks.com/matlabcentral/answers/420364-how-to-crop-required-roi-from-an-image
- Perspektivische Transformation
    - https://stackoverflow.com/questions/43708492/matlab-rectify-image-with-reference-of-corner-points/43709026#43709026
    - https://de.mathworks.com/help/matlab/creating_plots/understanding-view-projections.html
    - https://de.mathworks.com/help/images/ref/imwarp.html
- 3D Darstellung der Flächen
    - https://de.mathworks.com/matlabcentral/answers/458344-how-to-add-a-picture-in-the-3d-plane

**App**
- Generell
    - https://de.mathworks.com/products/matlab/app-designer.html
    - https://de.mathworks.com/help/matlab/ref/waitforbuttonpress.html
- Auswahl des Hintergrundes und Fluchtpunktes:
    - https://de.mathworks.com/help/images/ref/drawrectangle.html
    - https://de.mathworks.com/help/matlab/ref/ginput.html
    - https://inst.eecs.berkeley.edu/~cs194-26/fa15/hw/proj7-stitch/proj7g/index.html
- Ausführung in Funktion:
    - https://de.mathworks.com/matlabcentral/answers/465219-using-app-designer-how-do-i-execute-m-files-in-the-main-workspace








