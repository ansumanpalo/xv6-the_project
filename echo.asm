
_echo:     file format elf32-i386


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

  for(i = 1; i < argc; i++)
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  20:	83 c0 01             	add    $0x1,%eax
  23:	3b 03                	cmp    (%ebx),%eax
  25:	7d 07                	jge    2e <main+0x2e>
  27:	ba 52 08 00 00       	mov    $0x852,%edx
  2c:	eb 05                	jmp    33 <main+0x33>
  2e:	ba 54 08 00 00       	mov    $0x854,%edx
  33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  3d:	8b 43 04             	mov    0x4(%ebx),%eax
  40:	01 c8                	add    %ecx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	52                   	push   %edx
  45:	50                   	push   %eax
  46:	68 56 08 00 00       	push   $0x856
  4b:	6a 01                	push   $0x1
  4d:	e8 4a 04 00 00       	call   49c <printf>
  52:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
  int i;

  for(i = 1; i < argc; i++)
  55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5c:	3b 03                	cmp    (%ebx),%eax
  5e:	7c bd                	jl     1d <main+0x1d>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  exit();
  60:	e8 a8 02 00 00       	call   30d <exit>

00000065 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  65:	55                   	push   %ebp
  66:	89 e5                	mov    %esp,%ebp
  68:	57                   	push   %edi
  69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6d:	8b 55 10             	mov    0x10(%ebp),%edx
  70:	8b 45 0c             	mov    0xc(%ebp),%eax
  73:	89 cb                	mov    %ecx,%ebx
  75:	89 df                	mov    %ebx,%edi
  77:	89 d1                	mov    %edx,%ecx
  79:	fc                   	cld    
  7a:	f3 aa                	rep stos %al,%es:(%edi)
  7c:	89 ca                	mov    %ecx,%edx
  7e:	89 fb                	mov    %edi,%ebx
  80:	89 5d 08             	mov    %ebx,0x8(%ebp)
  83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  86:	90                   	nop
  87:	5b                   	pop    %ebx
  88:	5f                   	pop    %edi
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    

0000008b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  8b:	55                   	push   %ebp
  8c:	89 e5                	mov    %esp,%ebp
  8e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  91:	8b 45 08             	mov    0x8(%ebp),%eax
  94:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  97:	90                   	nop
  98:	8b 45 08             	mov    0x8(%ebp),%eax
  9b:	8d 50 01             	lea    0x1(%eax),%edx
  9e:	89 55 08             	mov    %edx,0x8(%ebp)
  a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  a4:	8d 4a 01             	lea    0x1(%edx),%ecx
  a7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  aa:	0f b6 12             	movzbl (%edx),%edx
  ad:	88 10                	mov    %dl,(%eax)
  af:	0f b6 00             	movzbl (%eax),%eax
  b2:	84 c0                	test   %al,%al
  b4:	75 e2                	jne    98 <strcpy+0xd>
    ;
  return os;
  b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b9:	c9                   	leave  
  ba:	c3                   	ret    

000000bb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bb:	55                   	push   %ebp
  bc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  be:	eb 08                	jmp    c8 <strcmp+0xd>
    p++, q++;
  c0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	0f b6 00             	movzbl (%eax),%eax
  ce:	84 c0                	test   %al,%al
  d0:	74 10                	je     e2 <strcmp+0x27>
  d2:	8b 45 08             	mov    0x8(%ebp),%eax
  d5:	0f b6 10             	movzbl (%eax),%edx
  d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  db:	0f b6 00             	movzbl (%eax),%eax
  de:	38 c2                	cmp    %al,%dl
  e0:	74 de                	je     c0 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	0f b6 00             	movzbl (%eax),%eax
  e8:	0f b6 d0             	movzbl %al,%edx
  eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ee:	0f b6 00             	movzbl (%eax),%eax
  f1:	0f b6 c0             	movzbl %al,%eax
  f4:	29 c2                	sub    %eax,%edx
  f6:	89 d0                	mov    %edx,%eax
}
  f8:	5d                   	pop    %ebp
  f9:	c3                   	ret    

