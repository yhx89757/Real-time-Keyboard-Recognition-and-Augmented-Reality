clear all
close all
clc
format short g;
movieObj = VideoReader('FINGER2.mp4'); % read movie
nFrames = movieObj.NumberOfFrames; % get number of frames
fprintf('Opening movie file with %d images\n', nFrames); % print number of frames in this movie
load TIME_NOTES_1_SEC.mat %get the time notes
movieObjOutput = VideoWriter('myResults.mp4', 'MPEG-4'); % create file for output
open(movieObjOutput); %Open output movie.
whitekeyinitial=0; %initialize everything
blackkeyinitial=0;
whichkeys=0;
for iFrame=1:1:nFrames
    I = read(movieObj,iFrame); % read image from movie
    figure(1), imshow(I), title(sprintf('Frame %d', iFrame)); % print current frame number in the title
      
   % PRINT FRAME NUMBER ON THE IMAGE
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    text(20,10,sprintf('Frame %d', iFrame), ... % Also print the frame number onto the image
     'BackgroundColor', 'w', ...
     'FontSize', 10); % Default = 10 
   % FOR INITIALIZING THE POSITION OF THE KEYBOARD AND KEYS
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if iFrame==1
         [whitekeyinitial,blackkeyinitial]=highlight_keys(I,iFrame,whichkeys,whitekeyinitial,blackkeyinitial); % highlight keys being pressed and the right ones
    end
    % FOR FINDING THE HIGHEST FINGER TIP IN THE IMAGE
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    [fingertipx, fingertipy, hand5] = HandGesture(I); % detect hands and draw boundary and fingertips and return the position of figertips
    fingertipx=cell2mat(fingertipx);
    fingertipy=cell2mat(fingertipy);
    [u,v]=size(fingertipy);
    if u>1 % find the highest finger tip among the finger tips we have found
        [fingertipy,maxidx]=max(fingertipy);
        fingertipx=fingertipx(maxidx,1);
    end
   % FOR FINDING WHICH KEY IS BEING PRESSED
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if ~isempty(fingertipx)
   for i=1:26
        if fingertipx > whitekeyinitial{i,1}(1) && fingertipx < whitekeyinitial{i,2}(1) && ...
           fingertipx > whitekeyinitial{i,4}(1) && fingertipx < whitekeyinitial{i,3}(1) 
                whichkeys=i;
                highlight_keys(I,iFrame,whichkeys,whitekeyinitial,blackkeyinitial);
        end
   end
   end
    % HIGHLIGHT THE "RIGHT" KEYS FROM THE SONG
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if 15+ceil(iFrame/30)<59
    whichkeys=key(15+ceil(iFrame/30),1);
    highlight_keys_for_song(I,iFrame,whichkeys,whitekeyinitial,blackkeyinitial);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
    newFrameOut = getframe; % write video
    writeVideo(movieObjOutput,newFrameOut);
    pause(0.1);
end
close all
close(movieObjOutput); % all done, close file