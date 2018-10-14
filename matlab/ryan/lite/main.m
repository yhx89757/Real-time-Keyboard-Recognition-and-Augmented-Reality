clear all
clc
close all

%camList = webcamlist;

% % Connect to the webcam.
% cam = webcam(1);
% I = snapshot(cam);
format short g;
movieObj = VideoReader('video1.mp4'); % read movie
nFrames = movieObj.NumberOfFrames; % get number of frames
fprintf('Opening movie file with %d images\n', nFrames); % print number of frames in this movie
%   iFrame=100;
 for iFrame=50:50:900
%     disp(iFrame)
I = read(movieObj,iFrame); % read image from movie
figure(1), imshow(I), title(sprintf('Frame %d', iFrame)); % print current frame number in the title
text(20,40,sprintf('Frame %d', iFrame), ... % Also print the frame number onto the image
 'BackgroundColor', 'w', ...
 'FontSize', 10); % Default = 10 

corners = get_LCD_corners(I);
I_LCD = ortho_LCD(corners,I);
centers_of_points = get_coords(I_LCD);

pause(0.5)
 end
