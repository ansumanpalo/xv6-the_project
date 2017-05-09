
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
  14:	68 c4 07 00 00       	push   $0x7c4
  19:	6a 01                	push   $0x1
  1b:	e8 ee 03 00 00       	call   40e <printf>
  20:	83 c4 10             	add    $0x10,%esp
 exit();
  23:	e8 57 02 00 00       	call   27f <exit>

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
 14b:	e8 47 01 00 00       	call   297 <read>
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
 1ae:	e8 0c 01 00 00       	call   2bf <open>
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
 1cf:	e8 03 01 00 00       	call   2d7 <fstat>
 1d4:	83 c4 10             	add    $0x10,%esp
 1d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1da:	83 ec 0c             	sub    $0xc,%esp
 1dd:	ff 75 f4             	pushl  -0xc(%ebp)
 1e0:	e8 c2 00 00 00       	call   2a7 <close>
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

0000023a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 23a:	55                   	push   %ebp
 23b:	89 e5                	mov    %esp,%ebp
 23d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 246:	8b 45 0c             	mov    0xc(%ebp),%eax
 249:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 24c:	eb 17                	jmp    265 <memmove+0x2b>
    *dst++ = *src++;
 24e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 251:	8d 50 01             	lea    0x1(%eax),%edx
 254:	89 55 fc             	mov    %edx,-0x4(%ebp)
 257:	8b 55 f8             	mov    -0x8(%ebp),%edx
 25a:	8d 4a 01             	lea    0x1(%edx),%ecx
 25d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 260:	0f b6 12             	movzbl (%edx),%edx
 263:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 265:	8b 45 10             	mov    0x10(%ebp),%eax
 268:	8d 50 ff             	lea    -0x1(%eax),%edx
 26b:	89 55 10             	mov    %edx,0x10(%ebp)
 26e:	85 c0                	test   %eax,%eax
 270:	7f dc                	jg     24e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 272:	8b 45 08             	mov    0x8(%ebp),%eax
}
 275:	c9                   	leave  
 276:	c3                   	ret    

00000277 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 277:	b8 01 00 00 00       	mov    $0x1,%eax
 27c:	cd 40                	int    $0x40
 27e:	c3                   	ret    

0000027f <exit>:
SYSCALL(exit)
 27f:	b8 02 00 00 00       	mov    $0x2,%eax
 284:	cd 40                	int    $0x40
 286:	c3                   	ret    

00000287 <wait>:
SYSCALL(wait)
 287:	b8 03 00 00 00       	mov    $0x3,%eax
 28c:	cd 40                	int    $0x40
 28e:	c3                   	ret    

0000028f <pipe>:
SYSCALL(pipe)
 28f:	b8 04 00 00 00       	mov    $0x4,%eax
 294:	cd 40                	int    $0x40
 296:	c3                   	ret    

00000297 <read>:
SYSCALL(read)
 297:	b8 05 00 00 00       	mov    $0x5,%eax
 29c:	cd 40                	int    $0x40
 29e:	c3                   	ret    

0000029f <write>:
SYSCALL(write)
 29f:	b8 10 00 00 00       	mov    $0x10,%eax
 2a4:	cd 40                	int    $0x40
 2a6:	c3                   	ret    

000002a7 <close>:
SYSCALL(close)
 2a7:	b8 15 00 00 00       	mov    $0x15,%eax
 2ac:	cd 40                	int    $0x40
 2ae:	c3                   	ret    

000002af <kill>:
SYSCALL(kill)
 2af:	b8 06 00 00 00       	mov    $0x6,%eax
 2b4:	cd 40                	int    $0x40
 2b6:	c3                   	ret    

000002b7 <exec>:
SYSCALL(exec)
 2b7:	b8 07 00 00 00       	mov    $0x7,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <open>:
SYSCALL(open)
 2bf:	b8 0f 00 00 00       	mov    $0xf,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <mknod>:
SYSCALL(mknod)
 2c7:	b8 11 00 00 00       	mov    $0x11,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <unlink>:
SYSCALL(unlink)
 2cf:	b8 12 00 00 00       	mov    $0x12,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <fstat>:
SYSCALL(fstat)
 2d7:	b8 08 00 00 00       	mov    $0x8,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <link>:
SYSCALL(link)
 2df:	b8 13 00 00 00       	mov    $0x13,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <mkdir>:
SYSCALL(mkdir)
 2e7:	b8 14 00 00 00       	mov    $0x14,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <chdir>:
SYSCALL(chdir)
 2ef:	b8 09 00 00 00       	mov    $0x9,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <dup>:
SYSCALL(dup)
 2f7:	b8 0a 00 00 00       	mov    $0xa,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <getpid>:
SYSCALL(getpid)
 2ff:	b8 0b 00 00 00       	mov    $0xb,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <sbrk>:
SYSCALL(sbrk)
 307:	b8 0c 00 00 00       	mov    $0xc,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <sleep>:
SYSCALL(sleep)
 30f:	b8 0d 00 00 00       	mov    $0xd,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <uptime>:
SYSCALL(uptime)
 317:	b8 0e 00 00 00       	mov    $0xe,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <randomX>:
SYSCALL(randomX)
 31f:	b8 16 00 00 00       	mov    $0x16,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <setSeedX>:
SYSCALL(setSeedX)
 327:	b8 17 00 00 00       	mov    $0x17,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <uniformR>:
SYSCALL(uniformR)
 32f:	b8 18 00 00 00       	mov    $0x18,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 337:	55                   	push   %ebp
 338:	89 e5                	mov    %esp,%ebp
 33a:	83 ec 18             	sub    $0x18,%esp
 33d:	8b 45 0c             	mov    0xc(%ebp),%eax
 340:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 343:	83 ec 04             	sub    $0x4,%esp
 346:	6a 01                	push   $0x1
 348:	8d 45 f4             	lea    -0xc(%ebp),%eax
 34b:	50                   	push   %eax
 34c:	ff 75 08             	pushl  0x8(%ebp)
 34f:	e8 4b ff ff ff       	call   29f <write>
 354:	83 c4 10             	add    $0x10,%esp
}
 357:	90                   	nop
 358:	c9                   	leave  
 359:	c3                   	ret    

0000035a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 35a:	55                   	push   %ebp
 35b:	89 e5                	mov    %esp,%ebp
 35d:	53                   	push   %ebx
 35e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 361:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 368:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 36c:	74 17                	je     385 <printint+0x2b>
 36e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 372:	79 11                	jns    385 <printint+0x2b>
    neg = 1;
 374:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 37b:	8b 45 0c             	mov    0xc(%ebp),%eax
 37e:	f7 d8                	neg    %eax
 380:	89 45 ec             	mov    %eax,-0x14(%ebp)
 383:	eb 06                	jmp    38b <printint+0x31>
  } else {
    x = xx;
 385:	8b 45 0c             	mov    0xc(%ebp),%eax
 388:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 38b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 392:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 395:	8d 41 01             	lea    0x1(%ecx),%eax
 398:	89 45 f4             	mov    %eax,-0xc(%ebp)
 39b:	8b 5d 10             	mov    0x10(%ebp),%ebx
 39e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3a1:	ba 00 00 00 00       	mov    $0x0,%edx
 3a6:	f7 f3                	div    %ebx
 3a8:	89 d0                	mov    %edx,%eax
 3aa:	0f b6 80 30 0a 00 00 	movzbl 0xa30(%eax),%eax
 3b1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3b8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3bb:	ba 00 00 00 00       	mov    $0x0,%edx
 3c0:	f7 f3                	div    %ebx
 3c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3c9:	75 c7                	jne    392 <printint+0x38>
  if(neg)
 3cb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3cf:	74 2d                	je     3fe <printint+0xa4>
    buf[i++] = '-';
 3d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3d4:	8d 50 01             	lea    0x1(%eax),%edx
 3d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3da:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3df:	eb 1d                	jmp    3fe <printint+0xa4>
    putc(fd, buf[i]);
 3e1:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e7:	01 d0                	add    %edx,%eax
 3e9:	0f b6 00             	movzbl (%eax),%eax
 3ec:	0f be c0             	movsbl %al,%eax
 3ef:	83 ec 08             	sub    $0x8,%esp
 3f2:	50                   	push   %eax
 3f3:	ff 75 08             	pushl  0x8(%ebp)
 3f6:	e8 3c ff ff ff       	call   337 <putc>
 3fb:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3fe:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 402:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 406:	79 d9                	jns    3e1 <printint+0x87>
    putc(fd, buf[i]);
}
 408:	90                   	nop
 409:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 40c:	c9                   	leave  
 40d:	c3                   	ret    

