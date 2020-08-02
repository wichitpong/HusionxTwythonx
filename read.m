OL = 0;
clear A
while 1
    disp('c')
    fileID = fopen('test.txt','r');
    A = (fscanf(fileID,'%f %f %f',[3 Inf]))';
    L = length(A);
    if L > OL && OL > 0
        for i = OL+1:L
            disp(A(i,:));
        end
    end
    OL = L;
    fclose(fileID);
    pause(1);
end