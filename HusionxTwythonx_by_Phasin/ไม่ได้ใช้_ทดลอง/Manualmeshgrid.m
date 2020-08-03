%========================================================================================
 clc
 clear
xx=800;yy=400;
set( gca,'color', 'white','xlim', [0, xx],'ylim', [0, yy])
% 

pos = [20 20]; 
angle=0;
Range=30;
AOV=60;
robot=line(pos(1), pos(2),'marker','o');
hold on

angle = 90-angle;
x = [pos(1) pos(1)+Range*cosd(angle)+Range*tand(35)*cosd(90-angle) pos(1)+Range*cosd(angle)-Range*tand(35)*cosd(90-angle)];
y = [pos(2) pos(2)+Range*sind(angle)-Range*tand(35)*sind(90-angle) pos(2)+Range*sind(angle)+Range*tand(35)*sind(90-angle)];
 
%z=1-(sqrt((x-pos(1)).^2+(y-pos(2)).^2)/Range)

Z=[]; 
P1=[x(1),y(1)]; P2=[x(2),y(2)];P3=[x(3),y(3)]; 
for i=1:yy+1
    for j=1:xx+1
        P=[i,j];
        P12 = P1-P2; P23 = P2-P3; P31 = P3-P1;
        t = sign(det([P31;P23]))*sign(det([P3-P;P23])) >= 0 & ...
        sign(det([P12;P31]))*sign(det([P1-P;P31])) >= 0 & ...
        sign(det([P23;P12]))*sign(det([P2-P;P12])) >= 0 ;
    
        if t==1;
            z=1-(sqrt((j-pos(1)).^2+(i-pos(2)).^2)/Range)  ;
            if z>=0;
                Z(i,j)=z;
            else
                Z(i,j)=0;
            end
        else t==0;
            Z(i,j)=0;
        end
    end
end
% P1=[x(1),y(1)]; P2=[x(2),y(2)];P3=[x(3),y(3)]; 
% for i=1:xx+1 
%     for j=1:yy+1
%         PP=[i,j];
%         vcheck= f_check_inside_triangle( P1,P2,P3,PP);
%     
%         if vcheck==1;
%             Z(i,j)=1;
%         else vcheck==0;
%             Z(i,j)=0;
%         end
%     end
% end

surf(Z)
grid off
shading interp
colormap(jet(80))

% P1=[0,0]; P2=[10,0];P3=[10,15]; P=[-5,0];
%    P12 = P1-P2; P23 = P2-P3; P31 = P3-P1;
%    t = sign(det([P31;P23]))*sign(det([P3-P;P23])) >= 0 & ...
%        sign(det([P12;P31]))*sign(det([P1-P;P31])) >= 0 & ...
%        sign(det([P23;P12]))*sign(det([P2-P;P12])) >= 0 