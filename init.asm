
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 f1 08 00 00       	push   $0x8f1
  1b:	e8 c9 03 00 00       	call   3e9 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 f1 08 00 00       	push   $0x8f1
  33:	e8 b9 03 00 00       	call   3f1 <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 f1 08 00 00       	push   $0x8f1
  45:	e8 9f 03 00 00       	call   3e9 <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 ca 03 00 00       	call   421 <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 bd 03 00 00       	call   421 <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 f9 08 00 00       	push   $0x8f9
  6f:	6a 01                	push   $0x1
  71:	e8 c2 04 00 00       	call   538 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  79:	e8 23 03 00 00       	call   3a1 <fork>
  7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
  87:	83 ec 08             	sub    $0x8,%esp
  8a:	68 0c 09 00 00       	push   $0x90c
  8f:	6a 01                	push   $0x1
  91:	e8 a2 04 00 00       	call   538 <printf>
  96:	83 c4 10             	add    $0x10,%esp
      exit();
  99:	e8 0b 03 00 00       	call   3a9 <exit>
    }
    if(pid == 0){
  9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a2:	75 3e                	jne    e2 <main+0xe2>
      exec("sh", argv);
  a4:	83 ec 08             	sub    $0x8,%esp
  a7:	68 c0 0b 00 00       	push   $0xbc0
  ac:	68 ee 08 00 00       	push   $0x8ee
  b1:	e8 2b 03 00 00       	call   3e1 <exec>
  b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	68 1f 09 00 00       	push   $0x91f
  c1:	6a 01                	push   $0x1
  c3:	e8 70 04 00 00       	call   538 <printf>
  c8:	83 c4 10             	add    $0x10,%esp
      exit();
  cb:	e8 d9 02 00 00       	call   3a9 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  d0:	83 ec 08             	sub    $0x8,%esp
  d3:	68 35 09 00 00       	push   $0x935
  d8:	6a 01                	push   $0x1
  da:	e8 59 04 00 00       	call   538 <printf>
  df:	83 c4 10             	add    $0x10,%esp
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  e2:	e8 ca 02 00 00       	call   3b1 <wait>
  e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
  f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  fa:	75 d4                	jne    d0 <main+0xd0>
      printf(1, "zombie!\n");
  }
  fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	57                   	push   %edi
 105:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 55 10             	mov    0x10(%ebp),%edx
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	89 cb                	mov    %ecx,%ebx
 111:	89 df                	mov    %ebx,%edi
 113:	89 d1                	mov    %edx,%ecx
 115:	fc                   	cld    
 116:	f3 aa                	rep stos %al,%es:(%edi)
 118:	89 ca                	mov    %ecx,%edx
 11a:	89 fb                	mov    %edi,%ebx
 11c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 122:	90                   	nop
 123:	5b                   	pop    %ebx
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    

00000127 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 133:	90                   	nop
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8d 50 01             	lea    0x1(%eax),%edx
 13a:	89 55 08             	mov    %edx,0x8(%ebp)
 13d:	8b 55 0c             	mov    0xc(%ebp),%edx
 140:	8d 4a 01             	lea    0x1(%edx),%ecx
 143:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 146:	0f b6 12             	movzbl (%edx),%edx
 149:	88 10                	mov    %dl,(%eax)
 14b:	0f b6 00             	movzbl (%eax),%eax
 14e:	84 c0                	test   %al,%al
 150:	75 e2                	jne    134 <strcpy+0xd>
    ;
  return os;
 152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 155:	c9                   	leave  
 156:	c3                   	ret    

00000157 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 157:	55                   	push   %ebp
 158:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 15a:	eb 08                	jmp    164 <strcmp+0xd>
    p++, q++;
 15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	0f b6 00             	movzbl (%eax),%eax
 16a:	84 c0                	test   %al,%al
 16c:	74 10                	je     17e <strcmp+0x27>
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	0f b6 10             	movzbl (%eax),%edx
 174:	8b 45 0c             	mov    0xc(%ebp),%eax
 177:	0f b6 00             	movzbl (%eax),%eax
 17a:	38 c2                	cmp    %al,%dl
 17c:	74 de                	je     15c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	0f b6 d0             	movzbl %al,%edx
 187:	8b 45 0c             	mov    0xc(%ebp),%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	0f b6 c0             	movzbl %al,%eax
 190:	29 c2                	sub    %eax,%edx
 192:	89 d0                	mov    %edx,%eax
}
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    

