
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
  c0:	68 a0 0a 00 00       	push   $0xaa0
  c5:	6a 01                	push   $0x1
  c7:	e8 1c 06 00 00       	call   6e8 <printf>
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
 135:	68 bc 0a 00 00       	push   $0xabc
 13a:	6a 01                	push   $0x1
 13c:	e8 a7 05 00 00       	call   6e8 <printf>
 141:	83 c4 10             	add    $0x10,%esp
            char *arg[3];
            arg[0] = "sleepN";
 144:	c7 45 c4 dc 0a 00 00 	movl   $0xadc,-0x3c(%ebp)
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
 16c:	68 dc 0a 00 00       	push   $0xadc
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
 19b:	68 e3 0a 00 00       	push   $0xae3
 1a0:	6a 01                	push   $0x1
 1a2:	e8 41 05 00 00       	call   6e8 <printf>
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
 1e4:	68 f9 0a 00 00       	push   $0xaf9
 1e9:	6a 01                	push   $0x1
 1eb:	e8 f8 04 00 00       	call   6e8 <printf>
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
 21b:	68 0a 0b 00 00       	push   $0xb0a
 220:	6a 01                	push   $0x1
 222:	e8 c1 04 00 00       	call   6e8 <printf>
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
 239:	68 24 0b 00 00       	push   $0xb24
 23e:	6a 01                	push   $0x1
 240:	e8 a3 04 00 00       	call   6e8 <printf>
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
 26b:	68 35 0b 00 00       	push   $0xb35
 270:	6a 01                	push   $0x1
 272:	e8 71 04 00 00       	call   6e8 <printf>
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
 4db:	0f b6 80 3a 0b 00 00 	movzbl 0xb3a(%eax),%eax
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

00000611 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 611:	55                   	push   %ebp
 612:	89 e5                	mov    %esp,%ebp
 614:	83 ec 18             	sub    $0x18,%esp
 617:	8b 45 0c             	mov    0xc(%ebp),%eax
 61a:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 61d:	83 ec 04             	sub    $0x4,%esp
 620:	6a 01                	push   $0x1
 622:	8d 45 f4             	lea    -0xc(%ebp),%eax
 625:	50                   	push   %eax
 626:	ff 75 08             	pushl  0x8(%ebp)
 629:	e8 4b ff ff ff       	call   579 <write>
 62e:	83 c4 10             	add    $0x10,%esp
}
 631:	90                   	nop
 632:	c9                   	leave  
 633:	c3                   	ret    

00000634 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 634:	55                   	push   %ebp
 635:	89 e5                	mov    %esp,%ebp
 637:	53                   	push   %ebx
 638:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 63b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 642:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 646:	74 17                	je     65f <printint+0x2b>
 648:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 64c:	79 11                	jns    65f <printint+0x2b>
    neg = 1;
 64e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 655:	8b 45 0c             	mov    0xc(%ebp),%eax
 658:	f7 d8                	neg    %eax
 65a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 65d:	eb 06                	jmp    665 <printint+0x31>
  } else {
    x = xx;
 65f:	8b 45 0c             	mov    0xc(%ebp),%eax
 662:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 665:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 66c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 66f:	8d 41 01             	lea    0x1(%ecx),%eax
 672:	89 45 f4             	mov    %eax,-0xc(%ebp)
 675:	8b 5d 10             	mov    0x10(%ebp),%ebx
 678:	8b 45 ec             	mov    -0x14(%ebp),%eax
 67b:	ba 00 00 00 00       	mov    $0x0,%edx
 680:	f7 f3                	div    %ebx
 682:	89 d0                	mov    %edx,%eax
 684:	0f b6 80 00 0e 00 00 	movzbl 0xe00(%eax),%eax
 68b:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 68f:	8b 5d 10             	mov    0x10(%ebp),%ebx
 692:	8b 45 ec             	mov    -0x14(%ebp),%eax
 695:	ba 00 00 00 00       	mov    $0x0,%edx
 69a:	f7 f3                	div    %ebx
 69c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 69f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 6a3:	75 c7                	jne    66c <printint+0x38>
  if(neg)
 6a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 6a9:	74 2d                	je     6d8 <printint+0xa4>
    buf[i++] = '-';
 6ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6ae:	8d 50 01             	lea    0x1(%eax),%edx
 6b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 6b4:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 6b9:	eb 1d                	jmp    6d8 <printint+0xa4>
    putc(fd, buf[i]);
 6bb:	8d 55 dc             	lea    -0x24(%ebp),%edx
 6be:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6c1:	01 d0                	add    %edx,%eax
 6c3:	0f b6 00             	movzbl (%eax),%eax
 6c6:	0f be c0             	movsbl %al,%eax
 6c9:	83 ec 08             	sub    $0x8,%esp
 6cc:	50                   	push   %eax
 6cd:	ff 75 08             	pushl  0x8(%ebp)
 6d0:	e8 3c ff ff ff       	call   611 <putc>
 6d5:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 6d8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 6dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6e0:	79 d9                	jns    6bb <printint+0x87>
    putc(fd, buf[i]);
}
 6e2:	90                   	nop
 6e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6e6:	c9                   	leave  
 6e7:	c3                   	ret    

