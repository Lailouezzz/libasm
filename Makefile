#!/usr/bin/make -f
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
#
# Author : Alan "ale-boud" Le Bouder <ale-boud@student.42lehavre.fr>
#
# Description of source tree :
# └── include
#     └── <header>.h
# └── src
#     └── <compilunit>.c
#
# After compilation :
# - $(OBJDIR) contain all object files and gcc generated dependencies
# - $(OUTDIR) contain the executable
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

# Default target
all: all-libasm
bonus: all

# Include vars and msg module
include Makefile.vars Makefile.msg

# ---
# General targets
# ---

# Mostly clean (clean everything but the end result)

clean: 
	$(call rmsg,Removing the object folder ($(OBJDIR)))
	$(call qcmd,$(RM) -r $(OBJDIR))

mclean: clean

# Clean everything

fclean: clean cleandoc
ifneq ($(OUTDIR),.)
	$(call rmsg,Removing the output binary folder ($(OUTDIR)))
	$(call qcmd,$(RM) -r $(OUTDIR))
else
	$(call rmsg,Removing the output binaries ($(LIB_PATH) $(TEST_BIN_PATH)))
	$(call qcmd,$(RM) $(LIB_PATH))
	$(call qcmd,$(RM) $(TEST_BIN_PATH))
endif

# Clean libs

cleanlibs: $(LIBS_CLEAN_RULE)
	$(call rmsg,Clean libs ($(LIBS)))

# Fclean libs

fcleanlibs: cleanlibs $(LIBS_FCLEAN_RULE)
	$(call rmsg,Fclean libs ($(LIBS)))

# To original state

mrproper: fclean fcleanlibs cleandoc
	$(call rmsg,Removing the configuration file (Makefile.cfg))
	$(call qcmd,$(RM) -r Makefile.cfg)

# Remake everything

re: fclean all
re-test: fclean all-test

# Make the doxygen documentation

all-doc: doc/Doxyfile
	$(call bcmd,doxygen,$<,doxygen $<)

# Clean the doxygen documentation

cleandoc:
	$(call rmsg,Removing the documentation (doc/html doc/man))
	$(call qcmd,$(RM) -r doc/html doc/man)


.PHONY: all clean mclean fclean cleanlibs fcleanlibs mrproper re all-doc \
	cleandoc bonus re-test

# ---
# Check configuration
# ---

Makefile.cfg:
	$(call emsg,Makefile.cfg missing did you "./configure")
	@exit 1

# ---
# Build targets
# ---

all-libasm: $(LIBS_MAKE_RULE) $(LIB_PATH)
all-test: $(TEST_BIN_PATH)

# Make the library

$(LIB_PATH): $(OBJS)
	$(call qcmd,$(MKDIR) -p $(@D))
	$(call bcmd,ar,$(OBJS),$(AR) rcs $@ $(OBJS))

# Make the tests

$(TEST_BIN_PATH): $(TEST_OBJS) $(LIB_PATH)
	$(call qcmd,$(MKDIR) -p $(@D))
	$(call bcmd,ld,$(TEST_OBJS),$(LD) $(LDFLAGS) -o $@ $^)

# Make objects

$(OBJDIR)/%.c.o: $(SRCDIR)/%.c
	$(call qcmd,$(MKDIR) -p $(@D))
	$(call bcmd,cc,$<,$(CC) -c $(CFLAGS) -o $@ $<)

$(OBJDIR)/test/%.c.o: $(TEST_SRCDIR)/%.c
	$(call qcmd,$(MKDIR) -p $(@D))
	$(call bcmd,cc,$<,$(CC) -c $(CFLAGS) -o $@ $<)

# Make object ressources

$(OBJDIR)/%.res.o: $(RESDIR)/%
	$(call qcmd,$(MKDIR) -p $(@D))
	$(call bcmd,ld,$<,ld --format=binary -r $< -o $@)

# Make object assembly

$(OBJDIR)/%.s.o: $(SRCDIR)/%.s
	$(call qcmd,$(MKDIR) -p $(@D))
	$(call bcmd,as,$<,$(AS) $(ASFLAGS) -o $@ $<)

# Include generated dep by cc

-include $(DEPS)

.PHONY: all-libasm all-test
