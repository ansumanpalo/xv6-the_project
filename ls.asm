
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;
  
  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	83 ec 0c             	sub    $0xc,%esp
   a:	ff 75 08             	pushl  0x8(%ebp)
   d:	e8 c9 03 00 00       	call   3db <strlen>
  12:	83 c4 10             	add    $0x10,%esp
  15:	89 c2                	mov    %eax,%edx
  17:	8b 45 08             	mov    0x8(%ebp),%eax
  1a:	01 d0                	add    %edx,%eax
  1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1f:	eb 04                	jmp    25 <fmtname+0x25>
  21:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  25:	8b 45 f4             	mov    -0xc(%ebp),%eax
  28:	3b 45 08             	cmp    0x8(%ebp),%eax
  2b:	72 0a                	jb     37 <fmtname+0x37>
  2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  30:	0f b6 00             	movzbl (%eax),%eax
  33:	3c 2f                	cmp    $0x2f,%al
  35:	75 ea                	jne    21 <fmtname+0x21>
    ;
  p++;
  37:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  
  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	ff 75 f4             	pushl  -0xc(%ebp)
  41:	e8 95 03 00 00       	call   3db <strlen>
  46:	83 c4 10             	add    $0x10,%esp
  49:	83 f8 0d             	cmp    $0xd,%eax
  4c:	76 05                	jbe    53 <fmtname+0x53>
    return p;
  4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  51:	eb 60                	jmp    b3 <fmtname+0xb3>
  memmove(buf, p, strlen(p));
  53:	83 ec 0c             	sub    $0xc,%esp
  56:	ff 75 f4             	pushl  -0xc(%ebp)
  59:	e8 7d 03 00 00       	call   3db <strlen>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	83 ec 04             	sub    $0x4,%esp
  64:	50                   	push   %eax
  65:	ff 75 f4             	pushl  -0xc(%ebp)
  68:	68 80 0e 00 00       	push   $0xe80
  6d:	e8 37 05 00 00       	call   5a9 <memmove>
  72:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  75:	83 ec 0c             	sub    $0xc,%esp
  78:	ff 75 f4             	pushl  -0xc(%ebp)
  7b:	e8 5b 03 00 00       	call   3db <strlen>
  80:	83 c4 10             	add    $0x10,%esp
  83:	ba 0e 00 00 00       	mov    $0xe,%edx
  88:	89 d3                	mov    %edx,%ebx
  8a:	29 c3                	sub    %eax,%ebx
  8c:	83 ec 0c             	sub    $0xc,%esp
  8f:	ff 75 f4             	pushl  -0xc(%ebp)
  92:	e8 44 03 00 00       	call   3db <strlen>
  97:	83 c4 10             	add    $0x10,%esp
  9a:	05 80 0e 00 00       	add    $0xe80,%eax
  9f:	83 ec 04             	sub    $0x4,%esp
  a2:	53                   	push   %ebx
  a3:	6a 20                	push   $0x20
  a5:	50                   	push   %eax
  a6:	e8 57 03 00 00       	call   402 <memset>
  ab:	83 c4 10             	add    $0x10,%esp
  return buf;
  ae:	b8 80 0e 00 00       	mov    $0xe80,%eax
}
  b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b6:	c9                   	leave  
  b7:	c3                   	ret    

000000b8 <ls>:

