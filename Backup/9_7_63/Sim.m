classdef Sim<handle
    properties
        L  
        L2
    end
    methods
        function openmap(~)
           map1 = map('map_v1.png');
           show(map1.fig)
           hold on
        end
        
        function addlandmarkBeta(obj)
            nn=input('How many landmarks? :'); n=1; obj.L={}; obj.L2=[];
            while n<=nn
                obj.L(n)=cellstr(input('Name :'));
                obj.L=string(obj.L);
                assignin('base',char(obj.L(n)),Landmark);
%                 char(obj.L(n)).addinfo;
                n=n+1;
            end
%             n=1;
%             while n<=nn
%                 obj.L2(n)=char(obj.L(n));
%                 n=n+1;
%             end
        end
        
        function addlandmark(~)
            disp('(Maximum of 4 landmarks)');
            nn=input('How many landmarks? :');
            if nn==1
                a=Landmark;
                a.addinfo;
                a.plotlandmark(a);
            elseif nn==2
                a=Landmark; b=Landmark;
                a.addinfo; b.addinfo;
                a.plotlandmark(a); b.plotlandmark(b);
            elseif nn==3
                a=Landmark; b=Landmark; c=Landmark;
                a.addinfo; b.addinfo; c.addinfo;
                a.plotlandmark(a); b.plotlandmark(b); c.plotlandmark(c)
            elseif nn==4
                a=Landmark; b=Landmark; c=Landmark; d=Landmark;
                a.addinfo; b.addinfo; c.addinfo; d.addinfo;
                a.plotlandmark(a); b.plotlandmark(b);c.plotlandmark(c); d.plotlandmark(d);
            else
                disp('invalid number')
            end
        end
        
        
        function Run(~)
            robott = Robot5;
            robott.Runn
        end
        
    end
            
 end