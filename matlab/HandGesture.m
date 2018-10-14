function [fingertipx, fingertipy, hand5] = HandGesture(I)
% fingertipx= x coord of peaks(finger tips) on the boundary of hand
% fingertipy= y coord of peaks(finger tips) on the boundary of hand
% hand5= (useless) skin color filtered, eroded,dilated and median filtered image of hand
hand = findskin(I); % hand with noise
%  figure(2);imshow(hand);
fingertipx=0;
fingertipy=0;
% hand2= imerode(hand,strel('disk',18));
% figure(2);imshow(hand2);
% 
% hand3= imdilate(hand2,strel('disk',10));
% figure(3);imshow(hand3);
                                                                   
% hand = bwareaopen(hand, 10000);
% hand = imfill(hand,'holes');
% figure(4);imshow(hand3);title('Small Areas removed & Holes Filled');  
hand2 = imerode(hand,strel('disk',10));                                        %erode image
%   imshow(hand2)
hand3 = imdilate(hand2,strel('disk',10));                                       %dilate iamge
%    figure(2);imshow(hand3)
% hand4 = medfilt2(hand3, [5 5]);                                                 %median filtering
% figure(2);imshow(hand4);title('Eroded,Dilated & Median Filtered');  
hand5 = bwareaopen(hand3, 50);                                               %finds objects, noise or regions with pixel area lower than 2000 and removes them
%  figure(3);imshow(hand5);title('Processed');                    %displays image with reduced noise
hand5 = flipdim(hand5,1);                                                       %flip image rows
%  figure(4);imshow(hand3);title('Flip Image');   
%   imshow(hand5)

REG=regionprops(hand5,'all');                                                 %calculate the properties of regions for objects found 
CEN = cat(1, REG.Centroid);                                                 %calculate Centroid
[B, L, N, A] = bwboundaries(hand5,'noholes');                               %returns a label matrix L where objects and holes are labeled.
                                                                            %returns N, the number of objects found, and A, an adjacency matrix.
% RND = 0;                                                                   % set variable RND to zero; to prevent errors if no object detected
if length(B)>0
       fingertipx=cell(length(B),1);
       fingertipy=cell(length(B),1);
%calculate the properties of regions for objects found
    for k =1:length(B)                                                      %for the given object k
            PER = REG(k).Perimeter;                                         %Perimeter is set as perimeter calculated by region properties 
            ARE = REG(k).Area;                                              %Area is set as area calculated by region properties
            RND = (4*pi*ARE)/(PER^2);                                       %Roundness value is calculated
            
            BND = B{k};                                                     %boundary set for object
            BNDx = BND(:,2);                                                %Boundary x coord
            BNDy = BND(:,1);                                                %Boundary y coord
%             if mean(BNDx)<173 || mean(BNDx)>1095 || mean(BNDy)<538
%                 fingertipx{k,1}=[0];
%                 fingertipy{k,1}=[0];
%                 continue;
%             end
            pkoffset = CEN(:,2)+.5*(CEN(:,2));                             %Calculate peak offset point from centroid             
            [pks,locs] = findpeaks(BNDy,'minpeakheight',1);         %find peaks in the boundary in y axis with a minimum height greater than the peak offset
            [u,v,w]=size(I);
            BNDy=u-BNDy;
            pks=u-pks;
            CEN(:,2)=u-CEN(:,2);
            [u1,v1]=size(pks);
            if u1>1 % just pick the highest peak when there are more than one peaks in the same boundary
                [pks,minidx]=min(pks);
                locs=locs(minidx,1);
            end
            if pks>430 || pks<272 || BNDx(locs)<170 || BNDx(locs)>1097
                continue;
            end
            fingertipx{k,1}=BNDx(locs);
            fingertipy{k,1}=pks;
           hold on
            plot(BNDx, BNDy, 'b', 'LineWidth', 2);                          %plot Boundary
%           plot(CEN(:,1),CEN(:,2), '*');                                   %plot centroid
            plot(BNDx(locs),pks,'rv','MarkerFaceColor','r','lineWidth',2);  %plot peaks
            hold off
%             pkNo = u1;                                            %finds the peak Nos
%             pkNo_STR = sprintf('%2.0f',pkNo);                              %puts the peakNo in a string
      end
                                                                           % roundness is useful, for an object of same shape ratio, regardless of
                                                                            % size the roundess value remains the same. For instance, a circle with
                                                                            % radius 5pixels will have the same roundness as a circle with radius
                                                                            % 100pixels. It is a measure of how round an object is.

                                                                            %     CHAR_STR = 'not identified hand';                                            %sets char_str value to 'not identified'
%     if RND >0.19 && RND < 0.24 && pkNo ==3
%         CHAR_STR = 'W';
%     elseif RND >0.44 && RND < 0.47  && pkNo ==1
%         CHAR_STR = 'O';
%     elseif RND >0.37 && RND < 0.40 && pkNo ==2
%         CHAR_STR = 'R';
%     elseif RND >0.40 && RND < 0.43 && pkNo == 3
%         CHAR_STR = 'D';
%     else
%         CHAR_STR = 'hand';
%     end
%     text(20,20,CHAR_STR,'color','g','Fontsize',14);                         %place text in x=20,y=20 on the figure with the value of Char_str in redcolour with font size 18
%     text(20,50,['roundness: ' sprintf('%f',RND)],'color','g','Fontsize',14);
%     text(20,80,['finger tips: ' pkNo_STR],'color','g','Fontsize',14);
  
end
end