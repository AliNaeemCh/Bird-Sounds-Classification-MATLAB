for i=1:10
    filename=['Human ',num2str(i),'.wav'];
    x=audioread(filename);
    y=audioinfo(filename);
    z=resample(x(:,1),16000,y.SampleRate);
    audiowrite(filename,z,16000);
end