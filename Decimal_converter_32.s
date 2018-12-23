
#include <WProgram.h>

#include <xc.h>
/* define all global symbols here */
.global main
.global read
.text
.set noreorder

.ent main
main:
    /* this code blocks sets up the ability to print, do not alter it */
   ADDIU $v0,$zero,1
    LA $t0,__XC_UART
    SW $v0,0($t0)
    LA $t0,U1MODE
    LW $v0,0($t0)
    ORI $v0,$v0,0b1000
    SW $v0,0($t0)
    LA $t0,U1BRG
    ADDIU $v0,$zero,12
    SW $v0,0($t0)

    
    LA $a0,WelcomeMessage
    JAL puts
    NOP

    /* your code goes underneath this */
   
    ANDi $t1,$t1,0
    ANDi $t2,$t2,0
    ANDi $t3,$t3,0
    ANDi $t4,$t4,0
    ANDi $t5,$t5,0
    ANDi $t6,$t6,0
    ANDi $t7,$t7,0
    li $t8,0b10000000000000000000000000000000
    LA $t0,inNumericString
    NOP
    
    loadagain:
    LB $t3,0($t0)
    BEQZ $t3,CHECK
    ADDi $t3,$t3,-16
    ADDi $t3,$t3,-16
    ADDi $t3,$t3,-13
    BEQ $t3,$t1,NEGATIVE
    BNE $t3,$t1,STORE
    NOP
    
    NEGATIVE:
    ADDi $t4,$t4,1
    addi $t0,$t0,1
    BGTZ $t4,loadagain
    NOP
    
    STORE:
    LB $t3,0($t0)
    addi $t3,$t3,-16
    addi $t3,$t3,-16
    addi $t3,$t3,-16
    mul $t6, $t6,10
    add $t6,$t3,$t6
    addi $t0,$t0,1
    BNE $t6,$t1,loadagain
    NOP
    
    CHECK:
    la $t0,outBinaryString
    BEQ $t4,$t1,STOREBYTE
    NOP
    
    NEV:
    la $t0,outBinaryString
    NOR $t6,$t6,$t6
    NOP
    
    plus:
    addi $t6,$t6,1
    NOP
    
    li $t8,0b10000000000000000000000000000000
    
    STOREBYTE:
    and $t2,$t6,$t8
    sltu $t1,$zero,$t2
    addi $t1,$t1,48
    sb $t1,0($t0)
    addi $t0,$t0,1
    srl $t8,$t8,1
    BNE $t8,$zero,STOREBYTE
    NOP
    
    
    /* your code goes above this */
    
    
    LA $a0,DecimalMessage
    JAL puts
    NOP
    LA $a0,inNumericString
    JAL puts
    NOP
    
    LA $a0,BinaryMessage
    JAL puts
    NOP
    LA $a0,outBinaryString
    JAL puts
    NOP
    
    

    
    

endProgram:
    J endProgram
    NOP
.end main




.data
WelcomeMessage: .asciiz "Welcome to the converter\n"
DecimalMessage: .asciiz "The decimal number is: "
BinaryMessage: .asciiz "The decimal number is: "
    
inNumericString: .asciiz "4095" 
RES1: .asciiz"0"
RES2: .asciiz"0"
outBinaryString: .asciiz "zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"


