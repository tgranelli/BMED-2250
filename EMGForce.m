function forceOut = EMGtoForce(file)
fh = fopen(file, 'r'); %assuming our input is a textfile of times and voltages like the file in the google drive
line = fgetl(fh);
AParr = []; %Vector of all the times an action potential was counted
while ischar(line)
    ind = strfind(line, ' ');
    timeCoord = str2num(line(1:ind)); %Gets the time from the line
    EPval = str2num(line(ind+1:end)); %Gets the Voltage value from the line
    if EPval < -.005
        AParr = [AParr, timeCoord]; %if the voltage exceeds the threshold, the time gets added to the vector
    end
    line = fgetl(fh);
    %continuously goes through the EMG data txt file
end

NMUf = 1; %We have to substitute this with the actual amount of force an NMU exerts
NMUq = length(AParr); %Number of total action potentials reached, can convert this to NMUs
forceOut = NMUf*NMUq % # of NMUs multiplied by individual force of 1 NMU = Magnitude* of Total Force

fclose(fh) %Hypothetically this code could work, we could add multiple input files to address different
           %EMG electrodes on different muscles. Thus we could obtain magnitude of force in multiple directions and orientations
           
end

