section .data
    newline db 10
<<<<<<< HEAD
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
    

=======
    space db 32
    msg1 db "Enter n: "
    len1 equ $-msg1
    msg2 db "Enter m: "
    len2 db $-msg2

section .bss
    n resb 2
    m resb 2
    num resb 2
    arr resw 20
    arr1 resw 20
    arr2 resw 20
    arr3 resw 20
    arrcount resb 2
    arrsize resb 2
    temp resb 2
    count resb 2
    j resb 2
    k resb 2
>>>>>>> 22d0435566f678ce836755c303afe6668c284776

section .text
global _start
_start:
<<<<<<< HEAD


    call read_array
    call count_array

=======
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 80h

    call read_num
    mov ax, word[num]
    mov word[n], ax

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 80h

    call read_num
    mov ax, word[num]
    mov word[m], ax

    mov ax, word[n]
    mov word[arrsize], ax
    mov ebx, arr1
    call read_array

    mov ax, word[m]
    mov word[arrsize], ax
    mov ebx, arr2
    call read_array

    mov ax, word[n]
    mov word[arrsize], ax
    mov ebx, arr1
    call print_array

    mov ax, word[m]
    mov word[arrsize], ax
    mov ebx, arr2
    call print_array

    mov ebx, arr3
    call merge

    mov ax, word[n]
    add ax, word[m]
    mov word[arrsize], ax
    mov ebx, arr3
    call print_array

    


    
>>>>>>> 22d0435566f678ce836755c303afe6668c284776
    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

<<<<<<< HEAD
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
=======
;---FUNCTIONS---

merge:
    ;pusha
    ;i = 0, j = 0, k = 0
    ;while i<(n+m):
    ;   if j>=n:
    ;       arr[i] = b[k]
    ;       i++
    ;       k++
    ;       continue
    ;   if k>m:
    ;       arr[i] = a[j]
    ;       j++
    ;       i++
    ;       continue
    ;   if a[j] >= b[k]:
        ;   arr[i] = a[j]
        ;   i++
    ;       j++
    ;       continue

    ;   if a[j]<b[k]:
    ;       arr[i] = b[k]
    ;       i++
    ;       k++


    mov word[arrcount], 0
    mov word[j], 0
    mov word[k], 0
    mov eax, 0
    merge_loop:
        mov ax, word[n]
        add ax, word[m]
        cmp word[arrcount], ax
        jae exit_merge_loop

        ;---           ---------------------------------------------------
        mov ax, word[j]
        cmp ax, word[n]
        jae if1
            else1:
                jmp L1
            if1:
                mov ax, word[k]
                mov dx, word[arr2 + 2*eax]

                mov ax, word[arrcount]
                mov ebx, arr3
                mov word[ebx + 2*eax], dx

                inc word[arrcount]
                inc word[k]
                jmp merge_loop
            L1:

        mov ax, word[k]
        cmp ax, word[m]
        jae if2
            else2:
                jmp L2
            if2:
                mov ax, word[j]
                mov dx, word[arr1 + 2*eax]

                mov ax, word[arrcount]
                mov ebx, arr3
                mov word[ebx + 2*eax], dx

                inc word[arrcount]
                inc word[j]
                jmp merge_loop
            L2:

        mov ax, word[j]
        mov dx, word[arr1 + 2*eax]

        mov ax, word[k]
        mov ax, word[arr2 + 2*eax]
        mov cx, ax

        cmp dx, cx
        jnb if3
            else3:
                ;cx is bigger ==>arr2 is bigger
                mov ax, word[k]
                mov dx, word[arr2 + 2*eax]

                mov ax, word[arrcount]
                mov ebx, arr3
                mov word[ebx + 2*eax], dx

                inc word[arrcount]
                inc word[k]
                
                jmp L3
            if3:
                ;dx is bigger ==> arr1 is bigger
                mov ax, word[j]
                mov dx, word[arr1 + 2*eax]

                mov ax, word[arrcount]
                mov ebx, arr3
                mov word[ebx + 2*eax], dx

                inc word[arrcount]
                inc word[j]
                jmp L3
            L3:
                jmp merge_loop
                
            ;---------- -----------------------

        jmp merge_loop
    exit_merge_loop:
    ;popa
    ret

read_array:
    pusha
    mov word[arrcount], 0

    read_array_loop:
        mov ax, word[arrsize]
        cmp word[arrcount], ax
        je exit_read_array_loop

        call read_num
        mov cx, word[num]
        mov ax, word[arrcount]
        mov word[ebx+2*eax], cx

        inc word[arrcount]
        jmp read_array_loop
    exit_read_array_loop:
    popa
    ret

print_array:
    pusha
    mov ax, word[arrsize]
    mov word[arrcount], ax

    print_array_loop:
        cmp word[arrcount], 0
        je exit_print_array_loop

        mov ax, word[arrcount]
        mov cx, word[ebx+2*eax]

        mov word[num], cx
        call print_num


        dec word[arrcount]
        jmp print_array_loop
    exit_print_array_loop:
>>>>>>> 22d0435566f678ce836755c303afe6668c284776

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h
<<<<<<< HEAD
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
=======

    popa

    ret

read_num:
    pusha
    mov word[num], 0
    read_loop:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp word[temp], 10
        je exit_read_loop

        sub word[temp], 30h
        
        mov ax, word[num]
        mov bx, 10
        mul bx

        add ax, word[temp]

        mov word[num], ax

        jmp read_loop
    exit_read_loop:
    popa
    ret

print_num:
    pusha
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
    mov ecx, newline
    mov edx, 1
    int 80h

    ret
    popa



    

>>>>>>> 22d0435566f678ce836755c303afe6668c284776
