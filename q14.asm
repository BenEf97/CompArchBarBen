.macro Terminate
li $v0,10
syscall
.end_macro

.data 0x10010000
A: .space 80 #reserving space
output: .asciiz "Please Enter a number to find at the array: "

.text
jal Data_Block #init 0x10010000 with random numbers
li $v0,4 #set up print
la $a0, output
syscall #prints the string
li $v0,5 #call for input from user
syscall #input call
move $a0,$0 #a0=0
Loop14:
lw $t3,0($t0) #$t3=$t0[i]
bne $t3,$v0,check
addi $a0,$a0,1 #$a0++
check:
addi $t0,$t0,4 #$t0+=4
bne $t0,$t2,Loop14

li $v0,1 #set up print
syscall #prints the result

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

