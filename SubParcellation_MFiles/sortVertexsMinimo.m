function [coorAnt,sortVertRegion]=sortVertexs(vertCoorx,vertexRegion,coorAnt)
sortVert=[];
fin=size(vertexRegion);
minX=99999;
minY=99999;
minZ=99999;
maxX=-9999;
maxY=-9999;
maxZ=-9999;
for i=1:fin(2),
  %
   %sortVert(i,1)=vertex;
   %sortVert(i,2)=vertCoorx(vertex,1)*abs(vertCoorx(vertex,1))+vertCoorx(vertex,2)*abs(vertCoorx(vertex,2))+vertCoorx(vertex,3)*abs(vertCoorx(vertex,3));
   vertex=vertexRegion(i);
   x=vertCoorx(vertex,1);
   y=vertCoorx(vertex,2);
   z=vertCoorx(vertex,3);
   if(x<minX), minXx=x;minXy=y;minXz=z; end
   if(y<minY), minYx=x;minYy=y;minYz=z; end
   if(z<minZ), minZx=y;minZy=y;minZz=z; end
   if(x>maxX), maxX=x; end
   if(y>maxY), maxY=y; end
   if(z>maxZ), maxZ=z; end
   % sortVert(i,2)=vertCoorx(vertex,2);
end
difX=maxX-minXx;
difY=maxY-minYy;
difZ=maxZ-minZz;
    if (coorAnt==1 || difX>difY && difX>difZ),
         if(coorAnt==0),
            coorAnt=1;
         end
         minx=minXx;
         miny=minXy;
         minz=minXz;
    elseif (coorAnt==2 || difY>difX && difY>difZ),
         if(coorAnt==0),
            coorAnt=2;
         end
         minx=minYx;
         miny=minYy;
         minz=minYz;
    else
         if(coorAnt==0),
            coorAnt=3;
         end
         minx=minZx;
         miny=minZy;
         minz=minZz;
    end     
for i=1:fin(2),
      vertex=vertexRegion(i);
      sortVert(i,1)=vertex;
      %sortVert(i,2)=vertCoorx(vertex,coordenada);   
      sortVert(i,2)=power((vertCoorx(vertex,1)-minx),2)+power((vertCoorx(vertex,2)-miny),2)+power((vertCoorx(vertex,3)-minz),2);
end
sortVert=sortrows(sortVert,2);
sortVertRegion=sortVert(:,1);
return;
end