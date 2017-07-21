%{
This fcn will perform an geometric shift on the signal of frequencies
Input:
    - original freq signal 'x'
    - sampling rate 'Fs'
    - number of half tones for shift 'v'
Return:
    - the playable signal 'y'
%}

function [y] = geo_shift(x, Fs, v)
    if (v > 1) 
        y = geo_shift_up(x,Fs,v);
    else
        y = geo_shift_down(x,Fs,v);
    end
end

