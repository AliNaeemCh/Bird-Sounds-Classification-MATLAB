function appendfiles(filename,totalfiles,Fs,separation_duration)
separation=zeros(separation_duration*Fs,1);
out=[];
for i=1:totalfiles
    file=[filename,' ',num2str(i),'.wav'];
    x=audioread(file);
    out=[out;x;separation];
end
audiowrite([filename,' Appended.wav'],out,Fs);
end