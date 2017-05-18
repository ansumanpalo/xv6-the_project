
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
  14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
  1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
  22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 47 09 00 00       	push   $0x947
  30:	6a 01                	push   $0x1
  32:	e8 5a 05 00 00       	call   591 <printf>
  37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  3a:	83 ec 04             	sub    $0x4,%esp
  3d:	68 00 02 00 00       	push   $0x200
  42:	6a 61                	push   $0x61
  44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  4a:	50                   	push   %eax
  4b:	e8 be 01 00 00       	call   20e <memset>
  50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  5a:	eb 0d                	jmp    69 <main+0x69>
    if(fork() > 0)
  5c:	e8 91 03 00 00       	call   3f2 <fork>
  61:	85 c0                	test   %eax,%eax
  63:	7f 0c                	jg     71 <main+0x71>
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));

  for(i = 0; i < 4; i++)
  65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  69:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
  6d:	7e ed                	jle    5c <main+0x5c>
  6f:	eb 01                	jmp    72 <main+0x72>
    if(fork() > 0)
      break;
  71:	90                   	nop

  printf(1, "write %d\n", i);
  72:	83 ec 04             	sub    $0x4,%esp
  75:	ff 75 f4             	pushl  -0xc(%ebp)
  78:	68 5a 09 00 00       	push   $0x95a
  7d:	6a 01                	push   $0x1
  7f:	e8 0d 05 00 00       	call   591 <printf>
  84:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  87:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  8b:	89 c2                	mov    %eax,%edx
  8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  90:	01 d0                	add    %edx,%eax
  92:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  95:	83 ec 08             	sub    $0x8,%esp
  98:	68 02 02 00 00       	push   $0x202
  9d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  a0:	50                   	push   %eax
  a1:	e8 94 03 00 00       	call   43a <open>
  a6:	83 c4 10             	add    $0x10,%esp
  a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
  ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  b3:	eb 1e                	jmp    d3 <main+0xd3>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b5:	83 ec 04             	sub    $0x4,%esp
  b8:	68 00 02 00 00       	push   $0x200
  bd:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  c3:	50                   	push   %eax
  c4:	ff 75 f0             	pushl  -0x10(%ebp)
  c7:	e8 4e 03 00 00       	call   41a <write>
  cc:	83 c4 10             	add    $0x10,%esp

  printf(1, "write %d\n", i);

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  for(i = 0; i < 20; i++)
  cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  d3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  d7:	7e dc                	jle    b5 <main+0xb5>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  close(fd);
  d9:	83 ec 0c             	sub    $0xc,%esp
  dc:	ff 75 f0             	pushl  -0x10(%ebp)
  df:	e8 3e 03 00 00       	call   422 <close>
  e4:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  e7:	83 ec 08             	sub    $0x8,%esp
  ea:	68 64 09 00 00       	push   $0x964
  ef:	6a 01                	push   $0x1
  f1:	e8 9b 04 00 00       	call   591 <printf>
  f6:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
  f9:	83 ec 08             	sub    $0x8,%esp
  fc:	6a 00                	push   $0x0
  fe:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 101:	50                   	push   %eax
 102:	e8 33 03 00 00       	call   43a <open>
 107:	83 c4 10             	add    $0x10,%esp
 10a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
 10d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 114:	eb 1e                	jmp    134 <main+0x134>
    read(fd, data, sizeof(data));
 116:	83 ec 04             	sub    $0x4,%esp
 119:	68 00 02 00 00       	push   $0x200
 11e:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
 124:	50                   	push   %eax
 125:	ff 75 f0             	pushl  -0x10(%ebp)
 128:	e8 e5 02 00 00       	call   412 <read>
 12d:	83 c4 10             	add    $0x10,%esp
  close(fd);

  printf(1, "read\n");

  fd = open(path, O_RDONLY);
  for (i = 0; i < 20; i++)
 130:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 134:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
 138:	7e dc                	jle    116 <main+0x116>
    read(fd, data, sizeof(data));
  close(fd);
 13a:	83 ec 0c             	sub    $0xc,%esp
 13d:	ff 75 f0             	pushl  -0x10(%ebp)
 140:	e8 dd 02 00 00       	call   422 <close>
 145:	83 c4 10             	add    $0x10,%esp

  wait();
 148:	e8 b5 02 00 00       	call   402 <wait>
  
  exit();
 14d:	e8 a8 02 00 00       	call   3fa <exit>

