%% beat checks
s = 2;

Fs = 44000; % samp rate
T = 1;  % period in seconds
n = 500.3; 
t = (0:(Fs*T-1))/Fs;
%y = sin(2*pi*t*n/T);
%figure;
%plot(t,y);

z = 0 + 1i;
x = exp(2*pi*z*t*n/T);
y_fft = transpose(fft(x));
w = exp(2*pi*z*t*s*n/T); %double the freq
x_comp_w_y_ifft = transpose(x); % this is to compare theo with orig
cft_x = zeros(Fs*T,1);
cft_w = zeros(Fs*T,1);
for i = 1:Fs*T
    %cft_x(i) = (-1/(pi*z)) * (1/(n - (i - 1))) * (Fs*T);
    %cft_w(i) = (-1/(pi*z)) * (1/(n - (i - 1))) * (Fs*T);
    cft_x(i) = (1/(2*pi*z)) * (T/(n-(i-1))) * (exp(2*pi*z*n) - 1) * (Fs*T);
    cft_w(i) = (1/(2*pi*z)) * (T/(s*n-(i-1))) * (exp(2*pi*z*s*n) - 1) * (Fs*T);
end

cft_x_shift = geo_shift(cft_x, Fs, s);
compare_array = horzcat(abs(cft_w), abs(cft_x_shift));
plot(t,real(ifft(cft_x_shift)));
% sound(real(ifft(cft_x_shift)), Fs)
%%
%y_fft = horzcat(y_fft,sec_form);
%{
hand_y_fft = zeros(Fs*T,1); % this is the theoretical one
for k = 1:Fs*T
    for j = 1:Fs*T
        hand_y_fft(k) = hand_y_fft(k) + x(j) * exp( ((-2*pi*z)/(Fs*T)) * (j-1)* (k-1));
    end
end
hand_y_ifft = ifft(hand_y_fft); % mostly right except first imaginary part
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% now to do fft(e^2*pi*i*440.3*t) shiftx2, ifft

y_fft_shift = geo_shift_up(y_fft, Fs, 2^(12/12)); % good with theo compare
y_ifft_shift = ifft(y_fft_shift); % good with hand theo compare

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% now to do theoretical cft(e^2*pi*i*440.3*t) shiftx2, ifft
% hand_y_fft_shift = geo_shift_up(hand_y_fft, Fs, 2^(12/12));
% hand_y_fft_shift_ifft = ifft(hand_y_fft_shift);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

