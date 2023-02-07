section .bss
    num resb 2
    num1 resb 2
    num2 resb 2
    num3 resb 2
    temp resb 2
    count resb 1

section .data
    newline db 10
    string db "The largest number is "
    len equ $-string
    inp db "Enter number: "
    inplen equ $-inp

section .text
global _start
_start:
    mov word[num1], 0

    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, inplen
    int 80h

    read_num1:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
        je exit_loop1

        sub byte[temp], 30h

        mov ax, word[num1]
        mov bx, 10
        mul bx ;since bx is 2 bytes, it is multiplied with ax and stored in dx:ax
        mov bh, 0
        mov bl, byte[temp]
        add ax, bx

        mov word[num1], ax
        jmp read_num1

    exit_loop1:
        ; mov eax, 4
        ; mov ebx, 1
        ; mov ecx, num1
        ; mov edx, 3
        ; int 80h

        ; mov eax, 4
        ; mov ebx, 1
        ; mov ecx, newline
        ; mov edx, 1
        ; int 80h


    mov word[num2], 0

    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, inplen
    int 80h

    read_num2:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
        je exit_loop2

        sub byte[temp], 30h

        mov ax, word[num2]
        mov bx, 10
        mul bx ;since bx is 2 bytes, it is multiplied with ax and stored in dx:ax
        mov bh, 0
        mov bl, byte[temp]
        add ax, bx

        mov word[num2], ax
        jmp read_num2

    exit_loop2:
        ; mov eax, 4
        ; mov ebx, 1
        ; mov ecx, num2
        ; mov edx, 3
        ; int 80h

        ; mov eax, 4
        ; mov ebx, 1
        ; mov ecx, newline
        ; mov edx, 1
        ; int 80h


    mov word[num3], 0
    
    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, inplen
    int 80h

    read_num3:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
        je exit_loop3

        sub byte[temp], 30h

        mov ax, word[num3]
        mov bx, 10
        mul bx ;since bx is 2 bytes, it is multiplied with ax and stored in dx:ax
        mov bh, 0
        mov bl, byte[temp]
        add ax, bx

        mov word[num3], ax
        jmp read_num3

    exit_loop3:
        ; mov eax, 4
        ; mov ebx, 1
        ; mov ecx, num3
        ; mov edx, 3
        ; int 80h

        ; mov eax, 4
        ; mov ebx, 1
        ; mov ecx, newline
        ; mov edx, 1
        ; int 80h

    compare:
        mov ax, word[num1]
        mov bx, word[num2]
        mov cx, word[num3]

        cmp ax, bx
        jnb if
        else:
            mov word[temp], bx
            jmp print
        if:
            mov word[temp], ax
        print:
            mov ax, word[temp]
            cmp ax, cx
            jnb if1

            else1:
                mov word[num],cx
                jmp exit
            if1:
                mov word[num], ax
            
            exit:
                mov eax, 4
                mov ebx, 1
                mov ecx, string
                mov edx, len
                int 80h

    print_num:

        mov byte[count], 0
        pusha

        extract_num:

            cmp word[num], 0
            je print_no

            inc byte[count]

            mov bx, 10
            
            mov dx, 0 ;to set the higher 8 bits to 0; DX:AX divides
            mov ax, word[num]
            
            div bx ;0:AX divided by bx

            ;remainder at DX, quotient at AX

            push dx
            mov word[num], ax

        jmp extract_num

        print_no:
            cmp byte[count], 0
            je exit_print_no

            dec byte[count]

            pop dx
            mov byte[temp], dl
            add byte[temp], 30h

            mov eax, 4
            mov ebx, 1
            mov ecx, temp
            mov edx, 1
            int 80h

        jmp print_no
    exit_print_no:

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h



