%{
The function splits the input signal up into subintervals and filters
them, also doing a kind of staggered addition of them in order to try
and combat the dropping off quality of the filtering. 
Input:
    - original signal 'x'
    - sample rate 'Fs'
    - length of the subintervals in seconds 'sub_intrv_len'
    - stagger fraction 'stag_frac' (fraction of the subintrv length)
    - an anonymous fcn corresponing to the type of filter 'fn'
Return:
    - the playable signal 'y'
%}

function [y] = split_n_filter(x, Fs, sub_intrv_len, stag_frac, fn)
    Nsamps = length(x);
    sub_intrv_Nsamps = floor(sub_intrv_len*Fs);
    k = ceil(sub_intrv_Nsamps * stag_frac);
    [m,n] = size(x);
    y = zeros(m,n);
    
    for i = 0:k:(Nsamps - sub_intrv_Nsamps)
        x_sub = x(1+i:sub_intrv_Nsamps+i);
        y_sub = fft_filter(x_sub, Fs, fn);
        for j = 1:sub_intrv_Nsamps
            y(j+i) = y(j+i) + y_sub(j);
        end
    end
    y_amp = avg_amp(y); x_amp = avg_amp(x);
    scl_fact = (x_amp/y_amp);
    %scl_fact = stag_frac;
    for i = 1:Nsamps
        y(i) = y(i) * scl_fact;
    end
end
