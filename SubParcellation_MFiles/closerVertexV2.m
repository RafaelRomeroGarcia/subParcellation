function closeVertex=closerVertexV2(subject,hemi)
[coor, faceInflated]=read_surf([subject 'surf/' hemi '.inflated']);
num=size(coor);
cuartil=1;
dist1=3.5;
dist2=2;
dist1=2.75
dist2=1.5
dist1=1
dist2=0.5

trozos=floor(num(1)/1);
primero=1+(cuartil-1)*trozos;
if (cuartil==8),
     ultimo=num(1);
else ultimo=(cuartil*trozos);
end
for i=1:num(1),
    coor(i,4)=i;    
end

coor=sortrows(coor,1);
salto=9999999;
coorAux=[];
long=ultimo-primero+1;
arrayVecinos=zeros(long,1);
arrayVecinos_2=zeros(long,1);
for i=primero:ultimo,
    i
    indice=i-primero+1;
    numVecinos=1;
    x=coor(i,1);
    y=coor(i,2);
    z=coor(i,3);
    arrayVecinos(indice,numVecinos)=coor(i,4);
    if i<=salto, desde=1;else desde=i-salto; end
    if desde+salto>num(1), hasta=num(1); else hasta=desde+salto; end
    coorAux=coor(desde:hasta,:);
    coorAux=sortrows(coorAux,2);
    coorAuxPos=coorAux(1:hasta-desde,:);
    n=size(coorAuxPos,1);
    coorAuxDif=abs(repmat([x y z],n,1)-coorAuxPos(:,1:3));
    xd=coorAuxDif(:,1);
    yd=coorAuxDif(:,2);
    zd=coorAuxDif(:,3);
    xd1=xd<repmat(dist1,n,1);
    xd2=xd<repmat(dist2,n,1);
    yd1=yd<repmat(dist1,n,1);
    yd2=yd<repmat(dist2,n,1);
    zd1=zd<repmat(dist1,n,1);
    zd2=zd<repmat(dist2,n,1);
    %break2=coorAuxPos(:,2)<dist1;
    cond1=xd2 .* yd1 .* zd1;
    cond2=xd1 .* yd2 .* zd1;
    cond3=xd1 .* yd1 .* zd2;
    cond=cond1+cond2+cond3;
%    cond=cond.*break2;
    numVecinos_2=1+sum(cond>0);
    arrayVecinos_2(indice,1)=coor(i,4);
    posVecinos=find(cond);
    if size(arrayVecinos_2,2)<posVecinos
        arrayVecinos_2(end,numVecinos_2)=0;
    end
    arrayVecinos_2(indice,2:numVecinos_2)=coorAux(posVecinos,4);
    
    %{
    for j=1:hasta-desde,
       x2=coorAux(j,1);
       y2=coorAux(j,2);
       z2=coorAux(j,3);
       if(abs(x-x2)<dist2 && abs(y-y2)<dist1 && abs(z-z2)<dist1)   || (abs(x-x2)<dist1 && abs(y-y2)<dist2 && abs(z-z2)<dist1) || (abs(x-x2)<dist1 && abs(y-y2)<dist1 && abs(z-z2)<dist2),
           numVecinos=numVecinos+1;
           arrayVecinos(indice,numVecinos)=coorAux(j,4);
       elseif y2>y+dist1, break;
       end
    end
    sum(sum(abs(arrayVecinos-arrayVecinos_2)))
    sum(abs(numVecinos-numVecinos_2))
    %}
end
arrayVecinos=arrayVecinos_2;
closeVertex=sortrows(arrayVecinos);
%savename=['/root/trabajo/',salida];
%save(savename, 'vecinos');
%save(salida,'vecinos');
return;
end