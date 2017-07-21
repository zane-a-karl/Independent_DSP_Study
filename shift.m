%{
This fcn will perform an linear shift on the signal of frequencies
Input:
    - original freq signal 'x'
    - sampling rate 'Fs'
    - magnitude of shift in Hz 'v'
    - upper bound in Hz 'ub'
%}

function [y] = shift(x, Fs, v, ub)
    N = length(x);
    tot_sec = N/Fs;
    v = ceil(v*tot_sec);
    ub = min(ceil(ub*tot_sec), N);
    
    for i = ub:-1:1
        if i-v >= 1
            x(i) = x(i - v);
        else
            x(i) = 0;
        end
    end
    y = x;
end
