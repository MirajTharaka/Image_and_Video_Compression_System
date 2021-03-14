%--------------------------------------------------------------------------
%EE596 - Mini Project - Design Image & Video Compression System - E/15/056
%Video Compression System - Video Decoding Process
%--------------------------------------------------------------------------
%================= Read ReadMe.txt before run the script =================%
%--------------------------------------------------------------------------

N = 8; %Size of MB
Q_mat = [18,21,25,25,25,25,25,25;25,21,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25;...
        25,25,25,25,25,25,25,25;25,25,25,25,25,25,25,25]; %Quantization matrix
Q_fac = 1; %Quality factor
Q_Mat = Q_fac*Q_mat;

%Load encode data files
load('Dict_Residual_P_Frames.mat');
load('Motion_Vectors.mat');
[R,C] = size(Motion_Vectors);
No_Frames = C;
Size_Dict_Residual_P_Frames = size(Dict_Residual_P_Frames{1,2});
Row_N = Size_Dict_Residual_P_Frames(1);
Column_N = Size_Dict_Residual_P_Frames(2);

%Read encode data from text file
File2 = fopen('Residual_Frames_Including_I_Frame.txt');
Data1 = textscan(File2,'%s','delimiter','*'); 
Data2 = Data1{1,1};
Encoded_Data_Set = cell(1,No_Frames);
for k = 1:No_Frames
    Encoded_Data = ReadTextFile(Data2{k,1},Row_N,Column_N);
    Encoded_Data_Set{1,k} = Encoded_Data ;
end

%Decode frames using encode data
Decoded_Residual_P_Frames = cell(1,No_Frames);
for i = 1:No_Frames
    Decoded_Residual_P_Frames{1,i} = DecodeFrame(Encoded_Data_Set{1,i},Dict_Residual_P_Frames{1,i},Q_Mat,N,Row_N*N,Column_N*N);   
end

%Bulid up predicted frames
Predicted_Frames = cell(1,No_Frames);
Predicted_Frames{1,1} = Decoded_Residual_P_Frames{1,1};
for i = 2:No_Frames
    Predicted_Frames{1,i} = MVPredict(Predicted_Frames{1,i-1},Motion_Vectors{1,i},N);
end

%Construct output frames
Output_Frames = cell(1,No_Frames);
Output_Frames{1,1} = Decoded_Residual_P_Frames{1,1};
for i = 2:No_Frames   
   Output_Frames{1,i} = double(Decoded_Residual_P_Frames{1,i})+double(Predicted_Frames{1,i});  
end

%Get compressed video
Output_Video = VideoWriter('Compressed Video','MPEG-4');
Output_Video.FrameRate = 10;
open(Output_Video);
for l = 1:No_Frames
   Frame = uint8(Output_Frames{1,l});
   writeVideo(Output_Video,Frame);
end
close(Output_Video)

%--------------------------------------------------------------------------