00000196 <strlen>:

uint
strlen(char *s)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 19c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a3:	eb 04                	jmp    1a9 <strlen+0x13>
 1a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
 1af:	01 d0                	add    %edx,%eax
 1b1:	0f b6 00             	movzbl (%eax),%eax
 1b4:	84 c0                	test   %al,%al
 1b6:	75 ed                	jne    1a5 <strlen+0xf>
    ;
  return n;
 1b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1bb:	c9                   	leave  
 1bc:	c3                   	ret    

000001bd <memset>:

void*
memset(void *dst, int c, uint n)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1c0:	8b 45 10             	mov    0x10(%ebp),%eax
 1c3:	50                   	push   %eax
 1c4:	ff 75 0c             	pushl  0xc(%ebp)
 1c7:	ff 75 08             	pushl  0x8(%ebp)
 1ca:	e8 32 ff ff ff       	call   101 <stosb>
 1cf:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d5:	c9                   	leave  
 1d6:	c3                   	ret    

000001d7 <strchr>:

char*
strchr(const char *s, char c)
{
 1d7:	55                   	push   %ebp
 1d8:	89 e5                	mov    %esp,%ebp
 1da:	83 ec 04             	sub    $0x4,%esp
 1dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1e3:	eb 14                	jmp    1f9 <strchr+0x22>
    if(*s == c)
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	0f b6 00             	movzbl (%eax),%eax
 1eb:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1ee:	75 05                	jne    1f5 <strchr+0x1e>
      return (char*)s;
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	eb 13                	jmp    208 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 1f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	0f b6 00             	movzbl (%eax),%eax
 1ff:	84 c0                	test   %al,%al
 201:	75 e2                	jne    1e5 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 203:	b8 00 00 00 00       	mov    $0x0,%eax
}
 208:	c9                   	leave  
 209:	c3                   	ret    

0000020a <gets>:

char*
gets(char *buf, int max)
{
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
 20d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 217:	eb 42                	jmp    25b <gets+0x51>
    cc = read(0, &c, 1);
 219:	83 ec 04             	sub    $0x4,%esp
 21c:	6a 01                	push   $0x1
 21e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 221:	50                   	push   %eax
 222:	6a 00                	push   $0x0
 224:	e8 98 01 00 00       	call   3c1 <read>
 229:	83 c4 10             	add    $0x10,%esp
 22c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 22f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 233:	7e 33                	jle    268 <gets+0x5e>
      break;
    buf[i++] = c;
 235:	8b 45 f4             	mov    -0xc(%ebp),%eax
 238:	8d 50 01             	lea    0x1(%eax),%edx
 23b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 23e:	89 c2                	mov    %eax,%edx
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	01 c2                	add    %eax,%edx
 245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 249:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 24b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 24f:	3c 0a                	cmp    $0xa,%al
 251:	74 16                	je     269 <gets+0x5f>
 253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 257:	3c 0d                	cmp    $0xd,%al
 259:	74 0e                	je     269 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 25b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25e:	83 c0 01             	add    $0x1,%eax
 261:	3b 45 0c             	cmp    0xc(%ebp),%eax
 264:	7c b3                	jl     219 <gets+0xf>
 266:	eb 01                	jmp    269 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 268:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 269:	8b 55 f4             	mov    -0xc(%ebp),%edx
 26c:	8b 45 08             	mov    0x8(%ebp),%eax
 26f:	01 d0                	add    %edx,%eax
 271:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 274:	8b 45 08             	mov    0x8(%ebp),%eax
}
 277:	c9                   	leave  
 278:	c3                   	ret    

00000279 <stat>:

int
stat(char *n, struct stat *st)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
 27c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27f:	83 ec 08             	sub    $0x8,%esp
 282:	6a 00                	push   $0x0
 284:	ff 75 08             	pushl  0x8(%ebp)
 287:	e8 5d 01 00 00       	call   3e9 <open>
 28c:	83 c4 10             	add    $0x10,%esp
 28f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 292:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 296:	79 07                	jns    29f <stat+0x26>
    return -1;
 298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 29d:	eb 25                	jmp    2c4 <stat+0x4b>
  r = fstat(fd, st);
 29f:	83 ec 08             	sub    $0x8,%esp
 2a2:	ff 75 0c             	pushl  0xc(%ebp)
 2a5:	ff 75 f4             	pushl  -0xc(%ebp)
 2a8:	e8 54 01 00 00       	call   401 <fstat>
 2ad:	83 c4 10             	add    $0x10,%esp
 2b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2b3:	83 ec 0c             	sub    $0xc,%esp
 2b6:	ff 75 f4             	pushl  -0xc(%ebp)
 2b9:	e8 13 01 00 00       	call   3d1 <close>
 2be:	83 c4 10             	add    $0x10,%esp
  return r;
 2c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <atoi>:

