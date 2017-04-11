
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
  14:	68 ac 07 00 00       	push   $0x7ac
  19:	6a 01                	push   $0x1
  1b:	e8 d6 03 00 00       	call   3f6 <printf>
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

0000031f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 31f:	55                   	push   %ebp
 320:	89 e5                	mov    %esp,%ebp
 322:	83 ec 18             	sub    $0x18,%esp
 325:	8b 45 0c             	mov    0xc(%ebp),%eax
 328:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 32b:	83 ec 04             	sub    $0x4,%esp
 32e:	6a 01                	push   $0x1
 330:	8d 45 f4             	lea    -0xc(%ebp),%eax
 333:	50                   	push   %eax
 334:	ff 75 08             	pushl  0x8(%ebp)
 337:	e8 63 ff ff ff       	call   29f <write>
 33c:	83 c4 10             	add    $0x10,%esp
}
 33f:	90                   	nop
 340:	c9                   	leave  
 341:	c3                   	ret    

00000342 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 342:	55                   	push   %ebp
 343:	89 e5                	mov    %esp,%ebp
 345:	53                   	push   %ebx
 346:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 349:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 350:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 354:	74 17                	je     36d <printint+0x2b>
 356:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 35a:	79 11                	jns    36d <printint+0x2b>
    neg = 1;
 35c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 363:	8b 45 0c             	mov    0xc(%ebp),%eax
 366:	f7 d8                	neg    %eax
 368:	89 45 ec             	mov    %eax,-0x14(%ebp)
 36b:	eb 06                	jmp    373 <printint+0x31>
  } else {
    x = xx;
 36d:	8b 45 0c             	mov    0xc(%ebp),%eax
 370:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 373:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 37a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 37d:	8d 41 01             	lea    0x1(%ecx),%eax
 380:	89 45 f4             	mov    %eax,-0xc(%ebp)
 383:	8b 5d 10             	mov    0x10(%ebp),%ebx
 386:	8b 45 ec             	mov    -0x14(%ebp),%eax
 389:	ba 00 00 00 00       	mov    $0x0,%edx
 38e:	f7 f3                	div    %ebx
 390:	89 d0                	mov    %edx,%eax
 392:	0f b6 80 18 0a 00 00 	movzbl 0xa18(%eax),%eax
 399:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 39d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3a3:	ba 00 00 00 00       	mov    $0x0,%edx
 3a8:	f7 f3                	div    %ebx
 3aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3b1:	75 c7                	jne    37a <printint+0x38>
  if(neg)
 3b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3b7:	74 2d                	je     3e6 <printint+0xa4>
    buf[i++] = '-';
 3b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3bc:	8d 50 01             	lea    0x1(%eax),%edx
 3bf:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3c2:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 3c7:	eb 1d                	jmp    3e6 <printint+0xa4>
    putc(fd, buf[i]);
 3c9:	8d 55 dc             	lea    -0x24(%ebp),%edx
 3cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3cf:	01 d0                	add    %edx,%eax
 3d1:	0f b6 00             	movzbl (%eax),%eax
 3d4:	0f be c0             	movsbl %al,%eax
 3d7:	83 ec 08             	sub    $0x8,%esp
 3da:	50                   	push   %eax
 3db:	ff 75 08             	pushl  0x8(%ebp)
 3de:	e8 3c ff ff ff       	call   31f <putc>
 3e3:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 3e6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 3ea:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 3ee:	79 d9                	jns    3c9 <printint+0x87>
    putc(fd, buf[i]);
}
 3f0:	90                   	nop
 3f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3f4:	c9                   	leave  
 3f5:	c3                   	ret    

