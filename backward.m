%applies ifft and creates a graph

function [y] = backward(x)
    L = length(x);
    subplot(1,3,1);
    plot(1:L,abs(x)); title('plot of input (single-sided freq plot)');
    
    %code to make single-sided input double-sided
    %{
    x2 = 1:1:2*L;
    x2(1:L) = x;
    for i = 1:L
       x2(2*L - i +1) = x(i);
    end
    x = x2;
    subplot(1,3,2); plot(1:2*L,abs(x)); title('double-sided freq plot');
    %}
    
    x = ifft(x);
    x = real(x);
    subplot(1,3,3);
    plot(1:L,x); title('plot of inverse fourier transform of input');
    
    y=x;
end