ReadIntInExpect:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 64
        mov     dword [rbp-24H], edi
        mov     dword [rbp-28H], esi
        mov     dword [rbp-2CH], edx
        mov     qword [rbp-38H], rcx
        mov     dword [rbp-4H], 0
        mov     byte [rbp-11H], 0
        lea     rcx, [rbp-11H]
        mov     eax, dword [rbp-24H]
        mov     edx, 1
        mov     rsi, rcx
        mov     edi, eax
        call    read
        mov     qword [rbp-10H], rax
        jmp     expect_loop_read

expect_read:  mov     edx, dword [rbp-4H]
        mov     eax, edx
        shl     eax, 2
        add     eax, edx
        add     eax, eax
        mov     edx, eax
        movzx   eax, byte [rbp-11H]
        movsx   eax, al
        sub     eax, 48
        add     eax, edx
        mov     dword [rbp-4H], eax
        mov     rax, qword [rbp-10H]
        sub     rax, 1
        mov     byte [rbp+rax-11H], 0
        lea     rcx, [rbp-11H]
        mov     eax, dword [rbp-24H]
        mov     edx, 1
        mov     rsi, rcx
        mov     edi, eax
        call    read
        mov     qword [rbp-10H], rax
expect_loop_read:  cmp     qword [rbp-10H], 0
        jz      expect_post_read
        movzx   eax, byte [rbp-11H]
        cmp     al, 47
        jle     expect_post_read
        movzx   eax, byte [rbp-11H]
        cmp     al, 57
        jle     expect_read
expect_post_read:  cmp     qword [rbp-10H], 0
        jnz     expect_check
        mov     edx, 15
        lea     rsi, [rel done_reading]
        mov     edi, 1
        call    write
        cmp     dword [rbp-4H], 0
        jz      expect_return_m
        mov     edx, 15
        lea     rsi, [rel unexpected_eof]
        mov     edi, 2
        call    write
        mov     edi, 1
        call    exit
expect_return_m:  mov     eax, 4294967295
        jmp     expect_end

expect_check:  mov     eax, dword [rbp-4H]
        cmp     eax, dword [rbp-28H]
        jl      expect_incorrect_bounds
        mov     eax, dword [rbp-4H]
        cmp     eax, dword [rbp-2CH]
        jle     expect_fine
expect_incorrect_bounds:  mov     rax, qword [rbp-38H]
        mov     rdi, rax
        call    strlen
        mov     rdx, rax
        mov     rax, qword [rbp-38H]
        mov     rsi, rax
        mov     edi, 1
        call    write
        mov     edi, 1
        call    exit
expect_fine:  mov     eax, dword [rbp-4H]
expect_end:  leave
        ret

ReadIntIn:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 64
        mov     dword [rbp-24H], edi
        mov     dword [rbp-28H], esi
        mov     dword [rbp-2CH], edx
        mov     qword [rbp-38H], rcx
        mov     dword [rbp-4H], 0
        lea     rcx, [rbp-11H]
        mov     eax, dword [rbp-24H]
        mov     edx, 1
        mov     rsi, rcx
        mov     edi, eax
        call    read
        mov     qword [rbp-10H], rax
        jmp     int_loop_read

int_read:  mov     edx, dword [rbp-4H]
        mov     eax, edx
        shl     eax, 2
        add     eax, edx
        add     eax, eax
        mov     edx, eax
        movzx   eax, byte [rbp-11H]
        movsx   eax, al
        sub     eax, 48
        add     eax, edx
        mov     dword [rbp-4H], eax
        mov     rax, qword [rbp-10H]
        sub     rax, 1
        mov     byte [rbp+rax-11H], 0
        lea     rcx, [rbp-11H]
        mov     eax, dword [rbp-24H]
        mov     edx, 1
        mov     rsi, rcx
        mov     edi, eax
        call    read
        mov     qword [rbp-10H], rax
int_loop_read:  cmp     qword [rbp-10H], 0
        jz      int_post_check
        movzx   eax, byte [rbp-11H]
        cmp     al, 47
        jle     int_post_check
        movzx   eax, byte [rbp-11H]
        cmp     al, 57
        jle     int_read
int_post_check:  cmp     qword [rbp-10H], 0
        jnz     int_read_advance
        mov     eax, dword [rbp-4H]
        jmp     int_read_end

