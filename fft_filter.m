%{
This function will take the fourier transform of a given signal, filter it
in the specified manner and then output the inverted playable signal. 
Input:
    - sound signal 'x'
    - sample rate 'Fs'
    - an anonymous fcn corresponing to the type of filter 'fn'
%}
function [y] = fft_filter(x, Fs, fn)

    %x_amp = avg_amp(x);
    N = length(x);
    %tot_sec = N/Fs;
    x_fft = fft(x);
    %{
    figure;
    plot(f,abs(x_fft)); title('x\_fft Before');xlim([0 2000]);
    %}
    %x_fft = zero_out_freq(x_fft,tot_sec,lb,ub);
    %x_fft = shift(x_fft, Fs, lb, ub);
    x_fft = fn(x_fft, Fs);
    for i = 1:N/2
        x_fft(N-i+1) = conj(x_fft(i+1));
    end
    %{
    figure;
    plot(f,abs(x_fft)); title('x\_fft After');xlim([0 2000]);
    %}
    y = real(ifft(x_fft));
    
    %{
    y_amp = avg_amp(y);
    for i = 1:N
        y(i) = y(i) * (x_amp/y_amp);
    end
    %}
end