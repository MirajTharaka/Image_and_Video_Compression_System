function Dequantized_Image = Dequantize(N,Decode,Q_Mat)
    %Perform dequantization for a given decode data using given quantization matrix and size of MB
    [Row,Column] = size(Decode);
    Dequantized_Image = zeros(Row,Column);
    for x = 1:N:Row
        for y = 1:N:Column
            Image  = Decode(x:x+N-1,y:y+N-1);
            Temp = zeros(N,N);
            for i = 1:N
                for j = 1:N
                    Temp(i,j) = Image(i,j)*Q_Mat(i,j);
                end
            end
            Dequantized_Image(x:x+N-1,y:y+N-1) = Temp;
        end
    end
end