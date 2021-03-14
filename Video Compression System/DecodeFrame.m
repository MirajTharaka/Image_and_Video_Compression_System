function Decoded_Frame = DecodeFrame(Encode_Frame,Dict_Frame,Q_Mat,N,Height,Width)
    %Perform frame decoding using the functions created for image compression
    Decode_Frame = HuffmanDecode(Encode_Frame,Dict_Frame,N,Height,Width); %Perform huffman coding for decoding encode data
    Dequantized_Frame = Dequantize(N,Decode_Frame,Q_Mat); %Perform dequantization
    Decoded_Frame = IDCT(Dequantized_Frame,N); %Perform inverse discrete cosine transform
end