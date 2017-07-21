%%
% Use Fourier transforms to find the frequency components of a signal buried in noise.
%Specify the parameters of a signal with a sampling frequency of 1 kHz and a signal duration of 1 second.

Fs = 5000;            % Sampling frequency-> so I'm guessing that this is in samples/sec or 1000Hz = 1kHz
T = 1/Fs;             % Sampling period   -> This is 1/1000 sec/sample
L = 5000;             % Length of signal  ->This is 1000 milliseconds I guess because we are given that the length of the signal is 1s
t1 = (0:L/2 - 1)*T;        % Time vector       -> This builds an array t with length L and then puts them between 0,1 
                                         %-> I.e 1000 evenly spaced between 0,1 
t2 = (L/2:L - 1)*T;
                                          
                                          
                                          
%Form a signal containing a 50 Hz sinusoid of amplitude 0.7 and a 120 Hz sinusoid of amplitude 1.

S1 = sin(2*pi*300*t1);   % this seems pretty self-explanitory, S is an array of 1000 elements
S2 = .7*sin(2*pi*120*t2);
S = cat(2,S1,S2);
S_fft = fft(S);
f = Fs*(1:L)/L;
figure; plot(f,abs(S_fft));xlim([0 500]); 
%for next time
%{
    /plot orig signal
    /run fft on this for whole signal 
    /plot this to see the four bumps
    /then run the inverse on the result of the FFT(s) i.e the one with four bumps
%}
figure;
%subplot(3,3,1);
plot(t,S);
title('Original Signal of Superimposed Sinusoids S(t)');
xlabel('t (sec)');
ylabel('S(t)');
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K = fft(S);
S2_single = abs(K/L);
S1_single = S2_single(1:L/2+1);
S1_single(2:end-1) = 2*S1_single(2:end-1);
f_S_single = Fs*(0:(L/2))/L;
figure; 
plot(f_S_single, S1_single);
title('Single-Sided Amplitude Spectrum of S1_{single}');
% Questions for anton: split works but join removed one of the frequencies


% now we will zero out the frequency 50Hz
J = zero_out_freq(S1_single, 1,51); figure; plot(f_S_single,J);
J(121) = 2*J(121); M = ifft(J); figure; plot(1:501,M); title('plot of M'); %because its a half signal
M_cconj = conj(M);
M_real = .5*(M+M_cconj);
N = fft(M_real);
N2 = abs(N/L);
N1 = N2(1:L/2+1);
N1(2:end-1) = 2*N1(2:end-1);
f_N1 = Fs*(0:(L/2))/L;
figure; plot(f_N1, N1);
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Z = fft(S);

S2 = abs(Z/L); % S2 is an array of 1000 elements of the elements of Z / L and made positive
S1 = S2(1:L);   % S1 is an array of 1000 elements of S2
S1(2:end-1) = 2*S1(2:end-1);

f_S = Fs*(1:L)/L;
%figure;
subplot(3,3,2);
plot(f_S,S1); % plots f_S versus the not doubled S1(1) the doubled S1(2:999) and the not doubled S1(1000)
title('Double-Sided Amplitude Spectrum of S1');
xlabel('f_S (Hz)');
ylabel('|S1(f_S)|');

W = ifft(S2); % ifft(S1);

%figure;
subplot(3,3,3);
plot(t,W); 
title('should be orig signal S(t)');
xlabel('t (sec)');
ylabel('S(t)');
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Corrupt the signal with zero-mean white noise with a variance of 4.

X = S + 2*randn(size(t));   %-> taking advantage of super position they add random values to the signals 1000 values




%Plot the noisy signal in the time domain. It is difficult to identify the frequency components by looking at the signal X(t).

%figure;
subplot(3,3,4);
plot(1000*t(1:50),X(1:50));     % -> plots first 50 points of t vs X -> t looks like 0,1,...,50 and X is 50 random looking points
title('Signal Corrupted with Zero-Mean Random Noise');
xlabel('t (milliseconds)');
ylabel('X(t)');



%Compute the Fourier transform of the signal.

