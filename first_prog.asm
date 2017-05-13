
_first_prog:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
 printf(1, "Checking Termainal output\n");
  11:	83 ec 08             	sub    $0x8,%esp
  14:	68 15 08 00 00       	push   $0x815
  19:	6a 01                	push   $0x1
  1b:	e8 3f 04 00 00       	call   45f <printf>
  20:	83 c4 10             	add    $0x10,%esp
 exit();
  23:	e8 a8 02 00 00       	call   2d0 <exit>

00000028 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  28:	55                   	push   %ebp
  29:	89 e5                	mov    %esp,%ebp
  2b:	57                   	push   %edi
  2c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  2d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  30:	8b 55 10             	mov    0x10(%ebp),%edx
  33:	8b 45 0c             	mov    0xc(%ebp),%eax
  36:	89 cb                	mov    %ecx,%ebx
  38:	89 df                	mov    %ebx,%edi
  3a:	89 d1                	mov    %edx,%ecx
  3c:	fc                   	cld    
  3d:	f3 aa                	rep stos %al,%es:(%edi)
  3f:	89 ca                	mov    %ecx,%edx
  41:	89 fb                	mov    %edi,%ebx
  43:	89 5d 08             	mov    %ebx,0x8(%ebp)
  46:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  49:	90                   	nop
  4a:	5b                   	pop    %ebx
  4b:	5f                   	pop    %edi
  4c:	5d                   	pop    %ebp
  4d:	c3                   	ret    

0000004e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  4e:	55                   	push   %ebp
  4f:	89 e5                	mov    %esp,%ebp
  51:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  54:	8b 45 08             	mov    0x8(%ebp),%eax
  57:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5a:	90                   	nop
  5b:	8b 45 08             	mov    0x8(%ebp),%eax
  5e:	8d 50 01             	lea    0x1(%eax),%edx
  61:	89 55 08             	mov    %edx,0x8(%ebp)
  64:	8b 55 0c             	mov    0xc(%ebp),%edx
  67:	8d 4a 01             	lea    0x1(%edx),%ecx
  6a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  6d:	0f b6 12             	movzbl (%edx),%edx
  70:	88 10                	mov    %dl,(%eax)
  72:	0f b6 00             	movzbl (%eax),%eax
  75:	84 c0                	test   %al,%al
  77:	75 e2                	jne    5b <strcpy+0xd>
    ;
  return os;
  79:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  7c:	c9                   	leave  
  7d:	c3                   	ret    

0000007e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  7e:	55                   	push   %ebp
  7f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  81:	eb 08                	jmp    8b <strcmp+0xd>
    p++, q++;
  83:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  87:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  8b:	8b 45 08             	mov    0x8(%ebp),%eax
  8e:	0f b6 00             	movzbl (%eax),%eax
  91:	84 c0                	test   %al,%al
  93:	74 10                	je     a5 <strcmp+0x27>
  95:	8b 45 08             	mov    0x8(%ebp),%eax
  98:	0f b6 10             	movzbl (%eax),%edx
  9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  9e:	0f b6 00             	movzbl (%eax),%eax
  a1:	38 c2                	cmp    %al,%dl
  a3:	74 de                	je     83 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	0f b6 00             	movzbl (%eax),%eax
  ab:	0f b6 d0             	movzbl %al,%edx
  ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  b1:	0f b6 00             	movzbl (%eax),%eax
  b4:	0f b6 c0             	movzbl %al,%eax
  b7:	29 c2                	sub    %eax,%edx
  b9:	89 d0                	mov    %edx,%eax
}
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    

000000bd <strlen>:

