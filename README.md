# VHDL

## Counter
- This is an up-counter with variable range. once the start signal gets triggered, it starts counting from zero to its maximum range. In the given below image, its a 3-bit counter ranging from 0 to 7.
  
![seq_det](https://github.com/DineshReddy2k/VHDL_projects/blob/main/counter.png)

## Package
- A package is a block of code which allows us to share and reuse code across multiple design units. This blocks generally consists of constants, types, sub programs, functions etc. Package is divided into two parts. Package declaration and package body.
- In the above given example, i defined a seven segment function in package with its implementation in the package body and re-used it in the different (using_pkg) module.

## Circular Ring buffer
- A circular ring buffer is a fixed size memory for storing a continuous sequence of fixed data size elements.
- It Operates like a queue, where new elements overwrite the oldest ones when the buffer is full.
- Contains two primary pointers:
- Write pointer: Tracks where new data is written.
- Read pointer: Tracks where data is read from.
- When the write pointer reaches the end, it wraps around to the beginning. Ensures efficient use of space by reusing memory.
  
![seq_det](https://github.com/DineshReddy2k/VHDL_projects/blob/main/ring_buffer.png)

## Traffic Light controller
- This project is a basic traffic light controller which holds different signals based on the input timer given for each traffic signal.
  
![seq_det](https://github.com/DineshReddy2k/VHDL_projects/blob/main/traffic_light_ctrl.png)
