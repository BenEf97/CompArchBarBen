.macro Terminate
li $v0,10
syscall
.end_macro

.data  0x10040000
B: .space 80  
C: .space 80


.text

#init first block
la $t3,B #loads address of B to $t3
jal Data_Block #init 0x10020000 with random numbers
#copying loop from 0x10020000 to 0x10040000
loop3:
lw  $t4,0($t0) # loads address value to $t4
sw $t4,0($t3) #store $t4 value at $t3
addi $t0,$t0,4 #t0+=4
addi $t3,$t3,4 #$t3+=4
bne $t0,$t2,loop3 #if $t0!=$t2 then jump to loop3

#init second block
la $t5,C#loads address of C to $t5
jal Data_Block #init 0x10020000 with random numbers
#copying loop from 0x10020000 to 0x10040000
loop4:
lw  $t6,0($t0) # loads address value to $t4
sw $t6,0($t5) #store $t6 value at $t5
addi $t0,$t0,4 #t0+=4
addi $t5,$t5,4 #$t5+=4
bne $t0,$t2,loop4 #if $t0!=$t2 then jump to loop4

#swapping between the blocks
la $t3,B #loads address of B to $t3
la $t5,C #loads address of C to $t5
addi $t2,$t3,80 # set last address of the block to $t2
loop5:
lw  $t4,0($t3) # loads address value to $t4
lw  $t6,0($t5) # loads address value to $t6
sw $t4,0($t5) #store $t4 value at $t5
sw $t6,0($t3) #store $t6 value at $t3
addi $t5,$t5,4 #t5+=4
addi $t3,$t3,4 #$t3+=4
bne $t3,$t2,loop5 #if $t3!=$t2 then jump to loop5



Terminate #close the program
