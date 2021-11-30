InDocumentary:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     dword [rbp-0CH], esi
        mov     rax, qword [rbp-8H]
        lea     rdx, [rax+4H]
        mov     eax, dword [rbp-0CH]
        mov     rsi, rdx
        mov     edi, eax
        call    ReadString
        mov     eax, dword [rbp-0CH]
        lea     rcx, [rel incorrect_year]
        mov     edx, 3022
        mov     esi, 1970
        mov     edi, eax
        call    ReadIntIn
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx+68H], eax
        mov     eax, dword [rbp-0CH]
        lea     rcx, [rel doc_incorrect_duration]
        mov     edx, 3600
        mov     esi, 45
        mov     edi, eax
        call    ReadIntIn
        mov     rdx, qword [rbp-8H]
        mov     dword [rdx], eax
        nop
        leave
        ret

InDocumentaryStochastic:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 24
        mov     qword [rbp-18H], rdi
        mov     rax, qword [rbp-18H]
        lea     rbx, [rax+4H]
        mov     esi, 51
        mov     edi, 1
        call    RandomInt
        mov     rsi, rbx
        mov     edi, eax
        call    RandomString
        mov     esi, 3022
        mov     edi, 1970
        call    RandomInt
        mov     rdx, qword [rbp-18H]
        mov     dword [rdx+68H], eax
        mov     esi, 3600
        mov     edi, 45
        call    RandomInt
        mov     rdx, qword [rbp-18H]
        mov     dword [rdx], eax
        nop
        add     rsp, 24
        pop     rbx
        pop     rbp
        ret

OutDocumentary:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 80
        mov     qword [rbp-48H], rdi
        mov     dword [rbp-4CH], esi
        mov     eax, dword [rbp-4CH]
        mov     edx, 18
        lea     rsi, [rel documentary_out_head]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-48H]
        add     rax, 4
        mov     rdi, rax
        call    strlen
        mov     rdx, rax
        mov     rax, qword [rbp-48H]
        lea     rcx, [rax+4H]
        mov     eax, dword [rbp-4CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-4CH]
        mov     edx, 6
        lea     rsi, [rel film_out_year]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-48H]
        mov     eax, dword [rax+68H]
        cdqe
        lea     rdx, [rbp-20H]
        mov     rsi, rdx
        mov     rdi, rax
        call    itoa
        movsxd  rdx, eax
        lea     rcx, [rbp-20H]
        mov     eax, dword [rbp-4CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-4CH]
        mov     edx, 10
        lea     rsi, [rel documentary_out_duration]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-48H]
        mov     eax, dword [rax]
        cdqe
        lea     rdx, [rbp-40H]
        mov     rsi, rdx
        mov     rdi, rax
        call    itoa
        movsxd  rdx, eax
        lea     rcx, [rbp-40H]
        mov     eax, dword [rbp-4CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-4CH]
        mov     edx, 1
        lea     rsi, [rel film_out_tail]
        mov     edi, eax
        call    write
        nop
        leave
        ret
