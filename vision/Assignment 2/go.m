load im1.txt
load im2.txt
load im3.txt
load im4.txt
load fim1.txt
load fim2.txt
load fim3.txt
load fim4.txt

writepgm(im1, 'vary_shrub.pgm');
writepgm(im2, 'vary_meter.pgm');
writepgm(im3, 'vary_tree.pgm');
writepgm(im4, 'vary_tsukuba.pgm');

writepgm(fim1, 'fixed_shrub.pgm');
writepgm(fim2, 'fixed_meter.pgm');
writepgm(fim3, 'fixed_tree.pgm');
writepgm(fim4, 'fixed_tsukuba.pgm');
