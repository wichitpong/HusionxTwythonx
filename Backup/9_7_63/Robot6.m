classdef Robot6<handle
    properties
          velocity = 0;                         
          position = [0 0];
          angle = 0;
          xl
          yl
          Hu
          sensor
    end
    methods 
        function Runn(obj)
             gcf
             set( gcf,'WindowKeyPressFcn',  @keyboard_down,'CloseRequestFcn', @close_window, 'WindowKeyReleaseFcn', @keyboard_up)
%            set( gca,'color', 'white','xlim', [0, 100],'ylim', [0, 100])
             robot=line(obj.position(1), obj.position(2),100,'marker','o','linewidth', 2);
             hold(gca,'on')
             
             obj.sensor.cam
             
%              orient = surf([],[],[]) ;
%              grid off 
%                 shading interp
%                 colormap(jet(50))
%                 view(2).
%             orient=line([obj.position(1) obj.position(1)+10*cosd(obj.angle)+10*tand(35)*cosd(90-obj.angle) obj.position(1)+10*cosd(obj.angle)-10*tand(35)*cosd(90-obj.angle) obj.position(1)]...
%                 ,[obj.position(2) obj.position(2)+10*sind(obj.angle)-10*tand(35)*sind(90-obj.angle) obj.position(2)+10*sind(obj.angle)+10*tand(35)*sind(90-obj.angle) obj.position(2)],...
%                 [100 100 100 100],'color', 'green', 'linewidth', 2);
              program_on = 1;
     
              while program_on         
                userdataStore=[obj.velocity obj.angle obj.position];
                %pause(0.001);
                
                vel = [userdataStore(1)*cosd(userdataStore(2)),userdataStore(1)*sind(userdataStore(2))];
                pos = userdataStore(3:4);
                new_position = pos + vel;
                if (new_position(1) > obj.xl || new_position(2) > obj.yl || new_position(1) < 0 || new_position(2) < 0)
                    new_position = pos;
                end
                obj.position = new_position;
                obj.sensor.Xcam = obj.position(1);
                obj.sensor.Ycam = obj.position(2);
                obj.sensor.theta=obj.angle;
                set(robot, 'XData', new_position(1), 'YData', new_position(2),'ZData',100);
                set(obj.sensor.orient,'XData',[new_position(1) new_position(1)+obj.sensor.Detection_range*cosd(userdataStore(2))+obj.sensor.Detection_range*tand(obj.sensor.Angle_of_view)*cosd(90-userdataStore(2)) new_position(1)+obj.sensor.Detection_range*cosd(userdataStore(2))-obj.sensor.Detection_range*tand(obj.sensor.Angle_of_view)*cosd(90-userdataStore(2)) new_position(1)],...
                                   'YData',[new_position(2) new_position(2)+obj.sensor.Detection_range*sind(userdataStore(2))-obj.sensor.Detection_range*tand(obj.sensor.Angle_of_view)*sind(90-userdataStore(2)) new_position(2)+obj.sensor.Detection_range*sind(userdataStore(2))+obj.sensor.Detection_range*tand(obj.sensor.Angle_of_view)*sind(90-userdataStore(2)) new_position(2)],...
                                   'ZData',[100 100 100 100])
%                 x=[new_position(1) new_position(1)+10*cosd(userdataStore(2))+10*tand(35)*cosd(90-userdataStore(2)) new_position(1)+10*cosd(userdataStore(2))-10*tand(35)*cosd(90-userdataStore(2))];
%                 y=[new_position(2) new_position(2)+10*sind(userdataStore(2))-10*tand(35)*sind(90-userdataStore(2)) new_position(2)+10*sind(userdataStore(2))+10*tand(35)*sind(90-userdataStore(2))];
%                 z=[100 0 0];
%                 xv = linspace(min(x), max(x), 100);
%                 yv = linspace(min(y), max(y), 100);
%                 [X,Y] = meshgrid(xv, yv);
%                 Z = griddata(x,y,z,X,Y);
%                 figure(2)
%                 set(orient,'XData',X,'YData',Y,'ZData',Z)
%                 drawnow
                pause(0.1)

                
               
        
              end
             delete(gcf);
              
             function close_window(~,~)
                program_on = 0;
             end
             
             function keyboard_down(~, event)
                switch event.Key
                    case 'downarrow'
                        obj.velocity = -1;
                    case 'uparrow'
                        obj.velocity = 1;   
                    case 'space'
                        pause(0.5)
                        obj.Hu.addD
                    case 'leftarrow'
                        obj.angle = obj.angle + 6;
                    case 'rightarrow'
                        obj.angle = obj.angle - 6;
                    otherwise
                        disp('unknown key');
                end
             end
             
            function keyboard_up(~,~)
                obj.velocity = 0;
            end
            
        end
        
    end
end

%============================

          