000003f6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3f6:	55                   	push   %ebp
 3f7:	89 e5                	mov    %esp,%ebp
 3f9:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 3fc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 403:	8d 45 0c             	lea    0xc(%ebp),%eax
 406:	83 c0 04             	add    $0x4,%eax
 409:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 40c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 413:	e9 59 01 00 00       	jmp    571 <printf+0x17b>
    c = fmt[i] & 0xff;
 418:	8b 55 0c             	mov    0xc(%ebp),%edx
 41b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 41e:	01 d0                	add    %edx,%eax
 420:	0f b6 00             	movzbl (%eax),%eax
 423:	0f be c0             	movsbl %al,%eax
 426:	25 ff 00 00 00       	and    $0xff,%eax
 42b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 42e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 432:	75 2c                	jne    460 <printf+0x6a>
      if(c == '%'){
 434:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 438:	75 0c                	jne    446 <printf+0x50>
        state = '%';
 43a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 441:	e9 27 01 00 00       	jmp    56d <printf+0x177>
      } else {
        putc(fd, c);
 446:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 449:	0f be c0             	movsbl %al,%eax
 44c:	83 ec 08             	sub    $0x8,%esp
 44f:	50                   	push   %eax
 450:	ff 75 08             	pushl  0x8(%ebp)
 453:	e8 c7 fe ff ff       	call   31f <putc>
 458:	83 c4 10             	add    $0x10,%esp
 45b:	e9 0d 01 00 00       	jmp    56d <printf+0x177>
      }
    } else if(state == '%'){
 460:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 464:	0f 85 03 01 00 00    	jne    56d <printf+0x177>
      if(c == 'd'){
 46a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 46e:	75 1e                	jne    48e <printf+0x98>
        printint(fd, *ap, 10, 1);
 470:	8b 45 e8             	mov    -0x18(%ebp),%eax
 473:	8b 00                	mov    (%eax),%eax
 475:	6a 01                	push   $0x1
 477:	6a 0a                	push   $0xa
 479:	50                   	push   %eax
 47a:	ff 75 08             	pushl  0x8(%ebp)
 47d:	e8 c0 fe ff ff       	call   342 <printint>
 482:	83 c4 10             	add    $0x10,%esp
        ap++;
 485:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 489:	e9 d8 00 00 00       	jmp    566 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 48e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 492:	74 06                	je     49a <printf+0xa4>
 494:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 498:	75 1e                	jne    4b8 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 49a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 49d:	8b 00                	mov    (%eax),%eax
 49f:	6a 00                	push   $0x0
 4a1:	6a 10                	push   $0x10
 4a3:	50                   	push   %eax
 4a4:	ff 75 08             	pushl  0x8(%ebp)
 4a7:	e8 96 fe ff ff       	call   342 <printint>
 4ac:	83 c4 10             	add    $0x10,%esp
        ap++;
 4af:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4b3:	e9 ae 00 00 00       	jmp    566 <printf+0x170>
      } else if(c == 's'){
 4b8:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 4bc:	75 43                	jne    501 <printf+0x10b>
        s = (char*)*ap;
 4be:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c1:	8b 00                	mov    (%eax),%eax
 4c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 4c6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 4ca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ce:	75 25                	jne    4f5 <printf+0xff>
          s = "(null)";
 4d0:	c7 45 f4 c7 07 00 00 	movl   $0x7c7,-0xc(%ebp)
        while(*s != 0){
 4d7:	eb 1c                	jmp    4f5 <printf+0xff>
          putc(fd, *s);
 4d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4dc:	0f b6 00             	movzbl (%eax),%eax
 4df:	0f be c0             	movsbl %al,%eax
 4e2:	83 ec 08             	sub    $0x8,%esp
 4e5:	50                   	push   %eax
 4e6:	ff 75 08             	pushl  0x8(%ebp)
 4e9:	e8 31 fe ff ff       	call   31f <putc>
 4ee:	83 c4 10             	add    $0x10,%esp
          s++;
 4f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f8:	0f b6 00             	movzbl (%eax),%eax
 4fb:	84 c0                	test   %al,%al
 4fd:	75 da                	jne    4d9 <printf+0xe3>
 4ff:	eb 65                	jmp    566 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 501:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 505:	75 1d                	jne    524 <printf+0x12e>
        putc(fd, *ap);
 507:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50a:	8b 00                	mov    (%eax),%eax
 50c:	0f be c0             	movsbl %al,%eax
 50f:	83 ec 08             	sub    $0x8,%esp
 512:	50                   	push   %eax
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	e8 04 fe ff ff       	call   31f <putc>
 51b:	83 c4 10             	add    $0x10,%esp
        ap++;
 51e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 522:	eb 42                	jmp    566 <printf+0x170>
      } else if(c == '%'){
 524:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 528:	75 17                	jne    541 <printf+0x14b>
        putc(fd, c);
 52a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 52d:	0f be c0             	movsbl %al,%eax
 530:	83 ec 08             	sub    $0x8,%esp
 533:	50                   	push   %eax
 534:	ff 75 08             	pushl  0x8(%ebp)
 537:	e8 e3 fd ff ff       	call   31f <putc>
 53c:	83 c4 10             	add    $0x10,%esp
 53f:	eb 25                	jmp    566 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 541:	83 ec 08             	sub    $0x8,%esp
 544:	6a 25                	push   $0x25
 546:	ff 75 08             	pushl  0x8(%ebp)
 549:	e8 d1 fd ff ff       	call   31f <putc>
 54e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 551:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 554:	0f be c0             	movsbl %al,%eax
 557:	83 ec 08             	sub    $0x8,%esp
 55a:	50                   	push   %eax
 55b:	ff 75 08             	pushl  0x8(%ebp)
 55e:	e8 bc fd ff ff       	call   31f <putc>
 563:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 566:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 56d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 571:	8b 55 0c             	mov    0xc(%ebp),%edx
 574:	8b 45 f0             	mov    -0x10(%ebp),%eax
 577:	01 d0                	add    %edx,%eax
 579:	0f b6 00             	movzbl (%eax),%eax
 57c:	84 c0                	test   %al,%al
 57e:	0f 85 94 fe ff ff    	jne    418 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 584:	90                   	nop
 585:	c9                   	leave  
 586:	c3                   	ret    

00000587 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 587:	55                   	push   %ebp
 588:	89 e5                	mov    %esp,%ebp
 58a:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 58d:	8b 45 08             	mov    0x8(%ebp),%eax
 590:	83 e8 08             	sub    $0x8,%eax
 593:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 596:	a1 34 0a 00 00       	mov    0xa34,%eax
 59b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 59e:	eb 24                	jmp    5c4 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5a3:	8b 00                	mov    (%eax),%eax
 5a5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5a8:	77 12                	ja     5bc <free+0x35>
 5aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ad:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5b0:	77 24                	ja     5d6 <free+0x4f>
 5b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5b5:	8b 00                	mov    (%eax),%eax
 5b7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5ba:	77 1a                	ja     5d6 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5bf:	8b 00                	mov    (%eax),%eax
 5c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5c7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5ca:	76 d4                	jbe    5a0 <free+0x19>
 5cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5cf:	8b 00                	mov    (%eax),%eax
 5d1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 5d4:	76 ca                	jbe    5a0 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 5d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5d9:	8b 40 04             	mov    0x4(%eax),%eax
 5dc:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5e6:	01 c2                	add    %eax,%edx
 5e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5eb:	8b 00                	mov    (%eax),%eax
 5ed:	39 c2                	cmp    %eax,%edx
 5ef:	75 24                	jne    615 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 5f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f4:	8b 50 04             	mov    0x4(%eax),%edx
 5f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fa:	8b 00                	mov    (%eax),%eax
 5fc:	8b 40 04             	mov    0x4(%eax),%eax
 5ff:	01 c2                	add    %eax,%edx
 601:	8b 45 f8             	mov    -0x8(%ebp),%eax
 604:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 607:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60a:	8b 00                	mov    (%eax),%eax
 60c:	8b 10                	mov    (%eax),%edx
 60e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 611:	89 10                	mov    %edx,(%eax)
 613:	eb 0a                	jmp    61f <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 615:	8b 45 fc             	mov    -0x4(%ebp),%eax
 618:	8b 10                	mov    (%eax),%edx
 61a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 622:	8b 40 04             	mov    0x4(%eax),%eax
 625:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 62c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62f:	01 d0                	add    %edx,%eax
 631:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 634:	75 20                	jne    656 <free+0xcf>
    p->s.size += bp->s.size;
 636:	8b 45 fc             	mov    -0x4(%ebp),%eax
 639:	8b 50 04             	mov    0x4(%eax),%edx
 63c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63f:	8b 40 04             	mov    0x4(%eax),%eax
 642:	01 c2                	add    %eax,%edx
 644:	8b 45 fc             	mov    -0x4(%ebp),%eax
 647:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64d:	8b 10                	mov    (%eax),%edx
 64f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 652:	89 10                	mov    %edx,(%eax)
 654:	eb 08                	jmp    65e <free+0xd7>
  } else
    p->s.ptr = bp;
 656:	8b 45 fc             	mov    -0x4(%ebp),%eax
 659:	8b 55 f8             	mov    -0x8(%ebp),%edx
 65c:	89 10                	mov    %edx,(%eax)
  freep = p;
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	a3 34 0a 00 00       	mov    %eax,0xa34
}
 666:	90                   	nop
 667:	c9                   	leave  
 668:	c3                   	ret    

00000669 <morecore>:

static Header*
morecore(uint nu)
{
 669:	55                   	push   %ebp
 66a:	89 e5                	mov    %esp,%ebp
 66c:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 66f:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 676:	77 07                	ja     67f <morecore+0x16>
    nu = 4096;
 678:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 67f:	8b 45 08             	mov    0x8(%ebp),%eax
 682:	c1 e0 03             	shl    $0x3,%eax
 685:	83 ec 0c             	sub    $0xc,%esp
 688:	50                   	push   %eax
 689:	e8 79 fc ff ff       	call   307 <sbrk>
 68e:	83 c4 10             	add    $0x10,%esp
 691:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 694:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 698:	75 07                	jne    6a1 <morecore+0x38>
    return 0;
 69a:	b8 00 00 00 00       	mov    $0x0,%eax
 69f:	eb 26                	jmp    6c7 <morecore+0x5e>
  hp = (Header*)p;
 6a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6a4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6aa:	8b 55 08             	mov    0x8(%ebp),%edx
 6ad:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b3:	83 c0 08             	add    $0x8,%eax
 6b6:	83 ec 0c             	sub    $0xc,%esp
 6b9:	50                   	push   %eax
 6ba:	e8 c8 fe ff ff       	call   587 <free>
 6bf:	83 c4 10             	add    $0x10,%esp
  return freep;
 6c2:	a1 34 0a 00 00       	mov    0xa34,%eax
}
 6c7:	c9                   	leave  
 6c8:	c3                   	ret    

000006c9 <malloc>:

void*
malloc(uint nbytes)
{
 6c9:	55                   	push   %ebp
 6ca:	89 e5                	mov    %esp,%ebp
 6cc:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6cf:	8b 45 08             	mov    0x8(%ebp),%eax
 6d2:	83 c0 07             	add    $0x7,%eax
 6d5:	c1 e8 03             	shr    $0x3,%eax
 6d8:	83 c0 01             	add    $0x1,%eax
 6db:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 6de:	a1 34 0a 00 00       	mov    0xa34,%eax
 6e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 6e6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6ea:	75 23                	jne    70f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 6ec:	c7 45 f0 2c 0a 00 00 	movl   $0xa2c,-0x10(%ebp)
 6f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f6:	a3 34 0a 00 00       	mov    %eax,0xa34
 6fb:	a1 34 0a 00 00       	mov    0xa34,%eax
 700:	a3 2c 0a 00 00       	mov    %eax,0xa2c
    base.s.size = 0;
 705:	c7 05 30 0a 00 00 00 	movl   $0x0,0xa30
 70c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 70f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 712:	8b 00                	mov    (%eax),%eax
 714:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 717:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71a:	8b 40 04             	mov    0x4(%eax),%eax
 71d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 720:	72 4d                	jb     76f <malloc+0xa6>
      if(p->s.size == nunits)
 722:	8b 45 f4             	mov    -0xc(%ebp),%eax
 725:	8b 40 04             	mov    0x4(%eax),%eax
 728:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 72b:	75 0c                	jne    739 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8b 10                	mov    (%eax),%edx
 732:	8b 45 f0             	mov    -0x10(%ebp),%eax
 735:	89 10                	mov    %edx,(%eax)
 737:	eb 26                	jmp    75f <malloc+0x96>
      else {
        p->s.size -= nunits;
 739:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73c:	8b 40 04             	mov    0x4(%eax),%eax
 73f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 742:	89 c2                	mov    %eax,%edx
 744:	8b 45 f4             	mov    -0xc(%ebp),%eax
 747:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 74a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74d:	8b 40 04             	mov    0x4(%eax),%eax
 750:	c1 e0 03             	shl    $0x3,%eax
 753:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 756:	8b 45 f4             	mov    -0xc(%ebp),%eax
 759:	8b 55 ec             	mov    -0x14(%ebp),%edx
 75c:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 75f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 762:	a3 34 0a 00 00       	mov    %eax,0xa34
      return (void*)(p + 1);
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	83 c0 08             	add    $0x8,%eax
 76d:	eb 3b                	jmp    7aa <malloc+0xe1>
    }
    if(p == freep)
 76f:	a1 34 0a 00 00       	mov    0xa34,%eax
 774:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 777:	75 1e                	jne    797 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 779:	83 ec 0c             	sub    $0xc,%esp
 77c:	ff 75 ec             	pushl  -0x14(%ebp)
 77f:	e8 e5 fe ff ff       	call   669 <morecore>
 784:	83 c4 10             	add    $0x10,%esp
 787:	89 45 f4             	mov    %eax,-0xc(%ebp)
 78a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 78e:	75 07                	jne    797 <malloc+0xce>
        return 0;
 790:	b8 00 00 00 00       	mov    $0x0,%eax
 795:	eb 13                	jmp    7aa <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 797:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 79d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a0:	8b 00                	mov    (%eax),%eax
 7a2:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7a5:	e9 6d ff ff ff       	jmp    717 <malloc+0x4e>
}
 7aa:	c9                   	leave  
 7ab:	c3                   	ret    
