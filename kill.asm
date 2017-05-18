
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
  1c:	68 67 08 00 00       	push   $0x867
  21:	6a 02                	push   $0x2
  23:	e8 89 04 00 00       	call   4b1 <printf>
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
 29c:	0f b6 80 7b 08 00 00 	movzbl 0x87b(%eax),%eax
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

000003d2 <setdeadline>:
 3d2:	b8 19 00 00 00       	mov    $0x19,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3da:	55                   	push   %ebp
 3db:	89 e5                	mov    %esp,%ebp
 3dd:	83 ec 18             	sub    $0x18,%esp
 3e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3e6:	83 ec 04             	sub    $0x4,%esp
 3e9:	6a 01                	push   $0x1
 3eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ee:	50                   	push   %eax
 3ef:	ff 75 08             	pushl  0x8(%ebp)
 3f2:	e8 43 ff ff ff       	call   33a <write>
 3f7:	83 c4 10             	add    $0x10,%esp
}
 3fa:	90                   	nop
 3fb:	c9                   	leave  
 3fc:	c3                   	ret    

000003fd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3fd:	55                   	push   %ebp
 3fe:	89 e5                	mov    %esp,%ebp
 400:	53                   	push   %ebx
 401:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 404:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 40b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 40f:	74 17                	je     428 <printint+0x2b>
 411:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 415:	79 11                	jns    428 <printint+0x2b>
    neg = 1;
 417:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 41e:	8b 45 0c             	mov    0xc(%ebp),%eax
 421:	f7 d8                	neg    %eax
 423:	89 45 ec             	mov    %eax,-0x14(%ebp)
 426:	eb 06                	jmp    42e <printint+0x31>
  } else {
    x = xx;
 428:	8b 45 0c             	mov    0xc(%ebp),%eax
 42b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 42e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 435:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 438:	8d 41 01             	lea    0x1(%ecx),%eax
 43b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 43e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 441:	8b 45 ec             	mov    -0x14(%ebp),%eax
 444:	ba 00 00 00 00       	mov    $0x0,%edx
 449:	f7 f3                	div    %ebx
 44b:	89 d0                	mov    %edx,%eax
 44d:	0f b6 80 00 0b 00 00 	movzbl 0xb00(%eax),%eax
 454:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 458:	8b 5d 10             	mov    0x10(%ebp),%ebx
 45b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45e:	ba 00 00 00 00       	mov    $0x0,%edx
 463:	f7 f3                	div    %ebx
 465:	89 45 ec             	mov    %eax,-0x14(%ebp)
 468:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 46c:	75 c7                	jne    435 <printint+0x38>
  if(neg)
 46e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 472:	74 2d                	je     4a1 <printint+0xa4>
    buf[i++] = '-';
 474:	8b 45 f4             	mov    -0xc(%ebp),%eax
 477:	8d 50 01             	lea    0x1(%eax),%edx
 47a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 47d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 482:	eb 1d                	jmp    4a1 <printint+0xa4>
    putc(fd, buf[i]);
 484:	8d 55 dc             	lea    -0x24(%ebp),%edx
 487:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48a:	01 d0                	add    %edx,%eax
 48c:	0f b6 00             	movzbl (%eax),%eax
 48f:	0f be c0             	movsbl %al,%eax
 492:	83 ec 08             	sub    $0x8,%esp
 495:	50                   	push   %eax
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 3c ff ff ff       	call   3da <putc>
 49e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4a1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a9:	79 d9                	jns    484 <printint+0x87>
    putc(fd, buf[i]);
}
 4ab:	90                   	nop
 4ac:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4af:	c9                   	leave  
 4b0:	c3                   	ret    

