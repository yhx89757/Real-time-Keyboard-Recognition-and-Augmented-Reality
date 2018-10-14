clear all
close all
global KEY_IS_PRESSED
KEY_IS_PRESSED = 0;

camList = webcamlist;
% Connect to the webcam.
cam = webcam(1);

while ~KEY_IS_PRESSED
    I = snapshot(cam);
    imshow(I); title('Press any key to quit');
    gcf;
    set(gcf, 'KeyPressFcn', @myKeyPressFcn);
end

clear cam
