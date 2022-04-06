.macro Terminate
li $v0,10
syscall
.end_macro

.data


.text
jal Data_Block #init 0x10020000 with random numbers
lw $t3,0($t0) # max
loop5:
addi $t0,$t0,4 #$t0+=4
lw $t1,0($t0) #current
blt $t3,$t1,L #if $t3<$t1 then jump to L
j check #else
L: move $t3,$t1 #max=cuurent
check:bne $t0,$t2 loop5 #if $t0!=$t2 jump to loop5,else done

li $v0,1 #print set up
la $a0,0($t3)
syscall
Terminate #close the program
