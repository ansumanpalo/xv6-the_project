
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
  2b:	e8 07 03 00 00       	call   337 <setSeedX>
  30:	83 c4 10             	add    $0x10,%esp
  exit();
  33:	e8 57 02 00 00       	call   28f <exit>

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
 15b:	e8 47 01 00 00       	call   2a7 <read>
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
 1be:	e8 0c 01 00 00       	call   2cf <open>
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
 1df:	e8 03 01 00 00       	call   2e7 <fstat>
 1e4:	83 c4 10             	add    $0x10,%esp
 1e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1ea:	83 ec 0c             	sub    $0xc,%esp
 1ed:	ff 75 f4             	pushl  -0xc(%ebp)
 1f0:	e8 c2 00 00 00       	call   2b7 <close>
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

0000024a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 24a:	55                   	push   %ebp
 24b:	89 e5                	mov    %esp,%ebp
 24d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 256:	8b 45 0c             	mov    0xc(%ebp),%eax
 259:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 25c:	eb 17                	jmp    275 <memmove+0x2b>
    *dst++ = *src++;
 25e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 261:	8d 50 01             	lea    0x1(%eax),%edx
 264:	89 55 fc             	mov    %edx,-0x4(%ebp)
 267:	8b 55 f8             	mov    -0x8(%ebp),%edx
 26a:	8d 4a 01             	lea    0x1(%edx),%ecx
 26d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 270:	0f b6 12             	movzbl (%edx),%edx
 273:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 275:	8b 45 10             	mov    0x10(%ebp),%eax
 278:	8d 50 ff             	lea    -0x1(%eax),%edx
 27b:	89 55 10             	mov    %edx,0x10(%ebp)
 27e:	85 c0                	test   %eax,%eax
 280:	7f dc                	jg     25e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 282:	8b 45 08             	mov    0x8(%ebp),%eax
}
 285:	c9                   	leave  
 286:	c3                   	ret    

00000287 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 287:	b8 01 00 00 00       	mov    $0x1,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <exit>:
SYSCALL(exit)
 28f:	b8 02 00 00 00       	mov    $0x2,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <wait>:
SYSCALL(wait)
 297:	b8 03 00 00 00       	mov    $0x3,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <pipe>:
SYSCALL(pipe)
 29f:	b8 04 00 00 00       	mov    $0x4,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <read>:
SYSCALL(read)
 2a7:	b8 05 00 00 00       	mov    $0x5,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <write>:
SYSCALL(write)
 2af:	b8 10 00 00 00       	mov    $0x10,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <close>:
SYSCALL(close)
 2b7:	b8 15 00 00 00       	mov    $0x15,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <kill>:
SYSCALL(kill)
 2bf:	b8 06 00 00 00       	mov    $0x6,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <exec>:
SYSCALL(exec)
 2c7:	b8 07 00 00 00       	mov    $0x7,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <open>:
SYSCALL(open)
 2cf:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <mknod>:
SYSCALL(mknod)
 2d7:	b8 11 00 00 00       	mov    $0x11,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <unlink>:
SYSCALL(unlink)
 2df:	b8 12 00 00 00       	mov    $0x12,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <fstat>:
SYSCALL(fstat)
 2e7:	b8 08 00 00 00       	mov    $0x8,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <link>:
SYSCALL(link)
 2ef:	b8 13 00 00 00       	mov    $0x13,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <mkdir>:
SYSCALL(mkdir)
 2f7:	b8 14 00 00 00       	mov    $0x14,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <chdir>:
SYSCALL(chdir)
 2ff:	b8 09 00 00 00       	mov    $0x9,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <dup>:
SYSCALL(dup)
 307:	b8 0a 00 00 00       	mov    $0xa,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <getpid>:
SYSCALL(getpid)
 30f:	b8 0b 00 00 00       	mov    $0xb,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <sbrk>:
SYSCALL(sbrk)
 317:	b8 0c 00 00 00       	mov    $0xc,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <sleep>:
SYSCALL(sleep)
 31f:	b8 0d 00 00 00       	mov    $0xd,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <uptime>:
SYSCALL(uptime)
 327:	b8 0e 00 00 00       	mov    $0xe,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <randomX>:
SYSCALL(randomX)
 32f:	b8 16 00 00 00       	mov    $0x16,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <setSeedX>:
SYSCALL(setSeedX)
 337:	b8 17 00 00 00       	mov    $0x17,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <uniformR>:
