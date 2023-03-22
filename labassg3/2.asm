section .data
    newline db 10
    space db 32
    msg1 db "Enter n and m: "
    len1 equ $-msg1
    msg2 db "Enter second array: "
    len2 equ $-msg2
    msg3 db "Final array: "
    len3 equ $-msg3

section .bss
    count resb 2
    arrcount resb 2
    num resb 2
    n resb 2
    m resb 2
    temp resb 2
    arrsize resb 4
    arr resw 20
    i resw 2
    j resw 2
    k resw 2


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
    mov word[n], ax

    call read_inp

    mov ax, word[num]
    mov word[m], ax

    call read_array

    mov ax, word[n]
    mov bx, word[m]
    mul bx
    mov word[arrsize], ax
    call print_array

    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

    read_inp:
        pusha
        mov word[num], 0
        read_num:

            mov eax, 3
            mov ebx, 0
            mov ecx, temp
            mov edx, 1
            int 80h

            cmp byte[temp], 10
            je exit_read_num

            cmp byte[temp], 32
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
    popa
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

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 80h
    

    popa
    ret

    print:
        pusha
        call print_num
        
        mov eax, 4
        mov ebx, 1
        mov ecx, 10
        mov edx, 1
        int 80h

        popa
    ret

    
    read_array:
        ;i = 0
        ;k = 0
        ; while i<n:
        ;   j = 0
        ;   while j<m:
        ;       read num
        ;       *(arr + k) = num
        ;       k++
        ;       j++
        ;   i++
        ; endwhile

        ; mov word[arrcount], 0 ;counter

        mov word[arrcount], 0
        mov word[k], 0
        array_loop:
            mov ax, word[arrcount]
            cmp ax, word[n]
            je array_loop_exit

            mov word[j], 0
            array_loop2:
                mov ax, word[m]
                cmp ax, word[j]
                je exit_array_loop2


                call read_inp
                mov cx, word[num]

                mov edi, dword[arrcount]
                mov eax, dword[n]
                mul edi

                mov edi, eax

                mov eax, 0
                mov ax, word[k]

                mov word[arr + 2*eax], cx

                inc word[k]
                inc word[j]
                jmp array_loop2
            exit_array_loop2:

            

            inc word[arrcount]
            jmp array_loop
        array_loop_exit:

    exit_read_array:
    ret

    print_array:


        pusha
        ;while i< n:
        ;   j = 0
        ;   while j<m:
        ;       print(arr + k)
        ;       k++
        ;       j++
        ;   print newline
        ;   
        ;   i++
        mov word[arrcount], 0
        mov word[k], 0
        mov ebx, arr

        ; mov word[num],


        print_array_loop:
            mov ax, word[arrcount]
            cmp ax, word[arrsize]
            je exit_print_array_loop
            mov word[j], 0
            print_array_loop2:
            
                mov ax, word[k]    
                mov cx, word[arr + 2*eax]
                mov word[num], cx
                call print_num

                inc word[k]
                inc word[j]
                jmp print_array_loop2
            exit_print_array2:

            mov eax, 4
            mov ebx, 1
            mov ecx, newline
            mov edx, 1
            int 80h



            

            inc word[arrcount]
            jmp print_array_loop
        exit_print_array_loop:
    exit_print_array:

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    popa
    ret