function [Dict,Encode] = EncodeFrame(Frame,Q_Mat,N)
    %Perform frame encoding using the functions created for image compression
    DCT_Frame = DCT(Frame,N); %Perform discrete cosine transform
    Quantized_I_frame = Quantize(DCT_Frame,Q_Mat,N); %Perform quantization
    [Dict,Encode] = HuffmanEncode(Quantized_I_frame,N); %Perform huffman coding for creating huffman dictionary and encode data
end