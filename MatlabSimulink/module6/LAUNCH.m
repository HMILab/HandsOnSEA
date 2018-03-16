pwmset
%Initialization of Parameters
model='forcesin';
load_system(model)
%This application is for first calibrating motor and then retrieving the
%velocity bandwidth of it

trtime=4;
trcount=24;
s_t=0.02;   %sample_period
s_f=1/s_t;     %sample_frequency
t_to_run=trtime*trcount;
RefAmp=5;            %reference amplitude used
Bias_Amp=-1.5;%-1.5*RefAmp;
Bias=RefAmp*Bias_Amp;

RefAmpvec=[1 2 4];
for RefAmp=RefAmpvec
    %% Setting parameters of the Simulink model
    ref_add=[ model '/' 'force reference/Increasing Frequency/'];
    set_param([ref_add 'trial length'],'Value',num2str(trtime));
    set_param([ref_add 'Amplitude'],'Value', num2str(RefAmp));
    set_param([ref_add 'Bias_Amp'],'Gain', num2str(Bias_Amp));
    set_param([ref_add 'Total time'],'const', num2str(t_to_run));
    %set_param('If needed for the communications','commented','on')
    %% Build Model
    slbuild(model)
    disp('Model Deployed')
    %% Collect and Simulate
    force_bode
    Bode_fit
end
graphall