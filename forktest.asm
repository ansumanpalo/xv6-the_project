
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	pushl  0xc(%ebp)
   c:	e8 97 01 00 00       	call   1a8 <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	pushl  0xc(%ebp)
  1b:	ff 75 08             	pushl  0x8(%ebp)
  1e:	e8 b8 03 00 00       	call   3db <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	90                   	nop
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	55                   	push   %ebp
  2a:	89 e5                	mov    %esp,%ebp
  2c:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	68 7c 04 00 00       	push   $0x47c
  37:	6a 01                	push   $0x1
  39:	e8 c2 ff ff ff       	call   0 <printf>
  3e:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  48:	eb 1d                	jmp    67 <forktest+0x3e>
    pid = fork();
  4a:	e8 64 03 00 00       	call   3b3 <fork>
  4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  56:	78 1a                	js     72 <forktest+0x49>
      break;
    if(pid == 0)
  58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5c:	75 05                	jne    63 <forktest+0x3a>
      exit();
  5e:	e8 58 03 00 00       	call   3bb <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<N; n++){
  63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  67:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  6e:	7e da                	jle    4a <forktest+0x21>
  70:	eb 01                	jmp    73 <forktest+0x4a>
    pid = fork();
    if(pid < 0)
      break;
  72:	90                   	nop
    if(pid == 0)
      exit();
  }
  
  if(n == N){
  73:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  7a:	75 40                	jne    bc <forktest+0x93>
    printf(1, "fork claimed to work N times!\n", N);
  7c:	83 ec 04             	sub    $0x4,%esp
  7f:	68 e8 03 00 00       	push   $0x3e8
  84:	68 88 04 00 00       	push   $0x488
  89:	6a 01                	push   $0x1
  8b:	e8 70 ff ff ff       	call   0 <printf>
  90:	83 c4 10             	add    $0x10,%esp
    exit();
  93:	e8 23 03 00 00       	call   3bb <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
  98:	e8 26 03 00 00       	call   3c3 <wait>
  9d:	85 c0                	test   %eax,%eax
  9f:	79 17                	jns    b8 <forktest+0x8f>
      printf(1, "wait stopped early\n");
  a1:	83 ec 08             	sub    $0x8,%esp
  a4:	68 a7 04 00 00       	push   $0x4a7
  a9:	6a 01                	push   $0x1
  ab:	e8 50 ff ff ff       	call   0 <printf>
  b0:	83 c4 10             	add    $0x10,%esp
      exit();
  b3:	e8 03 03 00 00       	call   3bb <exit>
  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
    exit();
  }
  
  for(; n > 0; n--){
  b8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  c0:	7f d6                	jg     98 <forktest+0x6f>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
  c2:	e8 fc 02 00 00       	call   3c3 <wait>
  c7:	83 f8 ff             	cmp    $0xffffffff,%eax
  ca:	74 17                	je     e3 <forktest+0xba>
    printf(1, "wait got too many\n");
  cc:	83 ec 08             	sub    $0x8,%esp
  cf:	68 bb 04 00 00       	push   $0x4bb
  d4:	6a 01                	push   $0x1
  d6:	e8 25 ff ff ff       	call   0 <printf>
  db:	83 c4 10             	add    $0x10,%esp
    exit();
  de:	e8 d8 02 00 00       	call   3bb <exit>
  }
  
  printf(1, "fork test OK\n");
  e3:	83 ec 08             	sub    $0x8,%esp
  e6:	68 ce 04 00 00       	push   $0x4ce
  eb:	6a 01                	push   $0x1
  ed:	e8 0e ff ff ff       	call   0 <printf>
  f2:	83 c4 10             	add    $0x10,%esp
}
  f5:	90                   	nop
  f6:	c9                   	leave  
  f7:	c3                   	ret    

000000f8 <main>:

