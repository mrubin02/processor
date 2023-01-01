# Processor
## NAME (NETID)
Dane Erickson (dte12)

## Description of Design
The processor is broken down into 5 pipelines (and an additional latch/pipeline specifically for multiplication). 
* Fetch - Gets the next PC from the PC latch and fetches the corresponding instruction from imem. The next PC is calculated here depending on if a branch or jump is taken at a later stage. 
* Decode - Decode the instruction to find the source and destination registers and read the data from those registers from the RegFile. Branches are performed here so they occur before jumps in the execute stage during a race condition. 
* Execute - Execute the desired operation with the data read from the RegFile and using the ALU for calculations and other operations. Multiplication and Division are also conducted here, but they have a separate DP latch at the beginning of their stage to store the operands and instruction. This is because MultDiv takes multiple cycles to operate and must insert nops into the processor while also storing the necessary information. Updated PCs for jumps are calculated here. 
* Memory - If necessary, write the results into Data Memory or read data from Data Memory.
* Writeback - Write the results of either the execute (multdiv) operation or memory operation into the correct destination register. 

## Bypassing
Bypassing is used to quickly send already calculated results straight to a required destination immediately. This processor uses WM bypassing for lw followed by sw, and WX and MX bypassing for execute/alu operations. Additionally, more bypassing was included for XD and MD to handle the branch cases for quick branches that are conducted in the decode stage. 

## Stalling
Stalling occurs when bypassing cannot supply the needed data or extra time is needed for operations. Nops are inserted when there is a load output directed to an ALU input. Additionally, nops are inserted to stall the processor during multiplication and division operations, which take more cycles. Finally, nops are inserted after branches and jumps to clear out the instructions in the earlier stages of the pipeline before the branches and jumps are executed. 
## Optimizations
The processor is optimized using the pipeline, bypass, and stall logic above. This ensures as few nops are inserted as possible and instructions are not waiting around for necessary data. 

## Bugs
There are no known bugs in this processor, and it passes all Gradescope tests. 