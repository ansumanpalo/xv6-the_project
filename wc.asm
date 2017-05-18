
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 69                	jmp    8b <wc+0x8b>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 58                	jmp    83 <wc+0x83>
      c++;
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 00 0d 00 00       	add    $0xd00,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 00 0d 00 00       	add    $0xd00,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	83 ec 08             	sub    $0x8,%esp
  53:	50                   	push   %eax
  54:	68 b2 09 00 00       	push   $0x9b2
  59:	e8 35 02 00 00       	call   293 <strchr>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	85 c0                	test   %eax,%eax
  63:	74 09                	je     6e <wc+0x6e>
        inword = 0;
  65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6c:	eb 11                	jmp    7f <wc+0x7f>
      else if(!inword){
  6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  72:	75 0b                	jne    7f <wc+0x7f>
        w++;
  74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
  7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  89:	7c a0                	jl     2b <wc+0x2b>
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8b:	83 ec 04             	sub    $0x4,%esp
  8e:	68 00 02 00 00       	push   $0x200
  93:	68 00 0d 00 00       	push   $0xd00
  98:	ff 75 08             	pushl  0x8(%ebp)
  9b:	e8 dd 03 00 00       	call   47d <read>
  a0:	83 c4 10             	add    $0x10,%esp
  a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
        w++;
        inword = 1;
      }
    }
  }
  if(n < 0){
  b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b4:	79 17                	jns    cd <wc+0xcd>
    printf(1, "wc: read error\n");
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 b8 09 00 00       	push   $0x9b8
  be:	6a 01                	push   $0x1
  c0:	e8 37 05 00 00       	call   5fc <printf>
  c5:	83 c4 10             	add    $0x10,%esp
    exit();
  c8:	e8 98 03 00 00       	call   465 <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	ff 75 0c             	pushl  0xc(%ebp)
  d3:	ff 75 e8             	pushl  -0x18(%ebp)
  d6:	ff 75 ec             	pushl  -0x14(%ebp)
  d9:	ff 75 f0             	pushl  -0x10(%ebp)
  dc:	68 c8 09 00 00       	push   $0x9c8
  e1:	6a 01                	push   $0x1
  e3:	e8 14 05 00 00       	call   5fc <printf>
  e8:	83 c4 20             	add    $0x20,%esp
}
  eb:	90                   	nop
  ec:	c9                   	leave  
  ed:	c3                   	ret    

000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f2:	83 e4 f0             	and    $0xfffffff0,%esp
  f5:	ff 71 fc             	pushl  -0x4(%ecx)
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	53                   	push   %ebx
  fc:	51                   	push   %ecx
  fd:	83 ec 10             	sub    $0x10,%esp
 100:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
 102:	83 3b 01             	cmpl   $0x1,(%ebx)
 105:	7f 17                	jg     11e <main+0x30>
    wc(0, "");
 107:	83 ec 08             	sub    $0x8,%esp
 10a:	68 d5 09 00 00       	push   $0x9d5
 10f:	6a 00                	push   $0x0
 111:	e8 ea fe ff ff       	call   0 <wc>
 116:	83 c4 10             	add    $0x10,%esp
    exit();
 119:	e8 47 03 00 00       	call   465 <exit>
  }

  for(i = 1; i < argc; i++){
 11e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 125:	e9 83 00 00 00       	jmp    1ad <main+0xbf>
    if((fd = open(argv[i], 0)) < 0){
 12a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 12d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 134:	8b 43 04             	mov    0x4(%ebx),%eax
 137:	01 d0                	add    %edx,%eax
 139:	8b 00                	mov    (%eax),%eax
 13b:	83 ec 08             	sub    $0x8,%esp
 13e:	6a 00                	push   $0x0
 140:	50                   	push   %eax
 141:	e8 5f 03 00 00       	call   4a5 <open>
 146:	83 c4 10             	add    $0x10,%esp
 149:	89 45 f0             	mov    %eax,-0x10(%ebp)
 14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 150:	79 29                	jns    17b <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
 152:	8b 45 f4             	mov    -0xc(%ebp),%eax
 155:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15c:	8b 43 04             	mov    0x4(%ebx),%eax
 15f:	01 d0                	add    %edx,%eax
 161:	8b 00                	mov    (%eax),%eax
 163:	83 ec 04             	sub    $0x4,%esp
 166:	50                   	push   %eax
 167:	68 d6 09 00 00       	push   $0x9d6
 16c:	6a 01                	push   $0x1
 16e:	e8 89 04 00 00       	call   5fc <printf>
 173:	83 c4 10             	add    $0x10,%esp
      exit();
 176:	e8 ea 02 00 00       	call   465 <exit>
    }
    wc(fd, argv[i]);
 17b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 185:	8b 43 04             	mov    0x4(%ebx),%eax
 188:	01 d0                	add    %edx,%eax
 18a:	8b 00                	mov    (%eax),%eax
 18c:	83 ec 08             	sub    $0x8,%esp
 18f:	50                   	push   %eax
 190:	ff 75 f0             	pushl  -0x10(%ebp)
 193:	e8 68 fe ff ff       	call   0 <wc>
 198:	83 c4 10             	add    $0x10,%esp
    close(fd);
 19b:	83 ec 0c             	sub    $0xc,%esp
 19e:	ff 75 f0             	pushl  -0x10(%ebp)
 1a1:	e8 e7 02 00 00       	call   48d <close>
 1a6:	83 c4 10             	add    $0x10,%esp
  if(argc <= 1){
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
 1a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b0:	3b 03                	cmp    (%ebx),%eax
 1b2:	0f 8c 72 ff ff ff    	jl     12a <main+0x3c>
      exit();
    }
    wc(fd, argv[i]);
    close(fd);
  }
  exit();
 1b8:	e8 a8 02 00 00       	call   465 <exit>

