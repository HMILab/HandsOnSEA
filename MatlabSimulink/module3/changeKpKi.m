o=instrfindall;
delete(o);
%---------------------------------------------------
%----------Serial port Initialization---------------
serialPort = 'COM2';
s = serial(serialPort);
initserial(s)
serwrite(s,2,6)
s_close(s)

