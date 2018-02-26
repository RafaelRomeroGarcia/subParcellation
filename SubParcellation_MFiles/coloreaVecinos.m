function numColores=coloreaVecinos(vertexVecinos,label)
num=size(vertexVecinos);
sal=[];
for i=2:num(2),
    vertice=vertexVecinos(i);
    if(vertice==0),break;end
    color=label(vertice);
    sal(i-1)=color;
end
numColores=size(unique(sal));
numColores=numColores(2);
end