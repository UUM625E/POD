clc;clear all;close all;
%*************************************************************************
%       Reduced Order Modelling of High-Fidelity Computational
%   Fluid-Structure Interaction Analysis for Aeroelastic Systems
%                       P?nar Acar, Melike Nikbay 
%*************************************************************************

x=linspace(0,1,21);
t=linspace(0,2,101);
% 10 ==> 20 20==>100
for i=1:21
    for j=1:101
        U(i,j)=(exp(1))^-(abs((x(i)-0.5)*(t(j)-1)))+sin(x(i)*t(j));
    end
end


[A,phi,Uavg,nbasis,UpodUpod,ModEnergy]=PODeig(U);

U_n1=phi(:,1:1)*A(1:1,:)+Uavg;
U_n2=phi(:,1:2)*A(1:2,:)+Uavg;
U_n3=phi(:,1:3)*A(1:3,:)+Uavg;

[X,Y] = meshgrid(0:0.05:1,0:0.02:2);

figure()
subplot(2,2,1)
surf(X,Y,U');shading interp
xlabel('x')
ylabel('t')
title('Analytical Solution')
colormap jet


subplot(2,2,2)
surf(X,Y,U_n1');shading interp
xlabel('x')
ylabel('t')
title('POD Solution (Mode1)')

subplot(2,2,3)
surf(X,Y,U_n2');shading interp
xlabel('x')
ylabel('t')
title('POD Solution (Mode1+Mode2)')

subplot(2,2,4)
plot(ModEnergy*100,'-*');shading interp
title('Energies of Eigenvalues')
xlabel('n. Eigenvalues');ylabel('Energies of Eigenvalues (%)');
grid on
 
% subplot(2,2,4)
% surf(U_n3);shading interp
% title('Mod1+Mod2+Mod3')