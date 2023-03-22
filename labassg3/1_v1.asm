section .data
    newline db 10
    space db 32
    msg1 db "Enter first array: "
    len1 equ $-msg1
    msg2 db "Enter second array: "
    len2 equ $-msg2
    msg3 db "Final array: "
    len3 equ $-msg3

section .bss
    count resb 2
    arrcount resb 2
    num resb 2
    temp resb 2
    arrsize resb 4
    arr resw 20
    i resw 1
    j resw 2
    


section .text
global _start
_start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 80h

    mov word[arrcount], 0

    call read_inp
    mov bx, word[num]
    mov word[arrsize], bx

    call read_array
    ; call print_array

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 80h

    call read_inp
    mov bx, word[num]
    add word[arrsize], bx

    call read_array

    call sort

    mov eax, 4
    mov ebx ,1
    mov ecx, msg3
    mov edx, len3
    int 80h

    call print_array

    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

    ;------------------FUNCtIONS-----------------;

    sort:
    ;i = 0
    ;j = 0
    ;while i<n-1:
    ;   j = 0
    ;   while j<n-1:
    ;       if *(arr+i)> *(arr + i + 1):
    ;           swap
    ;       j++
    ;   i++

    pusha

        mov word[i], 0
        mov dword[j], 0

        mov ax, word[arrsize]
        mov word[arrcount], ax
        dec word[arrcount]

        sortloop1:
            mov ax, word[i]
            cmp ax, word[arrcount]
            je exit_sortloop1

            mov dword[j], 0
            sortloop2:
                mov ax, word[j]
                cmp ax, word[arrcount]
                je exit_sortloop2


                mov eax, 0
                mov eax, dword[j]
                mov bx, word[arr + 2*eax]
                mov cx, word[arr + 2*eax+2]
                cmp bx, cx
                ja if1
                    else1:
                        jmp L1
                    if1:
                        ; mov bx, word[arr + 2*eax]
                        ; mov cx, word[arr + 4*eax]
                        mov word[arr + 2*eax+2], bx
                        mov word[arr + 2*eax], cx
                    L1:




                inc dword[j]
                jmp sortloop2
            exit_sortloop2:


            inc word[i]
            jmp sortloop1
        exit_sortloop1:

    popa
    ret

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
        ; while i<n:
        ;   read num
        ;   *(arr+i) = num 
        ;   i++
        ; endwhile

        ; mov word[arrcount], 0 ;counter


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

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    popa
    ret