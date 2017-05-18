
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
  19:	e8 16 03 00 00       	call   334 <exit>
  }
  printf(1, "Hello ");
  1e:	83 ec 08             	sub    $0x8,%esp
  21:	68 81 08 00 00       	push   $0x881
  26:	6a 01                	push   $0x1
  28:	e8 9e 04 00 00       	call   4cb <printf>
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
  50:	e8 76 04 00 00       	call   4cb <printf>
  55:	83 c4 10             	add    $0x10,%esp
    printf(1, " ");
  58:	83 ec 08             	sub    $0x8,%esp
  5b:	68 88 08 00 00       	push   $0x888
  60:	6a 01                	push   $0x1
  62:	e8 64 04 00 00       	call   4cb <printf>
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
  78:	68 8a 08 00 00       	push   $0x88a
  7d:	6a 01                	push   $0x1
  7f:	e8 47 04 00 00       	call   4cb <printf>
  84:	83 c4 10             	add    $0x10,%esp
  exit();
  87:	e8 a8 02 00 00       	call   334 <exit>

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
 1af:	e8 98 01 00 00       	call   34c <read>
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
 212:	e8 5d 01 00 00       	call   374 <open>
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
 233:	e8 54 01 00 00       	call   38c <fstat>
 238:	83 c4 10             	add    $0x10,%esp
 23b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 23e:	83 ec 0c             	sub    $0xc,%esp
 241:	ff 75 f4             	pushl  -0xc(%ebp)
 244:	e8 13 01 00 00       	call   35c <close>
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

0000029e <itoa>:

char*
itoa(int val, int base){
 29e:	55                   	push   %ebp
 29f:	89 e5                	mov    %esp,%ebp
 2a1:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 2a4:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 2ab:	eb 29                	jmp    2d6 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 2ad:	8b 45 08             	mov    0x8(%ebp),%eax
 2b0:	99                   	cltd   
 2b1:	f7 7d 0c             	idivl  0xc(%ebp)
 2b4:	89 d0                	mov    %edx,%eax
 2b6:	0f b6 80 8c 08 00 00 	movzbl 0x88c(%eax),%eax
 2bd:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2c0:	81 c2 40 0b 00 00    	add    $0xb40,%edx
 2c6:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 2c8:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 2cc:	8b 45 08             	mov    0x8(%ebp),%eax
 2cf:	99                   	cltd   
 2d0:	f7 7d 0c             	idivl  0xc(%ebp)
 2d3:	89 45 08             	mov    %eax,0x8(%ebp)
 2d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2da:	74 06                	je     2e2 <itoa+0x44>
 2dc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 2e0:	75 cb                	jne    2ad <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 2e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2e5:	83 c0 01             	add    $0x1,%eax
 2e8:	05 40 0b 00 00       	add    $0xb40,%eax

}
 2ed:	c9                   	leave  
 2ee:	c3                   	ret    

000002ef <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2ef:	55                   	push   %ebp
 2f0:	89 e5                	mov    %esp,%ebp
 2f2:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
 2f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2fb:	8b 45 0c             	mov    0xc(%ebp),%eax
 2fe:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 301:	eb 17                	jmp    31a <memmove+0x2b>
    *dst++ = *src++;
 303:	8b 45 fc             	mov    -0x4(%ebp),%eax
 306:	8d 50 01             	lea    0x1(%eax),%edx
 309:	89 55 fc             	mov    %edx,-0x4(%ebp)
 30c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 30f:	8d 4a 01             	lea    0x1(%edx),%ecx
 312:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 315:	0f b6 12             	movzbl (%edx),%edx
 318:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31a:	8b 45 10             	mov    0x10(%ebp),%eax
 31d:	8d 50 ff             	lea    -0x1(%eax),%edx
 320:	89 55 10             	mov    %edx,0x10(%ebp)
 323:	85 c0                	test   %eax,%eax
 325:	7f dc                	jg     303 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 327:	8b 45 08             	mov    0x8(%ebp),%eax
}
 32a:	c9                   	leave  
 32b:	c3                   	ret    

