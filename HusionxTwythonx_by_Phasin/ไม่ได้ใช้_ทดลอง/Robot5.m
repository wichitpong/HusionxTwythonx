classdef Robot5<handle
    properties
          velocity = 0;                         
          position = [0 0];
          angle=0;

    end
    methods
        function Runn(obj)
             set( gcf,'WindowKeyPressFcn',  @keyboard_down,'CloseRequestFcn', @close_window, 'WindowKeyReleaseFcn', @keyboard_up)
%              set( gca,'color', 'white','xlim', [-100, 100],'ylim', [-100, 100])
             robot=line(obj.position(1), obj.position(2),'marker','o');            
             orient=line(obj.position(1)+2*cos(obj.angle),obj.position(2)+2*sin(obj.angle),'marker','o','color','red');
             
              program_on = 1;
     
              while program_on
                  
                userdataStore=[obj.velocity obj.angle obj.position];
                pause(.01);
                
                vel = [userdataStore(1)*cos(userdataStore(2)),userdataStore(1)*sin(userdataStore(2))];
                pos = userdataStore(3:4);
                new_position = pos + vel;
                if (abs(new_position(1)) > 100 || abs(new_position(2)) > 100)
                    new_position = pos;
                end
                obj.position = new_position;
                set(robot, 'XData', new_position(1), 'YData', new_position(2));
                set(orient,'XData', new_position(1)+2*cos(userdataStore(2)), 'YData', new_position(2)+2*sin(userdataStore(2)));
             end
             delete(gcf);
              
             function close_window(~,~)
                program_on = 0;
             end
             
             function keyboard_down(~, event)
                switch event.Key
                    case 'downarrow'
                        obj.velocity = -0.2;
                    case 'uparrow'
                        obj.velocity = 0.2;    
                    case 'leftarrow'
                        obj.angle = obj.angle + pi/24;
                    case 'rightarrow'
                        obj.angle = obj.angle - pi/24;
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