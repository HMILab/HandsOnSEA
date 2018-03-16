%% Initializations
pwmset
model='mass_spring';
visual='serial_massspring';
%% Deploy Model
slbuild(model)
disp(['Model ' model ' is deployed'])
%% Open visual simulation
run([visual '.m'])