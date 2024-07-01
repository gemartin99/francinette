# include <unistd.h>
# include <string.h>
# include <sys/wait.h>
# include "sigsegv.hpp"
# include "color.hpp"

extern int iTest;
extern bool showTest;
extern int pipeOut;
extern int stdOut;

void handle_sig(string message)
{
	dup2(stdOut, 1);
	if (showTest)
		cout << FG_BLUE << "ft_printf: " << FG_LYELLOW << "[" << message << "]" << ENDL;
	else
		cout << FG_LYELLOW << iTest++ << "." << message << " ";
	dup2(pipeOut, 1);
	exit(EXIT_SUCCESS);
}

void sigsegv(int signal)
{
	(void)signal;
	handle_sig("SIGSEGV");
	exit(EXIT_SUCCESS);
}

void sigalarm(int signal)
{
	(void)signal;
	handle_sig("TIMEOUT");
	exit(EXIT_SUCCESS);
}

void sigabort(int signal)
{
	(void)signal;
	handle_sig("ABORT");
	exit(EXIT_SUCCESS);
}

void sigbus(int signal)
{
	(void)signal;
	handle_sig("BUS_ERROR");
	exit(EXIT_SUCCESS);
}

void handle_signals()
{
	signal(SIGSEGV, sigsegv);
	signal(SIGABRT, sigabort);
	signal(SIGBUS, sigbus);
	signal(SIGALRM, sigalarm);
}