000000fa <strlen>:

uint
strlen(char *s)
{
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 107:	eb 04                	jmp    10d <strlen+0x13>
 109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	01 d0                	add    %edx,%eax
 115:	0f b6 00             	movzbl (%eax),%eax
 118:	84 c0                	test   %al,%al
 11a:	75 ed                	jne    109 <strlen+0xf>
    ;
  return n;
 11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11f:	c9                   	leave  
 120:	c3                   	ret    

00000121 <memset>:

void*
memset(void *dst, int c, uint n)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 124:	8b 45 10             	mov    0x10(%ebp),%eax
 127:	50                   	push   %eax
 128:	ff 75 0c             	pushl  0xc(%ebp)
 12b:	ff 75 08             	pushl  0x8(%ebp)
 12e:	e8 32 ff ff ff       	call   65 <stosb>
 133:	83 c4 0c             	add    $0xc,%esp
  return dst;
 136:	8b 45 08             	mov    0x8(%ebp),%eax
}
 139:	c9                   	leave  
 13a:	c3                   	ret    

0000013b <strchr>:

char*
strchr(const char *s, char c)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	83 ec 04             	sub    $0x4,%esp
 141:	8b 45 0c             	mov    0xc(%ebp),%eax
 144:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 147:	eb 14                	jmp    15d <strchr+0x22>
    if(*s == c)
 149:	8b 45 08             	mov    0x8(%ebp),%eax
 14c:	0f b6 00             	movzbl (%eax),%eax
 14f:	3a 45 fc             	cmp    -0x4(%ebp),%al
 152:	75 05                	jne    159 <strchr+0x1e>
      return (char*)s;
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	eb 13                	jmp    16c <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 159:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	0f b6 00             	movzbl (%eax),%eax
 163:	84 c0                	test   %al,%al
 165:	75 e2                	jne    149 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 167:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16c:	c9                   	leave  
 16d:	c3                   	ret    

0000016e <gets>:

char*
gets(char *buf, int max)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 174:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17b:	eb 42                	jmp    1bf <gets+0x51>
    cc = read(0, &c, 1);
 17d:	83 ec 04             	sub    $0x4,%esp
 180:	6a 01                	push   $0x1
 182:	8d 45 ef             	lea    -0x11(%ebp),%eax
 185:	50                   	push   %eax
 186:	6a 00                	push   $0x0
 188:	e8 98 01 00 00       	call   325 <read>
 18d:	83 c4 10             	add    $0x10,%esp
 190:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 193:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 197:	7e 33                	jle    1cc <gets+0x5e>
      break;
    buf[i++] = c;
 199:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19c:	8d 50 01             	lea    0x1(%eax),%edx
 19f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a2:	89 c2                	mov    %eax,%edx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	01 c2                	add    %eax,%edx
 1a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b3:	3c 0a                	cmp    $0xa,%al
 1b5:	74 16                	je     1cd <gets+0x5f>
 1b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bb:	3c 0d                	cmp    $0xd,%al
 1bd:	74 0e                	je     1cd <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c2:	83 c0 01             	add    $0x1,%eax
 1c5:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1c8:	7c b3                	jl     17d <gets+0xf>
 1ca:	eb 01                	jmp    1cd <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1cc:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	01 d0                	add    %edx,%eax
 1d5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1db:	c9                   	leave  
 1dc:	c3                   	ret    

000001dd <stat>:

int
stat(char *n, struct stat *st)
{
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
 1e0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e3:	83 ec 08             	sub    $0x8,%esp
 1e6:	6a 00                	push   $0x0
 1e8:	ff 75 08             	pushl  0x8(%ebp)
 1eb:	e8 5d 01 00 00       	call   34d <open>
 1f0:	83 c4 10             	add    $0x10,%esp
 1f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1fa:	79 07                	jns    203 <stat+0x26>
    return -1;
 1fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 201:	eb 25                	jmp    228 <stat+0x4b>
  r = fstat(fd, st);
 203:	83 ec 08             	sub    $0x8,%esp
 206:	ff 75 0c             	pushl  0xc(%ebp)
 209:	ff 75 f4             	pushl  -0xc(%ebp)
 20c:	e8 54 01 00 00       	call   365 <fstat>
 211:	83 c4 10             	add    $0x10,%esp
 214:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 217:	83 ec 0c             	sub    $0xc,%esp
 21a:	ff 75 f4             	pushl  -0xc(%ebp)
 21d:	e8 13 01 00 00       	call   335 <close>
 222:	83 c4 10             	add    $0x10,%esp
  return r;
 225:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <atoi>:

int
atoi(const char *s)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 237:	eb 25                	jmp    25e <atoi+0x34>
    n = n*10 + *s++ - '0';
 239:	8b 55 fc             	mov    -0x4(%ebp),%edx
 23c:	89 d0                	mov    %edx,%eax
 23e:	c1 e0 02             	shl    $0x2,%eax
 241:	01 d0                	add    %edx,%eax
 243:	01 c0                	add    %eax,%eax
 245:	89 c1                	mov    %eax,%ecx
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	8d 50 01             	lea    0x1(%eax),%edx
 24d:	89 55 08             	mov    %edx,0x8(%ebp)
 250:	0f b6 00             	movzbl (%eax),%eax
 253:	0f be c0             	movsbl %al,%eax
 256:	01 c8                	add    %ecx,%eax
 258:	83 e8 30             	sub    $0x30,%eax
 25b:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	0f b6 00             	movzbl (%eax),%eax
 264:	3c 2f                	cmp    $0x2f,%al
 266:	7e 0a                	jle    272 <atoi+0x48>
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	0f b6 00             	movzbl (%eax),%eax
 26e:	3c 39                	cmp    $0x39,%al
 270:	7e c7                	jle    239 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 272:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 275:	c9                   	leave  
 276:	c3                   	ret    

00000277 <itoa>:

char*
itoa(int val, int base){
 277:	55                   	push   %ebp
 278:	89 e5                	mov    %esp,%ebp
 27a:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 27d:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 284:	eb 29                	jmp    2af <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	99                   	cltd   
 28a:	f7 7d 0c             	idivl  0xc(%ebp)
 28d:	89 d0                	mov    %edx,%eax
 28f:	0f b6 80 5b 08 00 00 	movzbl 0x85b(%eax),%eax
 296:	8b 55 fc             	mov    -0x4(%ebp),%edx
 299:	81 c2 00 0b 00 00    	add    $0xb00,%edx
 29f:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 2a1:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	99                   	cltd   
 2a9:	f7 7d 0c             	idivl  0xc(%ebp)
 2ac:	89 45 08             	mov    %eax,0x8(%ebp)
 2af:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2b3:	74 06                	je     2bb <itoa+0x44>
 2b5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 2b9:	75 cb                	jne    286 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 2bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2be:	83 c0 01             	add    $0x1,%eax
 2c1:	05 00 0b 00 00       	add    $0xb00,%eax

}
 2c6:	c9                   	leave  
 2c7:	c3                   	ret    

000002c8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2c8:	55                   	push   %ebp
 2c9:	89 e5                	mov    %esp,%ebp
 2cb:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 2ce:	8b 45 08             	mov    0x8(%ebp),%eax
 2d1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2d4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2d7:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2da:	eb 17                	jmp    2f3 <memmove+0x2b>
    *dst++ = *src++;
 2dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2df:	8d 50 01             	lea    0x1(%eax),%edx
 2e2:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2e8:	8d 4a 01             	lea    0x1(%edx),%ecx
 2eb:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2ee:	0f b6 12             	movzbl (%edx),%edx
 2f1:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2f3:	8b 45 10             	mov    0x10(%ebp),%eax
 2f6:	8d 50 ff             	lea    -0x1(%eax),%edx
 2f9:	89 55 10             	mov    %edx,0x10(%ebp)
 2fc:	85 c0                	test   %eax,%eax
 2fe:	7f dc                	jg     2dc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 300:	8b 45 08             	mov    0x8(%ebp),%eax
}
 303:	c9                   	leave  
 304:	c3                   	ret    

