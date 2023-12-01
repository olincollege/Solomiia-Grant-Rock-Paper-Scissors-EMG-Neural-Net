# Solomiia Grant Rock Paper Scissors EMG Neural Net
 
This project uses EMG data from a PISON wristband to predict rock paper scissors hand gestures with a neural net.

To create the neural net, open "(1)LoadFiles.mlx", change the file path to direct to the "Test_Data" and run the file.
After that run "(2)MakeFeatureTable.mlx" and "(3)OfflineClassification.mlx" in order and the neural net will be trained.

To use live classification, you must set up the PISON pipeline following the instruction shown here: https://github.com/smichalka/Neurotech2023/blob/main/README.md 

Once the PISON device is connected, run this command in terminal and follow the prompts to being live rock paper scissors classification.
python3 testData.py --matlabmodel <path/to/runMatlabModel.m>