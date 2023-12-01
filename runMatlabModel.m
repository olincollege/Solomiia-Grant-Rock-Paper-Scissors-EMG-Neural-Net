function res = runMatlabModel(data)
    %%%
    % This code  takes in live PISON data and prints a 1, 2, or 3 to 
    % represent rock, paper, and scissors respectively. 
    %%%

    %Gather and trim data
    disp(data)
    data = data(1:1400,1:4);

    % Extract Features
    includedFeatures = {'var','wl', 'mav', 'rms', 'iemg', 'ssi', 'ssc', 'mmav'}; 
    
    feature_table = extractFeature(data',includedFeatures);
    
    %Plot Features for debug

    % figure(1)
    % var = table2array(feature_table(:,1:4));
    % title('Variance')
    % plot(var)
    % hold on
    % 
    % figure(2)
    % wl = table2array(feature_table(:,5:8));
    % title('Wavelength')
    % plot(wl)
    % hold on 
    % 
    % figure(3)
    % mav = table2array(feature_table(:,9:12));
    % title('Mean Absolute Value')
    % plot(mav)
    % hold on 
    % 
    % figure(4)
    % rms = table2array(feature_table(:,13:16));
    % title('Root Mean Square')
    % plot(rms)
    % hold on 
    % 
    % figure(5)
    % iEMG = table2array(feature_table(:,17:20));
    % title('Integrated EMG')
    % plot(iEMG)
    % hold on 
    % 
    % figure(6)
    % ssi = table2array(feature_table(:,21:24));
    % title('Simple Square Integral')
    % plot(ssi)
    % hold on 
    % 
    % figure(7)
    % ssc = table2array(feature_table(:,25:28));
    % title('Simple Slope Change')
    % plot(ssc)
    % hold on 
    % 
    % figure(8)
    % imav = table2array(feature_table(:,29:32));
    % title('Improved Mean Absolute Value')
    % plot(imav)
    % hold on 

    %Use Trained model to classify data
    load("currentClassifier.mat")
    res = currentClassifier.predict(feature_table);
end