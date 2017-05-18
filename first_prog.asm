
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
  14:	68 1d 08 00 00       	push   $0x81d
  19:	6a 01                	push   $0x1
  1b:	e8 47 04 00 00       	call   467 <printf>
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
 252:	0f b6 80 38 08 00 00 	movzbl 0x838(%eax),%eax
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

00000388 <setdeadline>:
 388:	b8 19 00 00 00       	mov    $0x19,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	83 ec 18             	sub    $0x18,%esp
 396:	8b 45 0c             	mov    0xc(%ebp),%eax
 399:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 39c:	83 ec 04             	sub    $0x4,%esp
 39f:	6a 01                	push   $0x1
 3a1:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3a4:	50                   	push   %eax
 3a5:	ff 75 08             	pushl  0x8(%ebp)
 3a8:	e8 43 ff ff ff       	call   2f0 <write>
 3ad:	83 c4 10             	add    $0x10,%esp
}
 3b0:	90                   	nop
 3b1:	c9                   	leave  
 3b2:	c3                   	ret    

000003b3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b3:	55                   	push   %ebp
 3b4:	89 e5                	mov    %esp,%ebp
 3b6:	53                   	push   %ebx
 3b7:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ba:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3c1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c5:	74 17                	je     3de <printint+0x2b>
 3c7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3cb:	79 11                	jns    3de <printint+0x2b>
    neg = 1;
 3cd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d7:	f7 d8                	neg    %eax
 3d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3dc:	eb 06                	jmp    3e4 <printint+0x31>
  } else {
    x = xx;
 3de:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3eb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3ee:	8d 41 01             	lea    0x1(%ecx),%eax
 3f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3f4:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f7:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fa:	ba 00 00 00 00       	mov    $0x0,%edx
 3ff:	f7 f3                	div    %ebx
 401:	89 d0                	mov    %edx,%eax
 403:	0f b6 80 b8 0a 00 00 	movzbl 0xab8(%eax),%eax
 40a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 40e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 411:	8b 45 ec             	mov    -0x14(%ebp),%eax
 414:	ba 00 00 00 00       	mov    $0x0,%edx
 419:	f7 f3                	div    %ebx
 41b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 422:	75 c7                	jne    3eb <printint+0x38>
  if(neg)
 424:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 428:	74 2d                	je     457 <printint+0xa4>
    buf[i++] = '-';
 42a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42d:	8d 50 01             	lea    0x1(%eax),%edx
 430:	89 55 f4             	mov    %edx,-0xc(%ebp)
 433:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 438:	eb 1d                	jmp    457 <printint+0xa4>
    putc(fd, buf[i]);
 43a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 43d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 440:	01 d0                	add    %edx,%eax
 442:	0f b6 00             	movzbl (%eax),%eax
 445:	0f be c0             	movsbl %al,%eax
 448:	83 ec 08             	sub    $0x8,%esp
 44b:	50                   	push   %eax
 44c:	ff 75 08             	pushl  0x8(%ebp)
 44f:	e8 3c ff ff ff       	call   390 <putc>
 454:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 457:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 45b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 45f:	79 d9                	jns    43a <printint+0x87>
    putc(fd, buf[i]);
}
 461:	90                   	nop
 462:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 465:	c9                   	leave  
 466:	c3                   	ret    