int_read_advance:  mov     eax, dword [rbp-4H]
        cmp     eax, dword [rbp-28H]
        jl      int_post_read
        mov     eax, dword [rbp-4H]
        cmp     eax, dword [rbp-2CH]
        jle     int_read_fine
int_post_read:  mov     rax, qword [rbp-38H]
        mov     rdi, rax
        call    strlen
        mov     rdx, rax
        mov     rax, qword [rbp-38H]
        mov     rsi, rax
        mov     edi, 1
        call    write
        mov     edi, 1
        call    exit
int_read_fine:  mov     eax, dword [rbp-4H]
int_read_end:  leave
        ret

ReadString:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     dword [rbp-14H], edi
        mov     qword [rbp-20H], rsi
        lea     rcx, [rbp-0DH]
        mov     eax, dword [rbp-14H]
        mov     edx, 1
        mov     rsi, rcx
        mov     edi, eax
        call    read
        mov     qword [rbp-8H], rax
        mov     dword [rbp-0CH], 0
        jmp     str_read_check

str_read_loop:  mov     eax, dword [rbp-0CH]
        lea     edx, [rax+1H]
        mov     dword [rbp-0CH], edx
        movsxd  rdx, eax
        mov     rax, qword [rbp-20H]
        add     rdx, rax
        movzx   eax, byte [rbp-0DH]
        mov     byte [rdx], al
        mov     rax, qword [rbp-8H]
        sub     rax, 1
        mov     byte [rbp+rax-0DH], 0
        lea     rcx, [rbp-0DH]
        mov     eax, dword [rbp-14H]
        mov     edx, 1
        mov     rsi, rcx
        mov     edi, eax
        call    read
        mov     qword [rbp-8H], rax
str_read_check:  cmp     qword [rbp-8H], 0
        jz      str_read_check_incorrect
        movzx   eax, byte [rbp-0DH]
        cmp     al, 96
        jle     str_read_check_incorrect
        movzx   eax, byte [rbp-0DH]
        cmp     al, 122
        jle     str_read_loop
str_read_check_incorrect:  movzx   eax, byte [rbp-0DH]
        cmp     al, 64
        jle     str_read_incorrect
        movzx   eax, byte [rbp-0DH]
        cmp     al, 90
        jle     str_read_loop
str_read_incorrect:  movzx   eax, byte [rbp-0DH]
        cmp     al, 95
        jz      str_read_loop
        cmp     dword [rbp-0CH], 0
        jnz     str_read_end
        mov     edx, 48
        lea     rsi, [rel incorrect_title]
        mov     edi, 1
        call    write
        mov     edi, 1
        call    exit
str_read_end:  mov     eax, dword [rbp-0CH]
        movsxd  rdx, eax
        mov     rax, qword [rbp-20H]
        add     rax, rdx
        mov     byte [rax], 0
        mov     rax, qword [rbp-20H]
        leave
        ret

RandomInt:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     dword [rbp-4H], edi
        mov     dword [rbp-8H], esi
        mov     eax, 0
        call    rand
        mov     edx, dword [rbp-8H]
        mov     ecx, edx
        sub     ecx, dword [rbp-4H]
        cdq
        idiv    ecx
        mov     eax, dword [rbp-4H]
        add     eax, edx
        leave
        ret

RandomString:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     dword [rbp-14H], edi
        mov     qword [rbp-20H], rsi
        mov     dword [rbp-4H], 0
        jmp     loop_letters

make_letter:  mov     esi, 62
        mov     edi, 0
        call    RandomInt
        mov     edx, dword [rbp-4H]
        movsxd  rcx, edx
        mov     rdx, qword [rbp-20H]
        add     rdx, rcx
        cdqe
        lea     rcx, [rel alphabet]
        movzx   eax, byte [rax+rcx]
        mov     byte [rdx], al
        add     dword [rbp-4H], 1
loop_letters:  mov     eax, dword [rbp-4H]
        cmp     eax, dword [rbp-14H]
        jl      make_letter
        mov     eax, dword [rbp-14H]
        movsxd  rdx, eax
        mov     rax, qword [rbp-20H]
        add     rax, rdx
        mov     byte [rax], 0
        nop
        leave
        ret

syscallone:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-20H], rsi
        mov     rax, qword [rbp-18H]
        mov     rdx, qword [rbp-20H]
        mov     rdi, rdx
        syscall
        mov     qword [rbp-8H], rax
        mov     rax, qword [rbp-8H]
        pop     rbp
        ret

