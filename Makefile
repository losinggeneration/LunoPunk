MOONCFLAGS=
BUSTEDFLAGS=
BUSTED_LUA=luajit
DISTDIR=

LOVEPUNK_SRCS = $(shell find LunoPunk -iname '*.moon')
LOVEPUNK_OBJS = $(patsubst %.moon,%.lua,$(LOVEPUNK_SRCS))

all: $(LOVEPUNK_OBJS)

test: tests/mock_love.moon
	busted -p _spec.moon$$ tests

tap: tests/mock_love.moon
	busted -o TAP -p _spec.moon$$ tests

ci: tests/mock_love.moon coveralls/busted_coverage.lua
	busted -o coveralls/busted_coverage.lua -p _spec.moon$$ tests

# Dependencies
tests/mock_love.moon:
	@mkdir -p tmp
	@cp tests/generate_love_mock.moon tmp/main.moon
	@moonc tmp/main.moon
	@love tmp
	@mv mock_love.moon tests
	@rm -fr tmp

coveralls/busted_coverage.lua: coveralls/busted_coverage.moon
	moonc coveralls/busted_coverage.moon

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
