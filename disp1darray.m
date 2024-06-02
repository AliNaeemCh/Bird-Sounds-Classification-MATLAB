function disp1darray(array,precision)
for i=1:length(array)
    fprintf(['%.',num2str(precision),'f'],array(i))
    if i~=length(array)
        fprintf(',')
    end
    disp(' ')
end