syscallthree:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-20H], rsi
        mov     qword [rbp-28H], rdx
        mov     qword [rbp-30H], rcx
        mov     rax, qword [rbp-18H]
        mov     rdi, qword [rbp-20H]
        mov     rsi, qword [rbp-28H]
        mov     rdx, qword [rbp-30H]
        syscall
        mov     qword [rbp-8H], rax
        mov     rax, qword [rbp-8H]
        pop     rbp
        ret

read:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 24
        mov     dword [rbp-4H], edi
        mov     qword [rbp-10H], rsi
        mov     qword [rbp-18H], rdx
        mov     rcx, qword [rbp-18H]
        mov     rdx, qword [rbp-10H]
        mov     eax, dword [rbp-4H]
        cdqe
        mov     rsi, rax
        mov     edi, 0
        call    syscallthree
        leave
        ret

write:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 24
        mov     dword [rbp-4H], edi
        mov     qword [rbp-10H], rsi
        mov     qword [rbp-18H], rdx
        mov     rcx, qword [rbp-18H]
        mov     rdx, qword [rbp-10H]
        mov     eax, dword [rbp-4H]
        cdqe
        mov     rsi, rax
        mov     edi, 1
        call    syscallthree
        leave
        ret

exit:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 8
        mov     dword [rbp-4H], edi
        mov     eax, dword [rbp-4H]
        cdqe
        mov     rsi, rax
        mov     edi, 60
        call    syscallone
        nop
        leave
        ret

open:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     dword [rbp-0CH], esi
        mov     dword [rbp-10H], edx
        mov     eax, dword [rbp-10H]
        movsxd  rcx, eax
        mov     eax, dword [rbp-0CH]
        movsxd  rdx, eax
        mov     rax, qword [rbp-8H]
        mov     rsi, rax
        mov     edi, 2
        call    syscallthree
        leave
        ret

rand:
        push    rbp
        mov     rbp, rsp
        mov     rax, qword [rel __bss_start]
        mov     rdx, qword 5851F42D4C957F2DH
        imul    rax, rdx
        add     rax, 1
        mov     qword [rel __bss_start], rax
        mov     rax, qword [rel __bss_start]
        shr     rax, 33
        pop     rbp
        ret

strlen:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-18H], rdi
        mov     rax, qword [rbp-18H]
        mov     qword [rbp-8H], rax
        jmp     strlen_compare

strlen_next:  add     qword [rbp-18H], 1
strlen_compare:  mov     rax, qword [rbp-18H]
        movzx   eax, byte [rax]
        test    al, al
        jnz     strlen_next
        mov     rax, qword [rbp-18H]
        sub     rax, qword [rbp-8H]
        pop     rbp
        ret

atoi:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-18H], rdi
        mov     dword [rbp-4H], 1
        mov     dword [rbp-8H], 0
        mov     rax, qword [rbp-18H]
        movzx   eax, byte [rax]
        cmp     al, 45
        jnz     loop_digit
        mov     dword [rbp-4H], 1
        add     qword [rbp-18H], 1
loop_digit:  mov     rax, qword [rbp-18H]
        movzx   eax, byte [rax]
        mov     byte [rbp-9H], al
        cmp     byte [rbp-9H], 0
        jz      make_int
        mov     edx, dword [rbp-8H]
        mov     eax, edx
        shl     eax, 2
        add     eax, edx
        add     eax, eax
        mov     edx, eax
        movsx   eax, byte [rbp-9H]
        sub     eax, 48
        add     eax, edx
        mov     dword [rbp-8H], eax
        add     qword [rbp-18H], 1
        jmp     loop_digit

make_int:
        nop
        mov     eax, dword [rbp-4H]
        imul    eax, dword [rbp-8H]
        pop     rbp
        ret

itoa:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-28H], rdi
        mov     qword [rbp-30H], rsi
        mov     rax, qword [rbp-28H]
        mov     dword [rbp-10H], eax
        cmp     dword [rbp-10H], 0
        jns     itoa_init
        neg     qword [rbp-28H]
