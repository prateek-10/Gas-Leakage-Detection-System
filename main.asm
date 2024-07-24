ORG 0000H
START:
MOV P1, #0FFH                    ; Move the value 0xFF (255 in decimal) to Port 1

MOV R3, #17                      ; Initialize R3 with the value 23
Loop1:MOV R2, #255               ; Initialize R2 with the value 255
Loop2:MOV R1, #255               ; Initialize R1 with the value 255
Loop:DJNZ R1, Loop               ; Decrement R1 and jump to "Loop" if R1 is not zero
DJNZ R2, Loop2                   ; Decrement R2 and jump to "Loop2" if R2 is not zero
DJNZ R3, Loop1                   ; Decrement R3 and jump to "Loop1" if R3 is not zero

                 
CONTINUE:
MOV A, P1                        ; Move the value in Port 1 to the accumulator A
CJNE A, #0FEH, POSITIVE          ; Compare A with 0xFE and jump to "POSITIVE" if not equal
CJNE A, #0FFH, CONTINUE          ; Compare A with 0xFF and jump to "CONTINUE" if not equal


POSITIVE:     
Mov A, #38H                      ; Move the value 0x38 (56 in decimal) to accumulator A
ACALL init                       ; Call subroutine init with the value in A
MOV A, #0EH                      ; Move the value 0x0E (14 in decimal) to accumulator A
ACALL init                       ; Call subroutine init with the value in A
MOV A, #80H                      ; Move the value 0x80 (128 in decimal) to accumulator A
ACALL init                       ; Call subroutine init with the value in A
MOV A, #01H                      ; Move the value 0x01 (1 in decimal) to accumulator A
ACALL init                       ; Call subroutine init with the value in A

MOV DPTR ,#STR                   ; Move the address of the string STR to DPTR
IL: MOV A,#00H                   ; Move the value 0 to accumulator A
MOVC A,@A+DPTR                   ; Move the code byte from the address pointed by DPTR to A using MOVC
JZ TERMINATE                     ; Jump to TERMINATE if A is zero
ACALL LCD                        ; Call subroutine LCD
INC DPTR                         ; Increment the DPTR (data pointer)
SJMP IL                          ; Jump to IL
TERMINATE: SJMP TERMINATE        ; Infinite loop (program termination)

init: ACALL DELAY                ; Call subroutine DELAY
MOV P3, A                        ; Move the value in A to Port 3
CLR P2.0                         ; Clear bit 1 of Port 2
SETB P2.1                        ; Set bit 2 of Port 2
CLR P2.1                         ; Clear bit 2 of Port 2
RET    

LCD: ACALL DELAY                 ; Call subroutine DELAY
MOV P3, A                        ; Move the value in A to Port 3
SETB P2.0                        ; Set bit 1 of Port 2
SETB P2.1                        ; Set bit 2 of Port 2
CLR P2.1                         ; Clear bit 2 of Port 2
RET       

DELAY: MOV R0, #0FFH             ; Move the value 0xFF to register R0
L1: MOV R1, #0FFH                ; Move the value 0xFF to register R1
L2: DJNZ R1, L2                  ; Decrement R1 and jump to L2 if R1 is not zero
DJNZ R0, L1                      ; Decrement R0 and jump to L1 if R0 is not zero
RET       

STR: DB'GAS DETECTED',0          ; Define a null-terminated string 'GAS DETECTED'
END
