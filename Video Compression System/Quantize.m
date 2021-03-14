function Quantized_Image = Quantize(DCT_Image,Q_Mat,N)
    %Perform quantization for a given dct performed image using given quantization matrix and size of MB
    [Row,Column] = size(DCT_Image);
    Quantized_Image = zeros(Row,Column);
    for x = 1:N:Row
        for y = 1:N:Column
            Image  = DCT_Image(x:x+N-1,y:y+N-1);
            Temp = zeros(N,N);
            for i = 1:N
                for j = 1:N
                    Temp(i,j) = Image(i,j)/Q_Mat(i,j);           
                end
            end
            Quantized_Image(x:x+N-1,y:y+N-1) = round(Temp);
        end
    end
end