itoa_init:  mov     dword [rbp-4H], 0
itoa_loop_convert:  mov     rcx, qword [rbp-28H]
        mov     rdx, qword 6666666666666667H
        mov     rax, rcx
        imul    rdx
        sar     rdx, 2
        mov     rax, rcx
        sar     rax, 63
        sub     rdx, rax
        mov     rax, rdx
        shl     rax, 2
        add     rax, rdx
        add     rax, rax
        sub     rcx, rax
        mov     rdx, rcx
        mov     eax, edx
        lea     ecx, [rax+30H]
        mov     eax, dword [rbp-4H]
        lea     edx, [rax+1H]
        mov     dword [rbp-4H], edx
        movsxd  rdx, eax
        mov     rax, qword [rbp-30H]
        add     rax, rdx
        mov     edx, ecx
        mov     byte [rax], dl
        mov     rcx, qword [rbp-28H]
        mov     rdx, qword 6666666666666667H
        mov     rax, rcx
        imul    rdx
        sar     rdx, 2
        mov     rax, rcx
        sar     rax, 63
        sub     rdx, rax
        mov     rax, rdx
        mov     qword [rbp-28H], rax
        cmp     qword [rbp-28H], 0
        jg      itoa_loop_convert
        cmp     dword [rbp-10H], 0
        jns     itoa_reverse_init
        mov     eax, dword [rbp-4H]
        lea     edx, [rax+1H]
        mov     dword [rbp-4H], edx
        movsxd  rdx, eax
        mov     rax, qword [rbp-30H]
        add     rax, rdx
        mov     byte [rax], 45
itoa_reverse_init:  mov     dword [rbp-8H], 0
        mov     eax, dword [rbp-4H]
        sub     eax, 1
        mov     dword [rbp-0CH], eax
        jmp     itoa_reverse_thru

itoa_reverse_loop:  mov     eax, dword [rbp-8H]
        movsxd  rdx, eax
        mov     rax, qword [rbp-30H]
        add     rax, rdx
        movzx   eax, byte [rax]
        mov     byte [rbp-11H], al
        mov     eax, dword [rbp-0CH]
        movsxd  rdx, eax
        mov     rax, qword [rbp-30H]
        add     rax, rdx
        mov     edx, dword [rbp-8H]
        movsxd  rcx, edx
        mov     rdx, qword [rbp-30H]
        add     rdx, rcx
        movzx   eax, byte [rax]
        mov     byte [rdx], al
        mov     eax, dword [rbp-0CH]
        movsxd  rdx, eax
        mov     rax, qword [rbp-30H]
        add     rdx, rax
        movzx   eax, byte [rbp-11H]
        mov     byte [rdx], al
        add     dword [rbp-8H], 1
        sub     dword [rbp-0CH], 1
itoa_reverse_thru:  mov     eax, dword [rbp-8H]
        cmp     eax, dword [rbp-0CH]
        jl      itoa_reverse_loop
        mov     eax, dword [rbp-4H]
        movsxd  rdx, eax
        mov     rax, qword [rbp-30H]
        add     rax, rdx
        mov     byte [rax], 0
        mov     eax, dword [rbp-4H]
        pop     rbp
        ret

equals:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-8H], rdi
        mov     qword [rbp-10H], rsi
        jmp     equals_compare

equals_loop:  mov     rax, qword [rbp-8H]
        movzx   edx, byte [rax]
        mov     rax, qword [rbp-10H]
        movzx   eax, byte [rax]
        cmp     dl, al
        jz      equals_advance
        mov     eax, 0
        jmp     equals_end

equals_advance:  add     qword [rbp-8H], 1
        add     qword [rbp-10H], 1
equals_compare:  mov     rax, qword [rbp-8H]
        movzx   eax, byte [rax]
        test    al, al
        jz      equals_yes
        mov     rax, qword [rbp-10H]
        movzx   eax, byte [rax]
        test    al, al
        jnz     equals_loop
equals_yes:  mov     eax, 1
equals_end:  pop     rbp
        ret

ftoa:
        push    rbp
        mov     rbp, rsp
        movsd   qword [rbp-38H], xmm0
        mov     qword [rbp-40H], rdi
        mov     rax, qword [rbp-40H]
        mov     qword [rbp-8H], rax
        mov     rax, qword [rbp-8H]
        mov     qword [rbp-10H], rax
        pxor    xmm0, xmm0
        comisd  xmm0, qword [rbp-38H]
        jbe     ftoa_round
        movsd   xmm0, qword [rbp-38H]
        movq    xmm1, qword [rel dump]
        xorpd   xmm0, xmm1
        movsd   qword [rbp-38H], xmm0
        mov     rax, qword [rbp-8H]
        lea     rdx, [rax+1H]
        mov     qword [rbp-8H], rdx
        mov     byte [rax], 45
