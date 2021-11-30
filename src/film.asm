InFilm:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     dword [rbp-1CH], esi
        mov     eax, dword [rbp-1CH]
        lea     rcx, [rel wrong_genre_provided]
        mov     edx, 3
        mov     esi, 1
        mov     edi, eax
        call    ReadIntInExpect
        mov     dword [rbp-4H], eax
        cmp     dword [rbp-4H], 1
        jnz     in_cartoon
        mov     rax, qword [rbp-18H]
        mov     dword [rax], 0
        mov     rax, qword [rbp-18H]
        lea     rdx, [rax+4H]
        mov     eax, dword [rbp-1CH]
        mov     esi, eax
        mov     rdi, rdx
        call    InFeature
        jmp     in_end

in_cartoon:  cmp     dword [rbp-4H], 2
        jnz     in_documentary
        mov     rax, qword [rbp-18H]
        mov     dword [rax], 1
        mov     rax, qword [rbp-18H]
        lea     rdx, [rax+4H]
        mov     eax, dword [rbp-1CH]
        mov     esi, eax
        mov     rdi, rdx
        call    InCartoon
        jmp     in_end

in_documentary:  cmp     dword [rbp-4H], 3
        jnz     in_end
        mov     rax, qword [rbp-18H]
        mov     dword [rax], 2
        mov     rax, qword [rbp-18H]
        lea     rdx, [rax+4H]
        mov     eax, dword [rbp-1CH]
        mov     esi, eax
        mov     rdi, rdx
        call    InDocumentary
in_end:  mov     eax, dword [rbp-4H]
        leave
        ret

InFilmStochastic:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     esi, 4
        mov     edi, 1
        call    RandomInt
        mov     dword [rbp-4H], eax
        cmp     dword [rbp-4H], 1
        jnz     in_cartoon_stochastic
        mov     rax, qword [rbp-18H]
        mov     dword [rax], 0
        mov     rax, qword [rbp-18H]
        add     rax, 4
        mov     rdi, rax
        call    InFeatureStochastic
        jmp     in_stochastic_end

in_cartoon_stochastic:  cmp     dword [rbp-4H], 2
        jnz     in_documentary_stochastic
        mov     rax, qword [rbp-18H]
        mov     dword [rax], 1
        mov     rax, qword [rbp-18H]
        add     rax, 4
        mov     rdi, rax
        call    InCartoonStochastic
        jmp     in_stochastic_end

in_documentary_stochastic:  cmp     dword [rbp-4H], 3
        jnz     in_stochastic_wrong_genre
        mov     rax, qword [rbp-18H]
        mov     dword [rax], 2
        mov     rax, qword [rbp-18H]
        add     rax, 4
        mov     rdi, rax
        call    InDocumentaryStochastic
        jmp     in_stochastic_end

in_stochastic_wrong_genre:  mov     edx, 46
        lea     rsi, [rel wrong_genre_produced]
        mov     edi, 1
        call    write
        mov     edi, 2
        call    exit
in_stochastic_end:  nop
        leave
        ret

YearOverTitleSymbols:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]
        test    eax, eax
        jnz     second_alternative
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax+0CCH]
        mov     dword [rbp-4H], eax
        mov     rax, qword [rbp-18H]
        add     rax, 104
        mov     qword [rbp-10H], rax
        jmp     calculate_func

second_alternative:  mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]
        cmp     eax, 1
        jnz     third_alternative
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax+6CH]
        mov     dword [rbp-4H], eax
        mov     rax, qword [rbp-18H]
        add     rax, 8
        mov     qword [rbp-10H], rax
        jmp     calculate_func

third_alternative:  mov     rax, qword [rbp-18H]
        mov     eax, dword [rax]
        cmp     eax, 2
        jnz     incorrect_alternative
        mov     rax, qword [rbp-18H]
        mov     eax, dword [rax+6CH]
        mov     dword [rbp-4H], eax
        mov     rax, qword [rbp-18H]
        add     rax, 8
        mov     qword [rbp-10H], rax
        jmp     calculate_func

incorrect_alternative:  mov     edx, 69
        lea     rsi, [rel internal_genre_incorrect]
        mov     edi, 1
        call    write
        mov     edi, 2
        call    exit
calculate_func:  cvtsi2sd xmm2, dword [rbp-4H]
        movsd   qword [rbp-20H], xmm2
        mov     rax, qword [rbp-10H]
        mov     rdi, rax
        call    strlen
        test    rax, rax
        js      convert_scalar_double
        cvtsi2sd xmm0, rax
        jmp     perform

convert_scalar_double:  mov     rdx, rax
        shr     rdx, 1
        and     eax, 01H
        or      rdx, rax
        cvtsi2sd xmm0, rdx
        addsd   xmm0, xmm0
perform:  movsd   xmm1, qword [rbp-20H]
        divsd   xmm1, xmm0
        movapd  xmm0, xmm1
        leave
        ret