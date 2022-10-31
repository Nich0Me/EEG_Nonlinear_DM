function [Outcome, MatPlot] = FindDesignMatrix(Create_design)
%% This function divide the the EEG Decoding Matrix in partitions.
%% 'Sub_Distance' and 'Add_Distance' divide the decoding matrices according to the feature space distance between configurations
%% 'Sub_Category' and 'Add_Category' divide the decoding matrices according to the category of the configurations
%% 'Sub_Boundary_Sun', 'Sub_Boundary_Rain', 'Add_Boundary_Sun' and 'Add_Boundary_Rain' partition the decoding matrix by comparing conﬁgurations predicting the same outcome with either the same or different feature values.

counter=1;
for k = 1:5
    for j = 1:5
        ConfValueSub(counter) = abs(k-j);
        ConfValueAdd(counter) = abs(6-(k+j));
        counter = counter+1;
    end
end

mat_sim = zeros(25,25);
counter=1;
for k=1:25
    for j=1:25
        if j<=k

        else
            conf1S = ConfValueSub(k);
            conf2S = ConfValueSub(j);

            conf1A = ConfValueAdd(k);
            conf2A = ConfValueAdd(j);

            if strcmp(Create_design,'Sub_Category')
                if ((conf1S == 0 | conf1S == 1) & (conf2S == 0 | conf2S == 1)) | ((conf1S > 1) & (conf2S > 1))
                    Outcome(counter) = 1;
                else
                    Outcome(counter) = 2;
                end

            elseif strcmp(Create_design,'Sub_Boundary_Sun')
                if (conf1S == 0 & conf2S == 0) | (conf1S == 1 & conf2S == 1)
                    Outcome(counter) = 1;
                elseif (conf1S == 1 & conf2S == 0) | (conf1S == 0 & conf2S == 1)
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end

            elseif strcmp(Create_design,'Diff_SunRain')
                if (conf1S == 2 & conf2S == 2) | (conf1S == 1 & conf2S == 1)
                    Outcome(counter) = 1;
                elseif (conf1S == 1 & conf2S == 2) | (conf1S == 2 & conf2S == 1)
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end

            elseif strcmp(Create_design,'Sub_Boundary_Rain')
                if (conf1S == 2 & conf2S == 2) | (conf1S == 3 & conf2S == 3) | (conf1S == 4 & conf2S == 4)
                    Outcome(counter) = 1;
                elseif (conf1S == 2 & conf2S > 2) | (conf1S > 2 & conf2S == 2)...
                        | (conf1S == 3 & (conf2S == 2 | conf2S == 4)) | (conf2S == 3 & (conf1S == 2 | conf1S == 4))...
                        | (conf1S == 4 & (conf2S == 2 | conf2S == 3)) | (conf2S == 4 & (conf1S == 2 | conf1S == 3))
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end

            elseif strcmp(Create_design,'Sub_Distance')
                if abs(conf1S-conf2S) == 0 | abs(conf1S-conf2S) == 1
                    Outcome(counter) = 1;
                else
                    Outcome(counter) = 2;
                end


            elseif strcmp(Create_design,'WithinDiff')
                if abs(conf1S-conf2S) == 0
                    Outcome(counter) = 1;
                elseif abs(conf1S-conf2S) > 0
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end

            elseif strcmp(Create_design,'WithinAdd')
                if conf1A==conf2A
                    Outcome(counter) = 1;
                elseif abs(conf1A-conf2A) > 0
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end


            elseif strcmp(Create_design,'Add_Distance')
                if abs(conf1A-conf2A) == 0 | abs(conf1A-conf2A) == 1
                    Outcome(counter) = 1;
                else
                    Outcome(counter) = 2;
                end

            elseif strcmp(Create_design,'Add_Category')
                if ((conf1A == 1 | conf1A == 0) & (conf2A == 1 | conf2A == 0)) | ((conf1A > 1) & (conf2A > 1))
                    Outcome(counter) = 1;
                else
                    Outcome(counter) = 2;
                end

            elseif strcmp(Create_design,'Add_Boundary_Sun')
                if (conf1A == 1 & conf2A == 1) | (conf1A == 0 & conf2A == 0) 
                    Outcome(counter) = 1;
                elseif (conf1A == 1 & conf2A == 0) | (conf1A == 0 & conf2A == 1) 
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end

             elseif strcmp(Create_design,'Add_SunRain')
                if (conf1A == 1 & conf2A == 1) | (conf1A == 2 & conf2A == 2) 
                    Outcome(counter) = 1;
                elseif (conf1A == 1 & conf2A == 2) | (conf1A == 2 & conf2A == 1) 
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end

             elseif strcmp(Create_design,'Add_Boundary_Rain')
                if (conf1A == 2 & conf2A == 2) | (conf1A == 3 & conf2A == 3) | (conf1A == 4 & conf2A == 4) 
                    Outcome(counter) = 1;
                elseif (conf1A == 2 & conf2A > 2) | (conf1A > 2 & conf2A == 2)...
                        | (conf1A == 3 & (conf2A == 2 | conf2A == 4)) | (conf2A == 3 & (conf1A == 2 | conf1A == 4))...
                        | (conf1A == 4 & (conf2A == 2 | conf2A == 3)) | (conf2A == 4 & (conf1A == 2 | conf1A == 3))
                    Outcome(counter) = 2;
                else
                    Outcome(counter) = 0;
                end
            end
            MatPlot(k,j) = Outcome(counter);
            counter = counter+1;
        end
    end
end