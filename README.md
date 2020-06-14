# Architecture Project

## Objective

To design and implement a simple 5-stage pipelined processor, Harvard Architecture.
The design should conform to the ISA specification described in the following sections.

## Introduction

The processor in this project has a RISC-like instruction set architecture. There are eight 4-byte
general purpose registers; R0, till R7. Another two general purpose registers, one works as program
counter (PC). And the other, works as a stack pointer (SP); and; hence, points to the top of the
stack. The initial value of SP is (2^12-1). The memory address space is 4 KB of 16-bit width and
is word addressable. (N.B. word = 2 bytes). The bus between memory and the processor is
(16-bit or 32-bit) widths for instruction memory and 32-bit widths for data memory
When an interrupt occurs, the processor finishes the currently fetched instructions (instructions that
have already entered the pipeline), then the address of the next instruction (in PC) is saved on top of
the stack, and PC is loaded from address [2-3] of the memory (the address takes two words). To
return from an interrupt, an RTI instruction loads PC from the top of stack, and the flow of the
program resumes from the instruction after the interrupted instruction. Take care of corner cases
like Branching,Push,POP.

## ISA Specifications

### A) Registers

```
 R[0:7]<31:0> ; Eight 32-bit general purpose registers
 PC<31:0>     ; 32-bit program counter
 SP<31:0>     ; 32-bit stack pointer
 CCR<3:0>     ; condition code register
 Z<0>:=CCR<0> ; zero flag, change after arithmetic, logical, or shift operations
 N<0>:=CCR<1> ; negative flag, change after arithmetic, logical, or shift operations
 C<0>:=CCR<2> ; carry flag, change after arithmetic or shift operations.
 ```
 
### B) Input-Output

```
IN.PORT<31:0>   ; 32-bit data input port
OUT.PORT<31:0>  ; 32-bit data output port
INTR.IN<0>      ; a single, non-maskable interrupt
RESET.IN<0>     ; reset signal
```

### C) Notations 

```
Rsrc1 ; 1st operand register
Rsrc2 ; 2nd operand register
Rdst  ; result register
EA    ; Effective address (20 bit)
Imm   ; Immediate Value (16 bit)
```
### Some instructions will Occupy more than one memory location

![1](https://user-images.githubusercontent.com/44317150/84581966-3dd9f900-ade6-11ea-8e57-753ee808d2d6.PNG)

![2](https://user-images.githubusercontent.com/44317150/84581999-aa54f800-ade6-11ea-8a17-31d225994e26.PNG)

![4](https://user-images.githubusercontent.com/44317150/84582008-cc4e7a80-ade6-11ea-9af5-b08482c7163e.PNG)

![5](https://user-images.githubusercontent.com/44317150/84582023-f9029200-ade6-11ea-94a1-8a497fe4f2d5.PNG)

![6](https://user-images.githubusercontent.com/44317150/84582048-2f401180-ade7-11ea-95d7-c595946eaee7.PNG)


## OP-Code Distribution
![image](https://user-images.githubusercontent.com/44317150/84581827-847b2380-ade5-11ea-8741-14b5f15a3cfe.png)

![image](https://user-images.githubusercontent.com/44317150/84582069-631b3700-ade7-11ea-8d07-02d28ebf6e9e.png)

![image](https://user-images.githubusercontent.com/44317150/84582075-729a8000-ade7-11ea-8c41-d2b1138c7a4c.png)

![image](https://user-images.githubusercontent.com/44317150/84582076-7f1ed880-ade7-11ea-8da6-1a700e0d612f.png)

# Schematic Diagram For The Processor
![Architecture_Project_Diagram](https://user-images.githubusercontent.com/44317150/84582099-e177d900-ade7-11ea-8de6-c92bd6cb8206.jpg)

# Assembler For The Processor
It translate from assembly to machine code corresponding to my op-code distribution 
## How to use the assembler
### 1) 
After downloading the [Assembler](https://github.com/SamyBahaa/Assembler.git) and follow the screen instruction for the setup. when it finished you will find the app icon appear on the desktop like this.
![image](https://user-images.githubusercontent.com/44317150/84598574-00b84a00-ae6c-11ea-8d8d-7772c58e4288.png)

### 2)
Open the Assembler and it shoud look like this after the splash screen is over
![image](https://user-images.githubusercontent.com/44317150/84598592-33fad900-ae6c-11ea-8c4f-6d4056289d74.png)
![image](https://user-images.githubusercontent.com/44317150/84598608-55f45b80-ae6c-11ea-8f82-8e2dbe4a4d40.png)

### 3)
Click on browse and choose the the file that containe your assembly code if it was .asm or .txt
![image](https://user-images.githubusercontent.com/44317150/84598648-9358e900-ae6c-11ea-8127-d3ffe6a0402a.png)

### 4)
Once you choose your file that containe your assembly code click on complie and if every thing went well this window should appear
![image](https://user-images.githubusercontent.com/44317150/84598714-05c9c900-ae6d-11ea-8124-efc52cd69830.png)

### 5) 
The output of the assembler is 2 mem file that you will need to initialize the instruction memory and data memory of the processor. We have to separate file because we implement our processor using harvard architecture which have to separate memory one for data and other for instructions. It should look like this.
![image](https://user-images.githubusercontent.com/44317150/84598832-c780d980-ae6d-11ea-9ae1-327697b0d3ac.png)






