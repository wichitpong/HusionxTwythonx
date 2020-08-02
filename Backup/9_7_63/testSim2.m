%==============================Create Sim variable=================
test1=Sim2;

%=======================open map (Call Map)==========================
test1.openmap;
test1.pos;
hold on
%====================================Landmark=========================
figure(2)
% l1 = Landmark;
% l1.Id = 1;
% l1.Name = 'b1';
% l1.Type = 'building';
% l1.Vertices = [12 32;42 23;23 54;21 42];

% l1.Vertices =[12 42 23 21;32 23 54 42;10 10 10 10];
% fill3(l1.Vertices(1,:),l1.Vertices(2,:),l1.Vertices(3,:),'w')
% hold on

l2 = Landmark;
l2.Id = 2;
l2.Name = 'b2';
l2.Type = 'building';
%l2.Vertices = [89 69;76 98;37 97];
l2.Vertices = [89 76 37 89;69 98 97 69;10 10 10 10];
fill3(l2.Vertices(1,:),l2.Vertices(2,:),l2.Vertices(3,:),'w')
%area(l2.Vertices(1,:),l2.Vertices(2,:),'Facecolor','w')

% test1.mapp.addlandmark(l1);
% test1.mapp.addlandmark(l2);

% L1=Landmark
% L1.addinfo;
% 
% L2=Landmark
% L2.addinfo;
% 
% test1.plotlandmark(L1);
% test1.plotlandmark(L2);

%==============================Run Simulator (CallRobot)===========
c = Camera;
c.Angle_of_view = 25;
c.Detection_range = 20;

Run(test1,c);