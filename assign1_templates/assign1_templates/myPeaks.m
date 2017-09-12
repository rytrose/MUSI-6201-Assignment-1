function [ peaks ] = myPeaks( in_vec )
n = 3;
peaks = zeros(0,1);
i_1 = 1;
i_2 = 1;
prev = in_vec(1);
increasing = in_vec(2) >= in_vec(1);
peaking = false;
mid = ceil(length(in_vec)/2);
while n <= length(in_vec)
    if(~peaking)
        if(increasing)
            %was incresing
            increasing = in_vec(n) >= in_vec(n - 1);
            if(in_vec(n) == in_vec(n - 1))
                peaking = true;
                i_1 = n - 1;
            end
            if(~increasing)
                if(~(n - 1 <= mid && n + 1 >= mid))
                    peaks = vertcat(peaks, n-1);
                end
            end
        else
            %was decreasing
            increasing = in_vec(n) >= in_vec(n - 1);
        end
    else
        if(~(in_vec(n) == in_vec(n - 1)))
            peaking = false;
            increasing = in_vec(n) >= in_vec(n - 1);
            if(~increasing)
                i_2 = n - 1;
                if(~(i_1 -1 <= mid && i_2 + 1 >= mid))
                     peaks = vertcat(peaks, (i_2 + i_1)/2);
                end
            end
        end
    end
    n = n + 1;
end

end

