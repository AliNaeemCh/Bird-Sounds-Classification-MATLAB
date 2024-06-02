function write1darray(array,array_name,address,precision,size_definition)
fileId = fopen(address,'w');
length_array=length(array);
if ~exist('size_definition','var')
        fprintf(fileId,['float ',array_name,'[',num2str(length_array),']= {\n']);
else
        fprintf(fileId,['float ',array_name,'[',size_definition,']= {\n']);
end
for i=1:length_array
    fprintf(fileId,['%.',num2str(precision),'f'],array(i));
    if i~=length_array
        fprintf(fileId,',\n');
    end
end
fprintf(fileId,'};');
fclose(fileId);
end