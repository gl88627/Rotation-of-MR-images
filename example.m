%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% This is an example for the usage of FT_MAT_rot
%%% Written by Dr. Lei Guo, email: l.guo3@uq.edu.au
%%% 13/10/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear

I = double(imread('mri.png'));          % Load a MR image
I = I(2 : end - 1,2 : end - 1);         % Force the image size of 256 * 256
I = imresize(I, 0.5);                   % Resize the image so it has the size of 128 * 128. This is for saving the usage of memory

ref_image = image_normalization(I);     % Do the image normalization

[Nx, Ny] = size(ref_image);             % Get the dimension of the image. This dimension is the same with the dimension of its K-space

FT_MAT_rot = rot_FT2_Matrix(Nx, Ny, 45);     % Generate the rotating Fourier transform matrix with the rotation angle of 45 degree

k_rot = FT_MAT_rot * ref_image(:);           % Calculate the rotated K-space data using the rotating Fourier transform matrix
k_rot = reshape(k_rot, Nx, Ny);              % Reshape the K-space data so it has the dimension of Nx * Ny

I_rot = ifftshift(ifft2(k_rot));             % Do inverse Fourier transform for the rotated K-space
I_rot = reshape(I_rot, Nx, Ny);              % Reshape it

figure; imagesc(abs(I_rot)); axis image; colormap gray   % Plot the rotated image










