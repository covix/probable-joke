============
Introduction
============
    This page contains software and instructions for Canonical Time Warping
    (CTW) [2] and Generalized Time Warping (GTW) [1]. In addition, we provide
    implementations of the dynamic time warping (DTW) [3], derivative
    dynamic time warping (DDTW) [4], iterative motion warping (IMW) [5] as
    baselines. In order to align more than two sequences, we extended DTW,
    DDTW, IMW and CTW to pDTW, pDDTW, pIMW and pCTW respectively by adopting the
    framework of Procrustes analysis [6]. Most of the functions have been
    written and documented in Matlab format. In addition, we provided C++
    implementations for some functions.


============
Installation
============
    1. unzip ctw.zip to your folder;
    2. Run make.m to compile all C++ files;
    3. Run addPath.m to add sub-directories into the path of Matlab.
    4. Run demoXXX.m or testXXX.m

    
============
Instructions
============
    The package of ctw.zip contains following files and folders:

    ./data:       This folder contains a subset of CMU Grand Challenge
                  dataset, CMU Mocap dataset, Weizmann Action dataset and an
                  accelerometer sequence.

    ./src:        This folder contains the main implementation of CTW, GTW and other baseline methods.

    ./lib:        This folder contains some necessary library functions.

    ./make.m:     Matlab makefile for C++ code.

    ./addPath.m:  Adds the sub-directories into the path of Matlab.

    ./demoToy.m:  A demo comparison of different alignment methods on aligning two synthetic sequences. 
                  This is a similar function used for visualizing (Fig. 3) the first experiment (Sec 5.1) in the CTW paper [2].

    ./demoKit.m:  A demo of using CTW on aligning two CMU Grand Challenge mocap sequences.
                  This is the same function used for visualizing (Fig. 4) the second experiment (Sec 5.2) in the CTW paper [2].

    ./demoToys.m: A demo comparison of different alignment methods on aligning three synthetic sequences.
                  This is the same function used for visualizing (Fig. 4) the first experiment (Sec 5.2) in the GTW paper [1].

    ./demoWeis.m: A demo comparison of different alignment methods on aligning three Weizmann video sequences with different features.
                  This is the same function used for visualizing (Fig. 5) the second experiment (Sec 5.3) in the GTW paper [1].

    ./demoMix.m:  A demo of using GTW on aligning three multi-modal sequences (Mocap, video, and Accelerator)
                  This is the same function used for visualizing (Fig. 6) the third experiment (Sec 5.4) in the GTW paper [1].

    ./testToy.m:  Test alignment methods on aligning two synthetic sequences 100 times.
                  This is a similar function used for reporting (Fig. 3h) the first experiment (Sec 5.1) in the CTW paper [2].

    ./testToys.m: Test alignment methods on aligning three synthetic sequences 100 times.
                  This is the same function used for reporting (Fig. 4g) the first experiment (Sec 5.2) in the GTW paper [1].

    ./testWeis.m: Test alignment methods on aligning three Weizmann video sequences 10 times.
                  This is the same function used for reporting (Fig. 5h) the second experiment (Sec 5.3) in the GTW paper [1].



========
C++ Code
========
    For each C++ code, we provide its corresponding Matlab version. For
    instance, you can use "dtwFordSlow.m" instead of "dtwFord.cpp". They
    have the same interface in both input and output. The C++ code is
    faster to obtain result while the Matlab version is easier to
    understand and debug.


==========
References
==========
    [1] F. Zhou and F. De la Torre, "Generalized Time Warping for
    Multi-modal Alignment of Human Motion," in CVPR, 2012.

    [2] F. Zhou and F. De la Torre, "Canonical time warping for
    alignment of human behavior", Neural Information Processing Systems
    (NIPS), 2009.
    
    [3] L. Rabiner and B. Juang, "Fundamentals of speech recognition,"
    Prentice Hall, 1993.
    
    [4] E. J. Keogh and M. J. Pazzani, "Derivative Dynamic Time Warping,"
    in SDM, 2001.
    
    [5] E. Hsu, K. Pulli and J. Popovic, "Style Translation for Human
    Motion," ACM Trans. Graph., vol. 24, pp. 1082-1089, 2005.
    
    [6] I. L. Dryden and K. V. Mardia, "Statistical shape analysis",
    Wiley, 1998.


=========
Copyright
=========    
    This software is free for use in research projects. If you
    publish results obtained using this software, please use this
    citation.

    @inproceedings{ZhouD12,
       author    = {Feng Zhou and Fernando {De la Torre}},
       title     = {Generalized Time Warping for Alignment of Human Motion},
       booktitle = {CVPR},
       year      = {2012},
    }

    If you have any question, please feel free to contact Feng Zhou
    (zhfe99@gmail.com).
