%% Initialize
pwmset
model='explicit_force';
visual='KpKi_change';
%% Deploy Model
slbuild(model)
disp(['Model ' model ' is deployed'])
%% Open visual simulation
msgbox('Please use the Host_handson model file to change the controller values and view data.')
% run([visual '.m'])