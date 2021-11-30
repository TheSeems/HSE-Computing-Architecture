Init:
        push    rbp
        mov     rbp, rsp
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     dword [rax], 0
        nop
        pop     rbp
        ret

Clear:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 8
        mov     qword [rbp-8H], rdi
        mov     rax, qword [rbp-8H]
        mov     rdi, rax
        call    Init
        nop
        leave
        ret


InContainer:                            
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 16                                 
        mov     qword [rbp-8H], rdi                     
        mov     dword [rbp-0CH], esi                    
check_read_film:  mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax]                        
        mov     edx, 10000                              
        cmp     eax, edx                                
        jl      place_film                                   
        mov     edx, 76                                 
        lea     rsi, [rel container_lack]                        
        mov     edi, 1                                  
        call    write                                   
        mov     edi, 2                                  
        call    exit                                    
place_film:  mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax]                        
        movsxd  rdx, eax                                
        mov     rax, rdx                                
        add     rax, rax                                
        add     rax, rdx                                
        shl     rax, 2                                  
        add     rax, rdx                                
        shl     rax, 4                                  
        mov     rdx, qword [rbp-8H]                     
        add     rax, rdx                                
        lea     rdx, [rax+4H]                           
        mov     eax, dword [rbp-0CH]                    
        mov     esi, eax                                
        mov     rdi, rdx                                
        call    InFilm                                  
        cmp     eax, -1                                 
        jz      end_read_film                                   
        mov     rax, qword [rbp-8H]                     
        mov     eax, dword [rax]                        
        lea     edx, [rax+1H]                           
        mov     rax, qword [rbp-8H]                     
        mov     dword [rax], edx                        
        jmp     check_read_film                                   
end_read_film:  
        nop                                             
        nop                                             
        leave                                           
        ret                         

InContainerStochastic:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     dword [rbp-1CH], esi                    
        mov     eax, 10000                              
        cmp     dword [rbp-1CH], eax                    
        jle     generate_loop                                   
        mov     edx, 83                                 
        lea     rsi, [rel container_stochastic_lack]                        
        mov     edi, 1                                  
        call    write                                   
        mov     edi, 2                                  
        call    exit                                    
generate_loop:  mov     dword [rbp-4H], 0                       
        jmp     end_place_random_film                                   

place_random_film:  mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        lea     ecx, [rax+1H]                           
        mov     rdx, qword [rbp-18H]                    
        mov     dword [rdx], ecx                        
        movsxd  rdx, eax                                
        mov     rax, rdx                                
        add     rax, rax                                
        add     rax, rdx                                
        shl     rax, 2                                  
        add     rax, rdx                                
        shl     rax, 4                                  
        mov     rdx, qword [rbp-18H]                    
        add     rax, rdx                                
        add     rax, 4                                  
        mov     rdi, rax                                
        call    InFilmStochastic                        
        add     dword [rbp-4H], 1                       
end_place_random_film:  mov     eax, dword [rbp-4H]                     
        cmp     eax, dword [rbp-1CH]                    
        jl      place_random_film                                   
        nop                                             
        nop                                             
        leave                                           
        ret                                             

OutContainer:
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 96                                 
        mov     qword [rbp-58H], rdi                    
        mov     dword [rbp-5CH], esi                    
        mov     dword [rbp-4H], 0                       
        jmp     loop_write_films                                   

write_film:  mov     eax, dword [rbp-4H]                     
        add     eax, 1                                  
        cdqe                                            
        lea     rdx, [rbp-30H]                          
        mov     rsi, rdx                                
        mov     rdi, rax                                
        call    itoa                                    
        movsxd  rdx, eax                                
        lea     rcx, [rbp-30H]                          
        mov     eax, dword [rbp-5CH]                    
        mov     rsi, rcx                                
        mov     edi, eax                                
        call    write                                   
        mov     eax, dword [rbp-5CH]                    
        mov     edx, 2                                  
        lea     rsi, [rel film_out_pre]                        
        mov     edi, eax                                
        call    write                                   
        mov     eax, dword [rbp-4H]                     
        movsxd  rdx, eax                                
        mov     rax, rdx                                
        add     rax, rax                                
        add     rax, rdx                                
        shl     rax, 2                                  
        add     rax, rdx                                
        shl     rax, 4                                  
        mov     rdx, qword [rbp-58H]                    
        add     rax, rdx                                
        add     rax, 4                                  
        mov     qword [rbp-10H], rax                    
        mov     rax, qword [rbp-10H]                    
        mov     eax, dword [rax]                        
        test    eax, eax                                
        jnz     write_cartoon                                   
        mov     rax, qword [rbp-10H]                    
        lea     rdx, [rax+4H]                           
        mov     eax, dword [rbp-5CH]                    
        mov     esi, eax                                
        mov     rdi, rdx                                
        call    OutFeature                              
