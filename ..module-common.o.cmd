savedcmd_.module-common.o :=  x86_64-linux-gnu-gcc-15 -Wp,-MMD,./..module-common.o.d -nostdinc -I/usr/src/linux-headers-6.18.12+kali-common/arch/x86/include -I/usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated -I/usr/src/linux-headers-6.18.12+kali-common/include -I/usr/src/linux-headers-6.18.12+kali-amd64/include -I/usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi -I/usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi -I/usr/src/linux-headers-6.18.12+kali-common/include/uapi -I/usr/src/linux-headers-6.18.12+kali-amd64/include/generated/uapi -include /usr/src/linux-headers-6.18.12+kali-common/include/linux/compiler-version.h -include /usr/src/linux-headers-6.18.12+kali-common/include/linux/kconfig.h -include /usr/src/linux-headers-6.18.12+kali-common/include/linux/compiler_types.h -D__KERNEL__ -std=gnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE -fno-strict-aliasing -mno-sse -mno-mmx -mno-sse2 -mno-3dnow -mno-avx -mno-sse4a -fcf-protection=branch -fno-jump-tables -m64 -falign-jumps=1 -falign-loops=1 -mno-80387 -mno-fp-ret-in-387 -mpreferred-stack-boundary=3 -mskip-rax-setup -march=x86-64 -mtune=generic -mno-red-zone -mcmodel=kernel -mstack-protector-guard-reg=gs -mstack-protector-guard-symbol=__ref_stack_chk_guard -Wno-sign-compare -fno-asynchronous-unwind-tables -mindirect-branch=thunk-extern -mindirect-branch-register -mindirect-branch-cs-prefix -mfunction-return=thunk-extern -fno-jump-tables -mharden-sls=all -fpatchable-function-entry=16,16 -fno-delete-null-pointer-checks -O2 -fno-allow-store-data-races -fstack-protector-strong -ftrivial-auto-var-init=zero -fzero-init-padding-bits=all -fno-stack-clash-protection -pg -mrecord-mcount -mfentry -DCC_USING_FENTRY -fmin-function-alignment=16 -fstrict-flex-arrays=3 -fno-strict-overflow -fno-stack-check -fconserve-stack -fno-builtin-wcslen -Wall -Wextra -Wundef -Werror=implicit-function-declaration -Werror=implicit-int -Werror=return-type -Werror=strict-prototypes -Wno-format-security -Wno-trigraphs -Wno-frame-address -Wno-address-of-packed-member -Wmissing-declarations -Wmissing-prototypes -Wframe-larger-than=2048 -Wno-main -Wno-dangling-pointer -Wvla-larger-than=1 -Wno-pointer-sign -Wcast-function-type -Wno-unterminated-string-initialization -Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-larger-than -Wimplicit-fallthrough=5 -Werror=date-time -Werror=incompatible-pointer-types -Werror=designated-init -Wenum-conversion -Wunused -Wno-unused-but-set-variable -Wno-unused-const-variable -Wno-packed-not-aligned -Wno-format-overflow -Wno-format-truncation -Wno-stringop-truncation -Wno-override-init -Wno-missing-field-initializers -Wno-type-limits -Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-parameter -g  -fsanitize=bounds-strict -fsanitize=shift    -DMODULE  -DKBUILD_BASENAME='".module_common"' -DKBUILD_MODNAME='".module_common.o"' -D__KBUILD_MODNAME=kmod_.module_common.o -c -o .module-common.o /usr/src/linux-headers-6.18.12+kali-common/scripts/module-common.c   ; /usr/src/linux-headers-6.18.12+kali-amd64/tools/objtool/objtool --hacks=jump_label --hacks=noinstr --hacks=skylake --ibt --orc --retpoline --rethunk --sls --static-call --uaccess --prefix=16  --link  --module .module-common.o

source_.module-common.o := /usr/src/linux-headers-6.18.12+kali-common/scripts/module-common.c

