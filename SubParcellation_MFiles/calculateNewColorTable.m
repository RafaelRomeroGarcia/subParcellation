function newColorTable=calculateNewColorTable(colorTable,numlabel,numParcelaciones)
    tablaNombres=colorTable.struct_names;
    newColorTable=colorTable;
    salidaNombresAnt=tablaNombres(1:numlabel-1,1);
    salidaNombresMedAnt='';
    for i=1:numParcelaciones,
       salidaNombresMed=strcat(tablaNombres(numlabel),'_part',int2str(i));
       salidaNombresMedAnt=[salidaNombresMedAnt;salidaNombresMed];
    end
    salidaNombresPos=tablaNombres(numlabel+1:size(tablaNombres));
    newColorTable.struct_names=[salidaNombresAnt;salidaNombresMedAnt;salidaNombresPos];
    return;
end