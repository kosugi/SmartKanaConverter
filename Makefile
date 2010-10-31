
OTEST = /Developer/Tools/otest

TARGET = TestSmartKanaConverter

OBJS = SmartKanaConverter.o

INCLUDES = -I.

CFLAGS = -O2 -std=c99 -Wall $(INCLUDES)
LDFLAGS = -framework Foundation -framework AppKit -framework SenTestingKit

.m.o:
	$(CC) $(CFLAGS) -c $< -o $*.o

.PHONY: all
all: $(OBJS) $(TARGET).o
	$(CC) $(LDFLAGS) $(CFLAGS) -o $(TARGET) $^

.PHONY: clean
clean:
	$(RM) $(TARGET) $(OBJS)

SmartKanaConverter.o: \
SmartKanaConverter.m \
SmartKanaConverter_define.m \
SmartKanaConverter_init.m

TestSmartKanaConverter: TestSmartKanaConverter.o $(OBJS)
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $^

test: $(TARGET)
	$(OTEST) $^