ftoa_round:  movsd   xmm1, qword [rbp-38H]
        movsd   xmm0, qword [rel float_rounder]
        addsd   xmm0, xmm1
        movsd   qword [rbp-38H], xmm0
        movsd   xmm0, qword [rbp-38H]
        cvttsd2si rax, xmm0
        mov     qword [rbp-18H], rax
        cvtsi2sd xmm1, qword [rbp-18H]
        movsd   xmm0, qword [rbp-38H]
        subsd   xmm0, xmm1
        movsd   qword [rbp-38H], xmm0
        cmp     qword [rbp-18H], 0
        jnz     ftoa_start_convert
        mov     rax, qword [rbp-8H]
        lea     rdx, [rax+1H]
        mov     qword [rbp-8H], rdx
        mov     byte [rax], 48
        jmp     ftoa_start_decimal_part

ftoa_start_convert:  mov     rax, qword [rbp-8H]
        mov     qword [rbp-10H], rax
        jmp     ftoa_reverse_order

ftoa_convert_reverse_order:  mov     rcx, qword [rbp-18H]
        mov     rdx, qword 6666666666666667H
        mov     rax, rcx
        imul    rdx
        sar     rdx, 2
        mov     rax, rcx
        sar     rax, 63
        sub     rdx, rax
        mov     rax, rdx
        shl     rax, 2
        add     rax, rdx
        add     rax, rax
        sub     rcx, rax
        mov     rdx, rcx
        mov     eax, edx
        lea     ecx, [rax+30H]
        mov     rax, qword [rbp-10H]
        lea     rdx, [rax+1H]
        mov     qword [rbp-10H], rdx
        mov     edx, ecx
        mov     byte [rax], dl
        mov     rcx, qword [rbp-18H]
        mov     rdx, qword 6666666666666667H
        mov     rax, rcx
        imul    rdx
        sar     rdx, 2
        mov     rax, rcx
        sar     rax, 63
        sub     rdx, rax
        mov     rax, rdx
        mov     qword [rbp-18H], rax
ftoa_reverse_order:  cmp     qword [rbp-18H], 0
        jnz     ftoa_convert_reverse_order
        mov     rax, qword [rbp-10H]
        mov     qword [rbp-28H], rax
        jmp     ftoa_start_reverse_result

ftoa_reverse_result:  sub     qword [rbp-10H], 1
        mov     rax, qword [rbp-10H]
        movzx   eax, byte [rax]
        mov     byte [rbp-29H], al
        mov     rax, qword [rbp-8H]
        movzx   edx, byte [rax]
        mov     rax, qword [rbp-10H]
        mov     byte [rax], dl
        mov     rax, qword [rbp-8H]
        lea     rdx, [rax+1H]
        mov     qword [rbp-8H], rdx
        movzx   edx, byte [rbp-29H]
        mov     byte [rax], dl
ftoa_start_reverse_result:  mov     rax, qword [rbp-10H]
        cmp     rax, qword [rbp-8H]
        ja      ftoa_reverse_result
        mov     rax, qword [rbp-28H]
        mov     qword [rbp-8H], rax
ftoa_start_decimal_part:  mov     rax, qword [rbp-8H]
        lea     rdx, [rax+1H]
        mov     qword [rbp-8H], rdx
        mov     byte [rax], 46
        mov     dword [rbp-1CH], 2
        jmp     ftoa_start_convert_precision

ftoa_convert_precision:  movsd   xmm1, qword [rbp-38H]
        movsd   xmm0, qword [rel float_base]
        mulsd   xmm0, xmm1
        movsd   qword [rbp-38H], xmm0
        movsd   xmm0, qword [rbp-38H]
        cvttsd2si eax, xmm0
        mov     byte [rbp-29H], al
        movzx   eax, byte [rbp-29H]
        lea     ecx, [rax+30H]
        mov     rax, qword [rbp-8H]
        lea     rdx, [rax+1H]
        mov     qword [rbp-8H], rdx
        mov     edx, ecx
        mov     byte [rax], dl
        movsx   eax, byte [rbp-29H]
        cvtsi2sd xmm1, eax
        movsd   xmm0, qword [rbp-38H]
        subsd   xmm0, xmm1
        movsd   qword [rbp-38H], xmm0
