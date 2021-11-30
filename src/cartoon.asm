MapType:
        push    rbp
        mov     rbp, rsp
        mov     dword [rbp-14H], edi
        mov     qword [rbp-8H], 0
        cmp     dword [rbp-14H], 0
        jnz     type_puppet
        lea     rax, [rel drawing_string]
        mov     qword [rbp-8H], rax
        jmp     type_none

type_puppet:  cmp     dword [rbp-14H], 1
        jnz     type_plasticine
        lea     rax, [rel puppet_string]
        mov     qword [rbp-8H], rax
        jmp     type_none

type_plasticine:  cmp     dword [rbp-14H], 2
        jnz     type_none
        lea     rax, [rel plasticine_string]
        mov     qword [rbp-8H], rax
type_none:  mov     rax, qword [rbp-8H]
        pop     rbp
        ret

MapStr:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        lea     rsi, [rel drawing_string]
        mov     rdi, rax
        call    equals
        test    eax, eax
        jz      str_puppet
        mov     eax, 0
        jmp     str_end

str_puppet:  mov     rax, qword [rbp-8H]
        lea     rsi, [rel puppet_string]
        mov     rdi, rax
        call    equals
        test    eax, eax
        jz      str_plasticine
        mov     eax, 1
        jmp     str_end

str_plasticine:  mov     rax, qword [rbp-8H]
        lea     rsi, [rel plasticine_string]
        mov     rdi, rax
        call    equals
        test    eax, eax
        jz      str_none
        mov     eax, 2
        jmp     str_end

str_none:  mov     edx, 38
        lea     rsi, [rel incorrect_cartoon]
        mov     edi, 1
        call    write
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    strlen
        mov     rdx, rax
        mov     rax, qword [rbp-8H]
        mov     rsi, rax
        mov     edi, 1
        call    write
        mov     edi, 1
        call    exit
str_end:  leave
        ret

MapNum:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 48
        mov     dword [rbp-24H], edi
        cmp     dword [rbp-24H], 1
        jnz     num_puppet
        mov     eax, 0
        jmp     num_end

num_puppet:  cmp     dword [rbp-24H], 2
        jnz     num_plasticine
        mov     eax, 1
        jmp     num_end

num_plasticine:  cmp     dword [rbp-24H], 3
        jnz     num_none
        mov     eax, 2
        jmp     num_end

num_none:  mov     edx, 59
        lea     rsi, [rel incorrect_genre_number]
        mov     edi, 1
        call    write
        mov     eax, dword [rbp-24H]
        cdqe
        lea     rdx, [rbp-20H]
        mov     rsi, rdx
        mov     rdi, rax
        call    itoa
        movsxd  rdx, eax
        lea     rax, [rbp-20H]
        mov     rsi, rax
        mov     edi, 1
        call    write
        mov     edi, 2
        call    exit
num_end:  leave
        ret

InCartoon:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 1024
        mov     qword [rbp-3F8H], rdi
        mov     dword [rbp-3FCH], esi
        mov     rax, qword [rbp-3F8H]
        lea     rdx, [rax+4H]
        mov     eax, dword [rbp-3FCH]
        mov     rsi, rdx
        mov     edi, eax
        call    ReadString
        mov     eax, dword [rbp-3FCH]
        lea     rcx, [rel incorrect_year]
        mov     edx, 3022
        mov     esi, 1970
        mov     edi, eax
        call    ReadIntIn
        mov     rdx, qword [rbp-3F8H]
        mov     dword [rdx+68H], eax
        lea     rdx, [rbp-3F0H]
        mov     eax, dword [rbp-3FCH]
        mov     rsi, rdx
        mov     edi, eax
        call    ReadString
        mov     rdi, rax
        call    MapStr
        mov     rdx, qword [rbp-3F8H]
        mov     dword [rdx], eax
        nop
        leave
        ret

InCartoonStochastic:
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
        mov     esi, 4
        mov     edi, 1
        call    RandomInt
        mov     edi, eax
        call    MapNum
        mov     rdx, qword [rbp-18H]
        mov     dword [rdx], eax
        nop
        add     rsp, 24
        pop     rbx
        pop     rbp
        ret

OutCartoon:
        push    rbp
        mov     rbp, rsp
        push    rbx
        sub     rsp, 56
        mov     qword [rbp-38H], rdi
        mov     dword [rbp-3CH], esi
        mov     eax, dword [rbp-3CH]
        mov     edx, 14
        lea     rsi, [rel cartoon_out_head]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-38H]
        add     rax, 4
        mov     rdi, rax
        call    strlen
        mov     rdx, rax
        mov     rax, qword [rbp-38H]
        lea     rcx, [rax+4H]
        mov     eax, dword [rbp-3CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-3CH]
        mov     edx, 6
        lea     rsi, [rel film_out_year]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-38H]
        mov     eax, dword [rax+68H]
        cdqe
        lea     rdx, [rbp-30H]
        mov     rsi, rdx
        mov     rdi, rax
        call    itoa
        movsxd  rdx, eax
        lea     rcx, [rbp-30H]
        mov     eax, dword [rbp-3CH]
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-3CH]
        mov     edx, 6
        lea     rsi, [rel cartoon_out_type]
        mov     edi, eax
        call    write
        mov     rax, qword [rbp-38H]
        mov     eax, dword [rax]
        mov     edi, eax
        call    MapType
        mov     rdi, rax
        call    strlen
        mov     rbx, rax
        mov     rax, qword [rbp-38H]
        mov     eax, dword [rax]
        mov     edi, eax
        call    MapType
        mov     rcx, rax
        mov     eax, dword [rbp-3CH]
        mov     rdx, rbx
        mov     rsi, rcx
        mov     edi, eax
        call    write
        mov     eax, dword [rbp-3CH]
        mov     edx, 1
        lea     rsi, [rel film_out_tail]
        mov     edi, eax
        call    write
        nop
        add     rsp, 56
        pop     rbx
        pop     rbp
        ret