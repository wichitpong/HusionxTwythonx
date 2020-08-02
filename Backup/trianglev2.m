x = [0 25 12.5];
y = [0 5 -10];
z = [10 10 10];

xv = linspace(0, 200, 200);
yv = linspace(0, 100, 100);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);
figure(2)
surf(X, Y, Z);
grid on
set(gca, 'ZLim',[0 500])
shading interp
colormap(jet(80))
view(2)