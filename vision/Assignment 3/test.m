% A driver for saliency.m...
im1 = imread('test-images/bird.pgm');
im2 = imread('test-images/elephant.pgm');
im3 = imread('test-images/koala.pgm');
im4 = imread('test-images/snake.pgm');

images1 = saliency(im1, 10);
images2 = saliency(im2, 10);
images3 = saliency(im3, 10);
images4 = saliency(im4, 10);

% save fim1.txt img_out1 -ascii
% save fim2.txt img_out2 -ascii
% save fim3.txt img_out3 -ascii
% save fim4.txt img_out4 -ascii


% imwrite(img_out1, 'im1_ds.pgm');
% imwrite(img_out2, 'im2_ds.pgm');
% imwrite(img_out3, 'im3_ds.pgm');
% imwrite(img_out4, 'im4_ds.pgm');

 figure(1);
%  imshow(images1(1,1), [0 255]);
%  figure(2);
%  imshow(img_out2, [0 255]);
%  figure(3);
%  imshow(img_out3, [0 255]);
%  figure(4);
%  imshow(img_out4, [0 255]);

