%{
    This function takes in a matrix corresponding to the output of split 
    and joins the n columns of the matrix into a single wave 
    and returns an arrays, or wave
%}

function [y] = join(wave_mat)
    [m,n] = size(wave_mat);
    x = wave_mat(:,1);
    for i = 2:n
        % as per the documentation in matlab this fuction will 
        % append the columns wave_mat to the bottom of x.
        x = cat(1,x,wave_mat(:,i));
    end
    y = transpose(x);
end