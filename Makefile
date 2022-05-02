##############
# parameters #
##############
# should we show commands executed ?
DO_MKDBG?=0
# should we convert md to pdf?
DO_PDF=1

########
# code #
########
FILES_MD=$(shell find src -name "*.md")
FILES_PDF=$(addprefix out/,$(addsuffix .pdf,$(basename $(FILES_MD))))
ALL:=

ifeq ($(DO_PDF),1)
ALL+=$(FILES_PDF)
endif # DO_PDF

ifeq ($(DO_MKDBG),1)
Q=
# we are not silent in this branch
else # DO_MKDBG
Q=@
#.SILENT:
endif # DO_MKDBG

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: debug
debug:
	$(info FILES_MD is $(FILES_MD))
	$(info FILES_PDF is $(FILES_PDF))
	$(info ALL is $(ALL))

.PHONY: clean
clean:
	$(Q)rm $(ALL)

.PHONY: clean_hard
clean_hard:
	$(Q)git clean -qffxd

############
# patterns #
############
$(FILES_PDF): out/%.pdf: %.md
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)pandoc $< -o $@
