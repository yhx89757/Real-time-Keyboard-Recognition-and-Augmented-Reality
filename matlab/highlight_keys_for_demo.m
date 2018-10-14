% function [] = highlight_keys_for_demo(I,iFrame,whichkeys)

% testscript
clear all
close all
clc
%size white 8,2 black 5,1 keyboard 8,52
format short g;
movieObj = VideoReader('FINGER2.mp4'); % read movie
nFrames = movieObj.NumberOfFrames; % get number of frames
fprintf('Opening movie file with %d images\n', nFrames); % print number of frames in this movie

for iFrame=1:10:nFrames
I = read(movieObj,iFrame); % read image from movie
figure(1), imshow(I), title(sprintf('Frame %d', iFrame)); % print current frame number in the title
% script end

if iFrame==1
%     %59,262
%     %1228,262
%     %59,458
%     %1228,458
%     Pimg2=[59,262;1228,262;59,458;1228,458];
%     Pworld2=[59,262;1228,262;59,458;1228,458];
%     Tform=fitgeotrans(Pimg2,Pworld2,'projective');
%     ref2Doutput = imref2d(...
%     [458-262,1228-59],...
%     [59,1228],... 
%     [262,458]);
%     I = imwarp(I,Tform,'OutputView', ref2Doutput);

    keyinorder=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[corners, nMatches, avgErr, a1, a2] = findCheckerBoard(I); 
