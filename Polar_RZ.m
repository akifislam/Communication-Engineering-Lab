close all;
clear all;
clc;

bits = [1 0 1 1 0 0 1];


bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

index = 1;

for i = 1:length(time)
    if bits(index) == 1
        modulation(i) = voltage;
    else
        modulation(i) = -voltage;
    end
    
    if (time(i)*bitrate >= (index-bitrate/2))
        modulation(i) = 0;
    end
    
    if time(i)*bitrate >= index
        index = index+1;
    end
end
length(time)
length(modulation)
plot(time, modulation);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
grid on;


index = 1;

for i = 1:length(modulation)
    if modulation(i) == voltage
        demodulation(index) = 1;
    end
    if modulation(i) == -voltage
        demodulation(index) = 0;
    end
    if time(i)*bitrate >= index
        index = index+1;
    end
end

disp(demodulation);