
_mkdir:     file format elf32-i386


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

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: mkdir files...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 7d 08 00 00       	push   $0x87d
  21:	6a 02                	push   $0x2
  23:	e8 9f 04 00 00       	call   4c7 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 08 03 00 00       	call   338 <exit>
  }

  for(i = 1; i < argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 4b                	jmp    84 <main+0x84>
    if(mkdir(argv[i]) < 0){
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 4d 03 00 00       	call   3a0 <mkdir>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	79 26                	jns    80 <main+0x80>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  64:	8b 43 04             	mov    0x4(%ebx),%eax
  67:	01 d0                	add    %edx,%eax
  69:	8b 00                	mov    (%eax),%eax
  6b:	83 ec 04             	sub    $0x4,%esp
  6e:	50                   	push   %eax
  6f:	68 94 08 00 00       	push   $0x894
  74:	6a 02                	push   $0x2
  76:	e8 4c 04 00 00       	call   4c7 <printf>
  7b:	83 c4 10             	add    $0x10,%esp
      break;
  7e:	eb 0b                	jmp    8b <main+0x8b>
  if(argc < 2){
    printf(2, "Usage: mkdir files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  87:	3b 03                	cmp    (%ebx),%eax
  89:	7c ae                	jl     39 <main+0x39>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
      break;
    }
  }

  exit();
  8b:	e8 a8 02 00 00       	call   338 <exit>

00000090 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  95:	8b 4d 08             	mov    0x8(%ebp),%ecx
  98:	8b 55 10             	mov    0x10(%ebp),%edx
  9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  9e:	89 cb                	mov    %ecx,%ebx
  a0:	89 df                	mov    %ebx,%edi
  a2:	89 d1                	mov    %edx,%ecx
  a4:	fc                   	cld    
  a5:	f3 aa                	rep stos %al,%es:(%edi)
  a7:	89 ca                	mov    %ecx,%edx
  a9:	89 fb                	mov    %edi,%ebx
  ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ae:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  b1:	90                   	nop
  b2:	5b                   	pop    %ebx
  b3:	5f                   	pop    %edi
  b4:	5d                   	pop    %ebp
  b5:	c3                   	ret    

000000b6 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  b6:	55                   	push   %ebp
  b7:	89 e5                	mov    %esp,%ebp
  b9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  bc:	8b 45 08             	mov    0x8(%ebp),%eax
  bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  c2:	90                   	nop
  c3:	8b 45 08             	mov    0x8(%ebp),%eax
  c6:	8d 50 01             	lea    0x1(%eax),%edx
  c9:	89 55 08             	mov    %edx,0x8(%ebp)
  cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  cf:	8d 4a 01             	lea    0x1(%edx),%ecx
  d2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  d5:	0f b6 12             	movzbl (%edx),%edx
  d8:	88 10                	mov    %dl,(%eax)
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	84 c0                	test   %al,%al
  df:	75 e2                	jne    c3 <strcpy+0xd>
    ;
  return os;
  e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e4:	c9                   	leave  
  e5:	c3                   	ret    

000000e6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e6:	55                   	push   %ebp
  e7:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e9:	eb 08                	jmp    f3 <strcmp+0xd>
    p++, q++;
  eb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ef:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 00             	movzbl (%eax),%eax
  f9:	84 c0                	test   %al,%al
  fb:	74 10                	je     10d <strcmp+0x27>
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
 100:	0f b6 10             	movzbl (%eax),%edx
 103:	8b 45 0c             	mov    0xc(%ebp),%eax
 106:	0f b6 00             	movzbl (%eax),%eax
 109:	38 c2                	cmp    %al,%dl
 10b:	74 de                	je     eb <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 10d:	8b 45 08             	mov    0x8(%ebp),%eax
 110:	0f b6 00             	movzbl (%eax),%eax
 113:	0f b6 d0             	movzbl %al,%edx
 116:	8b 45 0c             	mov    0xc(%ebp),%eax
 119:	0f b6 00             	movzbl (%eax),%eax
 11c:	0f b6 c0             	movzbl %al,%eax
 11f:	29 c2                	sub    %eax,%edx
 121:	89 d0                	mov    %edx,%eax
}
 123:	5d                   	pop    %ebp
 124:	c3                   	ret    

00000125 <strlen>:

uint
strlen(char *s)
{
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
 128:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 12b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 132:	eb 04                	jmp    138 <strlen+0x13>
 134:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 138:	8b 55 fc             	mov    -0x4(%ebp),%edx
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	01 d0                	add    %edx,%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	84 c0                	test   %al,%al
 145:	75 ed                	jne    134 <strlen+0xf>
    ;
  return n;
 147:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 14a:	c9                   	leave  
 14b:	c3                   	ret    

0000014c <memset>:

void*
memset(void *dst, int c, uint n)
{
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 14f:	8b 45 10             	mov    0x10(%ebp),%eax
 152:	50                   	push   %eax
 153:	ff 75 0c             	pushl  0xc(%ebp)
 156:	ff 75 08             	pushl  0x8(%ebp)
 159:	e8 32 ff ff ff       	call   90 <stosb>
 15e:	83 c4 0c             	add    $0xc,%esp
  return dst;
 161:	8b 45 08             	mov    0x8(%ebp),%eax
}
 164:	c9                   	leave  
 165:	c3                   	ret    

00000166 <strchr>:

char*
strchr(const char *s, char c)
{
 166:	55                   	push   %ebp
 167:	89 e5                	mov    %esp,%ebp
 169:	83 ec 04             	sub    $0x4,%esp
 16c:	8b 45 0c             	mov    0xc(%ebp),%eax
 16f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 172:	eb 14                	jmp    188 <strchr+0x22>
    if(*s == c)
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	0f b6 00             	movzbl (%eax),%eax
 17a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 17d:	75 05                	jne    184 <strchr+0x1e>
      return (char*)s;
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	eb 13                	jmp    197 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 184:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	0f b6 00             	movzbl (%eax),%eax
 18e:	84 c0                	test   %al,%al
 190:	75 e2                	jne    174 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 192:	b8 00 00 00 00       	mov    $0x0,%eax
}
 197:	c9                   	leave  
 198:	c3                   	ret    

00000199 <gets>:

char*
gets(char *buf, int max)
{
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a6:	eb 42                	jmp    1ea <gets+0x51>
    cc = read(0, &c, 1);
 1a8:	83 ec 04             	sub    $0x4,%esp
 1ab:	6a 01                	push   $0x1
 1ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 98 01 00 00       	call   350 <read>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c2:	7e 33                	jle    1f7 <gets+0x5e>
      break;
    buf[i++] = c;
 1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c7:	8d 50 01             	lea    0x1(%eax),%edx
 1ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1cd:	89 c2                	mov    %eax,%edx
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	01 c2                	add    %eax,%edx
 1d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d8:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1de:	3c 0a                	cmp    $0xa,%al
 1e0:	74 16                	je     1f8 <gets+0x5f>
 1e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e6:	3c 0d                	cmp    $0xd,%al
 1e8:	74 0e                	je     1f8 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ed:	83 c0 01             	add    $0x1,%eax
 1f0:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1f3:	7c b3                	jl     1a8 <gets+0xf>
 1f5:	eb 01                	jmp    1f8 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1f7:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	01 d0                	add    %edx,%eax
 200:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 203:	8b 45 08             	mov    0x8(%ebp),%eax
}
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <stat>:

int
stat(char *n, struct stat *st)
{
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
 20b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20e:	83 ec 08             	sub    $0x8,%esp
 211:	6a 00                	push   $0x0
 213:	ff 75 08             	pushl  0x8(%ebp)
 216:	e8 5d 01 00 00       	call   378 <open>
 21b:	83 c4 10             	add    $0x10,%esp
 21e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 225:	79 07                	jns    22e <stat+0x26>
    return -1;
 227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22c:	eb 25                	jmp    253 <stat+0x4b>
  r = fstat(fd, st);
 22e:	83 ec 08             	sub    $0x8,%esp
 231:	ff 75 0c             	pushl  0xc(%ebp)
 234:	ff 75 f4             	pushl  -0xc(%ebp)
 237:	e8 54 01 00 00       	call   390 <fstat>
 23c:	83 c4 10             	add    $0x10,%esp
 23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 242:	83 ec 0c             	sub    $0xc,%esp
 245:	ff 75 f4             	pushl  -0xc(%ebp)
 248:	e8 13 01 00 00       	call   360 <close>
 24d:	83 c4 10             	add    $0x10,%esp
  return r;
 250:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 253:	c9                   	leave  
 254:	c3                   	ret    

00000255 <atoi>:

int
atoi(const char *s)
{
 255:	55                   	push   %ebp
 256:	89 e5                	mov    %esp,%ebp
 258:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 25b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 262:	eb 25                	jmp    289 <atoi+0x34>
    n = n*10 + *s++ - '0';
 264:	8b 55 fc             	mov    -0x4(%ebp),%edx
 267:	89 d0                	mov    %edx,%eax
 269:	c1 e0 02             	shl    $0x2,%eax
 26c:	01 d0                	add    %edx,%eax
 26e:	01 c0                	add    %eax,%eax
 270:	89 c1                	mov    %eax,%ecx
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	8d 50 01             	lea    0x1(%eax),%edx
 278:	89 55 08             	mov    %edx,0x8(%ebp)
 27b:	0f b6 00             	movzbl (%eax),%eax
 27e:	0f be c0             	movsbl %al,%eax
 281:	01 c8                	add    %ecx,%eax
 283:	83 e8 30             	sub    $0x30,%eax
 286:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	3c 2f                	cmp    $0x2f,%al
 291:	7e 0a                	jle    29d <atoi+0x48>
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	0f b6 00             	movzbl (%eax),%eax
 299:	3c 39                	cmp    $0x39,%al
 29b:	7e c7                	jle    264 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 2a0:	c9                   	leave  
 2a1:	c3                   	ret    

000002a2 <itoa>:

char*
itoa(int val, int base){
 2a2:	55                   	push   %ebp
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 2a8:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 2af:	eb 29                	jmp    2da <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 2b1:	8b 45 08             	mov    0x8(%ebp),%eax
 2b4:	99                   	cltd   
 2b5:	f7 7d 0c             	idivl  0xc(%ebp)
 2b8:	89 d0                	mov    %edx,%eax
 2ba:	0f b6 80 b0 08 00 00 	movzbl 0x8b0(%eax),%eax
 2c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c4:	81 c2 60 0b 00 00    	add    $0xb60,%edx
 2ca:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 2cc:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 2d0:	8b 45 08             	mov    0x8(%ebp),%eax
 2d3:	99                   	cltd   
 2d4:	f7 7d 0c             	idivl  0xc(%ebp)
 2d7:	89 45 08             	mov    %eax,0x8(%ebp)
 2da:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2de:	74 06                	je     2e6 <itoa+0x44>
 2e0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 2e4:	75 cb                	jne    2b1 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 2e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2e9:	83 c0 01             	add    $0x1,%eax
 2ec:	05 60 0b 00 00       	add    $0xb60,%eax

}
 2f1:	c9                   	leave  
 2f2:	c3                   	ret    

000002f3 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2f3:	55                   	push   %ebp
 2f4:	89 e5                	mov    %esp,%ebp
 2f6:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 2f9:	8b 45 08             	mov    0x8(%ebp),%eax
 2fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 302:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 305:	eb 17                	jmp    31e <memmove+0x2b>
    *dst++ = *src++;
 307:	8b 45 fc             	mov    -0x4(%ebp),%eax
 30a:	8d 50 01             	lea    0x1(%eax),%edx
 30d:	89 55 fc             	mov    %edx,-0x4(%ebp)
 310:	8b 55 f8             	mov    -0x8(%ebp),%edx
 313:	8d 4a 01             	lea    0x1(%edx),%ecx
 316:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 319:	0f b6 12             	movzbl (%edx),%edx
 31c:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	8b 45 10             	mov    0x10(%ebp),%eax
 321:	8d 50 ff             	lea    -0x1(%eax),%edx
 324:	89 55 10             	mov    %edx,0x10(%ebp)
 327:	85 c0                	test   %eax,%eax
 329:	7f dc                	jg     307 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 32e:	c9                   	leave  
 32f:	c3                   	ret    

00000330 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 330:	b8 01 00 00 00       	mov    $0x1,%eax
 335:	cd 40                	int    $0x40
 337:	c3                   	ret    

00000338 <exit>:
SYSCALL(exit)
 338:	b8 02 00 00 00       	mov    $0x2,%eax
 33d:	cd 40                	int    $0x40
 33f:	c3                   	ret    

00000340 <wait>:
SYSCALL(wait)
 340:	b8 03 00 00 00       	mov    $0x3,%eax
 345:	cd 40                	int    $0x40
 347:	c3                   	ret    

00000348 <pipe>:
SYSCALL(pipe)
 348:	b8 04 00 00 00       	mov    $0x4,%eax
 34d:	cd 40                	int    $0x40
 34f:	c3                   	ret    

00000350 <read>:
SYSCALL(read)
 350:	b8 05 00 00 00       	mov    $0x5,%eax
 355:	cd 40                	int    $0x40
 357:	c3                   	ret    

00000358 <write>:
SYSCALL(write)
 358:	b8 10 00 00 00       	mov    $0x10,%eax
 35d:	cd 40                	int    $0x40
 35f:	c3                   	ret    

00000360 <close>:
SYSCALL(close)
 360:	b8 15 00 00 00       	mov    $0x15,%eax
 365:	cd 40                	int    $0x40
 367:	c3                   	ret    

00000368 <kill>:
SYSCALL(kill)
 368:	b8 06 00 00 00       	mov    $0x6,%eax
 36d:	cd 40                	int    $0x40
 36f:	c3                   	ret    

00000370 <exec>:
SYSCALL(exec)
 370:	b8 07 00 00 00       	mov    $0x7,%eax
 375:	cd 40                	int    $0x40
 377:	c3                   	ret    

00000378 <open>:
SYSCALL(open)
 378:	b8 0f 00 00 00       	mov    $0xf,%eax
 37d:	cd 40                	int    $0x40
 37f:	c3                   	ret    

00000380 <mknod>:
SYSCALL(mknod)
 380:	b8 11 00 00 00       	mov    $0x11,%eax
 385:	cd 40                	int    $0x40
 387:	c3                   	ret    

00000388 <unlink>:
SYSCALL(unlink)
 388:	b8 12 00 00 00       	mov    $0x12,%eax
 38d:	cd 40                	int    $0x40
 38f:	c3                   	ret    

00000390 <fstat>:
SYSCALL(fstat)
 390:	b8 08 00 00 00       	mov    $0x8,%eax
 395:	cd 40                	int    $0x40
 397:	c3                   	ret    

00000398 <link>:
SYSCALL(link)
 398:	b8 13 00 00 00       	mov    $0x13,%eax
 39d:	cd 40                	int    $0x40
 39f:	c3                   	ret    

000003a0 <mkdir>:
SYSCALL(mkdir)
 3a0:	b8 14 00 00 00       	mov    $0x14,%eax
 3a5:	cd 40                	int    $0x40
 3a7:	c3                   	ret    

000003a8 <chdir>:
SYSCALL(chdir)
 3a8:	b8 09 00 00 00       	mov    $0x9,%eax
 3ad:	cd 40                	int    $0x40
 3af:	c3                   	ret    

000003b0 <dup>:
SYSCALL(dup)
 3b0:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b5:	cd 40                	int    $0x40
 3b7:	c3                   	ret    

000003b8 <getpid>:
SYSCALL(getpid)
 3b8:	b8 0b 00 00 00       	mov    $0xb,%eax
 3bd:	cd 40                	int    $0x40
 3bf:	c3                   	ret    

000003c0 <sbrk>:
SYSCALL(sbrk)
 3c0:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c5:	cd 40                	int    $0x40
 3c7:	c3                   	ret    

000003c8 <sleep>:
SYSCALL(sleep)
 3c8:	b8 0d 00 00 00       	mov    $0xd,%eax
 3cd:	cd 40                	int    $0x40
 3cf:	c3                   	ret    

000003d0 <uptime>:
SYSCALL(uptime)
 3d0:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d5:	cd 40                	int    $0x40
 3d7:	c3                   	ret    

000003d8 <randomX>:
SYSCALL(randomX)
 3d8:	b8 16 00 00 00       	mov    $0x16,%eax
 3dd:	cd 40                	int    $0x40
 3df:	c3                   	ret    

000003e0 <setSeedX>:
SYSCALL(setSeedX)
 3e0:	b8 17 00 00 00       	mov    $0x17,%eax
 3e5:	cd 40                	int    $0x40
 3e7:	c3                   	ret    

000003e8 <uniformR>:
SYSCALL(uniformR)
 3e8:	b8 18 00 00 00       	mov    $0x18,%eax
 3ed:	cd 40                	int    $0x40
 3ef:	c3                   	ret    

000003f0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	83 ec 18             	sub    $0x18,%esp
 3f6:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f9:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3fc:	83 ec 04             	sub    $0x4,%esp
 3ff:	6a 01                	push   $0x1
 401:	8d 45 f4             	lea    -0xc(%ebp),%eax
 404:	50                   	push   %eax
 405:	ff 75 08             	pushl  0x8(%ebp)
 408:	e8 4b ff ff ff       	call   358 <write>
 40d:	83 c4 10             	add    $0x10,%esp
}
 410:	90                   	nop
 411:	c9                   	leave  
 412:	c3                   	ret    

00000413 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 413:	55                   	push   %ebp
 414:	89 e5                	mov    %esp,%ebp
 416:	53                   	push   %ebx
 417:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 41a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 421:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 425:	74 17                	je     43e <printint+0x2b>
 427:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 42b:	79 11                	jns    43e <printint+0x2b>
    neg = 1;
 42d:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 434:	8b 45 0c             	mov    0xc(%ebp),%eax
 437:	f7 d8                	neg    %eax
 439:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43c:	eb 06                	jmp    444 <printint+0x31>
  } else {
    x = xx;
 43e:	8b 45 0c             	mov    0xc(%ebp),%eax
 441:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 444:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 44b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 44e:	8d 41 01             	lea    0x1(%ecx),%eax
 451:	89 45 f4             	mov    %eax,-0xc(%ebp)
 454:	8b 5d 10             	mov    0x10(%ebp),%ebx
 457:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45a:	ba 00 00 00 00       	mov    $0x0,%edx
 45f:	f7 f3                	div    %ebx
 461:	89 d0                	mov    %edx,%eax
 463:	0f b6 80 34 0b 00 00 	movzbl 0xb34(%eax),%eax
 46a:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 46e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 471:	8b 45 ec             	mov    -0x14(%ebp),%eax
 474:	ba 00 00 00 00       	mov    $0x0,%edx
 479:	f7 f3                	div    %ebx
 47b:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 482:	75 c7                	jne    44b <printint+0x38>
  if(neg)
 484:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 488:	74 2d                	je     4b7 <printint+0xa4>
    buf[i++] = '-';
 48a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48d:	8d 50 01             	lea    0x1(%eax),%edx
 490:	89 55 f4             	mov    %edx,-0xc(%ebp)
 493:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 498:	eb 1d                	jmp    4b7 <printint+0xa4>
    putc(fd, buf[i]);
 49a:	8d 55 dc             	lea    -0x24(%ebp),%edx
 49d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a0:	01 d0                	add    %edx,%eax
 4a2:	0f b6 00             	movzbl (%eax),%eax
 4a5:	0f be c0             	movsbl %al,%eax
 4a8:	83 ec 08             	sub    $0x8,%esp
 4ab:	50                   	push   %eax
 4ac:	ff 75 08             	pushl  0x8(%ebp)
 4af:	e8 3c ff ff ff       	call   3f0 <putc>
 4b4:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b7:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4bf:	79 d9                	jns    49a <printint+0x87>
    putc(fd, buf[i]);
}
 4c1:	90                   	nop
 4c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c5:	c9                   	leave  
 4c6:	c3                   	ret    

000004c7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c7:	55                   	push   %ebp
 4c8:	89 e5                	mov    %esp,%ebp
 4ca:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4cd:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4d4:	8d 45 0c             	lea    0xc(%ebp),%eax
 4d7:	83 c0 04             	add    $0x4,%eax
 4da:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e4:	e9 59 01 00 00       	jmp    642 <printf+0x17b>
    c = fmt[i] & 0xff;
 4e9:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ef:	01 d0                	add    %edx,%eax
 4f1:	0f b6 00             	movzbl (%eax),%eax
 4f4:	0f be c0             	movsbl %al,%eax
 4f7:	25 ff 00 00 00       	and    $0xff,%eax
 4fc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 503:	75 2c                	jne    531 <printf+0x6a>
      if(c == '%'){
 505:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 509:	75 0c                	jne    517 <printf+0x50>
        state = '%';
 50b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 512:	e9 27 01 00 00       	jmp    63e <printf+0x177>
      } else {
        putc(fd, c);
 517:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 51a:	0f be c0             	movsbl %al,%eax
 51d:	83 ec 08             	sub    $0x8,%esp
 520:	50                   	push   %eax
 521:	ff 75 08             	pushl  0x8(%ebp)
 524:	e8 c7 fe ff ff       	call   3f0 <putc>
 529:	83 c4 10             	add    $0x10,%esp
 52c:	e9 0d 01 00 00       	jmp    63e <printf+0x177>
      }
    } else if(state == '%'){
 531:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 535:	0f 85 03 01 00 00    	jne    63e <printf+0x177>
      if(c == 'd'){
 53b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 53f:	75 1e                	jne    55f <printf+0x98>
        printint(fd, *ap, 10, 1);
 541:	8b 45 e8             	mov    -0x18(%ebp),%eax
 544:	8b 00                	mov    (%eax),%eax
 546:	6a 01                	push   $0x1
 548:	6a 0a                	push   $0xa
 54a:	50                   	push   %eax
 54b:	ff 75 08             	pushl  0x8(%ebp)
 54e:	e8 c0 fe ff ff       	call   413 <printint>
 553:	83 c4 10             	add    $0x10,%esp
        ap++;
 556:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 55a:	e9 d8 00 00 00       	jmp    637 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 55f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 563:	74 06                	je     56b <printf+0xa4>
 565:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 569:	75 1e                	jne    589 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 56b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56e:	8b 00                	mov    (%eax),%eax
 570:	6a 00                	push   $0x0
 572:	6a 10                	push   $0x10
 574:	50                   	push   %eax
 575:	ff 75 08             	pushl  0x8(%ebp)
 578:	e8 96 fe ff ff       	call   413 <printint>
 57d:	83 c4 10             	add    $0x10,%esp
        ap++;
 580:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 584:	e9 ae 00 00 00       	jmp    637 <printf+0x170>
      } else if(c == 's'){
 589:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 58d:	75 43                	jne    5d2 <printf+0x10b>
        s = (char*)*ap;
 58f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 592:	8b 00                	mov    (%eax),%eax
 594:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 597:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 59b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 59f:	75 25                	jne    5c6 <printf+0xff>
          s = "(null)";
 5a1:	c7 45 f4 c1 08 00 00 	movl   $0x8c1,-0xc(%ebp)
        while(*s != 0){
 5a8:	eb 1c                	jmp    5c6 <printf+0xff>
          putc(fd, *s);
 5aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ad:	0f b6 00             	movzbl (%eax),%eax
 5b0:	0f be c0             	movsbl %al,%eax
 5b3:	83 ec 08             	sub    $0x8,%esp
 5b6:	50                   	push   %eax
 5b7:	ff 75 08             	pushl  0x8(%ebp)
 5ba:	e8 31 fe ff ff       	call   3f0 <putc>
 5bf:	83 c4 10             	add    $0x10,%esp
          s++;
 5c2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c9:	0f b6 00             	movzbl (%eax),%eax
 5cc:	84 c0                	test   %al,%al
 5ce:	75 da                	jne    5aa <printf+0xe3>
 5d0:	eb 65                	jmp    637 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d6:	75 1d                	jne    5f5 <printf+0x12e>
        putc(fd, *ap);
 5d8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5db:	8b 00                	mov    (%eax),%eax
 5dd:	0f be c0             	movsbl %al,%eax
 5e0:	83 ec 08             	sub    $0x8,%esp
 5e3:	50                   	push   %eax
 5e4:	ff 75 08             	pushl  0x8(%ebp)
 5e7:	e8 04 fe ff ff       	call   3f0 <putc>
 5ec:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ef:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f3:	eb 42                	jmp    637 <printf+0x170>
      } else if(c == '%'){
 5f5:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f9:	75 17                	jne    612 <printf+0x14b>
        putc(fd, c);
 5fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fe:	0f be c0             	movsbl %al,%eax
 601:	83 ec 08             	sub    $0x8,%esp
 604:	50                   	push   %eax
 605:	ff 75 08             	pushl  0x8(%ebp)
 608:	e8 e3 fd ff ff       	call   3f0 <putc>
 60d:	83 c4 10             	add    $0x10,%esp
 610:	eb 25                	jmp    637 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 612:	83 ec 08             	sub    $0x8,%esp
 615:	6a 25                	push   $0x25
 617:	ff 75 08             	pushl  0x8(%ebp)
 61a:	e8 d1 fd ff ff       	call   3f0 <putc>
 61f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 622:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 625:	0f be c0             	movsbl %al,%eax
 628:	83 ec 08             	sub    $0x8,%esp
 62b:	50                   	push   %eax
 62c:	ff 75 08             	pushl  0x8(%ebp)
 62f:	e8 bc fd ff ff       	call   3f0 <putc>
 634:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 637:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 642:	8b 55 0c             	mov    0xc(%ebp),%edx
 645:	8b 45 f0             	mov    -0x10(%ebp),%eax
 648:	01 d0                	add    %edx,%eax
 64a:	0f b6 00             	movzbl (%eax),%eax
 64d:	84 c0                	test   %al,%al
 64f:	0f 85 94 fe ff ff    	jne    4e9 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 655:	90                   	nop
 656:	c9                   	leave  
 657:	c3                   	ret    

00000658 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 658:	55                   	push   %ebp
 659:	89 e5                	mov    %esp,%ebp
 65b:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65e:	8b 45 08             	mov    0x8(%ebp),%eax
 661:	83 e8 08             	sub    $0x8,%eax
 664:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 667:	a1 88 0b 00 00       	mov    0xb88,%eax
 66c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66f:	eb 24                	jmp    695 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 679:	77 12                	ja     68d <free+0x35>
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 681:	77 24                	ja     6a7 <free+0x4f>
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68b:	77 1a                	ja     6a7 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	89 45 fc             	mov    %eax,-0x4(%ebp)
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69b:	76 d4                	jbe    671 <free+0x19>
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a5:	76 ca                	jbe    671 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	8b 40 04             	mov    0x4(%eax),%eax
 6ad:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b7:	01 c2                	add    %eax,%edx
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	39 c2                	cmp    %eax,%edx
 6c0:	75 24                	jne    6e6 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c5:	8b 50 04             	mov    0x4(%eax),%edx
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 00                	mov    (%eax),%eax
 6cd:	8b 40 04             	mov    0x4(%eax),%eax
 6d0:	01 c2                	add    %eax,%edx
 6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d5:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6db:	8b 00                	mov    (%eax),%eax
 6dd:	8b 10                	mov    (%eax),%edx
 6df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e2:	89 10                	mov    %edx,(%eax)
 6e4:	eb 0a                	jmp    6f0 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	8b 10                	mov    (%eax),%edx
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 40 04             	mov    0x4(%eax),%eax
 6f6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	01 d0                	add    %edx,%eax
 702:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 705:	75 20                	jne    727 <free+0xcf>
    p->s.size += bp->s.size;
 707:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70a:	8b 50 04             	mov    0x4(%eax),%edx
 70d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 710:	8b 40 04             	mov    0x4(%eax),%eax
 713:	01 c2                	add    %eax,%edx
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 71b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71e:	8b 10                	mov    (%eax),%edx
 720:	8b 45 fc             	mov    -0x4(%ebp),%eax
 723:	89 10                	mov    %edx,(%eax)
 725:	eb 08                	jmp    72f <free+0xd7>
  } else
    p->s.ptr = bp;
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 72d:	89 10                	mov    %edx,(%eax)
  freep = p;
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	a3 88 0b 00 00       	mov    %eax,0xb88
}
 737:	90                   	nop
 738:	c9                   	leave  
 739:	c3                   	ret    

0000073a <morecore>:

static Header*
morecore(uint nu)
{
 73a:	55                   	push   %ebp
 73b:	89 e5                	mov    %esp,%ebp
 73d:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 740:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 747:	77 07                	ja     750 <morecore+0x16>
    nu = 4096;
 749:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 750:	8b 45 08             	mov    0x8(%ebp),%eax
 753:	c1 e0 03             	shl    $0x3,%eax
 756:	83 ec 0c             	sub    $0xc,%esp
 759:	50                   	push   %eax
 75a:	e8 61 fc ff ff       	call   3c0 <sbrk>
 75f:	83 c4 10             	add    $0x10,%esp
 762:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 765:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 769:	75 07                	jne    772 <morecore+0x38>
    return 0;
 76b:	b8 00 00 00 00       	mov    $0x0,%eax
 770:	eb 26                	jmp    798 <morecore+0x5e>
  hp = (Header*)p;
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 778:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77b:	8b 55 08             	mov    0x8(%ebp),%edx
 77e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	83 c0 08             	add    $0x8,%eax
 787:	83 ec 0c             	sub    $0xc,%esp
 78a:	50                   	push   %eax
 78b:	e8 c8 fe ff ff       	call   658 <free>
 790:	83 c4 10             	add    $0x10,%esp
  return freep;
 793:	a1 88 0b 00 00       	mov    0xb88,%eax
}
 798:	c9                   	leave  
 799:	c3                   	ret    

0000079a <malloc>:

void*
malloc(uint nbytes)
{
 79a:	55                   	push   %ebp
 79b:	89 e5                	mov    %esp,%ebp
 79d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a0:	8b 45 08             	mov    0x8(%ebp),%eax
 7a3:	83 c0 07             	add    $0x7,%eax
 7a6:	c1 e8 03             	shr    $0x3,%eax
 7a9:	83 c0 01             	add    $0x1,%eax
 7ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7af:	a1 88 0b 00 00       	mov    0xb88,%eax
 7b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7bb:	75 23                	jne    7e0 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7bd:	c7 45 f0 80 0b 00 00 	movl   $0xb80,-0x10(%ebp)
 7c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c7:	a3 88 0b 00 00       	mov    %eax,0xb88
 7cc:	a1 88 0b 00 00       	mov    0xb88,%eax
 7d1:	a3 80 0b 00 00       	mov    %eax,0xb80
    base.s.size = 0;
 7d6:	c7 05 84 0b 00 00 00 	movl   $0x0,0xb84
 7dd:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e3:	8b 00                	mov    (%eax),%eax
 7e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	8b 40 04             	mov    0x4(%eax),%eax
 7ee:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f1:	72 4d                	jb     840 <malloc+0xa6>
      if(p->s.size == nunits)
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fc:	75 0c                	jne    80a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 801:	8b 10                	mov    (%eax),%edx
 803:	8b 45 f0             	mov    -0x10(%ebp),%eax
 806:	89 10                	mov    %edx,(%eax)
 808:	eb 26                	jmp    830 <malloc+0x96>
      else {
        p->s.size -= nunits;
 80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80d:	8b 40 04             	mov    0x4(%eax),%eax
 810:	2b 45 ec             	sub    -0x14(%ebp),%eax
 813:	89 c2                	mov    %eax,%edx
 815:	8b 45 f4             	mov    -0xc(%ebp),%eax
 818:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81e:	8b 40 04             	mov    0x4(%eax),%eax
 821:	c1 e0 03             	shl    $0x3,%eax
 824:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 82d:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 830:	8b 45 f0             	mov    -0x10(%ebp),%eax
 833:	a3 88 0b 00 00       	mov    %eax,0xb88
      return (void*)(p + 1);
 838:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83b:	83 c0 08             	add    $0x8,%eax
 83e:	eb 3b                	jmp    87b <malloc+0xe1>
    }
    if(p == freep)
 840:	a1 88 0b 00 00       	mov    0xb88,%eax
 845:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 848:	75 1e                	jne    868 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 84a:	83 ec 0c             	sub    $0xc,%esp
 84d:	ff 75 ec             	pushl  -0x14(%ebp)
 850:	e8 e5 fe ff ff       	call   73a <morecore>
 855:	83 c4 10             	add    $0x10,%esp
 858:	89 45 f4             	mov    %eax,-0xc(%ebp)
 85b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85f:	75 07                	jne    868 <malloc+0xce>
        return 0;
 861:	b8 00 00 00 00       	mov    $0x0,%eax
 866:	eb 13                	jmp    87b <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 868:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 871:	8b 00                	mov    (%eax),%eax
 873:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 876:	e9 6d ff ff ff       	jmp    7e8 <malloc+0x4e>
}
 87b:	c9                   	leave  
 87c:	c3                   	ret    
