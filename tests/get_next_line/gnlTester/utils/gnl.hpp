#ifndef GNL_HPP
#define GNL_HPP
#include "leaks.hpp"

#define TEST(x)                                                       \
	{                                                                 \
		int status = 0;                                               \
		int test = fork();                                            \
		if (test == 0)                                                \
		{                                                             \
			alarm(TIMEOUT_US / 1000000);                              \
			x;                                                        \
			showLeaks();                                              \
			cout << ENDL;                                             \
			exit(EXIT_SUCCESS);                                       \
		}                                                             \
		else                                                          \
		{                                                             \
			long total = 0;                                           \
			long interval = 50000;                                    \
			while (total < TIMEOUT_US)                                \
			{                                                         \
				usleep(interval);                                     \
				if (waitpid(test, &status, WNOHANG) != 0)             \
				{                                                     \
					break;                                            \
				}                                                     \
				total += interval;                                    \
			}                                                         \
			if (total >= TIMEOUT_US)                                  \
			{                                                         \
				if (waitpid(test, &status, WNOHANG) == 0)             \
				{                                                     \
					kill(test, SIGKILL);                              \
					cout << FG_YELLOW << iTest << ".TIMEOUT" << ENDL; \
				}                                                     \
			}                                                         \
		}                                                             \
	}

void gnl(int fd, char const *s);

#endif