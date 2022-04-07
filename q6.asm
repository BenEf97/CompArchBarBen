.macro Terminate
li $v0,10
syscall
.end_macro

.data  0x10010000
A: .space 80

.text

jal Data_Block #init 0x10010000 with random numbers
lw $t3,0($t0) # min
loop5:
addi $t0,$t0,4 #$t0+=4
lw $t1,0($t0) #current
blt $t1,$t3,L #if $t3<$t1 then jump to L
j check #else
L: move $t3,$t1 #min=cuurent
check:bne $t0,$t2 loop5 #if $t0!=$t2 jump to loop5,else done

li $v0,1 #print set up
la $a0,0($t3)
syscall
Terminate #close the program




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
