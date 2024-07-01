#ifndef SIGSEGV_HPP
# define SIGSEGV_HPP

# include <iostream>
# include <csignal>
# include <stdlib.h>
# include "color.hpp"

using namespace std;

void sigsegv(int signal);
void sigalarm(int signal);
void sigabort(int signal);
void sigbus(int signal);

#endif