Y = fft(X); % yields random looking complex numbers (shouldn't these represent frequencies? ask about what fft is really doing)



%Compute the two-sided spectrum P2. Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.

P2 = abs(Y/L); % P2 is an array of 1000 elements of the elements of Y / L and made positive
%P1 = P2(1:L/2+1);   % P1 is an array of first 501 elements of P2
%P1(2:end-1) = 2*P1(2:end-1); % sets the 2nd through 500th elements of P1 equal to double their original values
% why skip P1(1) and P1(501)? what's the point of this?

P1 = P2(1:L);   % P1 is an array of first 501 elements of P2
%P1(2:end-1) = 2*P1(2:end-1);


%Define the frequency domain f and plot the single-sided amplitude spectrum P1. The amplitudes 
%are not exactly at 0.7 and 1, as expected, because of the added noise. On average, longer signals
% produce better frequency approximations

f = Fs*(1:(L))/L; % f is an array of 100 elements that looks like 0,1,...,1000
%f = (0:(L/2));
%this is just multiplying and then dividing by 1000 why?

%figure;
subplot(3,3,5);
plot(f,P1); % plots f versus the not doubled P1(1) the doubled P1(2:500) and the not doubled P1(501)
title('Single-Sided Amplitude Spectrum of X(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

%Here we will attempt to retrieve the corrupted signal from the output of
%the fft()

V = ifft(Y);

%figure;
subplot(3,3,6);
plot(1000*t(1:50),V(1:50)); 
title('should be orig corrupted signal X(t)');
xlabel('t (sec)');
ylabel('X(t)');



%Now, take the Fourier transform of the original, uncorrupted signal and retrieve the exact amplitudes, 0.7 and 1.0.

Y = fft(S); %Y is now an array of length 1000 representing the Fourier transform of the original signal
P2 = abs(Y/L);  % P2 is an array of 1000 elements that are scaled by 1/L and made positive
P1 = P2(1:L/2+1);   % P1 is an array of 501 elements equal to the first 501 of P2
P1(2:end-1) = 2*P1(2:end-1);    % sets the 2nd through 500th elements of P1 equal to double their original values

%figure;
subplot(3,3,7);
plot(f,P1);
title('Single-Sided Amplitude Spectrum of S(t)');
xlabel('f (Hz)');
ylabel('|P1(f)|');

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% now try to fft the A4 signal and then ifft it back and play the result
% file name is tuning_fork_A4.wav

%Load File
file = 'Users/zanekarl/Documents/Fall_Quarter_Research/tuning_fork_A4.wav';
[y,Fs] = audioread(file);

Nsamps = length(y);
t = (1/Fs)*(1:Nsamps);          %Prepare time data for plot t is length of signal(i.e. number of total samples

%Do Fourier Transform
Y = fft(y);
y_fft = abs(Y);            %Retain Magnitude
%y_fft = y_fft(1:Nsamps/2);      %Discard Half of Points
f = Fs*(1:Nsamps)/Nsamps;%Fs*(0:Nsamps/2-1)/Nsamps;   %Prepare freq data for plot

%Plot Sound File in Time Domain
%figure;
subplot(2,2,1);
plot(t, y);
xlabel('Time (s)');
ylabel('Amplitude');
title('Tuning Fork A4 in Time Domain, y');

%Plot Sound File in Frequency Domain
%figure;
subplot(2,2,2);
plot(f, y_fft);
xlim([0 1000]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
title('Frequency Response of Tuning Fork A4, y\_fft');


% Do inverse fourier transform
y_ifft = ifft(Y);
%figure;
subplot(2,2,3);
plot(t, y_ifft);
xlabel('Time (s)');
ylabel('Amplitude');
title('Should be Original Tuning Fork A4 in Time Domain, y\_ifft');


% the plot of ifft(y_fft) 
%figure;
subplot(2,2,4);
plot(t, ifft(y_fft));
xlabel('Time (s)');
ylabel('Amplitude');
title('The plot of ifft(y_{fft}) in Time Domain, ifft(y\_fft)');

%{
 Here we're going to zero out all of the harmonics of A4, i.e. frequencies
 like ...,55,110,220,880,1760,...
%}
y_zeroed_harmonics = zero_out_freq(y_fft,1,439);
y_zeroed_harmonics = zero_out_freq(y_zeroed_harmonics,445,880);
figure; plot(f,y_zeroed_harmonics); title('y\_zeroed\_harmonics');
%xlim([0 1000]); Questions for Anton: This is the reason for the weird
%graph where things aren't zeroed out I believe (March 1)
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%{
len = length(y_zeroed_harmonics);
reverse = y_zeroed_harmonics;
for i = 1:len
        reverse(i) = y_zeroed_harmonics(len-i+1);
end
reverse = zero_out_freq(reverse,439);
y_zeroed_harmonics = reverse;
%}
figure; plot(f,y_zeroed_harmonics); title('y_zeroed_harmonics all');
xlim([0 1000]);
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%Question for Anton When I play sound(y_zeroed_harmonics,Fs) I just get a
%really scratchy sound ... WHY? BECAUSE WE NEED TO IFFT it first ...

% now let's go back to the original signal
get_back_orig_after_zeros = real(ifft(y_zeroed_harmonics));
% this merely returns the same wavy graph that we got in the subplots, we
% lose info on the original signal when we take the absolute value in order
% to plot the fft(y) at the beginning of this set. 