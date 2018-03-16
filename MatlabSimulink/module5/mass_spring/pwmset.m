%This mfile should be ran before running the simulink files

% Processor Frequency
CPU_frequency = 90e6; %(Hz)

% PWM Settings
PWM_frequency = 20e3; %(Hz)
PWM_Counter_Period = CPU_frequency/PWM_frequency/2; %(PWM timer counts)