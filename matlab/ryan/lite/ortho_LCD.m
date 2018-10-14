function I_LCD = ortho_LCD(Pimg2,I)

% Pimg2 = get_LCD_corners();

% Define location of control points in the world (in cm).
Pworld2 = [
    0, 0; % X,Y units in cm
    67.08, 0;
    67.08, 72.15;
    0, 72.15;
    ];
% Compute transform, from corresponding control points
Tform2 = fitgeotrans(Pimg2,Pworld2,'projective');

% bars_ratio = 40/12.8; %units in mm
% height = 480;
% width = floor(height / bars_ratio);
% ref2Doutput = imref2d(...
%     [height,width],...
%     [20,32],...
%     [10,60]);

ref2Doutput = imref2d(...
    [480,150],...
    [18,32],... 
    [14,60]); 
    % [image_height,image_width] -> [480,320],...
    % [xmin xmax]
    % [ymin ymax]

% Transform input image to output image
Iout2 = imwarp(I,Tform2,'OutputView', ref2Doutput);

% figure, imshow(Iout2,[]);
% title('raw')
level = graythresh(Iout2);
% level = .5;
Iout3 = im2bw(Iout2,level);
% figure, imshow(Iout3,[]);
% title('graythreshed')
% Iout3 = im2bw(Iout2);


% % Use to open Image----------------
SA_close = strel('disk',7);
Iout3 = imclose(Iout3,SA_close);
% figure, imshow(Iout3,[]);
% title('Closed')

%Use to close Image----------------
% SA_open = strel('disk',2);
% Iout5 = imopen(Iout5, SA_open);
% figure, imshow(Iout5,[]);
% title('Opened')
    
I_LCD = Iout3;
% figure, imshow(I_LCD,[]);
% title('Final')



end