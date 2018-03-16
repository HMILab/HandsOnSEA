%% Initialize
pwmset
model='virtualwall';
visual='serial_virtualwall';
%% Deploy Model
slbuild(model)
disp(['Model ' model ' is deployed'])
%% Open visual simulation
run([visual '.m'])