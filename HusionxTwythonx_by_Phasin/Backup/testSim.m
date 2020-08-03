%==============================Create Sim variable=================
test1=Sim;

%=======================open map (Call Map)==========================
test1.openmap;


%====================================Landmark=========================
test1.addlandmark;

% L1=Landmark
% L1.addinfo;
% 
% L2=Landmark
% L2.addinfo;
% 
% test1.plotlandmark(L1);
% test1.plotlandmark(L2);

%==============================Run Simulator (CallRobot)===========
test1.Run;