classdef Robot < handle
    % create and control robot in this class
    
    properties
        Velocity = 0                %meter/second                         
        Position = [0 0]            
        Angle = 0                   %degree
        Xlim
        Ylim
        BotFus 
        Sensor                      %type of sensor
        Object = [50 50]

    end
    
    methods 
        function obj = Robot(s)
            obj.Sensor = s;
        end
        
        function runRobot(obj)
            disp("Start Ros engine")
            rosinit
            % Robot setup
            xv = linspace(0, obj.Xlim, obj.Xlim*2+1);
            yv = linspace(0, obj.Ylim, obj.Ylim*2+1);
            [X,Y] = meshgrid(xv, yv);
            
            figure(1)
            
            plot(obj.Object(1),obj.Object(2),'marker','square','linewidth', 2);
            gcf;
            set(gcf,'WindowKeyPressFcn',  @keyboard_down,'CloseRequestFcn', @close_window, 'WindowKeyReleaseFcn', @keyboard_up)
            robot = line(obj.Position(1), obj.Position(2),1.1,'marker','o','linewidth', 2);
            hold(gca,'on')

%             OL = 0;
            
            
           
 
%% set up ipcx
            global count1 count2 ssc twitMsg
            global x1 x2 x3 y1 y2 y3 d1 d2 d3
            
            ssc = obj.Sensor.Count;
            count1 = 0;
            count2 = 0;
            sub = rossubscriber('twitupdate',@twitSub);
            sub2 = rossubscriber('updateSensor',@update);
            %ipc.subscribe2('updateSensor',@update);
            %ipc.subscribe2('twitupdate',@twitSub);
%% Callback function update sensor 
            
            function update(src,msg)
                %disp(msg.Data)
                
                [x1,x2,x3,y1,y2,y3,d1,d2,d3] = move();
                count1 = count1 + 1;
                count2 = count2 + 1;
                % Sensor response
                if d1 <= 0 && d2 <= 0 && d3 <= 0
                    res = 1;
                else
                    res = 0;
                end
                
                if count1 == ssc
                    sensorDetection(x1,x2,x3,y1,y2,y3,res);
                    count1 = 0;
                end
                 pause(0.05)
            end
%% Callback function twit track            
            function twitSub(src,msg)
 
                twitMsg= msg.Data;
                tempTwit = jsondecode(twitMsg);
                timeStamp = tempTwit.timeStamp;
                temp = tempTwit.location
                D = temp(1);
                xl_in = [temp(2) temp(3)];
                obj.BotFus.updateFusion(D,xl_in);


            end
%% other function
            %
            % robot controller
            function close_window(~,~)

                delete(gcf); %Delete current figure after exit the loop.
                rosshutdown
            end
            
            function keyboard_down(~,event)
                switch event.Key
                 	case 'downarrow'
                    	obj.Velocity = -1;
                        [x1,x2,x3,y1,y2,y3,d1,d2,d3] = move();
                  	case 'uparrow'
                       	obj.Velocity = 1;
                        [x1,x2,x3,y1,y2,y3,d1,d2,d3] = move();
                    case 'escape'
                        delete(gcf); %Delete current figure after exit the loop.
                        rosshutdown
                        
                    case 'space'
                        pause(0.5)
                        obj.BotFus.updateFusion;
                    case 'leftarrow'
                        obj.Angle = obj.Angle + 6;
                        [x1,x2,x3,y1,y2,y3,d1,d2,d3] = move();
                    case 'rightarrow'
                        obj.Angle = obj.Angle - 6;
                        [x1,x2,x3,y1,y2,y3,d1,d2,d3] = move();
                    
                        
                    otherwise
                        disp('unknown key');
                end
            end
            
            function keyboard_up(~,~)
                obj.Velocity = 0;
            end
            
            function [a,b,c,d,e,f,g,h,i] = move(~)
                % Store robot data in Loop for updating during the simulation.
                userdataStore = [obj.Velocity obj.Angle obj.Position];                   
                vel = [userdataStore(1)*cosd(userdataStore(2)),userdataStore(1)*sind(userdataStore(2))];
                pos = userdataStore(3:4);
                
                % Calculat robot's new position
                new_position = pos + vel;

                % Limit robot operating area
                if (new_position(1) > obj.Xlim || new_position(2) > obj.Ylim || new_position(1) < 0 || new_position(2) < 0)
                    new_position = pos;
                end

                % update position
                obj.Position = new_position; 

                x1 = new_position(1);
                x2 = new_position(1)+obj.Sensor.Range*cosd(userdataStore(2))+obj.Sensor.Range*tand(obj.Sensor.AOV/2)*cosd(90-userdataStore(2));
                x3 = new_position(1)+obj.Sensor.Range*cosd(userdataStore(2))-obj.Sensor.Range*tand(obj.Sensor.AOV/2)*cosd(90-userdataStore(2));
                y1 = new_position(2);
                y2 = new_position(2)+obj.Sensor.Range*sind(userdataStore(2))-obj.Sensor.Range*tand(obj.Sensor.AOV/2)*sind(90-userdataStore(2));
                y3 = new_position(2)+obj.Sensor.Range*sind(userdataStore(2))+obj.Sensor.Range*tand(obj.Sensor.AOV/2)*sind(90-userdataStore(2));

                % Detection
                v1 = [y2-y1 -x2+x1];
                v2 = [y3-y2 -x3+x2];
                v3 = [y1-y3 -x1+x3];

                v11 = [obj.Object(1)-x1 obj.Object(2)-y1];
                v22 = [obj.Object(1)-x2 obj.Object(2)-y2];
                v33 = [obj.Object(1)-x3 obj.Object(2)-y3];

                d1 = dot(v1,v11);
                d2 = dot(v2,v22);
                d3 = dot(v3,v33);

                % Add camera information by using robot information 
                obj.Sensor.Xcam = x1;
                obj.Sensor.Ycam = y1;
                obj.Sensor.Theta= obj.Angle;
                set(robot, 'XData', x1, 'YData', y1,'ZData',1.1);

                %Update camera (Set new triangle)
                set(obj.Sensor.Orient,'XData',[x1 x2 x3 x1],...
                                      'YData',[y1 y2 y3 y1],...
                                      'ZData',[1.1 1.1 1.1 1.1])
                                  
                % Robot path               
                line(x1, y1,1.1,'marker','.','linewidth', 1,'Color','magenta'); %to plot purple dot every step robot take during the simulation
                hold on
                
                a = x1;
                b = x2;
                c = x3;
                d = y1;
                e = y2;
                f = y3;
                g = d1;
                h = d2;
                i = d3;
            end
            
            function sensorDetection(x1,x2,x3,y1,y2,y3,c)
                if c == 0
                    x = [x1 x2 x3];
                    y = [y1 y2 y3];
                    z = [0.1 1 1];
                    
                    Z = griddata(x,y,z,X,Y,'cubic');
                    Z(isnan(Z)) = 1;
                    Likelihood = Z;
                    BotFusion(obj.BotFus,Likelihood);
                elseif c == 1
                    x = [x1 x2 x3];
                    y = [y1 y2 y3];
                    z = [0.9 0.9 0.9];
                    
                    Z = griddata(x,y,z,X,Y,'cubic');
                    Z(isnan(Z)) = 0;
                    Likelihood = Z;
                    BotFusion(obj.BotFus,Likelihood);
                end
            end
        end
    end
end

          