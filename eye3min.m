%% this file is to detect where there exists eyecontact between infant and parents
%% in the plot all the eye-contact will be labeled 1
%% so in the case the ratio && area needs to be very specific precise
%% detect eye on the first frame, use template to locate eyes
%% estimate eyes template based on template size


%% three issues determining accuracy  
%% using 1 or 2 eyes,(care the distance between two pupils or not)  -->
%% whether use grayscale or not ?have to use grayscale to set threshold) --> only grayscale works
%% the threshold for detecting the eye-white (greater than a certain value percentage of greatest)
%% the threshold of area of white/whole area

close all; clear all;

v = VideoReader('EEGmom27.asf');
% v = VideoWriter('newfile.avi');
% open(vw)
count = 0;
num = 0;
% FrontalFaceLBP
%EyeDetect = vision.CascadeObjectDetector('EyePairig');
EyeDetect = vision.CascadeObjectDetector('FrontalFaceLBP');

EyeContact = []; EyeContactTime = [];EyeContactValue = [];

%contrast = imadjust(IMG,stretchlim(IMG),[]);
%newIMG = histeq(IMG);


while count< 1740
    I = readFrame(v);
    count = count + 1;
end

%starting from 3rd min

I = readFrame(v);
I = rgb2gray(I);
I = imadjust(I,stretchlim(I),[]);
I = adapthisteq(I);

% I = uint8(255 * mat2gray(I));
BB= step(EyeDetect,I); %get a template
largestcompare = 0; newcompare = 0; largestcnt = 0;
for i = 1:size(BB,1)
    newcompare = BB(i,3)+BB(i,4);
    if newcompare > largestcompare
        largestcompare = newcompare;
        largestcnt = i;
    end
end

contact = 0;
template = I(BB(largestcnt,2):BB(largestcnt,2)+BB(largestcnt,4),BB(largestcnt,1):BB(largestcnt,1)+BB(largestcnt,3));
% templategray = rgb2gray(template);

area = size(template,2)*size(template,1);   

% while num < 1740
while num<522
    ct = 0;
    while ct<10
    I = readFrame(v);
    ct = ct + 1;
    end
    I = readFrame(v);
    I = rgb2gray(I);
    I = adapthisteq(I);
    I = imadjust(I,stretchlim(I),[]);
     
    NCC = normxcorr2(template,I);
    [row,col] = find(NCC==(max(NCC(:)))); %%finding the most match
    cnt = 0; flag = 0; %flag 0 stands for no contact, flag 1 stands for eyecontact
    if col-size(template,2) > 0 && row-size(template,1) > 0 && col < size(I,2) && row < size(I,1)
        
    for H = col-size(template,2):col
        for V = row-size(template,1):row

            if I(V,H) > 0.8*max(template(:))
                cnt = cnt+1;
            end
        end
    
                                                                                                                                                                                                                                                                                                                                                                                          end
    newtemp = I(row-size(template,1):row,col-size(template,2):col)
    newtemp = imresize(newtemp,[256 256]);
    
    
    filename = sprintf('Feature_eyemom27%d.jpeg', contact);
    contact = contact + 1;
    imwrite(newtemp,filename);
    
    else
        filename = sprintf('Feature_eyemom27%d.jpeg', contact);
        contact = contact + 1;
        imwrite(newtemp,filename);
    end
        
    
    
% else
%     filename = sprintf('Feature_eye%d.bmp', uncontact);
%     contact = contact + 1;
%     imwrite(,filename);
num = num + 1;  

end

% one issue is to do with left half

% EyeContactValue = [EyeContactValue,cnt/area];  
% EyeContact = [EyeContact,flag];
% end
% EyeContactTime = linspace(0,ceil(num/29),num);
% figure(1)
% plot(EyeContactTime,EyeContactValue)
% xlabel('Time(seconds)');
% ylabel('EyeContact(1 for exists)');
% title('EyeContact vs Time'); 