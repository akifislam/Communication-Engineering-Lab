clc; 
clear all; 
close all;

bits = [0 1 0 1 1 0 1 1];


bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

index = 1;

sign = 1; 
last = 1;

if bits(1) == 1
    sign = 0;
end

for i = 1:length(time)
    modulation(i) = sign*voltage;
    if time(i)*bitrate >= index
        if sign ~= 0
            last = sign;
        end
        index = index+1;
        if index <= length(bits) && bits(index) == 1
            if sign == 0
                sign = -last;
            else
                sign = 0;
            end
       end
     end
end

plot(time, modulation);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0,0]);
grid on;

%... Demodulation
index = 1;
last = voltage;

for i = 1:length(modulation)
    if modulation(i) == last
        demodultaion(index) = 0;
    else
        demodultaion(index) = 1;
    end
    if time(i)*bitrate >= index
        index = index+1;
        last = modulation(i);
    end
end

disp(demodultaion);