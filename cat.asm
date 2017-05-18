
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
   e:	68 40 0c 00 00       	push   $0xc40
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
  25:	68 40 0c 00 00       	push   $0xc40
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
  47:	68 04 09 00 00       	push   $0x904
  4c:	6a 01                	push   $0x1
  4e:	e8 fb 04 00 00       	call   54e <printf>
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
  cf:	68 15 09 00 00       	push   $0x915
  d4:	6a 01                	push   $0x1
  d6:	e8 73 04 00 00       	call   54e <printf>
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
 339:	0f b6 80 2a 09 00 00 	movzbl 0x92a(%eax),%eax
 340:	8b 55 fc             	mov    -0x4(%ebp),%edx
 343:	81 c2 00 0c 00 00    	add    $0xc00,%edx
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
 36b:	05 00 0c 00 00       	add    $0xc00,%eax

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

0000046f <setdeadline>:
 46f:	b8 19 00 00 00       	mov    $0x19,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 477:	55                   	push   %ebp
 478:	89 e5                	mov    %esp,%ebp
 47a:	83 ec 18             	sub    $0x18,%esp
 47d:	8b 45 0c             	mov    0xc(%ebp),%eax
 480:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 483:	83 ec 04             	sub    $0x4,%esp
 486:	6a 01                	push   $0x1
 488:	8d 45 f4             	lea    -0xc(%ebp),%eax
 48b:	50                   	push   %eax
 48c:	ff 75 08             	pushl  0x8(%ebp)
 48f:	e8 43 ff ff ff       	call   3d7 <write>
 494:	83 c4 10             	add    $0x10,%esp
}
 497:	90                   	nop
 498:	c9                   	leave  
 499:	c3                   	ret    

0000049a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 49a:	55                   	push   %ebp
 49b:	89 e5                	mov    %esp,%ebp
 49d:	53                   	push   %ebx
 49e:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4a1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4a8:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4ac:	74 17                	je     4c5 <printint+0x2b>
 4ae:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4b2:	79 11                	jns    4c5 <printint+0x2b>
    neg = 1;
 4b4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4bb:	8b 45 0c             	mov    0xc(%ebp),%eax
 4be:	f7 d8                	neg    %eax
 4c0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4c3:	eb 06                	jmp    4cb <printint+0x31>
  } else {
    x = xx;
 4c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4cb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4d2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4d5:	8d 41 01             	lea    0x1(%ecx),%eax
 4d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4db:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4de:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4e1:	ba 00 00 00 00       	mov    $0x0,%edx
 4e6:	f7 f3                	div    %ebx
 4e8:	89 d0                	mov    %edx,%eax
 4ea:	0f b6 80 d0 0b 00 00 	movzbl 0xbd0(%eax),%eax
 4f1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4f5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4fb:	ba 00 00 00 00       	mov    $0x0,%edx
 500:	f7 f3                	div    %ebx
 502:	89 45 ec             	mov    %eax,-0x14(%ebp)
 505:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 509:	75 c7                	jne    4d2 <printint+0x38>
  if(neg)
 50b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 50f:	74 2d                	je     53e <printint+0xa4>
    buf[i++] = '-';
 511:	8b 45 f4             	mov    -0xc(%ebp),%eax
 514:	8d 50 01             	lea    0x1(%eax),%edx
 517:	89 55 f4             	mov    %edx,-0xc(%ebp)
 51a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 51f:	eb 1d                	jmp    53e <printint+0xa4>
    putc(fd, buf[i]);
 521:	8d 55 dc             	lea    -0x24(%ebp),%edx
 524:	8b 45 f4             	mov    -0xc(%ebp),%eax
 527:	01 d0                	add    %edx,%eax
 529:	0f b6 00             	movzbl (%eax),%eax
 52c:	0f be c0             	movsbl %al,%eax
 52f:	83 ec 08             	sub    $0x8,%esp
 532:	50                   	push   %eax
 533:	ff 75 08             	pushl  0x8(%ebp)
 536:	e8 3c ff ff ff       	call   477 <putc>
 53b:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 53e:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 542:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 546:	79 d9                	jns    521 <printint+0x87>
    putc(fd, buf[i]);
}
 548:	90                   	nop
 549:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 54c:	c9                   	leave  
 54d:	c3                   	ret    