int
atoi(const char *s)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2d3:	eb 25                	jmp    2fa <atoi+0x34>
    n = n*10 + *s++ - '0';
 2d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2d8:	89 d0                	mov    %edx,%eax
 2da:	c1 e0 02             	shl    $0x2,%eax
 2dd:	01 d0                	add    %edx,%eax
 2df:	01 c0                	add    %eax,%eax
 2e1:	89 c1                	mov    %eax,%ecx
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	8d 50 01             	lea    0x1(%eax),%edx
 2e9:	89 55 08             	mov    %edx,0x8(%ebp)
 2ec:	0f b6 00             	movzbl (%eax),%eax
 2ef:	0f be c0             	movsbl %al,%eax
 2f2:	01 c8                	add    %ecx,%eax
 2f4:	83 e8 30             	sub    $0x30,%eax
 2f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2fa:	8b 45 08             	mov    0x8(%ebp),%eax
 2fd:	0f b6 00             	movzbl (%eax),%eax
 300:	3c 2f                	cmp    $0x2f,%al
 302:	7e 0a                	jle    30e <atoi+0x48>
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	0f b6 00             	movzbl (%eax),%eax
 30a:	3c 39                	cmp    $0x39,%al
 30c:	7e c7                	jle    2d5 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 30e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 311:	c9                   	leave  
 312:	c3                   	ret    

00000313 <itoa>:

char*
itoa(int val, int base){
 313:	55                   	push   %ebp
 314:	89 e5                	mov    %esp,%ebp
 316:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 319:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 320:	eb 29                	jmp    34b <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	99                   	cltd   
 326:	f7 7d 0c             	idivl  0xc(%ebp)
 329:	89 d0                	mov    %edx,%eax
 32b:	0f b6 80 3e 09 00 00 	movzbl 0x93e(%eax),%eax
 332:	8b 55 fc             	mov    -0x4(%ebp),%edx
 335:	81 c2 e0 0b 00 00    	add    $0xbe0,%edx
 33b:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 33d:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 341:	8b 45 08             	mov    0x8(%ebp),%eax
 344:	99                   	cltd   
 345:	f7 7d 0c             	idivl  0xc(%ebp)
 348:	89 45 08             	mov    %eax,0x8(%ebp)
 34b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 34f:	74 06                	je     357 <itoa+0x44>
 351:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 355:	75 cb                	jne    322 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 357:	8b 45 fc             	mov    -0x4(%ebp),%eax
 35a:	83 c0 01             	add    $0x1,%eax
 35d:	05 e0 0b 00 00       	add    $0xbe0,%eax

}
 362:	c9                   	leave  
 363:	c3                   	ret    

00000364 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 36a:	8b 45 08             	mov    0x8(%ebp),%eax
 36d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 370:	8b 45 0c             	mov    0xc(%ebp),%eax
 373:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 376:	eb 17                	jmp    38f <memmove+0x2b>
    *dst++ = *src++;
 378:	8b 45 fc             	mov    -0x4(%ebp),%eax
 37b:	8d 50 01             	lea    0x1(%eax),%edx
 37e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 381:	8b 55 f8             	mov    -0x8(%ebp),%edx
 384:	8d 4a 01             	lea    0x1(%edx),%ecx
 387:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 38a:	0f b6 12             	movzbl (%edx),%edx
 38d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 38f:	8b 45 10             	mov    0x10(%ebp),%eax
 392:	8d 50 ff             	lea    -0x1(%eax),%edx
 395:	89 55 10             	mov    %edx,0x10(%ebp)
 398:	85 c0                	test   %eax,%eax
 39a:	7f dc                	jg     378 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 39c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 39f:	c9                   	leave  
 3a0:	c3                   	ret    

000003a1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3a1:	b8 01 00 00 00       	mov    $0x1,%eax
 3a6:	cd 40                	int    $0x40
 3a8:	c3                   	ret    

000003a9 <exit>:
SYSCALL(exit)
 3a9:	b8 02 00 00 00       	mov    $0x2,%eax
 3ae:	cd 40                	int    $0x40
 3b0:	c3                   	ret    