000001bd <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	57                   	push   %edi
 1c1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c5:	8b 55 10             	mov    0x10(%ebp),%edx
 1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cb:	89 cb                	mov    %ecx,%ebx
 1cd:	89 df                	mov    %ebx,%edi
 1cf:	89 d1                	mov    %edx,%ecx
 1d1:	fc                   	cld    
 1d2:	f3 aa                	rep stos %al,%es:(%edi)
 1d4:	89 ca                	mov    %ecx,%edx
 1d6:	89 fb                	mov    %edi,%ebx
 1d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1db:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1de:	90                   	nop
 1df:	5b                   	pop    %ebx
 1e0:	5f                   	pop    %edi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    

000001e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1ef:	90                   	nop
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	8d 50 01             	lea    0x1(%eax),%edx
 1f6:	89 55 08             	mov    %edx,0x8(%ebp)
 1f9:	8b 55 0c             	mov    0xc(%ebp),%edx
 1fc:	8d 4a 01             	lea    0x1(%edx),%ecx
 1ff:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 202:	0f b6 12             	movzbl (%edx),%edx
 205:	88 10                	mov    %dl,(%eax)
 207:	0f b6 00             	movzbl (%eax),%eax
 20a:	84 c0                	test   %al,%al
 20c:	75 e2                	jne    1f0 <strcpy+0xd>
    ;
  return os;
 20e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 211:	c9                   	leave  
 212:	c3                   	ret    

00000213 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 213:	55                   	push   %ebp
 214:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 216:	eb 08                	jmp    220 <strcmp+0xd>
    p++, q++;
 218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 220:	8b 45 08             	mov    0x8(%ebp),%eax
 223:	0f b6 00             	movzbl (%eax),%eax
 226:	84 c0                	test   %al,%al
 228:	74 10                	je     23a <strcmp+0x27>
 22a:	8b 45 08             	mov    0x8(%ebp),%eax
 22d:	0f b6 10             	movzbl (%eax),%edx
 230:	8b 45 0c             	mov    0xc(%ebp),%eax
 233:	0f b6 00             	movzbl (%eax),%eax
 236:	38 c2                	cmp    %al,%dl
 238:	74 de                	je     218 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
 23d:	0f b6 00             	movzbl (%eax),%eax
 240:	0f b6 d0             	movzbl %al,%edx
 243:	8b 45 0c             	mov    0xc(%ebp),%eax
 246:	0f b6 00             	movzbl (%eax),%eax
 249:	0f b6 c0             	movzbl %al,%eax
 24c:	29 c2                	sub    %eax,%edx
 24e:	89 d0                	mov    %edx,%eax
}
 250:	5d                   	pop    %ebp
 251:	c3                   	ret    

00000252 <strlen>:

uint
strlen(char *s)
{
 252:	55                   	push   %ebp
 253:	89 e5                	mov    %esp,%ebp
 255:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 25f:	eb 04                	jmp    265 <strlen+0x13>
 261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 265:	8b 55 fc             	mov    -0x4(%ebp),%edx
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	01 d0                	add    %edx,%eax
 26d:	0f b6 00             	movzbl (%eax),%eax
 270:	84 c0                	test   %al,%al
 272:	75 ed                	jne    261 <strlen+0xf>
    ;
  return n;
 274:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 277:	c9                   	leave  
 278:	c3                   	ret    

00000279 <memset>:

void*
memset(void *dst, int c, uint n)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 27c:	8b 45 10             	mov    0x10(%ebp),%eax
 27f:	50                   	push   %eax
 280:	ff 75 0c             	pushl  0xc(%ebp)
 283:	ff 75 08             	pushl  0x8(%ebp)
 286:	e8 32 ff ff ff       	call   1bd <stosb>
 28b:	83 c4 0c             	add    $0xc,%esp
  return dst;
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 291:	c9                   	leave  
 292:	c3                   	ret    

00000293 <strchr>:

char*
strchr(const char *s, char c)
{
 293:	55                   	push   %ebp
 294:	89 e5                	mov    %esp,%ebp
 296:	83 ec 04             	sub    $0x4,%esp
 299:	8b 45 0c             	mov    0xc(%ebp),%eax
 29c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 29f:	eb 14                	jmp    2b5 <strchr+0x22>
    if(*s == c)
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	0f b6 00             	movzbl (%eax),%eax
 2a7:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2aa:	75 05                	jne    2b1 <strchr+0x1e>
      return (char*)s;
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
 2af:	eb 13                	jmp    2c4 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	84 c0                	test   %al,%al
 2bd:	75 e2                	jne    2a1 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <gets>:

char*
gets(char *buf, int max)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d3:	eb 42                	jmp    317 <gets+0x51>
    cc = read(0, &c, 1);
 2d5:	83 ec 04             	sub    $0x4,%esp
 2d8:	6a 01                	push   $0x1
 2da:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2dd:	50                   	push   %eax
 2de:	6a 00                	push   $0x0
 2e0:	e8 98 01 00 00       	call   47d <read>
 2e5:	83 c4 10             	add    $0x10,%esp
 2e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2ef:	7e 33                	jle    324 <gets+0x5e>
      break;
    buf[i++] = c;
 2f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f4:	8d 50 01             	lea    0x1(%eax),%edx
 2f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2fa:	89 c2                	mov    %eax,%edx
 2fc:	8b 45 08             	mov    0x8(%ebp),%eax
 2ff:	01 c2                	add    %eax,%edx
 301:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 305:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 307:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30b:	3c 0a                	cmp    $0xa,%al
 30d:	74 16                	je     325 <gets+0x5f>
 30f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 313:	3c 0d                	cmp    $0xd,%al
 315:	74 0e                	je     325 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 317:	8b 45 f4             	mov    -0xc(%ebp),%eax
 31a:	83 c0 01             	add    $0x1,%eax
 31d:	3b 45 0c             	cmp    0xc(%ebp),%eax
 320:	7c b3                	jl     2d5 <gets+0xf>
 322:	eb 01                	jmp    325 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 324:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 325:	8b 55 f4             	mov    -0xc(%ebp),%edx
 328:	8b 45 08             	mov    0x8(%ebp),%eax
 32b:	01 d0                	add    %edx,%eax
 32d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 330:	8b 45 08             	mov    0x8(%ebp),%eax
}
 333:	c9                   	leave  
 334:	c3                   	ret    

00000335 <stat>:

int
stat(char *n, struct stat *st)
{
 335:	55                   	push   %ebp
 336:	89 e5                	mov    %esp,%ebp
 338:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33b:	83 ec 08             	sub    $0x8,%esp
 33e:	6a 00                	push   $0x0
 340:	ff 75 08             	pushl  0x8(%ebp)
 343:	e8 5d 01 00 00       	call   4a5 <open>
 348:	83 c4 10             	add    $0x10,%esp
 34b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 34e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 352:	79 07                	jns    35b <stat+0x26>
    return -1;
 354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 359:	eb 25                	jmp    380 <stat+0x4b>
  r = fstat(fd, st);
 35b:	83 ec 08             	sub    $0x8,%esp
 35e:	ff 75 0c             	pushl  0xc(%ebp)
 361:	ff 75 f4             	pushl  -0xc(%ebp)
 364:	e8 54 01 00 00       	call   4bd <fstat>
 369:	83 c4 10             	add    $0x10,%esp
 36c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 36f:	83 ec 0c             	sub    $0xc,%esp
 372:	ff 75 f4             	pushl  -0xc(%ebp)
 375:	e8 13 01 00 00       	call   48d <close>
 37a:	83 c4 10             	add    $0x10,%esp
  return r;
 37d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 380:	c9                   	leave  
 381:	c3                   	ret    

00000382 <atoi>:

int
atoi(const char *s)
{
 382:	55                   	push   %ebp
 383:	89 e5                	mov    %esp,%ebp
 385:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 38f:	eb 25                	jmp    3b6 <atoi+0x34>
    n = n*10 + *s++ - '0';
 391:	8b 55 fc             	mov    -0x4(%ebp),%edx
 394:	89 d0                	mov    %edx,%eax
 396:	c1 e0 02             	shl    $0x2,%eax
 399:	01 d0                	add    %edx,%eax
 39b:	01 c0                	add    %eax,%eax
 39d:	89 c1                	mov    %eax,%ecx
 39f:	8b 45 08             	mov    0x8(%ebp),%eax
 3a2:	8d 50 01             	lea    0x1(%eax),%edx
 3a5:	89 55 08             	mov    %edx,0x8(%ebp)
 3a8:	0f b6 00             	movzbl (%eax),%eax
 3ab:	0f be c0             	movsbl %al,%eax
 3ae:	01 c8                	add    %ecx,%eax
 3b0:	83 e8 30             	sub    $0x30,%eax
 3b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b6:	8b 45 08             	mov    0x8(%ebp),%eax
 3b9:	0f b6 00             	movzbl (%eax),%eax
 3bc:	3c 2f                	cmp    $0x2f,%al
 3be:	7e 0a                	jle    3ca <atoi+0x48>
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
 3c3:	0f b6 00             	movzbl (%eax),%eax
 3c6:	3c 39                	cmp    $0x39,%al
 3c8:	7e c7                	jle    391 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3cd:	c9                   	leave  
 3ce:	c3                   	ret    

000003cf <itoa>:

char*
itoa(int val, int base){
 3cf:	55                   	push   %ebp
 3d0:	89 e5                	mov    %esp,%ebp
 3d2:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 3d5:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 3dc:	eb 29                	jmp    407 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 3de:	8b 45 08             	mov    0x8(%ebp),%eax
 3e1:	99                   	cltd   
 3e2:	f7 7d 0c             	idivl  0xc(%ebp)
 3e5:	89 d0                	mov    %edx,%eax
 3e7:	0f b6 80 ea 09 00 00 	movzbl 0x9ea(%eax),%eax
 3ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3f1:	81 c2 c0 0c 00 00    	add    $0xcc0,%edx
 3f7:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 3f9:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 3fd:	8b 45 08             	mov    0x8(%ebp),%eax
 400:	99                   	cltd   
 401:	f7 7d 0c             	idivl  0xc(%ebp)
 404:	89 45 08             	mov    %eax,0x8(%ebp)
 407:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 40b:	74 06                	je     413 <itoa+0x44>
 40d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 411:	75 cb                	jne    3de <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 413:	8b 45 fc             	mov    -0x4(%ebp),%eax
 416:	83 c0 01             	add    $0x1,%eax
 419:	05 c0 0c 00 00       	add    $0xcc0,%eax

}
 41e:	c9                   	leave  
 41f:	c3                   	ret    

00000420 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 426:	8b 45 08             	mov    0x8(%ebp),%eax
 429:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 42c:	8b 45 0c             	mov    0xc(%ebp),%eax
 42f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 432:	eb 17                	jmp    44b <memmove+0x2b>
    *dst++ = *src++;
 434:	8b 45 fc             	mov    -0x4(%ebp),%eax
 437:	8d 50 01             	lea    0x1(%eax),%edx
 43a:	89 55 fc             	mov    %edx,-0x4(%ebp)
 43d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 440:	8d 4a 01             	lea    0x1(%edx),%ecx
 443:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 446:	0f b6 12             	movzbl (%edx),%edx
 449:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 44b:	8b 45 10             	mov    0x10(%ebp),%eax
 44e:	8d 50 ff             	lea    -0x1(%eax),%edx
 451:	89 55 10             	mov    %edx,0x10(%ebp)
 454:	85 c0                	test   %eax,%eax
 456:	7f dc                	jg     434 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 458:	8b 45 08             	mov    0x8(%ebp),%eax
}
 45b:	c9                   	leave  
 45c:	c3                   	ret    

0000045d <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 45d:	b8 01 00 00 00       	mov    $0x1,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <exit>:
SYSCALL(exit)
 465:	b8 02 00 00 00       	mov    $0x2,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <wait>:
SYSCALL(wait)
 46d:	b8 03 00 00 00       	mov    $0x3,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <pipe>:
SYSCALL(pipe)
 475:	b8 04 00 00 00       	mov    $0x4,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <read>:
SYSCALL(read)
 47d:	b8 05 00 00 00       	mov    $0x5,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <write>:
SYSCALL(write)
 485:	b8 10 00 00 00       	mov    $0x10,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <close>:
SYSCALL(close)
 48d:	b8 15 00 00 00       	mov    $0x15,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <kill>:
SYSCALL(kill)
 495:	b8 06 00 00 00       	mov    $0x6,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret    

0000049d <exec>:
SYSCALL(exec)
 49d:	b8 07 00 00 00       	mov    $0x7,%eax
 4a2:	cd 40                	int    $0x40
 4a4:	c3                   	ret    

000004a5 <open>:
SYSCALL(open)
 4a5:	b8 0f 00 00 00       	mov    $0xf,%eax
 4aa:	cd 40                	int    $0x40
 4ac:	c3                   	ret    

000004ad <mknod>:
SYSCALL(mknod)
 4ad:	b8 11 00 00 00       	mov    $0x11,%eax
 4b2:	cd 40                	int    $0x40
 4b4:	c3                   	ret    

000004b5 <unlink>:
SYSCALL(unlink)
 4b5:	b8 12 00 00 00       	mov    $0x12,%eax
 4ba:	cd 40                	int    $0x40
 4bc:	c3                   	ret    

000004bd <fstat>:
SYSCALL(fstat)
 4bd:	b8 08 00 00 00       	mov    $0x8,%eax
 4c2:	cd 40                	int    $0x40
 4c4:	c3                   	ret    

000004c5 <link>:
SYSCALL(link)
 4c5:	b8 13 00 00 00       	mov    $0x13,%eax
 4ca:	cd 40                	int    $0x40
 4cc:	c3                   	ret    

000004cd <mkdir>:
SYSCALL(mkdir)
 4cd:	b8 14 00 00 00       	mov    $0x14,%eax
 4d2:	cd 40                	int    $0x40
 4d4:	c3                   	ret    

000004d5 <chdir>:
SYSCALL(chdir)
 4d5:	b8 09 00 00 00       	mov    $0x9,%eax
 4da:	cd 40                	int    $0x40
 4dc:	c3                   	ret    

000004dd <dup>:
SYSCALL(dup)
 4dd:	b8 0a 00 00 00       	mov    $0xa,%eax
 4e2:	cd 40                	int    $0x40
 4e4:	c3                   	ret    

000004e5 <getpid>:
SYSCALL(getpid)
 4e5:	b8 0b 00 00 00       	mov    $0xb,%eax
 4ea:	cd 40                	int    $0x40
 4ec:	c3                   	ret    

000004ed <sbrk>:
SYSCALL(sbrk)
 4ed:	b8 0c 00 00 00       	mov    $0xc,%eax
 4f2:	cd 40                	int    $0x40
 4f4:	c3                   	ret    

000004f5 <sleep>:
SYSCALL(sleep)
 4f5:	b8 0d 00 00 00       	mov    $0xd,%eax
 4fa:	cd 40                	int    $0x40
 4fc:	c3                   	ret    

000004fd <uptime>:
SYSCALL(uptime)
 4fd:	b8 0e 00 00 00       	mov    $0xe,%eax
 502:	cd 40                	int    $0x40
 504:	c3                   	ret    

00000505 <randomX>:
SYSCALL(randomX)
 505:	b8 16 00 00 00       	mov    $0x16,%eax
 50a:	cd 40                	int    $0x40
 50c:	c3                   	ret    

0000050d <setSeedX>:
SYSCALL(setSeedX)
 50d:	b8 17 00 00 00       	mov    $0x17,%eax
 512:	cd 40                	int    $0x40
 514:	c3                   	ret    

00000515 <uniformR>:
SYSCALL(uniformR)
 515:	b8 18 00 00 00       	mov    $0x18,%eax
 51a:	cd 40                	int    $0x40
 51c:	c3                   	ret    

0000051d <setdeadline>:
 51d:	b8 19 00 00 00       	mov    $0x19,%eax
 522:	cd 40                	int    $0x40
 524:	c3                   	ret    

00000525 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 525:	55                   	push   %ebp
 526:	89 e5                	mov    %esp,%ebp
 528:	83 ec 18             	sub    $0x18,%esp
 52b:	8b 45 0c             	mov    0xc(%ebp),%eax
 52e:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 531:	83 ec 04             	sub    $0x4,%esp
 534:	6a 01                	push   $0x1
 536:	8d 45 f4             	lea    -0xc(%ebp),%eax
 539:	50                   	push   %eax
 53a:	ff 75 08             	pushl  0x8(%ebp)
 53d:	e8 43 ff ff ff       	call   485 <write>
 542:	83 c4 10             	add    $0x10,%esp
}
 545:	90                   	nop
 546:	c9                   	leave  
 547:	c3                   	ret    

00000548 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 548:	55                   	push   %ebp
 549:	89 e5                	mov    %esp,%ebp
 54b:	53                   	push   %ebx
 54c:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 54f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 556:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 55a:	74 17                	je     573 <printint+0x2b>
 55c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 560:	79 11                	jns    573 <printint+0x2b>
    neg = 1;
 562:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 569:	8b 45 0c             	mov    0xc(%ebp),%eax
 56c:	f7 d8                	neg    %eax
 56e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 571:	eb 06                	jmp    579 <printint+0x31>
  } else {
    x = xx;
 573:	8b 45 0c             	mov    0xc(%ebp),%eax
 576:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 579:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 580:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 583:	8d 41 01             	lea    0x1(%ecx),%eax
 586:	89 45 f4             	mov    %eax,-0xc(%ebp)
 589:	8b 5d 10             	mov    0x10(%ebp),%ebx
 58c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 58f:	ba 00 00 00 00       	mov    $0x0,%edx
 594:	f7 f3                	div    %ebx
 596:	89 d0                	mov    %edx,%eax
 598:	0f b6 80 90 0c 00 00 	movzbl 0xc90(%eax),%eax
 59f:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 5a3:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5a6:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a9:	ba 00 00 00 00       	mov    $0x0,%edx
 5ae:	f7 f3                	div    %ebx
 5b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b7:	75 c7                	jne    580 <printint+0x38>
  if(neg)
 5b9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5bd:	74 2d                	je     5ec <printint+0xa4>
    buf[i++] = '-';
 5bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c2:	8d 50 01             	lea    0x1(%eax),%edx
 5c5:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c8:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5cd:	eb 1d                	jmp    5ec <printint+0xa4>
    putc(fd, buf[i]);
 5cf:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d5:	01 d0                	add    %edx,%eax
 5d7:	0f b6 00             	movzbl (%eax),%eax
 5da:	0f be c0             	movsbl %al,%eax
 5dd:	83 ec 08             	sub    $0x8,%esp
 5e0:	50                   	push   %eax
 5e1:	ff 75 08             	pushl  0x8(%ebp)
 5e4:	e8 3c ff ff ff       	call   525 <putc>
 5e9:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5ec:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5f4:	79 d9                	jns    5cf <printint+0x87>
    putc(fd, buf[i]);
}
 5f6:	90                   	nop
 5f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5fa:	c9                   	leave  
 5fb:	c3                   	ret    

