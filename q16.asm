.macro Terminate
li $v0,10
syscall
.end_macro

.data 0x10010000
T: .space 2000
Allice: .asciiz "Allice.txt" #Notice! the file must be at the same directory as MIPS.jar
AlliceU: .asciiz "AlliceU.txt"
.text

#open Allice.txt
la $a0,Allice #Read Allice.txt
jal ReadFile

move $t3,$v0
loop:
jal Replace
addi $a1,$a1,1 #a1[i++]
lb $t1,0($a1) #$t1=$a1[i]
bne $t1,$0,loop #buffer!=\0

#open AlliceU.txt
la $a0,AlliceU #Read AlliceU.txt
jal WriteFile


li $v0,16 #close file
syscall
Terminate #end program

#Functions:


ReadFile:
li $v0,13 #open file
li $a1,0 #read only
li $a2,0 
syscall
move $a0,$v0 #$a0=$v0 to save file descriptor
li $v0,14 #read file
la $a1,T #pointer for address
li $a2,2000 #maximum to read, check at debug
syscall
jr $ra


WriteFile:
li $v0,13 #open AlliceU
li $a1,1 #create file if needed
li $a2,0
syscall
move $a0,$v0 #$a0=$t1 for file descriptor for AlliceU
la $a1,T #load buffer address for $a1
move $a2,$t3 #load num of characters to write to $a2
li $v0,15 #read file
syscall
jr $ra

Replace:
lb $t5,0($a1) #$t5=$a1[i]
addi $t8,$0,97 #$t8='a' in ascii
addi $t9,$0,122 #$t9='z' in ascii
blt $t5,$t8,end #if $t5<a then jump to end
bgt $t5,$t9,end #if $t5>z then jump to end
addi $t5,$t5,-32 #lower case character was found, sub 32 to get Upper case
sb $t5,0($a1) #$a1[i]=$t5
end:
jr $ra
