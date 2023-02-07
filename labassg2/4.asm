section .data
    string1 db "Little-endian", 0Ah
    len1 equ $-string1
    string2 db "Big-endian", 0Ah
    len2 equ $-string2

section .text
global _start:
_start:
    mov ax, 10
    cmp al,10
    je if
    else:
        mov eax, 4
        mov ebx, 1
        mov ecx, string1
        mov edx, len1
        int 80h
        jmp exit
    if:
        mov eax, 4
        mov ebx, 1
        mov ecx, string2
        mov edx, len2
        int 80h
        
    exit:

        mov eax, 1
        mov ebx, 0
        int 80h

