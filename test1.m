v = VideoReader('EEGmom12.asf');
EyeDetect = vision.CascadeObjectDetector('FrontalFaceCART');
cnt = 0;
while cnt<3480
    I = readFrame(v);
    cnt = cnt + 1;
end

I = readFrame(v);
I = rgb2gray(I);
I = adapthisteq(I);
figure
imagesc(I)
BB= step(EyeDetect,I); %get a template
largestcompare = 0; newcompare = 0; largestcnt = 0;

for i = 1:size(BB,1)
    newcompare = BB(i,3)+BB(i,4);
    if newcompare > largestcompare
        largestcompare = newcompare;
        largestcnt = i;
    end
end
template = I(BB(largestcnt,2):BB(largestcnt,2)+BB(largestcnt,4),BB(largestcnt,1):BB(largestcnt,1)+BB(largestcnt,3));

% template = I(BB(2):BB(2)+BB(4),BB(1):BB(1)+BB(3));
% imshow(template)
figure
imshow(I)
% rectangle('Position',BB,'LineWidth',2,'LineStyle','-','EdgeColor','g');
rectangle('Position',[BB(largestcnt,1),BB(largestcnt,2),BB(largestcnt,3),BB(largestcnt,4)],'LineWidth',2,'LineStyle','-','EdgeColor','g');
% rectangle('Position',CC,'LineWidth',2,'LineStyle','-','EdgeColor','g');