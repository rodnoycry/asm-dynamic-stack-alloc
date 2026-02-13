section .data

section .text

global _start

_start:
    SUB esp,16 ; Moving pointer 16 bytes
    MOV dword [esp],42 ; Writing by address of moved pointer
    MOV eax,[esp] ; Just putting data to eax to read from gdb

    ; Exiting
    MOV ebx,0
    MOV eax,1
    INT 80h