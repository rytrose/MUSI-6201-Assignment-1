function [f0, timeInSec] = myPitchTrackAcf(x, blockSize, hopSize, fs)

%% Blockwise Pitch Tracking based on ACF
% Input:
%   x:          (N x 1) float vector, input signal
%   blockSize:  int, block size of the blockwise process
%   hopSize:    int, hop size of the blockwise process
%   fs:         float, sample rate in Hz
% Output:
%   f0:         (numBlocks x 1) float vector, detected pitch (Hz) per block
%   timeInSec:  (numBlocks x 1) float vector, time stamp (sec) of each block

% Check input dimensions 
[~,n] = size(x);
if (n>1)
    error('illegal input signal');
end
[m,n] = size(blockSize);
if (m ~= 1 && n ~=1)
    error('illegal blockSize');
end
[m,n] = size(hopSize);
if (m ~= 1 && n ~=1)
    error('illegal hopSize');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('illegal fs');
end

%% Please write your code here. Follow the steps as per the comments
% first block the audio and get the time-stamps per block (myBlockAudio)
[blocks, timeInSec] = myBlockAudio(x, blockSize, hopSize, fs);

% compute the ACF for each block (myCompAcf)
blocks_dims = size(blocks);
num_blocks = blocks_dims(2);
acf_size = (blockSize * 2) - 1;
acfs = zeros(acf_size, num_blocks);
block = 1;
while (block <= num_blocks)
    acfs(:, block) = myCompAcf(blocks(:, block), true);
    block = block + 1;
end

% compute the pitch in Hz for each block (myGetF0FromACF)
f0 = zeros(num_blocks, 1);
block = 1;
while (block <= num_blocks)
    acfVector = acfs(:, block);
    f0(block) = myGetF0FromAcf(acfVector, fs);
    block = block + 1;
end
end