000003b1 <wait>:
SYSCALL(wait)
 3b1:	b8 03 00 00 00       	mov    $0x3,%eax
 3b6:	cd 40                	int    $0x40
 3b8:	c3                   	ret    

000003b9 <pipe>:
SYSCALL(pipe)
 3b9:	b8 04 00 00 00       	mov    $0x4,%eax
 3be:	cd 40                	int    $0x40
 3c0:	c3                   	ret    

000003c1 <read>:
SYSCALL(read)
 3c1:	b8 05 00 00 00       	mov    $0x5,%eax
 3c6:	cd 40                	int    $0x40
 3c8:	c3                   	ret    

000003c9 <write>:
SYSCALL(write)
 3c9:	b8 10 00 00 00       	mov    $0x10,%eax
 3ce:	cd 40                	int    $0x40
 3d0:	c3                   	ret    

000003d1 <close>:
SYSCALL(close)
 3d1:	b8 15 00 00 00       	mov    $0x15,%eax
 3d6:	cd 40                	int    $0x40
 3d8:	c3                   	ret    

000003d9 <kill>:
SYSCALL(kill)
 3d9:	b8 06 00 00 00       	mov    $0x6,%eax
 3de:	cd 40                	int    $0x40
 3e0:	c3                   	ret    

000003e1 <exec>:
SYSCALL(exec)
 3e1:	b8 07 00 00 00       	mov    $0x7,%eax
 3e6:	cd 40                	int    $0x40
 3e8:	c3                   	ret    

000003e9 <open>:
SYSCALL(open)
 3e9:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ee:	cd 40                	int    $0x40
 3f0:	c3                   	ret    

000003f1 <mknod>:
SYSCALL(mknod)
 3f1:	b8 11 00 00 00       	mov    $0x11,%eax
 3f6:	cd 40                	int    $0x40
 3f8:	c3                   	ret    

000003f9 <unlink>:
SYSCALL(unlink)
 3f9:	b8 12 00 00 00       	mov    $0x12,%eax
 3fe:	cd 40                	int    $0x40
 400:	c3                   	ret    

00000401 <fstat>:
SYSCALL(fstat)
 401:	b8 08 00 00 00       	mov    $0x8,%eax
 406:	cd 40                	int    $0x40
 408:	c3                   	ret    

00000409 <link>:
SYSCALL(link)
 409:	b8 13 00 00 00       	mov    $0x13,%eax
 40e:	cd 40                	int    $0x40
 410:	c3                   	ret    

00000411 <mkdir>:
SYSCALL(mkdir)
 411:	b8 14 00 00 00       	mov    $0x14,%eax
 416:	cd 40                	int    $0x40
 418:	c3                   	ret    

00000419 <chdir>:
SYSCALL(chdir)
 419:	b8 09 00 00 00       	mov    $0x9,%eax
 41e:	cd 40                	int    $0x40
 420:	c3                   	ret    

00000421 <dup>:
SYSCALL(dup)
 421:	b8 0a 00 00 00       	mov    $0xa,%eax
 426:	cd 40                	int    $0x40
 428:	c3                   	ret    

00000429 <getpid>:
SYSCALL(getpid)
 429:	b8 0b 00 00 00       	mov    $0xb,%eax
 42e:	cd 40                	int    $0x40
 430:	c3                   	ret    

00000431 <sbrk>:
SYSCALL(sbrk)
 431:	b8 0c 00 00 00       	mov    $0xc,%eax
 436:	cd 40                	int    $0x40
 438:	c3                   	ret    

00000439 <sleep>:
SYSCALL(sleep)
 439:	b8 0d 00 00 00       	mov    $0xd,%eax
 43e:	cd 40                	int    $0x40
 440:	c3                   	ret    

00000441 <uptime>:
SYSCALL(uptime)
 441:	b8 0e 00 00 00       	mov    $0xe,%eax
 446:	cd 40                	int    $0x40
 448:	c3                   	ret    

00000449 <randomX>:
SYSCALL(randomX)
 449:	b8 16 00 00 00       	mov    $0x16,%eax
 44e:	cd 40                	int    $0x40
 450:	c3                   	ret    

00000451 <setSeedX>:
SYSCALL(setSeedX)
 451:	b8 17 00 00 00       	mov    $0x17,%eax
 456:	cd 40                	int    $0x40
 458:	c3                   	ret    

