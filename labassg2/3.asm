section .bss
    num1 resb 4
    num2 resb 4
    sum resb 4
    temp resb 4
    count resb 1

section .data
    newline db 10
    inp db "Enter a number: "
    len equ $-inp
    outp db "The sum is "
    len2 equ $-outp

section .text
global _start:
_start:

    mov dword[num1], 0
    
    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, len
    int 80h 

    read_num1:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
        je exit_read_num1

        sub byte[temp], 30h

        mov ebx, 10
        mov eax, dword[num1]

        mul ebx

        add eax, dword[temp]
        mov dword[num1], eax

        jmp read_num1
        
    exit_read_num1:

    mov dword[num2], 0
    
    mov eax, 4
    mov ebx, 1
    mov ecx, inp
    mov edx, len
    int 80h 

    read_num2:
        mov eax, 3
        mov ebx, 0
        mov ecx, temp
        mov edx, 1
        int 80h

        cmp byte[temp], 10
        je exit_read_num2

        sub byte[temp], 30h

        mov ebx, 10
        mov eax, dword[num2]

        mul ebx

        add eax, dword[temp]
        mov dword[num2], eax

        jmp read_num2
        
    exit_read_num2:

    mov eax, dword[num1]
    add eax, dword[num2]
    mov dword[sum], eax

    ;print a number
    ;while(num!=0)
    ;   temp = num%10
    ;   push(temp)
    ;   count++
    ;   num = num/10
    ;
    ;while(count!=0)
    ;   pop temp
    ;   print(temp)
    ;   count--

    ;Now, let's print sum

    mov eax, 4
    mov ebx, 1
    mov ecx, outp
    mov edx, len2
    int 80h

    print_num:
        mov byte[count], 0
        pusha

        extract_num:
            cmp dword[sum], 0
            je print_no

            mov edx, 0
            mov eax, dword[sum]
            
            mov ebx, 10
            div ebx

            push edx

            inc byte[count]

            mov dword[sum], eax

            jmp extract_num

        print_no:

            cmp byte[count], 0
            je exit_print_no

            pop edx
            mov dword[temp], edx
            add dword[temp], 30h

            mov eax, 4
            mov ebx, 1
            mov ecx, temp
            mov edx, 1
            int 80h

            dec byte[count]
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