section .data
    newline db 10
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

section .text
global _start
_start:
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

    


    
    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

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
    mov ax, word[arrsize]
    mov word[arrcount], ax

    read_array_loop:
        cmp word[arrcount], 0
        je exit_read_array_loop

        call read_num
        mov cx, word[num]
        mov ax, word[arrcount]
        mov word[ebx+2*eax], cx

        dec word[arrcount]
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

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

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



    

