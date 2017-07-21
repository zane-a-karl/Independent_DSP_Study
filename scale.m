%{
This  function that doubles the length and interpolates a point between 
    each point of the average of their amplitudes
Input:
    - The original signal 'x'
    - The length multiplier 'len_mult'
Return:
    - An expanded signal with an interpolated midpoint
%}

function [y] = scale(x, len_mult)
    N_old = length(x);
    N_new = floor(len_mult*N_old);
    y = zeros(N_new,1);
    for i = 1:N_new
        j = ((i-1)/len_mult) + 1;
        j_fl = floor(j);
        j_cl = ceil(j);
        if (j_cl > N_old) 
            j_cl = j_fl;
        end
        x_fl = x(j_fl);
        x_cl = x(j_cl);
        y(i) = x_fl + (j - j_fl) * (x_cl - x_fl);
    end
end

