% Author: Khaja Wahaajuddin Kawkabi  
% Description: This script runs an ABAQUS simulation for different velocities,   
% generating a DLOAD configuration and reading acceleration results.  

clc;  
clear;  

% Constants  
pst = 0.0226758;  % Constant related to the acceleration readings  
ss = 0;           % Initialize count for successful runs  
DIR = 'C:\Users\Kawkabi\Documents\MATLAB\ABAQUS_MATLAB';  % Directory for data files  

% Loop over a range of velocities from 150 km/h to 160 km/h in increments of 10  
for Velocitykmh = 150:10:450  
    % Convert velocity from km/h to m/s and display the converted value  
    velocity_mps = Velocitykmh * 0.278;  
    disp(velocity_mps);  
    ss = ss + 1;  % Increment successful runs count  

    % DLOAD configuration settings  
    Sub_name = 'DLOAD.for';  % Name of the DLOAD file  
    d0 = 1;                  % Some configuration parameter   
    width = 2.185;          % Width parameter for DLOAD  
    ssp = 24;               % Another configuration parameter  
    FMAT = [];              % Initialize frequency matrix  

    % Get frequency matrix from HSLMA function  
    [FMAT(:, 1), FMAT(:, 2)] = HSLMA(5);  

    % Generate DLOAD file using parameters defined above  
    generateDLOAD(Sub_name, FMAT(:, 2), d0, velocity_mps, ssp, max(FMAT(:, 1)), width);   

    %% Run ABAQUS simulation  
    UseWriteFile = 'Moving_Load160';  % Name for the output file  
    RunAbaqus(UseWriteFile, Sub_name, DIR);  % Execute ABAQUS run  
    
    % Read the acceleration data from the output file  
    a = ExtractMaxAcceleration(UseWriteFile, pst);  
    ACC(ss) = a;  % Store acceleration result in the ACC array  

    % Display completion messages  
    disp('________________');  
    Text1 = sprintf('Run Abaqus Finished Successfully for %d km/h', Velocitykmh);  
    disp(Text1);  
    disp('________________');  
    Text2 = sprintf('Running Abaqus for %d km/h', Velocitykmh + 10);  
    disp(Text2);  
end  

% Plotting the acceleration data  
figure;  % Open a new figure window  
plot(ACC);  
title('Acceleration Data');  % Title for the plot  
xlabel('Run Index');          % X-axis label  
ylabel('Acceleration');       % Y-axis label  
grid on;                     % Add grid lines for better readability