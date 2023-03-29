section .data
    newline db 10
    space db 32

section .bss
    temp resb 2
    count resb 2
    num resb 2
    arrsize resb 2
    arrcount resb 2
    arr resw 10

section .text
global _start
_start:
    call read_array
    call print_array
    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

    read_array:
        call read_inp
        mov ax, word[num]
        mov word[arrsize], ax

        ;while i < size
        ;   read num
        ;   *(arr+i) = num
        ;   i++
        mov word[arrcount], 0
        array_loop:
            mov ax, word[arrcount]
            cmp ax, word[arrsize]
            je exit_array_loop
                
            call read_inp
            mov ax, word[arrcount]
            mov bx, word[num]
            mov word[arr+2*eax], bx

            inc word[arrcount]
            jmp array_loop
        exit_array_loop:
    exit_read_array:
    ret

    print_array:
        mov word[arrcount], 0
        print_array_loop:
            mov ax, word[arrcount]
            cmp ax, word[arrsize]
            je exit_print_array_loop

            mov ax, word[arrcount]
            mov bx, word[arr+2*eax]

            mov word[num], bx
            call print_num

            mov eax, 4
            mov ebx, 1
            mov ecx, space
            mov edx, 1
            int 80h

            inc word[arrcount]
            jmp print_array_loop
        exit_print_array_loop:
        
        mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, 1
        int 80h
    exit_print_array:
    ret

    read_inp:
        mov word[num], 0
        read_num:
            mov eax, 3
            mov ebx, 0
            mov ecx, temp
            mov edx, 1
            int 80h

            cmp byte[temp], 10
            je exit_read_num

            sub byte[temp], 30h

            mov ax, word[num]
            mov bx, 10
            mul bx

            mov bh, 0
            mov bl, byte[temp]
            add ax, bx

            mov word[num], ax

            jmp read_num
        exit_read_num:

        ret

    print_num:
        mov word[count], 0

        extract_no:
            cmp word[num], 0
            je exit_extract_no

            mov dx, 0
            mov ax, word[num]
            mov bx, 10
            div bx

            push dx
            inc word[count]
            mov word[num], ax

            jmp extract_no
        exit_extract_no:

        print_no:
            cmp word[count], 0
            je exit_print_no

            pop dx
            mov word[temp], dx
            add word[temp], 30h

            mov eax, 4
            mov ebx, 1
            mov ecx, temp
            mov edx, 1
            int 80h

            dec word[count]
            jmp print_no
        exit_print_no:

        ret

    