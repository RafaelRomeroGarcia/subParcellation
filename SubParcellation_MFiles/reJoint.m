function [result label]=reJoint(vertexRegion,vecinos,label,vertexDentro,vertCoor)
       if size(vertexDentro,2)>size(vertexRegion,2)/2
           vertexOut= setdiff(vertexRegion,vertexDentro);
       else
           vertexOutAux= setdiff(vertexRegion,vertexDentro);
           vertexOut=vertexDentro;
           vertexDentro=vertexOutAux;
       end
       vertexDentroVecinos=vecinos(vertexDentro,:);
       nvd1=size(vertexDentroVecinos,1);
       nvd2=size(vertexDentroVecinos,2);
       labelGrande=label(vertexRegion(1));
       for vd1=1:nvd1
           for vd2=1:nvd2
               if not(vertexDentroVecinos(vd1,vd2)==0)
                vertexDentroVecinosLabel(vd1,vd2)=label(vertexDentroVecinos(vd1,vd2));
               end
           end
       end
       labelPos=vertexDentroVecinos(vertexDentroVecinos>0);
       vecinosGrande= unique(label(labelPos));
       numPeq=size(vertexOut,2);
       rnVertex=1;
       centroidx=median(vertCoor(vertexRegion,1));
       centroidy=median(vertCoor(vertexRegion,2));
       centroidz=median(vertCoor(vertexRegion,3));
       %centroidy=
       while numPeq>0 && rnVertex<=numPeq
          vertexOutInd=vertexOut(rnVertex);
          vecinosPerm=vecinos(vertexOutInd,:);
          labelPeq=vecinosPerm(vecinosPerm>0);
          vecinosPeq= unique(label(labelPeq));
          vecinosPeq=setdiff(vecinosPeq,labelGrande);
          vecinosCoin=intersect(vecinosPeq,vecinosGrande);
          rnVertex=1+rnVertex;
          if not(isempty(vecinosCoin))
              newLabelPeq=vecinosCoin(1); %LABEL DEL INTERMEDIO
              [c1 c2 c3]=find(vertexDentroVecinosLabel==newLabelPeq);
              verticesGrande=find(vertexDentroVecinosLabel==newLabelPeq); %Vertices de la region grande con un vecino Comun a pequeño
              numCand=size(c1,1);
              verticeGrandeCambiarCandidato=[];
              
              coorCandx=vertCoor(vertexDentroVecinos(verticesGrande),1);
              coorCandy=vertCoor(vertexDentroVecinos(verticesGrande),2);
              coorCandz=vertCoor(vertexDentroVecinos(verticesGrande),3);
     
              numCand=size(coorCandx,1);
              centroidxList=repmat(centroidx,numCand,1);
              centroidyList=repmat(centroidy,numCand,1);
              centroidzList=repmat(centroidz,numCand,1);
              
              centroidxDif=power(centroidxList-coorCandx,2);
              centroidyDif=power(centroidyList-coorCandy,2);
              centroidzDif=power(centroidzList-coorCandz,2);
              
              centroidDif=centroidxDif+centroidyDif+centroidzDif;
              [minimo vertexCercano]=min(centroidDif);
              verticeGrandeCambiar=vertexDentroVecinos(verticesGrande(vertexCercano));
              
              label(verticeGrandeCambiar)=labelGrande;
              label(vertexOutInd)=newLabelPeq;
              vertexOut=setdiff(vertexOut,vertexOutInd);
              numPeq=size(vertexOut,2);
              rnVertex=1;
          end
         
       end
       if numPeq>0
          result=false;
       else
          result=true;
       end
    end
    