00000459 <uniformR>:
SYSCALL(uniformR)
 459:	b8 18 00 00 00       	mov    $0x18,%eax
 45e:	cd 40                	int    $0x40
 460:	c3                   	ret    

00000461 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 461:	55                   	push   %ebp
 462:	89 e5                	mov    %esp,%ebp
 464:	83 ec 18             	sub    $0x18,%esp
 467:	8b 45 0c             	mov    0xc(%ebp),%eax
 46a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 46d:	83 ec 04             	sub    $0x4,%esp
 470:	6a 01                	push   $0x1
 472:	8d 45 f4             	lea    -0xc(%ebp),%eax
 475:	50                   	push   %eax
 476:	ff 75 08             	pushl  0x8(%ebp)
 479:	e8 4b ff ff ff       	call   3c9 <write>
 47e:	83 c4 10             	add    $0x10,%esp
}
 481:	90                   	nop
 482:	c9                   	leave  
 483:	c3                   	ret    

00000484 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 484:	55                   	push   %ebp
 485:	89 e5                	mov    %esp,%ebp
 487:	53                   	push   %ebx
 488:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 48b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 492:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 496:	74 17                	je     4af <printint+0x2b>
 498:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 49c:	79 11                	jns    4af <printint+0x2b>
    neg = 1;
 49e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a8:	f7 d8                	neg    %eax
 4aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ad:	eb 06                	jmp    4b5 <printint+0x31>
  } else {
    x = xx;
 4af:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4bc:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4bf:	8d 41 01             	lea    0x1(%ecx),%eax
 4c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4c5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4c8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4cb:	ba 00 00 00 00       	mov    $0x0,%edx
 4d0:	f7 f3                	div    %ebx
 4d2:	89 d0                	mov    %edx,%eax
 4d4:	0f b6 80 c8 0b 00 00 	movzbl 0xbc8(%eax),%eax
 4db:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4df:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4e5:	ba 00 00 00 00       	mov    $0x0,%edx
 4ea:	f7 f3                	div    %ebx
 4ec:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f3:	75 c7                	jne    4bc <printint+0x38>
  if(neg)
 4f5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4f9:	74 2d                	je     528 <printint+0xa4>
    buf[i++] = '-';
 4fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4fe:	8d 50 01             	lea    0x1(%eax),%edx
 501:	89 55 f4             	mov    %edx,-0xc(%ebp)
 504:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 509:	eb 1d                	jmp    528 <printint+0xa4>
    putc(fd, buf[i]);
 50b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 50e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 511:	01 d0                	add    %edx,%eax
 513:	0f b6 00             	movzbl (%eax),%eax
 516:	0f be c0             	movsbl %al,%eax
 519:	83 ec 08             	sub    $0x8,%esp
 51c:	50                   	push   %eax
 51d:	ff 75 08             	pushl  0x8(%ebp)
 520:	e8 3c ff ff ff       	call   461 <putc>
 525:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 528:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 52c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 530:	79 d9                	jns    50b <printint+0x87>
    putc(fd, buf[i]);
}
 532:	90                   	nop
 533:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 536:	c9                   	leave  
 537:	c3                   	ret    

