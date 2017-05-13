
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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
  int i;

  if(argc < 1){
  14:	83 3b 00             	cmpl   $0x0,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "usage: kill pid...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 5f 08 00 00       	push   $0x85f
  21:	6a 02                	push   $0x2
  23:	e8 81 04 00 00       	call   4a9 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 ea 02 00 00       	call   31a <exit>
  }
  for(i=1; i<argc; i++)
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 2d                	jmp    66 <main+0x66>
    kill(atoi(argv[i]));
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 e4 01 00 00       	call   237 <atoi>
  53:	83 c4 10             	add    $0x10,%esp
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	50                   	push   %eax
  5a:	e8 eb 02 00 00       	call   34a <kill>
  5f:	83 c4 10             	add    $0x10,%esp

  if(argc < 1){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  69:	3b 03                	cmp    (%ebx),%eax
  6b:	7c cc                	jl     39 <main+0x39>
    kill(atoi(argv[i]));
  exit();
  6d:	e8 a8 02 00 00       	call   31a <exit>

00000072 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  72:	55                   	push   %ebp
  73:	89 e5                	mov    %esp,%ebp
  75:	57                   	push   %edi
  76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  77:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7a:	8b 55 10             	mov    0x10(%ebp),%edx
  7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  80:	89 cb                	mov    %ecx,%ebx
  82:	89 df                	mov    %ebx,%edi
  84:	89 d1                	mov    %edx,%ecx
  86:	fc                   	cld    
  87:	f3 aa                	rep stos %al,%es:(%edi)
  89:	89 ca                	mov    %ecx,%edx
  8b:	89 fb                	mov    %edi,%ebx
  8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
  90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  93:	90                   	nop
  94:	5b                   	pop    %ebx
  95:	5f                   	pop    %edi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    

00000098 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  98:	55                   	push   %ebp
  99:	89 e5                	mov    %esp,%ebp
  9b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9e:	8b 45 08             	mov    0x8(%ebp),%eax
  a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a4:	90                   	nop
  a5:	8b 45 08             	mov    0x8(%ebp),%eax
  a8:	8d 50 01             	lea    0x1(%eax),%edx
  ab:	89 55 08             	mov    %edx,0x8(%ebp)
  ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  b1:	8d 4a 01             	lea    0x1(%edx),%ecx
  b4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b7:	0f b6 12             	movzbl (%edx),%edx
  ba:	88 10                	mov    %dl,(%eax)
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	84 c0                	test   %al,%al
  c1:	75 e2                	jne    a5 <strcpy+0xd>
    ;
  return os;
  c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c6:	c9                   	leave  
  c7:	c3                   	ret    

000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cb:	eb 08                	jmp    d5 <strcmp+0xd>
    p++, q++;
  cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	84 c0                	test   %al,%al
  dd:	74 10                	je     ef <strcmp+0x27>
  df:	8b 45 08             	mov    0x8(%ebp),%eax
  e2:	0f b6 10             	movzbl (%eax),%edx
  e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  e8:	0f b6 00             	movzbl (%eax),%eax
  eb:	38 c2                	cmp    %al,%dl
  ed:	74 de                	je     cd <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ef:	8b 45 08             	mov    0x8(%ebp),%eax
  f2:	0f b6 00             	movzbl (%eax),%eax
  f5:	0f b6 d0             	movzbl %al,%edx
  f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  fb:	0f b6 00             	movzbl (%eax),%eax
  fe:	0f b6 c0             	movzbl %al,%eax
 101:	29 c2                	sub    %eax,%edx
 103:	89 d0                	mov    %edx,%eax
}
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    

00000107 <strlen>:

uint
strlen(char *s)
{
 107:	55                   	push   %ebp
 108:	89 e5                	mov    %esp,%ebp
 10a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 114:	eb 04                	jmp    11a <strlen+0x13>
 116:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11d:	8b 45 08             	mov    0x8(%ebp),%eax
 120:	01 d0                	add    %edx,%eax
 122:	0f b6 00             	movzbl (%eax),%eax
 125:	84 c0                	test   %al,%al
 127:	75 ed                	jne    116 <strlen+0xf>
    ;
  return n;
 129:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12c:	c9                   	leave  
 12d:	c3                   	ret    

0000012e <memset>:

void*
memset(void *dst, int c, uint n)
{
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 131:	8b 45 10             	mov    0x10(%ebp),%eax
 134:	50                   	push   %eax
 135:	ff 75 0c             	pushl  0xc(%ebp)
 138:	ff 75 08             	pushl  0x8(%ebp)
 13b:	e8 32 ff ff ff       	call   72 <stosb>
 140:	83 c4 0c             	add    $0xc,%esp
  return dst;
 143:	8b 45 08             	mov    0x8(%ebp),%eax
}
 146:	c9                   	leave  
 147:	c3                   	ret    

00000148 <strchr>:

char*
strchr(const char *s, char c)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	83 ec 04             	sub    $0x4,%esp
 14e:	8b 45 0c             	mov    0xc(%ebp),%eax
 151:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 154:	eb 14                	jmp    16a <strchr+0x22>
    if(*s == c)
 156:	8b 45 08             	mov    0x8(%ebp),%eax
 159:	0f b6 00             	movzbl (%eax),%eax
 15c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15f:	75 05                	jne    166 <strchr+0x1e>
      return (char*)s;
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	eb 13                	jmp    179 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 166:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
 16d:	0f b6 00             	movzbl (%eax),%eax
 170:	84 c0                	test   %al,%al
 172:	75 e2                	jne    156 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 174:	b8 00 00 00 00       	mov    $0x0,%eax
}
 179:	c9                   	leave  
 17a:	c3                   	ret    

0000017b <gets>:

char*
gets(char *buf, int max)
{
 17b:	55                   	push   %ebp
 17c:	89 e5                	mov    %esp,%ebp
 17e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 181:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 188:	eb 42                	jmp    1cc <gets+0x51>
    cc = read(0, &c, 1);
 18a:	83 ec 04             	sub    $0x4,%esp
 18d:	6a 01                	push   $0x1
 18f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 192:	50                   	push   %eax
 193:	6a 00                	push   $0x0
 195:	e8 98 01 00 00       	call   332 <read>
 19a:	83 c4 10             	add    $0x10,%esp
 19d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a4:	7e 33                	jle    1d9 <gets+0x5e>
      break;
    buf[i++] = c;
 1a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a9:	8d 50 01             	lea    0x1(%eax),%edx
 1ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1af:	89 c2                	mov    %eax,%edx
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	01 c2                	add    %eax,%edx
 1b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ba:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c0:	3c 0a                	cmp    $0xa,%al
 1c2:	74 16                	je     1da <gets+0x5f>
 1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c8:	3c 0d                	cmp    $0xd,%al
 1ca:	74 0e                	je     1da <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1cf:	83 c0 01             	add    $0x1,%eax
 1d2:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d5:	7c b3                	jl     18a <gets+0xf>
 1d7:	eb 01                	jmp    1da <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1d9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1da:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	01 d0                	add    %edx,%eax
 1e2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e8:	c9                   	leave  
 1e9:	c3                   	ret    

000001ea <stat>:

int
stat(char *n, struct stat *st)
{
 1ea:	55                   	push   %ebp
 1eb:	89 e5                	mov    %esp,%ebp
 1ed:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f0:	83 ec 08             	sub    $0x8,%esp
 1f3:	6a 00                	push   $0x0
 1f5:	ff 75 08             	pushl  0x8(%ebp)
 1f8:	e8 5d 01 00 00       	call   35a <open>
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 203:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 207:	79 07                	jns    210 <stat+0x26>
    return -1;
 209:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 20e:	eb 25                	jmp    235 <stat+0x4b>
  r = fstat(fd, st);
 210:	83 ec 08             	sub    $0x8,%esp
 213:	ff 75 0c             	pushl  0xc(%ebp)
 216:	ff 75 f4             	pushl  -0xc(%ebp)
 219:	e8 54 01 00 00       	call   372 <fstat>
 21e:	83 c4 10             	add    $0x10,%esp
 221:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 224:	83 ec 0c             	sub    $0xc,%esp
 227:	ff 75 f4             	pushl  -0xc(%ebp)
 22a:	e8 13 01 00 00       	call   342 <close>
 22f:	83 c4 10             	add    $0x10,%esp
  return r;
 232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 235:	c9                   	leave  
 236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
 237:	55                   	push   %ebp
 238:	89 e5                	mov    %esp,%ebp
 23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 244:	eb 25                	jmp    26b <atoi+0x34>
    n = n*10 + *s++ - '0';
 246:	8b 55 fc             	mov    -0x4(%ebp),%edx
 249:	89 d0                	mov    %edx,%eax
 24b:	c1 e0 02             	shl    $0x2,%eax
 24e:	01 d0                	add    %edx,%eax
 250:	01 c0                	add    %eax,%eax
 252:	89 c1                	mov    %eax,%ecx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8d 50 01             	lea    0x1(%eax),%edx
 25a:	89 55 08             	mov    %edx,0x8(%ebp)
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	0f be c0             	movsbl %al,%eax
 263:	01 c8                	add    %ecx,%eax
 265:	83 e8 30             	sub    $0x30,%eax
 268:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	3c 2f                	cmp    $0x2f,%al
 273:	7e 0a                	jle    27f <atoi+0x48>
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	0f b6 00             	movzbl (%eax),%eax
 27b:	3c 39                	cmp    $0x39,%al
 27d:	7e c7                	jle    246 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 282:	c9                   	leave  
 283:	c3                   	ret    

00000284 <itoa>:

char*
itoa(int val, int base){
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 28a:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 291:	eb 29                	jmp    2bc <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	99                   	cltd   
 297:	f7 7d 0c             	idivl  0xc(%ebp)
 29a:	89 d0                	mov    %edx,%eax
 29c:	0f b6 80 73 08 00 00 	movzbl 0x873(%eax),%eax
 2a3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2a6:	81 c2 20 0b 00 00    	add    $0xb20,%edx
 2ac:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 2ae:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
 2b5:	99                   	cltd   
 2b6:	f7 7d 0c             	idivl  0xc(%ebp)
 2b9:	89 45 08             	mov    %eax,0x8(%ebp)
 2bc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2c0:	74 06                	je     2c8 <itoa+0x44>
 2c2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 2c6:	75 cb                	jne    293 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 2c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2cb:	83 c0 01             	add    $0x1,%eax
 2ce:	05 20 0b 00 00       	add    $0xb20,%eax

}
 2d3:	c9                   	leave  
 2d4:	c3                   	ret    

000002d5 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2d5:	55                   	push   %ebp
 2d6:	89 e5                	mov    %esp,%ebp
 2d8:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 2db:	8b 45 08             	mov    0x8(%ebp),%eax
 2de:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 2e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2e7:	eb 17                	jmp    300 <memmove+0x2b>
    *dst++ = *src++;
 2e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2ec:	8d 50 01             	lea    0x1(%eax),%edx
 2ef:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2f5:	8d 4a 01             	lea    0x1(%edx),%ecx
 2f8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2fb:	0f b6 12             	movzbl (%edx),%edx
 2fe:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 300:	8b 45 10             	mov    0x10(%ebp),%eax
 303:	8d 50 ff             	lea    -0x1(%eax),%edx
 306:	89 55 10             	mov    %edx,0x10(%ebp)
 309:	85 c0                	test   %eax,%eax
 30b:	7f dc                	jg     2e9 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 30d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 310:	c9                   	leave  
 311:	c3                   	ret    

00000312 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 312:	b8 01 00 00 00       	mov    $0x1,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <exit>:
SYSCALL(exit)
 31a:	b8 02 00 00 00       	mov    $0x2,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <wait>:
SYSCALL(wait)
 322:	b8 03 00 00 00       	mov    $0x3,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <pipe>:
SYSCALL(pipe)
 32a:	b8 04 00 00 00       	mov    $0x4,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <read>:
SYSCALL(read)
 332:	b8 05 00 00 00       	mov    $0x5,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <write>:
SYSCALL(write)
 33a:	b8 10 00 00 00       	mov    $0x10,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <close>:
SYSCALL(close)
 342:	b8 15 00 00 00       	mov    $0x15,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <kill>:
SYSCALL(kill)
 34a:	b8 06 00 00 00       	mov    $0x6,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <exec>:
SYSCALL(exec)
 352:	b8 07 00 00 00       	mov    $0x7,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <open>:
SYSCALL(open)
 35a:	b8 0f 00 00 00       	mov    $0xf,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <mknod>:
SYSCALL(mknod)
 362:	b8 11 00 00 00       	mov    $0x11,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <unlink>:
SYSCALL(unlink)
 36a:	b8 12 00 00 00       	mov    $0x12,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <fstat>:
SYSCALL(fstat)
 372:	b8 08 00 00 00       	mov    $0x8,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <link>:
SYSCALL(link)
 37a:	b8 13 00 00 00       	mov    $0x13,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <mkdir>:
SYSCALL(mkdir)
 382:	b8 14 00 00 00       	mov    $0x14,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <chdir>:
SYSCALL(chdir)
 38a:	b8 09 00 00 00       	mov    $0x9,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <dup>:
SYSCALL(dup)
 392:	b8 0a 00 00 00       	mov    $0xa,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <getpid>:
SYSCALL(getpid)
 39a:	b8 0b 00 00 00       	mov    $0xb,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <sbrk>:
SYSCALL(sbrk)
 3a2:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <sleep>:
SYSCALL(sleep)
 3aa:	b8 0d 00 00 00       	mov    $0xd,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <uptime>:
SYSCALL(uptime)
 3b2:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <randomX>:
SYSCALL(randomX)
 3ba:	b8 16 00 00 00       	mov    $0x16,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <setSeedX>:
SYSCALL(setSeedX)
 3c2:	b8 17 00 00 00       	mov    $0x17,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <uniformR>:
SYSCALL(uniformR)
 3ca:	b8 18 00 00 00       	mov    $0x18,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d2:	55                   	push   %ebp
 3d3:	89 e5                	mov    %esp,%ebp
 3d5:	83 ec 18             	sub    $0x18,%esp
 3d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3db:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3de:	83 ec 04             	sub    $0x4,%esp
 3e1:	6a 01                	push   $0x1
 3e3:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e6:	50                   	push   %eax
 3e7:	ff 75 08             	pushl  0x8(%ebp)
 3ea:	e8 4b ff ff ff       	call   33a <write>
 3ef:	83 c4 10             	add    $0x10,%esp
}
 3f2:	90                   	nop
 3f3:	c9                   	leave  
 3f4:	c3                   	ret    

000003f5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f5:	55                   	push   %ebp
 3f6:	89 e5                	mov    %esp,%ebp
 3f8:	53                   	push   %ebx
 3f9:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 403:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 407:	74 17                	je     420 <printint+0x2b>
 409:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40d:	79 11                	jns    420 <printint+0x2b>
    neg = 1;
 40f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 416:	8b 45 0c             	mov    0xc(%ebp),%eax
 419:	f7 d8                	neg    %eax
 41b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41e:	eb 06                	jmp    426 <printint+0x31>
  } else {
    x = xx;
 420:	8b 45 0c             	mov    0xc(%ebp),%eax
 423:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 426:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 430:	8d 41 01             	lea    0x1(%ecx),%eax
 433:	89 45 f4             	mov    %eax,-0xc(%ebp)
 436:	8b 5d 10             	mov    0x10(%ebp),%ebx
 439:	8b 45 ec             	mov    -0x14(%ebp),%eax
 43c:	ba 00 00 00 00       	mov    $0x0,%edx
 441:	f7 f3                	div    %ebx
 443:	89 d0                	mov    %edx,%eax
 445:	0f b6 80 f8 0a 00 00 	movzbl 0xaf8(%eax),%eax
 44c:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 450:	8b 5d 10             	mov    0x10(%ebp),%ebx
 453:	8b 45 ec             	mov    -0x14(%ebp),%eax
 456:	ba 00 00 00 00       	mov    $0x0,%edx
 45b:	f7 f3                	div    %ebx
 45d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 460:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 464:	75 c7                	jne    42d <printint+0x38>
  if(neg)
 466:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46a:	74 2d                	je     499 <printint+0xa4>
    buf[i++] = '-';
 46c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46f:	8d 50 01             	lea    0x1(%eax),%edx
 472:	89 55 f4             	mov    %edx,-0xc(%ebp)
 475:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47a:	eb 1d                	jmp    499 <printint+0xa4>
    putc(fd, buf[i]);
 47c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 47f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 482:	01 d0                	add    %edx,%eax
 484:	0f b6 00             	movzbl (%eax),%eax
 487:	0f be c0             	movsbl %al,%eax
 48a:	83 ec 08             	sub    $0x8,%esp
 48d:	50                   	push   %eax
 48e:	ff 75 08             	pushl  0x8(%ebp)
 491:	e8 3c ff ff ff       	call   3d2 <putc>
 496:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 499:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a1:	79 d9                	jns    47c <printint+0x87>
    putc(fd, buf[i]);
}
 4a3:	90                   	nop
 4a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4a7:	c9                   	leave  
 4a8:	c3                   	ret    

