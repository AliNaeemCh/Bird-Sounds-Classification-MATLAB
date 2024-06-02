%This function computes DCT-II
function X=computedct(x,firstcoeff,lastcoeff)
N=length(x);            
X=zeros(1,lastcoeff-firstcoeff+1);
Ndouble=2*N;
for i=firstcoeff:lastcoeff     
    for j=0:N-1
        X(i-firstcoeff+1)=X(i-firstcoeff+1)+x(j+1)*cos( (pi*i*(2*j+1))/Ndouble );
    end
    X(i-firstcoeff+1)=2*X(i-firstcoeff+1);
end