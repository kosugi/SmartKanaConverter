# for testing

OTEST = /Developer/Tools/otest
PYTHON = /usr/bin/python

INCLUDES = -Isrc
CFLAGS = -O2 -std=c99 -Wall $(INCLUDES)
LDFLAGS = -framework Foundation -framework AppKit -framework SenTestingKit

.PHONY: test
test: build build/TestSmartKanaConverter
	$(OTEST) build/TestSmartKanaConverter

.PHONY: build
build:
	mkdir -p build

build/TestSmartKanaConverter: test/TestSmartKanaConverter.m build/SmartKanaConverter.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

build/SmartKanaConverter.o: \
src/SmartKanaConverter.m \
src/SmartKanaConverter_define.m \
src/SmartKanaConverter_init.m \
src/SmartKanaConverter.h
	$(CC) $(CFLAGS) -c $< -o $@

src/SmartKanaConverter_define.m: mktbl.py
	$(PYTHON) $^

src/SmartKanaConverter_init.m: mktbl.py
	$(PYTHON) $^

.PHONY: clean
clean:
	$(RM) -r build
