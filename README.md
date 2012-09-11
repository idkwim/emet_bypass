Bypassing EMET 3.5′s ROP Mitigations

EMET’s ROP mitigation works around hooking certain APIs (Like VirtualProtect) with Shim Engine and monitors their initialization.I have used SHARED_USER_DATA which mapped at fixed address “0x7FFE0000″ to find KiFastSystemCall address (SystemCallStub at “0x7FFE0300″), So I could call any syscall by now! By calling ZwProtectVirtualMemory’s SYSCALL “0x0D7″, I made shellcode’s memory address RWX. After this step I could execute any instruction I wanted. But to execute actual shellcode (with hooked APIs like “WinExec”) I did patched EMET to be deactivated completely.I also bypassed EMET ROP mitigations using another EMET’s implementation mistake. EMET team forget about the KernelBase.dll and left all its functions unprotected. so I used @antic0de‘s method for finding base address of kernelbase.dll at run-time, then I used VirtualProtect inside the kernelbase.dll, not ntdll.dll or krenel32.dll.

Shahriyar Jalayeri
*repret.wordpress.com
*twitter.com/ponez