0000032c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 32c:	b8 01 00 00 00       	mov    $0x1,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <exit>:
SYSCALL(exit)
 334:	b8 02 00 00 00       	mov    $0x2,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <wait>:
SYSCALL(wait)
 33c:	b8 03 00 00 00       	mov    $0x3,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <pipe>:
SYSCALL(pipe)
 344:	b8 04 00 00 00       	mov    $0x4,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <read>:
SYSCALL(read)
 34c:	b8 05 00 00 00       	mov    $0x5,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <write>:
SYSCALL(write)
 354:	b8 10 00 00 00       	mov    $0x10,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <close>:
SYSCALL(close)
 35c:	b8 15 00 00 00       	mov    $0x15,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <kill>:
SYSCALL(kill)
 364:	b8 06 00 00 00       	mov    $0x6,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <exec>:
SYSCALL(exec)
 36c:	b8 07 00 00 00       	mov    $0x7,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <open>:
SYSCALL(open)
 374:	b8 0f 00 00 00       	mov    $0xf,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <mknod>:
SYSCALL(mknod)
 37c:	b8 11 00 00 00       	mov    $0x11,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <unlink>:
SYSCALL(unlink)
 384:	b8 12 00 00 00       	mov    $0x12,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <fstat>:
SYSCALL(fstat)
 38c:	b8 08 00 00 00       	mov    $0x8,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <link>:
SYSCALL(link)
 394:	b8 13 00 00 00       	mov    $0x13,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <mkdir>:
SYSCALL(mkdir)
 39c:	b8 14 00 00 00       	mov    $0x14,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <chdir>:
SYSCALL(chdir)
 3a4:	b8 09 00 00 00       	mov    $0x9,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <dup>:
SYSCALL(dup)
 3ac:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <getpid>:
SYSCALL(getpid)
 3b4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <sbrk>:
SYSCALL(sbrk)
 3bc:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <sleep>:
SYSCALL(sleep)
 3c4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <uptime>:
SYSCALL(uptime)
 3cc:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <randomX>:
SYSCALL(randomX)
 3d4:	b8 16 00 00 00       	mov    $0x16,%eax
 3d9:	cd 40                	int    $0x40
 3db:	c3                   	ret    

000003dc <setSeedX>:
SYSCALL(setSeedX)
 3dc:	b8 17 00 00 00       	mov    $0x17,%eax
 3e1:	cd 40                	int    $0x40
 3e3:	c3                   	ret    

000003e4 <uniformR>:
SYSCALL(uniformR)
 3e4:	b8 18 00 00 00       	mov    $0x18,%eax
 3e9:	cd 40                	int    $0x40
 3eb:	c3                   	ret    

000003ec <setdeadline>:
 3ec:	b8 19 00 00 00       	mov    $0x19,%eax
 3f1:	cd 40                	int    $0x40
 3f3:	c3                   	ret    

000003f4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f4:	55                   	push   %ebp
 3f5:	89 e5                	mov    %esp,%ebp
 3f7:	83 ec 18             	sub    $0x18,%esp
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 400:	83 ec 04             	sub    $0x4,%esp
 403:	6a 01                	push   $0x1
 405:	8d 45 f4             	lea    -0xc(%ebp),%eax
 408:	50                   	push   %eax
 409:	ff 75 08             	pushl  0x8(%ebp)
 40c:	e8 43 ff ff ff       	call   354 <write>
 411:	83 c4 10             	add    $0x10,%esp
}
 414:	90                   	nop
 415:	c9                   	leave  
 416:	c3                   	ret    

