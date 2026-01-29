.model small
.data
arr dw 1, 2, 3, 4, 5, 6, 7
len dw ($-arr)/2
msg1 db "key is found$"
msg2 db "key is nor found$"
x dw 9

.code
        mov ax, @data
        mov ds, ax
        mov si, 0000h
        mov di, len
        add di, di
        sub di, 2
rpt:
        cmp si, di
        ja knf
        mov ax, x
        mov bx, si
        add bx, di
        shr bx, 1

        cmp ax, arr[bx]
        je kf
        jb next
        mov si, bx
        add si, 2
        jmp rpt
next:
        mov di, bx
        sub di, 2
        jmp rpt
kf:
        lea dx, msg1
        mov ah, 09h
        int 21h
        jmp exit
knf:
        lea dx, msg2
        mov ah, 09h
        int 21h
exit:
        mov ah, 4ch
        int 21h
        end
