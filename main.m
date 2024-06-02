%frameit(*audio vector,*framesize,*framestep)
%createmelfilterbanks(*TotalMelbands)
%You can display the DFT plot of any signal using function: displaydft(*signal,Fs,plotype,resolution)
%You can visualize the Mel Filter Banks using function: vismelbanks(*melfilterbanks vector)
%You can visualize the Log Power Spectrogram using function: vislogpowerspect(*logpowerspect vector vector,freq linearity)
%You can visualize the MFCCs Spectrogram using function: dispmfccspect(*mfccs vector)
%You can visulalize desired frames MFCC values using function: dispmfccs(*birdaudio struct, *desired frames vector)
%You can compare MFCC values of different birds and their multiple audio...
%files in subplot by using function: mfccmp(*birdaudio struct, *Birds to compare, Total no. frames to compare)  
%You can contrast MFCC values of different birds in a single figure by using function:
%contrastmfccs(*birdaudio struct, Birds to compare)  
%You can contrast Spectral Centroid Values of different birds in a single figure by using function:
%dispspectcent(*birdaudio struct, Birds to compare)
%You can display Spectral Centroid Bar Graph of all birds on a single figure using function: spectcentcmp(*birdaudio)
%You can display ZCR values of all birds on a single figure using function: zcrcmp(*birdaudio)
%You can display Spectral Roll-off Bar Graph of all birds on a single figure using function: srocmp(*birdaudio)
%You can display desired Audio files Feature Vectors in a single figure by using function: 
%dispfv(*birdaudio struct, *featurevector, *Audio file number(s))
%You can contrast Feature Vector of different birds in a single figure by using function:
%contrastfv(*birdaudio struct, *feature vector, birds to compare)  
%You can train the classifer using function: trainersigmoid(*featurevector)
%You can test the classifer using function: testclassifier(*featurevector)
clear all
clc

%Parameters%
settotalmelfilterbanks(10);
setfirstmfcc(2);           %First MFCC Value would be MFCC 2
setlastmfcc(10);           %Last MFCC Value would be MFCC 10
settotalmfccs(getlastmfcc-getfirstmfcc+1);
settotaldelmfccs(gettotalmfccs-1);
setframesize(512);         %With Fs=16000, the duration of 1 frame (of 512 samples) is 32ms
setframestep(384);         %frame size of 512 and frame step of 384 means overlapping of 128 samples (8ms) (25% Overlapping)
settotalbirds(9);                   %Total Bird Species = 8 + 1 is the Noise Data
setFs(16000)                        %Sampling Frequency = 16kHz 
settotalfeatures(20);
setresolution(getFs/getframesize);  %DFT Default Resolution = 31.25Hz (Where DFT points = Frame Length = 512)
setamplitudescale(1);
set_total_audios_per_bird(10);
load('theta')
settheta(theta);
setbirdnames({'Montezuma Oropendola';'Koel';'Cuckoo';'Rook';'Nightjar';'Bullfinch';'Grey go-away-bird';'Barn Owl';'No Class'}); %Bird Names in strict sequence
% birdpictures={imread('Montezuma Oropendola.png');imread('Koel.png');imread('Cuckoo.png');imread('Rook.png');imread('Nightjar.png');
%     imread('Bullfinch.png');imread('grey gab.png');imread('Barnowl.png')};

%Parameters%

setmelfilterbanks(createmelfilterbanks(gettotalmelfilterbanks));
namevar=0;
for i=1:gettotalbirds*get_total_audios_per_bird
    if i<=10
        birdaudio(i).filename=['MOropendola ',num2str(i-namevar),'.wav'];    %birdaudio(1:10) area Montezuma Oropendola audios
    elseif i>10&&i<=20
        birdaudio(i).filename=['Koel ',num2str(i-namevar),'.wav'];           %birdaudio(11:20) are Koel audios
    elseif i>20&&i<=30
        birdaudio(i).filename=['Cuckoo ',num2str(i-namevar),'.wav'];         %birdaudio(21:30) are Cuckoo audios
    elseif i>30&&i<=40 
        birdaudio(i).filename=['Rook ',num2str(i-namevar),'.wav'];           %birdaudio(31:40) are Rook audios
    elseif i>40&&i<=50
        birdaudio(i).filename=['Nightjar ',num2str(i-namevar),'.wav'];       %birdaudio(41:50) are Nightjar audios
    elseif i>50&&i<=60
        birdaudio(i).filename=['Bullfinch ',num2str(i-namevar),'.wav'];      %birdaudio(51:60) are Bullfinch audios
    elseif i>60&&i<=70
        birdaudio(i).filename=['GreyGAB ',num2str(i-namevar),'.wav'];        %birdaudio(61:70) are Grey g-away-bird audios
    elseif i>70&&i<=80
        birdaudio(i).filename=['Barnowl ',num2str(i-namevar),'.wav'];        %birdaudio(71:80) are Barnowl audios
    elseif i>80&&i<=90
        birdaudio(i).filename=['NoClass ',num2str(i-namevar),'.wav'];        %birdaudio(81:90) are No Class audios
    end
    if rem(i,get_total_audios_per_bird)==0
        namevar=namevar+get_total_audios_per_bird;
    end
    birdaudio(i).info=audioinfo(birdaudio(i).filename);
    birdaudio(i).inputaudio=getamplitudescale*audioread(birdaudio(i).filename);
    birdaudio(i).inputaudio=birdaudio(i).inputaudio/max(abs(birdaudio(i).inputaudio));
    birdaudio(i).audio=conditionit(birdaudio(i).inputaudio,birdaudio(i).info);
    birdaudio(i).frames=frameit(birdaudio(i).audio,getframesize,getframestep);
    [birdaudio(i).windowed,birdaudio(i).totalwframes]=selectframes(window(birdaudio(i).frames));
    birdaudio(i).zcr=computezcr(birdaudio(i).windowed);
    for j=1:birdaudio(i).totalwframes
        birdaudio(i).framesdft(j,:)=dft(birdaudio(i).windowed(j,:));
    end
    birdaudio(i).logpowerspect=computelogpowerspect(getmelfilterbanks,birdaudio(i).framesdft);
    birdaudio(i).mfccs=computemfccs(birdaudio(i).logpowerspect);
    birdaudio(i).spectralcentroid=computespectralcentroid(birdaudio(i));
    birdaudio(i).sro=computesro(birdaudio(i).framesdft);
end
featurevector=genfv(birdaudio);
featurevectornorm=normalizeit(featurevector);