00000538 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 538:	55                   	push   %ebp
 539:	89 e5                	mov    %esp,%ebp
 53b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 53e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 545:	8d 45 0c             	lea    0xc(%ebp),%eax
 548:	83 c0 04             	add    $0x4,%eax
 54b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 54e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 555:	e9 59 01 00 00       	jmp    6b3 <printf+0x17b>
    c = fmt[i] & 0xff;
 55a:	8b 55 0c             	mov    0xc(%ebp),%edx
 55d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 560:	01 d0                	add    %edx,%eax
 562:	0f b6 00             	movzbl (%eax),%eax
 565:	0f be c0             	movsbl %al,%eax
 568:	25 ff 00 00 00       	and    $0xff,%eax
 56d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 570:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 574:	75 2c                	jne    5a2 <printf+0x6a>
      if(c == '%'){
 576:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 57a:	75 0c                	jne    588 <printf+0x50>
        state = '%';
 57c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 583:	e9 27 01 00 00       	jmp    6af <printf+0x177>
      } else {
        putc(fd, c);
 588:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58b:	0f be c0             	movsbl %al,%eax
 58e:	83 ec 08             	sub    $0x8,%esp
 591:	50                   	push   %eax
 592:	ff 75 08             	pushl  0x8(%ebp)
 595:	e8 c7 fe ff ff       	call   461 <putc>
 59a:	83 c4 10             	add    $0x10,%esp
 59d:	e9 0d 01 00 00       	jmp    6af <printf+0x177>
      }
    } else if(state == '%'){
 5a2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5a6:	0f 85 03 01 00 00    	jne    6af <printf+0x177>
      if(c == 'd'){
 5ac:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5b0:	75 1e                	jne    5d0 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5b2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b5:	8b 00                	mov    (%eax),%eax
 5b7:	6a 01                	push   $0x1
 5b9:	6a 0a                	push   $0xa
 5bb:	50                   	push   %eax
 5bc:	ff 75 08             	pushl  0x8(%ebp)
 5bf:	e8 c0 fe ff ff       	call   484 <printint>
 5c4:	83 c4 10             	add    $0x10,%esp
        ap++;
 5c7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5cb:	e9 d8 00 00 00       	jmp    6a8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5d0:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5d4:	74 06                	je     5dc <printf+0xa4>
 5d6:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5da:	75 1e                	jne    5fa <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5df:	8b 00                	mov    (%eax),%eax
 5e1:	6a 00                	push   $0x0
 5e3:	6a 10                	push   $0x10
 5e5:	50                   	push   %eax
 5e6:	ff 75 08             	pushl  0x8(%ebp)
 5e9:	e8 96 fe ff ff       	call   484 <printint>
 5ee:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f5:	e9 ae 00 00 00       	jmp    6a8 <printf+0x170>
      } else if(c == 's'){
 5fa:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 5fe:	75 43                	jne    643 <printf+0x10b>
        s = (char*)*ap;
 600:	8b 45 e8             	mov    -0x18(%ebp),%eax
 603:	8b 00                	mov    (%eax),%eax
 605:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 608:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 60c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 610:	75 25                	jne    637 <printf+0xff>
          s = "(null)";
 612:	c7 45 f4 4f 09 00 00 	movl   $0x94f,-0xc(%ebp)
        while(*s != 0){
 619:	eb 1c                	jmp    637 <printf+0xff>
          putc(fd, *s);
 61b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 61e:	0f b6 00             	movzbl (%eax),%eax
 621:	0f be c0             	movsbl %al,%eax
 624:	83 ec 08             	sub    $0x8,%esp
 627:	50                   	push   %eax
 628:	ff 75 08             	pushl  0x8(%ebp)
 62b:	e8 31 fe ff ff       	call   461 <putc>
 630:	83 c4 10             	add    $0x10,%esp
          s++;
 633:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 637:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63a:	0f b6 00             	movzbl (%eax),%eax
 63d:	84 c0                	test   %al,%al
 63f:	75 da                	jne    61b <printf+0xe3>
 641:	eb 65                	jmp    6a8 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 643:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 647:	75 1d                	jne    666 <printf+0x12e>
        putc(fd, *ap);
 649:	8b 45 e8             	mov    -0x18(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	0f be c0             	movsbl %al,%eax
 651:	83 ec 08             	sub    $0x8,%esp
 654:	50                   	push   %eax
 655:	ff 75 08             	pushl  0x8(%ebp)
 658:	e8 04 fe ff ff       	call   461 <putc>
 65d:	83 c4 10             	add    $0x10,%esp
        ap++;
 660:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 664:	eb 42                	jmp    6a8 <printf+0x170>
      } else if(c == '%'){
 666:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 66a:	75 17                	jne    683 <printf+0x14b>
        putc(fd, c);
 66c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 66f:	0f be c0             	movsbl %al,%eax
 672:	83 ec 08             	sub    $0x8,%esp
 675:	50                   	push   %eax
 676:	ff 75 08             	pushl  0x8(%ebp)
 679:	e8 e3 fd ff ff       	call   461 <putc>
 67e:	83 c4 10             	add    $0x10,%esp
 681:	eb 25                	jmp    6a8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 683:	83 ec 08             	sub    $0x8,%esp
 686:	6a 25                	push   $0x25
 688:	ff 75 08             	pushl  0x8(%ebp)
 68b:	e8 d1 fd ff ff       	call   461 <putc>
 690:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 693:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 696:	0f be c0             	movsbl %al,%eax
 699:	83 ec 08             	sub    $0x8,%esp
 69c:	50                   	push   %eax
 69d:	ff 75 08             	pushl  0x8(%ebp)
 6a0:	e8 bc fd ff ff       	call   461 <putc>
 6a5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6a8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6af:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6b3:	8b 55 0c             	mov    0xc(%ebp),%edx
 6b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6b9:	01 d0                	add    %edx,%eax
 6bb:	0f b6 00             	movzbl (%eax),%eax
 6be:	84 c0                	test   %al,%al
 6c0:	0f 85 94 fe ff ff    	jne    55a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6c6:	90                   	nop
 6c7:	c9                   	leave  
 6c8:	c3                   	ret    

000006c9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6c9:	55                   	push   %ebp
 6ca:	89 e5                	mov    %esp,%ebp
 6cc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6cf:	8b 45 08             	mov    0x8(%ebp),%eax
 6d2:	83 e8 08             	sub    $0x8,%eax
 6d5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6d8:	a1 08 0c 00 00       	mov    0xc08,%eax
 6dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6e0:	eb 24                	jmp    706 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 00                	mov    (%eax),%eax
 6e7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6ea:	77 12                	ja     6fe <free+0x35>
 6ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f2:	77 24                	ja     718 <free+0x4f>
 6f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f7:	8b 00                	mov    (%eax),%eax
 6f9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6fc:	77 1a                	ja     718 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
 701:	8b 00                	mov    (%eax),%eax
 703:	89 45 fc             	mov    %eax,-0x4(%ebp)
 706:	8b 45 f8             	mov    -0x8(%ebp),%eax
 709:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 70c:	76 d4                	jbe    6e2 <free+0x19>
 70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 711:	8b 00                	mov    (%eax),%eax
 713:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 716:	76 ca                	jbe    6e2 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 718:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71b:	8b 40 04             	mov    0x4(%eax),%eax
 71e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 725:	8b 45 f8             	mov    -0x8(%ebp),%eax
 728:	01 c2                	add    %eax,%edx
 72a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72d:	8b 00                	mov    (%eax),%eax
 72f:	39 c2                	cmp    %eax,%edx
 731:	75 24                	jne    757 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 733:	8b 45 f8             	mov    -0x8(%ebp),%eax
 736:	8b 50 04             	mov    0x4(%eax),%edx
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	8b 00                	mov    (%eax),%eax
 73e:	8b 40 04             	mov    0x4(%eax),%eax
 741:	01 c2                	add    %eax,%edx
 743:	8b 45 f8             	mov    -0x8(%ebp),%eax
 746:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 749:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74c:	8b 00                	mov    (%eax),%eax
 74e:	8b 10                	mov    (%eax),%edx
 750:	8b 45 f8             	mov    -0x8(%ebp),%eax
 753:	89 10                	mov    %edx,(%eax)
 755:	eb 0a                	jmp    761 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	8b 10                	mov    (%eax),%edx
 75c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 761:	8b 45 fc             	mov    -0x4(%ebp),%eax
 764:	8b 40 04             	mov    0x4(%eax),%eax
 767:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 76e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 771:	01 d0                	add    %edx,%eax
 773:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 776:	75 20                	jne    798 <free+0xcf>
    p->s.size += bp->s.size;
 778:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77b:	8b 50 04             	mov    0x4(%eax),%edx
 77e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 781:	8b 40 04             	mov    0x4(%eax),%eax
 784:	01 c2                	add    %eax,%edx
 786:	8b 45 fc             	mov    -0x4(%ebp),%eax
 789:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 78c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78f:	8b 10                	mov    (%eax),%edx
 791:	8b 45 fc             	mov    -0x4(%ebp),%eax
 794:	89 10                	mov    %edx,(%eax)
 796:	eb 08                	jmp    7a0 <free+0xd7>
  } else
    p->s.ptr = bp;
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 79e:	89 10                	mov    %edx,(%eax)
  freep = p;
 7a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a3:	a3 08 0c 00 00       	mov    %eax,0xc08
}
 7a8:	90                   	nop
 7a9:	c9                   	leave  
 7aa:	c3                   	ret    

000007ab <morecore>:

static Header*
morecore(uint nu)
{
 7ab:	55                   	push   %ebp
 7ac:	89 e5                	mov    %esp,%ebp
 7ae:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7b1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7b8:	77 07                	ja     7c1 <morecore+0x16>
    nu = 4096;
 7ba:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7c1:	8b 45 08             	mov    0x8(%ebp),%eax
 7c4:	c1 e0 03             	shl    $0x3,%eax
 7c7:	83 ec 0c             	sub    $0xc,%esp
 7ca:	50                   	push   %eax
 7cb:	e8 61 fc ff ff       	call   431 <sbrk>
 7d0:	83 c4 10             	add    $0x10,%esp
 7d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7d6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7da:	75 07                	jne    7e3 <morecore+0x38>
    return 0;
 7dc:	b8 00 00 00 00       	mov    $0x0,%eax
 7e1:	eb 26                	jmp    809 <morecore+0x5e>
  hp = (Header*)p;
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ec:	8b 55 08             	mov    0x8(%ebp),%edx
 7ef:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 7f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f5:	83 c0 08             	add    $0x8,%eax
 7f8:	83 ec 0c             	sub    $0xc,%esp
 7fb:	50                   	push   %eax
 7fc:	e8 c8 fe ff ff       	call   6c9 <free>
 801:	83 c4 10             	add    $0x10,%esp
  return freep;
 804:	a1 08 0c 00 00       	mov    0xc08,%eax
}
 809:	c9                   	leave  
 80a:	c3                   	ret    

0000080b <malloc>:

void*
malloc(uint nbytes)
{
 80b:	55                   	push   %ebp
 80c:	89 e5                	mov    %esp,%ebp
 80e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 811:	8b 45 08             	mov    0x8(%ebp),%eax
 814:	83 c0 07             	add    $0x7,%eax
 817:	c1 e8 03             	shr    $0x3,%eax
 81a:	83 c0 01             	add    $0x1,%eax
 81d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 820:	a1 08 0c 00 00       	mov    0xc08,%eax
 825:	89 45 f0             	mov    %eax,-0x10(%ebp)
 828:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 82c:	75 23                	jne    851 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 82e:	c7 45 f0 00 0c 00 00 	movl   $0xc00,-0x10(%ebp)
 835:	8b 45 f0             	mov    -0x10(%ebp),%eax
 838:	a3 08 0c 00 00       	mov    %eax,0xc08
 83d:	a1 08 0c 00 00       	mov    0xc08,%eax
 842:	a3 00 0c 00 00       	mov    %eax,0xc00
    base.s.size = 0;
 847:	c7 05 04 0c 00 00 00 	movl   $0x0,0xc04
 84e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 851:	8b 45 f0             	mov    -0x10(%ebp),%eax
 854:	8b 00                	mov    (%eax),%eax
 856:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 859:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85c:	8b 40 04             	mov    0x4(%eax),%eax
 85f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 862:	72 4d                	jb     8b1 <malloc+0xa6>
      if(p->s.size == nunits)
 864:	8b 45 f4             	mov    -0xc(%ebp),%eax
 867:	8b 40 04             	mov    0x4(%eax),%eax
 86a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 86d:	75 0c                	jne    87b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 86f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 872:	8b 10                	mov    (%eax),%edx
 874:	8b 45 f0             	mov    -0x10(%ebp),%eax
 877:	89 10                	mov    %edx,(%eax)
 879:	eb 26                	jmp    8a1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87e:	8b 40 04             	mov    0x4(%eax),%eax
 881:	2b 45 ec             	sub    -0x14(%ebp),%eax
 884:	89 c2                	mov    %eax,%edx
 886:	8b 45 f4             	mov    -0xc(%ebp),%eax
 889:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 88c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88f:	8b 40 04             	mov    0x4(%eax),%eax
 892:	c1 e0 03             	shl    $0x3,%eax
 895:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 898:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 89e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a4:	a3 08 0c 00 00       	mov    %eax,0xc08
      return (void*)(p + 1);
 8a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ac:	83 c0 08             	add    $0x8,%eax
 8af:	eb 3b                	jmp    8ec <malloc+0xe1>
    }
    if(p == freep)
 8b1:	a1 08 0c 00 00       	mov    0xc08,%eax
 8b6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8b9:	75 1e                	jne    8d9 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8bb:	83 ec 0c             	sub    $0xc,%esp
 8be:	ff 75 ec             	pushl  -0x14(%ebp)
 8c1:	e8 e5 fe ff ff       	call   7ab <morecore>
 8c6:	83 c4 10             	add    $0x10,%esp
 8c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8d0:	75 07                	jne    8d9 <malloc+0xce>
        return 0;
 8d2:	b8 00 00 00 00       	mov    $0x0,%eax
 8d7:	eb 13                	jmp    8ec <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e2:	8b 00                	mov    (%eax),%eax
 8e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8e7:	e9 6d ff ff ff       	jmp    859 <malloc+0x4e>
}
 8ec:	c9                   	leave  
 8ed:	c3                   	ret    
