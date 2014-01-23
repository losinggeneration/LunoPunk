MOONCFLAGS=
BUSTEDFLAGS=
BUSTED_LUA=love

LOVEPUNK_SRCS = $(shell find LovePunk -iname '*.moon')
LOVEPUNK_OBJS = $(LOVEPUNK_SRCS:.moon=.lua)

all: $(LOVEPUNK_OBJS)

test:
	busted -m LovePunk/?.moon -l $(BUSTED_LUA) -p _spec.moon$$ tests

# Dependencies
%.lua: %.moon
	moonc ${MOONCFLAGS} -p $< > $@

clean:
	rm -f $(LOVEPUNK_OBJS)

# Targets
.PHONY: clean all test
