target_rel_dir := $(if $(cwd_rel_from_top),$(cwd_rel_from_top)/,)

%.o: %.c
ifdef VERBOSE
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
else
	if [[ $(target_rel_dir) == *"testcases/kernel/syscalls"* ]]; then \
		$(CC) $(CPPFLAGS) $(CFLAGS) -DDUNE -pthread -c -o "dune_$@" $< ; \
	fi
	@$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
	@echo CC $(target_rel_dir)$@
endif

tst_test.o:tst_test.c
	@echo "tst_test is SPECIAL"
	@$(CC) $(CPPFLAGS) $(CFLAGS) -DDUNE -pthread -c -o "dune_$@" $<
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
	if [[ -f /home/loongson/ltp/$(target_rel_dir)dune_$< ]];then\
		$(CC) $(LDFLAGS) -pthread "dune_$^" $(LTPLDLIBS) $(subst -lltp, -lduneltp, $(LDLIBS))  /home/loongson/dune/dune/libdune.a -o "dune-$@"; \
	fi

	@$(CC) $(LDFLAGS) $^ $(LTPLDLIBS) $(LDLIBS) -o $@

	if [[ -f /home/loongson/ltp/$(target_rel_dir)dune_$< ]];then\
		rm /home/loongson/ltp/$(target_rel_dir)dune_$<; \
	fi
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
		if [[ ! "$(LDLIBS)" == *"-lltpuinput"* ]]; then \
			$(CC) $(CPPFLAGS) $(CFLAGS) -DDUNE -pthread $(LDFLAGS) $^ $(LTPLDLIBS) $(subst -lltp, -lduneltp, $(LDLIBS))  /home/loongson/dune/dune/libdune.a -o "dune-$@"; \
		fi \
	fi

	@echo CC $(target_rel_dir)$@
endif