int
main(void)
{
  f8:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  fc:	83 e4 f0             	and    $0xfffffff0,%esp
  ff:	ff 71 fc             	pushl  -0x4(%ecx)
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	51                   	push   %ecx
 106:	83 ec 04             	sub    $0x4,%esp
  forktest();
 109:	e8 1b ff ff ff       	call   29 <forktest>
  exit();
 10e:	e8 a8 02 00 00       	call   3bb <exit>

00000113 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 113:	55                   	push   %ebp
 114:	89 e5                	mov    %esp,%ebp
 116:	57                   	push   %edi
 117:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 118:	8b 4d 08             	mov    0x8(%ebp),%ecx
 11b:	8b 55 10             	mov    0x10(%ebp),%edx
 11e:	8b 45 0c             	mov    0xc(%ebp),%eax
 121:	89 cb                	mov    %ecx,%ebx
 123:	89 df                	mov    %ebx,%edi
 125:	89 d1                	mov    %edx,%ecx
 127:	fc                   	cld    
 128:	f3 aa                	rep stos %al,%es:(%edi)
 12a:	89 ca                	mov    %ecx,%edx
 12c:	89 fb                	mov    %edi,%ebx
 12e:	89 5d 08             	mov    %ebx,0x8(%ebp)
 131:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 134:	90                   	nop
 135:	5b                   	pop    %ebx
 136:	5f                   	pop    %edi
 137:	5d                   	pop    %ebp
 138:	c3                   	ret    

00000139 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 139:	55                   	push   %ebp
 13a:	89 e5                	mov    %esp,%ebp
 13c:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13f:	8b 45 08             	mov    0x8(%ebp),%eax
 142:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 145:	90                   	nop
 146:	8b 45 08             	mov    0x8(%ebp),%eax
 149:	8d 50 01             	lea    0x1(%eax),%edx
 14c:	89 55 08             	mov    %edx,0x8(%ebp)
 14f:	8b 55 0c             	mov    0xc(%ebp),%edx
 152:	8d 4a 01             	lea    0x1(%edx),%ecx
 155:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 158:	0f b6 12             	movzbl (%edx),%edx
 15b:	88 10                	mov    %dl,(%eax)
 15d:	0f b6 00             	movzbl (%eax),%eax
 160:	84 c0                	test   %al,%al
 162:	75 e2                	jne    146 <strcpy+0xd>
    ;
  return os;
 164:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 167:	c9                   	leave  
 168:	c3                   	ret    

00000169 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 169:	55                   	push   %ebp
 16a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 16c:	eb 08                	jmp    176 <strcmp+0xd>
    p++, q++;
 16e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 172:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 176:	8b 45 08             	mov    0x8(%ebp),%eax
 179:	0f b6 00             	movzbl (%eax),%eax
 17c:	84 c0                	test   %al,%al
 17e:	74 10                	je     190 <strcmp+0x27>
 180:	8b 45 08             	mov    0x8(%ebp),%eax
 183:	0f b6 10             	movzbl (%eax),%edx
 186:	8b 45 0c             	mov    0xc(%ebp),%eax
 189:	0f b6 00             	movzbl (%eax),%eax
 18c:	38 c2                	cmp    %al,%dl
 18e:	74 de                	je     16e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	0f b6 00             	movzbl (%eax),%eax
 196:	0f b6 d0             	movzbl %al,%edx
 199:	8b 45 0c             	mov    0xc(%ebp),%eax
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	0f b6 c0             	movzbl %al,%eax
 1a2:	29 c2                	sub    %eax,%edx
 1a4:	89 d0                	mov    %edx,%eax
}
 1a6:	5d                   	pop    %ebp
 1a7:	c3                   	ret    

000001a8 <strlen>:

uint
strlen(char *s)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
 1ab:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ae:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b5:	eb 04                	jmp    1bb <strlen+0x13>
 1b7:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1bb:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1be:	8b 45 08             	mov    0x8(%ebp),%eax
 1c1:	01 d0                	add    %edx,%eax
 1c3:	0f b6 00             	movzbl (%eax),%eax
 1c6:	84 c0                	test   %al,%al
 1c8:	75 ed                	jne    1b7 <strlen+0xf>
    ;
  return n;
 1ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1cd:	c9                   	leave  
 1ce:	c3                   	ret    

000001cf <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1d2:	8b 45 10             	mov    0x10(%ebp),%eax
 1d5:	50                   	push   %eax
 1d6:	ff 75 0c             	pushl  0xc(%ebp)
 1d9:	ff 75 08             	pushl  0x8(%ebp)
 1dc:	e8 32 ff ff ff       	call   113 <stosb>
 1e1:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1e4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e7:	c9                   	leave  
 1e8:	c3                   	ret    

000001e9 <strchr>:

char*
strchr(const char *s, char c)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 04             	sub    $0x4,%esp
 1ef:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1f5:	eb 14                	jmp    20b <strchr+0x22>
    if(*s == c)
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	0f b6 00             	movzbl (%eax),%eax
 1fd:	3a 45 fc             	cmp    -0x4(%ebp),%al
 200:	75 05                	jne    207 <strchr+0x1e>
      return (char*)s;
 202:	8b 45 08             	mov    0x8(%ebp),%eax
 205:	eb 13                	jmp    21a <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 207:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	0f b6 00             	movzbl (%eax),%eax
 211:	84 c0                	test   %al,%al
 213:	75 e2                	jne    1f7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 215:	b8 00 00 00 00       	mov    $0x0,%eax
}
 21a:	c9                   	leave  
 21b:	c3                   	ret    

0000021c <gets>:

