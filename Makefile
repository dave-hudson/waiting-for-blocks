CC := gcc
CFLAGS := -std=gnu99 -O2 -Wall
LDFLAGS := -std=gnu99
RM := rm

#
# Define our target app.
#
APP := wfb

#
# Define the source files for our build.
#
WFB_SRCS := wfb.c

#
# Create a list of object files from source files.
#
WFB_OBJS := $(patsubst %.c,%.o,$(filter %.c,$(WFB_SRCS)))

WFB_LIBS := -lm

%.o : %.c
	$(CC) $(CFLAGS) -MD -c $< -o $@

.PHONY: all

all: $(APP)

wfb: $(WFB_OBJS)
	$(CC) $(LDFLAGS) -o $@ $(WFB_OBJS) $(WFB_LIBS)

-include $(WFB_OBJS:.o=.d) 

.PHONY: clean

clean:
	$(RM) -f $(APP) *.o $(patsubst %,%/*.o,$(SUBDIRS))
	$(RM) -f $(APP) *.d $(patsubst %,%/*.d,$(SUBDIRS))

.PHONY: realclean

realclean: clean
	$(RM) -f *~ $(patsubst %,%/*~,$(SUBDIRS))
	$(RM) -f *.txt $(patsubst %,%/*~,$(SUBDIRS))

