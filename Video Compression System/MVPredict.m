function Predicted_Frame = MVPredict(P_Frame,Motion_Vectors,N)
    %Perform motion vetor prediction
    [Row,Column] = size(P_Frame);
    Predicted_Frame = zeros(Row,Column);
    for i = 1:N:Row
        for j = 1:N:Column
            MV = Motion_Vectors{ceil(i/N),ceil(j/N)};
            MV_Row = MV(1,1);
            MV_Column = MV(1,2);
            Predicted_Frame(i:i+N-1,j:j+N-1) = P_Frame(MV_Row:MV_Row+N-1,MV_Column:MV_Column+N-1);  
        end
    end
end