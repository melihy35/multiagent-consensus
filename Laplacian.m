function [L] = Laplacian(matrix)   
D=zeros(6); %initialize of in-degree matrix
for i = 1:6
    D(i,i) =sum(matrix(i,:)); % find in-degree matrix
end 
L= D-matrix; % return graph Laplacian matrix
end