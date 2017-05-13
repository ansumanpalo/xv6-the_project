
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
   6:	eb 15                	jmp    1d <cat+0x1d>
    write(1, buf, n);
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	pushl  -0xc(%ebp)
   e:	68 20 0c 00 00       	push   $0xc20
  13:	6a 01                	push   $0x1
  15:	e8 bd 03 00 00       	call   3d7 <write>
  1a:	83 c4 10             	add    $0x10,%esp
void
cat(int fd)
{
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0)
  1d:	83 ec 04             	sub    $0x4,%esp
  20:	68 00 02 00 00       	push   $0x200
  25:	68 20 0c 00 00       	push   $0xc20
  2a:	ff 75 08             	pushl  0x8(%ebp)
  2d:	e8 9d 03 00 00       	call   3cf <read>
  32:	83 c4 10             	add    $0x10,%esp
  35:	89 45 f4             	mov    %eax,-0xc(%ebp)
  38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  3c:	7f ca                	jg     8 <cat+0x8>
    write(1, buf, n);
  if(n < 0){
  3e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  42:	79 17                	jns    5b <cat+0x5b>
    printf(1, "cat: read error\n");
  44:	83 ec 08             	sub    $0x8,%esp
  47:	68 fc 08 00 00       	push   $0x8fc
  4c:	6a 01                	push   $0x1
  4e:	e8 f3 04 00 00       	call   546 <printf>
  53:	83 c4 10             	add    $0x10,%esp
    exit();
  56:	e8 5c 03 00 00       	call   3b7 <exit>
  }
}
  5b:	90                   	nop
  5c:	c9                   	leave  
  5d:	c3                   	ret    

0000005e <main>:

int
main(int argc, char *argv[])
{
  5e:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  62:	83 e4 f0             	and    $0xfffffff0,%esp
  65:	ff 71 fc             	pushl  -0x4(%ecx)
  68:	55                   	push   %ebp
  69:	89 e5                	mov    %esp,%ebp
  6b:	53                   	push   %ebx
  6c:	51                   	push   %ecx
  6d:	83 ec 10             	sub    $0x10,%esp
  70:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  72:	83 3b 01             	cmpl   $0x1,(%ebx)
  75:	7f 12                	jg     89 <main+0x2b>
    cat(0);
  77:	83 ec 0c             	sub    $0xc,%esp
  7a:	6a 00                	push   $0x0
  7c:	e8 7f ff ff ff       	call   0 <cat>
  81:	83 c4 10             	add    $0x10,%esp
    exit();
  84:	e8 2e 03 00 00       	call   3b7 <exit>
  }

  for(i = 1; i < argc; i++){
  89:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  90:	eb 71                	jmp    103 <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
  92:	8b 45 f4             	mov    -0xc(%ebp),%eax
  95:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  9c:	8b 43 04             	mov    0x4(%ebx),%eax
  9f:	01 d0                	add    %edx,%eax
  a1:	8b 00                	mov    (%eax),%eax
  a3:	83 ec 08             	sub    $0x8,%esp
  a6:	6a 00                	push   $0x0
  a8:	50                   	push   %eax
  a9:	e8 49 03 00 00       	call   3f7 <open>
  ae:	83 c4 10             	add    $0x10,%esp
  b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  b8:	79 29                	jns    e3 <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
  ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  bd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  c4:	8b 43 04             	mov    0x4(%ebx),%eax
  c7:	01 d0                	add    %edx,%eax
  c9:	8b 00                	mov    (%eax),%eax
  cb:	83 ec 04             	sub    $0x4,%esp
  ce:	50                   	push   %eax
  cf:	68 0d 09 00 00       	push   $0x90d
  d4:	6a 01                	push   $0x1
  d6:	e8 6b 04 00 00       	call   546 <printf>
  db:	83 c4 10             	add    $0x10,%esp
      exit();
  de:	e8 d4 02 00 00       	call   3b7 <exit>
    }
    cat(fd);
  e3:	83 ec 0c             	sub    $0xc,%esp
  e6:	ff 75 f0             	pushl  -0x10(%ebp)
  e9:	e8 12 ff ff ff       	call   0 <cat>
  ee:	83 c4 10             	add    $0x10,%esp
    close(fd);
  f1:	83 ec 0c             	sub    $0xc,%esp
  f4:	ff 75 f0             	pushl  -0x10(%ebp)
  f7:	e8 e3 02 00 00       	call   3df <close>
  fc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 103:	8b 45 f4             	mov    -0xc(%ebp),%eax
 106:	3b 03                	cmp    (%ebx),%eax
 108:	7c 88                	jl     92 <main+0x34>
      exit();
    }
    cat(fd);
    close(fd);
  }
  exit();
 10a:	e8 a8 02 00 00       	call   3b7 <exit>