char*
gets(char *buf, int max)
{
 21c:	55                   	push   %ebp
 21d:	89 e5                	mov    %esp,%ebp
 21f:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 222:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 229:	eb 42                	jmp    26d <gets+0x51>
    cc = read(0, &c, 1);
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	6a 01                	push   $0x1
 230:	8d 45 ef             	lea    -0x11(%ebp),%eax
 233:	50                   	push   %eax
 234:	6a 00                	push   $0x0
 236:	e8 98 01 00 00       	call   3d3 <read>
 23b:	83 c4 10             	add    $0x10,%esp
 23e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 241:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 245:	7e 33                	jle    27a <gets+0x5e>
      break;
    buf[i++] = c;
 247:	8b 45 f4             	mov    -0xc(%ebp),%eax
 24a:	8d 50 01             	lea    0x1(%eax),%edx
 24d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 250:	89 c2                	mov    %eax,%edx
 252:	8b 45 08             	mov    0x8(%ebp),%eax
 255:	01 c2                	add    %eax,%edx
 257:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 25d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 261:	3c 0a                	cmp    $0xa,%al
 263:	74 16                	je     27b <gets+0x5f>
 265:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 269:	3c 0d                	cmp    $0xd,%al
 26b:	74 0e                	je     27b <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 26d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 270:	83 c0 01             	add    $0x1,%eax
 273:	3b 45 0c             	cmp    0xc(%ebp),%eax
 276:	7c b3                	jl     22b <gets+0xf>
 278:	eb 01                	jmp    27b <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 27a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 27b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	01 d0                	add    %edx,%eax
 283:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 286:	8b 45 08             	mov    0x8(%ebp),%eax
}
 289:	c9                   	leave  
 28a:	c3                   	ret    

0000028b <stat>:

