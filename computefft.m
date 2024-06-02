function dft=computefft(input,dftpoints)
radix=2;
inputlength=length(input);
if ~exist('dftpoints','var')
    dftpoints=2^(ceil(log2(inputlength)));
elseif log2(dftpoints)~=fix(log2(dftpoints))
    disp('Illegal DFT Points entered! The DFT points must be the power of 2');
    return
end
if dftpoints<inputlength
    disp('Warning!')
    disp('Results would be wrong since the total DFT Points are less than the input samples');
end
if dftpoints>inputlength
    zerospadding=dftpoints-inputlength;
    for i=1:zerospadding
        input(inputlength+i)=0;
    end
end
stages=log2(dftpoints);
processmatrix=zeros(stages+1,dftpoints);
%The first row of process matrix will contain the sorted input sequence
%The second upto second last row of process matrix will contain the FFT results of intermediate stages
%The last row of process matrix will contain the Output FFT
indices=computefftindices(dftpoints);
for i=1:dftpoints
   processmatrix(1,i)=input(indices(i)+1);    
end
weight=exp(-1i*2*pi/dftpoints);
for i=1:dftpoints/2
    w(1,i)=weight^(i-1);    %First row of w will contain all the powers of weight from 0 to (dftpoints/2 - 1)
    w(2,i)=-w(1,i);         %Second row of w will contain all the negative powers of weight from 0 to (dftpoints/2 - 1)
end
for i=2:stages+1                               
    e=2^(stages-i+1);   %Exponent of w
    maxdistinctwvals=(dftpoints/e)/radix;
    row=1;              %w positive powers will be picked by row=1 and negative powers by row=2;
    jump=2^(i-2);       %This keeps track of necessary gap between the two inputs to compute single sample of DFT
    count=jump;         %This helps to revert the index back to first value following the periodicity of sequences 
    index=1;
    indicator=1;
    k=0;                %k multiplies with e in the power of w
    for j=1:dftpoints
        if count==0
            count=jump;
            if rem(indicator,2)~=0
                index=index-jump;
            else
                index=index+jump;
                k=0;
                row=1;
            end
            indicator=indicator+1;
        end
        if k>=maxdistinctwvals
            k=0;
            row=2;
        end
        processmatrix(i,j)=processmatrix(i-1,index)+w(row,e*k+1)*processmatrix(i-1,index+jump);
        count=count-1;
        index=index+1;
        k=k+1;
    end
end
dft=processmatrix(size(processmatrix,1),:);
end