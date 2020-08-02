colors = rgbmap('red','blue',N); 
for i=1:N
    square(i)=rectangle('position',[-D_segment(i)/2,z(i),D_segment(i),dz]); 
    set(square(i), 'LineStyle', 'none')
    set(square(i), 'FaceColor', colors(N,:))
 hold on
end