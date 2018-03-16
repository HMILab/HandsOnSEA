o=instrfindall;
delete(o)
%------------------------------------------
serialPort = 'COM2';
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
t=0;
trtime=4;
trcount=18;
s_t=0.02;   %sample_period
s_f=1/s_t;     %sample_frequency
t_to_run=trtime*trcount;
figure(1)
axis([0 trtime -1 1])
t_all=zeros(t_to_run*s_f+1,1);
vel_all=zeros(t_to_run*s_f+1,1);
i=1;
j=1;
k=1;
p1=plot(t_all,vel_all);
hold on 
p2=plot(t_all,vel_all);
beg=1;
tmod=0;
while t<t_to_run
%for i=1:100    
    if s.BytesAvailable
        x = fread(s,2,'int32');
        y = fread(s,1,'int16');
        %disp(x)
        vel=double(x(2))/1000;
        t=double(x(1))/1000;
        tmodx=tmod;
        tmod=mod(t,trtime);
        if tmod<tmodx
        %clf
        i=i+1;
        k=1;
        beg=(i-1)*trtime*s_f+1;
%         hold off
%         figure(i);
        end
        %scatter(tmod,vel,'.','r')
        x_data=mod(t_all(beg:beg+k-2),trtime);
        p1.XData=x_data;
        p1.YData=vel_all(beg:beg+k-2);
        p2.XData=mod(t_all(beg:beg+k-2),trtime);
        p2.YData=sin(i/2*2*pi*x_data);
        %pause(0.001)
        axis([0 4 -1 1])
        t_all(j)=t;
        vel_all(j)=vel;
        j=j+1;
        k=k+1;
        %hold off
        drawnow
    end
end
display('BYE BYE')
fclose(s)
delete(s)
clear s
