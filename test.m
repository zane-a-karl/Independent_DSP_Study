%% sine waves alone





%% test

file = 'Users/zanekarl/Documents/Fall_Quarter_Research/tuning_fork_A4.wav';
[y,Fs] = audioread(file);
y = 4*y;
Nsamps = length(y);
t = (1/Fs)*(1:Nsamps);
figure; plot(t,y); title('A tuning fork 440Hz');

%Do Fourier Transform
Y = fft(y);
y_fft = abs(Y);
f = Fs*(1:Nsamps)/Nsamps;
figure();
subplot(1,2,1);
plot(f,y_fft); title('Orig Freq Signal');
xlim([0 1000]); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');

y_ifft = ifft(Y); %something wrong the fourier transform reduces the amp
                % Nevermind it didn't reduce the freq it just zero'ed out a
                % higher frequency that apparently occured more... now the
                % question is why is this freq's amp so large?

y_zeroed_harmonics = zero_out_freq(y_fft, Nsamps/Fs,1,439);
y_zeroed_harmonics = zero_out_freq(y_zeroed_harmonics, Nsamps/Fs,445,1000);
%y_zeroed_harmonics = zero_out_freq(y_fft, Nsamps/Fs, 1, 880);
subplot(1,2,2);plot(f,y_zeroed_harmonics); title('y\_zeroed\_harmonics');
xlim([0 1000]); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%% Concat with sine waves
t = (1/Fs)*(0:2*Nsamps -1);
t1 = (0:Nsamps/2 - 1)*(1/Fs);
t2 = (Nsamps/2:Nsamps - 1)*(1/Fs); 

sine_wave1 = sin(2*pi*600*t1);
sine_wave2 = sin(2*pi*300*t2);
sine_waves = cat(2,sine_wave1,sine_wave2);
s = cat(2,sine_waves,transpose(y));figure; plot(t,s);
s_fft = fft(s);
S_fft = abs(s_fft);
S_fft = S_fft(1:floor(length(S_fft)/2));
s_ifft = ifft(s_fft);
subplot(1,2,1); plot(f/2,S_fft); xlim([0 1000]); % not sure why f/2 works...?
title('three notes 300,440,600Hz concat');xlabel('Frequency (Hz)');
ylabel('Amplitude');

%% Zero out the low sine wave and high sine wave

fn_shift = @(x_fft, Fs) shift(x_fft, Fs, 26, 40000000); % no overlap
fn_zero = @(x_fft, Fs) zero_out_freq(x_fft, Fs, 1, 300);% need overlap
fn_geo_shift = @(x_fft, Fs) geo_shift(x_fft, Fs, 7, 40000000); % no overlap

% zeroed_low_high = zero_out_freq(S_fft, 2*Nsamps/Fs, 1, 439); % signal is longer 
% zeroed_low_high = zero_out_freq(zeroed_low_high, 2*Nsamps/Fs, 445, 1000);
zeroed_low_high = split_n_filter(y, Fs, .01, 1, fn_zero);
fn_zero = @(x_fft, Fs) zero_out_freq(x_fft, Fs, 450, 1000);% need overlap
zeroed_low_high = split_n_filter(zeroed_low_high, Fs, .01, 1, fn_zero);

subplot(1,2,2); plot(f/2, zeroed_low_high); title('zeroed\_low\_high');
xlim([0 1000]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%zeroed_low_high = zero_out_freq(s_fft, Nsamps/Fs,1,439);
%zeroed_low_high = zero_out_freq(zeroed_low_high, Nsamps/Fs,445,1000);
zeroed_signal = abs(ifft(zeroed_low_high));
figure; plot(t(1:length(t)/2), zeroed_signal);

%% Add the sine waves together with the tuning fork A

super_pos_waves = sine_waves + y'; 

spw = fft(super_pos_waves);
SPW_fft = abs(spw);
subplot(1,2,1); plot(f,SPW_fft); xlim([0 1000]);
title('300 and 600Hz concat, 440 added');xlabel('Frequency (Hz)');
ylabel('Amplitude');



%% Zero out only the tuning fork A and ifft back to original

zero_A4_440 = zero_out_freq(SPW_fft, Nsamps/Fs,400,500); 

subplot(1,2,2); plot(f,zero_A4_440); title('zero\_A4\_440');
xlim([0 1000]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%zero_A4_440 = zero_out_freq(spw, Nsamps/Fs,400,500);
zeroed_signal = abs(ifft(zero_A4_440));

%% test for fft_filter
file = 'Users/zanekarl/Documents/Fall_Quarter_Research/tuning_fork_A4.wav';
[y,Fs] = audioread(file);
Nsamps = length(y);
t = (1/Fs)*(1:Nsamps);
sine_wave1 = sin(2*pi*600*t);
sine_wave2 = 5*sin(2*pi*329*t);
sine_waves = sine_wave1 + sine_wave2;

filtered_waves = fft_filter(sine_waves, Fs, 400, 1000);


