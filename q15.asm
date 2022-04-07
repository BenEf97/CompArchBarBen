.macro Terminate
li $v0,10
syscall
.end_macro

.data 0x10010000
A: .space 80 #reserving space
intro: .asciiz "Enter two numbers and I'll show you the sum, difference, product, quotient, and remainder.\n\nFirst number: "
second: .asciiz "Second number: "
sum: .asciiz "Sum: "
dif: .asciiz "\nDifference: "
prod: .asciiz "\nProduct: "
quot: .asciiz "\nQuotient: "
rem: .asciiz "\nRemainder: "
nodiv: .asciiz "\nCan't divive by 0!"

.text
li $v0,4 #set up print
la $a0, intro #intro string
syscall #prints the string
li $v0,5 #call for input from user
syscall #input call
add $t3,$v0,$0 #$t3=$a0

li $v0,4 #set up print
la $a0, second #intro string
syscall #prints the string
li $v0,5 #call for input from user
syscall #input call
add $t4,$v0,$0 #$t4=$a0

#print sum
li,$v0,4
la,$a0,sum
syscall
add $a0,$t3,$t4 #$a0=$t3+$t4
li $v0,1 #set up print
syscall #prints sum

#print difference
li,$v0,4
la,$a0,dif
syscall
sub $a0,$t3,$t4 #$a0=$t3-$t4
li $v0,1 #set up print
syscall #prints difference

#print product
li,$v0,4
la,$a0,prod
syscall
mul $a0,$t3,$t4 #$a0=$t3*$t4
li $v0,1 #set up print
syscall #prints product


beq $t4,$0,error #check if $t4==0

#print quotient
li,$v0,4
la,$a0,quot
syscall
div $t3,$t4 #$t3/$t4
mflo $a0
li $v0,1 #set up print
syscall #prints quotient

#print remainder
li,$v0,4
la,$a0,rem
syscall
mfhi $a0
li $v0,1 #set up print
syscall #prints remainder
j end

error: #output for dividing by 0
li,$v0,4
la,$a0,nodiv
syscall

end:
Terminate #end program