0000054e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 54e:	55                   	push   %ebp
 54f:	89 e5                	mov    %esp,%ebp
 551:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 554:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 55b:	8d 45 0c             	lea    0xc(%ebp),%eax
 55e:	83 c0 04             	add    $0x4,%eax
 561:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 564:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 56b:	e9 59 01 00 00       	jmp    6c9 <printf+0x17b>
    c = fmt[i] & 0xff;
 570:	8b 55 0c             	mov    0xc(%ebp),%edx
 573:	8b 45 f0             	mov    -0x10(%ebp),%eax
 576:	01 d0                	add    %edx,%eax
 578:	0f b6 00             	movzbl (%eax),%eax
 57b:	0f be c0             	movsbl %al,%eax
 57e:	25 ff 00 00 00       	and    $0xff,%eax
 583:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 586:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 58a:	75 2c                	jne    5b8 <printf+0x6a>
      if(c == '%'){
 58c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 590:	75 0c                	jne    59e <printf+0x50>
        state = '%';
 592:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 599:	e9 27 01 00 00       	jmp    6c5 <printf+0x177>
      } else {
        putc(fd, c);
 59e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a1:	0f be c0             	movsbl %al,%eax
 5a4:	83 ec 08             	sub    $0x8,%esp
 5a7:	50                   	push   %eax
 5a8:	ff 75 08             	pushl  0x8(%ebp)
 5ab:	e8 c7 fe ff ff       	call   477 <putc>
 5b0:	83 c4 10             	add    $0x10,%esp
 5b3:	e9 0d 01 00 00       	jmp    6c5 <printf+0x177>
      }
    } else if(state == '%'){
 5b8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5bc:	0f 85 03 01 00 00    	jne    6c5 <printf+0x177>
      if(c == 'd'){
 5c2:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5c6:	75 1e                	jne    5e6 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5c8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cb:	8b 00                	mov    (%eax),%eax
 5cd:	6a 01                	push   $0x1
 5cf:	6a 0a                	push   $0xa
 5d1:	50                   	push   %eax
 5d2:	ff 75 08             	pushl  0x8(%ebp)
 5d5:	e8 c0 fe ff ff       	call   49a <printint>
 5da:	83 c4 10             	add    $0x10,%esp
        ap++;
 5dd:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e1:	e9 d8 00 00 00       	jmp    6be <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5e6:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5ea:	74 06                	je     5f2 <printf+0xa4>
 5ec:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5f0:	75 1e                	jne    610 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5f2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f5:	8b 00                	mov    (%eax),%eax
 5f7:	6a 00                	push   $0x0
 5f9:	6a 10                	push   $0x10
 5fb:	50                   	push   %eax
 5fc:	ff 75 08             	pushl  0x8(%ebp)
 5ff:	e8 96 fe ff ff       	call   49a <printint>
 604:	83 c4 10             	add    $0x10,%esp
        ap++;
 607:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 60b:	e9 ae 00 00 00       	jmp    6be <printf+0x170>
      } else if(c == 's'){
 610:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 614:	75 43                	jne    659 <printf+0x10b>
        s = (char*)*ap;
 616:	8b 45 e8             	mov    -0x18(%ebp),%eax
 619:	8b 00                	mov    (%eax),%eax
 61b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 61e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 622:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 626:	75 25                	jne    64d <printf+0xff>
          s = "(null)";
 628:	c7 45 f4 3b 09 00 00 	movl   $0x93b,-0xc(%ebp)
        while(*s != 0){
 62f:	eb 1c                	jmp    64d <printf+0xff>
          putc(fd, *s);
 631:	8b 45 f4             	mov    -0xc(%ebp),%eax
 634:	0f b6 00             	movzbl (%eax),%eax
 637:	0f be c0             	movsbl %al,%eax
 63a:	83 ec 08             	sub    $0x8,%esp
 63d:	50                   	push   %eax
 63e:	ff 75 08             	pushl  0x8(%ebp)
 641:	e8 31 fe ff ff       	call   477 <putc>
 646:	83 c4 10             	add    $0x10,%esp
          s++;
 649:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 64d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 650:	0f b6 00             	movzbl (%eax),%eax
 653:	84 c0                	test   %al,%al
 655:	75 da                	jne    631 <printf+0xe3>
 657:	eb 65                	jmp    6be <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 659:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 65d:	75 1d                	jne    67c <printf+0x12e>
        putc(fd, *ap);
 65f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 662:	8b 00                	mov    (%eax),%eax
 664:	0f be c0             	movsbl %al,%eax
 667:	83 ec 08             	sub    $0x8,%esp
 66a:	50                   	push   %eax
 66b:	ff 75 08             	pushl  0x8(%ebp)
 66e:	e8 04 fe ff ff       	call   477 <putc>
 673:	83 c4 10             	add    $0x10,%esp
        ap++;
 676:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 67a:	eb 42                	jmp    6be <printf+0x170>
      } else if(c == '%'){
 67c:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 680:	75 17                	jne    699 <printf+0x14b>
        putc(fd, c);
 682:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 685:	0f be c0             	movsbl %al,%eax
 688:	83 ec 08             	sub    $0x8,%esp
 68b:	50                   	push   %eax
 68c:	ff 75 08             	pushl  0x8(%ebp)
 68f:	e8 e3 fd ff ff       	call   477 <putc>
 694:	83 c4 10             	add    $0x10,%esp
 697:	eb 25                	jmp    6be <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 699:	83 ec 08             	sub    $0x8,%esp
 69c:	6a 25                	push   $0x25
 69e:	ff 75 08             	pushl  0x8(%ebp)
 6a1:	e8 d1 fd ff ff       	call   477 <putc>
 6a6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6a9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ac:	0f be c0             	movsbl %al,%eax
 6af:	83 ec 08             	sub    $0x8,%esp
 6b2:	50                   	push   %eax
 6b3:	ff 75 08             	pushl  0x8(%ebp)
 6b6:	e8 bc fd ff ff       	call   477 <putc>
 6bb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6be:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6c9:	8b 55 0c             	mov    0xc(%ebp),%edx
 6cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6cf:	01 d0                	add    %edx,%eax
 6d1:	0f b6 00             	movzbl (%eax),%eax
 6d4:	84 c0                	test   %al,%al
 6d6:	0f 85 94 fe ff ff    	jne    570 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6dc:	90                   	nop
 6dd:	c9                   	leave  
 6de:	c3                   	ret    

000006df <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6df:	55                   	push   %ebp
 6e0:	89 e5                	mov    %esp,%ebp
 6e2:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6e5:	8b 45 08             	mov    0x8(%ebp),%eax
 6e8:	83 e8 08             	sub    $0x8,%eax
 6eb:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6ee:	a1 28 0c 00 00       	mov    0xc28,%eax
 6f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6f6:	eb 24                	jmp    71c <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fb:	8b 00                	mov    (%eax),%eax
 6fd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 700:	77 12                	ja     714 <free+0x35>
 702:	8b 45 f8             	mov    -0x8(%ebp),%eax
 705:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 708:	77 24                	ja     72e <free+0x4f>
 70a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70d:	8b 00                	mov    (%eax),%eax
 70f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 712:	77 1a                	ja     72e <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	8b 00                	mov    (%eax),%eax
 719:	89 45 fc             	mov    %eax,-0x4(%ebp)
 71c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 722:	76 d4                	jbe    6f8 <free+0x19>
 724:	8b 45 fc             	mov    -0x4(%ebp),%eax
 727:	8b 00                	mov    (%eax),%eax
 729:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 72c:	76 ca                	jbe    6f8 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 72e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 731:	8b 40 04             	mov    0x4(%eax),%eax
 734:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 73b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73e:	01 c2                	add    %eax,%edx
 740:	8b 45 fc             	mov    -0x4(%ebp),%eax
 743:	8b 00                	mov    (%eax),%eax
 745:	39 c2                	cmp    %eax,%edx
 747:	75 24                	jne    76d <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 749:	8b 45 f8             	mov    -0x8(%ebp),%eax
 74c:	8b 50 04             	mov    0x4(%eax),%edx
 74f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 752:	8b 00                	mov    (%eax),%eax
 754:	8b 40 04             	mov    0x4(%eax),%eax
 757:	01 c2                	add    %eax,%edx
 759:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75c:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 75f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 762:	8b 00                	mov    (%eax),%eax
 764:	8b 10                	mov    (%eax),%edx
 766:	8b 45 f8             	mov    -0x8(%ebp),%eax
 769:	89 10                	mov    %edx,(%eax)
 76b:	eb 0a                	jmp    777 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 76d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 770:	8b 10                	mov    (%eax),%edx
 772:	8b 45 f8             	mov    -0x8(%ebp),%eax
 775:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 40 04             	mov    0x4(%eax),%eax
 77d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 784:	8b 45 fc             	mov    -0x4(%ebp),%eax
 787:	01 d0                	add    %edx,%eax
 789:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 78c:	75 20                	jne    7ae <free+0xcf>
    p->s.size += bp->s.size;
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	8b 50 04             	mov    0x4(%eax),%edx
 794:	8b 45 f8             	mov    -0x8(%ebp),%eax
 797:	8b 40 04             	mov    0x4(%eax),%eax
 79a:	01 c2                	add    %eax,%edx
 79c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a5:	8b 10                	mov    (%eax),%edx
 7a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7aa:	89 10                	mov    %edx,(%eax)
 7ac:	eb 08                	jmp    7b6 <free+0xd7>
  } else
    p->s.ptr = bp;
 7ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b1:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7b4:	89 10                	mov    %edx,(%eax)
  freep = p;
 7b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b9:	a3 28 0c 00 00       	mov    %eax,0xc28
}
 7be:	90                   	nop
 7bf:	c9                   	leave  
 7c0:	c3                   	ret    

000007c1 <morecore>:

static Header*
morecore(uint nu)
{
 7c1:	55                   	push   %ebp
 7c2:	89 e5                	mov    %esp,%ebp
 7c4:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7c7:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7ce:	77 07                	ja     7d7 <morecore+0x16>
    nu = 4096;
 7d0:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7d7:	8b 45 08             	mov    0x8(%ebp),%eax
 7da:	c1 e0 03             	shl    $0x3,%eax
 7dd:	83 ec 0c             	sub    $0xc,%esp
 7e0:	50                   	push   %eax
 7e1:	e8 59 fc ff ff       	call   43f <sbrk>
 7e6:	83 c4 10             	add    $0x10,%esp
 7e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7ec:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7f0:	75 07                	jne    7f9 <morecore+0x38>
    return 0;
 7f2:	b8 00 00 00 00       	mov    $0x0,%eax
 7f7:	eb 26                	jmp    81f <morecore+0x5e>
  hp = (Header*)p;
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 802:	8b 55 08             	mov    0x8(%ebp),%edx
 805:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 808:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80b:	83 c0 08             	add    $0x8,%eax
 80e:	83 ec 0c             	sub    $0xc,%esp
 811:	50                   	push   %eax
 812:	e8 c8 fe ff ff       	call   6df <free>
 817:	83 c4 10             	add    $0x10,%esp
  return freep;
 81a:	a1 28 0c 00 00       	mov    0xc28,%eax
}
 81f:	c9                   	leave  
 820:	c3                   	ret    

00000821 <malloc>:

void*
malloc(uint nbytes)
{
 821:	55                   	push   %ebp
 822:	89 e5                	mov    %esp,%ebp
 824:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 827:	8b 45 08             	mov    0x8(%ebp),%eax
 82a:	83 c0 07             	add    $0x7,%eax
 82d:	c1 e8 03             	shr    $0x3,%eax
 830:	83 c0 01             	add    $0x1,%eax
 833:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 836:	a1 28 0c 00 00       	mov    0xc28,%eax
 83b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 83e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 842:	75 23                	jne    867 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 844:	c7 45 f0 20 0c 00 00 	movl   $0xc20,-0x10(%ebp)
 84b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84e:	a3 28 0c 00 00       	mov    %eax,0xc28
 853:	a1 28 0c 00 00       	mov    0xc28,%eax
 858:	a3 20 0c 00 00       	mov    %eax,0xc20
    base.s.size = 0;
 85d:	c7 05 24 0c 00 00 00 	movl   $0x0,0xc24
 864:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 867:	8b 45 f0             	mov    -0x10(%ebp),%eax
 86a:	8b 00                	mov    (%eax),%eax
 86c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 86f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 872:	8b 40 04             	mov    0x4(%eax),%eax
 875:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 878:	72 4d                	jb     8c7 <malloc+0xa6>
      if(p->s.size == nunits)
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	8b 40 04             	mov    0x4(%eax),%eax
 880:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 883:	75 0c                	jne    891 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 885:	8b 45 f4             	mov    -0xc(%ebp),%eax
 888:	8b 10                	mov    (%eax),%edx
 88a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88d:	89 10                	mov    %edx,(%eax)
 88f:	eb 26                	jmp    8b7 <malloc+0x96>
      else {
        p->s.size -= nunits;
 891:	8b 45 f4             	mov    -0xc(%ebp),%eax
 894:	8b 40 04             	mov    0x4(%eax),%eax
 897:	2b 45 ec             	sub    -0x14(%ebp),%eax
 89a:	89 c2                	mov    %eax,%edx
 89c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89f:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a5:	8b 40 04             	mov    0x4(%eax),%eax
 8a8:	c1 e0 03             	shl    $0x3,%eax
 8ab:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b1:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8b4:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ba:	a3 28 0c 00 00       	mov    %eax,0xc28
      return (void*)(p + 1);
 8bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c2:	83 c0 08             	add    $0x8,%eax
 8c5:	eb 3b                	jmp    902 <malloc+0xe1>
    }
    if(p == freep)
 8c7:	a1 28 0c 00 00       	mov    0xc28,%eax
 8cc:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8cf:	75 1e                	jne    8ef <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8d1:	83 ec 0c             	sub    $0xc,%esp
 8d4:	ff 75 ec             	pushl  -0x14(%ebp)
 8d7:	e8 e5 fe ff ff       	call   7c1 <morecore>
 8dc:	83 c4 10             	add    $0x10,%esp
 8df:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8e6:	75 07                	jne    8ef <malloc+0xce>
        return 0;
 8e8:	b8 00 00 00 00       	mov    $0x0,%eax
 8ed:	eb 13                	jmp    902 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f8:	8b 00                	mov    (%eax),%eax
 8fa:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 8fd:	e9 6d ff ff ff       	jmp    86f <malloc+0x4e>
}
 902:	c9                   	leave  
 903:	c3                   	ret    
