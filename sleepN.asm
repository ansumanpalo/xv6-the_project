
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
  18:	e8 17 03 00 00       	call   334 <exit>
  }
  int i = atoi(argv[1]);
  1d:	8b 40 04             	mov    0x4(%eax),%eax
  20:	83 c0 04             	add    $0x4,%eax
  23:	8b 00                	mov    (%eax),%eax
  25:	83 ec 0c             	sub    $0xc,%esp
  28:	50                   	push   %eax
  29:	e8 23 02 00 00       	call   251 <atoi>
  2e:	83 c4 10             	add    $0x10,%esp
  31:	89 45 f4             	mov    %eax,-0xc(%ebp)
  printf(1,"SleepN: Going to sleep \n");
  34:	83 ec 08             	sub    $0x8,%esp
  37:	68 79 08 00 00       	push   $0x879
  3c:	6a 01                	push   $0x1
  3e:	e8 80 04 00 00       	call   4c3 <printf>
  43:	83 c4 10             	add    $0x10,%esp
  sleep(1000*i/14);
  46:	8b 45 f4             	mov    -0xc(%ebp),%eax
  49:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
  4f:	ba 93 24 49 92       	mov    $0x92492493,%edx
  54:	89 c8                	mov    %ecx,%eax
  56:	f7 ea                	imul   %edx
  58:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  5b:	c1 f8 03             	sar    $0x3,%eax
  5e:	89 c2                	mov    %eax,%edx
  60:	89 c8                	mov    %ecx,%eax
  62:	c1 f8 1f             	sar    $0x1f,%eax
  65:	29 c2                	sub    %eax,%edx
  67:	89 d0                	mov    %edx,%eax
  69:	83 ec 0c             	sub    $0xc,%esp
  6c:	50                   	push   %eax
  6d:	e8 52 03 00 00       	call   3c4 <sleep>
  72:	83 c4 10             	add    $0x10,%esp
  printf(1,"SleepN: Slept \n");
  75:	83 ec 08             	sub    $0x8,%esp
  78:	68 92 08 00 00       	push   $0x892
  7d:	6a 01                	push   $0x1
  7f:	e8 3f 04 00 00       	call   4c3 <printf>
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
 2b6:	0f b6 80 a2 08 00 00 	movzbl 0x8a2(%eax),%eax
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

000003ec <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ec:	55                   	push   %ebp
 3ed:	89 e5                	mov    %esp,%ebp
 3ef:	83 ec 18             	sub    $0x18,%esp
 3f2:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f5:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3f8:	83 ec 04             	sub    $0x4,%esp
 3fb:	6a 01                	push   $0x1
 3fd:	8d 45 f4             	lea    -0xc(%ebp),%eax
 400:	50                   	push   %eax
 401:	ff 75 08             	pushl  0x8(%ebp)
 404:	e8 4b ff ff ff       	call   354 <write>
 409:	83 c4 10             	add    $0x10,%esp
}
 40c:	90                   	nop
 40d:	c9                   	leave  
 40e:	c3                   	ret    

