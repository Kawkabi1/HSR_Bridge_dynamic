function[maxAcc]=ExtractMaxAcceleration(outputFile, timeOffset)  
    % Open the specified output data file for reading  
    fileId = fopen([outputFile '.dat'], 'r');  
    % Initialize an array to store maximum acceleration values  
    maxAccValues = [];  

    % Read the first line (header) of the file  
    currentLine = fgetl(fileId);  
    
    % Loop through the file until the end  
    while ~feof(fileId)  
        % Read the next line from the file  
        currentLine = fgetl(fileId);  
        
        % Check if the line length is greater than 8 characters  
        if (length(currentLine)) > 8  
            % Check for 'MAXIMUM' entries in the line  
            if strcmp(currentLine(1:8), ' MAXIMUM') == 1  
                % Extract the acceleration value and add it to the array  
                maxAccValues = [maxAccValues; sscanf(currentLine, '%*s %f')];  
            % Check for 'MINIMUM' entries in the line (if applicable)  
            elseif strcmp(currentLine(1:8), ' MINIMUM') == 1  
                % Extract the acceleration value and add it to the array  
                maxAccValues = [maxAccValues; sscanf(currentLine, '%*s %f')];  
            end  
        end  
    end  

    % Create a datum array filled with the provided time offset value  
    datumArray = ones(length(maxAccValues), 1) .* timeOffset;  
    % Calculate the absolute values of the maximum acceleration  
    maxAccAbs = abs(maxAccValues);  
    % Get the maximum absolute acceleration value  
    maxAcc = max(maxAccAbs);  

    % Close all open files  
    fclose('all');  
end