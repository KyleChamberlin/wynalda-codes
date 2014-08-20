Wynalda Inkjet File Generator
=============================

[![Build status](https://ci.appveyor.com/api/projects/status/vvqjnnaqhi7xx4k6)](https://ci.appveyor.com/project/KyleChamberlin/wynalda-codes)

This program will take as input a file with a single code of arbitrary length and create an inkjet file which has two lines a line for the code, and a line for the break mark.

Using the Program
-----------------

All you need to do is drag a code file onto the executable file. you will then be prompted for the pertinent values needed to fulfil the order. In the even that you enter an invalid value you will be prompted again. 

Testing
-------

### Testing Framework

This project uses the [Micro Unit Testing Framework](github.com/AutoItMicro/MicroUnitTestingFramework), from [AutoItMicro](github.com/AutoItMicro). This framework is integrated via a git submodule. in order to activate this submodule, you need to run the following command after pulling down your source.

    git submodule update --init --recursive

### Running the Tests

To run the tests, simply open the `Tests.au3` file located in the `tests` folder.
Pressing F5 in SciTe will run the currently active script. The test results should display in the console. 
We find it is easiest to view the results if you have your console in a vertical split as apposed to a horizontal split.
You can change this setting under the options menu.

Continuous Integration
----------------------

### AppVeyor

AppVeyor Continuous Integration, is a hosted continuous integration service. We have chosen to integrate with them because the Micro framework we use provides great integrations.
We have setup AppVeyor to build any pull requests, and run the test suite automatically. This provides us with assurances that we will know if a given PR passes the test suite.
This means that even if you are having trouble getting the test suite to run, or if you just want to make a quick change via the github web interface, the test suite will still be run.
AppVeyor uses Windows Azure VMs to build ensuring that each build doesn't know about previous builds. it also helps us developers identify when there are special configurations on our systems that are affecting the building and running of the programs.
