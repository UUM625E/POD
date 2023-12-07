function [A,phi,Uavg,nbasis,Upod,ModEnergy]=PODeig(U)
%****************************************************************12/24/2019
%               AeroMDO LAB-Sihmehmet Yildiz 
% Proper Orhogonal Decomposition for Reduced Order Modeling
%           
%**************************************************************************
% U: Snapshot Matrix : The column of U represent different analysis results
%                      The row of U represent analysis results
%
%
%
%
%**************************************************************************
% U=input('Please enter the snapshot matrix in the appropriate format');

%Nt is number of snapshot, Ni is POD basis number
[Ni,Nt]=size(U);

%Calculation the mean matrix of snapshots
Uavg=repmat(mean(U,1),Ni,1);

%Obtain new snapshot ensamble with zero mean
Unew=U-Uavg;

%Calculation of correlation matrix 
C=(Unew*Unew')/(Nt-1);

% Calculation eigenvalues and eigenvectors of C matrix
[V,L] = eig(C,'vector');

%sorting eigenvalues from bigger to smaller
[lambda,ilam] = sort(L,'descend');

%eigenvectors edit according to eigenvalues
phi = V(:, ilam);  

%Calculation of dominant mods
tenergy=sum(lambda);
energy=0;
i=0;
cenergy=99.9;
 while((energy/tenergy)*100<cenergy) 
    i=i+1;
    energy=energy+lambda(i);
 end
 
 nbasis=i;
 
 ModEnergy=(lambda/tenergy);
 figure()
 plot((lambda/tenergy)*100,'*-');
 xlabel('Number of Eigenvalue');
 ylabel('Energy of Eigenvalues (%)');grid on
 
 %POD coefficient
%  A=(phi(:,1:nbasis))'*U;
 A=phi'*Unew;
 
 fprintf('Number of necessary basis to represent model %d',nbasis);
 fprintf('\nPOD coefficient');%A
 
 
 Uf=phi*A+Uavg;
 Upod=phi(:,1:nbasis)*A(1:nbasis,:)+Uavg;
end