close all;
clear all;
clc;

bits = [0 1 0 0 1 1];


bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

index = 1;

for i = 1:length(time)
    if bits(index) == 1
        modulation(i) = -voltage;
    else
        modulation(i) = voltage;
    end
    
    if (time(i)*bitrate >= (index-bitrate/2))
        modulation(i)= -modulation(i);
    end
    
    if time(i)*bitrate >= index
        index = index+1;
    end
end

plot(time, modulation);
axis([0 end_time -voltage-2 voltage+2]);
grid on;

index = 1;

for i = 1:length(modulation)
    if modulation(i) == -voltage && time(i)*bitrate<(index-bitrate/2)
        demodulation(index) = 1;
    end
    if modulation(i) == voltage && time(i)*bitrate<(index-bitrate/2)
        demodulation(index) = 0;
    end
    
    if time(i)*bitrate >= index
        index = index+1;
    end
end

disp(demodulation);