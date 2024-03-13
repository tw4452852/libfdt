#define memcpy c_memcpy
void *c_memcpy(void *, const void *, unsigned long);

#define memset c_memset
void *c_memset(void *, int, unsigned long);

#define memmove c_memmove
void *c_memmove(void *, const void *, unsigned long);

#define memcmp c_memcmp
int c_memcmp(const void *, const void *, unsigned long);

#define memchr c_memchr
void *c_memchr(const void *, int, unsigned long);

#define strlen c_strlen
unsigned long c_strlen(const char *);

#define strchr c_strchr
char *c_strchr(const char *, int);

#define strrchr c_strrchr
char *c_strrchr(const char *, int);

#define strnlen c_strnlen
size_t c_strnlen(const char *, size_t);