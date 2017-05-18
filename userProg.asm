
_userProg:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
int processruntime(int, int);
char* itoa(int, int);

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
   f:	83 ec 40             	sub    $0x40,%esp
  12:	89 cb                	mov    %ecx,%ebx
    int start = uptime();
  14:	e8 d8 05 00 00       	call   5f1 <uptime>
  19:	89 45 ec             	mov    %eax,-0x14(%ebp)
    int minp_time = atoi(argv[1]), maxp_time = atoi(argv[2]);
  1c:	8b 43 04             	mov    0x4(%ebx),%eax
  1f:	83 c0 04             	add    $0x4,%eax
  22:	8b 00                	mov    (%eax),%eax
  24:	83 ec 0c             	sub    $0xc,%esp
  27:	50                   	push   %eax
  28:	e8 49 04 00 00       	call   476 <atoi>
  2d:	83 c4 10             	add    $0x10,%esp
  30:	89 45 e8             	mov    %eax,-0x18(%ebp)
  33:	8b 43 04             	mov    0x4(%ebx),%eax
  36:	83 c0 08             	add    $0x8,%eax
  39:	8b 00                	mov    (%eax),%eax
  3b:	83 ec 0c             	sub    $0xc,%esp
  3e:	50                   	push   %eax
  3f:	e8 32 04 00 00       	call   476 <atoi>
  44:	83 c4 10             	add    $0x10,%esp
  47:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    int minp_runtime = atoi(argv[3]), maxp_runtime = atoi(argv[4]);
  4a:	8b 43 04             	mov    0x4(%ebx),%eax
  4d:	83 c0 0c             	add    $0xc,%eax
  50:	8b 00                	mov    (%eax),%eax
  52:	83 ec 0c             	sub    $0xc,%esp
  55:	50                   	push   %eax
  56:	e8 1b 04 00 00       	call   476 <atoi>
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  61:	8b 43 04             	mov    0x4(%ebx),%eax
  64:	83 c0 10             	add    $0x10,%eax
  67:	8b 00                	mov    (%eax),%eax
  69:	83 ec 0c             	sub    $0xc,%esp
  6c:	50                   	push   %eax
  6d:	e8 04 04 00 00       	call   476 <atoi>
  72:	83 c4 10             	add    $0x10,%esp
  75:	89 45 dc             	mov    %eax,-0x24(%ebp)
    int maxnum_processes = atoi(argv[5]);
  78:	8b 43 04             	mov    0x4(%ebx),%eax
  7b:	83 c0 14             	add    $0x14,%eax
  7e:	8b 00                	mov    (%eax),%eax
  80:	83 ec 0c             	sub    $0xc,%esp
  83:	50                   	push   %eax
  84:	e8 ed 03 00 00       	call   476 <atoi>
  89:	83 c4 10             	add    $0x10,%esp
  8c:	89 45 d8             	mov    %eax,-0x28(%ebp)

    int nextTime = nextprocessbirthtime(minp_time, maxp_time);
  8f:	83 ec 08             	sub    $0x8,%esp
  92:	ff 75 e4             	pushl  -0x1c(%ebp)
  95:	ff 75 e8             	pushl  -0x18(%ebp)
  98:	e8 e2 01 00 00       	call   27f <nextprocessbirthtime>
  9d:	83 c4 10             	add    $0x10,%esp
  a0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    int runTime = processruntime(minp_runtime, maxp_runtime);
  a3:	83 ec 08             	sub    $0x8,%esp
  a6:	ff 75 dc             	pushl  -0x24(%ebp)
  a9:	ff 75 e0             	pushl  -0x20(%ebp)
  ac:	e8 e7 01 00 00       	call   298 <processruntime>
  b1:	83 c4 10             	add    $0x10,%esp
  b4:	89 45 d0             	mov    %eax,-0x30(%ebp)


    printf(1,"Parent %d: Sleeping %d \n",getpid(), nextTime);
  b7:	e8 1d 05 00 00       	call   5d9 <getpid>
  bc:	ff 75 d4             	pushl  -0x2c(%ebp)
  bf:	50                   	push   %eax
  c0:	68 a8 0a 00 00       	push   $0xaa8
  c5:	6a 01                	push   $0x1
  c7:	e8 24 06 00 00       	call   6f0 <printf>
  cc:	83 c4 10             	add    $0x10,%esp
    sleep(1000*nextTime/14);
  cf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  d2:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
  d8:	ba 93 24 49 92       	mov    $0x92492493,%edx
  dd:	89 c8                	mov    %ecx,%eax
  df:	f7 ea                	imul   %edx
  e1:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
  e4:	c1 f8 03             	sar    $0x3,%eax
  e7:	89 c2                	mov    %eax,%edx
  e9:	89 c8                	mov    %ecx,%eax
  eb:	c1 f8 1f             	sar    $0x1f,%eax
  ee:	29 c2                	sub    %eax,%edx
  f0:	89 d0                	mov    %edx,%eax
  f2:	83 ec 0c             	sub    $0xc,%esp
  f5:	50                   	push   %eax
  f6:	e8 ee 04 00 00       	call   5e9 <sleep>
  fb:	83 c4 10             	add    $0x10,%esp

    int i;
    int pid;
    for(i=0; i< maxnum_processes; i++){
  fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 105:	e9 ed 00 00 00       	jmp    1f7 <main+0x1f7>
        pid = fork();
 10a:	e8 42 04 00 00       	call   551 <fork>
 10f:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if(pid == 0){
 112:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 116:	75 63                	jne    17b <main+0x17b>
            runTime = processruntime(minp_runtime, maxp_runtime);
 118:	83 ec 08             	sub    $0x8,%esp
 11b:	ff 75 dc             	pushl  -0x24(%ebp)
 11e:	ff 75 e0             	pushl  -0x20(%ebp)
 121:	e8 72 01 00 00       	call   298 <processruntime>
 126:	83 c4 10             	add    $0x10,%esp
 129:	89 45 d0             	mov    %eax,-0x30(%ebp)
            printf(1,"Child %d: Sleeping for %d sec \n", getpid(),runTime);
 12c:	e8 a8 04 00 00       	call   5d9 <getpid>
 131:	ff 75 d0             	pushl  -0x30(%ebp)
 134:	50                   	push   %eax
 135:	68 c4 0a 00 00       	push   $0xac4
 13a:	6a 01                	push   $0x1
 13c:	e8 af 05 00 00       	call   6f0 <printf>
 141:	83 c4 10             	add    $0x10,%esp
            char *arg[3];
            arg[0] = "sleepN";
 144:	c7 45 c4 e4 0a 00 00 	movl   $0xae4,-0x3c(%ebp)
            arg[1] = itoa(runTime, 10);
 14b:	83 ec 08             	sub    $0x8,%esp
 14e:	6a 0a                	push   $0xa
 150:	ff 75 d0             	pushl  -0x30(%ebp)
 153:	e8 6b 03 00 00       	call   4c3 <itoa>
 158:	83 c4 10             	add    $0x10,%esp
 15b:	89 45 c8             	mov    %eax,-0x38(%ebp)
            arg[2] = 0;
 15e:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
            exec("sleepN",arg);
 165:	83 ec 08             	sub    $0x8,%esp
 168:	8d 45 c4             	lea    -0x3c(%ebp),%eax
 16b:	50                   	push   %eax
 16c:	68 e4 0a 00 00       	push   $0xae4
 171:	e8 1b 04 00 00       	call   591 <exec>
 176:	83 c4 10             	add    $0x10,%esp
 179:	eb 78                	jmp    1f3 <main+0x1f3>
        }else if(pid > 0){
 17b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 17f:	7e 5a                	jle    1db <main+0x1db>
            nextTime = nextprocessbirthtime(minp_time, maxp_time);
 181:	83 ec 08             	sub    $0x8,%esp
 184:	ff 75 e4             	pushl  -0x1c(%ebp)
 187:	ff 75 e8             	pushl  -0x18(%ebp)
 18a:	e8 f0 00 00 00       	call   27f <nextprocessbirthtime>
 18f:	83 c4 10             	add    $0x10,%esp
 192:	89 45 d4             	mov    %eax,-0x2c(%ebp)
            printf(1,"Parent: Sleeping %d \n", nextTime);
 195:	83 ec 04             	sub    $0x4,%esp
 198:	ff 75 d4             	pushl  -0x2c(%ebp)
 19b:	68 eb 0a 00 00       	push   $0xaeb
 1a0:	6a 01                	push   $0x1
 1a2:	e8 49 05 00 00       	call   6f0 <printf>
 1a7:	83 c4 10             	add    $0x10,%esp
            sleep(1000*nextTime/14);
 1aa:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1ad:	69 c8 e8 03 00 00    	imul   $0x3e8,%eax,%ecx
 1b3:	ba 93 24 49 92       	mov    $0x92492493,%edx
 1b8:	89 c8                	mov    %ecx,%eax
 1ba:	f7 ea                	imul   %edx
 1bc:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
 1bf:	c1 f8 03             	sar    $0x3,%eax
 1c2:	89 c2                	mov    %eax,%edx
 1c4:	89 c8                	mov    %ecx,%eax
 1c6:	c1 f8 1f             	sar    $0x1f,%eax
 1c9:	29 c2                	sub    %eax,%edx
 1cb:	89 d0                	mov    %edx,%eax
 1cd:	83 ec 0c             	sub    $0xc,%esp
 1d0:	50                   	push   %eax
 1d1:	e8 13 04 00 00       	call   5e9 <sleep>
 1d6:	83 c4 10             	add    $0x10,%esp
 1d9:	eb 18                	jmp    1f3 <main+0x1f3>
            //wait();
        }else if(pid < 0){
 1db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1df:	79 12                	jns    1f3 <main+0x1f3>
            printf(1,"Error in forking");
 1e1:	83 ec 08             	sub    $0x8,%esp
 1e4:	68 01 0b 00 00       	push   $0xb01
 1e9:	6a 01                	push   $0x1
 1eb:	e8 00 05 00 00       	call   6f0 <printf>
 1f0:	83 c4 10             	add    $0x10,%esp
    printf(1,"Parent %d: Sleeping %d \n",getpid(), nextTime);
    sleep(1000*nextTime/14);

    int i;
    int pid;
    for(i=0; i< maxnum_processes; i++){
 1f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1fa:	3b 45 d8             	cmp    -0x28(%ebp),%eax
 1fd:	0f 8c 07 ff ff ff    	jl     10a <main+0x10a>
            //wait();
        }else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
 203:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 207:	7e 2d                	jle    236 <main+0x236>
        for(i=0; i< maxnum_processes; i++)
 209:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 210:	eb 1c                	jmp    22e <main+0x22e>
            printf(1,"Parent: Child %d exited \n", wait());
 212:	e8 4a 03 00 00       	call   561 <wait>
 217:	83 ec 04             	sub    $0x4,%esp
 21a:	50                   	push   %eax
 21b:	68 12 0b 00 00       	push   $0xb12
 220:	6a 01                	push   $0x1
 222:	e8 c9 04 00 00       	call   6f0 <printf>
 227:	83 c4 10             	add    $0x10,%esp
        }else if(pid < 0){
            printf(1,"Error in forking");
        }
    }
    if(pid > 0 ){
        for(i=0; i< maxnum_processes; i++)
 22a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 22e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 231:	3b 45 d8             	cmp    -0x28(%ebp),%eax
 234:	7c dc                	jl     212 <main+0x212>
            printf(1,"Parent: Child %d exited \n", wait());
    }
    printf(1,"Parent: Exiting\n");
 236:	83 ec 08             	sub    $0x8,%esp
 239:	68 2c 0b 00 00       	push   $0xb2c
 23e:	6a 01                	push   $0x1
 240:	e8 ab 04 00 00       	call   6f0 <printf>
 245:	83 c4 10             	add    $0x10,%esp
    printf(1,"%d \n",(uptime() - start)/72);
 248:	e8 a4 03 00 00       	call   5f1 <uptime>
 24d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 250:	89 c1                	mov    %eax,%ecx
 252:	ba 39 8e e3 38       	mov    $0x38e38e39,%edx
 257:	89 c8                	mov    %ecx,%eax
 259:	f7 ea                	imul   %edx
 25b:	c1 fa 04             	sar    $0x4,%edx
 25e:	89 c8                	mov    %ecx,%eax
 260:	c1 f8 1f             	sar    $0x1f,%eax
 263:	29 c2                	sub    %eax,%edx
 265:	89 d0                	mov    %edx,%eax
 267:	83 ec 04             	sub    $0x4,%esp
 26a:	50                   	push   %eax
 26b:	68 3d 0b 00 00       	push   $0xb3d
 270:	6a 01                	push   $0x1
 272:	e8 79 04 00 00       	call   6f0 <printf>
 277:	83 c4 10             	add    $0x10,%esp
    exit();
 27a:	e8 da 02 00 00       	call   559 <exit>

