@ BSS section
    .bss
z: .word 0

@ DATA SECTION
    .data
                .align
string1: .asciz "CAT"
string2: .asciz "CUT"

index: .word  0
length: .word  3

@Output
GREATER: .word 0

@ TEXT section
.text


#r1 => 
#r7 => 
#r8 => 
                
_main:
        ldr r0, =string1 ;@load string 1 address
        ldr r1, =string2 ;@load string 2 address
        ldr r5, =index   ;@index used to iterate through the string
        ldr r6, =length  ;@length of the string
				
		;@ load the value of index and length into register
        ldrb r2, [r5]
        ldrb r3, [r6]
        ;@ load the value and address of variable GREATER.
        ldr r7, =GREATER
        ldrb r6, [r5]
                
        B compare_string
end_comp_less:
        mov r6, #0xFFFFFFFF ;@ If comparision is false value of greater is set to 0xFFFFFFFF
        strb r6, [r7, #0]   ;@ store the value into memeory
                
end_routine:
        B END

compare_string:
        cmp r2, r3
        BEQ end_routine
        ldrb r4, [r0], #1   ;@read next byte from string1
        ldrb r5, [r1], #1   ;@read next byte from string2
        cmp r4, r5
        add r2, r2, #1		 ;@increment the index      
        BLT end_comp_less
        BGT compare_string
        BEQ compare_string
               
END:
		swi 0x11
        mov pc, r14
