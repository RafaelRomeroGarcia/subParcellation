function newColorTable=recalculateColors(colorTable,excepciones)
    newColorTable=colorTable;
    i=1;
    while i<=colorTable.numEntries,
        sal=0;
        if sal,
             newColorTable.table(i,1)=colorTable.table(excepciones(sal,2),1);
             newColorTable.table(i,2)=colorTable.table(excepciones(sal,2),2);
             newColorTable.table(i,3)=colorTable.table(excepciones(sal,2),3);
             newColorTable.table(i,4)=colorTable.table(excepciones(sal,2),4);
             newColorTable.table(i,5)=colorTable.table(excepciones(sal,2),5);
        else
        r=floor(rand*256);
        g=floor(rand*256);
        b=floor(rand*256);
        newColorTable.table(i,1)=r;
        newColorTable.table(i,2)=g;
        newColorTable.table(i,3)=b;
        newColorTable.table(i,4)=0;
        color=r + g*2^8 + b*2^16;
        newColorTable.table(i,5)=color;
        matriz=newColorTable.table(1:i-1,5);
        [r1 r2]=size(matriz(matriz==color));
        if (i>1 && r1>0),
            i=i-1;
        end
        end
        i=1+i;
   end
   return;
end