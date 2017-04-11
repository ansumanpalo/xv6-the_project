
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
  19:	e8 b3 02 00 00       	call   2d1 <exit>
  }
  printf(1, "Hello ");
  1e:	83 ec 08             	sub    $0x8,%esp
  21:	68 fe 07 00 00       	push   $0x7fe
  26:	6a 01                	push   $0x1
  28:	e8 1b 04 00 00       	call   448 <printf>
  2d:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i<argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 23                	jmp    5c <main+0x5c>
    printf(1, argv[i]);
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 08             	sub    $0x8,%esp
  4d:	50                   	push   %eax
  4e:	6a 01                	push   $0x1
  50:	e8 f3 03 00 00       	call   448 <printf>
  55:	83 c4 10             	add    $0x10,%esp
    int i;
  if(argc < 1){
    exit();
  }
  printf(1, "Hello ");
  for(i = 1; i<argc; i++){
  58:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5f:	3b 03                	cmp    (%ebx),%eax
  61:	7c d6                	jl     39 <main+0x39>
    printf(1, argv[i]);
  }
  printf(1, "\n");
  63:	83 ec 08             	sub    $0x8,%esp
  66:	68 05 08 00 00       	push   $0x805
  6b:	6a 01                	push   $0x1
  6d:	e8 d6 03 00 00       	call   448 <printf>
  72:	83 c4 10             	add    $0x10,%esp
  exit();
  75:	e8 57 02 00 00       	call   2d1 <exit>

0000007a <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  7a:	55                   	push   %ebp
  7b:	89 e5                	mov    %esp,%ebp
  7d:	57                   	push   %edi
  7e:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  82:	8b 55 10             	mov    0x10(%ebp),%edx
  85:	8b 45 0c             	mov    0xc(%ebp),%eax
  88:	89 cb                	mov    %ecx,%ebx
  8a:	89 df                	mov    %ebx,%edi
  8c:	89 d1                	mov    %edx,%ecx
  8e:	fc                   	cld    
  8f:	f3 aa                	rep stos %al,%es:(%edi)
  91:	89 ca                	mov    %ecx,%edx
  93:	89 fb                	mov    %edi,%ebx
  95:	89 5d 08             	mov    %ebx,0x8(%ebp)
  98:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  9b:	90                   	nop
  9c:	5b                   	pop    %ebx
  9d:	5f                   	pop    %edi
  9e:	5d                   	pop    %ebp
  9f:	c3                   	ret    

000000a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a6:	8b 45 08             	mov    0x8(%ebp),%eax
  a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  ac:	90                   	nop
  ad:	8b 45 08             	mov    0x8(%ebp),%eax
  b0:	8d 50 01             	lea    0x1(%eax),%edx
  b3:	89 55 08             	mov    %edx,0x8(%ebp)
  b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  b9:	8d 4a 01             	lea    0x1(%edx),%ecx
  bc:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  bf:	0f b6 12             	movzbl (%edx),%edx
  c2:	88 10                	mov    %dl,(%eax)
  c4:	0f b6 00             	movzbl (%eax),%eax
  c7:	84 c0                	test   %al,%al
  c9:	75 e2                	jne    ad <strcpy+0xd>
    ;
  return os;
  cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ce:	c9                   	leave  
  cf:	c3                   	ret    

000000d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  d3:	eb 08                	jmp    dd <strcmp+0xd>
    p++, q++;
  d5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d9:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  dd:	8b 45 08             	mov    0x8(%ebp),%eax
  e0:	0f b6 00             	movzbl (%eax),%eax
  e3:	84 c0                	test   %al,%al
  e5:	74 10                	je     f7 <strcmp+0x27>
  e7:	8b 45 08             	mov    0x8(%ebp),%eax
  ea:	0f b6 10             	movzbl (%eax),%edx
  ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  f0:	0f b6 00             	movzbl (%eax),%eax
  f3:	38 c2                	cmp    %al,%dl
  f5:	74 de                	je     d5 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  f7:	8b 45 08             	mov    0x8(%ebp),%eax
  fa:	0f b6 00             	movzbl (%eax),%eax
  fd:	0f b6 d0             	movzbl %al,%edx
 100:	8b 45 0c             	mov    0xc(%ebp),%eax
 103:	0f b6 00             	movzbl (%eax),%eax
 106:	0f b6 c0             	movzbl %al,%eax
 109:	29 c2                	sub    %eax,%edx
 10b:	89 d0                	mov    %edx,%eax
}
 10d:	5d                   	pop    %ebp
 10e:	c3                   	ret    

