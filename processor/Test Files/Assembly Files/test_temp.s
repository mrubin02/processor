nop
nop
nop
nop
nop
nop
#150000 register  
addi $r20, $r0, 50000 
addi $r20, $r20, 50000
addi $r20, $r20, 50000
# 256000 register
addi $r21, $r0, 50000 
addi $r21, $r21, 50000
addi $r21, $r21, 50000
addi $r21, $r21, 50000
addi $r21, $r21, 50000
addi $r21, $r21, 6000
# 30000 register 
addi $r22, $r0, 30000 
# 200000 register 
addi $r23, $r0, 50000 
addi $r23, $r23, 50000 
addi $r23, $r23, 50000 
addi $r23, $r23, 50000 
#100000
addi $r24, $r0, 50000 
addi $r24, $r24, 50000
button_off: 
add $r7, $r0, $r20
add $r3, $r0, $r22
add $r4, $r0, $r22
stall 5000000
branch: 
addi $r5, $r0, 0
addi $r6, $r0, 0
blt $r0, $r1, dance1
blt $r0, $r2, dance2
j branch
dance1:
add $r7, $r0, $r24
addi $r5, $r0, 1 
add $r3, $r0, $r21
add $r4, $r0, $r21
stall 5000000
add $r3, $r0, $r22
add $r4, $r0, $r22 
stall 5000000
dance1_loop: 
blt $r0, $r2, dance2
blt $r0, $r8, button_off
j dance1_loop
dance2:
addi $r6, $r0, 1
add $r3, $r0, $r21
add $r4, $r0, $r21
stall 5000000
add $r7, $r0, $r23
add $r3, $r0, $r22
add $r4, $r0, $r22 
stall 5000000
add $r7 $r0, $r24
stall 2000000
dance2_loop: 
blt $r0, $r1, dance1
blt $r0, $r8, button_off
j dance2_loop