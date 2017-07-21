%% loading
[y1,Fs1] = audioread('A4_440.wav');
[y2,Fs2] = audioread('Ab4_466.wav');
[y3,Fs3] = audioread('B2_123.wav');
[y4,Fs4] = audioread('Bella_Notte_5sec.wav');
[y5,Fs5] = audioread('JFK_Space_Speech.wav');

assert(Fs1 == Fs2 && Fs2 == Fs3);

Fs = Fs4;
y = y4;% + y2 + y3;
%x = linspace(0,1,44100);
%y = sin(440*x);


%{
figure;plot(f,abs(fft(y)));xlim([0 2000]);
y_zane = geo_shift(abs(fft(y)),Fs,12,40000000);
sound(abs(ifft(y_zane)),Fs);figure; plot(f,y_zane);xlim([0 2000]);
plot(t, abs(ifft(y_zane)));
% also I couldn't really figure out what was needed to manually compute the
% fourier transform to determine the evolution of the beats, 
% 
%}
%% filtering
Nsamps = length(y);
f = Fs*(1:Nsamps)/Nsamps;
t = (1/Fs)*(1:Nsamps);
%t_len = length(t);


figure;
subplot(2,2,1);
plot(t,y); title('original signal');

subplot(2,2,2);
zane = abs(fft(y));
plot(f, abs(fft(y))); title('fft of original signal'); xlim([0 2000]);


fn_shift = @(x_fft, Fs) shift(x_fft, Fs, 26, 40000000);        % no overlap
fn_zero = @(x_fft, Fs) zero_out_freq(x_fft, Fs, 1, 300);     % need overlap
fn_geo_shift_up = @(x_fft, Fs) geo_shift_up(x_fft, Fs, (2)^(12/12)); % no overlap
fn_geo_shift_down = @(x_fft, Fs) geo_shift_down(x_fft, Fs, (2)^(12/12));
fn_geo_shift = @(x_fft, Fs) geo_shift(x_fft, Fs, 2);

y_filtered = real(ifft(geo_shift(fft(y), Fs, 2)));
% y_filtered = split_n_filter(y, Fs, .1, 1, fn_geo_shift);
y_filtered = .75*y_filtered; % to try and avoid clipping
y_filtered = scale(y_filtered, (2));

sound(y_filtered,Fs);

Nsamps_scaled = length(y_filtered);
f_scaled = Fs*(1:Nsamps_scaled)/Nsamps_scaled;
t_scaled = (1/Fs)*(1:Nsamps_scaled);
%t_len_scaled = length(t_scaled);


subplot(2,2,3);
plot(f_scaled,abs(fft(y_filtered))); title('fft of modified'); xlim([0 2000]);

subplot(2,2,4);
plot(t_scaled,y_filtered); title('final output signal');

% output final signal into a file to use in audacity
% if beats exist in the output we want to see them
fname = 'filtered_output.wav';
audiowrite(fname, y_filtered, Fs);

%{
figure;
subplot(1,2,1);
spectrogram(y, 44100/10,'yaxis');
subplot(1,2,2);
spectrogram(y_filtered, 44100/10,'yaxis');

%}
