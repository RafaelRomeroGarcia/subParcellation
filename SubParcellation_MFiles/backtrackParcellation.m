function backtrackParcellation(subject,surface,closeVertex,hemi)
path_area= [subject 'surf/'  hemi '.white.avg.area.mgh'];
if not(exist(path_area))
    path_area= [subject 'surf/'  hemi '.area'];
     [vol, M]=read_curv(path_area);
else
   
    [vol, M, mr_parms, volsz]=load_mgh(path_area);
end
path_annot=[subject 'label/' hemi '.aparc.annot'];
path_new_annot=[subject 'label/' hemi '.' int2str(surface) '.aparc.annot'];
path_surf=[subject 'surf/' hemi '.white'];
path_surf_inflated=[subject 'surf/' hemi '.inflated'];

[vertCoorxInflated, faceInflated]=read_surf(path_surf_inflated);    
[vertCoorxInflated, faceInflated]=read_surf(path_surf_inflated);
[vertCoorx, face]=read_surf(path_surf);
vertCoorx=vertCoorxInflated;
[vertices, label, colortable]=read_annotation(path_annot);
metodoBordeRegion=[];
metodoSemillaRegion=[];
profundidad=5;
distancia=1;
antLabel=label;
numParcellacionTotal=0;
semillas=[];
numVertTotal=size(label);
areaTotal=0;
labelList=colortable.table(:,5);
numVertTotal=numVertTotal(1);
newColorTable=colortable;
numLabels=size(labelList);
numLabels=numLabels(1);
Newlabel=label; 
ultimoIndice=1;
indRegion=0;
colorUsado=0;
numSemilla=0;
sumas=[];
fin=0;
numVerticesPorRegion=25000;
vertexRegion35=zeros(1,numVerticesPorRegion);
excepciones=[];
numExcepciones=1;
label(find(label==0))=newColorTable.table(1,5);


