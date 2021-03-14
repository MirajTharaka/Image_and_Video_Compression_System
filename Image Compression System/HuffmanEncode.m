function [Dict,Encode] = HuffmanEncode(Quantized_Image,N)
    %Perform huffman coding and create huffman dictionary and encode data for a given quantized image and size of MB
    [Row,Column] = size(Quantized_Image);
    Encode = cell(Row/N,Column/N);
    Dict = cell(Row/N,Column/N);
    for i = 1:N:Row
        for j = 1:N:Column
            Image = Quantized_Image(i:i+N-1,j:j+N-1);
            if nnz(Image) == 0
                Image(1,1) = 1;
                [g,~,Intensity_val] = grp2idx(Image(:));
                Frequency = accumarray(g,1);
                Probability = Frequency./(N*N) ;
                DictIB = huffmandict(Intensity_val,Probability);
                Encode{floor(i/N)+1,floor(j/N)+1} = huffmanenco(Image(:),DictIB);
                Dict{floor(i/N)+1,floor(j/N)+1} = DictIB;
            else
                [g,~,Intensity_val] = grp2idx(Image(:));
                Frequency = accumarray(g,1);
                Probability = Frequency./(N*N) ;
                DictIB = huffmandict(Intensity_val,Probability);
                Encode{floor(i/N)+1,floor(j/N)+1} = huffmanenco(Image(:),DictIB);
                Dict{floor(i/N)+1,floor(j/N)+1} = DictIB;
            end
        end
    end
end