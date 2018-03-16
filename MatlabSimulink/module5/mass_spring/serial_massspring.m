% Running this file opens the virtual mass spring system simulator
%---------------------------------------------------
%----------Serial port Initialization---------------
function serial_massspring()
o=instrfindall;
delete(o);

serialPort = 'COM2';
s = serial(serialPort);
initserial(s)

box_wid=40;
psamp=16;

[handle, vbox, title, spring] = ms_init(psamp);

while 1
    % Gathering data 
    if s.BytesAvailable
        x = fread(s,2,'int32');
        y = fread(s,3,'int32');
    end
    x1=-double(x(1))/20-100;
    x2=-double(x(2))/20;
    %pause(0.001)
    %Update the figure 
%     handle.Position=[x1 2 box_wid 1];
%     vbox.Position=[x2 2 box_wid 1];"
%     in=linspace(x2+box_wid/2,x1+box_wid/2,psamp+1);
%     spring.XData=in;
    ms_update(x1, x2, psamp, box_wid, handle, vbox, spring);
end

fclose(s)
delete(s)
clear s

end


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
function [handle, vbox, title, spring] = ms_init(psamp)%, box_wid)
figure
axis([-300 300 1 4])
handle=rectangle('Position',[-50 2 1 1],'FaceColor','b');
hold on
vbox=rectangle('Position',[0 2 1 1],'FaceColor','r');
title=text(-100,4.1,'Mass Spring Damper Rendering Experiment');
in=0:psamp;
spring=plot(in*1/100,2.5+sin(in*pi/2)/2,'k');
end
function ms_update(x1, x2, psamp, box_wid, handle, vbox, spring)
    handle.Position=[x1 2 box_wid 1];
    vbox.Position=[x2 2 box_wid 1];
    in=linspace(x2+box_wid/2,x1+box_wid/2,psamp+1);
    spring.XData=in;
    drawnow
end