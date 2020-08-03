%========================================================================================
 set( gca,'color', 'white','xlim', [-20, 20],'ylim', [-20, 20])
% 
pos = [-1 10]; 
angle = 195;
robot=line(pos(1), pos(2),'marker','o');
hold on


% x = [pos(1) pos(1)+10 pos(1)+10];
% y = [pos(2) pos(2)-7 pos(2)+7];
x = [pos(1) pos(1)+10*cosd(angle)+10*tand(35)*cosd(90-angle) pos(1)+10*cosd(angle)-10*tand(35)*cosd(90-angle)];
y = [pos(2) pos(2)+10*sind(angle)-10*tand(35)*sind(90-angle) pos(2)+10*sind(angle)+10*tand(35)*sind(90-angle)];
z = [100 0 0];
%z = x.^2+y.^2;
%plot3(x,y,z)

xv = linspace(min(x), max(x), 1000);
yv = linspace(min(y), max(y), 1000);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);
%figure(1)
orient=surf(X, Y, Z);
grid off
set(gca, 'ZLim',[0 500])
shading interp
colormap(jet(80))
view(2)
hold on

%set(orient, 'XData',[0 10 10], 'YData', [0 -7 7],'ZData',[100 0 0]);
%delete(orient)

% x = [0 1 10];
% y = [0 -7 7];
% z = x.^2+y.^2;
% 
% xv = linspace(min(x), max(x), 100);
% yv = linspace(min(y), max(y), 100);
% [X,Y] = meshgrid(xv, yv);
% Z = griddata(x,y,z,X,Y);
% gcf
% surf(X, Y, Z);
% grid off
% set(gca, 'ZLim',[0 500])
% shading interp
% colormap(jet(80))
% view(2)
