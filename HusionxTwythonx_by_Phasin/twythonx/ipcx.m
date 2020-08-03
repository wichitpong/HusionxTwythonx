classdef ipcx < handle
    properties (Access = public)
        msg = "";
        topic = "";
        pub = "";
        sub = "";
    end
    
    
    methods (Access = public)
        
        function on(obj)
            rosinit
        end
        
        function off(obj)
            rosshutdown
        end
        
        function publish(obj,topic)
            pub = rospublisher(topic,"std_msgs/String");
            obj.msg = rosmessage(pub);
            obj.topic =topic;
            obj.pub = pub;
        end
        function send(obj,msg)
            obj.msg.Data = msg;
            send(obj.pub,obj.msg)
        end
      
        function sub = subscribe(obj,topic,show)
            
            if nargin == 2
                %default
                sub = rossubscriber(topic, @dispFx);
            elseif nargin == 3
                if show == "on"
                    sub = rossubscriber(topic, @dispFx);
                elseif show == "off"
                    sub = rossubscriber(topic);
                end
            end
            obj.topic =topic;
            obj.sub = sub;
        end
      
       function sub = subscribe2(obj,topic,func)
                
           sub = rossubscriber(topic, func);
           obj.topic =topic;
           obj.sub = sub;
       end
        
       function data = receive(obj)
            data = receive(obj.sub).Data;
       end
      
        
    end
end


function dispFx(src,msg)         
   disp(msg.Data)
end


