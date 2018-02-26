function newColorTable=calculateNewColorTable(colorTable,numlabel,ultimoIndice,numParcelaciones)
    tablaNombres=colorTable.struct_names;
    newColorTable=colorTable;
    tablaColores=colorTable.table;
    numlabel=numlabel+ultimoIndice;
    salidaNombresAnt=tablaNombres(1:numlabel-1);
    salidaNombresMedAnt='';
    salidaColoresAnt=tablaColores(1:numlabel-1);
    salidaColoresMedAnt='';
    for i=1:numParcelaciones,
       salidaNombresMed=strcat(tablaNombres(numlabel),'_part',int2str(i));
       salidaNombresMedAnt=[salidaNombresMedAnt;salidaNombresMed];
    end
    salidaNombresPos=tablaNombres(numlabel+1:size(tablaNombres));
    %salidaNombresPos=tablaNombres(numlabel+1:size(tablaNombres));
    newColorTable.struct_names=[salidaNombresAnt;salidaNombresMedAnt;salidaNombresPos];
    return;
end