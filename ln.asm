
_ln:     file format elf32-i386


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
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 69 08 00 00       	push   $0x869
  1e:	6a 02                	push   $0x2
  20:	e8 8e 04 00 00       	call   4b3 <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit();
  28:	e8 ef 02 00 00       	call   31c <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2d:	8b 43 04             	mov    0x4(%ebx),%eax
  30:	83 c0 08             	add    $0x8,%eax
  33:	8b 10                	mov    (%eax),%edx
  35:	8b 43 04             	mov    0x4(%ebx),%eax
  38:	83 c0 04             	add    $0x4,%eax
  3b:	8b 00                	mov    (%eax),%eax
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	52                   	push   %edx
  41:	50                   	push   %eax
  42:	e8 35 03 00 00       	call   37c <link>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	83 c0 08             	add    $0x8,%eax
  54:	8b 10                	mov    (%eax),%edx
  56:	8b 43 04             	mov    0x4(%ebx),%eax
  59:	83 c0 04             	add    $0x4,%eax
  5c:	8b 00                	mov    (%eax),%eax
  5e:	52                   	push   %edx
  5f:	50                   	push   %eax
  60:	68 7c 08 00 00       	push   $0x87c
  65:	6a 02                	push   $0x2
  67:	e8 47 04 00 00       	call   4b3 <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  exit();
  6f:	e8 a8 02 00 00       	call   31c <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7c:	8b 55 10             	mov    0x10(%ebp),%edx
  7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  82:	89 cb                	mov    %ecx,%ebx
  84:	89 df                	mov    %ebx,%edi
  86:	89 d1                	mov    %edx,%ecx
  88:	fc                   	cld    
  89:	f3 aa                	rep stos %al,%es:(%edi)
  8b:	89 ca                	mov    %ecx,%edx
  8d:	89 fb                	mov    %edi,%ebx
  8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  95:	90                   	nop
  96:	5b                   	pop    %ebx
  97:	5f                   	pop    %edi
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  9a:	55                   	push   %ebp
  9b:	89 e5                	mov    %esp,%ebp
  9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a6:	90                   	nop
  a7:	8b 45 08             	mov    0x8(%ebp),%eax
  aa:	8d 50 01             	lea    0x1(%eax),%edx
  ad:	89 55 08             	mov    %edx,0x8(%ebp)
  b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  b3:	8d 4a 01             	lea    0x1(%edx),%ecx
  b6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b9:	0f b6 12             	movzbl (%edx),%edx
  bc:	88 10                	mov    %dl,(%eax)
  be:	0f b6 00             	movzbl (%eax),%eax
  c1:	84 c0                	test   %al,%al
  c3:	75 e2                	jne    a7 <strcpy+0xd>
    ;
  return os;
  c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c8:	c9                   	leave  
  c9:	c3                   	ret    

000000ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cd:	eb 08                	jmp    d7 <strcmp+0xd>
    p++, q++;
  cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	84 c0                	test   %al,%al
  df:	74 10                	je     f1 <strcmp+0x27>
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	0f b6 10             	movzbl (%eax),%edx
  e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  ea:	0f b6 00             	movzbl (%eax),%eax
  ed:	38 c2                	cmp    %al,%dl
  ef:	74 de                	je     cf <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	0f b6 d0             	movzbl %al,%edx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	0f b6 c0             	movzbl %al,%eax
 103:	29 c2                	sub    %eax,%edx
 105:	89 d0                	mov    %edx,%eax
}
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    

00000109 <strlen>:

uint
strlen(char *s)
{
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 116:	eb 04                	jmp    11c <strlen+0x13>
 118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11f:	8b 45 08             	mov    0x8(%ebp),%eax
 122:	01 d0                	add    %edx,%eax
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	84 c0                	test   %al,%al
 129:	75 ed                	jne    118 <strlen+0xf>
    ;
  return n;
 12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12e:	c9                   	leave  
 12f:	c3                   	ret    

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 133:	8b 45 10             	mov    0x10(%ebp),%eax
 136:	50                   	push   %eax
 137:	ff 75 0c             	pushl  0xc(%ebp)
 13a:	ff 75 08             	pushl  0x8(%ebp)
 13d:	e8 32 ff ff ff       	call   74 <stosb>
 142:	83 c4 0c             	add    $0xc,%esp
  return dst;
 145:	8b 45 08             	mov    0x8(%ebp),%eax
}
 148:	c9                   	leave  
 149:	c3                   	ret    

