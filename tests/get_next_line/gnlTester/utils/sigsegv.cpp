#include "sigsegv.hpp"
#include "color.hpp"

extern int iTest;

void sigsegv(int signal)
{
	cout << FG_LYELLOW << iTest++ << ".SIGSEGV\n";
	(void)signal;
	exit(EXIT_SUCCESS);
}

void sigalarm(int signal)
{
	cout << FG_LYELLOW << iTest++ << ".TIMEOUT\n";
	(void)signal;
	exit(EXIT_SUCCESS);
}

void sigabort(int signal)
{
	cout << FG_LYELLOW << iTest++ << ".ABORT\n";
	(void)signal;
	exit(EXIT_SUCCESS);
}

void sigbus(int signal)
{
	cout << FG_LYELLOW << iTest++ << ".BUS_ERROR\n";
	(void)signal;
	exit(EXIT_SUCCESS);
}