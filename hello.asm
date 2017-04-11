
_hello:     file format elf32-i386


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

    int i;
  if(argc < 1){
  14:	83 3b 00             	cmpl   $0x0,(%ebx)
  17:	7f 05                	jg     1e <main+0x1e>
    exit();
  19:	e8 aa 02 00 00       	call   2c8 <exit>
  }
  printf(1, "Hello ");
  1e:	83 ec 08             	sub    $0x8,%esp
  21:	68 f5 07 00 00       	push   $0x7f5
  26:	6a 01                	push   $0x1
  28:	e8 12 04 00 00       	call   43f <printf>
  2d:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i<argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 1a                	jmp    53 <main+0x53>
    printf(1, argv[1]);
  39:	8b 43 04             	mov    0x4(%ebx),%eax
  3c:	83 c0 04             	add    $0x4,%eax
  3f:	8b 00                	mov    (%eax),%eax
  41:	83 ec 08             	sub    $0x8,%esp
  44:	50                   	push   %eax
  45:	6a 01                	push   $0x1
  47:	e8 f3 03 00 00       	call   43f <printf>
  4c:	83 c4 10             	add    $0x10,%esp
    int i;
  if(argc < 1){
    exit();
  }
  printf(1, "Hello ");
  for(i = 1; i<argc; i++){
  4f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  53:	8b 45 f4             	mov    -0xc(%ebp),%eax
  56:	3b 03                	cmp    (%ebx),%eax
  58:	7c df                	jl     39 <main+0x39>
    printf(1, argv[1]);
  }
  printf(1, "\n");
  5a:	83 ec 08             	sub    $0x8,%esp
  5d:	68 fc 07 00 00       	push   $0x7fc
  62:	6a 01                	push   $0x1
  64:	e8 d6 03 00 00       	call   43f <printf>
  69:	83 c4 10             	add    $0x10,%esp
  exit();
  6c:	e8 57 02 00 00       	call   2c8 <exit>

00000071 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  71:	55                   	push   %ebp
  72:	89 e5                	mov    %esp,%ebp
  74:	57                   	push   %edi
  75:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  76:	8b 4d 08             	mov    0x8(%ebp),%ecx
  79:	8b 55 10             	mov    0x10(%ebp),%edx
  7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  7f:	89 cb                	mov    %ecx,%ebx
  81:	89 df                	mov    %ebx,%edi
  83:	89 d1                	mov    %edx,%ecx
  85:	fc                   	cld    
  86:	f3 aa                	rep stos %al,%es:(%edi)
  88:	89 ca                	mov    %ecx,%edx
  8a:	89 fb                	mov    %edi,%ebx
  8c:	89 5d 08             	mov    %ebx,0x8(%ebp)
  8f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  92:	90                   	nop
  93:	5b                   	pop    %ebx
  94:	5f                   	pop    %edi
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    

00000097 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  97:	55                   	push   %ebp
  98:	89 e5                	mov    %esp,%ebp
  9a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9d:	8b 45 08             	mov    0x8(%ebp),%eax
  a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a3:	90                   	nop
  a4:	8b 45 08             	mov    0x8(%ebp),%eax
  a7:	8d 50 01             	lea    0x1(%eax),%edx
  aa:	89 55 08             	mov    %edx,0x8(%ebp)
  ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  b0:	8d 4a 01             	lea    0x1(%edx),%ecx
  b3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  b6:	0f b6 12             	movzbl (%edx),%edx
  b9:	88 10                	mov    %dl,(%eax)
  bb:	0f b6 00             	movzbl (%eax),%eax
  be:	84 c0                	test   %al,%al
  c0:	75 e2                	jne    a4 <strcpy+0xd>
    ;
  return os;
  c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c5:	c9                   	leave  
  c6:	c3                   	ret    

