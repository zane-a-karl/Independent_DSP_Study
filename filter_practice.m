%%
%{
        - keep mulling over what the fourier transform does for yourself 
    - do some filtering on the old sound bites that we worked with
        - start with the concatenation of the two sine waves and move up from there
        - try combining the A4 tuning fork with the concatenated sine waves.
    - Take three consecutive notes and filter out one of them
        - then invert back and plot look and see for note overlap info lost
%}

Fs = 5000;            
T = 1/Fs;       
L = 5000; 
t1 = (0:L/2 - 1)*T;    
t2 = (L/2:L - 1)*T;
                                          
                                          
                                          
%Form a signal containing a 50 Hz sinusoid of amplitude 0.7 and a 120 Hz sinusoid of amplitude 1.

S1 = sin(2*pi*300*t1);  
S2 = .7*sin(2*pi*120*t2);
S = cat(2,S1,S2);
S_fft = fft(S);
f = Fs*(1:L)/L;
figure; plot(f,abs(S_fft));xlim([0 500]); 

S_rm50_freqDM = zero_out_freq(S_fft,length(S_fft)/Fs,1,60);
S_rm50 = ifft()
