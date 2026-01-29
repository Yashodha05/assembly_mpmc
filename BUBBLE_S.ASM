.model small
.stack 100h

.data
arr dw 4, 2, 1, 0, 6
len equ 5
msg db 13, 10, 'the sorted array is::$'
.code

main:
        mov ax, @data
        mov ds, ax
        mov cl, len
        dec cl

loop2:
        mov si, offset arr
        mov bl, cl

loop1:
        mov ax, [si]
        mov dx, [si+2]
        cmp ax, dx
        jb next

        mov [si], dx
        mov[si+2], ax

next:
        add si, 2
        dec bl
        jnz loop1
        dec cl
        jnz loop2

        lea dx, msg
        mov ah, 09h
        int 21h
        mov cx, len
        mov si, offset arr

print_loop:
        mov ax, [si]
        add al, '0'
        mov dl, al
        mov ah, 02h
        int 21h

        mov dl, ' '
        mov ah, 02h
        int 21h
        add si, 2
        loop print_loop
        mov ah, 4ch
        int 21h
end main
