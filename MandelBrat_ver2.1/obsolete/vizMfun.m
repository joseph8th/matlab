function vizMfun(plotOpt, plotVals, profM)

% Break out profiles for BkW compat
cIn=profM(1).cIn; c=profM(1).c; 
Z_x=profM(1).Zx; z_x=profM(1).zx; 
Z_xSub1=profM(1).ZxSub1; z_xSub1=profM(1).zxSub1;

e=profM(2).c; 
Z_n=profM(2).Zx; z_n=profM(2).zx; 
Z_nSub1=profM(2).ZxSub1; z_nSub1=profM(2).zxSub1;

d=profM(3).c; 
Z_k=profM(3).Zx; z_k=profM(3).zx; 
Z_kSub1=profM(3).ZxSub1; z_kSub1=profM(3).zxSub1;

C = [c,e,d];
Z = [z_x,z_n,z_k]; 
ZSub1 = [z_xSub1,z_nSub1,z_kSub1];
figure(1)
hold on
switch plotOpt
    case 2
        plotMSet(plotVals);
    case 3
        plot(real(cIn),imag(cIn),'k.') 
        plot(real(C),imag(C),'-ro')
    case 4
        plot(real(Z_n),imag(Z_n),'g.')
        plot(real(Z_k),imag(Z_k),'b.')
        plot(real(Z),imag(Z),'-wx')
        plot(real(ZSub1),imag(ZSub1),'-yx')
    case 5
        plotMSet(plotVals);
        plot(real(cIn),imag(cIn),'ko') 
        plot(real(C),imag(C),'-wx')
    case 6
        plot(real(cIn),imag(cIn),'k.')
        plot(real(Z_n),imag(Z_n),'g.')
        plot(real(Z_k),imag(Z_k),'b.') 
        plot(real(C),imag(C),'-ro')
        plot(real(Z),imag(Z),'-wx')
        plot(real(ZSub1),imag(ZSub1),'-yx')
    case 7
        plotMSet(plotVals);
        plot(real(Z_xSub1),imag(Z_xSub1),'bo')
        plot(real(ZSub1),imag(ZSub1),'-yx')
    case 8
        plotMSet(plotVals);
        plot(real(Z_xSub1),imag(Z_xSub1),'yo')
        plot(real(cIn),imag(cIn),'k.')
        plot(real(Z_n),imag(Z_n),'g.')
        plot(real(Z_k),imag(Z_k),'b.') 
        plot(real(C),imag(C),'-ro')
        plot(real(Z),imag(Z),'-wx')
        plot(real(ZSub1),imag(ZSub1),'-yx')
end

    load profileC limits;
    axis([min(limits(1),limits(2)) max(limits(1),limits(2)) ...
          min(limits(3),limits(4)) max(limits(3),limits(4))])
    hold off

return;