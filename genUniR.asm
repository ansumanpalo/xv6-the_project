
_genUniR:     file format elf32-i386


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
    int a = atoi(argv[1]), b = atoi(argv[2]);
  14:	8b 43 04             	mov    0x4(%ebx),%eax
  17:	83 c0 04             	add    $0x4,%eax
  1a:	8b 00                	mov    (%eax),%eax
  1c:	83 ec 0c             	sub    $0xc,%esp
  1f:	50                   	push   %eax
  20:	e8 26 02 00 00       	call   24b <atoi>
  25:	83 c4 10             	add    $0x10,%esp
  28:	89 45 f0             	mov    %eax,-0x10(%ebp)
  2b:	8b 43 04             	mov    0x4(%ebx),%eax
  2e:	83 c0 08             	add    $0x8,%eax
  31:	8b 00                	mov    (%eax),%eax
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	50                   	push   %eax
  37:	e8 0f 02 00 00       	call   24b <atoi>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    int i;
    for(i=0; i< b-a+1; i++)
  42:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  49:	eb 28                	jmp    73 <main+0x73>
        printf(1,"%d \n",uniformR(a,b));
  4b:	83 ec 08             	sub    $0x8,%esp
  4e:	ff 75 ec             	pushl  -0x14(%ebp)
  51:	ff 75 f0             	pushl  -0x10(%ebp)
  54:	e8 85 03 00 00       	call   3de <uniformR>
  59:	83 c4 10             	add    $0x10,%esp
  5c:	83 ec 04             	sub    $0x4,%esp
  5f:	50                   	push   %eax
  60:	68 7b 08 00 00       	push   $0x87b
  65:	6a 01                	push   $0x1
  67:	e8 59 04 00 00       	call   4c5 <printf>
  6c:	83 c4 10             	add    $0x10,%esp
int
main(int argc, char *argv[])
{
    int a = atoi(argv[1]), b = atoi(argv[2]);
    int i;
    for(i=0; i< b-a+1; i++)
  6f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  73:	8b 45 ec             	mov    -0x14(%ebp),%eax
  76:	2b 45 f0             	sub    -0x10(%ebp),%eax
  79:	83 c0 01             	add    $0x1,%eax
  7c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  7f:	7f ca                	jg     4b <main+0x4b>
        printf(1,"%d \n",uniformR(a,b));

    exit();
  81:	e8 a8 02 00 00       	call   32e <exit>

00000086 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  86:	55                   	push   %ebp
  87:	89 e5                	mov    %esp,%ebp
  89:	57                   	push   %edi
  8a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  8b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8e:	8b 55 10             	mov    0x10(%ebp),%edx
  91:	8b 45 0c             	mov    0xc(%ebp),%eax
  94:	89 cb                	mov    %ecx,%ebx
  96:	89 df                	mov    %ebx,%edi
  98:	89 d1                	mov    %edx,%ecx
  9a:	fc                   	cld    
  9b:	f3 aa                	rep stos %al,%es:(%edi)
  9d:	89 ca                	mov    %ecx,%edx
  9f:	89 fb                	mov    %edi,%ebx
  a1:	89 5d 08             	mov    %ebx,0x8(%ebp)
  a4:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  a7:	90                   	nop
  a8:	5b                   	pop    %ebx
  a9:	5f                   	pop    %edi
  aa:	5d                   	pop    %ebp
  ab:	c3                   	ret    

000000ac <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  ac:	55                   	push   %ebp
  ad:	89 e5                	mov    %esp,%ebp
  af:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  b2:	8b 45 08             	mov    0x8(%ebp),%eax
  b5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  b8:	90                   	nop
  b9:	8b 45 08             	mov    0x8(%ebp),%eax
  bc:	8d 50 01             	lea    0x1(%eax),%edx
  bf:	89 55 08             	mov    %edx,0x8(%ebp)
  c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  c5:	8d 4a 01             	lea    0x1(%edx),%ecx
  c8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  cb:	0f b6 12             	movzbl (%edx),%edx
  ce:	88 10                	mov    %dl,(%eax)
  d0:	0f b6 00             	movzbl (%eax),%eax
  d3:	84 c0                	test   %al,%al
  d5:	75 e2                	jne    b9 <strcpy+0xd>
    ;
  return os;
  d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  da:	c9                   	leave  
  db:	c3                   	ret    

000000dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  dc:	55                   	push   %ebp
  dd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  df:	eb 08                	jmp    e9 <strcmp+0xd>
    p++, q++;
  e1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  e9:	8b 45 08             	mov    0x8(%ebp),%eax
  ec:	0f b6 00             	movzbl (%eax),%eax
  ef:	84 c0                	test   %al,%al
  f1:	74 10                	je     103 <strcmp+0x27>
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 10             	movzbl (%eax),%edx
  f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  fc:	0f b6 00             	movzbl (%eax),%eax
  ff:	38 c2                	cmp    %al,%dl
 101:	74 de                	je     e1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	0f b6 00             	movzbl (%eax),%eax
 109:	0f b6 d0             	movzbl %al,%edx
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	0f b6 00             	movzbl (%eax),%eax
 112:	0f b6 c0             	movzbl %al,%eax
 115:	29 c2                	sub    %eax,%edx
 117:	89 d0                	mov    %edx,%eax
}
 119:	5d                   	pop    %ebp
 11a:	c3                   	ret    

