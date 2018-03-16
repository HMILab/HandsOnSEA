pwmset
%Initialization of Parameters
model='velocity_sin';
load_system(model)
%This application is for first calibrating motor and then retrieving the
%velocity bandwidth of it

trtime=4;
trcount=24;
s_t=0.02;   %sample_period
s_f=1/s_t;     %sample_frequency
t_to_run=trtime*trcount;
% RefAmp=5;            %reference amplitude used
Bias=0;%-1.5*RefAmp;

% Initial Velocity Controller Params
Kp=8;
Ki=40;
%RefAmpvec=15:5:25;
RefAmpvec=15;
for RefAmp=RefAmpvec
    %% Setting parameters of the Simulink model
    ref_add=[ model '/' 'velocity reference/Increasing Frequency/'];
    set_param([ref_add 'trial length'],'Value',num2str(trtime));
    set_param([ref_add 'Amplitude'],'Value', num2str(RefAmp));
    set_param([ref_add 'Bias'],'Value', num2str(Bias));
    set_param([ref_add 'Total time'],'const', num2str(t_to_run));
    set_param([model '/velocity reference/Mode Select'],'Value' ,'2')
    set_param([model '/Velocity Controller/KpKi Communication/Kp SH'],'initCond' ,num2str(Kp))
    set_param([model '/Velocity Controller/KpKi Communication/Ki SH'],'initCond' ,num2str(Ki))
    %set_param('If needed for the communications','commented','on')
    %% Build Model
    slbuild(model)
    disp('Model Deployed')
    %% Collect and Simulate
    v_bode
    Bode_fit
end
% graphall