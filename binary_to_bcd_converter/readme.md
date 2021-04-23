# Binary to BCD Converter

This circuit takes a binary number of N bits and transform it into a set of BCD digits

While a binary number consisting of only four bits can be easily converted to a BCD representation using a combinatorial circuit, an arbitrary length binary number requires to follow an algorithm. Such algorithm requires to shift each of the bits in the binary number and to conditionally apply a transformation (excess 3) to each BCD digit (group of 4 bits).

The pseudo code of this algorithm is shown below

````python
#
# 	Binary to BCD convertion algorithm
#
binary_number[N -1: 0] <-- value to convert		# N bits unsigned binary number
bcd_digits[4M - 1 : 0] <-- 0's              	# each bcd_digit has 4 bits

for i in N-1 to 0:
    # apply transformation to each BCD digit, if required
   	for bcd_digit in bcd_digits:
        bcd_digit = (bcd_digit > 4)? bcd_digit + 3: bcd_digit;

    # shift to the left the pair [bcd_digits | binary_number]
    bcd_digits      <<= 1
    bcd_digits[LSB] = binay_number[MSB]
	binary_number   <<= 1
````



The following table illustrates the algorithm for the binary number: 1110 0111 0011 (3699 base 10). You should note that the 'transform' step, when not required, leaves each BCD digit without change.

![](D:\home\ework\vhdl\binary_to_bcd_converter\resources\images\paper_example.png)

## General Component Diagram

The following diagram show the interface of the circuit



![image-20210423075908532](C:\Users\g2marco\AppData\Roaming\Typora\typora-user-images\image-20210423075908532.png)



The clock and reset signal are general signal (they are common to all components). The 'nconvert' signal tells the component when to start a new conversion of the value present in the 'data' inputs. When the conversion ends, the 'bcd_digits' output present an stable outcome. This value is hold until a new conversion is requested. This general process is depicted in the diagram below. 

![image-20210423085845922](C:\Users\g2marco\AppData\Roaming\Typora\typora-user-images\image-20210423085845922.png)

## Top - Down Design

The diagram below show the internal blocks forming this component. Each block is responsible of one single task. The conversion process is controlled by the 'control' block. First, directs the 'load-sfhit' block to load the data that will be converted and to shifts its value as needed. Then indicates the 'binary to bcd' block to perform the transform and shift steps in the 'bcd_digits', or to hold de current value until another conversion starts.

 ![image-20210423093341746](C:\Users\g2marco\AppData\Roaming\Typora\typora-user-images\image-20210423093341746.png)



### Simulation of the LOAD_SHIFT block

DATA = 0011 0011 0011 0011 B 

![image-20210423094937208](C:\Users\g2marco\AppData\Roaming\Typora\typora-user-images\image-20210423094937208.png)



### Simulation of the BINARY_TO_BCD block

DATA = 1110 0111 0011 (3699 d) , this is the same value of the example

N= 12 bits

M = 4 BCD digits 

![image-20210423100831141](C:\Users\g2marco\AppData\Roaming\Typora\typora-user-images\image-20210423100831141.png)



### Simulation of the CONTROL block