0000011b <strlen>:

uint
strlen(char *s)
{
 11b:	55                   	push   %ebp
 11c:	89 e5                	mov    %esp,%ebp
 11e:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 121:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 128:	eb 04                	jmp    12e <strlen+0x13>
 12a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 12e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 131:	8b 45 08             	mov    0x8(%ebp),%eax
 134:	01 d0                	add    %edx,%eax
 136:	0f b6 00             	movzbl (%eax),%eax
 139:	84 c0                	test   %al,%al
 13b:	75 ed                	jne    12a <strlen+0xf>
    ;
  return n;
 13d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 140:	c9                   	leave  
 141:	c3                   	ret    

00000142 <memset>:

void*
memset(void *dst, int c, uint n)
{
 142:	55                   	push   %ebp
 143:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 145:	8b 45 10             	mov    0x10(%ebp),%eax
 148:	50                   	push   %eax
 149:	ff 75 0c             	pushl  0xc(%ebp)
 14c:	ff 75 08             	pushl  0x8(%ebp)
 14f:	e8 32 ff ff ff       	call   86 <stosb>
 154:	83 c4 0c             	add    $0xc,%esp
  return dst;
 157:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15a:	c9                   	leave  
 15b:	c3                   	ret    

0000015c <strchr>:

char*
strchr(const char *s, char c)
{
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	83 ec 04             	sub    $0x4,%esp
 162:	8b 45 0c             	mov    0xc(%ebp),%eax
 165:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 168:	eb 14                	jmp    17e <strchr+0x22>
    if(*s == c)
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
 16d:	0f b6 00             	movzbl (%eax),%eax
 170:	3a 45 fc             	cmp    -0x4(%ebp),%al
 173:	75 05                	jne    17a <strchr+0x1e>
      return (char*)s;
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	eb 13                	jmp    18d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 17a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	84 c0                	test   %al,%al
 186:	75 e2                	jne    16a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 188:	b8 00 00 00 00       	mov    $0x0,%eax
}
 18d:	c9                   	leave  
 18e:	c3                   	ret    

0000018f <gets>:

char*
gets(char *buf, int max)
{
 18f:	55                   	push   %ebp
 190:	89 e5                	mov    %esp,%ebp
 192:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 195:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 19c:	eb 42                	jmp    1e0 <gets+0x51>
    cc = read(0, &c, 1);
 19e:	83 ec 04             	sub    $0x4,%esp
 1a1:	6a 01                	push   $0x1
 1a3:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a6:	50                   	push   %eax
 1a7:	6a 00                	push   $0x0
 1a9:	e8 98 01 00 00       	call   346 <read>
 1ae:	83 c4 10             	add    $0x10,%esp
 1b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1b4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1b8:	7e 33                	jle    1ed <gets+0x5e>
      break;
    buf[i++] = c;
 1ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1bd:	8d 50 01             	lea    0x1(%eax),%edx
 1c0:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1c3:	89 c2                	mov    %eax,%edx
 1c5:	8b 45 08             	mov    0x8(%ebp),%eax
 1c8:	01 c2                	add    %eax,%edx
 1ca:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ce:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d4:	3c 0a                	cmp    $0xa,%al
 1d6:	74 16                	je     1ee <gets+0x5f>
 1d8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1dc:	3c 0d                	cmp    $0xd,%al
 1de:	74 0e                	je     1ee <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e3:	83 c0 01             	add    $0x1,%eax
 1e6:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1e9:	7c b3                	jl     19e <gets+0xf>
 1eb:	eb 01                	jmp    1ee <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 1ed:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1ee:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f1:	8b 45 08             	mov    0x8(%ebp),%eax
 1f4:	01 d0                	add    %edx,%eax
 1f6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1fc:	c9                   	leave  
 1fd:	c3                   	ret    

000001fe <stat>:

int
stat(char *n, struct stat *st)
{
 1fe:	55                   	push   %ebp
 1ff:	89 e5                	mov    %esp,%ebp
 201:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 204:	83 ec 08             	sub    $0x8,%esp
 207:	6a 00                	push   $0x0
 209:	ff 75 08             	pushl  0x8(%ebp)
 20c:	e8 5d 01 00 00       	call   36e <open>
 211:	83 c4 10             	add    $0x10,%esp
 214:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 217:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 21b:	79 07                	jns    224 <stat+0x26>
    return -1;
 21d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 222:	eb 25                	jmp    249 <stat+0x4b>
  r = fstat(fd, st);
 224:	83 ec 08             	sub    $0x8,%esp
 227:	ff 75 0c             	pushl  0xc(%ebp)
 22a:	ff 75 f4             	pushl  -0xc(%ebp)
 22d:	e8 54 01 00 00       	call   386 <fstat>
 232:	83 c4 10             	add    $0x10,%esp
 235:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 238:	83 ec 0c             	sub    $0xc,%esp
 23b:	ff 75 f4             	pushl  -0xc(%ebp)
 23e:	e8 13 01 00 00       	call   356 <close>
 243:	83 c4 10             	add    $0x10,%esp
  return r;
 246:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 249:	c9                   	leave  
 24a:	c3                   	ret    

0000024b <atoi>:

int
atoi(const char *s)
{
 24b:	55                   	push   %ebp
 24c:	89 e5                	mov    %esp,%ebp
 24e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 251:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 258:	eb 25                	jmp    27f <atoi+0x34>
    n = n*10 + *s++ - '0';
 25a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 25d:	89 d0                	mov    %edx,%eax
 25f:	c1 e0 02             	shl    $0x2,%eax
 262:	01 d0                	add    %edx,%eax
 264:	01 c0                	add    %eax,%eax
 266:	89 c1                	mov    %eax,%ecx
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	8d 50 01             	lea    0x1(%eax),%edx
 26e:	89 55 08             	mov    %edx,0x8(%ebp)
 271:	0f b6 00             	movzbl (%eax),%eax
 274:	0f be c0             	movsbl %al,%eax
 277:	01 c8                	add    %ecx,%eax
 279:	83 e8 30             	sub    $0x30,%eax
 27c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27f:	8b 45 08             	mov    0x8(%ebp),%eax
 282:	0f b6 00             	movzbl (%eax),%eax
 285:	3c 2f                	cmp    $0x2f,%al
 287:	7e 0a                	jle    293 <atoi+0x48>
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	3c 39                	cmp    $0x39,%al
 291:	7e c7                	jle    25a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 293:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <itoa>:

char*
itoa(int val, int base){
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 29e:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 2a5:	eb 29                	jmp    2d0 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	99                   	cltd   
 2ab:	f7 7d 0c             	idivl  0xc(%ebp)
 2ae:	89 d0                	mov    %edx,%eax
 2b0:	0f b6 80 80 08 00 00 	movzbl 0x880(%eax),%eax
 2b7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2ba:	81 c2 20 0b 00 00    	add    $0xb20,%edx
 2c0:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 2c2:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 2c6:	8b 45 08             	mov    0x8(%ebp),%eax
 2c9:	99                   	cltd   
 2ca:	f7 7d 0c             	idivl  0xc(%ebp)
 2cd:	89 45 08             	mov    %eax,0x8(%ebp)
 2d0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2d4:	74 06                	je     2dc <itoa+0x44>
 2d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 2da:	75 cb                	jne    2a7 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 2dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2df:	83 c0 01             	add    $0x1,%eax
 2e2:	05 20 0b 00 00       	add    $0xb20,%eax

}
 2e7:	c9                   	leave  
 2e8:	c3                   	ret    

000002e9 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2e9:	55                   	push   %ebp
 2ea:	89 e5                	mov    %esp,%ebp
 2ec:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 2ef:	8b 45 08             	mov    0x8(%ebp),%eax
 2f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2f5:	8b 45 0c             	mov    0xc(%ebp),%eax
 2f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2fb:	eb 17                	jmp    314 <memmove+0x2b>
    *dst++ = *src++;
 2fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 300:	8d 50 01             	lea    0x1(%eax),%edx
 303:	89 55 fc             	mov    %edx,-0x4(%ebp)
 306:	8b 55 f8             	mov    -0x8(%ebp),%edx
 309:	8d 4a 01             	lea    0x1(%edx),%ecx
 30c:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 30f:	0f b6 12             	movzbl (%edx),%edx
 312:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 314:	8b 45 10             	mov    0x10(%ebp),%eax
 317:	8d 50 ff             	lea    -0x1(%eax),%edx
 31a:	89 55 10             	mov    %edx,0x10(%ebp)
 31d:	85 c0                	test   %eax,%eax
 31f:	7f dc                	jg     2fd <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 321:	8b 45 08             	mov    0x8(%ebp),%eax
}
 324:	c9                   	leave  
 325:	c3                   	ret    

00000326 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 326:	b8 01 00 00 00       	mov    $0x1,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <exit>:
SYSCALL(exit)
 32e:	b8 02 00 00 00       	mov    $0x2,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <wait>:
SYSCALL(wait)
 336:	b8 03 00 00 00       	mov    $0x3,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <pipe>:
SYSCALL(pipe)
 33e:	b8 04 00 00 00       	mov    $0x4,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <read>:
SYSCALL(read)
 346:	b8 05 00 00 00       	mov    $0x5,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <write>:
SYSCALL(write)
 34e:	b8 10 00 00 00       	mov    $0x10,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <close>:
SYSCALL(close)
 356:	b8 15 00 00 00       	mov    $0x15,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <kill>:
SYSCALL(kill)
 35e:	b8 06 00 00 00       	mov    $0x6,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <exec>:
SYSCALL(exec)
 366:	b8 07 00 00 00       	mov    $0x7,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <open>:
SYSCALL(open)
 36e:	b8 0f 00 00 00       	mov    $0xf,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <mknod>:
SYSCALL(mknod)
 376:	b8 11 00 00 00       	mov    $0x11,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <unlink>:
SYSCALL(unlink)
 37e:	b8 12 00 00 00       	mov    $0x12,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <fstat>:
SYSCALL(fstat)
 386:	b8 08 00 00 00       	mov    $0x8,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <link>:
SYSCALL(link)
 38e:	b8 13 00 00 00       	mov    $0x13,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <mkdir>:
SYSCALL(mkdir)
 396:	b8 14 00 00 00       	mov    $0x14,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <chdir>:
SYSCALL(chdir)
 39e:	b8 09 00 00 00       	mov    $0x9,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <dup>:
SYSCALL(dup)
 3a6:	b8 0a 00 00 00       	mov    $0xa,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <getpid>:
SYSCALL(getpid)
 3ae:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <sbrk>:
SYSCALL(sbrk)
 3b6:	b8 0c 00 00 00       	mov    $0xc,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <sleep>:
SYSCALL(sleep)
 3be:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <uptime>:
SYSCALL(uptime)
 3c6:	b8 0e 00 00 00       	mov    $0xe,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <randomX>:
SYSCALL(randomX)
 3ce:	b8 16 00 00 00       	mov    $0x16,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <setSeedX>:
SYSCALL(setSeedX)
 3d6:	b8 17 00 00 00       	mov    $0x17,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <uniformR>:
SYSCALL(uniformR)
 3de:	b8 18 00 00 00       	mov    $0x18,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    

000003e6 <setdeadline>:
 3e6:	b8 19 00 00 00       	mov    $0x19,%eax
 3eb:	cd 40                	int    $0x40
 3ed:	c3                   	ret    

000003ee <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ee:	55                   	push   %ebp
 3ef:	89 e5                	mov    %esp,%ebp
 3f1:	83 ec 18             	sub    $0x18,%esp
 3f4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f7:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3fa:	83 ec 04             	sub    $0x4,%esp
 3fd:	6a 01                	push   $0x1
 3ff:	8d 45 f4             	lea    -0xc(%ebp),%eax
 402:	50                   	push   %eax
 403:	ff 75 08             	pushl  0x8(%ebp)
 406:	e8 43 ff ff ff       	call   34e <write>
 40b:	83 c4 10             	add    $0x10,%esp
}
 40e:	90                   	nop
 40f:	c9                   	leave  
 410:	c3                   	ret    

00000411 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 411:	55                   	push   %ebp
 412:	89 e5                	mov    %esp,%ebp
 414:	53                   	push   %ebx
 415:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 418:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 41f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 423:	74 17                	je     43c <printint+0x2b>
 425:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 429:	79 11                	jns    43c <printint+0x2b>
    neg = 1;
 42b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 432:	8b 45 0c             	mov    0xc(%ebp),%eax
 435:	f7 d8                	neg    %eax
 437:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43a:	eb 06                	jmp    442 <printint+0x31>
  } else {
    x = xx;
 43c:	8b 45 0c             	mov    0xc(%ebp),%eax
 43f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 442:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 449:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 44c:	8d 41 01             	lea    0x1(%ecx),%eax
 44f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 452:	8b 5d 10             	mov    0x10(%ebp),%ebx
 455:	8b 45 ec             	mov    -0x14(%ebp),%eax
 458:	ba 00 00 00 00       	mov    $0x0,%edx
 45d:	f7 f3                	div    %ebx
 45f:	89 d0                	mov    %edx,%eax
 461:	0f b6 80 04 0b 00 00 	movzbl 0xb04(%eax),%eax
 468:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 46c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 46f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 472:	ba 00 00 00 00       	mov    $0x0,%edx
 477:	f7 f3                	div    %ebx
 479:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 480:	75 c7                	jne    449 <printint+0x38>
  if(neg)
 482:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 486:	74 2d                	je     4b5 <printint+0xa4>
    buf[i++] = '-';
 488:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48b:	8d 50 01             	lea    0x1(%eax),%edx
 48e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 491:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 496:	eb 1d                	jmp    4b5 <printint+0xa4>
    putc(fd, buf[i]);
 498:	8d 55 dc             	lea    -0x24(%ebp),%edx
 49b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49e:	01 d0                	add    %edx,%eax
 4a0:	0f b6 00             	movzbl (%eax),%eax
 4a3:	0f be c0             	movsbl %al,%eax
 4a6:	83 ec 08             	sub    $0x8,%esp
 4a9:	50                   	push   %eax
 4aa:	ff 75 08             	pushl  0x8(%ebp)
 4ad:	e8 3c ff ff ff       	call   3ee <putc>
 4b2:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4b5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4bd:	79 d9                	jns    498 <printint+0x87>
    putc(fd, buf[i]);
}
 4bf:	90                   	nop
 4c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4c3:	c9                   	leave  
 4c4:	c3                   	ret    

000004c5 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4c5:	55                   	push   %ebp
 4c6:	89 e5                	mov    %esp,%ebp
 4c8:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4cb:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4d2:	8d 45 0c             	lea    0xc(%ebp),%eax
 4d5:	83 c0 04             	add    $0x4,%eax
 4d8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4db:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e2:	e9 59 01 00 00       	jmp    640 <printf+0x17b>
    c = fmt[i] & 0xff;
 4e7:	8b 55 0c             	mov    0xc(%ebp),%edx
 4ea:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ed:	01 d0                	add    %edx,%eax
 4ef:	0f b6 00             	movzbl (%eax),%eax
 4f2:	0f be c0             	movsbl %al,%eax
 4f5:	25 ff 00 00 00       	and    $0xff,%eax
 4fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4fd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 501:	75 2c                	jne    52f <printf+0x6a>
      if(c == '%'){
 503:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 507:	75 0c                	jne    515 <printf+0x50>
        state = '%';
 509:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 510:	e9 27 01 00 00       	jmp    63c <printf+0x177>
      } else {
        putc(fd, c);
 515:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 518:	0f be c0             	movsbl %al,%eax
 51b:	83 ec 08             	sub    $0x8,%esp
 51e:	50                   	push   %eax
 51f:	ff 75 08             	pushl  0x8(%ebp)
 522:	e8 c7 fe ff ff       	call   3ee <putc>
 527:	83 c4 10             	add    $0x10,%esp
 52a:	e9 0d 01 00 00       	jmp    63c <printf+0x177>
      }
    } else if(state == '%'){
 52f:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 533:	0f 85 03 01 00 00    	jne    63c <printf+0x177>
      if(c == 'd'){
 539:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 53d:	75 1e                	jne    55d <printf+0x98>
        printint(fd, *ap, 10, 1);
 53f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 542:	8b 00                	mov    (%eax),%eax
 544:	6a 01                	push   $0x1
 546:	6a 0a                	push   $0xa
 548:	50                   	push   %eax
 549:	ff 75 08             	pushl  0x8(%ebp)
 54c:	e8 c0 fe ff ff       	call   411 <printint>
 551:	83 c4 10             	add    $0x10,%esp
        ap++;
 554:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 558:	e9 d8 00 00 00       	jmp    635 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 55d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 561:	74 06                	je     569 <printf+0xa4>
 563:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 567:	75 1e                	jne    587 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 569:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56c:	8b 00                	mov    (%eax),%eax
 56e:	6a 00                	push   $0x0
 570:	6a 10                	push   $0x10
 572:	50                   	push   %eax
 573:	ff 75 08             	pushl  0x8(%ebp)
 576:	e8 96 fe ff ff       	call   411 <printint>
 57b:	83 c4 10             	add    $0x10,%esp
        ap++;
 57e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 582:	e9 ae 00 00 00       	jmp    635 <printf+0x170>
      } else if(c == 's'){
 587:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 58b:	75 43                	jne    5d0 <printf+0x10b>
        s = (char*)*ap;
 58d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 590:	8b 00                	mov    (%eax),%eax
 592:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 595:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 599:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 59d:	75 25                	jne    5c4 <printf+0xff>
          s = "(null)";
 59f:	c7 45 f4 91 08 00 00 	movl   $0x891,-0xc(%ebp)
        while(*s != 0){
 5a6:	eb 1c                	jmp    5c4 <printf+0xff>
          putc(fd, *s);
 5a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ab:	0f b6 00             	movzbl (%eax),%eax
 5ae:	0f be c0             	movsbl %al,%eax
 5b1:	83 ec 08             	sub    $0x8,%esp
 5b4:	50                   	push   %eax
 5b5:	ff 75 08             	pushl  0x8(%ebp)
 5b8:	e8 31 fe ff ff       	call   3ee <putc>
 5bd:	83 c4 10             	add    $0x10,%esp
          s++;
 5c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c7:	0f b6 00             	movzbl (%eax),%eax
 5ca:	84 c0                	test   %al,%al
 5cc:	75 da                	jne    5a8 <printf+0xe3>
 5ce:	eb 65                	jmp    635 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5d0:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d4:	75 1d                	jne    5f3 <printf+0x12e>
        putc(fd, *ap);
 5d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d9:	8b 00                	mov    (%eax),%eax
 5db:	0f be c0             	movsbl %al,%eax
 5de:	83 ec 08             	sub    $0x8,%esp
 5e1:	50                   	push   %eax
 5e2:	ff 75 08             	pushl  0x8(%ebp)
 5e5:	e8 04 fe ff ff       	call   3ee <putc>
 5ea:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ed:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f1:	eb 42                	jmp    635 <printf+0x170>
      } else if(c == '%'){
 5f3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f7:	75 17                	jne    610 <printf+0x14b>
        putc(fd, c);
 5f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fc:	0f be c0             	movsbl %al,%eax
 5ff:	83 ec 08             	sub    $0x8,%esp
 602:	50                   	push   %eax
 603:	ff 75 08             	pushl  0x8(%ebp)
 606:	e8 e3 fd ff ff       	call   3ee <putc>
 60b:	83 c4 10             	add    $0x10,%esp
 60e:	eb 25                	jmp    635 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 610:	83 ec 08             	sub    $0x8,%esp
 613:	6a 25                	push   $0x25
 615:	ff 75 08             	pushl  0x8(%ebp)
 618:	e8 d1 fd ff ff       	call   3ee <putc>
 61d:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 620:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 623:	0f be c0             	movsbl %al,%eax
 626:	83 ec 08             	sub    $0x8,%esp
 629:	50                   	push   %eax
 62a:	ff 75 08             	pushl  0x8(%ebp)
 62d:	e8 bc fd ff ff       	call   3ee <putc>
 632:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 635:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 63c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 640:	8b 55 0c             	mov    0xc(%ebp),%edx
 643:	8b 45 f0             	mov    -0x10(%ebp),%eax
 646:	01 d0                	add    %edx,%eax
 648:	0f b6 00             	movzbl (%eax),%eax
 64b:	84 c0                	test   %al,%al
 64d:	0f 85 94 fe ff ff    	jne    4e7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 653:	90                   	nop
 654:	c9                   	leave  
 655:	c3                   	ret    

00000656 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 656:	55                   	push   %ebp
 657:	89 e5                	mov    %esp,%ebp
 659:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 65c:	8b 45 08             	mov    0x8(%ebp),%eax
 65f:	83 e8 08             	sub    $0x8,%eax
 662:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 665:	a1 48 0b 00 00       	mov    0xb48,%eax
 66a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66d:	eb 24                	jmp    693 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 677:	77 12                	ja     68b <free+0x35>
 679:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67f:	77 24                	ja     6a5 <free+0x4f>
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 689:	77 1a                	ja     6a5 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 68b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68e:	8b 00                	mov    (%eax),%eax
 690:	89 45 fc             	mov    %eax,-0x4(%ebp)
 693:	8b 45 f8             	mov    -0x8(%ebp),%eax
 696:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 699:	76 d4                	jbe    66f <free+0x19>
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6a3:	76 ca                	jbe    66f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a8:	8b 40 04             	mov    0x4(%eax),%eax
 6ab:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b5:	01 c2                	add    %eax,%edx
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 00                	mov    (%eax),%eax
 6bc:	39 c2                	cmp    %eax,%edx
 6be:	75 24                	jne    6e4 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c3:	8b 50 04             	mov    0x4(%eax),%edx
 6c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c9:	8b 00                	mov    (%eax),%eax
 6cb:	8b 40 04             	mov    0x4(%eax),%eax
 6ce:	01 c2                	add    %eax,%edx
 6d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d3:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d9:	8b 00                	mov    (%eax),%eax
 6db:	8b 10                	mov    (%eax),%edx
 6dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e0:	89 10                	mov    %edx,(%eax)
 6e2:	eb 0a                	jmp    6ee <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 10                	mov    (%eax),%edx
 6e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ec:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f1:	8b 40 04             	mov    0x4(%eax),%eax
 6f4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fe:	01 d0                	add    %edx,%eax
 700:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 703:	75 20                	jne    725 <free+0xcf>
    p->s.size += bp->s.size;
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	8b 50 04             	mov    0x4(%eax),%edx
 70b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70e:	8b 40 04             	mov    0x4(%eax),%eax
 711:	01 c2                	add    %eax,%edx
 713:	8b 45 fc             	mov    -0x4(%ebp),%eax
 716:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 719:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71c:	8b 10                	mov    (%eax),%edx
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	89 10                	mov    %edx,(%eax)
 723:	eb 08                	jmp    72d <free+0xd7>
  } else
    p->s.ptr = bp;
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	8b 55 f8             	mov    -0x8(%ebp),%edx
 72b:	89 10                	mov    %edx,(%eax)
  freep = p;
 72d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 730:	a3 48 0b 00 00       	mov    %eax,0xb48
}
 735:	90                   	nop
 736:	c9                   	leave  
 737:	c3                   	ret    

00000738 <morecore>:

static Header*
morecore(uint nu)
{
 738:	55                   	push   %ebp
 739:	89 e5                	mov    %esp,%ebp
 73b:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 73e:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 745:	77 07                	ja     74e <morecore+0x16>
    nu = 4096;
 747:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 74e:	8b 45 08             	mov    0x8(%ebp),%eax
 751:	c1 e0 03             	shl    $0x3,%eax
 754:	83 ec 0c             	sub    $0xc,%esp
 757:	50                   	push   %eax
 758:	e8 59 fc ff ff       	call   3b6 <sbrk>
 75d:	83 c4 10             	add    $0x10,%esp
 760:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 763:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 767:	75 07                	jne    770 <morecore+0x38>
    return 0;
 769:	b8 00 00 00 00       	mov    $0x0,%eax
 76e:	eb 26                	jmp    796 <morecore+0x5e>
  hp = (Header*)p;
 770:	8b 45 f4             	mov    -0xc(%ebp),%eax
 773:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 776:	8b 45 f0             	mov    -0x10(%ebp),%eax
 779:	8b 55 08             	mov    0x8(%ebp),%edx
 77c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 77f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 782:	83 c0 08             	add    $0x8,%eax
 785:	83 ec 0c             	sub    $0xc,%esp
 788:	50                   	push   %eax
 789:	e8 c8 fe ff ff       	call   656 <free>
 78e:	83 c4 10             	add    $0x10,%esp
  return freep;
 791:	a1 48 0b 00 00       	mov    0xb48,%eax
}
 796:	c9                   	leave  
 797:	c3                   	ret    

00000798 <malloc>:

void*
malloc(uint nbytes)
{
 798:	55                   	push   %ebp
 799:	89 e5                	mov    %esp,%ebp
 79b:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 79e:	8b 45 08             	mov    0x8(%ebp),%eax
 7a1:	83 c0 07             	add    $0x7,%eax
 7a4:	c1 e8 03             	shr    $0x3,%eax
 7a7:	83 c0 01             	add    $0x1,%eax
 7aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7ad:	a1 48 0b 00 00       	mov    0xb48,%eax
 7b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7b9:	75 23                	jne    7de <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7bb:	c7 45 f0 40 0b 00 00 	movl   $0xb40,-0x10(%ebp)
 7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c5:	a3 48 0b 00 00       	mov    %eax,0xb48
 7ca:	a1 48 0b 00 00       	mov    0xb48,%eax
 7cf:	a3 40 0b 00 00       	mov    %eax,0xb40
    base.s.size = 0;
 7d4:	c7 05 44 0b 00 00 00 	movl   $0x0,0xb44
 7db:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7de:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e1:	8b 00                	mov    (%eax),%eax
 7e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e9:	8b 40 04             	mov    0x4(%eax),%eax
 7ec:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7ef:	72 4d                	jb     83e <malloc+0xa6>
      if(p->s.size == nunits)
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	8b 40 04             	mov    0x4(%eax),%eax
 7f7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7fa:	75 0c                	jne    808 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ff:	8b 10                	mov    (%eax),%edx
 801:	8b 45 f0             	mov    -0x10(%ebp),%eax
 804:	89 10                	mov    %edx,(%eax)
 806:	eb 26                	jmp    82e <malloc+0x96>
      else {
        p->s.size -= nunits;
 808:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80b:	8b 40 04             	mov    0x4(%eax),%eax
 80e:	2b 45 ec             	sub    -0x14(%ebp),%eax
 811:	89 c2                	mov    %eax,%edx
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 819:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81c:	8b 40 04             	mov    0x4(%eax),%eax
 81f:	c1 e0 03             	shl    $0x3,%eax
 822:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 825:	8b 45 f4             	mov    -0xc(%ebp),%eax
 828:	8b 55 ec             	mov    -0x14(%ebp),%edx
 82b:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 82e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 831:	a3 48 0b 00 00       	mov    %eax,0xb48
      return (void*)(p + 1);
 836:	8b 45 f4             	mov    -0xc(%ebp),%eax
 839:	83 c0 08             	add    $0x8,%eax
 83c:	eb 3b                	jmp    879 <malloc+0xe1>
    }
    if(p == freep)
 83e:	a1 48 0b 00 00       	mov    0xb48,%eax
 843:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 846:	75 1e                	jne    866 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 848:	83 ec 0c             	sub    $0xc,%esp
 84b:	ff 75 ec             	pushl  -0x14(%ebp)
 84e:	e8 e5 fe ff ff       	call   738 <morecore>
 853:	83 c4 10             	add    $0x10,%esp
 856:	89 45 f4             	mov    %eax,-0xc(%ebp)
 859:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85d:	75 07                	jne    866 <malloc+0xce>
        return 0;
 85f:	b8 00 00 00 00       	mov    $0x0,%eax
 864:	eb 13                	jmp    879 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 866:	8b 45 f4             	mov    -0xc(%ebp),%eax
 869:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86f:	8b 00                	mov    (%eax),%eax
 871:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 874:	e9 6d ff ff ff       	jmp    7e6 <malloc+0x4e>
}
 879:	c9                   	leave  
 87a:	c3                   	ret    
