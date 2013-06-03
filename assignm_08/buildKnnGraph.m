function A = buildKnnGraph(X,k)

[IDX,D]  =  knnsearch(X,X,'K',k+1); % find k+1 nearest neighbor. The first nearest neighbor is the point itself 

n = size(X,1);

A = sparse(n,n);
% Fill the adjacency matrix
for i=1:n
    A(i,IDX(i,:))=D(i,:);
    A(IDX(i,:),i)=D(i,:);
end

A(1:n+1:end) = 0; %set diagonal to zero