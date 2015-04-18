MOONCFLAGS=
BUSTEDFLAGS=
DISTDIR=

LOVEPUNK_SRCS = $(shell find LunoPunk -iname '*.moon')
LOVEPUNK_OBJS = $(patsubst %.moon,%.lua,$(LOVEPUNK_SRCS))

all: $(LOVEPUNK_OBJS)

test: tests/mock_love.moon
	busted tests

ci: tests/mock_love.moon
	busted -o plainTerminal -c tests

# Dependencies
tests/mock_love.moon:
	@mkdir -p tmp
	@cp tests/generate_love_mock.moon tmp/main.moon
	@moonc tmp/main.moon
	@love tmp
	@mv mock_love.moon tests
	@rm -fr tmp

%.lua: %.moon
	moonc ${MOONCFLAGS} -p $< > $@
ifneq ($(strip $(DISTDIR)),)
	@mkdir -p $(DISTDIR)/$(@D)
	@cp $@ $(DISTDIR)/$@
endif

clean:
	rm -f $(LOVEPUNK_OBJS) tests/mock_love.moon coveralls/busted.lua
ifneq ($(strip $(DISTDIR)),)
	rm -fr $(DISTDIR)
endif

# Targets
.PHONY: clean all test
