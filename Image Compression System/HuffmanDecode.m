function Decode = HuffmanDecode(Encoded_Data,Dict,N,Row,Column)
    %Perform huffman coding to decode data for a given encode data using given huffman dictionary and size of MB
    Decode = zeros(Row,Column);
    for i = 1:Row/N
        for j = 1:Column/N
            DicI = Dict{i,j};
            Encoded_DataI = Encoded_Data{i,j};
            Decode((i-1)*8+1:(i-1)*8+8,(j-1)*8+1:(j-1)*8+8) =  reshape(huffmandeco(Encoded_DataI,DicI),[N,N]);
        end
    end
end

