function xy = get_coords(I)
I = ~I;
[centers, radii, metric] = imfindcircles(I,[10 15],...
    'ObjectPolarity','bright','Sensitivity',.95,'EdgeThreshold',0.05);
[u,v]=size(centers);
if u>1
for i=1:length(centers)-1 % convert two centers into one for the same circle
     for j=i+1:length(centers)
         if i==j 
             break; 
         else
             if abs(centers(i,1)-centers(j,1))<20 && abs(centers(i,2)-centers(j,2))<20
                 a=i;
                 centers(j,1)=(centers(i,1)+centers(j,1))/2;
                 centers(j,2)=(centers(i,2)+centers(j,2))/2;
             end
         end
     end
end
centers=[centers(1:a-1,1:2);centers(a+1:length(centers),1:2)];
radii=[radii(1:a-1,1);radii(a+1:length(radii),1)];
end
output = centers;
if u>0
 figure(2), imshow(I,[]);
 hold on;
 plot(output(:,1),output(:,2),'ro');
 hold off;
end
%     for i = 1:length(output)
%         ptlabel = ['note ', num2str(i)];
%         text(output,ptlabel) 
%     end
xy = output;
end