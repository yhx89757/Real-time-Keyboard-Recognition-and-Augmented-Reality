function corners = get_LCD_corners(I)

% clear all
% close all
% clc

% global KEY_IS_PRESSED
% KEY_IS_PRESSED = 0;

% vidObj = VideoWriter('mymovie.avi'); % create avi file
% open(vidObj);

% camList = webcamlist;
% % Connect to the webcam.
% cam = webcam(1);
% old_output = zeros(4,2);



% I = snapshot(cam);

B = im2bw(I,graythresh(I));
    SA = strel('disk',3);
    B2 = imopen(B, SA);
    B3 = imclose(B2,SA);
    B = B3;
    iB = ~B;
[L,num] = bwlabel(B,4);
[iL,inum] = bwlabel(iB,4);
% figure, imshow(I,[]); title('raw');
% figure, imshow(L,[]); title('blobs');
% figure, imshow(iL,[]); title('iblobs');

blobs = regionprops(L,'Centroid',...
    'Perimeter','Area','BoundingBox');    
iblobs = regionprops(iL,'Centroid',...
    'Perimeter','Area','BoundingBox');   

%     H = 5.2; %Height of screen in cm
%     B = 3.3; %Width of screen in cm
%     c = B/H; %Ratio of Height to Width of LCD Screen
%     R = ones(num,1);
%         R_low = -0.1;
%         R_high = 0.1;
%     A_max = 0;
e_match = 30;
k=0;
for i = 1:num
    for j = 1:inum
        k = k+1;
            norm_check(k) = ...
                norm((blobs(i).Centroid - iblobs(j).Centroid),2);
            if(norm_check(k) < e_match)
%                 if(iblobs(j).Area > blobs(i).Area) 
                if(iblobs(j).Area > 10000)
                    index = j;
%                     disp(index);
%                     disp(norm_check(k));
                end
            end
%         end
    end
end

    
% disp(min(norm_check));

%     for i = 1:num
%     %     R = (4 * pi * blobs(i).Area)/(blobs(i).Perimeter)^2;
%     R(i) = (4*blobs(i).Area/blobs(i).Perimeter^2)*(1+2*c+c^2)-c;    
% 
%         if (R(i) > R_low && R(i) < R_high)
%             if A_max < blobs(i).Area;
%             index = i;
%             A_max = blobs(i).Area;
%             end
% 
%         end
% 
%     end
%     areas = cat(1, blobs(:).Area); % concatentate along dimension 1
% imshow(I,[]);


I_mask = masker(index,iL);
% figure, imshow(I_mask,[]);
%     rectangle('Position', blobs(index).BoundingBox, 'EdgeColor', 'r');
%     output = corners(blobs(index).BoundingBox,I_mask);
% output = corners2(I_mask);
% output = output_sorter(output);
[corners, nMatches, avgErr] = findCheckerBoard(I_mask);
output = corners;
% figure, imshow(I,[]);
% hold on;
% plot(output(:,1),output(:,2),'ro')
% for i = 1:length(corners)
%     ptlabel = ['Point ', num2str(i)];
%     text(corners(i,1),corners(i,2),ptlabel) 
% end

% x0 = blobs(index).Centroid(1);
% y0 = blobs(index).Centroid(2);
% line([x0-5 x0+5], [y0 y0], 'Color', 'r');
% line([x0 x0], [y0-5 y0+5], 'Color', 'r');

%     newFrameOut = getframe;
%     writeVideo(vidObj,newFrameOut);
%     
%     gcf;
%     set(gcf, 'KeyPressFcn', @myKeyPressFcn);

% old_output = (output + old_output);
%     old_output = rs;

% out_sort = output_sorter(output);
% close(vidObj);
% output_final = old_output./shot_num;
% hold on; plot(output_final(:,1),output_final(:,2),'b+');

% clear cam
% disp(corners);
end

