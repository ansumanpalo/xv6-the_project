
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
  19:	e8 c5 02 00 00       	call   2e3 <exit>
  }
  printf(1, "Hello ");
  1e:	83 ec 08             	sub    $0x8,%esp
  21:	68 20 08 00 00       	push   $0x820
  26:	6a 01                	push   $0x1
  28:	e8 3d 04 00 00       	call   46a <printf>
  2d:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i<argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 35                	jmp    6e <main+0x6e>
    printf(1, argv[i]);
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 08             	sub    $0x8,%esp
  4d:	50                   	push   %eax
  4e:	6a 01                	push   $0x1
  50:	e8 15 04 00 00       	call   46a <printf>
  55:	83 c4 10             	add    $0x10,%esp
    printf(1, " ");
  58:	83 ec 08             	sub    $0x8,%esp
  5b:	68 27 08 00 00       	push   $0x827
  60:	6a 01                	push   $0x1
  62:	e8 03 04 00 00       	call   46a <printf>
  67:	83 c4 10             	add    $0x10,%esp
    int i;
  if(argc < 1){
    exit();
  }
  printf(1, "Hello ");
  for(i = 1; i<argc; i++){
  6a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  71:	3b 03                	cmp    (%ebx),%eax
  73:	7c c4                	jl     39 <main+0x39>
    printf(1, argv[i]);
    printf(1, " ");
  }
  printf(1, "\n");
  75:	83 ec 08             	sub    $0x8,%esp
  78:	68 29 08 00 00       	push   $0x829
  7d:	6a 01                	push   $0x1
  7f:	e8 e6 03 00 00       	call   46a <printf>
  84:	83 c4 10             	add    $0x10,%esp
  exit();
  87:	e8 57 02 00 00       	call   2e3 <exit>

0000008c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	57                   	push   %edi
  90:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  91:	8b 4d 08             	mov    0x8(%ebp),%ecx
  94:	8b 55 10             	mov    0x10(%ebp),%edx
  97:	8b 45 0c             	mov    0xc(%ebp),%eax
  9a:	89 cb                	mov    %ecx,%ebx
  9c:	89 df                	mov    %ebx,%edi
  9e:	89 d1                	mov    %edx,%ecx
  a0:	fc                   	cld    
  a1:	f3 aa                	rep stos %al,%es:(%edi)
  a3:	89 ca                	mov    %ecx,%edx
  a5:	89 fb                	mov    %edi,%ebx
  a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  aa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  ad:	90                   	nop
  ae:	5b                   	pop    %ebx
  af:	5f                   	pop    %edi
  b0:	5d                   	pop    %ebp
  b1:	c3                   	ret    

000000b2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b2:	55                   	push   %ebp
  b3:	89 e5                	mov    %esp,%ebp
  b5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  b8:	8b 45 08             	mov    0x8(%ebp),%eax
  bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  be:	90                   	nop
  bf:	8b 45 08             	mov    0x8(%ebp),%eax
  c2:	8d 50 01             	lea    0x1(%eax),%edx
  c5:	89 55 08             	mov    %edx,0x8(%ebp)
  c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  cb:	8d 4a 01             	lea    0x1(%edx),%ecx
  ce:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d1:	0f b6 12             	movzbl (%edx),%edx
  d4:	88 10                	mov    %dl,(%eax)
  d6:	0f b6 00             	movzbl (%eax),%eax
  d9:	84 c0                	test   %al,%al
  db:	75 e2                	jne    bf <strcpy+0xd>
    ;
  return os;
  dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e0:	c9                   	leave  
  e1:	c3                   	ret    