% Returns:
%   corners: the locations of the four outer corners as a 4x2 array, in 
%       the form [ [x1,y1]; [x2,y2]; ... ].
%   nMatches:  number of matching points found (ideally is 81)
%   avgErr:  the average reprojection error of the matching points
%       Return empty if not found.
%   a1:  clockwise angle from horizontal x+.
%   a2:  counterclockwise angle from vertical y-.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% There is a slight deviation of angle when shooting the movie, so the
% whole keyboard is like a "parallelogram".
diffxupper=(corners(2,1)-corners(1,1))/26; % width of sigle whitekey(upper) = X2(x of point2)-X1(x of point1)
diffxlower=(corners(3,1)-corners(4,1))/26;% width of sigle whitekey(lower) = X3(x of point3)-X4(x of point4)
diffyleft=corners(4,2)-corners(1,2);
diffyright=corners(3,2)-corners(2,2);
diffylefttoright=(diffyleft-diffyright)/26; % difference of y per keys from left to right especially keyboard is not horizontal
% The whole keyboard is not absolutely "horizontal" in the camera, so we
% need "diffyupper" and "diffylower" as an adjustion.
diffyupper=sind(a1)*(corners(2,1)-corners(1,1))/26/26;
diffylower=sind(a1)*(corners(3,1)-corners(4,1))/26/26;
whitekey=cell(26,4); % create whitekey cell array

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:27 % identify and ciecle out every corner in the keyboard
    if i<18
        rectangle('Position', [corners(1,1)+0+(diffxupper+0.5)*(i-1)-10 corners(1,2)-10+diffyupper*(i-1) 10 10], ...
                     'Curvature', [1 1], 'EdgeColor', 'r', 'LineWidth', 1);
        rectangle('Position', [corners(4,1)+0+(diffxlower+0.5)*(i-1)-10 corners(4,2)-10+diffyupper*(i-1) 10 10], ...
                     'Curvature', [1 1], 'EdgeColor', 'r', 'LineWidth', 1);
 
    end
    if i>17
        rectangle('Position', [corners(1,1)+18+(diffxupper-0.5)*(i-1)-10 corners(1,2)-10+diffylower*(i-1) 10 10], ...
                     'Curvature', [1 1], 'EdgeColor', 'r', 'LineWidth', 1);
        rectangle('Position', [corners(4,1)+18+(diffxlower-0.5)*(i-1)-10 corners(4,2)-10+diffylower*(i-1) 10 10], ...
                     'Curvature', [1 1], 'EdgeColor', 'r', 'LineWidth', 1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:26  % record the position of four corners(clockwise) of the white keys into "whitekey" cell array.
    if i<18
        whitekey{i,1}= [corners(1,1)+0+(diffxupper+0.5)*(i-1), corners(1,2)+diffyupper*(i-1)-10+diffylefttoright*(j-1)/2];
        whitekey{i,4}= [corners(4,1)+0+(diffxlower+0.5)*(i-1), corners(4,2)+diffyupper*(i-1)-diffylefttoright*(j-1)/2];
        whitekey{i,2}= [corners(1,1)+0+(diffxupper+0.5)*(i), corners(1,2)+diffyupper*(i)-10+diffylefttoright*j/2];
        whitekey{i,3}= [corners(4,1)+0+(diffxlower+0.5)*(i), corners(4,2)+diffyupper*(i)-diffylefttoright*j/2];
    end
    if i>17
        whitekey{i,1}= [corners(1,1)+18+(diffxupper-0.5)*(i-1), corners(1,2)+diffylower*(i-1)-10+diffylefttoright*(j-1)/2];
        whitekey{i,4}= [corners(4,1)+18+(diffxlower-0.5)*(i-1), corners(4,2)+diffylower*(i-1)-diffylefttoright*(j-1)/2];
        whitekey{i,2}= [corners(1,1)+18+(diffxupper-0.5)*(i), corners(1,2)+diffylower*(i)-10+diffylefttoright*j/2];
        whitekey{i,3}= [corners(4,1)+18+(diffxlower-0.5)*(i), corners(4,2)+diffylower*(i)-diffylefttoright*j/2];
    end
end
blackkey=cell(18,4); % create blackkey cell array
NN=0; % initialize NN
for i=1:18  % record the position of four corners(clockwise) of the black keys into "blackkey" cell array.
    if i==1 || i==4 || i==6 || i==9 || i==11 || i==14 || i==16 %left blackkeys
        if i ==1 j=1; end
        if i ==4 j=5;NN=1; end
        if i ==6 j=8; end
        if i ==9 j=12;NN=1; end
        if i ==11 j=15; end
        if i ==14 j=19;NN=1; end
        if i ==16 j=22; end
        if NN==1
            blackkey{i,1}= [whitekey{j,2}(1)+diffxupper*0.07-diffxupper/2, whitekey{j,1}(2)];
            blackkey{i,4}= [whitekey{j,3}(1)+diffxlower*0.07-diffxlower/2, whitekey{j,4}(2)-diffyleft*4/8];
            blackkey{i,2}= [whitekey{j,2}(1)+diffxupper*0.07, whitekey{j,2}(2)];
            blackkey{i,3}= [whitekey{j,3}(1)+diffxlower*0.07, whitekey{j,3}(2)-diffyleft*4/8];
        else
            blackkey{i,1}= [whitekey{j,2}(1)+diffxupper*0.1-diffxupper/2, whitekey{j,1}(2)];
            blackkey{i,4}= [whitekey{j,3}(1)+diffxlower*0.1-diffxlower/2, whitekey{j,4}(2)-diffyleft*4/8];
            blackkey{i,2}= [whitekey{j,2}(1)+diffxupper*0.1, whitekey{j,2}(2)];
            blackkey{i,3}= [whitekey{j,3}(1)+diffxlower*0.1, whitekey{j,3}(2)-diffyleft*4/8];
        end
    end
    if i==2 || i==7 || i==12 || i==17  % middle blackkeys
        if i ==2 j=2; end
        if i ==7 j=9; end
        if i ==12 j=16; end
        if i ==17 j=23; end
            blackkey{i,1}= [whitekey{j,2}(1)+diffxupper*0.25-diffxupper/2, whitekey{j,1}(2)];
            blackkey{i,4}= [whitekey{j,3}(1)+diffxlower*0.25-diffxlower/2, whitekey{j,4}(2)-diffyleft*4/8];
            blackkey{i,2}= [whitekey{j,2}(1)+diffxupper*0.25, whitekey{j,2}(2)];
            blackkey{i,3}= [whitekey{j,3}(1)+diffxlower*0.25, whitekey{j,3}(2)-diffyleft*4/8];       
    end
    if i==3 || i==5 || i==8 || i==10 || i==13 || i==15 || i==18 % right blackkeys
        if i ==3 j=3; end
        if i ==5 j=6;NN=1; end
        if i ==8 j=10; end
        if i ==10 j=13;NN=1; end
        if i ==13 j=17; end
        if i ==15 j=20;NN=1; end
        if i ==18 j=24; end
        if NN==1
            blackkey{i,1}= [whitekey{j,2}(1)+diffxupper*(0.5-0.07)-diffxupper/2, whitekey{j,1}(2)];
            blackkey{i,4}= [whitekey{j,3}(1)+diffxlower*(0.5-0.07)-diffxlower/2, whitekey{j,4}(2)-diffyleft*4/8];
            blackkey{i,2}= [whitekey{j,2}(1)+diffxupper*(0.5-0.07), whitekey{j,2}(2)];
            blackkey{i,3}= [whitekey{j,3}(1)+diffxlower*(0.5-0.07), whitekey{j,3}(2)-diffyleft*4/8];
        else
            blackkey{i,1}= [whitekey{j,2}(1)+diffxupper*(0.5-0.1)-diffxupper/2, whitekey{j,1}(2)];
            blackkey{i,4}= [whitekey{j,3}(1)+diffxlower*(0.5-0.1)-diffxlower/2, whitekey{j,4}(2)-diffyleft*4/8];
            blackkey{i,2}= [whitekey{j,2}(1)+diffxupper*(0.5-0.1), whitekey{j,2}(2)];
            blackkey{i,3}= [whitekey{j,3}(1)+diffxlower*(0.5-0.1), whitekey{j,3}(2)-diffyleft*4/8];
        end
    end
    NN=0; % reset NN
  if i>9 % slight adjustment
            blackkey{i,1}= [blackkey{i,1}(1)-2, blackkey{i,1}(2)];
            blackkey{i,4}= [blackkey{i,4}(1)-2, blackkey{i,4}(2)];
            blackkey{i,2}= [blackkey{i,2}(1)-2, blackkey{i,2}(2)];
            blackkey{i,3}= [blackkey{i,3}(1)-2, blackkey{i,3}(2)];
            if i==10 || i==15
                blackkey{i,1}= [blackkey{i,1}(1)-4, blackkey{i,1}(2)];
                blackkey{i,4}= [blackkey{i,4}(1)-4, blackkey{i,4}(2)];
                blackkey{i,2}= [blackkey{i,2}(1)-4, blackkey{i,2}(2)];
                blackkey{i,3}= [blackkey{i,3}(1)-4, blackkey{i,3}(2)];
            end
  end
end
end
%for test
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i= 1:26 % highlight each whitekey in left-to-right order by using line function and data from "whitekey" cell array.
% 
%     figure(1), imshow(I), title(sprintf('Frame %d', iFrame));
%     line([whitekey{i,1}(1),whitekey{i,2}(1)],[whitekey{i,1}(2), whitekey{i,2}(2)],'Color','g','LineWidth',2)
%     line([whitekey{i,2}(1),whitekey{i,3}(1)],[whitekey{i,2}(2), whitekey{i,3}(2)],'Color','g','LineWidth',2)
%     line([whitekey{i,3}(1),whitekey{i,4}(1)],[whitekey{i,3}(2), whitekey{i,4}(2)],'Color','g','LineWidth',2)
%     line([whitekey{i,4}(1),whitekey{i,1}(1)],[whitekey{i,4}(2), whitekey{i,1}(2)],'Color','g','LineWidth',2)
%     pause(0.2);
% end
% 
% for i= 1:18 % highlight each blackkey in left-to-right order by using line function and data from "blackkey" cell array.
% 
%     figure(1), imshow(I), title(sprintf('Frame %d', iFrame));
%     line([blackkey{i,1}(1),blackkey{i,2}(1)],[blackkey{i,1}(2), blackkey{i,2}(2)],'Color','g','LineWidth',2)
%     line([blackkey{i,2}(1),blackkey{i,3}(1)],[blackkey{i,2}(2), blackkey{i,3}(2)],'Color','g','LineWidth',2)
%     line([blackkey{i,3}(1),blackkey{i,4}(1)],[blackkey{i,3}(2), blackkey{i,4}(2)],'Color','g','LineWidth',2)
%     line([blackkey{i,4}(1),blackkey{i,1}(1)],[blackkey{i,4}(2), blackkey{i,1}(2)],'Color','g','LineWidth',2)
%     pause(0.2);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% JUST FOR DEMO
 % highlight each whitekey in left-to-right order by using line function and data from "whitekey" cell array.
    i=keyinorder/20+1;
    if i<27
        line([whitekey{i,1}(1),whitekey{i,2}(1)],[whitekey{i,1}(2), whitekey{i,2}(2)],'Color','g','LineWidth',2)
        line([whitekey{i,2}(1),whitekey{i,3}(1)],[whitekey{i,2}(2), whitekey{i,3}(2)],'Color','g','LineWidth',2)
        line([whitekey{i,3}(1),whitekey{i,4}(1)],[whitekey{i,3}(2), whitekey{i,4}(2)],'Color','g','LineWidth',2)
        line([whitekey{i,4}(1),whitekey{i,1}(1)],[whitekey{i,4}(2), whitekey{i,1}(2)],'Color','g','LineWidth',2)
        pause(0.2);
    end


 % highlight each blackkey in left-to-right order by using line function and data from "blackkey" cell array.
    i=keyinorder/20+1;
    if i<19
        line([blackkey{i,1}(1),blackkey{i,2}(1)],[blackkey{i,1}(2), blackkey{i,2}(2)],'Color','b','LineWidth',3)
        line([blackkey{i,2}(1),blackkey{i,3}(1)],[blackkey{i,2}(2), blackkey{i,3}(2)],'Color','b','LineWidth',3)
        line([blackkey{i,3}(1),blackkey{i,4}(1)],[blackkey{i,3}(2), blackkey{i,4}(2)],'Color','b','LineWidth',3)
        line([blackkey{i,4}(1),blackkey{i,1}(1)],[blackkey{i,4}(2), blackkey{i,1}(2)],'Color','b','LineWidth',3)
        pause(0.2);
    end

if iFrame-keyinorder>19 keyinorder=keyinorder+20; end
% newFrameOut = getframe;
% writeVideo(movieObjOutput,newFrameOut);
% pause(0.1);
 end