int
stat(char *n, struct stat *st)
{
 28b:	55                   	push   %ebp
 28c:	89 e5                	mov    %esp,%ebp
 28e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 291:	83 ec 08             	sub    $0x8,%esp
 294:	6a 00                	push   $0x0
 296:	ff 75 08             	pushl  0x8(%ebp)
 299:	e8 5d 01 00 00       	call   3fb <open>
 29e:	83 c4 10             	add    $0x10,%esp
 2a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a8:	79 07                	jns    2b1 <stat+0x26>
    return -1;
 2aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2af:	eb 25                	jmp    2d6 <stat+0x4b>
  r = fstat(fd, st);
 2b1:	83 ec 08             	sub    $0x8,%esp
 2b4:	ff 75 0c             	pushl  0xc(%ebp)
 2b7:	ff 75 f4             	pushl  -0xc(%ebp)
 2ba:	e8 54 01 00 00       	call   413 <fstat>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c5:	83 ec 0c             	sub    $0xc,%esp
 2c8:	ff 75 f4             	pushl  -0xc(%ebp)
 2cb:	e8 13 01 00 00       	call   3e3 <close>
 2d0:	83 c4 10             	add    $0x10,%esp
  return r;
 2d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2d6:	c9                   	leave  
 2d7:	c3                   	ret    

000002d8 <atoi>:

int
atoi(const char *s)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e5:	eb 25                	jmp    30c <atoi+0x34>
    n = n*10 + *s++ - '0';
 2e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2ea:	89 d0                	mov    %edx,%eax
 2ec:	c1 e0 02             	shl    $0x2,%eax
 2ef:	01 d0                	add    %edx,%eax
 2f1:	01 c0                	add    %eax,%eax
 2f3:	89 c1                	mov    %eax,%ecx
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
 2f8:	8d 50 01             	lea    0x1(%eax),%edx
 2fb:	89 55 08             	mov    %edx,0x8(%ebp)
 2fe:	0f b6 00             	movzbl (%eax),%eax
 301:	0f be c0             	movsbl %al,%eax
 304:	01 c8                	add    %ecx,%eax
 306:	83 e8 30             	sub    $0x30,%eax
 309:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	0f b6 00             	movzbl (%eax),%eax
 312:	3c 2f                	cmp    $0x2f,%al
 314:	7e 0a                	jle    320 <atoi+0x48>
 316:	8b 45 08             	mov    0x8(%ebp),%eax
 319:	0f b6 00             	movzbl (%eax),%eax
 31c:	3c 39                	cmp    $0x39,%al
 31e:	7e c7                	jle    2e7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 320:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 323:	c9                   	leave  
 324:	c3                   	ret    

00000325 <itoa>:

char*
itoa(int val, int base){
 325:	55                   	push   %ebp
 326:	89 e5                	mov    %esp,%ebp
 328:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 32b:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 332:	eb 29                	jmp    35d <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	99                   	cltd   
 338:	f7 7d 0c             	idivl  0xc(%ebp)
 33b:	89 d0                	mov    %edx,%eax
 33d:	0f b6 80 dc 04 00 00 	movzbl 0x4dc(%eax),%eax
 344:	8b 55 fc             	mov    -0x4(%ebp),%edx
 347:	81 c2 e0 06 00 00    	add    $0x6e0,%edx
 34d:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 34f:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 353:	8b 45 08             	mov    0x8(%ebp),%eax
 356:	99                   	cltd   
 357:	f7 7d 0c             	idivl  0xc(%ebp)
 35a:	89 45 08             	mov    %eax,0x8(%ebp)
 35d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 361:	74 06                	je     369 <itoa+0x44>
 363:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 367:	75 cb                	jne    334 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 369:	8b 45 fc             	mov    -0x4(%ebp),%eax
 36c:	83 c0 01             	add    $0x1,%eax
 36f:	05 e0 06 00 00       	add    $0x6e0,%eax

}
 374:	c9                   	leave  
 375:	c3                   	ret    

00000376 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 376:	55                   	push   %ebp
 377:	89 e5                	mov    %esp,%ebp
 379:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 37c:	8b 45 08             	mov    0x8(%ebp),%eax
 37f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 382:	8b 45 0c             	mov    0xc(%ebp),%eax
 385:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 388:	eb 17                	jmp    3a1 <memmove+0x2b>
    *dst++ = *src++;
 38a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 38d:	8d 50 01             	lea    0x1(%eax),%edx
 390:	89 55 fc             	mov    %edx,-0x4(%ebp)
 393:	8b 55 f8             	mov    -0x8(%ebp),%edx
 396:	8d 4a 01             	lea    0x1(%edx),%ecx
 399:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 39c:	0f b6 12             	movzbl (%edx),%edx
 39f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3a1:	8b 45 10             	mov    0x10(%ebp),%eax
 3a4:	8d 50 ff             	lea    -0x1(%eax),%edx
 3a7:	89 55 10             	mov    %edx,0x10(%ebp)
 3aa:	85 c0                	test   %eax,%eax
 3ac:	7f dc                	jg     38a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3ae:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3b1:	c9                   	leave  
 3b2:	c3                   	ret    

000003b3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3b3:	b8 01 00 00 00       	mov    $0x1,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <exit>:
SYSCALL(exit)
 3bb:	b8 02 00 00 00       	mov    $0x2,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <wait>:
SYSCALL(wait)
 3c3:	b8 03 00 00 00       	mov    $0x3,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <pipe>:
SYSCALL(pipe)
 3cb:	b8 04 00 00 00       	mov    $0x4,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <read>:
SYSCALL(read)
 3d3:	b8 05 00 00 00       	mov    $0x5,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <write>:
SYSCALL(write)
 3db:	b8 10 00 00 00       	mov    $0x10,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <close>:
SYSCALL(close)
 3e3:	b8 15 00 00 00       	mov    $0x15,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <kill>:
SYSCALL(kill)
 3eb:	b8 06 00 00 00       	mov    $0x6,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <exec>:
SYSCALL(exec)
 3f3:	b8 07 00 00 00       	mov    $0x7,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <open>:
SYSCALL(open)
 3fb:	b8 0f 00 00 00       	mov    $0xf,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <mknod>:
SYSCALL(mknod)
 403:	b8 11 00 00 00       	mov    $0x11,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <unlink>:
SYSCALL(unlink)
 40b:	b8 12 00 00 00       	mov    $0x12,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <fstat>:
SYSCALL(fstat)
 413:	b8 08 00 00 00       	mov    $0x8,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <link>:
SYSCALL(link)
 41b:	b8 13 00 00 00       	mov    $0x13,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <mkdir>:
SYSCALL(mkdir)
 423:	b8 14 00 00 00       	mov    $0x14,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <chdir>:
SYSCALL(chdir)
 42b:	b8 09 00 00 00       	mov    $0x9,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <dup>:
SYSCALL(dup)
 433:	b8 0a 00 00 00       	mov    $0xa,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <getpid>:
SYSCALL(getpid)
 43b:	b8 0b 00 00 00       	mov    $0xb,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <sbrk>:
SYSCALL(sbrk)
 443:	b8 0c 00 00 00       	mov    $0xc,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <sleep>:
SYSCALL(sleep)
 44b:	b8 0d 00 00 00       	mov    $0xd,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <uptime>:
SYSCALL(uptime)
 453:	b8 0e 00 00 00       	mov    $0xe,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <randomX>:
SYSCALL(randomX)
 45b:	b8 16 00 00 00       	mov    $0x16,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <setSeedX>:
SYSCALL(setSeedX)
 463:	b8 17 00 00 00       	mov    $0x17,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <uniformR>:
SYSCALL(uniformR)
 46b:	b8 18 00 00 00       	mov    $0x18,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <setdeadline>:
 473:	b8 19 00 00 00       	mov    $0x19,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    
