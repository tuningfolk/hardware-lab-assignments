section .data
    newline db 10
    msg1 db "Enter n: "
    len1 equ $-msg1
    msg2 db "Enter m: "
    len2 equ $-msg2
    msg3 db "Enter the elements of A: "
    len3 equ $-msg3
    msg4 db "Enter the elements of B: "
    len4 equ $-msg4
    space db ' '
    msg5 db "C: ", 0Ah
    len5 equ $-msg5

section .bss
    num resb 2
    count resb 2
    temp resb 2
    i_count resb 2
    j_count resb 2

    A resw 50
    B resw 50
    C resw 50
    n1 resb 2
    m1 resb 2

section .text
global _start
_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 80h

    call read_inp
    mov ax, word[num]
    mov word[n1], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 80h

    call read_inp
    mov ax, word[num]
    mov word[m1], ax


    ;Elements of each matrix

    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 80h

    mov word[i_count], 0
    i1_loop:
        mov ax, word[i_count]
        cmp ax, word[n1]
        je exit_i1_loop

        mov word[j_count], 0
        j1_loop:
            mov ax, word[j_count]
            cmp ax, word[m1]
            je exit_j1_loop

            call read_inp
            mov ax, word[i_count]
            add ax, word[j_count]

            mov bx, word[num]
            mov word[A + 2*eax], bx

            inc word[j_count]
            jmp j1_loop
        exit_j1_loop:

        inc word[i_count]
        jmp i1_loop
    exit_i1_loop:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, len4
    int 80h

    mov word[i_count], 0
    i2_loop:
        mov ax, word[i_count]
        cmp ax, word[n1]
        je exit_i2_loop

        mov word[j_count], 0
        j2_loop:
            mov ax, word[j_count]
            cmp ax, word[m1]
            je exit_j2_loop

            call read_inp
            mov ax, word[i_count]
            add ax, word[j_count]

            mov bx, word[num]
            mov word[B + 2*eax], bx

            inc word[j_count]
            jmp j2_loop
        exit_j2_loop:

        inc word[i_count]
        jmp i2_loop
    exit_i2_loop:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg5
    mov edx, len5
    int 80h

    mov word[i_count], 0
    i3_loop:
        mov ax, word[i_count]
        cmp ax, word[n1]
        je exit_i3_loop

        mov word[j_count], 0
        j3_loop:
            mov ax, word[j_count]
            cmp ax, word[m1]
            je exit_j3_loop

            mov ax, word[i_count]
            add ax, word[j_count]

            mov bx, word[A+2*eax]
            add bx, word[B+2*eax]
            mov word[C + 2*eax], bx
            mov word[num], bx

            ;print the element
            call print_num

            mov eax, 4
            mov ebx, 1
            mov ecx, space
            mov edx, 1
            int 80h

            inc word[j_count]
            jmp j3_loop
        exit_j3_loop:

        ;newline
        mov eax, 4
        mov ebx, 1
        mov ecx, newline
        mov edx, 1
        int 80h

        inc word[i_count]
        jmp i3_loop
    exit_i3_loop:


    ;exit function
    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

    ;Read integer input from user
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
        pusha
        ;while num!= 0
        ;   temp = num%10
        ;   push temp
        ;   num = num/10
        ;   count++

        ;while count!=0
        ;   pop temp
        ;   print temp
        ;   count--
        
        mov word[count], 0
        extract_no:
            cmp word[num], 0
            je exit_extract_no

            mov dx, 0
            mov ax, word[num]
            mov bx, 10
            div bx

            push dx
            mov word[num], ax
            inc word[count]
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
    exit_print_num:
    popa 
    ret