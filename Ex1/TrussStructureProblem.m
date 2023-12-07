%****************************************************************
%   Computational Fluid and Solid Mechanics - K.J. Bathe
%                 Example 3.4 Truss Structure
%****************************************************************

cnt=0;
ElasM=linspace(125000,200000,4);
Area=linspace(6,12,4);
for ii=1:4
for jj=1:4
    E=ElasM(ii);
    A=Area(jj);
    cnt=cnt+1;
    truss_str;
    U(:,cnt)=d;
end
end

%E=125000, A=6 ==> U(:,1)
%E=150000, A=6 ==> U(:,2)
%E=175000, A=6 ==> U(:,3)
%E=200000, A=6 ==> U(:,4)
%E=125000, A=8 ==> U(:,5)
%E=150000, A=8 ==> U(:,6) ...

[Upod]=PODeig(U);
