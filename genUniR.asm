
_genUniR:     file format elf32-i386


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
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
    int a = atoi(argv[1]), b = atoi(argv[2]);
  14:	8b 43 04             	mov    0x4(%ebx),%eax
  17:	83 c0 04             	add    $0x4,%eax
  1a:	8b 00                	mov    (%eax),%eax
  1c:	83 ec 0c             	sub    $0xc,%esp
  1f:	50                   	push   %eax
  20:	e8 23 02 00 00       	call   248 <atoi>
  25:	83 c4 10             	add    $0x10,%esp
  28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  2b:	8b 43 04             	mov    0x4(%ebx),%eax
  2e:	83 c0 08             	add    $0x8,%eax
  31:	8b 00                	mov    (%eax),%eax
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	50                   	push   %eax
  37:	e8 0c 02 00 00       	call   248 <atoi>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    int i;
    for(i=0; i< b-a; i++)
  42:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  49:	eb 28                	jmp    73 <main+0x73>
        printf(1,"%d \n",uniformR(a,b));
  4b:	83 ec 08             	sub    $0x8,%esp
  4e:	ff 75 ec             	pushl  -0x14(%ebp)
  51:	ff 75 f0             	pushl  -0x10(%ebp)
  54:	e8 31 03 00 00       	call   38a <uniformR>
  59:	83 c4 10             	add    $0x10,%esp
  5c:	83 ec 04             	sub    $0x4,%esp
  5f:	50                   	push   %eax
  60:	68 1f 08 00 00       	push   $0x81f
  65:	6a 01                	push   $0x1
  67:	e8 fd 03 00 00       	call   469 <printf>
  6c:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
    int a = atoi(argv[1]), b = atoi(argv[2]);
    int i;
    for(i=0; i< b-a; i++)
  6f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  73:	8b 45 ec             	mov    -0x14(%ebp),%eax
  76:	2b 45 f0             	sub    -0x10(%ebp),%eax
  79:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  7c:	7f cd                	jg     4b <main+0x4b>
        printf(1,"%d \n",uniformR(a,b));

    exit();
  7e:	e8 57 02 00 00       	call   2da <exit>

00000083 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  83:	55                   	push   %ebp
  84:	89 e5                	mov    %esp,%ebp
  86:	57                   	push   %edi
  87:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  88:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8b:	8b 55 10             	mov    0x10(%ebp),%edx
  8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  91:	89 cb                	mov    %ecx,%ebx
  93:	89 df                	mov    %ebx,%edi
  95:	89 d1                	mov    %edx,%ecx
  97:	fc                   	cld    
  98:	f3 aa                	rep stos %al,%es:(%edi)
  9a:	89 ca                	mov    %ecx,%edx
  9c:	89 fb                	mov    %edi,%ebx
  9e:	89 5d 08             	mov    %ebx,0x8(%ebp)
  a1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a4:	90                   	nop
  a5:	5b                   	pop    %ebx
  a6:	5f                   	pop    %edi
  a7:	5d                   	pop    %ebp
  a8:	c3                   	ret    

000000a9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a9:	55                   	push   %ebp
  aa:	89 e5                	mov    %esp,%ebp
  ac:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  af:	8b 45 08             	mov    0x8(%ebp),%eax
  b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  b5:	90                   	nop
  b6:	8b 45 08             	mov    0x8(%ebp),%eax
  b9:	8d 50 01             	lea    0x1(%eax),%edx
  bc:	89 55 08             	mov    %edx,0x8(%ebp)
  bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  c2:	8d 4a 01             	lea    0x1(%edx),%ecx
  c5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  c8:	0f b6 12             	movzbl (%edx),%edx
  cb:	88 10                	mov    %dl,(%eax)
  cd:	0f b6 00             	movzbl (%eax),%eax
  d0:	84 c0                	test   %al,%al
  d2:	75 e2                	jne    b6 <strcpy+0xd>
    ;
  return os;
  d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  d7:	c9                   	leave  
  d8:	c3                   	ret    

