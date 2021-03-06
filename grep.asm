
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;
  
  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
   d:	e9 ab 00 00 00       	jmp    bd <grep+0xbd>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    p = buf;
  18:	c7 45 f0 c0 0e 00 00 	movl   $0xec0,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  1f:	eb 4a                	jmp    6b <grep+0x6b>
      *q = 0;
  21:	8b 45 e8             	mov    -0x18(%ebp),%eax
  24:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  27:	83 ec 08             	sub    $0x8,%esp
  2a:	ff 75 f0             	pushl  -0x10(%ebp)
  2d:	ff 75 08             	pushl  0x8(%ebp)
  30:	e8 9a 01 00 00       	call   1cf <match>
  35:	83 c4 10             	add    $0x10,%esp
  38:	85 c0                	test   %eax,%eax
  3a:	74 26                	je     62 <grep+0x62>
        *q = '\n';
  3c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  3f:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  42:	8b 45 e8             	mov    -0x18(%ebp),%eax
  45:	83 c0 01             	add    $0x1,%eax
  48:	89 c2                	mov    %eax,%edx
  4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  4d:	29 c2                	sub    %eax,%edx
  4f:	89 d0                	mov    %edx,%eax
  51:	83 ec 04             	sub    $0x4,%esp
  54:	50                   	push   %eax
  55:	ff 75 f0             	pushl  -0x10(%ebp)
  58:	6a 01                	push   $0x1
  5a:	e8 94 05 00 00       	call   5f3 <write>
  5f:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  62:	8b 45 e8             	mov    -0x18(%ebp),%eax
  65:	83 c0 01             	add    $0x1,%eax
  68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
    m += n;
    p = buf;
    while((q = strchr(p, '\n')) != 0){
  6b:	83 ec 08             	sub    $0x8,%esp
  6e:	6a 0a                	push   $0xa
  70:	ff 75 f0             	pushl  -0x10(%ebp)
  73:	e8 89 03 00 00       	call   401 <strchr>
  78:	83 c4 10             	add    $0x10,%esp
  7b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  7e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  82:	75 9d                	jne    21 <grep+0x21>
        *q = '\n';
        write(1, p, q+1 - p);
      }
      p = q+1;
    }
    if(p == buf)
  84:	81 7d f0 c0 0e 00 00 	cmpl   $0xec0,-0x10(%ebp)
  8b:	75 07                	jne    94 <grep+0x94>
      m = 0;
  8d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  94:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  98:	7e 23                	jle    bd <grep+0xbd>
      m -= p - buf;
  9a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  9d:	ba c0 0e 00 00       	mov    $0xec0,%edx
  a2:	29 d0                	sub    %edx,%eax
  a4:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  a7:	83 ec 04             	sub    $0x4,%esp
  aa:	ff 75 f4             	pushl  -0xc(%ebp)
  ad:	ff 75 f0             	pushl  -0x10(%ebp)
  b0:	68 c0 0e 00 00       	push   $0xec0
  b5:	e8 d4 04 00 00       	call   58e <memmove>
  ba:	83 c4 10             	add    $0x10,%esp
{
  int n, m;
  char *p, *q;
  
  m = 0;
  while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
  bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  c0:	ba 00 04 00 00       	mov    $0x400,%edx
  c5:	29 c2                	sub    %eax,%edx
  c7:	89 d0                	mov    %edx,%eax
  c9:	89 c2                	mov    %eax,%edx
  cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  ce:	05 c0 0e 00 00       	add    $0xec0,%eax
  d3:	83 ec 04             	sub    $0x4,%esp
  d6:	52                   	push   %edx
  d7:	50                   	push   %eax
  d8:	ff 75 0c             	pushl  0xc(%ebp)
  db:	e8 0b 05 00 00       	call   5eb <read>
  e0:	83 c4 10             	add    $0x10,%esp
  e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  ea:	0f 8f 22 ff ff ff    	jg     12 <grep+0x12>
    if(m > 0){
      m -= p - buf;
      memmove(buf, p, m);
    }
  }
}
  f0:	90                   	nop
  f1:	c9                   	leave  
  f2:	c3                   	ret    

000000f3 <main>:

int
main(int argc, char *argv[])
{
  f3:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f7:	83 e4 f0             	and    $0xfffffff0,%esp
  fa:	ff 71 fc             	pushl  -0x4(%ecx)
  fd:	55                   	push   %ebp
  fe:	89 e5                	mov    %esp,%ebp
 100:	53                   	push   %ebx
 101:	51                   	push   %ecx
 102:	83 ec 10             	sub    $0x10,%esp
 105:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;
  
  if(argc <= 1){
 107:	83 3b 01             	cmpl   $0x1,(%ebx)
 10a:	7f 17                	jg     123 <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
 10c:	83 ec 08             	sub    $0x8,%esp
 10f:	68 20 0b 00 00       	push   $0xb20
 114:	6a 02                	push   $0x2
 116:	e8 4f 06 00 00       	call   76a <printf>
 11b:	83 c4 10             	add    $0x10,%esp
    exit();
 11e:	e8 b0 04 00 00       	call   5d3 <exit>
  }
  pattern = argv[1];
 123:	8b 43 04             	mov    0x4(%ebx),%eax
 126:	8b 40 04             	mov    0x4(%eax),%eax
 129:	89 45 f0             	mov    %eax,-0x10(%ebp)
  
  if(argc <= 2){
 12c:	83 3b 02             	cmpl   $0x2,(%ebx)
 12f:	7f 15                	jg     146 <main+0x53>
    grep(pattern, 0);
 131:	83 ec 08             	sub    $0x8,%esp
 134:	6a 00                	push   $0x0
 136:	ff 75 f0             	pushl  -0x10(%ebp)
 139:	e8 c2 fe ff ff       	call   0 <grep>
 13e:	83 c4 10             	add    $0x10,%esp
    exit();
 141:	e8 8d 04 00 00       	call   5d3 <exit>
  }

  for(i = 2; i < argc; i++){
 146:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 14d:	eb 74                	jmp    1c3 <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
 14f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 152:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 159:	8b 43 04             	mov    0x4(%ebx),%eax
 15c:	01 d0                	add    %edx,%eax
 15e:	8b 00                	mov    (%eax),%eax
 160:	83 ec 08             	sub    $0x8,%esp
 163:	6a 00                	push   $0x0
 165:	50                   	push   %eax
 166:	e8 a8 04 00 00       	call   613 <open>
 16b:	83 c4 10             	add    $0x10,%esp
 16e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 171:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 175:	79 29                	jns    1a0 <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
 177:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 181:	8b 43 04             	mov    0x4(%ebx),%eax
 184:	01 d0                	add    %edx,%eax
 186:	8b 00                	mov    (%eax),%eax
 188:	83 ec 04             	sub    $0x4,%esp
 18b:	50                   	push   %eax
 18c:	68 40 0b 00 00       	push   $0xb40
 191:	6a 01                	push   $0x1
 193:	e8 d2 05 00 00       	call   76a <printf>
 198:	83 c4 10             	add    $0x10,%esp
      exit();
 19b:	e8 33 04 00 00       	call   5d3 <exit>
    }
    grep(pattern, fd);
 1a0:	83 ec 08             	sub    $0x8,%esp
 1a3:	ff 75 ec             	pushl  -0x14(%ebp)
 1a6:	ff 75 f0             	pushl  -0x10(%ebp)
 1a9:	e8 52 fe ff ff       	call   0 <grep>
 1ae:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1b1:	83 ec 0c             	sub    $0xc,%esp
 1b4:	ff 75 ec             	pushl  -0x14(%ebp)
 1b7:	e8 3f 04 00 00       	call   5fb <close>
 1bc:	83 c4 10             	add    $0x10,%esp
  if(argc <= 2){
    grep(pattern, 0);
    exit();
  }

  for(i = 2; i < argc; i++){
 1bf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c6:	3b 03                	cmp    (%ebx),%eax
 1c8:	7c 85                	jl     14f <main+0x5c>
      exit();
    }
    grep(pattern, fd);
    close(fd);
  }
  exit();
 1ca:	e8 04 04 00 00       	call   5d3 <exit>

