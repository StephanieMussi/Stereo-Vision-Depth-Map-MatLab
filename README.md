# Stereo_Vision_Depth_Map_MatLab
This project aims to compute disparity images for pairs of rectified stereo images.  

The algorithm of generating the disparity map is as below:  
* For each pixel in left image:  
	* Get the 11x11 (maximum size) neighborhood of that pixel;  
	* For each pixel within the distance of 10 on the same line in the right image:  
		* Get the neighborhood of same size in the right image;  
		* Calculate Sum-of-Square Differences and store it in an array;  
	* Sort the SSD array in ascending order;  
	* Get the best matching index;  
	* Calculate the disparity d = left image index – right image index;  
* End   

The corresponding codes can be found in ["disparityMapGenerator.m"](https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/disparityMapGenerator.m).  

For each pixel in the left image, its neighboring pixels need to be extracted.  
As the template size is given, it is necessary to know how many rows and columns are around the center pixel in the template.  

```matlab
halfSizeR = (sizeR - 1) / 2;
halfSizeC = (sizeC - 1) / 2;
```  

For example, for template size of 11x11, halfSizeR = halfSizeC= 5, which means there are 5 pixels at the left/right or above/below of the pixel.  

<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/algo1.png" width = 250 hright = 250>  

Then, the index range of the template is obtained. The scenario where pixels are at the edge or corner of the image needs to be considered.  

* For row index:
```matlab
minr = max(1, i - halfSizeR);
maxr = min(r, i + halfSizeR);
```  

* For column index:
```matlab
minc = max(1, j - halfSizeC);
maxc = (c, j + halfSizeC);
```  

<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/algo2.png" width = 470 hright = 320>  

```matlab
sampleL = Pl(minr:maxr, minc:maxc);
``` 
 

After getting the template from the left image, the next step is to get the index within the searching scope (≤ 10 pixels) in the right image.  

As in 3D stereo, the location of the same object in the left image should be to the right as compared to the right image. Therefore, the SSD matching only needs to be performed on the at most 10 pixels on the left in the same row.  
The case where there are less than 10 pixels on the left in needs to be considered.  
```matlab
mind = 0;
maxd = min(10, minc-1);
``` 
<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/algo3.png" width = 690 hright = 75>   
<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/algo4.png" width = 690 hright = 75>  

Then, for each pixel in the right image within the searching scope, its neighboring pixels need to be extracted. The size must be the same as the template.  
```matlab
sampleR = Pr(minr:maxr, (minc-num):(maxc-num));
```  

Where num ranges from mind to maxd. An example is as followed:  

<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/algo5.png" width = 700 hright = 250>    
<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/algo6.png" width = 700 hright = 250>  

For each matrix, Sum-of-Square Difference with the template is calculated, and the result is stored in an array.  
```matlab
SSD(pixelIndex, 1) = sumsqr(sampleL – sampleR);
```

Then, the array is sorted in ascending order, and the first index represents the best matching pixel.  
```matlab
[temp, sorted] = sort(SSD);
bestMatchIndex = sorted(1, 1);
```  

The disparity is the difference between left image index and right image best-matching index, which can be expressed as D(xl, yl) = xl – xr. The result is stored in disparity array D at index (i, j).  
```matlab
d = -(bestMatchIndex + mind – 1);  
```  

<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/algo7.png" width = 500 hright = 220>  

After the method is ready, the images "corridorl.jpg" and "corridorr.jpg" are read.  
```matlab
Pl1 = imread('corridorl.jpg');
Pl1 = rgb2gray(Pl1);
Pr1 = imread('corridorr.jpg');
Pr1 = rgb2gray(Pr1);
imshow(Pl1);
imshow(Pr1);
```  

<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/corridorl.jpg" width = 400 height = 400>
<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/corridorr.jpg" width = 400 height = 400>  

Then, the disparity map is computed:  

```matlab
obj = disparityMapGenerator;
D = obj.disparityMap(Pl1, Pr1, 25, 25);
imshow(-D,[-15 15])
```  
<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/disp1.png" width =  400 height = 400>  

Similarly, the disparity map of "triclops-i2l.jpg" and "triclops-i2r.jpg" is computed:   

<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/triclops-i2l.jpg" width = 345 height = 275>
<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/triclops-i2r.jpg" width = 345 height = 275>  

<img src = "https://github.com/StephanieMussi/Stereo_Vision_Depth_Map_MatLab/blob/main/Figures/disp2.png" width =  345 height = 275>  