uint
strlen(char *s)
{
  bd:	55                   	push   %ebp
  be:	89 e5                	mov    %esp,%ebp
  c0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  ca:	eb 04                	jmp    d0 <strlen+0x13>
  cc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	01 d0                	add    %edx,%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	84 c0                	test   %al,%al
  dd:	75 ed                	jne    cc <strlen+0xf>
    ;
  return n;
  df:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e2:	c9                   	leave  
  e3:	c3                   	ret    

000000e4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  e7:	8b 45 10             	mov    0x10(%ebp),%eax
  ea:	50                   	push   %eax
  eb:	ff 75 0c             	pushl  0xc(%ebp)
  ee:	ff 75 08             	pushl  0x8(%ebp)
  f1:	e8 32 ff ff ff       	call   28 <stosb>
  f6:	83 c4 0c             	add    $0xc,%esp
  return dst;
  f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  fc:	c9                   	leave  
  fd:	c3                   	ret    

000000fe <strchr>:

char*
strchr(const char *s, char c)
{
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	83 ec 04             	sub    $0x4,%esp
 104:	8b 45 0c             	mov    0xc(%ebp),%eax
 107:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10a:	eb 14                	jmp    120 <strchr+0x22>
    if(*s == c)
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	0f b6 00             	movzbl (%eax),%eax
 112:	3a 45 fc             	cmp    -0x4(%ebp),%al
 115:	75 05                	jne    11c <strchr+0x1e>
      return (char*)s;
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	eb 13                	jmp    12f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 11c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 120:	8b 45 08             	mov    0x8(%ebp),%eax
 123:	0f b6 00             	movzbl (%eax),%eax
 126:	84 c0                	test   %al,%al
 128:	75 e2                	jne    10c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 12a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 12f:	c9                   	leave  
 130:	c3                   	ret    

00000131 <gets>:

char*
gets(char *buf, int max)
{
 131:	55                   	push   %ebp
 132:	89 e5                	mov    %esp,%ebp
 134:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 137:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 13e:	eb 42                	jmp    182 <gets+0x51>
    cc = read(0, &c, 1);
 140:	83 ec 04             	sub    $0x4,%esp
 143:	6a 01                	push   $0x1
 145:	8d 45 ef             	lea    -0x11(%ebp),%eax
 148:	50                   	push   %eax
 149:	6a 00                	push   $0x0
 14b:	e8 98 01 00 00       	call   2e8 <read>
 150:	83 c4 10             	add    $0x10,%esp
 153:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 156:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 15a:	7e 33                	jle    18f <gets+0x5e>
      break;
    buf[i++] = c;
 15c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 15f:	8d 50 01             	lea    0x1(%eax),%edx
 162:	89 55 f4             	mov    %edx,-0xc(%ebp)
 165:	89 c2                	mov    %eax,%edx
 167:	8b 45 08             	mov    0x8(%ebp),%eax
 16a:	01 c2                	add    %eax,%edx
 16c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 170:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 172:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 176:	3c 0a                	cmp    $0xa,%al
 178:	74 16                	je     190 <gets+0x5f>
 17a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17e:	3c 0d                	cmp    $0xd,%al
 180:	74 0e                	je     190 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 182:	8b 45 f4             	mov    -0xc(%ebp),%eax
 185:	83 c0 01             	add    $0x1,%eax
 188:	3b 45 0c             	cmp    0xc(%ebp),%eax
 18b:	7c b3                	jl     140 <gets+0xf>
 18d:	eb 01                	jmp    190 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 18f:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 190:	8b 55 f4             	mov    -0xc(%ebp),%edx
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	01 d0                	add    %edx,%eax
 198:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 19b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 19e:	c9                   	leave  
 19f:	c3                   	ret    

000001a0 <stat>:

int
stat(char *n, struct stat *st)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a6:	83 ec 08             	sub    $0x8,%esp
 1a9:	6a 00                	push   $0x0
 1ab:	ff 75 08             	pushl  0x8(%ebp)
 1ae:	e8 5d 01 00 00       	call   310 <open>
 1b3:	83 c4 10             	add    $0x10,%esp
 1b6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1bd:	79 07                	jns    1c6 <stat+0x26>
    return -1;
 1bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c4:	eb 25                	jmp    1eb <stat+0x4b>
  r = fstat(fd, st);
 1c6:	83 ec 08             	sub    $0x8,%esp
 1c9:	ff 75 0c             	pushl  0xc(%ebp)
 1cc:	ff 75 f4             	pushl  -0xc(%ebp)
 1cf:	e8 54 01 00 00       	call   328 <fstat>
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1da:	83 ec 0c             	sub    $0xc,%esp
 1dd:	ff 75 f4             	pushl  -0xc(%ebp)
 1e0:	e8 13 01 00 00       	call   2f8 <close>
 1e5:	83 c4 10             	add    $0x10,%esp
  return r;
 1e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1eb:	c9                   	leave  
 1ec:	c3                   	ret    

000001ed <atoi>:

int
atoi(const char *s)
{
 1ed:	55                   	push   %ebp
 1ee:	89 e5                	mov    %esp,%ebp
 1f0:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1fa:	eb 25                	jmp    221 <atoi+0x34>
    n = n*10 + *s++ - '0';
 1fc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ff:	89 d0                	mov    %edx,%eax
 201:	c1 e0 02             	shl    $0x2,%eax
 204:	01 d0                	add    %edx,%eax
 206:	01 c0                	add    %eax,%eax
 208:	89 c1                	mov    %eax,%ecx
 20a:	8b 45 08             	mov    0x8(%ebp),%eax
 20d:	8d 50 01             	lea    0x1(%eax),%edx
 210:	89 55 08             	mov    %edx,0x8(%ebp)
 213:	0f b6 00             	movzbl (%eax),%eax
 216:	0f be c0             	movsbl %al,%eax
 219:	01 c8                	add    %ecx,%eax
 21b:	83 e8 30             	sub    $0x30,%eax
 21e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 221:	8b 45 08             	mov    0x8(%ebp),%eax
 224:	0f b6 00             	movzbl (%eax),%eax
 227:	3c 2f                	cmp    $0x2f,%al
 229:	7e 0a                	jle    235 <atoi+0x48>
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
 22e:	0f b6 00             	movzbl (%eax),%eax
 231:	3c 39                	cmp    $0x39,%al
 233:	7e c7                	jle    1fc <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 235:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 238:	c9                   	leave  
 239:	c3                   	ret    

0000023a <itoa>:

char*
itoa(int val, int base){
 23a:	55                   	push   %ebp
 23b:	89 e5                	mov    %esp,%ebp
 23d:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 240:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 247:	eb 29                	jmp    272 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 249:	8b 45 08             	mov    0x8(%ebp),%eax
 24c:	99                   	cltd   
 24d:	f7 7d 0c             	idivl  0xc(%ebp)
 250:	89 d0                	mov    %edx,%eax
 252:	0f b6 80 30 08 00 00 	movzbl 0x830(%eax),%eax
 259:	8b 55 fc             	mov    -0x4(%ebp),%edx
 25c:	81 c2 e0 0a 00 00    	add    $0xae0,%edx
 262:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 264:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	99                   	cltd   
 26c:	f7 7d 0c             	idivl  0xc(%ebp)
 26f:	89 45 08             	mov    %eax,0x8(%ebp)
 272:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 276:	74 06                	je     27e <itoa+0x44>
 278:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 27c:	75 cb                	jne    249 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 27e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 281:	83 c0 01             	add    $0x1,%eax
 284:	05 e0 0a 00 00       	add    $0xae0,%eax

}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 297:	8b 45 0c             	mov    0xc(%ebp),%eax
 29a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29d:	eb 17                	jmp    2b6 <memmove+0x2b>
    *dst++ = *src++;
 29f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a2:	8d 50 01             	lea    0x1(%eax),%edx
 2a5:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2ab:	8d 4a 01             	lea    0x1(%edx),%ecx
 2ae:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b1:	0f b6 12             	movzbl (%edx),%edx
 2b4:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b6:	8b 45 10             	mov    0x10(%ebp),%eax
 2b9:	8d 50 ff             	lea    -0x1(%eax),%edx
 2bc:	89 55 10             	mov    %edx,0x10(%ebp)
 2bf:	85 c0                	test   %eax,%eax
 2c1:	7f dc                	jg     29f <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c6:	c9                   	leave  
 2c7:	c3                   	ret    

000002c8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c8:	b8 01 00 00 00       	mov    $0x1,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <exit>:
SYSCALL(exit)
 2d0:	b8 02 00 00 00       	mov    $0x2,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <wait>:
SYSCALL(wait)
 2d8:	b8 03 00 00 00       	mov    $0x3,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <pipe>:
SYSCALL(pipe)
 2e0:	b8 04 00 00 00       	mov    $0x4,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <read>:
SYSCALL(read)
 2e8:	b8 05 00 00 00       	mov    $0x5,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <write>:
SYSCALL(write)
 2f0:	b8 10 00 00 00       	mov    $0x10,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <close>:
SYSCALL(close)
 2f8:	b8 15 00 00 00       	mov    $0x15,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <kill>:
SYSCALL(kill)
 300:	b8 06 00 00 00       	mov    $0x6,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <exec>:
SYSCALL(exec)
 308:	b8 07 00 00 00       	mov    $0x7,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <open>:
SYSCALL(open)
 310:	b8 0f 00 00 00       	mov    $0xf,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <mknod>:
SYSCALL(mknod)
 318:	b8 11 00 00 00       	mov    $0x11,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <unlink>:
SYSCALL(unlink)
 320:	b8 12 00 00 00       	mov    $0x12,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <fstat>:
SYSCALL(fstat)
 328:	b8 08 00 00 00       	mov    $0x8,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <link>:
SYSCALL(link)
 330:	b8 13 00 00 00       	mov    $0x13,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <mkdir>:
SYSCALL(mkdir)
 338:	b8 14 00 00 00       	mov    $0x14,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <chdir>:
SYSCALL(chdir)
 340:	b8 09 00 00 00       	mov    $0x9,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <dup>:
SYSCALL(dup)
 348:	b8 0a 00 00 00       	mov    $0xa,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <getpid>:
SYSCALL(getpid)
 350:	b8 0b 00 00 00       	mov    $0xb,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <sbrk>:
SYSCALL(sbrk)
 358:	b8 0c 00 00 00       	mov    $0xc,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <sleep>:
SYSCALL(sleep)
 360:	b8 0d 00 00 00       	mov    $0xd,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <uptime>:
SYSCALL(uptime)
 368:	b8 0e 00 00 00       	mov    $0xe,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <randomX>:
SYSCALL(randomX)
 370:	b8 16 00 00 00       	mov    $0x16,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <setSeedX>:
SYSCALL(setSeedX)
 378:	b8 17 00 00 00       	mov    $0x17,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <uniformR>:
SYSCALL(uniformR)
 380:	b8 18 00 00 00       	mov    $0x18,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	83 ec 18             	sub    $0x18,%esp
 38e:	8b 45 0c             	mov    0xc(%ebp),%eax
 391:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 394:	83 ec 04             	sub    $0x4,%esp
 397:	6a 01                	push   $0x1
 399:	8d 45 f4             	lea    -0xc(%ebp),%eax
 39c:	50                   	push   %eax
 39d:	ff 75 08             	pushl  0x8(%ebp)
 3a0:	e8 4b ff ff ff       	call   2f0 <write>
 3a5:	83 c4 10             	add    $0x10,%esp
}
 3a8:	90                   	nop
 3a9:	c9                   	leave  
 3aa:	c3                   	ret    

000003ab <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ab:	55                   	push   %ebp
 3ac:	89 e5                	mov    %esp,%ebp
 3ae:	53                   	push   %ebx
 3af:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3b9:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3bd:	74 17                	je     3d6 <printint+0x2b>
 3bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3c3:	79 11                	jns    3d6 <printint+0x2b>
    neg = 1;
 3c5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cf:	f7 d8                	neg    %eax
 3d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d4:	eb 06                	jmp    3dc <printint+0x31>
  } else {
    x = xx;
 3d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3dc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3e3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3e6:	8d 41 01             	lea    0x1(%ecx),%eax
 3e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f2:	ba 00 00 00 00       	mov    $0x0,%edx
 3f7:	f7 f3                	div    %ebx
 3f9:	89 d0                	mov    %edx,%eax
 3fb:	0f b6 80 b0 0a 00 00 	movzbl 0xab0(%eax),%eax
 402:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 406:	8b 5d 10             	mov    0x10(%ebp),%ebx
 409:	8b 45 ec             	mov    -0x14(%ebp),%eax
 40c:	ba 00 00 00 00       	mov    $0x0,%edx
 411:	f7 f3                	div    %ebx
 413:	89 45 ec             	mov    %eax,-0x14(%ebp)
 416:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 41a:	75 c7                	jne    3e3 <printint+0x38>
  if(neg)
 41c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 420:	74 2d                	je     44f <printint+0xa4>
    buf[i++] = '-';
 422:	8b 45 f4             	mov    -0xc(%ebp),%eax
 425:	8d 50 01             	lea    0x1(%eax),%edx
 428:	89 55 f4             	mov    %edx,-0xc(%ebp)
 42b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 430:	eb 1d                	jmp    44f <printint+0xa4>
    putc(fd, buf[i]);
 432:	8d 55 dc             	lea    -0x24(%ebp),%edx
 435:	8b 45 f4             	mov    -0xc(%ebp),%eax
 438:	01 d0                	add    %edx,%eax
 43a:	0f b6 00             	movzbl (%eax),%eax
 43d:	0f be c0             	movsbl %al,%eax
 440:	83 ec 08             	sub    $0x8,%esp
 443:	50                   	push   %eax
 444:	ff 75 08             	pushl  0x8(%ebp)
 447:	e8 3c ff ff ff       	call   388 <putc>
 44c:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 44f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 453:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 457:	79 d9                	jns    432 <printint+0x87>
    putc(fd, buf[i]);
}
 459:	90                   	nop
 45a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 45d:	c9                   	leave  
 45e:	c3                   	ret    

0000045f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 45f:	55                   	push   %ebp
 460:	89 e5                	mov    %esp,%ebp
 462:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 465:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 46c:	8d 45 0c             	lea    0xc(%ebp),%eax
 46f:	83 c0 04             	add    $0x4,%eax
 472:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 475:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 47c:	e9 59 01 00 00       	jmp    5da <printf+0x17b>
    c = fmt[i] & 0xff;
 481:	8b 55 0c             	mov    0xc(%ebp),%edx
 484:	8b 45 f0             	mov    -0x10(%ebp),%eax
 487:	01 d0                	add    %edx,%eax
 489:	0f b6 00             	movzbl (%eax),%eax
 48c:	0f be c0             	movsbl %al,%eax
 48f:	25 ff 00 00 00       	and    $0xff,%eax
 494:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 497:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 49b:	75 2c                	jne    4c9 <printf+0x6a>
      if(c == '%'){
 49d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4a1:	75 0c                	jne    4af <printf+0x50>
        state = '%';
 4a3:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4aa:	e9 27 01 00 00       	jmp    5d6 <printf+0x177>
      } else {
        putc(fd, c);
 4af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b2:	0f be c0             	movsbl %al,%eax
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	50                   	push   %eax
 4b9:	ff 75 08             	pushl  0x8(%ebp)
 4bc:	e8 c7 fe ff ff       	call   388 <putc>
 4c1:	83 c4 10             	add    $0x10,%esp
 4c4:	e9 0d 01 00 00       	jmp    5d6 <printf+0x177>
      }
    } else if(state == '%'){
 4c9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4cd:	0f 85 03 01 00 00    	jne    5d6 <printf+0x177>
      if(c == 'd'){
 4d3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4d7:	75 1e                	jne    4f7 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4d9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4dc:	8b 00                	mov    (%eax),%eax
 4de:	6a 01                	push   $0x1
 4e0:	6a 0a                	push   $0xa
 4e2:	50                   	push   %eax
 4e3:	ff 75 08             	pushl  0x8(%ebp)
 4e6:	e8 c0 fe ff ff       	call   3ab <printint>
 4eb:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f2:	e9 d8 00 00 00       	jmp    5cf <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4f7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4fb:	74 06                	je     503 <printf+0xa4>
 4fd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 501:	75 1e                	jne    521 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 503:	8b 45 e8             	mov    -0x18(%ebp),%eax
 506:	8b 00                	mov    (%eax),%eax
 508:	6a 00                	push   $0x0
 50a:	6a 10                	push   $0x10
 50c:	50                   	push   %eax
 50d:	ff 75 08             	pushl  0x8(%ebp)
 510:	e8 96 fe ff ff       	call   3ab <printint>
 515:	83 c4 10             	add    $0x10,%esp
        ap++;
 518:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 51c:	e9 ae 00 00 00       	jmp    5cf <printf+0x170>
      } else if(c == 's'){
 521:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 525:	75 43                	jne    56a <printf+0x10b>
        s = (char*)*ap;
 527:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52a:	8b 00                	mov    (%eax),%eax
 52c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 52f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 533:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 537:	75 25                	jne    55e <printf+0xff>
          s = "(null)";
 539:	c7 45 f4 41 08 00 00 	movl   $0x841,-0xc(%ebp)
        while(*s != 0){
 540:	eb 1c                	jmp    55e <printf+0xff>
          putc(fd, *s);
 542:	8b 45 f4             	mov    -0xc(%ebp),%eax
 545:	0f b6 00             	movzbl (%eax),%eax
 548:	0f be c0             	movsbl %al,%eax
 54b:	83 ec 08             	sub    $0x8,%esp
 54e:	50                   	push   %eax
 54f:	ff 75 08             	pushl  0x8(%ebp)
 552:	e8 31 fe ff ff       	call   388 <putc>
 557:	83 c4 10             	add    $0x10,%esp
          s++;
 55a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 55e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 561:	0f b6 00             	movzbl (%eax),%eax
 564:	84 c0                	test   %al,%al
 566:	75 da                	jne    542 <printf+0xe3>
 568:	eb 65                	jmp    5cf <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 56a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 56e:	75 1d                	jne    58d <printf+0x12e>
        putc(fd, *ap);
 570:	8b 45 e8             	mov    -0x18(%ebp),%eax
 573:	8b 00                	mov    (%eax),%eax
 575:	0f be c0             	movsbl %al,%eax
 578:	83 ec 08             	sub    $0x8,%esp
 57b:	50                   	push   %eax
 57c:	ff 75 08             	pushl  0x8(%ebp)
 57f:	e8 04 fe ff ff       	call   388 <putc>
 584:	83 c4 10             	add    $0x10,%esp
        ap++;
 587:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58b:	eb 42                	jmp    5cf <printf+0x170>
      } else if(c == '%'){
 58d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 591:	75 17                	jne    5aa <printf+0x14b>
        putc(fd, c);
 593:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 596:	0f be c0             	movsbl %al,%eax
 599:	83 ec 08             	sub    $0x8,%esp
 59c:	50                   	push   %eax
 59d:	ff 75 08             	pushl  0x8(%ebp)
 5a0:	e8 e3 fd ff ff       	call   388 <putc>
 5a5:	83 c4 10             	add    $0x10,%esp
 5a8:	eb 25                	jmp    5cf <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5aa:	83 ec 08             	sub    $0x8,%esp
 5ad:	6a 25                	push   $0x25
 5af:	ff 75 08             	pushl  0x8(%ebp)
 5b2:	e8 d1 fd ff ff       	call   388 <putc>
 5b7:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5bd:	0f be c0             	movsbl %al,%eax
 5c0:	83 ec 08             	sub    $0x8,%esp
 5c3:	50                   	push   %eax
 5c4:	ff 75 08             	pushl  0x8(%ebp)
 5c7:	e8 bc fd ff ff       	call   388 <putc>
 5cc:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5cf:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5da:	8b 55 0c             	mov    0xc(%ebp),%edx
 5dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5e0:	01 d0                	add    %edx,%eax
 5e2:	0f b6 00             	movzbl (%eax),%eax
 5e5:	84 c0                	test   %al,%al
 5e7:	0f 85 94 fe ff ff    	jne    481 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5ed:	90                   	nop
 5ee:	c9                   	leave  
 5ef:	c3                   	ret    

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
 5f1:	89 e5                	mov    %esp,%ebp
 5f3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5f6:	8b 45 08             	mov    0x8(%ebp),%eax
 5f9:	83 e8 08             	sub    $0x8,%eax
 5fc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ff:	a1 08 0b 00 00       	mov    0xb08,%eax
 604:	89 45 fc             	mov    %eax,-0x4(%ebp)
 607:	eb 24                	jmp    62d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 609:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60c:	8b 00                	mov    (%eax),%eax
 60e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 611:	77 12                	ja     625 <free+0x35>
 613:	8b 45 f8             	mov    -0x8(%ebp),%eax
 616:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 619:	77 24                	ja     63f <free+0x4f>
 61b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61e:	8b 00                	mov    (%eax),%eax
 620:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 623:	77 1a                	ja     63f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 625:	8b 45 fc             	mov    -0x4(%ebp),%eax
 628:	8b 00                	mov    (%eax),%eax
 62a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 62d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 630:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 633:	76 d4                	jbe    609 <free+0x19>
 635:	8b 45 fc             	mov    -0x4(%ebp),%eax
 638:	8b 00                	mov    (%eax),%eax
 63a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 63d:	76 ca                	jbe    609 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 63f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 642:	8b 40 04             	mov    0x4(%eax),%eax
 645:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 64c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64f:	01 c2                	add    %eax,%edx
 651:	8b 45 fc             	mov    -0x4(%ebp),%eax
 654:	8b 00                	mov    (%eax),%eax
 656:	39 c2                	cmp    %eax,%edx
 658:	75 24                	jne    67e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65d:	8b 50 04             	mov    0x4(%eax),%edx
 660:	8b 45 fc             	mov    -0x4(%ebp),%eax
 663:	8b 00                	mov    (%eax),%eax
 665:	8b 40 04             	mov    0x4(%eax),%eax
 668:	01 c2                	add    %eax,%edx
 66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 670:	8b 45 fc             	mov    -0x4(%ebp),%eax
 673:	8b 00                	mov    (%eax),%eax
 675:	8b 10                	mov    (%eax),%edx
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	89 10                	mov    %edx,(%eax)
 67c:	eb 0a                	jmp    688 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 10                	mov    (%eax),%edx
 683:	8b 45 f8             	mov    -0x8(%ebp),%eax
 686:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	8b 40 04             	mov    0x4(%eax),%eax
 68e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	01 d0                	add    %edx,%eax
 69a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69d:	75 20                	jne    6bf <free+0xcf>
    p->s.size += bp->s.size;
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	8b 50 04             	mov    0x4(%eax),%edx
 6a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a8:	8b 40 04             	mov    0x4(%eax),%eax
 6ab:	01 c2                	add    %eax,%edx
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	8b 10                	mov    (%eax),%edx
 6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bb:	89 10                	mov    %edx,(%eax)
 6bd:	eb 08                	jmp    6c7 <free+0xd7>
  } else
    p->s.ptr = bp;
 6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6c5:	89 10                	mov    %edx,(%eax)
  freep = p;
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	a3 08 0b 00 00       	mov    %eax,0xb08
}
 6cf:	90                   	nop
 6d0:	c9                   	leave  
 6d1:	c3                   	ret    

000006d2 <morecore>:

static Header*
morecore(uint nu)
{
 6d2:	55                   	push   %ebp
 6d3:	89 e5                	mov    %esp,%ebp
 6d5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6d8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6df:	77 07                	ja     6e8 <morecore+0x16>
    nu = 4096;
 6e1:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6e8:	8b 45 08             	mov    0x8(%ebp),%eax
 6eb:	c1 e0 03             	shl    $0x3,%eax
 6ee:	83 ec 0c             	sub    $0xc,%esp
 6f1:	50                   	push   %eax
 6f2:	e8 61 fc ff ff       	call   358 <sbrk>
 6f7:	83 c4 10             	add    $0x10,%esp
 6fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6fd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 701:	75 07                	jne    70a <morecore+0x38>
    return 0;
 703:	b8 00 00 00 00       	mov    $0x0,%eax
 708:	eb 26                	jmp    730 <morecore+0x5e>
  hp = (Header*)p;
 70a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 70d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 710:	8b 45 f0             	mov    -0x10(%ebp),%eax
 713:	8b 55 08             	mov    0x8(%ebp),%edx
 716:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 719:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71c:	83 c0 08             	add    $0x8,%eax
 71f:	83 ec 0c             	sub    $0xc,%esp
 722:	50                   	push   %eax
 723:	e8 c8 fe ff ff       	call   5f0 <free>
 728:	83 c4 10             	add    $0x10,%esp
  return freep;
 72b:	a1 08 0b 00 00       	mov    0xb08,%eax
}
 730:	c9                   	leave  
 731:	c3                   	ret    

00000732 <malloc>:

void*
malloc(uint nbytes)
{
 732:	55                   	push   %ebp
 733:	89 e5                	mov    %esp,%ebp
 735:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 738:	8b 45 08             	mov    0x8(%ebp),%eax
 73b:	83 c0 07             	add    $0x7,%eax
 73e:	c1 e8 03             	shr    $0x3,%eax
 741:	83 c0 01             	add    $0x1,%eax
 744:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 747:	a1 08 0b 00 00       	mov    0xb08,%eax
 74c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 74f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 753:	75 23                	jne    778 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 755:	c7 45 f0 00 0b 00 00 	movl   $0xb00,-0x10(%ebp)
 75c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75f:	a3 08 0b 00 00       	mov    %eax,0xb08
 764:	a1 08 0b 00 00       	mov    0xb08,%eax
 769:	a3 00 0b 00 00       	mov    %eax,0xb00
    base.s.size = 0;
 76e:	c7 05 04 0b 00 00 00 	movl   $0x0,0xb04
 775:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 778:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77b:	8b 00                	mov    (%eax),%eax
 77d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 780:	8b 45 f4             	mov    -0xc(%ebp),%eax
 783:	8b 40 04             	mov    0x4(%eax),%eax
 786:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 789:	72 4d                	jb     7d8 <malloc+0xa6>
      if(p->s.size == nunits)
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	8b 40 04             	mov    0x4(%eax),%eax
 791:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 794:	75 0c                	jne    7a2 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 796:	8b 45 f4             	mov    -0xc(%ebp),%eax
 799:	8b 10                	mov    (%eax),%edx
 79b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79e:	89 10                	mov    %edx,(%eax)
 7a0:	eb 26                	jmp    7c8 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	8b 40 04             	mov    0x4(%eax),%eax
 7a8:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7ab:	89 c2                	mov    %eax,%edx
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b6:	8b 40 04             	mov    0x4(%eax),%eax
 7b9:	c1 e0 03             	shl    $0x3,%eax
 7bc:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7c5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cb:	a3 08 0b 00 00       	mov    %eax,0xb08
      return (void*)(p + 1);
 7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d3:	83 c0 08             	add    $0x8,%eax
 7d6:	eb 3b                	jmp    813 <malloc+0xe1>
    }
    if(p == freep)
 7d8:	a1 08 0b 00 00       	mov    0xb08,%eax
 7dd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7e0:	75 1e                	jne    800 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7e2:	83 ec 0c             	sub    $0xc,%esp
 7e5:	ff 75 ec             	pushl  -0x14(%ebp)
 7e8:	e8 e5 fe ff ff       	call   6d2 <morecore>
 7ed:	83 c4 10             	add    $0x10,%esp
 7f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7f7:	75 07                	jne    800 <malloc+0xce>
        return 0;
 7f9:	b8 00 00 00 00       	mov    $0x0,%eax
 7fe:	eb 13                	jmp    813 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	89 45 f0             	mov    %eax,-0x10(%ebp)
 806:	8b 45 f4             	mov    -0xc(%ebp),%eax
 809:	8b 00                	mov    (%eax),%eax
 80b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 80e:	e9 6d ff ff ff       	jmp    780 <malloc+0x4e>
}
 813:	c9                   	leave  
 814:	c3                   	ret    
