function [w,b]=trainerunit(featurevector,labelvector)
totalfeatures=size(featurevector,2);
totaltrainingexamples=length(labelvector);
alpha=0.5;
b=0.01;
w=randn(1,totalfeatures);
cost=0;
for i=1:totaltrainingexamples
cost=cost+(labelvector(i)-g(featurevector(i,:)*transpose(w)+b))^2;
end
costex=cost;
repetition=0;
while cost>0
    if cost>costex
        alpha=-0.5*alpha;
    end
    if cost==costex
        repetition=repetition+1;
    end
    if repetition>10
        alpha=0.5;
        w=randn(1,totalfeatures);
        b=0.01;
        repetition=0;
    end
    diffw=zeros(1,totalfeatures);
    diffb=0;
    diffbflag=true;
    for j=1:totalfeatures
           for i=1:totaltrainingexamples
           diffw(j)=diffw(j)+(labelvector(i)-g(featurevector(i,:)*transpose(w)+b))*(-featurevector(i,j));
           if diffbflag==true
                diffb=diffb+(labelvector(i)-g(featurevector(i,:)*transpose(w)+b));
           end
           end
           diffbflag=false;
           diffw(j)=diffw(j)/totalfeatures;
           w(j)=w(j)+alpha*diffw(j);
    end
    diffb=diffb/totalfeatures;
    b=b+alpha*diffb;
    costex=cost;
    cost=0;
    for i=1:totaltrainingexamples
    cost=cost+(labelvector(i)-g(featurevector(i,:)*transpose(w)+b))^2;
    end
end
end