00000305 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 305:	b8 01 00 00 00       	mov    $0x1,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <exit>:
SYSCALL(exit)
 30d:	b8 02 00 00 00       	mov    $0x2,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <wait>:
SYSCALL(wait)
 315:	b8 03 00 00 00       	mov    $0x3,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <pipe>:
SYSCALL(pipe)
 31d:	b8 04 00 00 00       	mov    $0x4,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <read>:
SYSCALL(read)
 325:	b8 05 00 00 00       	mov    $0x5,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <write>:
SYSCALL(write)
 32d:	b8 10 00 00 00       	mov    $0x10,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <close>:
SYSCALL(close)
 335:	b8 15 00 00 00       	mov    $0x15,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <kill>:
SYSCALL(kill)
 33d:	b8 06 00 00 00       	mov    $0x6,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <exec>:
SYSCALL(exec)
 345:	b8 07 00 00 00       	mov    $0x7,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <open>:
SYSCALL(open)
 34d:	b8 0f 00 00 00       	mov    $0xf,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <mknod>:
SYSCALL(mknod)
 355:	b8 11 00 00 00       	mov    $0x11,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <unlink>:
SYSCALL(unlink)
 35d:	b8 12 00 00 00       	mov    $0x12,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <fstat>:
SYSCALL(fstat)
 365:	b8 08 00 00 00       	mov    $0x8,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <link>:
SYSCALL(link)
 36d:	b8 13 00 00 00       	mov    $0x13,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <mkdir>:
SYSCALL(mkdir)
 375:	b8 14 00 00 00       	mov    $0x14,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <chdir>:
SYSCALL(chdir)
 37d:	b8 09 00 00 00       	mov    $0x9,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <dup>:
SYSCALL(dup)
 385:	b8 0a 00 00 00       	mov    $0xa,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <getpid>:
SYSCALL(getpid)
 38d:	b8 0b 00 00 00       	mov    $0xb,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <sbrk>:
SYSCALL(sbrk)
 395:	b8 0c 00 00 00       	mov    $0xc,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <sleep>:
SYSCALL(sleep)
 39d:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <uptime>:
SYSCALL(uptime)
 3a5:	b8 0e 00 00 00       	mov    $0xe,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <randomX>:
SYSCALL(randomX)
 3ad:	b8 16 00 00 00       	mov    $0x16,%eax
 3b2:	cd 40                	int    $0x40
 3b4:	c3                   	ret    

000003b5 <setSeedX>:
SYSCALL(setSeedX)
 3b5:	b8 17 00 00 00       	mov    $0x17,%eax
 3ba:	cd 40                	int    $0x40
 3bc:	c3                   	ret    

000003bd <uniformR>:
SYSCALL(uniformR)
 3bd:	b8 18 00 00 00       	mov    $0x18,%eax
 3c2:	cd 40                	int    $0x40
 3c4:	c3                   	ret    

000003c5 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c5:	55                   	push   %ebp
 3c6:	89 e5                	mov    %esp,%ebp
 3c8:	83 ec 18             	sub    $0x18,%esp
 3cb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ce:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d1:	83 ec 04             	sub    $0x4,%esp
 3d4:	6a 01                	push   $0x1
 3d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3d9:	50                   	push   %eax
 3da:	ff 75 08             	pushl  0x8(%ebp)
 3dd:	e8 4b ff ff ff       	call   32d <write>
 3e2:	83 c4 10             	add    $0x10,%esp
}
 3e5:	90                   	nop
 3e6:	c9                   	leave  
 3e7:	c3                   	ret    

