%{
This function takes in a wave signal and splits it into n equal parts
(i.e arrays, or waves in our case) and returns an array of arrays, or waves
and 'n' is the number of rows
%}

function [y] = split(x,n)
    r = mod(length(x),n);
    d = (length(x)-r)/n; % d is the number of columns 
    wave_mat = zeros(d,n);
    for i = 1:n
        %I believe that this works and doesn't require a nested loop
        wave_mat(:,i) = x(1+((i-1)*d):d+((i-1)*d)); %ith column of wavemat
    end
    y = wave_mat;
end