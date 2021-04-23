# Hardware Description with  VHDL
This repository contains examples of digital circuits described with VHDL. This examples include

* binay_to_bcd_converter

  This is a configurable binary to BCD converter, using the the shift and excess 3 algorithm. 



## Directory Structure

A vendor independent directory structure is used for all of them, as shown below:

````python
/<project>
	/constraints
    /src
    /tests
    readme.md
````



- **readme.md** describes the circuit, its purpose and how the implementation is meant to work

- **/src** directory contains  VHDL source code files describing the circuit
- **/constraints** directory contains any constraint files used for generating the bitstream (by default, we use the Basys3 development board' constraint files)

- **/tests** may contain a subdirectory for each implemented test. Each of the test subfolders could include all the resources required for running an specific test.



## Important

- I share the VHDL code in this repository in order to help any one learning this HDL.
- This code is offered without any guarantee
- I'm not responsible of any damage the use of this code may cause. Use at your own risk!



## Log of changes

[04/21/2021] 

* This repository is created and the binaray_to_bcd_converted is included