000003e8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e8:	55                   	push   %ebp
 3e9:	89 e5                	mov    %esp,%ebp
 3eb:	53                   	push   %ebx
 3ec:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ef:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f6:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3fa:	74 17                	je     413 <printint+0x2b>
 3fc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 400:	79 11                	jns    413 <printint+0x2b>
    neg = 1;
 402:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 409:	8b 45 0c             	mov    0xc(%ebp),%eax
 40c:	f7 d8                	neg    %eax
 40e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 411:	eb 06                	jmp    419 <printint+0x31>
  } else {
    x = xx;
 413:	8b 45 0c             	mov    0xc(%ebp),%eax
 416:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 419:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 420:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 423:	8d 41 01             	lea    0x1(%ecx),%eax
 426:	89 45 f4             	mov    %eax,-0xc(%ebp)
 429:	8b 5d 10             	mov    0x10(%ebp),%ebx
 42c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 42f:	ba 00 00 00 00       	mov    $0x0,%edx
 434:	f7 f3                	div    %ebx
 436:	89 d0                	mov    %edx,%eax
 438:	0f b6 80 e0 0a 00 00 	movzbl 0xae0(%eax),%eax
 43f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 443:	8b 5d 10             	mov    0x10(%ebp),%ebx
 446:	8b 45 ec             	mov    -0x14(%ebp),%eax
 449:	ba 00 00 00 00       	mov    $0x0,%edx
 44e:	f7 f3                	div    %ebx
 450:	89 45 ec             	mov    %eax,-0x14(%ebp)
 453:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 457:	75 c7                	jne    420 <printint+0x38>
  if(neg)
 459:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45d:	74 2d                	je     48c <printint+0xa4>
    buf[i++] = '-';
 45f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 462:	8d 50 01             	lea    0x1(%eax),%edx
 465:	89 55 f4             	mov    %edx,-0xc(%ebp)
 468:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 46d:	eb 1d                	jmp    48c <printint+0xa4>
    putc(fd, buf[i]);
 46f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 472:	8b 45 f4             	mov    -0xc(%ebp),%eax
 475:	01 d0                	add    %edx,%eax
 477:	0f b6 00             	movzbl (%eax),%eax
 47a:	0f be c0             	movsbl %al,%eax
 47d:	83 ec 08             	sub    $0x8,%esp
 480:	50                   	push   %eax
 481:	ff 75 08             	pushl  0x8(%ebp)
 484:	e8 3c ff ff ff       	call   3c5 <putc>
 489:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 48c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 490:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 494:	79 d9                	jns    46f <printint+0x87>
    putc(fd, buf[i]);
}
 496:	90                   	nop
 497:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 49a:	c9                   	leave  
 49b:	c3                   	ret    

