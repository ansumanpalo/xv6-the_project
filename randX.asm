
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
  11:	e8 60 03 00 00       	call   376 <randomX>
  16:	83 ec 04             	sub    $0x4,%esp
  19:	50                   	push   %eax
  1a:	68 23 08 00 00       	push   $0x823
  1f:	6a 01                	push   $0x1
  21:	e8 47 04 00 00       	call   46d <printf>
  26:	83 c4 10             	add    $0x10,%esp
  exit();
  29:	e8 a8 02 00 00       	call   2d6 <exit>

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
 151:	e8 98 01 00 00       	call   2ee <read>
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
 1b4:	e8 5d 01 00 00       	call   316 <open>
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
 1d5:	e8 54 01 00 00       	call   32e <fstat>
 1da:	83 c4 10             	add    $0x10,%esp
 1dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1e0:	83 ec 0c             	sub    $0xc,%esp
 1e3:	ff 75 f4             	pushl  -0xc(%ebp)
 1e6:	e8 13 01 00 00       	call   2fe <close>
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

00000240 <itoa>:

char*
itoa(int val, int base){
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 246:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 24d:	eb 29                	jmp    278 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 24f:	8b 45 08             	mov    0x8(%ebp),%eax
 252:	99                   	cltd   
 253:	f7 7d 0c             	idivl  0xc(%ebp)
 256:	89 d0                	mov    %edx,%eax
 258:	0f b6 80 27 08 00 00 	movzbl 0x827(%eax),%eax
 25f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 262:	81 c2 c0 0a 00 00    	add    $0xac0,%edx
 268:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 26a:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	99                   	cltd   
 272:	f7 7d 0c             	idivl  0xc(%ebp)
 275:	89 45 08             	mov    %eax,0x8(%ebp)
 278:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 27c:	74 06                	je     284 <itoa+0x44>
 27e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 282:	75 cb                	jne    24f <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 284:	8b 45 fc             	mov    -0x4(%ebp),%eax
 287:	83 c0 01             	add    $0x1,%eax
 28a:	05 c0 0a 00 00       	add    $0xac0,%eax

}
 28f:	c9                   	leave  
 290:	c3                   	ret    

00000291 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 291:	55                   	push   %ebp
 292:	89 e5                	mov    %esp,%ebp
 294:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 297:	8b 45 08             	mov    0x8(%ebp),%eax
 29a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 29d:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2a3:	eb 17                	jmp    2bc <memmove+0x2b>
    *dst++ = *src++;
 2a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a8:	8d 50 01             	lea    0x1(%eax),%edx
 2ab:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2ae:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2b1:	8d 4a 01             	lea    0x1(%edx),%ecx
 2b4:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b7:	0f b6 12             	movzbl (%edx),%edx
 2ba:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2bc:	8b 45 10             	mov    0x10(%ebp),%eax
 2bf:	8d 50 ff             	lea    -0x1(%eax),%edx
 2c2:	89 55 10             	mov    %edx,0x10(%ebp)
 2c5:	85 c0                	test   %eax,%eax
 2c7:	7f dc                	jg     2a5 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2cc:	c9                   	leave  
 2cd:	c3                   	ret    

000002ce <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ce:	b8 01 00 00 00       	mov    $0x1,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <exit>:
SYSCALL(exit)
 2d6:	b8 02 00 00 00       	mov    $0x2,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <wait>:
SYSCALL(wait)
 2de:	b8 03 00 00 00       	mov    $0x3,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <pipe>:
SYSCALL(pipe)
 2e6:	b8 04 00 00 00       	mov    $0x4,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <read>:
SYSCALL(read)
 2ee:	b8 05 00 00 00       	mov    $0x5,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <write>:
SYSCALL(write)
 2f6:	b8 10 00 00 00       	mov    $0x10,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <close>:
SYSCALL(close)
 2fe:	b8 15 00 00 00       	mov    $0x15,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <kill>:
SYSCALL(kill)
 306:	b8 06 00 00 00       	mov    $0x6,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <exec>:
