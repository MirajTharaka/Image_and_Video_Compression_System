How to use Image Compression System
==============================

1.Check whether there are 9 MATLAB scripts.

2.These scripts are written using MATLAB 2018a.
   (Sometimes versions below MATLAB 2018a will not be supported.)

3.Copy the image to be compressed into the file which containing 
   those 9 MATLAB scripts.

4.Open "Encode_Image.m" script.

5.Replace 'XXXXXX.jpg' with the name of the image to be 
   compressed in the line,"Original_Image = imread('XXXXXX.jpg');".

6.Run "Encode_Image.m" script.

7.After finishing it,check whether the following files have been 
   created.
   "Dict.mat" & "Encode_Data.txt"

8.If those files have been created,run "Decode_Image.m" script.

9.After finishing it,you are able to get the compressed image.

Thank you.

=========================
EE596 - Mini Project - E/15/056
=========================