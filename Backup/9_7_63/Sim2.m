classdef Sim2 < handle
    properties
        mapp
        Hu
        robot
    end
    methods
        function openmap(obj)
            obj.mapp = map(100,200);
            figure(2)
            gca
            xlim([0 obj.mapp.width])
            ylim([0 obj.mapp.height])
            hold on
        end

        function Run(obj, value)
            obj.robot = Robot6;
            obj.robot.sensor = value;

            obj.robot.xl = obj.mapp.width;
            obj.robot.yl = obj.mapp.height;
            obj.robot.Hu = obj.Hu;
            obj.robot.Runn
        end
        function pos(obj)
           %run('husion_example.m')
           obj.Hu=husion;
           obj.Hu.addhusion
        end
        function addD(obj)
           obj.Hu.addhusion
        end
    end
 end