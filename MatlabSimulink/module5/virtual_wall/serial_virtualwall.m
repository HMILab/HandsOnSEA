function serial_virtualwall()
o=instrfindall;
delete(o);
% Running this file opens the virtual virtual wall simulator
%---------------------------------------------------
%----------Serial port Initialization---------------
serialPort = 'COM2';
s = serial(serialPort);
initserial(s)
%=====Initializations===============================
wall_wid=10;
box_wid=40;
psamp=64;
lim=120;
[box, qv, wall, t_virt, t_force, spring, in1, t_f]= virtwall_init(wall_wid,psamp,lim);
while 1
% Gathering data  
    if s.BytesAvailable
        x = fread(s,2,'int32');
        y = fread(s,1,'int16');
    end
        x2=double(x(2))/20;
        x1=double(x(1))/1000;%0*1.363*2;
        x3=double(x(1))/10000*1.363*2;
        %pause(0.001) 
        %Update the figure
        virtwall_update(x1, x2, x3, wall_wid, box_wid, psamp, box, wall ,in1, spring, qv, t_f, lim)
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
function [box, qv, wall, t_virt, t_force, spring, in1, t_f] = virtwall_init(wall_wid, psamp, lim)%, box_wid)
Fig=figure;
% screenpos=[-900, 50, 800, 700]; 
% screenpos=[-1920, -175, 1920, 955]; 
% Fig.Position=screenpos;
%Fig.Position(1)=Fig.Position(1)-1500; %if the second screen is being used
axis([-200 200 1 4])
box=rectangle('Position',[0 2 1 1],'FaceColor','y');
hold on
wall=rectangle('Position',[-wall_wid 1 wall_wid 3],'FaceColor','k');
qv=quiver(-100,3.8,1*1.111,0,'LineWidth',6,'AutoScale','off');
qv.ShowArrowHead='off';
%psamp=64;
l1=line([1 2], [2 2],'LineWidth',5);
in=0:psamp;
in1=linspace(-200,-wall_wid,psamp+1);
spring=plot(in*1/100,2.5+sin(in*pi/2)/2);
t_virt=text(-50,4.2,'Virtual Wall Experiment');
t_force=text(-110,3.9,'Force');
t_limit=text(lim,3.8,'|Limit');
t_f=text(-110,3.6,'');
end
function virtwall_update(x1, x2, x3, wall_wid, box_wid, psamp, box, wall ,in1, spring, qv, t_f, lim)
        box.Position=[-x2-box_wid 2 box_wid 1];
        if x2<0
            wall.Position=[-x2 1 wall_wid 3];
            spring.XData=-linspace(-200,x2-wall_wid,psamp+1);
        else
            wall.Position=[0 1 wall_wid 3];
            spring.XData=-in1;
        end
        if x1<0
            qv.Color='r';
        else
            qv.Color='b';
        end
        qv.UData=-x3;
        t_f.String='';%x1;
        if -x3>100+lim
            t_f.String= 'LIMIT REACHED, PLEASE LOWER THE FORCE';
            t_f.FontSize= 20;%+(-x3-lim-100)*0.1;
            t_f.Color='r';
        end
        drawnow
end