000006e8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 6e8:	55                   	push   %ebp
 6e9:	89 e5                	mov    %esp,%ebp
 6eb:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 6ee:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 6f5:	8d 45 0c             	lea    0xc(%ebp),%eax
 6f8:	83 c0 04             	add    $0x4,%eax
 6fb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 6fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 705:	e9 59 01 00 00       	jmp    863 <printf+0x17b>
    c = fmt[i] & 0xff;
 70a:	8b 55 0c             	mov    0xc(%ebp),%edx
 70d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 710:	01 d0                	add    %edx,%eax
 712:	0f b6 00             	movzbl (%eax),%eax
 715:	0f be c0             	movsbl %al,%eax
 718:	25 ff 00 00 00       	and    $0xff,%eax
 71d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 720:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 724:	75 2c                	jne    752 <printf+0x6a>
      if(c == '%'){
 726:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 72a:	75 0c                	jne    738 <printf+0x50>
        state = '%';
 72c:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 733:	e9 27 01 00 00       	jmp    85f <printf+0x177>
      } else {
        putc(fd, c);
 738:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 73b:	0f be c0             	movsbl %al,%eax
 73e:	83 ec 08             	sub    $0x8,%esp
 741:	50                   	push   %eax
 742:	ff 75 08             	pushl  0x8(%ebp)
 745:	e8 c7 fe ff ff       	call   611 <putc>
 74a:	83 c4 10             	add    $0x10,%esp
 74d:	e9 0d 01 00 00       	jmp    85f <printf+0x177>
      }
    } else if(state == '%'){
 752:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 756:	0f 85 03 01 00 00    	jne    85f <printf+0x177>
      if(c == 'd'){
 75c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 760:	75 1e                	jne    780 <printf+0x98>
        printint(fd, *ap, 10, 1);
 762:	8b 45 e8             	mov    -0x18(%ebp),%eax
 765:	8b 00                	mov    (%eax),%eax
 767:	6a 01                	push   $0x1
 769:	6a 0a                	push   $0xa
 76b:	50                   	push   %eax
 76c:	ff 75 08             	pushl  0x8(%ebp)
 76f:	e8 c0 fe ff ff       	call   634 <printint>
 774:	83 c4 10             	add    $0x10,%esp
        ap++;
 777:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 77b:	e9 d8 00 00 00       	jmp    858 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 780:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 784:	74 06                	je     78c <printf+0xa4>
 786:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 78a:	75 1e                	jne    7aa <printf+0xc2>
        printint(fd, *ap, 16, 0);
 78c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 78f:	8b 00                	mov    (%eax),%eax
 791:	6a 00                	push   $0x0
 793:	6a 10                	push   $0x10
 795:	50                   	push   %eax
 796:	ff 75 08             	pushl  0x8(%ebp)
 799:	e8 96 fe ff ff       	call   634 <printint>
 79e:	83 c4 10             	add    $0x10,%esp
        ap++;
 7a1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7a5:	e9 ae 00 00 00       	jmp    858 <printf+0x170>
      } else if(c == 's'){
 7aa:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 7ae:	75 43                	jne    7f3 <printf+0x10b>
        s = (char*)*ap;
 7b0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7b3:	8b 00                	mov    (%eax),%eax
 7b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 7b8:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 7bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7c0:	75 25                	jne    7e7 <printf+0xff>
          s = "(null)";
 7c2:	c7 45 f4 4b 0b 00 00 	movl   $0xb4b,-0xc(%ebp)
        while(*s != 0){
 7c9:	eb 1c                	jmp    7e7 <printf+0xff>
          putc(fd, *s);
 7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ce:	0f b6 00             	movzbl (%eax),%eax
 7d1:	0f be c0             	movsbl %al,%eax
 7d4:	83 ec 08             	sub    $0x8,%esp
 7d7:	50                   	push   %eax
 7d8:	ff 75 08             	pushl  0x8(%ebp)
 7db:	e8 31 fe ff ff       	call   611 <putc>
 7e0:	83 c4 10             	add    $0x10,%esp
          s++;
 7e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	0f b6 00             	movzbl (%eax),%eax
 7ed:	84 c0                	test   %al,%al
 7ef:	75 da                	jne    7cb <printf+0xe3>
 7f1:	eb 65                	jmp    858 <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 7f3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 7f7:	75 1d                	jne    816 <printf+0x12e>
        putc(fd, *ap);
 7f9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7fc:	8b 00                	mov    (%eax),%eax
 7fe:	0f be c0             	movsbl %al,%eax
 801:	83 ec 08             	sub    $0x8,%esp
 804:	50                   	push   %eax
 805:	ff 75 08             	pushl  0x8(%ebp)
 808:	e8 04 fe ff ff       	call   611 <putc>
 80d:	83 c4 10             	add    $0x10,%esp
        ap++;
 810:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 814:	eb 42                	jmp    858 <printf+0x170>
      } else if(c == '%'){
 816:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 81a:	75 17                	jne    833 <printf+0x14b>
        putc(fd, c);
 81c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 81f:	0f be c0             	movsbl %al,%eax
 822:	83 ec 08             	sub    $0x8,%esp
 825:	50                   	push   %eax
 826:	ff 75 08             	pushl  0x8(%ebp)
 829:	e8 e3 fd ff ff       	call   611 <putc>
 82e:	83 c4 10             	add    $0x10,%esp
 831:	eb 25                	jmp    858 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 833:	83 ec 08             	sub    $0x8,%esp
 836:	6a 25                	push   $0x25
 838:	ff 75 08             	pushl  0x8(%ebp)
 83b:	e8 d1 fd ff ff       	call   611 <putc>
 840:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 843:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 846:	0f be c0             	movsbl %al,%eax
 849:	83 ec 08             	sub    $0x8,%esp
 84c:	50                   	push   %eax
 84d:	ff 75 08             	pushl  0x8(%ebp)
 850:	e8 bc fd ff ff       	call   611 <putc>
 855:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 858:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 85f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 863:	8b 55 0c             	mov    0xc(%ebp),%edx
 866:	8b 45 f0             	mov    -0x10(%ebp),%eax
 869:	01 d0                	add    %edx,%eax
 86b:	0f b6 00             	movzbl (%eax),%eax
 86e:	84 c0                	test   %al,%al
 870:	0f 85 94 fe ff ff    	jne    70a <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 876:	90                   	nop
 877:	c9                   	leave  
 878:	c3                   	ret    

00000879 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 879:	55                   	push   %ebp
 87a:	89 e5                	mov    %esp,%ebp
 87c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 87f:	8b 45 08             	mov    0x8(%ebp),%eax
 882:	83 e8 08             	sub    $0x8,%eax
 885:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 888:	a1 48 0e 00 00       	mov    0xe48,%eax
 88d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 890:	eb 24                	jmp    8b6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 892:	8b 45 fc             	mov    -0x4(%ebp),%eax
 895:	8b 00                	mov    (%eax),%eax
 897:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 89a:	77 12                	ja     8ae <free+0x35>
 89c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 89f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8a2:	77 24                	ja     8c8 <free+0x4f>
 8a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8a7:	8b 00                	mov    (%eax),%eax
 8a9:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8ac:	77 1a                	ja     8c8 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 8ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8b1:	8b 00                	mov    (%eax),%eax
 8b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
 8b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8b9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 8bc:	76 d4                	jbe    892 <free+0x19>
 8be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8c1:	8b 00                	mov    (%eax),%eax
 8c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 8c6:	76 ca                	jbe    892 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 8c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8cb:	8b 40 04             	mov    0x4(%eax),%eax
 8ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 8d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8d8:	01 c2                	add    %eax,%edx
 8da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8dd:	8b 00                	mov    (%eax),%eax
 8df:	39 c2                	cmp    %eax,%edx
 8e1:	75 24                	jne    907 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 8e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8e6:	8b 50 04             	mov    0x4(%eax),%edx
 8e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8ec:	8b 00                	mov    (%eax),%eax
 8ee:	8b 40 04             	mov    0x4(%eax),%eax
 8f1:	01 c2                	add    %eax,%edx
 8f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 8f6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 8f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 8fc:	8b 00                	mov    (%eax),%eax
 8fe:	8b 10                	mov    (%eax),%edx
 900:	8b 45 f8             	mov    -0x8(%ebp),%eax
 903:	89 10                	mov    %edx,(%eax)
 905:	eb 0a                	jmp    911 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 907:	8b 45 fc             	mov    -0x4(%ebp),%eax
 90a:	8b 10                	mov    (%eax),%edx
 90c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 90f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 911:	8b 45 fc             	mov    -0x4(%ebp),%eax
 914:	8b 40 04             	mov    0x4(%eax),%eax
 917:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 91e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 921:	01 d0                	add    %edx,%eax
 923:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 926:	75 20                	jne    948 <free+0xcf>
    p->s.size += bp->s.size;
 928:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92b:	8b 50 04             	mov    0x4(%eax),%edx
 92e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 931:	8b 40 04             	mov    0x4(%eax),%eax
 934:	01 c2                	add    %eax,%edx
 936:	8b 45 fc             	mov    -0x4(%ebp),%eax
 939:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 93c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 93f:	8b 10                	mov    (%eax),%edx
 941:	8b 45 fc             	mov    -0x4(%ebp),%eax
 944:	89 10                	mov    %edx,(%eax)
 946:	eb 08                	jmp    950 <free+0xd7>
  } else
    p->s.ptr = bp;
 948:	8b 45 fc             	mov    -0x4(%ebp),%eax
 94b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 94e:	89 10                	mov    %edx,(%eax)
  freep = p;
 950:	8b 45 fc             	mov    -0x4(%ebp),%eax
 953:	a3 48 0e 00 00       	mov    %eax,0xe48
}
 958:	90                   	nop
 959:	c9                   	leave  
 95a:	c3                   	ret    

0000095b <morecore>:

static Header*
morecore(uint nu)
{
 95b:	55                   	push   %ebp
 95c:	89 e5                	mov    %esp,%ebp
 95e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 961:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 968:	77 07                	ja     971 <morecore+0x16>
    nu = 4096;
 96a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 971:	8b 45 08             	mov    0x8(%ebp),%eax
 974:	c1 e0 03             	shl    $0x3,%eax
 977:	83 ec 0c             	sub    $0xc,%esp
 97a:	50                   	push   %eax
 97b:	e8 61 fc ff ff       	call   5e1 <sbrk>
 980:	83 c4 10             	add    $0x10,%esp
 983:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 986:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 98a:	75 07                	jne    993 <morecore+0x38>
    return 0;
 98c:	b8 00 00 00 00       	mov    $0x0,%eax
 991:	eb 26                	jmp    9b9 <morecore+0x5e>
  hp = (Header*)p;
 993:	8b 45 f4             	mov    -0xc(%ebp),%eax
 996:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 999:	8b 45 f0             	mov    -0x10(%ebp),%eax
 99c:	8b 55 08             	mov    0x8(%ebp),%edx
 99f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 9a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9a5:	83 c0 08             	add    $0x8,%eax
 9a8:	83 ec 0c             	sub    $0xc,%esp
 9ab:	50                   	push   %eax
 9ac:	e8 c8 fe ff ff       	call   879 <free>
 9b1:	83 c4 10             	add    $0x10,%esp
  return freep;
 9b4:	a1 48 0e 00 00       	mov    0xe48,%eax
}
 9b9:	c9                   	leave  
 9ba:	c3                   	ret    

000009bb <malloc>:

void*
malloc(uint nbytes)
{
 9bb:	55                   	push   %ebp
 9bc:	89 e5                	mov    %esp,%ebp
 9be:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 9c1:	8b 45 08             	mov    0x8(%ebp),%eax
 9c4:	83 c0 07             	add    $0x7,%eax
 9c7:	c1 e8 03             	shr    $0x3,%eax
 9ca:	83 c0 01             	add    $0x1,%eax
 9cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 9d0:	a1 48 0e 00 00       	mov    0xe48,%eax
 9d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 9dc:	75 23                	jne    a01 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 9de:	c7 45 f0 40 0e 00 00 	movl   $0xe40,-0x10(%ebp)
 9e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 9e8:	a3 48 0e 00 00       	mov    %eax,0xe48
 9ed:	a1 48 0e 00 00       	mov    0xe48,%eax
 9f2:	a3 40 0e 00 00       	mov    %eax,0xe40
    base.s.size = 0;
 9f7:	c7 05 44 0e 00 00 00 	movl   $0x0,0xe44
 9fe:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a01:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a04:	8b 00                	mov    (%eax),%eax
 a06:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a0c:	8b 40 04             	mov    0x4(%eax),%eax
 a0f:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a12:	72 4d                	jb     a61 <malloc+0xa6>
      if(p->s.size == nunits)
 a14:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a17:	8b 40 04             	mov    0x4(%eax),%eax
 a1a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 a1d:	75 0c                	jne    a2b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 a1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a22:	8b 10                	mov    (%eax),%edx
 a24:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a27:	89 10                	mov    %edx,(%eax)
 a29:	eb 26                	jmp    a51 <malloc+0x96>
      else {
        p->s.size -= nunits;
 a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a2e:	8b 40 04             	mov    0x4(%eax),%eax
 a31:	2b 45 ec             	sub    -0x14(%ebp),%eax
 a34:	89 c2                	mov    %eax,%edx
 a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a39:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 a3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a3f:	8b 40 04             	mov    0x4(%eax),%eax
 a42:	c1 e0 03             	shl    $0x3,%eax
 a45:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a4b:	8b 55 ec             	mov    -0x14(%ebp),%edx
 a4e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 a51:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a54:	a3 48 0e 00 00       	mov    %eax,0xe48
      return (void*)(p + 1);
 a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a5c:	83 c0 08             	add    $0x8,%eax
 a5f:	eb 3b                	jmp    a9c <malloc+0xe1>
    }
    if(p == freep)
 a61:	a1 48 0e 00 00       	mov    0xe48,%eax
 a66:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 a69:	75 1e                	jne    a89 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 a6b:	83 ec 0c             	sub    $0xc,%esp
 a6e:	ff 75 ec             	pushl  -0x14(%ebp)
 a71:	e8 e5 fe ff ff       	call   95b <morecore>
 a76:	83 c4 10             	add    $0x10,%esp
 a79:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a7c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 a80:	75 07                	jne    a89 <malloc+0xce>
        return 0;
 a82:	b8 00 00 00 00       	mov    $0x0,%eax
 a87:	eb 13                	jmp    a9c <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a89:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a8f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a92:	8b 00                	mov    (%eax),%eax
 a94:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 a97:	e9 6d ff ff ff       	jmp    a09 <malloc+0x4e>
}
 a9c:	c9                   	leave  
 a9d:	c3                   	ret    
