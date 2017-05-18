
_userProg2:     file format elf32-i386


Disassembly of section .text:

00000000 <counter>:
#include "types.h"
#include "stat.h"
#include "user.h"
#define countval 3999

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
#include "user.h"
#define countval 3999

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
  4f:	e8 bf 04 00 00       	call   513 <uptime>
  54:	89 45 dc             	mov    %eax,-0x24(%ebp)
    int childnum = argc-2;
  57:	8b 03                	mov    (%ebx),%eax
  59:	83 e8 02             	sub    $0x2,%eax
  5c:	89 45 d8             	mov    %eax,-0x28(%ebp)

    int ptemp = uptime() + atoi(argv[1]);
  5f:	e8 af 04 00 00       	call   513 <uptime>
  64:	89 c6                	mov    %eax,%esi
  66:	8b 43 04             	mov    0x4(%ebx),%eax
  69:	83 c0 04             	add    $0x4,%eax
  6c:	8b 00                	mov    (%eax),%eax
  6e:	83 ec 0c             	sub    $0xc,%esp
  71:	50                   	push   %eax
  72:	e8 21 03 00 00       	call   398 <atoi>
  77:	83 c4 10             	add    $0x10,%esp
  7a:	01 f0                	add    %esi,%eax
  7c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    setdeadline(ptemp);
  7f:	83 ec 0c             	sub    $0xc,%esp
  82:	ff 75 d4             	pushl  -0x2c(%ebp)
  85:	e8 a9 04 00 00       	call   533 <setdeadline>
  8a:	83 c4 10             	add    $0x10,%esp

    int pid;
    for(i=0; i< childnum; i++){
  8d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  94:	e9 c9 00 00 00       	jmp    162 <main+0x12f>
        pid = fork();
  99:	e8 d5 03 00 00       	call   473 <fork>
  9e:	89 45 e0             	mov    %eax,-0x20(%ebp)
        
        if(pid == 0){
  a1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  a5:	75 7f                	jne    126 <main+0xf3>
            int temp = uptime()+atoi(argv[i+2]);
  a7:	e8 67 04 00 00       	call   513 <uptime>
  ac:	89 c6                	mov    %eax,%esi
  ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  b1:	83 c0 02             	add    $0x2,%eax
  b4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  bb:	8b 43 04             	mov    0x4(%ebx),%eax
  be:	01 d0                	add    %edx,%eax
  c0:	8b 00                	mov    (%eax),%eax
  c2:	83 ec 0c             	sub    $0xc,%esp
  c5:	50                   	push   %eax
  c6:	e8 cd 02 00 00       	call   398 <atoi>
  cb:	83 c4 10             	add    $0x10,%esp
  ce:	01 f0                	add    %esi,%eax
  d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
            setdeadline(temp);
  d3:	83 ec 0c             	sub    $0xc,%esp
  d6:	ff 75 d0             	pushl  -0x30(%ebp)
  d9:	e8 55 04 00 00       	call   533 <setdeadline>
  de:	83 c4 10             	add    $0x10,%esp
            printf(1,"--------Child %d: Deadline: %d\n", getpid(), temp);
  e1:	e8 15 04 00 00       	call   4fb <getpid>
  e6:	ff 75 d0             	pushl  -0x30(%ebp)
  e9:	50                   	push   %eax
  ea:	68 c8 09 00 00       	push   $0x9c8
  ef:	6a 01                	push   $0x1
  f1:	e8 1c 05 00 00       	call   612 <printf>
  f6:	83 c4 10             	add    $0x10,%esp
            counter(countval);
  f9:	83 ec 0c             	sub    $0xc,%esp
  fc:	68 9f 0f 00 00       	push   $0xf9f
 101:	e8 fa fe ff ff       	call   0 <counter>
 106:	83 c4 10             	add    $0x10,%esp
            printf(1,"--------Child %d: Exit\n", getpid());
 109:	e8 ed 03 00 00       	call   4fb <getpid>
 10e:	83 ec 04             	sub    $0x4,%esp
 111:	50                   	push   %eax
 112:	68 e8 09 00 00       	push   $0x9e8
 117:	6a 01                	push   $0x1
 119:	e8 f4 04 00 00       	call   612 <printf>
 11e:	83 c4 10             	add    $0x10,%esp
            exit();
 121:	e8 55 03 00 00       	call   47b <exit>
        }

        else if(pid > 0){
 126:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
 12a:	7e 1a                	jle    146 <main+0x113>
            printf(1,"-----Parent: %d deadline: %d \n", getpid(), ptemp);
 12c:	e8 ca 03 00 00       	call   4fb <getpid>
 131:	ff 75 d4             	pushl  -0x2c(%ebp)
 134:	50                   	push   %eax
 135:	68 00 0a 00 00       	push   $0xa00
 13a:	6a 01                	push   $0x1
 13c:	e8 d1 04 00 00       	call   612 <printf>
 141:	83 c4 10             	add    $0x10,%esp
 144:	eb 18                	jmp    15e <main+0x12b>
        }

        else if(pid < 0){
 146:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
 14a:	79 12                	jns    15e <main+0x12b>
            printf(1,"Error in forking");
 14c:	83 ec 08             	sub    $0x8,%esp
 14f:	68 1f 0a 00 00       	push   $0xa1f
 154:	6a 01                	push   $0x1
 156:	e8 b7 04 00 00       	call   612 <printf>
 15b:	83 c4 10             	add    $0x10,%esp

    int ptemp = uptime() + atoi(argv[1]);
    setdeadline(ptemp);

    int pid;
    for(i=0; i< childnum; i++){
 15e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 162:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 165:	3b 45 d8             	cmp    -0x28(%ebp),%eax
 168:	0f 8c 2b ff ff ff    	jl     99 <main+0x66>

        else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
 16e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
 172:	7e 2d                	jle    1a1 <main+0x16e>
        for(i=0; i< childnum; i++)
 174:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 17b:	eb 1c                	jmp    199 <main+0x166>
            printf(1,"Parent: Child %d exited \n", wait());
 17d:	e8 01 03 00 00       	call   483 <wait>
 182:	83 ec 04             	sub    $0x4,%esp
 185:	50                   	push   %eax
 186:	68 30 0a 00 00       	push   $0xa30
 18b:	6a 01                	push   $0x1
 18d:	e8 80 04 00 00       	call   612 <printf>
 192:	83 c4 10             	add    $0x10,%esp
        else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
        for(i=0; i< childnum; i++)
 195:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
 199:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 19c:	3b 45 d8             	cmp    -0x28(%ebp),%eax
 19f:	7c dc                	jl     17d <main+0x14a>
            printf(1,"Parent: Child %d exited \n", wait());
    }
    printf(1,"Parent: Exiting\n");
 1a1:	83 ec 08             	sub    $0x8,%esp
 1a4:	68 4a 0a 00 00       	push   $0xa4a
 1a9:	6a 01                	push   $0x1
 1ab:	e8 62 04 00 00       	call   612 <printf>
 1b0:	83 c4 10             	add    $0x10,%esp
    printf(1,"%d \n",uptime() - start);
 1b3:	e8 5b 03 00 00       	call   513 <uptime>
 1b8:	2b 45 dc             	sub    -0x24(%ebp),%eax
 1bb:	83 ec 04             	sub    $0x4,%esp
 1be:	50                   	push   %eax
 1bf:	68 5b 0a 00 00       	push   $0xa5b
 1c4:	6a 01                	push   $0x1
 1c6:	e8 47 04 00 00       	call   612 <printf>
 1cb:	83 c4 10             	add    $0x10,%esp
    exit();
 1ce:	e8 a8 02 00 00       	call   47b <exit>

000001d3 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1d3:	55                   	push   %ebp
 1d4:	89 e5                	mov    %esp,%ebp
 1d6:	57                   	push   %edi
 1d7:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1db:	8b 55 10             	mov    0x10(%ebp),%edx
 1de:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e1:	89 cb                	mov    %ecx,%ebx
 1e3:	89 df                	mov    %ebx,%edi
 1e5:	89 d1                	mov    %edx,%ecx
 1e7:	fc                   	cld    
 1e8:	f3 aa                	rep stos %al,%es:(%edi)
 1ea:	89 ca                	mov    %ecx,%edx
 1ec:	89 fb                	mov    %edi,%ebx
 1ee:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1f1:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1f4:	90                   	nop
 1f5:	5b                   	pop    %ebx
 1f6:	5f                   	pop    %edi
 1f7:	5d                   	pop    %ebp
 1f8:	c3                   	ret    

000001f9 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 1f9:	55                   	push   %ebp
 1fa:	89 e5                	mov    %esp,%ebp
 1fc:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
 202:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 205:	90                   	nop
 206:	8b 45 08             	mov    0x8(%ebp),%eax
 209:	8d 50 01             	lea    0x1(%eax),%edx
 20c:	89 55 08             	mov    %edx,0x8(%ebp)
 20f:	8b 55 0c             	mov    0xc(%ebp),%edx
 212:	8d 4a 01             	lea    0x1(%edx),%ecx
 215:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 218:	0f b6 12             	movzbl (%edx),%edx
 21b:	88 10                	mov    %dl,(%eax)
 21d:	0f b6 00             	movzbl (%eax),%eax
 220:	84 c0                	test   %al,%al
 222:	75 e2                	jne    206 <strcpy+0xd>
    ;
  return os;
 224:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 227:	c9                   	leave  
 228:	c3                   	ret    

00000229 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 229:	55                   	push   %ebp
 22a:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 22c:	eb 08                	jmp    236 <strcmp+0xd>
    p++, q++;
 22e:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 232:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 236:	8b 45 08             	mov    0x8(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	84 c0                	test   %al,%al
 23e:	74 10                	je     250 <strcmp+0x27>
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	0f b6 10             	movzbl (%eax),%edx
 246:	8b 45 0c             	mov    0xc(%ebp),%eax
 249:	0f b6 00             	movzbl (%eax),%eax
 24c:	38 c2                	cmp    %al,%dl
 24e:	74 de                	je     22e <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	0f b6 00             	movzbl (%eax),%eax
 256:	0f b6 d0             	movzbl %al,%edx
 259:	8b 45 0c             	mov    0xc(%ebp),%eax
 25c:	0f b6 00             	movzbl (%eax),%eax
 25f:	0f b6 c0             	movzbl %al,%eax
 262:	29 c2                	sub    %eax,%edx
 264:	89 d0                	mov    %edx,%eax
}
 266:	5d                   	pop    %ebp
 267:	c3                   	ret    

00000268 <strlen>:

uint
strlen(char *s)
{
 268:	55                   	push   %ebp
 269:	89 e5                	mov    %esp,%ebp
 26b:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 26e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 275:	eb 04                	jmp    27b <strlen+0x13>
 277:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 27b:	8b 55 fc             	mov    -0x4(%ebp),%edx
 27e:	8b 45 08             	mov    0x8(%ebp),%eax
 281:	01 d0                	add    %edx,%eax
 283:	0f b6 00             	movzbl (%eax),%eax
 286:	84 c0                	test   %al,%al
 288:	75 ed                	jne    277 <strlen+0xf>
    ;
  return n;
 28a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 28d:	c9                   	leave  
 28e:	c3                   	ret    

0000028f <memset>:

void*
memset(void *dst, int c, uint n)
{
 28f:	55                   	push   %ebp
 290:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 292:	8b 45 10             	mov    0x10(%ebp),%eax
 295:	50                   	push   %eax
 296:	ff 75 0c             	pushl  0xc(%ebp)
 299:	ff 75 08             	pushl  0x8(%ebp)
 29c:	e8 32 ff ff ff       	call   1d3 <stosb>
 2a1:	83 c4 0c             	add    $0xc,%esp
  return dst;
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a7:	c9                   	leave  
 2a8:	c3                   	ret    

000002a9 <strchr>:

char*
strchr(const char *s, char c)
{
 2a9:	55                   	push   %ebp
 2aa:	89 e5                	mov    %esp,%ebp
 2ac:	83 ec 04             	sub    $0x4,%esp
 2af:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b2:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 2b5:	eb 14                	jmp    2cb <strchr+0x22>
    if(*s == c)
 2b7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ba:	0f b6 00             	movzbl (%eax),%eax
 2bd:	3a 45 fc             	cmp    -0x4(%ebp),%al
 2c0:	75 05                	jne    2c7 <strchr+0x1e>
      return (char*)s;
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
 2c5:	eb 13                	jmp    2da <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2c7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2cb:	8b 45 08             	mov    0x8(%ebp),%eax
 2ce:	0f b6 00             	movzbl (%eax),%eax
 2d1:	84 c0                	test   %al,%al
 2d3:	75 e2                	jne    2b7 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 2d5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2da:	c9                   	leave  
 2db:	c3                   	ret    

000002dc <gets>:

char*
gets(char *buf, int max)
{
 2dc:	55                   	push   %ebp
 2dd:	89 e5                	mov    %esp,%ebp
 2df:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2e9:	eb 42                	jmp    32d <gets+0x51>
    cc = read(0, &c, 1);
 2eb:	83 ec 04             	sub    $0x4,%esp
 2ee:	6a 01                	push   $0x1
 2f0:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2f3:	50                   	push   %eax
 2f4:	6a 00                	push   $0x0
 2f6:	e8 98 01 00 00       	call   493 <read>
 2fb:	83 c4 10             	add    $0x10,%esp
 2fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 301:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 305:	7e 33                	jle    33a <gets+0x5e>
      break;
    buf[i++] = c;
 307:	8b 45 f4             	mov    -0xc(%ebp),%eax
 30a:	8d 50 01             	lea    0x1(%eax),%edx
 30d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 310:	89 c2                	mov    %eax,%edx
 312:	8b 45 08             	mov    0x8(%ebp),%eax
 315:	01 c2                	add    %eax,%edx
 317:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 31b:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 31d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 321:	3c 0a                	cmp    $0xa,%al
 323:	74 16                	je     33b <gets+0x5f>
 325:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 329:	3c 0d                	cmp    $0xd,%al
 32b:	74 0e                	je     33b <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 32d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 330:	83 c0 01             	add    $0x1,%eax
 333:	3b 45 0c             	cmp    0xc(%ebp),%eax
 336:	7c b3                	jl     2eb <gets+0xf>
 338:	eb 01                	jmp    33b <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 33a:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 33b:	8b 55 f4             	mov    -0xc(%ebp),%edx
 33e:	8b 45 08             	mov    0x8(%ebp),%eax
 341:	01 d0                	add    %edx,%eax
 343:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 346:	8b 45 08             	mov    0x8(%ebp),%eax
}
 349:	c9                   	leave  
 34a:	c3                   	ret    

0000034b <stat>:

int
stat(char *n, struct stat *st)
{
 34b:	55                   	push   %ebp
 34c:	89 e5                	mov    %esp,%ebp
 34e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 351:	83 ec 08             	sub    $0x8,%esp
 354:	6a 00                	push   $0x0
 356:	ff 75 08             	pushl  0x8(%ebp)
 359:	e8 5d 01 00 00       	call   4bb <open>
 35e:	83 c4 10             	add    $0x10,%esp
 361:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 364:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 368:	79 07                	jns    371 <stat+0x26>
    return -1;
 36a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 36f:	eb 25                	jmp    396 <stat+0x4b>
  r = fstat(fd, st);
 371:	83 ec 08             	sub    $0x8,%esp
 374:	ff 75 0c             	pushl  0xc(%ebp)
 377:	ff 75 f4             	pushl  -0xc(%ebp)
 37a:	e8 54 01 00 00       	call   4d3 <fstat>
 37f:	83 c4 10             	add    $0x10,%esp
 382:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 385:	83 ec 0c             	sub    $0xc,%esp
 388:	ff 75 f4             	pushl  -0xc(%ebp)
 38b:	e8 13 01 00 00       	call   4a3 <close>
 390:	83 c4 10             	add    $0x10,%esp
  return r;
 393:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 396:	c9                   	leave  
 397:	c3                   	ret    

00000398 <atoi>:

int
atoi(const char *s)
{
 398:	55                   	push   %ebp
 399:	89 e5                	mov    %esp,%ebp
 39b:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 39e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3a5:	eb 25                	jmp    3cc <atoi+0x34>
    n = n*10 + *s++ - '0';
 3a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3aa:	89 d0                	mov    %edx,%eax
 3ac:	c1 e0 02             	shl    $0x2,%eax
 3af:	01 d0                	add    %edx,%eax
 3b1:	01 c0                	add    %eax,%eax
 3b3:	89 c1                	mov    %eax,%ecx
 3b5:	8b 45 08             	mov    0x8(%ebp),%eax
 3b8:	8d 50 01             	lea    0x1(%eax),%edx
 3bb:	89 55 08             	mov    %edx,0x8(%ebp)
 3be:	0f b6 00             	movzbl (%eax),%eax
 3c1:	0f be c0             	movsbl %al,%eax
 3c4:	01 c8                	add    %ecx,%eax
 3c6:	83 e8 30             	sub    $0x30,%eax
 3c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3cc:	8b 45 08             	mov    0x8(%ebp),%eax
 3cf:	0f b6 00             	movzbl (%eax),%eax
 3d2:	3c 2f                	cmp    $0x2f,%al
 3d4:	7e 0a                	jle    3e0 <atoi+0x48>
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
 3d9:	0f b6 00             	movzbl (%eax),%eax
 3dc:	3c 39                	cmp    $0x39,%al
 3de:	7e c7                	jle    3a7 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 3e0:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3e3:	c9                   	leave  
 3e4:	c3                   	ret    

000003e5 <itoa>:

char*
itoa(int val, int base){
 3e5:	55                   	push   %ebp
 3e6:	89 e5                	mov    %esp,%ebp
 3e8:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 3eb:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 3f2:	eb 29                	jmp    41d <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 3f4:	8b 45 08             	mov    0x8(%ebp),%eax
 3f7:	99                   	cltd   
 3f8:	f7 7d 0c             	idivl  0xc(%ebp)
 3fb:	89 d0                	mov    %edx,%eax
 3fd:	0f b6 80 60 0a 00 00 	movzbl 0xa60(%eax),%eax
 404:	8b 55 fc             	mov    -0x4(%ebp),%edx
 407:	81 c2 20 0d 00 00    	add    $0xd20,%edx
 40d:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 40f:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 413:	8b 45 08             	mov    0x8(%ebp),%eax
 416:	99                   	cltd   
 417:	f7 7d 0c             	idivl  0xc(%ebp)
 41a:	89 45 08             	mov    %eax,0x8(%ebp)
 41d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 421:	74 06                	je     429 <itoa+0x44>
 423:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 427:	75 cb                	jne    3f4 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 429:	8b 45 fc             	mov    -0x4(%ebp),%eax
 42c:	83 c0 01             	add    $0x1,%eax
 42f:	05 20 0d 00 00       	add    $0xd20,%eax

}
 434:	c9                   	leave  
 435:	c3                   	ret    

00000436 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 436:	55                   	push   %ebp
 437:	89 e5                	mov    %esp,%ebp
 439:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 43c:	8b 45 08             	mov    0x8(%ebp),%eax
 43f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 442:	8b 45 0c             	mov    0xc(%ebp),%eax
 445:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 448:	eb 17                	jmp    461 <memmove+0x2b>
    *dst++ = *src++;
 44a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 44d:	8d 50 01             	lea    0x1(%eax),%edx
 450:	89 55 fc             	mov    %edx,-0x4(%ebp)
 453:	8b 55 f8             	mov    -0x8(%ebp),%edx
 456:	8d 4a 01             	lea    0x1(%edx),%ecx
 459:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 45c:	0f b6 12             	movzbl (%edx),%edx
 45f:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 461:	8b 45 10             	mov    0x10(%ebp),%eax
 464:	8d 50 ff             	lea    -0x1(%eax),%edx
 467:	89 55 10             	mov    %edx,0x10(%ebp)
 46a:	85 c0                	test   %eax,%eax
 46c:	7f dc                	jg     44a <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 46e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 471:	c9                   	leave  
 472:	c3                   	ret    

00000473 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 473:	b8 01 00 00 00       	mov    $0x1,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <exit>:
SYSCALL(exit)
 47b:	b8 02 00 00 00       	mov    $0x2,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <wait>:
SYSCALL(wait)
 483:	b8 03 00 00 00       	mov    $0x3,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <pipe>:
SYSCALL(pipe)
 48b:	b8 04 00 00 00       	mov    $0x4,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <read>:
SYSCALL(read)
 493:	b8 05 00 00 00       	mov    $0x5,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <write>:
SYSCALL(write)
 49b:	b8 10 00 00 00       	mov    $0x10,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <close>:
SYSCALL(close)
 4a3:	b8 15 00 00 00       	mov    $0x15,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <kill>:
SYSCALL(kill)
 4ab:	b8 06 00 00 00       	mov    $0x6,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <exec>:
SYSCALL(exec)
 4b3:	b8 07 00 00 00       	mov    $0x7,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    

000004bb <open>:
SYSCALL(open)
 4bb:	b8 0f 00 00 00       	mov    $0xf,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret    

000004c3 <mknod>:
SYSCALL(mknod)
 4c3:	b8 11 00 00 00       	mov    $0x11,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret    

000004cb <unlink>:
SYSCALL(unlink)
 4cb:	b8 12 00 00 00       	mov    $0x12,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret    

000004d3 <fstat>:
SYSCALL(fstat)
 4d3:	b8 08 00 00 00       	mov    $0x8,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret    

000004db <link>:
SYSCALL(link)
 4db:	b8 13 00 00 00       	mov    $0x13,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret    

000004e3 <mkdir>:
SYSCALL(mkdir)
 4e3:	b8 14 00 00 00       	mov    $0x14,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret    

000004eb <chdir>:
SYSCALL(chdir)
 4eb:	b8 09 00 00 00       	mov    $0x9,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret    

000004f3 <dup>:
SYSCALL(dup)
 4f3:	b8 0a 00 00 00       	mov    $0xa,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret    

000004fb <getpid>:
SYSCALL(getpid)
 4fb:	b8 0b 00 00 00       	mov    $0xb,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret    

00000503 <sbrk>:
SYSCALL(sbrk)
 503:	b8 0c 00 00 00       	mov    $0xc,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret    

0000050b <sleep>:
SYSCALL(sleep)
 50b:	b8 0d 00 00 00       	mov    $0xd,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret    

00000513 <uptime>:
SYSCALL(uptime)
 513:	b8 0e 00 00 00       	mov    $0xe,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret    

0000051b <randomX>:
SYSCALL(randomX)
 51b:	b8 16 00 00 00       	mov    $0x16,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret    

00000523 <setSeedX>:
SYSCALL(setSeedX)
 523:	b8 17 00 00 00       	mov    $0x17,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret    

0000052b <uniformR>:
SYSCALL(uniformR)
 52b:	b8 18 00 00 00       	mov    $0x18,%eax
 530:	cd 40                	int    $0x40
 532:	c3                   	ret    

00000533 <setdeadline>:
 533:	b8 19 00 00 00       	mov    $0x19,%eax
 538:	cd 40                	int    $0x40
 53a:	c3                   	ret    

0000053b <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 53b:	55                   	push   %ebp
 53c:	89 e5                	mov    %esp,%ebp
 53e:	83 ec 18             	sub    $0x18,%esp
 541:	8b 45 0c             	mov    0xc(%ebp),%eax
 544:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 547:	83 ec 04             	sub    $0x4,%esp
 54a:	6a 01                	push   $0x1
 54c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 54f:	50                   	push   %eax
 550:	ff 75 08             	pushl  0x8(%ebp)
 553:	e8 43 ff ff ff       	call   49b <write>
 558:	83 c4 10             	add    $0x10,%esp
}
 55b:	90                   	nop
 55c:	c9                   	leave  
 55d:	c3                   	ret    

0000055e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 55e:	55                   	push   %ebp
 55f:	89 e5                	mov    %esp,%ebp
 561:	53                   	push   %ebx
 562:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 565:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 56c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 570:	74 17                	je     589 <printint+0x2b>
 572:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 576:	79 11                	jns    589 <printint+0x2b>
    neg = 1;
 578:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 57f:	8b 45 0c             	mov    0xc(%ebp),%eax
 582:	f7 d8                	neg    %eax
 584:	89 45 ec             	mov    %eax,-0x14(%ebp)
 587:	eb 06                	jmp    58f <printint+0x31>
  } else {
    x = xx;
 589:	8b 45 0c             	mov    0xc(%ebp),%eax
 58c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 58f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 596:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 599:	8d 41 01             	lea    0x1(%ecx),%eax
 59c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 59f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a5:	ba 00 00 00 00       	mov    $0x0,%edx
 5aa:	f7 f3                	div    %ebx
 5ac:	89 d0                	mov    %edx,%eax
 5ae:	0f b6 80 08 0d 00 00 	movzbl 0xd08(%eax),%eax
 5b5:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 5b9:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5bc:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5bf:	ba 00 00 00 00       	mov    $0x0,%edx
 5c4:	f7 f3                	div    %ebx
 5c6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5c9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5cd:	75 c7                	jne    596 <printint+0x38>
  if(neg)
 5cf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5d3:	74 2d                	je     602 <printint+0xa4>
    buf[i++] = '-';
 5d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d8:	8d 50 01             	lea    0x1(%eax),%edx
 5db:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5de:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5e3:	eb 1d                	jmp    602 <printint+0xa4>
    putc(fd, buf[i]);
 5e5:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5eb:	01 d0                	add    %edx,%eax
 5ed:	0f b6 00             	movzbl (%eax),%eax
 5f0:	0f be c0             	movsbl %al,%eax
 5f3:	83 ec 08             	sub    $0x8,%esp
 5f6:	50                   	push   %eax
 5f7:	ff 75 08             	pushl  0x8(%ebp)
 5fa:	e8 3c ff ff ff       	call   53b <putc>
 5ff:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 602:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 606:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 60a:	79 d9                	jns    5e5 <printint+0x87>
    putc(fd, buf[i]);
}
 60c:	90                   	nop
 60d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 610:	c9                   	leave  
 611:	c3                   	ret    

00000612 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 612:	55                   	push   %ebp
 613:	89 e5                	mov    %esp,%ebp
 615:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 618:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 61f:	8d 45 0c             	lea    0xc(%ebp),%eax
 622:	83 c0 04             	add    $0x4,%eax
 625:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 628:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 62f:	e9 59 01 00 00       	jmp    78d <printf+0x17b>
    c = fmt[i] & 0xff;
 634:	8b 55 0c             	mov    0xc(%ebp),%edx
 637:	8b 45 f0             	mov    -0x10(%ebp),%eax
 63a:	01 d0                	add    %edx,%eax
 63c:	0f b6 00             	movzbl (%eax),%eax
 63f:	0f be c0             	movsbl %al,%eax
 642:	25 ff 00 00 00       	and    $0xff,%eax
 647:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 64a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 64e:	75 2c                	jne    67c <printf+0x6a>
      if(c == '%'){
 650:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 654:	75 0c                	jne    662 <printf+0x50>
        state = '%';
 656:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 65d:	e9 27 01 00 00       	jmp    789 <printf+0x177>
      } else {
        putc(fd, c);
 662:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 665:	0f be c0             	movsbl %al,%eax
 668:	83 ec 08             	sub    $0x8,%esp
 66b:	50                   	push   %eax
 66c:	ff 75 08             	pushl  0x8(%ebp)
 66f:	e8 c7 fe ff ff       	call   53b <putc>
 674:	83 c4 10             	add    $0x10,%esp
 677:	e9 0d 01 00 00       	jmp    789 <printf+0x177>
      }
    } else if(state == '%'){
 67c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 680:	0f 85 03 01 00 00    	jne    789 <printf+0x177>
      if(c == 'd'){
 686:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 68a:	75 1e                	jne    6aa <printf+0x98>
        printint(fd, *ap, 10, 1);
 68c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 68f:	8b 00                	mov    (%eax),%eax
 691:	6a 01                	push   $0x1
 693:	6a 0a                	push   $0xa
 695:	50                   	push   %eax
 696:	ff 75 08             	pushl  0x8(%ebp)
 699:	e8 c0 fe ff ff       	call   55e <printint>
 69e:	83 c4 10             	add    $0x10,%esp
        ap++;
 6a1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6a5:	e9 d8 00 00 00       	jmp    782 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 6aa:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 6ae:	74 06                	je     6b6 <printf+0xa4>
 6b0:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6b4:	75 1e                	jne    6d4 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 6b6:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6b9:	8b 00                	mov    (%eax),%eax
 6bb:	6a 00                	push   $0x0
 6bd:	6a 10                	push   $0x10
 6bf:	50                   	push   %eax
 6c0:	ff 75 08             	pushl  0x8(%ebp)
 6c3:	e8 96 fe ff ff       	call   55e <printint>
 6c8:	83 c4 10             	add    $0x10,%esp
        ap++;
 6cb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6cf:	e9 ae 00 00 00       	jmp    782 <printf+0x170>
      } else if(c == 's'){
 6d4:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6d8:	75 43                	jne    71d <printf+0x10b>
        s = (char*)*ap;
 6da:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6dd:	8b 00                	mov    (%eax),%eax
 6df:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6ea:	75 25                	jne    711 <printf+0xff>
          s = "(null)";
 6ec:	c7 45 f4 71 0a 00 00 	movl   $0xa71,-0xc(%ebp)
        while(*s != 0){
 6f3:	eb 1c                	jmp    711 <printf+0xff>
          putc(fd, *s);
 6f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f8:	0f b6 00             	movzbl (%eax),%eax
 6fb:	0f be c0             	movsbl %al,%eax
 6fe:	83 ec 08             	sub    $0x8,%esp
 701:	50                   	push   %eax
 702:	ff 75 08             	pushl  0x8(%ebp)
 705:	e8 31 fe ff ff       	call   53b <putc>
 70a:	83 c4 10             	add    $0x10,%esp
          s++;
 70d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 711:	8b 45 f4             	mov    -0xc(%ebp),%eax
 714:	0f b6 00             	movzbl (%eax),%eax
 717:	84 c0                	test   %al,%al
 719:	75 da                	jne    6f5 <printf+0xe3>
 71b:	eb 65                	jmp    782 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 71d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 721:	75 1d                	jne    740 <printf+0x12e>
        putc(fd, *ap);
 723:	8b 45 e8             	mov    -0x18(%ebp),%eax
 726:	8b 00                	mov    (%eax),%eax
 728:	0f be c0             	movsbl %al,%eax
 72b:	83 ec 08             	sub    $0x8,%esp
 72e:	50                   	push   %eax
 72f:	ff 75 08             	pushl  0x8(%ebp)
 732:	e8 04 fe ff ff       	call   53b <putc>
 737:	83 c4 10             	add    $0x10,%esp
        ap++;
 73a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 73e:	eb 42                	jmp    782 <printf+0x170>
      } else if(c == '%'){
 740:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 744:	75 17                	jne    75d <printf+0x14b>
        putc(fd, c);
 746:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 749:	0f be c0             	movsbl %al,%eax
 74c:	83 ec 08             	sub    $0x8,%esp
 74f:	50                   	push   %eax
 750:	ff 75 08             	pushl  0x8(%ebp)
 753:	e8 e3 fd ff ff       	call   53b <putc>
 758:	83 c4 10             	add    $0x10,%esp
 75b:	eb 25                	jmp    782 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 75d:	83 ec 08             	sub    $0x8,%esp
 760:	6a 25                	push   $0x25
 762:	ff 75 08             	pushl  0x8(%ebp)
 765:	e8 d1 fd ff ff       	call   53b <putc>
 76a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 76d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 770:	0f be c0             	movsbl %al,%eax
 773:	83 ec 08             	sub    $0x8,%esp
 776:	50                   	push   %eax
 777:	ff 75 08             	pushl  0x8(%ebp)
 77a:	e8 bc fd ff ff       	call   53b <putc>
 77f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 782:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 789:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 78d:	8b 55 0c             	mov    0xc(%ebp),%edx
 790:	8b 45 f0             	mov    -0x10(%ebp),%eax
 793:	01 d0                	add    %edx,%eax
 795:	0f b6 00             	movzbl (%eax),%eax
 798:	84 c0                	test   %al,%al
 79a:	0f 85 94 fe ff ff    	jne    634 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 7a0:	90                   	nop
 7a1:	c9                   	leave  
 7a2:	c3                   	ret    

000007a3 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a3:	55                   	push   %ebp
 7a4:	89 e5                	mov    %esp,%ebp
 7a6:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ac:	83 e8 08             	sub    $0x8,%eax
 7af:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b2:	a1 48 0d 00 00       	mov    0xd48,%eax
 7b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7ba:	eb 24                	jmp    7e0 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bf:	8b 00                	mov    (%eax),%eax
 7c1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7c4:	77 12                	ja     7d8 <free+0x35>
 7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7cc:	77 24                	ja     7f2 <free+0x4f>
 7ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d1:	8b 00                	mov    (%eax),%eax
 7d3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7d6:	77 1a                	ja     7f2 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7db:	8b 00                	mov    (%eax),%eax
 7dd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7e6:	76 d4                	jbe    7bc <free+0x19>
 7e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7eb:	8b 00                	mov    (%eax),%eax
 7ed:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7f0:	76 ca                	jbe    7bc <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 7f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f5:	8b 40 04             	mov    0x4(%eax),%eax
 7f8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 802:	01 c2                	add    %eax,%edx
 804:	8b 45 fc             	mov    -0x4(%ebp),%eax
 807:	8b 00                	mov    (%eax),%eax
 809:	39 c2                	cmp    %eax,%edx
 80b:	75 24                	jne    831 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 80d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 810:	8b 50 04             	mov    0x4(%eax),%edx
 813:	8b 45 fc             	mov    -0x4(%ebp),%eax
 816:	8b 00                	mov    (%eax),%eax
 818:	8b 40 04             	mov    0x4(%eax),%eax
 81b:	01 c2                	add    %eax,%edx
 81d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 820:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 823:	8b 45 fc             	mov    -0x4(%ebp),%eax
 826:	8b 00                	mov    (%eax),%eax
 828:	8b 10                	mov    (%eax),%edx
 82a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82d:	89 10                	mov    %edx,(%eax)
 82f:	eb 0a                	jmp    83b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 831:	8b 45 fc             	mov    -0x4(%ebp),%eax
 834:	8b 10                	mov    (%eax),%edx
 836:	8b 45 f8             	mov    -0x8(%ebp),%eax
 839:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 83b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83e:	8b 40 04             	mov    0x4(%eax),%eax
 841:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 848:	8b 45 fc             	mov    -0x4(%ebp),%eax
 84b:	01 d0                	add    %edx,%eax
 84d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 850:	75 20                	jne    872 <free+0xcf>
    p->s.size += bp->s.size;
 852:	8b 45 fc             	mov    -0x4(%ebp),%eax
 855:	8b 50 04             	mov    0x4(%eax),%edx
 858:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85b:	8b 40 04             	mov    0x4(%eax),%eax
 85e:	01 c2                	add    %eax,%edx
 860:	8b 45 fc             	mov    -0x4(%ebp),%eax
 863:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 866:	8b 45 f8             	mov    -0x8(%ebp),%eax
 869:	8b 10                	mov    (%eax),%edx
 86b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86e:	89 10                	mov    %edx,(%eax)
 870:	eb 08                	jmp    87a <free+0xd7>
  } else
    p->s.ptr = bp;
 872:	8b 45 fc             	mov    -0x4(%ebp),%eax
 875:	8b 55 f8             	mov    -0x8(%ebp),%edx
 878:	89 10                	mov    %edx,(%eax)
  freep = p;
 87a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 87d:	a3 48 0d 00 00       	mov    %eax,0xd48
}
 882:	90                   	nop
 883:	c9                   	leave  
 884:	c3                   	ret    

00000885 <morecore>:

static Header*
morecore(uint nu)
{
 885:	55                   	push   %ebp
 886:	89 e5                	mov    %esp,%ebp
 888:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 88b:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 892:	77 07                	ja     89b <morecore+0x16>
    nu = 4096;
 894:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 89b:	8b 45 08             	mov    0x8(%ebp),%eax
 89e:	c1 e0 03             	shl    $0x3,%eax
 8a1:	83 ec 0c             	sub    $0xc,%esp
 8a4:	50                   	push   %eax
 8a5:	e8 59 fc ff ff       	call   503 <sbrk>
 8aa:	83 c4 10             	add    $0x10,%esp
 8ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8b0:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8b4:	75 07                	jne    8bd <morecore+0x38>
    return 0;
 8b6:	b8 00 00 00 00       	mov    $0x0,%eax
 8bb:	eb 26                	jmp    8e3 <morecore+0x5e>
  hp = (Header*)p;
 8bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c6:	8b 55 08             	mov    0x8(%ebp),%edx
 8c9:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8cf:	83 c0 08             	add    $0x8,%eax
 8d2:	83 ec 0c             	sub    $0xc,%esp
 8d5:	50                   	push   %eax
 8d6:	e8 c8 fe ff ff       	call   7a3 <free>
 8db:	83 c4 10             	add    $0x10,%esp
  return freep;
 8de:	a1 48 0d 00 00       	mov    0xd48,%eax
}
 8e3:	c9                   	leave  
 8e4:	c3                   	ret    

000008e5 <malloc>:

void*
malloc(uint nbytes)
{
 8e5:	55                   	push   %ebp
 8e6:	89 e5                	mov    %esp,%ebp
 8e8:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8eb:	8b 45 08             	mov    0x8(%ebp),%eax
 8ee:	83 c0 07             	add    $0x7,%eax
 8f1:	c1 e8 03             	shr    $0x3,%eax
 8f4:	83 c0 01             	add    $0x1,%eax
 8f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8fa:	a1 48 0d 00 00       	mov    0xd48,%eax
 8ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
 902:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 906:	75 23                	jne    92b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 908:	c7 45 f0 40 0d 00 00 	movl   $0xd40,-0x10(%ebp)
 90f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 912:	a3 48 0d 00 00       	mov    %eax,0xd48
 917:	a1 48 0d 00 00       	mov    0xd48,%eax
 91c:	a3 40 0d 00 00       	mov    %eax,0xd40
    base.s.size = 0;
 921:	c7 05 44 0d 00 00 00 	movl   $0x0,0xd44
 928:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 92e:	8b 00                	mov    (%eax),%eax
 930:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 933:	8b 45 f4             	mov    -0xc(%ebp),%eax
 936:	8b 40 04             	mov    0x4(%eax),%eax
 939:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 93c:	72 4d                	jb     98b <malloc+0xa6>
      if(p->s.size == nunits)
 93e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 941:	8b 40 04             	mov    0x4(%eax),%eax
 944:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 947:	75 0c                	jne    955 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 949:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94c:	8b 10                	mov    (%eax),%edx
 94e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 951:	89 10                	mov    %edx,(%eax)
 953:	eb 26                	jmp    97b <malloc+0x96>
      else {
        p->s.size -= nunits;
 955:	8b 45 f4             	mov    -0xc(%ebp),%eax
 958:	8b 40 04             	mov    0x4(%eax),%eax
 95b:	2b 45 ec             	sub    -0x14(%ebp),%eax
 95e:	89 c2                	mov    %eax,%edx
 960:	8b 45 f4             	mov    -0xc(%ebp),%eax
 963:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 966:	8b 45 f4             	mov    -0xc(%ebp),%eax
 969:	8b 40 04             	mov    0x4(%eax),%eax
 96c:	c1 e0 03             	shl    $0x3,%eax
 96f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 972:	8b 45 f4             	mov    -0xc(%ebp),%eax
 975:	8b 55 ec             	mov    -0x14(%ebp),%edx
 978:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 97b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 97e:	a3 48 0d 00 00       	mov    %eax,0xd48
      return (void*)(p + 1);
 983:	8b 45 f4             	mov    -0xc(%ebp),%eax
 986:	83 c0 08             	add    $0x8,%eax
 989:	eb 3b                	jmp    9c6 <malloc+0xe1>
    }
    if(p == freep)
 98b:	a1 48 0d 00 00       	mov    0xd48,%eax
 990:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 993:	75 1e                	jne    9b3 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 995:	83 ec 0c             	sub    $0xc,%esp
 998:	ff 75 ec             	pushl  -0x14(%ebp)
 99b:	e8 e5 fe ff ff       	call   885 <morecore>
 9a0:	83 c4 10             	add    $0x10,%esp
 9a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 9a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 9aa:	75 07                	jne    9b3 <malloc+0xce>
        return 0;
 9ac:	b8 00 00 00 00       	mov    $0x0,%eax
 9b1:	eb 13                	jmp    9c6 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9bc:	8b 00                	mov    (%eax),%eax
 9be:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 9c1:	e9 6d ff ff ff       	jmp    933 <malloc+0x4e>
}
 9c6:	c9                   	leave  
 9c7:	c3                   	ret    
