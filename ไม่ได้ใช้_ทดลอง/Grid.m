x = [10 4 16];
y = [10 20 20];
z = [0.9 0.1 0.1];

I = ones(401,801);

xv = linspace(0, 200, 801);
yv = linspace(0, 100, 401);

[X,Y] = meshgrid(xv, yv);
Z = griddata(x,y,z,X,Y);

Z(isnan(Z))=0;
% Z = flip(Z);

Li = I-Z;

% figure(2)
% surf(X, Y, Z);
% grid on
% set(gca, 'ZLim',[-1 2])
% shading interp
% colormap(jet(80))
% view(2)