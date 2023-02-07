section .data
    newline db 10
    inp1 db "Enter n: "
    len1 equ $-inp1
    inp2 db "Enter number: "
    len2 equ $-inp2
    outp db "The mean is "
    len3 equ $-outp

section .bss
    n resb 2
    ntemp resb 2
    num resb 2
    sum resb 2
    mean resb 2
    temp resb 2
    count resb 1

section .text
global _start:
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, inp1
    mov edx, len1
    int 80h

    mov word[n], 0
    read_n:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp word[temp], 10
        je exit_read_n

        sub word[temp], 30h

        mov ax, word[n]
        mov bx, 10

        mul bx

        add ax, word[temp]
        mov word[n], ax
        jmp read_n

    exit_read_n:

    mov ax, word[n]
    mov word[ntemp], ax

    mov word[sum], 0
    loop: ; one iteration accepts one number
        cmp word[n], 0
        je exit_loop

        mov eax, 4
        mov ebx, 1
        mov ecx, inp2
        mov edx, len2
        int 80h

        mov word[num], 0
        read_num: ;one iteration accepts a digit of the 'i'th number
            mov eax, 3
            mov ebx, 0
            mov ecx, temp
            mov edx, 1
            int 80h

            cmp word[temp], 10
            je exit_read_num

            sub word[temp], 30h

            mov ax, word[num]
            mov bx, 10

            mul bx

            add ax, word[temp]
            mov word[num], ax
            jmp read_num

        exit_read_num:

        mov ax, word[num]
        add word[sum], ax


        dec word[n]
        jmp loop
    exit_loop:
    


    calculate_mean:
        mov dx, 0
        mov ax, word[sum]
        mov bx, word[ntemp]
        div bx

        mov word[mean], ax


    ;while(num!=0)
    ;   temp = num%10
    ;   push(temp)
    ;   num=num/10
    ;   count++
    ;
    ;while(count!=0)
    ;   pop temp
    ;   print(temp)
    ;   count--

    mov eax, 4
    mov ebx, 1
    mov ecx, outp
    mov edx, len3
    int 80h

    print_num:
        mov byte[count], 0
        pusha

        extract_num:
            cmp word[mean], 0
            je print_no
            
            mov dx, 0
            mov ax, word[mean]
            mov bx, 10

            div bx

            push dx ; remainder at dx, quotient at ax

            mov word[mean], ax
            inc byte[count]
            jmp extract_num

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
    popa

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h