0000027f <nextprocessbirthtime>:
}

int
nextprocessbirthtime(int min, int max){
 27f:	55                   	push   %ebp
 280:	89 e5                	mov    %esp,%ebp
 282:	83 ec 08             	sub    $0x8,%esp
    return uniformR(min, max);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	ff 75 0c             	pushl  0xc(%ebp)
 28b:	ff 75 08             	pushl  0x8(%ebp)
 28e:	e8 76 03 00 00       	call   609 <uniformR>
 293:	83 c4 10             	add    $0x10,%esp

}
 296:	c9                   	leave  
 297:	c3                   	ret    

00000298 <processruntime>:

int
processruntime(int min, int max){
 298:	55                   	push   %ebp
 299:	89 e5                	mov    %esp,%ebp
 29b:	83 ec 08             	sub    $0x8,%esp
    return uniformR(min, max);
 29e:	83 ec 08             	sub    $0x8,%esp
 2a1:	ff 75 0c             	pushl  0xc(%ebp)
 2a4:	ff 75 08             	pushl  0x8(%ebp)
 2a7:	e8 5d 03 00 00       	call   609 <uniformR>
 2ac:	83 c4 10             	add    $0x10,%esp

}
 2af:	c9                   	leave  
 2b0:	c3                   	ret    

