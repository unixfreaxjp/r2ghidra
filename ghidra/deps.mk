GHIDRA_HOME=../ghidra/ghidra/
GHIDRA_DECOMPILER=$(GHIDRA_HOME)/Ghidra/Features/Decompiler/src/decompile/cpp

G_DECOMPILER=space.cc float.cc address.cc pcoderaw.cc
G_DECOMPILER+=translate.cc opcodes.cc globalcontext.cc
G_DECOMPILER+=capability.cc architecture.cc options.cc graph.cc
G_DECOMPILER+=cover.cc block.cc cast.cc typeop.cc database.cc
G_DECOMPILER+=cpool.cc comment.cc fspec.cc action.cc loadimage.cc
G_DECOMPILER+=varnode.cc op.cc type.cc variable.cc varmap.cc
G_DECOMPILER+=jumptable.cc emulate.cc emulateutil.cc flow.cc userop.cc
G_DECOMPILER+=funcdata.cc funcdata_block.cc funcdata_varnode.cc
G_DECOMPILER+=funcdata_op.cc pcodeinject.cc heritage.cc prefersplit.cc
G_DECOMPILER+=rangeutil.cc ruleaction.cc subflow.cc blockaction.cc
G_DECOMPILER+=merge.cc double.cc coreaction.cc condexe.cc override.cc
G_DECOMPILER+=dynamic.cc crc32.cc prettyprint.cc printlanguage.cc
G_DECOMPILER+=printc.cc printjava.cc memstate.cc opbehavior.cc
G_DECOMPILER+=paramid.cc transform.cc string_ghidra.cc stringmanage.cc

# set(DECOMPILER_SOURCE_GHIDRA_CXX
# G_DECOMPILER+=ghidra_process.cc
ifeq (1,0)
G_DECOMPILER+=ghidra_arch.cc
G_DECOMPILER+=loadimage_ghidra.cc
G_DECOMPILER+=typegrp_ghidra.cc
G_DECOMPILER+=database_ghidra.cc
G_DECOMPILER+=ghidra_context.cc
G_DECOMPILER+=cpool_ghidra.cc
G_DECOMPILER+=comment_ghidra.cc
G_DECOMPILER+=inject_ghidra.cc
G_DECOMPILER+=ghidra_translate.cc
endif

G_DECOMPILER+= $(GHIDRA_LIBDECOMP_SRCS)

G_DECOMPILER+=sleigh_arch.cc
G_DECOMPILER+=sleigh.cc
G_DECOMPILER+=inject_sleigh.cc
G_DECOMPILER+=filemanage.cc
G_DECOMPILER+=semantics.cc
G_DECOMPILER+=slghsymbol.cc
G_DECOMPILER+=context.cc
G_DECOMPILER+=sleighbase.cc
G_DECOMPILER+=slghpatexpress.cc
G_DECOMPILER+=slghpattern.cc
G_DECOMPILER+=pcodecompile.cc

# set(DECOMPILER_SOURCE_CONSOLE_CXX
## G_DECOMPILER+=consolemain.cc
## G_DECOMPILER+=interface.cc
## G_DECOMPILER+=ifacedecomp.cc
## G_DECOMPILER+=ifaceterm.cc
## G_DECOMPILER+=callgraph.cc
## G_DECOMPILER+=raw_arch.cc

G_DECOMPILER+= xml.cc ## bison
G_DECOMPILER+= pcodeparse.cc ## bison
G_DECOMPILER+= ruleparse.cc ## bison
G_DECOMPILER+= slghparse.cc ## bison
G_DECOMPILER+= slghscan.cc ## bison
G_DECOMPILER+= grammar.cc ## bison
# G_DECOMPILER+= slghparse.cc ## bison
# G_DECOMPILER+= grammar.cc ## bison
# G_DECOMPILER+= ruleparse.cc ## bison

grammars:
	$(MAKE) $(GHIDRA_DECOMPILER)/grammar.cc
	$(MAKE) $(GHIDRA_DECOMPILER)/ruleparse.cc
	$(MAKE) $(GHIDRA_DECOMPILER)/xml.cc
	$(MAKE) $(GHIDRA_DECOMPILER)/pcodeparse.cc
	$(MAKE) $(GHIDRA_DECOMPILER)/slghparse.cc
	$(MAKE) $(GHIDRA_DECOMPILER)/slghscan.cc

$(GHIDRA_DECOMPILER)/grammar.cc: $(GHIDRA_DECOMPILER)/grammar.y
	$(BISON) -d -p grammar -o $(GHIDRA_DECOMPILER)/grammar.cc $(GHIDRA_DECOMPILER)/grammar.y
	#$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(GHIDRA_DECOMPILER)/grammar.o -c $(GHIDRA_DECOMPILER)/grammar.cc

$(GHIDRA_DECOMPILER)/ruleparse.cc: $(GHIDRA_DECOMPILER)/grammar.y
	$(BISON) -d -p ruleparse -o $(GHIDRA_DECOMPILER)/ruleparse.cc $(GHIDRA_DECOMPILER)/ruleparse.y
	#$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(GHIDRA_DECOMPILER)/ruleparse.o -c $(GHIDRA_DECOMPILER)/ruleparse.cc

