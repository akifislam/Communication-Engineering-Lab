bits = [0 1 0 0 1 1 1 0];

%modulation
voltage = 5;
bitrate = 1;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;

time = 0:sampling_time:end_time;

index = 1;

sign = 1;

if bits(index)==1
    sign=-1*sign;
end

for i=1:length(time)
    modulation(i)=voltage*sign;
    
    if time(i)*bitrate>=index
        index=index+1;
        
        if(index<=length(bits) && bits(index)==1)
            sign=-1*sign;
        end
    end
end

plot(time,modulation);
axis([0,end_time,-voltage-2,voltage+2]);
grid on;

%Demodulation

index = 1;
last=voltage;

for i=1:length(modulation)
    if(modulation(i)==last)
        demodulation(index)=0;
    else
        demodulation(index)=1;
    end
    
    if(time(i)*bitrate>=index)
        index=index+1;
        last = modulation(i);
    end
end

disp(demodulation);