000002b1 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 2b1:	55                   	push   %ebp
 2b2:	89 e5                	mov    %esp,%ebp
 2b4:	57                   	push   %edi
 2b5:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 2b6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2b9:	8b 55 10             	mov    0x10(%ebp),%edx
 2bc:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bf:	89 cb                	mov    %ecx,%ebx
 2c1:	89 df                	mov    %ebx,%edi
 2c3:	89 d1                	mov    %edx,%ecx
 2c5:	fc                   	cld    
 2c6:	f3 aa                	rep stos %al,%es:(%edi)
 2c8:	89 ca                	mov    %ecx,%edx
 2ca:	89 fb                	mov    %edi,%ebx
 2cc:	89 5d 08             	mov    %ebx,0x8(%ebp)
 2cf:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 2d2:	90                   	nop
 2d3:	5b                   	pop    %ebx
 2d4:	5f                   	pop    %edi
 2d5:	5d                   	pop    %ebp
 2d6:	c3                   	ret    

000002d7 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2d7:	55                   	push   %ebp
 2d8:	89 e5                	mov    %esp,%ebp
 2da:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 2e3:	90                   	nop
 2e4:	8b 45 08             	mov    0x8(%ebp),%eax
 2e7:	8d 50 01             	lea    0x1(%eax),%edx
 2ea:	89 55 08             	mov    %edx,0x8(%ebp)
 2ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 2f0:	8d 4a 01             	lea    0x1(%edx),%ecx
 2f3:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 2f6:	0f b6 12             	movzbl (%edx),%edx
 2f9:	88 10                	mov    %dl,(%eax)
 2fb:	0f b6 00             	movzbl (%eax),%eax
 2fe:	84 c0                	test   %al,%al
 300:	75 e2                	jne    2e4 <strcpy+0xd>
    ;
  return os;
 302:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 305:	c9                   	leave  
 306:	c3                   	ret    

00000307 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 307:	55                   	push   %ebp
 308:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 30a:	eb 08                	jmp    314 <strcmp+0xd>
    p++, q++;
 30c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 310:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 314:	8b 45 08             	mov    0x8(%ebp),%eax
 317:	0f b6 00             	movzbl (%eax),%eax
 31a:	84 c0                	test   %al,%al
 31c:	74 10                	je     32e <strcmp+0x27>
 31e:	8b 45 08             	mov    0x8(%ebp),%eax
 321:	0f b6 10             	movzbl (%eax),%edx
 324:	8b 45 0c             	mov    0xc(%ebp),%eax
 327:	0f b6 00             	movzbl (%eax),%eax
 32a:	38 c2                	cmp    %al,%dl
 32c:	74 de                	je     30c <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	0f b6 00             	movzbl (%eax),%eax
 334:	0f b6 d0             	movzbl %al,%edx
 337:	8b 45 0c             	mov    0xc(%ebp),%eax
 33a:	0f b6 00             	movzbl (%eax),%eax
 33d:	0f b6 c0             	movzbl %al,%eax
 340:	29 c2                	sub    %eax,%edx
 342:	89 d0                	mov    %edx,%eax
}
 344:	5d                   	pop    %ebp
 345:	c3                   	ret    

00000346 <strlen>:

