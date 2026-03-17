.MODEL SMALL

.DATA 
    N DW 6
    R DW 2
    NCR DW 0
    MSG DB 'NCR = $'   ; Dollar-terminated string for printing
    RESULT DB 5 DUP(?) ; To store converted result digits

.CODE
START:
    MOV AX, @DATA
    MOV DS, AX
    MOV AX, N
    MOV BX, R
    CALL NCR_PROC

    ; Print message "NCR = "
    LEA DX, MSG
    MOV AH, 09H
    INT 21H

    ; Convert NCR to ASCII and print
    MOV AX, NCR
    LEA SI, RESULT
    CALL CONVERT_PRINT

    ; Exit to DOS
    MOV AH, 4CH
    INT 21H

; NCR CALCULATION
NCR_PROC PROC
    CMP AX, BX
    JZ N1
    CMP BX, 0
    JZ N1
    CMP BX, 1
    JZ N2
    MOV CX, AX
    DEC CX
    CMP CX, BX
    JZ N2
    PUSH AX
    PUSH BX
    DEC AX 
    CALL NCR_PROC
    POP BX 
    POP AX
    DEC AX 
    DEC BX
    CALL NCR_PROC
    JMP LAST

N1: ADD NCR, 1
    RET
N2: ADD NCR, AX
LAST: RET
NCR_PROC ENDP

;-----------------------------
; CONVERT AX TO ASCII AND PRINT
;-----------------------------
CONVERT_PRINT PROC
    MOV CX, 0          ; Digit count
    MOV BX, 10         ; Base 10 divisor

REPEAT_DIV:
    XOR DX, DX         ; Clear remainder
    DIV BX             ; AX / 10 -> AX: quotient, DX: remainder
    ADD DL, '0'        ; Convert digit to ASCII
    DEC SI
    MOV [SI], DL       ; Store in buffer
    INC CX
    CMP AX, 0
    JNZ REPEAT_DIV

    ; Now print digits
    MOV AH, 02H
PRINT_LOOP:
    MOV DL, [SI]
    INT 21H
    INC SI
    LOOP PRINT_LOOP
    RET
CONVERT_PRINT ENDP

END START