write_cartoon:  mov     rax, qword [rbp-10H]                    
        mov     eax, dword [rax]                        
        cmp     eax, 1                                  
        jnz     write_documentary                                   
        mov     rax, qword [rbp-10H]                    
        lea     rdx, [rax+4H]                           
        mov     eax, dword [rbp-5CH]                    
        mov     esi, eax                                
        mov     rdi, rdx                                
        call    OutCartoon                              
write_documentary:  mov     rax, qword [rbp-10H]                    
        mov     eax, dword [rax]                        
        cmp     eax, 2                                  
        jnz     write_additional_sort_key_func                                   
        mov     rax, qword [rbp-10H]                    
        lea     rdx, [rax+4H]                           
        mov     eax, dword [rbp-5CH]                    
        mov     esi, eax                                
        mov     rdi, rdx                                
        call    OutDocumentary                          
write_additional_sort_key_func:  mov     eax, dword [rbp-5CH]                    
        mov     edx, 13                                 
        lea     rsi, [rel film_out_sort_key]                        
        mov     edi, eax                                
        call    write                                   
        mov     rax, qword [rbp-10H]                    
        mov     rdi, rax                                
        call    YearOverTitleSymbols                    
        lea     rax, [rbp-50H]                          
        mov     rdi, rax                                
        call    ftoa                                    
        lea     rax, [rbp-50H]                          
        mov     rdi, rax                                
        call    strlen                                  
        mov     rdx, rax                                
        lea     rcx, [rbp-50H]                          
        mov     eax, dword [rbp-5CH]                    
        mov     rsi, rcx                                
        mov     edi, eax                                
        call    write                                   
        mov     eax, dword [rbp-5CH]                    
        mov     edx, 1                                  
        lea     rsi, [rel film_out_post]                        
        mov     edi, eax                                
        call    write                                   
        add     dword [rbp-4H], 1                       
loop_write_films:  mov     rax, qword [rbp-58H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-4H], eax                     
        jl      write_film                                   
        nop                                             
        nop                                             
        leave                                           
        ret                                             

Sort:                                  
        push    rbp                                     
        mov     rbp, rsp                                
        sub     rsp, 32                                 
        mov     qword [rbp-18H], rdi                    
        mov     dword [rbp-4H], 0                       
        jmp     outer_body_iterate                                   

inner_body_iterate:  mov     eax, dword [rbp-4H]                     
        mov     dword [rbp-8H], eax                     
        jmp     inner_body                                   

body_calculate_sort:  mov     eax, dword [rbp-8H]                     
        movsxd  rdx, eax                                
        mov     rax, rdx                                
        add     rax, rax                                
        add     rax, rdx                                
        shl     rax, 2                                  
        add     rax, rdx                                
        shl     rax, 4                                  
        mov     rdx, qword [rbp-18H]                    
        add     rax, rdx                                
        add     rax, 4                                  
        mov     rdi, rax                                
        call    YearOverTitleSymbols                    
        movsd   qword [rbp-20H], xmm0                   
        mov     eax, dword [rbp-4H]                     
        movsxd  rdx, eax                                
        mov     rax, rdx                                
        add     rax, rax                                
        add     rax, rdx                                
        shl     rax, 2                                  
        add     rax, rdx                                
        shl     rax, 4                                  
        mov     rdx, qword [rbp-18H]                    
        add     rax, rdx                                
        add     rax, 4                                  
        mov     rdi, rax                                
        call    YearOverTitleSymbols                    
        movsd   xmm1, qword [rbp-20H]                   
        comisd  xmm1, xmm0                              
        jbe     inner_iterate                                   
        mov     eax, dword [rbp-4H]                     
        movsxd  rdx, eax                                
        mov     rax, rdx                                
        add     rax, rax                                
        add     rax, rdx                                
        shl     rax, 2                                  
        add     rax, rdx                                
        shl     rax, 4                                  
        mov     rdx, qword [rbp-18H]                    
        add     rax, rdx                                
        lea     rcx, [rax+4H]                           
        mov     eax, dword [rbp-8H]                     
        movsxd  rdx, eax                                
        mov     rax, rdx                                
        add     rax, rax                                
        add     rax, rdx                                
        shl     rax, 2                                  
        add     rax, rdx                                
        shl     rax, 4                                  
        mov     rdx, qword [rbp-18H]                    
        add     rax, rdx                                
        add     rax, 4                                  
        mov     rsi, rcx                                
        mov     rdi, rax                                
        call    swap                                    
inner_iterate:  add     dword [rbp-8H], 1                       
inner_body:  mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-8H], eax                     
        jl      body_calculate_sort                                   
        add     dword [rbp-4H], 1                       
outer_body_iterate:  mov     rax, qword [rbp-18H]                    
        mov     eax, dword [rax]                        
        cmp     dword [rbp-4H], eax                     
        jl      inner_body_iterate                                   
        nop                                             
        nop                                             
        leave                                           
        ret                                             