RefAmpvec=10:10:30;
for RefAmp=RefAmpvec
str=['BW_' num2str(RefAmp) '_' num2str(Bias) '.mat'];
load(str)
semilogx(0.5:0.5:trcount/2,20*log(vgain),'linewidth',2);
hold on, grid on
end
axis([0,20,-20,20])
bx=xlabel('Frequency [Hz]');
set(bx,'FontName','Times New Roman','FontSize',14);
by=ylabel('Gain [dB]');
set(by,'FontName','Times New Roman','FontSize',14);


legend([num2str(RefAmpvec(1)),'r/s'],[num2str(RefAmpvec(2)),'r/s'],[num2str(RefAmpvec(3)),'r/s']);
%legend([str(1),'N'],[str(2),'N'],[str(3),'N']);