$(GHIDRA_DECOMPILER)/xml.cc: $(GHIDRA_DECOMPILER)/xml.y
	$(BISON) -d -p xml -o $(GHIDRA_DECOMPILER)/xml.cc $(GHIDRA_DECOMPILER)/xml.y
	#$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(GHIDRA_DECOMPILER)/xml.o -c $(GHIDRA_DECOMPILER)/xml.cc

$(GHIDRA_DECOMPILER)/pcodeparse.cc: $(GHIDRA_DECOMPILER)/pcodeparse.y
	$(BISON) -d -p pcodeparser -o $(GHIDRA_DECOMPILER)/pcodeparse.cc $(GHIDRA_DECOMPILER)/pcodeparse.y
	#$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(GHIDRA_DECOMPILER)/pcodeparse.o -c $(GHIDRA_DECOMPILER)/pcodeparse.cc

$(GHIDRA_DECOMPILER)/slghparse.cc: $(GHIDRA_DECOMPILER)/slghparse.y
	# echo '#include \"slghparse.hpp\"' > $(GHIDRA_DECOMPILER)/slghparse.tab.hh
	# $(BISON) -d -o $(GHIDRA_DECOMPILER)/slghparse.tab.hh $(GHIDRA_DECOMPILER)/slghparse.y
	$(BISON) -d -o $(GHIDRA_DECOMPILER)/slghparse.cc $(GHIDRA_DECOMPILER)/slghparse.y
	#$(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(GHIDRA_DECOMPILER)/slghparse.o -c $(GHIDRA_DECOMPILER)/slghparse.cc

# .PHONY: $(GHIDRA_DECOMPILER)/slghparse.cc
# .PHONY: $(GHIDRA_DECOMPILER)/slghscan.cc

$(GHIDRA_DECOMPILER)/slghscan.cc: $(GHIDRA_DECOMPILER)/slghscan.l $(GHIDRA_DECOMPILER)/slghparse.cc
	# $(FLEX) --header-file=$(GHIDRA_DECOMPILER)/slghscan.tab.hh -o $(GHIDRA_DECOMPILER)/slghscan.cc $(GHIDRA_DECOMPILER)/slghscan.l
	$(FLEX) -o $(GHIDRA_DECOMPILER)/slghscan.cc $(GHIDRA_DECOMPILER)/slghscan.l
	# $(CXX) $(CXXFLAGS) $(LDFLAGS) -o $(GHIDRA_DECOMPILER)/slghscan.o -c $(GHIDRA_DECOMPILER)/slghscan.cc

GHIDRA_SRCS=$(addprefix $(GHIDRA_DECOMPILER)/,$(G_DECOMPILER))
GHIDRA_OBJS+=$(subst .cc,.o,$(GHIDRA_SRCS))

GHIDRA_LIBDECOMP_SRCS=libdecomp.cc
GHIDRA_LIBDECOMP_OBJS+=$(subst .cc,.o,$(GHIDRA_LIBDECOMP_SRCS))

GHIDRA_SLEIGH_COMPILER_SRCS=slgh_compile.cc
GHIDRA_SLEIGH_COMPILER_OBJS=$(subst .cc,.o,$(GHIDRA_SLEIGH_COMPILER_SRCS))

sleigh: sleighc
	$(SLEIGHC) $(SPECFILE) $(SLAFILE)

sleighc: $(GHIDRA_DECOMPILER)/slgh_compile.cc $(GHIDRA_DECOMPILER)/slghscan.o $(GHIDRA_DECOMPILER)/slghparse.o
	$(CXX) $(CXXFLAGS) $(LDFLAGS) -o sleighc $(GHIDRA_DECOMPILER)/slgh_compile.cc $(GHIDRA_DECOMPILER)/slghscan.o $(GHIDRA_OBJS)

GHIDRA_SLEIGH_SLASPECS=$(GHIDRA_HOME)/Ghidra/Processors/*.slaspec
GHIDRA_SLEIGH_FILES=$(GHIDRA_HOME)/Ghidra/Processors/*.cspec
GHIDRA_SLEIGH_FILES+=$(GHIDRA_HOME)/Ghidra/Processors/*.ldefs
GHIDRA_SLEIGH_FILES+=$(GHIDRA_HOME)/Ghidra/Processors/*.pspec

../ghidra-processors.txt:
	cp -f ../ghidra-processors.txt.default ../ghidra-processors.txt

sleigh-build: sleighc ../ghidra-processors.txt
	for a in DATA $(shell cat ../ghidra-processors.txt) ; do ./sleighc -a $(GHIDRA_HOME)/Ghidra/Processors/$$a ; done

GHIDRA_PROCS=$(GHIDRA_HOME)/Ghidra/Processors/*/*/*

S=$(GHIDRA_HOME)/Ghidra/Processors
D=$(R2_USER_PLUGINS)/r2ghidra_sleigh

sleigh-install:
	mkdir -p $(D)
	for a in DATA $(shell cat ../ghidra-processors.txt) ; do \
		for b in cspec ldefs pspec sla ; do \
			cp -f $(S)/$$a/*/*/*.$$b "$(D)"; \
		done ;\
	done

sleigh-uninstall:
	rm -rf "$(D)"
