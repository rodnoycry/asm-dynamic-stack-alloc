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
    MOV eax,[length]
    INC eax
    MUL dword [unit_size]
    ADD eax,8
    MOV ebx,[ebp + 8]
    MOV dword [eax],ebx
    RET

_start:
    ; Allocating the memory
    MOV eax,[capacity]
    MUL dword [unit_size]
    SUB esp,eax

    ; Saving ebp
    PUSH ebp
    ; Caching esp value in ebp
    MOV ebp,esp
    ; Pushing new value
    PUSH 42
    CALL push_to_arr

    ; Exiting
    MOV ebx,0
    MOV eax,1
    INT 80h