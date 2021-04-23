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



The following table illustrates the algorithm for the binary number: 1110 0111 0011 (3699 base 10)

![image-20210422233900056](C:\Users\g2marco\AppData\Roaming\Typora\typora-user-images\image-20210422233900056.png)



# Block Diagram

The following blocks are used in order to implement this circuit