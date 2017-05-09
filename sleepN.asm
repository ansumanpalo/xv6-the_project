
_sleepN:     file format elf32-i386


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
   e:	83 ec 14             	sub    $0x14,%esp
  11:	89 c8                	mov    %ecx,%eax

  if(argc < 1){
  13:	83 38 00             	cmpl   $0x0,(%eax)
  16:	7f 05                	jg     1d <main+0x1d>
    exit();
  18:	e8 a2 02 00 00       	call   2bf <exit>
  }
  int i = atoi(argv[1]);
  1d:	8b 40 04             	mov    0x4(%eax),%eax
  20:	83 c0 04             	add    $0x4,%eax
  23:	8b 00                	mov    (%eax),%eax
  25:	83 ec 0c             	sub    $0xc,%esp
  28:	50                   	push   %eax
  29:	e8 ff 01 00 00       	call   22d <atoi>
  2e:	83 c4 10             	add    $0x10,%esp
  31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  sleep(1000*i/14);
  34:	8b 45 f4             	mov    -0xc(%ebp),%eax
  37:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
  3d:	ba 93 24 49 92       	mov    $0x92492493,%edx
  42:	89 c8                	mov    %ecx,%eax
  44:	f7 ea                	imul   %edx
  46:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  49:	c1 f8 03             	sar    $0x3,%eax
  4c:	89 c2                	mov    %eax,%edx
  4e:	89 c8                	mov    %ecx,%eax
  50:	c1 f8 1f             	sar    $0x1f,%eax
  53:	29 c2                	sub    %eax,%edx
  55:	89 d0                	mov    %edx,%eax
  57:	83 ec 0c             	sub    $0xc,%esp
  5a:	50                   	push   %eax
  5b:	e8 ef 02 00 00       	call   34f <sleep>
  60:	83 c4 10             	add    $0x10,%esp
  exit();
  63:	e8 57 02 00 00       	call   2bf <exit>

00000068 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	57                   	push   %edi
  6c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  70:	8b 55 10             	mov    0x10(%ebp),%edx
  73:	8b 45 0c             	mov    0xc(%ebp),%eax
  76:	89 cb                	mov    %ecx,%ebx
  78:	89 df                	mov    %ebx,%edi
  7a:	89 d1                	mov    %edx,%ecx
  7c:	fc                   	cld    
  7d:	f3 aa                	rep stos %al,%es:(%edi)
  7f:	89 ca                	mov    %ecx,%edx
  81:	89 fb                	mov    %edi,%ebx
  83:	89 5d 08             	mov    %ebx,0x8(%ebp)
  86:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  89:	90                   	nop
  8a:	5b                   	pop    %ebx
  8b:	5f                   	pop    %edi
  8c:	5d                   	pop    %ebp
  8d:	c3                   	ret    

0000008e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8e:	55                   	push   %ebp
  8f:	89 e5                	mov    %esp,%ebp
  91:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  9a:	90                   	nop
  9b:	8b 45 08             	mov    0x8(%ebp),%eax
  9e:	8d 50 01             	lea    0x1(%eax),%edx
  a1:	89 55 08             	mov    %edx,0x8(%ebp)
  a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  a7:	8d 4a 01             	lea    0x1(%edx),%ecx
  aa:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  ad:	0f b6 12             	movzbl (%edx),%edx
  b0:	88 10                	mov    %dl,(%eax)
  b2:	0f b6 00             	movzbl (%eax),%eax
  b5:	84 c0                	test   %al,%al
  b7:	75 e2                	jne    9b <strcpy+0xd>
    ;
  return os;
  b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  bc:	c9                   	leave  
  bd:	c3                   	ret    

000000be <strcmp>:

int
strcmp(const char *p, const char *q)
{
  be:	55                   	push   %ebp
  bf:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  c1:	eb 08                	jmp    cb <strcmp+0xd>
    p++, q++;
  c3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  cb:	8b 45 08             	mov    0x8(%ebp),%eax
  ce:	0f b6 00             	movzbl (%eax),%eax
  d1:	84 c0                	test   %al,%al
  d3:	74 10                	je     e5 <strcmp+0x27>
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 10             	movzbl (%eax),%edx
  db:	8b 45 0c             	mov    0xc(%ebp),%eax
  de:	0f b6 00             	movzbl (%eax),%eax
  e1:	38 c2                	cmp    %al,%dl
  e3:	74 de                	je     c3 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e5:	8b 45 08             	mov    0x8(%ebp),%eax
  e8:	0f b6 00             	movzbl (%eax),%eax
  eb:	0f b6 d0             	movzbl %al,%edx
  ee:	8b 45 0c             	mov    0xc(%ebp),%eax
  f1:	0f b6 00             	movzbl (%eax),%eax
  f4:	0f b6 c0             	movzbl %al,%eax
  f7:	29 c2                	sub    %eax,%edx
  f9:	89 d0                	mov    %edx,%eax
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    

000000fd <strlen>:

uint
strlen(char *s)
{
  fd:	55                   	push   %ebp
  fe:	89 e5                	mov    %esp,%ebp
 100:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 103:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 10a:	eb 04                	jmp    110 <strlen+0x13>
 10c:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 110:	8b 55 fc             	mov    -0x4(%ebp),%edx
 113:	8b 45 08             	mov    0x8(%ebp),%eax
 116:	01 d0                	add    %edx,%eax
 118:	0f b6 00             	movzbl (%eax),%eax
 11b:	84 c0                	test   %al,%al
 11d:	75 ed                	jne    10c <strlen+0xf>
    ;
  return n;
 11f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 122:	c9                   	leave  
 123:	c3                   	ret    

00000124 <memset>:

void*
memset(void *dst, int c, uint n)
{
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 127:	8b 45 10             	mov    0x10(%ebp),%eax
 12a:	50                   	push   %eax
 12b:	ff 75 0c             	pushl  0xc(%ebp)
 12e:	ff 75 08             	pushl  0x8(%ebp)
 131:	e8 32 ff ff ff       	call   68 <stosb>
 136:	83 c4 0c             	add    $0xc,%esp
  return dst;
 139:	8b 45 08             	mov    0x8(%ebp),%eax
}
 13c:	c9                   	leave  
 13d:	c3                   	ret    

0000013e <strchr>:

char*
strchr(const char *s, char c)
{
 13e:	55                   	push   %ebp
 13f:	89 e5                	mov    %esp,%ebp
 141:	83 ec 04             	sub    $0x4,%esp
 144:	8b 45 0c             	mov    0xc(%ebp),%eax
 147:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 14a:	eb 14                	jmp    160 <strchr+0x22>
    if(*s == c)
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	0f b6 00             	movzbl (%eax),%eax
 152:	3a 45 fc             	cmp    -0x4(%ebp),%al
 155:	75 05                	jne    15c <strchr+0x1e>
      return (char*)s;
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	eb 13                	jmp    16f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 160:	8b 45 08             	mov    0x8(%ebp),%eax
 163:	0f b6 00             	movzbl (%eax),%eax
 166:	84 c0                	test   %al,%al
 168:	75 e2                	jne    14c <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 16a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16f:	c9                   	leave  
 170:	c3                   	ret    

00000171 <gets>:

char*
gets(char *buf, int max)
{
 171:	55                   	push   %ebp
 172:	89 e5                	mov    %esp,%ebp
 174:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 177:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17e:	eb 42                	jmp    1c2 <gets+0x51>
    cc = read(0, &c, 1);
 180:	83 ec 04             	sub    $0x4,%esp
 183:	6a 01                	push   $0x1
 185:	8d 45 ef             	lea    -0x11(%ebp),%eax
 188:	50                   	push   %eax
 189:	6a 00                	push   $0x0
 18b:	e8 47 01 00 00       	call   2d7 <read>
 190:	83 c4 10             	add    $0x10,%esp
 193:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 196:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 19a:	7e 33                	jle    1cf <gets+0x5e>
      break;
    buf[i++] = c;
 19c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19f:	8d 50 01             	lea    0x1(%eax),%edx
 1a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a5:	89 c2                	mov    %eax,%edx
 1a7:	8b 45 08             	mov    0x8(%ebp),%eax
 1aa:	01 c2                	add    %eax,%edx
 1ac:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1b2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b6:	3c 0a                	cmp    $0xa,%al
 1b8:	74 16                	je     1d0 <gets+0x5f>
 1ba:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1be:	3c 0d                	cmp    $0xd,%al
 1c0:	74 0e                	je     1d0 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c5:	83 c0 01             	add    $0x1,%eax
 1c8:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1cb:	7c b3                	jl     180 <gets+0xf>
 1cd:	eb 01                	jmp    1d0 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1cf:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 d0                	add    %edx,%eax
 1d8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1db:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1de:	c9                   	leave  
 1df:	c3                   	ret    

000001e0 <stat>:

int
stat(char *n, struct stat *st)
{
 1e0:	55                   	push   %ebp
 1e1:	89 e5                	mov    %esp,%ebp
 1e3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e6:	83 ec 08             	sub    $0x8,%esp
 1e9:	6a 00                	push   $0x0
 1eb:	ff 75 08             	pushl  0x8(%ebp)
 1ee:	e8 0c 01 00 00       	call   2ff <open>
 1f3:	83 c4 10             	add    $0x10,%esp
 1f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1fd:	79 07                	jns    206 <stat+0x26>
    return -1;
 1ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 204:	eb 25                	jmp    22b <stat+0x4b>
  r = fstat(fd, st);
 206:	83 ec 08             	sub    $0x8,%esp
 209:	ff 75 0c             	pushl  0xc(%ebp)
 20c:	ff 75 f4             	pushl  -0xc(%ebp)
 20f:	e8 03 01 00 00       	call   317 <fstat>
 214:	83 c4 10             	add    $0x10,%esp
 217:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 21a:	83 ec 0c             	sub    $0xc,%esp
 21d:	ff 75 f4             	pushl  -0xc(%ebp)
 220:	e8 c2 00 00 00       	call   2e7 <close>
 225:	83 c4 10             	add    $0x10,%esp
  return r;
 228:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 22b:	c9                   	leave  
 22c:	c3                   	ret    

0000022d <atoi>:

int
atoi(const char *s)
{
 22d:	55                   	push   %ebp
 22e:	89 e5                	mov    %esp,%ebp
 230:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 233:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 23a:	eb 25                	jmp    261 <atoi+0x34>
    n = n*10 + *s++ - '0';
 23c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 23f:	89 d0                	mov    %edx,%eax
 241:	c1 e0 02             	shl    $0x2,%eax
 244:	01 d0                	add    %edx,%eax
 246:	01 c0                	add    %eax,%eax
 248:	89 c1                	mov    %eax,%ecx
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	8d 50 01             	lea    0x1(%eax),%edx
 250:	89 55 08             	mov    %edx,0x8(%ebp)
 253:	0f b6 00             	movzbl (%eax),%eax
 256:	0f be c0             	movsbl %al,%eax
 259:	01 c8                	add    %ecx,%eax
 25b:	83 e8 30             	sub    $0x30,%eax
 25e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	0f b6 00             	movzbl (%eax),%eax
 267:	3c 2f                	cmp    $0x2f,%al
 269:	7e 0a                	jle    275 <atoi+0x48>
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	3c 39                	cmp    $0x39,%al
 273:	7e c7                	jle    23c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 275:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 278:	c9                   	leave  
 279:	c3                   	ret    

0000027a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 27a:	55                   	push   %ebp
 27b:	89 e5                	mov    %esp,%ebp
 27d:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 280:	8b 45 08             	mov    0x8(%ebp),%eax
 283:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 286:	8b 45 0c             	mov    0xc(%ebp),%eax
 289:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 28c:	eb 17                	jmp    2a5 <memmove+0x2b>
    *dst++ = *src++;
 28e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 291:	8d 50 01             	lea    0x1(%eax),%edx
 294:	89 55 fc             	mov    %edx,-0x4(%ebp)
 297:	8b 55 f8             	mov    -0x8(%ebp),%edx
 29a:	8d 4a 01             	lea    0x1(%edx),%ecx
 29d:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2a0:	0f b6 12             	movzbl (%edx),%edx
 2a3:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a5:	8b 45 10             	mov    0x10(%ebp),%eax
 2a8:	8d 50 ff             	lea    -0x1(%eax),%edx
 2ab:	89 55 10             	mov    %edx,0x10(%ebp)
 2ae:	85 c0                	test   %eax,%eax
 2b0:	7f dc                	jg     28e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b5:	c9                   	leave  
 2b6:	c3                   	ret    

000002b7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2b7:	b8 01 00 00 00       	mov    $0x1,%eax
 2bc:	cd 40                	int    $0x40
 2be:	c3                   	ret    

000002bf <exit>:
SYSCALL(exit)
 2bf:	b8 02 00 00 00       	mov    $0x2,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <wait>:
SYSCALL(wait)
 2c7:	b8 03 00 00 00       	mov    $0x3,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <pipe>:
SYSCALL(pipe)
 2cf:	b8 04 00 00 00       	mov    $0x4,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <read>:
SYSCALL(read)
 2d7:	b8 05 00 00 00       	mov    $0x5,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <write>:
SYSCALL(write)
 2df:	b8 10 00 00 00       	mov    $0x10,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <close>:
SYSCALL(close)
 2e7:	b8 15 00 00 00       	mov    $0x15,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <kill>:
SYSCALL(kill)
 2ef:	b8 06 00 00 00       	mov    $0x6,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <exec>:
SYSCALL(exec)
 2f7:	b8 07 00 00 00       	mov    $0x7,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <open>:
SYSCALL(open)
 2ff:	b8 0f 00 00 00       	mov    $0xf,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <mknod>:
SYSCALL(mknod)
 307:	b8 11 00 00 00       	mov    $0x11,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <unlink>:
SYSCALL(unlink)
 30f:	b8 12 00 00 00       	mov    $0x12,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <fstat>:
SYSCALL(fstat)
 317:	b8 08 00 00 00       	mov    $0x8,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <link>:
SYSCALL(link)
 31f:	b8 13 00 00 00       	mov    $0x13,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <mkdir>:
SYSCALL(mkdir)
 327:	b8 14 00 00 00       	mov    $0x14,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <chdir>:
SYSCALL(chdir)
 32f:	b8 09 00 00 00       	mov    $0x9,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <dup>:
SYSCALL(dup)
 337:	b8 0a 00 00 00       	mov    $0xa,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <getpid>:
SYSCALL(getpid)
 33f:	b8 0b 00 00 00       	mov    $0xb,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <sbrk>:
SYSCALL(sbrk)
 347:	b8 0c 00 00 00       	mov    $0xc,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <sleep>:
SYSCALL(sleep)
 34f:	b8 0d 00 00 00       	mov    $0xd,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <uptime>:
SYSCALL(uptime)
 357:	b8 0e 00 00 00       	mov    $0xe,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <randomX>:
SYSCALL(randomX)
 35f:	b8 16 00 00 00       	mov    $0x16,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <setSeedX>:
SYSCALL(setSeedX)
 367:	b8 17 00 00 00       	mov    $0x17,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <uniformR>:
SYSCALL(uniformR)
 36f:	b8 18 00 00 00       	mov    $0x18,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 377:	55                   	push   %ebp
 378:	89 e5                	mov    %esp,%ebp
 37a:	83 ec 18             	sub    $0x18,%esp
 37d:	8b 45 0c             	mov    0xc(%ebp),%eax
 380:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 383:	83 ec 04             	sub    $0x4,%esp
 386:	6a 01                	push   $0x1
 388:	8d 45 f4             	lea    -0xc(%ebp),%eax
 38b:	50                   	push   %eax
 38c:	ff 75 08             	pushl  0x8(%ebp)
 38f:	e8 4b ff ff ff       	call   2df <write>
 394:	83 c4 10             	add    $0x10,%esp
}
 397:	90                   	nop
 398:	c9                   	leave  
 399:	c3                   	ret    

0000039a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 39a:	55                   	push   %ebp
 39b:	89 e5                	mov    %esp,%ebp
 39d:	53                   	push   %ebx
 39e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3a8:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3ac:	74 17                	je     3c5 <printint+0x2b>
 3ae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3b2:	79 11                	jns    3c5 <printint+0x2b>
    neg = 1;
 3b4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3be:	f7 d8                	neg    %eax
 3c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3c3:	eb 06                	jmp    3cb <printint+0x31>
  } else {
    x = xx;
 3c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3d2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3d5:	8d 41 01             	lea    0x1(%ecx),%eax
 3d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3db:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3de:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e1:	ba 00 00 00 00       	mov    $0x0,%edx
 3e6:	f7 f3                	div    %ebx
 3e8:	89 d0                	mov    %edx,%eax
 3ea:	0f b6 80 54 0a 00 00 	movzbl 0xa54(%eax),%eax
 3f1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fb:	ba 00 00 00 00       	mov    $0x0,%edx
 400:	f7 f3                	div    %ebx
 402:	89 45 ec             	mov    %eax,-0x14(%ebp)
 405:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 409:	75 c7                	jne    3d2 <printint+0x38>
  if(neg)
 40b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 40f:	74 2d                	je     43e <printint+0xa4>
    buf[i++] = '-';
 411:	8b 45 f4             	mov    -0xc(%ebp),%eax
 414:	8d 50 01             	lea    0x1(%eax),%edx
 417:	89 55 f4             	mov    %edx,-0xc(%ebp)
 41a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 41f:	eb 1d                	jmp    43e <printint+0xa4>
    putc(fd, buf[i]);
 421:	8d 55 dc             	lea    -0x24(%ebp),%edx
 424:	8b 45 f4             	mov    -0xc(%ebp),%eax
 427:	01 d0                	add    %edx,%eax
 429:	0f b6 00             	movzbl (%eax),%eax
 42c:	0f be c0             	movsbl %al,%eax
 42f:	83 ec 08             	sub    $0x8,%esp
 432:	50                   	push   %eax
 433:	ff 75 08             	pushl  0x8(%ebp)
 436:	e8 3c ff ff ff       	call   377 <putc>
 43b:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 43e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 442:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 446:	79 d9                	jns    421 <printint+0x87>
    putc(fd, buf[i]);
}
 448:	90                   	nop
 449:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 44c:	c9                   	leave  
 44d:	c3                   	ret    

0000044e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 44e:	55                   	push   %ebp
 44f:	89 e5                	mov    %esp,%ebp
 451:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 454:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 45b:	8d 45 0c             	lea    0xc(%ebp),%eax
 45e:	83 c0 04             	add    $0x4,%eax
 461:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 464:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 46b:	e9 59 01 00 00       	jmp    5c9 <printf+0x17b>
    c = fmt[i] & 0xff;
 470:	8b 55 0c             	mov    0xc(%ebp),%edx
 473:	8b 45 f0             	mov    -0x10(%ebp),%eax
 476:	01 d0                	add    %edx,%eax
 478:	0f b6 00             	movzbl (%eax),%eax
 47b:	0f be c0             	movsbl %al,%eax
 47e:	25 ff 00 00 00       	and    $0xff,%eax
 483:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 486:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48a:	75 2c                	jne    4b8 <printf+0x6a>
      if(c == '%'){
 48c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 490:	75 0c                	jne    49e <printf+0x50>
        state = '%';
 492:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 499:	e9 27 01 00 00       	jmp    5c5 <printf+0x177>
      } else {
        putc(fd, c);
 49e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4a1:	0f be c0             	movsbl %al,%eax
 4a4:	83 ec 08             	sub    $0x8,%esp
 4a7:	50                   	push   %eax
 4a8:	ff 75 08             	pushl  0x8(%ebp)
 4ab:	e8 c7 fe ff ff       	call   377 <putc>
 4b0:	83 c4 10             	add    $0x10,%esp
 4b3:	e9 0d 01 00 00       	jmp    5c5 <printf+0x177>
      }
    } else if(state == '%'){
 4b8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4bc:	0f 85 03 01 00 00    	jne    5c5 <printf+0x177>
      if(c == 'd'){
 4c2:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4c6:	75 1e                	jne    4e6 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4cb:	8b 00                	mov    (%eax),%eax
 4cd:	6a 01                	push   $0x1
 4cf:	6a 0a                	push   $0xa
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	e8 c0 fe ff ff       	call   39a <printint>
 4da:	83 c4 10             	add    $0x10,%esp
        ap++;
 4dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e1:	e9 d8 00 00 00       	jmp    5be <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4e6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4ea:	74 06                	je     4f2 <printf+0xa4>
 4ec:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4f0:	75 1e                	jne    510 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4f5:	8b 00                	mov    (%eax),%eax
 4f7:	6a 00                	push   $0x0
 4f9:	6a 10                	push   $0x10
 4fb:	50                   	push   %eax
 4fc:	ff 75 08             	pushl  0x8(%ebp)
 4ff:	e8 96 fe ff ff       	call   39a <printint>
 504:	83 c4 10             	add    $0x10,%esp
        ap++;
 507:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 50b:	e9 ae 00 00 00       	jmp    5be <printf+0x170>
      } else if(c == 's'){
 510:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 514:	75 43                	jne    559 <printf+0x10b>
        s = (char*)*ap;
 516:	8b 45 e8             	mov    -0x18(%ebp),%eax
 519:	8b 00                	mov    (%eax),%eax
 51b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 51e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 522:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 526:	75 25                	jne    54d <printf+0xff>
          s = "(null)";
 528:	c7 45 f4 04 08 00 00 	movl   $0x804,-0xc(%ebp)
        while(*s != 0){
 52f:	eb 1c                	jmp    54d <printf+0xff>
          putc(fd, *s);
 531:	8b 45 f4             	mov    -0xc(%ebp),%eax
 534:	0f b6 00             	movzbl (%eax),%eax
 537:	0f be c0             	movsbl %al,%eax
 53a:	83 ec 08             	sub    $0x8,%esp
 53d:	50                   	push   %eax
 53e:	ff 75 08             	pushl  0x8(%ebp)
 541:	e8 31 fe ff ff       	call   377 <putc>
 546:	83 c4 10             	add    $0x10,%esp
          s++;
 549:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 550:	0f b6 00             	movzbl (%eax),%eax
 553:	84 c0                	test   %al,%al
 555:	75 da                	jne    531 <printf+0xe3>
 557:	eb 65                	jmp    5be <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 559:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 55d:	75 1d                	jne    57c <printf+0x12e>
        putc(fd, *ap);
 55f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 562:	8b 00                	mov    (%eax),%eax
 564:	0f be c0             	movsbl %al,%eax
 567:	83 ec 08             	sub    $0x8,%esp
 56a:	50                   	push   %eax
 56b:	ff 75 08             	pushl  0x8(%ebp)
 56e:	e8 04 fe ff ff       	call   377 <putc>
 573:	83 c4 10             	add    $0x10,%esp
        ap++;
 576:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57a:	eb 42                	jmp    5be <printf+0x170>
      } else if(c == '%'){
 57c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 580:	75 17                	jne    599 <printf+0x14b>
        putc(fd, c);
 582:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 585:	0f be c0             	movsbl %al,%eax
 588:	83 ec 08             	sub    $0x8,%esp
 58b:	50                   	push   %eax
 58c:	ff 75 08             	pushl  0x8(%ebp)
 58f:	e8 e3 fd ff ff       	call   377 <putc>
 594:	83 c4 10             	add    $0x10,%esp
 597:	eb 25                	jmp    5be <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 599:	83 ec 08             	sub    $0x8,%esp
 59c:	6a 25                	push   $0x25
 59e:	ff 75 08             	pushl  0x8(%ebp)
 5a1:	e8 d1 fd ff ff       	call   377 <putc>
 5a6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ac:	0f be c0             	movsbl %al,%eax
 5af:	83 ec 08             	sub    $0x8,%esp
 5b2:	50                   	push   %eax
 5b3:	ff 75 08             	pushl  0x8(%ebp)
 5b6:	e8 bc fd ff ff       	call   377 <putc>
 5bb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5c5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c9:	8b 55 0c             	mov    0xc(%ebp),%edx
 5cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5cf:	01 d0                	add    %edx,%eax
 5d1:	0f b6 00             	movzbl (%eax),%eax
 5d4:	84 c0                	test   %al,%al
 5d6:	0f 85 94 fe ff ff    	jne    470 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5dc:	90                   	nop
 5dd:	c9                   	leave  
 5de:	c3                   	ret    

000005df <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5df:	55                   	push   %ebp
 5e0:	89 e5                	mov    %esp,%ebp
 5e2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5e5:	8b 45 08             	mov    0x8(%ebp),%eax
 5e8:	83 e8 08             	sub    $0x8,%eax
 5eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ee:	a1 70 0a 00 00       	mov    0xa70,%eax
 5f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5f6:	eb 24                	jmp    61c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5fb:	8b 00                	mov    (%eax),%eax
 5fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 600:	77 12                	ja     614 <free+0x35>
 602:	8b 45 f8             	mov    -0x8(%ebp),%eax
 605:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 608:	77 24                	ja     62e <free+0x4f>
 60a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60d:	8b 00                	mov    (%eax),%eax
 60f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 612:	77 1a                	ja     62e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 614:	8b 45 fc             	mov    -0x4(%ebp),%eax
 617:	8b 00                	mov    (%eax),%eax
 619:	89 45 fc             	mov    %eax,-0x4(%ebp)
 61c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 622:	76 d4                	jbe    5f8 <free+0x19>
 624:	8b 45 fc             	mov    -0x4(%ebp),%eax
 627:	8b 00                	mov    (%eax),%eax
 629:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62c:	76 ca                	jbe    5f8 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 62e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 631:	8b 40 04             	mov    0x4(%eax),%eax
 634:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 63b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63e:	01 c2                	add    %eax,%edx
 640:	8b 45 fc             	mov    -0x4(%ebp),%eax
 643:	8b 00                	mov    (%eax),%eax
 645:	39 c2                	cmp    %eax,%edx
 647:	75 24                	jne    66d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 649:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64c:	8b 50 04             	mov    0x4(%eax),%edx
 64f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 652:	8b 00                	mov    (%eax),%eax
 654:	8b 40 04             	mov    0x4(%eax),%eax
 657:	01 c2                	add    %eax,%edx
 659:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 65f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 662:	8b 00                	mov    (%eax),%eax
 664:	8b 10                	mov    (%eax),%edx
 666:	8b 45 f8             	mov    -0x8(%ebp),%eax
 669:	89 10                	mov    %edx,(%eax)
 66b:	eb 0a                	jmp    677 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 10                	mov    (%eax),%edx
 672:	8b 45 f8             	mov    -0x8(%ebp),%eax
 675:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	8b 40 04             	mov    0x4(%eax),%eax
 67d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 684:	8b 45 fc             	mov    -0x4(%ebp),%eax
 687:	01 d0                	add    %edx,%eax
 689:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68c:	75 20                	jne    6ae <free+0xcf>
    p->s.size += bp->s.size;
 68e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 691:	8b 50 04             	mov    0x4(%eax),%edx
 694:	8b 45 f8             	mov    -0x8(%ebp),%eax
 697:	8b 40 04             	mov    0x4(%eax),%eax
 69a:	01 c2                	add    %eax,%edx
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a5:	8b 10                	mov    (%eax),%edx
 6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6aa:	89 10                	mov    %edx,(%eax)
 6ac:	eb 08                	jmp    6b6 <free+0xd7>
  } else
    p->s.ptr = bp;
 6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6b4:	89 10                	mov    %edx,(%eax)
  freep = p;
 6b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b9:	a3 70 0a 00 00       	mov    %eax,0xa70
}
 6be:	90                   	nop
 6bf:	c9                   	leave  
 6c0:	c3                   	ret    

000006c1 <morecore>:

static Header*
morecore(uint nu)
{
 6c1:	55                   	push   %ebp
 6c2:	89 e5                	mov    %esp,%ebp
 6c4:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ce:	77 07                	ja     6d7 <morecore+0x16>
    nu = 4096;
 6d0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d7:	8b 45 08             	mov    0x8(%ebp),%eax
 6da:	c1 e0 03             	shl    $0x3,%eax
 6dd:	83 ec 0c             	sub    $0xc,%esp
 6e0:	50                   	push   %eax
 6e1:	e8 61 fc ff ff       	call   347 <sbrk>
 6e6:	83 c4 10             	add    $0x10,%esp
 6e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6ec:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6f0:	75 07                	jne    6f9 <morecore+0x38>
    return 0;
 6f2:	b8 00 00 00 00       	mov    $0x0,%eax
 6f7:	eb 26                	jmp    71f <morecore+0x5e>
  hp = (Header*)p;
 6f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 702:	8b 55 08             	mov    0x8(%ebp),%edx
 705:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 708:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70b:	83 c0 08             	add    $0x8,%eax
 70e:	83 ec 0c             	sub    $0xc,%esp
 711:	50                   	push   %eax
 712:	e8 c8 fe ff ff       	call   5df <free>
 717:	83 c4 10             	add    $0x10,%esp
  return freep;
 71a:	a1 70 0a 00 00       	mov    0xa70,%eax
}
 71f:	c9                   	leave  
 720:	c3                   	ret    

00000721 <malloc>:

void*
malloc(uint nbytes)
{
 721:	55                   	push   %ebp
 722:	89 e5                	mov    %esp,%ebp
 724:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 727:	8b 45 08             	mov    0x8(%ebp),%eax
 72a:	83 c0 07             	add    $0x7,%eax
 72d:	c1 e8 03             	shr    $0x3,%eax
 730:	83 c0 01             	add    $0x1,%eax
 733:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 736:	a1 70 0a 00 00       	mov    0xa70,%eax
 73b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 73e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 742:	75 23                	jne    767 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 744:	c7 45 f0 68 0a 00 00 	movl   $0xa68,-0x10(%ebp)
 74b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74e:	a3 70 0a 00 00       	mov    %eax,0xa70
 753:	a1 70 0a 00 00       	mov    0xa70,%eax
 758:	a3 68 0a 00 00       	mov    %eax,0xa68
    base.s.size = 0;
 75d:	c7 05 6c 0a 00 00 00 	movl   $0x0,0xa6c
 764:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	8b 00                	mov    (%eax),%eax
 76c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 76f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 772:	8b 40 04             	mov    0x4(%eax),%eax
 775:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 778:	72 4d                	jb     7c7 <malloc+0xa6>
      if(p->s.size == nunits)
 77a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77d:	8b 40 04             	mov    0x4(%eax),%eax
 780:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 783:	75 0c                	jne    791 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 785:	8b 45 f4             	mov    -0xc(%ebp),%eax
 788:	8b 10                	mov    (%eax),%edx
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	89 10                	mov    %edx,(%eax)
 78f:	eb 26                	jmp    7b7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 791:	8b 45 f4             	mov    -0xc(%ebp),%eax
 794:	8b 40 04             	mov    0x4(%eax),%eax
 797:	2b 45 ec             	sub    -0x14(%ebp),%eax
 79a:	89 c2                	mov    %eax,%edx
 79c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a5:	8b 40 04             	mov    0x4(%eax),%eax
 7a8:	c1 e0 03             	shl    $0x3,%eax
 7ab:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7b4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ba:	a3 70 0a 00 00       	mov    %eax,0xa70
      return (void*)(p + 1);
 7bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c2:	83 c0 08             	add    $0x8,%eax
 7c5:	eb 3b                	jmp    802 <malloc+0xe1>
    }
    if(p == freep)
 7c7:	a1 70 0a 00 00       	mov    0xa70,%eax
 7cc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7cf:	75 1e                	jne    7ef <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7d1:	83 ec 0c             	sub    $0xc,%esp
 7d4:	ff 75 ec             	pushl  -0x14(%ebp)
 7d7:	e8 e5 fe ff ff       	call   6c1 <morecore>
 7dc:	83 c4 10             	add    $0x10,%esp
 7df:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7e6:	75 07                	jne    7ef <malloc+0xce>
        return 0;
 7e8:	b8 00 00 00 00       	mov    $0x0,%eax
 7ed:	eb 13                	jmp    802 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7fd:	e9 6d ff ff ff       	jmp    76f <malloc+0x4e>
}
 802:	c9                   	leave  
 803:	c3                   	ret    