00000467 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 467:	55                   	push   %ebp
 468:	89 e5                	mov    %esp,%ebp
 46a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 46d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 474:	8d 45 0c             	lea    0xc(%ebp),%eax
 477:	83 c0 04             	add    $0x4,%eax
 47a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 47d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 484:	e9 59 01 00 00       	jmp    5e2 <printf+0x17b>
    c = fmt[i] & 0xff;
 489:	8b 55 0c             	mov    0xc(%ebp),%edx
 48c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 48f:	01 d0                	add    %edx,%eax
 491:	0f b6 00             	movzbl (%eax),%eax
 494:	0f be c0             	movsbl %al,%eax
 497:	25 ff 00 00 00       	and    $0xff,%eax
 49c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 49f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a3:	75 2c                	jne    4d1 <printf+0x6a>
      if(c == '%'){
 4a5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4a9:	75 0c                	jne    4b7 <printf+0x50>
        state = '%';
 4ab:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b2:	e9 27 01 00 00       	jmp    5de <printf+0x177>
      } else {
        putc(fd, c);
 4b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ba:	0f be c0             	movsbl %al,%eax
 4bd:	83 ec 08             	sub    $0x8,%esp
 4c0:	50                   	push   %eax
 4c1:	ff 75 08             	pushl  0x8(%ebp)
 4c4:	e8 c7 fe ff ff       	call   390 <putc>
 4c9:	83 c4 10             	add    $0x10,%esp
 4cc:	e9 0d 01 00 00       	jmp    5de <printf+0x177>
      }
    } else if(state == '%'){
 4d1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d5:	0f 85 03 01 00 00    	jne    5de <printf+0x177>
      if(c == 'd'){
 4db:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4df:	75 1e                	jne    4ff <printf+0x98>
        printint(fd, *ap, 10, 1);
 4e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e4:	8b 00                	mov    (%eax),%eax
 4e6:	6a 01                	push   $0x1
 4e8:	6a 0a                	push   $0xa
 4ea:	50                   	push   %eax
 4eb:	ff 75 08             	pushl  0x8(%ebp)
 4ee:	e8 c0 fe ff ff       	call   3b3 <printint>
 4f3:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fa:	e9 d8 00 00 00       	jmp    5d7 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4ff:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 503:	74 06                	je     50b <printf+0xa4>
 505:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 509:	75 1e                	jne    529 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 50b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50e:	8b 00                	mov    (%eax),%eax
 510:	6a 00                	push   $0x0
 512:	6a 10                	push   $0x10
 514:	50                   	push   %eax
 515:	ff 75 08             	pushl  0x8(%ebp)
 518:	e8 96 fe ff ff       	call   3b3 <printint>
 51d:	83 c4 10             	add    $0x10,%esp
        ap++;
 520:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 524:	e9 ae 00 00 00       	jmp    5d7 <printf+0x170>
      } else if(c == 's'){
 529:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 52d:	75 43                	jne    572 <printf+0x10b>
        s = (char*)*ap;
 52f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 532:	8b 00                	mov    (%eax),%eax
 534:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 537:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 53b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 53f:	75 25                	jne    566 <printf+0xff>
          s = "(null)";
 541:	c7 45 f4 49 08 00 00 	movl   $0x849,-0xc(%ebp)
        while(*s != 0){
 548:	eb 1c                	jmp    566 <printf+0xff>
          putc(fd, *s);
 54a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54d:	0f b6 00             	movzbl (%eax),%eax
 550:	0f be c0             	movsbl %al,%eax
 553:	83 ec 08             	sub    $0x8,%esp
 556:	50                   	push   %eax
 557:	ff 75 08             	pushl  0x8(%ebp)
 55a:	e8 31 fe ff ff       	call   390 <putc>
 55f:	83 c4 10             	add    $0x10,%esp
          s++;
 562:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 566:	8b 45 f4             	mov    -0xc(%ebp),%eax
 569:	0f b6 00             	movzbl (%eax),%eax
 56c:	84 c0                	test   %al,%al
 56e:	75 da                	jne    54a <printf+0xe3>
 570:	eb 65                	jmp    5d7 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 572:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 576:	75 1d                	jne    595 <printf+0x12e>
        putc(fd, *ap);
 578:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57b:	8b 00                	mov    (%eax),%eax
 57d:	0f be c0             	movsbl %al,%eax
 580:	83 ec 08             	sub    $0x8,%esp
 583:	50                   	push   %eax
 584:	ff 75 08             	pushl  0x8(%ebp)
 587:	e8 04 fe ff ff       	call   390 <putc>
 58c:	83 c4 10             	add    $0x10,%esp
        ap++;
 58f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 593:	eb 42                	jmp    5d7 <printf+0x170>
      } else if(c == '%'){
 595:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 599:	75 17                	jne    5b2 <printf+0x14b>
        putc(fd, c);
 59b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59e:	0f be c0             	movsbl %al,%eax
 5a1:	83 ec 08             	sub    $0x8,%esp
 5a4:	50                   	push   %eax
 5a5:	ff 75 08             	pushl  0x8(%ebp)
 5a8:	e8 e3 fd ff ff       	call   390 <putc>
 5ad:	83 c4 10             	add    $0x10,%esp
 5b0:	eb 25                	jmp    5d7 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b2:	83 ec 08             	sub    $0x8,%esp
 5b5:	6a 25                	push   $0x25
 5b7:	ff 75 08             	pushl  0x8(%ebp)
 5ba:	e8 d1 fd ff ff       	call   390 <putc>
 5bf:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c5:	0f be c0             	movsbl %al,%eax
 5c8:	83 ec 08             	sub    $0x8,%esp
 5cb:	50                   	push   %eax
 5cc:	ff 75 08             	pushl  0x8(%ebp)
 5cf:	e8 bc fd ff ff       	call   390 <putc>
 5d4:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5d7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5de:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e2:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5e8:	01 d0                	add    %edx,%eax
 5ea:	0f b6 00             	movzbl (%eax),%eax
 5ed:	84 c0                	test   %al,%al
 5ef:	0f 85 94 fe ff ff    	jne    489 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5f5:	90                   	nop
 5f6:	c9                   	leave  
 5f7:	c3                   	ret    

000005f8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f8:	55                   	push   %ebp
 5f9:	89 e5                	mov    %esp,%ebp
 5fb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5fe:	8b 45 08             	mov    0x8(%ebp),%eax
 601:	83 e8 08             	sub    $0x8,%eax
 604:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 607:	a1 08 0b 00 00       	mov    0xb08,%eax
 60c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60f:	eb 24                	jmp    635 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 611:	8b 45 fc             	mov    -0x4(%ebp),%eax
 614:	8b 00                	mov    (%eax),%eax
 616:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 619:	77 12                	ja     62d <free+0x35>
 61b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 621:	77 24                	ja     647 <free+0x4f>
 623:	8b 45 fc             	mov    -0x4(%ebp),%eax
 626:	8b 00                	mov    (%eax),%eax
 628:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62b:	77 1a                	ja     647 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 00                	mov    (%eax),%eax
 632:	89 45 fc             	mov    %eax,-0x4(%ebp)
 635:	8b 45 f8             	mov    -0x8(%ebp),%eax
 638:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63b:	76 d4                	jbe    611 <free+0x19>
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 645:	76 ca                	jbe    611 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 647:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64a:	8b 40 04             	mov    0x4(%eax),%eax
 64d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 654:	8b 45 f8             	mov    -0x8(%ebp),%eax
 657:	01 c2                	add    %eax,%edx
 659:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65c:	8b 00                	mov    (%eax),%eax
 65e:	39 c2                	cmp    %eax,%edx
 660:	75 24                	jne    686 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	8b 50 04             	mov    0x4(%eax),%edx
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 00                	mov    (%eax),%eax
 66d:	8b 40 04             	mov    0x4(%eax),%eax
 670:	01 c2                	add    %eax,%edx
 672:	8b 45 f8             	mov    -0x8(%ebp),%eax
 675:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 678:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67b:	8b 00                	mov    (%eax),%eax
 67d:	8b 10                	mov    (%eax),%edx
 67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 682:	89 10                	mov    %edx,(%eax)
 684:	eb 0a                	jmp    690 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 686:	8b 45 fc             	mov    -0x4(%ebp),%eax
 689:	8b 10                	mov    (%eax),%edx
 68b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 690:	8b 45 fc             	mov    -0x4(%ebp),%eax
 693:	8b 40 04             	mov    0x4(%eax),%eax
 696:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	01 d0                	add    %edx,%eax
 6a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a5:	75 20                	jne    6c7 <free+0xcf>
    p->s.size += bp->s.size;
 6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6aa:	8b 50 04             	mov    0x4(%eax),%edx
 6ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b0:	8b 40 04             	mov    0x4(%eax),%eax
 6b3:	01 c2                	add    %eax,%edx
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6bb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6be:	8b 10                	mov    (%eax),%edx
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	89 10                	mov    %edx,(%eax)
 6c5:	eb 08                	jmp    6cf <free+0xd7>
  } else
    p->s.ptr = bp;
 6c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ca:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6cd:	89 10                	mov    %edx,(%eax)
  freep = p;
 6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d2:	a3 08 0b 00 00       	mov    %eax,0xb08
}
 6d7:	90                   	nop
 6d8:	c9                   	leave  
 6d9:	c3                   	ret    

000006da <morecore>:

static Header*
morecore(uint nu)
{
 6da:	55                   	push   %ebp
 6db:	89 e5                	mov    %esp,%ebp
 6dd:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6e0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6e7:	77 07                	ja     6f0 <morecore+0x16>
    nu = 4096;
 6e9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6f0:	8b 45 08             	mov    0x8(%ebp),%eax
 6f3:	c1 e0 03             	shl    $0x3,%eax
 6f6:	83 ec 0c             	sub    $0xc,%esp
 6f9:	50                   	push   %eax
 6fa:	e8 59 fc ff ff       	call   358 <sbrk>
 6ff:	83 c4 10             	add    $0x10,%esp
 702:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 705:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 709:	75 07                	jne    712 <morecore+0x38>
    return 0;
 70b:	b8 00 00 00 00       	mov    $0x0,%eax
 710:	eb 26                	jmp    738 <morecore+0x5e>
  hp = (Header*)p;
 712:	8b 45 f4             	mov    -0xc(%ebp),%eax
 715:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 718:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71b:	8b 55 08             	mov    0x8(%ebp),%edx
 71e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 721:	8b 45 f0             	mov    -0x10(%ebp),%eax
 724:	83 c0 08             	add    $0x8,%eax
 727:	83 ec 0c             	sub    $0xc,%esp
 72a:	50                   	push   %eax
 72b:	e8 c8 fe ff ff       	call   5f8 <free>
 730:	83 c4 10             	add    $0x10,%esp
  return freep;
 733:	a1 08 0b 00 00       	mov    0xb08,%eax
}
 738:	c9                   	leave  
 739:	c3                   	ret    

0000073a <malloc>:

void*
malloc(uint nbytes)
{
 73a:	55                   	push   %ebp
 73b:	89 e5                	mov    %esp,%ebp
 73d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 740:	8b 45 08             	mov    0x8(%ebp),%eax
 743:	83 c0 07             	add    $0x7,%eax
 746:	c1 e8 03             	shr    $0x3,%eax
 749:	83 c0 01             	add    $0x1,%eax
 74c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 74f:	a1 08 0b 00 00       	mov    0xb08,%eax
 754:	89 45 f0             	mov    %eax,-0x10(%ebp)
 757:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 75b:	75 23                	jne    780 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 75d:	c7 45 f0 00 0b 00 00 	movl   $0xb00,-0x10(%ebp)
 764:	8b 45 f0             	mov    -0x10(%ebp),%eax
 767:	a3 08 0b 00 00       	mov    %eax,0xb08
 76c:	a1 08 0b 00 00       	mov    0xb08,%eax
 771:	a3 00 0b 00 00       	mov    %eax,0xb00
    base.s.size = 0;
 776:	c7 05 04 0b 00 00 00 	movl   $0x0,0xb04
 77d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 780:	8b 45 f0             	mov    -0x10(%ebp),%eax
 783:	8b 00                	mov    (%eax),%eax
 785:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 788:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78b:	8b 40 04             	mov    0x4(%eax),%eax
 78e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 791:	72 4d                	jb     7e0 <malloc+0xa6>
      if(p->s.size == nunits)
 793:	8b 45 f4             	mov    -0xc(%ebp),%eax
 796:	8b 40 04             	mov    0x4(%eax),%eax
 799:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 79c:	75 0c                	jne    7aa <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 79e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a1:	8b 10                	mov    (%eax),%edx
 7a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a6:	89 10                	mov    %edx,(%eax)
 7a8:	eb 26                	jmp    7d0 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ad:	8b 40 04             	mov    0x4(%eax),%eax
 7b0:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b3:	89 c2                	mov    %eax,%edx
 7b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	8b 40 04             	mov    0x4(%eax),%eax
 7c1:	c1 e0 03             	shl    $0x3,%eax
 7c4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ca:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7cd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d3:	a3 08 0b 00 00       	mov    %eax,0xb08
      return (void*)(p + 1);
 7d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7db:	83 c0 08             	add    $0x8,%eax
 7de:	eb 3b                	jmp    81b <malloc+0xe1>
    }
    if(p == freep)
 7e0:	a1 08 0b 00 00       	mov    0xb08,%eax
 7e5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7e8:	75 1e                	jne    808 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7ea:	83 ec 0c             	sub    $0xc,%esp
 7ed:	ff 75 ec             	pushl  -0x14(%ebp)
 7f0:	e8 e5 fe ff ff       	call   6da <morecore>
 7f5:	83 c4 10             	add    $0x10,%esp
 7f8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7fb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7ff:	75 07                	jne    808 <malloc+0xce>
        return 0;
 801:	b8 00 00 00 00       	mov    $0x0,%eax
 806:	eb 13                	jmp    81b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 80e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 811:	8b 00                	mov    (%eax),%eax
 813:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 816:	e9 6d ff ff ff       	jmp    788 <malloc+0x4e>
}
 81b:	c9                   	leave  
 81c:	c3                   	ret    
