
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
  1a:	68 1b 08 00 00       	push   $0x81b
  1f:	6a 01                	push   $0x1
  21:	e8 3f 04 00 00       	call   465 <printf>
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
 258:	0f b6 80 1f 08 00 00 	movzbl 0x81f(%eax),%eax
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

0000038e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 38e:	55                   	push   %ebp
 38f:	89 e5                	mov    %esp,%ebp
 391:	83 ec 18             	sub    $0x18,%esp
 394:	8b 45 0c             	mov    0xc(%ebp),%eax
 397:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 39a:	83 ec 04             	sub    $0x4,%esp
 39d:	6a 01                	push   $0x1
 39f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3a2:	50                   	push   %eax
 3a3:	ff 75 08             	pushl  0x8(%ebp)
 3a6:	e8 4b ff ff ff       	call   2f6 <write>
 3ab:	83 c4 10             	add    $0x10,%esp
}
 3ae:	90                   	nop
 3af:	c9                   	leave  
 3b0:	c3                   	ret    

000003b1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b1:	55                   	push   %ebp
 3b2:	89 e5                	mov    %esp,%ebp
 3b4:	53                   	push   %ebx
 3b5:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3bf:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c3:	74 17                	je     3dc <printint+0x2b>
 3c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3c9:	79 11                	jns    3dc <printint+0x2b>
    neg = 1;
 3cb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d5:	f7 d8                	neg    %eax
 3d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3da:	eb 06                	jmp    3e2 <printint+0x31>
  } else {
    x = xx;
 3dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3df:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3e9:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3ec:	8d 41 01             	lea    0x1(%ecx),%eax
 3ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3f2:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f5:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f8:	ba 00 00 00 00       	mov    $0x0,%edx
 3fd:	f7 f3                	div    %ebx
 3ff:	89 d0                	mov    %edx,%eax
 401:	0f b6 80 a0 0a 00 00 	movzbl 0xaa0(%eax),%eax
 408:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 40c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 40f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 412:	ba 00 00 00 00       	mov    $0x0,%edx
 417:	f7 f3                	div    %ebx
 419:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 420:	75 c7                	jne    3e9 <printint+0x38>
  if(neg)
 422:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 426:	74 2d                	je     455 <printint+0xa4>
    buf[i++] = '-';
 428:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42b:	8d 50 01             	lea    0x1(%eax),%edx
 42e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 431:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 436:	eb 1d                	jmp    455 <printint+0xa4>
    putc(fd, buf[i]);
 438:	8d 55 dc             	lea    -0x24(%ebp),%edx
 43b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43e:	01 d0                	add    %edx,%eax
 440:	0f b6 00             	movzbl (%eax),%eax
 443:	0f be c0             	movsbl %al,%eax
 446:	83 ec 08             	sub    $0x8,%esp
 449:	50                   	push   %eax
 44a:	ff 75 08             	pushl  0x8(%ebp)
 44d:	e8 3c ff ff ff       	call   38e <putc>
 452:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 455:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 459:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 45d:	79 d9                	jns    438 <printint+0x87>
    putc(fd, buf[i]);
}
 45f:	90                   	nop
 460:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 463:	c9                   	leave  
 464:	c3                   	ret    

