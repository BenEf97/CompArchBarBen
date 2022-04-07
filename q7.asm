.macro Terminate
li $v0,10
syscall
.end_macro

.data 0x10010000
A: .space 80 #reserving space

.text
jal Data_Block #init 0x10010000 with random numbers
Loop7:
lw $t3,0($t0) #even index
lw $t4,4($t0) #odd index
sw $t3,4($t0) #store $t0+4 value at $t3
sw $t4,0($t0) #store $t0 value at $t4
addi $t0,$t0,8 #$t0+=8
bne $t0,$t2,Loop7

Terminate #end program


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

