function FT2_MAT = rot_FT2_Matrix(M, N, rot_angle)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This function is used to generate a Fourier transform matrix that can rotate the K-space (frequency domain of an image) data
%%% Input of the function: 
%%% M is the dimension of the K-space data along horizontal direction
%%% N is the dimension of the K-space data along vertical direction
%%% rot_angle is the rotation angle in degree
%%% Output of the function:
%%% FT2_MAT is a complex matrix with the size of M*N by M*N
%%% Please note that for the K-space data with size of 256 * 256, totally ~32 GB RAM is required
%%% Written by Dr. Lei Guo, email: l.guo3@uq.edu.au
%%% 13/10/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

total_n = M * N;     % Total number of K-space points

m_dash = (0 : M - 1) - (M - 1) / 2;    % Define the FT coordinate along the direection of M, this is critical. For rotation in K-space, coordinate begin with -M / 2
n_dash = (0 : N - 1) - (N - 1) / 2;    % Define the FT coordinate along the direction of N. Begin with -N / 2

[M_axis, N_axis] = ndgrid(m_dash, n_dash);    % Define the coordinate matrix

FT2_MAT = zeros(total_n, total_n);  % Initialization

theta = rot_angle / 180 * pi;       % Define the rotation angle in radiance

c_rot = cos(theta);     % Used for the rotation transform
s_rot = sin(theta);     % Used for the rotation transform

for ii = 1 : total_n
    
    [K, L] = ind2sub([M, N], ii);    % Get the subscript of a point in K-space
    
    K = (K - 1) - (M - 1) / 2;       % Make sure the origin is at (0, 0), so the FT begin with the point (-(M - 1) / 2)
    L = (L - 1) - (N - 1) / 2;       
    
    K_rot = K * c_rot + L * s_rot;          % Do the rotation transform along the K-direction
    L_rot = -1 * K * s_rot + L * c_rot;     % Do the rotation transform along the L-direction
    
    FT2_MAT(ii, :) = (exp(-1i * 2 * pi * (M_axis(:) .* (K_rot - 1)) ./ M) .* exp(-1i * 2 * pi * (N_axis(:) .* (L_rot - 1)) ./ N)).';     % The FT basis

end