0000040f <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 40f:	55                   	push   %ebp
 410:	89 e5                	mov    %esp,%ebp
 412:	53                   	push   %ebx
 413:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 416:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 41d:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 421:	74 17                	je     43a <printint+0x2b>
 423:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 427:	79 11                	jns    43a <printint+0x2b>
    neg = 1;
 429:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 430:	8b 45 0c             	mov    0xc(%ebp),%eax
 433:	f7 d8                	neg    %eax
 435:	89 45 ec             	mov    %eax,-0x14(%ebp)
 438:	eb 06                	jmp    440 <printint+0x31>
  } else {
    x = xx;
 43a:	8b 45 0c             	mov    0xc(%ebp),%eax
 43d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 440:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 447:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 44a:	8d 41 01             	lea    0x1(%ecx),%eax
 44d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 450:	8b 5d 10             	mov    0x10(%ebp),%ebx
 453:	8b 45 ec             	mov    -0x14(%ebp),%eax
 456:	ba 00 00 00 00       	mov    $0x0,%edx
 45b:	f7 f3                	div    %ebx
 45d:	89 d0                	mov    %edx,%eax
 45f:	0f b6 80 24 0b 00 00 	movzbl 0xb24(%eax),%eax
 466:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 46a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 46d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 470:	ba 00 00 00 00       	mov    $0x0,%edx
 475:	f7 f3                	div    %ebx
 477:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 47e:	75 c7                	jne    447 <printint+0x38>
  if(neg)
 480:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 484:	74 2d                	je     4b3 <printint+0xa4>
    buf[i++] = '-';
 486:	8b 45 f4             	mov    -0xc(%ebp),%eax
 489:	8d 50 01             	lea    0x1(%eax),%edx
 48c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 48f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 494:	eb 1d                	jmp    4b3 <printint+0xa4>
    putc(fd, buf[i]);
 496:	8d 55 dc             	lea    -0x24(%ebp),%edx
 499:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49c:	01 d0                	add    %edx,%eax
 49e:	0f b6 00             	movzbl (%eax),%eax
 4a1:	0f be c0             	movsbl %al,%eax
 4a4:	83 ec 08             	sub    $0x8,%esp
 4a7:	50                   	push   %eax
 4a8:	ff 75 08             	pushl  0x8(%ebp)
 4ab:	e8 3c ff ff ff       	call   3ec <putc>
 4b0:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b3:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4bb:	79 d9                	jns    496 <printint+0x87>
    putc(fd, buf[i]);
}
 4bd:	90                   	nop
 4be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c1:	c9                   	leave  
 4c2:	c3                   	ret    

