%--------------------------------------------------------------------------
%EE596 - Mini Project - Design Image & Video Compression System - E/15/056
%Image Compression System - Image Decoding Process
%--------------------------------------------------------------------------
%================= Read ReadMe.txt before run the script =================%
%--------------------------------------------------------------------------

N = 8; %Size of MB
Q_mat = [18,21,25,25,25,25,25,25;25,21,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25]; %Quantization matrix
Q_fac = 1; %Quality factor
Q_Mat = Q_fac*Q_mat;

%Load created huffman dictionary
load('Dict.mat'); 
Dict_Size = size(Dict);
Row_N = Dict_Size(1);
Column_N = Dict_Size(2);

%Read encode data from text file
File2 = fopen('Encode_Data.txt');
Data1 = textscan(File2,'%s','delimiter',','); 
Data2 = reshape(Data1{1,1},Column_N,Row_N);
Data3 = transpose(Data2);
Encoded_Data = cell(Row_N,Column_N);
for i = 1:Row_N
    for j = 1:Column_N
        Data4 = Data3{i,j};
        Data5 = size(Data4);
        Data6 = zeros(Data5(2),1);
        for k = 1:1:Data5(2)
            Data6(k,1) = str2num(Data4(1,k)); 
        end
        Encoded_Data{i,j} = Data6; 
    end   
end

%Perform huffman coding for decoding encode data
Decode = HuffmanDecode(Encoded_Data,Dict,N,(Row_N*N),(Column_N*N));

%Perform dequantization
Dequantized_Image = Dequantize(N,Decode,Q_Mat);

%Perform inverse discrete cosine transform
IDCT_Image = IDCT(Dequantized_Image,N);

%Get compressed image
imwrite(IDCT_Image,'Compressed Image.jpg')
figure(3);
imshow(IDCT_Image);
title('Compressed Image')

%--------------------------------------------------------------------------