SYSCALL(uniformR)
 33f:	b8 18 00 00 00       	mov    $0x18,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 347:	55                   	push   %ebp
 348:	89 e5                	mov    %esp,%ebp
 34a:	83 ec 18             	sub    $0x18,%esp
 34d:	8b 45 0c             	mov    0xc(%ebp),%eax
 350:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 353:	83 ec 04             	sub    $0x4,%esp
 356:	6a 01                	push   $0x1
 358:	8d 45 f4             	lea    -0xc(%ebp),%eax
 35b:	50                   	push   %eax
 35c:	ff 75 08             	pushl  0x8(%ebp)
 35f:	e8 4b ff ff ff       	call   2af <write>
 364:	83 c4 10             	add    $0x10,%esp
}
 367:	90                   	nop
 368:	c9                   	leave  
 369:	c3                   	ret    

0000036a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 36a:	55                   	push   %ebp
 36b:	89 e5                	mov    %esp,%ebp
 36d:	53                   	push   %ebx
 36e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 371:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 378:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 37c:	74 17                	je     395 <printint+0x2b>
 37e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 382:	79 11                	jns    395 <printint+0x2b>
    neg = 1;
 384:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 38b:	8b 45 0c             	mov    0xc(%ebp),%eax
 38e:	f7 d8                	neg    %eax
 390:	89 45 ec             	mov    %eax,-0x14(%ebp)
 393:	eb 06                	jmp    39b <printint+0x31>
  } else {
    x = xx;
 395:	8b 45 0c             	mov    0xc(%ebp),%eax
 398:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 39b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3a2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3a5:	8d 41 01             	lea    0x1(%ecx),%eax
 3a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3ab:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3ae:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b1:	ba 00 00 00 00       	mov    $0x0,%edx
 3b6:	f7 f3                	div    %ebx
 3b8:	89 d0                	mov    %edx,%eax
 3ba:	0f b6 80 24 0a 00 00 	movzbl 0xa24(%eax),%eax
 3c1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3cb:	ba 00 00 00 00       	mov    $0x0,%edx
 3d0:	f7 f3                	div    %ebx
 3d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3d9:	75 c7                	jne    3a2 <printint+0x38>
  if(neg)
 3db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3df:	74 2d                	je     40e <printint+0xa4>
    buf[i++] = '-';
 3e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e4:	8d 50 01             	lea    0x1(%eax),%edx
 3e7:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ea:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3ef:	eb 1d                	jmp    40e <printint+0xa4>
    putc(fd, buf[i]);
 3f1:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3f7:	01 d0                	add    %edx,%eax
 3f9:	0f b6 00             	movzbl (%eax),%eax
 3fc:	0f be c0             	movsbl %al,%eax
 3ff:	83 ec 08             	sub    $0x8,%esp
 402:	50                   	push   %eax
 403:	ff 75 08             	pushl  0x8(%ebp)
 406:	e8 3c ff ff ff       	call   347 <putc>
 40b:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 40e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 412:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 416:	79 d9                	jns    3f1 <printint+0x87>
    putc(fd, buf[i]);
}
 418:	90                   	nop
 419:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 41c:	c9                   	leave  
 41d:	c3                   	ret    

