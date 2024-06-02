function write2darray(array,array_name,address,precision,size_definition)
fileId = fopen(address,'w');
[row,col]=size(array);
if ~exist('size_definition','var')
        fprintf(fileId,['float ',array_name,'[',num2str(row),'][',num2str(col),']= {']);
else
        fprintf(fileId,['float ',array_name,'[',size_definition{1},'][',size_definition{2},']= {']);
end
for i=1:row
    fprintf(fileId,'\n');
    fprintf(fileId,'{');
    for j=1:col
        fprintf(fileId,['%.',num2str(precision),'f'],array(i,j));
        if(j~=col)
            fprintf(fileId,',');
        end
    end
    if i~=row
        fprintf(fileId,'},');
    else
        fprintf(fileId,'}');
    end
end
fprintf(fileId,'\n};'); 
fclose(fileId);
end