deps_.module-common.o := \
    $(wildcard include/config/UNWINDER_ORC) \
    $(wildcard include/config/MITIGATION_RETPOLINE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/compiler-version.h \
    $(wildcard include/config/CC_VERSION_TEXT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kconfig.h \
    $(wildcard include/config/CPU_BIG_ENDIAN) \
    $(wildcard include/config/BOOGER) \
    $(wildcard include/config/FOO) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/compiler_types.h \
    $(wildcard include/config/DEBUG_INFO_BTF) \
    $(wildcard include/config/PAHOLE_HAS_BTF_TAG) \
    $(wildcard include/config/FUNCTION_ALIGNMENT) \
    $(wildcard include/config/CC_HAS_SANE_FUNCTION_ALIGNMENT) \
    $(wildcard include/config/X86_64) \
    $(wildcard include/config/ARM64) \
    $(wildcard include/config/LD_DEAD_CODE_DATA_ELIMINATION) \
    $(wildcard include/config/LTO_CLANG) \
    $(wildcard include/config/HAVE_ARCH_COMPILER_H) \
    $(wildcard include/config/CC_HAS_ASSUME) \
    $(wildcard include/config/CC_HAS_COUNTED_BY) \
    $(wildcard include/config/CC_HAS_MULTIDIMENSIONAL_NONSTRING) \
    $(wildcard include/config/UBSAN_INTEGER_WRAP) \
    $(wildcard include/config/CFI) \
    $(wildcard include/config/ARCH_USES_CFI_GENERIC_LLVM_PASS) \
    $(wildcard include/config/CC_HAS_ASM_INLINE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/compiler_attributes.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/compiler-gcc.h \
    $(wildcard include/config/ARCH_USE_BUILTIN_BSWAP) \
    $(wildcard include/config/SHADOW_CALL_STACK) \
    $(wildcard include/config/KCOV) \
    $(wildcard include/config/CC_HAS_TYPEOF_UNQUAL) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/module.h \
    $(wildcard include/config/MODULES) \
    $(wildcard include/config/SYSFS) \
    $(wildcard include/config/MODULES_TREE_LOOKUP) \
    $(wildcard include/config/LIVEPATCH) \
    $(wildcard include/config/STACKTRACE_BUILD_ID) \
    $(wildcard include/config/ARCH_USES_CFI_TRAPS) \
    $(wildcard include/config/MODULE_SIG) \
    $(wildcard include/config/GENERIC_BUG) \
    $(wildcard include/config/KALLSYMS) \
    $(wildcard include/config/SMP) \
    $(wildcard include/config/TRACEPOINTS) \
    $(wildcard include/config/TREE_SRCU) \
    $(wildcard include/config/BPF_EVENTS) \
    $(wildcard include/config/DEBUG_INFO_BTF_MODULES) \
    $(wildcard include/config/JUMP_LABEL) \
    $(wildcard include/config/TRACING) \
    $(wildcard include/config/EVENT_TRACING) \
    $(wildcard include/config/DYNAMIC_FTRACE) \
    $(wildcard include/config/KPROBES) \
    $(wildcard include/config/HAVE_STATIC_CALL_INLINE) \
    $(wildcard include/config/KUNIT) \
    $(wildcard include/config/PRINTK_INDEX) \
    $(wildcard include/config/MODULE_UNLOAD) \
    $(wildcard include/config/CONSTRUCTORS) \
    $(wildcard include/config/FUNCTION_ERROR_INJECTION) \
    $(wildcard include/config/DYNAMIC_DEBUG_CORE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/list.h \
    $(wildcard include/config/LIST_HARDENED) \
    $(wildcard include/config/DEBUG_LIST) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/container_of.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/build_bug.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/compiler.h \
    $(wildcard include/config/TRACE_BRANCH_PROFILING) \
    $(wildcard include/config/PROFILE_ALL_BRANCHES) \
    $(wildcard include/config/OBJTOOL) \
    $(wildcard include/config/64BIT) \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/rwonce.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/rwonce.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kasan-checks.h \
    $(wildcard include/config/KASAN_GENERIC) \
    $(wildcard include/config/KASAN_SW_TAGS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/types.h \
    $(wildcard include/config/HAVE_UID16) \
    $(wildcard include/config/UID16) \
    $(wildcard include/config/ARCH_DMA_ADDR_T_64BIT) \
    $(wildcard include/config/PHYS_ADDR_T_64BIT) \
    $(wildcard include/config/ARCH_32BIT_USTAT_F_TINODE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/types.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/int-ll64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/int-ll64.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/bitsperlong.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitsperlong.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/bitsperlong.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/posix_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/stddef.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/stddef.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/posix_types.h \
    $(wildcard include/config/X86_32) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/posix_types_64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/posix_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kcsan-checks.h \
    $(wildcard include/config/KCSAN) \
    $(wildcard include/config/KCSAN_WEAK_MEMORY) \
    $(wildcard include/config/KCSAN_IGNORE_ATOMICS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/poison.h \
    $(wildcard include/config/ILLEGAL_POINTER_VALUE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/const.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/const.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/const.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/barrier.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/alternative.h \
    $(wildcard include/config/CALL_THUNKS) \
    $(wildcard include/config/MITIGATION_ITS) \
    $(wildcard include/config/MITIGATION_RETHUNK) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/stringify.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/objtool.h \
    $(wildcard include/config/FRAME_POINTER) \
    $(wildcard include/config/NOINSTR_VALIDATION) \
    $(wildcard include/config/MITIGATION_UNRET_ENTRY) \
    $(wildcard include/config/MITIGATION_SRSO) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/objtool_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/asm.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/extable_fixup_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/bug.h \
    $(wildcard include/config/DEBUG_BUGVERBOSE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/instrumentation.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bug.h \
    $(wildcard include/config/BUG) \
    $(wildcard include/config/GENERIC_BUG_RELATIVE_POINTERS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/once_lite.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/panic.h \
    $(wildcard include/config/PANIC_TIMEOUT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/stdarg.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/printk.h \
    $(wildcard include/config/MESSAGE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_DEFAULT) \
    $(wildcard include/config/CONSOLE_LOGLEVEL_QUIET) \
    $(wildcard include/config/EARLY_PRINTK) \
    $(wildcard include/config/PRINTK) \
    $(wildcard include/config/DYNAMIC_DEBUG) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/init.h \
    $(wildcard include/config/MEMORY_HOTPLUG) \
    $(wildcard include/config/HAVE_ARCH_PREL32_RELOCATIONS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kern_levels.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/linkage.h \
    $(wildcard include/config/ARCH_USE_SYM_ANNOTATIONS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/export.h \
    $(wildcard include/config/MODVERSIONS) \
    $(wildcard include/config/GENDWARFKSYMS) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/linkage.h \
    $(wildcard include/config/CALL_PADDING) \
    $(wildcard include/config/MITIGATION_SLS) \
    $(wildcard include/config/FUNCTION_PADDING_BYTES) \
    $(wildcard include/config/UML) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/ibt.h \
    $(wildcard include/config/X86_KERNEL_IBT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/ratelimit_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bits.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/bits.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/bits.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/overflow.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/limits.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/limits.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/limits.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/param.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/param.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/param.h \
    $(wildcard include/config/HZ) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/param.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/spinlock_types_raw.h \
    $(wildcard include/config/DEBUG_SPINLOCK) \
    $(wildcard include/config/DEBUG_LOCK_ALLOC) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/spinlock_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/qspinlock_types.h \
    $(wildcard include/config/NR_CPUS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/qrwlock_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/byteorder.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/byteorder/little_endian.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/byteorder/little_endian.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/swab.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/swab.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/swab.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/byteorder/generic.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/lockdep_types.h \
    $(wildcard include/config/PROVE_RAW_LOCK_NESTING) \
    $(wildcard include/config/LOCKDEP) \
    $(wildcard include/config/LOCK_STAT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/dynamic_debug.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/jump_label.h \
    $(wildcard include/config/HAVE_ARCH_JUMP_LABEL_RELATIVE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/cleanup.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/err.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/errno.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/errno.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/errno-base.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/args.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/jump_label.h \
    $(wildcard include/config/HAVE_JUMP_LABEL_HACK) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/nops.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/barrier.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/stat.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/stat.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/stat.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/time.h \
    $(wildcard include/config/POSIX_TIMERS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/cache.h \
    $(wildcard include/config/ARCH_HAS_CACHE_LINE_SIZE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/kernel.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/sysinfo.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/cache.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cache.h \
    $(wildcard include/config/X86_L1_CACHE_SHIFT) \
    $(wildcard include/config/X86_INTERNODE_CACHE_SHIFT) \
    $(wildcard include/config/X86_VSMP) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/math64.h \
    $(wildcard include/config/ARCH_SUPPORTS_INT128) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/math.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/div64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/div64.h \
    $(wildcard include/config/CC_OPTIMIZE_FOR_PERFORMANCE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/math64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/time64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/time64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/time.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/time_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/time32.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/timex.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/timex.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/timex.h \
    $(wildcard include/config/X86_TSC) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/processor.h \
    $(wildcard include/config/X86_VMX_FEATURE_NAMES) \
    $(wildcard include/config/X86_IOPL_IOPERM) \
    $(wildcard include/config/VM86) \
    $(wildcard include/config/X86_USER_SHADOW_STACK) \
    $(wildcard include/config/X86_DEBUG_FPU) \
    $(wildcard include/config/USE_X86_SEG_SUPPORT) \
    $(wildcard include/config/PARAVIRT_XXL) \
    $(wildcard include/config/CPU_SUP_AMD) \
    $(wildcard include/config/XEN) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/processor-flags.h \
    $(wildcard include/config/MITIGATION_PAGE_TABLE_ISOLATION) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/processor-flags.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mem_encrypt.h \
    $(wildcard include/config/ARCH_HAS_MEM_ENCRYPT) \
    $(wildcard include/config/AMD_MEM_ENCRYPT) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/mem_encrypt.h \
    $(wildcard include/config/X86_MEM_ENCRYPT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/cc_platform.h \
    $(wildcard include/config/ARCH_HAS_CC_PLATFORM) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/math_emu.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/ptrace.h \
    $(wildcard include/config/PARAVIRT) \
    $(wildcard include/config/IA32_EMULATION) \
    $(wildcard include/config/X86_DEBUGCTLMSR) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/segment.h \
    $(wildcard include/config/XEN_PV) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/page_types.h \
    $(wildcard include/config/PHYSICAL_START) \
    $(wildcard include/config/PHYSICAL_ALIGN) \
    $(wildcard include/config/DYNAMIC_PHYSICAL_MASK) \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/page.h \
    $(wildcard include/config/PAGE_SHIFT) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/page_64_types.h \
    $(wildcard include/config/KASAN) \
    $(wildcard include/config/RANDOMIZE_BASE) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/kaslr.h \
    $(wildcard include/config/RANDOMIZE_MEMORY) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/ptrace.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/ptrace-abi.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/paravirt_types.h \
    $(wildcard include/config/ZERO_CALL_USED_REGS) \
    $(wildcard include/config/PARAVIRT_DEBUG) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/desc_defs.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/pgtable_types.h \
    $(wildcard include/config/X86_INTEL_MEMORY_PROTECTION_KEYS) \
    $(wildcard include/config/X86_PAE) \
    $(wildcard include/config/MEM_SOFT_DIRTY) \
    $(wildcard include/config/HAVE_ARCH_USERFAULTFD_WP) \
    $(wildcard include/config/PGTABLE_LEVELS) \
    $(wildcard include/config/PROC_FS) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/pgtable_64_types.h \
    $(wildcard include/config/KMSAN) \
    $(wildcard include/config/DEBUG_KMAP_LOCAL_FORCE_MAP) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/sparsemem.h \
    $(wildcard include/config/SPARSEMEM) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/nospec-branch.h \
    $(wildcard include/config/CALL_THUNKS_DEBUG) \
    $(wildcard include/config/MITIGATION_CALL_DEPTH_TRACKING) \
    $(wildcard include/config/MITIGATION_IBPB_ENTRY) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/static_key.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cpufeatures.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/msr-index.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/unwind_hints.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/orc_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/percpu.h \
    $(wildcard include/config/CC_HAS_NAMED_AS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/percpu.h \
    $(wildcard include/config/DEBUG_PREEMPT) \
    $(wildcard include/config/HAVE_SETUP_PER_CPU_AREA) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/threads.h \
    $(wildcard include/config/BASE_SMALL) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/percpu-defs.h \
    $(wildcard include/config/ARCH_MODULE_NEEDS_WEAK_PER_CPU) \
    $(wildcard include/config/DEBUG_FORCE_WEAK_PER_CPU) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/asm-offsets.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/include/generated/asm-offsets.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/GEN-for-each-reg.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/proto.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/ldt.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/sigcontext.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/current.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cpuid/api.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cpuid/types.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/string.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/string_64.h \
    $(wildcard include/config/ARCH_HAS_UACCESS_FLUSHCACHE) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/paravirt.h \
    $(wildcard include/config/PARAVIRT_SPINLOCKS) \
    $(wildcard include/config/DEBUG_ENTRY) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bug.h \
    $(wildcard include/config/BUG_ON_DATA_CORRUPTION) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/cpumask.h \
    $(wildcard include/config/FORCE_NR_CPUS) \
    $(wildcard include/config/HOTPLUG_CPU) \
    $(wildcard include/config/DEBUG_PER_CPU_MAPS) \
    $(wildcard include/config/CPUMASK_OFFSTACK) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kernel.h \
    $(wildcard include/config/PREEMPT_VOLUNTARY_BUILD) \
    $(wildcard include/config/PREEMPT_DYNAMIC) \
    $(wildcard include/config/HAVE_PREEMPT_DYNAMIC_CALL) \
    $(wildcard include/config/HAVE_PREEMPT_DYNAMIC_KEY) \
    $(wildcard include/config/PREEMPT_) \
    $(wildcard include/config/DEBUG_ATOMIC_SLEEP) \
    $(wildcard include/config/MMU) \
    $(wildcard include/config/PROVE_LOCKING) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/align.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/align.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/array_size.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bitops.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/typecheck.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/generic-non-atomic.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/bitops.h \
    $(wildcard include/config/X86_CMOV) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/rmwcc.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/sched.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/arch_hweight.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/const_hweight.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/instrumented-atomic.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/instrumented.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kmsan-checks.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/instrumented-non-atomic.h \
    $(wildcard include/config/KCSAN_ASSUME_PLAIN_WRITES_ATOMIC) \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/instrumented-lock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/le.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/bitops/ext2-atomic-setbit.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/hex.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kstrtox.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/log2.h \
    $(wildcard include/config/ARCH_HAS_ILOG2_U32) \
    $(wildcard include/config/ARCH_HAS_ILOG2_U64) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/minmax.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sprintf.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/static_call_types.h \
    $(wildcard include/config/HAVE_STATIC_CALL) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/instruction_pointer.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/util_macros.h \
    $(wildcard include/config/FOO_SUSPEND) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/wordpart.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bitmap.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/errno.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/errno.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/find.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/string.h \
    $(wildcard include/config/BINARY_PRINTF) \
    $(wildcard include/config/FORTIFY_SOURCE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/string.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/fortify-string.h \
    $(wildcard include/config/CC_HAS_KASAN_MEMINTRINSIC_PREFIX) \
    $(wildcard include/config/GENERIC_ENTRY) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bitfield.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bitmap-str.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/cpumask_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/atomic.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/atomic.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cmpxchg.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cmpxchg_64.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/atomic64_64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/atomic/atomic-arch-fallback.h \
    $(wildcard include/config/GENERIC_ATOMIC64) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/atomic/atomic-long.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/atomic/atomic-instrumented.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/gfp_types.h \
    $(wildcard include/config/KASAN_HW_TAGS) \
    $(wildcard include/config/SLAB_OBJ_EXT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/numa.h \
    $(wildcard include/config/NUMA_KEEP_MEMINFO) \
    $(wildcard include/config/NUMA) \
    $(wildcard include/config/HAVE_ARCH_NODE_DEV_GROUP) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/nodemask.h \
    $(wildcard include/config/HIGHMEM) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/nodemask_types.h \
    $(wildcard include/config/NODES_SHIFT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/random.h \
    $(wildcard include/config/VMGENID) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/random.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/ioctl.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/ioctl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/ioctl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/ioctl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/irqnr.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/irqnr.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/frame.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/page.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/page_64.h \
    $(wildcard include/config/DEBUG_VIRTUAL) \
    $(wildcard include/config/X86_VSYSCALL_EMULATION) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/range.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/memory_model.h \
    $(wildcard include/config/FLATMEM) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/pfn.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/getorder.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/special_insns.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/irqflags.h \
    $(wildcard include/config/TRACE_IRQFLAGS) \
    $(wildcard include/config/PREEMPT_RT) \
    $(wildcard include/config/IRQSOFF_TRACER) \
    $(wildcard include/config/PREEMPT_TRACER) \
    $(wildcard include/config/DEBUG_IRQFLAGS) \
    $(wildcard include/config/TRACE_IRQFLAGS_SUPPORT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/irqflags_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/irqflags.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/fpu/types.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/vmxfeatures.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/vdso/processor.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/shstk.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/personality.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/personality.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/tsc.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cpufeature.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/cpufeaturemasks.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/msr.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/cpumask.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/msr.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/shared/msr.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/percpu.h \
    $(wildcard include/config/RANDOM_KMALLOC_CACHES) \
    $(wildcard include/config/PAGE_SIZE_4KB) \
    $(wildcard include/config/NEED_PER_CPU_PAGE_FIRST_CHUNK) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/alloc_tag.h \
    $(wildcard include/config/MEM_ALLOC_PROFILING_DEBUG) \
    $(wildcard include/config/MEM_ALLOC_PROFILING) \
    $(wildcard include/config/MEM_ALLOC_PROFILING_ENABLED_BY_DEFAULT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/codetag.h \
    $(wildcard include/config/CODE_TAGGING) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/preempt.h \
    $(wildcard include/config/PREEMPT_COUNT) \
    $(wildcard include/config/TRACE_PREEMPT_TOGGLE) \
    $(wildcard include/config/PREEMPTION) \
    $(wildcard include/config/PREEMPT_NOTIFIERS) \
    $(wildcard include/config/PREEMPT_NONE) \
    $(wildcard include/config/PREEMPT_VOLUNTARY) \
    $(wildcard include/config/PREEMPT) \
    $(wildcard include/config/PREEMPT_LAZY) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/preempt.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/smp.h \
    $(wildcard include/config/UP_LATE_INIT) \
    $(wildcard include/config/CSD_LOCK_WAIT_DEBUG) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/smp_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/llist.h \
    $(wildcard include/config/ARCH_HAVE_NMI_SAFE_CMPXCHG) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/thread_info.h \
    $(wildcard include/config/THREAD_INFO_IN_TASK) \
    $(wildcard include/config/ARCH_HAS_PREEMPT_LAZY) \
    $(wildcard include/config/HAVE_ARCH_WITHIN_STACK_FRAMES) \
    $(wildcard include/config/SH) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/restart_block.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/thread_info.h \
    $(wildcard include/config/X86_FRED) \
    $(wildcard include/config/COMPAT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/thread_info_tif.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/smp.h \
    $(wildcard include/config/DEBUG_NMI_SELFTEST) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mmdebug.h \
    $(wildcard include/config/DEBUG_VM) \
    $(wildcard include/config/DEBUG_VM_IRQSOFF) \
    $(wildcard include/config/DEBUG_VM_PGFLAGS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched.h \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_NATIVE) \
    $(wildcard include/config/SCHED_INFO) \
    $(wildcard include/config/SCHEDSTATS) \
    $(wildcard include/config/SCHED_CORE) \
    $(wildcard include/config/FAIR_GROUP_SCHED) \
    $(wildcard include/config/RT_GROUP_SCHED) \
    $(wildcard include/config/RT_MUTEXES) \
    $(wildcard include/config/UCLAMP_TASK) \
    $(wildcard include/config/UCLAMP_BUCKETS_COUNT) \
    $(wildcard include/config/KMAP_LOCAL) \
    $(wildcard include/config/SCHED_CLASS_EXT) \
    $(wildcard include/config/CGROUP_SCHED) \
    $(wildcard include/config/CFS_BANDWIDTH) \
    $(wildcard include/config/BLK_DEV_IO_TRACE) \
    $(wildcard include/config/PREEMPT_RCU) \
    $(wildcard include/config/TASKS_RCU) \
    $(wildcard include/config/TASKS_TRACE_RCU) \
    $(wildcard include/config/MEMCG_V1) \
    $(wildcard include/config/LRU_GEN) \
    $(wildcard include/config/COMPAT_BRK) \
    $(wildcard include/config/CGROUPS) \
    $(wildcard include/config/BLK_CGROUP) \
    $(wildcard include/config/PSI) \
    $(wildcard include/config/PAGE_OWNER) \
    $(wildcard include/config/EVENTFD) \
    $(wildcard include/config/ARCH_HAS_CPU_PASID) \
    $(wildcard include/config/X86_BUS_LOCK_DETECT) \
    $(wildcard include/config/TASK_DELAY_ACCT) \
    $(wildcard include/config/STACKPROTECTOR) \
    $(wildcard include/config/ARCH_HAS_SCALED_CPUTIME) \
    $(wildcard include/config/VIRT_CPU_ACCOUNTING_GEN) \
    $(wildcard include/config/NO_HZ_FULL) \
    $(wildcard include/config/POSIX_CPUTIMERS) \
    $(wildcard include/config/POSIX_CPU_TIMERS_TASK_WORK) \
    $(wildcard include/config/KEYS) \
    $(wildcard include/config/SYSVIPC) \
    $(wildcard include/config/DETECT_HUNG_TASK) \
    $(wildcard include/config/IO_URING) \
    $(wildcard include/config/AUDIT) \
    $(wildcard include/config/AUDITSYSCALL) \
    $(wildcard include/config/DETECT_HUNG_TASK_BLOCKER) \
    $(wildcard include/config/UBSAN) \
    $(wildcard include/config/UBSAN_TRAP) \
    $(wildcard include/config/COMPACTION) \
    $(wildcard include/config/TASK_XACCT) \
    $(wildcard include/config/CPUSETS) \
    $(wildcard include/config/X86_CPU_RESCTRL) \
    $(wildcard include/config/FUTEX) \
    $(wildcard include/config/PERF_EVENTS) \
    $(wildcard include/config/NUMA_BALANCING) \
    $(wildcard include/config/RSEQ) \
    $(wildcard include/config/DEBUG_RSEQ) \
    $(wildcard include/config/SCHED_MM_CID) \
    $(wildcard include/config/FAULT_INJECTION) \
    $(wildcard include/config/LATENCYTOP) \
    $(wildcard include/config/FUNCTION_GRAPH_TRACER) \
    $(wildcard include/config/MEMCG) \
    $(wildcard include/config/UPROBES) \
    $(wildcard include/config/BCACHE) \
    $(wildcard include/config/VMAP_STACK) \
    $(wildcard include/config/SECURITY) \
    $(wildcard include/config/BPF_SYSCALL) \
    $(wildcard include/config/KSTACK_ERASE) \
    $(wildcard include/config/KSTACK_ERASE_METRICS) \
    $(wildcard include/config/X86_MCE) \
    $(wildcard include/config/KRETPROBES) \
    $(wildcard include/config/RETHOOK) \
    $(wildcard include/config/ARCH_HAS_PARANOID_L1D_FLUSH) \
    $(wildcard include/config/RV) \
    $(wildcard include/config/RV_PER_TASK_MONITORS) \
    $(wildcard include/config/USER_EVENTS) \
    $(wildcard include/config/UNWIND_USER) \
    $(wildcard include/config/SCHED_PROXY_EXEC) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/sched.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/pid_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sem_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/shm.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/shmparam.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kmsan_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mutex_types.h \
    $(wildcard include/config/MUTEX_SPIN_ON_OWNER) \
    $(wildcard include/config/DEBUG_MUTEXES) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/osq_lock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/spinlock_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rwlock_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/plist_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/hrtimer_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/timerqueue_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rbtree_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/timer_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/seccomp_types.h \
    $(wildcard include/config/SECCOMP) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/refcount_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/resource.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/resource.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/resource.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/resource.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/resource.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/latencytop.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/prio.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/signal_types.h \
    $(wildcard include/config/OLD_SIGACTION) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/signal.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/signal.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/signal.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/signal-defs.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/siginfo.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/siginfo.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/spinlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bottom_half.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/lockdep.h \
    $(wildcard include/config/DEBUG_LOCKING_API_SELFTESTS) \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/mmiowb.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/mmiowb.h \
    $(wildcard include/config/MMIOWB) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/spinlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/qspinlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/qspinlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/qrwlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/qrwlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rwlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/spinlock_api_smp.h \
    $(wildcard include/config/INLINE_SPIN_LOCK) \
    $(wildcard include/config/INLINE_SPIN_LOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK) \
    $(wildcard include/config/INLINE_SPIN_TRYLOCK_BH) \
    $(wildcard include/config/UNINLINE_SPIN_UNLOCK) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_BH) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_SPIN_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/GENERIC_LOCKBREAK) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rwlock_api_smp.h \
    $(wildcard include/config/INLINE_READ_LOCK) \
    $(wildcard include/config/INLINE_WRITE_LOCK) \
    $(wildcard include/config/INLINE_READ_LOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_LOCK_BH) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_WRITE_LOCK_IRQSAVE) \
    $(wildcard include/config/INLINE_READ_TRYLOCK) \
    $(wildcard include/config/INLINE_WRITE_TRYLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK) \
    $(wildcard include/config/INLINE_READ_UNLOCK_BH) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_BH) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQ) \
    $(wildcard include/config/INLINE_READ_UNLOCK_IRQRESTORE) \
    $(wildcard include/config/INLINE_WRITE_UNLOCK_IRQRESTORE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/syscall_user_dispatch_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mm_types_task.h \
    $(wildcard include/config/ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/tlbbatch.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/netdevice_xmit.h \
    $(wildcard include/config/NET_EGRESS) \
    $(wildcard include/config/NET_ACT_MIRRED) \
    $(wildcard include/config/NF_DUP_NETDEV) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/task_io_accounting.h \
    $(wildcard include/config/TASK_IO_ACCOUNTING) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/posix-timers_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/rseq.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/seqlock_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kcsan.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rv.h \
    $(wildcard include/config/RV_LTL_MONITOR) \
    $(wildcard include/config/RV_REACTORS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/uidgid_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/tracepoint-defs.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/unwind_deferred_types.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/kmap_size.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/kmap_size.h \
    $(wildcard include/config/DEBUG_KMAP_LOCAL) \
  /usr/src/linux-headers-6.18.12+kali-amd64/include/generated/rq-offsets.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/ext.h \
    $(wildcard include/config/EXT_GROUP_SCHED) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rhashtable-types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mutex.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/debug_locks.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/workqueue_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/time32.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/time.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/uidgid.h \
    $(wildcard include/config/MULTIUSER) \
    $(wildcard include/config/USER_NS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/highuid.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/buildid.h \
    $(wildcard include/config/VMCORE_INFO) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kmod.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/umh.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/gfp.h \
    $(wildcard include/config/ZONE_DMA) \
    $(wildcard include/config/ZONE_DMA32) \
    $(wildcard include/config/ZONE_DEVICE) \
    $(wildcard include/config/CONTIG_ALLOC) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mmzone.h \
    $(wildcard include/config/ARCH_FORCE_MAX_ORDER) \
    $(wildcard include/config/PAGE_BLOCK_MAX_ORDER) \
    $(wildcard include/config/CMA) \
    $(wildcard include/config/MEMORY_ISOLATION) \
    $(wildcard include/config/ZSMALLOC) \
    $(wildcard include/config/UNACCEPTED_MEMORY) \
    $(wildcard include/config/IOMMU_SUPPORT) \
    $(wildcard include/config/SWAP) \
    $(wildcard include/config/HUGETLB_PAGE) \
    $(wildcard include/config/TRANSPARENT_HUGEPAGE) \
    $(wildcard include/config/LRU_GEN_STATS) \
    $(wildcard include/config/LRU_GEN_WALKS_MMU) \
    $(wildcard include/config/MEMORY_FAILURE) \
    $(wildcard include/config/PAGE_EXTENSION) \
    $(wildcard include/config/DEFERRED_STRUCT_PAGE_INIT) \
    $(wildcard include/config/HAVE_MEMORYLESS_NODES) \
    $(wildcard include/config/SPARSEMEM_EXTREME) \
    $(wildcard include/config/SPARSEMEM_VMEMMAP_PREINIT) \
    $(wildcard include/config/HAVE_ARCH_PFN_VALID) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/list_nulls.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/wait.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/seqlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/pageblock-flags.h \
    $(wildcard include/config/HUGETLB_PAGE_SIZE_VARIABLE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/page-flags-layout.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/include/generated/bounds.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mm_types.h \
    $(wildcard include/config/HAVE_ALIGNED_STRUCT_PAGE) \
    $(wildcard include/config/HUGETLB_PMD_PAGE_TABLE_SHARING) \
    $(wildcard include/config/SLAB_FREELIST_HARDENED) \
    $(wildcard include/config/USERFAULTFD) \
    $(wildcard include/config/ANON_VMA_NAME) \
    $(wildcard include/config/PER_VMA_LOCK) \
    $(wildcard include/config/HAVE_ARCH_COMPAT_MMAP_BASES) \
    $(wildcard include/config/MEMBARRIER) \
    $(wildcard include/config/FUTEX_PRIVATE_HASH) \
    $(wildcard include/config/ARCH_HAS_ELF_CORE_EFLAGS) \
    $(wildcard include/config/AIO) \
    $(wildcard include/config/MMU_NOTIFIER) \
    $(wildcard include/config/SPLIT_PMD_PTLOCKS) \
    $(wildcard include/config/IOMMU_MM_DATA) \
    $(wildcard include/config/KSM) \
    $(wildcard include/config/MM_ID) \
    $(wildcard include/config/CORE_DUMP_DEFAULT_ELF_HEADERS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/auxvec.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/auxvec.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/auxvec.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kref.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/refcount.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rbtree.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rcupdate.h \
    $(wildcard include/config/TINY_RCU) \
    $(wildcard include/config/RCU_STRICT_GRACE_PERIOD) \
    $(wildcard include/config/RCU_LAZY) \
    $(wildcard include/config/RCU_STALL_COMMON) \
    $(wildcard include/config/VIRT_XFER_TO_GUEST_WORK) \
    $(wildcard include/config/RCU_NOCB_CPU) \
    $(wildcard include/config/TASKS_RCU_GENERIC) \
    $(wildcard include/config/TASKS_RUDE_RCU) \
    $(wildcard include/config/TREE_RCU) \
    $(wildcard include/config/DEBUG_OBJECTS_RCU_HEAD) \
    $(wildcard include/config/PROVE_RCU) \
    $(wildcard include/config/ARCH_WEAK_RELEASE_ACQUIRE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/context_tracking_irq.h \
    $(wildcard include/config/CONTEXT_TRACKING_IDLE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rcutree.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/maple_tree.h \
    $(wildcard include/config/MAPLE_RCU_DISABLED) \
    $(wildcard include/config/DEBUG_MAPLE_TREE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rwsem.h \
    $(wildcard include/config/RWSEM_SPIN_ON_OWNER) \
    $(wildcard include/config/DEBUG_RWSEMS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/completion.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/swait.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/uprobes.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/timer.h \
    $(wildcard include/config/DEBUG_OBJECTS_TIMERS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/ktime.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/jiffies.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/jiffies.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/include/generated/timeconst.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/vdso/ktime.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/timekeeping.h \
    $(wildcard include/config/POSIX_AUX_CLOCKS) \
    $(wildcard include/config/GENERIC_CMOS_UPDATE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/clocksource_ids.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/debugobjects.h \
    $(wildcard include/config/DEBUG_OBJECTS) \
    $(wildcard include/config/DEBUG_OBJECTS_FREE) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/uprobes.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/notifier.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/srcu.h \
    $(wildcard include/config/TINY_SRCU) \
    $(wildcard include/config/NEED_SRCU_NMI_SAFE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/workqueue.h \
    $(wildcard include/config/DEBUG_OBJECTS_WORK) \
    $(wildcard include/config/FREEZER) \
    $(wildcard include/config/WQ_WATCHDOG) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rcu_segcblist.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/srcutree.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rcu_node_tree.h \
    $(wildcard include/config/RCU_FANOUT) \
    $(wildcard include/config/RCU_FANOUT_LEAF) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/percpu_counter.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/mmu.h \
    $(wildcard include/config/MODIFY_LDT_SYSCALL) \
    $(wildcard include/config/ADDRESS_MASKING) \
    $(wildcard include/config/BROADCAST_TLB_FLUSH) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/page-flags.h \
    $(wildcard include/config/PAGE_IDLE_FLAG) \
    $(wildcard include/config/ARCH_USES_PG_ARCH_2) \
    $(wildcard include/config/ARCH_USES_PG_ARCH_3) \
    $(wildcard include/config/MIGRATION) \
    $(wildcard include/config/HUGETLB_PAGE_OPTIMIZE_VMEMMAP) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/local_lock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/local_lock_internal.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/zswap.h \
    $(wildcard include/config/ZSWAP) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/memory_hotplug.h \
    $(wildcard include/config/ARCH_HAS_ADD_PAGES) \
    $(wildcard include/config/MEMORY_HOTREMOVE) \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/mmzone.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/mmzone.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/topology.h \
    $(wildcard include/config/USE_PERCPU_NUMA_NODE_ID) \
    $(wildcard include/config/SCHED_SMT) \
    $(wildcard include/config/GENERIC_ARCH_TOPOLOGY) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/arch_topology.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/topology.h \
    $(wildcard include/config/X86_LOCAL_APIC) \
    $(wildcard include/config/SCHED_MC_PRIO) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/mpspec.h \
    $(wildcard include/config/EISA) \
    $(wildcard include/config/X86_MPPARSE) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/mpspec_def.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/x86_init.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/apicdef.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/topology.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/cpu_smt.h \
    $(wildcard include/config/HOTPLUG_SMT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sysctl.h \
    $(wildcard include/config/SYSCTL) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/sysctl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/elf.h \
    $(wildcard include/config/ARCH_HAVE_EXTRA_ELF_NOTES) \
    $(wildcard include/config/ARCH_USE_GNU_PROPERTY) \
    $(wildcard include/config/ARCH_HAVE_ELF_PROT) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/elf.h \
    $(wildcard include/config/X86_X32_ABI) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/ia32.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/compat.h \
    $(wildcard include/config/ARCH_HAS_SYSCALL_WRAPPER) \
    $(wildcard include/config/COMPAT_OLD_SIGACTION) \
    $(wildcard include/config/HARDENED_USERCOPY) \
    $(wildcard include/config/ODD_RT_SIGACTION) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sem.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/sem.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/ipc.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/ipc.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/ipcbuf.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/ipcbuf.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/sembuf.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/socket.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/socket.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/socket.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/sockios.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/sockios.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/sockios.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/uio.h \
    $(wildcard include/config/ARCH_HAS_COPY_MC) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/ucopysize.h \
    $(wildcard include/config/HARDENED_USERCOPY_DEFAULT_ON) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/uio.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/socket.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/if.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/libc-compat.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/hdlc/ioctl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/fs.h \
    $(wildcard include/config/FANOTIFY_ACCESS_PERMISSIONS) \
    $(wildcard include/config/READ_ONLY_THP_FOR_FS) \
    $(wildcard include/config/FS_POSIX_ACL) \
    $(wildcard include/config/CGROUP_WRITEBACK) \
    $(wildcard include/config/IMA) \
    $(wildcard include/config/FILE_LOCKING) \
    $(wildcard include/config/FSNOTIFY) \
    $(wildcard include/config/EPOLL) \
    $(wildcard include/config/UNICODE) \
    $(wildcard include/config/FS_ENCRYPTION) \
    $(wildcard include/config/FS_VERITY) \
    $(wildcard include/config/QUOTA) \
    $(wildcard include/config/FS_DAX) \
    $(wildcard include/config/BLOCK) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/vfsdebug.h \
    $(wildcard include/config/DEBUG_VFS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/wait_bit.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kdev_t.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/kdev_t.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/dcache.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rculist.h \
    $(wildcard include/config/PROVE_RCU_LIST) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rculist_bl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/list_bl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/bit_spinlock.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/lockref.h \
    $(wildcard include/config/ARCH_USE_CMPXCHG_LOCKREF) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/stringhash.h \
    $(wildcard include/config/DCACHE_WORD_ACCESS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/hash.h \
    $(wildcard include/config/HAVE_ARCH_HASH) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/path.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/list_lru.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/shrinker.h \
    $(wildcard include/config/SHRINKER_DEBUG) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/xarray.h \
    $(wildcard include/config/XARRAY_MULTI) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/mm.h \
    $(wildcard include/config/MMU_LAZY_TLB_REFCOUNT) \
    $(wildcard include/config/ARCH_HAS_MEMBARRIER_CALLBACKS) \
    $(wildcard include/config/ARCH_HAS_SYNC_CORE_BEFORE_USERMODE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sync_core.h \
    $(wildcard include/config/ARCH_HAS_PREPARE_SYNC_CORE_CMD) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/sync_core.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/coredump.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/radix-tree.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/pid.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/capability.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/capability.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/semaphore.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/fcntl.h \
    $(wildcard include/config/ARCH_32BIT_OFF_T) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/fcntl.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/fcntl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/asm-generic/fcntl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/openat2.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/migrate_mode.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/percpu-rwsem.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rcuwait.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/signal.h \
    $(wildcard include/config/SCHED_AUTOGROUP) \
    $(wildcard include/config/BSD_PROCESS_ACCT) \
    $(wildcard include/config/TASKSTATS) \
    $(wildcard include/config/STACK_GROWSUP) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/signal.h \
    $(wildcard include/config/DYNAMIC_SIGFRAME) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/jobctl.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/task.h \
    $(wildcard include/config/HAVE_EXIT_THREAD) \
    $(wildcard include/config/ARCH_WANTS_DYNAMIC_TASK_STRUCT) \
    $(wildcard include/config/HAVE_ARCH_THREAD_STRUCT_WHITELIST) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/uaccess.h \
    $(wildcard include/config/ARCH_HAS_SUBPAGE_FAULTS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/fault-inject-usercopy.h \
    $(wildcard include/config/FAULT_INJECTION_USERCOPY) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/nospec.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/uaccess.h \
    $(wildcard include/config/CC_HAS_ASM_GOTO_OUTPUT) \
    $(wildcard include/config/CC_HAS_ASM_GOTO_TIED_OUTPUT) \
    $(wildcard include/config/X86_INTEL_USERCOPY) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mmap_lock.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/smap.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/extable.h \
    $(wildcard include/config/BPF_JIT) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/tlbflush.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mmu_notifier.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/interval_tree.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/invpcid.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/pti.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/pgtable.h \
    $(wildcard include/config/DEBUG_WX) \
    $(wildcard include/config/HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD) \
    $(wildcard include/config/ARCH_SUPPORTS_PMD_PFNMAP) \
    $(wildcard include/config/ARCH_SUPPORTS_PUD_PFNMAP) \
    $(wildcard include/config/HAVE_ARCH_SOFT_DIRTY) \
    $(wildcard include/config/ARCH_ENABLE_THP_MIGRATION) \
    $(wildcard include/config/PAGE_TABLE_CHECK) \
    $(wildcard include/config/X86_SGX) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/pkru.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/fpu/api.h \
    $(wildcard include/config/MATH_EMULATION) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/coco.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/pgtable_uffd.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/page_table_check.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/pgtable_64.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/fixmap.h \
    $(wildcard include/config/PROVIDE_OHCI1394_DMA_INIT) \
    $(wildcard include/config/X86_IO_APIC) \
    $(wildcard include/config/PCI_MMCONFIG) \
    $(wildcard include/config/ACPI_APEI_GHES) \
    $(wildcard include/config/INTEL_TXT) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/vsyscall.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/fixmap.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/pgtable-invert.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/uaccess_64.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/access_ok.h \
    $(wildcard include/config/ALTERNATE_USER_ADDRESS_SPACE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/cred.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/key.h \
    $(wildcard include/config/KEY_NOTIFICATIONS) \
    $(wildcard include/config/NET) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/assoc_array.h \
    $(wildcard include/config/ASSOCIATIVE_ARRAY) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/user.h \
    $(wildcard include/config/VFIO_PCI_ZDEV_KVM) \
    $(wildcard include/config/IOMMUFD) \
    $(wildcard include/config/WATCH_QUEUE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/ratelimit.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/posix-timers.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/alarmtimer.h \
    $(wildcard include/config/RTC_CLASS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/hrtimer.h \
    $(wildcard include/config/HIGH_RES_TIMERS) \
    $(wildcard include/config/TIME_LOW_RES) \
    $(wildcard include/config/TIMERFD) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/hrtimer_defs.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/timerqueue.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rcuref.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rcu_sync.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/delayed_call.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/uuid.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/errseq.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/ioprio.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/rt.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/iocontext.h \
    $(wildcard include/config/BLK_ICQ) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/ioprio.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/fs_types.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mount.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/mnt_idmapping.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/slab.h \
    $(wildcard include/config/FAILSLAB) \
    $(wildcard include/config/KFENCE) \
    $(wildcard include/config/SLUB_TINY) \
    $(wildcard include/config/SLUB_DEBUG) \
    $(wildcard include/config/SLAB_BUCKETS) \
    $(wildcard include/config/KVFREE_RCU_BATCHED) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/percpu-refcount.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kasan.h \
    $(wildcard include/config/KASAN_STACK) \
    $(wildcard include/config/KASAN_VMALLOC) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kasan-enabled.h \
    $(wildcard include/config/ARCH_DEFER_KASAN) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kasan-tags.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rw_hint.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/file_ref.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/unicode.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/fs.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/quota.h \
    $(wildcard include/config/QUOTA_NETLINK_INTERFACE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/dqblk_xfs.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/dqblk_v1.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/dqblk_v2.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/dqblk_qtree.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/projid.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/quota.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/aio_abi.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/unistd.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/unistd.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/uapi/asm/unistd.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/uapi/asm/unistd_64.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/unistd_64_x32.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/unistd_32_ia32.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/compat.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sched/task_stack.h \
    $(wildcard include/config/DEBUG_STACK_USAGE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/magic.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/user32.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/compat.h \
    $(wildcard include/config/COMPAT_FOR_U64_ALIGNMENT) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/syscall_wrapper.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/user.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/user_64.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/fsgsbase.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/syscall.h \
    $(wildcard include/config/X86_X32_DISABLED) \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/audit.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/elf-em.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/vdso.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/uapi/linux/elf.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kobject.h \
    $(wildcard include/config/UEVENT_HELPER) \
    $(wildcard include/config/DEBUG_KOBJECT_RELEASE) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/sysfs.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kernfs.h \
    $(wildcard include/config/KERNFS) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/idr.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/kobject_ns.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/moduleparam.h \
    $(wildcard include/config/ALPHA) \
    $(wildcard include/config/PPC64) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/rbtree_latch.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/error-injection.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/error-injection.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/module.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/asm-generic/module.h \
    $(wildcard include/config/HAVE_MOD_ARCH_SPECIFIC) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/build-salt.h \
    $(wildcard include/config/BUILD_SALT) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/elfnote.h \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/elfnote-lto.h \
    $(wildcard include/config/LTO) \
  /usr/src/linux-headers-6.18.12+kali-common/include/linux/vermagic.h \
    $(wildcard include/config/PREEMPT_BUILD) \
  /usr/src/linux-headers-6.18.12+kali-amd64/include/generated/utsrelease.h \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/vermagic.h \
    $(wildcard include/config/M486SX) \
    $(wildcard include/config/M486) \
    $(wildcard include/config/M586) \
    $(wildcard include/config/M586TSC) \
    $(wildcard include/config/M586MMX) \
    $(wildcard include/config/MATOM) \
    $(wildcard include/config/M686) \
    $(wildcard include/config/MPENTIUMII) \
    $(wildcard include/config/MPENTIUMIII) \
    $(wildcard include/config/MPENTIUMM) \
    $(wildcard include/config/MPENTIUM4) \
    $(wildcard include/config/MK6) \
    $(wildcard include/config/MK7) \
    $(wildcard include/config/MELAN) \
    $(wildcard include/config/MCRUSOE) \
    $(wildcard include/config/MEFFICEON) \
    $(wildcard include/config/MWINCHIPC6) \
    $(wildcard include/config/MWINCHIP3D) \
    $(wildcard include/config/MCYRIXIII) \
    $(wildcard include/config/MVIAC3_2) \
    $(wildcard include/config/MVIAC7) \
    $(wildcard include/config/MGEODEGX1) \
    $(wildcard include/config/MGEODE_LX) \
  /usr/src/linux-headers-6.18.12+kali-common/arch/x86/include/asm/orc_header.h \
  /usr/src/linux-headers-6.18.12+kali-amd64/arch/x86/include/generated/asm/orc_hash.h \

.module-common.o: $(deps_.module-common.o)

$(deps_.module-common.o):

.module-common.o: $(wildcard /usr/src/linux-headers-6.18.12+kali-amd64/tools/objtool/objtool)