uint
strlen(char *s)
{
 346:	55                   	push   %ebp
 347:	89 e5                	mov    %esp,%ebp
 349:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 34c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 353:	eb 04                	jmp    359 <strlen+0x13>
 355:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 359:	8b 55 fc             	mov    -0x4(%ebp),%edx
 35c:	8b 45 08             	mov    0x8(%ebp),%eax
 35f:	01 d0                	add    %edx,%eax
 361:	0f b6 00             	movzbl (%eax),%eax
 364:	84 c0                	test   %al,%al
 366:	75 ed                	jne    355 <strlen+0xf>
    ;
  return n;
 368:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 36b:	c9                   	leave  
 36c:	c3                   	ret    

0000036d <memset>:

void*
memset(void *dst, int c, uint n)
{
 36d:	55                   	push   %ebp
 36e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 370:	8b 45 10             	mov    0x10(%ebp),%eax
 373:	50                   	push   %eax
 374:	ff 75 0c             	pushl  0xc(%ebp)
 377:	ff 75 08             	pushl  0x8(%ebp)
 37a:	e8 32 ff ff ff       	call   2b1 <stosb>
 37f:	83 c4 0c             	add    $0xc,%esp
  return dst;
 382:	8b 45 08             	mov    0x8(%ebp),%eax
}
 385:	c9                   	leave  
 386:	c3                   	ret    

00000387 <strchr>:

char*
strchr(const char *s, char c)
{
 387:	55                   	push   %ebp
 388:	89 e5                	mov    %esp,%ebp
 38a:	83 ec 04             	sub    $0x4,%esp
 38d:	8b 45 0c             	mov    0xc(%ebp),%eax
 390:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 393:	eb 14                	jmp    3a9 <strchr+0x22>
    if(*s == c)
 395:	8b 45 08             	mov    0x8(%ebp),%eax
 398:	0f b6 00             	movzbl (%eax),%eax
 39b:	3a 45 fc             	cmp    -0x4(%ebp),%al
 39e:	75 05                	jne    3a5 <strchr+0x1e>
      return (char*)s;
 3a0:	8b 45 08             	mov    0x8(%ebp),%eax
 3a3:	eb 13                	jmp    3b8 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 3a5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3a9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ac:	0f b6 00             	movzbl (%eax),%eax
 3af:	84 c0                	test   %al,%al
 3b1:	75 e2                	jne    395 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 3b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3b8:	c9                   	leave  
 3b9:	c3                   	ret    

000003ba <gets>:

char*
gets(char *buf, int max)
{
 3ba:	55                   	push   %ebp
 3bb:	89 e5                	mov    %esp,%ebp
 3bd:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3c7:	eb 42                	jmp    40b <gets+0x51>
    cc = read(0, &c, 1);
 3c9:	83 ec 04             	sub    $0x4,%esp
 3cc:	6a 01                	push   $0x1
 3ce:	8d 45 ef             	lea    -0x11(%ebp),%eax
 3d1:	50                   	push   %eax
 3d2:	6a 00                	push   $0x0
 3d4:	e8 98 01 00 00       	call   571 <read>
 3d9:	83 c4 10             	add    $0x10,%esp
 3dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 3df:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 3e3:	7e 33                	jle    418 <gets+0x5e>
      break;
    buf[i++] = c;
 3e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3e8:	8d 50 01             	lea    0x1(%eax),%edx
 3eb:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3ee:	89 c2                	mov    %eax,%edx
 3f0:	8b 45 08             	mov    0x8(%ebp),%eax
 3f3:	01 c2                	add    %eax,%edx
 3f5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3f9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 3fb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 3ff:	3c 0a                	cmp    $0xa,%al
 401:	74 16                	je     419 <gets+0x5f>
 403:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 407:	3c 0d                	cmp    $0xd,%al
 409:	74 0e                	je     419 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 40b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40e:	83 c0 01             	add    $0x1,%eax
 411:	3b 45 0c             	cmp    0xc(%ebp),%eax
 414:	7c b3                	jl     3c9 <gets+0xf>
 416:	eb 01                	jmp    419 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
 418:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 419:	8b 55 f4             	mov    -0xc(%ebp),%edx
 41c:	8b 45 08             	mov    0x8(%ebp),%eax
 41f:	01 d0                	add    %edx,%eax
 421:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 424:	8b 45 08             	mov    0x8(%ebp),%eax
}
 427:	c9                   	leave  
 428:	c3                   	ret    

00000429 <stat>:

int
stat(char *n, struct stat *st)
{
 429:	55                   	push   %ebp
 42a:	89 e5                	mov    %esp,%ebp
 42c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 42f:	83 ec 08             	sub    $0x8,%esp
 432:	6a 00                	push   $0x0
 434:	ff 75 08             	pushl  0x8(%ebp)
 437:	e8 5d 01 00 00       	call   599 <open>
 43c:	83 c4 10             	add    $0x10,%esp
 43f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 442:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 446:	79 07                	jns    44f <stat+0x26>
    return -1;
 448:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 44d:	eb 25                	jmp    474 <stat+0x4b>
  r = fstat(fd, st);
 44f:	83 ec 08             	sub    $0x8,%esp
 452:	ff 75 0c             	pushl  0xc(%ebp)
 455:	ff 75 f4             	pushl  -0xc(%ebp)
 458:	e8 54 01 00 00       	call   5b1 <fstat>
 45d:	83 c4 10             	add    $0x10,%esp
 460:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 463:	83 ec 0c             	sub    $0xc,%esp
 466:	ff 75 f4             	pushl  -0xc(%ebp)
 469:	e8 13 01 00 00       	call   581 <close>
 46e:	83 c4 10             	add    $0x10,%esp
  return r;
 471:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 474:	c9                   	leave  
 475:	c3                   	ret    

00000476 <atoi>:

int
atoi(const char *s)
{
 476:	55                   	push   %ebp
 477:	89 e5                	mov    %esp,%ebp
 479:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 47c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 483:	eb 25                	jmp    4aa <atoi+0x34>
    n = n*10 + *s++ - '0';
 485:	8b 55 fc             	mov    -0x4(%ebp),%edx
 488:	89 d0                	mov    %edx,%eax
 48a:	c1 e0 02             	shl    $0x2,%eax
 48d:	01 d0                	add    %edx,%eax
 48f:	01 c0                	add    %eax,%eax
 491:	89 c1                	mov    %eax,%ecx
 493:	8b 45 08             	mov    0x8(%ebp),%eax
 496:	8d 50 01             	lea    0x1(%eax),%edx
 499:	89 55 08             	mov    %edx,0x8(%ebp)
 49c:	0f b6 00             	movzbl (%eax),%eax
 49f:	0f be c0             	movsbl %al,%eax
 4a2:	01 c8                	add    %ecx,%eax
 4a4:	83 e8 30             	sub    $0x30,%eax
 4a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 4aa:	8b 45 08             	mov    0x8(%ebp),%eax
 4ad:	0f b6 00             	movzbl (%eax),%eax
 4b0:	3c 2f                	cmp    $0x2f,%al
 4b2:	7e 0a                	jle    4be <atoi+0x48>
 4b4:	8b 45 08             	mov    0x8(%ebp),%eax
 4b7:	0f b6 00             	movzbl (%eax),%eax
 4ba:	3c 39                	cmp    $0x39,%al
 4bc:	7e c7                	jle    485 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 4be:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 4c1:	c9                   	leave  
 4c2:	c3                   	ret    

000004c3 <itoa>:

char*
itoa(int val, int base){
 4c3:	55                   	push   %ebp
 4c4:	89 e5                	mov    %esp,%ebp
 4c6:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
 4c9:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
 4d0:	eb 29                	jmp    4fb <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
 4d2:	8b 45 08             	mov    0x8(%ebp),%eax
 4d5:	99                   	cltd   
 4d6:	f7 7d 0c             	idivl  0xc(%ebp)
 4d9:	89 d0                	mov    %edx,%eax
 4db:	0f b6 80 42 0b 00 00 	movzbl 0xb42(%eax),%eax
 4e2:	8b 55 fc             	mov    -0x4(%ebp),%edx
 4e5:	81 c2 20 0e 00 00    	add    $0xe20,%edx
 4eb:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
 4ed:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
 4f1:	8b 45 08             	mov    0x8(%ebp),%eax
 4f4:	99                   	cltd   
 4f5:	f7 7d 0c             	idivl  0xc(%ebp)
 4f8:	89 45 08             	mov    %eax,0x8(%ebp)
 4fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 4ff:	74 06                	je     507 <itoa+0x44>
 501:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
 505:	75 cb                	jne    4d2 <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
 507:	8b 45 fc             	mov    -0x4(%ebp),%eax
 50a:	83 c0 01             	add    $0x1,%eax
 50d:	05 20 0e 00 00       	add    $0xe20,%eax

}
 512:	c9                   	leave  
 513:	c3                   	ret    

00000514 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
 51a:	8b 45 08             	mov    0x8(%ebp),%eax
 51d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 520:	8b 45 0c             	mov    0xc(%ebp),%eax
 523:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 526:	eb 17                	jmp    53f <memmove+0x2b>
    *dst++ = *src++;
 528:	8b 45 fc             	mov    -0x4(%ebp),%eax
 52b:	8d 50 01             	lea    0x1(%eax),%edx
 52e:	89 55 fc             	mov    %edx,-0x4(%ebp)
 531:	8b 55 f8             	mov    -0x8(%ebp),%edx
 534:	8d 4a 01             	lea    0x1(%edx),%ecx
 537:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 53a:	0f b6 12             	movzbl (%edx),%edx
 53d:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 53f:	8b 45 10             	mov    0x10(%ebp),%eax
 542:	8d 50 ff             	lea    -0x1(%eax),%edx
 545:	89 55 10             	mov    %edx,0x10(%ebp)
 548:	85 c0                	test   %eax,%eax
 54a:	7f dc                	jg     528 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 54c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 54f:	c9                   	leave  
 550:	c3                   	ret    

00000551 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 551:	b8 01 00 00 00       	mov    $0x1,%eax
 556:	cd 40                	int    $0x40
 558:	c3                   	ret    

00000559 <exit>:
SYSCALL(exit)
 559:	b8 02 00 00 00       	mov    $0x2,%eax
 55e:	cd 40                	int    $0x40
 560:	c3                   	ret    

00000561 <wait>:
SYSCALL(wait)
 561:	b8 03 00 00 00       	mov    $0x3,%eax
 566:	cd 40                	int    $0x40
 568:	c3                   	ret    

00000569 <pipe>:
SYSCALL(pipe)
 569:	b8 04 00 00 00       	mov    $0x4,%eax
 56e:	cd 40                	int    $0x40
 570:	c3                   	ret    

00000571 <read>:
SYSCALL(read)
 571:	b8 05 00 00 00       	mov    $0x5,%eax
 576:	cd 40                	int    $0x40
 578:	c3                   	ret    

00000579 <write>:
SYSCALL(write)
 579:	b8 10 00 00 00       	mov    $0x10,%eax
 57e:	cd 40                	int    $0x40
 580:	c3                   	ret    

00000581 <close>:
SYSCALL(close)
 581:	b8 15 00 00 00       	mov    $0x15,%eax
 586:	cd 40                	int    $0x40
 588:	c3                   	ret    

00000589 <kill>:
SYSCALL(kill)
 589:	b8 06 00 00 00       	mov    $0x6,%eax
 58e:	cd 40                	int    $0x40
 590:	c3                   	ret    

00000591 <exec>:
SYSCALL(exec)
 591:	b8 07 00 00 00       	mov    $0x7,%eax
 596:	cd 40                	int    $0x40
 598:	c3                   	ret    

00000599 <open>:
SYSCALL(open)
 599:	b8 0f 00 00 00       	mov    $0xf,%eax
 59e:	cd 40                	int    $0x40
 5a0:	c3                   	ret    

000005a1 <mknod>:
SYSCALL(mknod)
 5a1:	b8 11 00 00 00       	mov    $0x11,%eax
 5a6:	cd 40                	int    $0x40
 5a8:	c3                   	ret    

000005a9 <unlink>:
SYSCALL(unlink)
 5a9:	b8 12 00 00 00       	mov    $0x12,%eax
 5ae:	cd 40                	int    $0x40
 5b0:	c3                   	ret    

000005b1 <fstat>:
SYSCALL(fstat)
 5b1:	b8 08 00 00 00       	mov    $0x8,%eax
 5b6:	cd 40                	int    $0x40
 5b8:	c3                   	ret    

000005b9 <link>:
SYSCALL(link)
 5b9:	b8 13 00 00 00       	mov    $0x13,%eax
 5be:	cd 40                	int    $0x40
 5c0:	c3                   	ret    

000005c1 <mkdir>:
SYSCALL(mkdir)
 5c1:	b8 14 00 00 00       	mov    $0x14,%eax
 5c6:	cd 40                	int    $0x40
 5c8:	c3                   	ret    

000005c9 <chdir>:
SYSCALL(chdir)
 5c9:	b8 09 00 00 00       	mov    $0x9,%eax
 5ce:	cd 40                	int    $0x40
 5d0:	c3                   	ret    

000005d1 <dup>:
SYSCALL(dup)
 5d1:	b8 0a 00 00 00       	mov    $0xa,%eax
 5d6:	cd 40                	int    $0x40
 5d8:	c3                   	ret    

000005d9 <getpid>:
SYSCALL(getpid)
 5d9:	b8 0b 00 00 00       	mov    $0xb,%eax
 5de:	cd 40                	int    $0x40
 5e0:	c3                   	ret    

000005e1 <sbrk>:
SYSCALL(sbrk)
 5e1:	b8 0c 00 00 00       	mov    $0xc,%eax
 5e6:	cd 40                	int    $0x40
 5e8:	c3                   	ret    

000005e9 <sleep>:
SYSCALL(sleep)
 5e9:	b8 0d 00 00 00       	mov    $0xd,%eax
 5ee:	cd 40                	int    $0x40
 5f0:	c3                   	ret    

000005f1 <uptime>:
SYSCALL(uptime)
 5f1:	b8 0e 00 00 00       	mov    $0xe,%eax
 5f6:	cd 40                	int    $0x40
 5f8:	c3                   	ret    

000005f9 <randomX>:
SYSCALL(randomX)
 5f9:	b8 16 00 00 00       	mov    $0x16,%eax
 5fe:	cd 40                	int    $0x40
 600:	c3                   	ret    

00000601 <setSeedX>:
SYSCALL(setSeedX)
 601:	b8 17 00 00 00       	mov    $0x17,%eax
 606:	cd 40                	int    $0x40
 608:	c3                   	ret    

00000609 <uniformR>:
SYSCALL(uniformR)
 609:	b8 18 00 00 00       	mov    $0x18,%eax
 60e:	cd 40                	int    $0x40
 610:	c3                   	ret    

00000611 <setdeadline>:
 611:	b8 19 00 00 00       	mov    $0x19,%eax
 616:	cd 40                	int    $0x40
 618:	c3                   	ret    

00000619 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 619:	55                   	push   %ebp
 61a:	89 e5                	mov    %esp,%ebp
 61c:	83 ec 18             	sub    $0x18,%esp
 61f:	8b 45 0c             	mov    0xc(%ebp),%eax
 622:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 625:	83 ec 04             	sub    $0x4,%esp
 628:	6a 01                	push   $0x1
 62a:	8d 45 f4             	lea    -0xc(%ebp),%eax
 62d:	50                   	push   %eax
 62e:	ff 75 08             	pushl  0x8(%ebp)
 631:	e8 43 ff ff ff       	call   579 <write>
 636:	83 c4 10             	add    $0x10,%esp
}
 639:	90                   	nop
 63a:	c9                   	leave  
 63b:	c3                   	ret    

0000063c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 63c:	55                   	push   %ebp
 63d:	89 e5                	mov    %esp,%ebp
 63f:	53                   	push   %ebx
 640:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 643:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 64a:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 64e:	74 17                	je     667 <printint+0x2b>
 650:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 654:	79 11                	jns    667 <printint+0x2b>
    neg = 1;
 656:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 65d:	8b 45 0c             	mov    0xc(%ebp),%eax
 660:	f7 d8                	neg    %eax
 662:	89 45 ec             	mov    %eax,-0x14(%ebp)
 665:	eb 06                	jmp    66d <printint+0x31>
  } else {
    x = xx;
 667:	8b 45 0c             	mov    0xc(%ebp),%eax
 66a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 66d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 674:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 677:	8d 41 01             	lea    0x1(%ecx),%eax
 67a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 67d:	8b 5d 10             	mov    0x10(%ebp),%ebx
 680:	8b 45 ec             	mov    -0x14(%ebp),%eax
 683:	ba 00 00 00 00       	mov    $0x0,%edx
 688:	f7 f3                	div    %ebx
 68a:	89 d0                	mov    %edx,%eax
 68c:	0f b6 80 08 0e 00 00 	movzbl 0xe08(%eax),%eax
 693:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 697:	8b 5d 10             	mov    0x10(%ebp),%ebx
 69a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 69d:	ba 00 00 00 00       	mov    $0x0,%edx
 6a2:	f7 f3                	div    %ebx
 6a4:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6a7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6ab:	75 c7                	jne    674 <printint+0x38>
  if(neg)
 6ad:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6b1:	74 2d                	je     6e0 <printint+0xa4>
    buf[i++] = '-';
 6b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6b6:	8d 50 01             	lea    0x1(%eax),%edx
 6b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6bc:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6c1:	eb 1d                	jmp    6e0 <printint+0xa4>
    putc(fd, buf[i]);
 6c3:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c9:	01 d0                	add    %edx,%eax
 6cb:	0f b6 00             	movzbl (%eax),%eax
 6ce:	0f be c0             	movsbl %al,%eax
 6d1:	83 ec 08             	sub    $0x8,%esp
 6d4:	50                   	push   %eax
 6d5:	ff 75 08             	pushl  0x8(%ebp)
 6d8:	e8 3c ff ff ff       	call   619 <putc>
 6dd:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6e0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 6e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e8:	79 d9                	jns    6c3 <printint+0x87>
    putc(fd, buf[i]);
}
 6ea:	90                   	nop
 6eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6ee:	c9                   	leave  
 6ef:	c3                   	ret    

000006f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6f6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6fd:	8d 45 0c             	lea    0xc(%ebp),%eax
 700:	83 c0 04             	add    $0x4,%eax
 703:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 706:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 70d:	e9 59 01 00 00       	jmp    86b <printf+0x17b>
    c = fmt[i] & 0xff;
 712:	8b 55 0c             	mov    0xc(%ebp),%edx
 715:	8b 45 f0             	mov    -0x10(%ebp),%eax
 718:	01 d0                	add    %edx,%eax
 71a:	0f b6 00             	movzbl (%eax),%eax
 71d:	0f be c0             	movsbl %al,%eax
 720:	25 ff 00 00 00       	and    $0xff,%eax
 725:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 728:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 72c:	75 2c                	jne    75a <printf+0x6a>
      if(c == '%'){
 72e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 732:	75 0c                	jne    740 <printf+0x50>
        state = '%';
 734:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 73b:	e9 27 01 00 00       	jmp    867 <printf+0x177>
      } else {
        putc(fd, c);
 740:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 743:	0f be c0             	movsbl %al,%eax
 746:	83 ec 08             	sub    $0x8,%esp
 749:	50                   	push   %eax
 74a:	ff 75 08             	pushl  0x8(%ebp)
 74d:	e8 c7 fe ff ff       	call   619 <putc>
 752:	83 c4 10             	add    $0x10,%esp
 755:	e9 0d 01 00 00       	jmp    867 <printf+0x177>
      }
    } else if(state == '%'){
 75a:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 75e:	0f 85 03 01 00 00    	jne    867 <printf+0x177>
      if(c == 'd'){
 764:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 768:	75 1e                	jne    788 <printf+0x98>
        printint(fd, *ap, 10, 1);
 76a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 76d:	8b 00                	mov    (%eax),%eax
 76f:	6a 01                	push   $0x1
 771:	6a 0a                	push   $0xa
 773:	50                   	push   %eax
 774:	ff 75 08             	pushl  0x8(%ebp)
 777:	e8 c0 fe ff ff       	call   63c <printint>
 77c:	83 c4 10             	add    $0x10,%esp
        ap++;
 77f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 783:	e9 d8 00 00 00       	jmp    860 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 788:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 78c:	74 06                	je     794 <printf+0xa4>
 78e:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 792:	75 1e                	jne    7b2 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 794:	8b 45 e8             	mov    -0x18(%ebp),%eax
 797:	8b 00                	mov    (%eax),%eax
 799:	6a 00                	push   $0x0
 79b:	6a 10                	push   $0x10
 79d:	50                   	push   %eax
 79e:	ff 75 08             	pushl  0x8(%ebp)
 7a1:	e8 96 fe ff ff       	call   63c <printint>
 7a6:	83 c4 10             	add    $0x10,%esp
        ap++;
 7a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7ad:	e9 ae 00 00 00       	jmp    860 <printf+0x170>
      } else if(c == 's'){
 7b2:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7b6:	75 43                	jne    7fb <printf+0x10b>
        s = (char*)*ap;
 7b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7bb:	8b 00                	mov    (%eax),%eax
 7bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7c0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7c8:	75 25                	jne    7ef <printf+0xff>
          s = "(null)";
 7ca:	c7 45 f4 53 0b 00 00 	movl   $0xb53,-0xc(%ebp)
        while(*s != 0){
 7d1:	eb 1c                	jmp    7ef <printf+0xff>
          putc(fd, *s);
 7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d6:	0f b6 00             	movzbl (%eax),%eax
 7d9:	0f be c0             	movsbl %al,%eax
 7dc:	83 ec 08             	sub    $0x8,%esp
 7df:	50                   	push   %eax
 7e0:	ff 75 08             	pushl  0x8(%ebp)
 7e3:	e8 31 fe ff ff       	call   619 <putc>
 7e8:	83 c4 10             	add    $0x10,%esp
          s++;
 7eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	0f b6 00             	movzbl (%eax),%eax
 7f5:	84 c0                	test   %al,%al
 7f7:	75 da                	jne    7d3 <printf+0xe3>
 7f9:	eb 65                	jmp    860 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7fb:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7ff:	75 1d                	jne    81e <printf+0x12e>
        putc(fd, *ap);
 801:	8b 45 e8             	mov    -0x18(%ebp),%eax
 804:	8b 00                	mov    (%eax),%eax
 806:	0f be c0             	movsbl %al,%eax
 809:	83 ec 08             	sub    $0x8,%esp
 80c:	50                   	push   %eax
 80d:	ff 75 08             	pushl  0x8(%ebp)
 810:	e8 04 fe ff ff       	call   619 <putc>
 815:	83 c4 10             	add    $0x10,%esp
        ap++;
 818:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 81c:	eb 42                	jmp    860 <printf+0x170>
      } else if(c == '%'){
 81e:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 822:	75 17                	jne    83b <printf+0x14b>
        putc(fd, c);
 824:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 827:	0f be c0             	movsbl %al,%eax
 82a:	83 ec 08             	sub    $0x8,%esp
 82d:	50                   	push   %eax
 82e:	ff 75 08             	pushl  0x8(%ebp)
 831:	e8 e3 fd ff ff       	call   619 <putc>
 836:	83 c4 10             	add    $0x10,%esp
 839:	eb 25                	jmp    860 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 83b:	83 ec 08             	sub    $0x8,%esp
 83e:	6a 25                	push   $0x25
 840:	ff 75 08             	pushl  0x8(%ebp)
 843:	e8 d1 fd ff ff       	call   619 <putc>
 848:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 84b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 84e:	0f be c0             	movsbl %al,%eax
 851:	83 ec 08             	sub    $0x8,%esp
 854:	50                   	push   %eax
 855:	ff 75 08             	pushl  0x8(%ebp)
 858:	e8 bc fd ff ff       	call   619 <putc>
 85d:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 860:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 867:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 86b:	8b 55 0c             	mov    0xc(%ebp),%edx
 86e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 871:	01 d0                	add    %edx,%eax
 873:	0f b6 00             	movzbl (%eax),%eax
 876:	84 c0                	test   %al,%al
 878:	0f 85 94 fe ff ff    	jne    712 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 87e:	90                   	nop
 87f:	c9                   	leave  
 880:	c3                   	ret    

00000881 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 881:	55                   	push   %ebp
 882:	89 e5                	mov    %esp,%ebp
 884:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 887:	8b 45 08             	mov    0x8(%ebp),%eax
 88a:	83 e8 08             	sub    $0x8,%eax
 88d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 890:	a1 48 0e 00 00       	mov    0xe48,%eax
 895:	89 45 fc             	mov    %eax,-0x4(%ebp)
 898:	eb 24                	jmp    8be <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 89a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 89d:	8b 00                	mov    (%eax),%eax
 89f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8a2:	77 12                	ja     8b6 <free+0x35>
 8a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8a7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8aa:	77 24                	ja     8d0 <free+0x4f>
 8ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8af:	8b 00                	mov    (%eax),%eax
 8b1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8b4:	77 1a                	ja     8d0 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b9:	8b 00                	mov    (%eax),%eax
 8bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8be:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8c1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8c4:	76 d4                	jbe    89a <free+0x19>
 8c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c9:	8b 00                	mov    (%eax),%eax
 8cb:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ce:	76 ca                	jbe    89a <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d3:	8b 40 04             	mov    0x4(%eax),%eax
 8d6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e0:	01 c2                	add    %eax,%edx
 8e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8e5:	8b 00                	mov    (%eax),%eax
 8e7:	39 c2                	cmp    %eax,%edx
 8e9:	75 24                	jne    90f <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8ee:	8b 50 04             	mov    0x4(%eax),%edx
 8f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8f4:	8b 00                	mov    (%eax),%eax
 8f6:	8b 40 04             	mov    0x4(%eax),%eax
 8f9:	01 c2                	add    %eax,%edx
 8fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8fe:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 901:	8b 45 fc             	mov    -0x4(%ebp),%eax
 904:	8b 00                	mov    (%eax),%eax
 906:	8b 10                	mov    (%eax),%edx
 908:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90b:	89 10                	mov    %edx,(%eax)
 90d:	eb 0a                	jmp    919 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 90f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 912:	8b 10                	mov    (%eax),%edx
 914:	8b 45 f8             	mov    -0x8(%ebp),%eax
 917:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 919:	8b 45 fc             	mov    -0x4(%ebp),%eax
 91c:	8b 40 04             	mov    0x4(%eax),%eax
 91f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 926:	8b 45 fc             	mov    -0x4(%ebp),%eax
 929:	01 d0                	add    %edx,%eax
 92b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 92e:	75 20                	jne    950 <free+0xcf>
    p->s.size += bp->s.size;
 930:	8b 45 fc             	mov    -0x4(%ebp),%eax
 933:	8b 50 04             	mov    0x4(%eax),%edx
 936:	8b 45 f8             	mov    -0x8(%ebp),%eax
 939:	8b 40 04             	mov    0x4(%eax),%eax
 93c:	01 c2                	add    %eax,%edx
 93e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 941:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 944:	8b 45 f8             	mov    -0x8(%ebp),%eax
 947:	8b 10                	mov    (%eax),%edx
 949:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94c:	89 10                	mov    %edx,(%eax)
 94e:	eb 08                	jmp    958 <free+0xd7>
  } else
    p->s.ptr = bp;
 950:	8b 45 fc             	mov    -0x4(%ebp),%eax
 953:	8b 55 f8             	mov    -0x8(%ebp),%edx
 956:	89 10                	mov    %edx,(%eax)
  freep = p;
 958:	8b 45 fc             	mov    -0x4(%ebp),%eax
 95b:	a3 48 0e 00 00       	mov    %eax,0xe48
}
 960:	90                   	nop
 961:	c9                   	leave  
 962:	c3                   	ret    

00000963 <morecore>:

static Header*
morecore(uint nu)
{
 963:	55                   	push   %ebp
 964:	89 e5                	mov    %esp,%ebp
 966:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 969:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 970:	77 07                	ja     979 <morecore+0x16>
    nu = 4096;
 972:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 979:	8b 45 08             	mov    0x8(%ebp),%eax
 97c:	c1 e0 03             	shl    $0x3,%eax
 97f:	83 ec 0c             	sub    $0xc,%esp
 982:	50                   	push   %eax
 983:	e8 59 fc ff ff       	call   5e1 <sbrk>
 988:	83 c4 10             	add    $0x10,%esp
 98b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 98e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 992:	75 07                	jne    99b <morecore+0x38>
    return 0;
 994:	b8 00 00 00 00       	mov    $0x0,%eax
 999:	eb 26                	jmp    9c1 <morecore+0x5e>
  hp = (Header*)p;
 99b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 9a1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a4:	8b 55 08             	mov    0x8(%ebp),%edx
 9a7:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9ad:	83 c0 08             	add    $0x8,%eax
 9b0:	83 ec 0c             	sub    $0xc,%esp
 9b3:	50                   	push   %eax
 9b4:	e8 c8 fe ff ff       	call   881 <free>
 9b9:	83 c4 10             	add    $0x10,%esp
  return freep;
 9bc:	a1 48 0e 00 00       	mov    0xe48,%eax
}
 9c1:	c9                   	leave  
 9c2:	c3                   	ret    

000009c3 <malloc>:

void*
malloc(uint nbytes)
{
 9c3:	55                   	push   %ebp
 9c4:	89 e5                	mov    %esp,%ebp
 9c6:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c9:	8b 45 08             	mov    0x8(%ebp),%eax
 9cc:	83 c0 07             	add    $0x7,%eax
 9cf:	c1 e8 03             	shr    $0x3,%eax
 9d2:	83 c0 01             	add    $0x1,%eax
 9d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9d8:	a1 48 0e 00 00       	mov    0xe48,%eax
 9dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9e4:	75 23                	jne    a09 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9e6:	c7 45 f0 40 0e 00 00 	movl   $0xe40,-0x10(%ebp)
 9ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9f0:	a3 48 0e 00 00       	mov    %eax,0xe48
 9f5:	a1 48 0e 00 00       	mov    0xe48,%eax
 9fa:	a3 40 0e 00 00       	mov    %eax,0xe40
    base.s.size = 0;
 9ff:	c7 05 44 0e 00 00 00 	movl   $0x0,0xe44
 a06:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a09:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a0c:	8b 00                	mov    (%eax),%eax
 a0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a11:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a14:	8b 40 04             	mov    0x4(%eax),%eax
 a17:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a1a:	72 4d                	jb     a69 <malloc+0xa6>
      if(p->s.size == nunits)
 a1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a1f:	8b 40 04             	mov    0x4(%eax),%eax
 a22:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a25:	75 0c                	jne    a33 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a27:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2a:	8b 10                	mov    (%eax),%edx
 a2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a2f:	89 10                	mov    %edx,(%eax)
 a31:	eb 26                	jmp    a59 <malloc+0x96>
      else {
        p->s.size -= nunits;
 a33:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a36:	8b 40 04             	mov    0x4(%eax),%eax
 a39:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a3c:	89 c2                	mov    %eax,%edx
 a3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a41:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a44:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a47:	8b 40 04             	mov    0x4(%eax),%eax
 a4a:	c1 e0 03             	shl    $0x3,%eax
 a4d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a50:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a53:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a56:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a59:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a5c:	a3 48 0e 00 00       	mov    %eax,0xe48
      return (void*)(p + 1);
 a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a64:	83 c0 08             	add    $0x8,%eax
 a67:	eb 3b                	jmp    aa4 <malloc+0xe1>
    }
    if(p == freep)
 a69:	a1 48 0e 00 00       	mov    0xe48,%eax
 a6e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a71:	75 1e                	jne    a91 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a73:	83 ec 0c             	sub    $0xc,%esp
 a76:	ff 75 ec             	pushl  -0x14(%ebp)
 a79:	e8 e5 fe ff ff       	call   963 <morecore>
 a7e:	83 c4 10             	add    $0x10,%esp
 a81:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a84:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a88:	75 07                	jne    a91 <malloc+0xce>
        return 0;
 a8a:	b8 00 00 00 00       	mov    $0x0,%eax
 a8f:	eb 13                	jmp    aa4 <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a91:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a94:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a97:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a9a:	8b 00                	mov    (%eax),%eax
 a9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a9f:	e9 6d ff ff ff       	jmp    a11 <malloc+0x4e>
}
 aa4:	c9                   	leave  
 aa5:	c3                   	ret    
