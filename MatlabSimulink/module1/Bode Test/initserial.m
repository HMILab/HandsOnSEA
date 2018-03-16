function initserial(s)
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

head = fread(s,1,'int8');
a=['Head= ', head];
disp(a)
while(head~='S')
    disp('NO SIR')
    head = fread(s,1,'int8');
    a=['Head= ', head];
    disp(a)
end
disp('YES SIR')
end