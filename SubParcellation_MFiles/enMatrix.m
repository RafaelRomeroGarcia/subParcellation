function sal=enMatrix(A,val)
tam=size(A);
sal=0;
for i=1:tam(2),
   if(A(i)==val),
       sal=i;
       break;
   end
    
end

return;
end