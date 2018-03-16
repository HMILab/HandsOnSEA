function [data,flag]=serread(s)
%This function helps read the incoming serial data
%Force sensor data is also transmitted one can decide not to receive it and
%change the code accordingly
head = fread(s,1,'int8');
data(1) =fread(s,1,'int32');  
data(2)=fread(s,1,'int32');
terminator=fread(s,1,'int8');
comfix=0;
if head=='S' && terminator=='E'
    flag=false;
else
    flag=true;
    disp('COM ERROR')
    while(comfix~='E')
        comfix=fread(s,1,'int8');
        disp('COM ERROR FIXED')
    end
end