/*
// C library headers
#include <stdio.h>
#include <string.h>

// Linux headers
#include <fcntl.h> // Contains file controls like O_RDWR
#include <errno.h> // Error integer and strerror() function
#include <termios.h> // Contains POSIX terminal control definitions
#include <unistd.h> // write(), read(), close()

#include "../utils/log/log.h"

int serialPort = open("/dev/ttyO4", O_RDONLY);

// Check for Errors
if (serialPort < 0) {
    log_error("Error %i from open: %s", errno, strerror(errno));
}

typedef struct {
    UINT8 fades;
    UINT8 system;
    UINT16 servo [7]
} INT_REMOTE_STR

struct INT_REMOTE_STR intStr;

// Read in existing settings, and handle any error
// NOTE: This is important! POSIX states that the struct passed to tcsetattr()
// must have been initialized with a call to tcgetattr() overwise behaviour
// is undefined
if(tcgetattr(serial_port, &tty) != 0) {
    log_error("Error %i from tcgetattr: %s", errno, strerror(errno));
}


*/
