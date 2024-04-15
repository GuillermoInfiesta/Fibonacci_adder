A Fibonacci-eqsue adder done for a computers design course last year.

This component receives two inputs which represent the start of the operation.
  num1: First number. num2 : Second number.
The component creates a Fibonacci sequence using those 2 numbers as seeds instead of using the common 0 and 1.
IMPORTANT: num1 needs to be smaller than num2, as it represents the first number of the sequence, so it cannot
be bigger than the second.

Maquina_Fibonacci has a Fib_Validout output which represents if the operation was completed without errors or not, 
if an error ocurrs (eg: non valid inputs) Fib_Validout will be false. The other output, Fib_Out, will return the 
value of each number of the sequence. 
There´re also 2 generics, M & N, these represent the number of desired sequence numbers and the size (in bits)
of the inputs and output respectively.

The design was done with the Nexys4ddr board in mind, if the board is different the clk constrain may need to 
be readjusted to meet the board capabilities.
