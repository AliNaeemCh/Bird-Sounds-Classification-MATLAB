function input=quantizeit(input,resolution)
 if ~exist('resolution','var')
      resolution = getresolution;     %Default Resolution
 end
input=input/resolution ;
input = round(input);     %rounds to the nearest integer value
input = input * resolution;
end