0000010f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 10f:	55                   	push   %ebp
 110:	89 e5                	mov    %esp,%ebp
 112:	57                   	push   %edi
 113:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 114:	8b 4d 08             	mov    0x8(%ebp),%ecx
 117:	8b 55 10             	mov    0x10(%ebp),%edx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 cb                	mov    %ecx,%ebx
 11f:	89 df                	mov    %ebx,%edi
 121:	89 d1                	mov    %edx,%ecx
 123:	fc                   	cld    
 124:	f3 aa                	rep stos %al,%es:(%edi)
 126:	89 ca                	mov    %ecx,%edx
 128:	89 fb                	mov    %edi,%ebx
 12a:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 130:	90                   	nop
 131:	5b                   	pop    %ebx
 132:	5f                   	pop    %edi
 133:	5d                   	pop    %ebp
 134:	c3                   	ret    

00000135 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 141:	90                   	nop
 142:	8b 45 08             	mov    0x8(%ebp),%eax
 145:	8d 50 01             	lea    0x1(%eax),%edx
 148:	89 55 08             	mov    %edx,0x8(%ebp)
 14b:	8b 55 0c             	mov    0xc(%ebp),%edx
 14e:	8d 4a 01             	lea    0x1(%edx),%ecx
 151:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 154:	0f b6 12             	movzbl (%edx),%edx
 157:	88 10                	mov    %dl,(%eax)
 159:	0f b6 00             	movzbl (%eax),%eax
 15c:	84 c0                	test   %al,%al
 15e:	75 e2                	jne    142 <strcpy+0xd>
    ;
  return os;
 160:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 163:	c9                   	leave  
 164:	c3                   	ret    

00000165 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 165:	55                   	push   %ebp
 166:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 168:	eb 08                	jmp    172 <strcmp+0xd>
    p++, q++;
 16a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16e:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 172:	8b 45 08             	mov    0x8(%ebp),%eax
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	84 c0                	test   %al,%al
 17a:	74 10                	je     18c <strcmp+0x27>
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	0f b6 10             	movzbl (%eax),%edx
 182:	8b 45 0c             	mov    0xc(%ebp),%eax
 185:	0f b6 00             	movzbl (%eax),%eax
 188:	38 c2                	cmp    %al,%dl
 18a:	74 de                	je     16a <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 18c:	8b 45 08             	mov    0x8(%ebp),%eax
 18f:	0f b6 00             	movzbl (%eax),%eax
 192:	0f b6 d0             	movzbl %al,%edx
 195:	8b 45 0c             	mov    0xc(%ebp),%eax
 198:	0f b6 00             	movzbl (%eax),%eax
 19b:	0f b6 c0             	movzbl %al,%eax
 19e:	29 c2                	sub    %eax,%edx
 1a0:	89 d0                	mov    %edx,%eax
}
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    

000001a4 <strlen>:

uint
strlen(char *s)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b1:	eb 04                	jmp    1b7 <strlen+0x13>
 1b3:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ba:	8b 45 08             	mov    0x8(%ebp),%eax
 1bd:	01 d0                	add    %edx,%eax
 1bf:	0f b6 00             	movzbl (%eax),%eax
 1c2:	84 c0                	test   %al,%al
 1c4:	75 ed                	jne    1b3 <strlen+0xf>
    ;
  return n;
 1c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c9:	c9                   	leave  
 1ca:	c3                   	ret    

000001cb <memset>:

void*
memset(void *dst, int c, uint n)
{
 1cb:	55                   	push   %ebp
 1cc:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1ce:	8b 45 10             	mov    0x10(%ebp),%eax
 1d1:	50                   	push   %eax
 1d2:	ff 75 0c             	pushl  0xc(%ebp)
 1d5:	ff 75 08             	pushl  0x8(%ebp)
 1d8:	e8 32 ff ff ff       	call   10f <stosb>
 1dd:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1e0:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e3:	c9                   	leave  
 1e4:	c3                   	ret    

000001e5 <strchr>:

char*
strchr(const char *s, char c)
{
 1e5:	55                   	push   %ebp
 1e6:	89 e5                	mov    %esp,%ebp
 1e8:	83 ec 04             	sub    $0x4,%esp
 1eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ee:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1f1:	eb 14                	jmp    207 <strchr+0x22>
    if(*s == c)
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 00             	movzbl (%eax),%eax
 1f9:	3a 45 fc             	cmp    -0x4(%ebp),%al
 1fc:	75 05                	jne    203 <strchr+0x1e>
      return (char*)s;
 1fe:	8b 45 08             	mov    0x8(%ebp),%eax
 201:	eb 13                	jmp    216 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 203:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	0f b6 00             	movzbl (%eax),%eax
 20d:	84 c0                	test   %al,%al
 20f:	75 e2                	jne    1f3 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 211:	b8 00 00 00 00       	mov    $0x0,%eax
}
 216:	c9                   	leave  
 217:	c3                   	ret    

00000218 <gets>:

char*
gets(char *buf, int max)
{
 218:	55                   	push   %ebp
 219:	89 e5                	mov    %esp,%ebp
 21b:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 21e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 225:	eb 42                	jmp    269 <gets+0x51>
    cc = read(0, &c, 1);
 227:	83 ec 04             	sub    $0x4,%esp
 22a:	6a 01                	push   $0x1
 22c:	8d 45 ef             	lea    -0x11(%ebp),%eax
 22f:	50                   	push   %eax
 230:	6a 00                	push   $0x0
 232:	e8 98 01 00 00       	call   3cf <read>
 237:	83 c4 10             	add    $0x10,%esp
 23a:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 23d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 241:	7e 33                	jle    276 <gets+0x5e>
      break;
    buf[i++] = c;
 243:	8b 45 f4             	mov    -0xc(%ebp),%eax
 246:	8d 50 01             	lea    0x1(%eax),%edx
 249:	89 55 f4             	mov    %edx,-0xc(%ebp)
 24c:	89 c2                	mov    %eax,%edx
 24e:	8b 45 08             	mov    0x8(%ebp),%eax
 251:	01 c2                	add    %eax,%edx
 253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 257:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 259:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25d:	3c 0a                	cmp    $0xa,%al
 25f:	74 16                	je     277 <gets+0x5f>
 261:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 265:	3c 0d                	cmp    $0xd,%al
 267:	74 0e                	je     277 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 269:	8b 45 f4             	mov    -0xc(%ebp),%eax
 26c:	83 c0 01             	add    $0x1,%eax
 26f:	3b 45 0c             	cmp    0xc(%ebp),%eax
 272:	7c b3                	jl     227 <gets+0xf>
 274:	eb 01                	jmp    277 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 276:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 277:	8b 55 f4             	mov    -0xc(%ebp),%edx
 27a:	8b 45 08             	mov    0x8(%ebp),%eax
 27d:	01 d0                	add    %edx,%eax
 27f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 282:	8b 45 08             	mov    0x8(%ebp),%eax
}
 285:	c9                   	leave  
 286:	c3                   	ret    

00000287 <stat>:

int
stat(char *n, struct stat *st)
{
 287:	55                   	push   %ebp
 288:	89 e5                	mov    %esp,%ebp
 28a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 28d:	83 ec 08             	sub    $0x8,%esp
 290:	6a 00                	push   $0x0
 292:	ff 75 08             	pushl  0x8(%ebp)
 295:	e8 5d 01 00 00       	call   3f7 <open>
 29a:	83 c4 10             	add    $0x10,%esp
 29d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2a4:	79 07                	jns    2ad <stat+0x26>
    return -1;
 2a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ab:	eb 25                	jmp    2d2 <stat+0x4b>
  r = fstat(fd, st);
 2ad:	83 ec 08             	sub    $0x8,%esp
 2b0:	ff 75 0c             	pushl  0xc(%ebp)
 2b3:	ff 75 f4             	pushl  -0xc(%ebp)
 2b6:	e8 54 01 00 00       	call   40f <fstat>
 2bb:	83 c4 10             	add    $0x10,%esp
 2be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2c1:	83 ec 0c             	sub    $0xc,%esp
 2c4:	ff 75 f4             	pushl  -0xc(%ebp)
 2c7:	e8 13 01 00 00       	call   3df <close>
 2cc:	83 c4 10             	add    $0x10,%esp
  return r;
 2cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2d2:	c9                   	leave  
 2d3:	c3                   	ret    

000002d4 <atoi>:

int
atoi(const char *s)
{
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2e1:	eb 25                	jmp    308 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2e6:	89 d0                	mov    %edx,%eax
 2e8:	c1 e0 02             	shl    $0x2,%eax
 2eb:	01 d0                	add    %edx,%eax
 2ed:	01 c0                	add    %eax,%eax
 2ef:	89 c1                	mov    %eax,%ecx
 2f1:	8b 45 08             	mov    0x8(%ebp),%eax
 2f4:	8d 50 01             	lea    0x1(%eax),%edx
 2f7:	89 55 08             	mov    %edx,0x8(%ebp)
 2fa:	0f b6 00             	movzbl (%eax),%eax
 2fd:	0f be c0             	movsbl %al,%eax
 300:	01 c8                	add    %ecx,%eax
 302:	83 e8 30             	sub    $0x30,%eax
 305:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 308:	8b 45 08             	mov    0x8(%ebp),%eax
 30b:	0f b6 00             	movzbl (%eax),%eax
 30e:	3c 2f                	cmp    $0x2f,%al
 310:	7e 0a                	jle    31c <atoi+0x48>
 312:	8b 45 08             	mov    0x8(%ebp),%eax
 315:	0f b6 00             	movzbl (%eax),%eax
 318:	3c 39                	cmp    $0x39,%al
 31a:	7e c7                	jle    2e3 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 31c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 31f:	c9                   	leave  
 320:	c3                   	ret    

00000321 <itoa>:

char*
itoa(int val, int base){
 321:	55                   	push   %ebp
 322:	89 e5                	mov    %esp,%ebp
 324:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 327:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 32e:	eb 29                	jmp    359 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 330:	8b 45 08             	mov    0x8(%ebp),%eax
 333:	99                   	cltd   
 334:	f7 7d 0c             	idivl  0xc(%ebp)
 337:	89 d0                	mov    %edx,%eax
 339:	0f b6 80 22 09 00 00 	movzbl 0x922(%eax),%eax
 340:	8b 55 fc             	mov    -0x4(%ebp),%edx
 343:	81 c2 e0 0b 00 00    	add    $0xbe0,%edx
 349:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 34b:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 34f:	8b 45 08             	mov    0x8(%ebp),%eax
 352:	99                   	cltd   
 353:	f7 7d 0c             	idivl  0xc(%ebp)
 356:	89 45 08             	mov    %eax,0x8(%ebp)
 359:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 35d:	74 06                	je     365 <itoa+0x44>
 35f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 363:	75 cb                	jne    330 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 365:	8b 45 fc             	mov    -0x4(%ebp),%eax
 368:	83 c0 01             	add    $0x1,%eax
 36b:	05 e0 0b 00 00       	add    $0xbe0,%eax

}
 370:	c9                   	leave  
 371:	c3                   	ret    

00000372 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 372:	55                   	push   %ebp
 373:	89 e5                	mov    %esp,%ebp
 375:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 378:	8b 45 08             	mov    0x8(%ebp),%eax
 37b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 37e:	8b 45 0c             	mov    0xc(%ebp),%eax
 381:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 384:	eb 17                	jmp    39d <memmove+0x2b>
    *dst++ = *src++;
 386:	8b 45 fc             	mov    -0x4(%ebp),%eax
 389:	8d 50 01             	lea    0x1(%eax),%edx
 38c:	89 55 fc             	mov    %edx,-0x4(%ebp)
 38f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 392:	8d 4a 01             	lea    0x1(%edx),%ecx
 395:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 398:	0f b6 12             	movzbl (%edx),%edx
 39b:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 39d:	8b 45 10             	mov    0x10(%ebp),%eax
 3a0:	8d 50 ff             	lea    -0x1(%eax),%edx
 3a3:	89 55 10             	mov    %edx,0x10(%ebp)
 3a6:	85 c0                	test   %eax,%eax
 3a8:	7f dc                	jg     386 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3aa:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3ad:	c9                   	leave  
 3ae:	c3                   	ret    

000003af <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3af:	b8 01 00 00 00       	mov    $0x1,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <exit>:
SYSCALL(exit)
 3b7:	b8 02 00 00 00       	mov    $0x2,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <wait>:
SYSCALL(wait)
 3bf:	b8 03 00 00 00       	mov    $0x3,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <pipe>:
SYSCALL(pipe)
 3c7:	b8 04 00 00 00       	mov    $0x4,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <read>:
SYSCALL(read)
 3cf:	b8 05 00 00 00       	mov    $0x5,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <write>:
SYSCALL(write)
 3d7:	b8 10 00 00 00       	mov    $0x10,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <close>:
SYSCALL(close)
 3df:	b8 15 00 00 00       	mov    $0x15,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <kill>:
SYSCALL(kill)
 3e7:	b8 06 00 00 00       	mov    $0x6,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <exec>:
SYSCALL(exec)
 3ef:	b8 07 00 00 00       	mov    $0x7,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <open>:
SYSCALL(open)
 3f7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <mknod>:
SYSCALL(mknod)
 3ff:	b8 11 00 00 00       	mov    $0x11,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    

00000407 <unlink>:
SYSCALL(unlink)
 407:	b8 12 00 00 00       	mov    $0x12,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret    

0000040f <fstat>:
SYSCALL(fstat)
 40f:	b8 08 00 00 00       	mov    $0x8,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <link>:
SYSCALL(link)
 417:	b8 13 00 00 00       	mov    $0x13,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <mkdir>:
SYSCALL(mkdir)
 41f:	b8 14 00 00 00       	mov    $0x14,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret    

00000427 <chdir>:
SYSCALL(chdir)
 427:	b8 09 00 00 00       	mov    $0x9,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <dup>:
SYSCALL(dup)
 42f:	b8 0a 00 00 00       	mov    $0xa,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    

00000437 <getpid>:
SYSCALL(getpid)
 437:	b8 0b 00 00 00       	mov    $0xb,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret    

0000043f <sbrk>:
SYSCALL(sbrk)
 43f:	b8 0c 00 00 00       	mov    $0xc,%eax
 444:	cd 40                	int    $0x40
 446:	c3                   	ret    

00000447 <sleep>:
SYSCALL(sleep)
 447:	b8 0d 00 00 00       	mov    $0xd,%eax
 44c:	cd 40                	int    $0x40
 44e:	c3                   	ret    

0000044f <uptime>:
SYSCALL(uptime)
 44f:	b8 0e 00 00 00       	mov    $0xe,%eax
 454:	cd 40                	int    $0x40
 456:	c3                   	ret    

00000457 <randomX>:
SYSCALL(randomX)
 457:	b8 16 00 00 00       	mov    $0x16,%eax
 45c:	cd 40                	int    $0x40
 45e:	c3                   	ret    

0000045f <setSeedX>:
SYSCALL(setSeedX)
 45f:	b8 17 00 00 00       	mov    $0x17,%eax
 464:	cd 40                	int    $0x40
 466:	c3                   	ret    

00000467 <uniformR>:
SYSCALL(uniformR)
 467:	b8 18 00 00 00       	mov    $0x18,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 46f:	55                   	push   %ebp
 470:	89 e5                	mov    %esp,%ebp
 472:	83 ec 18             	sub    $0x18,%esp
 475:	8b 45 0c             	mov    0xc(%ebp),%eax
 478:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 47b:	83 ec 04             	sub    $0x4,%esp
 47e:	6a 01                	push   $0x1
 480:	8d 45 f4             	lea    -0xc(%ebp),%eax
 483:	50                   	push   %eax
 484:	ff 75 08             	pushl  0x8(%ebp)
 487:	e8 4b ff ff ff       	call   3d7 <write>
 48c:	83 c4 10             	add    $0x10,%esp
}
 48f:	90                   	nop
 490:	c9                   	leave  
 491:	c3                   	ret    

00000492 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 492:	55                   	push   %ebp
 493:	89 e5                	mov    %esp,%ebp
 495:	53                   	push   %ebx
 496:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 499:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4a0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4a4:	74 17                	je     4bd <printint+0x2b>
 4a6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4aa:	79 11                	jns    4bd <printint+0x2b>
    neg = 1;
 4ac:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b6:	f7 d8                	neg    %eax
 4b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4bb:	eb 06                	jmp    4c3 <printint+0x31>
  } else {
    x = xx;
 4bd:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4ca:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4cd:	8d 41 01             	lea    0x1(%ecx),%eax
 4d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4d3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d9:	ba 00 00 00 00       	mov    $0x0,%edx
 4de:	f7 f3                	div    %ebx
 4e0:	89 d0                	mov    %edx,%eax
 4e2:	0f b6 80 c8 0b 00 00 	movzbl 0xbc8(%eax),%eax
 4e9:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4ed:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4f0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4f3:	ba 00 00 00 00       	mov    $0x0,%edx
 4f8:	f7 f3                	div    %ebx
 4fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 501:	75 c7                	jne    4ca <printint+0x38>
  if(neg)
 503:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 507:	74 2d                	je     536 <printint+0xa4>
    buf[i++] = '-';
 509:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50c:	8d 50 01             	lea    0x1(%eax),%edx
 50f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 512:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 517:	eb 1d                	jmp    536 <printint+0xa4>
    putc(fd, buf[i]);
 519:	8d 55 dc             	lea    -0x24(%ebp),%edx
 51c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51f:	01 d0                	add    %edx,%eax
 521:	0f b6 00             	movzbl (%eax),%eax
 524:	0f be c0             	movsbl %al,%eax
 527:	83 ec 08             	sub    $0x8,%esp
 52a:	50                   	push   %eax
 52b:	ff 75 08             	pushl  0x8(%ebp)
 52e:	e8 3c ff ff ff       	call   46f <putc>
 533:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 536:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 53a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 53e:	79 d9                	jns    519 <printint+0x87>
    putc(fd, buf[i]);
}
 540:	90                   	nop
 541:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 544:	c9                   	leave  
 545:	c3                   	ret    

00000546 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 546:	55                   	push   %ebp
 547:	89 e5                	mov    %esp,%ebp
 549:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 54c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 553:	8d 45 0c             	lea    0xc(%ebp),%eax
 556:	83 c0 04             	add    $0x4,%eax
 559:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 55c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 563:	e9 59 01 00 00       	jmp    6c1 <printf+0x17b>
    c = fmt[i] & 0xff;
 568:	8b 55 0c             	mov    0xc(%ebp),%edx
 56b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 56e:	01 d0                	add    %edx,%eax
 570:	0f b6 00             	movzbl (%eax),%eax
 573:	0f be c0             	movsbl %al,%eax
 576:	25 ff 00 00 00       	and    $0xff,%eax
 57b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 57e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 582:	75 2c                	jne    5b0 <printf+0x6a>
      if(c == '%'){
 584:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 588:	75 0c                	jne    596 <printf+0x50>
        state = '%';
 58a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 591:	e9 27 01 00 00       	jmp    6bd <printf+0x177>
      } else {
        putc(fd, c);
 596:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 599:	0f be c0             	movsbl %al,%eax
 59c:	83 ec 08             	sub    $0x8,%esp
 59f:	50                   	push   %eax
 5a0:	ff 75 08             	pushl  0x8(%ebp)
 5a3:	e8 c7 fe ff ff       	call   46f <putc>
 5a8:	83 c4 10             	add    $0x10,%esp
 5ab:	e9 0d 01 00 00       	jmp    6bd <printf+0x177>
      }
    } else if(state == '%'){
 5b0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5b4:	0f 85 03 01 00 00    	jne    6bd <printf+0x177>
      if(c == 'd'){
 5ba:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5be:	75 1e                	jne    5de <printf+0x98>
        printint(fd, *ap, 10, 1);
 5c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c3:	8b 00                	mov    (%eax),%eax
 5c5:	6a 01                	push   $0x1
 5c7:	6a 0a                	push   $0xa
 5c9:	50                   	push   %eax
 5ca:	ff 75 08             	pushl  0x8(%ebp)
 5cd:	e8 c0 fe ff ff       	call   492 <printint>
 5d2:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d9:	e9 d8 00 00 00       	jmp    6b6 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5de:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5e2:	74 06                	je     5ea <printf+0xa4>
 5e4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5e8:	75 1e                	jne    608 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ed:	8b 00                	mov    (%eax),%eax
 5ef:	6a 00                	push   $0x0
 5f1:	6a 10                	push   $0x10
 5f3:	50                   	push   %eax
 5f4:	ff 75 08             	pushl  0x8(%ebp)
 5f7:	e8 96 fe ff ff       	call   492 <printint>
 5fc:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 603:	e9 ae 00 00 00       	jmp    6b6 <printf+0x170>
      } else if(c == 's'){
 608:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 60c:	75 43                	jne    651 <printf+0x10b>
        s = (char*)*ap;
 60e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 611:	8b 00                	mov    (%eax),%eax
 613:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 616:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 61a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 61e:	75 25                	jne    645 <printf+0xff>
          s = "(null)";
 620:	c7 45 f4 33 09 00 00 	movl   $0x933,-0xc(%ebp)
        while(*s != 0){
 627:	eb 1c                	jmp    645 <printf+0xff>
          putc(fd, *s);
 629:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62c:	0f b6 00             	movzbl (%eax),%eax
 62f:	0f be c0             	movsbl %al,%eax
 632:	83 ec 08             	sub    $0x8,%esp
 635:	50                   	push   %eax
 636:	ff 75 08             	pushl  0x8(%ebp)
 639:	e8 31 fe ff ff       	call   46f <putc>
 63e:	83 c4 10             	add    $0x10,%esp
          s++;
 641:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 645:	8b 45 f4             	mov    -0xc(%ebp),%eax
 648:	0f b6 00             	movzbl (%eax),%eax
 64b:	84 c0                	test   %al,%al
 64d:	75 da                	jne    629 <printf+0xe3>
 64f:	eb 65                	jmp    6b6 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 651:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 655:	75 1d                	jne    674 <printf+0x12e>
        putc(fd, *ap);
 657:	8b 45 e8             	mov    -0x18(%ebp),%eax
 65a:	8b 00                	mov    (%eax),%eax
 65c:	0f be c0             	movsbl %al,%eax
 65f:	83 ec 08             	sub    $0x8,%esp
 662:	50                   	push   %eax
 663:	ff 75 08             	pushl  0x8(%ebp)
 666:	e8 04 fe ff ff       	call   46f <putc>
 66b:	83 c4 10             	add    $0x10,%esp
        ap++;
 66e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 672:	eb 42                	jmp    6b6 <printf+0x170>
      } else if(c == '%'){
 674:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 678:	75 17                	jne    691 <printf+0x14b>
        putc(fd, c);
 67a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 67d:	0f be c0             	movsbl %al,%eax
 680:	83 ec 08             	sub    $0x8,%esp
 683:	50                   	push   %eax
 684:	ff 75 08             	pushl  0x8(%ebp)
 687:	e8 e3 fd ff ff       	call   46f <putc>
 68c:	83 c4 10             	add    $0x10,%esp
 68f:	eb 25                	jmp    6b6 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 691:	83 ec 08             	sub    $0x8,%esp
 694:	6a 25                	push   $0x25
 696:	ff 75 08             	pushl  0x8(%ebp)
 699:	e8 d1 fd ff ff       	call   46f <putc>
 69e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a4:	0f be c0             	movsbl %al,%eax
 6a7:	83 ec 08             	sub    $0x8,%esp
 6aa:	50                   	push   %eax
 6ab:	ff 75 08             	pushl  0x8(%ebp)
 6ae:	e8 bc fd ff ff       	call   46f <putc>
 6b3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6bd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6c1:	8b 55 0c             	mov    0xc(%ebp),%edx
 6c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c7:	01 d0                	add    %edx,%eax
 6c9:	0f b6 00             	movzbl (%eax),%eax
 6cc:	84 c0                	test   %al,%al
 6ce:	0f 85 94 fe ff ff    	jne    568 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6d4:	90                   	nop
 6d5:	c9                   	leave  
 6d6:	c3                   	ret    

000006d7 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d7:	55                   	push   %ebp
 6d8:	89 e5                	mov    %esp,%ebp
 6da:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6dd:	8b 45 08             	mov    0x8(%ebp),%eax
 6e0:	83 e8 08             	sub    $0x8,%eax
 6e3:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e6:	a1 08 0c 00 00       	mov    0xc08,%eax
 6eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6ee:	eb 24                	jmp    714 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 00                	mov    (%eax),%eax
 6f5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6f8:	77 12                	ja     70c <free+0x35>
 6fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 700:	77 24                	ja     726 <free+0x4f>
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 00                	mov    (%eax),%eax
 707:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 70a:	77 1a                	ja     726 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	8b 00                	mov    (%eax),%eax
 711:	89 45 fc             	mov    %eax,-0x4(%ebp)
 714:	8b 45 f8             	mov    -0x8(%ebp),%eax
 717:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71a:	76 d4                	jbe    6f0 <free+0x19>
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	8b 00                	mov    (%eax),%eax
 721:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 724:	76 ca                	jbe    6f0 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 726:	8b 45 f8             	mov    -0x8(%ebp),%eax
 729:	8b 40 04             	mov    0x4(%eax),%eax
 72c:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 733:	8b 45 f8             	mov    -0x8(%ebp),%eax
 736:	01 c2                	add    %eax,%edx
 738:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73b:	8b 00                	mov    (%eax),%eax
 73d:	39 c2                	cmp    %eax,%edx
 73f:	75 24                	jne    765 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 741:	8b 45 f8             	mov    -0x8(%ebp),%eax
 744:	8b 50 04             	mov    0x4(%eax),%edx
 747:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74a:	8b 00                	mov    (%eax),%eax
 74c:	8b 40 04             	mov    0x4(%eax),%eax
 74f:	01 c2                	add    %eax,%edx
 751:	8b 45 f8             	mov    -0x8(%ebp),%eax
 754:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	8b 00                	mov    (%eax),%eax
 75c:	8b 10                	mov    (%eax),%edx
 75e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 761:	89 10                	mov    %edx,(%eax)
 763:	eb 0a                	jmp    76f <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 765:	8b 45 fc             	mov    -0x4(%ebp),%eax
 768:	8b 10                	mov    (%eax),%edx
 76a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76d:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 76f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 772:	8b 40 04             	mov    0x4(%eax),%eax
 775:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 77c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77f:	01 d0                	add    %edx,%eax
 781:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 784:	75 20                	jne    7a6 <free+0xcf>
    p->s.size += bp->s.size;
 786:	8b 45 fc             	mov    -0x4(%ebp),%eax
 789:	8b 50 04             	mov    0x4(%eax),%edx
 78c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78f:	8b 40 04             	mov    0x4(%eax),%eax
 792:	01 c2                	add    %eax,%edx
 794:	8b 45 fc             	mov    -0x4(%ebp),%eax
 797:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 79a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79d:	8b 10                	mov    (%eax),%edx
 79f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a2:	89 10                	mov    %edx,(%eax)
 7a4:	eb 08                	jmp    7ae <free+0xd7>
  } else
    p->s.ptr = bp;
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7ac:	89 10                	mov    %edx,(%eax)
  freep = p;
 7ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b1:	a3 08 0c 00 00       	mov    %eax,0xc08
}
 7b6:	90                   	nop
 7b7:	c9                   	leave  
 7b8:	c3                   	ret    

000007b9 <morecore>:

static Header*
morecore(uint nu)
{
 7b9:	55                   	push   %ebp
 7ba:	89 e5                	mov    %esp,%ebp
 7bc:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7bf:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7c6:	77 07                	ja     7cf <morecore+0x16>
    nu = 4096;
 7c8:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7cf:	8b 45 08             	mov    0x8(%ebp),%eax
 7d2:	c1 e0 03             	shl    $0x3,%eax
 7d5:	83 ec 0c             	sub    $0xc,%esp
 7d8:	50                   	push   %eax
 7d9:	e8 61 fc ff ff       	call   43f <sbrk>
 7de:	83 c4 10             	add    $0x10,%esp
 7e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7e4:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7e8:	75 07                	jne    7f1 <morecore+0x38>
    return 0;
 7ea:	b8 00 00 00 00       	mov    $0x0,%eax
 7ef:	eb 26                	jmp    817 <morecore+0x5e>
  hp = (Header*)p;
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fa:	8b 55 08             	mov    0x8(%ebp),%edx
 7fd:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 800:	8b 45 f0             	mov    -0x10(%ebp),%eax
 803:	83 c0 08             	add    $0x8,%eax
 806:	83 ec 0c             	sub    $0xc,%esp
 809:	50                   	push   %eax
 80a:	e8 c8 fe ff ff       	call   6d7 <free>
 80f:	83 c4 10             	add    $0x10,%esp
  return freep;
 812:	a1 08 0c 00 00       	mov    0xc08,%eax
}
 817:	c9                   	leave  
 818:	c3                   	ret    

00000819 <malloc>:

void*
malloc(uint nbytes)
{
 819:	55                   	push   %ebp
 81a:	89 e5                	mov    %esp,%ebp
 81c:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 81f:	8b 45 08             	mov    0x8(%ebp),%eax
 822:	83 c0 07             	add    $0x7,%eax
 825:	c1 e8 03             	shr    $0x3,%eax
 828:	83 c0 01             	add    $0x1,%eax
 82b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 82e:	a1 08 0c 00 00       	mov    0xc08,%eax
 833:	89 45 f0             	mov    %eax,-0x10(%ebp)
 836:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 83a:	75 23                	jne    85f <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 83c:	c7 45 f0 00 0c 00 00 	movl   $0xc00,-0x10(%ebp)
 843:	8b 45 f0             	mov    -0x10(%ebp),%eax
 846:	a3 08 0c 00 00       	mov    %eax,0xc08
 84b:	a1 08 0c 00 00       	mov    0xc08,%eax
 850:	a3 00 0c 00 00       	mov    %eax,0xc00
    base.s.size = 0;
 855:	c7 05 04 0c 00 00 00 	movl   $0x0,0xc04
 85c:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 862:	8b 00                	mov    (%eax),%eax
 864:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 867:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86a:	8b 40 04             	mov    0x4(%eax),%eax
 86d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 870:	72 4d                	jb     8bf <malloc+0xa6>
      if(p->s.size == nunits)
 872:	8b 45 f4             	mov    -0xc(%ebp),%eax
 875:	8b 40 04             	mov    0x4(%eax),%eax
 878:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 87b:	75 0c                	jne    889 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 87d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 880:	8b 10                	mov    (%eax),%edx
 882:	8b 45 f0             	mov    -0x10(%ebp),%eax
 885:	89 10                	mov    %edx,(%eax)
 887:	eb 26                	jmp    8af <malloc+0x96>
      else {
        p->s.size -= nunits;
 889:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88c:	8b 40 04             	mov    0x4(%eax),%eax
 88f:	2b 45 ec             	sub    -0x14(%ebp),%eax
 892:	89 c2                	mov    %eax,%edx
 894:	8b 45 f4             	mov    -0xc(%ebp),%eax
 897:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 89a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89d:	8b 40 04             	mov    0x4(%eax),%eax
 8a0:	c1 e0 03             	shl    $0x3,%eax
 8a3:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a9:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8ac:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b2:	a3 08 0c 00 00       	mov    %eax,0xc08
      return (void*)(p + 1);
 8b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ba:	83 c0 08             	add    $0x8,%eax
 8bd:	eb 3b                	jmp    8fa <malloc+0xe1>
    }
    if(p == freep)
 8bf:	a1 08 0c 00 00       	mov    0xc08,%eax
 8c4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8c7:	75 1e                	jne    8e7 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8c9:	83 ec 0c             	sub    $0xc,%esp
 8cc:	ff 75 ec             	pushl  -0x14(%ebp)
 8cf:	e8 e5 fe ff ff       	call   7b9 <morecore>
 8d4:	83 c4 10             	add    $0x10,%esp
 8d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8de:	75 07                	jne    8e7 <malloc+0xce>
        return 0;
 8e0:	b8 00 00 00 00       	mov    $0x0,%eax
 8e5:	eb 13                	jmp    8fa <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f0:	8b 00                	mov    (%eax),%eax
 8f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8f5:	e9 6d ff ff ff       	jmp    867 <malloc+0x4e>
}
 8fa:	c9                   	leave  
 8fb:	c3                   	ret    
