MOONCFLAGS=
BUSTEDFLAGS=
BUSTED_LUA=love
DISTDIR=

LOVEPUNK_SRCS = $(shell find LunoPunk -iname '*.moon')
LOVEPUNK_OBJS = $(patsubst %.moon,%.lua,$(LOVEPUNK_SRCS))

all: $(LOVEPUNK_OBJS)

test: tests/mock_love.lua
	busted -m LunoPunk/?.moon -l $(BUSTED_LUA) -p _spec.moon$$ tests

ci: tests/mock_love.lua coveralls/busted.lua
	busted -o coveralls/busted.lua -m LunoPunk/?.moon -l $(BUSTED_LUA) -p _spec.moon$$ tests

# Dependencies
tests/mock_love.lua:
	@mkdir -p tmp
	@cp tests/generate_love_mock.moon tmp/main.moon
	@cp examples/rapid/main.lua tmp
	@love tmp
	@mv mock_love.lua tests
	@rm -fr tmp

coveralls/busted.lua: coveralls/busted.moon
	moonc coveralls/busted.moon

%.lua: %.moon
	moonc ${MOONCFLAGS} -p $< > $@
ifneq ($(strip $(DISTDIR)),)
	@mkdir -p $(DISTDIR)/$(@D)
	@cp $@ $(DISTDIR)/$@
endif

clean:
	rm -f $(LOVEPUNK_OBJS) tests/mock_love.lua coveralls/busted.lua
ifneq ($(strip $(DISTDIR)),)
	rm -fr $(DISTDIR)
endif

# Targets
.PHONY: clean all test
