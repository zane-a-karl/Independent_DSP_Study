%{
This fcn will perform an geometric shift on the signal of frequencies
Input:
    - original freq signal 'x'
    - sampling rate 'Fs'
    - number of half tones for shift 'v'
    % - upper bound in Hz 'ub'
Return:
    - the playable signal 'y'
%}

function [y] = geo_shift_up(x, Fs, v)
    N = length(x);
    %tot_sec = N/Fs;
    %v = (2)^(v/12);
    %ub = min(ceil(ub*tot_sec), N);
    
    for i = N-1:-1:0
        if (mod(i,2) == 1)
            x(i+1) = x(ceil((i-1)/v) + 1);
        else
            x(i+1) = 0;
        end
    end
    y = x;
end
