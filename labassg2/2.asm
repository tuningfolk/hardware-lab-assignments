section .bss
    num resb 2  ;input number
    square resb 2 ;result
    temp resb 2  ;used while inputting the number
    count resb 2  ;used as the loop iterative to calculate the square
    count2 resb 1

section .data
    newline db 10
    inp db "Enter a number: "
    len equ $-inp
    outp db "The square of the number is "
    len2 equ $-outp 

section .text
global _start:
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, len
    int 80h

    mov word[num], 0
    read_num:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp word[temp], 10
        je exit_read_num

        mov ax, word[num]
        mov bx, 10

        mul bx

        sub word[temp], 30h

        add ax, word[temp]
        mov word[num], ax

        jmp read_num

    exit_read_num:

    mov ax, word[num]
    mov word[count], ax

    mov word[square], ax

    square_loop:
        cmp word[count], 1
        je exit_square_loop

        dec word[count]

        mov ax, word[num]
        add word[square], ax

        jmp square_loop

    exit_square_loop:

    mov eax, 4
    mov ebx, 1
    mov ecx, outp
    mov edx, len2
    int 80h

    print_num:

            mov byte[count2], 0
            pusha

            extract_num:

                cmp word[square], 0
                je print_no

                inc byte[count2]

                mov bx, 10
                
                mov dx, 0 ;to set the higher 8 bits to 0; DX:AX divides
                mov ax, word[square]
                
                div bx ;0:AX divided by bx

                ;remainder at DX, quotient at AX

                push dx
                mov word[square], ax

            jmp extract_num

            print_no:
                cmp byte[count2], 0
                je exit_print_no

                dec byte[count2]

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