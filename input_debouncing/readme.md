# Input De-bouncing

This circuit takes a digital input, typically driven by an input element (push-button or switch) and de-bounces its value (it avoids any unwanted glitches occurring while switching the input element)

When a switch or push button is operated, we can see the output voltage does not transition sharply from one value to the other. Instead, voltage goes up and down while the input element makes an stable contact in the new position.



The following table illustrates the algorithm for the binary number: 1110 0111 0011 (3699 base 10). You should note that the 'transform' step, when not required, leaves each BCD digit without change.

<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/paper_example.png" /></p>


## General Component Diagram

The following diagram show the interface of the circuit



<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/component_interface.png" />




The clock and reset signal are general signal (they are common to all components). The 'nconvert' signal tells the component when to start a new conversion of the value present in the 'data' inputs. When the conversion ends, the 'bcd_digits' output present an stable outcome. This value is hold until a new conversion is requested. This general process is depicted in the diagram below. 

<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/interface_waveforms.png" /></p>

## Top - Down Design

The diagram below show the internal blocks forming this component. Each block is responsible of one single task. The conversion process is controlled by the 'control' block. First, directs the 'load-sfhit' block to load the data that will be converted and to shifts its value as needed. Then indicates the 'binary to bcd' block to perform the transform and shift steps in the 'bcd_digits', or to hold de current value until another conversion starts.

<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/block_diagram.png" /></p>



### Simulation of the LOAD_SHIFT block

DATA = 0011 0011 0011 0011 B 

<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/simulation_load_shift.png" /></p>



### Simulation of the BINARY_TO_BCD block

DATA = 1110 0111 0011 (3699 d) , this is the same value of the example

N= 12 bits

M = 4 BCD digits 

<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/simulation_binary_to_bcd.png" /></p>



### Simulation of the CONTROL block

<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/simulation_controlador.png" /></p>



### Simulation of the Component

Please compare this simulation waveforms with the the sketched waveform presented during the explanation of the component. They look alike.

<p align="center"><img src="https://raw.githubusercontent.com/g2marco/vhdl/main/binary_to_bcd_converter/resources/images/simulation_binary_bcd_converter.png" /></p>