00000417 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 417:	55                   	push   %ebp
 418:	89 e5                	mov    %esp,%ebp
 41a:	53                   	push   %ebx
 41b:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 41e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 425:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 429:	74 17                	je     442 <printint+0x2b>
 42b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 42f:	79 11                	jns    442 <printint+0x2b>
    neg = 1;
 431:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 438:	8b 45 0c             	mov    0xc(%ebp),%eax
 43b:	f7 d8                	neg    %eax
 43d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 440:	eb 06                	jmp    448 <printint+0x31>
  } else {
    x = xx;
 442:	8b 45 0c             	mov    0xc(%ebp),%eax
 445:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 448:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 44f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 452:	8d 41 01             	lea    0x1(%ecx),%eax
 455:	89 45 f4             	mov    %eax,-0xc(%ebp)
 458:	8b 5d 10             	mov    0x10(%ebp),%ebx
 45b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45e:	ba 00 00 00 00       	mov    $0x0,%edx
 463:	f7 f3                	div    %ebx
 465:	89 d0                	mov    %edx,%eax
 467:	0f b6 80 10 0b 00 00 	movzbl 0xb10(%eax),%eax
 46e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 472:	8b 5d 10             	mov    0x10(%ebp),%ebx
 475:	8b 45 ec             	mov    -0x14(%ebp),%eax
 478:	ba 00 00 00 00       	mov    $0x0,%edx
 47d:	f7 f3                	div    %ebx
 47f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 482:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 486:	75 c7                	jne    44f <printint+0x38>
  if(neg)
 488:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 48c:	74 2d                	je     4bb <printint+0xa4>
    buf[i++] = '-';
 48e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 491:	8d 50 01             	lea    0x1(%eax),%edx
 494:	89 55 f4             	mov    %edx,-0xc(%ebp)
 497:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 49c:	eb 1d                	jmp    4bb <printint+0xa4>
    putc(fd, buf[i]);
 49e:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a4:	01 d0                	add    %edx,%eax
 4a6:	0f b6 00             	movzbl (%eax),%eax
 4a9:	0f be c0             	movsbl %al,%eax
 4ac:	83 ec 08             	sub    $0x8,%esp
 4af:	50                   	push   %eax
 4b0:	ff 75 08             	pushl  0x8(%ebp)
 4b3:	e8 3c ff ff ff       	call   3f4 <putc>
 4b8:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4bb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4bf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4c3:	79 d9                	jns    49e <printint+0x87>
    putc(fd, buf[i]);
}
 4c5:	90                   	nop
 4c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c9:	c9                   	leave  
 4ca:	c3                   	ret    

