
_randX:     file format elf32-i386


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

  printf(1,"%d\n" ,randomX());
  11:	e8 0f 03 00 00       	call   325 <randomX>
  16:	83 ec 04             	sub    $0x4,%esp
  19:	50                   	push   %eax
  1a:	68 c2 07 00 00       	push   $0x7c2
  1f:	6a 01                	push   $0x1
  21:	e8 e6 03 00 00       	call   40c <printf>
  26:	83 c4 10             	add    $0x10,%esp
  exit();
  29:	e8 57 02 00 00       	call   285 <exit>

0000002e <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2e:	55                   	push   %ebp
  2f:	89 e5                	mov    %esp,%ebp
  31:	57                   	push   %edi
  32:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  33:	8b 4d 08             	mov    0x8(%ebp),%ecx
  36:	8b 55 10             	mov    0x10(%ebp),%edx
  39:	8b 45 0c             	mov    0xc(%ebp),%eax
  3c:	89 cb                	mov    %ecx,%ebx
  3e:	89 df                	mov    %ebx,%edi
  40:	89 d1                	mov    %edx,%ecx
  42:	fc                   	cld    
  43:	f3 aa                	rep stos %al,%es:(%edi)
  45:	89 ca                	mov    %ecx,%edx
  47:	89 fb                	mov    %edi,%ebx
  49:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4c:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4f:	90                   	nop
  50:	5b                   	pop    %ebx
  51:	5f                   	pop    %edi
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    

00000054 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  54:	55                   	push   %ebp
  55:	89 e5                	mov    %esp,%ebp
  57:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  5a:	8b 45 08             	mov    0x8(%ebp),%eax
  5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  60:	90                   	nop
  61:	8b 45 08             	mov    0x8(%ebp),%eax
  64:	8d 50 01             	lea    0x1(%eax),%edx
  67:	89 55 08             	mov    %edx,0x8(%ebp)
  6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  6d:	8d 4a 01             	lea    0x1(%edx),%ecx
  70:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  73:	0f b6 12             	movzbl (%edx),%edx
  76:	88 10                	mov    %dl,(%eax)
  78:	0f b6 00             	movzbl (%eax),%eax
  7b:	84 c0                	test   %al,%al
  7d:	75 e2                	jne    61 <strcpy+0xd>
    ;
  return os;
  7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  82:	c9                   	leave  
  83:	c3                   	ret    

00000084 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  87:	eb 08                	jmp    91 <strcmp+0xd>
    p++, q++;
  89:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  91:	8b 45 08             	mov    0x8(%ebp),%eax
  94:	0f b6 00             	movzbl (%eax),%eax
  97:	84 c0                	test   %al,%al
  99:	74 10                	je     ab <strcmp+0x27>
  9b:	8b 45 08             	mov    0x8(%ebp),%eax
  9e:	0f b6 10             	movzbl (%eax),%edx
  a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  a4:	0f b6 00             	movzbl (%eax),%eax
  a7:	38 c2                	cmp    %al,%dl
  a9:	74 de                	je     89 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ab:	8b 45 08             	mov    0x8(%ebp),%eax
  ae:	0f b6 00             	movzbl (%eax),%eax
  b1:	0f b6 d0             	movzbl %al,%edx
  b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  b7:	0f b6 00             	movzbl (%eax),%eax
  ba:	0f b6 c0             	movzbl %al,%eax
  bd:	29 c2                	sub    %eax,%edx
  bf:	89 d0                	mov    %edx,%eax
}
  c1:	5d                   	pop    %ebp
  c2:	c3                   	ret    

000000c3 <strlen>:

uint
strlen(char *s)
{
  c3:	55                   	push   %ebp
  c4:	89 e5                	mov    %esp,%ebp
  c6:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  d0:	eb 04                	jmp    d6 <strlen+0x13>
  d2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d9:	8b 45 08             	mov    0x8(%ebp),%eax
  dc:	01 d0                	add    %edx,%eax
  de:	0f b6 00             	movzbl (%eax),%eax
  e1:	84 c0                	test   %al,%al
  e3:	75 ed                	jne    d2 <strlen+0xf>
    ;
  return n;
  e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e8:	c9                   	leave  
  e9:	c3                   	ret    

000000ea <memset>:

void*
memset(void *dst, int c, uint n)
{
  ea:	55                   	push   %ebp
  eb:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  ed:	8b 45 10             	mov    0x10(%ebp),%eax
  f0:	50                   	push   %eax
  f1:	ff 75 0c             	pushl  0xc(%ebp)
  f4:	ff 75 08             	pushl  0x8(%ebp)
  f7:	e8 32 ff ff ff       	call   2e <stosb>
  fc:	83 c4 0c             	add    $0xc,%esp
  return dst;
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
 102:	c9                   	leave  
 103:	c3                   	ret    

00000104 <strchr>:

char*
strchr(const char *s, char c)
{
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	83 ec 04             	sub    $0x4,%esp
 10a:	8b 45 0c             	mov    0xc(%ebp),%eax
 10d:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 110:	eb 14                	jmp    126 <strchr+0x22>
    if(*s == c)
 112:	8b 45 08             	mov    0x8(%ebp),%eax
 115:	0f b6 00             	movzbl (%eax),%eax
 118:	3a 45 fc             	cmp    -0x4(%ebp),%al
 11b:	75 05                	jne    122 <strchr+0x1e>
      return (char*)s;
 11d:	8b 45 08             	mov    0x8(%ebp),%eax
 120:	eb 13                	jmp    135 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 122:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 126:	8b 45 08             	mov    0x8(%ebp),%eax
 129:	0f b6 00             	movzbl (%eax),%eax
 12c:	84 c0                	test   %al,%al
 12e:	75 e2                	jne    112 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 130:	b8 00 00 00 00       	mov    $0x0,%eax
}
 135:	c9                   	leave  
 136:	c3                   	ret    

00000137 <gets>:

char*
gets(char *buf, int max)
{
 137:	55                   	push   %ebp
 138:	89 e5                	mov    %esp,%ebp
 13a:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 144:	eb 42                	jmp    188 <gets+0x51>
    cc = read(0, &c, 1);
 146:	83 ec 04             	sub    $0x4,%esp
 149:	6a 01                	push   $0x1
 14b:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14e:	50                   	push   %eax
 14f:	6a 00                	push   $0x0
 151:	e8 47 01 00 00       	call   29d <read>
 156:	83 c4 10             	add    $0x10,%esp
 159:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 15c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 160:	7e 33                	jle    195 <gets+0x5e>
      break;
    buf[i++] = c;
 162:	8b 45 f4             	mov    -0xc(%ebp),%eax
 165:	8d 50 01             	lea    0x1(%eax),%edx
 168:	89 55 f4             	mov    %edx,-0xc(%ebp)
 16b:	89 c2                	mov    %eax,%edx
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	01 c2                	add    %eax,%edx
 172:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 176:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 178:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17c:	3c 0a                	cmp    $0xa,%al
 17e:	74 16                	je     196 <gets+0x5f>
 180:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 184:	3c 0d                	cmp    $0xd,%al
 186:	74 0e                	je     196 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 188:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18b:	83 c0 01             	add    $0x1,%eax
 18e:	3b 45 0c             	cmp    0xc(%ebp),%eax
 191:	7c b3                	jl     146 <gets+0xf>
 193:	eb 01                	jmp    196 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 195:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 196:	8b 55 f4             	mov    -0xc(%ebp),%edx
 199:	8b 45 08             	mov    0x8(%ebp),%eax
 19c:	01 d0                	add    %edx,%eax
 19e:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1a1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a4:	c9                   	leave  
 1a5:	c3                   	ret    

000001a6 <stat>:

int
stat(char *n, struct stat *st)
{
 1a6:	55                   	push   %ebp
 1a7:	89 e5                	mov    %esp,%ebp
 1a9:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ac:	83 ec 08             	sub    $0x8,%esp
 1af:	6a 00                	push   $0x0
 1b1:	ff 75 08             	pushl  0x8(%ebp)
 1b4:	e8 0c 01 00 00       	call   2c5 <open>
 1b9:	83 c4 10             	add    $0x10,%esp
 1bc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c3:	79 07                	jns    1cc <stat+0x26>
    return -1;
 1c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1ca:	eb 25                	jmp    1f1 <stat+0x4b>
  r = fstat(fd, st);
 1cc:	83 ec 08             	sub    $0x8,%esp
 1cf:	ff 75 0c             	pushl  0xc(%ebp)
 1d2:	ff 75 f4             	pushl  -0xc(%ebp)
 1d5:	e8 03 01 00 00       	call   2dd <fstat>
 1da:	83 c4 10             	add    $0x10,%esp
 1dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e0:	83 ec 0c             	sub    $0xc,%esp
 1e3:	ff 75 f4             	pushl  -0xc(%ebp)
 1e6:	e8 c2 00 00 00       	call   2ad <close>
 1eb:	83 c4 10             	add    $0x10,%esp
  return r;
 1ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1f1:	c9                   	leave  
 1f2:	c3                   	ret    

000001f3 <atoi>:

int
atoi(const char *s)
{
 1f3:	55                   	push   %ebp
 1f4:	89 e5                	mov    %esp,%ebp
 1f6:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 200:	eb 25                	jmp    227 <atoi+0x34>
    n = n*10 + *s++ - '0';
 202:	8b 55 fc             	mov    -0x4(%ebp),%edx
 205:	89 d0                	mov    %edx,%eax
 207:	c1 e0 02             	shl    $0x2,%eax
 20a:	01 d0                	add    %edx,%eax
 20c:	01 c0                	add    %eax,%eax
 20e:	89 c1                	mov    %eax,%ecx
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	8d 50 01             	lea    0x1(%eax),%edx
 216:	89 55 08             	mov    %edx,0x8(%ebp)
 219:	0f b6 00             	movzbl (%eax),%eax
 21c:	0f be c0             	movsbl %al,%eax
 21f:	01 c8                	add    %ecx,%eax
 221:	83 e8 30             	sub    $0x30,%eax
 224:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 227:	8b 45 08             	mov    0x8(%ebp),%eax
 22a:	0f b6 00             	movzbl (%eax),%eax
 22d:	3c 2f                	cmp    $0x2f,%al
 22f:	7e 0a                	jle    23b <atoi+0x48>
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	0f b6 00             	movzbl (%eax),%eax
 237:	3c 39                	cmp    $0x39,%al
 239:	7e c7                	jle    202 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 23b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23e:	c9                   	leave  
 23f:	c3                   	ret    

00000240 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 246:	8b 45 08             	mov    0x8(%ebp),%eax
 249:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24c:	8b 45 0c             	mov    0xc(%ebp),%eax
 24f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 252:	eb 17                	jmp    26b <memmove+0x2b>
    *dst++ = *src++;
 254:	8b 45 fc             	mov    -0x4(%ebp),%eax
 257:	8d 50 01             	lea    0x1(%eax),%edx
 25a:	89 55 fc             	mov    %edx,-0x4(%ebp)
 25d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 260:	8d 4a 01             	lea    0x1(%edx),%ecx
 263:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 266:	0f b6 12             	movzbl (%edx),%edx
 269:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 26b:	8b 45 10             	mov    0x10(%ebp),%eax
 26e:	8d 50 ff             	lea    -0x1(%eax),%edx
 271:	89 55 10             	mov    %edx,0x10(%ebp)
 274:	85 c0                	test   %eax,%eax
 276:	7f dc                	jg     254 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 278:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27b:	c9                   	leave  
 27c:	c3                   	ret    

0000027d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 27d:	b8 01 00 00 00       	mov    $0x1,%eax
 282:	cd 40                	int    $0x40
 284:	c3                   	ret    

00000285 <exit>:
SYSCALL(exit)
 285:	b8 02 00 00 00       	mov    $0x2,%eax
 28a:	cd 40                	int    $0x40
 28c:	c3                   	ret    

0000028d <wait>:
SYSCALL(wait)
 28d:	b8 03 00 00 00       	mov    $0x3,%eax
 292:	cd 40                	int    $0x40
 294:	c3                   	ret    

00000295 <pipe>:
SYSCALL(pipe)
 295:	b8 04 00 00 00       	mov    $0x4,%eax
 29a:	cd 40                	int    $0x40
 29c:	c3                   	ret    

0000029d <read>:
SYSCALL(read)
 29d:	b8 05 00 00 00       	mov    $0x5,%eax
 2a2:	cd 40                	int    $0x40
 2a4:	c3                   	ret    

000002a5 <write>:
SYSCALL(write)
 2a5:	b8 10 00 00 00       	mov    $0x10,%eax
 2aa:	cd 40                	int    $0x40
 2ac:	c3                   	ret    

000002ad <close>:
SYSCALL(close)
 2ad:	b8 15 00 00 00       	mov    $0x15,%eax
 2b2:	cd 40                	int    $0x40
 2b4:	c3                   	ret    

000002b5 <kill>:
SYSCALL(kill)
 2b5:	b8 06 00 00 00       	mov    $0x6,%eax
 2ba:	cd 40                	int    $0x40
 2bc:	c3                   	ret    

000002bd <exec>:
SYSCALL(exec)
 2bd:	b8 07 00 00 00       	mov    $0x7,%eax
 2c2:	cd 40                	int    $0x40
 2c4:	c3                   	ret    

000002c5 <open>:
SYSCALL(open)
 2c5:	b8 0f 00 00 00       	mov    $0xf,%eax
 2ca:	cd 40                	int    $0x40
 2cc:	c3                   	ret    

000002cd <mknod>:
SYSCALL(mknod)
 2cd:	b8 11 00 00 00       	mov    $0x11,%eax
 2d2:	cd 40                	int    $0x40
 2d4:	c3                   	ret    

000002d5 <unlink>:
SYSCALL(unlink)
 2d5:	b8 12 00 00 00       	mov    $0x12,%eax
 2da:	cd 40                	int    $0x40
 2dc:	c3                   	ret    

000002dd <fstat>:
SYSCALL(fstat)
 2dd:	b8 08 00 00 00       	mov    $0x8,%eax
 2e2:	cd 40                	int    $0x40
 2e4:	c3                   	ret    

000002e5 <link>:
SYSCALL(link)
 2e5:	b8 13 00 00 00       	mov    $0x13,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <mkdir>:
SYSCALL(mkdir)
 2ed:	b8 14 00 00 00       	mov    $0x14,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <chdir>:
SYSCALL(chdir)
 2f5:	b8 09 00 00 00       	mov    $0x9,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <dup>:
SYSCALL(dup)
 2fd:	b8 0a 00 00 00       	mov    $0xa,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <getpid>:
SYSCALL(getpid)
 305:	b8 0b 00 00 00       	mov    $0xb,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <sbrk>:
SYSCALL(sbrk)
 30d:	b8 0c 00 00 00       	mov    $0xc,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <sleep>:
SYSCALL(sleep)
 315:	b8 0d 00 00 00       	mov    $0xd,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <uptime>:
SYSCALL(uptime)
 31d:	b8 0e 00 00 00       	mov    $0xe,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <randomX>:
SYSCALL(randomX)
 325:	b8 16 00 00 00       	mov    $0x16,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <setSeedX>:
SYSCALL(setSeedX)
 32d:	b8 17 00 00 00       	mov    $0x17,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 335:	55                   	push   %ebp
 336:	89 e5                	mov    %esp,%ebp
 338:	83 ec 18             	sub    $0x18,%esp
 33b:	8b 45 0c             	mov    0xc(%ebp),%eax
 33e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 341:	83 ec 04             	sub    $0x4,%esp
 344:	6a 01                	push   $0x1
 346:	8d 45 f4             	lea    -0xc(%ebp),%eax
 349:	50                   	push   %eax
 34a:	ff 75 08             	pushl  0x8(%ebp)
 34d:	e8 53 ff ff ff       	call   2a5 <write>
 352:	83 c4 10             	add    $0x10,%esp
}
 355:	90                   	nop
 356:	c9                   	leave  
 357:	c3                   	ret    

00000358 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 358:	55                   	push   %ebp
 359:	89 e5                	mov    %esp,%ebp
 35b:	53                   	push   %ebx
 35c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 35f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 366:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 36a:	74 17                	je     383 <printint+0x2b>
 36c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 370:	79 11                	jns    383 <printint+0x2b>
    neg = 1;
 372:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 379:	8b 45 0c             	mov    0xc(%ebp),%eax
 37c:	f7 d8                	neg    %eax
 37e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 381:	eb 06                	jmp    389 <printint+0x31>
  } else {
    x = xx;
 383:	8b 45 0c             	mov    0xc(%ebp),%eax
 386:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 389:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 390:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 393:	8d 41 01             	lea    0x1(%ecx),%eax
 396:	89 45 f4             	mov    %eax,-0xc(%ebp)
 399:	8b 5d 10             	mov    0x10(%ebp),%ebx
 39c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 39f:	ba 00 00 00 00       	mov    $0x0,%edx
 3a4:	f7 f3                	div    %ebx
 3a6:	89 d0                	mov    %edx,%eax
 3a8:	0f b6 80 18 0a 00 00 	movzbl 0xa18(%eax),%eax
 3af:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3b3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3b9:	ba 00 00 00 00       	mov    $0x0,%edx
 3be:	f7 f3                	div    %ebx
 3c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3c3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3c7:	75 c7                	jne    390 <printint+0x38>
  if(neg)
 3c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3cd:	74 2d                	je     3fc <printint+0xa4>
    buf[i++] = '-';
 3cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3d2:	8d 50 01             	lea    0x1(%eax),%edx
 3d5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3d8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3dd:	eb 1d                	jmp    3fc <printint+0xa4>
    putc(fd, buf[i]);
 3df:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e5:	01 d0                	add    %edx,%eax
 3e7:	0f b6 00             	movzbl (%eax),%eax
 3ea:	0f be c0             	movsbl %al,%eax
 3ed:	83 ec 08             	sub    $0x8,%esp
 3f0:	50                   	push   %eax
 3f1:	ff 75 08             	pushl  0x8(%ebp)
 3f4:	e8 3c ff ff ff       	call   335 <putc>
 3f9:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3fc:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 400:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 404:	79 d9                	jns    3df <printint+0x87>
    putc(fd, buf[i]);
}
 406:	90                   	nop
 407:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 40a:	c9                   	leave  
 40b:	c3                   	ret    

0000040c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 40c:	55                   	push   %ebp
 40d:	89 e5                	mov    %esp,%ebp
 40f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 412:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 419:	8d 45 0c             	lea    0xc(%ebp),%eax
 41c:	83 c0 04             	add    $0x4,%eax
 41f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 422:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 429:	e9 59 01 00 00       	jmp    587 <printf+0x17b>
    c = fmt[i] & 0xff;
 42e:	8b 55 0c             	mov    0xc(%ebp),%edx
 431:	8b 45 f0             	mov    -0x10(%ebp),%eax
 434:	01 d0                	add    %edx,%eax
 436:	0f b6 00             	movzbl (%eax),%eax
 439:	0f be c0             	movsbl %al,%eax
 43c:	25 ff 00 00 00       	and    $0xff,%eax
 441:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 444:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 448:	75 2c                	jne    476 <printf+0x6a>
      if(c == '%'){
 44a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 44e:	75 0c                	jne    45c <printf+0x50>
        state = '%';
 450:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 457:	e9 27 01 00 00       	jmp    583 <printf+0x177>
      } else {
        putc(fd, c);
 45c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 45f:	0f be c0             	movsbl %al,%eax
 462:	83 ec 08             	sub    $0x8,%esp
 465:	50                   	push   %eax
 466:	ff 75 08             	pushl  0x8(%ebp)
 469:	e8 c7 fe ff ff       	call   335 <putc>
 46e:	83 c4 10             	add    $0x10,%esp
 471:	e9 0d 01 00 00       	jmp    583 <printf+0x177>
      }
    } else if(state == '%'){
 476:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 47a:	0f 85 03 01 00 00    	jne    583 <printf+0x177>
      if(c == 'd'){
 480:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 484:	75 1e                	jne    4a4 <printf+0x98>
        printint(fd, *ap, 10, 1);
 486:	8b 45 e8             	mov    -0x18(%ebp),%eax
 489:	8b 00                	mov    (%eax),%eax
 48b:	6a 01                	push   $0x1
 48d:	6a 0a                	push   $0xa
 48f:	50                   	push   %eax
 490:	ff 75 08             	pushl  0x8(%ebp)
 493:	e8 c0 fe ff ff       	call   358 <printint>
 498:	83 c4 10             	add    $0x10,%esp
        ap++;
 49b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 49f:	e9 d8 00 00 00       	jmp    57c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4a4:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4a8:	74 06                	je     4b0 <printf+0xa4>
 4aa:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4ae:	75 1e                	jne    4ce <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b3:	8b 00                	mov    (%eax),%eax
 4b5:	6a 00                	push   $0x0
 4b7:	6a 10                	push   $0x10
 4b9:	50                   	push   %eax
 4ba:	ff 75 08             	pushl  0x8(%ebp)
 4bd:	e8 96 fe ff ff       	call   358 <printint>
 4c2:	83 c4 10             	add    $0x10,%esp
        ap++;
 4c5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4c9:	e9 ae 00 00 00       	jmp    57c <printf+0x170>
      } else if(c == 's'){
 4ce:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4d2:	75 43                	jne    517 <printf+0x10b>
        s = (char*)*ap;
 4d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d7:	8b 00                	mov    (%eax),%eax
 4d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4dc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4e0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e4:	75 25                	jne    50b <printf+0xff>
          s = "(null)";
 4e6:	c7 45 f4 c6 07 00 00 	movl   $0x7c6,-0xc(%ebp)
        while(*s != 0){
 4ed:	eb 1c                	jmp    50b <printf+0xff>
          putc(fd, *s);
 4ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f2:	0f b6 00             	movzbl (%eax),%eax
 4f5:	0f be c0             	movsbl %al,%eax
 4f8:	83 ec 08             	sub    $0x8,%esp
 4fb:	50                   	push   %eax
 4fc:	ff 75 08             	pushl  0x8(%ebp)
 4ff:	e8 31 fe ff ff       	call   335 <putc>
 504:	83 c4 10             	add    $0x10,%esp
          s++;
 507:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 50b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50e:	0f b6 00             	movzbl (%eax),%eax
 511:	84 c0                	test   %al,%al
 513:	75 da                	jne    4ef <printf+0xe3>
 515:	eb 65                	jmp    57c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 517:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 51b:	75 1d                	jne    53a <printf+0x12e>
        putc(fd, *ap);
 51d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 520:	8b 00                	mov    (%eax),%eax
 522:	0f be c0             	movsbl %al,%eax
 525:	83 ec 08             	sub    $0x8,%esp
 528:	50                   	push   %eax
 529:	ff 75 08             	pushl  0x8(%ebp)
 52c:	e8 04 fe ff ff       	call   335 <putc>
 531:	83 c4 10             	add    $0x10,%esp
        ap++;
 534:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 538:	eb 42                	jmp    57c <printf+0x170>
      } else if(c == '%'){
 53a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 53e:	75 17                	jne    557 <printf+0x14b>
        putc(fd, c);
 540:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 543:	0f be c0             	movsbl %al,%eax
 546:	83 ec 08             	sub    $0x8,%esp
 549:	50                   	push   %eax
 54a:	ff 75 08             	pushl  0x8(%ebp)
 54d:	e8 e3 fd ff ff       	call   335 <putc>
 552:	83 c4 10             	add    $0x10,%esp
 555:	eb 25                	jmp    57c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 557:	83 ec 08             	sub    $0x8,%esp
 55a:	6a 25                	push   $0x25
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 d1 fd ff ff       	call   335 <putc>
 564:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 567:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56a:	0f be c0             	movsbl %al,%eax
 56d:	83 ec 08             	sub    $0x8,%esp
 570:	50                   	push   %eax
 571:	ff 75 08             	pushl  0x8(%ebp)
 574:	e8 bc fd ff ff       	call   335 <putc>
 579:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 57c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 583:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 587:	8b 55 0c             	mov    0xc(%ebp),%edx
 58a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 58d:	01 d0                	add    %edx,%eax
 58f:	0f b6 00             	movzbl (%eax),%eax
 592:	84 c0                	test   %al,%al
 594:	0f 85 94 fe ff ff    	jne    42e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 59a:	90                   	nop
 59b:	c9                   	leave  
 59c:	c3                   	ret    

0000059d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 59d:	55                   	push   %ebp
 59e:	89 e5                	mov    %esp,%ebp
 5a0:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a3:	8b 45 08             	mov    0x8(%ebp),%eax
 5a6:	83 e8 08             	sub    $0x8,%eax
 5a9:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ac:	a1 34 0a 00 00       	mov    0xa34,%eax
 5b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5b4:	eb 24                	jmp    5da <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5b9:	8b 00                	mov    (%eax),%eax
 5bb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5be:	77 12                	ja     5d2 <free+0x35>
 5c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5c6:	77 24                	ja     5ec <free+0x4f>
 5c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cb:	8b 00                	mov    (%eax),%eax
 5cd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5d0:	77 1a                	ja     5ec <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d5:	8b 00                	mov    (%eax),%eax
 5d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5dd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e0:	76 d4                	jbe    5b6 <free+0x19>
 5e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e5:	8b 00                	mov    (%eax),%eax
 5e7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5ea:	76 ca                	jbe    5b6 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ef:	8b 40 04             	mov    0x4(%eax),%eax
 5f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fc:	01 c2                	add    %eax,%edx
 5fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 601:	8b 00                	mov    (%eax),%eax
 603:	39 c2                	cmp    %eax,%edx
 605:	75 24                	jne    62b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 607:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60a:	8b 50 04             	mov    0x4(%eax),%edx
 60d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 610:	8b 00                	mov    (%eax),%eax
 612:	8b 40 04             	mov    0x4(%eax),%eax
 615:	01 c2                	add    %eax,%edx
 617:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 620:	8b 00                	mov    (%eax),%eax
 622:	8b 10                	mov    (%eax),%edx
 624:	8b 45 f8             	mov    -0x8(%ebp),%eax
 627:	89 10                	mov    %edx,(%eax)
 629:	eb 0a                	jmp    635 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 62b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62e:	8b 10                	mov    (%eax),%edx
 630:	8b 45 f8             	mov    -0x8(%ebp),%eax
 633:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 635:	8b 45 fc             	mov    -0x4(%ebp),%eax
 638:	8b 40 04             	mov    0x4(%eax),%eax
 63b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 642:	8b 45 fc             	mov    -0x4(%ebp),%eax
 645:	01 d0                	add    %edx,%eax
 647:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 64a:	75 20                	jne    66c <free+0xcf>
    p->s.size += bp->s.size;
 64c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64f:	8b 50 04             	mov    0x4(%eax),%edx
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	8b 40 04             	mov    0x4(%eax),%eax
 658:	01 c2                	add    %eax,%edx
 65a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	8b 10                	mov    (%eax),%edx
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	89 10                	mov    %edx,(%eax)
 66a:	eb 08                	jmp    674 <free+0xd7>
  } else
    p->s.ptr = bp;
 66c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 672:	89 10                	mov    %edx,(%eax)
  freep = p;
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	a3 34 0a 00 00       	mov    %eax,0xa34
}
 67c:	90                   	nop
 67d:	c9                   	leave  
 67e:	c3                   	ret    

0000067f <morecore>:

static Header*
morecore(uint nu)
{
 67f:	55                   	push   %ebp
 680:	89 e5                	mov    %esp,%ebp
 682:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 685:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 68c:	77 07                	ja     695 <morecore+0x16>
    nu = 4096;
 68e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 695:	8b 45 08             	mov    0x8(%ebp),%eax
 698:	c1 e0 03             	shl    $0x3,%eax
 69b:	83 ec 0c             	sub    $0xc,%esp
 69e:	50                   	push   %eax
 69f:	e8 69 fc ff ff       	call   30d <sbrk>
 6a4:	83 c4 10             	add    $0x10,%esp
 6a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6aa:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ae:	75 07                	jne    6b7 <morecore+0x38>
    return 0;
 6b0:	b8 00 00 00 00       	mov    $0x0,%eax
 6b5:	eb 26                	jmp    6dd <morecore+0x5e>
  hp = (Header*)p;
 6b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ba:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c0:	8b 55 08             	mov    0x8(%ebp),%edx
 6c3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c9:	83 c0 08             	add    $0x8,%eax
 6cc:	83 ec 0c             	sub    $0xc,%esp
 6cf:	50                   	push   %eax
 6d0:	e8 c8 fe ff ff       	call   59d <free>
 6d5:	83 c4 10             	add    $0x10,%esp
  return freep;
 6d8:	a1 34 0a 00 00       	mov    0xa34,%eax
}
 6dd:	c9                   	leave  
 6de:	c3                   	ret    

000006df <malloc>:

void*
malloc(uint nbytes)
{
 6df:	55                   	push   %ebp
 6e0:	89 e5                	mov    %esp,%ebp
 6e2:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e5:	8b 45 08             	mov    0x8(%ebp),%eax
 6e8:	83 c0 07             	add    $0x7,%eax
 6eb:	c1 e8 03             	shr    $0x3,%eax
 6ee:	83 c0 01             	add    $0x1,%eax
 6f1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6f4:	a1 34 0a 00 00       	mov    0xa34,%eax
 6f9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 700:	75 23                	jne    725 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 702:	c7 45 f0 2c 0a 00 00 	movl   $0xa2c,-0x10(%ebp)
 709:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70c:	a3 34 0a 00 00       	mov    %eax,0xa34
 711:	a1 34 0a 00 00       	mov    0xa34,%eax
 716:	a3 2c 0a 00 00       	mov    %eax,0xa2c
    base.s.size = 0;
 71b:	c7 05 30 0a 00 00 00 	movl   $0x0,0xa30
 722:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 725:	8b 45 f0             	mov    -0x10(%ebp),%eax
 728:	8b 00                	mov    (%eax),%eax
 72a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8b 40 04             	mov    0x4(%eax),%eax
 733:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 736:	72 4d                	jb     785 <malloc+0xa6>
      if(p->s.size == nunits)
 738:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 741:	75 0c                	jne    74f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 743:	8b 45 f4             	mov    -0xc(%ebp),%eax
 746:	8b 10                	mov    (%eax),%edx
 748:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74b:	89 10                	mov    %edx,(%eax)
 74d:	eb 26                	jmp    775 <malloc+0x96>
      else {
        p->s.size -= nunits;
 74f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 752:	8b 40 04             	mov    0x4(%eax),%eax
 755:	2b 45 ec             	sub    -0x14(%ebp),%eax
 758:	89 c2                	mov    %eax,%edx
 75a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	8b 40 04             	mov    0x4(%eax),%eax
 766:	c1 e0 03             	shl    $0x3,%eax
 769:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 76c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 772:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 775:	8b 45 f0             	mov    -0x10(%ebp),%eax
 778:	a3 34 0a 00 00       	mov    %eax,0xa34
      return (void*)(p + 1);
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	83 c0 08             	add    $0x8,%eax
 783:	eb 3b                	jmp    7c0 <malloc+0xe1>
    }
    if(p == freep)
 785:	a1 34 0a 00 00       	mov    0xa34,%eax
 78a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 78d:	75 1e                	jne    7ad <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 78f:	83 ec 0c             	sub    $0xc,%esp
 792:	ff 75 ec             	pushl  -0x14(%ebp)
 795:	e8 e5 fe ff ff       	call   67f <morecore>
 79a:	83 c4 10             	add    $0x10,%esp
 79d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a4:	75 07                	jne    7ad <malloc+0xce>
        return 0;
 7a6:	b8 00 00 00 00       	mov    $0x0,%eax
 7ab:	eb 13                	jmp    7c0 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b6:	8b 00                	mov    (%eax),%eax
 7b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7bb:	e9 6d ff ff ff       	jmp    72d <malloc+0x4e>
}
 7c0:	c9                   	leave  
 7c1:	c3                   	ret    
