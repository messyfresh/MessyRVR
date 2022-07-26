# Primary MessyRVR Makefile

# compiler and linker binaries
CC			:= gcc
LINKER		:= gcc

# directories
BINDIR		:= bin
SRCDIR		:= src
UTILDIR		:= utils

# compiler and linker flags

INCLUDES	:= $(wildcard *.h)
SOURCES		:= $(shell find $(SRCDIR) -name '*.c')
UTILS		:= $(shell find $(UTILDIR) -name '*.c')
OBJECTS		:= $(SOURCES:$%.c=$%.o) $(UTILS:$%.c=$%.o)

WFLAGS		:= -Wall -Wextra -Werror=float-equal -Wuninitialized -Wunused-variable -Wdouble-promotion
CFLAGS		:= -g -c -Wall 
LDFLAGS		:= -pthread -lm -lrt -l:librobotcontrol.so.1

prefix		:= /usr/local
RM			:= rm -f
RMDIR		:= rm -Rf
INSTALL		:= install -m 4755
INSTALLDIR	:= install -d -m 755

SYMLINK		:= ln -s -f
SYMLINKDIR	:= /etc/robotcontrol
SYMLINKNAME	:= link_to_startup_program

TARGET 		:= $(BINDIR)/messyrvr


# linking Objects
$(TARGET): $(OBJECTS)
	$(INSTALLDIR) $(BINDIR)
	@$(LINKER) -o $@ $(OBJECTS) $(LDFLAGS)
	@echo ""
	@echo "Make completed Successfully"
	@echo "To Start: $@"


# compiling command
$(OBJECTS): %.o : %.c $(INCLUDES)
	@$(CC) $(CFLAGS) $(WFLAGS) $(DEBUGFLAG) $< -o $@
	@echo "Compiled: $@"

all:
	$(TARGET)

debug:
	$(MAKE) $(MAKEFILE) DEBUGFLAG="-g -D DEBUG"
	@echo " "
	@echo "$(TARGET) Make Debug Complete"
	@echo " "

install:
	@$(MAKE) --no-print-directory
	@$(INSTALLDIR) $(DESTDIR)$(prefix)/bin
	@$(INSTALL) $(TARGET) $(DESTDIR)$(prefix)/bin
	@echo "$(TARGET) Install Complete"

clean:
	@$(RM) $(OBJECTS)
	@$(RM) $(TARGET)
	@$(RMDIR) $(BINDIR)
	@echo "$(TARGET) Clean Complete"

uninstall:
	@$(RM) $(DESTDIR)$(prefix)/bin/$(TARGET)
	@echo "$(TARGET) Uninstall Complete"

runonboot:
	@$(MAKE) install --no-print-directory
	@$(SYMLINK) $(DESTDIR)$(prefix)/bin/$(TARGET) $(SYMLINKDIR)/$(SYMLINKNAME)
	@echo "$(TARGET) Set to Run on Boot"

