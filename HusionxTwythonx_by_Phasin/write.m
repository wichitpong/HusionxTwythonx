fileID = fopen('map.json','w');
x = jsonencode(map);
fprintf(fileID,x);
fclose(fileID);

while 1
    fileID = fopen('test.txt','a');
    x = [2 randi([10 100],1,2)];
%     x = input('[value of D [location]] :');
%     if x == 's'
%         break
%     end
    fprintf(fileID,'%f %f %f\n',x);
    disp(x)
    fclose(fileID);
    pause(7)
end