function [Motion_Vectors,SAD_Val] = SADCal(Frame1,Frame2,N)
    %Perform sum of absolute differences calculation
    [Row,Column] = size(Frame1);
    Motion_Vectors = cell(Row/N,Column/N);
    SAD_Val = cell(Row/N,Column/N);
    for i = 1:N:Row
        for j = 1:N:Column
            Frame2_Block = Frame2(i:i+N-1,j:j+N-1);
            Previous_SAD = 10000;
            MV = zeros(1,2);
            for k = 1:N:Row
                for l = 1:N:Column  
                    Frame1_Block = Frame1(k:k+N-1,l:l+N-1);
                    Delta = abs(double(Frame2_Block)-double(Frame1_Block));
                    SAD = sum(Delta(:));
                    if (SAD<Previous_SAD)
                        Previous_SAD = SAD; 
                        MV(1,1) = k;
                        MV(1,2) = l;
                    end
                end
            end
            SAD_Val{ceil(i/N),ceil(j/N)} = Previous_SAD; 
            Motion_Vectors{ceil(i/N),ceil(j/N)} = MV;
        end
    end
end