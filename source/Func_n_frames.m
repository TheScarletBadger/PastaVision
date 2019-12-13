function [flast] = Func_n_frames(obj)
    flast = floor(obj.Duration*obj.FrameRate);
    pass = 0;
    while pass == 0
        try
            x = read(obj,(flast));
            pass = 1;
        catch
            flast = flast-1;
        end
    end
end

