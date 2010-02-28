% A driver for stereo.m...
im1l = imread('test-images/SHRUB-03.pgm');
im1r = imread('test-images/SHRUB-15.pgm');
im2l = imread('test-images/meter_l.pgm');
im2r = imread('test-images/meter_r.pgm');
im3l = imread('test-images/tree_l.pgm');
im3r = imread('test-images/tree_r.pgm');
im4l = imread('test-images/tsukuba_l.pgm');
im4r = imread('test-images/tsukuba_r.pgm');

img_out1 = stereo(im1l, im1r, 20, 15);
img_out2 = stereo(im2l, im2r, 20, 15);
img_out3 = stereo(im3l, im3r, 20, 15);
img_out4 = stereo(im4l, im4r, 20, 15);

save fim1.txt img_out1 -ascii
save fim2.txt img_out2 -ascii
save fim3.txt img_out3 -ascii
save fim4.txt img_out4 -ascii


% imwrite(img_out1, 'im1_ds.pgm');
% imwrite(img_out2, 'im2_ds.pgm');
% imwrite(img_out3, 'im3_ds.pgm');
% imwrite(img_out4, 'im4_ds.pgm');

 figure(1);
 imshow(img_out1, [0 255]);
 figure(2);
 imshow(img_out2, [0 255]);
 figure(3);
 imshow(img_out3, [0 255]);
 figure(4);
 imshow(img_out4, [0 255]);

