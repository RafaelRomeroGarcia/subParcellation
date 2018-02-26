function [coor cooraux]=numVecinos(coorVertex,vertexRegion,vecinos,newLabel,numSemilla)
coor=[];
num=size(vertexRegion);
num=num(2);
colorVertex=-1;
coloresVecinos=[];

for i=1:num,
    vertice=vertexRegion(i);
    verticesVecinos=vecinos(vertice,:);  
    colorVecinos=coloreaVecinos(verticesVecinos,newLabel);
    coloresVecinos(i,1)=colorVecinos;
    coloresVecinos(i,2)=vertice;
    
    if(colorVecinos>colorVertex),
        colorVertex=colorVecinos;
        Vertex=vertice;
    end
end
coloresVecinos=sortrows(coloresVecinos,1);
coor=coloresVecinos(num-numSemilla,2);
%coor=Vertex;
return;
end