SYSCALL(exec)
 30e:	b8 07 00 00 00       	mov    $0x7,%eax
 313:	cd 40                	int    $0x40
 315:	c3                   	ret    

00000316 <open>:
SYSCALL(open)
 316:	b8 0f 00 00 00       	mov    $0xf,%eax
 31b:	cd 40                	int    $0x40
 31d:	c3                   	ret    

0000031e <mknod>:
SYSCALL(mknod)
 31e:	b8 11 00 00 00       	mov    $0x11,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <unlink>:
SYSCALL(unlink)
 326:	b8 12 00 00 00       	mov    $0x12,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <fstat>:
SYSCALL(fstat)
 32e:	b8 08 00 00 00       	mov    $0x8,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <link>:
SYSCALL(link)
 336:	b8 13 00 00 00       	mov    $0x13,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <mkdir>:
SYSCALL(mkdir)
 33e:	b8 14 00 00 00       	mov    $0x14,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <chdir>:
SYSCALL(chdir)
 346:	b8 09 00 00 00       	mov    $0x9,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <dup>:
SYSCALL(dup)
 34e:	b8 0a 00 00 00       	mov    $0xa,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <getpid>:
SYSCALL(getpid)
 356:	b8 0b 00 00 00       	mov    $0xb,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <sbrk>:
SYSCALL(sbrk)
 35e:	b8 0c 00 00 00       	mov    $0xc,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <sleep>:
SYSCALL(sleep)
 366:	b8 0d 00 00 00       	mov    $0xd,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <uptime>:
SYSCALL(uptime)
 36e:	b8 0e 00 00 00       	mov    $0xe,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <randomX>:
SYSCALL(randomX)
 376:	b8 16 00 00 00       	mov    $0x16,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <setSeedX>:
SYSCALL(setSeedX)
 37e:	b8 17 00 00 00       	mov    $0x17,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <uniformR>:
SYSCALL(uniformR)
 386:	b8 18 00 00 00       	mov    $0x18,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <setdeadline>:
 38e:	b8 19 00 00 00       	mov    $0x19,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 396:	55                   	push   %ebp
 397:	89 e5                	mov    %esp,%ebp
 399:	83 ec 18             	sub    $0x18,%esp
 39c:	8b 45 0c             	mov    0xc(%ebp),%eax
 39f:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3a2:	83 ec 04             	sub    $0x4,%esp
 3a5:	6a 01                	push   $0x1
 3a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3aa:	50                   	push   %eax
 3ab:	ff 75 08             	pushl  0x8(%ebp)
 3ae:	e8 43 ff ff ff       	call   2f6 <write>
 3b3:	83 c4 10             	add    $0x10,%esp
}
 3b6:	90                   	nop
 3b7:	c9                   	leave  
 3b8:	c3                   	ret    

