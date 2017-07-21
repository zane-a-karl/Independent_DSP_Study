%% fft_filter practice with F3 and G5
% Remember http://www.audiocheck.net/blindtests_abspitch.php
info = audioinfo('superposition_F3_G5.wav');
[y,Fs] = audioread('superposition_F3_G5.wav');

%For the F3 note
info_f3 = audioinfo('F3_piano.wav');
[y_f3,Fs_f3] = audioread('F3_piano.wav');
%For the G5 note
info_g5 = audioinfo('G5_piano.wav');
[y_g5,Fs_g5] = audioread('G5_piano.wav');

sound(y,Fs);
sound(y_f3,Fs_f3);%F3 is 174.614
sound(y_g5,Fs_g5);%G5 is 783.991

Nsamps = length(y);
t = (1/Fs)*(1:Nsamps);figure;
subplot(1,3,1); plot(t,y); title('superpos\_f3\_g5');
Nsamps_f3 = length(y_f3);
t_f3 = (1/Fs_f3)*(1:Nsamps_f3);
subplot(1,3,2); plot(t_f3,y_f3);title('y\_f3');
Nsamps_g5 = length(y_g5);
t_g5 = (1/Fs_g5)*(1:Nsamps_g5);
subplot(1,3,3); plot(t_g5,y_g5);title('y\_g5');

%% now for the frequency domain 
f_f3 = Fs_f3*(1:length(y_f3))/length(y_f3);
f_g5 = Fs_g5*(1:length(y_g5))/length(y_g5);
% for f3 and g5
f3 = fft(y_f3); g5 = fft(y_g5);
f3_fft = abs(f3); g5_fft = abs(g5);
figure; subplot(1,2,1);
plot(f_f3/3,f3_fft); title('original f3');xlim([0 1000]); xlabel('Frequency (Hz)');ylabel('Amplitude');
subplot(1,2,2);
plot(f_g5/2,g5_fft); title('original g5');xlim([0 1000]); xlabel('Frequency (Hz)');ylabel('Amplitude');

%% Now to mess around with fft_filter
Y = fft(y);%fft(y_f3); fft(y_g5);
y_fft = abs(Y);
f = Fs*(1:Nsamps)/Nsamps;
figure();
subplot(1,2,1);
plot(f,y_fft); title('Orig Freq Signal');
xlim([0 1000]); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');

y_ifft = ifft(Y);


%y_fft_filter = zero_out_freq(y_fft, Nsamps/Fs, 1, 300);
y_fft_filter = fft_filter(y_fft, Fs, 1,300);
subplot(1,2,2);plot(f,y_fft_filter); title('y\_fft\_filter');
xlim([0 2000]); 
xlabel('Frequency (Hz)');
ylabel('Amplitude');

output = abs(ifft(10*y_fft_filter));