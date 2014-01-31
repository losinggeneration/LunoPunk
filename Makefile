MOONCFLAGS=
BUSTEDFLAGS=
BUSTED_LUA=love
DISTDIR=

LOVEPUNK_SRCS = $(shell find LunoPunk -iname '*.moon')
LOVEPUNK_OBJS = $(patsubst %.moon,%.lua,$(LOVEPUNK_SRCS))

all: $(LOVEPUNK_OBJS)

test:
	busted -m LunoPunk/?.moon -l $(BUSTED_LUA) -p _spec.moon$$ tests

# Dependencies
%.lua: %.moon
	moonc ${MOONCFLAGS} -p $< > $@
ifneq ($(strip $(DISTDIR)),)
	@mkdir -p $(DISTDIR)/$(@D)
	@cp $@ $(DISTDIR)/$@
endif

clean:
	rm -f $(LOVEPUNK_OBJS)
ifneq ($(strip $(DISTDIR)),)
	rm -fr $(DISTDIR)
endif

# Targets
.PHONY: clean all test
