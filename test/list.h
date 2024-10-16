#ifndef  LIST_H
# define LIST_H

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

t_list	*ft_create_elem(void *data);
t_list	*ft_create_elem_int(int nb);

#endif
