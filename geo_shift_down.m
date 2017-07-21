%{
This fcn will perform an geometric shift on the signal of frequencies
Input:
    - original freq signal 'x'
    - sampling rate 'Fs'
    - number of half tones for shift 'v'
    % - lower bound in Hz 'lb'
Return:
    - the playable signal 'y'
%}

function [y] = geo_shift_down(x, Fs, v)
    N = length(x);
    %tot_sec = N/Fs;
    %v = (2)^(v/12);
    % lb = max(floor(lb*tot_sec), 1);
    
    for i = 0:1:floor(N/2)-1
        if (floor(i*v) >= N/2)
            x(i+1) = 0;
        else
            x(i+1) = x(floor(i*v) + 1);
        end
    end
    y = x;
end