0000040e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 40e:	55                   	push   %ebp
 40f:	89 e5                	mov    %esp,%ebp
 411:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 414:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 41b:	8d 45 0c             	lea    0xc(%ebp),%eax
 41e:	83 c0 04             	add    $0x4,%eax
 421:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 424:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 42b:	e9 59 01 00 00       	jmp    589 <printf+0x17b>
    c = fmt[i] & 0xff;
 430:	8b 55 0c             	mov    0xc(%ebp),%edx
 433:	8b 45 f0             	mov    -0x10(%ebp),%eax
 436:	01 d0                	add    %edx,%eax
 438:	0f b6 00             	movzbl (%eax),%eax
 43b:	0f be c0             	movsbl %al,%eax
 43e:	25 ff 00 00 00       	and    $0xff,%eax
 443:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 446:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 44a:	75 2c                	jne    478 <printf+0x6a>
      if(c == '%'){
 44c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 450:	75 0c                	jne    45e <printf+0x50>
        state = '%';
 452:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 459:	e9 27 01 00 00       	jmp    585 <printf+0x177>
      } else {
        putc(fd, c);
 45e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 461:	0f be c0             	movsbl %al,%eax
 464:	83 ec 08             	sub    $0x8,%esp
 467:	50                   	push   %eax
 468:	ff 75 08             	pushl  0x8(%ebp)
 46b:	e8 c7 fe ff ff       	call   337 <putc>
 470:	83 c4 10             	add    $0x10,%esp
 473:	e9 0d 01 00 00       	jmp    585 <printf+0x177>
      }
    } else if(state == '%'){
 478:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 47c:	0f 85 03 01 00 00    	jne    585 <printf+0x177>
      if(c == 'd'){
 482:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 486:	75 1e                	jne    4a6 <printf+0x98>
        printint(fd, *ap, 10, 1);
 488:	8b 45 e8             	mov    -0x18(%ebp),%eax
 48b:	8b 00                	mov    (%eax),%eax
 48d:	6a 01                	push   $0x1
 48f:	6a 0a                	push   $0xa
 491:	50                   	push   %eax
 492:	ff 75 08             	pushl  0x8(%ebp)
 495:	e8 c0 fe ff ff       	call   35a <printint>
 49a:	83 c4 10             	add    $0x10,%esp
        ap++;
 49d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4a1:	e9 d8 00 00 00       	jmp    57e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4a6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4aa:	74 06                	je     4b2 <printf+0xa4>
 4ac:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4b0:	75 1e                	jne    4d0 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4b5:	8b 00                	mov    (%eax),%eax
 4b7:	6a 00                	push   $0x0
 4b9:	6a 10                	push   $0x10
 4bb:	50                   	push   %eax
 4bc:	ff 75 08             	pushl  0x8(%ebp)
 4bf:	e8 96 fe ff ff       	call   35a <printint>
 4c4:	83 c4 10             	add    $0x10,%esp
        ap++;
 4c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4cb:	e9 ae 00 00 00       	jmp    57e <printf+0x170>
      } else if(c == 's'){
 4d0:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4d4:	75 43                	jne    519 <printf+0x10b>
        s = (char*)*ap;
 4d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d9:	8b 00                	mov    (%eax),%eax
 4db:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4de:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4e6:	75 25                	jne    50d <printf+0xff>
          s = "(null)";
 4e8:	c7 45 f4 df 07 00 00 	movl   $0x7df,-0xc(%ebp)
        while(*s != 0){
 4ef:	eb 1c                	jmp    50d <printf+0xff>
          putc(fd, *s);
 4f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f4:	0f b6 00             	movzbl (%eax),%eax
 4f7:	0f be c0             	movsbl %al,%eax
 4fa:	83 ec 08             	sub    $0x8,%esp
 4fd:	50                   	push   %eax
 4fe:	ff 75 08             	pushl  0x8(%ebp)
 501:	e8 31 fe ff ff       	call   337 <putc>
 506:	83 c4 10             	add    $0x10,%esp
          s++;
 509:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 50d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 510:	0f b6 00             	movzbl (%eax),%eax
 513:	84 c0                	test   %al,%al
 515:	75 da                	jne    4f1 <printf+0xe3>
 517:	eb 65                	jmp    57e <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 519:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 51d:	75 1d                	jne    53c <printf+0x12e>
        putc(fd, *ap);
 51f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 522:	8b 00                	mov    (%eax),%eax
 524:	0f be c0             	movsbl %al,%eax
 527:	83 ec 08             	sub    $0x8,%esp
 52a:	50                   	push   %eax
 52b:	ff 75 08             	pushl  0x8(%ebp)
 52e:	e8 04 fe ff ff       	call   337 <putc>
 533:	83 c4 10             	add    $0x10,%esp
        ap++;
 536:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53a:	eb 42                	jmp    57e <printf+0x170>
      } else if(c == '%'){
 53c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 540:	75 17                	jne    559 <printf+0x14b>
        putc(fd, c);
 542:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 545:	0f be c0             	movsbl %al,%eax
 548:	83 ec 08             	sub    $0x8,%esp
 54b:	50                   	push   %eax
 54c:	ff 75 08             	pushl  0x8(%ebp)
 54f:	e8 e3 fd ff ff       	call   337 <putc>
 554:	83 c4 10             	add    $0x10,%esp
 557:	eb 25                	jmp    57e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 559:	83 ec 08             	sub    $0x8,%esp
 55c:	6a 25                	push   $0x25
 55e:	ff 75 08             	pushl  0x8(%ebp)
 561:	e8 d1 fd ff ff       	call   337 <putc>
 566:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 569:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 56c:	0f be c0             	movsbl %al,%eax
 56f:	83 ec 08             	sub    $0x8,%esp
 572:	50                   	push   %eax
 573:	ff 75 08             	pushl  0x8(%ebp)
 576:	e8 bc fd ff ff       	call   337 <putc>
 57b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 57e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 585:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 589:	8b 55 0c             	mov    0xc(%ebp),%edx
 58c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 58f:	01 d0                	add    %edx,%eax
 591:	0f b6 00             	movzbl (%eax),%eax
 594:	84 c0                	test   %al,%al
 596:	0f 85 94 fe ff ff    	jne    430 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 59c:	90                   	nop
 59d:	c9                   	leave  
 59e:	c3                   	ret    

0000059f <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 59f:	55                   	push   %ebp
 5a0:	89 e5                	mov    %esp,%ebp
 5a2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	83 e8 08             	sub    $0x8,%eax
 5ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ae:	a1 4c 0a 00 00       	mov    0xa4c,%eax
 5b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5b6:	eb 24                	jmp    5dc <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5bb:	8b 00                	mov    (%eax),%eax
 5bd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5c0:	77 12                	ja     5d4 <free+0x35>
 5c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5c8:	77 24                	ja     5ee <free+0x4f>
 5ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cd:	8b 00                	mov    (%eax),%eax
 5cf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5d2:	77 1a                	ja     5ee <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5d7:	8b 00                	mov    (%eax),%eax
 5d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5df:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5e2:	76 d4                	jbe    5b8 <free+0x19>
 5e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5e7:	8b 00                	mov    (%eax),%eax
 5e9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5ec:	76 ca                	jbe    5b8 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f1:	8b 40 04             	mov    0x4(%eax),%eax
 5f4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fe:	01 c2                	add    %eax,%edx
 600:	8b 45 fc             	mov    -0x4(%ebp),%eax
 603:	8b 00                	mov    (%eax),%eax
 605:	39 c2                	cmp    %eax,%edx
 607:	75 24                	jne    62d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 609:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60c:	8b 50 04             	mov    0x4(%eax),%edx
 60f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	8b 40 04             	mov    0x4(%eax),%eax
 617:	01 c2                	add    %eax,%edx
 619:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 622:	8b 00                	mov    (%eax),%eax
 624:	8b 10                	mov    (%eax),%edx
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	89 10                	mov    %edx,(%eax)
 62b:	eb 0a                	jmp    637 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 10                	mov    (%eax),%edx
 632:	8b 45 f8             	mov    -0x8(%ebp),%eax
 635:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 637:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63a:	8b 40 04             	mov    0x4(%eax),%eax
 63d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 644:	8b 45 fc             	mov    -0x4(%ebp),%eax
 647:	01 d0                	add    %edx,%eax
 649:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 64c:	75 20                	jne    66e <free+0xcf>
    p->s.size += bp->s.size;
 64e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 651:	8b 50 04             	mov    0x4(%eax),%edx
 654:	8b 45 f8             	mov    -0x8(%ebp),%eax
 657:	8b 40 04             	mov    0x4(%eax),%eax
 65a:	01 c2                	add    %eax,%edx
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	8b 10                	mov    (%eax),%edx
 667:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66a:	89 10                	mov    %edx,(%eax)
 66c:	eb 08                	jmp    676 <free+0xd7>
  } else
    p->s.ptr = bp;
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	8b 55 f8             	mov    -0x8(%ebp),%edx
 674:	89 10                	mov    %edx,(%eax)
  freep = p;
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	a3 4c 0a 00 00       	mov    %eax,0xa4c
}
 67e:	90                   	nop
 67f:	c9                   	leave  
 680:	c3                   	ret    

00000681 <morecore>:

static Header*
morecore(uint nu)
{
 681:	55                   	push   %ebp
 682:	89 e5                	mov    %esp,%ebp
 684:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 687:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 68e:	77 07                	ja     697 <morecore+0x16>
    nu = 4096;
 690:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 697:	8b 45 08             	mov    0x8(%ebp),%eax
 69a:	c1 e0 03             	shl    $0x3,%eax
 69d:	83 ec 0c             	sub    $0xc,%esp
 6a0:	50                   	push   %eax
 6a1:	e8 61 fc ff ff       	call   307 <sbrk>
 6a6:	83 c4 10             	add    $0x10,%esp
 6a9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ac:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6b0:	75 07                	jne    6b9 <morecore+0x38>
    return 0;
 6b2:	b8 00 00 00 00       	mov    $0x0,%eax
 6b7:	eb 26                	jmp    6df <morecore+0x5e>
  hp = (Header*)p;
 6b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c2:	8b 55 08             	mov    0x8(%ebp),%edx
 6c5:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6cb:	83 c0 08             	add    $0x8,%eax
 6ce:	83 ec 0c             	sub    $0xc,%esp
 6d1:	50                   	push   %eax
 6d2:	e8 c8 fe ff ff       	call   59f <free>
 6d7:	83 c4 10             	add    $0x10,%esp
  return freep;
 6da:	a1 4c 0a 00 00       	mov    0xa4c,%eax
}
 6df:	c9                   	leave  
 6e0:	c3                   	ret    

000006e1 <malloc>:

void*
malloc(uint nbytes)
{
 6e1:	55                   	push   %ebp
 6e2:	89 e5                	mov    %esp,%ebp
 6e4:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e7:	8b 45 08             	mov    0x8(%ebp),%eax
 6ea:	83 c0 07             	add    $0x7,%eax
 6ed:	c1 e8 03             	shr    $0x3,%eax
 6f0:	83 c0 01             	add    $0x1,%eax
 6f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6f6:	a1 4c 0a 00 00       	mov    0xa4c,%eax
 6fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6fe:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 702:	75 23                	jne    727 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 704:	c7 45 f0 44 0a 00 00 	movl   $0xa44,-0x10(%ebp)
 70b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70e:	a3 4c 0a 00 00       	mov    %eax,0xa4c
 713:	a1 4c 0a 00 00       	mov    0xa4c,%eax
 718:	a3 44 0a 00 00       	mov    %eax,0xa44
    base.s.size = 0;
 71d:	c7 05 48 0a 00 00 00 	movl   $0x0,0xa48
 724:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 727:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72a:	8b 00                	mov    (%eax),%eax
 72c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 72f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 732:	8b 40 04             	mov    0x4(%eax),%eax
 735:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 738:	72 4d                	jb     787 <malloc+0xa6>
      if(p->s.size == nunits)
 73a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73d:	8b 40 04             	mov    0x4(%eax),%eax
 740:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 743:	75 0c                	jne    751 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 745:	8b 45 f4             	mov    -0xc(%ebp),%eax
 748:	8b 10                	mov    (%eax),%edx
 74a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74d:	89 10                	mov    %edx,(%eax)
 74f:	eb 26                	jmp    777 <malloc+0x96>
      else {
        p->s.size -= nunits;
 751:	8b 45 f4             	mov    -0xc(%ebp),%eax
 754:	8b 40 04             	mov    0x4(%eax),%eax
 757:	2b 45 ec             	sub    -0x14(%ebp),%eax
 75a:	89 c2                	mov    %eax,%edx
 75c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 762:	8b 45 f4             	mov    -0xc(%ebp),%eax
 765:	8b 40 04             	mov    0x4(%eax),%eax
 768:	c1 e0 03             	shl    $0x3,%eax
 76b:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 76e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 771:	8b 55 ec             	mov    -0x14(%ebp),%edx
 774:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 777:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77a:	a3 4c 0a 00 00       	mov    %eax,0xa4c
      return (void*)(p + 1);
 77f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 782:	83 c0 08             	add    $0x8,%eax
 785:	eb 3b                	jmp    7c2 <malloc+0xe1>
    }
    if(p == freep)
 787:	a1 4c 0a 00 00       	mov    0xa4c,%eax
 78c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 78f:	75 1e                	jne    7af <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 791:	83 ec 0c             	sub    $0xc,%esp
 794:	ff 75 ec             	pushl  -0x14(%ebp)
 797:	e8 e5 fe ff ff       	call   681 <morecore>
 79c:	83 c4 10             	add    $0x10,%esp
 79f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7a6:	75 07                	jne    7af <malloc+0xce>
        return 0;
 7a8:	b8 00 00 00 00       	mov    $0x0,%eax
 7ad:	eb 13                	jmp    7c2 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b8:	8b 00                	mov    (%eax),%eax
 7ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7bd:	e9 6d ff ff ff       	jmp    72f <malloc+0x4e>
}
 7c2:	c9                   	leave  
 7c3:	c3                   	ret    
