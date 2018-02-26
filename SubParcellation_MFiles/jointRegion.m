function [label conexa]=jointRegion(vertexRegion,vecinos,label)
    vertexDentro=[];
    numVertex=1;
    numBolsa=1;
    num=size(vertexRegion);
    vertexInicial=vertexRegion(1);
    vertex=vertexInicial;
    bolsa=[vertex];
    tamBolsa=size(bolsa);
    vertexDentro(numVertex)=vertexInicial;
    numVertex=numVertex+1;
    while tamBolsa(2)>0,
        verticeSemilla=bolsa(1);
        vertexVecinos=vecinos(verticeSemilla,:);
        tam=size(vertexVecinos);
        for i=1:tam(2),
            vertex=vertexVecinos(i);
            if(vertex==0), break;end
            cond1=enMatrix(vertexRegion,vertex);
            cond2=enMatrix(vertexDentro,vertex);
            if (cond1>0 && cond2==0),
                 bolsa=[bolsa vertex];
                 vertexDentro(numVertex)=vertex;
      %          label(vertex)=7;
                 numVertex=numVertex+1;
            end
        end
        tamBolsa=size(bolsa);
        bolsa=bolsa(2:tamBolsa(2));
        tamBolsa=tamBolsa-1;
        
    end
    tam1=size(vertexRegion);
    tam1=tam1(2);
    tam2=size(vertexDentro);
    tam2=tam2(2);
    conexa=(tam1<tam2+15);
    return;
end
