function s=s_open(str)
%Opens the serial port
o=instrfindall;
delete(o)
%------------------------------------------
serialPort = str;
s = serial(serialPort);
s.Baudrate=115200;
s.StopBits=1;
%s.Header='S';
%s.Terminator='E';
s.Parity='none';
s.FlowControl='none';
if (s.Status == 'closed')
    disp('hi')
    s.BytesAvailableFcnMode = 'byte';
    s.BytesAvailableFcnCount = 200;
    %s.BytesAvailableFcn = @Serial_OnDataReceived;
    
    fopen(s);
end
end