000000c7 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c7:	55                   	push   %ebp
  c8:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  ca:	eb 08                	jmp    d4 <strcmp+0xd>
    p++, q++;
  cc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  d4:	8b 45 08             	mov    0x8(%ebp),%eax
  d7:	0f b6 00             	movzbl (%eax),%eax
  da:	84 c0                	test   %al,%al
  dc:	74 10                	je     ee <strcmp+0x27>
  de:	8b 45 08             	mov    0x8(%ebp),%eax
  e1:	0f b6 10             	movzbl (%eax),%edx
  e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  e7:	0f b6 00             	movzbl (%eax),%eax
  ea:	38 c2                	cmp    %al,%dl
  ec:	74 de                	je     cc <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  ee:	8b 45 08             	mov    0x8(%ebp),%eax
  f1:	0f b6 00             	movzbl (%eax),%eax
  f4:	0f b6 d0             	movzbl %al,%edx
  f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  fa:	0f b6 00             	movzbl (%eax),%eax
  fd:	0f b6 c0             	movzbl %al,%eax
 100:	29 c2                	sub    %eax,%edx
 102:	89 d0                	mov    %edx,%eax
}
 104:	5d                   	pop    %ebp
 105:	c3                   	ret    

00000106 <strlen>:

uint
strlen(char *s)
{
 106:	55                   	push   %ebp
 107:	89 e5                	mov    %esp,%ebp
 109:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 113:	eb 04                	jmp    119 <strlen+0x13>
 115:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 119:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11c:	8b 45 08             	mov    0x8(%ebp),%eax
 11f:	01 d0                	add    %edx,%eax
 121:	0f b6 00             	movzbl (%eax),%eax
 124:	84 c0                	test   %al,%al
 126:	75 ed                	jne    115 <strlen+0xf>
    ;
  return n;
 128:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12b:	c9                   	leave  
 12c:	c3                   	ret    

0000012d <memset>:

void*
memset(void *dst, int c, uint n)
{
 12d:	55                   	push   %ebp
 12e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 130:	8b 45 10             	mov    0x10(%ebp),%eax
 133:	50                   	push   %eax
 134:	ff 75 0c             	pushl  0xc(%ebp)
 137:	ff 75 08             	pushl  0x8(%ebp)
 13a:	e8 32 ff ff ff       	call   71 <stosb>
 13f:	83 c4 0c             	add    $0xc,%esp
  return dst;
 142:	8b 45 08             	mov    0x8(%ebp),%eax
}
 145:	c9                   	leave  
 146:	c3                   	ret    

00000147 <strchr>:

char*
strchr(const char *s, char c)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	83 ec 04             	sub    $0x4,%esp
 14d:	8b 45 0c             	mov    0xc(%ebp),%eax
 150:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 153:	eb 14                	jmp    169 <strchr+0x22>
    if(*s == c)
 155:	8b 45 08             	mov    0x8(%ebp),%eax
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15e:	75 05                	jne    165 <strchr+0x1e>
      return (char*)s;
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	eb 13                	jmp    178 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 165:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	0f b6 00             	movzbl (%eax),%eax
 16f:	84 c0                	test   %al,%al
 171:	75 e2                	jne    155 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 173:	b8 00 00 00 00       	mov    $0x0,%eax
}
 178:	c9                   	leave  
 179:	c3                   	ret    

0000017a <gets>:

char*
gets(char *buf, int max)
{
 17a:	55                   	push   %ebp
 17b:	89 e5                	mov    %esp,%ebp
 17d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 180:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 187:	eb 42                	jmp    1cb <gets+0x51>
    cc = read(0, &c, 1);
 189:	83 ec 04             	sub    $0x4,%esp
 18c:	6a 01                	push   $0x1
 18e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 191:	50                   	push   %eax
 192:	6a 00                	push   $0x0
 194:	e8 47 01 00 00       	call   2e0 <read>
 199:	83 c4 10             	add    $0x10,%esp
 19c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 19f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a3:	7e 33                	jle    1d8 <gets+0x5e>
      break;
    buf[i++] = c;
 1a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a8:	8d 50 01             	lea    0x1(%eax),%edx
 1ab:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1ae:	89 c2                	mov    %eax,%edx
 1b0:	8b 45 08             	mov    0x8(%ebp),%eax
 1b3:	01 c2                	add    %eax,%edx
 1b5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1bb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bf:	3c 0a                	cmp    $0xa,%al
 1c1:	74 16                	je     1d9 <gets+0x5f>
 1c3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c7:	3c 0d                	cmp    $0xd,%al
 1c9:	74 0e                	je     1d9 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ce:	83 c0 01             	add    $0x1,%eax
 1d1:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1d4:	7c b3                	jl     189 <gets+0xf>
 1d6:	eb 01                	jmp    1d9 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1d8:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1dc:	8b 45 08             	mov    0x8(%ebp),%eax
 1df:	01 d0                	add    %edx,%eax
 1e1:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <stat>:

int
stat(char *n, struct stat *st)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1ef:	83 ec 08             	sub    $0x8,%esp
 1f2:	6a 00                	push   $0x0
 1f4:	ff 75 08             	pushl  0x8(%ebp)
 1f7:	e8 0c 01 00 00       	call   308 <open>
 1fc:	83 c4 10             	add    $0x10,%esp
 1ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 202:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 206:	79 07                	jns    20f <stat+0x26>
    return -1;
 208:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 20d:	eb 25                	jmp    234 <stat+0x4b>
  r = fstat(fd, st);
 20f:	83 ec 08             	sub    $0x8,%esp
 212:	ff 75 0c             	pushl  0xc(%ebp)
 215:	ff 75 f4             	pushl  -0xc(%ebp)
 218:	e8 03 01 00 00       	call   320 <fstat>
 21d:	83 c4 10             	add    $0x10,%esp
 220:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 223:	83 ec 0c             	sub    $0xc,%esp
 226:	ff 75 f4             	pushl  -0xc(%ebp)
 229:	e8 c2 00 00 00       	call   2f0 <close>
 22e:	83 c4 10             	add    $0x10,%esp
  return r;
 231:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 234:	c9                   	leave  
 235:	c3                   	ret    

00000236 <atoi>:

int
atoi(const char *s)
{
 236:	55                   	push   %ebp
 237:	89 e5                	mov    %esp,%ebp
 239:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 243:	eb 25                	jmp    26a <atoi+0x34>
    n = n*10 + *s++ - '0';
 245:	8b 55 fc             	mov    -0x4(%ebp),%edx
 248:	89 d0                	mov    %edx,%eax
 24a:	c1 e0 02             	shl    $0x2,%eax
 24d:	01 d0                	add    %edx,%eax
 24f:	01 c0                	add    %eax,%eax
 251:	89 c1                	mov    %eax,%ecx
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	8d 50 01             	lea    0x1(%eax),%edx
 259:	89 55 08             	mov    %edx,0x8(%ebp)
 25c:	0f b6 00             	movzbl (%eax),%eax
 25f:	0f be c0             	movsbl %al,%eax
 262:	01 c8                	add    %ecx,%eax
 264:	83 e8 30             	sub    $0x30,%eax
 267:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	0f b6 00             	movzbl (%eax),%eax
 270:	3c 2f                	cmp    $0x2f,%al
 272:	7e 0a                	jle    27e <atoi+0x48>
 274:	8b 45 08             	mov    0x8(%ebp),%eax
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	3c 39                	cmp    $0x39,%al
 27c:	7e c7                	jle    245 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 27e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 281:	c9                   	leave  
 282:	c3                   	ret    

00000283 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 283:	55                   	push   %ebp
 284:	89 e5                	mov    %esp,%ebp
 286:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 28f:	8b 45 0c             	mov    0xc(%ebp),%eax
 292:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 295:	eb 17                	jmp    2ae <memmove+0x2b>
    *dst++ = *src++;
 297:	8b 45 fc             	mov    -0x4(%ebp),%eax
 29a:	8d 50 01             	lea    0x1(%eax),%edx
 29d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a0:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2a3:	8d 4a 01             	lea    0x1(%edx),%ecx
 2a6:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2a9:	0f b6 12             	movzbl (%edx),%edx
 2ac:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2ae:	8b 45 10             	mov    0x10(%ebp),%eax
 2b1:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b4:	89 55 10             	mov    %edx,0x10(%ebp)
 2b7:	85 c0                	test   %eax,%eax
 2b9:	7f dc                	jg     297 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2be:	c9                   	leave  
 2bf:	c3                   	ret    

000002c0 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c0:	b8 01 00 00 00       	mov    $0x1,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <exit>:
SYSCALL(exit)
 2c8:	b8 02 00 00 00       	mov    $0x2,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <wait>:
SYSCALL(wait)
 2d0:	b8 03 00 00 00       	mov    $0x3,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <pipe>:
SYSCALL(pipe)
 2d8:	b8 04 00 00 00       	mov    $0x4,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <read>:
SYSCALL(read)
 2e0:	b8 05 00 00 00       	mov    $0x5,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <write>:
SYSCALL(write)
 2e8:	b8 10 00 00 00       	mov    $0x10,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <close>:
SYSCALL(close)
 2f0:	b8 15 00 00 00       	mov    $0x15,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <kill>:
SYSCALL(kill)
 2f8:	b8 06 00 00 00       	mov    $0x6,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <exec>:
SYSCALL(exec)
 300:	b8 07 00 00 00       	mov    $0x7,%eax
 305:	cd 40                	int    $0x40
 307:	c3                   	ret    

00000308 <open>:
SYSCALL(open)
 308:	b8 0f 00 00 00       	mov    $0xf,%eax
 30d:	cd 40                	int    $0x40
 30f:	c3                   	ret    

00000310 <mknod>:
SYSCALL(mknod)
 310:	b8 11 00 00 00       	mov    $0x11,%eax
 315:	cd 40                	int    $0x40
 317:	c3                   	ret    

00000318 <unlink>:
SYSCALL(unlink)
 318:	b8 12 00 00 00       	mov    $0x12,%eax
 31d:	cd 40                	int    $0x40
 31f:	c3                   	ret    

00000320 <fstat>:
SYSCALL(fstat)
 320:	b8 08 00 00 00       	mov    $0x8,%eax
 325:	cd 40                	int    $0x40
 327:	c3                   	ret    

00000328 <link>:
SYSCALL(link)
 328:	b8 13 00 00 00       	mov    $0x13,%eax
 32d:	cd 40                	int    $0x40
 32f:	c3                   	ret    

00000330 <mkdir>:
SYSCALL(mkdir)
 330:	b8 14 00 00 00       	mov    $0x14,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <chdir>:
SYSCALL(chdir)
 338:	b8 09 00 00 00       	mov    $0x9,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <dup>:
SYSCALL(dup)
 340:	b8 0a 00 00 00       	mov    $0xa,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <getpid>:
SYSCALL(getpid)
 348:	b8 0b 00 00 00       	mov    $0xb,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <sbrk>:
SYSCALL(sbrk)
 350:	b8 0c 00 00 00       	mov    $0xc,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <sleep>:
SYSCALL(sleep)
 358:	b8 0d 00 00 00       	mov    $0xd,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <uptime>:
SYSCALL(uptime)
 360:	b8 0e 00 00 00       	mov    $0xe,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	83 ec 18             	sub    $0x18,%esp
 36e:	8b 45 0c             	mov    0xc(%ebp),%eax
 371:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 374:	83 ec 04             	sub    $0x4,%esp
 377:	6a 01                	push   $0x1
 379:	8d 45 f4             	lea    -0xc(%ebp),%eax
 37c:	50                   	push   %eax
 37d:	ff 75 08             	pushl  0x8(%ebp)
 380:	e8 63 ff ff ff       	call   2e8 <write>
 385:	83 c4 10             	add    $0x10,%esp
}
 388:	90                   	nop
 389:	c9                   	leave  
 38a:	c3                   	ret    

0000038b <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 38b:	55                   	push   %ebp
 38c:	89 e5                	mov    %esp,%ebp
 38e:	53                   	push   %ebx
 38f:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 392:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 399:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 39d:	74 17                	je     3b6 <printint+0x2b>
 39f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3a3:	79 11                	jns    3b6 <printint+0x2b>
    neg = 1;
 3a5:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3ac:	8b 45 0c             	mov    0xc(%ebp),%eax
 3af:	f7 d8                	neg    %eax
 3b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3b4:	eb 06                	jmp    3bc <printint+0x31>
  } else {
    x = xx;
 3b6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3bc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3c3:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3c6:	8d 41 01             	lea    0x1(%ecx),%eax
 3c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3cc:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d2:	ba 00 00 00 00       	mov    $0x0,%edx
 3d7:	f7 f3                	div    %ebx
 3d9:	89 d0                	mov    %edx,%eax
 3db:	0f b6 80 54 0a 00 00 	movzbl 0xa54(%eax),%eax
 3e2:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3e6:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3e9:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ec:	ba 00 00 00 00       	mov    $0x0,%edx
 3f1:	f7 f3                	div    %ebx
 3f3:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 3fa:	75 c7                	jne    3c3 <printint+0x38>
  if(neg)
 3fc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 400:	74 2d                	je     42f <printint+0xa4>
    buf[i++] = '-';
 402:	8b 45 f4             	mov    -0xc(%ebp),%eax
 405:	8d 50 01             	lea    0x1(%eax),%edx
 408:	89 55 f4             	mov    %edx,-0xc(%ebp)
 40b:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 410:	eb 1d                	jmp    42f <printint+0xa4>
    putc(fd, buf[i]);
 412:	8d 55 dc             	lea    -0x24(%ebp),%edx
 415:	8b 45 f4             	mov    -0xc(%ebp),%eax
 418:	01 d0                	add    %edx,%eax
 41a:	0f b6 00             	movzbl (%eax),%eax
 41d:	0f be c0             	movsbl %al,%eax
 420:	83 ec 08             	sub    $0x8,%esp
 423:	50                   	push   %eax
 424:	ff 75 08             	pushl  0x8(%ebp)
 427:	e8 3c ff ff ff       	call   368 <putc>
 42c:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 42f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 433:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 437:	79 d9                	jns    412 <printint+0x87>
    putc(fd, buf[i]);
}
 439:	90                   	nop
 43a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 43d:	c9                   	leave  
 43e:	c3                   	ret    

