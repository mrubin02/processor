# r3 is left hand 
# r11 is right hand 
#r7 is middle guy 
#r9 is up down guy 

nop
nop
nop
nop
nop
nop
#150000 register  STOP 
addi $r20, $r0, 50000 
addi $r20, $r20, 50000
addi $r20, $r20, 50000
# 256000 register std 180 
addi $r21, $r0, 50000 
addi $r21, $r21, 50000
addi $r21, $r21, 50000
addi $r21, $r21, 50000
addi $r21, $r21, 50000
addi $r21, $r21, 6000
# 30000 register std 0 
addi $r22, $r0, 50000 
# 200000 register CW
addi $r23, $r0, 50000 
addi $r23, $r23, 50000 
addi $r23, $r23, 50000 
addi $r23, $r23, 50000 
#100000 CCW
addi $r24, $r0, 50000 
addi $r24, $r24, 50000
off: 
addi $r5, $r0, 0
addi $r6, $r0, 0
add $r7, $r0, $r20 
add $r3, $r0, $r22 
off_loop: 
blt $r0, $r1, dance1
blt $r0, $r2, dance2
j off_loop
dance1:
addi $r5, $r0, 1 
add $r3, $r0, $r21 
add $r10, $r0, $r21
add $r7, $r0, $r23
add $r9, $r0, $r21
add $r11, $r0, $r21
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
add $r3, $r0, $r22 
add $r10, $r0, $r22
add $r9, $r0, $r22 
add $r11, $r0, $r22
add $r7, $r0, $r24
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
stall 5000000
blt $r0, $r8, off
blt $r0, $r2, dance2
j dance1
dance2:
addi $r6, $r0, 1
add $r3, $r0, $r21
add $r11, $r0, $r21
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
add $r3, $r0, $r22
add $r11, $r0, $r22
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
add $r7, $r0, $r24 
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
add $r7, $r0, $r20
add $r9, $r0, $r21
add $r10, $r0, $r21
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
add $r9, $r0, $r22
add $r10, $r0, $r22
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
stall 5000000
blt $r0, $r8, off
blt $r0, $r1, dance1
j dance2