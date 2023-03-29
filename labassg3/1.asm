section .data
    newline db 10
    msg1 db "Enter the number of elements: "
    len1 equ $-msg1
    msg2 db "Enter the elements of the array: ", 0Ah
    len2 equ $-msg2
    msg3 db "No. of even numbers: "
    len3 equ $-msg3
    msg4 db "No. of odd numbers: "
    len4 equ $-msg4

section .bss
    count resb 2
    arrcount resb 2
    num resb 2
    temp resb 2
    arrsize resb 4
    arr resw 5
    even resb 2
    odd resb 2
    


section .text
global _start
_start:


    call read_array
    call count_array

    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

    ;------------------FUNCtIONS-----------------;

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

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
    popa
    ret

    
    read_array:
        ;i = 0
        ; while i<n:
        ;   read num
        ;   *(arr+i) = num 
        ;   i++
        ; endwhile

        mov word[arrcount], 0 ;counter

        ;read size
        mov eax, 4
        mov ebx, 1
        mov ecx, msg1
        mov edx, len1
        int 80h

        call read_inp

        mov bx, word[num]
        mov word[arrsize], bx

        ;read elements
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, len2
        int 80h


        array_loop:
            mov ax, word[arrcount]
            cmp ax, word[arrsize]
            jnb array_loop_exit

            call read_inp
            mov cx, word[num]

            mov ax, word[arrcount]

            mov word[arr + 2*eax], cx


            inc word[arrcount]
            jmp array_loop
        array_loop_exit:

    exit_read_array:
    ret

    print_array:
        pusha
        ;while i<n:
        ;   print *(arr+i)
        ;   i++
        ; mov word[arrcount], 0
        mov word[arrcount], 0
        mov ebx, arr

        ; mov word[num],


        print_array_loop:
            mov ax, word[arrcount]
            cmp ax, word[arrsize]
            je exit_print_array_loop

            mov ax, word[arrcount]    
            mov cx, word[arr + 2*eax]
            mov word[num], cx

            call print_num

            inc word[arrcount]
            jmp print_array_loop
        exit_print_array_loop:
    exit_print_array:
    popa
    ret

    count_array:
        ;while i<n:
        ;   if *(arr+i)%2 == 0:
        ;       even++
        ;   i++
        
        mov word[arrcount], 0
        mov word[even], 0
        count_loop:
            mov ax, word[arrcount]
            cmp ax, word[arrsize]
            je exit_count_loop

            mov ax, word[arrcount]
            mov dx, 0
            mov ax, word[arr+2*eax]
            mov bx, 2
            div bx

            cmp dx, 0
            je if1
            else1:
                jmp L1
            if1:
                inc word[even]
            L1:

            inc word[arrcount]
            jmp count_loop
        exit_count_loop:

        mov eax, 4
        mov ebx, 1
        mov ecx, msg3
        mov edx, len3
        int 80h

        mov ax, word[even]
        mov word[num], ax

        call print_num

        mov bx, word[arrsize]
        mov word[odd], bx
        sub word[odd], ax

        mov eax, 4
        mov ebx, 1
        mov ecx, msg4
        mov edx, len4
        int 80h

        mov ax, word[odd]
        mov word[num], ax

        call print_num

    exit_count_array:
    ret