0000043f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 43f:	55                   	push   %ebp
 440:	89 e5                	mov    %esp,%ebp
 442:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 445:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 44c:	8d 45 0c             	lea    0xc(%ebp),%eax
 44f:	83 c0 04             	add    $0x4,%eax
 452:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 455:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 45c:	e9 59 01 00 00       	jmp    5ba <printf+0x17b>
    c = fmt[i] & 0xff;
 461:	8b 55 0c             	mov    0xc(%ebp),%edx
 464:	8b 45 f0             	mov    -0x10(%ebp),%eax
 467:	01 d0                	add    %edx,%eax
 469:	0f b6 00             	movzbl (%eax),%eax
 46c:	0f be c0             	movsbl %al,%eax
 46f:	25 ff 00 00 00       	and    $0xff,%eax
 474:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 477:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47b:	75 2c                	jne    4a9 <printf+0x6a>
      if(c == '%'){
 47d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 481:	75 0c                	jne    48f <printf+0x50>
        state = '%';
 483:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 48a:	e9 27 01 00 00       	jmp    5b6 <printf+0x177>
      } else {
        putc(fd, c);
 48f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 492:	0f be c0             	movsbl %al,%eax
 495:	83 ec 08             	sub    $0x8,%esp
 498:	50                   	push   %eax
 499:	ff 75 08             	pushl  0x8(%ebp)
 49c:	e8 c7 fe ff ff       	call   368 <putc>
 4a1:	83 c4 10             	add    $0x10,%esp
 4a4:	e9 0d 01 00 00       	jmp    5b6 <printf+0x177>
      }
    } else if(state == '%'){
 4a9:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4ad:	0f 85 03 01 00 00    	jne    5b6 <printf+0x177>
      if(c == 'd'){
 4b3:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4b7:	75 1e                	jne    4d7 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4bc:	8b 00                	mov    (%eax),%eax
 4be:	6a 01                	push   $0x1
 4c0:	6a 0a                	push   $0xa
 4c2:	50                   	push   %eax
 4c3:	ff 75 08             	pushl  0x8(%ebp)
 4c6:	e8 c0 fe ff ff       	call   38b <printint>
 4cb:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ce:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d2:	e9 d8 00 00 00       	jmp    5af <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4d7:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4db:	74 06                	je     4e3 <printf+0xa4>
 4dd:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e1:	75 1e                	jne    501 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e6:	8b 00                	mov    (%eax),%eax
 4e8:	6a 00                	push   $0x0
 4ea:	6a 10                	push   $0x10
 4ec:	50                   	push   %eax
 4ed:	ff 75 08             	pushl  0x8(%ebp)
 4f0:	e8 96 fe ff ff       	call   38b <printint>
 4f5:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fc:	e9 ae 00 00 00       	jmp    5af <printf+0x170>
      } else if(c == 's'){
 501:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 505:	75 43                	jne    54a <printf+0x10b>
        s = (char*)*ap;
 507:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50a:	8b 00                	mov    (%eax),%eax
 50c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 50f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 513:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 517:	75 25                	jne    53e <printf+0xff>
          s = "(null)";
 519:	c7 45 f4 fe 07 00 00 	movl   $0x7fe,-0xc(%ebp)
        while(*s != 0){
 520:	eb 1c                	jmp    53e <printf+0xff>
          putc(fd, *s);
 522:	8b 45 f4             	mov    -0xc(%ebp),%eax
 525:	0f b6 00             	movzbl (%eax),%eax
 528:	0f be c0             	movsbl %al,%eax
 52b:	83 ec 08             	sub    $0x8,%esp
 52e:	50                   	push   %eax
 52f:	ff 75 08             	pushl  0x8(%ebp)
 532:	e8 31 fe ff ff       	call   368 <putc>
 537:	83 c4 10             	add    $0x10,%esp
          s++;
 53a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 53e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 541:	0f b6 00             	movzbl (%eax),%eax
 544:	84 c0                	test   %al,%al
 546:	75 da                	jne    522 <printf+0xe3>
 548:	eb 65                	jmp    5af <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 54a:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 54e:	75 1d                	jne    56d <printf+0x12e>
        putc(fd, *ap);
 550:	8b 45 e8             	mov    -0x18(%ebp),%eax
 553:	8b 00                	mov    (%eax),%eax
 555:	0f be c0             	movsbl %al,%eax
 558:	83 ec 08             	sub    $0x8,%esp
 55b:	50                   	push   %eax
 55c:	ff 75 08             	pushl  0x8(%ebp)
 55f:	e8 04 fe ff ff       	call   368 <putc>
 564:	83 c4 10             	add    $0x10,%esp
        ap++;
 567:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 56b:	eb 42                	jmp    5af <printf+0x170>
      } else if(c == '%'){
 56d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 571:	75 17                	jne    58a <printf+0x14b>
        putc(fd, c);
 573:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 576:	0f be c0             	movsbl %al,%eax
 579:	83 ec 08             	sub    $0x8,%esp
 57c:	50                   	push   %eax
 57d:	ff 75 08             	pushl  0x8(%ebp)
 580:	e8 e3 fd ff ff       	call   368 <putc>
 585:	83 c4 10             	add    $0x10,%esp
 588:	eb 25                	jmp    5af <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 58a:	83 ec 08             	sub    $0x8,%esp
 58d:	6a 25                	push   $0x25
 58f:	ff 75 08             	pushl  0x8(%ebp)
 592:	e8 d1 fd ff ff       	call   368 <putc>
 597:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 59a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59d:	0f be c0             	movsbl %al,%eax
 5a0:	83 ec 08             	sub    $0x8,%esp
 5a3:	50                   	push   %eax
 5a4:	ff 75 08             	pushl  0x8(%ebp)
 5a7:	e8 bc fd ff ff       	call   368 <putc>
 5ac:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5af:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b6:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5ba:	8b 55 0c             	mov    0xc(%ebp),%edx
 5bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c0:	01 d0                	add    %edx,%eax
 5c2:	0f b6 00             	movzbl (%eax),%eax
 5c5:	84 c0                	test   %al,%al
 5c7:	0f 85 94 fe ff ff    	jne    461 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5cd:	90                   	nop
 5ce:	c9                   	leave  
 5cf:	c3                   	ret    

000005d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d6:	8b 45 08             	mov    0x8(%ebp),%eax
 5d9:	83 e8 08             	sub    $0x8,%eax
 5dc:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5df:	a1 70 0a 00 00       	mov    0xa70,%eax
 5e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5e7:	eb 24                	jmp    60d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5ec:	8b 00                	mov    (%eax),%eax
 5ee:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f1:	77 12                	ja     605 <free+0x35>
 5f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5f6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f9:	77 24                	ja     61f <free+0x4f>
 5fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fe:	8b 00                	mov    (%eax),%eax
 600:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 603:	77 1a                	ja     61f <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 605:	8b 45 fc             	mov    -0x4(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 610:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 613:	76 d4                	jbe    5e9 <free+0x19>
 615:	8b 45 fc             	mov    -0x4(%ebp),%eax
 618:	8b 00                	mov    (%eax),%eax
 61a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 61d:	76 ca                	jbe    5e9 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 61f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 622:	8b 40 04             	mov    0x4(%eax),%eax
 625:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 62c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62f:	01 c2                	add    %eax,%edx
 631:	8b 45 fc             	mov    -0x4(%ebp),%eax
 634:	8b 00                	mov    (%eax),%eax
 636:	39 c2                	cmp    %eax,%edx
 638:	75 24                	jne    65e <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 63a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63d:	8b 50 04             	mov    0x4(%eax),%edx
 640:	8b 45 fc             	mov    -0x4(%ebp),%eax
 643:	8b 00                	mov    (%eax),%eax
 645:	8b 40 04             	mov    0x4(%eax),%eax
 648:	01 c2                	add    %eax,%edx
 64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64d:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 650:	8b 45 fc             	mov    -0x4(%ebp),%eax
 653:	8b 00                	mov    (%eax),%eax
 655:	8b 10                	mov    (%eax),%edx
 657:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65a:	89 10                	mov    %edx,(%eax)
 65c:	eb 0a                	jmp    668 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 65e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 661:	8b 10                	mov    (%eax),%edx
 663:	8b 45 f8             	mov    -0x8(%ebp),%eax
 666:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 40 04             	mov    0x4(%eax),%eax
 66e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 675:	8b 45 fc             	mov    -0x4(%ebp),%eax
 678:	01 d0                	add    %edx,%eax
 67a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67d:	75 20                	jne    69f <free+0xcf>
    p->s.size += bp->s.size;
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 50 04             	mov    0x4(%eax),%edx
 685:	8b 45 f8             	mov    -0x8(%ebp),%eax
 688:	8b 40 04             	mov    0x4(%eax),%eax
 68b:	01 c2                	add    %eax,%edx
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 693:	8b 45 f8             	mov    -0x8(%ebp),%eax
 696:	8b 10                	mov    (%eax),%edx
 698:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69b:	89 10                	mov    %edx,(%eax)
 69d:	eb 08                	jmp    6a7 <free+0xd7>
  } else
    p->s.ptr = bp;
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6a5:	89 10                	mov    %edx,(%eax)
  freep = p;
 6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6aa:	a3 70 0a 00 00       	mov    %eax,0xa70
}
 6af:	90                   	nop
 6b0:	c9                   	leave  
 6b1:	c3                   	ret    

000006b2 <morecore>:

static Header*
morecore(uint nu)
{
 6b2:	55                   	push   %ebp
 6b3:	89 e5                	mov    %esp,%ebp
 6b5:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6b8:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6bf:	77 07                	ja     6c8 <morecore+0x16>
    nu = 4096;
 6c1:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6c8:	8b 45 08             	mov    0x8(%ebp),%eax
 6cb:	c1 e0 03             	shl    $0x3,%eax
 6ce:	83 ec 0c             	sub    $0xc,%esp
 6d1:	50                   	push   %eax
 6d2:	e8 79 fc ff ff       	call   350 <sbrk>
 6d7:	83 c4 10             	add    $0x10,%esp
 6da:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6dd:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6e1:	75 07                	jne    6ea <morecore+0x38>
    return 0;
 6e3:	b8 00 00 00 00       	mov    $0x0,%eax
 6e8:	eb 26                	jmp    710 <morecore+0x5e>
  hp = (Header*)p;
 6ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f3:	8b 55 08             	mov    0x8(%ebp),%edx
 6f6:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 6f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fc:	83 c0 08             	add    $0x8,%eax
 6ff:	83 ec 0c             	sub    $0xc,%esp
 702:	50                   	push   %eax
 703:	e8 c8 fe ff ff       	call   5d0 <free>
 708:	83 c4 10             	add    $0x10,%esp
  return freep;
 70b:	a1 70 0a 00 00       	mov    0xa70,%eax
}
 710:	c9                   	leave  
 711:	c3                   	ret    

00000712 <malloc>:

void*
malloc(uint nbytes)
{
 712:	55                   	push   %ebp
 713:	89 e5                	mov    %esp,%ebp
 715:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 718:	8b 45 08             	mov    0x8(%ebp),%eax
 71b:	83 c0 07             	add    $0x7,%eax
 71e:	c1 e8 03             	shr    $0x3,%eax
 721:	83 c0 01             	add    $0x1,%eax
 724:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 727:	a1 70 0a 00 00       	mov    0xa70,%eax
 72c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 72f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 733:	75 23                	jne    758 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 735:	c7 45 f0 68 0a 00 00 	movl   $0xa68,-0x10(%ebp)
 73c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73f:	a3 70 0a 00 00       	mov    %eax,0xa70
 744:	a1 70 0a 00 00       	mov    0xa70,%eax
 749:	a3 68 0a 00 00       	mov    %eax,0xa68
    base.s.size = 0;
 74e:	c7 05 6c 0a 00 00 00 	movl   $0x0,0xa6c
 755:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 758:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75b:	8b 00                	mov    (%eax),%eax
 75d:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	8b 40 04             	mov    0x4(%eax),%eax
 766:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 769:	72 4d                	jb     7b8 <malloc+0xa6>
      if(p->s.size == nunits)
 76b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76e:	8b 40 04             	mov    0x4(%eax),%eax
 771:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 774:	75 0c                	jne    782 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 776:	8b 45 f4             	mov    -0xc(%ebp),%eax
 779:	8b 10                	mov    (%eax),%edx
 77b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77e:	89 10                	mov    %edx,(%eax)
 780:	eb 26                	jmp    7a8 <malloc+0x96>
      else {
        p->s.size -= nunits;
 782:	8b 45 f4             	mov    -0xc(%ebp),%eax
 785:	8b 40 04             	mov    0x4(%eax),%eax
 788:	2b 45 ec             	sub    -0x14(%ebp),%eax
 78b:	89 c2                	mov    %eax,%edx
 78d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 790:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 793:	8b 45 f4             	mov    -0xc(%ebp),%eax
 796:	8b 40 04             	mov    0x4(%eax),%eax
 799:	c1 e0 03             	shl    $0x3,%eax
 79c:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a2:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7a5:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	a3 70 0a 00 00       	mov    %eax,0xa70
      return (void*)(p + 1);
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	83 c0 08             	add    $0x8,%eax
 7b6:	eb 3b                	jmp    7f3 <malloc+0xe1>
    }
    if(p == freep)
 7b8:	a1 70 0a 00 00       	mov    0xa70,%eax
 7bd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c0:	75 1e                	jne    7e0 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7c2:	83 ec 0c             	sub    $0xc,%esp
 7c5:	ff 75 ec             	pushl  -0x14(%ebp)
 7c8:	e8 e5 fe ff ff       	call   6b2 <morecore>
 7cd:	83 c4 10             	add    $0x10,%esp
 7d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7d7:	75 07                	jne    7e0 <malloc+0xce>
        return 0;
 7d9:	b8 00 00 00 00       	mov    $0x0,%eax
 7de:	eb 13                	jmp    7f3 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8b 00                	mov    (%eax),%eax
 7eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7ee:	e9 6d ff ff ff       	jmp    760 <malloc+0x4e>
}
 7f3:	c9                   	leave  
 7f4:	c3                   	ret    
