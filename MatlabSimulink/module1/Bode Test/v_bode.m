%function v_bode( trtime,trcount, s_f)
o=instrfindall;
delete(o);
%---------------------------------------------------
%----------Serial port Initialization---------------
serialPort = 'COM2';
s = serial(serialPort);
initserial(s)
%%Initializations
t=0;
t_to_run=trtime*trcount;
figure(1)
t_all=zeros(t_to_run*s_f+1,1);
v_all=zeros(t_to_run*s_f+1,1);
i=1;
j=1;
k=1;
p1=plot(t_all,v_all,'r');
hold on
p2=plot(t_all,v_all,'b');
beg=1;
tmod=0;
ax_arr=[0 trtime -RefAmp-0.5 RefAmp+0.5];
axis(ax_arr)
%% Plotting
while t<t_to_run
    %for i=1:100
    if s.BytesAvailable
        [data, com_error]=serread(s);
        %disp(x)
        v=double(data(2))/1000;
        t=double(data(1))/1000;
        if t>0
            tmodx=tmod;
            tmod=mod(t,trtime);
            
            if tmod<tmodx
                %clf
                i=i+1;
                k=1;
                beg=(i-1)*trtime*s_f+1;
            end
            %scatter(tmod,vel,'.','r')
            t_all(j)=t;
            v_all(j)=v;
            
            x_data=mod(t_all(beg:beg+k-3),trtime);
            %p1 is retrieved from encoder p2 is the reference
            p1.XData=x_data;
            p1.YData=v_all(beg:beg+k-3);
            p2.XData=mod(t_all(beg:beg+k-3),trtime);
            p2.YData=(Bias+RefAmp*sin(i/2*2*pi*x_data));
            %pause(0.001)
            
            axis(ax_arr);% + trtime*(i-1)*[1 1 0 0]);
            k=k+1;
            j=j+1;
            %hold off
            drawnow
        end
    end
end
display('BYE BYE')
fclose(s)
delete(s)
clear s
