% Clear Everything
clc;
clear all;
close all;

bits = [1 0 1 1 0 0 1];

%Modulation
bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;

time = 0:sampling_time:end_time;

index = 1;

for i=1:length(time)
    
    if(bits(index)==1)
       modulation(i)=voltage;
    else
       modulation(i)=0;
    end
    
    if(time(i)*bitrate>=index)
        index=index+1;
    end
end

plot(time,modulation);
axis([0,end_time,-voltage-2,voltage+2]);
grid on;

%Demodulation
index=1;

modulated_signal = modulation;

for i=1:length(modulation)
    if(modulation(i)==voltage)
        demodulation(index)=1;
    else
        demodulation(index)=0;
    
    end
    
    if (time(i)*bitrate>=index)
        index=index+1;
    end
end

disp("Data after Demodulation :");
disp(demodulation);
        



    
    





