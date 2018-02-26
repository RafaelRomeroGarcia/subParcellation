function etiqueta=cambiarLabel(newColorTable,label)
etiqueta=[]; 
numEtiquetasSinCambiar=0;
for i=1:size(label),
    %PARA QUE NO COJA LAS QUE NO SE HAN TOCADO
    a=label(i);
    if(label(i)<5000),
        
     %QUIZAS HAYA QUE PONER etiqueta(i+numEtiquietasSinCambiar) o table(
     if label(i)==0
         label(i)=1;
     end
        b=newColorTable.table(label(i),5); 
        etiqueta(i)=newColorTable.table(label(i),5);  
    else
        etiqueta(i)=label(i);
        numEtiquetasSinCambiar=numEtiquetasSinCambiar+1;
    end
end
etiqueta=etiqueta';
end