function  [force]=Force(force,numberElements,elementNodes,LElem,P)
% and force vector
for e=1:numberElements; 
  indice=elementNodes(e,:)   ;       
  elementDof=[ 2*(indice(1)-1)+1 2*(indice(2)-1)...
      2*(indice(2)-1)+1 2*(indice(2)-1)+2]; 
    f1=[P*LElem/2 P*LElem*LElem/12 P*LElem/2 ...
      -P*LElem*LElem/12]';
  
  % equivalent force vector
  force(elementDof)=force(elementDof)+f1;  

end
