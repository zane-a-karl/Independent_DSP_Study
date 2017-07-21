%{
This function takes in a file and outputs the index of the max value in
that file divided by the total length of the signal in seconds. 
Input:
    - 'filename' is the name of the file we are testing 
%}

function [output] = test_file(filename)
    [y,Fs] = audioread(filename);
    y_fft = abs(fft(y));
    [M,i] = max(y_fft);
    output = i/(length(y_fft)/Fs);
end