for i=1:numLabels,
    display Region:;
    conexa=1;
    display (i);
    numLabel=labelList(i);
    vertexRegion=extractRegion(numLabel,label);
    if isempty(vertexRegion)
        colorUsado=colorUsado+1;
        newColorTable.struct_names(ultimoIndice)=colortable.struct_names(i);
        newColorTable=calculateNewColorTable(newColorTable,ultimoIndice,1);
        ultimoIndice=ultimoIndice+1;
    else
    num=size(vertexRegion);
    tam=numVerticesPorRegion-num(2);
    arrayAux=zeros(tam,1);
    total=[vertexRegion arrayAux'];
    vertexRegion35(i,:)=total;
    coordAnt=0;
    semilla=numVecinos(vertCoorx,vertexRegion,closeVertex,label,numSemilla);
    colorRegion=colortable.table(i,5);
    [coordAnt,vertexRegion]=sortVertexs(vertCoorx,vertexRegion,semilla,coordAnt);
    indRegion=indRegion+1;
    semillas(indRegion)=semilla;
    numVertexRegion=size(vertexRegion);
    areaTotalRegion=0;
    numVertexRegion=numVertexRegion(2);
    for k=1:numVertexRegion
          indexVertex=vertexRegion(k);
          areaTotalRegion= areaTotalRegion + vol(indexVertex);
    end
        
    if (areaTotalRegion/surface)<0.5,
            entra=false;
    else    entra=true; %Cambiar
    end
    colorUsado=colorUsado+1;
    colortable.struct_names(i)
    if entra && (not (strcmp(colortable.struct_names(i),'unknown') || strcmp(colortable.struct_names(i),'corpuscallosum') || strcmp(colortable.struct_names(i),'Corpus_callosum') || strcmp(colortable.struct_names(i),'corpuscallosum') || strcmp(colortable.struct_names(i),'Unknown'))),  
            vertexRegionAlmacenada=vertexRegion;
            areaTotal=areaTotal+areaTotalRegion;
            %Hay que repartir el área
            numParcelacionesRegion=max(1,areaTotalRegion/surface);
            ProporcionSobra=numParcelacionesRegion-floor(numParcelacionesRegion);
            areaTotalRegionTruncada=areaTotalRegion-ProporcionSobra*areaTotalRegion;
            numParcelacionesRegion=floor(numParcelacionesRegion);
    
            %Comprobar si hay que poner un trozo más
       %if (not(numParcelacionesRegion==1)),     %%%QUIZAS SE DEBA QUITAR
            if ProporcionSobra<0.5,
                areaSobra=areaTotalRegion-(numParcelacionesRegion*surface);
                areaFinalRegion=surface + areaSobra/numParcelacionesRegion;
            else
                numParcelacionesRegion=numParcelacionesRegion +1;
                areaSobra=(numParcelacionesRegion*surface)-areaTotalRegion;
                areaFinalRegion=surface - areaSobra/numParcelacionesRegion;
            end
            areaADividirRegion=surface+ ProporcionSobra;

      % else areaFinalRegion=areaTotalRegion;  QUITADO
      %      areaADividirRegion=areaTotalRegion;
      % end
            numParcellacionTotal=numParcelacionesRegion + numParcellacionTotal;
            aux=areaFinalRegion*numParcelacionesRegion;
            numVertexReg=size(vertexRegion);
            
            suma=0;
            newColorTable=calculateNewColorTable(newColorTable,ultimoIndice,numParcelacionesRegion);
            ultimoIndice=ultimoIndice+numParcelacionesRegion;    
            numVertexReg=numVertexReg(2);
            vertexRegAux=vertexRegion;
            numVertexRegAux=size(vertexRegAux);
            numVertexRegAux=numVertexRegAux(2);
            j=1;
            %%%%%%%%%%
            labelSeguro=label;
            indRegionSeguro=indRegion;
            colorUsadoSeguro=colorUsado;
            vertexRegAuxSeguro=vertexRegAux;
            %%%%%%%%%
            
            %%%%%
            while j<=numVertexRegAux,
                Vertex=vertexRegAux(j);
                suma=suma+vol(Vertex);
                if(suma>areaFinalRegion || j==numVertexRegAux),
                    sumas(colorUsado,1)=suma;
                    suma=0;
                    label(Vertex)=colorUsado;
                    vertexRegAux= vertexRegAux(j+1:1:numVertexRegAux);
                    numVertexRegAux=size(vertexRegAux);
                    numVertexRegAux=numVertexRegAux(2);
                    seccionRestante=numVertexRegAux;
                    if (not(0==numVertexRegAux)),
                    indRegion=indRegion+1;
                    colorUsado=colorUsado+1;
                    vertexRegionConexa=vertexRegAux;
                    tamVertRegion=size(vertexRegionConexa);
                    if (tamVertRegion>0),
                       [label conexa]=jointRegion(vertexRegionConexa,closeVertex,label);
                       %conexa=1;
                       if (conexa==0) 
                             label=labelSeguro;
                            indRegion=indRegionSeguro;
                            colorUsado=colorUsadoSeguro;
                            vertexRegAux=vertexRegAuxSeguro;
                            numSemilla=numSemilla+1;
                        else
                            labelSeguro=label;
                            indRegionSeguro=indRegion;
                            colorUsadoSeguro=colorUsado;
                            vertexRegAuxSeguro=vertexRegAux;
                            numSemilla=0;
                        end
                    end
                    semilla=numVecinos(vertCoorx,vertexRegAux,closeVertex,label,numSemilla);
                    semillas(indRegion)=semilla;
                    [coordAnt,vertexRegAux]=sortVertexs(vertCoorx,vertexRegAux,semilla,coordAnt);
                    numVertexRegAux=size(vertexRegAux);
                    numVertexRegAux=numVertexRegAux(2);
                    j=0;
                    end
                else     
                    label(Vertex)=colorUsado;
                end   
            j=j+1;
            end
            %%%
            %end
            %%%
    else
        %Casos especiales
        newColorTable.struct_names(ultimoIndice)=colortable.struct_names(i);
        newColorTable=calculateNewColorTable(newColorTable,ultimoIndice,1);
        
        numVertexRegion=size(vertexRegion);
        for l=1:numVertexRegion(2),
            label(vertexRegion(l))=colorUsado;
        end
        ultimoIndice=ultimoIndice+1;
        
    end
    end
   
end
newColorTable.numEntries=ultimoIndice-1;
newColorTable=recalculateColors(newColorTable,excepciones);
newLabel=cambiarLabel(newColorTable,label);
Write_Brain_Annotation(path_new_annot,vertices, newLabel, newColorTable);
Write_Brain_Annotation([subject 'label/' hemi '.new.aparc.annot'],vertices, newLabel, newColorTable);
end

