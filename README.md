Wynalda Code File Generator
=============

[![Build status](https://ci.appveyor.com/api/projects/status/vvqjnnaqhi7xx4k6)](https://ci.appveyor.com/project/KyleChamberlin/wynalda-codes)

This program will take as input a file with a single code of arbitrary length and create an inkjet file which has two lines a line for the code, and a line for the break mark.

Using the Program
-----------------

All you need to do is drag a code file onto the executable file. you will then be prompted for the pertinent values needed to fulfil the order. In the even that you enter an invalid value you will be prompted again. 

Running the tests
-----------------

This project uses the [Micro Unit Testing Framework](github.com/AutoItMicro/MicroUnitTestingFramework), from [AutoItMicro](github.com/AutoItMicro). This framework is integrated via a git submodule. in order to activate this submodule, you need to run the following command after pulling down your source.

    git submodule update --init --recursive

the if you run the Tests.au3 file in the tests folder, the console should display the status of each of the tests.

Testing Framework
-----------------

We are using the Micro Unit Testing Framework for AutoIT. 