ftoa_start_convert_precision:  mov     eax, dword [rbp-1CH]
        lea     edx, [rax-1H]
        mov     dword [rbp-1CH], edx
        test    eax, eax
        jnz     ftoa_convert_precision
        mov     rax, qword [rbp-8H]
        mov     byte [rax], 0
        mov     rax, qword [rbp-40H]
        pop     rbp
        ret

swap:
        push    rbp                                     
        mov     rbp, rsp                                
        push    rbx                                     
        sub     rsp, 104                                
        mov     qword [rbp-0E0H], rdi                   
        mov     qword [rbp-0E8H], rsi                   
        mov     rax, qword [rbp-0E0H]                   
        mov     rcx, qword [rax]                        
        mov     rbx, qword [rax+8H]                     
        mov     qword [rbp-0D8H], rcx                   
        mov     qword [rbp-0D0H], rbx                   
        mov     rcx, qword [rax+10H]                    
        mov     rbx, qword [rax+18H]                    
        mov     qword [rbp-0C8H], rcx                   
        mov     qword [rbp-0C0H], rbx                   
        mov     rcx, qword [rax+20H]                    
        mov     rbx, qword [rax+28H]                    
        mov     qword [rbp-0B8H], rcx                   
        mov     qword [rbp-0B0H], rbx                   
        mov     rcx, qword [rax+30H]                    
        mov     rbx, qword [rax+38H]                    
        mov     qword [rbp-0A8H], rcx                   
        mov     qword [rbp-0A0H], rbx                   
        mov     rcx, qword [rax+40H]                    
        mov     rbx, qword [rax+48H]                    
        mov     qword [rbp-98H], rcx                    
        mov     qword [rbp-90H], rbx                    
        mov     rcx, qword [rax+50H]                    
        mov     rbx, qword [rax+58H]                    
        mov     qword [rbp-88H], rcx                    
        mov     qword [rbp-80H], rbx                    
        mov     rcx, qword [rax+60H]                    
        mov     rbx, qword [rax+68H]                    
        mov     qword [rbp-78H], rcx                    
        mov     qword [rbp-70H], rbx                    
        mov     rcx, qword [rax+70H]                    
        mov     rbx, qword [rax+78H]                    
        mov     qword [rbp-68H], rcx                    
        mov     qword [rbp-60H], rbx                    
        mov     rcx, qword [rax+80H]                    
        mov     rbx, qword [rax+88H]                    
        mov     qword [rbp-58H], rcx                    
        mov     qword [rbp-50H], rbx                    
        mov     rcx, qword [rax+90H]                    
        mov     rbx, qword [rax+98H]                    
        mov     qword [rbp-48H], rcx                    
        mov     qword [rbp-40H], rbx                    
        mov     rcx, qword [rax+0A0H]                   
        mov     rbx, qword [rax+0A8H]                   
        mov     qword [rbp-38H], rcx                    
        mov     qword [rbp-30H], rbx                    
        mov     rcx, qword [rax+0B0H]                   
        mov     rbx, qword [rax+0B8H]                   
        mov     qword [rbp-28H], rcx                    
        mov     qword [rbp-20H], rbx                    
        mov     rdx, qword [rax+0C8H]                   
        mov     rax, qword [rax+0C0H]                   
        mov     qword [rbp-18H], rax                    
        mov     qword [rbp-10H], rdx                    
        mov     rax, qword [rbp-0E0H]                   
        mov     rdx, qword [rbp-0E8H]                   
        mov     rcx, qword [rdx]                        
        mov     rbx, qword [rdx+8H]                     
        mov     qword [rax], rcx                        
        mov     qword [rax+8H], rbx                     
        mov     rcx, qword [rdx+10H]                    
        mov     rbx, qword [rdx+18H]                    
        mov     qword [rax+10H], rcx                    
        mov     qword [rax+18H], rbx                    
        mov     rcx, qword [rdx+20H]                    
        mov     rbx, qword [rdx+28H]                    
        mov     qword [rax+20H], rcx                    
        mov     qword [rax+28H], rbx                    
        mov     rcx, qword [rdx+30H]                    
        mov     rbx, qword [rdx+38H]                    
        mov     qword [rax+30H], rcx                    
        mov     qword [rax+38H], rbx                    
        mov     rcx, qword [rdx+40H]                    
        mov     rbx, qword [rdx+48H]                    
        mov     qword [rax+40H], rcx                    
        mov     qword [rax+48H], rbx                    
        mov     rcx, qword [rdx+50H]                    
        mov     rbx, qword [rdx+58H]                    
        mov     qword [rax+50H], rcx                    
        mov     qword [rax+58H], rbx                    
        mov     rcx, qword [rdx+60H]                    
        mov     rbx, qword [rdx+68H]                    
        mov     qword [rax+60H], rcx                    
        mov     qword [rax+68H], rbx                    
        mov     rcx, qword [rdx+70H]                    
        mov     rbx, qword [rdx+78H]                    
        mov     qword [rax+70H], rcx                    
        mov     qword [rax+78H], rbx                    
        mov     rcx, qword [rdx+80H]                    
        mov     rbx, qword [rdx+88H]                    
        mov     qword [rax+80H], rcx                    
        mov     qword [rax+88H], rbx                    
        mov     rcx, qword [rdx+90H]                    
        mov     rbx, qword [rdx+98H]                    
        mov     qword [rax+90H], rcx                    
        mov     qword [rax+98H], rbx                    
        mov     rcx, qword [rdx+0A0H]                   
        mov     rbx, qword [rdx+0A8H]                   
        mov     qword [rax+0A0H], rcx                   
        mov     qword [rax+0A8H], rbx                   
        mov     rcx, qword [rdx+0B0H]                   
        mov     rbx, qword [rdx+0B8H]                   
        mov     qword [rax+0B0H], rcx                   
        mov     qword [rax+0B8H], rbx                   
        mov     rcx, qword [rdx+0C0H]                   
        mov     rbx, qword [rdx+0C8H]                   
        mov     qword [rax+0C0H], rcx                   
        mov     qword [rax+0C8H], rbx                   
        mov     rax, qword [rbp-0E8H]                   
        mov     rcx, qword [rbp-0D8H]                   
        mov     rbx, qword [rbp-0D0H]                   
        mov     qword [rax], rcx                        
        mov     qword [rax+8H], rbx                     
        mov     rcx, qword [rbp-0C8H]                   
        mov     rbx, qword [rbp-0C0H]                   
        mov     qword [rax+10H], rcx                    
        mov     qword [rax+18H], rbx                    
        mov     rcx, qword [rbp-0B8H]                   
        mov     rbx, qword [rbp-0B0H]                   
        mov     qword [rax+20H], rcx                    
        mov     qword [rax+28H], rbx                    
        mov     rcx, qword [rbp-0A8H]                   
        mov     rbx, qword [rbp-0A0H]                   
        mov     qword [rax+30H], rcx                    
        mov     qword [rax+38H], rbx                    
        mov     rcx, qword [rbp-98H]                    
        mov     rbx, qword [rbp-90H]                    
        mov     qword [rax+40H], rcx                    
        mov     qword [rax+48H], rbx                    
        mov     rcx, qword [rbp-88H]                    
        mov     rbx, qword [rbp-80H]                    
        mov     qword [rax+50H], rcx                    
        mov     qword [rax+58H], rbx                    
        mov     rcx, qword [rbp-78H]                    
        mov     rbx, qword [rbp-70H]                    
        mov     qword [rax+60H], rcx                    
        mov     qword [rax+68H], rbx                    
        mov     rcx, qword [rbp-68H]                    
        mov     rbx, qword [rbp-60H]                    
        mov     qword [rax+70H], rcx                    
        mov     qword [rax+78H], rbx                    
        mov     rcx, qword [rbp-58H]                    
        mov     rbx, qword [rbp-50H]                    
        mov     qword [rax+80H], rcx                    
        mov     qword [rax+88H], rbx                    
        mov     rcx, qword [rbp-48H]                    
        mov     rbx, qword [rbp-40H]                    
        mov     qword [rax+90H], rcx                    
        mov     qword [rax+98H], rbx                    
        mov     rcx, qword [rbp-38H]                    
        mov     rbx, qword [rbp-30H]                    
        mov     qword [rax+0A0H], rcx                   
        mov     qword [rax+0A8H], rbx                   
        mov     rcx, qword [rbp-28H]                    
        mov     rbx, qword [rbp-20H]                    
        mov     qword [rax+0B0H], rcx                   
        mov     qword [rax+0B8H], rbx                   
        mov     rcx, qword [rbp-18H]                    
        mov     rbx, qword [rbp-10H]                    
        mov     qword [rax+0C0H], rcx                   
        mov     qword [rax+0C8H], rbx                   
        nop                                             
        add     rsp, 104                                
        pop     rbx                                     
        pop     rbp                                     
        ret                                             
