section .data
    newline db 10
    msg1 db "Enter string: "
    len1 equ $-msg1
    msg2 db "Not a palindrome", 0Ah
    len2 equ $-msg2
    msg3 db "It is a palindrome", 0Ah
    len3 equ $-msg3

section .bss
    str1 resb 50
    strlen1 resb 2
    temp resb 2
    count resb 2
    temp2 resb 2

section .text
global _start
_start:

    call read_string
    call palindrome
    ; call print_string

    exit:
        mov eax, 1
        mov ebx, 0
        int 80h

    read_string:

        mov eax, 4
        mov ebx, 1
        mov ecx, msg1
        mov edx, len1
        int 80h
        
        mov word[strlen1], 0
        string_loop:
            mov eax, 3
            mov ebx, 0
            mov ecx, temp
            mov edx, 1
            int 80h

            cmp word[temp], 10
            je exit_string_loop

            mov bx, word[temp]
            mov ax, word[strlen1]
            mov word[str1 + 2*eax], bx

            inc word[strlen1]
            jmp string_loop
        exit_string_loop:

    exit_read_string:
    ret

    palindrome:
        mov word[count], 0
        palindrome_loop:
            mov ax, word[count]
            cmp ax, word[strlen1]
            je exit_palindrome_loop

            mov bx, word[strlen1]
            mov word[temp], bx
            sub word[temp], 1
            
            mov bx, word[count]
            sub word[temp], bx

            mov ax, word[temp]
            mov bx, word[count]
            mov cx, word[str1 + 2*ebx]
            mov dx, word[str1 + 2*eax]

            cmp cx, dx
            jne exit_palindrome

            inc word[count]
            jmp palindrome_loop
        exit_palindrome_loop:

        mov eax, 4
        mov ebx, 1
        mov ecx, msg3
        mov edx, len3
        int 80h

        ret
    exit_palindrome:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 80h

    ret

    print_string:
        mov word[count], 0
        print_string_loop:
            mov ax, word[count]
            cmp ax, word[strlen1]
            je exit_print_string_loop

            mov ax, word[count]
            mov bx, word[str1 + 2*eax]
            mov word[temp], bx

            ; add word[count], 30h
            ; mov eax, 4
            ; mov ebx, 1
            ; mov ecx, count
            ; mov edx, 1
            ; int 80h
            ; sub word[count], 30h

            mov eax, 4
            mov ebx, 1
            mov ecx ,temp
            mov edx, 1
            int 80h

            inc word[count]
            jmp print_string_loop
        exit_print_string_loop:

    exit_print_string:
    ret