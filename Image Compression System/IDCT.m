function IDCT_Image_uint8 = IDCT(Dequantized_Image,N)
    %Perform inverse discrete cosine transform for a given dequantized image using given size of MB
    [Row,Column] = size(Dequantized_Image);
    IDCT_Image = zeros(Row,Column);
    for i= 1:N:Row
        for j = 1:N:Column
            IDCT_Image(i:i+N-1,j:j+N-1) = idct2(Dequantized_Image(i:i+N-1,j:j+N-1));
        end
    end
    IDCT_Image_uint8 = uint8(IDCT_Image);
end

