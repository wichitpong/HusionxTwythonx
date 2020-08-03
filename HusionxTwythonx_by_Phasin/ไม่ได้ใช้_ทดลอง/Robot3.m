classdef Robot3<handle
    properties
%         f = figure('KeyPressFcn',@figure_KeyPressFcn);
%         size=axes('XLim',[-100 100],'YLim',[-100 100]);
         userdata=[0 0 0 0];
%          velocity = userdata(1:2);                         
%          position = userdata(3:4);
%         robot=line(0, 0,'marker','o');            
%         orient=line(2*cos(0),2*sin(0),'marker','o','color','red');
    end
    methods
        function Run(obj)
             set( gcf,'WindowKeyPressFcn',  @keyboard_down,'CloseRequestFcn', @close_window)
             set( gca,'color', 'white','xlim', [-100, 100],'ylim', [-100, 100])
             position=obj.userdata(3:4);
             robot=line(position(1), position(2),'marker','o');            
             orient=line(position(1)+2*cos(obj.userdata(2)),position(2)+2*sin(obj.userdata(2)),'marker','o','color','red');
             
              program_on = 1;
%     
              while program_on
                 userdataStore=obj.userdata
                  pause(.01);
%                 set(gcf,'color',rand(1,3));
%                 velocity = userdataStore(1:2);                         
%                 position = userdataStore(3:4);
                velocity = [userdataStore(1)*cos(userdataStore(2)),userdataStore(1)*sin(userdataStore(2))];
                position = userdataStore(3:4);
                new_position = position + velocity;
                if (abs(new_position(1)) > 100 | abs(new_position(2)) > 100)
                    new_position = position;
                end
                obj.userdata(3:4) = new_position;
                set(robot, 'XData', new_position(1), 'YData', new_position(2));
                set(orient,'XData', new_position(1)+2*cos(userdataStore(2)), 'YData', new_position(2)+2*sin(userdataStore(2)));
             end
             delete(gcf);
%              
             function close_window(~,~)
                program_on = 0;
             end
             
             function keyboard_down(~, event)
                switch event.Key
                    case 'downarrow'
                        obj.userdata(1) = obj.userdata(1) - 0.1;
                    case 'uparrow'
                        obj.userdata(1) = obj.userdata(1) + 0.1;    
                    case 'leftarrow'
                        obj.userdata(2) = obj.userdata(2) + pi/12;
                    case 'rightarrow'
                        obj.userdata(2) = obj.userdata(2) - pi/12;
                    otherwise
                        disp('unknown key');
                end
             end
            
        end
        
    end
end