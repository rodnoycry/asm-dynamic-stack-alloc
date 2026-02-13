section .data
    length dd 0
    capacity dd 4
    unit_size dd 4

section .text

global _start

panic:
    MOV ebx,1
    MOV eax,1
    INT 80h

push_to_arr:
    ; basic pushing logic
    MOV eax,[length]
    CMP eax,[capacity]
    JE panic
    MOV ecx,[length]
    INC ecx
    MOV [length],ecx
    INC eax
    MUL dword [unit_size]
    MOV ecx,ebp
    SUB ecx,eax
    MOV ebx,[esp + 4]
    MOV dword [ecx],ebx
    RET

_start:
    ; Saving ebp
    PUSH ebp
    ; Caching esp value in ebp
    MOV ebp,esp
    
    ; Allocating the memory
    MOV eax,[capacity]
    MUL dword [unit_size]
    SUB esp,eax

    ; Pushing new value
    PUSH 42
    CALL push_to_arr

    ; Exiting
    MOV ebx,0
    MOV eax,1
    INT 80h