000003b9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b9:	55                   	push   %ebp
 3ba:	89 e5                	mov    %esp,%ebp
 3bc:	53                   	push   %ebx
 3bd:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3c7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3cb:	74 17                	je     3e4 <printint+0x2b>
 3cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3d1:	79 11                	jns    3e4 <printint+0x2b>
    neg = 1;
 3d3:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	f7 d8                	neg    %eax
 3df:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e2:	eb 06                	jmp    3ea <printint+0x31>
  } else {
    x = xx;
 3e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3ea:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3f1:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3f4:	8d 41 01             	lea    0x1(%ecx),%eax
 3f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3fa:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3fd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 400:	ba 00 00 00 00       	mov    $0x0,%edx
 405:	f7 f3                	div    %ebx
 407:	89 d0                	mov    %edx,%eax
 409:	0f b6 80 a8 0a 00 00 	movzbl 0xaa8(%eax),%eax
 410:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 414:	8b 5d 10             	mov    0x10(%ebp),%ebx
 417:	8b 45 ec             	mov    -0x14(%ebp),%eax
 41a:	ba 00 00 00 00       	mov    $0x0,%edx
 41f:	f7 f3                	div    %ebx
 421:	89 45 ec             	mov    %eax,-0x14(%ebp)
 424:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 428:	75 c7                	jne    3f1 <printint+0x38>
  if(neg)
 42a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 42e:	74 2d                	je     45d <printint+0xa4>
    buf[i++] = '-';
 430:	8b 45 f4             	mov    -0xc(%ebp),%eax
 433:	8d 50 01             	lea    0x1(%eax),%edx
 436:	89 55 f4             	mov    %edx,-0xc(%ebp)
 439:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 43e:	eb 1d                	jmp    45d <printint+0xa4>
    putc(fd, buf[i]);
 440:	8d 55 dc             	lea    -0x24(%ebp),%edx
 443:	8b 45 f4             	mov    -0xc(%ebp),%eax
 446:	01 d0                	add    %edx,%eax
 448:	0f b6 00             	movzbl (%eax),%eax
 44b:	0f be c0             	movsbl %al,%eax
 44e:	83 ec 08             	sub    $0x8,%esp
 451:	50                   	push   %eax
 452:	ff 75 08             	pushl  0x8(%ebp)
 455:	e8 3c ff ff ff       	call   396 <putc>
 45a:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 45d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 461:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 465:	79 d9                	jns    440 <printint+0x87>
    putc(fd, buf[i]);
}
 467:	90                   	nop
 468:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 46b:	c9                   	leave  
 46c:	c3                   	ret    

