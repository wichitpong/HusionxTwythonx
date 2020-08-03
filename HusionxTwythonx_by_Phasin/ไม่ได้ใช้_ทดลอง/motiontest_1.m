function pong
         
    set( gcf, ...
        'WindowKeyPressFcn',  @keyboard_down, ...
        'WindowKeyReleaseFcn', @keyboard_up, ...
        'CloseRequestFcn', @close_window, ...
        'MenuBar', 'none', ...
        'NumberTitle', 'off');
    
    set( gca, ...
        'color', 'white', ...
        'xlim', [-100, 100], ...
        'ylim', [-100, 100], ...
        'position', [0, 0, 1, 1]);
  
    %tiangle = plot([-4*cosd(75) 0 4*cosd(75)],[4*sind(75) 0 4*sind(75)]);
    tiangle = line([-8*cosd(75) 0 8*cosd(75)],[8*sind(75) 0 8*sind(75)],'color', 'red', 'linewidth', 2);      
    ball = line('color', 'blue',  'marker', '.', 'markersize', 60);
    
    
    ball_pos = [0, 0];
    ball_vel = [0, 0];
    %ball = plot(ball_pos(1), ball_pos(2),'o');
   
    
    block = line([0 0],[2 10],'color', 'green', 'linewidth', 20);
    set(block,'XData', [ 5, 5], ...
                  'YData', [ -10, 10]);
              
    block2 = line([-10 -10],[9 10],'color', 'green', 'linewidth', 10);
    set(block2,'XData', [ -15, 15], ...
                  'YData', [ -20, -20]);
              
    block3 = line([-10 -10],[9 10],'color', 'green', 'linewidth', 10);
    set(block3,'XData', [ -15, -15], ...
                  'YData', [ -20, 20]);
    
    program_on = 1;
    
    while program_on
        pause(.01);
        ball_pos  = ball_pos  + ball_vel;
        set(ball, 'XData', ball_pos(1), 'YData', ball_pos(2));
    end
    
    delete(gcf);
    
    function keyboard_down(~, event)
        switch event.Key
            case 'leftarrow', 
                if ball_pos(1) < -80;  
                    ball_vel(1) = 0;
                else
                    ball_vel(1) = -.5;
                    set( tiangle,'XData', [ball_pos(1)-8*cosd(15) ball_pos(1) ball_pos(1)-8*cosd(15)], 'YData', [ball_pos(2)+8*sind(15) ball_pos(2) ball_pos(2)-8*sind(15)]);
                end
            case 'rightarrow', 

                if ball_pos(1) > 80  
                    ball_vel(1) = 0;
                else
                    ball_vel(1) =  .5;
                    set( tiangle,'XData', [ball_pos(1)+8*cosd(15) ball_pos(1) ball_pos(1)+8*cosd(15)], 'YData', [ball_pos(2)+8*sind(15) ball_pos(2) ball_pos(2)-8*sind(15)]);
                end
            case 'downarrow', 
                if ball_pos(2) < -80;  
                    ball_vel(2) = 0;
                else
                    ball_vel(2) = -.5;
                    set( tiangle,'XData', [ball_pos(1)-8*cosd(75) ball_pos(1) ball_pos(1)+8*cosd(75)], 'YData', [ball_pos(2)-8*sind(75) ball_pos(2) ball_pos(2)-8*sind(75)]);
                end
            case 'uparrow',   
                if ball_pos(2) > 80;  
                    ball_vel(2) = 0;
                else
                    ball_vel(2) = .5;
                    set( tiangle,'XData', [ball_pos(1)-8*cosd(75) ball_pos(1) ball_pos(1)+8*cosd(75)], 'YData', [ball_pos(2)+8*sind(75) ball_pos(2) ball_pos(2)+8*sind(75)]);
                end
               
        end
    end
    function keyboard_up(~, ~)
        ball_vel = [0,0];
    end

    function close_window(~,~)
        program_on = 0;
    end
end