00000465 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 465:	55                   	push   %ebp
 466:	89 e5                	mov    %esp,%ebp
 468:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 46b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 472:	8d 45 0c             	lea    0xc(%ebp),%eax
 475:	83 c0 04             	add    $0x4,%eax
 478:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 47b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 482:	e9 59 01 00 00       	jmp    5e0 <printf+0x17b>
    c = fmt[i] & 0xff;
 487:	8b 55 0c             	mov    0xc(%ebp),%edx
 48a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 48d:	01 d0                	add    %edx,%eax
 48f:	0f b6 00             	movzbl (%eax),%eax
 492:	0f be c0             	movsbl %al,%eax
 495:	25 ff 00 00 00       	and    $0xff,%eax
 49a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 49d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a1:	75 2c                	jne    4cf <printf+0x6a>
      if(c == '%'){
 4a3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4a7:	75 0c                	jne    4b5 <printf+0x50>
        state = '%';
 4a9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b0:	e9 27 01 00 00       	jmp    5dc <printf+0x177>
      } else {
        putc(fd, c);
 4b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b8:	0f be c0             	movsbl %al,%eax
 4bb:	83 ec 08             	sub    $0x8,%esp
 4be:	50                   	push   %eax
 4bf:	ff 75 08             	pushl  0x8(%ebp)
 4c2:	e8 c7 fe ff ff       	call   38e <putc>
 4c7:	83 c4 10             	add    $0x10,%esp
 4ca:	e9 0d 01 00 00       	jmp    5dc <printf+0x177>
      }
    } else if(state == '%'){
 4cf:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d3:	0f 85 03 01 00 00    	jne    5dc <printf+0x177>
      if(c == 'd'){
 4d9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4dd:	75 1e                	jne    4fd <printf+0x98>
        printint(fd, *ap, 10, 1);
 4df:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e2:	8b 00                	mov    (%eax),%eax
 4e4:	6a 01                	push   $0x1
 4e6:	6a 0a                	push   $0xa
 4e8:	50                   	push   %eax
 4e9:	ff 75 08             	pushl  0x8(%ebp)
 4ec:	e8 c0 fe ff ff       	call   3b1 <printint>
 4f1:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f8:	e9 d8 00 00 00       	jmp    5d5 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4fd:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 501:	74 06                	je     509 <printf+0xa4>
 503:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 507:	75 1e                	jne    527 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 509:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50c:	8b 00                	mov    (%eax),%eax
 50e:	6a 00                	push   $0x0
 510:	6a 10                	push   $0x10
 512:	50                   	push   %eax
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	e8 96 fe ff ff       	call   3b1 <printint>
 51b:	83 c4 10             	add    $0x10,%esp
        ap++;
 51e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 522:	e9 ae 00 00 00       	jmp    5d5 <printf+0x170>
      } else if(c == 's'){
 527:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 52b:	75 43                	jne    570 <printf+0x10b>
        s = (char*)*ap;
 52d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 530:	8b 00                	mov    (%eax),%eax
 532:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 535:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 539:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 53d:	75 25                	jne    564 <printf+0xff>
          s = "(null)";
 53f:	c7 45 f4 30 08 00 00 	movl   $0x830,-0xc(%ebp)
        while(*s != 0){
 546:	eb 1c                	jmp    564 <printf+0xff>
          putc(fd, *s);
 548:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54b:	0f b6 00             	movzbl (%eax),%eax
 54e:	0f be c0             	movsbl %al,%eax
 551:	83 ec 08             	sub    $0x8,%esp
 554:	50                   	push   %eax
 555:	ff 75 08             	pushl  0x8(%ebp)
 558:	e8 31 fe ff ff       	call   38e <putc>
 55d:	83 c4 10             	add    $0x10,%esp
          s++;
 560:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 564:	8b 45 f4             	mov    -0xc(%ebp),%eax
 567:	0f b6 00             	movzbl (%eax),%eax
 56a:	84 c0                	test   %al,%al
 56c:	75 da                	jne    548 <printf+0xe3>
 56e:	eb 65                	jmp    5d5 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 570:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 574:	75 1d                	jne    593 <printf+0x12e>
        putc(fd, *ap);
 576:	8b 45 e8             	mov    -0x18(%ebp),%eax
 579:	8b 00                	mov    (%eax),%eax
 57b:	0f be c0             	movsbl %al,%eax
 57e:	83 ec 08             	sub    $0x8,%esp
 581:	50                   	push   %eax
 582:	ff 75 08             	pushl  0x8(%ebp)
 585:	e8 04 fe ff ff       	call   38e <putc>
 58a:	83 c4 10             	add    $0x10,%esp
        ap++;
 58d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 591:	eb 42                	jmp    5d5 <printf+0x170>
      } else if(c == '%'){
 593:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 597:	75 17                	jne    5b0 <printf+0x14b>
        putc(fd, c);
 599:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59c:	0f be c0             	movsbl %al,%eax
 59f:	83 ec 08             	sub    $0x8,%esp
 5a2:	50                   	push   %eax
 5a3:	ff 75 08             	pushl  0x8(%ebp)
 5a6:	e8 e3 fd ff ff       	call   38e <putc>
 5ab:	83 c4 10             	add    $0x10,%esp
 5ae:	eb 25                	jmp    5d5 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b0:	83 ec 08             	sub    $0x8,%esp
 5b3:	6a 25                	push   $0x25
 5b5:	ff 75 08             	pushl  0x8(%ebp)
 5b8:	e8 d1 fd ff ff       	call   38e <putc>
 5bd:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5c0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c3:	0f be c0             	movsbl %al,%eax
 5c6:	83 ec 08             	sub    $0x8,%esp
 5c9:	50                   	push   %eax
 5ca:	ff 75 08             	pushl  0x8(%ebp)
 5cd:	e8 bc fd ff ff       	call   38e <putc>
 5d2:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5d5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5dc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e0:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5e6:	01 d0                	add    %edx,%eax
 5e8:	0f b6 00             	movzbl (%eax),%eax
 5eb:	84 c0                	test   %al,%al
 5ed:	0f 85 94 fe ff ff    	jne    487 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5f3:	90                   	nop
 5f4:	c9                   	leave  
 5f5:	c3                   	ret    

000005f6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f6:	55                   	push   %ebp
 5f7:	89 e5                	mov    %esp,%ebp
 5f9:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5fc:	8b 45 08             	mov    0x8(%ebp),%eax
 5ff:	83 e8 08             	sub    $0x8,%eax
 602:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 605:	a1 e8 0a 00 00       	mov    0xae8,%eax
 60a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60d:	eb 24                	jmp    633 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 617:	77 12                	ja     62b <free+0x35>
 619:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61f:	77 24                	ja     645 <free+0x4f>
 621:	8b 45 fc             	mov    -0x4(%ebp),%eax
 624:	8b 00                	mov    (%eax),%eax
 626:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 629:	77 1a                	ja     645 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 62b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62e:	8b 00                	mov    (%eax),%eax
 630:	89 45 fc             	mov    %eax,-0x4(%ebp)
 633:	8b 45 f8             	mov    -0x8(%ebp),%eax
 636:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 639:	76 d4                	jbe    60f <free+0x19>
 63b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63e:	8b 00                	mov    (%eax),%eax
 640:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 643:	76 ca                	jbe    60f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 645:	8b 45 f8             	mov    -0x8(%ebp),%eax
 648:	8b 40 04             	mov    0x4(%eax),%eax
 64b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	01 c2                	add    %eax,%edx
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	8b 00                	mov    (%eax),%eax
 65c:	39 c2                	cmp    %eax,%edx
 65e:	75 24                	jne    684 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	8b 50 04             	mov    0x4(%eax),%edx
 666:	8b 45 fc             	mov    -0x4(%ebp),%eax
 669:	8b 00                	mov    (%eax),%eax
 66b:	8b 40 04             	mov    0x4(%eax),%eax
 66e:	01 c2                	add    %eax,%edx
 670:	8b 45 f8             	mov    -0x8(%ebp),%eax
 673:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	8b 00                	mov    (%eax),%eax
 67b:	8b 10                	mov    (%eax),%edx
 67d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 680:	89 10                	mov    %edx,(%eax)
 682:	eb 0a                	jmp    68e <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 684:	8b 45 fc             	mov    -0x4(%ebp),%eax
 687:	8b 10                	mov    (%eax),%edx
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 68e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 691:	8b 40 04             	mov    0x4(%eax),%eax
 694:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	01 d0                	add    %edx,%eax
 6a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a3:	75 20                	jne    6c5 <free+0xcf>
    p->s.size += bp->s.size;
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	8b 50 04             	mov    0x4(%eax),%edx
 6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ae:	8b 40 04             	mov    0x4(%eax),%eax
 6b1:	01 c2                	add    %eax,%edx
 6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bc:	8b 10                	mov    (%eax),%edx
 6be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c1:	89 10                	mov    %edx,(%eax)
 6c3:	eb 08                	jmp    6cd <free+0xd7>
  } else
    p->s.ptr = bp;
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6cb:	89 10                	mov    %edx,(%eax)
  freep = p;
 6cd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d0:	a3 e8 0a 00 00       	mov    %eax,0xae8
}
 6d5:	90                   	nop
 6d6:	c9                   	leave  
 6d7:	c3                   	ret    

000006d8 <morecore>:

static Header*
morecore(uint nu)
{
 6d8:	55                   	push   %ebp
 6d9:	89 e5                	mov    %esp,%ebp
 6db:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6de:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6e5:	77 07                	ja     6ee <morecore+0x16>
    nu = 4096;
 6e7:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6ee:	8b 45 08             	mov    0x8(%ebp),%eax
 6f1:	c1 e0 03             	shl    $0x3,%eax
 6f4:	83 ec 0c             	sub    $0xc,%esp
 6f7:	50                   	push   %eax
 6f8:	e8 61 fc ff ff       	call   35e <sbrk>
 6fd:	83 c4 10             	add    $0x10,%esp
 700:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 703:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 707:	75 07                	jne    710 <morecore+0x38>
    return 0;
 709:	b8 00 00 00 00       	mov    $0x0,%eax
 70e:	eb 26                	jmp    736 <morecore+0x5e>
  hp = (Header*)p;
 710:	8b 45 f4             	mov    -0xc(%ebp),%eax
 713:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 716:	8b 45 f0             	mov    -0x10(%ebp),%eax
 719:	8b 55 08             	mov    0x8(%ebp),%edx
 71c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 71f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 722:	83 c0 08             	add    $0x8,%eax
 725:	83 ec 0c             	sub    $0xc,%esp
 728:	50                   	push   %eax
 729:	e8 c8 fe ff ff       	call   5f6 <free>
 72e:	83 c4 10             	add    $0x10,%esp
  return freep;
 731:	a1 e8 0a 00 00       	mov    0xae8,%eax
}
 736:	c9                   	leave  
 737:	c3                   	ret    

00000738 <malloc>:

void*
malloc(uint nbytes)
{
 738:	55                   	push   %ebp
 739:	89 e5                	mov    %esp,%ebp
 73b:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 73e:	8b 45 08             	mov    0x8(%ebp),%eax
 741:	83 c0 07             	add    $0x7,%eax
 744:	c1 e8 03             	shr    $0x3,%eax
 747:	83 c0 01             	add    $0x1,%eax
 74a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 74d:	a1 e8 0a 00 00       	mov    0xae8,%eax
 752:	89 45 f0             	mov    %eax,-0x10(%ebp)
 755:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 759:	75 23                	jne    77e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 75b:	c7 45 f0 e0 0a 00 00 	movl   $0xae0,-0x10(%ebp)
 762:	8b 45 f0             	mov    -0x10(%ebp),%eax
 765:	a3 e8 0a 00 00       	mov    %eax,0xae8
 76a:	a1 e8 0a 00 00       	mov    0xae8,%eax
 76f:	a3 e0 0a 00 00       	mov    %eax,0xae0
    base.s.size = 0;
 774:	c7 05 e4 0a 00 00 00 	movl   $0x0,0xae4
 77b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 77e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 781:	8b 00                	mov    (%eax),%eax
 783:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 786:	8b 45 f4             	mov    -0xc(%ebp),%eax
 789:	8b 40 04             	mov    0x4(%eax),%eax
 78c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 78f:	72 4d                	jb     7de <malloc+0xa6>
      if(p->s.size == nunits)
 791:	8b 45 f4             	mov    -0xc(%ebp),%eax
 794:	8b 40 04             	mov    0x4(%eax),%eax
 797:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 79a:	75 0c                	jne    7a8 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	8b 10                	mov    (%eax),%edx
 7a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a4:	89 10                	mov    %edx,(%eax)
 7a6:	eb 26                	jmp    7ce <malloc+0x96>
      else {
        p->s.size -= nunits;
 7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ab:	8b 40 04             	mov    0x4(%eax),%eax
 7ae:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b1:	89 c2                	mov    %eax,%edx
 7b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b6:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bc:	8b 40 04             	mov    0x4(%eax),%eax
 7bf:	c1 e0 03             	shl    $0x3,%eax
 7c2:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7cb:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d1:	a3 e8 0a 00 00       	mov    %eax,0xae8
      return (void*)(p + 1);
 7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d9:	83 c0 08             	add    $0x8,%eax
 7dc:	eb 3b                	jmp    819 <malloc+0xe1>
    }
    if(p == freep)
 7de:	a1 e8 0a 00 00       	mov    0xae8,%eax
 7e3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7e6:	75 1e                	jne    806 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7e8:	83 ec 0c             	sub    $0xc,%esp
 7eb:	ff 75 ec             	pushl  -0x14(%ebp)
 7ee:	e8 e5 fe ff ff       	call   6d8 <morecore>
 7f3:	83 c4 10             	add    $0x10,%esp
 7f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7fd:	75 07                	jne    806 <malloc+0xce>
        return 0;
 7ff:	b8 00 00 00 00       	mov    $0x0,%eax
 804:	eb 13                	jmp    819 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 806:	8b 45 f4             	mov    -0xc(%ebp),%eax
 809:	89 45 f0             	mov    %eax,-0x10(%ebp)
 80c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80f:	8b 00                	mov    (%eax),%eax
 811:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 814:	e9 6d ff ff ff       	jmp    786 <malloc+0x4e>
}
 819:	c9                   	leave  
 81a:	c3                   	ret    
