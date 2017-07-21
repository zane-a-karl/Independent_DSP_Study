%Take orig signal and find avg, so that in the future we could
% scale the orig signals amplitude AKA AVERAGING FUNCTON WRITE IT!

function [z] = avg_amp(x)
    z = 0;
    % x = original signal amplitudes
    for i = 1:numel(x)
        z = z + abs(x(i));
    end
    z = z/numel(x);
end