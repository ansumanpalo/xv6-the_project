
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

0000036f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 36f:	55                   	push   %ebp
 370:	89 e5                	mov    %esp,%ebp
 372:	83 ec 18             	sub    $0x18,%esp
 375:	8b 45 0c             	mov    0xc(%ebp),%eax
 378:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 37b:	83 ec 04             	sub    $0x4,%esp
 37e:	6a 01                	push   $0x1
 380:	8d 45 f4             	lea    -0xc(%ebp),%eax
 383:	50                   	push   %eax
 384:	ff 75 08             	pushl  0x8(%ebp)
 387:	e8 53 ff ff ff       	call   2df <write>
 38c:	83 c4 10             	add    $0x10,%esp
}
 38f:	90                   	nop
 390:	c9                   	leave  
 391:	c3                   	ret    

00000392 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 392:	55                   	push   %ebp
 393:	89 e5                	mov    %esp,%ebp
 395:	53                   	push   %ebx
 396:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 399:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3a0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3a4:	74 17                	je     3bd <printint+0x2b>
 3a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3aa:	79 11                	jns    3bd <printint+0x2b>
    neg = 1;
 3ac:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b6:	f7 d8                	neg    %eax
 3b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3bb:	eb 06                	jmp    3c3 <printint+0x31>
  } else {
    x = xx;
 3bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ca:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3cd:	8d 41 01             	lea    0x1(%ecx),%eax
 3d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3d3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d9:	ba 00 00 00 00       	mov    $0x0,%edx
 3de:	f7 f3                	div    %ebx
 3e0:	89 d0                	mov    %edx,%eax
 3e2:	0f b6 80 4c 0a 00 00 	movzbl 0xa4c(%eax),%eax
 3e9:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 3ed:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f3:	ba 00 00 00 00       	mov    $0x0,%edx
 3f8:	f7 f3                	div    %ebx
 3fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 401:	75 c7                	jne    3ca <printint+0x38>
  if(neg)
 403:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 407:	74 2d                	je     436 <printint+0xa4>
    buf[i++] = '-';
 409:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40c:	8d 50 01             	lea    0x1(%eax),%edx
 40f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 412:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 417:	eb 1d                	jmp    436 <printint+0xa4>
    putc(fd, buf[i]);
 419:	8d 55 dc             	lea    -0x24(%ebp),%edx
 41c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 41f:	01 d0                	add    %edx,%eax
 421:	0f b6 00             	movzbl (%eax),%eax
 424:	0f be c0             	movsbl %al,%eax
 427:	83 ec 08             	sub    $0x8,%esp
 42a:	50                   	push   %eax
 42b:	ff 75 08             	pushl  0x8(%ebp)
 42e:	e8 3c ff ff ff       	call   36f <putc>
 433:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 436:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 43a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 43e:	79 d9                	jns    419 <printint+0x87>
    putc(fd, buf[i]);
}
 440:	90                   	nop
 441:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 444:	c9                   	leave  
 445:	c3                   	ret    

