
OTEST = /Developer/Tools/otest

TARGET = TestSmartKanaConverter

OBJS = SmartKanaConverter.o

INCLUDES = -I.

CFLAGS = -O2 -std=c99 -Wall $(INCLUDES) -fprofile-arcs -ftest-coverage
LDFLAGS = -framework Foundation -framework AppKit -framework SenTestingKit

.m.o:
	$(CC) $(CFLAGS) -c $< -o $*.o

.PHONY: all
all: $(OBJS) $(TARGET).o
	$(CC) $(LDFLAGS) $(CFLAGS) -o $(TARGET) $^

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJS)

SmartKanaConverter_define.m: mktbl.py
	python $^

SmartKanaConverter_init.m: mktbl.py
	python $^

SmartKanaConverter.o: \
SmartKanaConverter.m \
SmartKanaConverter_define.m \
SmartKanaConverter_init.m

TestSmartKanaConverter: TestSmartKanaConverter.o $(OBJS)
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $^

test: $(TARGET)
	$(OTEST) $^
