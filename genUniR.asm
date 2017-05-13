
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
  60:	68 73 08 00 00       	push   $0x873
  65:	6a 01                	push   $0x1
  67:	e8 51 04 00 00       	call   4bd <printf>
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
 2b0:	0f b6 80 78 08 00 00 	movzbl 0x878(%eax),%eax
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

000003e6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e6:	55                   	push   %ebp
 3e7:	89 e5                	mov    %esp,%ebp
 3e9:	83 ec 18             	sub    $0x18,%esp
 3ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ef:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3f2:	83 ec 04             	sub    $0x4,%esp
 3f5:	6a 01                	push   $0x1
 3f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3fa:	50                   	push   %eax
 3fb:	ff 75 08             	pushl  0x8(%ebp)
 3fe:	e8 4b ff ff ff       	call   34e <write>
 403:	83 c4 10             	add    $0x10,%esp
}
 406:	90                   	nop
 407:	c9                   	leave  
 408:	c3                   	ret    

00000409 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 409:	55                   	push   %ebp
 40a:	89 e5                	mov    %esp,%ebp
 40c:	53                   	push   %ebx
 40d:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 410:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 417:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 41b:	74 17                	je     434 <printint+0x2b>
 41d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 421:	79 11                	jns    434 <printint+0x2b>
    neg = 1;
 423:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 42a:	8b 45 0c             	mov    0xc(%ebp),%eax
 42d:	f7 d8                	neg    %eax
 42f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 432:	eb 06                	jmp    43a <printint+0x31>
  } else {
    x = xx;
 434:	8b 45 0c             	mov    0xc(%ebp),%eax
 437:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 43a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 441:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 444:	8d 41 01             	lea    0x1(%ecx),%eax
 447:	89 45 f4             	mov    %eax,-0xc(%ebp)
 44a:	8b 5d 10             	mov    0x10(%ebp),%ebx
 44d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 450:	ba 00 00 00 00       	mov    $0x0,%edx
 455:	f7 f3                	div    %ebx
 457:	89 d0                	mov    %edx,%eax
 459:	0f b6 80 fc 0a 00 00 	movzbl 0xafc(%eax),%eax
 460:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 464:	8b 5d 10             	mov    0x10(%ebp),%ebx
 467:	8b 45 ec             	mov    -0x14(%ebp),%eax
 46a:	ba 00 00 00 00       	mov    $0x0,%edx
 46f:	f7 f3                	div    %ebx
 471:	89 45 ec             	mov    %eax,-0x14(%ebp)
 474:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 478:	75 c7                	jne    441 <printint+0x38>
  if(neg)
 47a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 47e:	74 2d                	je     4ad <printint+0xa4>
    buf[i++] = '-';
 480:	8b 45 f4             	mov    -0xc(%ebp),%eax
 483:	8d 50 01             	lea    0x1(%eax),%edx
 486:	89 55 f4             	mov    %edx,-0xc(%ebp)
 489:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 48e:	eb 1d                	jmp    4ad <printint+0xa4>
    putc(fd, buf[i]);
 490:	8d 55 dc             	lea    -0x24(%ebp),%edx
 493:	8b 45 f4             	mov    -0xc(%ebp),%eax
 496:	01 d0                	add    %edx,%eax
 498:	0f b6 00             	movzbl (%eax),%eax
 49b:	0f be c0             	movsbl %al,%eax
 49e:	83 ec 08             	sub    $0x8,%esp
 4a1:	50                   	push   %eax
 4a2:	ff 75 08             	pushl  0x8(%ebp)
 4a5:	e8 3c ff ff ff       	call   3e6 <putc>
 4aa:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 4ad:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b5:	79 d9                	jns    490 <printint+0x87>
    putc(fd, buf[i]);
}
 4b7:	90                   	nop
 4b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 4bb:	c9                   	leave  
 4bc:	c3                   	ret    

