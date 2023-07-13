clc;
clear all; 
close all;

bits = [1 1 0 0 0 0 1 0 0 0 0];

%... Modulation
bitrate = 1;
voltage = 5;

sampling_rate = 1000;
sampling_time = 1/sampling_rate;

end_time = length(bits)/bitrate;
time = 0:sampling_time:end_time;

count = 0;
zero = 0;
one = 0;

for i = 1:length(bits)
  if bits(i) == 0
    count = count+1;
  else
    count = 0;
    one = one+1;
  end
  if count == 4
    bits(i) = -1;
    count = 0;
    if rem(one, 2) == 0
      bits(i-3) = 1;
    end
  end
end

index = 1;
sign = -1;

for i = 1:length(time)
  modulation(i) = bits(index)*sign*voltage;
  if time(i)*bitrate >= index
    if bits(index) == 1
      sign = -sign;
    end
    index = index+1;
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

last = 0;
for i = 1:length(demodulation)
  if demodulation(i) ~= 0
    if last ~= 0 && demodulation(i) == last
      for j = -3:0
        demodulation(i+j) = 0;
      end
    end
    last = demodulation(i);
  end
end

demodulation = abs(demodulation);

disp(demodulation);