00000446 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 446:	55                   	push   %ebp
 447:	89 e5                	mov    %esp,%ebp
 449:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 44c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 453:	8d 45 0c             	lea    0xc(%ebp),%eax
 456:	83 c0 04             	add    $0x4,%eax
 459:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 45c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 463:	e9 59 01 00 00       	jmp    5c1 <printf+0x17b>
    c = fmt[i] & 0xff;
 468:	8b 55 0c             	mov    0xc(%ebp),%edx
 46b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 46e:	01 d0                	add    %edx,%eax
 470:	0f b6 00             	movzbl (%eax),%eax
 473:	0f be c0             	movsbl %al,%eax
 476:	25 ff 00 00 00       	and    $0xff,%eax
 47b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 47e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 482:	75 2c                	jne    4b0 <printf+0x6a>
      if(c == '%'){
 484:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 488:	75 0c                	jne    496 <printf+0x50>
        state = '%';
 48a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 491:	e9 27 01 00 00       	jmp    5bd <printf+0x177>
      } else {
        putc(fd, c);
 496:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 499:	0f be c0             	movsbl %al,%eax
 49c:	83 ec 08             	sub    $0x8,%esp
 49f:	50                   	push   %eax
 4a0:	ff 75 08             	pushl  0x8(%ebp)
 4a3:	e8 c7 fe ff ff       	call   36f <putc>
 4a8:	83 c4 10             	add    $0x10,%esp
 4ab:	e9 0d 01 00 00       	jmp    5bd <printf+0x177>
      }
    } else if(state == '%'){
 4b0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4b4:	0f 85 03 01 00 00    	jne    5bd <printf+0x177>
      if(c == 'd'){
 4ba:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4be:	75 1e                	jne    4de <printf+0x98>
        printint(fd, *ap, 10, 1);
 4c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c3:	8b 00                	mov    (%eax),%eax
 4c5:	6a 01                	push   $0x1
 4c7:	6a 0a                	push   $0xa
 4c9:	50                   	push   %eax
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 c0 fe ff ff       	call   392 <printint>
 4d2:	83 c4 10             	add    $0x10,%esp
        ap++;
 4d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d9:	e9 d8 00 00 00       	jmp    5b6 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4de:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4e2:	74 06                	je     4ea <printf+0xa4>
 4e4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e8:	75 1e                	jne    508 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ed:	8b 00                	mov    (%eax),%eax
 4ef:	6a 00                	push   $0x0
 4f1:	6a 10                	push   $0x10
 4f3:	50                   	push   %eax
 4f4:	ff 75 08             	pushl  0x8(%ebp)
 4f7:	e8 96 fe ff ff       	call   392 <printint>
 4fc:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 503:	e9 ae 00 00 00       	jmp    5b6 <printf+0x170>
      } else if(c == 's'){
 508:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 50c:	75 43                	jne    551 <printf+0x10b>
        s = (char*)*ap;
 50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 511:	8b 00                	mov    (%eax),%eax
 513:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 516:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 51a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 51e:	75 25                	jne    545 <printf+0xff>
          s = "(null)";
 520:	c7 45 f4 fc 07 00 00 	movl   $0x7fc,-0xc(%ebp)
        while(*s != 0){
 527:	eb 1c                	jmp    545 <printf+0xff>
          putc(fd, *s);
 529:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52c:	0f b6 00             	movzbl (%eax),%eax
 52f:	0f be c0             	movsbl %al,%eax
 532:	83 ec 08             	sub    $0x8,%esp
 535:	50                   	push   %eax
 536:	ff 75 08             	pushl  0x8(%ebp)
 539:	e8 31 fe ff ff       	call   36f <putc>
 53e:	83 c4 10             	add    $0x10,%esp
          s++;
 541:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 545:	8b 45 f4             	mov    -0xc(%ebp),%eax
 548:	0f b6 00             	movzbl (%eax),%eax
 54b:	84 c0                	test   %al,%al
 54d:	75 da                	jne    529 <printf+0xe3>
 54f:	eb 65                	jmp    5b6 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 551:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 555:	75 1d                	jne    574 <printf+0x12e>
        putc(fd, *ap);
 557:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55a:	8b 00                	mov    (%eax),%eax
 55c:	0f be c0             	movsbl %al,%eax
 55f:	83 ec 08             	sub    $0x8,%esp
 562:	50                   	push   %eax
 563:	ff 75 08             	pushl  0x8(%ebp)
 566:	e8 04 fe ff ff       	call   36f <putc>
 56b:	83 c4 10             	add    $0x10,%esp
        ap++;
 56e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 572:	eb 42                	jmp    5b6 <printf+0x170>
      } else if(c == '%'){
 574:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 578:	75 17                	jne    591 <printf+0x14b>
        putc(fd, c);
 57a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57d:	0f be c0             	movsbl %al,%eax
 580:	83 ec 08             	sub    $0x8,%esp
 583:	50                   	push   %eax
 584:	ff 75 08             	pushl  0x8(%ebp)
 587:	e8 e3 fd ff ff       	call   36f <putc>
 58c:	83 c4 10             	add    $0x10,%esp
 58f:	eb 25                	jmp    5b6 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 591:	83 ec 08             	sub    $0x8,%esp
 594:	6a 25                	push   $0x25
 596:	ff 75 08             	pushl  0x8(%ebp)
 599:	e8 d1 fd ff ff       	call   36f <putc>
 59e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a4:	0f be c0             	movsbl %al,%eax
 5a7:	83 ec 08             	sub    $0x8,%esp
 5aa:	50                   	push   %eax
 5ab:	ff 75 08             	pushl  0x8(%ebp)
 5ae:	e8 bc fd ff ff       	call   36f <putc>
 5b3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5bd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c7:	01 d0                	add    %edx,%eax
 5c9:	0f b6 00             	movzbl (%eax),%eax
 5cc:	84 c0                	test   %al,%al
 5ce:	0f 85 94 fe ff ff    	jne    468 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5d4:	90                   	nop
 5d5:	c9                   	leave  
 5d6:	c3                   	ret    

000005d7 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d7:	55                   	push   %ebp
 5d8:	89 e5                	mov    %esp,%ebp
 5da:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	83 e8 08             	sub    $0x8,%eax
 5e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e6:	a1 68 0a 00 00       	mov    0xa68,%eax
 5eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ee:	eb 24                	jmp    614 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f3:	8b 00                	mov    (%eax),%eax
 5f5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 5f8:	77 12                	ja     60c <free+0x35>
 5fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 600:	77 24                	ja     626 <free+0x4f>
 602:	8b 45 fc             	mov    -0x4(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 60a:	77 1a                	ja     626 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 60f:	8b 00                	mov    (%eax),%eax
 611:	89 45 fc             	mov    %eax,-0x4(%ebp)
 614:	8b 45 f8             	mov    -0x8(%ebp),%eax
 617:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61a:	76 d4                	jbe    5f0 <free+0x19>
 61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61f:	8b 00                	mov    (%eax),%eax
 621:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 624:	76 ca                	jbe    5f0 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	8b 40 04             	mov    0x4(%eax),%eax
 62c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 633:	8b 45 f8             	mov    -0x8(%ebp),%eax
 636:	01 c2                	add    %eax,%edx
 638:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63b:	8b 00                	mov    (%eax),%eax
 63d:	39 c2                	cmp    %eax,%edx
 63f:	75 24                	jne    665 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 641:	8b 45 f8             	mov    -0x8(%ebp),%eax
 644:	8b 50 04             	mov    0x4(%eax),%edx
 647:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64a:	8b 00                	mov    (%eax),%eax
 64c:	8b 40 04             	mov    0x4(%eax),%eax
 64f:	01 c2                	add    %eax,%edx
 651:	8b 45 f8             	mov    -0x8(%ebp),%eax
 654:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 657:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65a:	8b 00                	mov    (%eax),%eax
 65c:	8b 10                	mov    (%eax),%edx
 65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 661:	89 10                	mov    %edx,(%eax)
 663:	eb 0a                	jmp    66f <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 10                	mov    (%eax),%edx
 66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 40 04             	mov    0x4(%eax),%eax
 675:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 67c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67f:	01 d0                	add    %edx,%eax
 681:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 684:	75 20                	jne    6a6 <free+0xcf>
    p->s.size += bp->s.size;
 686:	8b 45 fc             	mov    -0x4(%ebp),%eax
 689:	8b 50 04             	mov    0x4(%eax),%edx
 68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68f:	8b 40 04             	mov    0x4(%eax),%eax
 692:	01 c2                	add    %eax,%edx
 694:	8b 45 fc             	mov    -0x4(%ebp),%eax
 697:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 69a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69d:	8b 10                	mov    (%eax),%edx
 69f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a2:	89 10                	mov    %edx,(%eax)
 6a4:	eb 08                	jmp    6ae <free+0xd7>
  } else
    p->s.ptr = bp;
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ac:	89 10                	mov    %edx,(%eax)
  freep = p;
 6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b1:	a3 68 0a 00 00       	mov    %eax,0xa68
}
 6b6:	90                   	nop
 6b7:	c9                   	leave  
 6b8:	c3                   	ret    

000006b9 <morecore>:

static Header*
morecore(uint nu)
{
 6b9:	55                   	push   %ebp
 6ba:	89 e5                	mov    %esp,%ebp
 6bc:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6bf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6c6:	77 07                	ja     6cf <morecore+0x16>
    nu = 4096;
 6c8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6cf:	8b 45 08             	mov    0x8(%ebp),%eax
 6d2:	c1 e0 03             	shl    $0x3,%eax
 6d5:	83 ec 0c             	sub    $0xc,%esp
 6d8:	50                   	push   %eax
 6d9:	e8 69 fc ff ff       	call   347 <sbrk>
 6de:	83 c4 10             	add    $0x10,%esp
 6e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6e4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6e8:	75 07                	jne    6f1 <morecore+0x38>
    return 0;
 6ea:	b8 00 00 00 00       	mov    $0x0,%eax
 6ef:	eb 26                	jmp    717 <morecore+0x5e>
  hp = (Header*)p;
 6f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fa:	8b 55 08             	mov    0x8(%ebp),%edx
 6fd:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 700:	8b 45 f0             	mov    -0x10(%ebp),%eax
 703:	83 c0 08             	add    $0x8,%eax
 706:	83 ec 0c             	sub    $0xc,%esp
 709:	50                   	push   %eax
 70a:	e8 c8 fe ff ff       	call   5d7 <free>
 70f:	83 c4 10             	add    $0x10,%esp
  return freep;
 712:	a1 68 0a 00 00       	mov    0xa68,%eax
}
 717:	c9                   	leave  
 718:	c3                   	ret    

00000719 <malloc>:

void*
malloc(uint nbytes)
{
 719:	55                   	push   %ebp
 71a:	89 e5                	mov    %esp,%ebp
 71c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 71f:	8b 45 08             	mov    0x8(%ebp),%eax
 722:	83 c0 07             	add    $0x7,%eax
 725:	c1 e8 03             	shr    $0x3,%eax
 728:	83 c0 01             	add    $0x1,%eax
 72b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 72e:	a1 68 0a 00 00       	mov    0xa68,%eax
 733:	89 45 f0             	mov    %eax,-0x10(%ebp)
 736:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 73a:	75 23                	jne    75f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 73c:	c7 45 f0 60 0a 00 00 	movl   $0xa60,-0x10(%ebp)
 743:	8b 45 f0             	mov    -0x10(%ebp),%eax
 746:	a3 68 0a 00 00       	mov    %eax,0xa68
 74b:	a1 68 0a 00 00       	mov    0xa68,%eax
 750:	a3 60 0a 00 00       	mov    %eax,0xa60
    base.s.size = 0;
 755:	c7 05 64 0a 00 00 00 	movl   $0x0,0xa64
 75c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 75f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 762:	8b 00                	mov    (%eax),%eax
 764:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 767:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76a:	8b 40 04             	mov    0x4(%eax),%eax
 76d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 770:	72 4d                	jb     7bf <malloc+0xa6>
      if(p->s.size == nunits)
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	8b 40 04             	mov    0x4(%eax),%eax
 778:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 77b:	75 0c                	jne    789 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 77d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 780:	8b 10                	mov    (%eax),%edx
 782:	8b 45 f0             	mov    -0x10(%ebp),%eax
 785:	89 10                	mov    %edx,(%eax)
 787:	eb 26                	jmp    7af <malloc+0x96>
      else {
        p->s.size -= nunits;
 789:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78c:	8b 40 04             	mov    0x4(%eax),%eax
 78f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 792:	89 c2                	mov    %eax,%edx
 794:	8b 45 f4             	mov    -0xc(%ebp),%eax
 797:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	8b 40 04             	mov    0x4(%eax),%eax
 7a0:	c1 e0 03             	shl    $0x3,%eax
 7a3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ac:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b2:	a3 68 0a 00 00       	mov    %eax,0xa68
      return (void*)(p + 1);
 7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ba:	83 c0 08             	add    $0x8,%eax
 7bd:	eb 3b                	jmp    7fa <malloc+0xe1>
    }
    if(p == freep)
 7bf:	a1 68 0a 00 00       	mov    0xa68,%eax
 7c4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c7:	75 1e                	jne    7e7 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7c9:	83 ec 0c             	sub    $0xc,%esp
 7cc:	ff 75 ec             	pushl  -0x14(%ebp)
 7cf:	e8 e5 fe ff ff       	call   6b9 <morecore>
 7d4:	83 c4 10             	add    $0x10,%esp
 7d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7de:	75 07                	jne    7e7 <malloc+0xce>
        return 0;
 7e0:	b8 00 00 00 00       	mov    $0x0,%eax
 7e5:	eb 13                	jmp    7fa <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f0:	8b 00                	mov    (%eax),%eax
 7f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 7f5:	e9 6d ff ff ff       	jmp    767 <malloc+0x4e>
}
 7fa:	c9                   	leave  
 7fb:	c3                   	ret    
