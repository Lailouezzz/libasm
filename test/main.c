#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>

extern size_t	ft_strlen(const char *str);
extern char		*ft_strcpy(char *dst, const char *src);
extern int		ft_strcmp(const char *str1, const char *str2);
extern ssize_t	ft_write(int fd, const char *buf, size_t count);
extern ssize_t	ft_read(int fd, const char *buf, size_t count);
extern char		*ft_strdup(const char *str);
extern int		ft_atoi_base_int(const char *str, int base);
extern int		ft_atoi_base(const char *str, const char *base);

void	test_ft_strlen(const char *test_str)
{
	printf("ft_strlen(\"%s\") == %zu\n", test_str, ft_strlen(test_str));
}

void	test_ft_strcpy(const char *test_str)
{
	char	buf[30] = { 0 };
	printf("ft_strcpy(\"%s\", \"%s\") == ", buf, test_str);
	printf("\"%s\"\n", ft_strcpy(buf, test_str));
}

void	test_ft_strcmp(const char *test_str1, const char *test_str2)
{
	printf("ft_strcmp(\"%s\", \"%s\") == %d\n", test_str1, test_str2, ft_strcmp(test_str1, test_str2));
	printf("strcmp(\"%s\", \"%s\") == %d\n", test_str1, test_str2, strcmp(test_str1, test_str2));
}

void	test_ft_write(const char *str)
{
	write(STDOUT_FILENO, str, ft_strlen(str));
	ft_write(STDOUT_FILENO, str, ft_strlen(str));
}

void	test_ft_atoi_base_int(const char *str, int base)
{
	printf("ft_atoi_base_int(\"%s\", %d) == %d\n", str, base, ft_atoi_base_int(str, base));
}

void	test_ft_atoi_base(const char *str, const char *base)
{
	printf("ft_atoi_base(\"%s\", \"%s\") == %d\n", str, base, ft_atoi_base(str, base));
}

void	test_ft_read(void)
{
	char buf[4];
	int	fd = open("test/testfile", O_RDONLY);
	
	ft_write(STDOUT_FILENO, buf, read(fd, buf, 4));
	ft_write(STDOUT_FILENO, buf, ft_read(fd, buf, 4));
	printf("\ninvalid fd ft_read : %zd\n", ft_read(-1, buf, 3));
	printf("errno : %d\n", errno);
	errno = 0;
	printf("invalid fd read : %zd\n", read(-1, buf, 3));
	printf("errno : %d\n", errno);
	errno = 0;
	printf("nothing to read ft_read : %zd\n", ft_read(fd, buf, 4));
	printf("errno : %d\n", errno);
	errno = 0;
	printf("nothing to read read : %zd\n", read(fd, buf, 4));
	printf("errno : %d\n", errno);
	errno = 0;
	close(fd);
	fd = open("test/testfile", O_RDONLY);
	printf("invalid ft_read : %zd\n", ft_read(fd, NULL, 3));
	printf("errno : %d\n", errno);
	errno = 0;
	printf("invalid read : %zd\n", read(fd, NULL, 3));
	printf("errno : %d\n", errno);
	errno = 0;
	close(fd);
}

void	test_ft_strdup(const char *str)
{
	char	*tmp = ft_strdup(str);
	printf("ft_strdup(\"%s\") == %s\n", str, tmp);
	free(tmp);
}

int	main(void)
{
	test_ft_strlen("");
	test_ft_strlen("1");
	test_ft_strlen("test");
	test_ft_strlen("42");
	test_ft_strlen("Ce string fait 29 characteres");
	test_ft_strcpy("");
	test_ft_strcpy("1");
	test_ft_strcpy("test");
	test_ft_strcpy("42");
	test_ft_strcpy("Ce string fait 29 characteres");
	test_ft_strcmp("", "1");
	test_ft_strcmp("1", "2");
	test_ft_strcmp("test", "42");
	test_ft_strcmp("42", "42");
	test_ft_strcmp("Ce string fait 29 characteres", "Ce string");
	test_ft_write("\n");
	test_ft_write("42\n");
	test_ft_write("test\n");
	test_ft_write("Ce string fait 29 characteres\n");
	test_ft_read();
	test_ft_strdup("");
	test_ft_strdup("42");
	test_ft_strdup("test");
	test_ft_strdup("Ce string fait 29 characteres");
	test_ft_atoi_base_int("Ce string fait 29 characteres", 10);
	test_ft_atoi_base_int("", 10);
	test_ft_atoi_base_int("+++++2", 10);
	test_ft_atoi_base_int("1", 10);
	test_ft_atoi_base_int("777", 8);
	test_ft_atoi_base_int("    \t\f\r\n\v3g4", 16);
	test_ft_atoi_base_int("++++-++++-++++42", 10);
	test_ft_atoi_base("++++-++++-++++42", "0123456789");
	test_ft_atoi_base("++++-++++-++++42", "12");
	test_ft_atoi_base("++++-++++-++++42", "122");
	test_ft_atoi_base("++++-++++-++++42", "");
	test_ft_atoi_base("++++-++++-++++42", "1");
	return (0);
}
