How to use Video Compression System
==============================

1.Check whether there are 14 MATLAB scripts.

2.These scripts are written using MATLAB 2018a.
   (Sometimes versions below MATLAB 2018a will not be supported.)

3.Copy the video to be compressed into the file which containing 
   those 14 MATLAB scripts.

4.Open "Encode_Video.m" script.

5.Replace 'XXXXXX.mp4' with the name of the video to be 
   compressed in the line,"Original_Video = VideoReader('XXXXXX.mp4');".

6.Run "Encode_Video.m" script.

7.After finishing it,check whether the following files have been 
   created.
   "Dict_Residual_P_Frames.mat","Motion_Vectors.mat" & 
   "Residual_Frames_Including_I_Frame.txt"

8.If those files have been created,run "Decode_Video.m" script.

9.After finishing it,you are able to get the compressed video.

Thank you.

=========================
EE596 - Mini Project - E/15/056
=========================