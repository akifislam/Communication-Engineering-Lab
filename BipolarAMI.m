close all;
clear all;
clc;

bits = [0 1 0 0 1 0];


bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

index = 1;
sign=-1;

%Modulation
for i = 1:length(time)
    if bits(index) == 0
        modulation(i) = 0;
    else
        modulation(i) = voltage*sign;
    end
    
    if (time(i)*bitrate >= index)
        index = index+1;
        if index <= length(bits) && bits(index) == 1
            sign = -sign;
        end
    end
end

plot(time, modulation);
axis([0 end_time -voltage-2 voltage+2]);
grid on;

index = 1;
% Demodulation
for i = 1:length(modulation)
    if modulation(i) == 0
        demodulation(index) = 0;
    else
        demodulation(index)=1;
    end
    
    if time(i)*bitrate >= index
        index = index+1;
    end
end

disp(demodulation);