function out=gsigmoidmodified(in)
[N,M] = size(in);
for m = 1:M
    for n = 1:N
    out(n,m)=(1+exp(-in(n,m))).^-1;
    end
end
end