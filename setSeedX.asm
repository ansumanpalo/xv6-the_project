
_setSeedX:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  11:	89 c8                	mov    %ecx,%eax

  setSeedX(atoi(argv[1]));
  13:	8b 40 04             	mov    0x4(%eax),%eax
  16:	83 c0 04             	add    $0x4,%eax
  19:	8b 00                	mov    (%eax),%eax
  1b:	83 ec 0c             	sub    $0xc,%esp
  1e:	50                   	push   %eax
  1f:	e8 d9 01 00 00       	call   1fd <atoi>
  24:	83 c4 10             	add    $0x10,%esp
  27:	83 ec 0c             	sub    $0xc,%esp
  2a:	50                   	push   %eax
  2b:	e8 58 03 00 00       	call   388 <setSeedX>
  30:	83 c4 10             	add    $0x10,%esp
  exit();
  33:	e8 a8 02 00 00       	call   2e0 <exit>

00000038 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  38:	55                   	push   %ebp
  39:	89 e5                	mov    %esp,%ebp
  3b:	57                   	push   %edi
  3c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  3d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  40:	8b 55 10             	mov    0x10(%ebp),%edx
  43:	8b 45 0c             	mov    0xc(%ebp),%eax
  46:	89 cb                	mov    %ecx,%ebx
  48:	89 df                	mov    %ebx,%edi
  4a:	89 d1                	mov    %edx,%ecx
  4c:	fc                   	cld    
  4d:	f3 aa                	rep stos %al,%es:(%edi)
  4f:	89 ca                	mov    %ecx,%edx
  51:	89 fb                	mov    %edi,%ebx
  53:	89 5d 08             	mov    %ebx,0x8(%ebp)
  56:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  59:	90                   	nop
  5a:	5b                   	pop    %ebx
  5b:	5f                   	pop    %edi
  5c:	5d                   	pop    %ebp
  5d:	c3                   	ret    

0000005e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  5e:	55                   	push   %ebp
  5f:	89 e5                	mov    %esp,%ebp
  61:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  6a:	90                   	nop
  6b:	8b 45 08             	mov    0x8(%ebp),%eax
  6e:	8d 50 01             	lea    0x1(%eax),%edx
  71:	89 55 08             	mov    %edx,0x8(%ebp)
  74:	8b 55 0c             	mov    0xc(%ebp),%edx
  77:	8d 4a 01             	lea    0x1(%edx),%ecx
  7a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  7d:	0f b6 12             	movzbl (%edx),%edx
  80:	88 10                	mov    %dl,(%eax)
  82:	0f b6 00             	movzbl (%eax),%eax
  85:	84 c0                	test   %al,%al
  87:	75 e2                	jne    6b <strcpy+0xd>
    ;
  return os;
  89:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8c:	c9                   	leave  
  8d:	c3                   	ret    

0000008e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8e:	55                   	push   %ebp
  8f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  91:	eb 08                	jmp    9b <strcmp+0xd>
    p++, q++;
  93:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  97:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  9b:	8b 45 08             	mov    0x8(%ebp),%eax
  9e:	0f b6 00             	movzbl (%eax),%eax
  a1:	84 c0                	test   %al,%al
  a3:	74 10                	je     b5 <strcmp+0x27>
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	0f b6 10             	movzbl (%eax),%edx
  ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  ae:	0f b6 00             	movzbl (%eax),%eax
  b1:	38 c2                	cmp    %al,%dl
  b3:	74 de                	je     93 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  b5:	8b 45 08             	mov    0x8(%ebp),%eax
  b8:	0f b6 00             	movzbl (%eax),%eax
  bb:	0f b6 d0             	movzbl %al,%edx
  be:	8b 45 0c             	mov    0xc(%ebp),%eax
  c1:	0f b6 00             	movzbl (%eax),%eax
  c4:	0f b6 c0             	movzbl %al,%eax
  c7:	29 c2                	sub    %eax,%edx
  c9:	89 d0                	mov    %edx,%eax
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    

000000cd <strlen>:

