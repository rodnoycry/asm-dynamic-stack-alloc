section .text

section .data

global _start

_start:
    MOV ebx,42
    MOV eax,1
    INT 80h