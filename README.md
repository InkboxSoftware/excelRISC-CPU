# Excel 8-Bit RISC CPU
The Excel 8-Bit RISC CPU repository contains the following main files:
```
RISC-CPU.xlsx - The main spreadsheet which contains the CPU
ROM.xlsx - The ROM spreadsheet read by the RISC-CPU excel file
ISA-SRISC.xlsx - CPU's ISA documentation
compileExcelASM8.py - The Excel-ASM8 compiler
Excel-ASM8.xml - Markdown for the Excel-ASM8 language compatible with Notepad++
Other sample programs to be found in the assembler folder
```

The RISC-CPU.xlsx file features an 8-bit RISC CPU running a 10 instruction ISA. The system has 1 register, a stack, 1KB RAM, 1KB ROM, and a 16x16 64-color display.

**Excel note: Iterative Calcuation must be turned on.** This can be done by going to File -> Options -> Formulas -> then Enable Iterative Calculation. Remember to **set Maximum Iterations to 1**
**The ROM.xlsx file path must also be updated**

The CPU runs off a clock signal set in B2. This clock signal will update under the normal conditions of recalculation within an Excel spreadsheet. Pressing the F9 key will recalculate the spreadsheet. 

The Reset Button in the L2 cell, if set to true, will reset the PC register, stack, and RAM back to 0. 

The computer in the CPU.xlsx file can be controlled either in automatic or manual mode. This is controlled by the button in F2. If set to true, when the clock signal from B2 is high, then the CPU will carry out the operation specified in the override slot. If false, then the CPU will execute the operation retrieved from ROM at the address specified by the PC register. 

The CPU is designed to run according to the instruction set architecture specified in the ISA-SRISC.xlsx spreadsheet. 

Press the F9 key to update the CPU clock. Hold down the F9 key to run a program at full speed. 

To assemble a program using the compileExcelASM8.py assembler into an excel spreadsheet:
```
  py compileExcelASM8.py [program.s] ROM.xlsx
```

Excel-ASM8 has only 10 instructions. The assembler is not case sensitive. Both decimal and hexadecimal numbers are supported.

#### LDI
```
  LDI #102     ; load value 102 into register
  LDI $FF      ; load value 255 into register
  LDI VAR      ; load value specified by variable VAR
```
#### PUSH
```
  PUSH        ; pushes current register value onto top of stack
              ; value still remains in register
              ; stack pointer is decreased
```
#### POP
```
  POP         ; pops top of stack into register
              ; stack pointer is increased
```
#### LDR
```
  LDR         ; uses the value at the top of stack as address to read value into register from ROM
              ; pops top of stack and increases stack pointer
```
#### STR
```
  STR         ; uses register's value as the RAM address to store the value in top of the stack
              ; pops top of stack and increases stack pointer
```
#### ADD
```
  ADD         ; adds the register's value, top of stack, and the carry flag, stored in the register
              ; pops top of stack and increases stack pointer
```
#### CMP
```
  CMP #01
  CMP $F0     ; compares register's value to the immediate operand in the instruction, only affecting the system's Carry/Zero flag
```
#### BGE
```
  BGE LABEL   ; if the Carry/Zero flag is set then the system will jump to the label
  BGE $30     ; the immediate value is a signed byte in range from -128 to 127.
              ; any referenced label must be in that range
```
#### CLC
```
  CLC         ; sets system Carry/Zero flag to 0
```
#### SEC
```
  SEC         ; sets system Carry/Zero flag to 1
```

Given that the system's register is only 8-bytes wide, in order to address the full 1KB of RAM the 0th memory cells acts as the current working block number 0 to 7.
All LDR/STR specified addresses less than 128 will always access the block 0. Any address greater than or equal to 128 will add ((blockNumber * 128) - 128) to the specified address.
Blocks 6 and 7 of RAM control the screen's pixels, with 1 pixel per memory cell. Only 64 colors are provided in conditional formatting. 

### Color Palette
The following image represents the system's color palette: 

![colorPalLarge](https://github.com/user-attachments/assets/25e8bf40-2cf9-426e-9b05-d1a96365e03f)

Example setting the 1st and last pixels to color $0F (red).
```
  ;SET PAGE TO 6
  LDI $06
  PUSH
  LDI $00
  STR      ;PAGE NOW SET TO 6
  ;STORE IN FIRST PIXEL OF SCREEN
  LDI $0F    ;RED
  PUSH
  LDI $80    ;128 WILL BE SUBTRACTED FROM THIS ADDRESS, SO $80 IS EQUIVLENT TO ADDRESSING THE ROM BLOCK'S Oth MEMORY CELL
  STR

  ;SET PAGE TO 7
  LDI $07
  PUSH
  LDI $00
  STR     ;PAGE NOW SET TO 7
  ;STORE PIXEL IN LAST CELL
  LDI $0F  ;RED
  PUSH
  LDI $FF
  STR
```


## Psuedo Instructions
### Labels
```
  LOOP:          ; loop name followed by colon
    LDI #01
    PUSH
    LDI #02
    CLC
    ADD
    SEC
    BGE LOOP      ; jumps back to the label named LOOP
```
### Variables
```
  VAR = #244    ; all variables must be less than 255
  F00 = $01
```

### ORG
```
  ORG $100		; sets the location of the next instruction to the immediate value operand in range from 0 to 1023
				      ; specified value must be further than the current length of program
```
### INC
```
  INC "file.bin"	; copies the binary file into the program starting from the current address of this instruction
```

