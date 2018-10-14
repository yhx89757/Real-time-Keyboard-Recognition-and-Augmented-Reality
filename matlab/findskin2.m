function [final_image] = findskin(I)

RGB=imresize(I,[2000 2000]);% resize the image
a = RGB;
[r c p] = size(a);
 HSV=rgb2hsv(a); % change the rgb to hsb color space
h =HSV(:,:,1);
s =HSV(:,:,2);
v =HSV(:,:,3);
 d=zeros(r,c);
 Z=100;  
 for i=1:r;
    for j=1:c;
        if ((h(i,j)<.25)&&((s(i,j)<.68)&& (s(i,j)>0.106)));
            d(i,j)=1;
            O=i-Z;
           K=j-640;
         end
    end
 end
 for i=1:r;
      for j=1:c;
            F=d(i,j);
            if F~=1;
                a(i,j,1)=0;
                  a(i,j,2)=0;
                  a(i,j,3)=0;
            end
      end
 end
 final_image=d;

end