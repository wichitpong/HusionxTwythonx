x = [0 10 10];
y = [0 -7 7];
z = x.^2+y.^2;

xv = linspace(min(x), max(x), 100);
yv = linspace(min(y), max(y), 100);
[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);
figure(2)
surf(X, Y, Z);
grid on
set(gca, 'ZLim',[0 500])
shading interp
colormap(jet(80))
view(2)