
# Template project 

This is Final project for the course EE2003 at IIT Madras.
## Contributers
* EE19B098 MUHAMMED HISHAM
* EE19B041 MUHAMED ZAMEEL
* EE19B111 RESHMA AIYAPPAN

## Problem statement
This project aims to optimize the nanojpeg decoder which runs on picorv32 processor using hardware accelerator approach

## How to run

### Step 1 - Clone the repo
```sh
$ git clone 
```
### Step 2 -  Generate a suitable input
```sh
$ cd firmware
$ python3 jpg2hex.py kitten.jpg > jpg.hex
```
### Step 3 - Build and run with verilator
```sh
$ make test_verilator
```
### Step 4 - View the output
When you run the code, you will see that it generates a file named `output.dump` in the main `nanojpeg` folder. Rename this file as `output.ppm` and open it to view the decoded image.