000004b1 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4b1:	55                   	push   %ebp
 4b2:	89 e5                	mov    %esp,%ebp
 4b4:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4be:	8d 45 0c             	lea    0xc(%ebp),%eax
 4c1:	83 c0 04             	add    $0x4,%eax
 4c4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4ce:	e9 59 01 00 00       	jmp    62c <printf+0x17b>
    c = fmt[i] & 0xff;
 4d3:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d9:	01 d0                	add    %edx,%eax
 4db:	0f b6 00             	movzbl (%eax),%eax
 4de:	0f be c0             	movsbl %al,%eax
 4e1:	25 ff 00 00 00       	and    $0xff,%eax
 4e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ed:	75 2c                	jne    51b <printf+0x6a>
      if(c == '%'){
 4ef:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4f3:	75 0c                	jne    501 <printf+0x50>
        state = '%';
 4f5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4fc:	e9 27 01 00 00       	jmp    628 <printf+0x177>
      } else {
        putc(fd, c);
 501:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 504:	0f be c0             	movsbl %al,%eax
 507:	83 ec 08             	sub    $0x8,%esp
 50a:	50                   	push   %eax
 50b:	ff 75 08             	pushl  0x8(%ebp)
 50e:	e8 c7 fe ff ff       	call   3da <putc>
 513:	83 c4 10             	add    $0x10,%esp
 516:	e9 0d 01 00 00       	jmp    628 <printf+0x177>
      }
    } else if(state == '%'){
 51b:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 51f:	0f 85 03 01 00 00    	jne    628 <printf+0x177>
      if(c == 'd'){
 525:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 529:	75 1e                	jne    549 <printf+0x98>
        printint(fd, *ap, 10, 1);
 52b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52e:	8b 00                	mov    (%eax),%eax
 530:	6a 01                	push   $0x1
 532:	6a 0a                	push   $0xa
 534:	50                   	push   %eax
 535:	ff 75 08             	pushl  0x8(%ebp)
 538:	e8 c0 fe ff ff       	call   3fd <printint>
 53d:	83 c4 10             	add    $0x10,%esp
        ap++;
 540:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 544:	e9 d8 00 00 00       	jmp    621 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 549:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 54d:	74 06                	je     555 <printf+0xa4>
 54f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 553:	75 1e                	jne    573 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 555:	8b 45 e8             	mov    -0x18(%ebp),%eax
 558:	8b 00                	mov    (%eax),%eax
 55a:	6a 00                	push   $0x0
 55c:	6a 10                	push   $0x10
 55e:	50                   	push   %eax
 55f:	ff 75 08             	pushl  0x8(%ebp)
 562:	e8 96 fe ff ff       	call   3fd <printint>
 567:	83 c4 10             	add    $0x10,%esp
        ap++;
 56a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56e:	e9 ae 00 00 00       	jmp    621 <printf+0x170>
      } else if(c == 's'){
 573:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 577:	75 43                	jne    5bc <printf+0x10b>
        s = (char*)*ap;
 579:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57c:	8b 00                	mov    (%eax),%eax
 57e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 581:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 585:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 589:	75 25                	jne    5b0 <printf+0xff>
          s = "(null)";
 58b:	c7 45 f4 8c 08 00 00 	movl   $0x88c,-0xc(%ebp)
        while(*s != 0){
 592:	eb 1c                	jmp    5b0 <printf+0xff>
          putc(fd, *s);
 594:	8b 45 f4             	mov    -0xc(%ebp),%eax
 597:	0f b6 00             	movzbl (%eax),%eax
 59a:	0f be c0             	movsbl %al,%eax
 59d:	83 ec 08             	sub    $0x8,%esp
 5a0:	50                   	push   %eax
 5a1:	ff 75 08             	pushl  0x8(%ebp)
 5a4:	e8 31 fe ff ff       	call   3da <putc>
 5a9:	83 c4 10             	add    $0x10,%esp
          s++;
 5ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b3:	0f b6 00             	movzbl (%eax),%eax
 5b6:	84 c0                	test   %al,%al
 5b8:	75 da                	jne    594 <printf+0xe3>
 5ba:	eb 65                	jmp    621 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5bc:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5c0:	75 1d                	jne    5df <printf+0x12e>
        putc(fd, *ap);
 5c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c5:	8b 00                	mov    (%eax),%eax
 5c7:	0f be c0             	movsbl %al,%eax
 5ca:	83 ec 08             	sub    $0x8,%esp
 5cd:	50                   	push   %eax
 5ce:	ff 75 08             	pushl  0x8(%ebp)
 5d1:	e8 04 fe ff ff       	call   3da <putc>
 5d6:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5dd:	eb 42                	jmp    621 <printf+0x170>
      } else if(c == '%'){
 5df:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5e3:	75 17                	jne    5fc <printf+0x14b>
        putc(fd, c);
 5e5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e8:	0f be c0             	movsbl %al,%eax
 5eb:	83 ec 08             	sub    $0x8,%esp
 5ee:	50                   	push   %eax
 5ef:	ff 75 08             	pushl  0x8(%ebp)
 5f2:	e8 e3 fd ff ff       	call   3da <putc>
 5f7:	83 c4 10             	add    $0x10,%esp
 5fa:	eb 25                	jmp    621 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5fc:	83 ec 08             	sub    $0x8,%esp
 5ff:	6a 25                	push   $0x25
 601:	ff 75 08             	pushl  0x8(%ebp)
 604:	e8 d1 fd ff ff       	call   3da <putc>
 609:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 60c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 60f:	0f be c0             	movsbl %al,%eax
 612:	83 ec 08             	sub    $0x8,%esp
 615:	50                   	push   %eax
 616:	ff 75 08             	pushl  0x8(%ebp)
 619:	e8 bc fd ff ff       	call   3da <putc>
 61e:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 621:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 628:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 62c:	8b 55 0c             	mov    0xc(%ebp),%edx
 62f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 632:	01 d0                	add    %edx,%eax
 634:	0f b6 00             	movzbl (%eax),%eax
 637:	84 c0                	test   %al,%al
 639:	0f 85 94 fe ff ff    	jne    4d3 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 63f:	90                   	nop
 640:	c9                   	leave  
 641:	c3                   	ret    

00000642 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 642:	55                   	push   %ebp
 643:	89 e5                	mov    %esp,%ebp
 645:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	83 e8 08             	sub    $0x8,%eax
 64e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 651:	a1 48 0b 00 00       	mov    0xb48,%eax
 656:	89 45 fc             	mov    %eax,-0x4(%ebp)
 659:	eb 24                	jmp    67f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	8b 00                	mov    (%eax),%eax
 660:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 663:	77 12                	ja     677 <free+0x35>
 665:	8b 45 f8             	mov    -0x8(%ebp),%eax
 668:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66b:	77 24                	ja     691 <free+0x4f>
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 675:	77 1a                	ja     691 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 682:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 685:	76 d4                	jbe    65b <free+0x19>
 687:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68a:	8b 00                	mov    (%eax),%eax
 68c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68f:	76 ca                	jbe    65b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	8b 40 04             	mov    0x4(%eax),%eax
 697:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a1:	01 c2                	add    %eax,%edx
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	8b 00                	mov    (%eax),%eax
 6a8:	39 c2                	cmp    %eax,%edx
 6aa:	75 24                	jne    6d0 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6af:	8b 50 04             	mov    0x4(%eax),%edx
 6b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b5:	8b 00                	mov    (%eax),%eax
 6b7:	8b 40 04             	mov    0x4(%eax),%eax
 6ba:	01 c2                	add    %eax,%edx
 6bc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bf:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	8b 00                	mov    (%eax),%eax
 6c7:	8b 10                	mov    (%eax),%edx
 6c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cc:	89 10                	mov    %edx,(%eax)
 6ce:	eb 0a                	jmp    6da <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d3:	8b 10                	mov    (%eax),%edx
 6d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d8:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	8b 40 04             	mov    0x4(%eax),%eax
 6e0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ea:	01 d0                	add    %edx,%eax
 6ec:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6ef:	75 20                	jne    711 <free+0xcf>
    p->s.size += bp->s.size;
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	8b 50 04             	mov    0x4(%eax),%edx
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	8b 40 04             	mov    0x4(%eax),%eax
 6fd:	01 c2                	add    %eax,%edx
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 705:	8b 45 f8             	mov    -0x8(%ebp),%eax
 708:	8b 10                	mov    (%eax),%edx
 70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70d:	89 10                	mov    %edx,(%eax)
 70f:	eb 08                	jmp    719 <free+0xd7>
  } else
    p->s.ptr = bp;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	8b 55 f8             	mov    -0x8(%ebp),%edx
 717:	89 10                	mov    %edx,(%eax)
  freep = p;
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	a3 48 0b 00 00       	mov    %eax,0xb48
}
 721:	90                   	nop
 722:	c9                   	leave  
 723:	c3                   	ret    

00000724 <morecore>:

static Header*
morecore(uint nu)
{
 724:	55                   	push   %ebp
 725:	89 e5                	mov    %esp,%ebp
 727:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 72a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 731:	77 07                	ja     73a <morecore+0x16>
    nu = 4096;
 733:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 73a:	8b 45 08             	mov    0x8(%ebp),%eax
 73d:	c1 e0 03             	shl    $0x3,%eax
 740:	83 ec 0c             	sub    $0xc,%esp
 743:	50                   	push   %eax
 744:	e8 59 fc ff ff       	call   3a2 <sbrk>
 749:	83 c4 10             	add    $0x10,%esp
 74c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 74f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 753:	75 07                	jne    75c <morecore+0x38>
    return 0;
 755:	b8 00 00 00 00       	mov    $0x0,%eax
 75a:	eb 26                	jmp    782 <morecore+0x5e>
  hp = (Header*)p;
 75c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 762:	8b 45 f0             	mov    -0x10(%ebp),%eax
 765:	8b 55 08             	mov    0x8(%ebp),%edx
 768:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 76b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76e:	83 c0 08             	add    $0x8,%eax
 771:	83 ec 0c             	sub    $0xc,%esp
 774:	50                   	push   %eax
 775:	e8 c8 fe ff ff       	call   642 <free>
 77a:	83 c4 10             	add    $0x10,%esp
  return freep;
 77d:	a1 48 0b 00 00       	mov    0xb48,%eax
}
 782:	c9                   	leave  
 783:	c3                   	ret    

00000784 <malloc>:

void*
malloc(uint nbytes)
{
 784:	55                   	push   %ebp
 785:	89 e5                	mov    %esp,%ebp
 787:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78a:	8b 45 08             	mov    0x8(%ebp),%eax
 78d:	83 c0 07             	add    $0x7,%eax
 790:	c1 e8 03             	shr    $0x3,%eax
 793:	83 c0 01             	add    $0x1,%eax
 796:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 799:	a1 48 0b 00 00       	mov    0xb48,%eax
 79e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a5:	75 23                	jne    7ca <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7a7:	c7 45 f0 40 0b 00 00 	movl   $0xb40,-0x10(%ebp)
 7ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b1:	a3 48 0b 00 00       	mov    %eax,0xb48
 7b6:	a1 48 0b 00 00       	mov    0xb48,%eax
 7bb:	a3 40 0b 00 00       	mov    %eax,0xb40
    base.s.size = 0;
 7c0:	c7 05 44 0b 00 00 00 	movl   $0x0,0xb44
 7c7:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cd:	8b 00                	mov    (%eax),%eax
 7cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d5:	8b 40 04             	mov    0x4(%eax),%eax
 7d8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7db:	72 4d                	jb     82a <malloc+0xa6>
      if(p->s.size == nunits)
 7dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e0:	8b 40 04             	mov    0x4(%eax),%eax
 7e3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e6:	75 0c                	jne    7f4 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	8b 10                	mov    (%eax),%edx
 7ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f0:	89 10                	mov    %edx,(%eax)
 7f2:	eb 26                	jmp    81a <malloc+0x96>
      else {
        p->s.size -= nunits;
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7fd:	89 c2                	mov    %eax,%edx
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 805:	8b 45 f4             	mov    -0xc(%ebp),%eax
 808:	8b 40 04             	mov    0x4(%eax),%eax
 80b:	c1 e0 03             	shl    $0x3,%eax
 80e:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	8b 55 ec             	mov    -0x14(%ebp),%edx
 817:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 81a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81d:	a3 48 0b 00 00       	mov    %eax,0xb48
      return (void*)(p + 1);
 822:	8b 45 f4             	mov    -0xc(%ebp),%eax
 825:	83 c0 08             	add    $0x8,%eax
 828:	eb 3b                	jmp    865 <malloc+0xe1>
    }
    if(p == freep)
 82a:	a1 48 0b 00 00       	mov    0xb48,%eax
 82f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 832:	75 1e                	jne    852 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 834:	83 ec 0c             	sub    $0xc,%esp
 837:	ff 75 ec             	pushl  -0x14(%ebp)
 83a:	e8 e5 fe ff ff       	call   724 <morecore>
 83f:	83 c4 10             	add    $0x10,%esp
 842:	89 45 f4             	mov    %eax,-0xc(%ebp)
 845:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 849:	75 07                	jne    852 <malloc+0xce>
        return 0;
 84b:	b8 00 00 00 00       	mov    $0x0,%eax
 850:	eb 13                	jmp    865 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 852:	8b 45 f4             	mov    -0xc(%ebp),%eax
 855:	89 45 f0             	mov    %eax,-0x10(%ebp)
 858:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85b:	8b 00                	mov    (%eax),%eax
 85d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 860:	e9 6d ff ff ff       	jmp    7d2 <malloc+0x4e>
}
 865:	c9                   	leave  
 866:	c3                   	ret    