000001cf <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1cf:	55                   	push   %ebp
 1d0:	89 e5                	mov    %esp,%ebp
 1d2:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1d5:	8b 45 08             	mov    0x8(%ebp),%eax
 1d8:	0f b6 00             	movzbl (%eax),%eax
 1db:	3c 5e                	cmp    $0x5e,%al
 1dd:	75 17                	jne    1f6 <match+0x27>
    return matchhere(re+1, text);
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	83 c0 01             	add    $0x1,%eax
 1e5:	83 ec 08             	sub    $0x8,%esp
 1e8:	ff 75 0c             	pushl  0xc(%ebp)
 1eb:	50                   	push   %eax
 1ec:	e8 38 00 00 00       	call   229 <matchhere>
 1f1:	83 c4 10             	add    $0x10,%esp
 1f4:	eb 31                	jmp    227 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
 1f6:	83 ec 08             	sub    $0x8,%esp
 1f9:	ff 75 0c             	pushl  0xc(%ebp)
 1fc:	ff 75 08             	pushl  0x8(%ebp)
 1ff:	e8 25 00 00 00       	call   229 <matchhere>
 204:	83 c4 10             	add    $0x10,%esp
 207:	85 c0                	test   %eax,%eax
 209:	74 07                	je     212 <match+0x43>
      return 1;
 20b:	b8 01 00 00 00       	mov    $0x1,%eax
 210:	eb 15                	jmp    227 <match+0x58>
  }while(*text++ != '\0');
 212:	8b 45 0c             	mov    0xc(%ebp),%eax
 215:	8d 50 01             	lea    0x1(%eax),%edx
 218:	89 55 0c             	mov    %edx,0xc(%ebp)
 21b:	0f b6 00             	movzbl (%eax),%eax
 21e:	84 c0                	test   %al,%al
 220:	75 d4                	jne    1f6 <match+0x27>
  return 0;
 222:	b8 00 00 00 00       	mov    $0x0,%eax
}
 227:	c9                   	leave  
 228:	c3                   	ret    

00000229 <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 229:	55                   	push   %ebp
 22a:	89 e5                	mov    %esp,%ebp
 22c:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	84 c0                	test   %al,%al
 237:	75 0a                	jne    243 <matchhere+0x1a>
    return 1;
 239:	b8 01 00 00 00       	mov    $0x1,%eax
 23e:	e9 99 00 00 00       	jmp    2dc <matchhere+0xb3>
  if(re[1] == '*')
 243:	8b 45 08             	mov    0x8(%ebp),%eax
 246:	83 c0 01             	add    $0x1,%eax
 249:	0f b6 00             	movzbl (%eax),%eax
 24c:	3c 2a                	cmp    $0x2a,%al
 24e:	75 21                	jne    271 <matchhere+0x48>
    return matchstar(re[0], re+2, text);
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	8d 50 02             	lea    0x2(%eax),%edx
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	0f b6 00             	movzbl (%eax),%eax
 25c:	0f be c0             	movsbl %al,%eax
 25f:	83 ec 04             	sub    $0x4,%esp
 262:	ff 75 0c             	pushl  0xc(%ebp)
 265:	52                   	push   %edx
 266:	50                   	push   %eax
 267:	e8 72 00 00 00       	call   2de <matchstar>
 26c:	83 c4 10             	add    $0x10,%esp
 26f:	eb 6b                	jmp    2dc <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	0f b6 00             	movzbl (%eax),%eax
 277:	3c 24                	cmp    $0x24,%al
 279:	75 1d                	jne    298 <matchhere+0x6f>
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	83 c0 01             	add    $0x1,%eax
 281:	0f b6 00             	movzbl (%eax),%eax
 284:	84 c0                	test   %al,%al
 286:	75 10                	jne    298 <matchhere+0x6f>
    return *text == '\0';
 288:	8b 45 0c             	mov    0xc(%ebp),%eax
 28b:	0f b6 00             	movzbl (%eax),%eax
 28e:	84 c0                	test   %al,%al
 290:	0f 94 c0             	sete   %al
 293:	0f b6 c0             	movzbl %al,%eax
 296:	eb 44                	jmp    2dc <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 298:	8b 45 0c             	mov    0xc(%ebp),%eax
 29b:	0f b6 00             	movzbl (%eax),%eax
 29e:	84 c0                	test   %al,%al
 2a0:	74 35                	je     2d7 <matchhere+0xae>
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
 2a5:	0f b6 00             	movzbl (%eax),%eax
 2a8:	3c 2e                	cmp    $0x2e,%al
 2aa:	74 10                	je     2bc <matchhere+0x93>
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
 2af:	0f b6 10             	movzbl (%eax),%edx
 2b2:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b5:	0f b6 00             	movzbl (%eax),%eax
 2b8:	38 c2                	cmp    %al,%dl
 2ba:	75 1b                	jne    2d7 <matchhere+0xae>
    return matchhere(re+1, text+1);
 2bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bf:	8d 50 01             	lea    0x1(%eax),%edx
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
 2c5:	83 c0 01             	add    $0x1,%eax
 2c8:	83 ec 08             	sub    $0x8,%esp
 2cb:	52                   	push   %edx
 2cc:	50                   	push   %eax
 2cd:	e8 57 ff ff ff       	call   229 <matchhere>
 2d2:	83 c4 10             	add    $0x10,%esp
 2d5:	eb 05                	jmp    2dc <matchhere+0xb3>
  return 0;
 2d7:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2dc:	c9                   	leave  
 2dd:	c3                   	ret    