0000049c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 49c:	55                   	push   %ebp
 49d:	89 e5                	mov    %esp,%ebp
 49f:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4a9:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ac:	83 c0 04             	add    $0x4,%eax
 4af:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4b9:	e9 59 01 00 00       	jmp    617 <printf+0x17b>
    c = fmt[i] & 0xff;
 4be:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c4:	01 d0                	add    %edx,%eax
 4c6:	0f b6 00             	movzbl (%eax),%eax
 4c9:	0f be c0             	movsbl %al,%eax
 4cc:	25 ff 00 00 00       	and    $0xff,%eax
 4d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d8:	75 2c                	jne    506 <printf+0x6a>
      if(c == '%'){
 4da:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4de:	75 0c                	jne    4ec <printf+0x50>
        state = '%';
 4e0:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4e7:	e9 27 01 00 00       	jmp    613 <printf+0x177>
      } else {
        putc(fd, c);
 4ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ef:	0f be c0             	movsbl %al,%eax
 4f2:	83 ec 08             	sub    $0x8,%esp
 4f5:	50                   	push   %eax
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 c7 fe ff ff       	call   3c5 <putc>
 4fe:	83 c4 10             	add    $0x10,%esp
 501:	e9 0d 01 00 00       	jmp    613 <printf+0x177>
      }
    } else if(state == '%'){
 506:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 50a:	0f 85 03 01 00 00    	jne    613 <printf+0x177>
      if(c == 'd'){
 510:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 514:	75 1e                	jne    534 <printf+0x98>
        printint(fd, *ap, 10, 1);
 516:	8b 45 e8             	mov    -0x18(%ebp),%eax
 519:	8b 00                	mov    (%eax),%eax
 51b:	6a 01                	push   $0x1
 51d:	6a 0a                	push   $0xa
 51f:	50                   	push   %eax
 520:	ff 75 08             	pushl  0x8(%ebp)
 523:	e8 c0 fe ff ff       	call   3e8 <printint>
 528:	83 c4 10             	add    $0x10,%esp
        ap++;
 52b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52f:	e9 d8 00 00 00       	jmp    60c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 534:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 538:	74 06                	je     540 <printf+0xa4>
 53a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 53e:	75 1e                	jne    55e <printf+0xc2>
        printint(fd, *ap, 16, 0);
 540:	8b 45 e8             	mov    -0x18(%ebp),%eax
 543:	8b 00                	mov    (%eax),%eax
 545:	6a 00                	push   $0x0
 547:	6a 10                	push   $0x10
 549:	50                   	push   %eax
 54a:	ff 75 08             	pushl  0x8(%ebp)
 54d:	e8 96 fe ff ff       	call   3e8 <printint>
 552:	83 c4 10             	add    $0x10,%esp
        ap++;
 555:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 559:	e9 ae 00 00 00       	jmp    60c <printf+0x170>
      } else if(c == 's'){
 55e:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 562:	75 43                	jne    5a7 <printf+0x10b>
        s = (char*)*ap;
 564:	8b 45 e8             	mov    -0x18(%ebp),%eax
 567:	8b 00                	mov    (%eax),%eax
 569:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 56c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 570:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 574:	75 25                	jne    59b <printf+0xff>
          s = "(null)";
 576:	c7 45 f4 6c 08 00 00 	movl   $0x86c,-0xc(%ebp)
        while(*s != 0){
 57d:	eb 1c                	jmp    59b <printf+0xff>
          putc(fd, *s);
 57f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 582:	0f b6 00             	movzbl (%eax),%eax
 585:	0f be c0             	movsbl %al,%eax
 588:	83 ec 08             	sub    $0x8,%esp
 58b:	50                   	push   %eax
 58c:	ff 75 08             	pushl  0x8(%ebp)
 58f:	e8 31 fe ff ff       	call   3c5 <putc>
 594:	83 c4 10             	add    $0x10,%esp
          s++;
 597:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 59b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59e:	0f b6 00             	movzbl (%eax),%eax
 5a1:	84 c0                	test   %al,%al
 5a3:	75 da                	jne    57f <printf+0xe3>
 5a5:	eb 65                	jmp    60c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5a7:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ab:	75 1d                	jne    5ca <printf+0x12e>
        putc(fd, *ap);
 5ad:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b0:	8b 00                	mov    (%eax),%eax
 5b2:	0f be c0             	movsbl %al,%eax
 5b5:	83 ec 08             	sub    $0x8,%esp
 5b8:	50                   	push   %eax
 5b9:	ff 75 08             	pushl  0x8(%ebp)
 5bc:	e8 04 fe ff ff       	call   3c5 <putc>
 5c1:	83 c4 10             	add    $0x10,%esp
        ap++;
 5c4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c8:	eb 42                	jmp    60c <printf+0x170>
      } else if(c == '%'){
 5ca:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ce:	75 17                	jne    5e7 <printf+0x14b>
        putc(fd, c);
 5d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d3:	0f be c0             	movsbl %al,%eax
 5d6:	83 ec 08             	sub    $0x8,%esp
 5d9:	50                   	push   %eax
 5da:	ff 75 08             	pushl  0x8(%ebp)
 5dd:	e8 e3 fd ff ff       	call   3c5 <putc>
 5e2:	83 c4 10             	add    $0x10,%esp
 5e5:	eb 25                	jmp    60c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e7:	83 ec 08             	sub    $0x8,%esp
 5ea:	6a 25                	push   $0x25
 5ec:	ff 75 08             	pushl  0x8(%ebp)
 5ef:	e8 d1 fd ff ff       	call   3c5 <putc>
 5f4:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fa:	0f be c0             	movsbl %al,%eax
 5fd:	83 ec 08             	sub    $0x8,%esp
 600:	50                   	push   %eax
 601:	ff 75 08             	pushl  0x8(%ebp)
 604:	e8 bc fd ff ff       	call   3c5 <putc>
 609:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 60c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 613:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 617:	8b 55 0c             	mov    0xc(%ebp),%edx
 61a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61d:	01 d0                	add    %edx,%eax
 61f:	0f b6 00             	movzbl (%eax),%eax
 622:	84 c0                	test   %al,%al
 624:	0f 85 94 fe ff ff    	jne    4be <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 62a:	90                   	nop
 62b:	c9                   	leave  
 62c:	c3                   	ret    

0000062d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 62d:	55                   	push   %ebp
 62e:	89 e5                	mov    %esp,%ebp
 630:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 633:	8b 45 08             	mov    0x8(%ebp),%eax
 636:	83 e8 08             	sub    $0x8,%eax
 639:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63c:	a1 28 0b 00 00       	mov    0xb28,%eax
 641:	89 45 fc             	mov    %eax,-0x4(%ebp)
 644:	eb 24                	jmp    66a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 646:	8b 45 fc             	mov    -0x4(%ebp),%eax
 649:	8b 00                	mov    (%eax),%eax
 64b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 64e:	77 12                	ja     662 <free+0x35>
 650:	8b 45 f8             	mov    -0x8(%ebp),%eax
 653:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 656:	77 24                	ja     67c <free+0x4f>
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 660:	77 1a                	ja     67c <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 662:	8b 45 fc             	mov    -0x4(%ebp),%eax
 665:	8b 00                	mov    (%eax),%eax
 667:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 670:	76 d4                	jbe    646 <free+0x19>
 672:	8b 45 fc             	mov    -0x4(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67a:	76 ca                	jbe    646 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 67c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67f:	8b 40 04             	mov    0x4(%eax),%eax
 682:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	01 c2                	add    %eax,%edx
 68e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 691:	8b 00                	mov    (%eax),%eax
 693:	39 c2                	cmp    %eax,%edx
 695:	75 24                	jne    6bb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	8b 50 04             	mov    0x4(%eax),%edx
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	8b 40 04             	mov    0x4(%eax),%eax
 6a5:	01 c2                	add    %eax,%edx
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	8b 10                	mov    (%eax),%edx
 6b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b7:	89 10                	mov    %edx,(%eax)
 6b9:	eb 0a                	jmp    6c5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6be:	8b 10                	mov    (%eax),%edx
 6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	8b 40 04             	mov    0x4(%eax),%eax
 6cb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	01 d0                	add    %edx,%eax
 6d7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6da:	75 20                	jne    6fc <free+0xcf>
    p->s.size += bp->s.size;
 6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6df:	8b 50 04             	mov    0x4(%eax),%edx
 6e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e5:	8b 40 04             	mov    0x4(%eax),%eax
 6e8:	01 c2                	add    %eax,%edx
 6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ed:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f3:	8b 10                	mov    (%eax),%edx
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	89 10                	mov    %edx,(%eax)
 6fa:	eb 08                	jmp    704 <free+0xd7>
  } else
    p->s.ptr = bp;
 6fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ff:	8b 55 f8             	mov    -0x8(%ebp),%edx
 702:	89 10                	mov    %edx,(%eax)
  freep = p;
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	a3 28 0b 00 00       	mov    %eax,0xb28
}
 70c:	90                   	nop
 70d:	c9                   	leave  
 70e:	c3                   	ret    

0000070f <morecore>:

static Header*
morecore(uint nu)
{
 70f:	55                   	push   %ebp
 710:	89 e5                	mov    %esp,%ebp
 712:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 715:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 71c:	77 07                	ja     725 <morecore+0x16>
    nu = 4096;
 71e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 725:	8b 45 08             	mov    0x8(%ebp),%eax
 728:	c1 e0 03             	shl    $0x3,%eax
 72b:	83 ec 0c             	sub    $0xc,%esp
 72e:	50                   	push   %eax
 72f:	e8 61 fc ff ff       	call   395 <sbrk>
 734:	83 c4 10             	add    $0x10,%esp
 737:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 73a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 73e:	75 07                	jne    747 <morecore+0x38>
    return 0;
 740:	b8 00 00 00 00       	mov    $0x0,%eax
 745:	eb 26                	jmp    76d <morecore+0x5e>
  hp = (Header*)p;
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 74d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 750:	8b 55 08             	mov    0x8(%ebp),%edx
 753:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 756:	8b 45 f0             	mov    -0x10(%ebp),%eax
 759:	83 c0 08             	add    $0x8,%eax
 75c:	83 ec 0c             	sub    $0xc,%esp
 75f:	50                   	push   %eax
 760:	e8 c8 fe ff ff       	call   62d <free>
 765:	83 c4 10             	add    $0x10,%esp
  return freep;
 768:	a1 28 0b 00 00       	mov    0xb28,%eax
}
 76d:	c9                   	leave  
 76e:	c3                   	ret    

0000076f <malloc>:

void*
malloc(uint nbytes)
{
 76f:	55                   	push   %ebp
 770:	89 e5                	mov    %esp,%ebp
 772:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 775:	8b 45 08             	mov    0x8(%ebp),%eax
 778:	83 c0 07             	add    $0x7,%eax
 77b:	c1 e8 03             	shr    $0x3,%eax
 77e:	83 c0 01             	add    $0x1,%eax
 781:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 784:	a1 28 0b 00 00       	mov    0xb28,%eax
 789:	89 45 f0             	mov    %eax,-0x10(%ebp)
 78c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 790:	75 23                	jne    7b5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 792:	c7 45 f0 20 0b 00 00 	movl   $0xb20,-0x10(%ebp)
 799:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79c:	a3 28 0b 00 00       	mov    %eax,0xb28
 7a1:	a1 28 0b 00 00       	mov    0xb28,%eax
 7a6:	a3 20 0b 00 00       	mov    %eax,0xb20
    base.s.size = 0;
 7ab:	c7 05 24 0b 00 00 00 	movl   $0x0,0xb24
 7b2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b8:	8b 00                	mov    (%eax),%eax
 7ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c0:	8b 40 04             	mov    0x4(%eax),%eax
 7c3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7c6:	72 4d                	jb     815 <malloc+0xa6>
      if(p->s.size == nunits)
 7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cb:	8b 40 04             	mov    0x4(%eax),%eax
 7ce:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7d1:	75 0c                	jne    7df <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d6:	8b 10                	mov    (%eax),%edx
 7d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7db:	89 10                	mov    %edx,(%eax)
 7dd:	eb 26                	jmp    805 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e2:	8b 40 04             	mov    0x4(%eax),%eax
 7e5:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7e8:	89 c2                	mov    %eax,%edx
 7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ed:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f3:	8b 40 04             	mov    0x4(%eax),%eax
 7f6:	c1 e0 03             	shl    $0x3,%eax
 7f9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
 802:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 805:	8b 45 f0             	mov    -0x10(%ebp),%eax
 808:	a3 28 0b 00 00       	mov    %eax,0xb28
      return (void*)(p + 1);
 80d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 810:	83 c0 08             	add    $0x8,%eax
 813:	eb 3b                	jmp    850 <malloc+0xe1>
    }
    if(p == freep)
 815:	a1 28 0b 00 00       	mov    0xb28,%eax
 81a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 81d:	75 1e                	jne    83d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 81f:	83 ec 0c             	sub    $0xc,%esp
 822:	ff 75 ec             	pushl  -0x14(%ebp)
 825:	e8 e5 fe ff ff       	call   70f <morecore>
 82a:	83 c4 10             	add    $0x10,%esp
 82d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 830:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 834:	75 07                	jne    83d <malloc+0xce>
        return 0;
 836:	b8 00 00 00 00       	mov    $0x0,%eax
 83b:	eb 13                	jmp    850 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 840:	89 45 f0             	mov    %eax,-0x10(%ebp)
 843:	8b 45 f4             	mov    -0xc(%ebp),%eax
 846:	8b 00                	mov    (%eax),%eax
 848:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 84b:	e9 6d ff ff ff       	jmp    7bd <malloc+0x4e>
}
 850:	c9                   	leave  
 851:	c3                   	ret    
