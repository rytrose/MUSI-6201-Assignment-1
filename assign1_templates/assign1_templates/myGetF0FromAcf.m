function [f0] = myGetF0FromAcf(acfVector, fs)

%% Computes the pitch for a block of audio from the ACF vector
% Input:
%   acfVector:  (blockSize x 1) float vector, ACF of a block
%   fs:         float, sampling rate in Hz
% Output:
%   f0:         float, fundamental frequency of the block in Hz  

% check input dimensions
[~, n] = size(acfVector);
if (n>1)
    error('illegal input acfVector');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('illegal fs');
end


%% Please insert your code here
n = 2;
size_acf = size(acfVector);
local_max_1 = 0;
local_max_2 = 0;
flag = true;
decreasing = true;

% Check first samples for slope
delta = acfVector(n) - acfVector(n - 1);
if(delta >= 0)
    decreasing = false;
    local_max_1 = n;
    flag = ~flag;
else
    decreasing = true;
    local_max_1 = (n - 1);
    flag = ~flag;
end
n = n + 1;

% look for local maxima
while n <= size(acfVector)
    prev_behavior = decreasing;
    delta = acfVector(n) - acfVector(n - 1);
    
    if(delta >= 0)
        decreasing = false;
    else
        decreasing = true;
    end
    
    % local maximum found
    if(~prev_behavior && decreasing)
        if(flag)
            local_max_1 = (n - 1);
            flag = ~flag;
        else
            local_max_2 = (n - 1);
            flag = ~flag;
        end
    end
    
    n = n + 1;
    
end

t0_in_samples = abs(local_max_1 - local_max_2);
t0_in_sec = t0_in_samples/fs;
f0 = 1/(t0_in_sec);

end
