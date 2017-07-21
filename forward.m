%applies fft and creates a graph

function [y] = forward(x)
    L = length(x);
    subplot(1,3,1);
    plot(1:L,x); title('plot of input');
    
    x = fft(x);
    x = abs(x);
    subplot(1,3,2);
    plot(1:L,abs(x)); title('plot of fourier transform of input');
    
    x = x(1:(L/2));
    subplot(1,3,3); 
    plot(1:(L/2),abs(x)); title('plot of single-sided fourier transform of input');
    
    y=x;
    
end