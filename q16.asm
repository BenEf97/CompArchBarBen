.macro Terminate
li $v0,10
syscall
.end_macro

.data 0x10010000
T: .space 2000
Allice: .asciiz "Allice.txt"
AlliceU: .asciiz "AlliceU.txt"
a: .ascii "a"
z: .ascii "z"
.text

#open Allice.txt
li $v0,13 #open file
la $a0,Allice #Read Allice.txt
li $a1,0 
li $a2,0
syscall
move $t0,$v0

#open AlliceU.txt
li $v0,13 #open file
la $a0,AlliceU #Read AlliceU.txt
li $a1,0 
li $a2,0
syscall
move $t1,$v0

jal ReadFile

#open AlliceU.txt
#loop:
#read from Allice.txt 500 tav
#check if a<=tav<=z
#if yes replace
#Write to AlliceU.txt

li $v0,16 #close file
syscall
Terminate #end program


ReadFile:
move $a0,$v0 #$a0=$v0 to save file descriptor
li $v0,14 #read file
la $a1,T #pointer for address
li $a2,500 #maximum to read, check at debug
syscall
move $t6,$v0
jr $ra


WriteFile:
move $a0,$t1 #$a0=$t1 for file descriptor for AlliceU
la $a1,T #load buffer address for $a1
move $a2,$t6 #load num of characters to write to $a2
li $v0,15 #read file
syscall
jr $ra

#Replace:
#blt $t5,a,end #if $t5<a then jump to end
#blt z,$t5,end #if $t5>z then jump to end
#addi $t5,$t5,-32 #lower case character was found, sub 32 to get Upper case
#end:
#jr $ra