00000152 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
 155:	57                   	push   %edi
 156:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 157:	8b 4d 08             	mov    0x8(%ebp),%ecx
 15a:	8b 55 10             	mov    0x10(%ebp),%edx
 15d:	8b 45 0c             	mov    0xc(%ebp),%eax
 160:	89 cb                	mov    %ecx,%ebx
 162:	89 df                	mov    %ebx,%edi
 164:	89 d1                	mov    %edx,%ecx
 166:	fc                   	cld    
 167:	f3 aa                	rep stos %al,%es:(%edi)
 169:	89 ca                	mov    %ecx,%edx
 16b:	89 fb                	mov    %edi,%ebx
 16d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 170:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 173:	90                   	nop
 174:	5b                   	pop    %ebx
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    

00000178 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
 17b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 184:	90                   	nop
 185:	8b 45 08             	mov    0x8(%ebp),%eax
 188:	8d 50 01             	lea    0x1(%eax),%edx
 18b:	89 55 08             	mov    %edx,0x8(%ebp)
 18e:	8b 55 0c             	mov    0xc(%ebp),%edx
 191:	8d 4a 01             	lea    0x1(%edx),%ecx
 194:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 197:	0f b6 12             	movzbl (%edx),%edx
 19a:	88 10                	mov    %dl,(%eax)
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	84 c0                	test   %al,%al
 1a1:	75 e2                	jne    185 <strcpy+0xd>
    ;
  return os;
 1a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a6:	c9                   	leave  
 1a7:	c3                   	ret    

000001a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1ab:	eb 08                	jmp    1b5 <strcmp+0xd>
    p++, q++;
 1ad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 1b5:	8b 45 08             	mov    0x8(%ebp),%eax
 1b8:	0f b6 00             	movzbl (%eax),%eax
 1bb:	84 c0                	test   %al,%al
 1bd:	74 10                	je     1cf <strcmp+0x27>
 1bf:	8b 45 08             	mov    0x8(%ebp),%eax
 1c2:	0f b6 10             	movzbl (%eax),%edx
 1c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c8:	0f b6 00             	movzbl (%eax),%eax
 1cb:	38 c2                	cmp    %al,%dl
 1cd:	74 de                	je     1ad <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	0f b6 00             	movzbl (%eax),%eax
 1d5:	0f b6 d0             	movzbl %al,%edx
 1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1db:	0f b6 00             	movzbl (%eax),%eax
 1de:	0f b6 c0             	movzbl %al,%eax
 1e1:	29 c2                	sub    %eax,%edx
 1e3:	89 d0                	mov    %edx,%eax
}
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    

000001e7 <strlen>:

uint
strlen(char *s)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1f4:	eb 04                	jmp    1fa <strlen+0x13>
 1f6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	01 d0                	add    %edx,%eax
 202:	0f b6 00             	movzbl (%eax),%eax
 205:	84 c0                	test   %al,%al
 207:	75 ed                	jne    1f6 <strlen+0xf>
    ;
  return n;
 209:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20c:	c9                   	leave  
 20d:	c3                   	ret    

0000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
 20e:	55                   	push   %ebp
 20f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 211:	8b 45 10             	mov    0x10(%ebp),%eax
 214:	50                   	push   %eax
 215:	ff 75 0c             	pushl  0xc(%ebp)
 218:	ff 75 08             	pushl  0x8(%ebp)
 21b:	e8 32 ff ff ff       	call   152 <stosb>
 220:	83 c4 0c             	add    $0xc,%esp
  return dst;
 223:	8b 45 08             	mov    0x8(%ebp),%eax
}
 226:	c9                   	leave  
 227:	c3                   	ret    

00000228 <strchr>:

char*
strchr(const char *s, char c)
{
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	8b 45 0c             	mov    0xc(%ebp),%eax
 231:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 234:	eb 14                	jmp    24a <strchr+0x22>
    if(*s == c)
 236:	8b 45 08             	mov    0x8(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	3a 45 fc             	cmp    -0x4(%ebp),%al
 23f:	75 05                	jne    246 <strchr+0x1e>
      return (char*)s;
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	eb 13                	jmp    259 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 246:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	84 c0                	test   %al,%al
 252:	75 e2                	jne    236 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 254:	b8 00 00 00 00       	mov    $0x0,%eax
}
 259:	c9                   	leave  
 25a:	c3                   	ret    

0000025b <gets>:

char*
gets(char *buf, int max)
{
 25b:	55                   	push   %ebp
 25c:	89 e5                	mov    %esp,%ebp
 25e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 261:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 268:	eb 42                	jmp    2ac <gets+0x51>
    cc = read(0, &c, 1);
 26a:	83 ec 04             	sub    $0x4,%esp
 26d:	6a 01                	push   $0x1
 26f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 272:	50                   	push   %eax
 273:	6a 00                	push   $0x0
 275:	e8 98 01 00 00       	call   412 <read>
 27a:	83 c4 10             	add    $0x10,%esp
 27d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 284:	7e 33                	jle    2b9 <gets+0x5e>
      break;
    buf[i++] = c;
 286:	8b 45 f4             	mov    -0xc(%ebp),%eax
 289:	8d 50 01             	lea    0x1(%eax),%edx
 28c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 28f:	89 c2                	mov    %eax,%edx
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	01 c2                	add    %eax,%edx
 296:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 29a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 29c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a0:	3c 0a                	cmp    $0xa,%al
 2a2:	74 16                	je     2ba <gets+0x5f>
 2a4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a8:	3c 0d                	cmp    $0xd,%al
 2aa:	74 0e                	je     2ba <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2af:	83 c0 01             	add    $0x1,%eax
 2b2:	3b 45 0c             	cmp    0xc(%ebp),%eax
 2b5:	7c b3                	jl     26a <gets+0xf>
 2b7:	eb 01                	jmp    2ba <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 2b9:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 2ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2bd:	8b 45 08             	mov    0x8(%ebp),%eax
 2c0:	01 d0                	add    %edx,%eax
 2c2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c8:	c9                   	leave  
 2c9:	c3                   	ret    

000002ca <stat>:

int
stat(char *n, struct stat *st)
{
 2ca:	55                   	push   %ebp
 2cb:	89 e5                	mov    %esp,%ebp
 2cd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	6a 00                	push   $0x0
 2d5:	ff 75 08             	pushl  0x8(%ebp)
 2d8:	e8 5d 01 00 00       	call   43a <open>
 2dd:	83 c4 10             	add    $0x10,%esp
 2e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2e7:	79 07                	jns    2f0 <stat+0x26>
    return -1;
 2e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ee:	eb 25                	jmp    315 <stat+0x4b>
  r = fstat(fd, st);
 2f0:	83 ec 08             	sub    $0x8,%esp
 2f3:	ff 75 0c             	pushl  0xc(%ebp)
 2f6:	ff 75 f4             	pushl  -0xc(%ebp)
 2f9:	e8 54 01 00 00       	call   452 <fstat>
 2fe:	83 c4 10             	add    $0x10,%esp
 301:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 304:	83 ec 0c             	sub    $0xc,%esp
 307:	ff 75 f4             	pushl  -0xc(%ebp)
 30a:	e8 13 01 00 00       	call   422 <close>
 30f:	83 c4 10             	add    $0x10,%esp
  return r;
 312:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 315:	c9                   	leave  
 316:	c3                   	ret    

00000317 <atoi>:

int
atoi(const char *s)
{
 317:	55                   	push   %ebp
 318:	89 e5                	mov    %esp,%ebp
 31a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 31d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 324:	eb 25                	jmp    34b <atoi+0x34>
    n = n*10 + *s++ - '0';
 326:	8b 55 fc             	mov    -0x4(%ebp),%edx
 329:	89 d0                	mov    %edx,%eax
 32b:	c1 e0 02             	shl    $0x2,%eax
 32e:	01 d0                	add    %edx,%eax
 330:	01 c0                	add    %eax,%eax
 332:	89 c1                	mov    %eax,%ecx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8d 50 01             	lea    0x1(%eax),%edx
 33a:	89 55 08             	mov    %edx,0x8(%ebp)
 33d:	0f b6 00             	movzbl (%eax),%eax
 340:	0f be c0             	movsbl %al,%eax
 343:	01 c8                	add    %ecx,%eax
 345:	83 e8 30             	sub    $0x30,%eax
 348:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
 34e:	0f b6 00             	movzbl (%eax),%eax
 351:	3c 2f                	cmp    $0x2f,%al
 353:	7e 0a                	jle    35f <atoi+0x48>
 355:	8b 45 08             	mov    0x8(%ebp),%eax
 358:	0f b6 00             	movzbl (%eax),%eax
 35b:	3c 39                	cmp    $0x39,%al
 35d:	7e c7                	jle    326 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 35f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 362:	c9                   	leave  
 363:	c3                   	ret    

00000364 <itoa>:

char*
itoa(int val, int base){
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 36a:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 371:	eb 29                	jmp    39c <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 373:	8b 45 08             	mov    0x8(%ebp),%eax
 376:	99                   	cltd   
 377:	f7 7d 0c             	idivl  0xc(%ebp)
 37a:	89 d0                	mov    %edx,%eax
 37c:	0f b6 80 6a 09 00 00 	movzbl 0x96a(%eax),%eax
 383:	8b 55 fc             	mov    -0x4(%ebp),%edx
 386:	81 c2 00 0c 00 00    	add    $0xc00,%edx
 38c:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 38e:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 392:	8b 45 08             	mov    0x8(%ebp),%eax
 395:	99                   	cltd   
 396:	f7 7d 0c             	idivl  0xc(%ebp)
 399:	89 45 08             	mov    %eax,0x8(%ebp)
 39c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 3a0:	74 06                	je     3a8 <itoa+0x44>
 3a2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 3a6:	75 cb                	jne    373 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 3a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ab:	83 c0 01             	add    $0x1,%eax
 3ae:	05 00 0c 00 00       	add    $0xc00,%eax

}
 3b3:	c9                   	leave  
 3b4:	c3                   	ret    

000003b5 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 3b5:	55                   	push   %ebp
 3b6:	89 e5                	mov    %esp,%ebp
 3b8:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 3bb:	8b 45 08             	mov    0x8(%ebp),%eax
 3be:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3c1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3c7:	eb 17                	jmp    3e0 <memmove+0x2b>
    *dst++ = *src++;
 3c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3cc:	8d 50 01             	lea    0x1(%eax),%edx
 3cf:	89 55 fc             	mov    %edx,-0x4(%ebp)
 3d2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3d5:	8d 4a 01             	lea    0x1(%edx),%ecx
 3d8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 3db:	0f b6 12             	movzbl (%edx),%edx
 3de:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3e0:	8b 45 10             	mov    0x10(%ebp),%eax
 3e3:	8d 50 ff             	lea    -0x1(%eax),%edx
 3e6:	89 55 10             	mov    %edx,0x10(%ebp)
 3e9:	85 c0                	test   %eax,%eax
 3eb:	7f dc                	jg     3c9 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 3ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3f0:	c9                   	leave  
 3f1:	c3                   	ret    

000003f2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3f2:	b8 01 00 00 00       	mov    $0x1,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <exit>:
SYSCALL(exit)
 3fa:	b8 02 00 00 00       	mov    $0x2,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <wait>:
SYSCALL(wait)
 402:	b8 03 00 00 00       	mov    $0x3,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <pipe>:
SYSCALL(pipe)
 40a:	b8 04 00 00 00       	mov    $0x4,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <read>:
SYSCALL(read)
 412:	b8 05 00 00 00       	mov    $0x5,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <write>:
SYSCALL(write)
 41a:	b8 10 00 00 00       	mov    $0x10,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <close>:
SYSCALL(close)
 422:	b8 15 00 00 00       	mov    $0x15,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <kill>:
SYSCALL(kill)
 42a:	b8 06 00 00 00       	mov    $0x6,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <exec>:
SYSCALL(exec)
 432:	b8 07 00 00 00       	mov    $0x7,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <open>:
SYSCALL(open)
 43a:	b8 0f 00 00 00       	mov    $0xf,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <mknod>:
SYSCALL(mknod)
 442:	b8 11 00 00 00       	mov    $0x11,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <unlink>:
SYSCALL(unlink)
 44a:	b8 12 00 00 00       	mov    $0x12,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <fstat>:
SYSCALL(fstat)
 452:	b8 08 00 00 00       	mov    $0x8,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <link>:
SYSCALL(link)
 45a:	b8 13 00 00 00       	mov    $0x13,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <mkdir>:
SYSCALL(mkdir)
 462:	b8 14 00 00 00       	mov    $0x14,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <chdir>:
SYSCALL(chdir)
 46a:	b8 09 00 00 00       	mov    $0x9,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <dup>:
SYSCALL(dup)
 472:	b8 0a 00 00 00       	mov    $0xa,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <getpid>:
SYSCALL(getpid)
 47a:	b8 0b 00 00 00       	mov    $0xb,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <sbrk>:
SYSCALL(sbrk)
 482:	b8 0c 00 00 00       	mov    $0xc,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <sleep>:
SYSCALL(sleep)
 48a:	b8 0d 00 00 00       	mov    $0xd,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <uptime>:
SYSCALL(uptime)
 492:	b8 0e 00 00 00       	mov    $0xe,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <randomX>:
SYSCALL(randomX)
 49a:	b8 16 00 00 00       	mov    $0x16,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <setSeedX>:
SYSCALL(setSeedX)
 4a2:	b8 17 00 00 00       	mov    $0x17,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <uniformR>:
SYSCALL(uniformR)
 4aa:	b8 18 00 00 00       	mov    $0x18,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <setdeadline>:
 4b2:	b8 19 00 00 00       	mov    $0x19,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4ba:	55                   	push   %ebp
 4bb:	89 e5                	mov    %esp,%ebp
 4bd:	83 ec 18             	sub    $0x18,%esp
 4c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4c6:	83 ec 04             	sub    $0x4,%esp
 4c9:	6a 01                	push   $0x1
 4cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4ce:	50                   	push   %eax
 4cf:	ff 75 08             	pushl  0x8(%ebp)
 4d2:	e8 43 ff ff ff       	call   41a <write>
 4d7:	83 c4 10             	add    $0x10,%esp
}
 4da:	90                   	nop
 4db:	c9                   	leave  
 4dc:	c3                   	ret    

000004dd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4dd:	55                   	push   %ebp
 4de:	89 e5                	mov    %esp,%ebp
 4e0:	53                   	push   %ebx
 4e1:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4e4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4eb:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4ef:	74 17                	je     508 <printint+0x2b>
 4f1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4f5:	79 11                	jns    508 <printint+0x2b>
    neg = 1;
 4f7:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 501:	f7 d8                	neg    %eax
 503:	89 45 ec             	mov    %eax,-0x14(%ebp)
 506:	eb 06                	jmp    50e <printint+0x31>
  } else {
    x = xx;
 508:	8b 45 0c             	mov    0xc(%ebp),%eax
 50b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 50e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 515:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 518:	8d 41 01             	lea    0x1(%ecx),%eax
 51b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 51e:	8b 5d 10             	mov    0x10(%ebp),%ebx
 521:	8b 45 ec             	mov    -0x14(%ebp),%eax
 524:	ba 00 00 00 00       	mov    $0x0,%edx
 529:	f7 f3                	div    %ebx
 52b:	89 d0                	mov    %edx,%eax
 52d:	0f b6 80 ec 0b 00 00 	movzbl 0xbec(%eax),%eax
 534:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 538:	8b 5d 10             	mov    0x10(%ebp),%ebx
 53b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 53e:	ba 00 00 00 00       	mov    $0x0,%edx
 543:	f7 f3                	div    %ebx
 545:	89 45 ec             	mov    %eax,-0x14(%ebp)
 548:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 54c:	75 c7                	jne    515 <printint+0x38>
  if(neg)
 54e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 552:	74 2d                	je     581 <printint+0xa4>
    buf[i++] = '-';
 554:	8b 45 f4             	mov    -0xc(%ebp),%eax
 557:	8d 50 01             	lea    0x1(%eax),%edx
 55a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 55d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 562:	eb 1d                	jmp    581 <printint+0xa4>
    putc(fd, buf[i]);
 564:	8d 55 dc             	lea    -0x24(%ebp),%edx
 567:	8b 45 f4             	mov    -0xc(%ebp),%eax
 56a:	01 d0                	add    %edx,%eax
 56c:	0f b6 00             	movzbl (%eax),%eax
 56f:	0f be c0             	movsbl %al,%eax
 572:	83 ec 08             	sub    $0x8,%esp
 575:	50                   	push   %eax
 576:	ff 75 08             	pushl  0x8(%ebp)
 579:	e8 3c ff ff ff       	call   4ba <putc>
 57e:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 581:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 585:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 589:	79 d9                	jns    564 <printint+0x87>
    putc(fd, buf[i]);
}
 58b:	90                   	nop
 58c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 58f:	c9                   	leave  
 590:	c3                   	ret    

00000591 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 591:	55                   	push   %ebp
 592:	89 e5                	mov    %esp,%ebp
 594:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 597:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 59e:	8d 45 0c             	lea    0xc(%ebp),%eax
 5a1:	83 c0 04             	add    $0x4,%eax
 5a4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 5a7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5ae:	e9 59 01 00 00       	jmp    70c <printf+0x17b>
    c = fmt[i] & 0xff;
 5b3:	8b 55 0c             	mov    0xc(%ebp),%edx
 5b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b9:	01 d0                	add    %edx,%eax
 5bb:	0f b6 00             	movzbl (%eax),%eax
 5be:	0f be c0             	movsbl %al,%eax
 5c1:	25 ff 00 00 00       	and    $0xff,%eax
 5c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5cd:	75 2c                	jne    5fb <printf+0x6a>
      if(c == '%'){
 5cf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d3:	75 0c                	jne    5e1 <printf+0x50>
        state = '%';
 5d5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5dc:	e9 27 01 00 00       	jmp    708 <printf+0x177>
      } else {
        putc(fd, c);
 5e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e4:	0f be c0             	movsbl %al,%eax
 5e7:	83 ec 08             	sub    $0x8,%esp
 5ea:	50                   	push   %eax
 5eb:	ff 75 08             	pushl  0x8(%ebp)
 5ee:	e8 c7 fe ff ff       	call   4ba <putc>
 5f3:	83 c4 10             	add    $0x10,%esp
 5f6:	e9 0d 01 00 00       	jmp    708 <printf+0x177>
      }
    } else if(state == '%'){
 5fb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5ff:	0f 85 03 01 00 00    	jne    708 <printf+0x177>
      if(c == 'd'){
 605:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 609:	75 1e                	jne    629 <printf+0x98>
        printint(fd, *ap, 10, 1);
 60b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 60e:	8b 00                	mov    (%eax),%eax
 610:	6a 01                	push   $0x1
 612:	6a 0a                	push   $0xa
 614:	50                   	push   %eax
 615:	ff 75 08             	pushl  0x8(%ebp)
 618:	e8 c0 fe ff ff       	call   4dd <printint>
 61d:	83 c4 10             	add    $0x10,%esp
        ap++;
 620:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 624:	e9 d8 00 00 00       	jmp    701 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 629:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 62d:	74 06                	je     635 <printf+0xa4>
 62f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 633:	75 1e                	jne    653 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 635:	8b 45 e8             	mov    -0x18(%ebp),%eax
 638:	8b 00                	mov    (%eax),%eax
 63a:	6a 00                	push   $0x0
 63c:	6a 10                	push   $0x10
 63e:	50                   	push   %eax
 63f:	ff 75 08             	pushl  0x8(%ebp)
 642:	e8 96 fe ff ff       	call   4dd <printint>
 647:	83 c4 10             	add    $0x10,%esp
        ap++;
 64a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 64e:	e9 ae 00 00 00       	jmp    701 <printf+0x170>
      } else if(c == 's'){
 653:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 657:	75 43                	jne    69c <printf+0x10b>
        s = (char*)*ap;
 659:	8b 45 e8             	mov    -0x18(%ebp),%eax
 65c:	8b 00                	mov    (%eax),%eax
 65e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 661:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 665:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 669:	75 25                	jne    690 <printf+0xff>
          s = "(null)";
 66b:	c7 45 f4 7b 09 00 00 	movl   $0x97b,-0xc(%ebp)
        while(*s != 0){
 672:	eb 1c                	jmp    690 <printf+0xff>
          putc(fd, *s);
 674:	8b 45 f4             	mov    -0xc(%ebp),%eax
 677:	0f b6 00             	movzbl (%eax),%eax
 67a:	0f be c0             	movsbl %al,%eax
 67d:	83 ec 08             	sub    $0x8,%esp
 680:	50                   	push   %eax
 681:	ff 75 08             	pushl  0x8(%ebp)
 684:	e8 31 fe ff ff       	call   4ba <putc>
 689:	83 c4 10             	add    $0x10,%esp
          s++;
 68c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 690:	8b 45 f4             	mov    -0xc(%ebp),%eax
 693:	0f b6 00             	movzbl (%eax),%eax
 696:	84 c0                	test   %al,%al
 698:	75 da                	jne    674 <printf+0xe3>
 69a:	eb 65                	jmp    701 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 69c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 6a0:	75 1d                	jne    6bf <printf+0x12e>
        putc(fd, *ap);
 6a2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a5:	8b 00                	mov    (%eax),%eax
 6a7:	0f be c0             	movsbl %al,%eax
 6aa:	83 ec 08             	sub    $0x8,%esp
 6ad:	50                   	push   %eax
 6ae:	ff 75 08             	pushl  0x8(%ebp)
 6b1:	e8 04 fe ff ff       	call   4ba <putc>
 6b6:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6bd:	eb 42                	jmp    701 <printf+0x170>
      } else if(c == '%'){
 6bf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6c3:	75 17                	jne    6dc <printf+0x14b>
        putc(fd, c);
 6c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c8:	0f be c0             	movsbl %al,%eax
 6cb:	83 ec 08             	sub    $0x8,%esp
 6ce:	50                   	push   %eax
 6cf:	ff 75 08             	pushl  0x8(%ebp)
 6d2:	e8 e3 fd ff ff       	call   4ba <putc>
 6d7:	83 c4 10             	add    $0x10,%esp
 6da:	eb 25                	jmp    701 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6dc:	83 ec 08             	sub    $0x8,%esp
 6df:	6a 25                	push   $0x25
 6e1:	ff 75 08             	pushl  0x8(%ebp)
 6e4:	e8 d1 fd ff ff       	call   4ba <putc>
 6e9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6ec:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6ef:	0f be c0             	movsbl %al,%eax
 6f2:	83 ec 08             	sub    $0x8,%esp
 6f5:	50                   	push   %eax
 6f6:	ff 75 08             	pushl  0x8(%ebp)
 6f9:	e8 bc fd ff ff       	call   4ba <putc>
 6fe:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 701:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 708:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 70c:	8b 55 0c             	mov    0xc(%ebp),%edx
 70f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 712:	01 d0                	add    %edx,%eax
 714:	0f b6 00             	movzbl (%eax),%eax
 717:	84 c0                	test   %al,%al
 719:	0f 85 94 fe ff ff    	jne    5b3 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 71f:	90                   	nop
 720:	c9                   	leave  
 721:	c3                   	ret    

00000722 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 722:	55                   	push   %ebp
 723:	89 e5                	mov    %esp,%ebp
 725:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 728:	8b 45 08             	mov    0x8(%ebp),%eax
 72b:	83 e8 08             	sub    $0x8,%eax
 72e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	a1 28 0c 00 00       	mov    0xc28,%eax
 736:	89 45 fc             	mov    %eax,-0x4(%ebp)
 739:	eb 24                	jmp    75f <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 73b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73e:	8b 00                	mov    (%eax),%eax
 740:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 743:	77 12                	ja     757 <free+0x35>
 745:	8b 45 f8             	mov    -0x8(%ebp),%eax
 748:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 74b:	77 24                	ja     771 <free+0x4f>
 74d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 750:	8b 00                	mov    (%eax),%eax
 752:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 755:	77 1a                	ja     771 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 757:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75a:	8b 00                	mov    (%eax),%eax
 75c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 75f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 762:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 765:	76 d4                	jbe    73b <free+0x19>
 767:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76a:	8b 00                	mov    (%eax),%eax
 76c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 76f:	76 ca                	jbe    73b <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 771:	8b 45 f8             	mov    -0x8(%ebp),%eax
 774:	8b 40 04             	mov    0x4(%eax),%eax
 777:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 77e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 781:	01 c2                	add    %eax,%edx
 783:	8b 45 fc             	mov    -0x4(%ebp),%eax
 786:	8b 00                	mov    (%eax),%eax
 788:	39 c2                	cmp    %eax,%edx
 78a:	75 24                	jne    7b0 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 78c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78f:	8b 50 04             	mov    0x4(%eax),%edx
 792:	8b 45 fc             	mov    -0x4(%ebp),%eax
 795:	8b 00                	mov    (%eax),%eax
 797:	8b 40 04             	mov    0x4(%eax),%eax
 79a:	01 c2                	add    %eax,%edx
 79c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79f:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 00                	mov    (%eax),%eax
 7a7:	8b 10                	mov    (%eax),%edx
 7a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ac:	89 10                	mov    %edx,(%eax)
 7ae:	eb 0a                	jmp    7ba <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	8b 10                	mov    (%eax),%edx
 7b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b8:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bd:	8b 40 04             	mov    0x4(%eax),%eax
 7c0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ca:	01 d0                	add    %edx,%eax
 7cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7cf:	75 20                	jne    7f1 <free+0xcf>
    p->s.size += bp->s.size;
 7d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d4:	8b 50 04             	mov    0x4(%eax),%edx
 7d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7da:	8b 40 04             	mov    0x4(%eax),%eax
 7dd:	01 c2                	add    %eax,%edx
 7df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e8:	8b 10                	mov    (%eax),%edx
 7ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ed:	89 10                	mov    %edx,(%eax)
 7ef:	eb 08                	jmp    7f9 <free+0xd7>
  } else
    p->s.ptr = bp;
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7f7:	89 10                	mov    %edx,(%eax)
  freep = p;
 7f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fc:	a3 28 0c 00 00       	mov    %eax,0xc28
}
 801:	90                   	nop
 802:	c9                   	leave  
 803:	c3                   	ret    

00000804 <morecore>:

static Header*
morecore(uint nu)
{
 804:	55                   	push   %ebp
 805:	89 e5                	mov    %esp,%ebp
 807:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 80a:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 811:	77 07                	ja     81a <morecore+0x16>
    nu = 4096;
 813:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 81a:	8b 45 08             	mov    0x8(%ebp),%eax
 81d:	c1 e0 03             	shl    $0x3,%eax
 820:	83 ec 0c             	sub    $0xc,%esp
 823:	50                   	push   %eax
 824:	e8 59 fc ff ff       	call   482 <sbrk>
 829:	83 c4 10             	add    $0x10,%esp
 82c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 82f:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 833:	75 07                	jne    83c <morecore+0x38>
    return 0;
 835:	b8 00 00 00 00       	mov    $0x0,%eax
 83a:	eb 26                	jmp    862 <morecore+0x5e>
  hp = (Header*)p;
 83c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 842:	8b 45 f0             	mov    -0x10(%ebp),%eax
 845:	8b 55 08             	mov    0x8(%ebp),%edx
 848:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 84b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 84e:	83 c0 08             	add    $0x8,%eax
 851:	83 ec 0c             	sub    $0xc,%esp
 854:	50                   	push   %eax
 855:	e8 c8 fe ff ff       	call   722 <free>
 85a:	83 c4 10             	add    $0x10,%esp
  return freep;
 85d:	a1 28 0c 00 00       	mov    0xc28,%eax
}
 862:	c9                   	leave  
 863:	c3                   	ret    

00000864 <malloc>:

void*
malloc(uint nbytes)
{
 864:	55                   	push   %ebp
 865:	89 e5                	mov    %esp,%ebp
 867:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 86a:	8b 45 08             	mov    0x8(%ebp),%eax
 86d:	83 c0 07             	add    $0x7,%eax
 870:	c1 e8 03             	shr    $0x3,%eax
 873:	83 c0 01             	add    $0x1,%eax
 876:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 879:	a1 28 0c 00 00       	mov    0xc28,%eax
 87e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 881:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 885:	75 23                	jne    8aa <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 887:	c7 45 f0 20 0c 00 00 	movl   $0xc20,-0x10(%ebp)
 88e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 891:	a3 28 0c 00 00       	mov    %eax,0xc28
 896:	a1 28 0c 00 00       	mov    0xc28,%eax
 89b:	a3 20 0c 00 00       	mov    %eax,0xc20
    base.s.size = 0;
 8a0:	c7 05 24 0c 00 00 00 	movl   $0x0,0xc24
 8a7:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ad:	8b 00                	mov    (%eax),%eax
 8af:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b5:	8b 40 04             	mov    0x4(%eax),%eax
 8b8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8bb:	72 4d                	jb     90a <malloc+0xa6>
      if(p->s.size == nunits)
 8bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c0:	8b 40 04             	mov    0x4(%eax),%eax
 8c3:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 8c6:	75 0c                	jne    8d4 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cb:	8b 10                	mov    (%eax),%edx
 8cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8d0:	89 10                	mov    %edx,(%eax)
 8d2:	eb 26                	jmp    8fa <malloc+0x96>
      else {
        p->s.size -= nunits;
 8d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d7:	8b 40 04             	mov    0x4(%eax),%eax
 8da:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8dd:	89 c2                	mov    %eax,%edx
 8df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e2:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e8:	8b 40 04             	mov    0x4(%eax),%eax
 8eb:	c1 e0 03             	shl    $0x3,%eax
 8ee:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f4:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8f7:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8fa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fd:	a3 28 0c 00 00       	mov    %eax,0xc28
      return (void*)(p + 1);
 902:	8b 45 f4             	mov    -0xc(%ebp),%eax
 905:	83 c0 08             	add    $0x8,%eax
 908:	eb 3b                	jmp    945 <malloc+0xe1>
    }
    if(p == freep)
 90a:	a1 28 0c 00 00       	mov    0xc28,%eax
 90f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 912:	75 1e                	jne    932 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 914:	83 ec 0c             	sub    $0xc,%esp
 917:	ff 75 ec             	pushl  -0x14(%ebp)
 91a:	e8 e5 fe ff ff       	call   804 <morecore>
 91f:	83 c4 10             	add    $0x10,%esp
 922:	89 45 f4             	mov    %eax,-0xc(%ebp)
 925:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 929:	75 07                	jne    932 <malloc+0xce>
        return 0;
 92b:	b8 00 00 00 00       	mov    $0x0,%eax
 930:	eb 13                	jmp    945 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 932:	8b 45 f4             	mov    -0xc(%ebp),%eax
 935:	89 45 f0             	mov    %eax,-0x10(%ebp)
 938:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93b:	8b 00                	mov    (%eax),%eax
 93d:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 940:	e9 6d ff ff ff       	jmp    8b2 <malloc+0x4e>
}
 945:	c9                   	leave  
 946:	c3                   	ret    