000005fc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5fc:	55                   	push   %ebp
 5fd:	89 e5                	mov    %esp,%ebp
 5ff:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 602:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 609:	8d 45 0c             	lea    0xc(%ebp),%eax
 60c:	83 c0 04             	add    $0x4,%eax
 60f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 612:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 619:	e9 59 01 00 00       	jmp    777 <printf+0x17b>
    c = fmt[i] & 0xff;
 61e:	8b 55 0c             	mov    0xc(%ebp),%edx
 621:	8b 45 f0             	mov    -0x10(%ebp),%eax
 624:	01 d0                	add    %edx,%eax
 626:	0f b6 00             	movzbl (%eax),%eax
 629:	0f be c0             	movsbl %al,%eax
 62c:	25 ff 00 00 00       	and    $0xff,%eax
 631:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 634:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 638:	75 2c                	jne    666 <printf+0x6a>
      if(c == '%'){
 63a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 63e:	75 0c                	jne    64c <printf+0x50>
        state = '%';
 640:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 647:	e9 27 01 00 00       	jmp    773 <printf+0x177>
      } else {
        putc(fd, c);
 64c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64f:	0f be c0             	movsbl %al,%eax
 652:	83 ec 08             	sub    $0x8,%esp
 655:	50                   	push   %eax
 656:	ff 75 08             	pushl  0x8(%ebp)
 659:	e8 c7 fe ff ff       	call   525 <putc>
 65e:	83 c4 10             	add    $0x10,%esp
 661:	e9 0d 01 00 00       	jmp    773 <printf+0x177>
      }
    } else if(state == '%'){
 666:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 66a:	0f 85 03 01 00 00    	jne    773 <printf+0x177>
      if(c == 'd'){
 670:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 674:	75 1e                	jne    694 <printf+0x98>
        printint(fd, *ap, 10, 1);
 676:	8b 45 e8             	mov    -0x18(%ebp),%eax
 679:	8b 00                	mov    (%eax),%eax
 67b:	6a 01                	push   $0x1
 67d:	6a 0a                	push   $0xa
 67f:	50                   	push   %eax
 680:	ff 75 08             	pushl  0x8(%ebp)
 683:	e8 c0 fe ff ff       	call   548 <printint>
 688:	83 c4 10             	add    $0x10,%esp
        ap++;
 68b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68f:	e9 d8 00 00 00       	jmp    76c <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 694:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 698:	74 06                	je     6a0 <printf+0xa4>
 69a:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 69e:	75 1e                	jne    6be <printf+0xc2>
        printint(fd, *ap, 16, 0);
 6a0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a3:	8b 00                	mov    (%eax),%eax
 6a5:	6a 00                	push   $0x0
 6a7:	6a 10                	push   $0x10
 6a9:	50                   	push   %eax
 6aa:	ff 75 08             	pushl  0x8(%ebp)
 6ad:	e8 96 fe ff ff       	call   548 <printint>
 6b2:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b9:	e9 ae 00 00 00       	jmp    76c <printf+0x170>
      } else if(c == 's'){
 6be:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6c2:	75 43                	jne    707 <printf+0x10b>
        s = (char*)*ap;
 6c4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c7:	8b 00                	mov    (%eax),%eax
 6c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6cc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6d4:	75 25                	jne    6fb <printf+0xff>
          s = "(null)";
 6d6:	c7 45 f4 fb 09 00 00 	movl   $0x9fb,-0xc(%ebp)
        while(*s != 0){
 6dd:	eb 1c                	jmp    6fb <printf+0xff>
          putc(fd, *s);
 6df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e2:	0f b6 00             	movzbl (%eax),%eax
 6e5:	0f be c0             	movsbl %al,%eax
 6e8:	83 ec 08             	sub    $0x8,%esp
 6eb:	50                   	push   %eax
 6ec:	ff 75 08             	pushl  0x8(%ebp)
 6ef:	e8 31 fe ff ff       	call   525 <putc>
 6f4:	83 c4 10             	add    $0x10,%esp
          s++;
 6f7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fe:	0f b6 00             	movzbl (%eax),%eax
 701:	84 c0                	test   %al,%al
 703:	75 da                	jne    6df <printf+0xe3>
 705:	eb 65                	jmp    76c <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 707:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 70b:	75 1d                	jne    72a <printf+0x12e>
        putc(fd, *ap);
 70d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 710:	8b 00                	mov    (%eax),%eax
 712:	0f be c0             	movsbl %al,%eax
 715:	83 ec 08             	sub    $0x8,%esp
 718:	50                   	push   %eax
 719:	ff 75 08             	pushl  0x8(%ebp)
 71c:	e8 04 fe ff ff       	call   525 <putc>
 721:	83 c4 10             	add    $0x10,%esp
        ap++;
 724:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 728:	eb 42                	jmp    76c <printf+0x170>
      } else if(c == '%'){
 72a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 72e:	75 17                	jne    747 <printf+0x14b>
        putc(fd, c);
 730:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 733:	0f be c0             	movsbl %al,%eax
 736:	83 ec 08             	sub    $0x8,%esp
 739:	50                   	push   %eax
 73a:	ff 75 08             	pushl  0x8(%ebp)
 73d:	e8 e3 fd ff ff       	call   525 <putc>
 742:	83 c4 10             	add    $0x10,%esp
 745:	eb 25                	jmp    76c <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 747:	83 ec 08             	sub    $0x8,%esp
 74a:	6a 25                	push   $0x25
 74c:	ff 75 08             	pushl  0x8(%ebp)
 74f:	e8 d1 fd ff ff       	call   525 <putc>
 754:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 757:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 75a:	0f be c0             	movsbl %al,%eax
 75d:	83 ec 08             	sub    $0x8,%esp
 760:	50                   	push   %eax
 761:	ff 75 08             	pushl  0x8(%ebp)
 764:	e8 bc fd ff ff       	call   525 <putc>
 769:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 76c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 773:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 777:	8b 55 0c             	mov    0xc(%ebp),%edx
 77a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77d:	01 d0                	add    %edx,%eax
 77f:	0f b6 00             	movzbl (%eax),%eax
 782:	84 c0                	test   %al,%al
 784:	0f 85 94 fe ff ff    	jne    61e <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 78a:	90                   	nop
 78b:	c9                   	leave  
 78c:	c3                   	ret    

0000078d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 78d:	55                   	push   %ebp
 78e:	89 e5                	mov    %esp,%ebp
 790:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 793:	8b 45 08             	mov    0x8(%ebp),%eax
 796:	83 e8 08             	sub    $0x8,%eax
 799:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79c:	a1 e8 0c 00 00       	mov    0xce8,%eax
 7a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a4:	eb 24                	jmp    7ca <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	8b 00                	mov    (%eax),%eax
 7ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ae:	77 12                	ja     7c2 <free+0x35>
 7b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b6:	77 24                	ja     7dc <free+0x4f>
 7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bb:	8b 00                	mov    (%eax),%eax
 7bd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7c0:	77 1a                	ja     7dc <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d0:	76 d4                	jbe    7a6 <free+0x19>
 7d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d5:	8b 00                	mov    (%eax),%eax
 7d7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7da:	76 ca                	jbe    7a6 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7df:	8b 40 04             	mov    0x4(%eax),%eax
 7e2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ec:	01 c2                	add    %eax,%edx
 7ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f1:	8b 00                	mov    (%eax),%eax
 7f3:	39 c2                	cmp    %eax,%edx
 7f5:	75 24                	jne    81b <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7fa:	8b 50 04             	mov    0x4(%eax),%edx
 7fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 800:	8b 00                	mov    (%eax),%eax
 802:	8b 40 04             	mov    0x4(%eax),%eax
 805:	01 c2                	add    %eax,%edx
 807:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80a:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 80d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 810:	8b 00                	mov    (%eax),%eax
 812:	8b 10                	mov    (%eax),%edx
 814:	8b 45 f8             	mov    -0x8(%ebp),%eax
 817:	89 10                	mov    %edx,(%eax)
 819:	eb 0a                	jmp    825 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 81b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81e:	8b 10                	mov    (%eax),%edx
 820:	8b 45 f8             	mov    -0x8(%ebp),%eax
 823:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 825:	8b 45 fc             	mov    -0x4(%ebp),%eax
 828:	8b 40 04             	mov    0x4(%eax),%eax
 82b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 832:	8b 45 fc             	mov    -0x4(%ebp),%eax
 835:	01 d0                	add    %edx,%eax
 837:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 83a:	75 20                	jne    85c <free+0xcf>
    p->s.size += bp->s.size;
 83c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83f:	8b 50 04             	mov    0x4(%eax),%edx
 842:	8b 45 f8             	mov    -0x8(%ebp),%eax
 845:	8b 40 04             	mov    0x4(%eax),%eax
 848:	01 c2                	add    %eax,%edx
 84a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84d:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 850:	8b 45 f8             	mov    -0x8(%ebp),%eax
 853:	8b 10                	mov    (%eax),%edx
 855:	8b 45 fc             	mov    -0x4(%ebp),%eax
 858:	89 10                	mov    %edx,(%eax)
 85a:	eb 08                	jmp    864 <free+0xd7>
  } else
    p->s.ptr = bp;
 85c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 862:	89 10                	mov    %edx,(%eax)
  freep = p;
 864:	8b 45 fc             	mov    -0x4(%ebp),%eax
 867:	a3 e8 0c 00 00       	mov    %eax,0xce8
}
 86c:	90                   	nop
 86d:	c9                   	leave  
 86e:	c3                   	ret    

0000086f <morecore>:

static Header*
morecore(uint nu)
{
 86f:	55                   	push   %ebp
 870:	89 e5                	mov    %esp,%ebp
 872:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 875:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 87c:	77 07                	ja     885 <morecore+0x16>
    nu = 4096;
 87e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 885:	8b 45 08             	mov    0x8(%ebp),%eax
 888:	c1 e0 03             	shl    $0x3,%eax
 88b:	83 ec 0c             	sub    $0xc,%esp
 88e:	50                   	push   %eax
 88f:	e8 59 fc ff ff       	call   4ed <sbrk>
 894:	83 c4 10             	add    $0x10,%esp
 897:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 89a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 89e:	75 07                	jne    8a7 <morecore+0x38>
    return 0;
 8a0:	b8 00 00 00 00       	mov    $0x0,%eax
 8a5:	eb 26                	jmp    8cd <morecore+0x5e>
  hp = (Header*)p;
 8a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b0:	8b 55 08             	mov    0x8(%ebp),%edx
 8b3:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b9:	83 c0 08             	add    $0x8,%eax
 8bc:	83 ec 0c             	sub    $0xc,%esp
 8bf:	50                   	push   %eax
 8c0:	e8 c8 fe ff ff       	call   78d <free>
 8c5:	83 c4 10             	add    $0x10,%esp
  return freep;
 8c8:	a1 e8 0c 00 00       	mov    0xce8,%eax
}
 8cd:	c9                   	leave  
 8ce:	c3                   	ret    

000008cf <malloc>:

void*
malloc(uint nbytes)
{
 8cf:	55                   	push   %ebp
 8d0:	89 e5                	mov    %esp,%ebp
 8d2:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d5:	8b 45 08             	mov    0x8(%ebp),%eax
 8d8:	83 c0 07             	add    $0x7,%eax
 8db:	c1 e8 03             	shr    $0x3,%eax
 8de:	83 c0 01             	add    $0x1,%eax
 8e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8e4:	a1 e8 0c 00 00       	mov    0xce8,%eax
 8e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8f0:	75 23                	jne    915 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8f2:	c7 45 f0 e0 0c 00 00 	movl   $0xce0,-0x10(%ebp)
 8f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fc:	a3 e8 0c 00 00       	mov    %eax,0xce8
 901:	a1 e8 0c 00 00       	mov    0xce8,%eax
 906:	a3 e0 0c 00 00       	mov    %eax,0xce0
    base.s.size = 0;
 90b:	c7 05 e4 0c 00 00 00 	movl   $0x0,0xce4
 912:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 915:	8b 45 f0             	mov    -0x10(%ebp),%eax
 918:	8b 00                	mov    (%eax),%eax
 91a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 91d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 920:	8b 40 04             	mov    0x4(%eax),%eax
 923:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 926:	72 4d                	jb     975 <malloc+0xa6>
      if(p->s.size == nunits)
 928:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92b:	8b 40 04             	mov    0x4(%eax),%eax
 92e:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 931:	75 0c                	jne    93f <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 933:	8b 45 f4             	mov    -0xc(%ebp),%eax
 936:	8b 10                	mov    (%eax),%edx
 938:	8b 45 f0             	mov    -0x10(%ebp),%eax
 93b:	89 10                	mov    %edx,(%eax)
 93d:	eb 26                	jmp    965 <malloc+0x96>
      else {
        p->s.size -= nunits;
 93f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 942:	8b 40 04             	mov    0x4(%eax),%eax
 945:	2b 45 ec             	sub    -0x14(%ebp),%eax
 948:	89 c2                	mov    %eax,%edx
 94a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94d:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 950:	8b 45 f4             	mov    -0xc(%ebp),%eax
 953:	8b 40 04             	mov    0x4(%eax),%eax
 956:	c1 e0 03             	shl    $0x3,%eax
 959:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 95c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 962:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 965:	8b 45 f0             	mov    -0x10(%ebp),%eax
 968:	a3 e8 0c 00 00       	mov    %eax,0xce8
      return (void*)(p + 1);
 96d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 970:	83 c0 08             	add    $0x8,%eax
 973:	eb 3b                	jmp    9b0 <malloc+0xe1>
    }
    if(p == freep)
 975:	a1 e8 0c 00 00       	mov    0xce8,%eax
 97a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 97d:	75 1e                	jne    99d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 97f:	83 ec 0c             	sub    $0xc,%esp
 982:	ff 75 ec             	pushl  -0x14(%ebp)
 985:	e8 e5 fe ff ff       	call   86f <morecore>
 98a:	83 c4 10             	add    $0x10,%esp
 98d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 990:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 994:	75 07                	jne    99d <malloc+0xce>
        return 0;
 996:	b8 00 00 00 00       	mov    $0x0,%eax
 99b:	eb 13                	jmp    9b0 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a6:	8b 00                	mov    (%eax),%eax
 9a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9ab:	e9 6d ff ff ff       	jmp    91d <malloc+0x4e>
}
 9b0:	c9                   	leave  
 9b1:	c3                   	ret    
