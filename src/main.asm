
default rel

global _end
global MapType: function
global MapStr: function
global MapNum: function
global InCartoon: function
global InCartoonStochastic: function
global OutCartoon: function
global Init: function
global Clear: function
global InContainer: function
global InContainerStochastic: function
global OutContainer: function
global Sort: function
global InDocumentary: function
global InDocumentaryStochastic: function
global OutDocumentary: function
global InFeature: function
global InFeatureStochastic: function
global OutFeature: function
global InFilm: function
global InFilmStochastic: function
global YearOverTitleSymbols: function
global ReadIntInExpect: function
global ReadIntIn: function
global ReadString: function
global RandomInt: function
global RandomString: function
global atoi: function
global itoa: function
global equals: function
global ftoa: function
global SendIncorrectUsage: function
global SendIncorrectQualifier: function
global SendIncorrectSize: function
global ViaFile: function
global ViaStochastic: function
global SortWithContainer: function
global main: function
global _start: function
global CONTAINER_MAX_SIZE
global _edata
global __bss_start


SECTION .text

%include "src/cartoon.asm"
%include "src/container.asm"
%include "src/documentary.asm"
%include "src/feature.asm"
%include "src/film.asm"
%include "src/io.asm"

SendIncorrectUsage:
        push    rbp
        mov     rbp, rsp
        lea     rdi, [rel incorrect_usage]
        call    strlen
        mov     rdx, rax
        lea     rsi, [rel incorrect_usage]
        mov     edi, 1
        call    write
        nop
        pop     rbp
        ret

SendIncorrectQualifier:
        push    rbp
        mov     rbp, rsp
        lea     rdi, [rel when_incorrect_qualifier]
        call    strlen
        mov     rdx, rax
        lea     rsi, [rel when_incorrect_qualifier]
        mov     edi, 1
        call    write
        nop
        pop     rbp
        ret

SendIncorrectSize:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 8
        mov     dword [rbp-4H], edi
        lea     rdi, [rel incorrect_size]
        call    strlen
        mov     rdx, rax
        lea     rsi, [rel incorrect_size]
        mov     edi, 1
        call    write
        nop
        leave
        ret

ViaFile:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-20H], rsi
        mov     rax, qword [rbp-20H]
        mov     edx, 420
        mov     esi, 0
        mov     rdi, rax
        call    open
        mov     dword [rbp-4H], eax
        mov     edx, dword [rbp-4H]
        mov     rax, qword [rbp-18H]
        mov     esi, edx
        mov     rdi, rax
        call    InContainer
        nop
        leave
        ret

ViaStochastic:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     qword [rbp-8H], rdi
        mov     dword [rbp-0CH], esi
        cmp     dword [rbp-0CH], 0
        jle     stochastic_incorrect_size
        cmp     dword [rbp-0CH], 10000
        jle     stochastic_input_container
stochastic_incorrect_size:  mov     eax, dword [rbp-0CH]
        mov     edi, eax
        call    SendIncorrectSize
        mov     edi, 3
        call    exit
stochastic_input_container:  mov     edx, dword [rbp-0CH]
        mov     rax, qword [rbp-8H]
        mov     esi, edx
        mov     rdi, rax
        call    InContainerStochastic
        nop
        leave
        ret

SortWithContainer:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 48
        mov     qword [rbp-18H], rdi
        mov     qword [rbp-20H], rsi
        mov     qword [rbp-28H], rdx
        mov     rax, qword [rbp-20H]
        mov     edx, 420
        mov     esi, 65
        mov     rdi, rax
        call    open
        mov     dword [rbp-4H], eax
        mov     eax, dword [rbp-4H]
        mov     edx, 17
        lea     rsi, [rel input_container_header]
        mov     edi, eax
        call    write
        mov     edx, dword [rbp-4H]
        mov     rax, qword [rbp-18H]
        mov     esi, edx
        mov     rdi, rax
        call    OutContainer
        mov     rax, qword [rbp-28H]
        mov     edx, 420
        mov     esi, 65
        mov     rdi, rax
        call    open
        mov     dword [rbp-8H], eax
        mov     rax, qword [rbp-18H]
        mov     rdi, rax
        call    Sort
        mov     eax, dword [rbp-8H]
        mov     edx, 18
        lea     rsi, [rel sorted_container_header]
        mov     edi, eax
        call    write
        mov     edx, dword [rbp-8H]
        mov     rax, qword [rbp-18H]
        mov     esi, edx
        mov     rdi, rax
        call    OutContainer
        mov     rax, qword [rbp-18H]
        mov     rdi, rax
        call    Clear
        nop
        leave
        ret

main:
        push    rbp
        mov     rbp, rsp
        lea     r11, [rsp-1FB000H]
check_args:  sub     rsp, 4096
        or      dword [rsp], 00H
        cmp     rsp, r11
        jnz     check_args
        sub     rsp, 3360
        mov     dword [rbp-1FBD14H], edi
        mov     qword [rbp-1FBD20H], rsi
        cmp     dword [rbp-1FBD14H], 5
        jz      from_file
        mov     eax, 0
        call    SendIncorrectUsage
        mov     eax, 1
        jmp     end_main

from_file:  mov     edx, 6
        lea     rsi, [rel start_output]
        mov     edi, 1
        call    write
        lea     rax, [rbp-1FBD10H]
        mov     rdi, rax
        call    Init
        mov     rax, qword [rbp-1FBD20H]
        add     rax, 8
        mov     rax, qword [rax]
        lea     rsi, [rel file_flag]
        mov     rdi, rax
        call    equals
        test    eax, eax
        jz      stochastic
        mov     rax, qword [rbp-1FBD20H]
        add     rax, 16
        mov     rdx, qword [rax]
        lea     rax, [rbp-1FBD10H]
        mov     rsi, rdx
        mov     rdi, rax
        call    ViaFile
        jmp     sort_container

stochastic:  mov     rax, qword [rbp-1FBD20H]
        add     rax, 8
        mov     rax, qword [rax]
        lea     rsi, [rel random_flag]
        mov     rdi, rax
        call    equals
        test    eax, eax
        jz      when_incorrect_qualifier
        mov     rax, qword [rbp-1FBD20H]
        add     rax, 16
        mov     rax, qword [rax]
        mov     rdi, rax
        call    atoi
        mov     edx, eax
        lea     rax, [rbp-1FBD10H]
        mov     esi, edx
        mov     rdi, rax
        call    ViaStochastic
        jmp     sort_container

when_incorrect_qualifier:  mov     eax, 0
        call    SendIncorrectQualifier
        mov     eax, 2
        jmp     end_main

sort_container:  mov     rax, qword [rbp-1FBD20H]
        add     rax, 32
        mov     rdx, qword [rax]
        mov     rax, qword [rbp-1FBD20H]
        add     rax, 24
        mov     rcx, qword [rax]
        lea     rax, [rbp-1FBD10H]
        mov     rsi, rcx
        mov     rdi, rax
        call    SortWithContainer
        mov     eax, 0
end_main:  leave
        ret

_start:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 16
        mov     rax, qword [rbp+8H]
        mov     qword [rbp-8H], rax
        mov     rax, rbp
        add     rax, 16
        mov     qword [rbp-10H], rax
        mov     rax, qword [rbp-8H]
        mov     edx, eax
        mov     rax, qword [rbp-10H]
        mov     rsi, rax
        mov     edi, edx
        call    main
        mov     edi, 0
        call    exit
        nop
        leave
        ret


%include "src/constants.asm"
