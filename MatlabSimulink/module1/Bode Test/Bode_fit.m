%trcount=4;
beg=1;
vgain=zeros(trcount,1);
for i=1:trcount
    %figure(i)
    beg=200*(i-1)+1;
    interv=beg+50:beg+200-1;
    plot(t_all(interv),v_all(interv))
    cfun=fit(t_all(interv), v_all(interv)-Bias, 'sin1');
    coefs=coeffvalues(cfun);
    hold on
    plot(t_all(interv),coefs(1)*sin(coefs(2)*t_all(interv)+coefs(3))+Bias,'r')
    vgain(i)=coefs(1)/RefAmp;
end

plot(vgain)

figure(trcount+1)
b1=semilogx(0.5:0.5:trcount/2,20*log(vgain));
hold on, grid on
set(b1,'linewidth',2);
axis([0,20,-20,20])
bx=xlabel('Frequency [Hz]');
set(bx,'FontName','Times New Roman','FontSize',14);
by=ylabel('Gain [dB]');
set(by,'FontName','Times New Roman','FontSize',14);


str=['BW_' num2str(RefAmp) '_' num2str(Bias) '.mat'];
save(str,'t_all','v_all','vgain')
