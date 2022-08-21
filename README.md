This is Final project for the course EE2003(Computer Architecture and organisation) at IIT Madras.

This project aims to optimize the nanojpeg decoder which runs on picorv32 processor using hardware accelerator approach. In the process of decoding jpeg images to ppm using nanojpeg decoder, the botteleneck is identified as the inverse DCT calculation part. Thus the whole process is accelerated just by optimising the IDCT calcuations using FPGA. 

## How to run
### Step 1 - Clone the repo
```sh
$ git clone "https://github.com/hisham-hariz/NanoJpeg"
```
### Step 2 -  Generate a suitable input
You can give any jpeg image as input by running the following command on your terminal. An example is given wiz kitten.jpeg 
```sh
$ cd firmware
$ python3 jpg2hex.py kitten.jpg > jpg.hex
```
### Step 3 - Build and run with verilator
The below commmand will automatically run the nanojeg c code in riscv processor and do the IDCT calculations in the hardware designed in verilog.
```sh
$ make test_verilator
```
### Step 4 - View the output
When you run the code, you will see that it generates a file named `output.dump` in the main `nanojpeg` folder. Rename this file as `output.ppm` and open it to view the decoded image.
