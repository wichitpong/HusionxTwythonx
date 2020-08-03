%%
%Add location of MatlabLib in your computer.
libPath = 'G:\My Drive\เรียน\year 3\ฝึกงาน\ASL\Git\HusionxTwythonx';           %param
addpath('ipcx')

%Add width and height of the map
w = 150;                                                            %param
h = 100;                                                            %param

figure(1);

%%
%Call map in figure 1
map = Map(w,h);

%%
fus = Fusion(w,h,libPath);
hold on


%% Add Landmark in the following format:
% obj = Landmark(ID,Name,Type,Vertices>>[x1 y1;x2 y2;...))

l1 = Landmark(1,'b1','building',[12 15;13 15;13 17;12 17]);         %param
map.loadLandmark(l1);                                               %param

l2 = Landmark(2,'b2','building',[89 90;90 90;91 92]);               %param
map.loadLandmark(l2);                                               %param

l3 = Landmark(2,'b3','building',[120 90;121 90;122 91]);            %param
map.loadLandmark(l3);                                               %param

jsonencode(map);

Im=imread('Google.jpg');
Imflip = flip(Im ,1);
imshow(Imflip);
axis on
set(gca,'YDir','normal');

%%
period = 0.1; %time per update (sec, one decimal)                   %param
count = period*10*2;
camera = Camera(count);

%Add camera's angle of view and Range:
camera.AOV = 80;                                                    %param
camera.Range = 10;                                                  %param


%Robot calls the added camera.
robot = Robot(camera);

%%            
% xv = linspace(0, w, w*2+1);
% yv = linspace(0, h, h*2+1);
% [X,Y] = meshgrid(xv, yv);
% key = keys(map.LandmarkList);
% for i = 1:length(key)
%     x = (map.LandmarkList(char(key(i))).Vertices(:,1))';
%     y = (map.LandmarkList(char(key(i))).Vertices(:,2))';
%     z = zeros(1,length(x));
%     
%     Z = griddata(x,y,z,X,Y);
%     Z(isnan(Z)) = 1;
%     Likelihood = Z;
%     BotFusion(fus,Likelihood);
% end


%%
test = Simulator(map,fus,robot);