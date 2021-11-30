
InFeature:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     dword [rbp-0CH], esi
        mov     rax, qword [rbp-8H]
        lea     rdx, [rax+64H]
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
        mov     dword [rdx+0C8H], eax
        mov     rdx, qword [rbp-8H]
        mov     eax, dword [rbp-0CH]
        mov     rsi, rdx
        mov     edi, eax
        call    ReadString
        nop
        leave
        ret

InFeatureStochastic:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 24
        mov     qword [rbp-18H], rdi
        mov     rax, qword [rbp-18H]
        lea     rbx, [rax+64H]
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
        mov     dword [rdx+0C8H], eax
        mov     rbx, qword [rbp-18H]
        mov     esi, 51
        mov     edi, 1
        call    RandomInt
        mov     rsi, rbx
        mov     edi, eax
        call    RandomString
        nop
        add     rsp, 24
        pop     rbx
        pop     rbp
        ret

OutFeature:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 48
        mov     qword [rbp-28H], rdi
        mov     dword [rbp-2CH], esi
        mov     eax, dword [rbp-2CH]
        mov     edx, 14
        lea     rsi, [rel feature_out_head]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-28H]
        add     rax, 100
        mov     rdi, rax
        call    strlen
        mov     rdx, rax
        mov     rax, qword [rbp-28H]
        lea     rcx, [rax+64H]
        mov     eax, dword [rbp-2CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-2CH]
        mov     edx, 6
        lea     rsi, [rel film_out_year]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-28H]
        mov     eax, dword [rax+0C8H]
        cdqe
        lea     rdx, [rbp-20H]
        mov     rsi, rdx
        mov     rdi, rax
        call    itoa
        movsxd  rdx, eax
        lea     rcx, [rbp-20H]
        mov     eax, dword [rbp-2CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-2CH]
        mov     edx, 10
        lea     rsi, [rel feature_out_director]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-28H]
        mov     rdi, rax
        call    strlen
        mov     rdx, rax
        mov     rcx, qword [rbp-28H]
        mov     eax, dword [rbp-2CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-2CH]
        mov     edx, 1
        lea     rsi, [rel film_out_tail]
        mov     edi, eax
        call    write
        nop
        leave
        ret