0000010f <strlen>:

uint
strlen(char *s)
{
 10f:	55                   	push   %ebp
 110:	89 e5                	mov    %esp,%ebp
 112:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 115:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 11c:	eb 04                	jmp    122 <strlen+0x13>
 11e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 122:	8b 55 fc             	mov    -0x4(%ebp),%edx
 125:	8b 45 08             	mov    0x8(%ebp),%eax
 128:	01 d0                	add    %edx,%eax
 12a:	0f b6 00             	movzbl (%eax),%eax
 12d:	84 c0                	test   %al,%al
 12f:	75 ed                	jne    11e <strlen+0xf>
    ;
  return n;
 131:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 134:	c9                   	leave  
 135:	c3                   	ret    

00000136 <memset>:

void*
memset(void *dst, int c, uint n)
{
 136:	55                   	push   %ebp
 137:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 139:	8b 45 10             	mov    0x10(%ebp),%eax
 13c:	50                   	push   %eax
 13d:	ff 75 0c             	pushl  0xc(%ebp)
 140:	ff 75 08             	pushl  0x8(%ebp)
 143:	e8 32 ff ff ff       	call   7a <stosb>
 148:	83 c4 0c             	add    $0xc,%esp
  return dst;
 14b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 14e:	c9                   	leave  
 14f:	c3                   	ret    

00000150 <strchr>:

char*
strchr(const char *s, char c)
{
 150:	55                   	push   %ebp
 151:	89 e5                	mov    %esp,%ebp
 153:	83 ec 04             	sub    $0x4,%esp
 156:	8b 45 0c             	mov    0xc(%ebp),%eax
 159:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 15c:	eb 14                	jmp    172 <strchr+0x22>
    if(*s == c)
 15e:	8b 45 08             	mov    0x8(%ebp),%eax
 161:	0f b6 00             	movzbl (%eax),%eax
 164:	3a 45 fc             	cmp    -0x4(%ebp),%al
 167:	75 05                	jne    16e <strchr+0x1e>
      return (char*)s;
 169:	8b 45 08             	mov    0x8(%ebp),%eax
 16c:	eb 13                	jmp    181 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	84 c0                	test   %al,%al
 17a:	75 e2                	jne    15e <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 17c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 181:	c9                   	leave  
 182:	c3                   	ret    

00000183 <gets>:

char*
gets(char *buf, int max)
{
 183:	55                   	push   %ebp
 184:	89 e5                	mov    %esp,%ebp
 186:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 189:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 190:	eb 42                	jmp    1d4 <gets+0x51>
    cc = read(0, &c, 1);
 192:	83 ec 04             	sub    $0x4,%esp
 195:	6a 01                	push   $0x1
 197:	8d 45 ef             	lea    -0x11(%ebp),%eax
 19a:	50                   	push   %eax
 19b:	6a 00                	push   $0x0
 19d:	e8 47 01 00 00       	call   2e9 <read>
 1a2:	83 c4 10             	add    $0x10,%esp
 1a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1ac:	7e 33                	jle    1e1 <gets+0x5e>
      break;
    buf[i++] = c;
 1ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b1:	8d 50 01             	lea    0x1(%eax),%edx
 1b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b7:	89 c2                	mov    %eax,%edx
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	01 c2                	add    %eax,%edx
 1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c8:	3c 0a                	cmp    $0xa,%al
 1ca:	74 16                	je     1e2 <gets+0x5f>
 1cc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d0:	3c 0d                	cmp    $0xd,%al
 1d2:	74 0e                	je     1e2 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d7:	83 c0 01             	add    $0x1,%eax
 1da:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1dd:	7c b3                	jl     192 <gets+0xf>
 1df:	eb 01                	jmp    1e2 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1e1:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	01 d0                	add    %edx,%eax
 1ea:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f0:	c9                   	leave  
 1f1:	c3                   	ret    

000001f2 <stat>:

int
stat(char *n, struct stat *st)
{
 1f2:	55                   	push   %ebp
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f8:	83 ec 08             	sub    $0x8,%esp
 1fb:	6a 00                	push   $0x0
 1fd:	ff 75 08             	pushl  0x8(%ebp)
 200:	e8 0c 01 00 00       	call   311 <open>
 205:	83 c4 10             	add    $0x10,%esp
 208:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20f:	79 07                	jns    218 <stat+0x26>
    return -1;
 211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 216:	eb 25                	jmp    23d <stat+0x4b>
  r = fstat(fd, st);
 218:	83 ec 08             	sub    $0x8,%esp
 21b:	ff 75 0c             	pushl  0xc(%ebp)
 21e:	ff 75 f4             	pushl  -0xc(%ebp)
 221:	e8 03 01 00 00       	call   329 <fstat>
 226:	83 c4 10             	add    $0x10,%esp
 229:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22c:	83 ec 0c             	sub    $0xc,%esp
 22f:	ff 75 f4             	pushl  -0xc(%ebp)
 232:	e8 c2 00 00 00       	call   2f9 <close>
 237:	83 c4 10             	add    $0x10,%esp
  return r;
 23a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23d:	c9                   	leave  
 23e:	c3                   	ret    

0000023f <atoi>:

int
atoi(const char *s)
{
 23f:	55                   	push   %ebp
 240:	89 e5                	mov    %esp,%ebp
 242:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 245:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24c:	eb 25                	jmp    273 <atoi+0x34>
    n = n*10 + *s++ - '0';
 24e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 251:	89 d0                	mov    %edx,%eax
 253:	c1 e0 02             	shl    $0x2,%eax
 256:	01 d0                	add    %edx,%eax
 258:	01 c0                	add    %eax,%eax
 25a:	89 c1                	mov    %eax,%ecx
 25c:	8b 45 08             	mov    0x8(%ebp),%eax
 25f:	8d 50 01             	lea    0x1(%eax),%edx
 262:	89 55 08             	mov    %edx,0x8(%ebp)
 265:	0f b6 00             	movzbl (%eax),%eax
 268:	0f be c0             	movsbl %al,%eax
 26b:	01 c8                	add    %ecx,%eax
 26d:	83 e8 30             	sub    $0x30,%eax
 270:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	3c 2f                	cmp    $0x2f,%al
 27b:	7e 0a                	jle    287 <atoi+0x48>
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	0f b6 00             	movzbl (%eax),%eax
 283:	3c 39                	cmp    $0x39,%al
 285:	7e c7                	jle    24e <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 287:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 28a:	c9                   	leave  
 28b:	c3                   	ret    

0000028c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28c:	55                   	push   %ebp
 28d:	89 e5                	mov    %esp,%ebp
 28f:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
 295:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 298:	8b 45 0c             	mov    0xc(%ebp),%eax
 29b:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29e:	eb 17                	jmp    2b7 <memmove+0x2b>
    *dst++ = *src++;
 2a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a3:	8d 50 01             	lea    0x1(%eax),%edx
 2a6:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2ac:	8d 4a 01             	lea    0x1(%edx),%ecx
 2af:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b2:	0f b6 12             	movzbl (%edx),%edx
 2b5:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b7:	8b 45 10             	mov    0x10(%ebp),%eax
 2ba:	8d 50 ff             	lea    -0x1(%eax),%edx
 2bd:	89 55 10             	mov    %edx,0x10(%ebp)
 2c0:	85 c0                	test   %eax,%eax
 2c2:	7f dc                	jg     2a0 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c7:	c9                   	leave  
 2c8:	c3                   	ret    

000002c9 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c9:	b8 01 00 00 00       	mov    $0x1,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <exit>:
SYSCALL(exit)
 2d1:	b8 02 00 00 00       	mov    $0x2,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <wait>:
SYSCALL(wait)
 2d9:	b8 03 00 00 00       	mov    $0x3,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <pipe>:
SYSCALL(pipe)
 2e1:	b8 04 00 00 00       	mov    $0x4,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <read>:
SYSCALL(read)
 2e9:	b8 05 00 00 00       	mov    $0x5,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <write>:
SYSCALL(write)
 2f1:	b8 10 00 00 00       	mov    $0x10,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <close>:
SYSCALL(close)
 2f9:	b8 15 00 00 00       	mov    $0x15,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <kill>:
SYSCALL(kill)
 301:	b8 06 00 00 00       	mov    $0x6,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <exec>:
SYSCALL(exec)
 309:	b8 07 00 00 00       	mov    $0x7,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <open>:
SYSCALL(open)
 311:	b8 0f 00 00 00       	mov    $0xf,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <mknod>:
SYSCALL(mknod)
 319:	b8 11 00 00 00       	mov    $0x11,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <unlink>:
SYSCALL(unlink)
 321:	b8 12 00 00 00       	mov    $0x12,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <fstat>:
SYSCALL(fstat)
 329:	b8 08 00 00 00       	mov    $0x8,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <link>:
SYSCALL(link)
 331:	b8 13 00 00 00       	mov    $0x13,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <mkdir>:
SYSCALL(mkdir)
 339:	b8 14 00 00 00       	mov    $0x14,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <chdir>:
SYSCALL(chdir)
 341:	b8 09 00 00 00       	mov    $0x9,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <dup>:
SYSCALL(dup)
 349:	b8 0a 00 00 00       	mov    $0xa,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <getpid>:
SYSCALL(getpid)
 351:	b8 0b 00 00 00       	mov    $0xb,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <sbrk>:
SYSCALL(sbrk)
 359:	b8 0c 00 00 00       	mov    $0xc,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <sleep>:
SYSCALL(sleep)
 361:	b8 0d 00 00 00       	mov    $0xd,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <uptime>:
SYSCALL(uptime)
 369:	b8 0e 00 00 00       	mov    $0xe,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 371:	55                   	push   %ebp
 372:	89 e5                	mov    %esp,%ebp
 374:	83 ec 18             	sub    $0x18,%esp
 377:	8b 45 0c             	mov    0xc(%ebp),%eax
 37a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 37d:	83 ec 04             	sub    $0x4,%esp
 380:	6a 01                	push   $0x1
 382:	8d 45 f4             	lea    -0xc(%ebp),%eax
 385:	50                   	push   %eax
 386:	ff 75 08             	pushl  0x8(%ebp)
 389:	e8 63 ff ff ff       	call   2f1 <write>
 38e:	83 c4 10             	add    $0x10,%esp
}
 391:	90                   	nop
 392:	c9                   	leave  
 393:	c3                   	ret    

00000394 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 394:	55                   	push   %ebp
 395:	89 e5                	mov    %esp,%ebp
 397:	53                   	push   %ebx
 398:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 39b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3a2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3a6:	74 17                	je     3bf <printint+0x2b>
 3a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3ac:	79 11                	jns    3bf <printint+0x2b>
    neg = 1;
 3ae:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b8:	f7 d8                	neg    %eax
 3ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3bd:	eb 06                	jmp    3c5 <printint+0x31>
  } else {
    x = xx;
 3bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3cc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3cf:	8d 41 01             	lea    0x1(%ecx),%eax
 3d2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3db:	ba 00 00 00 00       	mov    $0x0,%edx
 3e0:	f7 f3                	div    %ebx
 3e2:	89 d0                	mov    %edx,%eax
 3e4:	0f b6 80 5c 0a 00 00 	movzbl 0xa5c(%eax),%eax
 3eb:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3ef:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f5:	ba 00 00 00 00       	mov    $0x0,%edx
 3fa:	f7 f3                	div    %ebx
 3fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 403:	75 c7                	jne    3cc <printint+0x38>
  if(neg)
 405:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 409:	74 2d                	je     438 <printint+0xa4>
    buf[i++] = '-';
 40b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40e:	8d 50 01             	lea    0x1(%eax),%edx
 411:	89 55 f4             	mov    %edx,-0xc(%ebp)
 414:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 419:	eb 1d                	jmp    438 <printint+0xa4>
    putc(fd, buf[i]);
 41b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 41e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 421:	01 d0                	add    %edx,%eax
 423:	0f b6 00             	movzbl (%eax),%eax
 426:	0f be c0             	movsbl %al,%eax
 429:	83 ec 08             	sub    $0x8,%esp
 42c:	50                   	push   %eax
 42d:	ff 75 08             	pushl  0x8(%ebp)
 430:	e8 3c ff ff ff       	call   371 <putc>
 435:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 438:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 43c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 440:	79 d9                	jns    41b <printint+0x87>
    putc(fd, buf[i]);
}
 442:	90                   	nop
 443:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 446:	c9                   	leave  
 447:	c3                   	ret    

00000448 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 448:	55                   	push   %ebp
 449:	89 e5                	mov    %esp,%ebp
 44b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 44e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 455:	8d 45 0c             	lea    0xc(%ebp),%eax
 458:	83 c0 04             	add    $0x4,%eax
 45b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 45e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 465:	e9 59 01 00 00       	jmp    5c3 <printf+0x17b>
    c = fmt[i] & 0xff;
 46a:	8b 55 0c             	mov    0xc(%ebp),%edx
 46d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 470:	01 d0                	add    %edx,%eax
 472:	0f b6 00             	movzbl (%eax),%eax
 475:	0f be c0             	movsbl %al,%eax
 478:	25 ff 00 00 00       	and    $0xff,%eax
 47d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 480:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 484:	75 2c                	jne    4b2 <printf+0x6a>
      if(c == '%'){
 486:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 48a:	75 0c                	jne    498 <printf+0x50>
        state = '%';
 48c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 493:	e9 27 01 00 00       	jmp    5bf <printf+0x177>
      } else {
        putc(fd, c);
 498:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 49b:	0f be c0             	movsbl %al,%eax
 49e:	83 ec 08             	sub    $0x8,%esp
 4a1:	50                   	push   %eax
 4a2:	ff 75 08             	pushl  0x8(%ebp)
 4a5:	e8 c7 fe ff ff       	call   371 <putc>
 4aa:	83 c4 10             	add    $0x10,%esp
 4ad:	e9 0d 01 00 00       	jmp    5bf <printf+0x177>
      }
    } else if(state == '%'){
 4b2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4b6:	0f 85 03 01 00 00    	jne    5bf <printf+0x177>
      if(c == 'd'){
 4bc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4c0:	75 1e                	jne    4e0 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c5:	8b 00                	mov    (%eax),%eax
 4c7:	6a 01                	push   $0x1
 4c9:	6a 0a                	push   $0xa
 4cb:	50                   	push   %eax
 4cc:	ff 75 08             	pushl  0x8(%ebp)
 4cf:	e8 c0 fe ff ff       	call   394 <printint>
 4d4:	83 c4 10             	add    $0x10,%esp
        ap++;
 4d7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4db:	e9 d8 00 00 00       	jmp    5b8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4e0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4e4:	74 06                	je     4ec <printf+0xa4>
 4e6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4ea:	75 1e                	jne    50a <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ef:	8b 00                	mov    (%eax),%eax
 4f1:	6a 00                	push   $0x0
 4f3:	6a 10                	push   $0x10
 4f5:	50                   	push   %eax
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 96 fe ff ff       	call   394 <printint>
 4fe:	83 c4 10             	add    $0x10,%esp
        ap++;
 501:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 505:	e9 ae 00 00 00       	jmp    5b8 <printf+0x170>
      } else if(c == 's'){
 50a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 50e:	75 43                	jne    553 <printf+0x10b>
        s = (char*)*ap;
 510:	8b 45 e8             	mov    -0x18(%ebp),%eax
 513:	8b 00                	mov    (%eax),%eax
 515:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 518:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 51c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 520:	75 25                	jne    547 <printf+0xff>
          s = "(null)";
 522:	c7 45 f4 07 08 00 00 	movl   $0x807,-0xc(%ebp)
        while(*s != 0){
 529:	eb 1c                	jmp    547 <printf+0xff>
          putc(fd, *s);
 52b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52e:	0f b6 00             	movzbl (%eax),%eax
 531:	0f be c0             	movsbl %al,%eax
 534:	83 ec 08             	sub    $0x8,%esp
 537:	50                   	push   %eax
 538:	ff 75 08             	pushl  0x8(%ebp)
 53b:	e8 31 fe ff ff       	call   371 <putc>
 540:	83 c4 10             	add    $0x10,%esp
          s++;
 543:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 547:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54a:	0f b6 00             	movzbl (%eax),%eax
 54d:	84 c0                	test   %al,%al
 54f:	75 da                	jne    52b <printf+0xe3>
 551:	eb 65                	jmp    5b8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 553:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 557:	75 1d                	jne    576 <printf+0x12e>
        putc(fd, *ap);
 559:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55c:	8b 00                	mov    (%eax),%eax
 55e:	0f be c0             	movsbl %al,%eax
 561:	83 ec 08             	sub    $0x8,%esp
 564:	50                   	push   %eax
 565:	ff 75 08             	pushl  0x8(%ebp)
 568:	e8 04 fe ff ff       	call   371 <putc>
 56d:	83 c4 10             	add    $0x10,%esp
        ap++;
 570:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 574:	eb 42                	jmp    5b8 <printf+0x170>
      } else if(c == '%'){
 576:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 57a:	75 17                	jne    593 <printf+0x14b>
        putc(fd, c);
 57c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57f:	0f be c0             	movsbl %al,%eax
 582:	83 ec 08             	sub    $0x8,%esp
 585:	50                   	push   %eax
 586:	ff 75 08             	pushl  0x8(%ebp)
 589:	e8 e3 fd ff ff       	call   371 <putc>
 58e:	83 c4 10             	add    $0x10,%esp
 591:	eb 25                	jmp    5b8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 593:	83 ec 08             	sub    $0x8,%esp
 596:	6a 25                	push   $0x25
 598:	ff 75 08             	pushl  0x8(%ebp)
 59b:	e8 d1 fd ff ff       	call   371 <putc>
 5a0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5a3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a6:	0f be c0             	movsbl %al,%eax
 5a9:	83 ec 08             	sub    $0x8,%esp
 5ac:	50                   	push   %eax
 5ad:	ff 75 08             	pushl  0x8(%ebp)
 5b0:	e8 bc fd ff ff       	call   371 <putc>
 5b5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5b8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5bf:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c3:	8b 55 0c             	mov    0xc(%ebp),%edx
 5c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c9:	01 d0                	add    %edx,%eax
 5cb:	0f b6 00             	movzbl (%eax),%eax
 5ce:	84 c0                	test   %al,%al
 5d0:	0f 85 94 fe ff ff    	jne    46a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d6:	90                   	nop
 5d7:	c9                   	leave  
 5d8:	c3                   	ret    

000005d9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d9:	55                   	push   %ebp
 5da:	89 e5                	mov    %esp,%ebp
 5dc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5df:	8b 45 08             	mov    0x8(%ebp),%eax
 5e2:	83 e8 08             	sub    $0x8,%eax
 5e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e8:	a1 78 0a 00 00       	mov    0xa78,%eax
 5ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f0:	eb 24                	jmp    616 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f5:	8b 00                	mov    (%eax),%eax
 5f7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5fa:	77 12                	ja     60e <free+0x35>
 5fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5ff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 602:	77 24                	ja     628 <free+0x4f>
 604:	8b 45 fc             	mov    -0x4(%ebp),%eax
 607:	8b 00                	mov    (%eax),%eax
 609:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60c:	77 1a                	ja     628 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 611:	8b 00                	mov    (%eax),%eax
 613:	89 45 fc             	mov    %eax,-0x4(%ebp)
 616:	8b 45 f8             	mov    -0x8(%ebp),%eax
 619:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61c:	76 d4                	jbe    5f2 <free+0x19>
 61e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 621:	8b 00                	mov    (%eax),%eax
 623:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 626:	76 ca                	jbe    5f2 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 628:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62b:	8b 40 04             	mov    0x4(%eax),%eax
 62e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 635:	8b 45 f8             	mov    -0x8(%ebp),%eax
 638:	01 c2                	add    %eax,%edx
 63a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63d:	8b 00                	mov    (%eax),%eax
 63f:	39 c2                	cmp    %eax,%edx
 641:	75 24                	jne    667 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 643:	8b 45 f8             	mov    -0x8(%ebp),%eax
 646:	8b 50 04             	mov    0x4(%eax),%edx
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	8b 40 04             	mov    0x4(%eax),%eax
 651:	01 c2                	add    %eax,%edx
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 659:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65c:	8b 00                	mov    (%eax),%eax
 65e:	8b 10                	mov    (%eax),%edx
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	89 10                	mov    %edx,(%eax)
 665:	eb 0a                	jmp    671 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 667:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66a:	8b 10                	mov    (%eax),%edx
 66c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 40 04             	mov    0x4(%eax),%eax
 677:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 67e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 681:	01 d0                	add    %edx,%eax
 683:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 686:	75 20                	jne    6a8 <free+0xcf>
    p->s.size += bp->s.size;
 688:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68b:	8b 50 04             	mov    0x4(%eax),%edx
 68e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 691:	8b 40 04             	mov    0x4(%eax),%eax
 694:	01 c2                	add    %eax,%edx
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 69c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69f:	8b 10                	mov    (%eax),%edx
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	89 10                	mov    %edx,(%eax)
 6a6:	eb 08                	jmp    6b0 <free+0xd7>
  } else
    p->s.ptr = bp;
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ae:	89 10                	mov    %edx,(%eax)
  freep = p;
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	a3 78 0a 00 00       	mov    %eax,0xa78
}
 6b8:	90                   	nop
 6b9:	c9                   	leave  
 6ba:	c3                   	ret    

000006bb <morecore>:

static Header*
morecore(uint nu)
{
 6bb:	55                   	push   %ebp
 6bc:	89 e5                	mov    %esp,%ebp
 6be:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6c8:	77 07                	ja     6d1 <morecore+0x16>
    nu = 4096;
 6ca:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d1:	8b 45 08             	mov    0x8(%ebp),%eax
 6d4:	c1 e0 03             	shl    $0x3,%eax
 6d7:	83 ec 0c             	sub    $0xc,%esp
 6da:	50                   	push   %eax
 6db:	e8 79 fc ff ff       	call   359 <sbrk>
 6e0:	83 c4 10             	add    $0x10,%esp
 6e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6e6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6ea:	75 07                	jne    6f3 <morecore+0x38>
    return 0;
 6ec:	b8 00 00 00 00       	mov    $0x0,%eax
 6f1:	eb 26                	jmp    719 <morecore+0x5e>
  hp = (Header*)p;
 6f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fc:	8b 55 08             	mov    0x8(%ebp),%edx
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 702:	8b 45 f0             	mov    -0x10(%ebp),%eax
 705:	83 c0 08             	add    $0x8,%eax
 708:	83 ec 0c             	sub    $0xc,%esp
 70b:	50                   	push   %eax
 70c:	e8 c8 fe ff ff       	call   5d9 <free>
 711:	83 c4 10             	add    $0x10,%esp
  return freep;
 714:	a1 78 0a 00 00       	mov    0xa78,%eax
}
 719:	c9                   	leave  
 71a:	c3                   	ret    

0000071b <malloc>:

void*
malloc(uint nbytes)
{
 71b:	55                   	push   %ebp
 71c:	89 e5                	mov    %esp,%ebp
 71e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 721:	8b 45 08             	mov    0x8(%ebp),%eax
 724:	83 c0 07             	add    $0x7,%eax
 727:	c1 e8 03             	shr    $0x3,%eax
 72a:	83 c0 01             	add    $0x1,%eax
 72d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 730:	a1 78 0a 00 00       	mov    0xa78,%eax
 735:	89 45 f0             	mov    %eax,-0x10(%ebp)
 738:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 73c:	75 23                	jne    761 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 73e:	c7 45 f0 70 0a 00 00 	movl   $0xa70,-0x10(%ebp)
 745:	8b 45 f0             	mov    -0x10(%ebp),%eax
 748:	a3 78 0a 00 00       	mov    %eax,0xa78
 74d:	a1 78 0a 00 00       	mov    0xa78,%eax
 752:	a3 70 0a 00 00       	mov    %eax,0xa70
    base.s.size = 0;
 757:	c7 05 74 0a 00 00 00 	movl   $0x0,0xa74
 75e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 761:	8b 45 f0             	mov    -0x10(%ebp),%eax
 764:	8b 00                	mov    (%eax),%eax
 766:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 769:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76c:	8b 40 04             	mov    0x4(%eax),%eax
 76f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 772:	72 4d                	jb     7c1 <malloc+0xa6>
      if(p->s.size == nunits)
 774:	8b 45 f4             	mov    -0xc(%ebp),%eax
 777:	8b 40 04             	mov    0x4(%eax),%eax
 77a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 77d:	75 0c                	jne    78b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 77f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 782:	8b 10                	mov    (%eax),%edx
 784:	8b 45 f0             	mov    -0x10(%ebp),%eax
 787:	89 10                	mov    %edx,(%eax)
 789:	eb 26                	jmp    7b1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	8b 40 04             	mov    0x4(%eax),%eax
 791:	2b 45 ec             	sub    -0x14(%ebp),%eax
 794:	89 c2                	mov    %eax,%edx
 796:	8b 45 f4             	mov    -0xc(%ebp),%eax
 799:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	8b 40 04             	mov    0x4(%eax),%eax
 7a2:	c1 e0 03             	shl    $0x3,%eax
 7a5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ae:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b4:	a3 78 0a 00 00       	mov    %eax,0xa78
      return (void*)(p + 1);
 7b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bc:	83 c0 08             	add    $0x8,%eax
 7bf:	eb 3b                	jmp    7fc <malloc+0xe1>
    }
    if(p == freep)
 7c1:	a1 78 0a 00 00       	mov    0xa78,%eax
 7c6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c9:	75 1e                	jne    7e9 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7cb:	83 ec 0c             	sub    $0xc,%esp
 7ce:	ff 75 ec             	pushl  -0x14(%ebp)
 7d1:	e8 e5 fe ff ff       	call   6bb <morecore>
 7d6:	83 c4 10             	add    $0x10,%esp
 7d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e0:	75 07                	jne    7e9 <malloc+0xce>
        return 0;
 7e2:	b8 00 00 00 00       	mov    $0x0,%eax
 7e7:	eb 13                	jmp    7fc <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	8b 00                	mov    (%eax),%eax
 7f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7f7:	e9 6d ff ff ff       	jmp    769 <malloc+0x4e>
}
 7fc:	c9                   	leave  
 7fd:	c3                   	ret    
