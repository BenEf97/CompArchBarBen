.macro Terminate
li $v0,10
syscall
.end_macro

.data 0x10040000
B: .space 80


.text
jal Data_Block #init 0x10020000 with random numbers
la $t3,B #loads address of B to $t3

#copying loop from 0x10020000 to 0x10040000
loop3:
lw  $t4,0($t0) # loads address value to $t4
sw $t4,0($t3) #store $t4 value at $t3
addi $t0,$t0,4 #t0+=4
addi $t3,$t3,4 #$t3+=4
bne $t0,$t2,loop3 #if $t0!=$t2 then jump to loop3

Terminate #close the program