000004cb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4cb:	55                   	push   %ebp
 4cc:	89 e5                	mov    %esp,%ebp
 4ce:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4d8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4db:	83 c0 04             	add    $0x4,%eax
 4de:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e8:	e9 59 01 00 00       	jmp    646 <printf+0x17b>
    c = fmt[i] & 0xff;
 4ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 4f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4f3:	01 d0                	add    %edx,%eax
 4f5:	0f b6 00             	movzbl (%eax),%eax
 4f8:	0f be c0             	movsbl %al,%eax
 4fb:	25 ff 00 00 00       	and    $0xff,%eax
 500:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 503:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 507:	75 2c                	jne    535 <printf+0x6a>
      if(c == '%'){
 509:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 50d:	75 0c                	jne    51b <printf+0x50>
        state = '%';
 50f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 516:	e9 27 01 00 00       	jmp    642 <printf+0x177>
      } else {
        putc(fd, c);
 51b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 51e:	0f be c0             	movsbl %al,%eax
 521:	83 ec 08             	sub    $0x8,%esp
 524:	50                   	push   %eax
 525:	ff 75 08             	pushl  0x8(%ebp)
 528:	e8 c7 fe ff ff       	call   3f4 <putc>
 52d:	83 c4 10             	add    $0x10,%esp
 530:	e9 0d 01 00 00       	jmp    642 <printf+0x177>
      }
    } else if(state == '%'){
 535:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 539:	0f 85 03 01 00 00    	jne    642 <printf+0x177>
      if(c == 'd'){
 53f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 543:	75 1e                	jne    563 <printf+0x98>
        printint(fd, *ap, 10, 1);
 545:	8b 45 e8             	mov    -0x18(%ebp),%eax
 548:	8b 00                	mov    (%eax),%eax
 54a:	6a 01                	push   $0x1
 54c:	6a 0a                	push   $0xa
 54e:	50                   	push   %eax
 54f:	ff 75 08             	pushl  0x8(%ebp)
 552:	e8 c0 fe ff ff       	call   417 <printint>
 557:	83 c4 10             	add    $0x10,%esp
        ap++;
 55a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 55e:	e9 d8 00 00 00       	jmp    63b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 563:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 567:	74 06                	je     56f <printf+0xa4>
 569:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 56d:	75 1e                	jne    58d <printf+0xc2>
        printint(fd, *ap, 16, 0);
 56f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 572:	8b 00                	mov    (%eax),%eax
 574:	6a 00                	push   $0x0
 576:	6a 10                	push   $0x10
 578:	50                   	push   %eax
 579:	ff 75 08             	pushl  0x8(%ebp)
 57c:	e8 96 fe ff ff       	call   417 <printint>
 581:	83 c4 10             	add    $0x10,%esp
        ap++;
 584:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 588:	e9 ae 00 00 00       	jmp    63b <printf+0x170>
      } else if(c == 's'){
 58d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 591:	75 43                	jne    5d6 <printf+0x10b>
        s = (char*)*ap;
 593:	8b 45 e8             	mov    -0x18(%ebp),%eax
 596:	8b 00                	mov    (%eax),%eax
 598:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 59b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 59f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a3:	75 25                	jne    5ca <printf+0xff>
          s = "(null)";
 5a5:	c7 45 f4 9d 08 00 00 	movl   $0x89d,-0xc(%ebp)
        while(*s != 0){
 5ac:	eb 1c                	jmp    5ca <printf+0xff>
          putc(fd, *s);
 5ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b1:	0f b6 00             	movzbl (%eax),%eax
 5b4:	0f be c0             	movsbl %al,%eax
 5b7:	83 ec 08             	sub    $0x8,%esp
 5ba:	50                   	push   %eax
 5bb:	ff 75 08             	pushl  0x8(%ebp)
 5be:	e8 31 fe ff ff       	call   3f4 <putc>
 5c3:	83 c4 10             	add    $0x10,%esp
          s++;
 5c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5cd:	0f b6 00             	movzbl (%eax),%eax
 5d0:	84 c0                	test   %al,%al
 5d2:	75 da                	jne    5ae <printf+0xe3>
 5d4:	eb 65                	jmp    63b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5da:	75 1d                	jne    5f9 <printf+0x12e>
        putc(fd, *ap);
 5dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5df:	8b 00                	mov    (%eax),%eax
 5e1:	0f be c0             	movsbl %al,%eax
 5e4:	83 ec 08             	sub    $0x8,%esp
 5e7:	50                   	push   %eax
 5e8:	ff 75 08             	pushl  0x8(%ebp)
 5eb:	e8 04 fe ff ff       	call   3f4 <putc>
 5f0:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f7:	eb 42                	jmp    63b <printf+0x170>
      } else if(c == '%'){
 5f9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5fd:	75 17                	jne    616 <printf+0x14b>
        putc(fd, c);
 5ff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 602:	0f be c0             	movsbl %al,%eax
 605:	83 ec 08             	sub    $0x8,%esp
 608:	50                   	push   %eax
 609:	ff 75 08             	pushl  0x8(%ebp)
 60c:	e8 e3 fd ff ff       	call   3f4 <putc>
 611:	83 c4 10             	add    $0x10,%esp
 614:	eb 25                	jmp    63b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 616:	83 ec 08             	sub    $0x8,%esp
 619:	6a 25                	push   $0x25
 61b:	ff 75 08             	pushl  0x8(%ebp)
 61e:	e8 d1 fd ff ff       	call   3f4 <putc>
 623:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 626:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 629:	0f be c0             	movsbl %al,%eax
 62c:	83 ec 08             	sub    $0x8,%esp
 62f:	50                   	push   %eax
 630:	ff 75 08             	pushl  0x8(%ebp)
 633:	e8 bc fd ff ff       	call   3f4 <putc>
 638:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 63b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 642:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 646:	8b 55 0c             	mov    0xc(%ebp),%edx
 649:	8b 45 f0             	mov    -0x10(%ebp),%eax
 64c:	01 d0                	add    %edx,%eax
 64e:	0f b6 00             	movzbl (%eax),%eax
 651:	84 c0                	test   %al,%al
 653:	0f 85 94 fe ff ff    	jne    4ed <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 659:	90                   	nop
 65a:	c9                   	leave  
 65b:	c3                   	ret    

0000065c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 65c:	55                   	push   %ebp
 65d:	89 e5                	mov    %esp,%ebp
 65f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 662:	8b 45 08             	mov    0x8(%ebp),%eax
 665:	83 e8 08             	sub    $0x8,%eax
 668:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66b:	a1 68 0b 00 00       	mov    0xb68,%eax
 670:	89 45 fc             	mov    %eax,-0x4(%ebp)
 673:	eb 24                	jmp    699 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 675:	8b 45 fc             	mov    -0x4(%ebp),%eax
 678:	8b 00                	mov    (%eax),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	77 12                	ja     691 <free+0x35>
 67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 682:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 685:	77 24                	ja     6ab <free+0x4f>
 687:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68a:	8b 00                	mov    (%eax),%eax
 68c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 68f:	77 1a                	ja     6ab <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	89 45 fc             	mov    %eax,-0x4(%ebp)
 699:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69f:	76 d4                	jbe    675 <free+0x19>
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 00                	mov    (%eax),%eax
 6a6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a9:	76 ca                	jbe    675 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ae:	8b 40 04             	mov    0x4(%eax),%eax
 6b1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bb:	01 c2                	add    %eax,%edx
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	8b 00                	mov    (%eax),%eax
 6c2:	39 c2                	cmp    %eax,%edx
 6c4:	75 24                	jne    6ea <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c9:	8b 50 04             	mov    0x4(%eax),%edx
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	8b 00                	mov    (%eax),%eax
 6d1:	8b 40 04             	mov    0x4(%eax),%eax
 6d4:	01 c2                	add    %eax,%edx
 6d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6df:	8b 00                	mov    (%eax),%eax
 6e1:	8b 10                	mov    (%eax),%edx
 6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e6:	89 10                	mov    %edx,(%eax)
 6e8:	eb 0a                	jmp    6f4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ed:	8b 10                	mov    (%eax),%edx
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f7:	8b 40 04             	mov    0x4(%eax),%eax
 6fa:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 701:	8b 45 fc             	mov    -0x4(%ebp),%eax
 704:	01 d0                	add    %edx,%eax
 706:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 709:	75 20                	jne    72b <free+0xcf>
    p->s.size += bp->s.size;
 70b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70e:	8b 50 04             	mov    0x4(%eax),%edx
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	8b 40 04             	mov    0x4(%eax),%eax
 717:	01 c2                	add    %eax,%edx
 719:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 71f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 722:	8b 10                	mov    (%eax),%edx
 724:	8b 45 fc             	mov    -0x4(%ebp),%eax
 727:	89 10                	mov    %edx,(%eax)
 729:	eb 08                	jmp    733 <free+0xd7>
  } else
    p->s.ptr = bp;
 72b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 731:	89 10                	mov    %edx,(%eax)
  freep = p;
 733:	8b 45 fc             	mov    -0x4(%ebp),%eax
 736:	a3 68 0b 00 00       	mov    %eax,0xb68
}
 73b:	90                   	nop
 73c:	c9                   	leave  
 73d:	c3                   	ret    

0000073e <morecore>:

static Header*
morecore(uint nu)
{
 73e:	55                   	push   %ebp
 73f:	89 e5                	mov    %esp,%ebp
 741:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 744:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 74b:	77 07                	ja     754 <morecore+0x16>
    nu = 4096;
 74d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 754:	8b 45 08             	mov    0x8(%ebp),%eax
 757:	c1 e0 03             	shl    $0x3,%eax
 75a:	83 ec 0c             	sub    $0xc,%esp
 75d:	50                   	push   %eax
 75e:	e8 59 fc ff ff       	call   3bc <sbrk>
 763:	83 c4 10             	add    $0x10,%esp
 766:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 769:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 76d:	75 07                	jne    776 <morecore+0x38>
    return 0;
 76f:	b8 00 00 00 00       	mov    $0x0,%eax
 774:	eb 26                	jmp    79c <morecore+0x5e>
  hp = (Header*)p;
 776:	8b 45 f4             	mov    -0xc(%ebp),%eax
 779:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 77c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77f:	8b 55 08             	mov    0x8(%ebp),%edx
 782:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 785:	8b 45 f0             	mov    -0x10(%ebp),%eax
 788:	83 c0 08             	add    $0x8,%eax
 78b:	83 ec 0c             	sub    $0xc,%esp
 78e:	50                   	push   %eax
 78f:	e8 c8 fe ff ff       	call   65c <free>
 794:	83 c4 10             	add    $0x10,%esp
  return freep;
 797:	a1 68 0b 00 00       	mov    0xb68,%eax
}
 79c:	c9                   	leave  
 79d:	c3                   	ret    

0000079e <malloc>:

void*
malloc(uint nbytes)
{
 79e:	55                   	push   %ebp
 79f:	89 e5                	mov    %esp,%ebp
 7a1:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a4:	8b 45 08             	mov    0x8(%ebp),%eax
 7a7:	83 c0 07             	add    $0x7,%eax
 7aa:	c1 e8 03             	shr    $0x3,%eax
 7ad:	83 c0 01             	add    $0x1,%eax
 7b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7b3:	a1 68 0b 00 00       	mov    0xb68,%eax
 7b8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7bb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7bf:	75 23                	jne    7e4 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7c1:	c7 45 f0 60 0b 00 00 	movl   $0xb60,-0x10(%ebp)
 7c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cb:	a3 68 0b 00 00       	mov    %eax,0xb68
 7d0:	a1 68 0b 00 00       	mov    0xb68,%eax
 7d5:	a3 60 0b 00 00       	mov    %eax,0xb60
    base.s.size = 0;
 7da:	c7 05 64 0b 00 00 00 	movl   $0x0,0xb64
 7e1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e7:	8b 00                	mov    (%eax),%eax
 7e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 40 04             	mov    0x4(%eax),%eax
 7f2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f5:	72 4d                	jb     844 <malloc+0xa6>
      if(p->s.size == nunits)
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	8b 40 04             	mov    0x4(%eax),%eax
 7fd:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 800:	75 0c                	jne    80e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 802:	8b 45 f4             	mov    -0xc(%ebp),%eax
 805:	8b 10                	mov    (%eax),%edx
 807:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80a:	89 10                	mov    %edx,(%eax)
 80c:	eb 26                	jmp    834 <malloc+0x96>
      else {
        p->s.size -= nunits;
 80e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 811:	8b 40 04             	mov    0x4(%eax),%eax
 814:	2b 45 ec             	sub    -0x14(%ebp),%eax
 817:	89 c2                	mov    %eax,%edx
 819:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 81f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 822:	8b 40 04             	mov    0x4(%eax),%eax
 825:	c1 e0 03             	shl    $0x3,%eax
 828:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 82b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 831:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 834:	8b 45 f0             	mov    -0x10(%ebp),%eax
 837:	a3 68 0b 00 00       	mov    %eax,0xb68
      return (void*)(p + 1);
 83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83f:	83 c0 08             	add    $0x8,%eax
 842:	eb 3b                	jmp    87f <malloc+0xe1>
    }
    if(p == freep)
 844:	a1 68 0b 00 00       	mov    0xb68,%eax
 849:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 84c:	75 1e                	jne    86c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 84e:	83 ec 0c             	sub    $0xc,%esp
 851:	ff 75 ec             	pushl  -0x14(%ebp)
 854:	e8 e5 fe ff ff       	call   73e <morecore>
 859:	83 c4 10             	add    $0x10,%esp
 85c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 85f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 863:	75 07                	jne    86c <malloc+0xce>
        return 0;
 865:	b8 00 00 00 00       	mov    $0x0,%eax
 86a:	eb 13                	jmp    87f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 86c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 872:	8b 45 f4             	mov    -0xc(%ebp),%eax
 875:	8b 00                	mov    (%eax),%eax
 877:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 87a:	e9 6d ff ff ff       	jmp    7ec <malloc+0x4e>
}
 87f:	c9                   	leave  
 880:	c3                   	ret    
