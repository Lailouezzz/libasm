#ifndef  LIST_H
# define LIST_H

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

t_list			*ft_create_elem(void *data);
t_list			*ft_create_elem_int(int nb);
extern	void	ft_list_push_back(t_list **begin_list, void *data);
extern	void	ft_list_push_front(t_list **begin_list, void *data);
extern	void	ft_list_sort(t_list **begin_list, int (*cmp)());
extern	int		ft_list_size(t_list *begin_list);
extern	int		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

#endif