000004a9 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4a9:	55                   	push   %ebp
 4aa:	89 e5                	mov    %esp,%ebp
 4ac:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b6:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b9:	83 c0 04             	add    $0x4,%eax
 4bc:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4bf:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c6:	e9 59 01 00 00       	jmp    624 <printf+0x17b>
    c = fmt[i] & 0xff;
 4cb:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d1:	01 d0                	add    %edx,%eax
 4d3:	0f b6 00             	movzbl (%eax),%eax
 4d6:	0f be c0             	movsbl %al,%eax
 4d9:	25 ff 00 00 00       	and    $0xff,%eax
 4de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e5:	75 2c                	jne    513 <printf+0x6a>
      if(c == '%'){
 4e7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4eb:	75 0c                	jne    4f9 <printf+0x50>
        state = '%';
 4ed:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f4:	e9 27 01 00 00       	jmp    620 <printf+0x177>
      } else {
        putc(fd, c);
 4f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4fc:	0f be c0             	movsbl %al,%eax
 4ff:	83 ec 08             	sub    $0x8,%esp
 502:	50                   	push   %eax
 503:	ff 75 08             	pushl  0x8(%ebp)
 506:	e8 c7 fe ff ff       	call   3d2 <putc>
 50b:	83 c4 10             	add    $0x10,%esp
 50e:	e9 0d 01 00 00       	jmp    620 <printf+0x177>
      }
    } else if(state == '%'){
 513:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 517:	0f 85 03 01 00 00    	jne    620 <printf+0x177>
      if(c == 'd'){
 51d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 521:	75 1e                	jne    541 <printf+0x98>
        printint(fd, *ap, 10, 1);
 523:	8b 45 e8             	mov    -0x18(%ebp),%eax
 526:	8b 00                	mov    (%eax),%eax
 528:	6a 01                	push   $0x1
 52a:	6a 0a                	push   $0xa
 52c:	50                   	push   %eax
 52d:	ff 75 08             	pushl  0x8(%ebp)
 530:	e8 c0 fe ff ff       	call   3f5 <printint>
 535:	83 c4 10             	add    $0x10,%esp
        ap++;
 538:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53c:	e9 d8 00 00 00       	jmp    619 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 541:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 545:	74 06                	je     54d <printf+0xa4>
 547:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54b:	75 1e                	jne    56b <printf+0xc2>
        printint(fd, *ap, 16, 0);
 54d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 550:	8b 00                	mov    (%eax),%eax
 552:	6a 00                	push   $0x0
 554:	6a 10                	push   $0x10
 556:	50                   	push   %eax
 557:	ff 75 08             	pushl  0x8(%ebp)
 55a:	e8 96 fe ff ff       	call   3f5 <printint>
 55f:	83 c4 10             	add    $0x10,%esp
        ap++;
 562:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 566:	e9 ae 00 00 00       	jmp    619 <printf+0x170>
      } else if(c == 's'){
 56b:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 56f:	75 43                	jne    5b4 <printf+0x10b>
        s = (char*)*ap;
 571:	8b 45 e8             	mov    -0x18(%ebp),%eax
 574:	8b 00                	mov    (%eax),%eax
 576:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 579:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 581:	75 25                	jne    5a8 <printf+0xff>
          s = "(null)";
 583:	c7 45 f4 84 08 00 00 	movl   $0x884,-0xc(%ebp)
        while(*s != 0){
 58a:	eb 1c                	jmp    5a8 <printf+0xff>
          putc(fd, *s);
 58c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58f:	0f b6 00             	movzbl (%eax),%eax
 592:	0f be c0             	movsbl %al,%eax
 595:	83 ec 08             	sub    $0x8,%esp
 598:	50                   	push   %eax
 599:	ff 75 08             	pushl  0x8(%ebp)
 59c:	e8 31 fe ff ff       	call   3d2 <putc>
 5a1:	83 c4 10             	add    $0x10,%esp
          s++;
 5a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ab:	0f b6 00             	movzbl (%eax),%eax
 5ae:	84 c0                	test   %al,%al
 5b0:	75 da                	jne    58c <printf+0xe3>
 5b2:	eb 65                	jmp    619 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5b4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5b8:	75 1d                	jne    5d7 <printf+0x12e>
        putc(fd, *ap);
 5ba:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bd:	8b 00                	mov    (%eax),%eax
 5bf:	0f be c0             	movsbl %al,%eax
 5c2:	83 ec 08             	sub    $0x8,%esp
 5c5:	50                   	push   %eax
 5c6:	ff 75 08             	pushl  0x8(%ebp)
 5c9:	e8 04 fe ff ff       	call   3d2 <putc>
 5ce:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d5:	eb 42                	jmp    619 <printf+0x170>
      } else if(c == '%'){
 5d7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5db:	75 17                	jne    5f4 <printf+0x14b>
        putc(fd, c);
 5dd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e0:	0f be c0             	movsbl %al,%eax
 5e3:	83 ec 08             	sub    $0x8,%esp
 5e6:	50                   	push   %eax
 5e7:	ff 75 08             	pushl  0x8(%ebp)
 5ea:	e8 e3 fd ff ff       	call   3d2 <putc>
 5ef:	83 c4 10             	add    $0x10,%esp
 5f2:	eb 25                	jmp    619 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f4:	83 ec 08             	sub    $0x8,%esp
 5f7:	6a 25                	push   $0x25
 5f9:	ff 75 08             	pushl  0x8(%ebp)
 5fc:	e8 d1 fd ff ff       	call   3d2 <putc>
 601:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 604:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 607:	0f be c0             	movsbl %al,%eax
 60a:	83 ec 08             	sub    $0x8,%esp
 60d:	50                   	push   %eax
 60e:	ff 75 08             	pushl  0x8(%ebp)
 611:	e8 bc fd ff ff       	call   3d2 <putc>
 616:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 619:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 620:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 624:	8b 55 0c             	mov    0xc(%ebp),%edx
 627:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62a:	01 d0                	add    %edx,%eax
 62c:	0f b6 00             	movzbl (%eax),%eax
 62f:	84 c0                	test   %al,%al
 631:	0f 85 94 fe ff ff    	jne    4cb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 637:	90                   	nop
 638:	c9                   	leave  
 639:	c3                   	ret    

0000063a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 63a:	55                   	push   %ebp
 63b:	89 e5                	mov    %esp,%ebp
 63d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 640:	8b 45 08             	mov    0x8(%ebp),%eax
 643:	83 e8 08             	sub    $0x8,%eax
 646:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 649:	a1 48 0b 00 00       	mov    0xb48,%eax
 64e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 651:	eb 24                	jmp    677 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	8b 00                	mov    (%eax),%eax
 658:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 65b:	77 12                	ja     66f <free+0x35>
 65d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 660:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 663:	77 24                	ja     689 <free+0x4f>
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 66d:	77 1a                	ja     689 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	89 45 fc             	mov    %eax,-0x4(%ebp)
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	76 d4                	jbe    653 <free+0x19>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 687:	76 ca                	jbe    653 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	8b 40 04             	mov    0x4(%eax),%eax
 68f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 696:	8b 45 f8             	mov    -0x8(%ebp),%eax
 699:	01 c2                	add    %eax,%edx
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	39 c2                	cmp    %eax,%edx
 6a2:	75 24                	jne    6c8 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a7:	8b 50 04             	mov    0x4(%eax),%edx
 6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ad:	8b 00                	mov    (%eax),%eax
 6af:	8b 40 04             	mov    0x4(%eax),%eax
 6b2:	01 c2                	add    %eax,%edx
 6b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b7:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 00                	mov    (%eax),%eax
 6bf:	8b 10                	mov    (%eax),%edx
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	89 10                	mov    %edx,(%eax)
 6c6:	eb 0a                	jmp    6d2 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 10                	mov    (%eax),%edx
 6cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	8b 40 04             	mov    0x4(%eax),%eax
 6d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	01 d0                	add    %edx,%eax
 6e4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6e7:	75 20                	jne    709 <free+0xcf>
    p->s.size += bp->s.size;
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 50 04             	mov    0x4(%eax),%edx
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	8b 40 04             	mov    0x4(%eax),%eax
 6f5:	01 c2                	add    %eax,%edx
 6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	8b 10                	mov    (%eax),%edx
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	89 10                	mov    %edx,(%eax)
 707:	eb 08                	jmp    711 <free+0xd7>
  } else
    p->s.ptr = bp;
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70f:	89 10                	mov    %edx,(%eax)
  freep = p;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	a3 48 0b 00 00       	mov    %eax,0xb48
}
 719:	90                   	nop
 71a:	c9                   	leave  
 71b:	c3                   	ret    

0000071c <morecore>:

static Header*
morecore(uint nu)
{
 71c:	55                   	push   %ebp
 71d:	89 e5                	mov    %esp,%ebp
 71f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 722:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 729:	77 07                	ja     732 <morecore+0x16>
    nu = 4096;
 72b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 732:	8b 45 08             	mov    0x8(%ebp),%eax
 735:	c1 e0 03             	shl    $0x3,%eax
 738:	83 ec 0c             	sub    $0xc,%esp
 73b:	50                   	push   %eax
 73c:	e8 61 fc ff ff       	call   3a2 <sbrk>
 741:	83 c4 10             	add    $0x10,%esp
 744:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 747:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74b:	75 07                	jne    754 <morecore+0x38>
    return 0;
 74d:	b8 00 00 00 00       	mov    $0x0,%eax
 752:	eb 26                	jmp    77a <morecore+0x5e>
  hp = (Header*)p;
 754:	8b 45 f4             	mov    -0xc(%ebp),%eax
 757:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	8b 55 08             	mov    0x8(%ebp),%edx
 760:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 763:	8b 45 f0             	mov    -0x10(%ebp),%eax
 766:	83 c0 08             	add    $0x8,%eax
 769:	83 ec 0c             	sub    $0xc,%esp
 76c:	50                   	push   %eax
 76d:	e8 c8 fe ff ff       	call   63a <free>
 772:	83 c4 10             	add    $0x10,%esp
  return freep;
 775:	a1 48 0b 00 00       	mov    0xb48,%eax
}
 77a:	c9                   	leave  
 77b:	c3                   	ret    

0000077c <malloc>:

void*
malloc(uint nbytes)
{
 77c:	55                   	push   %ebp
 77d:	89 e5                	mov    %esp,%ebp
 77f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	8b 45 08             	mov    0x8(%ebp),%eax
 785:	83 c0 07             	add    $0x7,%eax
 788:	c1 e8 03             	shr    $0x3,%eax
 78b:	83 c0 01             	add    $0x1,%eax
 78e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 791:	a1 48 0b 00 00       	mov    0xb48,%eax
 796:	89 45 f0             	mov    %eax,-0x10(%ebp)
 799:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79d:	75 23                	jne    7c2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 79f:	c7 45 f0 40 0b 00 00 	movl   $0xb40,-0x10(%ebp)
 7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a9:	a3 48 0b 00 00       	mov    %eax,0xb48
 7ae:	a1 48 0b 00 00       	mov    0xb48,%eax
 7b3:	a3 40 0b 00 00       	mov    %eax,0xb40
    base.s.size = 0;
 7b8:	c7 05 44 0b 00 00 00 	movl   $0x0,0xb44
 7bf:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cd:	8b 40 04             	mov    0x4(%eax),%eax
 7d0:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d3:	72 4d                	jb     822 <malloc+0xa6>
      if(p->s.size == nunits)
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	8b 40 04             	mov    0x4(%eax),%eax
 7db:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7de:	75 0c                	jne    7ec <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 10                	mov    (%eax),%edx
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	89 10                	mov    %edx,(%eax)
 7ea:	eb 26                	jmp    812 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 40 04             	mov    0x4(%eax),%eax
 7f2:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f5:	89 c2                	mov    %eax,%edx
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	8b 40 04             	mov    0x4(%eax),%eax
 803:	c1 e0 03             	shl    $0x3,%eax
 806:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 80f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 812:	8b 45 f0             	mov    -0x10(%ebp),%eax
 815:	a3 48 0b 00 00       	mov    %eax,0xb48
      return (void*)(p + 1);
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	83 c0 08             	add    $0x8,%eax
 820:	eb 3b                	jmp    85d <malloc+0xe1>
    }
    if(p == freep)
 822:	a1 48 0b 00 00       	mov    0xb48,%eax
 827:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 82a:	75 1e                	jne    84a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 82c:	83 ec 0c             	sub    $0xc,%esp
 82f:	ff 75 ec             	pushl  -0x14(%ebp)
 832:	e8 e5 fe ff ff       	call   71c <morecore>
 837:	83 c4 10             	add    $0x10,%esp
 83a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 841:	75 07                	jne    84a <malloc+0xce>
        return 0;
 843:	b8 00 00 00 00       	mov    $0x0,%eax
 848:	eb 13                	jmp    85d <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 00                	mov    (%eax),%eax
 855:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 858:	e9 6d ff ff ff       	jmp    7ca <malloc+0x4e>
}
 85d:	c9                   	leave  
 85e:	c3                   	ret    
