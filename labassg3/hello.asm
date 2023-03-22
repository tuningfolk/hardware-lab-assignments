section .text
global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, 50
    mov edx, 1
    int 80h

    mov eax, 4
    mov ebx, 1
    mov ecx, 10
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h