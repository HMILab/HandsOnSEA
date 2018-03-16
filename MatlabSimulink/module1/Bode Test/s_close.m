function s_close(s)
% Closes and deletes the serial port
fclose(s)
delete(s)
clear s
disp('COM closed')
end