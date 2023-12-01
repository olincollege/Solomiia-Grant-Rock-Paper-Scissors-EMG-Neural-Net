function [feature_table] = extractFeatures(dataChTimeTr,includedFeatures)
    
    % List of channels to include (can change to only use some)
    includedChannels = 1:size(dataChTimeTr,1);
    
    % Empty feature table
    feature_table = table();
    datapoints = size(dataChTimeTr, 3); 

    
    for f = 1:length(includedFeatures)

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Calcuate feature values for 
        % fvalues should have rows = number of trials
        % usually fvales will have coluns = number of channels (but not if
        % it is some comparison between channels)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        % Check the name of each feature and hop down to that part of the
        % code ("case" is like... in the case that it is this thing.. do
        % this code)
        switch includedFeatures{f}

            % Variance  
            % variance represents the average squared deviation of the
            % signal from the mean. In this case, the signal is all of the
            % timepoints for a single channel and trial.
            %(fvalues = trials x channels)
            case 'var'
                fvalues = squeeze(var(dataChTimeTr,0,2))';
      
            % Waveform Length 
            % represents the sum of amplitide changes between adjecent data
            % indicates the degree of cange in amplitude of the signal
            %(fvalues = trials x channels)
            case 'wl'
                 fvalues = zeros(datapoints, 4);
                 fvalues(:, 1) = (sum(abs(diff(reshape(dataChTimeTr(1, :, :), [1400, datapoints]))))).';
                 fvalues(:, 2) = (sum(abs(diff(reshape(dataChTimeTr(2, :, :), [1400, datapoints]))))).';
                 fvalues(:, 3) = (sum(abs(diff(reshape(dataChTimeTr(3, :, :), [1400, datapoints]))))).';
                 fvalues(:, 4) = (sum(abs(diff(reshape(dataChTimeTr(4, :, :), [1400, datapoints]))))).';

            %Mean Absolute Values 
            case 'mav'
                fvalues = zeros(datapoints, 4);
                 l = length(dataChTimeTr(1, 1, :));
                 fvalues(:, 1) = sum(abs(reshape(dataChTimeTr(1, :, :), [1400, datapoints])))/l;
                 fvalues(:, 2) = sum(abs(reshape(dataChTimeTr(2, :, :), [1400, datapoints])))/l;
                 fvalues(:, 3) = sum(abs(reshape(dataChTimeTr(3, :, :), [1400, datapoints])))/l;
                 fvalues(:, 4) = sum(abs(reshape(dataChTimeTr(4, :, :), [1400, datapoints])))/l;
                 
            % Root Mean Square 
            % can be used to meausre power fo EMG and the energy of a
            % signal 
            % Can be used to determine to muscle production 
            case 'rms'
                 fvalues = zeros(datapoints, 4);
                 l = length(dataChTimeTr(1, 1, :));
                 fvalues(:, 1) = sqrt(sum(reshape(dataChTimeTr(1, :, :), [1400, datapoints]).^2))/l;
                 fvalues(:, 2) = sqrt(sum(reshape(dataChTimeTr(2, :, :), [1400, datapoints]).^2))/l;
                 fvalues(:, 3) = sqrt(sum(reshape(dataChTimeTr(3, :, :), [1400, datapoints]).^2))/l;
                 fvalues(:, 4) = sqrt(sum(reshape(dataChTimeTr(4, :, :), [1400, datapoints]).^2))/l;

            % Inegrated EMG 
            % The integrated EMG (IEMG) is typically used as a starting point
            % detection index associated with the electromyography signal 
            % sequence emission point, represented as the sum of the absolute 
            % values of the EMG signal amplitude
            case "iemg"
                  fvalues = zeros(datapoints, 4);
                  fvalues(:, 1) = sum(abs(reshape(dataChTimeTr(1, :, :), [1400, datapoints])));
                  fvalues(:, 2) = sum(abs(reshape(dataChTimeTr(2, :, :), [1400, datapoints])));
                  fvalues(:, 3) = sum(abs(reshape(dataChTimeTr(3, :, :), [1400, datapoints])));
                  fvalues(:, 4) = sum(abs(reshape(dataChTimeTr(4, :, :), [1400, datapoints])));

            % Simple Square Integral 
            %The simple square integral (SSI) uses the energy of the electromyography signal 
            % as the EMG feature, which represents the sum of the squares of the electromyography 
            % signal amplitudes
            case "ssi"
                  fvalues = zeros(datapoints, 4);
                  fvalues(:, 1) = sum(reshape(dataChTimeTr(1, :, :), [1400, datapoints]).^2);
                  fvalues(:, 2) = sum(reshape(dataChTimeTr(2, :, :), [1400, datapoints]).^2);
                  fvalues(:, 3) = sum(reshape(dataChTimeTr(3, :, :), [1400, datapoints]).^2);
                  fvalues(:, 4) = sum(reshape(dataChTimeTr(4, :, :), [1400, datapoints]).^2);
                  
            %The SSC counts the number of changes in the data symbols in the signal sequence, 
            % which is another way to denote the frequency information of the electromyography 
            % signal. At the same time, in order to avoid the effects of background noise 
            % in the electromyography signal, it can use a threshold function to generate positive and 
            % negative slope changes between three consecutive segments.
            case "ssc"
                   fvalues = zeros(datapoints, 4);
                   ssc = (abs(diff(reshape(dataChTimeTr(1, :, :), [1400, datapoints]))));
                   for i = 1:1:length(ssc)
                       if ssc(i) < 0.05
                           ssc(i) = 0;
                       end 
                   end 
                   fvalues(:, 1) = sum(ssc).';
                   ssc = (abs(diff(reshape(dataChTimeTr(2, :, :), [1400, datapoints]))));
                   for i = 1:1:length(ssc)
                       if ssc(i) < 0.05
                           ssc(i) = 0;
                       end 
                   end 
                   fvalues(:, 2) = sum(ssc).';
                   ssc = (abs(diff(reshape(dataChTimeTr(3, :, :), [1400, datapoints]))));
                   for i = 1:1:length(ssc)
                       if ssc(i) < 0.05
                           ssc(i) = 0;
                       end 
                   end 
                   fvalues(:, 3) = sum(ssc).';
                   ssc = (abs(diff(reshape(dataChTimeTr(4, :, :), [1400, datapoints]))));
                   for i = 1:1:length(ssc)
                       if ssc(i) < 0.05
                           ssc(i) = 0;
                       end 
                   end 
                   fvalues(:, 4) = sum(ssc).';
             

            %The improved mean absolute value (MAV) represents an extension of the MAV feature, 
            % and the weighted window function wi added in the equation can improve the robustness 
            % of the MAV feature
            case "mmav"
                fvalues = zeros(datapoints, 4);
                 l = length(dataChTimeTr(1, 1, :));
                 mav = abs(reshape(dataChTimeTr(1, :, :), [1400, datapoints]));
                 for i = 1:1:length(ssc)
                       if (0.25*l <= mav(i)) && (mav(i) <= 0.075*l)
                           mav(i) = mav(i);
                       else
                           mav(i) = mav(i)./2;
                       end 
                 end 
                 fvalues(:, 1) = sum(mav)/l;
                 mav = abs(reshape(dataChTimeTr(2, :, :), [1400, datapoints]));
                 for i = 1:1:length(ssc)
                       if (0.25*l <= mav(i)) && (mav(i) <= 0.075*l)
                           mav(i) = mav(i);
                       else
                           mav(i) = mav(i)./2;
                       end 
                 end 
                 fvalues(:, 2) = sum(mav)/l;
                 mav = abs(reshape(dataChTimeTr(3, :, :), [1400, datapoints]));
                 for i = 1:1:length(ssc)
                       if (0.25*l <= mav(i)) && (mav(i) <= 0.075*l)
                           mav(i) = mav(i);
                       else
                           mav(i) = mav(i)./2;
                       end 
                 end 
                 fvalues(:, 3) = sum(mav)/l;
                 mav = abs(reshape(dataChTimeTr(4, :, :), [1400, datapoints]));
                 for i = 1:1:length(ssc)
                       if (0.25*l <= mav(i)) && (mav(i) <= 0.075*l)
                           mav(i) = mav(i);
                       else
                           mav(i) = mav(i)./2;
                       end 
                 end 
                 fvalues(:, 4) = sum(mav)/l;


            otherwise
                % If you don't recognize the feature name in the cases
                % above
                disp(strcat('unknown feature: ', includedFeatures{f},', skipping....'))
                break % This breaks out of this round of the for loop, skipping the code below that's in the loop so you don't include this unknown feature
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Put feature values (fvalues) into a table with appropriate names
        % fvalues should have rows = number of trials
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        % If there is only one feature, just name it the feature name
        if size(fvalues,2) == 1
            feature_table = [feature_table table(fvalues,...
                'VariableNames',string(strcat(includedFeatures{f})))];
        
        % If the number of features matches the number of included
        % channels, then assume each column is a channel
        elseif size(fvalues,2) == length(includedChannels)
            %Put data into a table with the feature name and channel number
            for  ch = includedChannels
                feature_table = [feature_table table(fvalues(:,ch),...
                    'VariableNames',string(strcat(includedFeatures{f}, '_' ,'Ch',num2str(ch))))]; %#ok<AGROW>
            end
        
        
        else
        % Otherwise, loop through each one and give a number name 
            for  v = 1:size(fvalues,2)
                feature_table = [feature_table table(fvalues(:,v),...
                    'VariableNames',string(strcat(includedFeatures{f}, '_' ,'val',num2str(v))))]; %#ok<AGROW>
            end
        end
    end


    

end