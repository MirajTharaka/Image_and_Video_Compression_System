function Gray_Scale_Image = Padding(GrayScale_Image,N)
    %Perform array padding for given gary scale image data 
    [Row,Column] = size(GrayScale_Image);
    if rem(Row,N) == 0
        Gray_Scale_Image = GrayScale_Image;
    else
        Pad_Row = N-rem(Row,N);
        Pad_Column = N-rem(Column,N);
        Gray_Scale_Image = padarray(GrayScale_Image,[Pad_Row Pad_Column],'replicate','post');
    end     
end

   