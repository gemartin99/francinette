#include "sigsegv.hpp"
#include "color.hpp"

extern int iTest;

void sigsegv(int signal)
{
	cout << FG_LYELLOW << iTest++ << ".SIGSEGV" << ENDL;
	exit(signal);
}