void
ls(char *path)
{
  b8:	55                   	push   %ebp
  b9:	89 e5                	mov    %esp,%ebp
  bb:	57                   	push   %edi
  bc:	56                   	push   %esi
  bd:	53                   	push   %ebx
  be:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  
  if((fd = open(path, 0)) < 0){
  c4:	83 ec 08             	sub    $0x8,%esp
  c7:	6a 00                	push   $0x0
  c9:	ff 75 08             	pushl  0x8(%ebp)
  cc:	e8 5d 05 00 00       	call   62e <open>
  d1:	83 c4 10             	add    $0x10,%esp
  d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  db:	79 1a                	jns    f7 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
  dd:	83 ec 04             	sub    $0x4,%esp
  e0:	ff 75 08             	pushl  0x8(%ebp)
  e3:	68 3b 0b 00 00       	push   $0xb3b
  e8:	6a 02                	push   $0x2
  ea:	e8 96 06 00 00       	call   785 <printf>
  ef:	83 c4 10             	add    $0x10,%esp
    return;
  f2:	e9 e3 01 00 00       	jmp    2da <ls+0x222>
  }
  
  if(fstat(fd, &st) < 0){
  f7:	83 ec 08             	sub    $0x8,%esp
  fa:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 100:	50                   	push   %eax
 101:	ff 75 e4             	pushl  -0x1c(%ebp)
 104:	e8 3d 05 00 00       	call   646 <fstat>
 109:	83 c4 10             	add    $0x10,%esp
 10c:	85 c0                	test   %eax,%eax
 10e:	79 28                	jns    138 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
 110:	83 ec 04             	sub    $0x4,%esp
 113:	ff 75 08             	pushl  0x8(%ebp)
 116:	68 4f 0b 00 00       	push   $0xb4f
 11b:	6a 02                	push   $0x2
 11d:	e8 63 06 00 00       	call   785 <printf>
 122:	83 c4 10             	add    $0x10,%esp
    close(fd);
 125:	83 ec 0c             	sub    $0xc,%esp
 128:	ff 75 e4             	pushl  -0x1c(%ebp)
 12b:	e8 e6 04 00 00       	call   616 <close>
 130:	83 c4 10             	add    $0x10,%esp
    return;
 133:	e9 a2 01 00 00       	jmp    2da <ls+0x222>
  }
  
  switch(st.type){
 138:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 13f:	98                   	cwtl   
 140:	83 f8 01             	cmp    $0x1,%eax
 143:	74 48                	je     18d <ls+0xd5>
 145:	83 f8 02             	cmp    $0x2,%eax
 148:	0f 85 7e 01 00 00    	jne    2cc <ls+0x214>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 14e:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 154:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 15a:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 161:	0f bf d8             	movswl %ax,%ebx
 164:	83 ec 0c             	sub    $0xc,%esp
 167:	ff 75 08             	pushl  0x8(%ebp)
 16a:	e8 91 fe ff ff       	call   0 <fmtname>
 16f:	83 c4 10             	add    $0x10,%esp
 172:	83 ec 08             	sub    $0x8,%esp
 175:	57                   	push   %edi
 176:	56                   	push   %esi
 177:	53                   	push   %ebx
 178:	50                   	push   %eax
 179:	68 63 0b 00 00       	push   $0xb63
 17e:	6a 01                	push   $0x1
 180:	e8 00 06 00 00       	call   785 <printf>
 185:	83 c4 20             	add    $0x20,%esp
    break;
 188:	e9 3f 01 00 00       	jmp    2cc <ls+0x214>
  
  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 18d:	83 ec 0c             	sub    $0xc,%esp
 190:	ff 75 08             	pushl  0x8(%ebp)
 193:	e8 43 02 00 00       	call   3db <strlen>
 198:	83 c4 10             	add    $0x10,%esp
 19b:	83 c0 10             	add    $0x10,%eax
 19e:	3d 00 02 00 00       	cmp    $0x200,%eax
 1a3:	76 17                	jbe    1bc <ls+0x104>
      printf(1, "ls: path too long\n");
 1a5:	83 ec 08             	sub    $0x8,%esp
 1a8:	68 70 0b 00 00       	push   $0xb70
 1ad:	6a 01                	push   $0x1
 1af:	e8 d1 05 00 00       	call   785 <printf>
 1b4:	83 c4 10             	add    $0x10,%esp
      break;
 1b7:	e9 10 01 00 00       	jmp    2cc <ls+0x214>
    }
    strcpy(buf, path);
 1bc:	83 ec 08             	sub    $0x8,%esp
 1bf:	ff 75 08             	pushl  0x8(%ebp)
 1c2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1c8:	50                   	push   %eax
 1c9:	e8 9e 01 00 00       	call   36c <strcpy>
 1ce:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1d1:	83 ec 0c             	sub    $0xc,%esp
 1d4:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1da:	50                   	push   %eax
 1db:	e8 fb 01 00 00       	call   3db <strlen>
 1e0:	83 c4 10             	add    $0x10,%esp
 1e3:	89 c2                	mov    %eax,%edx
 1e5:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1eb:	01 d0                	add    %edx,%eax
 1ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1f3:	8d 50 01             	lea    0x1(%eax),%edx
 1f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
 1f9:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1fc:	e9 aa 00 00 00       	jmp    2ab <ls+0x1f3>
      if(de.inum == 0)
 201:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 208:	66 85 c0             	test   %ax,%ax
 20b:	75 05                	jne    212 <ls+0x15a>
        continue;
 20d:	e9 99 00 00 00       	jmp    2ab <ls+0x1f3>
      memmove(p, de.name, DIRSIZ);
 212:	83 ec 04             	sub    $0x4,%esp
 215:	6a 0e                	push   $0xe
 217:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 21d:	83 c0 02             	add    $0x2,%eax
 220:	50                   	push   %eax
 221:	ff 75 e0             	pushl  -0x20(%ebp)
 224:	e8 80 03 00 00       	call   5a9 <memmove>
 229:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
 22c:	8b 45 e0             	mov    -0x20(%ebp),%eax
 22f:	83 c0 0e             	add    $0xe,%eax
 232:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 235:	83 ec 08             	sub    $0x8,%esp
 238:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 23e:	50                   	push   %eax
 23f:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 245:	50                   	push   %eax
 246:	e8 73 02 00 00       	call   4be <stat>
 24b:	83 c4 10             	add    $0x10,%esp
 24e:	85 c0                	test   %eax,%eax
 250:	79 1b                	jns    26d <ls+0x1b5>
        printf(1, "ls: cannot stat %s\n", buf);
 252:	83 ec 04             	sub    $0x4,%esp
 255:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 25b:	50                   	push   %eax
 25c:	68 4f 0b 00 00       	push   $0xb4f
 261:	6a 01                	push   $0x1
 263:	e8 1d 05 00 00       	call   785 <printf>
 268:	83 c4 10             	add    $0x10,%esp
        continue;
 26b:	eb 3e                	jmp    2ab <ls+0x1f3>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 26d:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 273:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 279:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 280:	0f bf d8             	movswl %ax,%ebx
 283:	83 ec 0c             	sub    $0xc,%esp
 286:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 28c:	50                   	push   %eax
 28d:	e8 6e fd ff ff       	call   0 <fmtname>
 292:	83 c4 10             	add    $0x10,%esp
 295:	83 ec 08             	sub    $0x8,%esp
 298:	57                   	push   %edi
 299:	56                   	push   %esi
 29a:	53                   	push   %ebx
 29b:	50                   	push   %eax
 29c:	68 63 0b 00 00       	push   $0xb63
 2a1:	6a 01                	push   $0x1
 2a3:	e8 dd 04 00 00       	call   785 <printf>
 2a8:	83 c4 20             	add    $0x20,%esp
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2ab:	83 ec 04             	sub    $0x4,%esp
 2ae:	6a 10                	push   $0x10
 2b0:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2b6:	50                   	push   %eax
 2b7:	ff 75 e4             	pushl  -0x1c(%ebp)
 2ba:	e8 47 03 00 00       	call   606 <read>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	83 f8 10             	cmp    $0x10,%eax
 2c5:	0f 84 36 ff ff ff    	je     201 <ls+0x149>
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
 2cb:	90                   	nop
  }
  close(fd);
 2cc:	83 ec 0c             	sub    $0xc,%esp
 2cf:	ff 75 e4             	pushl  -0x1c(%ebp)
 2d2:	e8 3f 03 00 00       	call   616 <close>
 2d7:	83 c4 10             	add    $0x10,%esp
}
 2da:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2dd:	5b                   	pop    %ebx
 2de:	5e                   	pop    %esi
 2df:	5f                   	pop    %edi
 2e0:	5d                   	pop    %ebp
 2e1:	c3                   	ret    

000002e2 <main>:

int
main(int argc, char *argv[])
{
 2e2:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2e6:	83 e4 f0             	and    $0xfffffff0,%esp
 2e9:	ff 71 fc             	pushl  -0x4(%ecx)
 2ec:	55                   	push   %ebp
 2ed:	89 e5                	mov    %esp,%ebp
 2ef:	53                   	push   %ebx
 2f0:	51                   	push   %ecx
 2f1:	83 ec 10             	sub    $0x10,%esp
 2f4:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
 2f6:	83 3b 01             	cmpl   $0x1,(%ebx)
 2f9:	7f 15                	jg     310 <main+0x2e>
    ls(".");
 2fb:	83 ec 0c             	sub    $0xc,%esp
 2fe:	68 83 0b 00 00       	push   $0xb83
 303:	e8 b0 fd ff ff       	call   b8 <ls>
 308:	83 c4 10             	add    $0x10,%esp
    exit();
 30b:	e8 de 02 00 00       	call   5ee <exit>
  }
  for(i=1; i<argc; i++)
 310:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 317:	eb 21                	jmp    33a <main+0x58>
    ls(argv[i]);
 319:	8b 45 f4             	mov    -0xc(%ebp),%eax
 31c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 323:	8b 43 04             	mov    0x4(%ebx),%eax
 326:	01 d0                	add    %edx,%eax
 328:	8b 00                	mov    (%eax),%eax
 32a:	83 ec 0c             	sub    $0xc,%esp
 32d:	50                   	push   %eax
 32e:	e8 85 fd ff ff       	call   b8 <ls>
 333:	83 c4 10             	add    $0x10,%esp

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
 336:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 33a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 33d:	3b 03                	cmp    (%ebx),%eax
 33f:	7c d8                	jl     319 <main+0x37>
    ls(argv[i]);
  exit();
 341:	e8 a8 02 00 00       	call   5ee <exit>

00000346 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	57                   	push   %edi
 34a:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 34b:	8b 4d 08             	mov    0x8(%ebp),%ecx
 34e:	8b 55 10             	mov    0x10(%ebp),%edx
 351:	8b 45 0c             	mov    0xc(%ebp),%eax
 354:	89 cb                	mov    %ecx,%ebx
 356:	89 df                	mov    %ebx,%edi
 358:	89 d1                	mov    %edx,%ecx
 35a:	fc                   	cld    
 35b:	f3 aa                	rep stos %al,%es:(%edi)
 35d:	89 ca                	mov    %ecx,%edx
 35f:	89 fb                	mov    %edi,%ebx
 361:	89 5d 08             	mov    %ebx,0x8(%ebp)
 364:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 367:	90                   	nop
 368:	5b                   	pop    %ebx
 369:	5f                   	pop    %edi
 36a:	5d                   	pop    %ebp
 36b:	c3                   	ret    

0000036c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 36c:	55                   	push   %ebp
 36d:	89 e5                	mov    %esp,%ebp
 36f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 372:	8b 45 08             	mov    0x8(%ebp),%eax
 375:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 378:	90                   	nop
 379:	8b 45 08             	mov    0x8(%ebp),%eax
 37c:	8d 50 01             	lea    0x1(%eax),%edx
 37f:	89 55 08             	mov    %edx,0x8(%ebp)
 382:	8b 55 0c             	mov    0xc(%ebp),%edx
 385:	8d 4a 01             	lea    0x1(%edx),%ecx
 388:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 38b:	0f b6 12             	movzbl (%edx),%edx
 38e:	88 10                	mov    %dl,(%eax)
 390:	0f b6 00             	movzbl (%eax),%eax
 393:	84 c0                	test   %al,%al
 395:	75 e2                	jne    379 <strcpy+0xd>
    ;
  return os;
 397:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 39a:	c9                   	leave  
 39b:	c3                   	ret    

0000039c <strcmp>:

int
strcmp(const char *p, const char *q)
{
 39c:	55                   	push   %ebp
 39d:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 39f:	eb 08                	jmp    3a9 <strcmp+0xd>
    p++, q++;
 3a1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3a5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 3a9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ac:	0f b6 00             	movzbl (%eax),%eax
 3af:	84 c0                	test   %al,%al
 3b1:	74 10                	je     3c3 <strcmp+0x27>
 3b3:	8b 45 08             	mov    0x8(%ebp),%eax
 3b6:	0f b6 10             	movzbl (%eax),%edx
 3b9:	8b 45 0c             	mov    0xc(%ebp),%eax
 3bc:	0f b6 00             	movzbl (%eax),%eax
 3bf:	38 c2                	cmp    %al,%dl
 3c1:	74 de                	je     3a1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 3c3:	8b 45 08             	mov    0x8(%ebp),%eax
 3c6:	0f b6 00             	movzbl (%eax),%eax
 3c9:	0f b6 d0             	movzbl %al,%edx
 3cc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cf:	0f b6 00             	movzbl (%eax),%eax
 3d2:	0f b6 c0             	movzbl %al,%eax
 3d5:	29 c2                	sub    %eax,%edx
 3d7:	89 d0                	mov    %edx,%eax
}
 3d9:	5d                   	pop    %ebp
 3da:	c3                   	ret    

000003db <strlen>:

