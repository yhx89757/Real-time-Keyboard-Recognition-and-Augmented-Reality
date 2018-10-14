function [final_image] = findskin(I) %%skin region in rgb image%%%%%%%%% 
if(size(I, 3) > 1)
    final_image = zeros(size(I,1), size(I,2));
    for i = 1:size(I,1)
        for j = 162:1102
            R = I(i,j,1);
            G = I(i,j,2);
            B = I(i,j,3);
%             if(R > 95 && G > 40 && B > 20)
              if(R > 100 && G > 45 && B > 26)
                v = [R,G,B];
%                 if((max(v) - min(v)) > 15)
                 if((max(v) - min(v)) > 15)
                    if(abs(R-G) > 25 && R > G && R > B)
                        %it is a skin
                        final_image(i,j) = 1;
                    end
                end
            end
        end
    end
end %%% added
%     figure, imshow(final_image);
%     disp('before');
BW=final_image;
%else
%    BW=im2bw(I);
 % figure, imshow(BW);
%disp('convert');
%end
L = bwlabel(BW,4);

BB = regionprops(L, 'BoundingBox');

BB1 =struct2cell(BB);
BB2 = cell2mat(BB1);
[s1 s2]=size(BB2);

% mx=0; % find max value in BB2
% 
% for k=3:4:s2-1
%     p=BB2(1,k)*BB2(1,k+1);
%     if p>mx && (BB2(1,k)/BB2(1,k+1))<1.8
%         mx=p;
%         j=k;
%     end
% end
 end