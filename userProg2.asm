
_userProg2:     file format elf32-i386


Disassembly of section .text:

00000000 <counter>:
#include "types.h"
#include "stat.h"
#include "user.h"

void counter(int delay){
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 10             	sub    $0x10,%esp
    int i , j;
    for(i =0; i< delay; i++){
   6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
   d:	eb 19                	jmp    28 <counter+0x28>

        for(j=0; j< delay; j++){
   f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  16:	eb 04                	jmp    1c <counter+0x1c>
  18:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  1c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1f:	3b 45 08             	cmp    0x8(%ebp),%eax
  22:	7c f4                	jl     18 <counter+0x18>
#include "stat.h"
#include "user.h"

void counter(int delay){
    int i , j;
    for(i =0; i< delay; i++){
  24:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  28:	8b 45 fc             	mov    -0x4(%ebp),%eax
  2b:	3b 45 08             	cmp    0x8(%ebp),%eax
  2e:	7c df                	jl     f <counter+0xf>

        for(j=0; j< delay; j++){
            //printf(1,"i: %d j: %d\n",i,j );
        }
    }
}
  30:	90                   	nop
  31:	c9                   	leave  
  32:	c3                   	ret    

00000033 <main>:

int
main(int argc, char *argv[])
{
  33:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  37:	83 e4 f0             	and    $0xfffffff0,%esp
  3a:	ff 71 fc             	pushl  -0x4(%ecx)
  3d:	55                   	push   %ebp
  3e:	89 e5                	mov    %esp,%ebp
  40:	56                   	push   %esi
  41:	53                   	push   %ebx
  42:	51                   	push   %ecx
  43:	83 ec 2c             	sub    $0x2c,%esp
  46:	89 cb                	mov    %ecx,%ebx
    int i=0;
  48:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    int start = uptime();
  4f:	e8 af 04 00 00       	call   503 <uptime>
  54:	89 45 dc             	mov    %eax,-0x24(%ebp)
    int childnum = argc-2;
  57:	8b 03                	mov    (%ebx),%eax
  59:	83 e8 02             	sub    $0x2,%eax
  5c:	89 45 d8             	mov    %eax,-0x28(%ebp)

    int ptemp = uptime() + atoi(argv[1]);
  5f:	e8 9f 04 00 00       	call   503 <uptime>
  64:	89 c6                	mov    %eax,%esi
  66:	8b 43 04             	mov    0x4(%ebx),%eax
  69:	83 c0 04             	add    $0x4,%eax
  6c:	8b 00                	mov    (%eax),%eax
  6e:	83 ec 0c             	sub    $0xc,%esp
  71:	50                   	push   %eax
  72:	e8 11 03 00 00       	call   388 <atoi>
  77:	83 c4 10             	add    $0x10,%esp
  7a:	01 f0                	add    %esi,%eax
  7c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    counter(ptemp);
  7f:	83 ec 0c             	sub    $0xc,%esp
  82:	ff 75 d4             	pushl  -0x2c(%ebp)
  85:	e8 76 ff ff ff       	call   0 <counter>
  8a:	83 c4 10             	add    $0x10,%esp
    //setdeadline(ptemp);

    int pid;
    for(i=0; i< childnum; i++){
  8d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  94:	e9 b9 00 00 00       	jmp    152 <main+0x11f>
        pid = fork();
  99:	e8 c5 03 00 00       	call   463 <fork>
  9e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        
        if(pid == 0){
  a1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  a5:	75 6f                	jne    116 <main+0xe3>
            int temp = uptime()+atoi(argv[i+2]);
  a7:	e8 57 04 00 00       	call   503 <uptime>
  ac:	89 c6                	mov    %eax,%esi
  ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  b1:	83 c0 02             	add    $0x2,%eax
  b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  bb:	8b 43 04             	mov    0x4(%ebx),%eax
  be:	01 d0                	add    %edx,%eax
  c0:	8b 00                	mov    (%eax),%eax
  c2:	83 ec 0c             	sub    $0xc,%esp
  c5:	50                   	push   %eax
  c6:	e8 bd 02 00 00       	call   388 <atoi>
  cb:	83 c4 10             	add    $0x10,%esp
  ce:	01 f0                	add    %esi,%eax
  d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
            //setdeadline(temp);
            printf(1,"--------Child %d: Deadline: %d\n", getpid(), temp);
  d3:	e8 13 04 00 00       	call   4eb <getpid>
  d8:	ff 75 d0             	pushl  -0x30(%ebp)
  db:	50                   	push   %eax
  dc:	68 b0 09 00 00       	push   $0x9b0
  e1:	6a 01                	push   $0x1
  e3:	e8 12 05 00 00       	call   5fa <printf>
  e8:	83 c4 10             	add    $0x10,%esp
            counter(temp);
  eb:	83 ec 0c             	sub    $0xc,%esp
  ee:	ff 75 d0             	pushl  -0x30(%ebp)
  f1:	e8 0a ff ff ff       	call   0 <counter>
  f6:	83 c4 10             	add    $0x10,%esp
            printf(1,"--------Child %d: Exit\n", getpid());
  f9:	e8 ed 03 00 00       	call   4eb <getpid>
  fe:	83 ec 04             	sub    $0x4,%esp
 101:	50                   	push   %eax
 102:	68 d0 09 00 00       	push   $0x9d0
 107:	6a 01                	push   $0x1
 109:	e8 ec 04 00 00       	call   5fa <printf>
 10e:	83 c4 10             	add    $0x10,%esp
            exit();
 111:	e8 55 03 00 00       	call   46b <exit>
        }

        else if(pid > 0){
 116:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
 11a:	7e 1a                	jle    136 <main+0x103>
            printf(1,"-----Parent: %d deadline: %d \n", getpid(), ptemp);
 11c:	e8 ca 03 00 00       	call   4eb <getpid>
 121:	ff 75 d4             	pushl  -0x2c(%ebp)
 124:	50                   	push   %eax
 125:	68 e8 09 00 00       	push   $0x9e8
 12a:	6a 01                	push   $0x1
 12c:	e8 c9 04 00 00       	call   5fa <printf>
 131:	83 c4 10             	add    $0x10,%esp
 134:	eb 18                	jmp    14e <main+0x11b>
        }

        else if(pid < 0){
 136:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
 13a:	79 12                	jns    14e <main+0x11b>
            printf(1,"Error in forking");
 13c:	83 ec 08             	sub    $0x8,%esp
 13f:	68 07 0a 00 00       	push   $0xa07
 144:	6a 01                	push   $0x1
 146:	e8 af 04 00 00       	call   5fa <printf>
 14b:	83 c4 10             	add    $0x10,%esp
    int ptemp = uptime() + atoi(argv[1]);
    counter(ptemp);
    //setdeadline(ptemp);

    int pid;
    for(i=0; i< childnum; i++){
 14e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 152:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 155:	3b 45 d8             	cmp    -0x28(%ebp),%eax
 158:	0f 8c 3b ff ff ff    	jl     99 <main+0x66>

        else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
 15e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
 162:	7e 2d                	jle    191 <main+0x15e>
        for(i=0; i< childnum; i++)
 164:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 16b:	eb 1c                	jmp    189 <main+0x156>
            printf(1,"Parent: Child %d exited \n", wait());
 16d:	e8 01 03 00 00       	call   473 <wait>
 172:	83 ec 04             	sub    $0x4,%esp
 175:	50                   	push   %eax
 176:	68 18 0a 00 00       	push   $0xa18
 17b:	6a 01                	push   $0x1
 17d:	e8 78 04 00 00       	call   5fa <printf>
 182:	83 c4 10             	add    $0x10,%esp
        else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
        for(i=0; i< childnum; i++)
 185:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 189:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 18c:	3b 45 d8             	cmp    -0x28(%ebp),%eax
 18f:	7c dc                	jl     16d <main+0x13a>
            printf(1,"Parent: Child %d exited \n", wait());
    }
    printf(1,"Parent: Exiting\n");
 191:	83 ec 08             	sub    $0x8,%esp
 194:	68 32 0a 00 00       	push   $0xa32
 199:	6a 01                	push   $0x1
 19b:	e8 5a 04 00 00       	call   5fa <printf>
 1a0:	83 c4 10             	add    $0x10,%esp
    printf(1,"%d \n",uptime() - start);
 1a3:	e8 5b 03 00 00       	call   503 <uptime>
 1a8:	2b 45 dc             	sub    -0x24(%ebp),%eax
 1ab:	83 ec 04             	sub    $0x4,%esp
 1ae:	50                   	push   %eax
 1af:	68 43 0a 00 00       	push   $0xa43
 1b4:	6a 01                	push   $0x1
 1b6:	e8 3f 04 00 00       	call   5fa <printf>
 1bb:	83 c4 10             	add    $0x10,%esp
    exit();
 1be:	e8 a8 02 00 00       	call   46b <exit>

000001c3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1c3:	55                   	push   %ebp
 1c4:	89 e5                	mov    %esp,%ebp
 1c6:	57                   	push   %edi
 1c7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1c8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1cb:	8b 55 10             	mov    0x10(%ebp),%edx
 1ce:	8b 45 0c             	mov    0xc(%ebp),%eax
 1d1:	89 cb                	mov    %ecx,%ebx
 1d3:	89 df                	mov    %ebx,%edi
 1d5:	89 d1                	mov    %edx,%ecx
 1d7:	fc                   	cld    
 1d8:	f3 aa                	rep stos %al,%es:(%edi)
 1da:	89 ca                	mov    %ecx,%edx
 1dc:	89 fb                	mov    %edi,%ebx
 1de:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1e1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1e4:	90                   	nop
 1e5:	5b                   	pop    %ebx
 1e6:	5f                   	pop    %edi
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    

000001e9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1e9:	55                   	push   %ebp
 1ea:	89 e5                	mov    %esp,%ebp
 1ec:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1ef:	8b 45 08             	mov    0x8(%ebp),%eax
 1f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1f5:	90                   	nop
 1f6:	8b 45 08             	mov    0x8(%ebp),%eax
 1f9:	8d 50 01             	lea    0x1(%eax),%edx
 1fc:	89 55 08             	mov    %edx,0x8(%ebp)
 1ff:	8b 55 0c             	mov    0xc(%ebp),%edx
 202:	8d 4a 01             	lea    0x1(%edx),%ecx
 205:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 208:	0f b6 12             	movzbl (%edx),%edx
 20b:	88 10                	mov    %dl,(%eax)
 20d:	0f b6 00             	movzbl (%eax),%eax
 210:	84 c0                	test   %al,%al
 212:	75 e2                	jne    1f6 <strcpy+0xd>
    ;
  return os;
 214:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 217:	c9                   	leave  
 218:	c3                   	ret    

00000219 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 219:	55                   	push   %ebp
 21a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 21c:	eb 08                	jmp    226 <strcmp+0xd>
    p++, q++;
 21e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 222:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 226:	8b 45 08             	mov    0x8(%ebp),%eax
 229:	0f b6 00             	movzbl (%eax),%eax
 22c:	84 c0                	test   %al,%al
 22e:	74 10                	je     240 <strcmp+0x27>
 230:	8b 45 08             	mov    0x8(%ebp),%eax
 233:	0f b6 10             	movzbl (%eax),%edx
 236:	8b 45 0c             	mov    0xc(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	38 c2                	cmp    %al,%dl
 23e:	74 de                	je     21e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	0f b6 00             	movzbl (%eax),%eax
 246:	0f b6 d0             	movzbl %al,%edx
 249:	8b 45 0c             	mov    0xc(%ebp),%eax
 24c:	0f b6 00             	movzbl (%eax),%eax
 24f:	0f b6 c0             	movzbl %al,%eax
 252:	29 c2                	sub    %eax,%edx
 254:	89 d0                	mov    %edx,%eax
}
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    

00000258 <strlen>:

uint
strlen(char *s)
{
 258:	55                   	push   %ebp
 259:	89 e5                	mov    %esp,%ebp
 25b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 25e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 265:	eb 04                	jmp    26b <strlen+0x13>
 267:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 26b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	01 d0                	add    %edx,%eax
 273:	0f b6 00             	movzbl (%eax),%eax
 276:	84 c0                	test   %al,%al
 278:	75 ed                	jne    267 <strlen+0xf>
    ;
  return n;
 27a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 27d:	c9                   	leave  
 27e:	c3                   	ret    

0000027f <memset>:

void*
memset(void *dst, int c, uint n)
{
 27f:	55                   	push   %ebp
 280:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 282:	8b 45 10             	mov    0x10(%ebp),%eax
 285:	50                   	push   %eax
 286:	ff 75 0c             	pushl  0xc(%ebp)
 289:	ff 75 08             	pushl  0x8(%ebp)
 28c:	e8 32 ff ff ff       	call   1c3 <stosb>
 291:	83 c4 0c             	add    $0xc,%esp
  return dst;
 294:	8b 45 08             	mov    0x8(%ebp),%eax
}
 297:	c9                   	leave  
 298:	c3                   	ret    

00000299 <strchr>:

char*
strchr(const char *s, char c)
{
 299:	55                   	push   %ebp
 29a:	89 e5                	mov    %esp,%ebp
 29c:	83 ec 04             	sub    $0x4,%esp
 29f:	8b 45 0c             	mov    0xc(%ebp),%eax
 2a2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2a5:	eb 14                	jmp    2bb <strchr+0x22>
    if(*s == c)
 2a7:	8b 45 08             	mov    0x8(%ebp),%eax
 2aa:	0f b6 00             	movzbl (%eax),%eax
 2ad:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2b0:	75 05                	jne    2b7 <strchr+0x1e>
      return (char*)s;
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
 2b5:	eb 13                	jmp    2ca <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2b7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
 2be:	0f b6 00             	movzbl (%eax),%eax
 2c1:	84 c0                	test   %al,%al
 2c3:	75 e2                	jne    2a7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2c5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2ca:	c9                   	leave  
 2cb:	c3                   	ret    

000002cc <gets>:

char*
gets(char *buf, int max)
{
 2cc:	55                   	push   %ebp
 2cd:	89 e5                	mov    %esp,%ebp
 2cf:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2d2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d9:	eb 42                	jmp    31d <gets+0x51>
    cc = read(0, &c, 1);
 2db:	83 ec 04             	sub    $0x4,%esp
 2de:	6a 01                	push   $0x1
 2e0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2e3:	50                   	push   %eax
 2e4:	6a 00                	push   $0x0
 2e6:	e8 98 01 00 00       	call   483 <read>
 2eb:	83 c4 10             	add    $0x10,%esp
 2ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2f5:	7e 33                	jle    32a <gets+0x5e>
      break;
    buf[i++] = c;
 2f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2fa:	8d 50 01             	lea    0x1(%eax),%edx
 2fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 300:	89 c2                	mov    %eax,%edx
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	01 c2                	add    %eax,%edx
 307:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 30d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 311:	3c 0a                	cmp    $0xa,%al
 313:	74 16                	je     32b <gets+0x5f>
 315:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 319:	3c 0d                	cmp    $0xd,%al
 31b:	74 0e                	je     32b <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 320:	83 c0 01             	add    $0x1,%eax
 323:	3b 45 0c             	cmp    0xc(%ebp),%eax
 326:	7c b3                	jl     2db <gets+0xf>
 328:	eb 01                	jmp    32b <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 32a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 32b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	01 d0                	add    %edx,%eax
 333:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 336:	8b 45 08             	mov    0x8(%ebp),%eax
}
 339:	c9                   	leave  
 33a:	c3                   	ret    

0000033b <stat>:

int
stat(char *n, struct stat *st)
{
 33b:	55                   	push   %ebp
 33c:	89 e5                	mov    %esp,%ebp
 33e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 341:	83 ec 08             	sub    $0x8,%esp
 344:	6a 00                	push   $0x0
 346:	ff 75 08             	pushl  0x8(%ebp)
 349:	e8 5d 01 00 00       	call   4ab <open>
 34e:	83 c4 10             	add    $0x10,%esp
 351:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 354:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 358:	79 07                	jns    361 <stat+0x26>
    return -1;
 35a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 35f:	eb 25                	jmp    386 <stat+0x4b>
  r = fstat(fd, st);
 361:	83 ec 08             	sub    $0x8,%esp
 364:	ff 75 0c             	pushl  0xc(%ebp)
 367:	ff 75 f4             	pushl  -0xc(%ebp)
 36a:	e8 54 01 00 00       	call   4c3 <fstat>
 36f:	83 c4 10             	add    $0x10,%esp
 372:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 375:	83 ec 0c             	sub    $0xc,%esp
 378:	ff 75 f4             	pushl  -0xc(%ebp)
 37b:	e8 13 01 00 00       	call   493 <close>
 380:	83 c4 10             	add    $0x10,%esp
  return r;
 383:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 386:	c9                   	leave  
 387:	c3                   	ret    

00000388 <atoi>:

int
atoi(const char *s)
{
 388:	55                   	push   %ebp
 389:	89 e5                	mov    %esp,%ebp
 38b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 38e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 395:	eb 25                	jmp    3bc <atoi+0x34>
    n = n*10 + *s++ - '0';
 397:	8b 55 fc             	mov    -0x4(%ebp),%edx
 39a:	89 d0                	mov    %edx,%eax
 39c:	c1 e0 02             	shl    $0x2,%eax
 39f:	01 d0                	add    %edx,%eax
 3a1:	01 c0                	add    %eax,%eax
 3a3:	89 c1                	mov    %eax,%ecx
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
 3a8:	8d 50 01             	lea    0x1(%eax),%edx
 3ab:	89 55 08             	mov    %edx,0x8(%ebp)
 3ae:	0f b6 00             	movzbl (%eax),%eax
 3b1:	0f be c0             	movsbl %al,%eax
 3b4:	01 c8                	add    %ecx,%eax
 3b6:	83 e8 30             	sub    $0x30,%eax
 3b9:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	0f b6 00             	movzbl (%eax),%eax
 3c2:	3c 2f                	cmp    $0x2f,%al
 3c4:	7e 0a                	jle    3d0 <atoi+0x48>
 3c6:	8b 45 08             	mov    0x8(%ebp),%eax
 3c9:	0f b6 00             	movzbl (%eax),%eax
 3cc:	3c 39                	cmp    $0x39,%al
 3ce:	7e c7                	jle    397 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3d3:	c9                   	leave  
 3d4:	c3                   	ret    

000003d5 <itoa>:

char*
itoa(int val, int base){
 3d5:	55                   	push   %ebp
 3d6:	89 e5                	mov    %esp,%ebp
 3d8:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 3db:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 3e2:	eb 29                	jmp    40d <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 3e4:	8b 45 08             	mov    0x8(%ebp),%eax
 3e7:	99                   	cltd   
 3e8:	f7 7d 0c             	idivl  0xc(%ebp)
 3eb:	89 d0                	mov    %edx,%eax
 3ed:	0f b6 80 48 0a 00 00 	movzbl 0xa48(%eax),%eax
 3f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3f7:	81 c2 20 0d 00 00    	add    $0xd20,%edx
 3fd:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 3ff:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 403:	8b 45 08             	mov    0x8(%ebp),%eax
 406:	99                   	cltd   
 407:	f7 7d 0c             	idivl  0xc(%ebp)
 40a:	89 45 08             	mov    %eax,0x8(%ebp)
 40d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 411:	74 06                	je     419 <itoa+0x44>
 413:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 417:	75 cb                	jne    3e4 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 419:	8b 45 fc             	mov    -0x4(%ebp),%eax
 41c:	83 c0 01             	add    $0x1,%eax
 41f:	05 20 0d 00 00       	add    $0xd20,%eax

}
 424:	c9                   	leave  
 425:	c3                   	ret    

00000426 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 426:	55                   	push   %ebp
 427:	89 e5                	mov    %esp,%ebp
 429:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 42c:	8b 45 08             	mov    0x8(%ebp),%eax
 42f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 432:	8b 45 0c             	mov    0xc(%ebp),%eax
 435:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 438:	eb 17                	jmp    451 <memmove+0x2b>
    *dst++ = *src++;
 43a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 43d:	8d 50 01             	lea    0x1(%eax),%edx
 440:	89 55 fc             	mov    %edx,-0x4(%ebp)
 443:	8b 55 f8             	mov    -0x8(%ebp),%edx
 446:	8d 4a 01             	lea    0x1(%edx),%ecx
 449:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 44c:	0f b6 12             	movzbl (%edx),%edx
 44f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 451:	8b 45 10             	mov    0x10(%ebp),%eax
 454:	8d 50 ff             	lea    -0x1(%eax),%edx
 457:	89 55 10             	mov    %edx,0x10(%ebp)
 45a:	85 c0                	test   %eax,%eax
 45c:	7f dc                	jg     43a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 45e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 461:	c9                   	leave  
 462:	c3                   	ret    

00000463 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 463:	b8 01 00 00 00       	mov    $0x1,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <exit>:
SYSCALL(exit)
 46b:	b8 02 00 00 00       	mov    $0x2,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <wait>:
SYSCALL(wait)
 473:	b8 03 00 00 00       	mov    $0x3,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <pipe>:
SYSCALL(pipe)
 47b:	b8 04 00 00 00       	mov    $0x4,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <read>:
SYSCALL(read)
 483:	b8 05 00 00 00       	mov    $0x5,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <write>:
SYSCALL(write)
 48b:	b8 10 00 00 00       	mov    $0x10,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <close>:
SYSCALL(close)
 493:	b8 15 00 00 00       	mov    $0x15,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <kill>:
SYSCALL(kill)
 49b:	b8 06 00 00 00       	mov    $0x6,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <exec>:
SYSCALL(exec)
 4a3:	b8 07 00 00 00       	mov    $0x7,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <open>:
SYSCALL(open)
 4ab:	b8 0f 00 00 00       	mov    $0xf,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <mknod>:
SYSCALL(mknod)
 4b3:	b8 11 00 00 00       	mov    $0x11,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <unlink>:
SYSCALL(unlink)
 4bb:	b8 12 00 00 00       	mov    $0x12,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <fstat>:
SYSCALL(fstat)
 4c3:	b8 08 00 00 00       	mov    $0x8,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <link>:
SYSCALL(link)
 4cb:	b8 13 00 00 00       	mov    $0x13,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <mkdir>:
SYSCALL(mkdir)
 4d3:	b8 14 00 00 00       	mov    $0x14,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <chdir>:
SYSCALL(chdir)
 4db:	b8 09 00 00 00       	mov    $0x9,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <dup>:
SYSCALL(dup)
 4e3:	b8 0a 00 00 00       	mov    $0xa,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <getpid>:
SYSCALL(getpid)
 4eb:	b8 0b 00 00 00       	mov    $0xb,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <sbrk>:
SYSCALL(sbrk)
 4f3:	b8 0c 00 00 00       	mov    $0xc,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <sleep>:
SYSCALL(sleep)
 4fb:	b8 0d 00 00 00       	mov    $0xd,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <uptime>:
SYSCALL(uptime)
 503:	b8 0e 00 00 00       	mov    $0xe,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <randomX>:
SYSCALL(randomX)
 50b:	b8 16 00 00 00       	mov    $0x16,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <setSeedX>:
SYSCALL(setSeedX)
 513:	b8 17 00 00 00       	mov    $0x17,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <uniformR>:
SYSCALL(uniformR)
 51b:	b8 18 00 00 00       	mov    $0x18,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 523:	55                   	push   %ebp
 524:	89 e5                	mov    %esp,%ebp
 526:	83 ec 18             	sub    $0x18,%esp
 529:	8b 45 0c             	mov    0xc(%ebp),%eax
 52c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 52f:	83 ec 04             	sub    $0x4,%esp
 532:	6a 01                	push   $0x1
 534:	8d 45 f4             	lea    -0xc(%ebp),%eax
 537:	50                   	push   %eax
 538:	ff 75 08             	pushl  0x8(%ebp)
 53b:	e8 4b ff ff ff       	call   48b <write>
 540:	83 c4 10             	add    $0x10,%esp
}
 543:	90                   	nop
 544:	c9                   	leave  
 545:	c3                   	ret    

00000546 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 546:	55                   	push   %ebp
 547:	89 e5                	mov    %esp,%ebp
 549:	53                   	push   %ebx
 54a:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 54d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 554:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 558:	74 17                	je     571 <printint+0x2b>
 55a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 55e:	79 11                	jns    571 <printint+0x2b>
    neg = 1;
 560:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 567:	8b 45 0c             	mov    0xc(%ebp),%eax
 56a:	f7 d8                	neg    %eax
 56c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 56f:	eb 06                	jmp    577 <printint+0x31>
  } else {
    x = xx;
 571:	8b 45 0c             	mov    0xc(%ebp),%eax
 574:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 577:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 57e:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 581:	8d 41 01             	lea    0x1(%ecx),%eax
 584:	89 45 f4             	mov    %eax,-0xc(%ebp)
 587:	8b 5d 10             	mov    0x10(%ebp),%ebx
 58a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 58d:	ba 00 00 00 00       	mov    $0x0,%edx
 592:	f7 f3                	div    %ebx
 594:	89 d0                	mov    %edx,%eax
 596:	0f b6 80 f0 0c 00 00 	movzbl 0xcf0(%eax),%eax
 59d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 5a1:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a7:	ba 00 00 00 00       	mov    $0x0,%edx
 5ac:	f7 f3                	div    %ebx
 5ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5b1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b5:	75 c7                	jne    57e <printint+0x38>
  if(neg)
 5b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5bb:	74 2d                	je     5ea <printint+0xa4>
    buf[i++] = '-';
 5bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c0:	8d 50 01             	lea    0x1(%eax),%edx
 5c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c6:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5cb:	eb 1d                	jmp    5ea <printint+0xa4>
    putc(fd, buf[i]);
 5cd:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d3:	01 d0                	add    %edx,%eax
 5d5:	0f b6 00             	movzbl (%eax),%eax
 5d8:	0f be c0             	movsbl %al,%eax
 5db:	83 ec 08             	sub    $0x8,%esp
 5de:	50                   	push   %eax
 5df:	ff 75 08             	pushl  0x8(%ebp)
 5e2:	e8 3c ff ff ff       	call   523 <putc>
 5e7:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5ea:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5f2:	79 d9                	jns    5cd <printint+0x87>
    putc(fd, buf[i]);
}
 5f4:	90                   	nop
 5f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 5f8:	c9                   	leave  
 5f9:	c3                   	ret    

000005fa <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5fa:	55                   	push   %ebp
 5fb:	89 e5                	mov    %esp,%ebp
 5fd:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 600:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 607:	8d 45 0c             	lea    0xc(%ebp),%eax
 60a:	83 c0 04             	add    $0x4,%eax
 60d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 610:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 617:	e9 59 01 00 00       	jmp    775 <printf+0x17b>
    c = fmt[i] & 0xff;
 61c:	8b 55 0c             	mov    0xc(%ebp),%edx
 61f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 622:	01 d0                	add    %edx,%eax
 624:	0f b6 00             	movzbl (%eax),%eax
 627:	0f be c0             	movsbl %al,%eax
 62a:	25 ff 00 00 00       	and    $0xff,%eax
 62f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 632:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 636:	75 2c                	jne    664 <printf+0x6a>
      if(c == '%'){
 638:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 63c:	75 0c                	jne    64a <printf+0x50>
        state = '%';
 63e:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 645:	e9 27 01 00 00       	jmp    771 <printf+0x177>
      } else {
        putc(fd, c);
 64a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 64d:	0f be c0             	movsbl %al,%eax
 650:	83 ec 08             	sub    $0x8,%esp
 653:	50                   	push   %eax
 654:	ff 75 08             	pushl  0x8(%ebp)
 657:	e8 c7 fe ff ff       	call   523 <putc>
 65c:	83 c4 10             	add    $0x10,%esp
 65f:	e9 0d 01 00 00       	jmp    771 <printf+0x177>
      }
    } else if(state == '%'){
 664:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 668:	0f 85 03 01 00 00    	jne    771 <printf+0x177>
      if(c == 'd'){
 66e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 672:	75 1e                	jne    692 <printf+0x98>
        printint(fd, *ap, 10, 1);
 674:	8b 45 e8             	mov    -0x18(%ebp),%eax
 677:	8b 00                	mov    (%eax),%eax
 679:	6a 01                	push   $0x1
 67b:	6a 0a                	push   $0xa
 67d:	50                   	push   %eax
 67e:	ff 75 08             	pushl  0x8(%ebp)
 681:	e8 c0 fe ff ff       	call   546 <printint>
 686:	83 c4 10             	add    $0x10,%esp
        ap++;
 689:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68d:	e9 d8 00 00 00       	jmp    76a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 692:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 696:	74 06                	je     69e <printf+0xa4>
 698:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 69c:	75 1e                	jne    6bc <printf+0xc2>
        printint(fd, *ap, 16, 0);
 69e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6a1:	8b 00                	mov    (%eax),%eax
 6a3:	6a 00                	push   $0x0
 6a5:	6a 10                	push   $0x10
 6a7:	50                   	push   %eax
 6a8:	ff 75 08             	pushl  0x8(%ebp)
 6ab:	e8 96 fe ff ff       	call   546 <printint>
 6b0:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b7:	e9 ae 00 00 00       	jmp    76a <printf+0x170>
      } else if(c == 's'){
 6bc:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6c0:	75 43                	jne    705 <printf+0x10b>
        s = (char*)*ap;
 6c2:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6c5:	8b 00                	mov    (%eax),%eax
 6c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6ca:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6ce:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6d2:	75 25                	jne    6f9 <printf+0xff>
          s = "(null)";
 6d4:	c7 45 f4 59 0a 00 00 	movl   $0xa59,-0xc(%ebp)
        while(*s != 0){
 6db:	eb 1c                	jmp    6f9 <printf+0xff>
          putc(fd, *s);
 6dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e0:	0f b6 00             	movzbl (%eax),%eax
 6e3:	0f be c0             	movsbl %al,%eax
 6e6:	83 ec 08             	sub    $0x8,%esp
 6e9:	50                   	push   %eax
 6ea:	ff 75 08             	pushl  0x8(%ebp)
 6ed:	e8 31 fe ff ff       	call   523 <putc>
 6f2:	83 c4 10             	add    $0x10,%esp
          s++;
 6f5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fc:	0f b6 00             	movzbl (%eax),%eax
 6ff:	84 c0                	test   %al,%al
 701:	75 da                	jne    6dd <printf+0xe3>
 703:	eb 65                	jmp    76a <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 705:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 709:	75 1d                	jne    728 <printf+0x12e>
        putc(fd, *ap);
 70b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 70e:	8b 00                	mov    (%eax),%eax
 710:	0f be c0             	movsbl %al,%eax
 713:	83 ec 08             	sub    $0x8,%esp
 716:	50                   	push   %eax
 717:	ff 75 08             	pushl  0x8(%ebp)
 71a:	e8 04 fe ff ff       	call   523 <putc>
 71f:	83 c4 10             	add    $0x10,%esp
        ap++;
 722:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 726:	eb 42                	jmp    76a <printf+0x170>
      } else if(c == '%'){
 728:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 72c:	75 17                	jne    745 <printf+0x14b>
        putc(fd, c);
 72e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 731:	0f be c0             	movsbl %al,%eax
 734:	83 ec 08             	sub    $0x8,%esp
 737:	50                   	push   %eax
 738:	ff 75 08             	pushl  0x8(%ebp)
 73b:	e8 e3 fd ff ff       	call   523 <putc>
 740:	83 c4 10             	add    $0x10,%esp
 743:	eb 25                	jmp    76a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 745:	83 ec 08             	sub    $0x8,%esp
 748:	6a 25                	push   $0x25
 74a:	ff 75 08             	pushl  0x8(%ebp)
 74d:	e8 d1 fd ff ff       	call   523 <putc>
 752:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 755:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 758:	0f be c0             	movsbl %al,%eax
 75b:	83 ec 08             	sub    $0x8,%esp
 75e:	50                   	push   %eax
 75f:	ff 75 08             	pushl  0x8(%ebp)
 762:	e8 bc fd ff ff       	call   523 <putc>
 767:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 76a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 771:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 775:	8b 55 0c             	mov    0xc(%ebp),%edx
 778:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77b:	01 d0                	add    %edx,%eax
 77d:	0f b6 00             	movzbl (%eax),%eax
 780:	84 c0                	test   %al,%al
 782:	0f 85 94 fe ff ff    	jne    61c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 788:	90                   	nop
 789:	c9                   	leave  
 78a:	c3                   	ret    

0000078b <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 78b:	55                   	push   %ebp
 78c:	89 e5                	mov    %esp,%ebp
 78e:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 791:	8b 45 08             	mov    0x8(%ebp),%eax
 794:	83 e8 08             	sub    $0x8,%eax
 797:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 79a:	a1 48 0d 00 00       	mov    0xd48,%eax
 79f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7a2:	eb 24                	jmp    7c8 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a7:	8b 00                	mov    (%eax),%eax
 7a9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ac:	77 12                	ja     7c0 <free+0x35>
 7ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7b4:	77 24                	ja     7da <free+0x4f>
 7b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b9:	8b 00                	mov    (%eax),%eax
 7bb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7be:	77 1a                	ja     7da <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	8b 00                	mov    (%eax),%eax
 7c5:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7cb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ce:	76 d4                	jbe    7a4 <free+0x19>
 7d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d3:	8b 00                	mov    (%eax),%eax
 7d5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d8:	76 ca                	jbe    7a4 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7da:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7dd:	8b 40 04             	mov    0x4(%eax),%eax
 7e0:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ea:	01 c2                	add    %eax,%edx
 7ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ef:	8b 00                	mov    (%eax),%eax
 7f1:	39 c2                	cmp    %eax,%edx
 7f3:	75 24                	jne    819 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f8:	8b 50 04             	mov    0x4(%eax),%edx
 7fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7fe:	8b 00                	mov    (%eax),%eax
 800:	8b 40 04             	mov    0x4(%eax),%eax
 803:	01 c2                	add    %eax,%edx
 805:	8b 45 f8             	mov    -0x8(%ebp),%eax
 808:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 80b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 80e:	8b 00                	mov    (%eax),%eax
 810:	8b 10                	mov    (%eax),%edx
 812:	8b 45 f8             	mov    -0x8(%ebp),%eax
 815:	89 10                	mov    %edx,(%eax)
 817:	eb 0a                	jmp    823 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 819:	8b 45 fc             	mov    -0x4(%ebp),%eax
 81c:	8b 10                	mov    (%eax),%edx
 81e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 821:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 823:	8b 45 fc             	mov    -0x4(%ebp),%eax
 826:	8b 40 04             	mov    0x4(%eax),%eax
 829:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 830:	8b 45 fc             	mov    -0x4(%ebp),%eax
 833:	01 d0                	add    %edx,%eax
 835:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 838:	75 20                	jne    85a <free+0xcf>
    p->s.size += bp->s.size;
 83a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83d:	8b 50 04             	mov    0x4(%eax),%edx
 840:	8b 45 f8             	mov    -0x8(%ebp),%eax
 843:	8b 40 04             	mov    0x4(%eax),%eax
 846:	01 c2                	add    %eax,%edx
 848:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84b:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 84e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 851:	8b 10                	mov    (%eax),%edx
 853:	8b 45 fc             	mov    -0x4(%ebp),%eax
 856:	89 10                	mov    %edx,(%eax)
 858:	eb 08                	jmp    862 <free+0xd7>
  } else
    p->s.ptr = bp;
 85a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85d:	8b 55 f8             	mov    -0x8(%ebp),%edx
 860:	89 10                	mov    %edx,(%eax)
  freep = p;
 862:	8b 45 fc             	mov    -0x4(%ebp),%eax
 865:	a3 48 0d 00 00       	mov    %eax,0xd48
}
 86a:	90                   	nop
 86b:	c9                   	leave  
 86c:	c3                   	ret    

0000086d <morecore>:

static Header*
morecore(uint nu)
{
 86d:	55                   	push   %ebp
 86e:	89 e5                	mov    %esp,%ebp
 870:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 873:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 87a:	77 07                	ja     883 <morecore+0x16>
    nu = 4096;
 87c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 883:	8b 45 08             	mov    0x8(%ebp),%eax
 886:	c1 e0 03             	shl    $0x3,%eax
 889:	83 ec 0c             	sub    $0xc,%esp
 88c:	50                   	push   %eax
 88d:	e8 61 fc ff ff       	call   4f3 <sbrk>
 892:	83 c4 10             	add    $0x10,%esp
 895:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 898:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 89c:	75 07                	jne    8a5 <morecore+0x38>
    return 0;
 89e:	b8 00 00 00 00       	mov    $0x0,%eax
 8a3:	eb 26                	jmp    8cb <morecore+0x5e>
  hp = (Header*)p;
 8a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ae:	8b 55 08             	mov    0x8(%ebp),%edx
 8b1:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b7:	83 c0 08             	add    $0x8,%eax
 8ba:	83 ec 0c             	sub    $0xc,%esp
 8bd:	50                   	push   %eax
 8be:	e8 c8 fe ff ff       	call   78b <free>
 8c3:	83 c4 10             	add    $0x10,%esp
  return freep;
 8c6:	a1 48 0d 00 00       	mov    0xd48,%eax
}
 8cb:	c9                   	leave  
 8cc:	c3                   	ret    

000008cd <malloc>:

void*
malloc(uint nbytes)
{
 8cd:	55                   	push   %ebp
 8ce:	89 e5                	mov    %esp,%ebp
 8d0:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8d3:	8b 45 08             	mov    0x8(%ebp),%eax
 8d6:	83 c0 07             	add    $0x7,%eax
 8d9:	c1 e8 03             	shr    $0x3,%eax
 8dc:	83 c0 01             	add    $0x1,%eax
 8df:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8e2:	a1 48 0d 00 00       	mov    0xd48,%eax
 8e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8ee:	75 23                	jne    913 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8f0:	c7 45 f0 40 0d 00 00 	movl   $0xd40,-0x10(%ebp)
 8f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8fa:	a3 48 0d 00 00       	mov    %eax,0xd48
 8ff:	a1 48 0d 00 00       	mov    0xd48,%eax
 904:	a3 40 0d 00 00       	mov    %eax,0xd40
    base.s.size = 0;
 909:	c7 05 44 0d 00 00 00 	movl   $0x0,0xd44
 910:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 913:	8b 45 f0             	mov    -0x10(%ebp),%eax
 916:	8b 00                	mov    (%eax),%eax
 918:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 91b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91e:	8b 40 04             	mov    0x4(%eax),%eax
 921:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 924:	72 4d                	jb     973 <malloc+0xa6>
      if(p->s.size == nunits)
 926:	8b 45 f4             	mov    -0xc(%ebp),%eax
 929:	8b 40 04             	mov    0x4(%eax),%eax
 92c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 92f:	75 0c                	jne    93d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 931:	8b 45 f4             	mov    -0xc(%ebp),%eax
 934:	8b 10                	mov    (%eax),%edx
 936:	8b 45 f0             	mov    -0x10(%ebp),%eax
 939:	89 10                	mov    %edx,(%eax)
 93b:	eb 26                	jmp    963 <malloc+0x96>
      else {
        p->s.size -= nunits;
 93d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 940:	8b 40 04             	mov    0x4(%eax),%eax
 943:	2b 45 ec             	sub    -0x14(%ebp),%eax
 946:	89 c2                	mov    %eax,%edx
 948:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94b:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 94e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 951:	8b 40 04             	mov    0x4(%eax),%eax
 954:	c1 e0 03             	shl    $0x3,%eax
 957:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 95a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95d:	8b 55 ec             	mov    -0x14(%ebp),%edx
 960:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 963:	8b 45 f0             	mov    -0x10(%ebp),%eax
 966:	a3 48 0d 00 00       	mov    %eax,0xd48
      return (void*)(p + 1);
 96b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 96e:	83 c0 08             	add    $0x8,%eax
 971:	eb 3b                	jmp    9ae <malloc+0xe1>
    }
    if(p == freep)
 973:	a1 48 0d 00 00       	mov    0xd48,%eax
 978:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 97b:	75 1e                	jne    99b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 97d:	83 ec 0c             	sub    $0xc,%esp
 980:	ff 75 ec             	pushl  -0x14(%ebp)
 983:	e8 e5 fe ff ff       	call   86d <morecore>
 988:	83 c4 10             	add    $0x10,%esp
 98b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 98e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 992:	75 07                	jne    99b <malloc+0xce>
        return 0;
 994:	b8 00 00 00 00       	mov    $0x0,%eax
 999:	eb 13                	jmp    9ae <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 99b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a4:	8b 00                	mov    (%eax),%eax
 9a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9a9:	e9 6d ff ff ff       	jmp    91b <malloc+0x4e>
}
 9ae:	c9                   	leave  
 9af:	c3                   	ret    
