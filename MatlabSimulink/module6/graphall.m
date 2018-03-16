% RefAmpvec=[1,2,3];
biasvec=-1.5*RefAmpvec;
for i=1:3
%i=3;
RefAmp=RefAmpvec(i);
bias=biasvec(i);
str=['BW_' num2str(RefAmp) '_' num2str(bias) '.mat'];
load(str)
semilogx(0.5:0.5:trcount/2,20*log(vgain),'linewidth',2);
hold on, grid on
%str(i)=[num2str(RefAmpvec(i)), ' N'];
end
axis([0,20,-20,20])
bx=xlabel('Frequency [Hz]');
set(bx,'FontName','Times New Roman','FontSize',14);
by=ylabel('Gain [dB]');
set(by,'FontName','Times New Roman','FontSize',14);


legend([num2str(RefAmpvec(1)),'N'],[num2str(RefAmpvec(2)),'N'],[num2str(RefAmpvec(3)),'N']);
%legend([str(1),'N'],[str(2),'N'],[str(3),'N']);