function DCT_Image = DCT(Gray_Scale_Image,N)
    %Perform discrete cosine transform for a given gray scale image using given size of MB
    [Row,Column] = size(Gray_Scale_Image);
    DCT_Image = zeros(Row,Column);
    for i = 1:N:Row
        for j = 1:N:Column
            DCT_Image(i:i+N-1,j:j+N-1) = dct2(Gray_Scale_Image(i:i+N-1,j:j+N-1));
        end
    end
end

