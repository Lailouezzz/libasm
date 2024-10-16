#include <stdlib.h>

#include "list.h"

t_list	*ft_create_elem(void *data)
{
	t_list	*l = malloc(sizeof(*l));

	if (l == NULL)
		return (NULL);
	l->data = data;
	l->next = NULL;
	return (l);
}

t_list	*ft_create_elem_int(int nb)
{
	int	*n = malloc(sizeof(*n));

	if (n == NULL)
		return (NULL);
	*n = nb;
	t_list	*l = ft_create_elem(n);
	if (l == NULL)
	{
		free(n);
		return (NULL);
	}
	return (l);
}
