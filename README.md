This repository contains supporting code and data for manuscript [Marchingo et al., Antigen affinity, costimulation, and cytokine inputs sum linearly to amplify T cell expansion, Science, 2014].

It is assumed that you have read the paper, know what Cyton model is and what different parameters of the model mean. This readme file comments on the structure of the repository and helps in using the software for your data. If you have any further requests regarding the software, please contact Andrey Kan at akan (+ @ + wehi.edu.au ).

***
The software is implemented in MATLAB, and in order to run it you will need MATLAB with statistics, optimization and parallel computing toolboxes. It is recommended to have at least MATLAB R2012a, the code was not tested on earlier versions. It is also recommended to run software on Windows. The code was not tested on a Mac.
***

The code in [cyton fitter 6.1.5] folder implements the Cyton model computation and an automated data fitting procedure. This code can be used in two modes. First, you can implement various data fitting scenarios using scripts (e.g., fitting different datasets using different starting parameters), and run scripts automatically. You will require MATLAB proficiency in order to use this option. Second, you can use a graphical user interface (GUI) to fit each dataset either manually or automatically.

---------------------------------------
USING THE SCRIPTS

Examples of fitting scripts can be found in files [randstart.m], [varctx.m], and [boostrap.m]. These 3 files are provided exactly as they were used for the paper. File [run_fitting.m] is the main entry point that iterates over the datasets and run each of the scripts. For demonstration purposes, the main file is configured so that it reads data from [input] folder and writes the output to the current folder. The script files are well commented, and the code for the main file is straightforward. Please contact me if you have difficulties with customising the files for your purposes.

---------------------------------------
INPUT FILES

For each dataset, the input contains two files. A file with measurements and a file with allowed parameter ranges. For historical reasons, the former file must be an [.xlsx], and the latter must be an [.xls] file.

The [input] folder contains an example of real data and parameter ranges files as used in the paper. In this case, this is the dataset used to produce Figure S4.A-C and Supplementary Table S4 in the paper. Furthermore, file [input/data_format_explained.xlsx] explains the data format further using some mock data.

The parameter ranges are specified in the second sheet of the parameter ranges file. The first sheet specify starting parameter values. These starting values are ignored if the fitting scenario uses randomized starting values.

Locking means lock parameter value to a constant, and fixing means allowing the parameter to vary but ensure that all conditions/concentrations within the dataset have the same value.

---------------------------------------
OUTPUT FILES

Main script [run_fitting.m] will produce output in the current folder. File [settings.mat] will store required fitting settings (such as the fields of "scriptSettings" variable in [bootstratp.m]). This file is primarily useful when using the fitter with a GUI (next section), because it will allow to remember positions of windows. When the fitter is run through the scripts, the scripts will override the fitting settings each time anyway.

Next, [run_fitting-log.txt] will contain logs all output to MATLAB console. Finally, the [results-*] folder for each input dataset will contain fitting results. There will be a sub-folder for each fitting script. Furthermore, there will be a sub-folder for each fitting iteration. Importantly, [randstart/top_fitted.xlsx] will contain the fitted parameters for the top five fitting attempts (parameters are in rows starting from the second row, the first row shows the value of the objective function); and [bootstrap/summary.xls] contain confidence intervals for the fitted parameters. Note that the scripts use a random number generator, and the results will vary from run to run unless you reset the random stream before running the scripts.

---------------------------------------
USING THE GRAPHICAL USER INTERFACE

Open MATLAB environment and set current folder to [cyton fitter 6.1.5]. Then in MATLAB console execute command > fitter_multi_gui

Use [import data] button to load the data file. You can use [load parameters] button to load starting parameter values and parameter ranges, but if you don't use this button, default values will be loaded.

Locking means lock parameter value to a constant, and fixing means allowing the parameter to vary but ensure that all conditions/concentrations within the dataset have the same value.

You can use [plot] button to plot the data, and [fit] button to automatically fit the data using current parameter values as a starting point.

---------------------------------------
CREDITS

This software has been developed at the laboratory of Prof. Phil Hodgkin at the Walter and Eliza Hall Institute in collaboration with Prof. Ken Duffy of Hamilton Institute, National University of Ireland Maynooth.

Matlab code was written by Cameron Wellard, Andrey Kan, and Damian Pavlyshyn.

Past and present members of the Hodgkin Lab who contributed to developing, evaluating and modifying the theory and algorithms on which the code is based:

Amanda Gett, Elissa Deenick, Brendan See, Hilary Todd, Carel van Gend, Ming Chang, Edwin Hawkins, Marian Turner, Mark Dowling, John Markham, Mirja Hommel, Julia Marchingo, Jie Zhou, and Su Heinzel.