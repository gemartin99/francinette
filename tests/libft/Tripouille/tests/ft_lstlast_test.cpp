extern "C"
{
#define new tripouille
#include "libft.h"
#undef new
}

#include "sigsegv.hpp"
#include "check.hpp"
#include "leaks.hpp"
#include <string.h>

void freeList(t_list *head) {if (head) freeList((t_list *)head->next); free(head);}

void	own_add_back(t_list **list, t_list *node)
{
	t_list	*last;

	last = ft_lstlast(*list);
	if (last == NULL)
		*list = node;
	else
		last->next = node;
}

int iTest = 1;
int main(void)
{
	signal(SIGSEGV, sigsegv);
	title("ft_lstlast\t: ")

	t_list * l =  NULL;
	/* 1 */ check(ft_lstlast(l) == 0);
	own_add_back(&l, ft_lstnew((void*)1));
	/* 2 */ check(ft_lstlast(l)->content == (void*)1);
	own_add_back(&l, ft_lstnew((void*)2));
	/* 3 */ check(ft_lstlast(l)->content == (void*)2);
	/* 4 */ check(ft_lstlast(l)->next == 0);
	freeList(l); showLeaks();
	write(1, "\n", 1);
	return (0);
}
