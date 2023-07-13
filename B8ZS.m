clc; 
clear all; 
close all; 

bits = [1 0 0 0 0 0 0 0 0 1 0 1];

%... Modulation
bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

count = 0;

for i = 1:length(bits)
  if bits(i) == 0
    count = count+1;
  else
    count = 0;
  end
  if count == 8
    bits(i-4) = -1; bits(i-3) = -1; bits(i-1) = 1;
    bits(i) = 1; count = 0;
  end
  end

index = 1;
sign = 1;
if bits(1) == 1
  sign = -1;
end

for i = 1:length(time)
  modulation(i) = bits(index)*sign*voltage;
  if time(i)*bitrate >= index
        index = index+1;
        if index <= length(bits) && bits(index) ~= 0
            sign = -sign;
        end
  end
end

plot(time, modulation);
axis([0 end_time -voltage-5 voltage+5]);
line([0 end_time], [0 0]);
grid on;

%... Demodulation
index = 1;

for i = 1:length(modulation)
  demodulation(index) = modulation(i)/voltage;
  if time(i)*bitrate >= index
    index = index+1;
  end
end

last = 1;

for i = 1:length(demodulation)
  if demodulation(i) ~= 0
    if demodulation(i) == last
      for j = 0:4
        demodulation(i+j) = 0;
      end
    else
      last = demodulation(i);
    end
  end
end

demodulation = abs(demodulation);

disp(demodulation);