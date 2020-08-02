Im=imread('Googlemap1.jpg');
%  subplot(2,2,4);
%  axes('position',[0,1,0,1]); 
 
%  h1 = axes ;

 Imflip = flip(Im ,1);  

imshow(Imflip);
 axis on
 set(gca,'YDir','normal');