000000d9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d9:	55                   	push   %ebp
  da:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  dc:	eb 08                	jmp    e6 <strcmp+0xd>
    p++, q++;
  de:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e2:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	0f b6 00             	movzbl (%eax),%eax
  ec:	84 c0                	test   %al,%al
  ee:	74 10                	je     100 <strcmp+0x27>
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	0f b6 10             	movzbl (%eax),%edx
  f6:	8b 45 0c             	mov    0xc(%ebp),%eax
  f9:	0f b6 00             	movzbl (%eax),%eax
  fc:	38 c2                	cmp    %al,%dl
  fe:	74 de                	je     de <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 100:	8b 45 08             	mov    0x8(%ebp),%eax
 103:	0f b6 00             	movzbl (%eax),%eax
 106:	0f b6 d0             	movzbl %al,%edx
 109:	8b 45 0c             	mov    0xc(%ebp),%eax
 10c:	0f b6 00             	movzbl (%eax),%eax
 10f:	0f b6 c0             	movzbl %al,%eax
 112:	29 c2                	sub    %eax,%edx
 114:	89 d0                	mov    %edx,%eax
}
 116:	5d                   	pop    %ebp
 117:	c3                   	ret    

00000118 <strlen>:

uint
strlen(char *s)
{
 118:	55                   	push   %ebp
 119:	89 e5                	mov    %esp,%ebp
 11b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 11e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 125:	eb 04                	jmp    12b <strlen+0x13>
 127:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 12b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 12e:	8b 45 08             	mov    0x8(%ebp),%eax
 131:	01 d0                	add    %edx,%eax
 133:	0f b6 00             	movzbl (%eax),%eax
 136:	84 c0                	test   %al,%al
 138:	75 ed                	jne    127 <strlen+0xf>
    ;
  return n;
 13a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 13d:	c9                   	leave  
 13e:	c3                   	ret    

0000013f <memset>:

void*
memset(void *dst, int c, uint n)
{
 13f:	55                   	push   %ebp
 140:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 142:	8b 45 10             	mov    0x10(%ebp),%eax
 145:	50                   	push   %eax
 146:	ff 75 0c             	pushl  0xc(%ebp)
 149:	ff 75 08             	pushl  0x8(%ebp)
 14c:	e8 32 ff ff ff       	call   83 <stosb>
 151:	83 c4 0c             	add    $0xc,%esp
  return dst;
 154:	8b 45 08             	mov    0x8(%ebp),%eax
}
 157:	c9                   	leave  
 158:	c3                   	ret    

00000159 <strchr>:

char*
strchr(const char *s, char c)
{
 159:	55                   	push   %ebp
 15a:	89 e5                	mov    %esp,%ebp
 15c:	83 ec 04             	sub    $0x4,%esp
 15f:	8b 45 0c             	mov    0xc(%ebp),%eax
 162:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 165:	eb 14                	jmp    17b <strchr+0x22>
    if(*s == c)
 167:	8b 45 08             	mov    0x8(%ebp),%eax
 16a:	0f b6 00             	movzbl (%eax),%eax
 16d:	3a 45 fc             	cmp    -0x4(%ebp),%al
 170:	75 05                	jne    177 <strchr+0x1e>
      return (char*)s;
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	eb 13                	jmp    18a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 177:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	0f b6 00             	movzbl (%eax),%eax
 181:	84 c0                	test   %al,%al
 183:	75 e2                	jne    167 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 185:	b8 00 00 00 00       	mov    $0x0,%eax
}
 18a:	c9                   	leave  
 18b:	c3                   	ret    

0000018c <gets>:

char*
gets(char *buf, int max)
{
 18c:	55                   	push   %ebp
 18d:	89 e5                	mov    %esp,%ebp
 18f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 192:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 199:	eb 42                	jmp    1dd <gets+0x51>
    cc = read(0, &c, 1);
 19b:	83 ec 04             	sub    $0x4,%esp
 19e:	6a 01                	push   $0x1
 1a0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a3:	50                   	push   %eax
 1a4:	6a 00                	push   $0x0
 1a6:	e8 47 01 00 00       	call   2f2 <read>
 1ab:	83 c4 10             	add    $0x10,%esp
 1ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b5:	7e 33                	jle    1ea <gets+0x5e>
      break;
    buf[i++] = c;
 1b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ba:	8d 50 01             	lea    0x1(%eax),%edx
 1bd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1c0:	89 c2                	mov    %eax,%edx
 1c2:	8b 45 08             	mov    0x8(%ebp),%eax
 1c5:	01 c2                	add    %eax,%edx
 1c7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1cb:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1cd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d1:	3c 0a                	cmp    $0xa,%al
 1d3:	74 16                	je     1eb <gets+0x5f>
 1d5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d9:	3c 0d                	cmp    $0xd,%al
 1db:	74 0e                	je     1eb <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e0:	83 c0 01             	add    $0x1,%eax
 1e3:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1e6:	7c b3                	jl     19b <gets+0xf>
 1e8:	eb 01                	jmp    1eb <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1ea:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1ee:	8b 45 08             	mov    0x8(%ebp),%eax
 1f1:	01 d0                	add    %edx,%eax
 1f3:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1f6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f9:	c9                   	leave  
 1fa:	c3                   	ret    

000001fb <stat>:

int
stat(char *n, struct stat *st)
{
 1fb:	55                   	push   %ebp
 1fc:	89 e5                	mov    %esp,%ebp
 1fe:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 201:	83 ec 08             	sub    $0x8,%esp
 204:	6a 00                	push   $0x0
 206:	ff 75 08             	pushl  0x8(%ebp)
 209:	e8 0c 01 00 00       	call   31a <open>
 20e:	83 c4 10             	add    $0x10,%esp
 211:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 214:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 218:	79 07                	jns    221 <stat+0x26>
    return -1;
 21a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 21f:	eb 25                	jmp    246 <stat+0x4b>
  r = fstat(fd, st);
 221:	83 ec 08             	sub    $0x8,%esp
 224:	ff 75 0c             	pushl  0xc(%ebp)
 227:	ff 75 f4             	pushl  -0xc(%ebp)
 22a:	e8 03 01 00 00       	call   332 <fstat>
 22f:	83 c4 10             	add    $0x10,%esp
 232:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 235:	83 ec 0c             	sub    $0xc,%esp
 238:	ff 75 f4             	pushl  -0xc(%ebp)
 23b:	e8 c2 00 00 00       	call   302 <close>
 240:	83 c4 10             	add    $0x10,%esp
  return r;
 243:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 246:	c9                   	leave  
 247:	c3                   	ret    

00000248 <atoi>:

int
atoi(const char *s)
{
 248:	55                   	push   %ebp
 249:	89 e5                	mov    %esp,%ebp
 24b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 24e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 255:	eb 25                	jmp    27c <atoi+0x34>
    n = n*10 + *s++ - '0';
 257:	8b 55 fc             	mov    -0x4(%ebp),%edx
 25a:	89 d0                	mov    %edx,%eax
 25c:	c1 e0 02             	shl    $0x2,%eax
 25f:	01 d0                	add    %edx,%eax
 261:	01 c0                	add    %eax,%eax
 263:	89 c1                	mov    %eax,%ecx
 265:	8b 45 08             	mov    0x8(%ebp),%eax
 268:	8d 50 01             	lea    0x1(%eax),%edx
 26b:	89 55 08             	mov    %edx,0x8(%ebp)
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	0f be c0             	movsbl %al,%eax
 274:	01 c8                	add    %ecx,%eax
 276:	83 e8 30             	sub    $0x30,%eax
 279:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
 27f:	0f b6 00             	movzbl (%eax),%eax
 282:	3c 2f                	cmp    $0x2f,%al
 284:	7e 0a                	jle    290 <atoi+0x48>
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	0f b6 00             	movzbl (%eax),%eax
 28c:	3c 39                	cmp    $0x39,%al
 28e:	7e c7                	jle    257 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 290:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 293:	c9                   	leave  
 294:	c3                   	ret    

00000295 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 295:	55                   	push   %ebp
 296:	89 e5                	mov    %esp,%ebp
 298:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 29b:	8b 45 08             	mov    0x8(%ebp),%eax
 29e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2a1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2a7:	eb 17                	jmp    2c0 <memmove+0x2b>
    *dst++ = *src++;
 2a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2ac:	8d 50 01             	lea    0x1(%eax),%edx
 2af:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2b2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2b5:	8d 4a 01             	lea    0x1(%edx),%ecx
 2b8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2bb:	0f b6 12             	movzbl (%edx),%edx
 2be:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c0:	8b 45 10             	mov    0x10(%ebp),%eax
 2c3:	8d 50 ff             	lea    -0x1(%eax),%edx
 2c6:	89 55 10             	mov    %edx,0x10(%ebp)
 2c9:	85 c0                	test   %eax,%eax
 2cb:	7f dc                	jg     2a9 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2cd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d0:	c9                   	leave  
 2d1:	c3                   	ret    

000002d2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d2:	b8 01 00 00 00       	mov    $0x1,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <exit>:
SYSCALL(exit)
 2da:	b8 02 00 00 00       	mov    $0x2,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <wait>:
SYSCALL(wait)
 2e2:	b8 03 00 00 00       	mov    $0x3,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <pipe>:
SYSCALL(pipe)
 2ea:	b8 04 00 00 00       	mov    $0x4,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <read>:
SYSCALL(read)
 2f2:	b8 05 00 00 00       	mov    $0x5,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <write>:
SYSCALL(write)
 2fa:	b8 10 00 00 00       	mov    $0x10,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <close>:
SYSCALL(close)
 302:	b8 15 00 00 00       	mov    $0x15,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <kill>:
SYSCALL(kill)
 30a:	b8 06 00 00 00       	mov    $0x6,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <exec>:
SYSCALL(exec)
 312:	b8 07 00 00 00       	mov    $0x7,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <open>:
SYSCALL(open)
 31a:	b8 0f 00 00 00       	mov    $0xf,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <mknod>:
SYSCALL(mknod)
 322:	b8 11 00 00 00       	mov    $0x11,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <unlink>:
SYSCALL(unlink)
 32a:	b8 12 00 00 00       	mov    $0x12,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <fstat>:
SYSCALL(fstat)
 332:	b8 08 00 00 00       	mov    $0x8,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <link>:
SYSCALL(link)
 33a:	b8 13 00 00 00       	mov    $0x13,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <mkdir>:
SYSCALL(mkdir)
 342:	b8 14 00 00 00       	mov    $0x14,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <chdir>:
SYSCALL(chdir)
 34a:	b8 09 00 00 00       	mov    $0x9,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <dup>:
SYSCALL(dup)
 352:	b8 0a 00 00 00       	mov    $0xa,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <getpid>:
SYSCALL(getpid)
 35a:	b8 0b 00 00 00       	mov    $0xb,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <sbrk>:
SYSCALL(sbrk)
 362:	b8 0c 00 00 00       	mov    $0xc,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <sleep>:
SYSCALL(sleep)
 36a:	b8 0d 00 00 00       	mov    $0xd,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <uptime>:
SYSCALL(uptime)
 372:	b8 0e 00 00 00       	mov    $0xe,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <randomX>:
SYSCALL(randomX)
 37a:	b8 16 00 00 00       	mov    $0x16,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <setSeedX>:
SYSCALL(setSeedX)
 382:	b8 17 00 00 00       	mov    $0x17,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <uniformR>:
SYSCALL(uniformR)
 38a:	b8 18 00 00 00       	mov    $0x18,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 392:	55                   	push   %ebp
 393:	89 e5                	mov    %esp,%ebp
 395:	83 ec 18             	sub    $0x18,%esp
 398:	8b 45 0c             	mov    0xc(%ebp),%eax
 39b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 39e:	83 ec 04             	sub    $0x4,%esp
 3a1:	6a 01                	push   $0x1
 3a3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3a6:	50                   	push   %eax
 3a7:	ff 75 08             	pushl  0x8(%ebp)
 3aa:	e8 4b ff ff ff       	call   2fa <write>
 3af:	83 c4 10             	add    $0x10,%esp
}
 3b2:	90                   	nop
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    

000003b5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
 3b8:	53                   	push   %ebx
 3b9:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3bc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3c3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c7:	74 17                	je     3e0 <printint+0x2b>
 3c9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3cd:	79 11                	jns    3e0 <printint+0x2b>
    neg = 1;
 3cf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3d6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d9:	f7 d8                	neg    %eax
 3db:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3de:	eb 06                	jmp    3e6 <printint+0x31>
  } else {
    x = xx;
 3e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ed:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3f0:	8d 41 01             	lea    0x1(%ecx),%eax
 3f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3f6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fc:	ba 00 00 00 00       	mov    $0x0,%edx
 401:	f7 f3                	div    %ebx
 403:	89 d0                	mov    %edx,%eax
 405:	0f b6 80 78 0a 00 00 	movzbl 0xa78(%eax),%eax
 40c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 410:	8b 5d 10             	mov    0x10(%ebp),%ebx
 413:	8b 45 ec             	mov    -0x14(%ebp),%eax
 416:	ba 00 00 00 00       	mov    $0x0,%edx
 41b:	f7 f3                	div    %ebx
 41d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 420:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 424:	75 c7                	jne    3ed <printint+0x38>
  if(neg)
 426:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 42a:	74 2d                	je     459 <printint+0xa4>
    buf[i++] = '-';
 42c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42f:	8d 50 01             	lea    0x1(%eax),%edx
 432:	89 55 f4             	mov    %edx,-0xc(%ebp)
 435:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 43a:	eb 1d                	jmp    459 <printint+0xa4>
    putc(fd, buf[i]);
 43c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 43f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 442:	01 d0                	add    %edx,%eax
 444:	0f b6 00             	movzbl (%eax),%eax
 447:	0f be c0             	movsbl %al,%eax
 44a:	83 ec 08             	sub    $0x8,%esp
 44d:	50                   	push   %eax
 44e:	ff 75 08             	pushl  0x8(%ebp)
 451:	e8 3c ff ff ff       	call   392 <putc>
 456:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 459:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 45d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 461:	79 d9                	jns    43c <printint+0x87>
    putc(fd, buf[i]);
}
 463:	90                   	nop
 464:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 467:	c9                   	leave  
 468:	c3                   	ret    

00000469 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 469:	55                   	push   %ebp
 46a:	89 e5                	mov    %esp,%ebp
 46c:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 46f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 476:	8d 45 0c             	lea    0xc(%ebp),%eax
 479:	83 c0 04             	add    $0x4,%eax
 47c:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 47f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 486:	e9 59 01 00 00       	jmp    5e4 <printf+0x17b>
    c = fmt[i] & 0xff;
 48b:	8b 55 0c             	mov    0xc(%ebp),%edx
 48e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 491:	01 d0                	add    %edx,%eax
 493:	0f b6 00             	movzbl (%eax),%eax
 496:	0f be c0             	movsbl %al,%eax
 499:	25 ff 00 00 00       	and    $0xff,%eax
 49e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a5:	75 2c                	jne    4d3 <printf+0x6a>
      if(c == '%'){
 4a7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ab:	75 0c                	jne    4b9 <printf+0x50>
        state = '%';
 4ad:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b4:	e9 27 01 00 00       	jmp    5e0 <printf+0x177>
      } else {
        putc(fd, c);
 4b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4bc:	0f be c0             	movsbl %al,%eax
 4bf:	83 ec 08             	sub    $0x8,%esp
 4c2:	50                   	push   %eax
 4c3:	ff 75 08             	pushl  0x8(%ebp)
 4c6:	e8 c7 fe ff ff       	call   392 <putc>
 4cb:	83 c4 10             	add    $0x10,%esp
 4ce:	e9 0d 01 00 00       	jmp    5e0 <printf+0x177>
      }
    } else if(state == '%'){
 4d3:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d7:	0f 85 03 01 00 00    	jne    5e0 <printf+0x177>
      if(c == 'd'){
 4dd:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e1:	75 1e                	jne    501 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e6:	8b 00                	mov    (%eax),%eax
 4e8:	6a 01                	push   $0x1
 4ea:	6a 0a                	push   $0xa
 4ec:	50                   	push   %eax
 4ed:	ff 75 08             	pushl  0x8(%ebp)
 4f0:	e8 c0 fe ff ff       	call   3b5 <printint>
 4f5:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fc:	e9 d8 00 00 00       	jmp    5d9 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 501:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 505:	74 06                	je     50d <printf+0xa4>
 507:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 50b:	75 1e                	jne    52b <printf+0xc2>
        printint(fd, *ap, 16, 0);
 50d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 510:	8b 00                	mov    (%eax),%eax
 512:	6a 00                	push   $0x0
 514:	6a 10                	push   $0x10
 516:	50                   	push   %eax
 517:	ff 75 08             	pushl  0x8(%ebp)
 51a:	e8 96 fe ff ff       	call   3b5 <printint>
 51f:	83 c4 10             	add    $0x10,%esp
        ap++;
 522:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 526:	e9 ae 00 00 00       	jmp    5d9 <printf+0x170>
      } else if(c == 's'){
 52b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 52f:	75 43                	jne    574 <printf+0x10b>
        s = (char*)*ap;
 531:	8b 45 e8             	mov    -0x18(%ebp),%eax
 534:	8b 00                	mov    (%eax),%eax
 536:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 539:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 53d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 541:	75 25                	jne    568 <printf+0xff>
          s = "(null)";
 543:	c7 45 f4 24 08 00 00 	movl   $0x824,-0xc(%ebp)
        while(*s != 0){
 54a:	eb 1c                	jmp    568 <printf+0xff>
          putc(fd, *s);
 54c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54f:	0f b6 00             	movzbl (%eax),%eax
 552:	0f be c0             	movsbl %al,%eax
 555:	83 ec 08             	sub    $0x8,%esp
 558:	50                   	push   %eax
 559:	ff 75 08             	pushl  0x8(%ebp)
 55c:	e8 31 fe ff ff       	call   392 <putc>
 561:	83 c4 10             	add    $0x10,%esp
          s++;
 564:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 568:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56b:	0f b6 00             	movzbl (%eax),%eax
 56e:	84 c0                	test   %al,%al
 570:	75 da                	jne    54c <printf+0xe3>
 572:	eb 65                	jmp    5d9 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 574:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 578:	75 1d                	jne    597 <printf+0x12e>
        putc(fd, *ap);
 57a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57d:	8b 00                	mov    (%eax),%eax
 57f:	0f be c0             	movsbl %al,%eax
 582:	83 ec 08             	sub    $0x8,%esp
 585:	50                   	push   %eax
 586:	ff 75 08             	pushl  0x8(%ebp)
 589:	e8 04 fe ff ff       	call   392 <putc>
 58e:	83 c4 10             	add    $0x10,%esp
        ap++;
 591:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 595:	eb 42                	jmp    5d9 <printf+0x170>
      } else if(c == '%'){
 597:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 59b:	75 17                	jne    5b4 <printf+0x14b>
        putc(fd, c);
 59d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a0:	0f be c0             	movsbl %al,%eax
 5a3:	83 ec 08             	sub    $0x8,%esp
 5a6:	50                   	push   %eax
 5a7:	ff 75 08             	pushl  0x8(%ebp)
 5aa:	e8 e3 fd ff ff       	call   392 <putc>
 5af:	83 c4 10             	add    $0x10,%esp
 5b2:	eb 25                	jmp    5d9 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b4:	83 ec 08             	sub    $0x8,%esp
 5b7:	6a 25                	push   $0x25
 5b9:	ff 75 08             	pushl  0x8(%ebp)
 5bc:	e8 d1 fd ff ff       	call   392 <putc>
 5c1:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5c4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c7:	0f be c0             	movsbl %al,%eax
 5ca:	83 ec 08             	sub    $0x8,%esp
 5cd:	50                   	push   %eax
 5ce:	ff 75 08             	pushl  0x8(%ebp)
 5d1:	e8 bc fd ff ff       	call   392 <putc>
 5d6:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5d9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e4:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ea:	01 d0                	add    %edx,%eax
 5ec:	0f b6 00             	movzbl (%eax),%eax
 5ef:	84 c0                	test   %al,%al
 5f1:	0f 85 94 fe ff ff    	jne    48b <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5f7:	90                   	nop
 5f8:	c9                   	leave  
 5f9:	c3                   	ret    

000005fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5fa:	55                   	push   %ebp
 5fb:	89 e5                	mov    %esp,%ebp
 5fd:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 600:	8b 45 08             	mov    0x8(%ebp),%eax
 603:	83 e8 08             	sub    $0x8,%eax
 606:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 609:	a1 94 0a 00 00       	mov    0xa94,%eax
 60e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 611:	eb 24                	jmp    637 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 613:	8b 45 fc             	mov    -0x4(%ebp),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61b:	77 12                	ja     62f <free+0x35>
 61d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 620:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 623:	77 24                	ja     649 <free+0x4f>
 625:	8b 45 fc             	mov    -0x4(%ebp),%eax
 628:	8b 00                	mov    (%eax),%eax
 62a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62d:	77 1a                	ja     649 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 632:	8b 00                	mov    (%eax),%eax
 634:	89 45 fc             	mov    %eax,-0x4(%ebp)
 637:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63d:	76 d4                	jbe    613 <free+0x19>
 63f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 642:	8b 00                	mov    (%eax),%eax
 644:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 647:	76 ca                	jbe    613 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 649:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64c:	8b 40 04             	mov    0x4(%eax),%eax
 64f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 656:	8b 45 f8             	mov    -0x8(%ebp),%eax
 659:	01 c2                	add    %eax,%edx
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	8b 00                	mov    (%eax),%eax
 660:	39 c2                	cmp    %eax,%edx
 662:	75 24                	jne    688 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 664:	8b 45 f8             	mov    -0x8(%ebp),%eax
 667:	8b 50 04             	mov    0x4(%eax),%edx
 66a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66d:	8b 00                	mov    (%eax),%eax
 66f:	8b 40 04             	mov    0x4(%eax),%eax
 672:	01 c2                	add    %eax,%edx
 674:	8b 45 f8             	mov    -0x8(%ebp),%eax
 677:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67d:	8b 00                	mov    (%eax),%eax
 67f:	8b 10                	mov    (%eax),%edx
 681:	8b 45 f8             	mov    -0x8(%ebp),%eax
 684:	89 10                	mov    %edx,(%eax)
 686:	eb 0a                	jmp    692 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	8b 10                	mov    (%eax),%edx
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 692:	8b 45 fc             	mov    -0x4(%ebp),%eax
 695:	8b 40 04             	mov    0x4(%eax),%eax
 698:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	01 d0                	add    %edx,%eax
 6a4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a7:	75 20                	jne    6c9 <free+0xcf>
    p->s.size += bp->s.size;
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 50 04             	mov    0x4(%eax),%edx
 6af:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b2:	8b 40 04             	mov    0x4(%eax),%eax
 6b5:	01 c2                	add    %eax,%edx
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c0:	8b 10                	mov    (%eax),%edx
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	89 10                	mov    %edx,(%eax)
 6c7:	eb 08                	jmp    6d1 <free+0xd7>
  } else
    p->s.ptr = bp;
 6c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cc:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6cf:	89 10                	mov    %edx,(%eax)
  freep = p;
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	a3 94 0a 00 00       	mov    %eax,0xa94
}
 6d9:	90                   	nop
 6da:	c9                   	leave  
 6db:	c3                   	ret    

000006dc <morecore>:

static Header*
morecore(uint nu)
{
 6dc:	55                   	push   %ebp
 6dd:	89 e5                	mov    %esp,%ebp
 6df:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6e2:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6e9:	77 07                	ja     6f2 <morecore+0x16>
    nu = 4096;
 6eb:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6f2:	8b 45 08             	mov    0x8(%ebp),%eax
 6f5:	c1 e0 03             	shl    $0x3,%eax
 6f8:	83 ec 0c             	sub    $0xc,%esp
 6fb:	50                   	push   %eax
 6fc:	e8 61 fc ff ff       	call   362 <sbrk>
 701:	83 c4 10             	add    $0x10,%esp
 704:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 707:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 70b:	75 07                	jne    714 <morecore+0x38>
    return 0;
 70d:	b8 00 00 00 00       	mov    $0x0,%eax
 712:	eb 26                	jmp    73a <morecore+0x5e>
  hp = (Header*)p;
 714:	8b 45 f4             	mov    -0xc(%ebp),%eax
 717:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 71a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71d:	8b 55 08             	mov    0x8(%ebp),%edx
 720:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 723:	8b 45 f0             	mov    -0x10(%ebp),%eax
 726:	83 c0 08             	add    $0x8,%eax
 729:	83 ec 0c             	sub    $0xc,%esp
 72c:	50                   	push   %eax
 72d:	e8 c8 fe ff ff       	call   5fa <free>
 732:	83 c4 10             	add    $0x10,%esp
  return freep;
 735:	a1 94 0a 00 00       	mov    0xa94,%eax
}
 73a:	c9                   	leave  
 73b:	c3                   	ret    

0000073c <malloc>:

void*
malloc(uint nbytes)
{
 73c:	55                   	push   %ebp
 73d:	89 e5                	mov    %esp,%ebp
 73f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 742:	8b 45 08             	mov    0x8(%ebp),%eax
 745:	83 c0 07             	add    $0x7,%eax
 748:	c1 e8 03             	shr    $0x3,%eax
 74b:	83 c0 01             	add    $0x1,%eax
 74e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 751:	a1 94 0a 00 00       	mov    0xa94,%eax
 756:	89 45 f0             	mov    %eax,-0x10(%ebp)
 759:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 75d:	75 23                	jne    782 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 75f:	c7 45 f0 8c 0a 00 00 	movl   $0xa8c,-0x10(%ebp)
 766:	8b 45 f0             	mov    -0x10(%ebp),%eax
 769:	a3 94 0a 00 00       	mov    %eax,0xa94
 76e:	a1 94 0a 00 00       	mov    0xa94,%eax
 773:	a3 8c 0a 00 00       	mov    %eax,0xa8c
    base.s.size = 0;
 778:	c7 05 90 0a 00 00 00 	movl   $0x0,0xa90
 77f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 782:	8b 45 f0             	mov    -0x10(%ebp),%eax
 785:	8b 00                	mov    (%eax),%eax
 787:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78d:	8b 40 04             	mov    0x4(%eax),%eax
 790:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 793:	72 4d                	jb     7e2 <malloc+0xa6>
      if(p->s.size == nunits)
 795:	8b 45 f4             	mov    -0xc(%ebp),%eax
 798:	8b 40 04             	mov    0x4(%eax),%eax
 79b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 79e:	75 0c                	jne    7ac <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a3:	8b 10                	mov    (%eax),%edx
 7a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a8:	89 10                	mov    %edx,(%eax)
 7aa:	eb 26                	jmp    7d2 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7af:	8b 40 04             	mov    0x4(%eax),%eax
 7b2:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b5:	89 c2                	mov    %eax,%edx
 7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ba:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c0:	8b 40 04             	mov    0x4(%eax),%eax
 7c3:	c1 e0 03             	shl    $0x3,%eax
 7c6:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cc:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7cf:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d5:	a3 94 0a 00 00       	mov    %eax,0xa94
      return (void*)(p + 1);
 7da:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7dd:	83 c0 08             	add    $0x8,%eax
 7e0:	eb 3b                	jmp    81d <malloc+0xe1>
    }
    if(p == freep)
 7e2:	a1 94 0a 00 00       	mov    0xa94,%eax
 7e7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7ea:	75 1e                	jne    80a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7ec:	83 ec 0c             	sub    $0xc,%esp
 7ef:	ff 75 ec             	pushl  -0x14(%ebp)
 7f2:	e8 e5 fe ff ff       	call   6dc <morecore>
 7f7:	83 c4 10             	add    $0x10,%esp
 7fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 801:	75 07                	jne    80a <malloc+0xce>
        return 0;
 803:	b8 00 00 00 00       	mov    $0x0,%eax
 808:	eb 13                	jmp    81d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	8b 00                	mov    (%eax),%eax
 815:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 818:	e9 6d ff ff ff       	jmp    78a <malloc+0x4e>
}
 81d:	c9                   	leave  
 81e:	c3                   	ret    
