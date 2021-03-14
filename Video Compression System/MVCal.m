function [Predicted_Frames,Motion_Vectors] = MVCal(Decoded_I_Frame,No_Frames,N)
    %Perform motion vector calculation 
    Motion_Vectors = cell(1,No_Frames);
    Frame_Names = cell(1,No_Frames);
    Frames = cell(1,No_Frames);
    Predicted_Frames = cell(1,No_Frames);
    for i = 1:No_Frames
        Frame_Names{1,i} = strcat('Frame',num2str(i),'.jpg');
    end
    for j = 1:No_Frames
        Frames{1,j} = imread(Frame_Names{1,j}); 
    end
    Predicted_Frames{1,1} = Decoded_I_Frame;
    for k = 2:No_Frames 
        if k == 2 
            Predicted_Frame = Decoded_I_Frame;
        else 
            Predicted_Frame = Predicted_Frames{1,k-1};
        end
        Motion_Vectors{1,k} = SADCal(Predicted_Frame,Frames{1,k},N);
        Predicted_Frames{1,k} =  MVPredict(Predicted_Frame,Motion_Vectors{1,k},N);
    end
end