uint
strlen(char *s)
{
  cd:	55                   	push   %ebp
  ce:	89 e5                	mov    %esp,%ebp
  d0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  da:	eb 04                	jmp    e0 <strlen+0x13>
  dc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	01 d0                	add    %edx,%eax
  e8:	0f b6 00             	movzbl (%eax),%eax
  eb:	84 c0                	test   %al,%al
  ed:	75 ed                	jne    dc <strlen+0xf>
    ;
  return n;
  ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f2:	c9                   	leave  
  f3:	c3                   	ret    

000000f4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  f7:	8b 45 10             	mov    0x10(%ebp),%eax
  fa:	50                   	push   %eax
  fb:	ff 75 0c             	pushl  0xc(%ebp)
  fe:	ff 75 08             	pushl  0x8(%ebp)
 101:	e8 32 ff ff ff       	call   38 <stosb>
 106:	83 c4 0c             	add    $0xc,%esp
  return dst;
 109:	8b 45 08             	mov    0x8(%ebp),%eax
}
 10c:	c9                   	leave  
 10d:	c3                   	ret    

0000010e <strchr>:

char*
strchr(const char *s, char c)
{
 10e:	55                   	push   %ebp
 10f:	89 e5                	mov    %esp,%ebp
 111:	83 ec 04             	sub    $0x4,%esp
 114:	8b 45 0c             	mov    0xc(%ebp),%eax
 117:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 11a:	eb 14                	jmp    130 <strchr+0x22>
    if(*s == c)
 11c:	8b 45 08             	mov    0x8(%ebp),%eax
 11f:	0f b6 00             	movzbl (%eax),%eax
 122:	3a 45 fc             	cmp    -0x4(%ebp),%al
 125:	75 05                	jne    12c <strchr+0x1e>
      return (char*)s;
 127:	8b 45 08             	mov    0x8(%ebp),%eax
 12a:	eb 13                	jmp    13f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 12c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 130:	8b 45 08             	mov    0x8(%ebp),%eax
 133:	0f b6 00             	movzbl (%eax),%eax
 136:	84 c0                	test   %al,%al
 138:	75 e2                	jne    11c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 13a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 13f:	c9                   	leave  
 140:	c3                   	ret    

00000141 <gets>:

char*
gets(char *buf, int max)
{
 141:	55                   	push   %ebp
 142:	89 e5                	mov    %esp,%ebp
 144:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 147:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 14e:	eb 42                	jmp    192 <gets+0x51>
    cc = read(0, &c, 1);
 150:	83 ec 04             	sub    $0x4,%esp
 153:	6a 01                	push   $0x1
 155:	8d 45 ef             	lea    -0x11(%ebp),%eax
 158:	50                   	push   %eax
 159:	6a 00                	push   $0x0
 15b:	e8 98 01 00 00       	call   2f8 <read>
 160:	83 c4 10             	add    $0x10,%esp
 163:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 166:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16a:	7e 33                	jle    19f <gets+0x5e>
      break;
    buf[i++] = c;
 16c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16f:	8d 50 01             	lea    0x1(%eax),%edx
 172:	89 55 f4             	mov    %edx,-0xc(%ebp)
 175:	89 c2                	mov    %eax,%edx
 177:	8b 45 08             	mov    0x8(%ebp),%eax
 17a:	01 c2                	add    %eax,%edx
 17c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 180:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 182:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 186:	3c 0a                	cmp    $0xa,%al
 188:	74 16                	je     1a0 <gets+0x5f>
 18a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 18e:	3c 0d                	cmp    $0xd,%al
 190:	74 0e                	je     1a0 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 192:	8b 45 f4             	mov    -0xc(%ebp),%eax
 195:	83 c0 01             	add    $0x1,%eax
 198:	3b 45 0c             	cmp    0xc(%ebp),%eax
 19b:	7c b3                	jl     150 <gets+0xf>
 19d:	eb 01                	jmp    1a0 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 19f:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1a0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	01 d0                	add    %edx,%eax
 1a8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ae:	c9                   	leave  
 1af:	c3                   	ret    

000001b0 <stat>:

int
stat(char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b6:	83 ec 08             	sub    $0x8,%esp
 1b9:	6a 00                	push   $0x0
 1bb:	ff 75 08             	pushl  0x8(%ebp)
 1be:	e8 5d 01 00 00       	call   320 <open>
 1c3:	83 c4 10             	add    $0x10,%esp
 1c6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1c9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1cd:	79 07                	jns    1d6 <stat+0x26>
    return -1;
 1cf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d4:	eb 25                	jmp    1fb <stat+0x4b>
  r = fstat(fd, st);
 1d6:	83 ec 08             	sub    $0x8,%esp
 1d9:	ff 75 0c             	pushl  0xc(%ebp)
 1dc:	ff 75 f4             	pushl  -0xc(%ebp)
 1df:	e8 54 01 00 00       	call   338 <fstat>
 1e4:	83 c4 10             	add    $0x10,%esp
 1e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1ea:	83 ec 0c             	sub    $0xc,%esp
 1ed:	ff 75 f4             	pushl  -0xc(%ebp)
 1f0:	e8 13 01 00 00       	call   308 <close>
 1f5:	83 c4 10             	add    $0x10,%esp
  return r;
 1f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1fb:	c9                   	leave  
 1fc:	c3                   	ret    

000001fd <atoi>:

int
atoi(const char *s)
{
 1fd:	55                   	push   %ebp
 1fe:	89 e5                	mov    %esp,%ebp
 200:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 203:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 20a:	eb 25                	jmp    231 <atoi+0x34>
    n = n*10 + *s++ - '0';
 20c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 20f:	89 d0                	mov    %edx,%eax
 211:	c1 e0 02             	shl    $0x2,%eax
 214:	01 d0                	add    %edx,%eax
 216:	01 c0                	add    %eax,%eax
 218:	89 c1                	mov    %eax,%ecx
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	8d 50 01             	lea    0x1(%eax),%edx
 220:	89 55 08             	mov    %edx,0x8(%ebp)
 223:	0f b6 00             	movzbl (%eax),%eax
 226:	0f be c0             	movsbl %al,%eax
 229:	01 c8                	add    %ecx,%eax
 22b:	83 e8 30             	sub    $0x30,%eax
 22e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	0f b6 00             	movzbl (%eax),%eax
 237:	3c 2f                	cmp    $0x2f,%al
 239:	7e 0a                	jle    245 <atoi+0x48>
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	0f b6 00             	movzbl (%eax),%eax
 241:	3c 39                	cmp    $0x39,%al
 243:	7e c7                	jle    20c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 245:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 248:	c9                   	leave  
 249:	c3                   	ret    

0000024a <itoa>:

char*
itoa(int val, int base){
 24a:	55                   	push   %ebp
 24b:	89 e5                	mov    %esp,%ebp
 24d:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 250:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 257:	eb 29                	jmp    282 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 259:	8b 45 08             	mov    0x8(%ebp),%eax
 25c:	99                   	cltd   
 25d:	f7 7d 0c             	idivl  0xc(%ebp)
 260:	89 d0                	mov    %edx,%eax
 262:	0f b6 80 2d 08 00 00 	movzbl 0x82d(%eax),%eax
 269:	8b 55 fc             	mov    -0x4(%ebp),%edx
 26c:	81 c2 e0 0a 00 00    	add    $0xae0,%edx
 272:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 274:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 278:	8b 45 08             	mov    0x8(%ebp),%eax
 27b:	99                   	cltd   
 27c:	f7 7d 0c             	idivl  0xc(%ebp)
 27f:	89 45 08             	mov    %eax,0x8(%ebp)
 282:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 286:	74 06                	je     28e <itoa+0x44>
 288:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 28c:	75 cb                	jne    259 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 28e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 291:	83 c0 01             	add    $0x1,%eax
 294:	05 e0 0a 00 00       	add    $0xae0,%eax

}
 299:	c9                   	leave  
 29a:	c3                   	ret    

0000029b <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 29b:	55                   	push   %ebp
 29c:	89 e5                	mov    %esp,%ebp
 29e:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2ad:	eb 17                	jmp    2c6 <memmove+0x2b>
    *dst++ = *src++;
 2af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b2:	8d 50 01             	lea    0x1(%eax),%edx
 2b5:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2b8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2bb:	8d 4a 01             	lea    0x1(%edx),%ecx
 2be:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2c1:	0f b6 12             	movzbl (%edx),%edx
 2c4:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c6:	8b 45 10             	mov    0x10(%ebp),%eax
 2c9:	8d 50 ff             	lea    -0x1(%eax),%edx
 2cc:	89 55 10             	mov    %edx,0x10(%ebp)
 2cf:	85 c0                	test   %eax,%eax
 2d1:	7f dc                	jg     2af <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d6:	c9                   	leave  
 2d7:	c3                   	ret    

000002d8 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d8:	b8 01 00 00 00       	mov    $0x1,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <exit>:
SYSCALL(exit)
 2e0:	b8 02 00 00 00       	mov    $0x2,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <wait>:
SYSCALL(wait)
 2e8:	b8 03 00 00 00       	mov    $0x3,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <pipe>:
SYSCALL(pipe)
 2f0:	b8 04 00 00 00       	mov    $0x4,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <read>:
SYSCALL(read)
 2f8:	b8 05 00 00 00       	mov    $0x5,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <write>:
SYSCALL(write)
 300:	b8 10 00 00 00       	mov    $0x10,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <close>:
SYSCALL(close)
 308:	b8 15 00 00 00       	mov    $0x15,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <kill>:
SYSCALL(kill)
 310:	b8 06 00 00 00       	mov    $0x6,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <exec>:
SYSCALL(exec)
 318:	b8 07 00 00 00       	mov    $0x7,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <open>:
SYSCALL(open)
 320:	b8 0f 00 00 00       	mov    $0xf,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <mknod>:
SYSCALL(mknod)
 328:	b8 11 00 00 00       	mov    $0x11,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <unlink>:
SYSCALL(unlink)
 330:	b8 12 00 00 00       	mov    $0x12,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <fstat>:
SYSCALL(fstat)
 338:	b8 08 00 00 00       	mov    $0x8,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <link>:
SYSCALL(link)
 340:	b8 13 00 00 00       	mov    $0x13,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <mkdir>:
SYSCALL(mkdir)
 348:	b8 14 00 00 00       	mov    $0x14,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <chdir>:
SYSCALL(chdir)
 350:	b8 09 00 00 00       	mov    $0x9,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <dup>:
SYSCALL(dup)
 358:	b8 0a 00 00 00       	mov    $0xa,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <getpid>:
SYSCALL(getpid)
 360:	b8 0b 00 00 00       	mov    $0xb,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <sbrk>:
SYSCALL(sbrk)
 368:	b8 0c 00 00 00       	mov    $0xc,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <sleep>:
SYSCALL(sleep)
 370:	b8 0d 00 00 00       	mov    $0xd,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <uptime>:
SYSCALL(uptime)
 378:	b8 0e 00 00 00       	mov    $0xe,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <randomX>:
SYSCALL(randomX)
 380:	b8 16 00 00 00       	mov    $0x16,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <setSeedX>:
SYSCALL(setSeedX)
 388:	b8 17 00 00 00       	mov    $0x17,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <uniformR>:
SYSCALL(uniformR)
 390:	b8 18 00 00 00       	mov    $0x18,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <setdeadline>:
 398:	b8 19 00 00 00       	mov    $0x19,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	83 ec 18             	sub    $0x18,%esp
 3a6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3ac:	83 ec 04             	sub    $0x4,%esp
 3af:	6a 01                	push   $0x1
 3b1:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3b4:	50                   	push   %eax
 3b5:	ff 75 08             	pushl  0x8(%ebp)
 3b8:	e8 43 ff ff ff       	call   300 <write>
 3bd:	83 c4 10             	add    $0x10,%esp
}
 3c0:	90                   	nop
 3c1:	c9                   	leave  
 3c2:	c3                   	ret    

000003c3 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c3:	55                   	push   %ebp
 3c4:	89 e5                	mov    %esp,%ebp
 3c6:	53                   	push   %ebx
 3c7:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3d1:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3d5:	74 17                	je     3ee <printint+0x2b>
 3d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3db:	79 11                	jns    3ee <printint+0x2b>
    neg = 1;
 3dd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e7:	f7 d8                	neg    %eax
 3e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ec:	eb 06                	jmp    3f4 <printint+0x31>
  } else {
    x = xx;
 3ee:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3fb:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3fe:	8d 41 01             	lea    0x1(%ecx),%eax
 401:	89 45 f4             	mov    %eax,-0xc(%ebp)
 404:	8b 5d 10             	mov    0x10(%ebp),%ebx
 407:	8b 45 ec             	mov    -0x14(%ebp),%eax
 40a:	ba 00 00 00 00       	mov    $0x0,%edx
 40f:	f7 f3                	div    %ebx
 411:	89 d0                	mov    %edx,%eax
 413:	0f b6 80 b0 0a 00 00 	movzbl 0xab0(%eax),%eax
 41a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 41e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 421:	8b 45 ec             	mov    -0x14(%ebp),%eax
 424:	ba 00 00 00 00       	mov    $0x0,%edx
 429:	f7 f3                	div    %ebx
 42b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 42e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 432:	75 c7                	jne    3fb <printint+0x38>
  if(neg)
 434:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 438:	74 2d                	je     467 <printint+0xa4>
    buf[i++] = '-';
 43a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43d:	8d 50 01             	lea    0x1(%eax),%edx
 440:	89 55 f4             	mov    %edx,-0xc(%ebp)
 443:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 448:	eb 1d                	jmp    467 <printint+0xa4>
    putc(fd, buf[i]);
 44a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 44d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 450:	01 d0                	add    %edx,%eax
 452:	0f b6 00             	movzbl (%eax),%eax
 455:	0f be c0             	movsbl %al,%eax
 458:	83 ec 08             	sub    $0x8,%esp
 45b:	50                   	push   %eax
 45c:	ff 75 08             	pushl  0x8(%ebp)
 45f:	e8 3c ff ff ff       	call   3a0 <putc>
 464:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 467:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 46b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 46f:	79 d9                	jns    44a <printint+0x87>
    putc(fd, buf[i]);
}
 471:	90                   	nop
 472:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 475:	c9                   	leave  
 476:	c3                   	ret    

00000477 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 477:	55                   	push   %ebp
 478:	89 e5                	mov    %esp,%ebp
 47a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 47d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 484:	8d 45 0c             	lea    0xc(%ebp),%eax
 487:	83 c0 04             	add    $0x4,%eax
 48a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 48d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 494:	e9 59 01 00 00       	jmp    5f2 <printf+0x17b>
    c = fmt[i] & 0xff;
 499:	8b 55 0c             	mov    0xc(%ebp),%edx
 49c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 49f:	01 d0                	add    %edx,%eax
 4a1:	0f b6 00             	movzbl (%eax),%eax
 4a4:	0f be c0             	movsbl %al,%eax
 4a7:	25 ff 00 00 00       	and    $0xff,%eax
 4ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4b3:	75 2c                	jne    4e1 <printf+0x6a>
      if(c == '%'){
 4b5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4b9:	75 0c                	jne    4c7 <printf+0x50>
        state = '%';
 4bb:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4c2:	e9 27 01 00 00       	jmp    5ee <printf+0x177>
      } else {
        putc(fd, c);
 4c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ca:	0f be c0             	movsbl %al,%eax
 4cd:	83 ec 08             	sub    $0x8,%esp
 4d0:	50                   	push   %eax
 4d1:	ff 75 08             	pushl  0x8(%ebp)
 4d4:	e8 c7 fe ff ff       	call   3a0 <putc>
 4d9:	83 c4 10             	add    $0x10,%esp
 4dc:	e9 0d 01 00 00       	jmp    5ee <printf+0x177>
      }
    } else if(state == '%'){
 4e1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4e5:	0f 85 03 01 00 00    	jne    5ee <printf+0x177>
      if(c == 'd'){
 4eb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ef:	75 1e                	jne    50f <printf+0x98>
        printint(fd, *ap, 10, 1);
 4f1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f4:	8b 00                	mov    (%eax),%eax
 4f6:	6a 01                	push   $0x1
 4f8:	6a 0a                	push   $0xa
 4fa:	50                   	push   %eax
 4fb:	ff 75 08             	pushl  0x8(%ebp)
 4fe:	e8 c0 fe ff ff       	call   3c3 <printint>
 503:	83 c4 10             	add    $0x10,%esp
        ap++;
 506:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 50a:	e9 d8 00 00 00       	jmp    5e7 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 50f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 513:	74 06                	je     51b <printf+0xa4>
 515:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 519:	75 1e                	jne    539 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 51b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51e:	8b 00                	mov    (%eax),%eax
 520:	6a 00                	push   $0x0
 522:	6a 10                	push   $0x10
 524:	50                   	push   %eax
 525:	ff 75 08             	pushl  0x8(%ebp)
 528:	e8 96 fe ff ff       	call   3c3 <printint>
 52d:	83 c4 10             	add    $0x10,%esp
        ap++;
 530:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 534:	e9 ae 00 00 00       	jmp    5e7 <printf+0x170>
      } else if(c == 's'){
 539:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 53d:	75 43                	jne    582 <printf+0x10b>
        s = (char*)*ap;
 53f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 542:	8b 00                	mov    (%eax),%eax
 544:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 547:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 54b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 54f:	75 25                	jne    576 <printf+0xff>
          s = "(null)";
 551:	c7 45 f4 3e 08 00 00 	movl   $0x83e,-0xc(%ebp)
        while(*s != 0){
 558:	eb 1c                	jmp    576 <printf+0xff>
          putc(fd, *s);
 55a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 55d:	0f b6 00             	movzbl (%eax),%eax
 560:	0f be c0             	movsbl %al,%eax
 563:	83 ec 08             	sub    $0x8,%esp
 566:	50                   	push   %eax
 567:	ff 75 08             	pushl  0x8(%ebp)
 56a:	e8 31 fe ff ff       	call   3a0 <putc>
 56f:	83 c4 10             	add    $0x10,%esp
          s++;
 572:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 576:	8b 45 f4             	mov    -0xc(%ebp),%eax
 579:	0f b6 00             	movzbl (%eax),%eax
 57c:	84 c0                	test   %al,%al
 57e:	75 da                	jne    55a <printf+0xe3>
 580:	eb 65                	jmp    5e7 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 582:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 586:	75 1d                	jne    5a5 <printf+0x12e>
        putc(fd, *ap);
 588:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58b:	8b 00                	mov    (%eax),%eax
 58d:	0f be c0             	movsbl %al,%eax
 590:	83 ec 08             	sub    $0x8,%esp
 593:	50                   	push   %eax
 594:	ff 75 08             	pushl  0x8(%ebp)
 597:	e8 04 fe ff ff       	call   3a0 <putc>
 59c:	83 c4 10             	add    $0x10,%esp
        ap++;
 59f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5a3:	eb 42                	jmp    5e7 <printf+0x170>
      } else if(c == '%'){
 5a5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5a9:	75 17                	jne    5c2 <printf+0x14b>
        putc(fd, c);
 5ab:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ae:	0f be c0             	movsbl %al,%eax
 5b1:	83 ec 08             	sub    $0x8,%esp
 5b4:	50                   	push   %eax
 5b5:	ff 75 08             	pushl  0x8(%ebp)
 5b8:	e8 e3 fd ff ff       	call   3a0 <putc>
 5bd:	83 c4 10             	add    $0x10,%esp
 5c0:	eb 25                	jmp    5e7 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5c2:	83 ec 08             	sub    $0x8,%esp
 5c5:	6a 25                	push   $0x25
 5c7:	ff 75 08             	pushl  0x8(%ebp)
 5ca:	e8 d1 fd ff ff       	call   3a0 <putc>
 5cf:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d5:	0f be c0             	movsbl %al,%eax
 5d8:	83 ec 08             	sub    $0x8,%esp
 5db:	50                   	push   %eax
 5dc:	ff 75 08             	pushl  0x8(%ebp)
 5df:	e8 bc fd ff ff       	call   3a0 <putc>
 5e4:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5e7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ee:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5f2:	8b 55 0c             	mov    0xc(%ebp),%edx
 5f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5f8:	01 d0                	add    %edx,%eax
 5fa:	0f b6 00             	movzbl (%eax),%eax
 5fd:	84 c0                	test   %al,%al
 5ff:	0f 85 94 fe ff ff    	jne    499 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 605:	90                   	nop
 606:	c9                   	leave  
 607:	c3                   	ret    

00000608 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 608:	55                   	push   %ebp
 609:	89 e5                	mov    %esp,%ebp
 60b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 60e:	8b 45 08             	mov    0x8(%ebp),%eax
 611:	83 e8 08             	sub    $0x8,%eax
 614:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 617:	a1 08 0b 00 00       	mov    0xb08,%eax
 61c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 61f:	eb 24                	jmp    645 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 629:	77 12                	ja     63d <free+0x35>
 62b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 631:	77 24                	ja     657 <free+0x4f>
 633:	8b 45 fc             	mov    -0x4(%ebp),%eax
 636:	8b 00                	mov    (%eax),%eax
 638:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 63b:	77 1a                	ja     657 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 00                	mov    (%eax),%eax
 642:	89 45 fc             	mov    %eax,-0x4(%ebp)
 645:	8b 45 f8             	mov    -0x8(%ebp),%eax
 648:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 64b:	76 d4                	jbe    621 <free+0x19>
 64d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 650:	8b 00                	mov    (%eax),%eax
 652:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 655:	76 ca                	jbe    621 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 657:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65a:	8b 40 04             	mov    0x4(%eax),%eax
 65d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 664:	8b 45 f8             	mov    -0x8(%ebp),%eax
 667:	01 c2                	add    %eax,%edx
 669:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66c:	8b 00                	mov    (%eax),%eax
 66e:	39 c2                	cmp    %eax,%edx
 670:	75 24                	jne    696 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 672:	8b 45 f8             	mov    -0x8(%ebp),%eax
 675:	8b 50 04             	mov    0x4(%eax),%edx
 678:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67b:	8b 00                	mov    (%eax),%eax
 67d:	8b 40 04             	mov    0x4(%eax),%eax
 680:	01 c2                	add    %eax,%edx
 682:	8b 45 f8             	mov    -0x8(%ebp),%eax
 685:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	8b 00                	mov    (%eax),%eax
 68d:	8b 10                	mov    (%eax),%edx
 68f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 692:	89 10                	mov    %edx,(%eax)
 694:	eb 0a                	jmp    6a0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	8b 10                	mov    (%eax),%edx
 69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a3:	8b 40 04             	mov    0x4(%eax),%eax
 6a6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	01 d0                	add    %edx,%eax
 6b2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6b5:	75 20                	jne    6d7 <free+0xcf>
    p->s.size += bp->s.size;
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 50 04             	mov    0x4(%eax),%edx
 6bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c0:	8b 40 04             	mov    0x4(%eax),%eax
 6c3:	01 c2                	add    %eax,%edx
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ce:	8b 10                	mov    (%eax),%edx
 6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d3:	89 10                	mov    %edx,(%eax)
 6d5:	eb 08                	jmp    6df <free+0xd7>
  } else
    p->s.ptr = bp;
 6d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6da:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6dd:	89 10                	mov    %edx,(%eax)
  freep = p;
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	a3 08 0b 00 00       	mov    %eax,0xb08
}
 6e7:	90                   	nop
 6e8:	c9                   	leave  
 6e9:	c3                   	ret    

000006ea <morecore>:

static Header*
morecore(uint nu)
{
 6ea:	55                   	push   %ebp
 6eb:	89 e5                	mov    %esp,%ebp
 6ed:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6f0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6f7:	77 07                	ja     700 <morecore+0x16>
    nu = 4096;
 6f9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 700:	8b 45 08             	mov    0x8(%ebp),%eax
 703:	c1 e0 03             	shl    $0x3,%eax
 706:	83 ec 0c             	sub    $0xc,%esp
 709:	50                   	push   %eax
 70a:	e8 59 fc ff ff       	call   368 <sbrk>
 70f:	83 c4 10             	add    $0x10,%esp
 712:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 715:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 719:	75 07                	jne    722 <morecore+0x38>
    return 0;
 71b:	b8 00 00 00 00       	mov    $0x0,%eax
 720:	eb 26                	jmp    748 <morecore+0x5e>
  hp = (Header*)p;
 722:	8b 45 f4             	mov    -0xc(%ebp),%eax
 725:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 728:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72b:	8b 55 08             	mov    0x8(%ebp),%edx
 72e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 731:	8b 45 f0             	mov    -0x10(%ebp),%eax
 734:	83 c0 08             	add    $0x8,%eax
 737:	83 ec 0c             	sub    $0xc,%esp
 73a:	50                   	push   %eax
 73b:	e8 c8 fe ff ff       	call   608 <free>
 740:	83 c4 10             	add    $0x10,%esp
  return freep;
 743:	a1 08 0b 00 00       	mov    0xb08,%eax
}
 748:	c9                   	leave  
 749:	c3                   	ret    

0000074a <malloc>:

void*
malloc(uint nbytes)
{
 74a:	55                   	push   %ebp
 74b:	89 e5                	mov    %esp,%ebp
 74d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 750:	8b 45 08             	mov    0x8(%ebp),%eax
 753:	83 c0 07             	add    $0x7,%eax
 756:	c1 e8 03             	shr    $0x3,%eax
 759:	83 c0 01             	add    $0x1,%eax
 75c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 75f:	a1 08 0b 00 00       	mov    0xb08,%eax
 764:	89 45 f0             	mov    %eax,-0x10(%ebp)
 767:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 76b:	75 23                	jne    790 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 76d:	c7 45 f0 00 0b 00 00 	movl   $0xb00,-0x10(%ebp)
 774:	8b 45 f0             	mov    -0x10(%ebp),%eax
 777:	a3 08 0b 00 00       	mov    %eax,0xb08
 77c:	a1 08 0b 00 00       	mov    0xb08,%eax
 781:	a3 00 0b 00 00       	mov    %eax,0xb00
    base.s.size = 0;
 786:	c7 05 04 0b 00 00 00 	movl   $0x0,0xb04
 78d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 790:	8b 45 f0             	mov    -0x10(%ebp),%eax
 793:	8b 00                	mov    (%eax),%eax
 795:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 798:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79b:	8b 40 04             	mov    0x4(%eax),%eax
 79e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7a1:	72 4d                	jb     7f0 <malloc+0xa6>
      if(p->s.size == nunits)
 7a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a6:	8b 40 04             	mov    0x4(%eax),%eax
 7a9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ac:	75 0c                	jne    7ba <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	8b 10                	mov    (%eax),%edx
 7b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b6:	89 10                	mov    %edx,(%eax)
 7b8:	eb 26                	jmp    7e0 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bd:	8b 40 04             	mov    0x4(%eax),%eax
 7c0:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7c3:	89 c2                	mov    %eax,%edx
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ce:	8b 40 04             	mov    0x4(%eax),%eax
 7d1:	c1 e0 03             	shl    $0x3,%eax
 7d4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7da:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7dd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e3:	a3 08 0b 00 00       	mov    %eax,0xb08
      return (void*)(p + 1);
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	83 c0 08             	add    $0x8,%eax
 7ee:	eb 3b                	jmp    82b <malloc+0xe1>
    }
    if(p == freep)
 7f0:	a1 08 0b 00 00       	mov    0xb08,%eax
 7f5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7f8:	75 1e                	jne    818 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7fa:	83 ec 0c             	sub    $0xc,%esp
 7fd:	ff 75 ec             	pushl  -0x14(%ebp)
 800:	e8 e5 fe ff ff       	call   6ea <morecore>
 805:	83 c4 10             	add    $0x10,%esp
 808:	89 45 f4             	mov    %eax,-0xc(%ebp)
 80b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 80f:	75 07                	jne    818 <malloc+0xce>
        return 0;
 811:	b8 00 00 00 00       	mov    $0x0,%eax
 816:	eb 13                	jmp    82b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 818:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 821:	8b 00                	mov    (%eax),%eax
 823:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 826:	e9 6d ff ff ff       	jmp    798 <malloc+0x4e>
}
 82b:	c9                   	leave  
 82c:	c3                   	ret    