000002de <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2de:	55                   	push   %ebp
 2df:	89 e5                	mov    %esp,%ebp
 2e1:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2e4:	83 ec 08             	sub    $0x8,%esp
 2e7:	ff 75 10             	pushl  0x10(%ebp)
 2ea:	ff 75 0c             	pushl  0xc(%ebp)
 2ed:	e8 37 ff ff ff       	call   229 <matchhere>
 2f2:	83 c4 10             	add    $0x10,%esp
 2f5:	85 c0                	test   %eax,%eax
 2f7:	74 07                	je     300 <matchstar+0x22>
      return 1;
 2f9:	b8 01 00 00 00       	mov    $0x1,%eax
 2fe:	eb 29                	jmp    329 <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
 300:	8b 45 10             	mov    0x10(%ebp),%eax
 303:	0f b6 00             	movzbl (%eax),%eax
 306:	84 c0                	test   %al,%al
 308:	74 1a                	je     324 <matchstar+0x46>
 30a:	8b 45 10             	mov    0x10(%ebp),%eax
 30d:	8d 50 01             	lea    0x1(%eax),%edx
 310:	89 55 10             	mov    %edx,0x10(%ebp)
 313:	0f b6 00             	movzbl (%eax),%eax
 316:	0f be c0             	movsbl %al,%eax
 319:	3b 45 08             	cmp    0x8(%ebp),%eax
 31c:	74 c6                	je     2e4 <matchstar+0x6>
 31e:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 322:	74 c0                	je     2e4 <matchstar+0x6>
  return 0;
 324:	b8 00 00 00 00       	mov    $0x0,%eax
}
 329:	c9                   	leave  
 32a:	c3                   	ret    

0000032b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 32b:	55                   	push   %ebp
 32c:	89 e5                	mov    %esp,%ebp
 32e:	57                   	push   %edi
 32f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 330:	8b 4d 08             	mov    0x8(%ebp),%ecx
 333:	8b 55 10             	mov    0x10(%ebp),%edx
 336:	8b 45 0c             	mov    0xc(%ebp),%eax
 339:	89 cb                	mov    %ecx,%ebx
 33b:	89 df                	mov    %ebx,%edi
 33d:	89 d1                	mov    %edx,%ecx
 33f:	fc                   	cld    
 340:	f3 aa                	rep stos %al,%es:(%edi)
 342:	89 ca                	mov    %ecx,%edx
 344:	89 fb                	mov    %edi,%ebx
 346:	89 5d 08             	mov    %ebx,0x8(%ebp)
 349:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 34c:	90                   	nop
 34d:	5b                   	pop    %ebx
 34e:	5f                   	pop    %edi
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    

00000351 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 351:	55                   	push   %ebp
 352:	89 e5                	mov    %esp,%ebp
 354:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 357:	8b 45 08             	mov    0x8(%ebp),%eax
 35a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 35d:	90                   	nop
 35e:	8b 45 08             	mov    0x8(%ebp),%eax
 361:	8d 50 01             	lea    0x1(%eax),%edx
 364:	89 55 08             	mov    %edx,0x8(%ebp)
 367:	8b 55 0c             	mov    0xc(%ebp),%edx
 36a:	8d 4a 01             	lea    0x1(%edx),%ecx
 36d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 370:	0f b6 12             	movzbl (%edx),%edx
 373:	88 10                	mov    %dl,(%eax)
 375:	0f b6 00             	movzbl (%eax),%eax
 378:	84 c0                	test   %al,%al
 37a:	75 e2                	jne    35e <strcpy+0xd>
    ;
  return os;
 37c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 37f:	c9                   	leave  
 380:	c3                   	ret    

00000381 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 381:	55                   	push   %ebp
 382:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 384:	eb 08                	jmp    38e <strcmp+0xd>
    p++, q++;
 386:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 38a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 38e:	8b 45 08             	mov    0x8(%ebp),%eax
 391:	0f b6 00             	movzbl (%eax),%eax
 394:	84 c0                	test   %al,%al
 396:	74 10                	je     3a8 <strcmp+0x27>
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	0f b6 10             	movzbl (%eax),%edx
 39e:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a1:	0f b6 00             	movzbl (%eax),%eax
 3a4:	38 c2                	cmp    %al,%dl
 3a6:	74 de                	je     386 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	0f b6 00             	movzbl (%eax),%eax
 3ae:	0f b6 d0             	movzbl %al,%edx
 3b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b4:	0f b6 00             	movzbl (%eax),%eax
 3b7:	0f b6 c0             	movzbl %al,%eax
 3ba:	29 c2                	sub    %eax,%edx
 3bc:	89 d0                	mov    %edx,%eax
}
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    

000003c0 <strlen>:

uint
strlen(char *s)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3cd:	eb 04                	jmp    3d3 <strlen+0x13>
 3cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3d6:	8b 45 08             	mov    0x8(%ebp),%eax
 3d9:	01 d0                	add    %edx,%eax
 3db:	0f b6 00             	movzbl (%eax),%eax
 3de:	84 c0                	test   %al,%al
 3e0:	75 ed                	jne    3cf <strlen+0xf>
    ;
  return n;
 3e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3e5:	c9                   	leave  
 3e6:	c3                   	ret    

