function Encoded_Data = ReadTextFile(Data1,Row_N,Column_N)
    %Perform encode data reading in the text file
    Encoded_Data = cell(Row_N ,Column_N);
    Data2 = textscan(Data1,'%s','delimiter',',');
    Data3 = reshape(Data2{1,1},Column_N,Row_N);
    Data4 = transpose(Data3);
    for i = 1:Row_N
        for j = 1:Column_N
            Data5 = Data4{i,j};
            Data6 = size(Data5);
            Data7 = zeros(Data6(2),1);
            for k = 1:1:Data6(2)
                Data7(k,1) = str2num(Data5(1,k));  
            end
            Encoded_Data{i,j} = Data7; 
        end   
    end
end