0000041e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 41e:	55                   	push   %ebp
 41f:	89 e5                	mov    %esp,%ebp
 421:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 424:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 42b:	8d 45 0c             	lea    0xc(%ebp),%eax
 42e:	83 c0 04             	add    $0x4,%eax
 431:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 434:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 43b:	e9 59 01 00 00       	jmp    599 <printf+0x17b>
    c = fmt[i] & 0xff;
 440:	8b 55 0c             	mov    0xc(%ebp),%edx
 443:	8b 45 f0             	mov    -0x10(%ebp),%eax
 446:	01 d0                	add    %edx,%eax
 448:	0f b6 00             	movzbl (%eax),%eax
 44b:	0f be c0             	movsbl %al,%eax
 44e:	25 ff 00 00 00       	and    $0xff,%eax
 453:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 456:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45a:	75 2c                	jne    488 <printf+0x6a>
      if(c == '%'){
 45c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 460:	75 0c                	jne    46e <printf+0x50>
        state = '%';
 462:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 469:	e9 27 01 00 00       	jmp    595 <printf+0x177>
      } else {
        putc(fd, c);
 46e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 471:	0f be c0             	movsbl %al,%eax
 474:	83 ec 08             	sub    $0x8,%esp
 477:	50                   	push   %eax
 478:	ff 75 08             	pushl  0x8(%ebp)
 47b:	e8 c7 fe ff ff       	call   347 <putc>
 480:	83 c4 10             	add    $0x10,%esp
 483:	e9 0d 01 00 00       	jmp    595 <printf+0x177>
      }
    } else if(state == '%'){
 488:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 48c:	0f 85 03 01 00 00    	jne    595 <printf+0x177>
      if(c == 'd'){
 492:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 496:	75 1e                	jne    4b6 <printf+0x98>
        printint(fd, *ap, 10, 1);
 498:	8b 45 e8             	mov    -0x18(%ebp),%eax
 49b:	8b 00                	mov    (%eax),%eax
 49d:	6a 01                	push   $0x1
 49f:	6a 0a                	push   $0xa
 4a1:	50                   	push   %eax
 4a2:	ff 75 08             	pushl  0x8(%ebp)
 4a5:	e8 c0 fe ff ff       	call   36a <printint>
 4aa:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b1:	e9 d8 00 00 00       	jmp    58e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4b6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ba:	74 06                	je     4c2 <printf+0xa4>
 4bc:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4c0:	75 1e                	jne    4e0 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c5:	8b 00                	mov    (%eax),%eax
 4c7:	6a 00                	push   $0x0
 4c9:	6a 10                	push   $0x10
 4cb:	50                   	push   %eax
 4cc:	ff 75 08             	pushl  0x8(%ebp)
 4cf:	e8 96 fe ff ff       	call   36a <printint>
 4d4:	83 c4 10             	add    $0x10,%esp
        ap++;
 4d7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4db:	e9 ae 00 00 00       	jmp    58e <printf+0x170>
      } else if(c == 's'){
 4e0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4e4:	75 43                	jne    529 <printf+0x10b>
        s = (char*)*ap;
 4e6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e9:	8b 00                	mov    (%eax),%eax
 4eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4f6:	75 25                	jne    51d <printf+0xff>
          s = "(null)";
 4f8:	c7 45 f4 d4 07 00 00 	movl   $0x7d4,-0xc(%ebp)
        while(*s != 0){
 4ff:	eb 1c                	jmp    51d <printf+0xff>
          putc(fd, *s);
 501:	8b 45 f4             	mov    -0xc(%ebp),%eax
 504:	0f b6 00             	movzbl (%eax),%eax
 507:	0f be c0             	movsbl %al,%eax
 50a:	83 ec 08             	sub    $0x8,%esp
 50d:	50                   	push   %eax
 50e:	ff 75 08             	pushl  0x8(%ebp)
 511:	e8 31 fe ff ff       	call   347 <putc>
 516:	83 c4 10             	add    $0x10,%esp
          s++;
 519:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 51d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 520:	0f b6 00             	movzbl (%eax),%eax
 523:	84 c0                	test   %al,%al
 525:	75 da                	jne    501 <printf+0xe3>
 527:	eb 65                	jmp    58e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 529:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 52d:	75 1d                	jne    54c <printf+0x12e>
        putc(fd, *ap);
 52f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 532:	8b 00                	mov    (%eax),%eax
 534:	0f be c0             	movsbl %al,%eax
 537:	83 ec 08             	sub    $0x8,%esp
 53a:	50                   	push   %eax
 53b:	ff 75 08             	pushl  0x8(%ebp)
 53e:	e8 04 fe ff ff       	call   347 <putc>
 543:	83 c4 10             	add    $0x10,%esp
        ap++;
 546:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54a:	eb 42                	jmp    58e <printf+0x170>
      } else if(c == '%'){
 54c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 550:	75 17                	jne    569 <printf+0x14b>
        putc(fd, c);
 552:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 555:	0f be c0             	movsbl %al,%eax
 558:	83 ec 08             	sub    $0x8,%esp
 55b:	50                   	push   %eax
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 e3 fd ff ff       	call   347 <putc>
 564:	83 c4 10             	add    $0x10,%esp
 567:	eb 25                	jmp    58e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 569:	83 ec 08             	sub    $0x8,%esp
 56c:	6a 25                	push   $0x25
 56e:	ff 75 08             	pushl  0x8(%ebp)
 571:	e8 d1 fd ff ff       	call   347 <putc>
 576:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 579:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57c:	0f be c0             	movsbl %al,%eax
 57f:	83 ec 08             	sub    $0x8,%esp
 582:	50                   	push   %eax
 583:	ff 75 08             	pushl  0x8(%ebp)
 586:	e8 bc fd ff ff       	call   347 <putc>
 58b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 58e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 595:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 599:	8b 55 0c             	mov    0xc(%ebp),%edx
 59c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 59f:	01 d0                	add    %edx,%eax
 5a1:	0f b6 00             	movzbl (%eax),%eax
 5a4:	84 c0                	test   %al,%al
 5a6:	0f 85 94 fe ff ff    	jne    440 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5ac:	90                   	nop
 5ad:	c9                   	leave  
 5ae:	c3                   	ret    

000005af <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5af:	55                   	push   %ebp
 5b0:	89 e5                	mov    %esp,%ebp
 5b2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5b5:	8b 45 08             	mov    0x8(%ebp),%eax
 5b8:	83 e8 08             	sub    $0x8,%eax
 5bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5be:	a1 40 0a 00 00       	mov    0xa40,%eax
 5c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c6:	eb 24                	jmp    5ec <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cb:	8b 00                	mov    (%eax),%eax
 5cd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d0:	77 12                	ja     5e4 <free+0x35>
 5d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5d8:	77 24                	ja     5fe <free+0x4f>
 5da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5dd:	8b 00                	mov    (%eax),%eax
 5df:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5e2:	77 1a                	ja     5fe <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e7:	8b 00                	mov    (%eax),%eax
 5e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f2:	76 d4                	jbe    5c8 <free+0x19>
 5f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f7:	8b 00                	mov    (%eax),%eax
 5f9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5fc:	76 ca                	jbe    5c8 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
 601:	8b 40 04             	mov    0x4(%eax),%eax
 604:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 60b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60e:	01 c2                	add    %eax,%edx
 610:	8b 45 fc             	mov    -0x4(%ebp),%eax
 613:	8b 00                	mov    (%eax),%eax
 615:	39 c2                	cmp    %eax,%edx
 617:	75 24                	jne    63d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 619:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61c:	8b 50 04             	mov    0x4(%eax),%edx
 61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 622:	8b 00                	mov    (%eax),%eax
 624:	8b 40 04             	mov    0x4(%eax),%eax
 627:	01 c2                	add    %eax,%edx
 629:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 62f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 632:	8b 00                	mov    (%eax),%eax
 634:	8b 10                	mov    (%eax),%edx
 636:	8b 45 f8             	mov    -0x8(%ebp),%eax
 639:	89 10                	mov    %edx,(%eax)
 63b:	eb 0a                	jmp    647 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 63d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 640:	8b 10                	mov    (%eax),%edx
 642:	8b 45 f8             	mov    -0x8(%ebp),%eax
 645:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 647:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64a:	8b 40 04             	mov    0x4(%eax),%eax
 64d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 654:	8b 45 fc             	mov    -0x4(%ebp),%eax
 657:	01 d0                	add    %edx,%eax
 659:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 65c:	75 20                	jne    67e <free+0xcf>
    p->s.size += bp->s.size;
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	8b 50 04             	mov    0x4(%eax),%edx
 664:	8b 45 f8             	mov    -0x8(%ebp),%eax
 667:	8b 40 04             	mov    0x4(%eax),%eax
 66a:	01 c2                	add    %eax,%edx
 66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 672:	8b 45 f8             	mov    -0x8(%ebp),%eax
 675:	8b 10                	mov    (%eax),%edx
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	89 10                	mov    %edx,(%eax)
 67c:	eb 08                	jmp    686 <free+0xd7>
  } else
    p->s.ptr = bp;
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 55 f8             	mov    -0x8(%ebp),%edx
 684:	89 10                	mov    %edx,(%eax)
  freep = p;
 686:	8b 45 fc             	mov    -0x4(%ebp),%eax
 689:	a3 40 0a 00 00       	mov    %eax,0xa40
}
 68e:	90                   	nop
 68f:	c9                   	leave  
 690:	c3                   	ret    

00000691 <morecore>:

static Header*
morecore(uint nu)
{
 691:	55                   	push   %ebp
 692:	89 e5                	mov    %esp,%ebp
 694:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 697:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 69e:	77 07                	ja     6a7 <morecore+0x16>
    nu = 4096;
 6a0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6a7:	8b 45 08             	mov    0x8(%ebp),%eax
 6aa:	c1 e0 03             	shl    $0x3,%eax
 6ad:	83 ec 0c             	sub    $0xc,%esp
 6b0:	50                   	push   %eax
 6b1:	e8 61 fc ff ff       	call   317 <sbrk>
 6b6:	83 c4 10             	add    $0x10,%esp
 6b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6bc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6c0:	75 07                	jne    6c9 <morecore+0x38>
    return 0;
 6c2:	b8 00 00 00 00       	mov    $0x0,%eax
 6c7:	eb 26                	jmp    6ef <morecore+0x5e>
  hp = (Header*)p;
 6c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d2:	8b 55 08             	mov    0x8(%ebp),%edx
 6d5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6db:	83 c0 08             	add    $0x8,%eax
 6de:	83 ec 0c             	sub    $0xc,%esp
 6e1:	50                   	push   %eax
 6e2:	e8 c8 fe ff ff       	call   5af <free>
 6e7:	83 c4 10             	add    $0x10,%esp
  return freep;
 6ea:	a1 40 0a 00 00       	mov    0xa40,%eax
}
 6ef:	c9                   	leave  
 6f0:	c3                   	ret    

000006f1 <malloc>:

void*
malloc(uint nbytes)
{
 6f1:	55                   	push   %ebp
 6f2:	89 e5                	mov    %esp,%ebp
 6f4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f7:	8b 45 08             	mov    0x8(%ebp),%eax
 6fa:	83 c0 07             	add    $0x7,%eax
 6fd:	c1 e8 03             	shr    $0x3,%eax
 700:	83 c0 01             	add    $0x1,%eax
 703:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 706:	a1 40 0a 00 00       	mov    0xa40,%eax
 70b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 70e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 712:	75 23                	jne    737 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 714:	c7 45 f0 38 0a 00 00 	movl   $0xa38,-0x10(%ebp)
 71b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71e:	a3 40 0a 00 00       	mov    %eax,0xa40
 723:	a1 40 0a 00 00       	mov    0xa40,%eax
 728:	a3 38 0a 00 00       	mov    %eax,0xa38
    base.s.size = 0;
 72d:	c7 05 3c 0a 00 00 00 	movl   $0x0,0xa3c
 734:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 737:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73a:	8b 00                	mov    (%eax),%eax
 73c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 73f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 742:	8b 40 04             	mov    0x4(%eax),%eax
 745:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 748:	72 4d                	jb     797 <malloc+0xa6>
      if(p->s.size == nunits)
 74a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74d:	8b 40 04             	mov    0x4(%eax),%eax
 750:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 753:	75 0c                	jne    761 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 755:	8b 45 f4             	mov    -0xc(%ebp),%eax
 758:	8b 10                	mov    (%eax),%edx
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	89 10                	mov    %edx,(%eax)
 75f:	eb 26                	jmp    787 <malloc+0x96>
      else {
        p->s.size -= nunits;
 761:	8b 45 f4             	mov    -0xc(%ebp),%eax
 764:	8b 40 04             	mov    0x4(%eax),%eax
 767:	2b 45 ec             	sub    -0x14(%ebp),%eax
 76a:	89 c2                	mov    %eax,%edx
 76c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	8b 40 04             	mov    0x4(%eax),%eax
 778:	c1 e0 03             	shl    $0x3,%eax
 77b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	8b 55 ec             	mov    -0x14(%ebp),%edx
 784:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 787:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78a:	a3 40 0a 00 00       	mov    %eax,0xa40
      return (void*)(p + 1);
 78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 792:	83 c0 08             	add    $0x8,%eax
 795:	eb 3b                	jmp    7d2 <malloc+0xe1>
    }
    if(p == freep)
 797:	a1 40 0a 00 00       	mov    0xa40,%eax
 79c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 79f:	75 1e                	jne    7bf <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7a1:	83 ec 0c             	sub    $0xc,%esp
 7a4:	ff 75 ec             	pushl  -0x14(%ebp)
 7a7:	e8 e5 fe ff ff       	call   691 <morecore>
 7ac:	83 c4 10             	add    $0x10,%esp
 7af:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7b6:	75 07                	jne    7bf <malloc+0xce>
        return 0;
 7b8:	b8 00 00 00 00       	mov    $0x0,%eax
 7bd:	eb 13                	jmp    7d2 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	8b 00                	mov    (%eax),%eax
 7ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7cd:	e9 6d ff ff ff       	jmp    73f <malloc+0x4e>
}
 7d2:	c9                   	leave  
 7d3:	c3                   	ret    