000000e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e5:	eb 08                	jmp    ef <strcmp+0xd>
    p++, q++;
  e7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  eb:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ef:	8b 45 08             	mov    0x8(%ebp),%eax
  f2:	0f b6 00             	movzbl (%eax),%eax
  f5:	84 c0                	test   %al,%al
  f7:	74 10                	je     109 <strcmp+0x27>
  f9:	8b 45 08             	mov    0x8(%ebp),%eax
  fc:	0f b6 10             	movzbl (%eax),%edx
  ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 102:	0f b6 00             	movzbl (%eax),%eax
 105:	38 c2                	cmp    %al,%dl
 107:	74 de                	je     e7 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 109:	8b 45 08             	mov    0x8(%ebp),%eax
 10c:	0f b6 00             	movzbl (%eax),%eax
 10f:	0f b6 d0             	movzbl %al,%edx
 112:	8b 45 0c             	mov    0xc(%ebp),%eax
 115:	0f b6 00             	movzbl (%eax),%eax
 118:	0f b6 c0             	movzbl %al,%eax
 11b:	29 c2                	sub    %eax,%edx
 11d:	89 d0                	mov    %edx,%eax
}
 11f:	5d                   	pop    %ebp
 120:	c3                   	ret    

00000121 <strlen>:

uint
strlen(char *s)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
 124:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 127:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 12e:	eb 04                	jmp    134 <strlen+0x13>
 130:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 134:	8b 55 fc             	mov    -0x4(%ebp),%edx
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	01 d0                	add    %edx,%eax
 13c:	0f b6 00             	movzbl (%eax),%eax
 13f:	84 c0                	test   %al,%al
 141:	75 ed                	jne    130 <strlen+0xf>
    ;
  return n;
 143:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 146:	c9                   	leave  
 147:	c3                   	ret    

00000148 <memset>:

void*
memset(void *dst, int c, uint n)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 14b:	8b 45 10             	mov    0x10(%ebp),%eax
 14e:	50                   	push   %eax
 14f:	ff 75 0c             	pushl  0xc(%ebp)
 152:	ff 75 08             	pushl  0x8(%ebp)
 155:	e8 32 ff ff ff       	call   8c <stosb>
 15a:	83 c4 0c             	add    $0xc,%esp
  return dst;
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 160:	c9                   	leave  
 161:	c3                   	ret    

00000162 <strchr>:

char*
strchr(const char *s, char c)
{
 162:	55                   	push   %ebp
 163:	89 e5                	mov    %esp,%ebp
 165:	83 ec 04             	sub    $0x4,%esp
 168:	8b 45 0c             	mov    0xc(%ebp),%eax
 16b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16e:	eb 14                	jmp    184 <strchr+0x22>
    if(*s == c)
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	0f b6 00             	movzbl (%eax),%eax
 176:	3a 45 fc             	cmp    -0x4(%ebp),%al
 179:	75 05                	jne    180 <strchr+0x1e>
      return (char*)s;
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	eb 13                	jmp    193 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 180:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 00             	movzbl (%eax),%eax
 18a:	84 c0                	test   %al,%al
 18c:	75 e2                	jne    170 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 18e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 193:	c9                   	leave  
 194:	c3                   	ret    

00000195 <gets>:

char*
gets(char *buf, int max)
{
 195:	55                   	push   %ebp
 196:	89 e5                	mov    %esp,%ebp
 198:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a2:	eb 42                	jmp    1e6 <gets+0x51>
    cc = read(0, &c, 1);
 1a4:	83 ec 04             	sub    $0x4,%esp
 1a7:	6a 01                	push   $0x1
 1a9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ac:	50                   	push   %eax
 1ad:	6a 00                	push   $0x0
 1af:	e8 47 01 00 00       	call   2fb <read>
 1b4:	83 c4 10             	add    $0x10,%esp
 1b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1be:	7e 33                	jle    1f3 <gets+0x5e>
      break;
    buf[i++] = c;
 1c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c3:	8d 50 01             	lea    0x1(%eax),%edx
 1c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1c9:	89 c2                	mov    %eax,%edx
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	01 c2                	add    %eax,%edx
 1d0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1da:	3c 0a                	cmp    $0xa,%al
 1dc:	74 16                	je     1f4 <gets+0x5f>
 1de:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e2:	3c 0d                	cmp    $0xd,%al
 1e4:	74 0e                	je     1f4 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e9:	83 c0 01             	add    $0x1,%eax
 1ec:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1ef:	7c b3                	jl     1a4 <gets+0xf>
 1f1:	eb 01                	jmp    1f4 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1f3:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	01 d0                	add    %edx,%eax
 1fc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
 202:	c9                   	leave  
 203:	c3                   	ret    

00000204 <stat>:

int
stat(char *n, struct stat *st)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20a:	83 ec 08             	sub    $0x8,%esp
 20d:	6a 00                	push   $0x0
 20f:	ff 75 08             	pushl  0x8(%ebp)
 212:	e8 0c 01 00 00       	call   323 <open>
 217:	83 c4 10             	add    $0x10,%esp
 21a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 21d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 221:	79 07                	jns    22a <stat+0x26>
    return -1;
 223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 228:	eb 25                	jmp    24f <stat+0x4b>
  r = fstat(fd, st);
 22a:	83 ec 08             	sub    $0x8,%esp
 22d:	ff 75 0c             	pushl  0xc(%ebp)
 230:	ff 75 f4             	pushl  -0xc(%ebp)
 233:	e8 03 01 00 00       	call   33b <fstat>
 238:	83 c4 10             	add    $0x10,%esp
 23b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 23e:	83 ec 0c             	sub    $0xc,%esp
 241:	ff 75 f4             	pushl  -0xc(%ebp)
 244:	e8 c2 00 00 00       	call   30b <close>
 249:	83 c4 10             	add    $0x10,%esp
  return r;
 24c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 24f:	c9                   	leave  
 250:	c3                   	ret    

00000251 <atoi>:

int
atoi(const char *s)
{
 251:	55                   	push   %ebp
 252:	89 e5                	mov    %esp,%ebp
 254:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 25e:	eb 25                	jmp    285 <atoi+0x34>
    n = n*10 + *s++ - '0';
 260:	8b 55 fc             	mov    -0x4(%ebp),%edx
 263:	89 d0                	mov    %edx,%eax
 265:	c1 e0 02             	shl    $0x2,%eax
 268:	01 d0                	add    %edx,%eax
 26a:	01 c0                	add    %eax,%eax
 26c:	89 c1                	mov    %eax,%ecx
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	8d 50 01             	lea    0x1(%eax),%edx
 274:	89 55 08             	mov    %edx,0x8(%ebp)
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	0f be c0             	movsbl %al,%eax
 27d:	01 c8                	add    %ecx,%eax
 27f:	83 e8 30             	sub    $0x30,%eax
 282:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 285:	8b 45 08             	mov    0x8(%ebp),%eax
 288:	0f b6 00             	movzbl (%eax),%eax
 28b:	3c 2f                	cmp    $0x2f,%al
 28d:	7e 0a                	jle    299 <atoi+0x48>
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	0f b6 00             	movzbl (%eax),%eax
 295:	3c 39                	cmp    $0x39,%al
 297:	7e c7                	jle    260 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 299:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29c:	c9                   	leave  
 29d:	c3                   	ret    

0000029e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 29e:	55                   	push   %ebp
 29f:	89 e5                	mov    %esp,%ebp
 2a1:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;
  
  dst = vdst;
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b0:	eb 17                	jmp    2c9 <memmove+0x2b>
    *dst++ = *src++;
 2b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2b5:	8d 50 01             	lea    0x1(%eax),%edx
 2b8:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2bb:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2be:	8d 4a 01             	lea    0x1(%edx),%ecx
 2c1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2c4:	0f b6 12             	movzbl (%edx),%edx
 2c7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;
  
  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c9:	8b 45 10             	mov    0x10(%ebp),%eax
 2cc:	8d 50 ff             	lea    -0x1(%eax),%edx
 2cf:	89 55 10             	mov    %edx,0x10(%ebp)
 2d2:	85 c0                	test   %eax,%eax
 2d4:	7f dc                	jg     2b2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d9:	c9                   	leave  
 2da:	c3                   	ret    

000002db <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2db:	b8 01 00 00 00       	mov    $0x1,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <exit>:
SYSCALL(exit)
 2e3:	b8 02 00 00 00       	mov    $0x2,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <wait>:
SYSCALL(wait)
 2eb:	b8 03 00 00 00       	mov    $0x3,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <pipe>:
SYSCALL(pipe)
 2f3:	b8 04 00 00 00       	mov    $0x4,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <read>:
SYSCALL(read)
 2fb:	b8 05 00 00 00       	mov    $0x5,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <write>:
SYSCALL(write)
 303:	b8 10 00 00 00       	mov    $0x10,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <close>:
SYSCALL(close)
 30b:	b8 15 00 00 00       	mov    $0x15,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <kill>:
SYSCALL(kill)
 313:	b8 06 00 00 00       	mov    $0x6,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <exec>:
SYSCALL(exec)
 31b:	b8 07 00 00 00       	mov    $0x7,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <open>:
SYSCALL(open)
 323:	b8 0f 00 00 00       	mov    $0xf,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <mknod>:
SYSCALL(mknod)
 32b:	b8 11 00 00 00       	mov    $0x11,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <unlink>:
SYSCALL(unlink)
 333:	b8 12 00 00 00       	mov    $0x12,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <fstat>:
SYSCALL(fstat)
 33b:	b8 08 00 00 00       	mov    $0x8,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <link>:
SYSCALL(link)
 343:	b8 13 00 00 00       	mov    $0x13,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <mkdir>:
SYSCALL(mkdir)
 34b:	b8 14 00 00 00       	mov    $0x14,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <chdir>:
SYSCALL(chdir)
 353:	b8 09 00 00 00       	mov    $0x9,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <dup>:
SYSCALL(dup)
 35b:	b8 0a 00 00 00       	mov    $0xa,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <getpid>:
SYSCALL(getpid)
 363:	b8 0b 00 00 00       	mov    $0xb,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <sbrk>:
SYSCALL(sbrk)
 36b:	b8 0c 00 00 00       	mov    $0xc,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <sleep>:
SYSCALL(sleep)
 373:	b8 0d 00 00 00       	mov    $0xd,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <uptime>:
SYSCALL(uptime)
 37b:	b8 0e 00 00 00       	mov    $0xe,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <randomX>:
SYSCALL(randomX)
 383:	b8 16 00 00 00       	mov    $0x16,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <setSeedX>:
SYSCALL(setSeedX)
 38b:	b8 17 00 00 00       	mov    $0x17,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 393:	55                   	push   %ebp
 394:	89 e5                	mov    %esp,%ebp
 396:	83 ec 18             	sub    $0x18,%esp
 399:	8b 45 0c             	mov    0xc(%ebp),%eax
 39c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 39f:	83 ec 04             	sub    $0x4,%esp
 3a2:	6a 01                	push   $0x1
 3a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3a7:	50                   	push   %eax
 3a8:	ff 75 08             	pushl  0x8(%ebp)
 3ab:	e8 53 ff ff ff       	call   303 <write>
 3b0:	83 c4 10             	add    $0x10,%esp
}
 3b3:	90                   	nop
 3b4:	c9                   	leave  
 3b5:	c3                   	ret    

000003b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b6:	55                   	push   %ebp
 3b7:	89 e5                	mov    %esp,%ebp
 3b9:	53                   	push   %ebx
 3ba:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3c4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c8:	74 17                	je     3e1 <printint+0x2b>
 3ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3ce:	79 11                	jns    3e1 <printint+0x2b>
    neg = 1;
 3d0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 3da:	f7 d8                	neg    %eax
 3dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3df:	eb 06                	jmp    3e7 <printint+0x31>
  } else {
    x = xx;
 3e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3ee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 3f1:	8d 41 01             	lea    0x1(%ecx),%eax
 3f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 3f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fd:	ba 00 00 00 00       	mov    $0x0,%edx
 402:	f7 f3                	div    %ebx
 404:	89 d0                	mov    %edx,%eax
 406:	0f b6 80 80 0a 00 00 	movzbl 0xa80(%eax),%eax
 40d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 411:	8b 5d 10             	mov    0x10(%ebp),%ebx
 414:	8b 45 ec             	mov    -0x14(%ebp),%eax
 417:	ba 00 00 00 00       	mov    $0x0,%edx
 41c:	f7 f3                	div    %ebx
 41e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 421:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 425:	75 c7                	jne    3ee <printint+0x38>
  if(neg)
 427:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 42b:	74 2d                	je     45a <printint+0xa4>
    buf[i++] = '-';
 42d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 430:	8d 50 01             	lea    0x1(%eax),%edx
 433:	89 55 f4             	mov    %edx,-0xc(%ebp)
 436:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 43b:	eb 1d                	jmp    45a <printint+0xa4>
    putc(fd, buf[i]);
 43d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 440:	8b 45 f4             	mov    -0xc(%ebp),%eax
 443:	01 d0                	add    %edx,%eax
 445:	0f b6 00             	movzbl (%eax),%eax
 448:	0f be c0             	movsbl %al,%eax
 44b:	83 ec 08             	sub    $0x8,%esp
 44e:	50                   	push   %eax
 44f:	ff 75 08             	pushl  0x8(%ebp)
 452:	e8 3c ff ff ff       	call   393 <putc>
 457:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 45a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 45e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 462:	79 d9                	jns    43d <printint+0x87>
    putc(fd, buf[i]);
}
 464:	90                   	nop
 465:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 468:	c9                   	leave  
 469:	c3                   	ret    

0000046a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 46a:	55                   	push   %ebp
 46b:	89 e5                	mov    %esp,%ebp
 46d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 470:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 477:	8d 45 0c             	lea    0xc(%ebp),%eax
 47a:	83 c0 04             	add    $0x4,%eax
 47d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 480:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 487:	e9 59 01 00 00       	jmp    5e5 <printf+0x17b>
    c = fmt[i] & 0xff;
 48c:	8b 55 0c             	mov    0xc(%ebp),%edx
 48f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 492:	01 d0                	add    %edx,%eax
 494:	0f b6 00             	movzbl (%eax),%eax
 497:	0f be c0             	movsbl %al,%eax
 49a:	25 ff 00 00 00       	and    $0xff,%eax
 49f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4a6:	75 2c                	jne    4d4 <printf+0x6a>
      if(c == '%'){
 4a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ac:	75 0c                	jne    4ba <printf+0x50>
        state = '%';
 4ae:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4b5:	e9 27 01 00 00       	jmp    5e1 <printf+0x177>
      } else {
        putc(fd, c);
 4ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4bd:	0f be c0             	movsbl %al,%eax
 4c0:	83 ec 08             	sub    $0x8,%esp
 4c3:	50                   	push   %eax
 4c4:	ff 75 08             	pushl  0x8(%ebp)
 4c7:	e8 c7 fe ff ff       	call   393 <putc>
 4cc:	83 c4 10             	add    $0x10,%esp
 4cf:	e9 0d 01 00 00       	jmp    5e1 <printf+0x177>
      }
    } else if(state == '%'){
 4d4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d8:	0f 85 03 01 00 00    	jne    5e1 <printf+0x177>
      if(c == 'd'){
 4de:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e2:	75 1e                	jne    502 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4e7:	8b 00                	mov    (%eax),%eax
 4e9:	6a 01                	push   $0x1
 4eb:	6a 0a                	push   $0xa
 4ed:	50                   	push   %eax
 4ee:	ff 75 08             	pushl  0x8(%ebp)
 4f1:	e8 c0 fe ff ff       	call   3b6 <printint>
 4f6:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4fd:	e9 d8 00 00 00       	jmp    5da <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 502:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 506:	74 06                	je     50e <printf+0xa4>
 508:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 50c:	75 1e                	jne    52c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 511:	8b 00                	mov    (%eax),%eax
 513:	6a 00                	push   $0x0
 515:	6a 10                	push   $0x10
 517:	50                   	push   %eax
 518:	ff 75 08             	pushl  0x8(%ebp)
 51b:	e8 96 fe ff ff       	call   3b6 <printint>
 520:	83 c4 10             	add    $0x10,%esp
        ap++;
 523:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 527:	e9 ae 00 00 00       	jmp    5da <printf+0x170>
      } else if(c == 's'){
 52c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 530:	75 43                	jne    575 <printf+0x10b>
        s = (char*)*ap;
 532:	8b 45 e8             	mov    -0x18(%ebp),%eax
 535:	8b 00                	mov    (%eax),%eax
 537:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 53a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 53e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 542:	75 25                	jne    569 <printf+0xff>
          s = "(null)";
 544:	c7 45 f4 2b 08 00 00 	movl   $0x82b,-0xc(%ebp)
        while(*s != 0){
 54b:	eb 1c                	jmp    569 <printf+0xff>
          putc(fd, *s);
 54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 550:	0f b6 00             	movzbl (%eax),%eax
 553:	0f be c0             	movsbl %al,%eax
 556:	83 ec 08             	sub    $0x8,%esp
 559:	50                   	push   %eax
 55a:	ff 75 08             	pushl  0x8(%ebp)
 55d:	e8 31 fe ff ff       	call   393 <putc>
 562:	83 c4 10             	add    $0x10,%esp
          s++;
 565:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 569:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56c:	0f b6 00             	movzbl (%eax),%eax
 56f:	84 c0                	test   %al,%al
 571:	75 da                	jne    54d <printf+0xe3>
 573:	eb 65                	jmp    5da <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 575:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 579:	75 1d                	jne    598 <printf+0x12e>
        putc(fd, *ap);
 57b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 57e:	8b 00                	mov    (%eax),%eax
 580:	0f be c0             	movsbl %al,%eax
 583:	83 ec 08             	sub    $0x8,%esp
 586:	50                   	push   %eax
 587:	ff 75 08             	pushl  0x8(%ebp)
 58a:	e8 04 fe ff ff       	call   393 <putc>
 58f:	83 c4 10             	add    $0x10,%esp
        ap++;
 592:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 596:	eb 42                	jmp    5da <printf+0x170>
      } else if(c == '%'){
 598:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 59c:	75 17                	jne    5b5 <printf+0x14b>
        putc(fd, c);
 59e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	83 ec 08             	sub    $0x8,%esp
 5a7:	50                   	push   %eax
 5a8:	ff 75 08             	pushl  0x8(%ebp)
 5ab:	e8 e3 fd ff ff       	call   393 <putc>
 5b0:	83 c4 10             	add    $0x10,%esp
 5b3:	eb 25                	jmp    5da <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5b5:	83 ec 08             	sub    $0x8,%esp
 5b8:	6a 25                	push   $0x25
 5ba:	ff 75 08             	pushl  0x8(%ebp)
 5bd:	e8 d1 fd ff ff       	call   393 <putc>
 5c2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c8:	0f be c0             	movsbl %al,%eax
 5cb:	83 ec 08             	sub    $0x8,%esp
 5ce:	50                   	push   %eax
 5cf:	ff 75 08             	pushl  0x8(%ebp)
 5d2:	e8 bc fd ff ff       	call   393 <putc>
 5d7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5eb:	01 d0                	add    %edx,%eax
 5ed:	0f b6 00             	movzbl (%eax),%eax
 5f0:	84 c0                	test   %al,%al
 5f2:	0f 85 94 fe ff ff    	jne    48c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 5f8:	90                   	nop
 5f9:	c9                   	leave  
 5fa:	c3                   	ret    

000005fb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5fb:	55                   	push   %ebp
 5fc:	89 e5                	mov    %esp,%ebp
 5fe:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 601:	8b 45 08             	mov    0x8(%ebp),%eax
 604:	83 e8 08             	sub    $0x8,%eax
 607:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60a:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 60f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 612:	eb 24                	jmp    638 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 614:	8b 45 fc             	mov    -0x4(%ebp),%eax
 617:	8b 00                	mov    (%eax),%eax
 619:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61c:	77 12                	ja     630 <free+0x35>
 61e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 621:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 624:	77 24                	ja     64a <free+0x4f>
 626:	8b 45 fc             	mov    -0x4(%ebp),%eax
 629:	8b 00                	mov    (%eax),%eax
 62b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 62e:	77 1a                	ja     64a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 630:	8b 45 fc             	mov    -0x4(%ebp),%eax
 633:	8b 00                	mov    (%eax),%eax
 635:	89 45 fc             	mov    %eax,-0x4(%ebp)
 638:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63e:	76 d4                	jbe    614 <free+0x19>
 640:	8b 45 fc             	mov    -0x4(%ebp),%eax
 643:	8b 00                	mov    (%eax),%eax
 645:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 648:	76 ca                	jbe    614 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 64a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 64d:	8b 40 04             	mov    0x4(%eax),%eax
 650:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 657:	8b 45 f8             	mov    -0x8(%ebp),%eax
 65a:	01 c2                	add    %eax,%edx
 65c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65f:	8b 00                	mov    (%eax),%eax
 661:	39 c2                	cmp    %eax,%edx
 663:	75 24                	jne    689 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 665:	8b 45 f8             	mov    -0x8(%ebp),%eax
 668:	8b 50 04             	mov    0x4(%eax),%edx
 66b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66e:	8b 00                	mov    (%eax),%eax
 670:	8b 40 04             	mov    0x4(%eax),%eax
 673:	01 c2                	add    %eax,%edx
 675:	8b 45 f8             	mov    -0x8(%ebp),%eax
 678:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 67b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67e:	8b 00                	mov    (%eax),%eax
 680:	8b 10                	mov    (%eax),%edx
 682:	8b 45 f8             	mov    -0x8(%ebp),%eax
 685:	89 10                	mov    %edx,(%eax)
 687:	eb 0a                	jmp    693 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 10                	mov    (%eax),%edx
 68e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 691:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 693:	8b 45 fc             	mov    -0x4(%ebp),%eax
 696:	8b 40 04             	mov    0x4(%eax),%eax
 699:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a3:	01 d0                	add    %edx,%eax
 6a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a8:	75 20                	jne    6ca <free+0xcf>
    p->s.size += bp->s.size;
 6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ad:	8b 50 04             	mov    0x4(%eax),%edx
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	8b 40 04             	mov    0x4(%eax),%eax
 6b6:	01 c2                	add    %eax,%edx
 6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	8b 10                	mov    (%eax),%edx
 6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c6:	89 10                	mov    %edx,(%eax)
 6c8:	eb 08                	jmp    6d2 <free+0xd7>
  } else
    p->s.ptr = bp;
 6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d0:	89 10                	mov    %edx,(%eax)
  freep = p;
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	a3 9c 0a 00 00       	mov    %eax,0xa9c
}
 6da:	90                   	nop
 6db:	c9                   	leave  
 6dc:	c3                   	ret    

000006dd <morecore>:

static Header*
morecore(uint nu)
{
 6dd:	55                   	push   %ebp
 6de:	89 e5                	mov    %esp,%ebp
 6e0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6e3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6ea:	77 07                	ja     6f3 <morecore+0x16>
    nu = 4096;
 6ec:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6f3:	8b 45 08             	mov    0x8(%ebp),%eax
 6f6:	c1 e0 03             	shl    $0x3,%eax
 6f9:	83 ec 0c             	sub    $0xc,%esp
 6fc:	50                   	push   %eax
 6fd:	e8 69 fc ff ff       	call   36b <sbrk>
 702:	83 c4 10             	add    $0x10,%esp
 705:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 708:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 70c:	75 07                	jne    715 <morecore+0x38>
    return 0;
 70e:	b8 00 00 00 00       	mov    $0x0,%eax
 713:	eb 26                	jmp    73b <morecore+0x5e>
  hp = (Header*)p;
 715:	8b 45 f4             	mov    -0xc(%ebp),%eax
 718:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 71b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 71e:	8b 55 08             	mov    0x8(%ebp),%edx
 721:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 724:	8b 45 f0             	mov    -0x10(%ebp),%eax
 727:	83 c0 08             	add    $0x8,%eax
 72a:	83 ec 0c             	sub    $0xc,%esp
 72d:	50                   	push   %eax
 72e:	e8 c8 fe ff ff       	call   5fb <free>
 733:	83 c4 10             	add    $0x10,%esp
  return freep;
 736:	a1 9c 0a 00 00       	mov    0xa9c,%eax
}
 73b:	c9                   	leave  
 73c:	c3                   	ret    

0000073d <malloc>:

void*
malloc(uint nbytes)
{
 73d:	55                   	push   %ebp
 73e:	89 e5                	mov    %esp,%ebp
 740:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 743:	8b 45 08             	mov    0x8(%ebp),%eax
 746:	83 c0 07             	add    $0x7,%eax
 749:	c1 e8 03             	shr    $0x3,%eax
 74c:	83 c0 01             	add    $0x1,%eax
 74f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 752:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 757:	89 45 f0             	mov    %eax,-0x10(%ebp)
 75a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 75e:	75 23                	jne    783 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 760:	c7 45 f0 94 0a 00 00 	movl   $0xa94,-0x10(%ebp)
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	a3 9c 0a 00 00       	mov    %eax,0xa9c
 76f:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 774:	a3 94 0a 00 00       	mov    %eax,0xa94
    base.s.size = 0;
 779:	c7 05 98 0a 00 00 00 	movl   $0x0,0xa98
 780:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 783:	8b 45 f0             	mov    -0x10(%ebp),%eax
 786:	8b 00                	mov    (%eax),%eax
 788:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 78b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78e:	8b 40 04             	mov    0x4(%eax),%eax
 791:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 794:	72 4d                	jb     7e3 <malloc+0xa6>
      if(p->s.size == nunits)
 796:	8b 45 f4             	mov    -0xc(%ebp),%eax
 799:	8b 40 04             	mov    0x4(%eax),%eax
 79c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 79f:	75 0c                	jne    7ad <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a4:	8b 10                	mov    (%eax),%edx
 7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a9:	89 10                	mov    %edx,(%eax)
 7ab:	eb 26                	jmp    7d3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b0:	8b 40 04             	mov    0x4(%eax),%eax
 7b3:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7b6:	89 c2                	mov    %eax,%edx
 7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c1:	8b 40 04             	mov    0x4(%eax),%eax
 7c4:	c1 e0 03             	shl    $0x3,%eax
 7c7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cd:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7d0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d6:	a3 9c 0a 00 00       	mov    %eax,0xa9c
      return (void*)(p + 1);
 7db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7de:	83 c0 08             	add    $0x8,%eax
 7e1:	eb 3b                	jmp    81e <malloc+0xe1>
    }
    if(p == freep)
 7e3:	a1 9c 0a 00 00       	mov    0xa9c,%eax
 7e8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7eb:	75 1e                	jne    80b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7ed:	83 ec 0c             	sub    $0xc,%esp
 7f0:	ff 75 ec             	pushl  -0x14(%ebp)
 7f3:	e8 e5 fe ff ff       	call   6dd <morecore>
 7f8:	83 c4 10             	add    $0x10,%esp
 7fb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7fe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 802:	75 07                	jne    80b <malloc+0xce>
        return 0;
 804:	b8 00 00 00 00       	mov    $0x0,%eax
 809:	eb 13                	jmp    81e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	8b 00                	mov    (%eax),%eax
 816:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 819:	e9 6d ff ff ff       	jmp    78b <malloc+0x4e>
}
 81e:	c9                   	leave  
 81f:	c3                   	ret    