0000046d <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 46d:	55                   	push   %ebp
 46e:	89 e5                	mov    %esp,%ebp
 470:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 473:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 47a:	8d 45 0c             	lea    0xc(%ebp),%eax
 47d:	83 c0 04             	add    $0x4,%eax
 480:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 483:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 48a:	e9 59 01 00 00       	jmp    5e8 <printf+0x17b>
    c = fmt[i] & 0xff;
 48f:	8b 55 0c             	mov    0xc(%ebp),%edx
 492:	8b 45 f0             	mov    -0x10(%ebp),%eax
 495:	01 d0                	add    %edx,%eax
 497:	0f b6 00             	movzbl (%eax),%eax
 49a:	0f be c0             	movsbl %al,%eax
 49d:	25 ff 00 00 00       	and    $0xff,%eax
 4a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4a5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a9:	75 2c                	jne    4d7 <printf+0x6a>
      if(c == '%'){
 4ab:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4af:	75 0c                	jne    4bd <printf+0x50>
        state = '%';
 4b1:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b8:	e9 27 01 00 00       	jmp    5e4 <printf+0x177>
      } else {
        putc(fd, c);
 4bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4c0:	0f be c0             	movsbl %al,%eax
 4c3:	83 ec 08             	sub    $0x8,%esp
 4c6:	50                   	push   %eax
 4c7:	ff 75 08             	pushl  0x8(%ebp)
 4ca:	e8 c7 fe ff ff       	call   396 <putc>
 4cf:	83 c4 10             	add    $0x10,%esp
 4d2:	e9 0d 01 00 00       	jmp    5e4 <printf+0x177>
      }
    } else if(state == '%'){
 4d7:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4db:	0f 85 03 01 00 00    	jne    5e4 <printf+0x177>
      if(c == 'd'){
 4e1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e5:	75 1e                	jne    505 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4e7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ea:	8b 00                	mov    (%eax),%eax
 4ec:	6a 01                	push   $0x1
 4ee:	6a 0a                	push   $0xa
 4f0:	50                   	push   %eax
 4f1:	ff 75 08             	pushl  0x8(%ebp)
 4f4:	e8 c0 fe ff ff       	call   3b9 <printint>
 4f9:	83 c4 10             	add    $0x10,%esp
        ap++;
 4fc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 500:	e9 d8 00 00 00       	jmp    5dd <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 505:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 509:	74 06                	je     511 <printf+0xa4>
 50b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 50f:	75 1e                	jne    52f <printf+0xc2>
        printint(fd, *ap, 16, 0);
 511:	8b 45 e8             	mov    -0x18(%ebp),%eax
 514:	8b 00                	mov    (%eax),%eax
 516:	6a 00                	push   $0x0
 518:	6a 10                	push   $0x10
 51a:	50                   	push   %eax
 51b:	ff 75 08             	pushl  0x8(%ebp)
 51e:	e8 96 fe ff ff       	call   3b9 <printint>
 523:	83 c4 10             	add    $0x10,%esp
        ap++;
 526:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52a:	e9 ae 00 00 00       	jmp    5dd <printf+0x170>
      } else if(c == 's'){
 52f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 533:	75 43                	jne    578 <printf+0x10b>
        s = (char*)*ap;
 535:	8b 45 e8             	mov    -0x18(%ebp),%eax
 538:	8b 00                	mov    (%eax),%eax
 53a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 53d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 541:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 545:	75 25                	jne    56c <printf+0xff>
          s = "(null)";
 547:	c7 45 f4 38 08 00 00 	movl   $0x838,-0xc(%ebp)
        while(*s != 0){
 54e:	eb 1c                	jmp    56c <printf+0xff>
          putc(fd, *s);
 550:	8b 45 f4             	mov    -0xc(%ebp),%eax
 553:	0f b6 00             	movzbl (%eax),%eax
 556:	0f be c0             	movsbl %al,%eax
 559:	83 ec 08             	sub    $0x8,%esp
 55c:	50                   	push   %eax
 55d:	ff 75 08             	pushl  0x8(%ebp)
 560:	e8 31 fe ff ff       	call   396 <putc>
 565:	83 c4 10             	add    $0x10,%esp
          s++;
 568:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 56c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56f:	0f b6 00             	movzbl (%eax),%eax
 572:	84 c0                	test   %al,%al
 574:	75 da                	jne    550 <printf+0xe3>
 576:	eb 65                	jmp    5dd <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 578:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 57c:	75 1d                	jne    59b <printf+0x12e>
        putc(fd, *ap);
 57e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 581:	8b 00                	mov    (%eax),%eax
 583:	0f be c0             	movsbl %al,%eax
 586:	83 ec 08             	sub    $0x8,%esp
 589:	50                   	push   %eax
 58a:	ff 75 08             	pushl  0x8(%ebp)
 58d:	e8 04 fe ff ff       	call   396 <putc>
 592:	83 c4 10             	add    $0x10,%esp
        ap++;
 595:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 599:	eb 42                	jmp    5dd <printf+0x170>
      } else if(c == '%'){
 59b:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 59f:	75 17                	jne    5b8 <printf+0x14b>
        putc(fd, c);
 5a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a4:	0f be c0             	movsbl %al,%eax
 5a7:	83 ec 08             	sub    $0x8,%esp
 5aa:	50                   	push   %eax
 5ab:	ff 75 08             	pushl  0x8(%ebp)
 5ae:	e8 e3 fd ff ff       	call   396 <putc>
 5b3:	83 c4 10             	add    $0x10,%esp
 5b6:	eb 25                	jmp    5dd <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b8:	83 ec 08             	sub    $0x8,%esp
 5bb:	6a 25                	push   $0x25
 5bd:	ff 75 08             	pushl  0x8(%ebp)
 5c0:	e8 d1 fd ff ff       	call   396 <putc>
 5c5:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5cb:	0f be c0             	movsbl %al,%eax
 5ce:	83 ec 08             	sub    $0x8,%esp
 5d1:	50                   	push   %eax
 5d2:	ff 75 08             	pushl  0x8(%ebp)
 5d5:	e8 bc fd ff ff       	call   396 <putc>
 5da:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5dd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e8:	8b 55 0c             	mov    0xc(%ebp),%edx
 5eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5ee:	01 d0                	add    %edx,%eax
 5f0:	0f b6 00             	movzbl (%eax),%eax
 5f3:	84 c0                	test   %al,%al
 5f5:	0f 85 94 fe ff ff    	jne    48f <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5fb:	90                   	nop
 5fc:	c9                   	leave  
 5fd:	c3                   	ret    

000005fe <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5fe:	55                   	push   %ebp
 5ff:	89 e5                	mov    %esp,%ebp
 601:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 604:	8b 45 08             	mov    0x8(%ebp),%eax
 607:	83 e8 08             	sub    $0x8,%eax
 60a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60d:	a1 e8 0a 00 00       	mov    0xae8,%eax
 612:	89 45 fc             	mov    %eax,-0x4(%ebp)
 615:	eb 24                	jmp    63b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 617:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61a:	8b 00                	mov    (%eax),%eax
 61c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61f:	77 12                	ja     633 <free+0x35>
 621:	8b 45 f8             	mov    -0x8(%ebp),%eax
 624:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 627:	77 24                	ja     64d <free+0x4f>
 629:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62c:	8b 00                	mov    (%eax),%eax
 62e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 631:	77 1a                	ja     64d <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 633:	8b 45 fc             	mov    -0x4(%ebp),%eax
 636:	8b 00                	mov    (%eax),%eax
 638:	89 45 fc             	mov    %eax,-0x4(%ebp)
 63b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 641:	76 d4                	jbe    617 <free+0x19>
 643:	8b 45 fc             	mov    -0x4(%ebp),%eax
 646:	8b 00                	mov    (%eax),%eax
 648:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 64b:	76 ca                	jbe    617 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 64d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 650:	8b 40 04             	mov    0x4(%eax),%eax
 653:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 65a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65d:	01 c2                	add    %eax,%edx
 65f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 662:	8b 00                	mov    (%eax),%eax
 664:	39 c2                	cmp    %eax,%edx
 666:	75 24                	jne    68c <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 668:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66b:	8b 50 04             	mov    0x4(%eax),%edx
 66e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 671:	8b 00                	mov    (%eax),%eax
 673:	8b 40 04             	mov    0x4(%eax),%eax
 676:	01 c2                	add    %eax,%edx
 678:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67b:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	8b 00                	mov    (%eax),%eax
 683:	8b 10                	mov    (%eax),%edx
 685:	8b 45 f8             	mov    -0x8(%ebp),%eax
 688:	89 10                	mov    %edx,(%eax)
 68a:	eb 0a                	jmp    696 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68f:	8b 10                	mov    (%eax),%edx
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	8b 40 04             	mov    0x4(%eax),%eax
 69c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	01 d0                	add    %edx,%eax
 6a8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ab:	75 20                	jne    6cd <free+0xcf>
    p->s.size += bp->s.size;
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 50 04             	mov    0x4(%eax),%edx
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	8b 40 04             	mov    0x4(%eax),%eax
 6b9:	01 c2                	add    %eax,%edx
 6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6be:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	8b 10                	mov    (%eax),%edx
 6c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c9:	89 10                	mov    %edx,(%eax)
 6cb:	eb 08                	jmp    6d5 <free+0xd7>
  } else
    p->s.ptr = bp;
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d3:	89 10                	mov    %edx,(%eax)
  freep = p;
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	a3 e8 0a 00 00       	mov    %eax,0xae8
}
 6dd:	90                   	nop
 6de:	c9                   	leave  
 6df:	c3                   	ret    

000006e0 <morecore>:

static Header*
morecore(uint nu)
{
 6e0:	55                   	push   %ebp
 6e1:	89 e5                	mov    %esp,%ebp
 6e3:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6e6:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ed:	77 07                	ja     6f6 <morecore+0x16>
    nu = 4096;
 6ef:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6f6:	8b 45 08             	mov    0x8(%ebp),%eax
 6f9:	c1 e0 03             	shl    $0x3,%eax
 6fc:	83 ec 0c             	sub    $0xc,%esp
 6ff:	50                   	push   %eax
 700:	e8 59 fc ff ff       	call   35e <sbrk>
 705:	83 c4 10             	add    $0x10,%esp
 708:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 70b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 70f:	75 07                	jne    718 <morecore+0x38>
    return 0;
 711:	b8 00 00 00 00       	mov    $0x0,%eax
 716:	eb 26                	jmp    73e <morecore+0x5e>
  hp = (Header*)p;
 718:	8b 45 f4             	mov    -0xc(%ebp),%eax
 71b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 71e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 721:	8b 55 08             	mov    0x8(%ebp),%edx
 724:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 727:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72a:	83 c0 08             	add    $0x8,%eax
 72d:	83 ec 0c             	sub    $0xc,%esp
 730:	50                   	push   %eax
 731:	e8 c8 fe ff ff       	call   5fe <free>
 736:	83 c4 10             	add    $0x10,%esp
  return freep;
 739:	a1 e8 0a 00 00       	mov    0xae8,%eax
}
 73e:	c9                   	leave  
 73f:	c3                   	ret    

00000740 <malloc>:

void*
malloc(uint nbytes)
{
 740:	55                   	push   %ebp
 741:	89 e5                	mov    %esp,%ebp
 743:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 746:	8b 45 08             	mov    0x8(%ebp),%eax
 749:	83 c0 07             	add    $0x7,%eax
 74c:	c1 e8 03             	shr    $0x3,%eax
 74f:	83 c0 01             	add    $0x1,%eax
 752:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 755:	a1 e8 0a 00 00       	mov    0xae8,%eax
 75a:	89 45 f0             	mov    %eax,-0x10(%ebp)
 75d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 761:	75 23                	jne    786 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 763:	c7 45 f0 e0 0a 00 00 	movl   $0xae0,-0x10(%ebp)
 76a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76d:	a3 e8 0a 00 00       	mov    %eax,0xae8
 772:	a1 e8 0a 00 00       	mov    0xae8,%eax
 777:	a3 e0 0a 00 00       	mov    %eax,0xae0
    base.s.size = 0;
 77c:	c7 05 e4 0a 00 00 00 	movl   $0x0,0xae4
 783:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 786:	8b 45 f0             	mov    -0x10(%ebp),%eax
 789:	8b 00                	mov    (%eax),%eax
 78b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 78e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 791:	8b 40 04             	mov    0x4(%eax),%eax
 794:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 797:	72 4d                	jb     7e6 <malloc+0xa6>
      if(p->s.size == nunits)
 799:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79c:	8b 40 04             	mov    0x4(%eax),%eax
 79f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7a2:	75 0c                	jne    7b0 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a7:	8b 10                	mov    (%eax),%edx
 7a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ac:	89 10                	mov    %edx,(%eax)
 7ae:	eb 26                	jmp    7d6 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b9:	89 c2                	mov    %eax,%edx
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c4:	8b 40 04             	mov    0x4(%eax),%eax
 7c7:	c1 e0 03             	shl    $0x3,%eax
 7ca:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d0:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7d3:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d9:	a3 e8 0a 00 00       	mov    %eax,0xae8
      return (void*)(p + 1);
 7de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e1:	83 c0 08             	add    $0x8,%eax
 7e4:	eb 3b                	jmp    821 <malloc+0xe1>
    }
    if(p == freep)
 7e6:	a1 e8 0a 00 00       	mov    0xae8,%eax
 7eb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7ee:	75 1e                	jne    80e <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7f0:	83 ec 0c             	sub    $0xc,%esp
 7f3:	ff 75 ec             	pushl  -0x14(%ebp)
 7f6:	e8 e5 fe ff ff       	call   6e0 <morecore>
 7fb:	83 c4 10             	add    $0x10,%esp
 7fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
 801:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 805:	75 07                	jne    80e <malloc+0xce>
        return 0;
 807:	b8 00 00 00 00       	mov    $0x0,%eax
 80c:	eb 13                	jmp    821 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 811:	89 45 f0             	mov    %eax,-0x10(%ebp)
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	8b 00                	mov    (%eax),%eax
 819:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 81c:	e9 6d ff ff ff       	jmp    78e <malloc+0x4e>
}
 821:	c9                   	leave  
 822:	c3                   	ret    
