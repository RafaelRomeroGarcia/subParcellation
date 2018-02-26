function [Vertex]= extractRegion(numLabel,label)
Vertex=[];
numVert=size(label);
numVert=numVert(1);
j=1;
for i=1:numVert,
   if (label(i)==numLabel),
    Vertex(j)=i;
       j=j+1;
   end
end
return;
