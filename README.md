# Stereo_Vision_Depth_Map_MatLab

The algorithm and corresponding codes of generating the disparity map is as below:  
* For each pixel in left image:  
	* Get the 11x11 (maximum size) neighborhood of that pixel;  
	* For each pixel within the distance of 10 on the same line in the right image:  
		* Get the neighborhood of same size in the right image;  
		* Calculate Sum-of-Square Differences and store it in an array;  
	* Sort the SSD array in ascending order;  
	* Get the best matching index;  
	* Calculate the disparity d = left image index – right image index;  
* End  
