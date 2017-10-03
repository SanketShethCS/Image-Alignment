% CSCI 431/631 Programming Assignment 1, starter Matlab code
% Adapted from A. Efros and R. Fergus
%Author - Sanket Sheth (sas6792@g.rit.edu)

% name of the input file
imname = 'part3_6.jpg'; %address name of image replace the file name by image
                        %

% read in the image
fullim = imread(imname);  %reading the user provided image

% convert to double matrix 
fullim = im2double(fullim); %converting the user image to double

% compute the height of each part (just 1/3 of total)
height = floor(size(fullim,1)/3); %finding out the height of each channel 
                                  %image for seperation

% separate color channels; you may use different techniques for
% seperating the images.
B = fullim(1:height,:);
G = fullim(height+1:height*2,:);
R = fullim(height*2+1:height*3,:);

% Align the images
% Functions that might be useful to you for aligning the images include: 
% "circshift", "sum"

%Aligning G with B and than R with B
aG = align(G,B);

aR = align(R,B);
%Aliging transpose of aG with transpose of B and same with aR transpose
aG= align(aG',B');

aR= align(aR',B');
%taking transpose again to get original orientation
aG=aG';
aR=aR';
figure(1);
colorim = cat(3,B,aG,aR); %Concatenation of all three aligned images
imshow(colorim);

imwrite(colorim,['result-' imname]); %writing the new obtained image to file


function result = align(p1,p2)  %this function aligns p1 according to p2
    ssdData=[];  %array to sstore SSD values for the window
    i=1;
    for count = -15:15 %looping over window of -15:15
        tempImg=circshift(p1,count);  %sifting the p1 image by one pixel
        ssdData(i) = sum(sum((p2-tempImg).^2)); %SSD calculation against p2
        i=i+1;
    end
    [~,I]=min(ssdData); %finding index for minimum value of SSD
    shift = I-16; %calculating the shift required for aligning the image
    result=circshift(p1,shift); %aligning the image
    disp(ssdData)
end


% open figure


% create a color image (3D array)
% ... use the "cat" command

% show the resulting image
% ... use the "imshow" command

% save result image