000004bd <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 4bd:	55                   	push   %ebp
 4be:	89 e5                	mov    %esp,%ebp
 4c0:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4c3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4ca:	8d 45 0c             	lea    0xc(%ebp),%eax
 4cd:	83 c0 04             	add    $0x4,%eax
 4d0:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4da:	e9 59 01 00 00       	jmp    638 <printf+0x17b>
    c = fmt[i] & 0xff;
 4df:	8b 55 0c             	mov    0xc(%ebp),%edx
 4e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4e5:	01 d0                	add    %edx,%eax
 4e7:	0f b6 00             	movzbl (%eax),%eax
 4ea:	0f be c0             	movsbl %al,%eax
 4ed:	25 ff 00 00 00       	and    $0xff,%eax
 4f2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f9:	75 2c                	jne    527 <printf+0x6a>
      if(c == '%'){
 4fb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ff:	75 0c                	jne    50d <printf+0x50>
        state = '%';
 501:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 508:	e9 27 01 00 00       	jmp    634 <printf+0x177>
      } else {
        putc(fd, c);
 50d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 510:	0f be c0             	movsbl %al,%eax
 513:	83 ec 08             	sub    $0x8,%esp
 516:	50                   	push   %eax
 517:	ff 75 08             	pushl  0x8(%ebp)
 51a:	e8 c7 fe ff ff       	call   3e6 <putc>
 51f:	83 c4 10             	add    $0x10,%esp
 522:	e9 0d 01 00 00       	jmp    634 <printf+0x177>
      }
    } else if(state == '%'){
 527:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 52b:	0f 85 03 01 00 00    	jne    634 <printf+0x177>
      if(c == 'd'){
 531:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 535:	75 1e                	jne    555 <printf+0x98>
        printint(fd, *ap, 10, 1);
 537:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53a:	8b 00                	mov    (%eax),%eax
 53c:	6a 01                	push   $0x1
 53e:	6a 0a                	push   $0xa
 540:	50                   	push   %eax
 541:	ff 75 08             	pushl  0x8(%ebp)
 544:	e8 c0 fe ff ff       	call   409 <printint>
 549:	83 c4 10             	add    $0x10,%esp
        ap++;
 54c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 550:	e9 d8 00 00 00       	jmp    62d <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 555:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 559:	74 06                	je     561 <printf+0xa4>
 55b:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 55f:	75 1e                	jne    57f <printf+0xc2>
        printint(fd, *ap, 16, 0);
 561:	8b 45 e8             	mov    -0x18(%ebp),%eax
 564:	8b 00                	mov    (%eax),%eax
 566:	6a 00                	push   $0x0
 568:	6a 10                	push   $0x10
 56a:	50                   	push   %eax
 56b:	ff 75 08             	pushl  0x8(%ebp)
 56e:	e8 96 fe ff ff       	call   409 <printint>
 573:	83 c4 10             	add    $0x10,%esp
        ap++;
 576:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 57a:	e9 ae 00 00 00       	jmp    62d <printf+0x170>
      } else if(c == 's'){
 57f:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 583:	75 43                	jne    5c8 <printf+0x10b>
        s = (char*)*ap;
 585:	8b 45 e8             	mov    -0x18(%ebp),%eax
 588:	8b 00                	mov    (%eax),%eax
 58a:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 58d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 591:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 595:	75 25                	jne    5bc <printf+0xff>
          s = "(null)";
 597:	c7 45 f4 89 08 00 00 	movl   $0x889,-0xc(%ebp)
        while(*s != 0){
 59e:	eb 1c                	jmp    5bc <printf+0xff>
          putc(fd, *s);
 5a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a3:	0f b6 00             	movzbl (%eax),%eax
 5a6:	0f be c0             	movsbl %al,%eax
 5a9:	83 ec 08             	sub    $0x8,%esp
 5ac:	50                   	push   %eax
 5ad:	ff 75 08             	pushl  0x8(%ebp)
 5b0:	e8 31 fe ff ff       	call   3e6 <putc>
 5b5:	83 c4 10             	add    $0x10,%esp
          s++;
 5b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bf:	0f b6 00             	movzbl (%eax),%eax
 5c2:	84 c0                	test   %al,%al
 5c4:	75 da                	jne    5a0 <printf+0xe3>
 5c6:	eb 65                	jmp    62d <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5c8:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5cc:	75 1d                	jne    5eb <printf+0x12e>
        putc(fd, *ap);
 5ce:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d1:	8b 00                	mov    (%eax),%eax
 5d3:	0f be c0             	movsbl %al,%eax
 5d6:	83 ec 08             	sub    $0x8,%esp
 5d9:	50                   	push   %eax
 5da:	ff 75 08             	pushl  0x8(%ebp)
 5dd:	e8 04 fe ff ff       	call   3e6 <putc>
 5e2:	83 c4 10             	add    $0x10,%esp
        ap++;
 5e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e9:	eb 42                	jmp    62d <printf+0x170>
      } else if(c == '%'){
 5eb:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ef:	75 17                	jne    608 <printf+0x14b>
        putc(fd, c);
 5f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f4:	0f be c0             	movsbl %al,%eax
 5f7:	83 ec 08             	sub    $0x8,%esp
 5fa:	50                   	push   %eax
 5fb:	ff 75 08             	pushl  0x8(%ebp)
 5fe:	e8 e3 fd ff ff       	call   3e6 <putc>
 603:	83 c4 10             	add    $0x10,%esp
 606:	eb 25                	jmp    62d <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 608:	83 ec 08             	sub    $0x8,%esp
 60b:	6a 25                	push   $0x25
 60d:	ff 75 08             	pushl  0x8(%ebp)
 610:	e8 d1 fd ff ff       	call   3e6 <putc>
 615:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 618:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 61b:	0f be c0             	movsbl %al,%eax
 61e:	83 ec 08             	sub    $0x8,%esp
 621:	50                   	push   %eax
 622:	ff 75 08             	pushl  0x8(%ebp)
 625:	e8 bc fd ff ff       	call   3e6 <putc>
 62a:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 62d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 634:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 638:	8b 55 0c             	mov    0xc(%ebp),%edx
 63b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 63e:	01 d0                	add    %edx,%eax
 640:	0f b6 00             	movzbl (%eax),%eax
 643:	84 c0                	test   %al,%al
 645:	0f 85 94 fe ff ff    	jne    4df <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 64b:	90                   	nop
 64c:	c9                   	leave  
 64d:	c3                   	ret    

0000064e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 64e:	55                   	push   %ebp
 64f:	89 e5                	mov    %esp,%ebp
 651:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 654:	8b 45 08             	mov    0x8(%ebp),%eax
 657:	83 e8 08             	sub    $0x8,%eax
 65a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65d:	a1 48 0b 00 00       	mov    0xb48,%eax
 662:	89 45 fc             	mov    %eax,-0x4(%ebp)
 665:	eb 24                	jmp    68b <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 667:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66a:	8b 00                	mov    (%eax),%eax
 66c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66f:	77 12                	ja     683 <free+0x35>
 671:	8b 45 f8             	mov    -0x8(%ebp),%eax
 674:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 677:	77 24                	ja     69d <free+0x4f>
 679:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67c:	8b 00                	mov    (%eax),%eax
 67e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 681:	77 1a                	ja     69d <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	89 45 fc             	mov    %eax,-0x4(%ebp)
 68b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 691:	76 d4                	jbe    667 <free+0x19>
 693:	8b 45 fc             	mov    -0x4(%ebp),%eax
 696:	8b 00                	mov    (%eax),%eax
 698:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 69b:	76 ca                	jbe    667 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 69d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a0:	8b 40 04             	mov    0x4(%eax),%eax
 6a3:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ad:	01 c2                	add    %eax,%edx
 6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b2:	8b 00                	mov    (%eax),%eax
 6b4:	39 c2                	cmp    %eax,%edx
 6b6:	75 24                	jne    6dc <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bb:	8b 50 04             	mov    0x4(%eax),%edx
 6be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c1:	8b 00                	mov    (%eax),%eax
 6c3:	8b 40 04             	mov    0x4(%eax),%eax
 6c6:	01 c2                	add    %eax,%edx
 6c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cb:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d1:	8b 00                	mov    (%eax),%eax
 6d3:	8b 10                	mov    (%eax),%edx
 6d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d8:	89 10                	mov    %edx,(%eax)
 6da:	eb 0a                	jmp    6e6 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6df:	8b 10                	mov    (%eax),%edx
 6e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e4:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	8b 40 04             	mov    0x4(%eax),%eax
 6ec:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f6:	01 d0                	add    %edx,%eax
 6f8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6fb:	75 20                	jne    71d <free+0xcf>
    p->s.size += bp->s.size;
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	8b 50 04             	mov    0x4(%eax),%edx
 703:	8b 45 f8             	mov    -0x8(%ebp),%eax
 706:	8b 40 04             	mov    0x4(%eax),%eax
 709:	01 c2                	add    %eax,%edx
 70b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70e:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 711:	8b 45 f8             	mov    -0x8(%ebp),%eax
 714:	8b 10                	mov    (%eax),%edx
 716:	8b 45 fc             	mov    -0x4(%ebp),%eax
 719:	89 10                	mov    %edx,(%eax)
 71b:	eb 08                	jmp    725 <free+0xd7>
  } else
    p->s.ptr = bp;
 71d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 720:	8b 55 f8             	mov    -0x8(%ebp),%edx
 723:	89 10                	mov    %edx,(%eax)
  freep = p;
 725:	8b 45 fc             	mov    -0x4(%ebp),%eax
 728:	a3 48 0b 00 00       	mov    %eax,0xb48
}
 72d:	90                   	nop
 72e:	c9                   	leave  
 72f:	c3                   	ret    

00000730 <morecore>:

static Header*
morecore(uint nu)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 736:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 73d:	77 07                	ja     746 <morecore+0x16>
    nu = 4096;
 73f:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 746:	8b 45 08             	mov    0x8(%ebp),%eax
 749:	c1 e0 03             	shl    $0x3,%eax
 74c:	83 ec 0c             	sub    $0xc,%esp
 74f:	50                   	push   %eax
 750:	e8 61 fc ff ff       	call   3b6 <sbrk>
 755:	83 c4 10             	add    $0x10,%esp
 758:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 75b:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 75f:	75 07                	jne    768 <morecore+0x38>
    return 0;
 761:	b8 00 00 00 00       	mov    $0x0,%eax
 766:	eb 26                	jmp    78e <morecore+0x5e>
  hp = (Header*)p;
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 76e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 771:	8b 55 08             	mov    0x8(%ebp),%edx
 774:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 777:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77a:	83 c0 08             	add    $0x8,%eax
 77d:	83 ec 0c             	sub    $0xc,%esp
 780:	50                   	push   %eax
 781:	e8 c8 fe ff ff       	call   64e <free>
 786:	83 c4 10             	add    $0x10,%esp
  return freep;
 789:	a1 48 0b 00 00       	mov    0xb48,%eax
}
 78e:	c9                   	leave  
 78f:	c3                   	ret    