0000014a <strchr>:

char*
strchr(const char *s, char c)
{
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 04             	sub    $0x4,%esp
 150:	8b 45 0c             	mov    0xc(%ebp),%eax
 153:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 156:	eb 14                	jmp    16c <strchr+0x22>
    if(*s == c)
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	3a 45 fc             	cmp    -0x4(%ebp),%al
 161:	75 05                	jne    168 <strchr+0x1e>
      return (char*)s;
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	eb 13                	jmp    17b <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	84 c0                	test   %al,%al
 174:	75 e2                	jne    158 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 176:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17b:	c9                   	leave  
 17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
 17d:	55                   	push   %ebp
 17e:	89 e5                	mov    %esp,%ebp
 180:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18a:	eb 42                	jmp    1ce <gets+0x51>
    cc = read(0, &c, 1);
 18c:	83 ec 04             	sub    $0x4,%esp
 18f:	6a 01                	push   $0x1
 191:	8d 45 ef             	lea    -0x11(%ebp),%eax
 194:	50                   	push   %eax
 195:	6a 00                	push   $0x0
 197:	e8 98 01 00 00       	call   334 <read>
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a6:	7e 33                	jle    1db <gets+0x5e>
      break;
    buf[i++] = c;
 1a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ab:	8d 50 01             	lea    0x1(%eax),%edx
 1ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b1:	89 c2                	mov    %eax,%edx
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	01 c2                	add    %eax,%edx
 1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bc:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c2:	3c 0a                	cmp    $0xa,%al
 1c4:	74 16                	je     1dc <gets+0x5f>
 1c6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ca:	3c 0d                	cmp    $0xd,%al
 1cc:	74 0e                	je     1dc <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d1:	83 c0 01             	add    $0x1,%eax
 1d4:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d7:	7c b3                	jl     18c <gets+0xf>
 1d9:	eb 01                	jmp    1dc <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1db:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	01 d0                	add    %edx,%eax
 1e4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ea:	c9                   	leave  
 1eb:	c3                   	ret    

000001ec <stat>:

int
stat(char *n, struct stat *st)
{
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f2:	83 ec 08             	sub    $0x8,%esp
 1f5:	6a 00                	push   $0x0
 1f7:	ff 75 08             	pushl  0x8(%ebp)
 1fa:	e8 5d 01 00 00       	call   35c <open>
 1ff:	83 c4 10             	add    $0x10,%esp
 202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 209:	79 07                	jns    212 <stat+0x26>
    return -1;
 20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 210:	eb 25                	jmp    237 <stat+0x4b>
  r = fstat(fd, st);
 212:	83 ec 08             	sub    $0x8,%esp
 215:	ff 75 0c             	pushl  0xc(%ebp)
 218:	ff 75 f4             	pushl  -0xc(%ebp)
 21b:	e8 54 01 00 00       	call   374 <fstat>
 220:	83 c4 10             	add    $0x10,%esp
 223:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 226:	83 ec 0c             	sub    $0xc,%esp
 229:	ff 75 f4             	pushl  -0xc(%ebp)
 22c:	e8 13 01 00 00       	call   344 <close>
 231:	83 c4 10             	add    $0x10,%esp
  return r;
 234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 237:	c9                   	leave  
 238:	c3                   	ret    

00000239 <atoi>:

int
atoi(const char *s)
{
 239:	55                   	push   %ebp
 23a:	89 e5                	mov    %esp,%ebp
 23c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 246:	eb 25                	jmp    26d <atoi+0x34>
    n = n*10 + *s++ - '0';
 248:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24b:	89 d0                	mov    %edx,%eax
 24d:	c1 e0 02             	shl    $0x2,%eax
 250:	01 d0                	add    %edx,%eax
 252:	01 c0                	add    %eax,%eax
 254:	89 c1                	mov    %eax,%ecx
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 08             	mov    %edx,0x8(%ebp)
 25f:	0f b6 00             	movzbl (%eax),%eax
 262:	0f be c0             	movsbl %al,%eax
 265:	01 c8                	add    %ecx,%eax
 267:	83 e8 30             	sub    $0x30,%eax
 26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2f                	cmp    $0x2f,%al
 275:	7e 0a                	jle    281 <atoi+0x48>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 39                	cmp    $0x39,%al
 27f:	7e c7                	jle    248 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <itoa>:

char*
itoa(int val, int base){
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 28c:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 293:	eb 29                	jmp    2be <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 295:	8b 45 08             	mov    0x8(%ebp),%eax
 298:	99                   	cltd   
 299:	f7 7d 0c             	idivl  0xc(%ebp)
 29c:	89 d0                	mov    %edx,%eax
 29e:	0f b6 80 90 08 00 00 	movzbl 0x890(%eax),%eax
 2a5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2a8:	81 c2 40 0b 00 00    	add    $0xb40,%edx
 2ae:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 2b0:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 2b4:	8b 45 08             	mov    0x8(%ebp),%eax
 2b7:	99                   	cltd   
 2b8:	f7 7d 0c             	idivl  0xc(%ebp)
 2bb:	89 45 08             	mov    %eax,0x8(%ebp)
 2be:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2c2:	74 06                	je     2ca <itoa+0x44>
 2c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 2c8:	75 cb                	jne    295 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 2ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2cd:	83 c0 01             	add    $0x1,%eax
 2d0:	05 40 0b 00 00       	add    $0xb40,%eax

}
 2d5:	c9                   	leave  
 2d6:	c3                   	ret    

000002d7 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2d7:	55                   	push   %ebp
 2d8:	89 e5                	mov    %esp,%ebp
 2da:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2e3:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e6:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2e9:	eb 17                	jmp    302 <memmove+0x2b>
    *dst++ = *src++;
 2eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2ee:	8d 50 01             	lea    0x1(%eax),%edx
 2f1:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2f4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2f7:	8d 4a 01             	lea    0x1(%edx),%ecx
 2fa:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2fd:	0f b6 12             	movzbl (%edx),%edx
 300:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 302:	8b 45 10             	mov    0x10(%ebp),%eax
 305:	8d 50 ff             	lea    -0x1(%eax),%edx
 308:	89 55 10             	mov    %edx,0x10(%ebp)
 30b:	85 c0                	test   %eax,%eax
 30d:	7f dc                	jg     2eb <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 312:	c9                   	leave  
 313:	c3                   	ret    

00000314 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 314:	b8 01 00 00 00       	mov    $0x1,%eax
 319:	cd 40                	int    $0x40
 31b:	c3                   	ret    

0000031c <exit>:
SYSCALL(exit)
 31c:	b8 02 00 00 00       	mov    $0x2,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <wait>:
SYSCALL(wait)
 324:	b8 03 00 00 00       	mov    $0x3,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <pipe>:
SYSCALL(pipe)
 32c:	b8 04 00 00 00       	mov    $0x4,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <read>:
SYSCALL(read)
 334:	b8 05 00 00 00       	mov    $0x5,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <write>:
SYSCALL(write)
 33c:	b8 10 00 00 00       	mov    $0x10,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <close>:
SYSCALL(close)
 344:	b8 15 00 00 00       	mov    $0x15,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <kill>:
SYSCALL(kill)
 34c:	b8 06 00 00 00       	mov    $0x6,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <exec>:
SYSCALL(exec)
 354:	b8 07 00 00 00       	mov    $0x7,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <open>:
SYSCALL(open)
 35c:	b8 0f 00 00 00       	mov    $0xf,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <mknod>:
SYSCALL(mknod)
 364:	b8 11 00 00 00       	mov    $0x11,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <unlink>:
SYSCALL(unlink)
 36c:	b8 12 00 00 00       	mov    $0x12,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <fstat>:
SYSCALL(fstat)
 374:	b8 08 00 00 00       	mov    $0x8,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <link>:
SYSCALL(link)
 37c:	b8 13 00 00 00       	mov    $0x13,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <mkdir>:
SYSCALL(mkdir)
 384:	b8 14 00 00 00       	mov    $0x14,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <chdir>:
SYSCALL(chdir)
 38c:	b8 09 00 00 00       	mov    $0x9,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <dup>:
SYSCALL(dup)
 394:	b8 0a 00 00 00       	mov    $0xa,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <getpid>:
SYSCALL(getpid)
 39c:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <sbrk>:
SYSCALL(sbrk)
 3a4:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <sleep>:
SYSCALL(sleep)
 3ac:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <uptime>:
SYSCALL(uptime)
 3b4:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <randomX>:
SYSCALL(randomX)
 3bc:	b8 16 00 00 00       	mov    $0x16,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <setSeedX>:
SYSCALL(setSeedX)
 3c4:	b8 17 00 00 00       	mov    $0x17,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <uniformR>:
SYSCALL(uniformR)
 3cc:	b8 18 00 00 00       	mov    $0x18,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <setdeadline>:
 3d4:	b8 19 00 00 00       	mov    $0x19,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3dc:	55                   	push   %ebp
 3dd:	89 e5                	mov    %esp,%ebp
 3df:	83 ec 18             	sub    $0x18,%esp
 3e2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3e8:	83 ec 04             	sub    $0x4,%esp
 3eb:	6a 01                	push   $0x1
 3ed:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3f0:	50                   	push   %eax
 3f1:	ff 75 08             	pushl  0x8(%ebp)
 3f4:	e8 43 ff ff ff       	call   33c <write>
 3f9:	83 c4 10             	add    $0x10,%esp
}
 3fc:	90                   	nop
 3fd:	c9                   	leave  
 3fe:	c3                   	ret    

000003ff <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	53                   	push   %ebx
 403:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 406:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 40d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 411:	74 17                	je     42a <printint+0x2b>
 413:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 417:	79 11                	jns    42a <printint+0x2b>
    neg = 1;
 419:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 420:	8b 45 0c             	mov    0xc(%ebp),%eax
 423:	f7 d8                	neg    %eax
 425:	89 45 ec             	mov    %eax,-0x14(%ebp)
 428:	eb 06                	jmp    430 <printint+0x31>
  } else {
    x = xx;
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 430:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 437:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 43a:	8d 41 01             	lea    0x1(%ecx),%eax
 43d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 440:	8b 5d 10             	mov    0x10(%ebp),%ebx
 443:	8b 45 ec             	mov    -0x14(%ebp),%eax
 446:	ba 00 00 00 00       	mov    $0x0,%edx
 44b:	f7 f3                	div    %ebx
 44d:	89 d0                	mov    %edx,%eax
 44f:	0f b6 80 14 0b 00 00 	movzbl 0xb14(%eax),%eax
 456:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 45a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 45d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 460:	ba 00 00 00 00       	mov    $0x0,%edx
 465:	f7 f3                	div    %ebx
 467:	89 45 ec             	mov    %eax,-0x14(%ebp)
 46a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 46e:	75 c7                	jne    437 <printint+0x38>
  if(neg)
 470:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 474:	74 2d                	je     4a3 <printint+0xa4>
    buf[i++] = '-';
 476:	8b 45 f4             	mov    -0xc(%ebp),%eax
 479:	8d 50 01             	lea    0x1(%eax),%edx
 47c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 47f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 484:	eb 1d                	jmp    4a3 <printint+0xa4>
    putc(fd, buf[i]);
 486:	8d 55 dc             	lea    -0x24(%ebp),%edx
 489:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48c:	01 d0                	add    %edx,%eax
 48e:	0f b6 00             	movzbl (%eax),%eax
 491:	0f be c0             	movsbl %al,%eax
 494:	83 ec 08             	sub    $0x8,%esp
 497:	50                   	push   %eax
 498:	ff 75 08             	pushl  0x8(%ebp)
 49b:	e8 3c ff ff ff       	call   3dc <putc>
 4a0:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4a3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4ab:	79 d9                	jns    486 <printint+0x87>
    putc(fd, buf[i]);
}
 4ad:	90                   	nop
 4ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4b1:	c9                   	leave  
 4b2:	c3                   	ret    

000004b3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b3:	55                   	push   %ebp
 4b4:	89 e5                	mov    %esp,%ebp
 4b6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4c0:	8d 45 0c             	lea    0xc(%ebp),%eax
 4c3:	83 c0 04             	add    $0x4,%eax
 4c6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4d0:	e9 59 01 00 00       	jmp    62e <printf+0x17b>
    c = fmt[i] & 0xff;
 4d5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4db:	01 d0                	add    %edx,%eax
 4dd:	0f b6 00             	movzbl (%eax),%eax
 4e0:	0f be c0             	movsbl %al,%eax
 4e3:	25 ff 00 00 00       	and    $0xff,%eax
 4e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ef:	75 2c                	jne    51d <printf+0x6a>
      if(c == '%'){
 4f1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f5:	75 0c                	jne    503 <printf+0x50>
        state = '%';
 4f7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4fe:	e9 27 01 00 00       	jmp    62a <printf+0x177>
      } else {
        putc(fd, c);
 503:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 506:	0f be c0             	movsbl %al,%eax
 509:	83 ec 08             	sub    $0x8,%esp
 50c:	50                   	push   %eax
 50d:	ff 75 08             	pushl  0x8(%ebp)
 510:	e8 c7 fe ff ff       	call   3dc <putc>
 515:	83 c4 10             	add    $0x10,%esp
 518:	e9 0d 01 00 00       	jmp    62a <printf+0x177>
      }
    } else if(state == '%'){
 51d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 521:	0f 85 03 01 00 00    	jne    62a <printf+0x177>
      if(c == 'd'){
 527:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 52b:	75 1e                	jne    54b <printf+0x98>
        printint(fd, *ap, 10, 1);
 52d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 530:	8b 00                	mov    (%eax),%eax
 532:	6a 01                	push   $0x1
 534:	6a 0a                	push   $0xa
 536:	50                   	push   %eax
 537:	ff 75 08             	pushl  0x8(%ebp)
 53a:	e8 c0 fe ff ff       	call   3ff <printint>
 53f:	83 c4 10             	add    $0x10,%esp
        ap++;
 542:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 546:	e9 d8 00 00 00       	jmp    623 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 54b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54f:	74 06                	je     557 <printf+0xa4>
 551:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 555:	75 1e                	jne    575 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 557:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55a:	8b 00                	mov    (%eax),%eax
 55c:	6a 00                	push   $0x0
 55e:	6a 10                	push   $0x10
 560:	50                   	push   %eax
 561:	ff 75 08             	pushl  0x8(%ebp)
 564:	e8 96 fe ff ff       	call   3ff <printint>
 569:	83 c4 10             	add    $0x10,%esp
        ap++;
 56c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 570:	e9 ae 00 00 00       	jmp    623 <printf+0x170>
      } else if(c == 's'){
 575:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 579:	75 43                	jne    5be <printf+0x10b>
        s = (char*)*ap;
 57b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57e:	8b 00                	mov    (%eax),%eax
 580:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 583:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 587:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 58b:	75 25                	jne    5b2 <printf+0xff>
          s = "(null)";
 58d:	c7 45 f4 a1 08 00 00 	movl   $0x8a1,-0xc(%ebp)
        while(*s != 0){
 594:	eb 1c                	jmp    5b2 <printf+0xff>
          putc(fd, *s);
 596:	8b 45 f4             	mov    -0xc(%ebp),%eax
 599:	0f b6 00             	movzbl (%eax),%eax
 59c:	0f be c0             	movsbl %al,%eax
 59f:	83 ec 08             	sub    $0x8,%esp
 5a2:	50                   	push   %eax
 5a3:	ff 75 08             	pushl  0x8(%ebp)
 5a6:	e8 31 fe ff ff       	call   3dc <putc>
 5ab:	83 c4 10             	add    $0x10,%esp
          s++;
 5ae:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b5:	0f b6 00             	movzbl (%eax),%eax
 5b8:	84 c0                	test   %al,%al
 5ba:	75 da                	jne    596 <printf+0xe3>
 5bc:	eb 65                	jmp    623 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5be:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5c2:	75 1d                	jne    5e1 <printf+0x12e>
        putc(fd, *ap);
 5c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c7:	8b 00                	mov    (%eax),%eax
 5c9:	0f be c0             	movsbl %al,%eax
 5cc:	83 ec 08             	sub    $0x8,%esp
 5cf:	50                   	push   %eax
 5d0:	ff 75 08             	pushl  0x8(%ebp)
 5d3:	e8 04 fe ff ff       	call   3dc <putc>
 5d8:	83 c4 10             	add    $0x10,%esp
        ap++;
 5db:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5df:	eb 42                	jmp    623 <printf+0x170>
      } else if(c == '%'){
 5e1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5e5:	75 17                	jne    5fe <printf+0x14b>
        putc(fd, c);
 5e7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ea:	0f be c0             	movsbl %al,%eax
 5ed:	83 ec 08             	sub    $0x8,%esp
 5f0:	50                   	push   %eax
 5f1:	ff 75 08             	pushl  0x8(%ebp)
 5f4:	e8 e3 fd ff ff       	call   3dc <putc>
 5f9:	83 c4 10             	add    $0x10,%esp
 5fc:	eb 25                	jmp    623 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5fe:	83 ec 08             	sub    $0x8,%esp
 601:	6a 25                	push   $0x25
 603:	ff 75 08             	pushl  0x8(%ebp)
 606:	e8 d1 fd ff ff       	call   3dc <putc>
 60b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 60e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 611:	0f be c0             	movsbl %al,%eax
 614:	83 ec 08             	sub    $0x8,%esp
 617:	50                   	push   %eax
 618:	ff 75 08             	pushl  0x8(%ebp)
 61b:	e8 bc fd ff ff       	call   3dc <putc>
 620:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 623:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 62a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 62e:	8b 55 0c             	mov    0xc(%ebp),%edx
 631:	8b 45 f0             	mov    -0x10(%ebp),%eax
 634:	01 d0                	add    %edx,%eax
 636:	0f b6 00             	movzbl (%eax),%eax
 639:	84 c0                	test   %al,%al
 63b:	0f 85 94 fe ff ff    	jne    4d5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 641:	90                   	nop
 642:	c9                   	leave  
 643:	c3                   	ret    

00000644 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 644:	55                   	push   %ebp
 645:	89 e5                	mov    %esp,%ebp
 647:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 64a:	8b 45 08             	mov    0x8(%ebp),%eax
 64d:	83 e8 08             	sub    $0x8,%eax
 650:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 653:	a1 68 0b 00 00       	mov    0xb68,%eax
 658:	89 45 fc             	mov    %eax,-0x4(%ebp)
 65b:	eb 24                	jmp    681 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 660:	8b 00                	mov    (%eax),%eax
 662:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 665:	77 12                	ja     679 <free+0x35>
 667:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66d:	77 24                	ja     693 <free+0x4f>
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 677:	77 1a                	ja     693 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 681:	8b 45 f8             	mov    -0x8(%ebp),%eax
 684:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 687:	76 d4                	jbe    65d <free+0x19>
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 691:	76 ca                	jbe    65d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 693:	8b 45 f8             	mov    -0x8(%ebp),%eax
 696:	8b 40 04             	mov    0x4(%eax),%eax
 699:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a3:	01 c2                	add    %eax,%edx
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	8b 00                	mov    (%eax),%eax
 6aa:	39 c2                	cmp    %eax,%edx
 6ac:	75 24                	jne    6d2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b1:	8b 50 04             	mov    0x4(%eax),%edx
 6b4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b7:	8b 00                	mov    (%eax),%eax
 6b9:	8b 40 04             	mov    0x4(%eax),%eax
 6bc:	01 c2                	add    %eax,%edx
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	8b 10                	mov    (%eax),%edx
 6cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ce:	89 10                	mov    %edx,(%eax)
 6d0:	eb 0a                	jmp    6dc <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	8b 10                	mov    (%eax),%edx
 6d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6da:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6df:	8b 40 04             	mov    0x4(%eax),%eax
 6e2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	01 d0                	add    %edx,%eax
 6ee:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f1:	75 20                	jne    713 <free+0xcf>
    p->s.size += bp->s.size;
 6f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f6:	8b 50 04             	mov    0x4(%eax),%edx
 6f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fc:	8b 40 04             	mov    0x4(%eax),%eax
 6ff:	01 c2                	add    %eax,%edx
 701:	8b 45 fc             	mov    -0x4(%ebp),%eax
 704:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 707:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70a:	8b 10                	mov    (%eax),%edx
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	89 10                	mov    %edx,(%eax)
 711:	eb 08                	jmp    71b <free+0xd7>
  } else
    p->s.ptr = bp;
 713:	8b 45 fc             	mov    -0x4(%ebp),%eax
 716:	8b 55 f8             	mov    -0x8(%ebp),%edx
 719:	89 10                	mov    %edx,(%eax)
  freep = p;
 71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71e:	a3 68 0b 00 00       	mov    %eax,0xb68
}
 723:	90                   	nop
 724:	c9                   	leave  
 725:	c3                   	ret    

00000726 <morecore>:

static Header*
morecore(uint nu)
{
 726:	55                   	push   %ebp
 727:	89 e5                	mov    %esp,%ebp
 729:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 72c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 733:	77 07                	ja     73c <morecore+0x16>
    nu = 4096;
 735:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 73c:	8b 45 08             	mov    0x8(%ebp),%eax
 73f:	c1 e0 03             	shl    $0x3,%eax
 742:	83 ec 0c             	sub    $0xc,%esp
 745:	50                   	push   %eax
 746:	e8 59 fc ff ff       	call   3a4 <sbrk>
 74b:	83 c4 10             	add    $0x10,%esp
 74e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 751:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 755:	75 07                	jne    75e <morecore+0x38>
    return 0;
 757:	b8 00 00 00 00       	mov    $0x0,%eax
 75c:	eb 26                	jmp    784 <morecore+0x5e>
  hp = (Header*)p;
 75e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 761:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 764:	8b 45 f0             	mov    -0x10(%ebp),%eax
 767:	8b 55 08             	mov    0x8(%ebp),%edx
 76a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 76d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 770:	83 c0 08             	add    $0x8,%eax
 773:	83 ec 0c             	sub    $0xc,%esp
 776:	50                   	push   %eax
 777:	e8 c8 fe ff ff       	call   644 <free>
 77c:	83 c4 10             	add    $0x10,%esp
  return freep;
 77f:	a1 68 0b 00 00       	mov    0xb68,%eax
}
 784:	c9                   	leave  
 785:	c3                   	ret    

00000786 <malloc>:

void*
malloc(uint nbytes)
{
 786:	55                   	push   %ebp
 787:	89 e5                	mov    %esp,%ebp
 789:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78c:	8b 45 08             	mov    0x8(%ebp),%eax
 78f:	83 c0 07             	add    $0x7,%eax
 792:	c1 e8 03             	shr    $0x3,%eax
 795:	83 c0 01             	add    $0x1,%eax
 798:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 79b:	a1 68 0b 00 00       	mov    0xb68,%eax
 7a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a7:	75 23                	jne    7cc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7a9:	c7 45 f0 60 0b 00 00 	movl   $0xb60,-0x10(%ebp)
 7b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b3:	a3 68 0b 00 00       	mov    %eax,0xb68
 7b8:	a1 68 0b 00 00       	mov    0xb68,%eax
 7bd:	a3 60 0b 00 00       	mov    %eax,0xb60
    base.s.size = 0;
 7c2:	c7 05 64 0b 00 00 00 	movl   $0x0,0xb64
 7c9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cf:	8b 00                	mov    (%eax),%eax
 7d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d7:	8b 40 04             	mov    0x4(%eax),%eax
 7da:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7dd:	72 4d                	jb     82c <malloc+0xa6>
      if(p->s.size == nunits)
 7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e2:	8b 40 04             	mov    0x4(%eax),%eax
 7e5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e8:	75 0c                	jne    7f6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ed:	8b 10                	mov    (%eax),%edx
 7ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f2:	89 10                	mov    %edx,(%eax)
 7f4:	eb 26                	jmp    81c <malloc+0x96>
      else {
        p->s.size -= nunits;
 7f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f9:	8b 40 04             	mov    0x4(%eax),%eax
 7fc:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7ff:	89 c2                	mov    %eax,%edx
 801:	8b 45 f4             	mov    -0xc(%ebp),%eax
 804:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 807:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80a:	8b 40 04             	mov    0x4(%eax),%eax
 80d:	c1 e0 03             	shl    $0x3,%eax
 810:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	8b 55 ec             	mov    -0x14(%ebp),%edx
 819:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 81c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81f:	a3 68 0b 00 00       	mov    %eax,0xb68
      return (void*)(p + 1);
 824:	8b 45 f4             	mov    -0xc(%ebp),%eax
 827:	83 c0 08             	add    $0x8,%eax
 82a:	eb 3b                	jmp    867 <malloc+0xe1>
    }
    if(p == freep)
 82c:	a1 68 0b 00 00       	mov    0xb68,%eax
 831:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 834:	75 1e                	jne    854 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 836:	83 ec 0c             	sub    $0xc,%esp
 839:	ff 75 ec             	pushl  -0x14(%ebp)
 83c:	e8 e5 fe ff ff       	call   726 <morecore>
 841:	83 c4 10             	add    $0x10,%esp
 844:	89 45 f4             	mov    %eax,-0xc(%ebp)
 847:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 84b:	75 07                	jne    854 <malloc+0xce>
        return 0;
 84d:	b8 00 00 00 00       	mov    $0x0,%eax
 852:	eb 13                	jmp    867 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 854:	8b 45 f4             	mov    -0xc(%ebp),%eax
 857:	89 45 f0             	mov    %eax,-0x10(%ebp)
 85a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85d:	8b 00                	mov    (%eax),%eax
 85f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 862:	e9 6d ff ff ff       	jmp    7d4 <malloc+0x4e>
}
 867:	c9                   	leave  
 868:	c3                   	ret    
