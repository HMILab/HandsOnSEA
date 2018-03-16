HostFile='Host_handson.slx';
open(HostFile)
msgbox('Please use the Host_handson model file to view data after the model is built.')
pwmset
ModelName='backdriveable';
slbuild(ModelName)