00000790 <malloc>:

void*
malloc(uint nbytes)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 796:	8b 45 08             	mov    0x8(%ebp),%eax
 799:	83 c0 07             	add    $0x7,%eax
 79c:	c1 e8 03             	shr    $0x3,%eax
 79f:	83 c0 01             	add    $0x1,%eax
 7a2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7a5:	a1 48 0b 00 00       	mov    0xb48,%eax
 7aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ad:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7b1:	75 23                	jne    7d6 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7b3:	c7 45 f0 40 0b 00 00 	movl   $0xb40,-0x10(%ebp)
 7ba:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bd:	a3 48 0b 00 00       	mov    %eax,0xb48
 7c2:	a1 48 0b 00 00       	mov    0xb48,%eax
 7c7:	a3 40 0b 00 00       	mov    %eax,0xb40
    base.s.size = 0;
 7cc:	c7 05 44 0b 00 00 00 	movl   $0x0,0xb44
 7d3:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d9:	8b 00                	mov    (%eax),%eax
 7db:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e1:	8b 40 04             	mov    0x4(%eax),%eax
 7e4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e7:	72 4d                	jb     836 <malloc+0xa6>
      if(p->s.size == nunits)
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	8b 40 04             	mov    0x4(%eax),%eax
 7ef:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7f2:	75 0c                	jne    800 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 10                	mov    (%eax),%edx
 7f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fc:	89 10                	mov    %edx,(%eax)
 7fe:	eb 26                	jmp    826 <malloc+0x96>
      else {
        p->s.size -= nunits;
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	8b 40 04             	mov    0x4(%eax),%eax
 806:	2b 45 ec             	sub    -0x14(%ebp),%eax
 809:	89 c2                	mov    %eax,%edx
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 811:	8b 45 f4             	mov    -0xc(%ebp),%eax
 814:	8b 40 04             	mov    0x4(%eax),%eax
 817:	c1 e0 03             	shl    $0x3,%eax
 81a:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	8b 55 ec             	mov    -0x14(%ebp),%edx
 823:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 826:	8b 45 f0             	mov    -0x10(%ebp),%eax
 829:	a3 48 0b 00 00       	mov    %eax,0xb48
      return (void*)(p + 1);
 82e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 831:	83 c0 08             	add    $0x8,%eax
 834:	eb 3b                	jmp    871 <malloc+0xe1>
    }
    if(p == freep)
 836:	a1 48 0b 00 00       	mov    0xb48,%eax
 83b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 83e:	75 1e                	jne    85e <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 840:	83 ec 0c             	sub    $0xc,%esp
 843:	ff 75 ec             	pushl  -0x14(%ebp)
 846:	e8 e5 fe ff ff       	call   730 <morecore>
 84b:	83 c4 10             	add    $0x10,%esp
 84e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 851:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 855:	75 07                	jne    85e <malloc+0xce>
        return 0;
 857:	b8 00 00 00 00       	mov    $0x0,%eax
 85c:	eb 13                	jmp    871 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 861:	89 45 f0             	mov    %eax,-0x10(%ebp)
 864:	8b 45 f4             	mov    -0xc(%ebp),%eax
 867:	8b 00                	mov    (%eax),%eax
 869:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 86c:	e9 6d ff ff ff       	jmp    7de <malloc+0x4e>
}
 871:	c9                   	leave  
 872:	c3                   	ret    
