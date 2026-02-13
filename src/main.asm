section .data
    length dd 0
    capacity dd 4
    unit_size dd 4

section .text

global _start

grow:
    MOV ecx,[capacity]
    INC ecx
    MOV [capacity],ecx
    JMP write_val

push_to_arr:
    ; basic pushing logic
    MOV eax,[length]
    CMP eax,[capacity]
    MOV ebx,[esp + 4]
    JE grow
write_val:
    MOV ecx,[length]
    INC ecx
    MOV [length],ecx
    INC eax
    MUL dword [unit_size]
    MOV ecx,ebp
    SUB ecx,eax
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

    ; Pushing new value
    PUSH 88
    CALL push_to_arr

    ; Pushing new value
    PUSH 12
    CALL push_to_arr

    ; Pushing new value
    PUSH 35
    CALL push_to_arr

    ; Pushing new value
    PUSH 99
    CALL push_to_arr

    ; Pushing new value
    PUSH 17
    CALL push_to_arr

    ; Exiting
    MOV ebx,0
    MOV eax,1
    INT 80h