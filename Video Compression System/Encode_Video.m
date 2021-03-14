%--------------------------------------------------------------------------
%EE596 - Mini Project - Design Image & Video Compression System - E/15/056
%Video Compression System - Video Encoding Process
%--------------------------------------------------------------------------
%================= Read ReadMe.txt before run the script =================%
%--------------------------------------------------------------------------

%Input video for compression
Original_Video = VideoReader('Wave.mp4');

N = 8; %MB size
Q_mat = [18,21,25,25,25,25,25,25;25,21,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25]; %Quantization matrix
Q_fac = 1; %Quality factor
Q_Mat = Q_fac*Q_mat;
No_Frames = 10; %No. of frames
Frame_Size = [184,320]; %Size of frame

%Break video into given no. of frames
for Frame = 1:No_Frames
    Frame_Name=strcat('Frame',num2str(Frame),'.jpg');
    RGB_Frame = read(Original_Video,Frame);
    GrayScale_Frame = rgb2gray(RGB_Frame);
    Gray_Scale_Frame = imresize(GrayScale_Frame,Frame_Size);
    imwrite(Gray_Scale_Frame,Frame_Name);
end
VFrames  = cell(1,No_Frames);
VFrames_Names = cell(1,No_Frames);
for i = 1:No_Frames
    VFrames_Names{1,i} = strcat('Frame',num2str(i),'.jpg');
end
for j = 1:No_Frames
    VFrames{1,j} = imread(VFrames_Names{1,j}); 
end
for k = 1:No_Frames
   Frame = uint8(VFrames{1,k});
end
VFrames_Size = size(VFrames{1,1});
Height = VFrames_Size(1);
Width = VFrames_Size(2);

%Encode and decode I frame
I_Frame = imread('Frame1.jpg');
[Dict_I_Frame,Encode_I_Frame] = EncodeFrame(I_Frame,Q_Mat,N);
Decode_I_Frame = DecodeFrame(Encode_I_Frame,Dict_I_Frame,Q_Mat,N,Height,Width);
for i = 1:No_Frames
    Frame_Names{1,i} = strcat('Frame',num2str(i),'.jpg') ;
end
for j = 1:No_Frames
    Frames{1,j} = imread(Frame_Names{1,j}); 
end

%Calculate motion vectors
[Dict,Encode] = EncodeFrame(Frames{1,1},Q_Mat,N);
Decoded_I_Frame = DecodeFrame(Encode,Dict,Q_Mat,N,Height,Width);
[Predicted_Frames,Motion_Vectors] = MVCal(Decoded_I_Frame,No_Frames,N);
Predicted_Frames{1,1} = Frames{1,1};

%Get residual of P frames
Residual_P_Frame = cell(1,No_Frames);
for i = 1:No_Frames
    Residual_P_Frame{1,i} = double(Frames{1,i}) - double(Predicted_Frames{1,i});
end

%Encode residual of P frames
Dict_Residual_P_Frames = cell(1,No_Frames);
Encode_Residual_P_Frames = cell(1,No_Frames);
for i = 2:No_Frames
    [Dict_Residual_P_Frame,Encode_Residual_P_Frame] = EncodeFrame(Residual_P_Frame{1,i},Q_Mat,N);
    Dict_Residual_P_Frames{1,i} = Dict_Residual_P_Frame; 
    Encode_Residual_P_Frames{1,i} = Encode_Residual_P_Frame;
end
Encode_Residual_P_Frames{1,1} = Encode_I_Frame;

%Write encode data to a text file
File1 = fopen('Residual_Frames_Including_I_Frame.txt','w');
for l = 1:No_Frames
    Data = Encode_Residual_P_Frames{1,l};
    for i = 1:Height/N
        for j = 1:Width/N       
            fprintf(File1,num2str(Data{i,j}));
            fprintf(File1,',');  
        end
    end
    fprintf(File1,'*');
end
fclose(File1);

%Save huffman dictionary for residual of P frames and motion vectors
Dict_Residual_P_Frames{1,1} = Dict_I_Frame ;
save('Dict_Residual_P_Frames.mat','Dict_Residual_P_Frames');
save('Motion_Vectors.mat','Motion_Vectors');

%--------------------------------------------------------------------------