000004c3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c3:	55                   	push   %ebp
 4c4:	89 e5                	mov    %esp,%ebp
 4c6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4d0:	8d 45 0c             	lea    0xc(%ebp),%eax
 4d3:	83 c0 04             	add    $0x4,%eax
 4d6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4d9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e0:	e9 59 01 00 00       	jmp    63e <printf+0x17b>
    c = fmt[i] & 0xff;
 4e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4eb:	01 d0                	add    %edx,%eax
 4ed:	0f b6 00             	movzbl (%eax),%eax
 4f0:	0f be c0             	movsbl %al,%eax
 4f3:	25 ff 00 00 00       	and    $0xff,%eax
 4f8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4fb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ff:	75 2c                	jne    52d <printf+0x6a>
      if(c == '%'){
 501:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 505:	75 0c                	jne    513 <printf+0x50>
        state = '%';
 507:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 50e:	e9 27 01 00 00       	jmp    63a <printf+0x177>
      } else {
        putc(fd, c);
 513:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 516:	0f be c0             	movsbl %al,%eax
 519:	83 ec 08             	sub    $0x8,%esp
 51c:	50                   	push   %eax
 51d:	ff 75 08             	pushl  0x8(%ebp)
 520:	e8 c7 fe ff ff       	call   3ec <putc>
 525:	83 c4 10             	add    $0x10,%esp
 528:	e9 0d 01 00 00       	jmp    63a <printf+0x177>
      }
    } else if(state == '%'){
 52d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 531:	0f 85 03 01 00 00    	jne    63a <printf+0x177>
      if(c == 'd'){
 537:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 53b:	75 1e                	jne    55b <printf+0x98>
        printint(fd, *ap, 10, 1);
 53d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 540:	8b 00                	mov    (%eax),%eax
 542:	6a 01                	push   $0x1
 544:	6a 0a                	push   $0xa
 546:	50                   	push   %eax
 547:	ff 75 08             	pushl  0x8(%ebp)
 54a:	e8 c0 fe ff ff       	call   40f <printint>
 54f:	83 c4 10             	add    $0x10,%esp
        ap++;
 552:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 556:	e9 d8 00 00 00       	jmp    633 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 55b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 55f:	74 06                	je     567 <printf+0xa4>
 561:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 565:	75 1e                	jne    585 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 567:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56a:	8b 00                	mov    (%eax),%eax
 56c:	6a 00                	push   $0x0
 56e:	6a 10                	push   $0x10
 570:	50                   	push   %eax
 571:	ff 75 08             	pushl  0x8(%ebp)
 574:	e8 96 fe ff ff       	call   40f <printint>
 579:	83 c4 10             	add    $0x10,%esp
        ap++;
 57c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 580:	e9 ae 00 00 00       	jmp    633 <printf+0x170>
      } else if(c == 's'){
 585:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 589:	75 43                	jne    5ce <printf+0x10b>
        s = (char*)*ap;
 58b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 58e:	8b 00                	mov    (%eax),%eax
 590:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 593:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 597:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 59b:	75 25                	jne    5c2 <printf+0xff>
          s = "(null)";
 59d:	c7 45 f4 b3 08 00 00 	movl   $0x8b3,-0xc(%ebp)
        while(*s != 0){
 5a4:	eb 1c                	jmp    5c2 <printf+0xff>
          putc(fd, *s);
 5a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a9:	0f b6 00             	movzbl (%eax),%eax
 5ac:	0f be c0             	movsbl %al,%eax
 5af:	83 ec 08             	sub    $0x8,%esp
 5b2:	50                   	push   %eax
 5b3:	ff 75 08             	pushl  0x8(%ebp)
 5b6:	e8 31 fe ff ff       	call   3ec <putc>
 5bb:	83 c4 10             	add    $0x10,%esp
          s++;
 5be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c5:	0f b6 00             	movzbl (%eax),%eax
 5c8:	84 c0                	test   %al,%al
 5ca:	75 da                	jne    5a6 <printf+0xe3>
 5cc:	eb 65                	jmp    633 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5ce:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d2:	75 1d                	jne    5f1 <printf+0x12e>
        putc(fd, *ap);
 5d4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d7:	8b 00                	mov    (%eax),%eax
 5d9:	0f be c0             	movsbl %al,%eax
 5dc:	83 ec 08             	sub    $0x8,%esp
 5df:	50                   	push   %eax
 5e0:	ff 75 08             	pushl  0x8(%ebp)
 5e3:	e8 04 fe ff ff       	call   3ec <putc>
 5e8:	83 c4 10             	add    $0x10,%esp
        ap++;
 5eb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ef:	eb 42                	jmp    633 <printf+0x170>
      } else if(c == '%'){
 5f1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f5:	75 17                	jne    60e <printf+0x14b>
        putc(fd, c);
 5f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fa:	0f be c0             	movsbl %al,%eax
 5fd:	83 ec 08             	sub    $0x8,%esp
 600:	50                   	push   %eax
 601:	ff 75 08             	pushl  0x8(%ebp)
 604:	e8 e3 fd ff ff       	call   3ec <putc>
 609:	83 c4 10             	add    $0x10,%esp
 60c:	eb 25                	jmp    633 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 60e:	83 ec 08             	sub    $0x8,%esp
 611:	6a 25                	push   $0x25
 613:	ff 75 08             	pushl  0x8(%ebp)
 616:	e8 d1 fd ff ff       	call   3ec <putc>
 61b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 61e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 621:	0f be c0             	movsbl %al,%eax
 624:	83 ec 08             	sub    $0x8,%esp
 627:	50                   	push   %eax
 628:	ff 75 08             	pushl  0x8(%ebp)
 62b:	e8 bc fd ff ff       	call   3ec <putc>
 630:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 633:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 63e:	8b 55 0c             	mov    0xc(%ebp),%edx
 641:	8b 45 f0             	mov    -0x10(%ebp),%eax
 644:	01 d0                	add    %edx,%eax
 646:	0f b6 00             	movzbl (%eax),%eax
 649:	84 c0                	test   %al,%al
 64b:	0f 85 94 fe ff ff    	jne    4e5 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 651:	90                   	nop
 652:	c9                   	leave  
 653:	c3                   	ret    

00000654 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 654:	55                   	push   %ebp
 655:	89 e5                	mov    %esp,%ebp
 657:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65a:	8b 45 08             	mov    0x8(%ebp),%eax
 65d:	83 e8 08             	sub    $0x8,%eax
 660:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 663:	a1 68 0b 00 00       	mov    0xb68,%eax
 668:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66b:	eb 24                	jmp    691 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 12                	ja     689 <free+0x35>
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	77 24                	ja     6a3 <free+0x4f>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 687:	77 1a                	ja     6a3 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 689:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68c:	8b 00                	mov    (%eax),%eax
 68e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 691:	8b 45 f8             	mov    -0x8(%ebp),%eax
 694:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 697:	76 d4                	jbe    66d <free+0x19>
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a1:	76 ca                	jbe    66d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a6:	8b 40 04             	mov    0x4(%eax),%eax
 6a9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	01 c2                	add    %eax,%edx
 6b5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b8:	8b 00                	mov    (%eax),%eax
 6ba:	39 c2                	cmp    %eax,%edx
 6bc:	75 24                	jne    6e2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c1:	8b 50 04             	mov    0x4(%eax),%edx
 6c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	8b 40 04             	mov    0x4(%eax),%eax
 6cc:	01 c2                	add    %eax,%edx
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
 6e0:	eb 0a                	jmp    6ec <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 10                	mov    (%eax),%edx
 6e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ea:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 40 04             	mov    0x4(%eax),%eax
 6f2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	01 d0                	add    %edx,%eax
 6fe:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 701:	75 20                	jne    723 <free+0xcf>
    p->s.size += bp->s.size;
 703:	8b 45 fc             	mov    -0x4(%ebp),%eax
 706:	8b 50 04             	mov    0x4(%eax),%edx
 709:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70c:	8b 40 04             	mov    0x4(%eax),%eax
 70f:	01 c2                	add    %eax,%edx
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	8b 10                	mov    (%eax),%edx
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	89 10                	mov    %edx,(%eax)
 721:	eb 08                	jmp    72b <free+0xd7>
  } else
    p->s.ptr = bp;
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	8b 55 f8             	mov    -0x8(%ebp),%edx
 729:	89 10                	mov    %edx,(%eax)
  freep = p;
 72b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72e:	a3 68 0b 00 00       	mov    %eax,0xb68
}
 733:	90                   	nop
 734:	c9                   	leave  
 735:	c3                   	ret    

00000736 <morecore>:

static Header*
morecore(uint nu)
{
 736:	55                   	push   %ebp
 737:	89 e5                	mov    %esp,%ebp
 739:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 73c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 743:	77 07                	ja     74c <morecore+0x16>
    nu = 4096;
 745:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 74c:	8b 45 08             	mov    0x8(%ebp),%eax
 74f:	c1 e0 03             	shl    $0x3,%eax
 752:	83 ec 0c             	sub    $0xc,%esp
 755:	50                   	push   %eax
 756:	e8 61 fc ff ff       	call   3bc <sbrk>
 75b:	83 c4 10             	add    $0x10,%esp
 75e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 761:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 765:	75 07                	jne    76e <morecore+0x38>
    return 0;
 767:	b8 00 00 00 00       	mov    $0x0,%eax
 76c:	eb 26                	jmp    794 <morecore+0x5e>
  hp = (Header*)p;
 76e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 771:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 774:	8b 45 f0             	mov    -0x10(%ebp),%eax
 777:	8b 55 08             	mov    0x8(%ebp),%edx
 77a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 77d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 780:	83 c0 08             	add    $0x8,%eax
 783:	83 ec 0c             	sub    $0xc,%esp
 786:	50                   	push   %eax
 787:	e8 c8 fe ff ff       	call   654 <free>
 78c:	83 c4 10             	add    $0x10,%esp
  return freep;
 78f:	a1 68 0b 00 00       	mov    0xb68,%eax
}
 794:	c9                   	leave  
 795:	c3                   	ret    

00000796 <malloc>:

void*
malloc(uint nbytes)
{
 796:	55                   	push   %ebp
 797:	89 e5                	mov    %esp,%ebp
 799:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79c:	8b 45 08             	mov    0x8(%ebp),%eax
 79f:	83 c0 07             	add    $0x7,%eax
 7a2:	c1 e8 03             	shr    $0x3,%eax
 7a5:	83 c0 01             	add    $0x1,%eax
 7a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7ab:	a1 68 0b 00 00       	mov    0xb68,%eax
 7b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7b7:	75 23                	jne    7dc <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7b9:	c7 45 f0 60 0b 00 00 	movl   $0xb60,-0x10(%ebp)
 7c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c3:	a3 68 0b 00 00       	mov    %eax,0xb68
 7c8:	a1 68 0b 00 00       	mov    0xb68,%eax
 7cd:	a3 60 0b 00 00       	mov    %eax,0xb60
    base.s.size = 0;
 7d2:	c7 05 64 0b 00 00 00 	movl   $0x0,0xb64
 7d9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7df:	8b 00                	mov    (%eax),%eax
 7e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e7:	8b 40 04             	mov    0x4(%eax),%eax
 7ea:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ed:	72 4d                	jb     83c <malloc+0xa6>
      if(p->s.size == nunits)
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	8b 40 04             	mov    0x4(%eax),%eax
 7f5:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f8:	75 0c                	jne    806 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fd:	8b 10                	mov    (%eax),%edx
 7ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 802:	89 10                	mov    %edx,(%eax)
 804:	eb 26                	jmp    82c <malloc+0x96>
      else {
        p->s.size -= nunits;
 806:	8b 45 f4             	mov    -0xc(%ebp),%eax
 809:	8b 40 04             	mov    0x4(%eax),%eax
 80c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 80f:	89 c2                	mov    %eax,%edx
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 817:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81a:	8b 40 04             	mov    0x4(%eax),%eax
 81d:	c1 e0 03             	shl    $0x3,%eax
 820:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 823:	8b 45 f4             	mov    -0xc(%ebp),%eax
 826:	8b 55 ec             	mov    -0x14(%ebp),%edx
 829:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 82c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82f:	a3 68 0b 00 00       	mov    %eax,0xb68
      return (void*)(p + 1);
 834:	8b 45 f4             	mov    -0xc(%ebp),%eax
 837:	83 c0 08             	add    $0x8,%eax
 83a:	eb 3b                	jmp    877 <malloc+0xe1>
    }
    if(p == freep)
 83c:	a1 68 0b 00 00       	mov    0xb68,%eax
 841:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 844:	75 1e                	jne    864 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 846:	83 ec 0c             	sub    $0xc,%esp
 849:	ff 75 ec             	pushl  -0x14(%ebp)
 84c:	e8 e5 fe ff ff       	call   736 <morecore>
 851:	83 c4 10             	add    $0x10,%esp
 854:	89 45 f4             	mov    %eax,-0xc(%ebp)
 857:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85b:	75 07                	jne    864 <malloc+0xce>
        return 0;
 85d:	b8 00 00 00 00       	mov    $0x0,%eax
 862:	eb 13                	jmp    877 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 864:	8b 45 f4             	mov    -0xc(%ebp),%eax
 867:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86d:	8b 00                	mov    (%eax),%eax
 86f:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 872:	e9 6d ff ff ff       	jmp    7e4 <malloc+0x4e>
}
 877:	c9                   	leave  
 878:	c3                   	ret    
