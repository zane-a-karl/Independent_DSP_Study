%{
This function will take in a given frequency and zero out the desired
frequency range,
Input:
    - 'x' , the original siginal in the frequency space
    - 'Fs', the sample rate
    - 'lb', the lower bound frequency
    - 'ub', the upper bound frequency
%}

function [y] = zero_out_freq(x, Fs, lb, ub)
    s = length(x)/Fs;
    lb = ceil(lb*s);
    ub = min(ceil(ub*s), length(x));
    for i = lb:ub
        %x(i) = x(lb) + (i - lb)/(ub - lb) * (x(ub) - x(lb));
        x(i) = 0 ;
    end
    y = x;
end
