function [r] = myCompAcf (inputVector, bIsNormalized)

%% Computes the ACF of an input with optional normalization
% Input:
%   inputVector:	(N x 1) float vector, block of audio
%   bIsNormalized: 	bool variable for normalization of ACF 
% Output:
%   r:				(N x 1) float vector, ACF of the inputVector

% set uninitialized input arguments
if (nargin < 2)
    bIsNormalized = true;
end

% check input dimension
[m,n] = size(inputVector);
if ((m<=1 && n<=1) || (m>1 && n>1))
    error('illegal input vector');
end

%% Please insert your ACF computation code here
r = zeros(((length(inputVector) * 2) - 1), 1);
i = 1;
shifted = zeros(length(inputVector) - 1, 1);
shifted = vertcat(shifted, inputVector);
shifted = vertcat(shifted, zeros(length(inputVector), 1));
while i <= length(r)
    laggedVec = shifted(i:length(inputVector) + i - 1);
    r(i) = sum(laggedVec.*inputVector);
    %shifted = vertcat(shifted(2:length(shifted)), zeros(1, 1));
    i = i + 1;
end

% normalize result
if (bIsNormalized)
    %% Please inset your normalization code here
    normalization = sum(inputVector.^2);
    r = r./normalization;
end

end