000003e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 3e7:	55                   	push   %ebp
 3e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 3ea:	8b 45 10             	mov    0x10(%ebp),%eax
 3ed:	50                   	push   %eax
 3ee:	ff 75 0c             	pushl  0xc(%ebp)
 3f1:	ff 75 08             	pushl  0x8(%ebp)
 3f4:	e8 32 ff ff ff       	call   32b <stosb>
 3f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 3fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 3ff:	c9                   	leave  
 400:	c3                   	ret    

00000401 <strchr>:

char*
strchr(const char *s, char c)
{
 401:	55                   	push   %ebp
 402:	89 e5                	mov    %esp,%ebp
 404:	83 ec 04             	sub    $0x4,%esp
 407:	8b 45 0c             	mov    0xc(%ebp),%eax
 40a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 40d:	eb 14                	jmp    423 <strchr+0x22>
    if(*s == c)
 40f:	8b 45 08             	mov    0x8(%ebp),%eax
 412:	0f b6 00             	movzbl (%eax),%eax
 415:	3a 45 fc             	cmp    -0x4(%ebp),%al
 418:	75 05                	jne    41f <strchr+0x1e>
      return (char*)s;
 41a:	8b 45 08             	mov    0x8(%ebp),%eax
 41d:	eb 13                	jmp    432 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 41f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 423:	8b 45 08             	mov    0x8(%ebp),%eax
 426:	0f b6 00             	movzbl (%eax),%eax
 429:	84 c0                	test   %al,%al
 42b:	75 e2                	jne    40f <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 42d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 432:	c9                   	leave  
 433:	c3                   	ret    

00000434 <gets>:

char*
gets(char *buf, int max)
{
 434:	55                   	push   %ebp
 435:	89 e5                	mov    %esp,%ebp
 437:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 43a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 441:	eb 42                	jmp    485 <gets+0x51>
    cc = read(0, &c, 1);
 443:	83 ec 04             	sub    $0x4,%esp
 446:	6a 01                	push   $0x1
 448:	8d 45 ef             	lea    -0x11(%ebp),%eax
 44b:	50                   	push   %eax
 44c:	6a 00                	push   $0x0
 44e:	e8 98 01 00 00       	call   5eb <read>
 453:	83 c4 10             	add    $0x10,%esp
 456:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 459:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45d:	7e 33                	jle    492 <gets+0x5e>
      break;
    buf[i++] = c;
 45f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 462:	8d 50 01             	lea    0x1(%eax),%edx
 465:	89 55 f4             	mov    %edx,-0xc(%ebp)
 468:	89 c2                	mov    %eax,%edx
 46a:	8b 45 08             	mov    0x8(%ebp),%eax
 46d:	01 c2                	add    %eax,%edx
 46f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 473:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 475:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 479:	3c 0a                	cmp    $0xa,%al
 47b:	74 16                	je     493 <gets+0x5f>
 47d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 481:	3c 0d                	cmp    $0xd,%al
 483:	74 0e                	je     493 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 485:	8b 45 f4             	mov    -0xc(%ebp),%eax
 488:	83 c0 01             	add    $0x1,%eax
 48b:	3b 45 0c             	cmp    0xc(%ebp),%eax
 48e:	7c b3                	jl     443 <gets+0xf>
 490:	eb 01                	jmp    493 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 492:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 493:	8b 55 f4             	mov    -0xc(%ebp),%edx
 496:	8b 45 08             	mov    0x8(%ebp),%eax
 499:	01 d0                	add    %edx,%eax
 49b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 49e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4a1:	c9                   	leave  
 4a2:	c3                   	ret    

000004a3 <stat>:

int
stat(char *n, struct stat *st)
{
 4a3:	55                   	push   %ebp
 4a4:	89 e5                	mov    %esp,%ebp
 4a6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4a9:	83 ec 08             	sub    $0x8,%esp
 4ac:	6a 00                	push   $0x0
 4ae:	ff 75 08             	pushl  0x8(%ebp)
 4b1:	e8 5d 01 00 00       	call   613 <open>
 4b6:	83 c4 10             	add    $0x10,%esp
 4b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4c0:	79 07                	jns    4c9 <stat+0x26>
    return -1;
 4c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4c7:	eb 25                	jmp    4ee <stat+0x4b>
  r = fstat(fd, st);
 4c9:	83 ec 08             	sub    $0x8,%esp
 4cc:	ff 75 0c             	pushl  0xc(%ebp)
 4cf:	ff 75 f4             	pushl  -0xc(%ebp)
 4d2:	e8 54 01 00 00       	call   62b <fstat>
 4d7:	83 c4 10             	add    $0x10,%esp
 4da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4dd:	83 ec 0c             	sub    $0xc,%esp
 4e0:	ff 75 f4             	pushl  -0xc(%ebp)
 4e3:	e8 13 01 00 00       	call   5fb <close>
 4e8:	83 c4 10             	add    $0x10,%esp
  return r;
 4eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 4ee:	c9                   	leave  
 4ef:	c3                   	ret    

000004f0 <atoi>:

int
atoi(const char *s)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 4f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 4fd:	eb 25                	jmp    524 <atoi+0x34>
    n = n*10 + *s++ - '0';
 4ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
 502:	89 d0                	mov    %edx,%eax
 504:	c1 e0 02             	shl    $0x2,%eax
 507:	01 d0                	add    %edx,%eax
 509:	01 c0                	add    %eax,%eax
 50b:	89 c1                	mov    %eax,%ecx
 50d:	8b 45 08             	mov    0x8(%ebp),%eax
 510:	8d 50 01             	lea    0x1(%eax),%edx
 513:	89 55 08             	mov    %edx,0x8(%ebp)
 516:	0f b6 00             	movzbl (%eax),%eax
 519:	0f be c0             	movsbl %al,%eax
 51c:	01 c8                	add    %ecx,%eax
 51e:	83 e8 30             	sub    $0x30,%eax
 521:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 524:	8b 45 08             	mov    0x8(%ebp),%eax
 527:	0f b6 00             	movzbl (%eax),%eax
 52a:	3c 2f                	cmp    $0x2f,%al
 52c:	7e 0a                	jle    538 <atoi+0x48>
 52e:	8b 45 08             	mov    0x8(%ebp),%eax
 531:	0f b6 00             	movzbl (%eax),%eax
 534:	3c 39                	cmp    $0x39,%al
 536:	7e c7                	jle    4ff <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 538:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 53b:	c9                   	leave  
 53c:	c3                   	ret    

0000053d <itoa>:

char*
itoa(int val, int base){
 53d:	55                   	push   %ebp
 53e:	89 e5                	mov    %esp,%ebp
 540:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 543:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 54a:	eb 29                	jmp    575 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 54c:	8b 45 08             	mov    0x8(%ebp),%eax
 54f:	99                   	cltd   
 550:	f7 7d 0c             	idivl  0xc(%ebp)
 553:	89 d0                	mov    %edx,%eax
 555:	0f b6 80 56 0b 00 00 	movzbl 0xb56(%eax),%eax
 55c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 55f:	81 c2 80 0e 00 00    	add    $0xe80,%edx
 565:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 567:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 56b:	8b 45 08             	mov    0x8(%ebp),%eax
 56e:	99                   	cltd   
 56f:	f7 7d 0c             	idivl  0xc(%ebp)
 572:	89 45 08             	mov    %eax,0x8(%ebp)
 575:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 579:	74 06                	je     581 <itoa+0x44>
 57b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 57f:	75 cb                	jne    54c <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 581:	8b 45 fc             	mov    -0x4(%ebp),%eax
 584:	83 c0 01             	add    $0x1,%eax
 587:	05 80 0e 00 00       	add    $0xe80,%eax

}
 58c:	c9                   	leave  
 58d:	c3                   	ret    

0000058e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 58e:	55                   	push   %ebp
 58f:	89 e5                	mov    %esp,%ebp
 591:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 594:	8b 45 08             	mov    0x8(%ebp),%eax
 597:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 59a:	8b 45 0c             	mov    0xc(%ebp),%eax
 59d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 5a0:	eb 17                	jmp    5b9 <memmove+0x2b>
    *dst++ = *src++;
 5a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5a5:	8d 50 01             	lea    0x1(%eax),%edx
 5a8:	89 55 fc             	mov    %edx,-0x4(%ebp)
 5ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
 5ae:	8d 4a 01             	lea    0x1(%edx),%ecx
 5b1:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 5b4:	0f b6 12             	movzbl (%edx),%edx
 5b7:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5b9:	8b 45 10             	mov    0x10(%ebp),%eax
 5bc:	8d 50 ff             	lea    -0x1(%eax),%edx
 5bf:	89 55 10             	mov    %edx,0x10(%ebp)
 5c2:	85 c0                	test   %eax,%eax
 5c4:	7f dc                	jg     5a2 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5c9:	c9                   	leave  
 5ca:	c3                   	ret    

000005cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5cb:	b8 01 00 00 00       	mov    $0x1,%eax
 5d0:	cd 40                	int    $0x40
 5d2:	c3                   	ret    

000005d3 <exit>:
SYSCALL(exit)
 5d3:	b8 02 00 00 00       	mov    $0x2,%eax
 5d8:	cd 40                	int    $0x40
 5da:	c3                   	ret    

000005db <wait>:
SYSCALL(wait)
 5db:	b8 03 00 00 00       	mov    $0x3,%eax
 5e0:	cd 40                	int    $0x40
 5e2:	c3                   	ret    

000005e3 <pipe>:
SYSCALL(pipe)
 5e3:	b8 04 00 00 00       	mov    $0x4,%eax
 5e8:	cd 40                	int    $0x40
 5ea:	c3                   	ret    

000005eb <read>:
SYSCALL(read)
 5eb:	b8 05 00 00 00       	mov    $0x5,%eax
 5f0:	cd 40                	int    $0x40
 5f2:	c3                   	ret    

000005f3 <write>:
SYSCALL(write)
 5f3:	b8 10 00 00 00       	mov    $0x10,%eax
 5f8:	cd 40                	int    $0x40
 5fa:	c3                   	ret    

000005fb <close>:
SYSCALL(close)
 5fb:	b8 15 00 00 00       	mov    $0x15,%eax
 600:	cd 40                	int    $0x40
 602:	c3                   	ret    

00000603 <kill>:
SYSCALL(kill)
 603:	b8 06 00 00 00       	mov    $0x6,%eax
 608:	cd 40                	int    $0x40
 60a:	c3                   	ret    

0000060b <exec>:
SYSCALL(exec)
 60b:	b8 07 00 00 00       	mov    $0x7,%eax
 610:	cd 40                	int    $0x40
 612:	c3                   	ret    

00000613 <open>:
SYSCALL(open)
 613:	b8 0f 00 00 00       	mov    $0xf,%eax
 618:	cd 40                	int    $0x40
 61a:	c3                   	ret    

0000061b <mknod>:
SYSCALL(mknod)
 61b:	b8 11 00 00 00       	mov    $0x11,%eax
 620:	cd 40                	int    $0x40
 622:	c3                   	ret    

00000623 <unlink>:
SYSCALL(unlink)
 623:	b8 12 00 00 00       	mov    $0x12,%eax
 628:	cd 40                	int    $0x40
 62a:	c3                   	ret    

0000062b <fstat>:
SYSCALL(fstat)
 62b:	b8 08 00 00 00       	mov    $0x8,%eax
 630:	cd 40                	int    $0x40
 632:	c3                   	ret    

00000633 <link>:
SYSCALL(link)
 633:	b8 13 00 00 00       	mov    $0x13,%eax
 638:	cd 40                	int    $0x40
 63a:	c3                   	ret    

0000063b <mkdir>:
SYSCALL(mkdir)
 63b:	b8 14 00 00 00       	mov    $0x14,%eax
 640:	cd 40                	int    $0x40
 642:	c3                   	ret    

00000643 <chdir>:
SYSCALL(chdir)
 643:	b8 09 00 00 00       	mov    $0x9,%eax
 648:	cd 40                	int    $0x40
 64a:	c3                   	ret    

0000064b <dup>:
SYSCALL(dup)
 64b:	b8 0a 00 00 00       	mov    $0xa,%eax
 650:	cd 40                	int    $0x40
 652:	c3                   	ret    

00000653 <getpid>:
SYSCALL(getpid)
 653:	b8 0b 00 00 00       	mov    $0xb,%eax
 658:	cd 40                	int    $0x40
 65a:	c3                   	ret    

0000065b <sbrk>:
SYSCALL(sbrk)
 65b:	b8 0c 00 00 00       	mov    $0xc,%eax
 660:	cd 40                	int    $0x40
 662:	c3                   	ret    

00000663 <sleep>:
SYSCALL(sleep)
 663:	b8 0d 00 00 00       	mov    $0xd,%eax
 668:	cd 40                	int    $0x40
 66a:	c3                   	ret    

0000066b <uptime>:
SYSCALL(uptime)
 66b:	b8 0e 00 00 00       	mov    $0xe,%eax
 670:	cd 40                	int    $0x40
 672:	c3                   	ret    

00000673 <randomX>:
SYSCALL(randomX)
 673:	b8 16 00 00 00       	mov    $0x16,%eax
 678:	cd 40                	int    $0x40
 67a:	c3                   	ret    

0000067b <setSeedX>:
SYSCALL(setSeedX)
 67b:	b8 17 00 00 00       	mov    $0x17,%eax
 680:	cd 40                	int    $0x40
 682:	c3                   	ret    

00000683 <uniformR>:
SYSCALL(uniformR)
 683:	b8 18 00 00 00       	mov    $0x18,%eax
 688:	cd 40                	int    $0x40
 68a:	c3                   	ret    

0000068b <setdeadline>:
 68b:	b8 19 00 00 00       	mov    $0x19,%eax
 690:	cd 40                	int    $0x40
 692:	c3                   	ret    

00000693 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 693:	55                   	push   %ebp
 694:	89 e5                	mov    %esp,%ebp
 696:	83 ec 18             	sub    $0x18,%esp
 699:	8b 45 0c             	mov    0xc(%ebp),%eax
 69c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 69f:	83 ec 04             	sub    $0x4,%esp
 6a2:	6a 01                	push   $0x1
 6a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6a7:	50                   	push   %eax
 6a8:	ff 75 08             	pushl  0x8(%ebp)
 6ab:	e8 43 ff ff ff       	call   5f3 <write>
 6b0:	83 c4 10             	add    $0x10,%esp
}
 6b3:	90                   	nop
 6b4:	c9                   	leave  
 6b5:	c3                   	ret    

000006b6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b6:	55                   	push   %ebp
 6b7:	89 e5                	mov    %esp,%ebp
 6b9:	53                   	push   %ebx
 6ba:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6c4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6c8:	74 17                	je     6e1 <printint+0x2b>
 6ca:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6ce:	79 11                	jns    6e1 <printint+0x2b>
    neg = 1;
 6d0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 6da:	f7 d8                	neg    %eax
 6dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6df:	eb 06                	jmp    6e7 <printint+0x31>
  } else {
    x = xx;
 6e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 6e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6e7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6ee:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 6f1:	8d 41 01             	lea    0x1(%ecx),%eax
 6f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 6f7:	8b 5d 10             	mov    0x10(%ebp),%ebx
 6fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6fd:	ba 00 00 00 00       	mov    $0x0,%edx
 702:	f7 f3                	div    %ebx
 704:	89 d0                	mov    %edx,%eax
 706:	0f b6 80 5c 0e 00 00 	movzbl 0xe5c(%eax),%eax
 70d:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 711:	8b 5d 10             	mov    0x10(%ebp),%ebx
 714:	8b 45 ec             	mov    -0x14(%ebp),%eax
 717:	ba 00 00 00 00       	mov    $0x0,%edx
 71c:	f7 f3                	div    %ebx
 71e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 721:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 725:	75 c7                	jne    6ee <printint+0x38>
  if(neg)
 727:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 72b:	74 2d                	je     75a <printint+0xa4>
    buf[i++] = '-';
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	8d 50 01             	lea    0x1(%eax),%edx
 733:	89 55 f4             	mov    %edx,-0xc(%ebp)
 736:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 73b:	eb 1d                	jmp    75a <printint+0xa4>
    putc(fd, buf[i]);
 73d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 740:	8b 45 f4             	mov    -0xc(%ebp),%eax
 743:	01 d0                	add    %edx,%eax
 745:	0f b6 00             	movzbl (%eax),%eax
 748:	0f be c0             	movsbl %al,%eax
 74b:	83 ec 08             	sub    $0x8,%esp
 74e:	50                   	push   %eax
 74f:	ff 75 08             	pushl  0x8(%ebp)
 752:	e8 3c ff ff ff       	call   693 <putc>
 757:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 75a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 75e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 762:	79 d9                	jns    73d <printint+0x87>
    putc(fd, buf[i]);
}
 764:	90                   	nop
 765:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 768:	c9                   	leave  
 769:	c3                   	ret    

0000076a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 76a:	55                   	push   %ebp
 76b:	89 e5                	mov    %esp,%ebp
 76d:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 770:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 777:	8d 45 0c             	lea    0xc(%ebp),%eax
 77a:	83 c0 04             	add    $0x4,%eax
 77d:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 780:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 787:	e9 59 01 00 00       	jmp    8e5 <printf+0x17b>
    c = fmt[i] & 0xff;
 78c:	8b 55 0c             	mov    0xc(%ebp),%edx
 78f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 792:	01 d0                	add    %edx,%eax
 794:	0f b6 00             	movzbl (%eax),%eax
 797:	0f be c0             	movsbl %al,%eax
 79a:	25 ff 00 00 00       	and    $0xff,%eax
 79f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7a2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7a6:	75 2c                	jne    7d4 <printf+0x6a>
      if(c == '%'){
 7a8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ac:	75 0c                	jne    7ba <printf+0x50>
        state = '%';
 7ae:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7b5:	e9 27 01 00 00       	jmp    8e1 <printf+0x177>
      } else {
        putc(fd, c);
 7ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7bd:	0f be c0             	movsbl %al,%eax
 7c0:	83 ec 08             	sub    $0x8,%esp
 7c3:	50                   	push   %eax
 7c4:	ff 75 08             	pushl  0x8(%ebp)
 7c7:	e8 c7 fe ff ff       	call   693 <putc>
 7cc:	83 c4 10             	add    $0x10,%esp
 7cf:	e9 0d 01 00 00       	jmp    8e1 <printf+0x177>
      }
    } else if(state == '%'){
 7d4:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7d8:	0f 85 03 01 00 00    	jne    8e1 <printf+0x177>
      if(c == 'd'){
 7de:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7e2:	75 1e                	jne    802 <printf+0x98>
        printint(fd, *ap, 10, 1);
 7e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7e7:	8b 00                	mov    (%eax),%eax
 7e9:	6a 01                	push   $0x1
 7eb:	6a 0a                	push   $0xa
 7ed:	50                   	push   %eax
 7ee:	ff 75 08             	pushl  0x8(%ebp)
 7f1:	e8 c0 fe ff ff       	call   6b6 <printint>
 7f6:	83 c4 10             	add    $0x10,%esp
        ap++;
 7f9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7fd:	e9 d8 00 00 00       	jmp    8da <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 802:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 806:	74 06                	je     80e <printf+0xa4>
 808:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 80c:	75 1e                	jne    82c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 80e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 811:	8b 00                	mov    (%eax),%eax
 813:	6a 00                	push   $0x0
 815:	6a 10                	push   $0x10
 817:	50                   	push   %eax
 818:	ff 75 08             	pushl  0x8(%ebp)
 81b:	e8 96 fe ff ff       	call   6b6 <printint>
 820:	83 c4 10             	add    $0x10,%esp
        ap++;
 823:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 827:	e9 ae 00 00 00       	jmp    8da <printf+0x170>
      } else if(c == 's'){
 82c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 830:	75 43                	jne    875 <printf+0x10b>
        s = (char*)*ap;
 832:	8b 45 e8             	mov    -0x18(%ebp),%eax
 835:	8b 00                	mov    (%eax),%eax
 837:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 83a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 83e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 842:	75 25                	jne    869 <printf+0xff>
          s = "(null)";
 844:	c7 45 f4 67 0b 00 00 	movl   $0xb67,-0xc(%ebp)
        while(*s != 0){
 84b:	eb 1c                	jmp    869 <printf+0xff>
          putc(fd, *s);
 84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 850:	0f b6 00             	movzbl (%eax),%eax
 853:	0f be c0             	movsbl %al,%eax
 856:	83 ec 08             	sub    $0x8,%esp
 859:	50                   	push   %eax
 85a:	ff 75 08             	pushl  0x8(%ebp)
 85d:	e8 31 fe ff ff       	call   693 <putc>
 862:	83 c4 10             	add    $0x10,%esp
          s++;
 865:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 869:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86c:	0f b6 00             	movzbl (%eax),%eax
 86f:	84 c0                	test   %al,%al
 871:	75 da                	jne    84d <printf+0xe3>
 873:	eb 65                	jmp    8da <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 875:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 879:	75 1d                	jne    898 <printf+0x12e>
        putc(fd, *ap);
 87b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 87e:	8b 00                	mov    (%eax),%eax
 880:	0f be c0             	movsbl %al,%eax
 883:	83 ec 08             	sub    $0x8,%esp
 886:	50                   	push   %eax
 887:	ff 75 08             	pushl  0x8(%ebp)
 88a:	e8 04 fe ff ff       	call   693 <putc>
 88f:	83 c4 10             	add    $0x10,%esp
        ap++;
 892:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 896:	eb 42                	jmp    8da <printf+0x170>
      } else if(c == '%'){
 898:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 89c:	75 17                	jne    8b5 <printf+0x14b>
        putc(fd, c);
 89e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8a1:	0f be c0             	movsbl %al,%eax
 8a4:	83 ec 08             	sub    $0x8,%esp
 8a7:	50                   	push   %eax
 8a8:	ff 75 08             	pushl  0x8(%ebp)
 8ab:	e8 e3 fd ff ff       	call   693 <putc>
 8b0:	83 c4 10             	add    $0x10,%esp
 8b3:	eb 25                	jmp    8da <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8b5:	83 ec 08             	sub    $0x8,%esp
 8b8:	6a 25                	push   $0x25
 8ba:	ff 75 08             	pushl  0x8(%ebp)
 8bd:	e8 d1 fd ff ff       	call   693 <putc>
 8c2:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 8c5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8c8:	0f be c0             	movsbl %al,%eax
 8cb:	83 ec 08             	sub    $0x8,%esp
 8ce:	50                   	push   %eax
 8cf:	ff 75 08             	pushl  0x8(%ebp)
 8d2:	e8 bc fd ff ff       	call   693 <putc>
 8d7:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8da:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8e1:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8e5:	8b 55 0c             	mov    0xc(%ebp),%edx
 8e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8eb:	01 d0                	add    %edx,%eax
 8ed:	0f b6 00             	movzbl (%eax),%eax
 8f0:	84 c0                	test   %al,%al
 8f2:	0f 85 94 fe ff ff    	jne    78c <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 8f8:	90                   	nop
 8f9:	c9                   	leave  
 8fa:	c3                   	ret    

000008fb <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 8fb:	55                   	push   %ebp
 8fc:	89 e5                	mov    %esp,%ebp
 8fe:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 901:	8b 45 08             	mov    0x8(%ebp),%eax
 904:	83 e8 08             	sub    $0x8,%eax
 907:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 90a:	a1 a8 0e 00 00       	mov    0xea8,%eax
 90f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 912:	eb 24                	jmp    938 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 914:	8b 45 fc             	mov    -0x4(%ebp),%eax
 917:	8b 00                	mov    (%eax),%eax
 919:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 91c:	77 12                	ja     930 <free+0x35>
 91e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 921:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 924:	77 24                	ja     94a <free+0x4f>
 926:	8b 45 fc             	mov    -0x4(%ebp),%eax
 929:	8b 00                	mov    (%eax),%eax
 92b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 92e:	77 1a                	ja     94a <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 930:	8b 45 fc             	mov    -0x4(%ebp),%eax
 933:	8b 00                	mov    (%eax),%eax
 935:	89 45 fc             	mov    %eax,-0x4(%ebp)
 938:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 93e:	76 d4                	jbe    914 <free+0x19>
 940:	8b 45 fc             	mov    -0x4(%ebp),%eax
 943:	8b 00                	mov    (%eax),%eax
 945:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 948:	76 ca                	jbe    914 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 94a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 94d:	8b 40 04             	mov    0x4(%eax),%eax
 950:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 957:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95a:	01 c2                	add    %eax,%edx
 95c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95f:	8b 00                	mov    (%eax),%eax
 961:	39 c2                	cmp    %eax,%edx
 963:	75 24                	jne    989 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 965:	8b 45 f8             	mov    -0x8(%ebp),%eax
 968:	8b 50 04             	mov    0x4(%eax),%edx
 96b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 96e:	8b 00                	mov    (%eax),%eax
 970:	8b 40 04             	mov    0x4(%eax),%eax
 973:	01 c2                	add    %eax,%edx
 975:	8b 45 f8             	mov    -0x8(%ebp),%eax
 978:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 97b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97e:	8b 00                	mov    (%eax),%eax
 980:	8b 10                	mov    (%eax),%edx
 982:	8b 45 f8             	mov    -0x8(%ebp),%eax
 985:	89 10                	mov    %edx,(%eax)
 987:	eb 0a                	jmp    993 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 989:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98c:	8b 10                	mov    (%eax),%edx
 98e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 991:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 993:	8b 45 fc             	mov    -0x4(%ebp),%eax
 996:	8b 40 04             	mov    0x4(%eax),%eax
 999:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a3:	01 d0                	add    %edx,%eax
 9a5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9a8:	75 20                	jne    9ca <free+0xcf>
    p->s.size += bp->s.size;
 9aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ad:	8b 50 04             	mov    0x4(%eax),%edx
 9b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9b3:	8b 40 04             	mov    0x4(%eax),%eax
 9b6:	01 c2                	add    %eax,%edx
 9b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9bb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9c1:	8b 10                	mov    (%eax),%edx
 9c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c6:	89 10                	mov    %edx,(%eax)
 9c8:	eb 08                	jmp    9d2 <free+0xd7>
  } else
    p->s.ptr = bp;
 9ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9cd:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9d0:	89 10                	mov    %edx,(%eax)
  freep = p;
 9d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d5:	a3 a8 0e 00 00       	mov    %eax,0xea8
}
 9da:	90                   	nop
 9db:	c9                   	leave  
 9dc:	c3                   	ret    

000009dd <morecore>:

static Header*
morecore(uint nu)
{
 9dd:	55                   	push   %ebp
 9de:	89 e5                	mov    %esp,%ebp
 9e0:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9e3:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9ea:	77 07                	ja     9f3 <morecore+0x16>
    nu = 4096;
 9ec:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 9f3:	8b 45 08             	mov    0x8(%ebp),%eax
 9f6:	c1 e0 03             	shl    $0x3,%eax
 9f9:	83 ec 0c             	sub    $0xc,%esp
 9fc:	50                   	push   %eax
 9fd:	e8 59 fc ff ff       	call   65b <sbrk>
 a02:	83 c4 10             	add    $0x10,%esp
 a05:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a08:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a0c:	75 07                	jne    a15 <morecore+0x38>
    return 0;
 a0e:	b8 00 00 00 00       	mov    $0x0,%eax
 a13:	eb 26                	jmp    a3b <morecore+0x5e>
  hp = (Header*)p;
 a15:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a18:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a1b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a1e:	8b 55 08             	mov    0x8(%ebp),%edx
 a21:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a24:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a27:	83 c0 08             	add    $0x8,%eax
 a2a:	83 ec 0c             	sub    $0xc,%esp
 a2d:	50                   	push   %eax
 a2e:	e8 c8 fe ff ff       	call   8fb <free>
 a33:	83 c4 10             	add    $0x10,%esp
  return freep;
 a36:	a1 a8 0e 00 00       	mov    0xea8,%eax
}
 a3b:	c9                   	leave  
 a3c:	c3                   	ret    

00000a3d <malloc>:

void*
malloc(uint nbytes)
{
 a3d:	55                   	push   %ebp
 a3e:	89 e5                	mov    %esp,%ebp
 a40:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a43:	8b 45 08             	mov    0x8(%ebp),%eax
 a46:	83 c0 07             	add    $0x7,%eax
 a49:	c1 e8 03             	shr    $0x3,%eax
 a4c:	83 c0 01             	add    $0x1,%eax
 a4f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a52:	a1 a8 0e 00 00       	mov    0xea8,%eax
 a57:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a5a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a5e:	75 23                	jne    a83 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a60:	c7 45 f0 a0 0e 00 00 	movl   $0xea0,-0x10(%ebp)
 a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a6a:	a3 a8 0e 00 00       	mov    %eax,0xea8
 a6f:	a1 a8 0e 00 00       	mov    0xea8,%eax
 a74:	a3 a0 0e 00 00       	mov    %eax,0xea0
    base.s.size = 0;
 a79:	c7 05 a4 0e 00 00 00 	movl   $0x0,0xea4
 a80:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a83:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a86:	8b 00                	mov    (%eax),%eax
 a88:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8e:	8b 40 04             	mov    0x4(%eax),%eax
 a91:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a94:	72 4d                	jb     ae3 <malloc+0xa6>
      if(p->s.size == nunits)
 a96:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a99:	8b 40 04             	mov    0x4(%eax),%eax
 a9c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a9f:	75 0c                	jne    aad <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa4:	8b 10                	mov    (%eax),%edx
 aa6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa9:	89 10                	mov    %edx,(%eax)
 aab:	eb 26                	jmp    ad3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab0:	8b 40 04             	mov    0x4(%eax),%eax
 ab3:	2b 45 ec             	sub    -0x14(%ebp),%eax
 ab6:	89 c2                	mov    %eax,%edx
 ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abb:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac1:	8b 40 04             	mov    0x4(%eax),%eax
 ac4:	c1 e0 03             	shl    $0x3,%eax
 ac7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acd:	8b 55 ec             	mov    -0x14(%ebp),%edx
 ad0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 ad3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ad6:	a3 a8 0e 00 00       	mov    %eax,0xea8
      return (void*)(p + 1);
 adb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ade:	83 c0 08             	add    $0x8,%eax
 ae1:	eb 3b                	jmp    b1e <malloc+0xe1>
    }
    if(p == freep)
 ae3:	a1 a8 0e 00 00       	mov    0xea8,%eax
 ae8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 aeb:	75 1e                	jne    b0b <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 aed:	83 ec 0c             	sub    $0xc,%esp
 af0:	ff 75 ec             	pushl  -0x14(%ebp)
 af3:	e8 e5 fe ff ff       	call   9dd <morecore>
 af8:	83 c4 10             	add    $0x10,%esp
 afb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 afe:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b02:	75 07                	jne    b0b <malloc+0xce>
        return 0;
 b04:	b8 00 00 00 00       	mov    $0x0,%eax
 b09:	eb 13                	jmp    b1e <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b14:	8b 00                	mov    (%eax),%eax
 b16:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b19:	e9 6d ff ff ff       	jmp    a8b <malloc+0x4e>
}
 b1e:	c9                   	leave  
 b1f:	c3                   	ret    
