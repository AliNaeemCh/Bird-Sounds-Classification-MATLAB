function out=dropdecimal(in,dplaces)
factor=10^dplaces;
out=fix(in*factor)/factor;
end