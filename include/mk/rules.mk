target_rel_dir := $(if $(cwd_rel_from_top),$(cwd_rel_from_top)/,)

%.o: %.c
ifdef VERBOSE
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
else
	# 路径在 kernel syscall 的进行一下判断吧
	echo $(target_rel_dir)
	# TODO 生成两份 .o 对于特殊的.c
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
	@echo CC $(target_rel_dir)$@
endif

tst_test.o:tst_test.c
	@echo "tst_test is SPECIAL"
	@$(CC) $(CPPFLAGS) $(CFLAGS) -DDUNE -c -o "dune_$@" $<
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
	@echo CC $(target_rel_dir)$@

ifdef VERBOSE
COMPILE.c=$(CC) $(CPPFLAGS) $(CFLAGS) -c
else
COMPILE.c=@echo CC $(target_rel_dir)$@; $(CC) $(CPPFLAGS) $(CFLAGS) -c
endif

%: %.o
ifdef VERBOSE
	$(CC) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
else
	# TODO 对于 .o 进行判断
	@$(CC) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
	@echo LD $(target_rel_dir)$@
endif

$(HOST_MAKE_TARGETS): %: %.c
ifdef VERBOSE
	$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $< $(HOST_LDLIBS) -o $@
else
	@$(HOSTCC) $(HOST_CFLAGS) $(HOST_LDFLAGS) $< $(HOST_LDLIBS) -o $@
	@echo HOSTCC $(target_rel_dir)$@
endif

%: %.c
ifdef VERBOSE
	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@
else
	@$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@

	if [[ "$(LDLIBS)" == *"-lltp"* ]]; then \
		$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) $^ $(LTPLDLIBS) $(subst -lltp, -lduneltp, $(LDLIBS))  /home/loongson/dune/dune/libdune.a -o "dune-$@"; \
	fi

	@echo CC $(target_rel_dir)$@
endif
