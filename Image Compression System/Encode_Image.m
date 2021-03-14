%--------------------------------------------------------------------------
%EE596 - Mini Project - Design Image & Video Compression System - E/15/056
%Image Compression System - Image Encoding Process
%--------------------------------------------------------------------------
%================= Read ReadMe.txt before run the script =================%
%--------------------------------------------------------------------------

%Input image for compression
Original_Image = imread('Wave.jpg'); 

N = 8; %Size of MB
Q_mat = [18,21,25,25,25,25,25,25;25,21,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25]; %Quantization matrix
Q_fac = 1; %Quality factor
Q_Mat = Q_fac*Q_mat;

imwrite(Original_Image,'RGB Image.jpg');
figure(1);
imshow(Original_Image)
title('Original Image')

GrayScale_Image = rgb2gray(Original_Image);

%Perform array padding
Gray_Scale_Image = Padding(GrayScale_Image,N);
[Row,Column] = size(Gray_Scale_Image); 

imwrite(Gray_Scale_Image,'Gray Scale Image.jpg');
figure(2);
imshow(Gray_Scale_Image);
title('Gray Scale Image or Image to be Compressed')

%Perform discrete cosine transform
DCT_Image = DCT(Gray_Scale_Image,N);

%Perform quantization
Quantized_Image = round(Quantize(DCT_Image,Q_Mat,N),0);

%Perform huffman coding for creating huffman dictionary and encode data 
[Dict,Encode] = HuffmanEncode(Quantized_Image,N);

%Save huffman dictionary
save('Dict.mat','Dict');

%Write encode data to a text file
File1 = fopen('Encode_Data.txt','w');
for i = 1:(Row/N)
    for j = 1:(Column/N)
        fprintf(File1,num2str(Encode{i,j}));
        fprintf(File1,',');
    end
end    
fclose(File1);

%--------------------------------------------------------------------------