function disp2darray(array,precision)
format long
[row,col]=size(array);
for i=1:row
    disp(' ')
    disp('{')
    for j=1:col
        fprintf(['%.',num2str(precision),'f'],array(i,j))
        if(j~=col)
            fprintf(',')
        end
    end
    fprintf('},')     
end
end