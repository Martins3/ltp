# SPDX-License-Identifier: GPL-2.0-or-later
#    testcases/kernel/syscalls Makefile.
#
#    Copyright (C) 2009, Cisco Systems Inc.
#
# Ngie Cooper, July 2009
#

top_srcdir		?= ../../../..

include $(top_srcdir)/include/mk/testcases.mk

CPPFLAGS		+= -D_XOPEN_SOURCE=500 -D_XOPEN_SOURCE_EXTENDED

MAKE_TARGETS		:= nftw01 nftw6401

nftw01: CPPFLAGS += -D_LARGEFILE_SOURCE

nftw01: nftw.o tools.o test_func.o test.o lib.o 
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
	$(MAKE) dune-nftw01

dune-nftw01: dune_nftw.o dune_tools.o dune_test_func.o dune_test.o dune_lib.o 
	if [[ "$(LDLIBS)" == *"-lltp"* ]]; then \
		$(LINK.o) $^ $(LOADLIBES) -pthread $(subst -lltp, -lduneltp, $(LDLIBS)) /home/loongson/dune/dune/libdune.a $(OUTPUT_OPTION); \
	fi

nftw64.o tools64.o test_func64.o test64.o lib64.o: %.o: %.c

%64.o: CPPFLAGS += -D_LARGEFILE64_SOURCE

nftw6401: nftw64.o tools64.o test_func64.o test64.o lib64.o
	$(LINK.o) $^ $(LOADLIBES) $(LDLIBS) $(OUTPUT_OPTION)
	$(MAKE) dune-nftw6401

dune-nftw6401: dune_nftw64.o dune_tools64.o dune_test_func64.o dune_test64.o dune_lib64.o
	if [[ "$(LDLIBS)" == *"-lltp"* ]]; then \
		$(LINK.o) $^ $(LOADLIBES) -pthread $(subst -lltp, -lduneltp, $(LDLIBS)) /home/loongson/dune/dune/libdune.a $(OUTPUT_OPTION); \
	fi

include $(top_srcdir)/include/mk/generic_leaf_target.mk
