Pl1 = imread('corridorl.jpg');
Pl1 = rgb2gray(Pl1);
Pr1 = imread('corridorr.jpg');
Pr1 = rgb2gray(Pr1);
obj = disparityMapGenerator;
D = obj.disparityMap(Pl1, Pr1, 11, 11);
imshow(-D,[-15 15])
D = obj.disparityMap(Pl1, Pr1, 25, 25);
imshow(-D,[-15 15])


Pl2 = imread('triclops-i2l.jpg');
Pl2 = rgb2gray(Pl2);
Pr2 = imread('triclops-i2r.jpg');
Pr2 = rgb2gray(Pr2);
obj = disparityMapGenerator;
D = obj.disparityMap(Pl2, Pr2, 11, 11);
imshow(-D,[-15 15])
D = obj.disparityMap(Pl2, Pr2, 19, 19);
imshow(-D,[-15 15])


