@ BSS section
    .bss
z: .word 0

@ DATA SECTION
    .data
                .align
string1: .asciz "CS6620"
string2: .asciz "620"
len_string1: .byte             6
len_string2: .byte  3        ;@ length of string 2
index: .byte 0
position: .byte 0

@ TEXT section
    .text

.global _main

#r1 => 
#r7 => 
#r8 => 
                
_main:
        ldr r0, =string1
        ldr r1, =string2
        ldr r5, =len_string1
        ldr r6, =len_string2
        ldrb r2, [r5]        ;@ length of string 1
        ldrb r3, [r6]        ;@ length of string 2
        mov r4, #0           ;@ this is iterator for string1.
        mov r5, #0           ;@ this is iteratore for string2.
        ldr r7, =position
        ldrb r6, [r7]        ;@load byte the value of position
        B get_substring_pos
end_comp_less:
        mov r6, #0xFFFFFFFF
        strb r6, [r7, #0]

#
#    | a | b | c | d | e |  --> String 1
#
#    | c | d | e |                                  --> string2
#
                
end_routine:
        cmp r5, r3           ;@ if r5 and r3 value matches then it means that string is matched else not
        BGT END
        mov r6, #0           ;@ substring could not be found hence reset any prev posiotn set
        B END

get_substring_pos:
        add r5, r5, #1       ;@ increment the position by 1. First postion is indexed as position 1.
        cmp r5, r3
        BGT end_routine      ;@ end the loop
                
#       cmp r6, #0           ;@ check if prev character had any match. If not the no point in checking the next character. End the loop
#       BEQ end_routine
                
        ldrb r9, [r1], #1    ;@ read character at index r5 from string 2

loop1:
        add r4, r4, #1       ;@ increment the position by 1. First postion is indexed as position 1.
        cmp r4, r2
        BGT end_routine      ;@ end the loop if reached end of string
                
        ldrb r8, [r0], #1    ;@read character at index r4 from string 1
        cmp r9, r8           ;@search for character from string 2 in string 1
        BNE loop1
             
        cmp r6, #0           ;@set the starting postion for first character in string 1
        moveq r6, r4
                
        cmp r5, #2           ;@keep incrementing position if still we are at first character of string 1
        beq adjust_position
        bne skip_adjust      
adjust_position:
        sub r8, r4, r6       ;@ check if position is already stored with the initial value. If yes then do not overwrite
        sub r8, #1           ;@ dec by 1
        add r6, r6, r8       ;@correct the starting posiotn of substring discounting any repetion.

skip_adjust:
        B get_substring_pos  ;@ since prev value matched, pick next character from string 2 to match search in string2
                                
END:
        mov pc, r14
