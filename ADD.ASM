.model small
.stack 100h
.data
        a dw 1234h
        b dw 0002h
.code
main:
        mov ax,@data
        mov ds,ax

        mov ax,a
        add ax,b

        add al,30h
        mov dl, al
        mov ah,02h
        int 21h

        mov ah,4Ch
        int 21h
end main
