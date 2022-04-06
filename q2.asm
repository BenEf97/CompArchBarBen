.data 0x10020000
A: .space 80
.globl Data_Block #access from directory folder
#write program to fill data block at 0x10020000 with random numbers word type -50 to 50. use syscall 42
.text
Data_Block:
la $t0,A #load the desired address to $t0
addi $t2,$t0,80 # set last address of the block to $t2
li $a0 ,0x5768 #initlize $a0 with a value
li $a1, 100


loop:
li $v0,42 #puts random numbers at $a0 in range from 0 to 100

syscall
addi $a0,$a0,-50 #subbing 50 from $a0
sw $a0,0($t0) #stores $a0 to $t0
addi $t0,$t0,4 # $t0+=4
bne $t0,$t2,loop # if $t0!=$t2 jump to loop


la $t0,A #load the desired address to $t0, save it later if needed
jr $ra