uint
strlen(char *s)
{
 3db:	55                   	push   %ebp
 3dc:	89 e5                	mov    %esp,%ebp
 3de:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3e8:	eb 04                	jmp    3ee <strlen+0x13>
 3ea:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3ee:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	01 d0                	add    %edx,%eax
 3f6:	0f b6 00             	movzbl (%eax),%eax
 3f9:	84 c0                	test   %al,%al
 3fb:	75 ed                	jne    3ea <strlen+0xf>
    ;
  return n;
 3fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 400:	c9                   	leave  
 401:	c3                   	ret    

00000402 <memset>:

void*
memset(void *dst, int c, uint n)
{
 402:	55                   	push   %ebp
 403:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 405:	8b 45 10             	mov    0x10(%ebp),%eax
 408:	50                   	push   %eax
 409:	ff 75 0c             	pushl  0xc(%ebp)
 40c:	ff 75 08             	pushl  0x8(%ebp)
 40f:	e8 32 ff ff ff       	call   346 <stosb>
 414:	83 c4 0c             	add    $0xc,%esp
  return dst;
 417:	8b 45 08             	mov    0x8(%ebp),%eax
}
 41a:	c9                   	leave  
 41b:	c3                   	ret    

0000041c <strchr>:

char*
strchr(const char *s, char c)
{
 41c:	55                   	push   %ebp
 41d:	89 e5                	mov    %esp,%ebp
 41f:	83 ec 04             	sub    $0x4,%esp
 422:	8b 45 0c             	mov    0xc(%ebp),%eax
 425:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 428:	eb 14                	jmp    43e <strchr+0x22>
    if(*s == c)
 42a:	8b 45 08             	mov    0x8(%ebp),%eax
 42d:	0f b6 00             	movzbl (%eax),%eax
 430:	3a 45 fc             	cmp    -0x4(%ebp),%al
 433:	75 05                	jne    43a <strchr+0x1e>
      return (char*)s;
 435:	8b 45 08             	mov    0x8(%ebp),%eax
 438:	eb 13                	jmp    44d <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 43a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 43e:	8b 45 08             	mov    0x8(%ebp),%eax
 441:	0f b6 00             	movzbl (%eax),%eax
 444:	84 c0                	test   %al,%al
 446:	75 e2                	jne    42a <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 448:	b8 00 00 00 00       	mov    $0x0,%eax
}
 44d:	c9                   	leave  
 44e:	c3                   	ret    

0000044f <gets>:

char*
gets(char *buf, int max)
{
 44f:	55                   	push   %ebp
 450:	89 e5                	mov    %esp,%ebp
 452:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 455:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 45c:	eb 42                	jmp    4a0 <gets+0x51>
    cc = read(0, &c, 1);
 45e:	83 ec 04             	sub    $0x4,%esp
 461:	6a 01                	push   $0x1
 463:	8d 45 ef             	lea    -0x11(%ebp),%eax
 466:	50                   	push   %eax
 467:	6a 00                	push   $0x0
 469:	e8 98 01 00 00       	call   606 <read>
 46e:	83 c4 10             	add    $0x10,%esp
 471:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 474:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 478:	7e 33                	jle    4ad <gets+0x5e>
      break;
    buf[i++] = c;
 47a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 47d:	8d 50 01             	lea    0x1(%eax),%edx
 480:	89 55 f4             	mov    %edx,-0xc(%ebp)
 483:	89 c2                	mov    %eax,%edx
 485:	8b 45 08             	mov    0x8(%ebp),%eax
 488:	01 c2                	add    %eax,%edx
 48a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 48e:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 490:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 494:	3c 0a                	cmp    $0xa,%al
 496:	74 16                	je     4ae <gets+0x5f>
 498:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 49c:	3c 0d                	cmp    $0xd,%al
 49e:	74 0e                	je     4ae <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a3:	83 c0 01             	add    $0x1,%eax
 4a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
 4a9:	7c b3                	jl     45e <gets+0xf>
 4ab:	eb 01                	jmp    4ae <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 4ad:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 4ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4b1:	8b 45 08             	mov    0x8(%ebp),%eax
 4b4:	01 d0                	add    %edx,%eax
 4b6:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4b9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4bc:	c9                   	leave  
 4bd:	c3                   	ret    

000004be <stat>:

int
stat(char *n, struct stat *st)
{
 4be:	55                   	push   %ebp
 4bf:	89 e5                	mov    %esp,%ebp
 4c1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c4:	83 ec 08             	sub    $0x8,%esp
 4c7:	6a 00                	push   $0x0
 4c9:	ff 75 08             	pushl  0x8(%ebp)
 4cc:	e8 5d 01 00 00       	call   62e <open>
 4d1:	83 c4 10             	add    $0x10,%esp
 4d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4db:	79 07                	jns    4e4 <stat+0x26>
    return -1;
 4dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4e2:	eb 25                	jmp    509 <stat+0x4b>
  r = fstat(fd, st);
 4e4:	83 ec 08             	sub    $0x8,%esp
 4e7:	ff 75 0c             	pushl  0xc(%ebp)
 4ea:	ff 75 f4             	pushl  -0xc(%ebp)
 4ed:	e8 54 01 00 00       	call   646 <fstat>
 4f2:	83 c4 10             	add    $0x10,%esp
 4f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	ff 75 f4             	pushl  -0xc(%ebp)
 4fe:	e8 13 01 00 00       	call   616 <close>
 503:	83 c4 10             	add    $0x10,%esp
  return r;
 506:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 509:	c9                   	leave  
 50a:	c3                   	ret    

0000050b <atoi>:

int
atoi(const char *s)
{
 50b:	55                   	push   %ebp
 50c:	89 e5                	mov    %esp,%ebp
 50e:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 511:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 518:	eb 25                	jmp    53f <atoi+0x34>
    n = n*10 + *s++ - '0';
 51a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 51d:	89 d0                	mov    %edx,%eax
 51f:	c1 e0 02             	shl    $0x2,%eax
 522:	01 d0                	add    %edx,%eax
 524:	01 c0                	add    %eax,%eax
 526:	89 c1                	mov    %eax,%ecx
 528:	8b 45 08             	mov    0x8(%ebp),%eax
 52b:	8d 50 01             	lea    0x1(%eax),%edx
 52e:	89 55 08             	mov    %edx,0x8(%ebp)
 531:	0f b6 00             	movzbl (%eax),%eax
 534:	0f be c0             	movsbl %al,%eax
 537:	01 c8                	add    %ecx,%eax
 539:	83 e8 30             	sub    $0x30,%eax
 53c:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 53f:	8b 45 08             	mov    0x8(%ebp),%eax
 542:	0f b6 00             	movzbl (%eax),%eax
 545:	3c 2f                	cmp    $0x2f,%al
 547:	7e 0a                	jle    553 <atoi+0x48>
 549:	8b 45 08             	mov    0x8(%ebp),%eax
 54c:	0f b6 00             	movzbl (%eax),%eax
 54f:	3c 39                	cmp    $0x39,%al
 551:	7e c7                	jle    51a <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 553:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 556:	c9                   	leave  
 557:	c3                   	ret    

00000558 <itoa>:

char*
itoa(int val, int base){
 558:	55                   	push   %ebp
 559:	89 e5                	mov    %esp,%ebp
 55b:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 55e:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 565:	eb 29                	jmp    590 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 567:	8b 45 08             	mov    0x8(%ebp),%eax
 56a:	99                   	cltd   
 56b:	f7 7d 0c             	idivl  0xc(%ebp)
 56e:	89 d0                	mov    %edx,%eax
 570:	0f b6 80 85 0b 00 00 	movzbl 0xb85(%eax),%eax
 577:	8b 55 fc             	mov    -0x4(%ebp),%edx
 57a:	81 c2 a0 0e 00 00    	add    $0xea0,%edx
 580:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 582:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 586:	8b 45 08             	mov    0x8(%ebp),%eax
 589:	99                   	cltd   
 58a:	f7 7d 0c             	idivl  0xc(%ebp)
 58d:	89 45 08             	mov    %eax,0x8(%ebp)
 590:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 594:	74 06                	je     59c <itoa+0x44>
 596:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 59a:	75 cb                	jne    567 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 59c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 59f:	83 c0 01             	add    $0x1,%eax
 5a2:	05 a0 0e 00 00       	add    $0xea0,%eax

}
 5a7:	c9                   	leave  
 5a8:	c3                   	ret    

000005a9 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 5a9:	55                   	push   %ebp
 5aa:	89 e5                	mov    %esp,%ebp
 5ac:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 5af:	8b 45 08             	mov    0x8(%ebp),%eax
 5b2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 5b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 5b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 5bb:	eb 17                	jmp    5d4 <memmove+0x2b>
    *dst++ = *src++;
 5bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5c0:	8d 50 01             	lea    0x1(%eax),%edx
 5c3:	89 55 fc             	mov    %edx,-0x4(%ebp)
 5c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 5c9:	8d 4a 01             	lea    0x1(%edx),%ecx
 5cc:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 5cf:	0f b6 12             	movzbl (%edx),%edx
 5d2:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5d4:	8b 45 10             	mov    0x10(%ebp),%eax
 5d7:	8d 50 ff             	lea    -0x1(%eax),%edx
 5da:	89 55 10             	mov    %edx,0x10(%ebp)
 5dd:	85 c0                	test   %eax,%eax
 5df:	7f dc                	jg     5bd <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 5e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
 5e4:	c9                   	leave  
 5e5:	c3                   	ret    

000005e6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5e6:	b8 01 00 00 00       	mov    $0x1,%eax
 5eb:	cd 40                	int    $0x40
 5ed:	c3                   	ret    

000005ee <exit>:
SYSCALL(exit)
 5ee:	b8 02 00 00 00       	mov    $0x2,%eax
 5f3:	cd 40                	int    $0x40
 5f5:	c3                   	ret    

000005f6 <wait>:
SYSCALL(wait)
 5f6:	b8 03 00 00 00       	mov    $0x3,%eax
 5fb:	cd 40                	int    $0x40
 5fd:	c3                   	ret    

000005fe <pipe>:
SYSCALL(pipe)
 5fe:	b8 04 00 00 00       	mov    $0x4,%eax
 603:	cd 40                	int    $0x40
 605:	c3                   	ret    

00000606 <read>:
SYSCALL(read)
 606:	b8 05 00 00 00       	mov    $0x5,%eax
 60b:	cd 40                	int    $0x40
 60d:	c3                   	ret    

0000060e <write>:
SYSCALL(write)
 60e:	b8 10 00 00 00       	mov    $0x10,%eax
 613:	cd 40                	int    $0x40
 615:	c3                   	ret    

00000616 <close>:
SYSCALL(close)
 616:	b8 15 00 00 00       	mov    $0x15,%eax
 61b:	cd 40                	int    $0x40
 61d:	c3                   	ret    

0000061e <kill>:
SYSCALL(kill)
 61e:	b8 06 00 00 00       	mov    $0x6,%eax
 623:	cd 40                	int    $0x40
 625:	c3                   	ret    

00000626 <exec>:
SYSCALL(exec)
 626:	b8 07 00 00 00       	mov    $0x7,%eax
 62b:	cd 40                	int    $0x40
 62d:	c3                   	ret    

0000062e <open>:
SYSCALL(open)
 62e:	b8 0f 00 00 00       	mov    $0xf,%eax
 633:	cd 40                	int    $0x40
 635:	c3                   	ret    

00000636 <mknod>:
SYSCALL(mknod)
 636:	b8 11 00 00 00       	mov    $0x11,%eax
 63b:	cd 40                	int    $0x40
 63d:	c3                   	ret    

0000063e <unlink>:
SYSCALL(unlink)
 63e:	b8 12 00 00 00       	mov    $0x12,%eax
 643:	cd 40                	int    $0x40
 645:	c3                   	ret    

00000646 <fstat>:
SYSCALL(fstat)
 646:	b8 08 00 00 00       	mov    $0x8,%eax
 64b:	cd 40                	int    $0x40
 64d:	c3                   	ret    

0000064e <link>:
SYSCALL(link)
 64e:	b8 13 00 00 00       	mov    $0x13,%eax
 653:	cd 40                	int    $0x40
 655:	c3                   	ret    

00000656 <mkdir>:
SYSCALL(mkdir)
 656:	b8 14 00 00 00       	mov    $0x14,%eax
 65b:	cd 40                	int    $0x40
 65d:	c3                   	ret    

0000065e <chdir>:
SYSCALL(chdir)
 65e:	b8 09 00 00 00       	mov    $0x9,%eax
 663:	cd 40                	int    $0x40
 665:	c3                   	ret    

00000666 <dup>:
SYSCALL(dup)
 666:	b8 0a 00 00 00       	mov    $0xa,%eax
 66b:	cd 40                	int    $0x40
 66d:	c3                   	ret    

0000066e <getpid>:
SYSCALL(getpid)
 66e:	b8 0b 00 00 00       	mov    $0xb,%eax
 673:	cd 40                	int    $0x40
 675:	c3                   	ret    

00000676 <sbrk>:
SYSCALL(sbrk)
 676:	b8 0c 00 00 00       	mov    $0xc,%eax
 67b:	cd 40                	int    $0x40
 67d:	c3                   	ret    

0000067e <sleep>:
SYSCALL(sleep)
 67e:	b8 0d 00 00 00       	mov    $0xd,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <uptime>:
SYSCALL(uptime)
 686:	b8 0e 00 00 00       	mov    $0xe,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <randomX>:
SYSCALL(randomX)
 68e:	b8 16 00 00 00       	mov    $0x16,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <setSeedX>:
SYSCALL(setSeedX)
 696:	b8 17 00 00 00       	mov    $0x17,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <uniformR>:
SYSCALL(uniformR)
 69e:	b8 18 00 00 00       	mov    $0x18,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <setdeadline>:
 6a6:	b8 19 00 00 00       	mov    $0x19,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 6ae:	55                   	push   %ebp
 6af:	89 e5                	mov    %esp,%ebp
 6b1:	83 ec 18             	sub    $0x18,%esp
 6b4:	8b 45 0c             	mov    0xc(%ebp),%eax
 6b7:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 6ba:	83 ec 04             	sub    $0x4,%esp
 6bd:	6a 01                	push   $0x1
 6bf:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6c2:	50                   	push   %eax
 6c3:	ff 75 08             	pushl  0x8(%ebp)
 6c6:	e8 43 ff ff ff       	call   60e <write>
 6cb:	83 c4 10             	add    $0x10,%esp
}
 6ce:	90                   	nop
 6cf:	c9                   	leave  
 6d0:	c3                   	ret    

000006d1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6d1:	55                   	push   %ebp
 6d2:	89 e5                	mov    %esp,%ebp
 6d4:	53                   	push   %ebx
 6d5:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6d8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6df:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6e3:	74 17                	je     6fc <printint+0x2b>
 6e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6e9:	79 11                	jns    6fc <printint+0x2b>
    neg = 1;
 6eb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6f2:	8b 45 0c             	mov    0xc(%ebp),%eax
 6f5:	f7 d8                	neg    %eax
 6f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6fa:	eb 06                	jmp    702 <printint+0x31>
  } else {
    x = xx;
 6fc:	8b 45 0c             	mov    0xc(%ebp),%eax
 6ff:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 702:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 709:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 70c:	8d 41 01             	lea    0x1(%ecx),%eax
 70f:	89 45 f4             	mov    %eax,-0xc(%ebp)
 712:	8b 5d 10             	mov    0x10(%ebp),%ebx
 715:	8b 45 ec             	mov    -0x14(%ebp),%eax
 718:	ba 00 00 00 00       	mov    $0x0,%edx
 71d:	f7 f3                	div    %ebx
 71f:	89 d0                	mov    %edx,%eax
 721:	0f b6 80 60 0e 00 00 	movzbl 0xe60(%eax),%eax
 728:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 72c:	8b 5d 10             	mov    0x10(%ebp),%ebx
 72f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 732:	ba 00 00 00 00       	mov    $0x0,%edx
 737:	f7 f3                	div    %ebx
 739:	89 45 ec             	mov    %eax,-0x14(%ebp)
 73c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 740:	75 c7                	jne    709 <printint+0x38>
  if(neg)
 742:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 746:	74 2d                	je     775 <printint+0xa4>
    buf[i++] = '-';
 748:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74b:	8d 50 01             	lea    0x1(%eax),%edx
 74e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 751:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 756:	eb 1d                	jmp    775 <printint+0xa4>
    putc(fd, buf[i]);
 758:	8d 55 dc             	lea    -0x24(%ebp),%edx
 75b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75e:	01 d0                	add    %edx,%eax
 760:	0f b6 00             	movzbl (%eax),%eax
 763:	0f be c0             	movsbl %al,%eax
 766:	83 ec 08             	sub    $0x8,%esp
 769:	50                   	push   %eax
 76a:	ff 75 08             	pushl  0x8(%ebp)
 76d:	e8 3c ff ff ff       	call   6ae <putc>
 772:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 775:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 779:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 77d:	79 d9                	jns    758 <printint+0x87>
    putc(fd, buf[i]);
}
 77f:	90                   	nop
 780:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 783:	c9                   	leave  
 784:	c3                   	ret    

00000785 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 785:	55                   	push   %ebp
 786:	89 e5                	mov    %esp,%ebp
 788:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 78b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 792:	8d 45 0c             	lea    0xc(%ebp),%eax
 795:	83 c0 04             	add    $0x4,%eax
 798:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 79b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7a2:	e9 59 01 00 00       	jmp    900 <printf+0x17b>
    c = fmt[i] & 0xff;
 7a7:	8b 55 0c             	mov    0xc(%ebp),%edx
 7aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ad:	01 d0                	add    %edx,%eax
 7af:	0f b6 00             	movzbl (%eax),%eax
 7b2:	0f be c0             	movsbl %al,%eax
 7b5:	25 ff 00 00 00       	and    $0xff,%eax
 7ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7bd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7c1:	75 2c                	jne    7ef <printf+0x6a>
      if(c == '%'){
 7c3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7c7:	75 0c                	jne    7d5 <printf+0x50>
        state = '%';
 7c9:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7d0:	e9 27 01 00 00       	jmp    8fc <printf+0x177>
      } else {
        putc(fd, c);
 7d5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7d8:	0f be c0             	movsbl %al,%eax
 7db:	83 ec 08             	sub    $0x8,%esp
 7de:	50                   	push   %eax
 7df:	ff 75 08             	pushl  0x8(%ebp)
 7e2:	e8 c7 fe ff ff       	call   6ae <putc>
 7e7:	83 c4 10             	add    $0x10,%esp
 7ea:	e9 0d 01 00 00       	jmp    8fc <printf+0x177>
      }
    } else if(state == '%'){
 7ef:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7f3:	0f 85 03 01 00 00    	jne    8fc <printf+0x177>
      if(c == 'd'){
 7f9:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7fd:	75 1e                	jne    81d <printf+0x98>
        printint(fd, *ap, 10, 1);
 7ff:	8b 45 e8             	mov    -0x18(%ebp),%eax
 802:	8b 00                	mov    (%eax),%eax
 804:	6a 01                	push   $0x1
 806:	6a 0a                	push   $0xa
 808:	50                   	push   %eax
 809:	ff 75 08             	pushl  0x8(%ebp)
 80c:	e8 c0 fe ff ff       	call   6d1 <printint>
 811:	83 c4 10             	add    $0x10,%esp
        ap++;
 814:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 818:	e9 d8 00 00 00       	jmp    8f5 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 81d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 821:	74 06                	je     829 <printf+0xa4>
 823:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 827:	75 1e                	jne    847 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 829:	8b 45 e8             	mov    -0x18(%ebp),%eax
 82c:	8b 00                	mov    (%eax),%eax
 82e:	6a 00                	push   $0x0
 830:	6a 10                	push   $0x10
 832:	50                   	push   %eax
 833:	ff 75 08             	pushl  0x8(%ebp)
 836:	e8 96 fe ff ff       	call   6d1 <printint>
 83b:	83 c4 10             	add    $0x10,%esp
        ap++;
 83e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 842:	e9 ae 00 00 00       	jmp    8f5 <printf+0x170>
      } else if(c == 's'){
 847:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 84b:	75 43                	jne    890 <printf+0x10b>
        s = (char*)*ap;
 84d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 850:	8b 00                	mov    (%eax),%eax
 852:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 855:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 859:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85d:	75 25                	jne    884 <printf+0xff>
          s = "(null)";
 85f:	c7 45 f4 96 0b 00 00 	movl   $0xb96,-0xc(%ebp)
        while(*s != 0){
 866:	eb 1c                	jmp    884 <printf+0xff>
          putc(fd, *s);
 868:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86b:	0f b6 00             	movzbl (%eax),%eax
 86e:	0f be c0             	movsbl %al,%eax
 871:	83 ec 08             	sub    $0x8,%esp
 874:	50                   	push   %eax
 875:	ff 75 08             	pushl  0x8(%ebp)
 878:	e8 31 fe ff ff       	call   6ae <putc>
 87d:	83 c4 10             	add    $0x10,%esp
          s++;
 880:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 884:	8b 45 f4             	mov    -0xc(%ebp),%eax
 887:	0f b6 00             	movzbl (%eax),%eax
 88a:	84 c0                	test   %al,%al
 88c:	75 da                	jne    868 <printf+0xe3>
 88e:	eb 65                	jmp    8f5 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 890:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 894:	75 1d                	jne    8b3 <printf+0x12e>
        putc(fd, *ap);
 896:	8b 45 e8             	mov    -0x18(%ebp),%eax
 899:	8b 00                	mov    (%eax),%eax
 89b:	0f be c0             	movsbl %al,%eax
 89e:	83 ec 08             	sub    $0x8,%esp
 8a1:	50                   	push   %eax
 8a2:	ff 75 08             	pushl  0x8(%ebp)
 8a5:	e8 04 fe ff ff       	call   6ae <putc>
 8aa:	83 c4 10             	add    $0x10,%esp
        ap++;
 8ad:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8b1:	eb 42                	jmp    8f5 <printf+0x170>
      } else if(c == '%'){
 8b3:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8b7:	75 17                	jne    8d0 <printf+0x14b>
        putc(fd, c);
 8b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8bc:	0f be c0             	movsbl %al,%eax
 8bf:	83 ec 08             	sub    $0x8,%esp
 8c2:	50                   	push   %eax
 8c3:	ff 75 08             	pushl  0x8(%ebp)
 8c6:	e8 e3 fd ff ff       	call   6ae <putc>
 8cb:	83 c4 10             	add    $0x10,%esp
 8ce:	eb 25                	jmp    8f5 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8d0:	83 ec 08             	sub    $0x8,%esp
 8d3:	6a 25                	push   $0x25
 8d5:	ff 75 08             	pushl  0x8(%ebp)
 8d8:	e8 d1 fd ff ff       	call   6ae <putc>
 8dd:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 8e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8e3:	0f be c0             	movsbl %al,%eax
 8e6:	83 ec 08             	sub    $0x8,%esp
 8e9:	50                   	push   %eax
 8ea:	ff 75 08             	pushl  0x8(%ebp)
 8ed:	e8 bc fd ff ff       	call   6ae <putc>
 8f2:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8f5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8fc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 900:	8b 55 0c             	mov    0xc(%ebp),%edx
 903:	8b 45 f0             	mov    -0x10(%ebp),%eax
 906:	01 d0                	add    %edx,%eax
 908:	0f b6 00             	movzbl (%eax),%eax
 90b:	84 c0                	test   %al,%al
 90d:	0f 85 94 fe ff ff    	jne    7a7 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 913:	90                   	nop
 914:	c9                   	leave  
 915:	c3                   	ret    

00000916 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 916:	55                   	push   %ebp
 917:	89 e5                	mov    %esp,%ebp
 919:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 91c:	8b 45 08             	mov    0x8(%ebp),%eax
 91f:	83 e8 08             	sub    $0x8,%eax
 922:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 925:	a1 c8 0e 00 00       	mov    0xec8,%eax
 92a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 92d:	eb 24                	jmp    953 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 92f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 932:	8b 00                	mov    (%eax),%eax
 934:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 937:	77 12                	ja     94b <free+0x35>
 939:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 93f:	77 24                	ja     965 <free+0x4f>
 941:	8b 45 fc             	mov    -0x4(%ebp),%eax
 944:	8b 00                	mov    (%eax),%eax
 946:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 949:	77 1a                	ja     965 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94e:	8b 00                	mov    (%eax),%eax
 950:	89 45 fc             	mov    %eax,-0x4(%ebp)
 953:	8b 45 f8             	mov    -0x8(%ebp),%eax
 956:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 959:	76 d4                	jbe    92f <free+0x19>
 95b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95e:	8b 00                	mov    (%eax),%eax
 960:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 963:	76 ca                	jbe    92f <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 965:	8b 45 f8             	mov    -0x8(%ebp),%eax
 968:	8b 40 04             	mov    0x4(%eax),%eax
 96b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 972:	8b 45 f8             	mov    -0x8(%ebp),%eax
 975:	01 c2                	add    %eax,%edx
 977:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97a:	8b 00                	mov    (%eax),%eax
 97c:	39 c2                	cmp    %eax,%edx
 97e:	75 24                	jne    9a4 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 980:	8b 45 f8             	mov    -0x8(%ebp),%eax
 983:	8b 50 04             	mov    0x4(%eax),%edx
 986:	8b 45 fc             	mov    -0x4(%ebp),%eax
 989:	8b 00                	mov    (%eax),%eax
 98b:	8b 40 04             	mov    0x4(%eax),%eax
 98e:	01 c2                	add    %eax,%edx
 990:	8b 45 f8             	mov    -0x8(%ebp),%eax
 993:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 996:	8b 45 fc             	mov    -0x4(%ebp),%eax
 999:	8b 00                	mov    (%eax),%eax
 99b:	8b 10                	mov    (%eax),%edx
 99d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a0:	89 10                	mov    %edx,(%eax)
 9a2:	eb 0a                	jmp    9ae <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a7:	8b 10                	mov    (%eax),%edx
 9a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ac:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b1:	8b 40 04             	mov    0x4(%eax),%eax
 9b4:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9be:	01 d0                	add    %edx,%eax
 9c0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 9c3:	75 20                	jne    9e5 <free+0xcf>
    p->s.size += bp->s.size;
 9c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c8:	8b 50 04             	mov    0x4(%eax),%edx
 9cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ce:	8b 40 04             	mov    0x4(%eax),%eax
 9d1:	01 c2                	add    %eax,%edx
 9d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9d6:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9d9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9dc:	8b 10                	mov    (%eax),%edx
 9de:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e1:	89 10                	mov    %edx,(%eax)
 9e3:	eb 08                	jmp    9ed <free+0xd7>
  } else
    p->s.ptr = bp;
 9e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e8:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9eb:	89 10                	mov    %edx,(%eax)
  freep = p;
 9ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f0:	a3 c8 0e 00 00       	mov    %eax,0xec8
}
 9f5:	90                   	nop
 9f6:	c9                   	leave  
 9f7:	c3                   	ret    

000009f8 <morecore>:

static Header*
morecore(uint nu)
{
 9f8:	55                   	push   %ebp
 9f9:	89 e5                	mov    %esp,%ebp
 9fb:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 9fe:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a05:	77 07                	ja     a0e <morecore+0x16>
    nu = 4096;
 a07:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a0e:	8b 45 08             	mov    0x8(%ebp),%eax
 a11:	c1 e0 03             	shl    $0x3,%eax
 a14:	83 ec 0c             	sub    $0xc,%esp
 a17:	50                   	push   %eax
 a18:	e8 59 fc ff ff       	call   676 <sbrk>
 a1d:	83 c4 10             	add    $0x10,%esp
 a20:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a23:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a27:	75 07                	jne    a30 <morecore+0x38>
    return 0;
 a29:	b8 00 00 00 00       	mov    $0x0,%eax
 a2e:	eb 26                	jmp    a56 <morecore+0x5e>
  hp = (Header*)p;
 a30:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a39:	8b 55 08             	mov    0x8(%ebp),%edx
 a3c:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a3f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a42:	83 c0 08             	add    $0x8,%eax
 a45:	83 ec 0c             	sub    $0xc,%esp
 a48:	50                   	push   %eax
 a49:	e8 c8 fe ff ff       	call   916 <free>
 a4e:	83 c4 10             	add    $0x10,%esp
  return freep;
 a51:	a1 c8 0e 00 00       	mov    0xec8,%eax
}
 a56:	c9                   	leave  
 a57:	c3                   	ret    

00000a58 <malloc>:

void*
malloc(uint nbytes)
{
 a58:	55                   	push   %ebp
 a59:	89 e5                	mov    %esp,%ebp
 a5b:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a5e:	8b 45 08             	mov    0x8(%ebp),%eax
 a61:	83 c0 07             	add    $0x7,%eax
 a64:	c1 e8 03             	shr    $0x3,%eax
 a67:	83 c0 01             	add    $0x1,%eax
 a6a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a6d:	a1 c8 0e 00 00       	mov    0xec8,%eax
 a72:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a75:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a79:	75 23                	jne    a9e <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a7b:	c7 45 f0 c0 0e 00 00 	movl   $0xec0,-0x10(%ebp)
 a82:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a85:	a3 c8 0e 00 00       	mov    %eax,0xec8
 a8a:	a1 c8 0e 00 00       	mov    0xec8,%eax
 a8f:	a3 c0 0e 00 00       	mov    %eax,0xec0
    base.s.size = 0;
 a94:	c7 05 c4 0e 00 00 00 	movl   $0x0,0xec4
 a9b:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa1:	8b 00                	mov    (%eax),%eax
 aa3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 aa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aa9:	8b 40 04             	mov    0x4(%eax),%eax
 aac:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aaf:	72 4d                	jb     afe <malloc+0xa6>
      if(p->s.size == nunits)
 ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab4:	8b 40 04             	mov    0x4(%eax),%eax
 ab7:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 aba:	75 0c                	jne    ac8 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abf:	8b 10                	mov    (%eax),%edx
 ac1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac4:	89 10                	mov    %edx,(%eax)
 ac6:	eb 26                	jmp    aee <malloc+0x96>
      else {
        p->s.size -= nunits;
 ac8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acb:	8b 40 04             	mov    0x4(%eax),%eax
 ace:	2b 45 ec             	sub    -0x14(%ebp),%eax
 ad1:	89 c2                	mov    %eax,%edx
 ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad6:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 adc:	8b 40 04             	mov    0x4(%eax),%eax
 adf:	c1 e0 03             	shl    $0x3,%eax
 ae2:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae8:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aeb:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 aee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af1:	a3 c8 0e 00 00       	mov    %eax,0xec8
      return (void*)(p + 1);
 af6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 af9:	83 c0 08             	add    $0x8,%eax
 afc:	eb 3b                	jmp    b39 <malloc+0xe1>
    }
    if(p == freep)
 afe:	a1 c8 0e 00 00       	mov    0xec8,%eax
 b03:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b06:	75 1e                	jne    b26 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 b08:	83 ec 0c             	sub    $0xc,%esp
 b0b:	ff 75 ec             	pushl  -0x14(%ebp)
 b0e:	e8 e5 fe ff ff       	call   9f8 <morecore>
 b13:	83 c4 10             	add    $0x10,%esp
 b16:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b19:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b1d:	75 07                	jne    b26 <malloc+0xce>
        return 0;
 b1f:	b8 00 00 00 00       	mov    $0x0,%eax
 b24:	eb 13                	jmp    b39 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b26:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b29:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2f:	8b 00                	mov    (%eax),%eax
 b31:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 b34:	e9 6d ff ff ff       	jmp    aa6 <malloc+0x4e>
}
 b39:	c9                   	leave  
 b3a:	c3                   	ret    
