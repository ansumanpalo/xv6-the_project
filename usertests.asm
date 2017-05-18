
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
       6:	a1 28 5f 00 00       	mov    0x5f28,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 ba 41 00 00       	push   $0x41ba
      13:	50                   	push   %eax
      14:	e8 d2 3d 00 00       	call   3deb <printf>
      19:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
      1c:	83 ec 08             	sub    $0x8,%esp
      1f:	6a 00                	push   $0x0
      21:	68 a4 41 00 00       	push   $0x41a4
      26:	e8 69 3c 00 00       	call   3c94 <open>
      2b:	83 c4 10             	add    $0x10,%esp
      2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
      31:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      35:	79 1b                	jns    52 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
      37:	a1 28 5f 00 00       	mov    0x5f28,%eax
      3c:	83 ec 08             	sub    $0x8,%esp
      3f:	68 c5 41 00 00       	push   $0x41c5
      44:	50                   	push   %eax
      45:	e8 a1 3d 00 00       	call   3deb <printf>
      4a:	83 c4 10             	add    $0x10,%esp
    exit();
      4d:	e8 02 3c 00 00       	call   3c54 <exit>
  }
  close(fd);
      52:	83 ec 0c             	sub    $0xc,%esp
      55:	ff 75 f4             	pushl  -0xc(%ebp)
      58:	e8 1f 3c 00 00       	call   3c7c <close>
      5d:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
      60:	83 ec 08             	sub    $0x8,%esp
      63:	6a 00                	push   $0x0
      65:	68 d8 41 00 00       	push   $0x41d8
      6a:	e8 25 3c 00 00       	call   3c94 <open>
      6f:	83 c4 10             	add    $0x10,%esp
      72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
      75:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
      79:	78 1b                	js     96 <opentest+0x96>
    printf(stdout, "open doesnotexist succeeded!\n");
      7b:	a1 28 5f 00 00       	mov    0x5f28,%eax
      80:	83 ec 08             	sub    $0x8,%esp
      83:	68 e5 41 00 00       	push   $0x41e5
      88:	50                   	push   %eax
      89:	e8 5d 3d 00 00       	call   3deb <printf>
      8e:	83 c4 10             	add    $0x10,%esp
    exit();
      91:	e8 be 3b 00 00       	call   3c54 <exit>
  }
  printf(stdout, "open test ok\n");
      96:	a1 28 5f 00 00       	mov    0x5f28,%eax
      9b:	83 ec 08             	sub    $0x8,%esp
      9e:	68 03 42 00 00       	push   $0x4203
      a3:	50                   	push   %eax
      a4:	e8 42 3d 00 00       	call   3deb <printf>
      a9:	83 c4 10             	add    $0x10,%esp
}
      ac:	90                   	nop
      ad:	c9                   	leave  
      ae:	c3                   	ret    

000000af <writetest>:

void
writetest(void)
{
      af:	55                   	push   %ebp
      b0:	89 e5                	mov    %esp,%ebp
      b2:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
      b5:	a1 28 5f 00 00       	mov    0x5f28,%eax
      ba:	83 ec 08             	sub    $0x8,%esp
      bd:	68 11 42 00 00       	push   $0x4211
      c2:	50                   	push   %eax
      c3:	e8 23 3d 00 00       	call   3deb <printf>
      c8:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
      cb:	83 ec 08             	sub    $0x8,%esp
      ce:	68 02 02 00 00       	push   $0x202
      d3:	68 22 42 00 00       	push   $0x4222
      d8:	e8 b7 3b 00 00       	call   3c94 <open>
      dd:	83 c4 10             	add    $0x10,%esp
      e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
      e3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
      e7:	78 22                	js     10b <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
      e9:	a1 28 5f 00 00       	mov    0x5f28,%eax
      ee:	83 ec 08             	sub    $0x8,%esp
      f1:	68 28 42 00 00       	push   $0x4228
      f6:	50                   	push   %eax
      f7:	e8 ef 3c 00 00       	call   3deb <printf>
      fc:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
      ff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     106:	e9 8f 00 00 00       	jmp    19a <writetest+0xeb>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     10b:	a1 28 5f 00 00       	mov    0x5f28,%eax
     110:	83 ec 08             	sub    $0x8,%esp
     113:	68 43 42 00 00       	push   $0x4243
     118:	50                   	push   %eax
     119:	e8 cd 3c 00 00       	call   3deb <printf>
     11e:	83 c4 10             	add    $0x10,%esp
    exit();
     121:	e8 2e 3b 00 00       	call   3c54 <exit>
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     126:	83 ec 04             	sub    $0x4,%esp
     129:	6a 0a                	push   $0xa
     12b:	68 5f 42 00 00       	push   $0x425f
     130:	ff 75 f0             	pushl  -0x10(%ebp)
     133:	e8 3c 3b 00 00       	call   3c74 <write>
     138:	83 c4 10             	add    $0x10,%esp
     13b:	83 f8 0a             	cmp    $0xa,%eax
     13e:	74 1e                	je     15e <writetest+0xaf>
      printf(stdout, "error: write aa %d new file failed\n", i);
     140:	a1 28 5f 00 00       	mov    0x5f28,%eax
     145:	83 ec 04             	sub    $0x4,%esp
     148:	ff 75 f4             	pushl  -0xc(%ebp)
     14b:	68 6c 42 00 00       	push   $0x426c
     150:	50                   	push   %eax
     151:	e8 95 3c 00 00       	call   3deb <printf>
     156:	83 c4 10             	add    $0x10,%esp
      exit();
     159:	e8 f6 3a 00 00       	call   3c54 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     15e:	83 ec 04             	sub    $0x4,%esp
     161:	6a 0a                	push   $0xa
     163:	68 90 42 00 00       	push   $0x4290
     168:	ff 75 f0             	pushl  -0x10(%ebp)
     16b:	e8 04 3b 00 00       	call   3c74 <write>
     170:	83 c4 10             	add    $0x10,%esp
     173:	83 f8 0a             	cmp    $0xa,%eax
     176:	74 1e                	je     196 <writetest+0xe7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     178:	a1 28 5f 00 00       	mov    0x5f28,%eax
     17d:	83 ec 04             	sub    $0x4,%esp
     180:	ff 75 f4             	pushl  -0xc(%ebp)
     183:	68 9c 42 00 00       	push   $0x429c
     188:	50                   	push   %eax
     189:	e8 5d 3c 00 00       	call   3deb <printf>
     18e:	83 c4 10             	add    $0x10,%esp
      exit();
     191:	e8 be 3a 00 00       	call   3c54 <exit>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     196:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     19a:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     19e:	7e 86                	jle    126 <writetest+0x77>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     1a0:	a1 28 5f 00 00       	mov    0x5f28,%eax
     1a5:	83 ec 08             	sub    $0x8,%esp
     1a8:	68 c0 42 00 00       	push   $0x42c0
     1ad:	50                   	push   %eax
     1ae:	e8 38 3c 00 00       	call   3deb <printf>
     1b3:	83 c4 10             	add    $0x10,%esp
  close(fd);
     1b6:	83 ec 0c             	sub    $0xc,%esp
     1b9:	ff 75 f0             	pushl  -0x10(%ebp)
     1bc:	e8 bb 3a 00 00       	call   3c7c <close>
     1c1:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     1c4:	83 ec 08             	sub    $0x8,%esp
     1c7:	6a 00                	push   $0x0
     1c9:	68 22 42 00 00       	push   $0x4222
     1ce:	e8 c1 3a 00 00       	call   3c94 <open>
     1d3:	83 c4 10             	add    $0x10,%esp
     1d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     1d9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     1dd:	78 3c                	js     21b <writetest+0x16c>
    printf(stdout, "open small succeeded ok\n");
     1df:	a1 28 5f 00 00       	mov    0x5f28,%eax
     1e4:	83 ec 08             	sub    $0x8,%esp
     1e7:	68 cb 42 00 00       	push   $0x42cb
     1ec:	50                   	push   %eax
     1ed:	e8 f9 3b 00 00       	call   3deb <printf>
     1f2:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     1f5:	83 ec 04             	sub    $0x4,%esp
     1f8:	68 d0 07 00 00       	push   $0x7d0
     1fd:	68 40 87 00 00       	push   $0x8740
     202:	ff 75 f0             	pushl  -0x10(%ebp)
     205:	e8 62 3a 00 00       	call   3c6c <read>
     20a:	83 c4 10             	add    $0x10,%esp
     20d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     210:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     217:	75 57                	jne    270 <writetest+0x1c1>
     219:	eb 1b                	jmp    236 <writetest+0x187>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     21b:	a1 28 5f 00 00       	mov    0x5f28,%eax
     220:	83 ec 08             	sub    $0x8,%esp
     223:	68 e4 42 00 00       	push   $0x42e4
     228:	50                   	push   %eax
     229:	e8 bd 3b 00 00       	call   3deb <printf>
     22e:	83 c4 10             	add    $0x10,%esp
    exit();
     231:	e8 1e 3a 00 00       	call   3c54 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
     236:	a1 28 5f 00 00       	mov    0x5f28,%eax
     23b:	83 ec 08             	sub    $0x8,%esp
     23e:	68 ff 42 00 00       	push   $0x42ff
     243:	50                   	push   %eax
     244:	e8 a2 3b 00 00       	call   3deb <printf>
     249:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     24c:	83 ec 0c             	sub    $0xc,%esp
     24f:	ff 75 f0             	pushl  -0x10(%ebp)
     252:	e8 25 3a 00 00       	call   3c7c <close>
     257:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     25a:	83 ec 0c             	sub    $0xc,%esp
     25d:	68 22 42 00 00       	push   $0x4222
     262:	e8 3d 3a 00 00       	call   3ca4 <unlink>
     267:	83 c4 10             	add    $0x10,%esp
     26a:	85 c0                	test   %eax,%eax
     26c:	79 38                	jns    2a6 <writetest+0x1f7>
     26e:	eb 1b                	jmp    28b <writetest+0x1dc>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     270:	a1 28 5f 00 00       	mov    0x5f28,%eax
     275:	83 ec 08             	sub    $0x8,%esp
     278:	68 12 43 00 00       	push   $0x4312
     27d:	50                   	push   %eax
     27e:	e8 68 3b 00 00       	call   3deb <printf>
     283:	83 c4 10             	add    $0x10,%esp
    exit();
     286:	e8 c9 39 00 00       	call   3c54 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     28b:	a1 28 5f 00 00       	mov    0x5f28,%eax
     290:	83 ec 08             	sub    $0x8,%esp
     293:	68 1f 43 00 00       	push   $0x431f
     298:	50                   	push   %eax
     299:	e8 4d 3b 00 00       	call   3deb <printf>
     29e:	83 c4 10             	add    $0x10,%esp
    exit();
     2a1:	e8 ae 39 00 00       	call   3c54 <exit>
  }
  printf(stdout, "small file test ok\n");
     2a6:	a1 28 5f 00 00       	mov    0x5f28,%eax
     2ab:	83 ec 08             	sub    $0x8,%esp
     2ae:	68 34 43 00 00       	push   $0x4334
     2b3:	50                   	push   %eax
     2b4:	e8 32 3b 00 00       	call   3deb <printf>
     2b9:	83 c4 10             	add    $0x10,%esp
}
     2bc:	90                   	nop
     2bd:	c9                   	leave  
     2be:	c3                   	ret    

000002bf <writetest1>:

void
writetest1(void)
{
     2bf:	55                   	push   %ebp
     2c0:	89 e5                	mov    %esp,%ebp
     2c2:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     2c5:	a1 28 5f 00 00       	mov    0x5f28,%eax
     2ca:	83 ec 08             	sub    $0x8,%esp
     2cd:	68 48 43 00 00       	push   $0x4348
     2d2:	50                   	push   %eax
     2d3:	e8 13 3b 00 00       	call   3deb <printf>
     2d8:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     2db:	83 ec 08             	sub    $0x8,%esp
     2de:	68 02 02 00 00       	push   $0x202
     2e3:	68 58 43 00 00       	push   $0x4358
     2e8:	e8 a7 39 00 00       	call   3c94 <open>
     2ed:	83 c4 10             	add    $0x10,%esp
     2f0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     2f3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     2f7:	79 1b                	jns    314 <writetest1+0x55>
    printf(stdout, "error: creat big failed!\n");
     2f9:	a1 28 5f 00 00       	mov    0x5f28,%eax
     2fe:	83 ec 08             	sub    $0x8,%esp
     301:	68 5c 43 00 00       	push   $0x435c
     306:	50                   	push   %eax
     307:	e8 df 3a 00 00       	call   3deb <printf>
     30c:	83 c4 10             	add    $0x10,%esp
    exit();
     30f:	e8 40 39 00 00       	call   3c54 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     314:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     31b:	eb 4b                	jmp    368 <writetest1+0xa9>
    ((int*)buf)[0] = i;
     31d:	ba 40 87 00 00       	mov    $0x8740,%edx
     322:	8b 45 f4             	mov    -0xc(%ebp),%eax
     325:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     327:	83 ec 04             	sub    $0x4,%esp
     32a:	68 00 02 00 00       	push   $0x200
     32f:	68 40 87 00 00       	push   $0x8740
     334:	ff 75 ec             	pushl  -0x14(%ebp)
     337:	e8 38 39 00 00       	call   3c74 <write>
     33c:	83 c4 10             	add    $0x10,%esp
     33f:	3d 00 02 00 00       	cmp    $0x200,%eax
     344:	74 1e                	je     364 <writetest1+0xa5>
      printf(stdout, "error: write big file failed\n", i);
     346:	a1 28 5f 00 00       	mov    0x5f28,%eax
     34b:	83 ec 04             	sub    $0x4,%esp
     34e:	ff 75 f4             	pushl  -0xc(%ebp)
     351:	68 76 43 00 00       	push   $0x4376
     356:	50                   	push   %eax
     357:	e8 8f 3a 00 00       	call   3deb <printf>
     35c:	83 c4 10             	add    $0x10,%esp
      exit();
     35f:	e8 f0 38 00 00       	call   3c54 <exit>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     364:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     368:	8b 45 f4             	mov    -0xc(%ebp),%eax
     36b:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     370:	76 ab                	jbe    31d <writetest1+0x5e>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     372:	83 ec 0c             	sub    $0xc,%esp
     375:	ff 75 ec             	pushl  -0x14(%ebp)
     378:	e8 ff 38 00 00       	call   3c7c <close>
     37d:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     380:	83 ec 08             	sub    $0x8,%esp
     383:	6a 00                	push   $0x0
     385:	68 58 43 00 00       	push   $0x4358
     38a:	e8 05 39 00 00       	call   3c94 <open>
     38f:	83 c4 10             	add    $0x10,%esp
     392:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     395:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     399:	79 1b                	jns    3b6 <writetest1+0xf7>
    printf(stdout, "error: open big failed!\n");
     39b:	a1 28 5f 00 00       	mov    0x5f28,%eax
     3a0:	83 ec 08             	sub    $0x8,%esp
     3a3:	68 94 43 00 00       	push   $0x4394
     3a8:	50                   	push   %eax
     3a9:	e8 3d 3a 00 00       	call   3deb <printf>
     3ae:	83 c4 10             	add    $0x10,%esp
    exit();
     3b1:	e8 9e 38 00 00       	call   3c54 <exit>
  }

  n = 0;
     3b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     3bd:	83 ec 04             	sub    $0x4,%esp
     3c0:	68 00 02 00 00       	push   $0x200
     3c5:	68 40 87 00 00       	push   $0x8740
     3ca:	ff 75 ec             	pushl  -0x14(%ebp)
     3cd:	e8 9a 38 00 00       	call   3c6c <read>
     3d2:	83 c4 10             	add    $0x10,%esp
     3d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     3d8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     3dc:	75 27                	jne    405 <writetest1+0x146>
      if(n == MAXFILE - 1){
     3de:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     3e5:	75 7d                	jne    464 <writetest1+0x1a5>
        printf(stdout, "read only %d blocks from big", n);
     3e7:	a1 28 5f 00 00       	mov    0x5f28,%eax
     3ec:	83 ec 04             	sub    $0x4,%esp
     3ef:	ff 75 f0             	pushl  -0x10(%ebp)
     3f2:	68 ad 43 00 00       	push   $0x43ad
     3f7:	50                   	push   %eax
     3f8:	e8 ee 39 00 00       	call   3deb <printf>
     3fd:	83 c4 10             	add    $0x10,%esp
        exit();
     400:	e8 4f 38 00 00       	call   3c54 <exit>
      }
      break;
    } else if(i != 512){
     405:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     40c:	74 1e                	je     42c <writetest1+0x16d>
      printf(stdout, "read failed %d\n", i);
     40e:	a1 28 5f 00 00       	mov    0x5f28,%eax
     413:	83 ec 04             	sub    $0x4,%esp
     416:	ff 75 f4             	pushl  -0xc(%ebp)
     419:	68 ca 43 00 00       	push   $0x43ca
     41e:	50                   	push   %eax
     41f:	e8 c7 39 00 00       	call   3deb <printf>
     424:	83 c4 10             	add    $0x10,%esp
      exit();
     427:	e8 28 38 00 00       	call   3c54 <exit>
    }
    if(((int*)buf)[0] != n){
     42c:	b8 40 87 00 00       	mov    $0x8740,%eax
     431:	8b 00                	mov    (%eax),%eax
     433:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     436:	74 23                	je     45b <writetest1+0x19c>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     438:	b8 40 87 00 00       	mov    $0x8740,%eax
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     43d:	8b 10                	mov    (%eax),%edx
     43f:	a1 28 5f 00 00       	mov    0x5f28,%eax
     444:	52                   	push   %edx
     445:	ff 75 f0             	pushl  -0x10(%ebp)
     448:	68 dc 43 00 00       	push   $0x43dc
     44d:	50                   	push   %eax
     44e:	e8 98 39 00 00       	call   3deb <printf>
     453:	83 c4 10             	add    $0x10,%esp
             n, ((int*)buf)[0]);
      exit();
     456:	e8 f9 37 00 00       	call   3c54 <exit>
    }
    n++;
     45b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }
     45f:	e9 59 ff ff ff       	jmp    3bd <writetest1+0xfe>
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
     464:	90                   	nop
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     465:	83 ec 0c             	sub    $0xc,%esp
     468:	ff 75 ec             	pushl  -0x14(%ebp)
     46b:	e8 0c 38 00 00       	call   3c7c <close>
     470:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     473:	83 ec 0c             	sub    $0xc,%esp
     476:	68 58 43 00 00       	push   $0x4358
     47b:	e8 24 38 00 00       	call   3ca4 <unlink>
     480:	83 c4 10             	add    $0x10,%esp
     483:	85 c0                	test   %eax,%eax
     485:	79 1b                	jns    4a2 <writetest1+0x1e3>
    printf(stdout, "unlink big failed\n");
     487:	a1 28 5f 00 00       	mov    0x5f28,%eax
     48c:	83 ec 08             	sub    $0x8,%esp
     48f:	68 fc 43 00 00       	push   $0x43fc
     494:	50                   	push   %eax
     495:	e8 51 39 00 00       	call   3deb <printf>
     49a:	83 c4 10             	add    $0x10,%esp
    exit();
     49d:	e8 b2 37 00 00       	call   3c54 <exit>
  }
  printf(stdout, "big files ok\n");
     4a2:	a1 28 5f 00 00       	mov    0x5f28,%eax
     4a7:	83 ec 08             	sub    $0x8,%esp
     4aa:	68 0f 44 00 00       	push   $0x440f
     4af:	50                   	push   %eax
     4b0:	e8 36 39 00 00       	call   3deb <printf>
     4b5:	83 c4 10             	add    $0x10,%esp
}
     4b8:	90                   	nop
     4b9:	c9                   	leave  
     4ba:	c3                   	ret    

000004bb <createtest>:

void
createtest(void)
{
     4bb:	55                   	push   %ebp
     4bc:	89 e5                	mov    %esp,%ebp
     4be:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     4c1:	a1 28 5f 00 00       	mov    0x5f28,%eax
     4c6:	83 ec 08             	sub    $0x8,%esp
     4c9:	68 20 44 00 00       	push   $0x4420
     4ce:	50                   	push   %eax
     4cf:	e8 17 39 00 00       	call   3deb <printf>
     4d4:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     4d7:	c6 05 40 a7 00 00 61 	movb   $0x61,0xa740
  name[2] = '\0';
     4de:	c6 05 42 a7 00 00 00 	movb   $0x0,0xa742
  for(i = 0; i < 52; i++){
     4e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     4ec:	eb 35                	jmp    523 <createtest+0x68>
    name[1] = '0' + i;
     4ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
     4f1:	83 c0 30             	add    $0x30,%eax
     4f4:	a2 41 a7 00 00       	mov    %al,0xa741
    fd = open(name, O_CREATE|O_RDWR);
     4f9:	83 ec 08             	sub    $0x8,%esp
     4fc:	68 02 02 00 00       	push   $0x202
     501:	68 40 a7 00 00       	push   $0xa740
     506:	e8 89 37 00 00       	call   3c94 <open>
     50b:	83 c4 10             	add    $0x10,%esp
     50e:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     511:	83 ec 0c             	sub    $0xc,%esp
     514:	ff 75 f0             	pushl  -0x10(%ebp)
     517:	e8 60 37 00 00       	call   3c7c <close>
     51c:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     51f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     523:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     527:	7e c5                	jle    4ee <createtest+0x33>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     529:	c6 05 40 a7 00 00 61 	movb   $0x61,0xa740
  name[2] = '\0';
     530:	c6 05 42 a7 00 00 00 	movb   $0x0,0xa742
  for(i = 0; i < 52; i++){
     537:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     53e:	eb 1f                	jmp    55f <createtest+0xa4>
    name[1] = '0' + i;
     540:	8b 45 f4             	mov    -0xc(%ebp),%eax
     543:	83 c0 30             	add    $0x30,%eax
     546:	a2 41 a7 00 00       	mov    %al,0xa741
    unlink(name);
     54b:	83 ec 0c             	sub    $0xc,%esp
     54e:	68 40 a7 00 00       	push   $0xa740
     553:	e8 4c 37 00 00       	call   3ca4 <unlink>
     558:	83 c4 10             	add    $0x10,%esp
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     55b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     55f:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     563:	7e db                	jle    540 <createtest+0x85>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     565:	a1 28 5f 00 00       	mov    0x5f28,%eax
     56a:	83 ec 08             	sub    $0x8,%esp
     56d:	68 48 44 00 00       	push   $0x4448
     572:	50                   	push   %eax
     573:	e8 73 38 00 00       	call   3deb <printf>
     578:	83 c4 10             	add    $0x10,%esp
}
     57b:	90                   	nop
     57c:	c9                   	leave  
     57d:	c3                   	ret    

0000057e <dirtest>:

void dirtest(void)
{
     57e:	55                   	push   %ebp
     57f:	89 e5                	mov    %esp,%ebp
     581:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     584:	a1 28 5f 00 00       	mov    0x5f28,%eax
     589:	83 ec 08             	sub    $0x8,%esp
     58c:	68 6e 44 00 00       	push   $0x446e
     591:	50                   	push   %eax
     592:	e8 54 38 00 00       	call   3deb <printf>
     597:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     59a:	83 ec 0c             	sub    $0xc,%esp
     59d:	68 7a 44 00 00       	push   $0x447a
     5a2:	e8 15 37 00 00       	call   3cbc <mkdir>
     5a7:	83 c4 10             	add    $0x10,%esp
     5aa:	85 c0                	test   %eax,%eax
     5ac:	79 1b                	jns    5c9 <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     5ae:	a1 28 5f 00 00       	mov    0x5f28,%eax
     5b3:	83 ec 08             	sub    $0x8,%esp
     5b6:	68 7f 44 00 00       	push   $0x447f
     5bb:	50                   	push   %eax
     5bc:	e8 2a 38 00 00       	call   3deb <printf>
     5c1:	83 c4 10             	add    $0x10,%esp
    exit();
     5c4:	e8 8b 36 00 00       	call   3c54 <exit>
  }

  if(chdir("dir0") < 0){
     5c9:	83 ec 0c             	sub    $0xc,%esp
     5cc:	68 7a 44 00 00       	push   $0x447a
     5d1:	e8 ee 36 00 00       	call   3cc4 <chdir>
     5d6:	83 c4 10             	add    $0x10,%esp
     5d9:	85 c0                	test   %eax,%eax
     5db:	79 1b                	jns    5f8 <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
     5dd:	a1 28 5f 00 00       	mov    0x5f28,%eax
     5e2:	83 ec 08             	sub    $0x8,%esp
     5e5:	68 8d 44 00 00       	push   $0x448d
     5ea:	50                   	push   %eax
     5eb:	e8 fb 37 00 00       	call   3deb <printf>
     5f0:	83 c4 10             	add    $0x10,%esp
    exit();
     5f3:	e8 5c 36 00 00       	call   3c54 <exit>
  }

  if(chdir("..") < 0){
     5f8:	83 ec 0c             	sub    $0xc,%esp
     5fb:	68 a0 44 00 00       	push   $0x44a0
     600:	e8 bf 36 00 00       	call   3cc4 <chdir>
     605:	83 c4 10             	add    $0x10,%esp
     608:	85 c0                	test   %eax,%eax
     60a:	79 1b                	jns    627 <dirtest+0xa9>
    printf(stdout, "chdir .. failed\n");
     60c:	a1 28 5f 00 00       	mov    0x5f28,%eax
     611:	83 ec 08             	sub    $0x8,%esp
     614:	68 a3 44 00 00       	push   $0x44a3
     619:	50                   	push   %eax
     61a:	e8 cc 37 00 00       	call   3deb <printf>
     61f:	83 c4 10             	add    $0x10,%esp
    exit();
     622:	e8 2d 36 00 00       	call   3c54 <exit>
  }

  if(unlink("dir0") < 0){
     627:	83 ec 0c             	sub    $0xc,%esp
     62a:	68 7a 44 00 00       	push   $0x447a
     62f:	e8 70 36 00 00       	call   3ca4 <unlink>
     634:	83 c4 10             	add    $0x10,%esp
     637:	85 c0                	test   %eax,%eax
     639:	79 1b                	jns    656 <dirtest+0xd8>
    printf(stdout, "unlink dir0 failed\n");
     63b:	a1 28 5f 00 00       	mov    0x5f28,%eax
     640:	83 ec 08             	sub    $0x8,%esp
     643:	68 b4 44 00 00       	push   $0x44b4
     648:	50                   	push   %eax
     649:	e8 9d 37 00 00       	call   3deb <printf>
     64e:	83 c4 10             	add    $0x10,%esp
    exit();
     651:	e8 fe 35 00 00       	call   3c54 <exit>
  }
  printf(stdout, "mkdir test\n");
     656:	a1 28 5f 00 00       	mov    0x5f28,%eax
     65b:	83 ec 08             	sub    $0x8,%esp
     65e:	68 6e 44 00 00       	push   $0x446e
     663:	50                   	push   %eax
     664:	e8 82 37 00 00       	call   3deb <printf>
     669:	83 c4 10             	add    $0x10,%esp
}
     66c:	90                   	nop
     66d:	c9                   	leave  
     66e:	c3                   	ret    

0000066f <exectest>:

void
exectest(void)
{
     66f:	55                   	push   %ebp
     670:	89 e5                	mov    %esp,%ebp
     672:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     675:	a1 28 5f 00 00       	mov    0x5f28,%eax
     67a:	83 ec 08             	sub    $0x8,%esp
     67d:	68 c8 44 00 00       	push   $0x44c8
     682:	50                   	push   %eax
     683:	e8 63 37 00 00       	call   3deb <printf>
     688:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     68b:	83 ec 08             	sub    $0x8,%esp
     68e:	68 14 5f 00 00       	push   $0x5f14
     693:	68 a4 41 00 00       	push   $0x41a4
     698:	e8 ef 35 00 00       	call   3c8c <exec>
     69d:	83 c4 10             	add    $0x10,%esp
     6a0:	85 c0                	test   %eax,%eax
     6a2:	79 1b                	jns    6bf <exectest+0x50>
    printf(stdout, "exec echo failed\n");
     6a4:	a1 28 5f 00 00       	mov    0x5f28,%eax
     6a9:	83 ec 08             	sub    $0x8,%esp
     6ac:	68 d3 44 00 00       	push   $0x44d3
     6b1:	50                   	push   %eax
     6b2:	e8 34 37 00 00       	call   3deb <printf>
     6b7:	83 c4 10             	add    $0x10,%esp
    exit();
     6ba:	e8 95 35 00 00       	call   3c54 <exit>
  }
}
     6bf:	90                   	nop
     6c0:	c9                   	leave  
     6c1:	c3                   	ret    

000006c2 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     6c2:	55                   	push   %ebp
     6c3:	89 e5                	mov    %esp,%ebp
     6c5:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     6c8:	83 ec 0c             	sub    $0xc,%esp
     6cb:	8d 45 d8             	lea    -0x28(%ebp),%eax
     6ce:	50                   	push   %eax
     6cf:	e8 90 35 00 00       	call   3c64 <pipe>
     6d4:	83 c4 10             	add    $0x10,%esp
     6d7:	85 c0                	test   %eax,%eax
     6d9:	74 17                	je     6f2 <pipe1+0x30>
    printf(1, "pipe() failed\n");
     6db:	83 ec 08             	sub    $0x8,%esp
     6de:	68 e5 44 00 00       	push   $0x44e5
     6e3:	6a 01                	push   $0x1
     6e5:	e8 01 37 00 00       	call   3deb <printf>
     6ea:	83 c4 10             	add    $0x10,%esp
    exit();
     6ed:	e8 62 35 00 00       	call   3c54 <exit>
  }
  pid = fork();
     6f2:	e8 55 35 00 00       	call   3c4c <fork>
     6f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     6fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     701:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     705:	0f 85 89 00 00 00    	jne    794 <pipe1+0xd2>
    close(fds[0]);
     70b:	8b 45 d8             	mov    -0x28(%ebp),%eax
     70e:	83 ec 0c             	sub    $0xc,%esp
     711:	50                   	push   %eax
     712:	e8 65 35 00 00       	call   3c7c <close>
     717:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     71a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     721:	eb 66                	jmp    789 <pipe1+0xc7>
      for(i = 0; i < 1033; i++)
     723:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     72a:	eb 19                	jmp    745 <pipe1+0x83>
        buf[i] = seq++;
     72c:	8b 45 f4             	mov    -0xc(%ebp),%eax
     72f:	8d 50 01             	lea    0x1(%eax),%edx
     732:	89 55 f4             	mov    %edx,-0xc(%ebp)
     735:	89 c2                	mov    %eax,%edx
     737:	8b 45 f0             	mov    -0x10(%ebp),%eax
     73a:	05 40 87 00 00       	add    $0x8740,%eax
     73f:	88 10                	mov    %dl,(%eax)
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     741:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     745:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     74c:	7e de                	jle    72c <pipe1+0x6a>
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     74e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     751:	83 ec 04             	sub    $0x4,%esp
     754:	68 09 04 00 00       	push   $0x409
     759:	68 40 87 00 00       	push   $0x8740
     75e:	50                   	push   %eax
     75f:	e8 10 35 00 00       	call   3c74 <write>
     764:	83 c4 10             	add    $0x10,%esp
     767:	3d 09 04 00 00       	cmp    $0x409,%eax
     76c:	74 17                	je     785 <pipe1+0xc3>
        printf(1, "pipe1 oops 1\n");
     76e:	83 ec 08             	sub    $0x8,%esp
     771:	68 f4 44 00 00       	push   $0x44f4
     776:	6a 01                	push   $0x1
     778:	e8 6e 36 00 00       	call   3deb <printf>
     77d:	83 c4 10             	add    $0x10,%esp
        exit();
     780:	e8 cf 34 00 00       	call   3c54 <exit>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     785:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     789:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     78d:	7e 94                	jle    723 <pipe1+0x61>
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
     78f:	e8 c0 34 00 00       	call   3c54 <exit>
  } else if(pid > 0){
     794:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     798:	0f 8e f4 00 00 00    	jle    892 <pipe1+0x1d0>
    close(fds[1]);
     79e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     7a1:	83 ec 0c             	sub    $0xc,%esp
     7a4:	50                   	push   %eax
     7a5:	e8 d2 34 00 00       	call   3c7c <close>
     7aa:	83 c4 10             	add    $0x10,%esp
    total = 0;
     7ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     7b4:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     7bb:	eb 66                	jmp    823 <pipe1+0x161>
      for(i = 0; i < n; i++){
     7bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     7c4:	eb 3b                	jmp    801 <pipe1+0x13f>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     7c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
     7c9:	05 40 87 00 00       	add    $0x8740,%eax
     7ce:	0f b6 00             	movzbl (%eax),%eax
     7d1:	0f be c8             	movsbl %al,%ecx
     7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7d7:	8d 50 01             	lea    0x1(%eax),%edx
     7da:	89 55 f4             	mov    %edx,-0xc(%ebp)
     7dd:	31 c8                	xor    %ecx,%eax
     7df:	0f b6 c0             	movzbl %al,%eax
     7e2:	85 c0                	test   %eax,%eax
     7e4:	74 17                	je     7fd <pipe1+0x13b>
          printf(1, "pipe1 oops 2\n");
     7e6:	83 ec 08             	sub    $0x8,%esp
     7e9:	68 02 45 00 00       	push   $0x4502
     7ee:	6a 01                	push   $0x1
     7f0:	e8 f6 35 00 00       	call   3deb <printf>
     7f5:	83 c4 10             	add    $0x10,%esp
     7f8:	e9 ac 00 00 00       	jmp    8a9 <pipe1+0x1e7>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     7fd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     801:	8b 45 f0             	mov    -0x10(%ebp),%eax
     804:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     807:	7c bd                	jl     7c6 <pipe1+0x104>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     809:	8b 45 ec             	mov    -0x14(%ebp),%eax
     80c:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     80f:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     812:	8b 45 e8             	mov    -0x18(%ebp),%eax
     815:	3d 00 20 00 00       	cmp    $0x2000,%eax
     81a:	76 07                	jbe    823 <pipe1+0x161>
        cc = sizeof(buf);
     81c:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     823:	8b 45 d8             	mov    -0x28(%ebp),%eax
     826:	83 ec 04             	sub    $0x4,%esp
     829:	ff 75 e8             	pushl  -0x18(%ebp)
     82c:	68 40 87 00 00       	push   $0x8740
     831:	50                   	push   %eax
     832:	e8 35 34 00 00       	call   3c6c <read>
     837:	83 c4 10             	add    $0x10,%esp
     83a:	89 45 ec             	mov    %eax,-0x14(%ebp)
     83d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     841:	0f 8f 76 ff ff ff    	jg     7bd <pipe1+0xfb>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     847:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     84e:	74 1a                	je     86a <pipe1+0x1a8>
      printf(1, "pipe1 oops 3 total %d\n", total);
     850:	83 ec 04             	sub    $0x4,%esp
     853:	ff 75 e4             	pushl  -0x1c(%ebp)
     856:	68 10 45 00 00       	push   $0x4510
     85b:	6a 01                	push   $0x1
     85d:	e8 89 35 00 00       	call   3deb <printf>
     862:	83 c4 10             	add    $0x10,%esp
      exit();
     865:	e8 ea 33 00 00       	call   3c54 <exit>
    }
    close(fds[0]);
     86a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     86d:	83 ec 0c             	sub    $0xc,%esp
     870:	50                   	push   %eax
     871:	e8 06 34 00 00       	call   3c7c <close>
     876:	83 c4 10             	add    $0x10,%esp
    wait();
     879:	e8 de 33 00 00       	call   3c5c <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     87e:	83 ec 08             	sub    $0x8,%esp
     881:	68 36 45 00 00       	push   $0x4536
     886:	6a 01                	push   $0x1
     888:	e8 5e 35 00 00       	call   3deb <printf>
     88d:	83 c4 10             	add    $0x10,%esp
     890:	eb 17                	jmp    8a9 <pipe1+0x1e7>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     892:	83 ec 08             	sub    $0x8,%esp
     895:	68 27 45 00 00       	push   $0x4527
     89a:	6a 01                	push   $0x1
     89c:	e8 4a 35 00 00       	call   3deb <printf>
     8a1:	83 c4 10             	add    $0x10,%esp
    exit();
     8a4:	e8 ab 33 00 00       	call   3c54 <exit>
  }
  printf(1, "pipe1 ok\n");
}
     8a9:	c9                   	leave  
     8aa:	c3                   	ret    

000008ab <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     8ab:	55                   	push   %ebp
     8ac:	89 e5                	mov    %esp,%ebp
     8ae:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     8b1:	83 ec 08             	sub    $0x8,%esp
     8b4:	68 40 45 00 00       	push   $0x4540
     8b9:	6a 01                	push   $0x1
     8bb:	e8 2b 35 00 00       	call   3deb <printf>
     8c0:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     8c3:	e8 84 33 00 00       	call   3c4c <fork>
     8c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     8cb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     8cf:	75 02                	jne    8d3 <preempt+0x28>
    for(;;)
      ;
     8d1:	eb fe                	jmp    8d1 <preempt+0x26>

  pid2 = fork();
     8d3:	e8 74 33 00 00       	call   3c4c <fork>
     8d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     8db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     8df:	75 02                	jne    8e3 <preempt+0x38>
    for(;;)
      ;
     8e1:	eb fe                	jmp    8e1 <preempt+0x36>

  pipe(pfds);
     8e3:	83 ec 0c             	sub    $0xc,%esp
     8e6:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     8e9:	50                   	push   %eax
     8ea:	e8 75 33 00 00       	call   3c64 <pipe>
     8ef:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     8f2:	e8 55 33 00 00       	call   3c4c <fork>
     8f7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     8fa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     8fe:	75 4d                	jne    94d <preempt+0xa2>
    close(pfds[0]);
     900:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     903:	83 ec 0c             	sub    $0xc,%esp
     906:	50                   	push   %eax
     907:	e8 70 33 00 00       	call   3c7c <close>
     90c:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     90f:	8b 45 e8             	mov    -0x18(%ebp),%eax
     912:	83 ec 04             	sub    $0x4,%esp
     915:	6a 01                	push   $0x1
     917:	68 4a 45 00 00       	push   $0x454a
     91c:	50                   	push   %eax
     91d:	e8 52 33 00 00       	call   3c74 <write>
     922:	83 c4 10             	add    $0x10,%esp
     925:	83 f8 01             	cmp    $0x1,%eax
     928:	74 12                	je     93c <preempt+0x91>
      printf(1, "preempt write error");
     92a:	83 ec 08             	sub    $0x8,%esp
     92d:	68 4c 45 00 00       	push   $0x454c
     932:	6a 01                	push   $0x1
     934:	e8 b2 34 00 00       	call   3deb <printf>
     939:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     93c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     93f:	83 ec 0c             	sub    $0xc,%esp
     942:	50                   	push   %eax
     943:	e8 34 33 00 00       	call   3c7c <close>
     948:	83 c4 10             	add    $0x10,%esp
    for(;;)
      ;
     94b:	eb fe                	jmp    94b <preempt+0xa0>
  }

  close(pfds[1]);
     94d:	8b 45 e8             	mov    -0x18(%ebp),%eax
     950:	83 ec 0c             	sub    $0xc,%esp
     953:	50                   	push   %eax
     954:	e8 23 33 00 00       	call   3c7c <close>
     959:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     95c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     95f:	83 ec 04             	sub    $0x4,%esp
     962:	68 00 20 00 00       	push   $0x2000
     967:	68 40 87 00 00       	push   $0x8740
     96c:	50                   	push   %eax
     96d:	e8 fa 32 00 00       	call   3c6c <read>
     972:	83 c4 10             	add    $0x10,%esp
     975:	83 f8 01             	cmp    $0x1,%eax
     978:	74 14                	je     98e <preempt+0xe3>
    printf(1, "preempt read error");
     97a:	83 ec 08             	sub    $0x8,%esp
     97d:	68 60 45 00 00       	push   $0x4560
     982:	6a 01                	push   $0x1
     984:	e8 62 34 00 00       	call   3deb <printf>
     989:	83 c4 10             	add    $0x10,%esp
     98c:	eb 7e                	jmp    a0c <preempt+0x161>
    return;
  }
  close(pfds[0]);
     98e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     991:	83 ec 0c             	sub    $0xc,%esp
     994:	50                   	push   %eax
     995:	e8 e2 32 00 00       	call   3c7c <close>
     99a:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     99d:	83 ec 08             	sub    $0x8,%esp
     9a0:	68 73 45 00 00       	push   $0x4573
     9a5:	6a 01                	push   $0x1
     9a7:	e8 3f 34 00 00       	call   3deb <printf>
     9ac:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     9af:	83 ec 0c             	sub    $0xc,%esp
     9b2:	ff 75 f4             	pushl  -0xc(%ebp)
     9b5:	e8 ca 32 00 00       	call   3c84 <kill>
     9ba:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     9bd:	83 ec 0c             	sub    $0xc,%esp
     9c0:	ff 75 f0             	pushl  -0x10(%ebp)
     9c3:	e8 bc 32 00 00       	call   3c84 <kill>
     9c8:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     9cb:	83 ec 0c             	sub    $0xc,%esp
     9ce:	ff 75 ec             	pushl  -0x14(%ebp)
     9d1:	e8 ae 32 00 00       	call   3c84 <kill>
     9d6:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     9d9:	83 ec 08             	sub    $0x8,%esp
     9dc:	68 7c 45 00 00       	push   $0x457c
     9e1:	6a 01                	push   $0x1
     9e3:	e8 03 34 00 00       	call   3deb <printf>
     9e8:	83 c4 10             	add    $0x10,%esp
  wait();
     9eb:	e8 6c 32 00 00       	call   3c5c <wait>
  wait();
     9f0:	e8 67 32 00 00       	call   3c5c <wait>
  wait();
     9f5:	e8 62 32 00 00       	call   3c5c <wait>
  printf(1, "preempt ok\n");
     9fa:	83 ec 08             	sub    $0x8,%esp
     9fd:	68 85 45 00 00       	push   $0x4585
     a02:	6a 01                	push   $0x1
     a04:	e8 e2 33 00 00       	call   3deb <printf>
     a09:	83 c4 10             	add    $0x10,%esp
}
     a0c:	c9                   	leave  
     a0d:	c3                   	ret    

00000a0e <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     a0e:	55                   	push   %ebp
     a0f:	89 e5                	mov    %esp,%ebp
     a11:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     a14:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     a1b:	eb 4f                	jmp    a6c <exitwait+0x5e>
    pid = fork();
     a1d:	e8 2a 32 00 00       	call   3c4c <fork>
     a22:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     a25:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a29:	79 14                	jns    a3f <exitwait+0x31>
      printf(1, "fork failed\n");
     a2b:	83 ec 08             	sub    $0x8,%esp
     a2e:	68 91 45 00 00       	push   $0x4591
     a33:	6a 01                	push   $0x1
     a35:	e8 b1 33 00 00       	call   3deb <printf>
     a3a:	83 c4 10             	add    $0x10,%esp
      return;
     a3d:	eb 45                	jmp    a84 <exitwait+0x76>
    }
    if(pid){
     a3f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     a43:	74 1e                	je     a63 <exitwait+0x55>
      if(wait() != pid){
     a45:	e8 12 32 00 00       	call   3c5c <wait>
     a4a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
     a4d:	74 19                	je     a68 <exitwait+0x5a>
        printf(1, "wait wrong pid\n");
     a4f:	83 ec 08             	sub    $0x8,%esp
     a52:	68 9e 45 00 00       	push   $0x459e
     a57:	6a 01                	push   $0x1
     a59:	e8 8d 33 00 00       	call   3deb <printf>
     a5e:	83 c4 10             	add    $0x10,%esp
        return;
     a61:	eb 21                	jmp    a84 <exitwait+0x76>
      }
    } else {
      exit();
     a63:	e8 ec 31 00 00       	call   3c54 <exit>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     a68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     a6c:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     a70:	7e ab                	jle    a1d <exitwait+0xf>
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     a72:	83 ec 08             	sub    $0x8,%esp
     a75:	68 ae 45 00 00       	push   $0x45ae
     a7a:	6a 01                	push   $0x1
     a7c:	e8 6a 33 00 00       	call   3deb <printf>
     a81:	83 c4 10             	add    $0x10,%esp
}
     a84:	c9                   	leave  
     a85:	c3                   	ret    

00000a86 <mem>:

void
mem(void)
{
     a86:	55                   	push   %ebp
     a87:	89 e5                	mov    %esp,%ebp
     a89:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     a8c:	83 ec 08             	sub    $0x8,%esp
     a8f:	68 bb 45 00 00       	push   $0x45bb
     a94:	6a 01                	push   $0x1
     a96:	e8 50 33 00 00       	call   3deb <printf>
     a9b:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     a9e:	e8 31 32 00 00       	call   3cd4 <getpid>
     aa3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     aa6:	e8 a1 31 00 00       	call   3c4c <fork>
     aab:	89 45 ec             	mov    %eax,-0x14(%ebp)
     aae:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     ab2:	0f 85 b7 00 00 00    	jne    b6f <mem+0xe9>
    m1 = 0;
     ab8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     abf:	eb 0e                	jmp    acf <mem+0x49>
      *(char**)m2 = m1;
     ac1:	8b 45 e8             	mov    -0x18(%ebp),%eax
     ac4:	8b 55 f4             	mov    -0xc(%ebp),%edx
     ac7:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     ac9:	8b 45 e8             	mov    -0x18(%ebp),%eax
     acc:	89 45 f4             	mov    %eax,-0xc(%ebp)

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     acf:	83 ec 0c             	sub    $0xc,%esp
     ad2:	68 11 27 00 00       	push   $0x2711
     ad7:	e8 e2 35 00 00       	call   40be <malloc>
     adc:	83 c4 10             	add    $0x10,%esp
     adf:	89 45 e8             	mov    %eax,-0x18(%ebp)
     ae2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     ae6:	75 d9                	jne    ac1 <mem+0x3b>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     ae8:	eb 1c                	jmp    b06 <mem+0x80>
      m2 = *(char**)m1;
     aea:	8b 45 f4             	mov    -0xc(%ebp),%eax
     aed:	8b 00                	mov    (%eax),%eax
     aef:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     af2:	83 ec 0c             	sub    $0xc,%esp
     af5:	ff 75 f4             	pushl  -0xc(%ebp)
     af8:	e8 7f 34 00 00       	call   3f7c <free>
     afd:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     b00:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b03:	89 45 f4             	mov    %eax,-0xc(%ebp)
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     b06:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b0a:	75 de                	jne    aea <mem+0x64>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     b0c:	83 ec 0c             	sub    $0xc,%esp
     b0f:	68 00 50 00 00       	push   $0x5000
     b14:	e8 a5 35 00 00       	call   40be <malloc>
     b19:	83 c4 10             	add    $0x10,%esp
     b1c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     b1f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     b23:	75 25                	jne    b4a <mem+0xc4>
      printf(1, "couldn't allocate mem?!!\n");
     b25:	83 ec 08             	sub    $0x8,%esp
     b28:	68 c5 45 00 00       	push   $0x45c5
     b2d:	6a 01                	push   $0x1
     b2f:	e8 b7 32 00 00       	call   3deb <printf>
     b34:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     b37:	83 ec 0c             	sub    $0xc,%esp
     b3a:	ff 75 f0             	pushl  -0x10(%ebp)
     b3d:	e8 42 31 00 00       	call   3c84 <kill>
     b42:	83 c4 10             	add    $0x10,%esp
      exit();
     b45:	e8 0a 31 00 00       	call   3c54 <exit>
    }
    free(m1);
     b4a:	83 ec 0c             	sub    $0xc,%esp
     b4d:	ff 75 f4             	pushl  -0xc(%ebp)
     b50:	e8 27 34 00 00       	call   3f7c <free>
     b55:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     b58:	83 ec 08             	sub    $0x8,%esp
     b5b:	68 df 45 00 00       	push   $0x45df
     b60:	6a 01                	push   $0x1
     b62:	e8 84 32 00 00       	call   3deb <printf>
     b67:	83 c4 10             	add    $0x10,%esp
    exit();
     b6a:	e8 e5 30 00 00       	call   3c54 <exit>
  } else {
    wait();
     b6f:	e8 e8 30 00 00       	call   3c5c <wait>
  }
}
     b74:	90                   	nop
     b75:	c9                   	leave  
     b76:	c3                   	ret    

00000b77 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     b77:	55                   	push   %ebp
     b78:	89 e5                	mov    %esp,%ebp
     b7a:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     b7d:	83 ec 08             	sub    $0x8,%esp
     b80:	68 e7 45 00 00       	push   $0x45e7
     b85:	6a 01                	push   $0x1
     b87:	e8 5f 32 00 00       	call   3deb <printf>
     b8c:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     b8f:	83 ec 0c             	sub    $0xc,%esp
     b92:	68 f6 45 00 00       	push   $0x45f6
     b97:	e8 08 31 00 00       	call   3ca4 <unlink>
     b9c:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     b9f:	83 ec 08             	sub    $0x8,%esp
     ba2:	68 02 02 00 00       	push   $0x202
     ba7:	68 f6 45 00 00       	push   $0x45f6
     bac:	e8 e3 30 00 00       	call   3c94 <open>
     bb1:	83 c4 10             	add    $0x10,%esp
     bb4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     bb7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     bbb:	79 17                	jns    bd4 <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     bbd:	83 ec 08             	sub    $0x8,%esp
     bc0:	68 00 46 00 00       	push   $0x4600
     bc5:	6a 01                	push   $0x1
     bc7:	e8 1f 32 00 00       	call   3deb <printf>
     bcc:	83 c4 10             	add    $0x10,%esp
    return;
     bcf:	e9 84 01 00 00       	jmp    d58 <sharedfd+0x1e1>
  }
  pid = fork();
     bd4:	e8 73 30 00 00       	call   3c4c <fork>
     bd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     bdc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     be0:	75 07                	jne    be9 <sharedfd+0x72>
     be2:	b8 63 00 00 00       	mov    $0x63,%eax
     be7:	eb 05                	jmp    bee <sharedfd+0x77>
     be9:	b8 70 00 00 00       	mov    $0x70,%eax
     bee:	83 ec 04             	sub    $0x4,%esp
     bf1:	6a 0a                	push   $0xa
     bf3:	50                   	push   %eax
     bf4:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     bf7:	50                   	push   %eax
     bf8:	e8 6b 2e 00 00       	call   3a68 <memset>
     bfd:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     c00:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     c07:	eb 31                	jmp    c3a <sharedfd+0xc3>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     c09:	83 ec 04             	sub    $0x4,%esp
     c0c:	6a 0a                	push   $0xa
     c0e:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     c11:	50                   	push   %eax
     c12:	ff 75 e8             	pushl  -0x18(%ebp)
     c15:	e8 5a 30 00 00       	call   3c74 <write>
     c1a:	83 c4 10             	add    $0x10,%esp
     c1d:	83 f8 0a             	cmp    $0xa,%eax
     c20:	74 14                	je     c36 <sharedfd+0xbf>
      printf(1, "fstests: write sharedfd failed\n");
     c22:	83 ec 08             	sub    $0x8,%esp
     c25:	68 2c 46 00 00       	push   $0x462c
     c2a:	6a 01                	push   $0x1
     c2c:	e8 ba 31 00 00       	call   3deb <printf>
     c31:	83 c4 10             	add    $0x10,%esp
      break;
     c34:	eb 0d                	jmp    c43 <sharedfd+0xcc>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
  memset(buf, pid==0?'c':'p', sizeof(buf));
  for(i = 0; i < 1000; i++){
     c36:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     c3a:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     c41:	7e c6                	jle    c09 <sharedfd+0x92>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
      printf(1, "fstests: write sharedfd failed\n");
      break;
    }
  }
  if(pid == 0)
     c43:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     c47:	75 05                	jne    c4e <sharedfd+0xd7>
    exit();
     c49:	e8 06 30 00 00       	call   3c54 <exit>
  else
    wait();
     c4e:	e8 09 30 00 00       	call   3c5c <wait>
  close(fd);
     c53:	83 ec 0c             	sub    $0xc,%esp
     c56:	ff 75 e8             	pushl  -0x18(%ebp)
     c59:	e8 1e 30 00 00       	call   3c7c <close>
     c5e:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     c61:	83 ec 08             	sub    $0x8,%esp
     c64:	6a 00                	push   $0x0
     c66:	68 f6 45 00 00       	push   $0x45f6
     c6b:	e8 24 30 00 00       	call   3c94 <open>
     c70:	83 c4 10             	add    $0x10,%esp
     c73:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     c76:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     c7a:	79 17                	jns    c93 <sharedfd+0x11c>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     c7c:	83 ec 08             	sub    $0x8,%esp
     c7f:	68 4c 46 00 00       	push   $0x464c
     c84:	6a 01                	push   $0x1
     c86:	e8 60 31 00 00       	call   3deb <printf>
     c8b:	83 c4 10             	add    $0x10,%esp
    return;
     c8e:	e9 c5 00 00 00       	jmp    d58 <sharedfd+0x1e1>
  }
  nc = np = 0;
     c93:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     c9a:	8b 45 ec             	mov    -0x14(%ebp),%eax
     c9d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     ca0:	eb 3b                	jmp    cdd <sharedfd+0x166>
    for(i = 0; i < sizeof(buf); i++){
     ca2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     ca9:	eb 2a                	jmp    cd5 <sharedfd+0x15e>
      if(buf[i] == 'c')
     cab:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     cae:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cb1:	01 d0                	add    %edx,%eax
     cb3:	0f b6 00             	movzbl (%eax),%eax
     cb6:	3c 63                	cmp    $0x63,%al
     cb8:	75 04                	jne    cbe <sharedfd+0x147>
        nc++;
     cba:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
     cbe:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     cc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cc4:	01 d0                	add    %edx,%eax
     cc6:	0f b6 00             	movzbl (%eax),%eax
     cc9:	3c 70                	cmp    $0x70,%al
     ccb:	75 04                	jne    cd1 <sharedfd+0x15a>
        np++;
     ccd:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     cd1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     cd5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     cd8:	83 f8 09             	cmp    $0x9,%eax
     cdb:	76 ce                	jbe    cab <sharedfd+0x134>
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     cdd:	83 ec 04             	sub    $0x4,%esp
     ce0:	6a 0a                	push   $0xa
     ce2:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ce5:	50                   	push   %eax
     ce6:	ff 75 e8             	pushl  -0x18(%ebp)
     ce9:	e8 7e 2f 00 00       	call   3c6c <read>
     cee:	83 c4 10             	add    $0x10,%esp
     cf1:	89 45 e0             	mov    %eax,-0x20(%ebp)
     cf4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     cf8:	7f a8                	jg     ca2 <sharedfd+0x12b>
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     cfa:	83 ec 0c             	sub    $0xc,%esp
     cfd:	ff 75 e8             	pushl  -0x18(%ebp)
     d00:	e8 77 2f 00 00       	call   3c7c <close>
     d05:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
     d08:	83 ec 0c             	sub    $0xc,%esp
     d0b:	68 f6 45 00 00       	push   $0x45f6
     d10:	e8 8f 2f 00 00       	call   3ca4 <unlink>
     d15:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
     d18:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
     d1f:	75 1d                	jne    d3e <sharedfd+0x1c7>
     d21:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
     d28:	75 14                	jne    d3e <sharedfd+0x1c7>
    printf(1, "sharedfd ok\n");
     d2a:	83 ec 08             	sub    $0x8,%esp
     d2d:	68 77 46 00 00       	push   $0x4677
     d32:	6a 01                	push   $0x1
     d34:	e8 b2 30 00 00       	call   3deb <printf>
     d39:	83 c4 10             	add    $0x10,%esp
     d3c:	eb 1a                	jmp    d58 <sharedfd+0x1e1>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
     d3e:	ff 75 ec             	pushl  -0x14(%ebp)
     d41:	ff 75 f0             	pushl  -0x10(%ebp)
     d44:	68 84 46 00 00       	push   $0x4684
     d49:	6a 01                	push   $0x1
     d4b:	e8 9b 30 00 00       	call   3deb <printf>
     d50:	83 c4 10             	add    $0x10,%esp
    exit();
     d53:	e8 fc 2e 00 00       	call   3c54 <exit>
  }
}
     d58:	c9                   	leave  
     d59:	c3                   	ret    

00000d5a <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     d5a:	55                   	push   %ebp
     d5b:	89 e5                	mov    %esp,%ebp
     d5d:	83 ec 28             	sub    $0x28,%esp
  int fd, pid, i, j, n, total;
  char *fname;

  printf(1, "twofiles test\n");
     d60:	83 ec 08             	sub    $0x8,%esp
     d63:	68 99 46 00 00       	push   $0x4699
     d68:	6a 01                	push   $0x1
     d6a:	e8 7c 30 00 00       	call   3deb <printf>
     d6f:	83 c4 10             	add    $0x10,%esp

  unlink("f1");
     d72:	83 ec 0c             	sub    $0xc,%esp
     d75:	68 a8 46 00 00       	push   $0x46a8
     d7a:	e8 25 2f 00 00       	call   3ca4 <unlink>
     d7f:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     d82:	83 ec 0c             	sub    $0xc,%esp
     d85:	68 ab 46 00 00       	push   $0x46ab
     d8a:	e8 15 2f 00 00       	call   3ca4 <unlink>
     d8f:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     d92:	e8 b5 2e 00 00       	call   3c4c <fork>
     d97:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
     d9a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     d9e:	79 17                	jns    db7 <twofiles+0x5d>
    printf(1, "fork failed\n");
     da0:	83 ec 08             	sub    $0x8,%esp
     da3:	68 91 45 00 00       	push   $0x4591
     da8:	6a 01                	push   $0x1
     daa:	e8 3c 30 00 00       	call   3deb <printf>
     daf:	83 c4 10             	add    $0x10,%esp
    exit();
     db2:	e8 9d 2e 00 00       	call   3c54 <exit>
  }

  fname = pid ? "f1" : "f2";
     db7:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     dbb:	74 07                	je     dc4 <twofiles+0x6a>
     dbd:	b8 a8 46 00 00       	mov    $0x46a8,%eax
     dc2:	eb 05                	jmp    dc9 <twofiles+0x6f>
     dc4:	b8 ab 46 00 00       	mov    $0x46ab,%eax
     dc9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  fd = open(fname, O_CREATE | O_RDWR);
     dcc:	83 ec 08             	sub    $0x8,%esp
     dcf:	68 02 02 00 00       	push   $0x202
     dd4:	ff 75 e4             	pushl  -0x1c(%ebp)
     dd7:	e8 b8 2e 00 00       	call   3c94 <open>
     ddc:	83 c4 10             	add    $0x10,%esp
     ddf:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(fd < 0){
     de2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     de6:	79 17                	jns    dff <twofiles+0xa5>
    printf(1, "create failed\n");
     de8:	83 ec 08             	sub    $0x8,%esp
     deb:	68 ae 46 00 00       	push   $0x46ae
     df0:	6a 01                	push   $0x1
     df2:	e8 f4 2f 00 00       	call   3deb <printf>
     df7:	83 c4 10             	add    $0x10,%esp
    exit();
     dfa:	e8 55 2e 00 00       	call   3c54 <exit>
  }

  memset(buf, pid?'p':'c', 512);
     dff:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e03:	74 07                	je     e0c <twofiles+0xb2>
     e05:	b8 70 00 00 00       	mov    $0x70,%eax
     e0a:	eb 05                	jmp    e11 <twofiles+0xb7>
     e0c:	b8 63 00 00 00       	mov    $0x63,%eax
     e11:	83 ec 04             	sub    $0x4,%esp
     e14:	68 00 02 00 00       	push   $0x200
     e19:	50                   	push   %eax
     e1a:	68 40 87 00 00       	push   $0x8740
     e1f:	e8 44 2c 00 00       	call   3a68 <memset>
     e24:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 12; i++){
     e27:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e2e:	eb 42                	jmp    e72 <twofiles+0x118>
    if((n = write(fd, buf, 500)) != 500){
     e30:	83 ec 04             	sub    $0x4,%esp
     e33:	68 f4 01 00 00       	push   $0x1f4
     e38:	68 40 87 00 00       	push   $0x8740
     e3d:	ff 75 e0             	pushl  -0x20(%ebp)
     e40:	e8 2f 2e 00 00       	call   3c74 <write>
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	89 45 dc             	mov    %eax,-0x24(%ebp)
     e4b:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
     e52:	74 1a                	je     e6e <twofiles+0x114>
      printf(1, "write failed %d\n", n);
     e54:	83 ec 04             	sub    $0x4,%esp
     e57:	ff 75 dc             	pushl  -0x24(%ebp)
     e5a:	68 bd 46 00 00       	push   $0x46bd
     e5f:	6a 01                	push   $0x1
     e61:	e8 85 2f 00 00       	call   3deb <printf>
     e66:	83 c4 10             	add    $0x10,%esp
      exit();
     e69:	e8 e6 2d 00 00       	call   3c54 <exit>
    printf(1, "create failed\n");
    exit();
  }

  memset(buf, pid?'p':'c', 512);
  for(i = 0; i < 12; i++){
     e6e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     e72:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
     e76:	7e b8                	jle    e30 <twofiles+0xd6>
    if((n = write(fd, buf, 500)) != 500){
      printf(1, "write failed %d\n", n);
      exit();
    }
  }
  close(fd);
     e78:	83 ec 0c             	sub    $0xc,%esp
     e7b:	ff 75 e0             	pushl  -0x20(%ebp)
     e7e:	e8 f9 2d 00 00       	call   3c7c <close>
     e83:	83 c4 10             	add    $0x10,%esp
  if(pid)
     e86:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     e8a:	74 11                	je     e9d <twofiles+0x143>
    wait();
     e8c:	e8 cb 2d 00 00       	call   3c5c <wait>
  else
    exit();

  for(i = 0; i < 2; i++){
     e91:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     e98:	e9 dd 00 00 00       	jmp    f7a <twofiles+0x220>
  }
  close(fd);
  if(pid)
    wait();
  else
    exit();
     e9d:	e8 b2 2d 00 00       	call   3c54 <exit>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
     ea2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ea6:	74 07                	je     eaf <twofiles+0x155>
     ea8:	b8 a8 46 00 00       	mov    $0x46a8,%eax
     ead:	eb 05                	jmp    eb4 <twofiles+0x15a>
     eaf:	b8 ab 46 00 00       	mov    $0x46ab,%eax
     eb4:	83 ec 08             	sub    $0x8,%esp
     eb7:	6a 00                	push   $0x0
     eb9:	50                   	push   %eax
     eba:	e8 d5 2d 00 00       	call   3c94 <open>
     ebf:	83 c4 10             	add    $0x10,%esp
     ec2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    total = 0;
     ec5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
     ecc:	eb 56                	jmp    f24 <twofiles+0x1ca>
      for(j = 0; j < n; j++){
     ece:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ed5:	eb 3f                	jmp    f16 <twofiles+0x1bc>
        if(buf[j] != (i?'p':'c')){
     ed7:	8b 45 f0             	mov    -0x10(%ebp),%eax
     eda:	05 40 87 00 00       	add    $0x8740,%eax
     edf:	0f b6 00             	movzbl (%eax),%eax
     ee2:	0f be c0             	movsbl %al,%eax
     ee5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     ee9:	74 07                	je     ef2 <twofiles+0x198>
     eeb:	ba 70 00 00 00       	mov    $0x70,%edx
     ef0:	eb 05                	jmp    ef7 <twofiles+0x19d>
     ef2:	ba 63 00 00 00       	mov    $0x63,%edx
     ef7:	39 d0                	cmp    %edx,%eax
     ef9:	74 17                	je     f12 <twofiles+0x1b8>
          printf(1, "wrong char\n");
     efb:	83 ec 08             	sub    $0x8,%esp
     efe:	68 ce 46 00 00       	push   $0x46ce
     f03:	6a 01                	push   $0x1
     f05:	e8 e1 2e 00 00       	call   3deb <printf>
     f0a:	83 c4 10             	add    $0x10,%esp
          exit();
     f0d:	e8 42 2d 00 00       	call   3c54 <exit>

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
     f12:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     f16:	8b 45 f0             	mov    -0x10(%ebp),%eax
     f19:	3b 45 dc             	cmp    -0x24(%ebp),%eax
     f1c:	7c b9                	jl     ed7 <twofiles+0x17d>
        if(buf[j] != (i?'p':'c')){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
     f1e:	8b 45 dc             	mov    -0x24(%ebp),%eax
     f21:	01 45 ec             	add    %eax,-0x14(%ebp)
    exit();

  for(i = 0; i < 2; i++){
    fd = open(i?"f1":"f2", 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f24:	83 ec 04             	sub    $0x4,%esp
     f27:	68 00 20 00 00       	push   $0x2000
     f2c:	68 40 87 00 00       	push   $0x8740
     f31:	ff 75 e0             	pushl  -0x20(%ebp)
     f34:	e8 33 2d 00 00       	call   3c6c <read>
     f39:	83 c4 10             	add    $0x10,%esp
     f3c:	89 45 dc             	mov    %eax,-0x24(%ebp)
     f3f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
     f43:	7f 89                	jg     ece <twofiles+0x174>
          exit();
        }
      }
      total += n;
    }
    close(fd);
     f45:	83 ec 0c             	sub    $0xc,%esp
     f48:	ff 75 e0             	pushl  -0x20(%ebp)
     f4b:	e8 2c 2d 00 00       	call   3c7c <close>
     f50:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
     f53:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
     f5a:	74 1a                	je     f76 <twofiles+0x21c>
      printf(1, "wrong length %d\n", total);
     f5c:	83 ec 04             	sub    $0x4,%esp
     f5f:	ff 75 ec             	pushl  -0x14(%ebp)
     f62:	68 da 46 00 00       	push   $0x46da
     f67:	6a 01                	push   $0x1
     f69:	e8 7d 2e 00 00       	call   3deb <printf>
     f6e:	83 c4 10             	add    $0x10,%esp
      exit();
     f71:	e8 de 2c 00 00       	call   3c54 <exit>
  if(pid)
    wait();
  else
    exit();

  for(i = 0; i < 2; i++){
     f76:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f7a:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
     f7e:	0f 8e 1e ff ff ff    	jle    ea2 <twofiles+0x148>
      printf(1, "wrong length %d\n", total);
      exit();
    }
  }

  unlink("f1");
     f84:	83 ec 0c             	sub    $0xc,%esp
     f87:	68 a8 46 00 00       	push   $0x46a8
     f8c:	e8 13 2d 00 00       	call   3ca4 <unlink>
     f91:	83 c4 10             	add    $0x10,%esp
  unlink("f2");
     f94:	83 ec 0c             	sub    $0xc,%esp
     f97:	68 ab 46 00 00       	push   $0x46ab
     f9c:	e8 03 2d 00 00       	call   3ca4 <unlink>
     fa1:	83 c4 10             	add    $0x10,%esp

  printf(1, "twofiles ok\n");
     fa4:	83 ec 08             	sub    $0x8,%esp
     fa7:	68 eb 46 00 00       	push   $0x46eb
     fac:	6a 01                	push   $0x1
     fae:	e8 38 2e 00 00       	call   3deb <printf>
     fb3:	83 c4 10             	add    $0x10,%esp
}
     fb6:	90                   	nop
     fb7:	c9                   	leave  
     fb8:	c3                   	ret    

00000fb9 <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
     fb9:	55                   	push   %ebp
     fba:	89 e5                	mov    %esp,%ebp
     fbc:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd;
  char name[32];

  printf(1, "createdelete test\n");
     fbf:	83 ec 08             	sub    $0x8,%esp
     fc2:	68 f8 46 00 00       	push   $0x46f8
     fc7:	6a 01                	push   $0x1
     fc9:	e8 1d 2e 00 00       	call   3deb <printf>
     fce:	83 c4 10             	add    $0x10,%esp
  pid = fork();
     fd1:	e8 76 2c 00 00       	call   3c4c <fork>
     fd6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid < 0){
     fd9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     fdd:	79 17                	jns    ff6 <createdelete+0x3d>
    printf(1, "fork failed\n");
     fdf:	83 ec 08             	sub    $0x8,%esp
     fe2:	68 91 45 00 00       	push   $0x4591
     fe7:	6a 01                	push   $0x1
     fe9:	e8 fd 2d 00 00       	call   3deb <printf>
     fee:	83 c4 10             	add    $0x10,%esp
    exit();
     ff1:	e8 5e 2c 00 00       	call   3c54 <exit>
  }

  name[0] = pid ? 'p' : 'c';
     ff6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     ffa:	74 07                	je     1003 <createdelete+0x4a>
     ffc:	b8 70 00 00 00       	mov    $0x70,%eax
    1001:	eb 05                	jmp    1008 <createdelete+0x4f>
    1003:	b8 63 00 00 00       	mov    $0x63,%eax
    1008:	88 45 cc             	mov    %al,-0x34(%ebp)
  name[2] = '\0';
    100b:	c6 45 ce 00          	movb   $0x0,-0x32(%ebp)
  for(i = 0; i < N; i++){
    100f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1016:	e9 9b 00 00 00       	jmp    10b6 <createdelete+0xfd>
    name[1] = '0' + i;
    101b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    101e:	83 c0 30             	add    $0x30,%eax
    1021:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, O_CREATE | O_RDWR);
    1024:	83 ec 08             	sub    $0x8,%esp
    1027:	68 02 02 00 00       	push   $0x202
    102c:	8d 45 cc             	lea    -0x34(%ebp),%eax
    102f:	50                   	push   %eax
    1030:	e8 5f 2c 00 00       	call   3c94 <open>
    1035:	83 c4 10             	add    $0x10,%esp
    1038:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    103b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    103f:	79 17                	jns    1058 <createdelete+0x9f>
      printf(1, "create failed\n");
    1041:	83 ec 08             	sub    $0x8,%esp
    1044:	68 ae 46 00 00       	push   $0x46ae
    1049:	6a 01                	push   $0x1
    104b:	e8 9b 2d 00 00       	call   3deb <printf>
    1050:	83 c4 10             	add    $0x10,%esp
      exit();
    1053:	e8 fc 2b 00 00       	call   3c54 <exit>
    }
    close(fd);
    1058:	83 ec 0c             	sub    $0xc,%esp
    105b:	ff 75 ec             	pushl  -0x14(%ebp)
    105e:	e8 19 2c 00 00       	call   3c7c <close>
    1063:	83 c4 10             	add    $0x10,%esp
    if(i > 0 && (i % 2 ) == 0){
    1066:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    106a:	7e 46                	jle    10b2 <createdelete+0xf9>
    106c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    106f:	83 e0 01             	and    $0x1,%eax
    1072:	85 c0                	test   %eax,%eax
    1074:	75 3c                	jne    10b2 <createdelete+0xf9>
      name[1] = '0' + (i / 2);
    1076:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1079:	89 c2                	mov    %eax,%edx
    107b:	c1 ea 1f             	shr    $0x1f,%edx
    107e:	01 d0                	add    %edx,%eax
    1080:	d1 f8                	sar    %eax
    1082:	83 c0 30             	add    $0x30,%eax
    1085:	88 45 cd             	mov    %al,-0x33(%ebp)
      if(unlink(name) < 0){
    1088:	83 ec 0c             	sub    $0xc,%esp
    108b:	8d 45 cc             	lea    -0x34(%ebp),%eax
    108e:	50                   	push   %eax
    108f:	e8 10 2c 00 00       	call   3ca4 <unlink>
    1094:	83 c4 10             	add    $0x10,%esp
    1097:	85 c0                	test   %eax,%eax
    1099:	79 17                	jns    10b2 <createdelete+0xf9>
        printf(1, "unlink failed\n");
    109b:	83 ec 08             	sub    $0x8,%esp
    109e:	68 0b 47 00 00       	push   $0x470b
    10a3:	6a 01                	push   $0x1
    10a5:	e8 41 2d 00 00       	call   3deb <printf>
    10aa:	83 c4 10             	add    $0x10,%esp
        exit();
    10ad:	e8 a2 2b 00 00       	call   3c54 <exit>
    exit();
  }

  name[0] = pid ? 'p' : 'c';
  name[2] = '\0';
  for(i = 0; i < N; i++){
    10b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    10b6:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    10ba:	0f 8e 5b ff ff ff    	jle    101b <createdelete+0x62>
        exit();
      }
    }
  }

  if(pid==0)
    10c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    10c4:	75 05                	jne    10cb <createdelete+0x112>
    exit();
    10c6:	e8 89 2b 00 00       	call   3c54 <exit>
  else
    wait();
    10cb:	e8 8c 2b 00 00       	call   3c5c <wait>

  for(i = 0; i < N; i++){
    10d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    10d7:	e9 22 01 00 00       	jmp    11fe <createdelete+0x245>
    name[0] = 'p';
    10dc:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    10e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    10e3:	83 c0 30             	add    $0x30,%eax
    10e6:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    10e9:	83 ec 08             	sub    $0x8,%esp
    10ec:	6a 00                	push   $0x0
    10ee:	8d 45 cc             	lea    -0x34(%ebp),%eax
    10f1:	50                   	push   %eax
    10f2:	e8 9d 2b 00 00       	call   3c94 <open>
    10f7:	83 c4 10             	add    $0x10,%esp
    10fa:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    10fd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1101:	74 06                	je     1109 <createdelete+0x150>
    1103:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1107:	7e 21                	jle    112a <createdelete+0x171>
    1109:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    110d:	79 1b                	jns    112a <createdelete+0x171>
      printf(1, "oops createdelete %s didn't exist\n", name);
    110f:	83 ec 04             	sub    $0x4,%esp
    1112:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1115:	50                   	push   %eax
    1116:	68 1c 47 00 00       	push   $0x471c
    111b:	6a 01                	push   $0x1
    111d:	e8 c9 2c 00 00       	call   3deb <printf>
    1122:	83 c4 10             	add    $0x10,%esp
      exit();
    1125:	e8 2a 2b 00 00       	call   3c54 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    112a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    112e:	7e 27                	jle    1157 <createdelete+0x19e>
    1130:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1134:	7f 21                	jg     1157 <createdelete+0x19e>
    1136:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    113a:	78 1b                	js     1157 <createdelete+0x19e>
      printf(1, "oops createdelete %s did exist\n", name);
    113c:	83 ec 04             	sub    $0x4,%esp
    113f:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1142:	50                   	push   %eax
    1143:	68 40 47 00 00       	push   $0x4740
    1148:	6a 01                	push   $0x1
    114a:	e8 9c 2c 00 00       	call   3deb <printf>
    114f:	83 c4 10             	add    $0x10,%esp
      exit();
    1152:	e8 fd 2a 00 00       	call   3c54 <exit>
    }
    if(fd >= 0)
    1157:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    115b:	78 0e                	js     116b <createdelete+0x1b2>
      close(fd);
    115d:	83 ec 0c             	sub    $0xc,%esp
    1160:	ff 75 ec             	pushl  -0x14(%ebp)
    1163:	e8 14 2b 00 00       	call   3c7c <close>
    1168:	83 c4 10             	add    $0x10,%esp

    name[0] = 'c';
    116b:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    name[1] = '0' + i;
    116f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1172:	83 c0 30             	add    $0x30,%eax
    1175:	88 45 cd             	mov    %al,-0x33(%ebp)
    fd = open(name, 0);
    1178:	83 ec 08             	sub    $0x8,%esp
    117b:	6a 00                	push   $0x0
    117d:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1180:	50                   	push   %eax
    1181:	e8 0e 2b 00 00       	call   3c94 <open>
    1186:	83 c4 10             	add    $0x10,%esp
    1189:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((i == 0 || i >= N/2) && fd < 0){
    118c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1190:	74 06                	je     1198 <createdelete+0x1df>
    1192:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1196:	7e 21                	jle    11b9 <createdelete+0x200>
    1198:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    119c:	79 1b                	jns    11b9 <createdelete+0x200>
      printf(1, "oops createdelete %s didn't exist\n", name);
    119e:	83 ec 04             	sub    $0x4,%esp
    11a1:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11a4:	50                   	push   %eax
    11a5:	68 1c 47 00 00       	push   $0x471c
    11aa:	6a 01                	push   $0x1
    11ac:	e8 3a 2c 00 00       	call   3deb <printf>
    11b1:	83 c4 10             	add    $0x10,%esp
      exit();
    11b4:	e8 9b 2a 00 00       	call   3c54 <exit>
    } else if((i >= 1 && i < N/2) && fd >= 0){
    11b9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    11bd:	7e 27                	jle    11e6 <createdelete+0x22d>
    11bf:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    11c3:	7f 21                	jg     11e6 <createdelete+0x22d>
    11c5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11c9:	78 1b                	js     11e6 <createdelete+0x22d>
      printf(1, "oops createdelete %s did exist\n", name);
    11cb:	83 ec 04             	sub    $0x4,%esp
    11ce:	8d 45 cc             	lea    -0x34(%ebp),%eax
    11d1:	50                   	push   %eax
    11d2:	68 40 47 00 00       	push   $0x4740
    11d7:	6a 01                	push   $0x1
    11d9:	e8 0d 2c 00 00       	call   3deb <printf>
    11de:	83 c4 10             	add    $0x10,%esp
      exit();
    11e1:	e8 6e 2a 00 00       	call   3c54 <exit>
    }
    if(fd >= 0)
    11e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    11ea:	78 0e                	js     11fa <createdelete+0x241>
      close(fd);
    11ec:	83 ec 0c             	sub    $0xc,%esp
    11ef:	ff 75 ec             	pushl  -0x14(%ebp)
    11f2:	e8 85 2a 00 00       	call   3c7c <close>
    11f7:	83 c4 10             	add    $0x10,%esp
  if(pid==0)
    exit();
  else
    wait();

  for(i = 0; i < N; i++){
    11fa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    11fe:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1202:	0f 8e d4 fe ff ff    	jle    10dc <createdelete+0x123>
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1208:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    120f:	eb 33                	jmp    1244 <createdelete+0x28b>
    name[0] = 'p';
    1211:	c6 45 cc 70          	movb   $0x70,-0x34(%ebp)
    name[1] = '0' + i;
    1215:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1218:	83 c0 30             	add    $0x30,%eax
    121b:	88 45 cd             	mov    %al,-0x33(%ebp)
    unlink(name);
    121e:	83 ec 0c             	sub    $0xc,%esp
    1221:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1224:	50                   	push   %eax
    1225:	e8 7a 2a 00 00       	call   3ca4 <unlink>
    122a:	83 c4 10             	add    $0x10,%esp
    name[0] = 'c';
    122d:	c6 45 cc 63          	movb   $0x63,-0x34(%ebp)
    unlink(name);
    1231:	83 ec 0c             	sub    $0xc,%esp
    1234:	8d 45 cc             	lea    -0x34(%ebp),%eax
    1237:	50                   	push   %eax
    1238:	e8 67 2a 00 00       	call   3ca4 <unlink>
    123d:	83 c4 10             	add    $0x10,%esp
    }
    if(fd >= 0)
      close(fd);
  }

  for(i = 0; i < N; i++){
    1240:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1244:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1248:	7e c7                	jle    1211 <createdelete+0x258>
    unlink(name);
    name[0] = 'c';
    unlink(name);
  }

  printf(1, "createdelete ok\n");
    124a:	83 ec 08             	sub    $0x8,%esp
    124d:	68 60 47 00 00       	push   $0x4760
    1252:	6a 01                	push   $0x1
    1254:	e8 92 2b 00 00       	call   3deb <printf>
    1259:	83 c4 10             	add    $0x10,%esp
}
    125c:	90                   	nop
    125d:	c9                   	leave  
    125e:	c3                   	ret    

0000125f <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    125f:	55                   	push   %ebp
    1260:	89 e5                	mov    %esp,%ebp
    1262:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1265:	83 ec 08             	sub    $0x8,%esp
    1268:	68 71 47 00 00       	push   $0x4771
    126d:	6a 01                	push   $0x1
    126f:	e8 77 2b 00 00       	call   3deb <printf>
    1274:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1277:	83 ec 08             	sub    $0x8,%esp
    127a:	68 02 02 00 00       	push   $0x202
    127f:	68 82 47 00 00       	push   $0x4782
    1284:	e8 0b 2a 00 00       	call   3c94 <open>
    1289:	83 c4 10             	add    $0x10,%esp
    128c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    128f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1293:	79 17                	jns    12ac <unlinkread+0x4d>
    printf(1, "create unlinkread failed\n");
    1295:	83 ec 08             	sub    $0x8,%esp
    1298:	68 8d 47 00 00       	push   $0x478d
    129d:	6a 01                	push   $0x1
    129f:	e8 47 2b 00 00       	call   3deb <printf>
    12a4:	83 c4 10             	add    $0x10,%esp
    exit();
    12a7:	e8 a8 29 00 00       	call   3c54 <exit>
  }
  write(fd, "hello", 5);
    12ac:	83 ec 04             	sub    $0x4,%esp
    12af:	6a 05                	push   $0x5
    12b1:	68 a7 47 00 00       	push   $0x47a7
    12b6:	ff 75 f4             	pushl  -0xc(%ebp)
    12b9:	e8 b6 29 00 00       	call   3c74 <write>
    12be:	83 c4 10             	add    $0x10,%esp
  close(fd);
    12c1:	83 ec 0c             	sub    $0xc,%esp
    12c4:	ff 75 f4             	pushl  -0xc(%ebp)
    12c7:	e8 b0 29 00 00       	call   3c7c <close>
    12cc:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    12cf:	83 ec 08             	sub    $0x8,%esp
    12d2:	6a 02                	push   $0x2
    12d4:	68 82 47 00 00       	push   $0x4782
    12d9:	e8 b6 29 00 00       	call   3c94 <open>
    12de:	83 c4 10             	add    $0x10,%esp
    12e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    12e4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    12e8:	79 17                	jns    1301 <unlinkread+0xa2>
    printf(1, "open unlinkread failed\n");
    12ea:	83 ec 08             	sub    $0x8,%esp
    12ed:	68 ad 47 00 00       	push   $0x47ad
    12f2:	6a 01                	push   $0x1
    12f4:	e8 f2 2a 00 00       	call   3deb <printf>
    12f9:	83 c4 10             	add    $0x10,%esp
    exit();
    12fc:	e8 53 29 00 00       	call   3c54 <exit>
  }
  if(unlink("unlinkread") != 0){
    1301:	83 ec 0c             	sub    $0xc,%esp
    1304:	68 82 47 00 00       	push   $0x4782
    1309:	e8 96 29 00 00       	call   3ca4 <unlink>
    130e:	83 c4 10             	add    $0x10,%esp
    1311:	85 c0                	test   %eax,%eax
    1313:	74 17                	je     132c <unlinkread+0xcd>
    printf(1, "unlink unlinkread failed\n");
    1315:	83 ec 08             	sub    $0x8,%esp
    1318:	68 c5 47 00 00       	push   $0x47c5
    131d:	6a 01                	push   $0x1
    131f:	e8 c7 2a 00 00       	call   3deb <printf>
    1324:	83 c4 10             	add    $0x10,%esp
    exit();
    1327:	e8 28 29 00 00       	call   3c54 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    132c:	83 ec 08             	sub    $0x8,%esp
    132f:	68 02 02 00 00       	push   $0x202
    1334:	68 82 47 00 00       	push   $0x4782
    1339:	e8 56 29 00 00       	call   3c94 <open>
    133e:	83 c4 10             	add    $0x10,%esp
    1341:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    1344:	83 ec 04             	sub    $0x4,%esp
    1347:	6a 03                	push   $0x3
    1349:	68 df 47 00 00       	push   $0x47df
    134e:	ff 75 f0             	pushl  -0x10(%ebp)
    1351:	e8 1e 29 00 00       	call   3c74 <write>
    1356:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1359:	83 ec 0c             	sub    $0xc,%esp
    135c:	ff 75 f0             	pushl  -0x10(%ebp)
    135f:	e8 18 29 00 00       	call   3c7c <close>
    1364:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    1367:	83 ec 04             	sub    $0x4,%esp
    136a:	68 00 20 00 00       	push   $0x2000
    136f:	68 40 87 00 00       	push   $0x8740
    1374:	ff 75 f4             	pushl  -0xc(%ebp)
    1377:	e8 f0 28 00 00       	call   3c6c <read>
    137c:	83 c4 10             	add    $0x10,%esp
    137f:	83 f8 05             	cmp    $0x5,%eax
    1382:	74 17                	je     139b <unlinkread+0x13c>
    printf(1, "unlinkread read failed");
    1384:	83 ec 08             	sub    $0x8,%esp
    1387:	68 e3 47 00 00       	push   $0x47e3
    138c:	6a 01                	push   $0x1
    138e:	e8 58 2a 00 00       	call   3deb <printf>
    1393:	83 c4 10             	add    $0x10,%esp
    exit();
    1396:	e8 b9 28 00 00       	call   3c54 <exit>
  }
  if(buf[0] != 'h'){
    139b:	0f b6 05 40 87 00 00 	movzbl 0x8740,%eax
    13a2:	3c 68                	cmp    $0x68,%al
    13a4:	74 17                	je     13bd <unlinkread+0x15e>
    printf(1, "unlinkread wrong data\n");
    13a6:	83 ec 08             	sub    $0x8,%esp
    13a9:	68 fa 47 00 00       	push   $0x47fa
    13ae:	6a 01                	push   $0x1
    13b0:	e8 36 2a 00 00       	call   3deb <printf>
    13b5:	83 c4 10             	add    $0x10,%esp
    exit();
    13b8:	e8 97 28 00 00       	call   3c54 <exit>
  }
  if(write(fd, buf, 10) != 10){
    13bd:	83 ec 04             	sub    $0x4,%esp
    13c0:	6a 0a                	push   $0xa
    13c2:	68 40 87 00 00       	push   $0x8740
    13c7:	ff 75 f4             	pushl  -0xc(%ebp)
    13ca:	e8 a5 28 00 00       	call   3c74 <write>
    13cf:	83 c4 10             	add    $0x10,%esp
    13d2:	83 f8 0a             	cmp    $0xa,%eax
    13d5:	74 17                	je     13ee <unlinkread+0x18f>
    printf(1, "unlinkread write failed\n");
    13d7:	83 ec 08             	sub    $0x8,%esp
    13da:	68 11 48 00 00       	push   $0x4811
    13df:	6a 01                	push   $0x1
    13e1:	e8 05 2a 00 00       	call   3deb <printf>
    13e6:	83 c4 10             	add    $0x10,%esp
    exit();
    13e9:	e8 66 28 00 00       	call   3c54 <exit>
  }
  close(fd);
    13ee:	83 ec 0c             	sub    $0xc,%esp
    13f1:	ff 75 f4             	pushl  -0xc(%ebp)
    13f4:	e8 83 28 00 00       	call   3c7c <close>
    13f9:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    13fc:	83 ec 0c             	sub    $0xc,%esp
    13ff:	68 82 47 00 00       	push   $0x4782
    1404:	e8 9b 28 00 00       	call   3ca4 <unlink>
    1409:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    140c:	83 ec 08             	sub    $0x8,%esp
    140f:	68 2a 48 00 00       	push   $0x482a
    1414:	6a 01                	push   $0x1
    1416:	e8 d0 29 00 00       	call   3deb <printf>
    141b:	83 c4 10             	add    $0x10,%esp
}
    141e:	90                   	nop
    141f:	c9                   	leave  
    1420:	c3                   	ret    

00001421 <linktest>:

void
linktest(void)
{
    1421:	55                   	push   %ebp
    1422:	89 e5                	mov    %esp,%ebp
    1424:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    1427:	83 ec 08             	sub    $0x8,%esp
    142a:	68 39 48 00 00       	push   $0x4839
    142f:	6a 01                	push   $0x1
    1431:	e8 b5 29 00 00       	call   3deb <printf>
    1436:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    1439:	83 ec 0c             	sub    $0xc,%esp
    143c:	68 43 48 00 00       	push   $0x4843
    1441:	e8 5e 28 00 00       	call   3ca4 <unlink>
    1446:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    1449:	83 ec 0c             	sub    $0xc,%esp
    144c:	68 47 48 00 00       	push   $0x4847
    1451:	e8 4e 28 00 00       	call   3ca4 <unlink>
    1456:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    1459:	83 ec 08             	sub    $0x8,%esp
    145c:	68 02 02 00 00       	push   $0x202
    1461:	68 43 48 00 00       	push   $0x4843
    1466:	e8 29 28 00 00       	call   3c94 <open>
    146b:	83 c4 10             	add    $0x10,%esp
    146e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1471:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1475:	79 17                	jns    148e <linktest+0x6d>
    printf(1, "create lf1 failed\n");
    1477:	83 ec 08             	sub    $0x8,%esp
    147a:	68 4b 48 00 00       	push   $0x484b
    147f:	6a 01                	push   $0x1
    1481:	e8 65 29 00 00       	call   3deb <printf>
    1486:	83 c4 10             	add    $0x10,%esp
    exit();
    1489:	e8 c6 27 00 00       	call   3c54 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    148e:	83 ec 04             	sub    $0x4,%esp
    1491:	6a 05                	push   $0x5
    1493:	68 a7 47 00 00       	push   $0x47a7
    1498:	ff 75 f4             	pushl  -0xc(%ebp)
    149b:	e8 d4 27 00 00       	call   3c74 <write>
    14a0:	83 c4 10             	add    $0x10,%esp
    14a3:	83 f8 05             	cmp    $0x5,%eax
    14a6:	74 17                	je     14bf <linktest+0x9e>
    printf(1, "write lf1 failed\n");
    14a8:	83 ec 08             	sub    $0x8,%esp
    14ab:	68 5e 48 00 00       	push   $0x485e
    14b0:	6a 01                	push   $0x1
    14b2:	e8 34 29 00 00       	call   3deb <printf>
    14b7:	83 c4 10             	add    $0x10,%esp
    exit();
    14ba:	e8 95 27 00 00       	call   3c54 <exit>
  }
  close(fd);
    14bf:	83 ec 0c             	sub    $0xc,%esp
    14c2:	ff 75 f4             	pushl  -0xc(%ebp)
    14c5:	e8 b2 27 00 00       	call   3c7c <close>
    14ca:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    14cd:	83 ec 08             	sub    $0x8,%esp
    14d0:	68 47 48 00 00       	push   $0x4847
    14d5:	68 43 48 00 00       	push   $0x4843
    14da:	e8 d5 27 00 00       	call   3cb4 <link>
    14df:	83 c4 10             	add    $0x10,%esp
    14e2:	85 c0                	test   %eax,%eax
    14e4:	79 17                	jns    14fd <linktest+0xdc>
    printf(1, "link lf1 lf2 failed\n");
    14e6:	83 ec 08             	sub    $0x8,%esp
    14e9:	68 70 48 00 00       	push   $0x4870
    14ee:	6a 01                	push   $0x1
    14f0:	e8 f6 28 00 00       	call   3deb <printf>
    14f5:	83 c4 10             	add    $0x10,%esp
    exit();
    14f8:	e8 57 27 00 00       	call   3c54 <exit>
  }
  unlink("lf1");
    14fd:	83 ec 0c             	sub    $0xc,%esp
    1500:	68 43 48 00 00       	push   $0x4843
    1505:	e8 9a 27 00 00       	call   3ca4 <unlink>
    150a:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    150d:	83 ec 08             	sub    $0x8,%esp
    1510:	6a 00                	push   $0x0
    1512:	68 43 48 00 00       	push   $0x4843
    1517:	e8 78 27 00 00       	call   3c94 <open>
    151c:	83 c4 10             	add    $0x10,%esp
    151f:	85 c0                	test   %eax,%eax
    1521:	78 17                	js     153a <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    1523:	83 ec 08             	sub    $0x8,%esp
    1526:	68 88 48 00 00       	push   $0x4888
    152b:	6a 01                	push   $0x1
    152d:	e8 b9 28 00 00       	call   3deb <printf>
    1532:	83 c4 10             	add    $0x10,%esp
    exit();
    1535:	e8 1a 27 00 00       	call   3c54 <exit>
  }

  fd = open("lf2", 0);
    153a:	83 ec 08             	sub    $0x8,%esp
    153d:	6a 00                	push   $0x0
    153f:	68 47 48 00 00       	push   $0x4847
    1544:	e8 4b 27 00 00       	call   3c94 <open>
    1549:	83 c4 10             	add    $0x10,%esp
    154c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    154f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1553:	79 17                	jns    156c <linktest+0x14b>
    printf(1, "open lf2 failed\n");
    1555:	83 ec 08             	sub    $0x8,%esp
    1558:	68 ad 48 00 00       	push   $0x48ad
    155d:	6a 01                	push   $0x1
    155f:	e8 87 28 00 00       	call   3deb <printf>
    1564:	83 c4 10             	add    $0x10,%esp
    exit();
    1567:	e8 e8 26 00 00       	call   3c54 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    156c:	83 ec 04             	sub    $0x4,%esp
    156f:	68 00 20 00 00       	push   $0x2000
    1574:	68 40 87 00 00       	push   $0x8740
    1579:	ff 75 f4             	pushl  -0xc(%ebp)
    157c:	e8 eb 26 00 00       	call   3c6c <read>
    1581:	83 c4 10             	add    $0x10,%esp
    1584:	83 f8 05             	cmp    $0x5,%eax
    1587:	74 17                	je     15a0 <linktest+0x17f>
    printf(1, "read lf2 failed\n");
    1589:	83 ec 08             	sub    $0x8,%esp
    158c:	68 be 48 00 00       	push   $0x48be
    1591:	6a 01                	push   $0x1
    1593:	e8 53 28 00 00       	call   3deb <printf>
    1598:	83 c4 10             	add    $0x10,%esp
    exit();
    159b:	e8 b4 26 00 00       	call   3c54 <exit>
  }
  close(fd);
    15a0:	83 ec 0c             	sub    $0xc,%esp
    15a3:	ff 75 f4             	pushl  -0xc(%ebp)
    15a6:	e8 d1 26 00 00       	call   3c7c <close>
    15ab:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    15ae:	83 ec 08             	sub    $0x8,%esp
    15b1:	68 47 48 00 00       	push   $0x4847
    15b6:	68 47 48 00 00       	push   $0x4847
    15bb:	e8 f4 26 00 00       	call   3cb4 <link>
    15c0:	83 c4 10             	add    $0x10,%esp
    15c3:	85 c0                	test   %eax,%eax
    15c5:	78 17                	js     15de <linktest+0x1bd>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    15c7:	83 ec 08             	sub    $0x8,%esp
    15ca:	68 cf 48 00 00       	push   $0x48cf
    15cf:	6a 01                	push   $0x1
    15d1:	e8 15 28 00 00       	call   3deb <printf>
    15d6:	83 c4 10             	add    $0x10,%esp
    exit();
    15d9:	e8 76 26 00 00       	call   3c54 <exit>
  }

  unlink("lf2");
    15de:	83 ec 0c             	sub    $0xc,%esp
    15e1:	68 47 48 00 00       	push   $0x4847
    15e6:	e8 b9 26 00 00       	call   3ca4 <unlink>
    15eb:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    15ee:	83 ec 08             	sub    $0x8,%esp
    15f1:	68 43 48 00 00       	push   $0x4843
    15f6:	68 47 48 00 00       	push   $0x4847
    15fb:	e8 b4 26 00 00       	call   3cb4 <link>
    1600:	83 c4 10             	add    $0x10,%esp
    1603:	85 c0                	test   %eax,%eax
    1605:	78 17                	js     161e <linktest+0x1fd>
    printf(1, "link non-existant succeeded! oops\n");
    1607:	83 ec 08             	sub    $0x8,%esp
    160a:	68 f0 48 00 00       	push   $0x48f0
    160f:	6a 01                	push   $0x1
    1611:	e8 d5 27 00 00       	call   3deb <printf>
    1616:	83 c4 10             	add    $0x10,%esp
    exit();
    1619:	e8 36 26 00 00       	call   3c54 <exit>
  }

  if(link(".", "lf1") >= 0){
    161e:	83 ec 08             	sub    $0x8,%esp
    1621:	68 43 48 00 00       	push   $0x4843
    1626:	68 13 49 00 00       	push   $0x4913
    162b:	e8 84 26 00 00       	call   3cb4 <link>
    1630:	83 c4 10             	add    $0x10,%esp
    1633:	85 c0                	test   %eax,%eax
    1635:	78 17                	js     164e <linktest+0x22d>
    printf(1, "link . lf1 succeeded! oops\n");
    1637:	83 ec 08             	sub    $0x8,%esp
    163a:	68 15 49 00 00       	push   $0x4915
    163f:	6a 01                	push   $0x1
    1641:	e8 a5 27 00 00       	call   3deb <printf>
    1646:	83 c4 10             	add    $0x10,%esp
    exit();
    1649:	e8 06 26 00 00       	call   3c54 <exit>
  }

  printf(1, "linktest ok\n");
    164e:	83 ec 08             	sub    $0x8,%esp
    1651:	68 31 49 00 00       	push   $0x4931
    1656:	6a 01                	push   $0x1
    1658:	e8 8e 27 00 00       	call   3deb <printf>
    165d:	83 c4 10             	add    $0x10,%esp
}
    1660:	90                   	nop
    1661:	c9                   	leave  
    1662:	c3                   	ret    

00001663 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1663:	55                   	push   %ebp
    1664:	89 e5                	mov    %esp,%ebp
    1666:	83 ec 58             	sub    $0x58,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1669:	83 ec 08             	sub    $0x8,%esp
    166c:	68 3e 49 00 00       	push   $0x493e
    1671:	6a 01                	push   $0x1
    1673:	e8 73 27 00 00       	call   3deb <printf>
    1678:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    167b:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    167f:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1683:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    168a:	e9 fc 00 00 00       	jmp    178b <concreate+0x128>
    file[1] = '0' + i;
    168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1692:	83 c0 30             	add    $0x30,%eax
    1695:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    1698:	83 ec 0c             	sub    $0xc,%esp
    169b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    169e:	50                   	push   %eax
    169f:	e8 00 26 00 00       	call   3ca4 <unlink>
    16a4:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    16a7:	e8 a0 25 00 00       	call   3c4c <fork>
    16ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid && (i % 3) == 1){
    16af:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16b3:	74 3b                	je     16f0 <concreate+0x8d>
    16b5:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16b8:	ba 56 55 55 55       	mov    $0x55555556,%edx
    16bd:	89 c8                	mov    %ecx,%eax
    16bf:	f7 ea                	imul   %edx
    16c1:	89 c8                	mov    %ecx,%eax
    16c3:	c1 f8 1f             	sar    $0x1f,%eax
    16c6:	29 c2                	sub    %eax,%edx
    16c8:	89 d0                	mov    %edx,%eax
    16ca:	01 c0                	add    %eax,%eax
    16cc:	01 d0                	add    %edx,%eax
    16ce:	29 c1                	sub    %eax,%ecx
    16d0:	89 ca                	mov    %ecx,%edx
    16d2:	83 fa 01             	cmp    $0x1,%edx
    16d5:	75 19                	jne    16f0 <concreate+0x8d>
      link("C0", file);
    16d7:	83 ec 08             	sub    $0x8,%esp
    16da:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16dd:	50                   	push   %eax
    16de:	68 4e 49 00 00       	push   $0x494e
    16e3:	e8 cc 25 00 00       	call   3cb4 <link>
    16e8:	83 c4 10             	add    $0x10,%esp
    16eb:	e9 87 00 00 00       	jmp    1777 <concreate+0x114>
    } else if(pid == 0 && (i % 5) == 1){
    16f0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    16f4:	75 3b                	jne    1731 <concreate+0xce>
    16f6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    16f9:	ba 67 66 66 66       	mov    $0x66666667,%edx
    16fe:	89 c8                	mov    %ecx,%eax
    1700:	f7 ea                	imul   %edx
    1702:	d1 fa                	sar    %edx
    1704:	89 c8                	mov    %ecx,%eax
    1706:	c1 f8 1f             	sar    $0x1f,%eax
    1709:	29 c2                	sub    %eax,%edx
    170b:	89 d0                	mov    %edx,%eax
    170d:	c1 e0 02             	shl    $0x2,%eax
    1710:	01 d0                	add    %edx,%eax
    1712:	29 c1                	sub    %eax,%ecx
    1714:	89 ca                	mov    %ecx,%edx
    1716:	83 fa 01             	cmp    $0x1,%edx
    1719:	75 16                	jne    1731 <concreate+0xce>
      link("C0", file);
    171b:	83 ec 08             	sub    $0x8,%esp
    171e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1721:	50                   	push   %eax
    1722:	68 4e 49 00 00       	push   $0x494e
    1727:	e8 88 25 00 00       	call   3cb4 <link>
    172c:	83 c4 10             	add    $0x10,%esp
    172f:	eb 46                	jmp    1777 <concreate+0x114>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1731:	83 ec 08             	sub    $0x8,%esp
    1734:	68 02 02 00 00       	push   $0x202
    1739:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    173c:	50                   	push   %eax
    173d:	e8 52 25 00 00       	call   3c94 <open>
    1742:	83 c4 10             	add    $0x10,%esp
    1745:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(fd < 0){
    1748:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    174c:	79 1b                	jns    1769 <concreate+0x106>
        printf(1, "concreate create %s failed\n", file);
    174e:	83 ec 04             	sub    $0x4,%esp
    1751:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1754:	50                   	push   %eax
    1755:	68 51 49 00 00       	push   $0x4951
    175a:	6a 01                	push   $0x1
    175c:	e8 8a 26 00 00       	call   3deb <printf>
    1761:	83 c4 10             	add    $0x10,%esp
        exit();
    1764:	e8 eb 24 00 00       	call   3c54 <exit>
      }
      close(fd);
    1769:	83 ec 0c             	sub    $0xc,%esp
    176c:	ff 75 e8             	pushl  -0x18(%ebp)
    176f:	e8 08 25 00 00       	call   3c7c <close>
    1774:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1777:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    177b:	75 05                	jne    1782 <concreate+0x11f>
      exit();
    177d:	e8 d2 24 00 00       	call   3c54 <exit>
    else
      wait();
    1782:	e8 d5 24 00 00       	call   3c5c <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    1787:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    178b:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    178f:	0f 8e fa fe ff ff    	jle    168f <concreate+0x2c>
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    1795:	83 ec 04             	sub    $0x4,%esp
    1798:	6a 28                	push   $0x28
    179a:	6a 00                	push   $0x0
    179c:	8d 45 bd             	lea    -0x43(%ebp),%eax
    179f:	50                   	push   %eax
    17a0:	e8 c3 22 00 00       	call   3a68 <memset>
    17a5:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    17a8:	83 ec 08             	sub    $0x8,%esp
    17ab:	6a 00                	push   $0x0
    17ad:	68 13 49 00 00       	push   $0x4913
    17b2:	e8 dd 24 00 00       	call   3c94 <open>
    17b7:	83 c4 10             	add    $0x10,%esp
    17ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
  n = 0;
    17bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    17c4:	e9 93 00 00 00       	jmp    185c <concreate+0x1f9>
    if(de.inum == 0)
    17c9:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    17cd:	66 85 c0             	test   %ax,%ax
    17d0:	75 05                	jne    17d7 <concreate+0x174>
      continue;
    17d2:	e9 85 00 00 00       	jmp    185c <concreate+0x1f9>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    17d7:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    17db:	3c 43                	cmp    $0x43,%al
    17dd:	75 7d                	jne    185c <concreate+0x1f9>
    17df:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    17e3:	84 c0                	test   %al,%al
    17e5:	75 75                	jne    185c <concreate+0x1f9>
      i = de.name[1] - '0';
    17e7:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    17eb:	0f be c0             	movsbl %al,%eax
    17ee:	83 e8 30             	sub    $0x30,%eax
    17f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    17f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    17f8:	78 08                	js     1802 <concreate+0x19f>
    17fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
    17fd:	83 f8 27             	cmp    $0x27,%eax
    1800:	76 1e                	jbe    1820 <concreate+0x1bd>
        printf(1, "concreate weird file %s\n", de.name);
    1802:	83 ec 04             	sub    $0x4,%esp
    1805:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1808:	83 c0 02             	add    $0x2,%eax
    180b:	50                   	push   %eax
    180c:	68 6d 49 00 00       	push   $0x496d
    1811:	6a 01                	push   $0x1
    1813:	e8 d3 25 00 00       	call   3deb <printf>
    1818:	83 c4 10             	add    $0x10,%esp
        exit();
    181b:	e8 34 24 00 00       	call   3c54 <exit>
      }
      if(fa[i]){
    1820:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1823:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1826:	01 d0                	add    %edx,%eax
    1828:	0f b6 00             	movzbl (%eax),%eax
    182b:	84 c0                	test   %al,%al
    182d:	74 1e                	je     184d <concreate+0x1ea>
        printf(1, "concreate duplicate file %s\n", de.name);
    182f:	83 ec 04             	sub    $0x4,%esp
    1832:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1835:	83 c0 02             	add    $0x2,%eax
    1838:	50                   	push   %eax
    1839:	68 86 49 00 00       	push   $0x4986
    183e:	6a 01                	push   $0x1
    1840:	e8 a6 25 00 00       	call   3deb <printf>
    1845:	83 c4 10             	add    $0x10,%esp
        exit();
    1848:	e8 07 24 00 00       	call   3c54 <exit>
      }
      fa[i] = 1;
    184d:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1850:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1853:	01 d0                	add    %edx,%eax
    1855:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1858:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  }

  memset(fa, 0, sizeof(fa));
  fd = open(".", 0);
  n = 0;
  while(read(fd, &de, sizeof(de)) > 0){
    185c:	83 ec 04             	sub    $0x4,%esp
    185f:	6a 10                	push   $0x10
    1861:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1864:	50                   	push   %eax
    1865:	ff 75 e8             	pushl  -0x18(%ebp)
    1868:	e8 ff 23 00 00       	call   3c6c <read>
    186d:	83 c4 10             	add    $0x10,%esp
    1870:	85 c0                	test   %eax,%eax
    1872:	0f 8f 51 ff ff ff    	jg     17c9 <concreate+0x166>
      }
      fa[i] = 1;
      n++;
    }
  }
  close(fd);
    1878:	83 ec 0c             	sub    $0xc,%esp
    187b:	ff 75 e8             	pushl  -0x18(%ebp)
    187e:	e8 f9 23 00 00       	call   3c7c <close>
    1883:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1886:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    188a:	74 17                	je     18a3 <concreate+0x240>
    printf(1, "concreate not enough files in directory listing\n");
    188c:	83 ec 08             	sub    $0x8,%esp
    188f:	68 a4 49 00 00       	push   $0x49a4
    1894:	6a 01                	push   $0x1
    1896:	e8 50 25 00 00       	call   3deb <printf>
    189b:	83 c4 10             	add    $0x10,%esp
    exit();
    189e:	e8 b1 23 00 00       	call   3c54 <exit>
  }

  for(i = 0; i < 40; i++){
    18a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    18aa:	e9 45 01 00 00       	jmp    19f4 <concreate+0x391>
    file[1] = '0' + i;
    18af:	8b 45 f4             	mov    -0xc(%ebp),%eax
    18b2:	83 c0 30             	add    $0x30,%eax
    18b5:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    18b8:	e8 8f 23 00 00       	call   3c4c <fork>
    18bd:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(pid < 0){
    18c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    18c4:	79 17                	jns    18dd <concreate+0x27a>
      printf(1, "fork failed\n");
    18c6:	83 ec 08             	sub    $0x8,%esp
    18c9:	68 91 45 00 00       	push   $0x4591
    18ce:	6a 01                	push   $0x1
    18d0:	e8 16 25 00 00       	call   3deb <printf>
    18d5:	83 c4 10             	add    $0x10,%esp
      exit();
    18d8:	e8 77 23 00 00       	call   3c54 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    18dd:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    18e0:	ba 56 55 55 55       	mov    $0x55555556,%edx
    18e5:	89 c8                	mov    %ecx,%eax
    18e7:	f7 ea                	imul   %edx
    18e9:	89 c8                	mov    %ecx,%eax
    18eb:	c1 f8 1f             	sar    $0x1f,%eax
    18ee:	29 c2                	sub    %eax,%edx
    18f0:	89 d0                	mov    %edx,%eax
    18f2:	89 c2                	mov    %eax,%edx
    18f4:	01 d2                	add    %edx,%edx
    18f6:	01 c2                	add    %eax,%edx
    18f8:	89 c8                	mov    %ecx,%eax
    18fa:	29 d0                	sub    %edx,%eax
    18fc:	85 c0                	test   %eax,%eax
    18fe:	75 06                	jne    1906 <concreate+0x2a3>
    1900:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1904:	74 28                	je     192e <concreate+0x2cb>
       ((i % 3) == 1 && pid != 0)){
    1906:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1909:	ba 56 55 55 55       	mov    $0x55555556,%edx
    190e:	89 c8                	mov    %ecx,%eax
    1910:	f7 ea                	imul   %edx
    1912:	89 c8                	mov    %ecx,%eax
    1914:	c1 f8 1f             	sar    $0x1f,%eax
    1917:	29 c2                	sub    %eax,%edx
    1919:	89 d0                	mov    %edx,%eax
    191b:	01 c0                	add    %eax,%eax
    191d:	01 d0                	add    %edx,%eax
    191f:	29 c1                	sub    %eax,%ecx
    1921:	89 ca                	mov    %ecx,%edx
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1923:	83 fa 01             	cmp    $0x1,%edx
    1926:	75 7c                	jne    19a4 <concreate+0x341>
       ((i % 3) == 1 && pid != 0)){
    1928:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    192c:	74 76                	je     19a4 <concreate+0x341>
      close(open(file, 0));
    192e:	83 ec 08             	sub    $0x8,%esp
    1931:	6a 00                	push   $0x0
    1933:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1936:	50                   	push   %eax
    1937:	e8 58 23 00 00       	call   3c94 <open>
    193c:	83 c4 10             	add    $0x10,%esp
    193f:	83 ec 0c             	sub    $0xc,%esp
    1942:	50                   	push   %eax
    1943:	e8 34 23 00 00       	call   3c7c <close>
    1948:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    194b:	83 ec 08             	sub    $0x8,%esp
    194e:	6a 00                	push   $0x0
    1950:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1953:	50                   	push   %eax
    1954:	e8 3b 23 00 00       	call   3c94 <open>
    1959:	83 c4 10             	add    $0x10,%esp
    195c:	83 ec 0c             	sub    $0xc,%esp
    195f:	50                   	push   %eax
    1960:	e8 17 23 00 00       	call   3c7c <close>
    1965:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1968:	83 ec 08             	sub    $0x8,%esp
    196b:	6a 00                	push   $0x0
    196d:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1970:	50                   	push   %eax
    1971:	e8 1e 23 00 00       	call   3c94 <open>
    1976:	83 c4 10             	add    $0x10,%esp
    1979:	83 ec 0c             	sub    $0xc,%esp
    197c:	50                   	push   %eax
    197d:	e8 fa 22 00 00       	call   3c7c <close>
    1982:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1985:	83 ec 08             	sub    $0x8,%esp
    1988:	6a 00                	push   $0x0
    198a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    198d:	50                   	push   %eax
    198e:	e8 01 23 00 00       	call   3c94 <open>
    1993:	83 c4 10             	add    $0x10,%esp
    1996:	83 ec 0c             	sub    $0xc,%esp
    1999:	50                   	push   %eax
    199a:	e8 dd 22 00 00       	call   3c7c <close>
    199f:	83 c4 10             	add    $0x10,%esp
    19a2:	eb 3c                	jmp    19e0 <concreate+0x37d>
    } else {
      unlink(file);
    19a4:	83 ec 0c             	sub    $0xc,%esp
    19a7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19aa:	50                   	push   %eax
    19ab:	e8 f4 22 00 00       	call   3ca4 <unlink>
    19b0:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19b3:	83 ec 0c             	sub    $0xc,%esp
    19b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19b9:	50                   	push   %eax
    19ba:	e8 e5 22 00 00       	call   3ca4 <unlink>
    19bf:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19c2:	83 ec 0c             	sub    $0xc,%esp
    19c5:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19c8:	50                   	push   %eax
    19c9:	e8 d6 22 00 00       	call   3ca4 <unlink>
    19ce:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    19d1:	83 ec 0c             	sub    $0xc,%esp
    19d4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19d7:	50                   	push   %eax
    19d8:	e8 c7 22 00 00       	call   3ca4 <unlink>
    19dd:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    19e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    19e4:	75 05                	jne    19eb <concreate+0x388>
      exit();
    19e6:	e8 69 22 00 00       	call   3c54 <exit>
    else
      wait();
    19eb:	e8 6c 22 00 00       	call   3c5c <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    19f0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    19f4:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    19f8:	0f 8e b1 fe ff ff    	jle    18af <concreate+0x24c>
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    19fe:	83 ec 08             	sub    $0x8,%esp
    1a01:	68 d5 49 00 00       	push   $0x49d5
    1a06:	6a 01                	push   $0x1
    1a08:	e8 de 23 00 00       	call   3deb <printf>
    1a0d:	83 c4 10             	add    $0x10,%esp
}
    1a10:	90                   	nop
    1a11:	c9                   	leave  
    1a12:	c3                   	ret    

00001a13 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1a13:	55                   	push   %ebp
    1a14:	89 e5                	mov    %esp,%ebp
    1a16:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1a19:	83 ec 08             	sub    $0x8,%esp
    1a1c:	68 e3 49 00 00       	push   $0x49e3
    1a21:	6a 01                	push   $0x1
    1a23:	e8 c3 23 00 00       	call   3deb <printf>
    1a28:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1a2b:	83 ec 0c             	sub    $0xc,%esp
    1a2e:	68 4a 45 00 00       	push   $0x454a
    1a33:	e8 6c 22 00 00       	call   3ca4 <unlink>
    1a38:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1a3b:	e8 0c 22 00 00       	call   3c4c <fork>
    1a40:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1a43:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a47:	79 17                	jns    1a60 <linkunlink+0x4d>
    printf(1, "fork failed\n");
    1a49:	83 ec 08             	sub    $0x8,%esp
    1a4c:	68 91 45 00 00       	push   $0x4591
    1a51:	6a 01                	push   $0x1
    1a53:	e8 93 23 00 00       	call   3deb <printf>
    1a58:	83 c4 10             	add    $0x10,%esp
    exit();
    1a5b:	e8 f4 21 00 00       	call   3c54 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1a60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a64:	74 07                	je     1a6d <linkunlink+0x5a>
    1a66:	b8 01 00 00 00       	mov    $0x1,%eax
    1a6b:	eb 05                	jmp    1a72 <linkunlink+0x5f>
    1a6d:	b8 61 00 00 00       	mov    $0x61,%eax
    1a72:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1a75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1a7c:	e9 9a 00 00 00       	jmp    1b1b <linkunlink+0x108>
    x = x * 1103515245 + 12345;
    1a81:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1a84:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1a8a:	05 39 30 00 00       	add    $0x3039,%eax
    1a8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1a92:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1a95:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1a9a:	89 c8                	mov    %ecx,%eax
    1a9c:	f7 e2                	mul    %edx
    1a9e:	89 d0                	mov    %edx,%eax
    1aa0:	d1 e8                	shr    %eax
    1aa2:	89 c2                	mov    %eax,%edx
    1aa4:	01 d2                	add    %edx,%edx
    1aa6:	01 c2                	add    %eax,%edx
    1aa8:	89 c8                	mov    %ecx,%eax
    1aaa:	29 d0                	sub    %edx,%eax
    1aac:	85 c0                	test   %eax,%eax
    1aae:	75 23                	jne    1ad3 <linkunlink+0xc0>
      close(open("x", O_RDWR | O_CREATE));
    1ab0:	83 ec 08             	sub    $0x8,%esp
    1ab3:	68 02 02 00 00       	push   $0x202
    1ab8:	68 4a 45 00 00       	push   $0x454a
    1abd:	e8 d2 21 00 00       	call   3c94 <open>
    1ac2:	83 c4 10             	add    $0x10,%esp
    1ac5:	83 ec 0c             	sub    $0xc,%esp
    1ac8:	50                   	push   %eax
    1ac9:	e8 ae 21 00 00       	call   3c7c <close>
    1ace:	83 c4 10             	add    $0x10,%esp
    1ad1:	eb 44                	jmp    1b17 <linkunlink+0x104>
    } else if((x % 3) == 1){
    1ad3:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1ad6:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1adb:	89 c8                	mov    %ecx,%eax
    1add:	f7 e2                	mul    %edx
    1adf:	d1 ea                	shr    %edx
    1ae1:	89 d0                	mov    %edx,%eax
    1ae3:	01 c0                	add    %eax,%eax
    1ae5:	01 d0                	add    %edx,%eax
    1ae7:	29 c1                	sub    %eax,%ecx
    1ae9:	89 ca                	mov    %ecx,%edx
    1aeb:	83 fa 01             	cmp    $0x1,%edx
    1aee:	75 17                	jne    1b07 <linkunlink+0xf4>
      link("cat", "x");
    1af0:	83 ec 08             	sub    $0x8,%esp
    1af3:	68 4a 45 00 00       	push   $0x454a
    1af8:	68 f4 49 00 00       	push   $0x49f4
    1afd:	e8 b2 21 00 00       	call   3cb4 <link>
    1b02:	83 c4 10             	add    $0x10,%esp
    1b05:	eb 10                	jmp    1b17 <linkunlink+0x104>
    } else {
      unlink("x");
    1b07:	83 ec 0c             	sub    $0xc,%esp
    1b0a:	68 4a 45 00 00       	push   $0x454a
    1b0f:	e8 90 21 00 00       	call   3ca4 <unlink>
    1b14:	83 c4 10             	add    $0x10,%esp
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1b17:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1b1b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1b1f:	0f 8e 5c ff ff ff    	jle    1a81 <linkunlink+0x6e>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1b25:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1b29:	74 07                	je     1b32 <linkunlink+0x11f>
    wait();
    1b2b:	e8 2c 21 00 00       	call   3c5c <wait>
    1b30:	eb 05                	jmp    1b37 <linkunlink+0x124>
  else 
    exit();
    1b32:	e8 1d 21 00 00       	call   3c54 <exit>

  printf(1, "linkunlink ok\n");
    1b37:	83 ec 08             	sub    $0x8,%esp
    1b3a:	68 f8 49 00 00       	push   $0x49f8
    1b3f:	6a 01                	push   $0x1
    1b41:	e8 a5 22 00 00       	call   3deb <printf>
    1b46:	83 c4 10             	add    $0x10,%esp
}
    1b49:	90                   	nop
    1b4a:	c9                   	leave  
    1b4b:	c3                   	ret    

00001b4c <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1b4c:	55                   	push   %ebp
    1b4d:	89 e5                	mov    %esp,%ebp
    1b4f:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1b52:	83 ec 08             	sub    $0x8,%esp
    1b55:	68 07 4a 00 00       	push   $0x4a07
    1b5a:	6a 01                	push   $0x1
    1b5c:	e8 8a 22 00 00       	call   3deb <printf>
    1b61:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1b64:	83 ec 0c             	sub    $0xc,%esp
    1b67:	68 14 4a 00 00       	push   $0x4a14
    1b6c:	e8 33 21 00 00       	call   3ca4 <unlink>
    1b71:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1b74:	83 ec 08             	sub    $0x8,%esp
    1b77:	68 00 02 00 00       	push   $0x200
    1b7c:	68 14 4a 00 00       	push   $0x4a14
    1b81:	e8 0e 21 00 00       	call   3c94 <open>
    1b86:	83 c4 10             	add    $0x10,%esp
    1b89:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1b8c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1b90:	79 17                	jns    1ba9 <bigdir+0x5d>
    printf(1, "bigdir create failed\n");
    1b92:	83 ec 08             	sub    $0x8,%esp
    1b95:	68 17 4a 00 00       	push   $0x4a17
    1b9a:	6a 01                	push   $0x1
    1b9c:	e8 4a 22 00 00       	call   3deb <printf>
    1ba1:	83 c4 10             	add    $0x10,%esp
    exit();
    1ba4:	e8 ab 20 00 00       	call   3c54 <exit>
  }
  close(fd);
    1ba9:	83 ec 0c             	sub    $0xc,%esp
    1bac:	ff 75 f0             	pushl  -0x10(%ebp)
    1baf:	e8 c8 20 00 00       	call   3c7c <close>
    1bb4:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1bb7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1bbe:	eb 63                	jmp    1c23 <bigdir+0xd7>
    name[0] = 'x';
    1bc0:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1bc4:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bc7:	8d 50 3f             	lea    0x3f(%eax),%edx
    1bca:	85 c0                	test   %eax,%eax
    1bcc:	0f 48 c2             	cmovs  %edx,%eax
    1bcf:	c1 f8 06             	sar    $0x6,%eax
    1bd2:	83 c0 30             	add    $0x30,%eax
    1bd5:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1bd8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1bdb:	99                   	cltd   
    1bdc:	c1 ea 1a             	shr    $0x1a,%edx
    1bdf:	01 d0                	add    %edx,%eax
    1be1:	83 e0 3f             	and    $0x3f,%eax
    1be4:	29 d0                	sub    %edx,%eax
    1be6:	83 c0 30             	add    $0x30,%eax
    1be9:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1bec:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1bf0:	83 ec 08             	sub    $0x8,%esp
    1bf3:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1bf6:	50                   	push   %eax
    1bf7:	68 14 4a 00 00       	push   $0x4a14
    1bfc:	e8 b3 20 00 00       	call   3cb4 <link>
    1c01:	83 c4 10             	add    $0x10,%esp
    1c04:	85 c0                	test   %eax,%eax
    1c06:	74 17                	je     1c1f <bigdir+0xd3>
      printf(1, "bigdir link failed\n");
    1c08:	83 ec 08             	sub    $0x8,%esp
    1c0b:	68 2d 4a 00 00       	push   $0x4a2d
    1c10:	6a 01                	push   $0x1
    1c12:	e8 d4 21 00 00       	call   3deb <printf>
    1c17:	83 c4 10             	add    $0x10,%esp
      exit();
    1c1a:	e8 35 20 00 00       	call   3c54 <exit>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1c1f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1c23:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1c2a:	7e 94                	jle    1bc0 <bigdir+0x74>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1c2c:	83 ec 0c             	sub    $0xc,%esp
    1c2f:	68 14 4a 00 00       	push   $0x4a14
    1c34:	e8 6b 20 00 00       	call   3ca4 <unlink>
    1c39:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1c3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1c43:	eb 5e                	jmp    1ca3 <bigdir+0x157>
    name[0] = 'x';
    1c45:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1c49:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c4c:	8d 50 3f             	lea    0x3f(%eax),%edx
    1c4f:	85 c0                	test   %eax,%eax
    1c51:	0f 48 c2             	cmovs  %edx,%eax
    1c54:	c1 f8 06             	sar    $0x6,%eax
    1c57:	83 c0 30             	add    $0x30,%eax
    1c5a:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1c60:	99                   	cltd   
    1c61:	c1 ea 1a             	shr    $0x1a,%edx
    1c64:	01 d0                	add    %edx,%eax
    1c66:	83 e0 3f             	and    $0x3f,%eax
    1c69:	29 d0                	sub    %edx,%eax
    1c6b:	83 c0 30             	add    $0x30,%eax
    1c6e:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1c71:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1c75:	83 ec 0c             	sub    $0xc,%esp
    1c78:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1c7b:	50                   	push   %eax
    1c7c:	e8 23 20 00 00       	call   3ca4 <unlink>
    1c81:	83 c4 10             	add    $0x10,%esp
    1c84:	85 c0                	test   %eax,%eax
    1c86:	74 17                	je     1c9f <bigdir+0x153>
      printf(1, "bigdir unlink failed");
    1c88:	83 ec 08             	sub    $0x8,%esp
    1c8b:	68 41 4a 00 00       	push   $0x4a41
    1c90:	6a 01                	push   $0x1
    1c92:	e8 54 21 00 00       	call   3deb <printf>
    1c97:	83 c4 10             	add    $0x10,%esp
      exit();
    1c9a:	e8 b5 1f 00 00       	call   3c54 <exit>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1c9f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1ca3:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1caa:	7e 99                	jle    1c45 <bigdir+0xf9>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1cac:	83 ec 08             	sub    $0x8,%esp
    1caf:	68 56 4a 00 00       	push   $0x4a56
    1cb4:	6a 01                	push   $0x1
    1cb6:	e8 30 21 00 00       	call   3deb <printf>
    1cbb:	83 c4 10             	add    $0x10,%esp
}
    1cbe:	90                   	nop
    1cbf:	c9                   	leave  
    1cc0:	c3                   	ret    

00001cc1 <subdir>:

void
subdir(void)
{
    1cc1:	55                   	push   %ebp
    1cc2:	89 e5                	mov    %esp,%ebp
    1cc4:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1cc7:	83 ec 08             	sub    $0x8,%esp
    1cca:	68 61 4a 00 00       	push   $0x4a61
    1ccf:	6a 01                	push   $0x1
    1cd1:	e8 15 21 00 00       	call   3deb <printf>
    1cd6:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    1cd9:	83 ec 0c             	sub    $0xc,%esp
    1cdc:	68 6e 4a 00 00       	push   $0x4a6e
    1ce1:	e8 be 1f 00 00       	call   3ca4 <unlink>
    1ce6:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    1ce9:	83 ec 0c             	sub    $0xc,%esp
    1cec:	68 71 4a 00 00       	push   $0x4a71
    1cf1:	e8 c6 1f 00 00       	call   3cbc <mkdir>
    1cf6:	83 c4 10             	add    $0x10,%esp
    1cf9:	85 c0                	test   %eax,%eax
    1cfb:	74 17                	je     1d14 <subdir+0x53>
    printf(1, "subdir mkdir dd failed\n");
    1cfd:	83 ec 08             	sub    $0x8,%esp
    1d00:	68 74 4a 00 00       	push   $0x4a74
    1d05:	6a 01                	push   $0x1
    1d07:	e8 df 20 00 00       	call   3deb <printf>
    1d0c:	83 c4 10             	add    $0x10,%esp
    exit();
    1d0f:	e8 40 1f 00 00       	call   3c54 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1d14:	83 ec 08             	sub    $0x8,%esp
    1d17:	68 02 02 00 00       	push   $0x202
    1d1c:	68 8c 4a 00 00       	push   $0x4a8c
    1d21:	e8 6e 1f 00 00       	call   3c94 <open>
    1d26:	83 c4 10             	add    $0x10,%esp
    1d29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1d2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1d30:	79 17                	jns    1d49 <subdir+0x88>
    printf(1, "create dd/ff failed\n");
    1d32:	83 ec 08             	sub    $0x8,%esp
    1d35:	68 92 4a 00 00       	push   $0x4a92
    1d3a:	6a 01                	push   $0x1
    1d3c:	e8 aa 20 00 00       	call   3deb <printf>
    1d41:	83 c4 10             	add    $0x10,%esp
    exit();
    1d44:	e8 0b 1f 00 00       	call   3c54 <exit>
  }
  write(fd, "ff", 2);
    1d49:	83 ec 04             	sub    $0x4,%esp
    1d4c:	6a 02                	push   $0x2
    1d4e:	68 6e 4a 00 00       	push   $0x4a6e
    1d53:	ff 75 f4             	pushl  -0xc(%ebp)
    1d56:	e8 19 1f 00 00       	call   3c74 <write>
    1d5b:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1d5e:	83 ec 0c             	sub    $0xc,%esp
    1d61:	ff 75 f4             	pushl  -0xc(%ebp)
    1d64:	e8 13 1f 00 00       	call   3c7c <close>
    1d69:	83 c4 10             	add    $0x10,%esp
  
  if(unlink("dd") >= 0){
    1d6c:	83 ec 0c             	sub    $0xc,%esp
    1d6f:	68 71 4a 00 00       	push   $0x4a71
    1d74:	e8 2b 1f 00 00       	call   3ca4 <unlink>
    1d79:	83 c4 10             	add    $0x10,%esp
    1d7c:	85 c0                	test   %eax,%eax
    1d7e:	78 17                	js     1d97 <subdir+0xd6>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    1d80:	83 ec 08             	sub    $0x8,%esp
    1d83:	68 a8 4a 00 00       	push   $0x4aa8
    1d88:	6a 01                	push   $0x1
    1d8a:	e8 5c 20 00 00       	call   3deb <printf>
    1d8f:	83 c4 10             	add    $0x10,%esp
    exit();
    1d92:	e8 bd 1e 00 00       	call   3c54 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    1d97:	83 ec 0c             	sub    $0xc,%esp
    1d9a:	68 ce 4a 00 00       	push   $0x4ace
    1d9f:	e8 18 1f 00 00       	call   3cbc <mkdir>
    1da4:	83 c4 10             	add    $0x10,%esp
    1da7:	85 c0                	test   %eax,%eax
    1da9:	74 17                	je     1dc2 <subdir+0x101>
    printf(1, "subdir mkdir dd/dd failed\n");
    1dab:	83 ec 08             	sub    $0x8,%esp
    1dae:	68 d5 4a 00 00       	push   $0x4ad5
    1db3:	6a 01                	push   $0x1
    1db5:	e8 31 20 00 00       	call   3deb <printf>
    1dba:	83 c4 10             	add    $0x10,%esp
    exit();
    1dbd:	e8 92 1e 00 00       	call   3c54 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1dc2:	83 ec 08             	sub    $0x8,%esp
    1dc5:	68 02 02 00 00       	push   $0x202
    1dca:	68 f0 4a 00 00       	push   $0x4af0
    1dcf:	e8 c0 1e 00 00       	call   3c94 <open>
    1dd4:	83 c4 10             	add    $0x10,%esp
    1dd7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1dda:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1dde:	79 17                	jns    1df7 <subdir+0x136>
    printf(1, "create dd/dd/ff failed\n");
    1de0:	83 ec 08             	sub    $0x8,%esp
    1de3:	68 f9 4a 00 00       	push   $0x4af9
    1de8:	6a 01                	push   $0x1
    1dea:	e8 fc 1f 00 00       	call   3deb <printf>
    1def:	83 c4 10             	add    $0x10,%esp
    exit();
    1df2:	e8 5d 1e 00 00       	call   3c54 <exit>
  }
  write(fd, "FF", 2);
    1df7:	83 ec 04             	sub    $0x4,%esp
    1dfa:	6a 02                	push   $0x2
    1dfc:	68 11 4b 00 00       	push   $0x4b11
    1e01:	ff 75 f4             	pushl  -0xc(%ebp)
    1e04:	e8 6b 1e 00 00       	call   3c74 <write>
    1e09:	83 c4 10             	add    $0x10,%esp
  close(fd);
    1e0c:	83 ec 0c             	sub    $0xc,%esp
    1e0f:	ff 75 f4             	pushl  -0xc(%ebp)
    1e12:	e8 65 1e 00 00       	call   3c7c <close>
    1e17:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    1e1a:	83 ec 08             	sub    $0x8,%esp
    1e1d:	6a 00                	push   $0x0
    1e1f:	68 14 4b 00 00       	push   $0x4b14
    1e24:	e8 6b 1e 00 00       	call   3c94 <open>
    1e29:	83 c4 10             	add    $0x10,%esp
    1e2c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1e2f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1e33:	79 17                	jns    1e4c <subdir+0x18b>
    printf(1, "open dd/dd/../ff failed\n");
    1e35:	83 ec 08             	sub    $0x8,%esp
    1e38:	68 20 4b 00 00       	push   $0x4b20
    1e3d:	6a 01                	push   $0x1
    1e3f:	e8 a7 1f 00 00       	call   3deb <printf>
    1e44:	83 c4 10             	add    $0x10,%esp
    exit();
    1e47:	e8 08 1e 00 00       	call   3c54 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    1e4c:	83 ec 04             	sub    $0x4,%esp
    1e4f:	68 00 20 00 00       	push   $0x2000
    1e54:	68 40 87 00 00       	push   $0x8740
    1e59:	ff 75 f4             	pushl  -0xc(%ebp)
    1e5c:	e8 0b 1e 00 00       	call   3c6c <read>
    1e61:	83 c4 10             	add    $0x10,%esp
    1e64:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    1e67:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    1e6b:	75 0b                	jne    1e78 <subdir+0x1b7>
    1e6d:	0f b6 05 40 87 00 00 	movzbl 0x8740,%eax
    1e74:	3c 66                	cmp    $0x66,%al
    1e76:	74 17                	je     1e8f <subdir+0x1ce>
    printf(1, "dd/dd/../ff wrong content\n");
    1e78:	83 ec 08             	sub    $0x8,%esp
    1e7b:	68 39 4b 00 00       	push   $0x4b39
    1e80:	6a 01                	push   $0x1
    1e82:	e8 64 1f 00 00       	call   3deb <printf>
    1e87:	83 c4 10             	add    $0x10,%esp
    exit();
    1e8a:	e8 c5 1d 00 00       	call   3c54 <exit>
  }
  close(fd);
    1e8f:	83 ec 0c             	sub    $0xc,%esp
    1e92:	ff 75 f4             	pushl  -0xc(%ebp)
    1e95:	e8 e2 1d 00 00       	call   3c7c <close>
    1e9a:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e9d:	83 ec 08             	sub    $0x8,%esp
    1ea0:	68 54 4b 00 00       	push   $0x4b54
    1ea5:	68 f0 4a 00 00       	push   $0x4af0
    1eaa:	e8 05 1e 00 00       	call   3cb4 <link>
    1eaf:	83 c4 10             	add    $0x10,%esp
    1eb2:	85 c0                	test   %eax,%eax
    1eb4:	74 17                	je     1ecd <subdir+0x20c>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    1eb6:	83 ec 08             	sub    $0x8,%esp
    1eb9:	68 60 4b 00 00       	push   $0x4b60
    1ebe:	6a 01                	push   $0x1
    1ec0:	e8 26 1f 00 00       	call   3deb <printf>
    1ec5:	83 c4 10             	add    $0x10,%esp
    exit();
    1ec8:	e8 87 1d 00 00       	call   3c54 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    1ecd:	83 ec 0c             	sub    $0xc,%esp
    1ed0:	68 f0 4a 00 00       	push   $0x4af0
    1ed5:	e8 ca 1d 00 00       	call   3ca4 <unlink>
    1eda:	83 c4 10             	add    $0x10,%esp
    1edd:	85 c0                	test   %eax,%eax
    1edf:	74 17                	je     1ef8 <subdir+0x237>
    printf(1, "unlink dd/dd/ff failed\n");
    1ee1:	83 ec 08             	sub    $0x8,%esp
    1ee4:	68 81 4b 00 00       	push   $0x4b81
    1ee9:	6a 01                	push   $0x1
    1eeb:	e8 fb 1e 00 00       	call   3deb <printf>
    1ef0:	83 c4 10             	add    $0x10,%esp
    exit();
    1ef3:	e8 5c 1d 00 00       	call   3c54 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ef8:	83 ec 08             	sub    $0x8,%esp
    1efb:	6a 00                	push   $0x0
    1efd:	68 f0 4a 00 00       	push   $0x4af0
    1f02:	e8 8d 1d 00 00       	call   3c94 <open>
    1f07:	83 c4 10             	add    $0x10,%esp
    1f0a:	85 c0                	test   %eax,%eax
    1f0c:	78 17                	js     1f25 <subdir+0x264>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    1f0e:	83 ec 08             	sub    $0x8,%esp
    1f11:	68 9c 4b 00 00       	push   $0x4b9c
    1f16:	6a 01                	push   $0x1
    1f18:	e8 ce 1e 00 00       	call   3deb <printf>
    1f1d:	83 c4 10             	add    $0x10,%esp
    exit();
    1f20:	e8 2f 1d 00 00       	call   3c54 <exit>
  }

  if(chdir("dd") != 0){
    1f25:	83 ec 0c             	sub    $0xc,%esp
    1f28:	68 71 4a 00 00       	push   $0x4a71
    1f2d:	e8 92 1d 00 00       	call   3cc4 <chdir>
    1f32:	83 c4 10             	add    $0x10,%esp
    1f35:	85 c0                	test   %eax,%eax
    1f37:	74 17                	je     1f50 <subdir+0x28f>
    printf(1, "chdir dd failed\n");
    1f39:	83 ec 08             	sub    $0x8,%esp
    1f3c:	68 c0 4b 00 00       	push   $0x4bc0
    1f41:	6a 01                	push   $0x1
    1f43:	e8 a3 1e 00 00       	call   3deb <printf>
    1f48:	83 c4 10             	add    $0x10,%esp
    exit();
    1f4b:	e8 04 1d 00 00       	call   3c54 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    1f50:	83 ec 0c             	sub    $0xc,%esp
    1f53:	68 d1 4b 00 00       	push   $0x4bd1
    1f58:	e8 67 1d 00 00       	call   3cc4 <chdir>
    1f5d:	83 c4 10             	add    $0x10,%esp
    1f60:	85 c0                	test   %eax,%eax
    1f62:	74 17                	je     1f7b <subdir+0x2ba>
    printf(1, "chdir dd/../../dd failed\n");
    1f64:	83 ec 08             	sub    $0x8,%esp
    1f67:	68 dd 4b 00 00       	push   $0x4bdd
    1f6c:	6a 01                	push   $0x1
    1f6e:	e8 78 1e 00 00       	call   3deb <printf>
    1f73:	83 c4 10             	add    $0x10,%esp
    exit();
    1f76:	e8 d9 1c 00 00       	call   3c54 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    1f7b:	83 ec 0c             	sub    $0xc,%esp
    1f7e:	68 f7 4b 00 00       	push   $0x4bf7
    1f83:	e8 3c 1d 00 00       	call   3cc4 <chdir>
    1f88:	83 c4 10             	add    $0x10,%esp
    1f8b:	85 c0                	test   %eax,%eax
    1f8d:	74 17                	je     1fa6 <subdir+0x2e5>
    printf(1, "chdir dd/../../dd failed\n");
    1f8f:	83 ec 08             	sub    $0x8,%esp
    1f92:	68 dd 4b 00 00       	push   $0x4bdd
    1f97:	6a 01                	push   $0x1
    1f99:	e8 4d 1e 00 00       	call   3deb <printf>
    1f9e:	83 c4 10             	add    $0x10,%esp
    exit();
    1fa1:	e8 ae 1c 00 00       	call   3c54 <exit>
  }
  if(chdir("./..") != 0){
    1fa6:	83 ec 0c             	sub    $0xc,%esp
    1fa9:	68 06 4c 00 00       	push   $0x4c06
    1fae:	e8 11 1d 00 00       	call   3cc4 <chdir>
    1fb3:	83 c4 10             	add    $0x10,%esp
    1fb6:	85 c0                	test   %eax,%eax
    1fb8:	74 17                	je     1fd1 <subdir+0x310>
    printf(1, "chdir ./.. failed\n");
    1fba:	83 ec 08             	sub    $0x8,%esp
    1fbd:	68 0b 4c 00 00       	push   $0x4c0b
    1fc2:	6a 01                	push   $0x1
    1fc4:	e8 22 1e 00 00       	call   3deb <printf>
    1fc9:	83 c4 10             	add    $0x10,%esp
    exit();
    1fcc:	e8 83 1c 00 00       	call   3c54 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    1fd1:	83 ec 08             	sub    $0x8,%esp
    1fd4:	6a 00                	push   $0x0
    1fd6:	68 54 4b 00 00       	push   $0x4b54
    1fdb:	e8 b4 1c 00 00       	call   3c94 <open>
    1fe0:	83 c4 10             	add    $0x10,%esp
    1fe3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1fe6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1fea:	79 17                	jns    2003 <subdir+0x342>
    printf(1, "open dd/dd/ffff failed\n");
    1fec:	83 ec 08             	sub    $0x8,%esp
    1fef:	68 1e 4c 00 00       	push   $0x4c1e
    1ff4:	6a 01                	push   $0x1
    1ff6:	e8 f0 1d 00 00       	call   3deb <printf>
    1ffb:	83 c4 10             	add    $0x10,%esp
    exit();
    1ffe:	e8 51 1c 00 00       	call   3c54 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    2003:	83 ec 04             	sub    $0x4,%esp
    2006:	68 00 20 00 00       	push   $0x2000
    200b:	68 40 87 00 00       	push   $0x8740
    2010:	ff 75 f4             	pushl  -0xc(%ebp)
    2013:	e8 54 1c 00 00       	call   3c6c <read>
    2018:	83 c4 10             	add    $0x10,%esp
    201b:	83 f8 02             	cmp    $0x2,%eax
    201e:	74 17                	je     2037 <subdir+0x376>
    printf(1, "read dd/dd/ffff wrong len\n");
    2020:	83 ec 08             	sub    $0x8,%esp
    2023:	68 36 4c 00 00       	push   $0x4c36
    2028:	6a 01                	push   $0x1
    202a:	e8 bc 1d 00 00       	call   3deb <printf>
    202f:	83 c4 10             	add    $0x10,%esp
    exit();
    2032:	e8 1d 1c 00 00       	call   3c54 <exit>
  }
  close(fd);
    2037:	83 ec 0c             	sub    $0xc,%esp
    203a:	ff 75 f4             	pushl  -0xc(%ebp)
    203d:	e8 3a 1c 00 00       	call   3c7c <close>
    2042:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    2045:	83 ec 08             	sub    $0x8,%esp
    2048:	6a 00                	push   $0x0
    204a:	68 f0 4a 00 00       	push   $0x4af0
    204f:	e8 40 1c 00 00       	call   3c94 <open>
    2054:	83 c4 10             	add    $0x10,%esp
    2057:	85 c0                	test   %eax,%eax
    2059:	78 17                	js     2072 <subdir+0x3b1>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    205b:	83 ec 08             	sub    $0x8,%esp
    205e:	68 54 4c 00 00       	push   $0x4c54
    2063:	6a 01                	push   $0x1
    2065:	e8 81 1d 00 00       	call   3deb <printf>
    206a:	83 c4 10             	add    $0x10,%esp
    exit();
    206d:	e8 e2 1b 00 00       	call   3c54 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2072:	83 ec 08             	sub    $0x8,%esp
    2075:	68 02 02 00 00       	push   $0x202
    207a:	68 79 4c 00 00       	push   $0x4c79
    207f:	e8 10 1c 00 00       	call   3c94 <open>
    2084:	83 c4 10             	add    $0x10,%esp
    2087:	85 c0                	test   %eax,%eax
    2089:	78 17                	js     20a2 <subdir+0x3e1>
    printf(1, "create dd/ff/ff succeeded!\n");
    208b:	83 ec 08             	sub    $0x8,%esp
    208e:	68 82 4c 00 00       	push   $0x4c82
    2093:	6a 01                	push   $0x1
    2095:	e8 51 1d 00 00       	call   3deb <printf>
    209a:	83 c4 10             	add    $0x10,%esp
    exit();
    209d:	e8 b2 1b 00 00       	call   3c54 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    20a2:	83 ec 08             	sub    $0x8,%esp
    20a5:	68 02 02 00 00       	push   $0x202
    20aa:	68 9e 4c 00 00       	push   $0x4c9e
    20af:	e8 e0 1b 00 00       	call   3c94 <open>
    20b4:	83 c4 10             	add    $0x10,%esp
    20b7:	85 c0                	test   %eax,%eax
    20b9:	78 17                	js     20d2 <subdir+0x411>
    printf(1, "create dd/xx/ff succeeded!\n");
    20bb:	83 ec 08             	sub    $0x8,%esp
    20be:	68 a7 4c 00 00       	push   $0x4ca7
    20c3:	6a 01                	push   $0x1
    20c5:	e8 21 1d 00 00       	call   3deb <printf>
    20ca:	83 c4 10             	add    $0x10,%esp
    exit();
    20cd:	e8 82 1b 00 00       	call   3c54 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    20d2:	83 ec 08             	sub    $0x8,%esp
    20d5:	68 00 02 00 00       	push   $0x200
    20da:	68 71 4a 00 00       	push   $0x4a71
    20df:	e8 b0 1b 00 00       	call   3c94 <open>
    20e4:	83 c4 10             	add    $0x10,%esp
    20e7:	85 c0                	test   %eax,%eax
    20e9:	78 17                	js     2102 <subdir+0x441>
    printf(1, "create dd succeeded!\n");
    20eb:	83 ec 08             	sub    $0x8,%esp
    20ee:	68 c3 4c 00 00       	push   $0x4cc3
    20f3:	6a 01                	push   $0x1
    20f5:	e8 f1 1c 00 00       	call   3deb <printf>
    20fa:	83 c4 10             	add    $0x10,%esp
    exit();
    20fd:	e8 52 1b 00 00       	call   3c54 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    2102:	83 ec 08             	sub    $0x8,%esp
    2105:	6a 02                	push   $0x2
    2107:	68 71 4a 00 00       	push   $0x4a71
    210c:	e8 83 1b 00 00       	call   3c94 <open>
    2111:	83 c4 10             	add    $0x10,%esp
    2114:	85 c0                	test   %eax,%eax
    2116:	78 17                	js     212f <subdir+0x46e>
    printf(1, "open dd rdwr succeeded!\n");
    2118:	83 ec 08             	sub    $0x8,%esp
    211b:	68 d9 4c 00 00       	push   $0x4cd9
    2120:	6a 01                	push   $0x1
    2122:	e8 c4 1c 00 00       	call   3deb <printf>
    2127:	83 c4 10             	add    $0x10,%esp
    exit();
    212a:	e8 25 1b 00 00       	call   3c54 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    212f:	83 ec 08             	sub    $0x8,%esp
    2132:	6a 01                	push   $0x1
    2134:	68 71 4a 00 00       	push   $0x4a71
    2139:	e8 56 1b 00 00       	call   3c94 <open>
    213e:	83 c4 10             	add    $0x10,%esp
    2141:	85 c0                	test   %eax,%eax
    2143:	78 17                	js     215c <subdir+0x49b>
    printf(1, "open dd wronly succeeded!\n");
    2145:	83 ec 08             	sub    $0x8,%esp
    2148:	68 f2 4c 00 00       	push   $0x4cf2
    214d:	6a 01                	push   $0x1
    214f:	e8 97 1c 00 00       	call   3deb <printf>
    2154:	83 c4 10             	add    $0x10,%esp
    exit();
    2157:	e8 f8 1a 00 00       	call   3c54 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    215c:	83 ec 08             	sub    $0x8,%esp
    215f:	68 0d 4d 00 00       	push   $0x4d0d
    2164:	68 79 4c 00 00       	push   $0x4c79
    2169:	e8 46 1b 00 00       	call   3cb4 <link>
    216e:	83 c4 10             	add    $0x10,%esp
    2171:	85 c0                	test   %eax,%eax
    2173:	75 17                	jne    218c <subdir+0x4cb>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2175:	83 ec 08             	sub    $0x8,%esp
    2178:	68 18 4d 00 00       	push   $0x4d18
    217d:	6a 01                	push   $0x1
    217f:	e8 67 1c 00 00       	call   3deb <printf>
    2184:	83 c4 10             	add    $0x10,%esp
    exit();
    2187:	e8 c8 1a 00 00       	call   3c54 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    218c:	83 ec 08             	sub    $0x8,%esp
    218f:	68 0d 4d 00 00       	push   $0x4d0d
    2194:	68 9e 4c 00 00       	push   $0x4c9e
    2199:	e8 16 1b 00 00       	call   3cb4 <link>
    219e:	83 c4 10             	add    $0x10,%esp
    21a1:	85 c0                	test   %eax,%eax
    21a3:	75 17                	jne    21bc <subdir+0x4fb>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    21a5:	83 ec 08             	sub    $0x8,%esp
    21a8:	68 3c 4d 00 00       	push   $0x4d3c
    21ad:	6a 01                	push   $0x1
    21af:	e8 37 1c 00 00       	call   3deb <printf>
    21b4:	83 c4 10             	add    $0x10,%esp
    exit();
    21b7:	e8 98 1a 00 00       	call   3c54 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    21bc:	83 ec 08             	sub    $0x8,%esp
    21bf:	68 54 4b 00 00       	push   $0x4b54
    21c4:	68 8c 4a 00 00       	push   $0x4a8c
    21c9:	e8 e6 1a 00 00       	call   3cb4 <link>
    21ce:	83 c4 10             	add    $0x10,%esp
    21d1:	85 c0                	test   %eax,%eax
    21d3:	75 17                	jne    21ec <subdir+0x52b>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    21d5:	83 ec 08             	sub    $0x8,%esp
    21d8:	68 60 4d 00 00       	push   $0x4d60
    21dd:	6a 01                	push   $0x1
    21df:	e8 07 1c 00 00       	call   3deb <printf>
    21e4:	83 c4 10             	add    $0x10,%esp
    exit();
    21e7:	e8 68 1a 00 00       	call   3c54 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    21ec:	83 ec 0c             	sub    $0xc,%esp
    21ef:	68 79 4c 00 00       	push   $0x4c79
    21f4:	e8 c3 1a 00 00       	call   3cbc <mkdir>
    21f9:	83 c4 10             	add    $0x10,%esp
    21fc:	85 c0                	test   %eax,%eax
    21fe:	75 17                	jne    2217 <subdir+0x556>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2200:	83 ec 08             	sub    $0x8,%esp
    2203:	68 82 4d 00 00       	push   $0x4d82
    2208:	6a 01                	push   $0x1
    220a:	e8 dc 1b 00 00       	call   3deb <printf>
    220f:	83 c4 10             	add    $0x10,%esp
    exit();
    2212:	e8 3d 1a 00 00       	call   3c54 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    2217:	83 ec 0c             	sub    $0xc,%esp
    221a:	68 9e 4c 00 00       	push   $0x4c9e
    221f:	e8 98 1a 00 00       	call   3cbc <mkdir>
    2224:	83 c4 10             	add    $0x10,%esp
    2227:	85 c0                	test   %eax,%eax
    2229:	75 17                	jne    2242 <subdir+0x581>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    222b:	83 ec 08             	sub    $0x8,%esp
    222e:	68 9d 4d 00 00       	push   $0x4d9d
    2233:	6a 01                	push   $0x1
    2235:	e8 b1 1b 00 00       	call   3deb <printf>
    223a:	83 c4 10             	add    $0x10,%esp
    exit();
    223d:	e8 12 1a 00 00       	call   3c54 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    2242:	83 ec 0c             	sub    $0xc,%esp
    2245:	68 54 4b 00 00       	push   $0x4b54
    224a:	e8 6d 1a 00 00       	call   3cbc <mkdir>
    224f:	83 c4 10             	add    $0x10,%esp
    2252:	85 c0                	test   %eax,%eax
    2254:	75 17                	jne    226d <subdir+0x5ac>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    2256:	83 ec 08             	sub    $0x8,%esp
    2259:	68 b8 4d 00 00       	push   $0x4db8
    225e:	6a 01                	push   $0x1
    2260:	e8 86 1b 00 00       	call   3deb <printf>
    2265:	83 c4 10             	add    $0x10,%esp
    exit();
    2268:	e8 e7 19 00 00       	call   3c54 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    226d:	83 ec 0c             	sub    $0xc,%esp
    2270:	68 9e 4c 00 00       	push   $0x4c9e
    2275:	e8 2a 1a 00 00       	call   3ca4 <unlink>
    227a:	83 c4 10             	add    $0x10,%esp
    227d:	85 c0                	test   %eax,%eax
    227f:	75 17                	jne    2298 <subdir+0x5d7>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2281:	83 ec 08             	sub    $0x8,%esp
    2284:	68 d5 4d 00 00       	push   $0x4dd5
    2289:	6a 01                	push   $0x1
    228b:	e8 5b 1b 00 00       	call   3deb <printf>
    2290:	83 c4 10             	add    $0x10,%esp
    exit();
    2293:	e8 bc 19 00 00       	call   3c54 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    2298:	83 ec 0c             	sub    $0xc,%esp
    229b:	68 79 4c 00 00       	push   $0x4c79
    22a0:	e8 ff 19 00 00       	call   3ca4 <unlink>
    22a5:	83 c4 10             	add    $0x10,%esp
    22a8:	85 c0                	test   %eax,%eax
    22aa:	75 17                	jne    22c3 <subdir+0x602>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    22ac:	83 ec 08             	sub    $0x8,%esp
    22af:	68 f1 4d 00 00       	push   $0x4df1
    22b4:	6a 01                	push   $0x1
    22b6:	e8 30 1b 00 00       	call   3deb <printf>
    22bb:	83 c4 10             	add    $0x10,%esp
    exit();
    22be:	e8 91 19 00 00       	call   3c54 <exit>
  }
  if(chdir("dd/ff") == 0){
    22c3:	83 ec 0c             	sub    $0xc,%esp
    22c6:	68 8c 4a 00 00       	push   $0x4a8c
    22cb:	e8 f4 19 00 00       	call   3cc4 <chdir>
    22d0:	83 c4 10             	add    $0x10,%esp
    22d3:	85 c0                	test   %eax,%eax
    22d5:	75 17                	jne    22ee <subdir+0x62d>
    printf(1, "chdir dd/ff succeeded!\n");
    22d7:	83 ec 08             	sub    $0x8,%esp
    22da:	68 0d 4e 00 00       	push   $0x4e0d
    22df:	6a 01                	push   $0x1
    22e1:	e8 05 1b 00 00       	call   3deb <printf>
    22e6:	83 c4 10             	add    $0x10,%esp
    exit();
    22e9:	e8 66 19 00 00       	call   3c54 <exit>
  }
  if(chdir("dd/xx") == 0){
    22ee:	83 ec 0c             	sub    $0xc,%esp
    22f1:	68 25 4e 00 00       	push   $0x4e25
    22f6:	e8 c9 19 00 00       	call   3cc4 <chdir>
    22fb:	83 c4 10             	add    $0x10,%esp
    22fe:	85 c0                	test   %eax,%eax
    2300:	75 17                	jne    2319 <subdir+0x658>
    printf(1, "chdir dd/xx succeeded!\n");
    2302:	83 ec 08             	sub    $0x8,%esp
    2305:	68 2b 4e 00 00       	push   $0x4e2b
    230a:	6a 01                	push   $0x1
    230c:	e8 da 1a 00 00       	call   3deb <printf>
    2311:	83 c4 10             	add    $0x10,%esp
    exit();
    2314:	e8 3b 19 00 00       	call   3c54 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    2319:	83 ec 0c             	sub    $0xc,%esp
    231c:	68 54 4b 00 00       	push   $0x4b54
    2321:	e8 7e 19 00 00       	call   3ca4 <unlink>
    2326:	83 c4 10             	add    $0x10,%esp
    2329:	85 c0                	test   %eax,%eax
    232b:	74 17                	je     2344 <subdir+0x683>
    printf(1, "unlink dd/dd/ff failed\n");
    232d:	83 ec 08             	sub    $0x8,%esp
    2330:	68 81 4b 00 00       	push   $0x4b81
    2335:	6a 01                	push   $0x1
    2337:	e8 af 1a 00 00       	call   3deb <printf>
    233c:	83 c4 10             	add    $0x10,%esp
    exit();
    233f:	e8 10 19 00 00       	call   3c54 <exit>
  }
  if(unlink("dd/ff") != 0){
    2344:	83 ec 0c             	sub    $0xc,%esp
    2347:	68 8c 4a 00 00       	push   $0x4a8c
    234c:	e8 53 19 00 00       	call   3ca4 <unlink>
    2351:	83 c4 10             	add    $0x10,%esp
    2354:	85 c0                	test   %eax,%eax
    2356:	74 17                	je     236f <subdir+0x6ae>
    printf(1, "unlink dd/ff failed\n");
    2358:	83 ec 08             	sub    $0x8,%esp
    235b:	68 43 4e 00 00       	push   $0x4e43
    2360:	6a 01                	push   $0x1
    2362:	e8 84 1a 00 00       	call   3deb <printf>
    2367:	83 c4 10             	add    $0x10,%esp
    exit();
    236a:	e8 e5 18 00 00       	call   3c54 <exit>
  }
  if(unlink("dd") == 0){
    236f:	83 ec 0c             	sub    $0xc,%esp
    2372:	68 71 4a 00 00       	push   $0x4a71
    2377:	e8 28 19 00 00       	call   3ca4 <unlink>
    237c:	83 c4 10             	add    $0x10,%esp
    237f:	85 c0                	test   %eax,%eax
    2381:	75 17                	jne    239a <subdir+0x6d9>
    printf(1, "unlink non-empty dd succeeded!\n");
    2383:	83 ec 08             	sub    $0x8,%esp
    2386:	68 58 4e 00 00       	push   $0x4e58
    238b:	6a 01                	push   $0x1
    238d:	e8 59 1a 00 00       	call   3deb <printf>
    2392:	83 c4 10             	add    $0x10,%esp
    exit();
    2395:	e8 ba 18 00 00       	call   3c54 <exit>
  }
  if(unlink("dd/dd") < 0){
    239a:	83 ec 0c             	sub    $0xc,%esp
    239d:	68 78 4e 00 00       	push   $0x4e78
    23a2:	e8 fd 18 00 00       	call   3ca4 <unlink>
    23a7:	83 c4 10             	add    $0x10,%esp
    23aa:	85 c0                	test   %eax,%eax
    23ac:	79 17                	jns    23c5 <subdir+0x704>
    printf(1, "unlink dd/dd failed\n");
    23ae:	83 ec 08             	sub    $0x8,%esp
    23b1:	68 7e 4e 00 00       	push   $0x4e7e
    23b6:	6a 01                	push   $0x1
    23b8:	e8 2e 1a 00 00       	call   3deb <printf>
    23bd:	83 c4 10             	add    $0x10,%esp
    exit();
    23c0:	e8 8f 18 00 00       	call   3c54 <exit>
  }
  if(unlink("dd") < 0){
    23c5:	83 ec 0c             	sub    $0xc,%esp
    23c8:	68 71 4a 00 00       	push   $0x4a71
    23cd:	e8 d2 18 00 00       	call   3ca4 <unlink>
    23d2:	83 c4 10             	add    $0x10,%esp
    23d5:	85 c0                	test   %eax,%eax
    23d7:	79 17                	jns    23f0 <subdir+0x72f>
    printf(1, "unlink dd failed\n");
    23d9:	83 ec 08             	sub    $0x8,%esp
    23dc:	68 93 4e 00 00       	push   $0x4e93
    23e1:	6a 01                	push   $0x1
    23e3:	e8 03 1a 00 00       	call   3deb <printf>
    23e8:	83 c4 10             	add    $0x10,%esp
    exit();
    23eb:	e8 64 18 00 00       	call   3c54 <exit>
  }

  printf(1, "subdir ok\n");
    23f0:	83 ec 08             	sub    $0x8,%esp
    23f3:	68 a5 4e 00 00       	push   $0x4ea5
    23f8:	6a 01                	push   $0x1
    23fa:	e8 ec 19 00 00       	call   3deb <printf>
    23ff:	83 c4 10             	add    $0x10,%esp
}
    2402:	90                   	nop
    2403:	c9                   	leave  
    2404:	c3                   	ret    

00002405 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2405:	55                   	push   %ebp
    2406:	89 e5                	mov    %esp,%ebp
    2408:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    240b:	83 ec 08             	sub    $0x8,%esp
    240e:	68 b0 4e 00 00       	push   $0x4eb0
    2413:	6a 01                	push   $0x1
    2415:	e8 d1 19 00 00       	call   3deb <printf>
    241a:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    241d:	83 ec 0c             	sub    $0xc,%esp
    2420:	68 bf 4e 00 00       	push   $0x4ebf
    2425:	e8 7a 18 00 00       	call   3ca4 <unlink>
    242a:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    242d:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    2434:	e9 a8 00 00 00       	jmp    24e1 <bigwrite+0xdc>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2439:	83 ec 08             	sub    $0x8,%esp
    243c:	68 02 02 00 00       	push   $0x202
    2441:	68 bf 4e 00 00       	push   $0x4ebf
    2446:	e8 49 18 00 00       	call   3c94 <open>
    244b:	83 c4 10             	add    $0x10,%esp
    244e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    2451:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2455:	79 17                	jns    246e <bigwrite+0x69>
      printf(1, "cannot create bigwrite\n");
    2457:	83 ec 08             	sub    $0x8,%esp
    245a:	68 c8 4e 00 00       	push   $0x4ec8
    245f:	6a 01                	push   $0x1
    2461:	e8 85 19 00 00       	call   3deb <printf>
    2466:	83 c4 10             	add    $0x10,%esp
      exit();
    2469:	e8 e6 17 00 00       	call   3c54 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    246e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2475:	eb 3f                	jmp    24b6 <bigwrite+0xb1>
      int cc = write(fd, buf, sz);
    2477:	83 ec 04             	sub    $0x4,%esp
    247a:	ff 75 f4             	pushl  -0xc(%ebp)
    247d:	68 40 87 00 00       	push   $0x8740
    2482:	ff 75 ec             	pushl  -0x14(%ebp)
    2485:	e8 ea 17 00 00       	call   3c74 <write>
    248a:	83 c4 10             	add    $0x10,%esp
    248d:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    2490:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2493:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2496:	74 1a                	je     24b2 <bigwrite+0xad>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2498:	ff 75 e8             	pushl  -0x18(%ebp)
    249b:	ff 75 f4             	pushl  -0xc(%ebp)
    249e:	68 e0 4e 00 00       	push   $0x4ee0
    24a3:	6a 01                	push   $0x1
    24a5:	e8 41 19 00 00       	call   3deb <printf>
    24aa:	83 c4 10             	add    $0x10,%esp
        exit();
    24ad:	e8 a2 17 00 00       	call   3c54 <exit>
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
    24b2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    24b6:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    24ba:	7e bb                	jle    2477 <bigwrite+0x72>
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    24bc:	83 ec 0c             	sub    $0xc,%esp
    24bf:	ff 75 ec             	pushl  -0x14(%ebp)
    24c2:	e8 b5 17 00 00       	call   3c7c <close>
    24c7:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    24ca:	83 ec 0c             	sub    $0xc,%esp
    24cd:	68 bf 4e 00 00       	push   $0x4ebf
    24d2:	e8 cd 17 00 00       	call   3ca4 <unlink>
    24d7:	83 c4 10             	add    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    24da:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    24e1:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    24e8:	0f 8e 4b ff ff ff    	jle    2439 <bigwrite+0x34>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    24ee:	83 ec 08             	sub    $0x8,%esp
    24f1:	68 f2 4e 00 00       	push   $0x4ef2
    24f6:	6a 01                	push   $0x1
    24f8:	e8 ee 18 00 00       	call   3deb <printf>
    24fd:	83 c4 10             	add    $0x10,%esp
}
    2500:	90                   	nop
    2501:	c9                   	leave  
    2502:	c3                   	ret    

00002503 <bigfile>:

void
bigfile(void)
{
    2503:	55                   	push   %ebp
    2504:	89 e5                	mov    %esp,%ebp
    2506:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    2509:	83 ec 08             	sub    $0x8,%esp
    250c:	68 ff 4e 00 00       	push   $0x4eff
    2511:	6a 01                	push   $0x1
    2513:	e8 d3 18 00 00       	call   3deb <printf>
    2518:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    251b:	83 ec 0c             	sub    $0xc,%esp
    251e:	68 0d 4f 00 00       	push   $0x4f0d
    2523:	e8 7c 17 00 00       	call   3ca4 <unlink>
    2528:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    252b:	83 ec 08             	sub    $0x8,%esp
    252e:	68 02 02 00 00       	push   $0x202
    2533:	68 0d 4f 00 00       	push   $0x4f0d
    2538:	e8 57 17 00 00       	call   3c94 <open>
    253d:	83 c4 10             	add    $0x10,%esp
    2540:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    2543:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2547:	79 17                	jns    2560 <bigfile+0x5d>
    printf(1, "cannot create bigfile");
    2549:	83 ec 08             	sub    $0x8,%esp
    254c:	68 15 4f 00 00       	push   $0x4f15
    2551:	6a 01                	push   $0x1
    2553:	e8 93 18 00 00       	call   3deb <printf>
    2558:	83 c4 10             	add    $0x10,%esp
    exit();
    255b:	e8 f4 16 00 00       	call   3c54 <exit>
  }
  for(i = 0; i < 20; i++){
    2560:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2567:	eb 52                	jmp    25bb <bigfile+0xb8>
    memset(buf, i, 600);
    2569:	83 ec 04             	sub    $0x4,%esp
    256c:	68 58 02 00 00       	push   $0x258
    2571:	ff 75 f4             	pushl  -0xc(%ebp)
    2574:	68 40 87 00 00       	push   $0x8740
    2579:	e8 ea 14 00 00       	call   3a68 <memset>
    257e:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    2581:	83 ec 04             	sub    $0x4,%esp
    2584:	68 58 02 00 00       	push   $0x258
    2589:	68 40 87 00 00       	push   $0x8740
    258e:	ff 75 ec             	pushl  -0x14(%ebp)
    2591:	e8 de 16 00 00       	call   3c74 <write>
    2596:	83 c4 10             	add    $0x10,%esp
    2599:	3d 58 02 00 00       	cmp    $0x258,%eax
    259e:	74 17                	je     25b7 <bigfile+0xb4>
      printf(1, "write bigfile failed\n");
    25a0:	83 ec 08             	sub    $0x8,%esp
    25a3:	68 2b 4f 00 00       	push   $0x4f2b
    25a8:	6a 01                	push   $0x1
    25aa:	e8 3c 18 00 00       	call   3deb <printf>
    25af:	83 c4 10             	add    $0x10,%esp
      exit();
    25b2:	e8 9d 16 00 00       	call   3c54 <exit>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    25b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    25bb:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    25bf:	7e a8                	jle    2569 <bigfile+0x66>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    25c1:	83 ec 0c             	sub    $0xc,%esp
    25c4:	ff 75 ec             	pushl  -0x14(%ebp)
    25c7:	e8 b0 16 00 00       	call   3c7c <close>
    25cc:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    25cf:	83 ec 08             	sub    $0x8,%esp
    25d2:	6a 00                	push   $0x0
    25d4:	68 0d 4f 00 00       	push   $0x4f0d
    25d9:	e8 b6 16 00 00       	call   3c94 <open>
    25de:	83 c4 10             	add    $0x10,%esp
    25e1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    25e4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    25e8:	79 17                	jns    2601 <bigfile+0xfe>
    printf(1, "cannot open bigfile\n");
    25ea:	83 ec 08             	sub    $0x8,%esp
    25ed:	68 41 4f 00 00       	push   $0x4f41
    25f2:	6a 01                	push   $0x1
    25f4:	e8 f2 17 00 00       	call   3deb <printf>
    25f9:	83 c4 10             	add    $0x10,%esp
    exit();
    25fc:	e8 53 16 00 00       	call   3c54 <exit>
  }
  total = 0;
    2601:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    2608:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    260f:	83 ec 04             	sub    $0x4,%esp
    2612:	68 2c 01 00 00       	push   $0x12c
    2617:	68 40 87 00 00       	push   $0x8740
    261c:	ff 75 ec             	pushl  -0x14(%ebp)
    261f:	e8 48 16 00 00       	call   3c6c <read>
    2624:	83 c4 10             	add    $0x10,%esp
    2627:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    262a:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    262e:	79 17                	jns    2647 <bigfile+0x144>
      printf(1, "read bigfile failed\n");
    2630:	83 ec 08             	sub    $0x8,%esp
    2633:	68 56 4f 00 00       	push   $0x4f56
    2638:	6a 01                	push   $0x1
    263a:	e8 ac 17 00 00       	call   3deb <printf>
    263f:	83 c4 10             	add    $0x10,%esp
      exit();
    2642:	e8 0d 16 00 00       	call   3c54 <exit>
    }
    if(cc == 0)
    2647:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    264b:	74 7a                	je     26c7 <bigfile+0x1c4>
      break;
    if(cc != 300){
    264d:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    2654:	74 17                	je     266d <bigfile+0x16a>
      printf(1, "short read bigfile\n");
    2656:	83 ec 08             	sub    $0x8,%esp
    2659:	68 6b 4f 00 00       	push   $0x4f6b
    265e:	6a 01                	push   $0x1
    2660:	e8 86 17 00 00       	call   3deb <printf>
    2665:	83 c4 10             	add    $0x10,%esp
      exit();
    2668:	e8 e7 15 00 00       	call   3c54 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    266d:	0f b6 05 40 87 00 00 	movzbl 0x8740,%eax
    2674:	0f be d0             	movsbl %al,%edx
    2677:	8b 45 f4             	mov    -0xc(%ebp),%eax
    267a:	89 c1                	mov    %eax,%ecx
    267c:	c1 e9 1f             	shr    $0x1f,%ecx
    267f:	01 c8                	add    %ecx,%eax
    2681:	d1 f8                	sar    %eax
    2683:	39 c2                	cmp    %eax,%edx
    2685:	75 1a                	jne    26a1 <bigfile+0x19e>
    2687:	0f b6 05 6b 88 00 00 	movzbl 0x886b,%eax
    268e:	0f be d0             	movsbl %al,%edx
    2691:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2694:	89 c1                	mov    %eax,%ecx
    2696:	c1 e9 1f             	shr    $0x1f,%ecx
    2699:	01 c8                	add    %ecx,%eax
    269b:	d1 f8                	sar    %eax
    269d:	39 c2                	cmp    %eax,%edx
    269f:	74 17                	je     26b8 <bigfile+0x1b5>
      printf(1, "read bigfile wrong data\n");
    26a1:	83 ec 08             	sub    $0x8,%esp
    26a4:	68 7f 4f 00 00       	push   $0x4f7f
    26a9:	6a 01                	push   $0x1
    26ab:	e8 3b 17 00 00       	call   3deb <printf>
    26b0:	83 c4 10             	add    $0x10,%esp
      exit();
    26b3:	e8 9c 15 00 00       	call   3c54 <exit>
    }
    total += cc;
    26b8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    26bb:	01 45 f0             	add    %eax,-0x10(%ebp)
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    26be:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
    26c2:	e9 48 ff ff ff       	jmp    260f <bigfile+0x10c>
    if(cc < 0){
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    26c7:	90                   	nop
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    26c8:	83 ec 0c             	sub    $0xc,%esp
    26cb:	ff 75 ec             	pushl  -0x14(%ebp)
    26ce:	e8 a9 15 00 00       	call   3c7c <close>
    26d3:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    26d6:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    26dd:	74 17                	je     26f6 <bigfile+0x1f3>
    printf(1, "read bigfile wrong total\n");
    26df:	83 ec 08             	sub    $0x8,%esp
    26e2:	68 98 4f 00 00       	push   $0x4f98
    26e7:	6a 01                	push   $0x1
    26e9:	e8 fd 16 00 00       	call   3deb <printf>
    26ee:	83 c4 10             	add    $0x10,%esp
    exit();
    26f1:	e8 5e 15 00 00       	call   3c54 <exit>
  }
  unlink("bigfile");
    26f6:	83 ec 0c             	sub    $0xc,%esp
    26f9:	68 0d 4f 00 00       	push   $0x4f0d
    26fe:	e8 a1 15 00 00       	call   3ca4 <unlink>
    2703:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    2706:	83 ec 08             	sub    $0x8,%esp
    2709:	68 b2 4f 00 00       	push   $0x4fb2
    270e:	6a 01                	push   $0x1
    2710:	e8 d6 16 00 00       	call   3deb <printf>
    2715:	83 c4 10             	add    $0x10,%esp
}
    2718:	90                   	nop
    2719:	c9                   	leave  
    271a:	c3                   	ret    

0000271b <fourteen>:

void
fourteen(void)
{
    271b:	55                   	push   %ebp
    271c:	89 e5                	mov    %esp,%ebp
    271e:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    2721:	83 ec 08             	sub    $0x8,%esp
    2724:	68 c3 4f 00 00       	push   $0x4fc3
    2729:	6a 01                	push   $0x1
    272b:	e8 bb 16 00 00       	call   3deb <printf>
    2730:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    2733:	83 ec 0c             	sub    $0xc,%esp
    2736:	68 d2 4f 00 00       	push   $0x4fd2
    273b:	e8 7c 15 00 00       	call   3cbc <mkdir>
    2740:	83 c4 10             	add    $0x10,%esp
    2743:	85 c0                	test   %eax,%eax
    2745:	74 17                	je     275e <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    2747:	83 ec 08             	sub    $0x8,%esp
    274a:	68 e1 4f 00 00       	push   $0x4fe1
    274f:	6a 01                	push   $0x1
    2751:	e8 95 16 00 00       	call   3deb <printf>
    2756:	83 c4 10             	add    $0x10,%esp
    exit();
    2759:	e8 f6 14 00 00       	call   3c54 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    275e:	83 ec 0c             	sub    $0xc,%esp
    2761:	68 00 50 00 00       	push   $0x5000
    2766:	e8 51 15 00 00       	call   3cbc <mkdir>
    276b:	83 c4 10             	add    $0x10,%esp
    276e:	85 c0                	test   %eax,%eax
    2770:	74 17                	je     2789 <fourteen+0x6e>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2772:	83 ec 08             	sub    $0x8,%esp
    2775:	68 20 50 00 00       	push   $0x5020
    277a:	6a 01                	push   $0x1
    277c:	e8 6a 16 00 00       	call   3deb <printf>
    2781:	83 c4 10             	add    $0x10,%esp
    exit();
    2784:	e8 cb 14 00 00       	call   3c54 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2789:	83 ec 08             	sub    $0x8,%esp
    278c:	68 00 02 00 00       	push   $0x200
    2791:	68 50 50 00 00       	push   $0x5050
    2796:	e8 f9 14 00 00       	call   3c94 <open>
    279b:	83 c4 10             	add    $0x10,%esp
    279e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    27a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27a5:	79 17                	jns    27be <fourteen+0xa3>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    27a7:	83 ec 08             	sub    $0x8,%esp
    27aa:	68 80 50 00 00       	push   $0x5080
    27af:	6a 01                	push   $0x1
    27b1:	e8 35 16 00 00       	call   3deb <printf>
    27b6:	83 c4 10             	add    $0x10,%esp
    exit();
    27b9:	e8 96 14 00 00       	call   3c54 <exit>
  }
  close(fd);
    27be:	83 ec 0c             	sub    $0xc,%esp
    27c1:	ff 75 f4             	pushl  -0xc(%ebp)
    27c4:	e8 b3 14 00 00       	call   3c7c <close>
    27c9:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    27cc:	83 ec 08             	sub    $0x8,%esp
    27cf:	6a 00                	push   $0x0
    27d1:	68 c0 50 00 00       	push   $0x50c0
    27d6:	e8 b9 14 00 00       	call   3c94 <open>
    27db:	83 c4 10             	add    $0x10,%esp
    27de:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    27e1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    27e5:	79 17                	jns    27fe <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    27e7:	83 ec 08             	sub    $0x8,%esp
    27ea:	68 f0 50 00 00       	push   $0x50f0
    27ef:	6a 01                	push   $0x1
    27f1:	e8 f5 15 00 00       	call   3deb <printf>
    27f6:	83 c4 10             	add    $0x10,%esp
    exit();
    27f9:	e8 56 14 00 00       	call   3c54 <exit>
  }
  close(fd);
    27fe:	83 ec 0c             	sub    $0xc,%esp
    2801:	ff 75 f4             	pushl  -0xc(%ebp)
    2804:	e8 73 14 00 00       	call   3c7c <close>
    2809:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    280c:	83 ec 0c             	sub    $0xc,%esp
    280f:	68 2a 51 00 00       	push   $0x512a
    2814:	e8 a3 14 00 00       	call   3cbc <mkdir>
    2819:	83 c4 10             	add    $0x10,%esp
    281c:	85 c0                	test   %eax,%eax
    281e:	75 17                	jne    2837 <fourteen+0x11c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2820:	83 ec 08             	sub    $0x8,%esp
    2823:	68 48 51 00 00       	push   $0x5148
    2828:	6a 01                	push   $0x1
    282a:	e8 bc 15 00 00       	call   3deb <printf>
    282f:	83 c4 10             	add    $0x10,%esp
    exit();
    2832:	e8 1d 14 00 00       	call   3c54 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2837:	83 ec 0c             	sub    $0xc,%esp
    283a:	68 78 51 00 00       	push   $0x5178
    283f:	e8 78 14 00 00       	call   3cbc <mkdir>
    2844:	83 c4 10             	add    $0x10,%esp
    2847:	85 c0                	test   %eax,%eax
    2849:	75 17                	jne    2862 <fourteen+0x147>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    284b:	83 ec 08             	sub    $0x8,%esp
    284e:	68 98 51 00 00       	push   $0x5198
    2853:	6a 01                	push   $0x1
    2855:	e8 91 15 00 00       	call   3deb <printf>
    285a:	83 c4 10             	add    $0x10,%esp
    exit();
    285d:	e8 f2 13 00 00       	call   3c54 <exit>
  }

  printf(1, "fourteen ok\n");
    2862:	83 ec 08             	sub    $0x8,%esp
    2865:	68 c9 51 00 00       	push   $0x51c9
    286a:	6a 01                	push   $0x1
    286c:	e8 7a 15 00 00       	call   3deb <printf>
    2871:	83 c4 10             	add    $0x10,%esp
}
    2874:	90                   	nop
    2875:	c9                   	leave  
    2876:	c3                   	ret    

00002877 <rmdot>:

void
rmdot(void)
{
    2877:	55                   	push   %ebp
    2878:	89 e5                	mov    %esp,%ebp
    287a:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    287d:	83 ec 08             	sub    $0x8,%esp
    2880:	68 d6 51 00 00       	push   $0x51d6
    2885:	6a 01                	push   $0x1
    2887:	e8 5f 15 00 00       	call   3deb <printf>
    288c:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    288f:	83 ec 0c             	sub    $0xc,%esp
    2892:	68 e2 51 00 00       	push   $0x51e2
    2897:	e8 20 14 00 00       	call   3cbc <mkdir>
    289c:	83 c4 10             	add    $0x10,%esp
    289f:	85 c0                	test   %eax,%eax
    28a1:	74 17                	je     28ba <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    28a3:	83 ec 08             	sub    $0x8,%esp
    28a6:	68 e7 51 00 00       	push   $0x51e7
    28ab:	6a 01                	push   $0x1
    28ad:	e8 39 15 00 00       	call   3deb <printf>
    28b2:	83 c4 10             	add    $0x10,%esp
    exit();
    28b5:	e8 9a 13 00 00       	call   3c54 <exit>
  }
  if(chdir("dots") != 0){
    28ba:	83 ec 0c             	sub    $0xc,%esp
    28bd:	68 e2 51 00 00       	push   $0x51e2
    28c2:	e8 fd 13 00 00       	call   3cc4 <chdir>
    28c7:	83 c4 10             	add    $0x10,%esp
    28ca:	85 c0                	test   %eax,%eax
    28cc:	74 17                	je     28e5 <rmdot+0x6e>
    printf(1, "chdir dots failed\n");
    28ce:	83 ec 08             	sub    $0x8,%esp
    28d1:	68 fa 51 00 00       	push   $0x51fa
    28d6:	6a 01                	push   $0x1
    28d8:	e8 0e 15 00 00       	call   3deb <printf>
    28dd:	83 c4 10             	add    $0x10,%esp
    exit();
    28e0:	e8 6f 13 00 00       	call   3c54 <exit>
  }
  if(unlink(".") == 0){
    28e5:	83 ec 0c             	sub    $0xc,%esp
    28e8:	68 13 49 00 00       	push   $0x4913
    28ed:	e8 b2 13 00 00       	call   3ca4 <unlink>
    28f2:	83 c4 10             	add    $0x10,%esp
    28f5:	85 c0                	test   %eax,%eax
    28f7:	75 17                	jne    2910 <rmdot+0x99>
    printf(1, "rm . worked!\n");
    28f9:	83 ec 08             	sub    $0x8,%esp
    28fc:	68 0d 52 00 00       	push   $0x520d
    2901:	6a 01                	push   $0x1
    2903:	e8 e3 14 00 00       	call   3deb <printf>
    2908:	83 c4 10             	add    $0x10,%esp
    exit();
    290b:	e8 44 13 00 00       	call   3c54 <exit>
  }
  if(unlink("..") == 0){
    2910:	83 ec 0c             	sub    $0xc,%esp
    2913:	68 a0 44 00 00       	push   $0x44a0
    2918:	e8 87 13 00 00       	call   3ca4 <unlink>
    291d:	83 c4 10             	add    $0x10,%esp
    2920:	85 c0                	test   %eax,%eax
    2922:	75 17                	jne    293b <rmdot+0xc4>
    printf(1, "rm .. worked!\n");
    2924:	83 ec 08             	sub    $0x8,%esp
    2927:	68 1b 52 00 00       	push   $0x521b
    292c:	6a 01                	push   $0x1
    292e:	e8 b8 14 00 00       	call   3deb <printf>
    2933:	83 c4 10             	add    $0x10,%esp
    exit();
    2936:	e8 19 13 00 00       	call   3c54 <exit>
  }
  if(chdir("/") != 0){
    293b:	83 ec 0c             	sub    $0xc,%esp
    293e:	68 2a 52 00 00       	push   $0x522a
    2943:	e8 7c 13 00 00       	call   3cc4 <chdir>
    2948:	83 c4 10             	add    $0x10,%esp
    294b:	85 c0                	test   %eax,%eax
    294d:	74 17                	je     2966 <rmdot+0xef>
    printf(1, "chdir / failed\n");
    294f:	83 ec 08             	sub    $0x8,%esp
    2952:	68 2c 52 00 00       	push   $0x522c
    2957:	6a 01                	push   $0x1
    2959:	e8 8d 14 00 00       	call   3deb <printf>
    295e:	83 c4 10             	add    $0x10,%esp
    exit();
    2961:	e8 ee 12 00 00       	call   3c54 <exit>
  }
  if(unlink("dots/.") == 0){
    2966:	83 ec 0c             	sub    $0xc,%esp
    2969:	68 3c 52 00 00       	push   $0x523c
    296e:	e8 31 13 00 00       	call   3ca4 <unlink>
    2973:	83 c4 10             	add    $0x10,%esp
    2976:	85 c0                	test   %eax,%eax
    2978:	75 17                	jne    2991 <rmdot+0x11a>
    printf(1, "unlink dots/. worked!\n");
    297a:	83 ec 08             	sub    $0x8,%esp
    297d:	68 43 52 00 00       	push   $0x5243
    2982:	6a 01                	push   $0x1
    2984:	e8 62 14 00 00       	call   3deb <printf>
    2989:	83 c4 10             	add    $0x10,%esp
    exit();
    298c:	e8 c3 12 00 00       	call   3c54 <exit>
  }
  if(unlink("dots/..") == 0){
    2991:	83 ec 0c             	sub    $0xc,%esp
    2994:	68 5a 52 00 00       	push   $0x525a
    2999:	e8 06 13 00 00       	call   3ca4 <unlink>
    299e:	83 c4 10             	add    $0x10,%esp
    29a1:	85 c0                	test   %eax,%eax
    29a3:	75 17                	jne    29bc <rmdot+0x145>
    printf(1, "unlink dots/.. worked!\n");
    29a5:	83 ec 08             	sub    $0x8,%esp
    29a8:	68 62 52 00 00       	push   $0x5262
    29ad:	6a 01                	push   $0x1
    29af:	e8 37 14 00 00       	call   3deb <printf>
    29b4:	83 c4 10             	add    $0x10,%esp
    exit();
    29b7:	e8 98 12 00 00       	call   3c54 <exit>
  }
  if(unlink("dots") != 0){
    29bc:	83 ec 0c             	sub    $0xc,%esp
    29bf:	68 e2 51 00 00       	push   $0x51e2
    29c4:	e8 db 12 00 00       	call   3ca4 <unlink>
    29c9:	83 c4 10             	add    $0x10,%esp
    29cc:	85 c0                	test   %eax,%eax
    29ce:	74 17                	je     29e7 <rmdot+0x170>
    printf(1, "unlink dots failed!\n");
    29d0:	83 ec 08             	sub    $0x8,%esp
    29d3:	68 7a 52 00 00       	push   $0x527a
    29d8:	6a 01                	push   $0x1
    29da:	e8 0c 14 00 00       	call   3deb <printf>
    29df:	83 c4 10             	add    $0x10,%esp
    exit();
    29e2:	e8 6d 12 00 00       	call   3c54 <exit>
  }
  printf(1, "rmdot ok\n");
    29e7:	83 ec 08             	sub    $0x8,%esp
    29ea:	68 8f 52 00 00       	push   $0x528f
    29ef:	6a 01                	push   $0x1
    29f1:	e8 f5 13 00 00       	call   3deb <printf>
    29f6:	83 c4 10             	add    $0x10,%esp
}
    29f9:	90                   	nop
    29fa:	c9                   	leave  
    29fb:	c3                   	ret    

000029fc <dirfile>:

void
dirfile(void)
{
    29fc:	55                   	push   %ebp
    29fd:	89 e5                	mov    %esp,%ebp
    29ff:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2a02:	83 ec 08             	sub    $0x8,%esp
    2a05:	68 99 52 00 00       	push   $0x5299
    2a0a:	6a 01                	push   $0x1
    2a0c:	e8 da 13 00 00       	call   3deb <printf>
    2a11:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2a14:	83 ec 08             	sub    $0x8,%esp
    2a17:	68 00 02 00 00       	push   $0x200
    2a1c:	68 a6 52 00 00       	push   $0x52a6
    2a21:	e8 6e 12 00 00       	call   3c94 <open>
    2a26:	83 c4 10             	add    $0x10,%esp
    2a29:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a30:	79 17                	jns    2a49 <dirfile+0x4d>
    printf(1, "create dirfile failed\n");
    2a32:	83 ec 08             	sub    $0x8,%esp
    2a35:	68 ae 52 00 00       	push   $0x52ae
    2a3a:	6a 01                	push   $0x1
    2a3c:	e8 aa 13 00 00       	call   3deb <printf>
    2a41:	83 c4 10             	add    $0x10,%esp
    exit();
    2a44:	e8 0b 12 00 00       	call   3c54 <exit>
  }
  close(fd);
    2a49:	83 ec 0c             	sub    $0xc,%esp
    2a4c:	ff 75 f4             	pushl  -0xc(%ebp)
    2a4f:	e8 28 12 00 00       	call   3c7c <close>
    2a54:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2a57:	83 ec 0c             	sub    $0xc,%esp
    2a5a:	68 a6 52 00 00       	push   $0x52a6
    2a5f:	e8 60 12 00 00       	call   3cc4 <chdir>
    2a64:	83 c4 10             	add    $0x10,%esp
    2a67:	85 c0                	test   %eax,%eax
    2a69:	75 17                	jne    2a82 <dirfile+0x86>
    printf(1, "chdir dirfile succeeded!\n");
    2a6b:	83 ec 08             	sub    $0x8,%esp
    2a6e:	68 c5 52 00 00       	push   $0x52c5
    2a73:	6a 01                	push   $0x1
    2a75:	e8 71 13 00 00       	call   3deb <printf>
    2a7a:	83 c4 10             	add    $0x10,%esp
    exit();
    2a7d:	e8 d2 11 00 00       	call   3c54 <exit>
  }
  fd = open("dirfile/xx", 0);
    2a82:	83 ec 08             	sub    $0x8,%esp
    2a85:	6a 00                	push   $0x0
    2a87:	68 df 52 00 00       	push   $0x52df
    2a8c:	e8 03 12 00 00       	call   3c94 <open>
    2a91:	83 c4 10             	add    $0x10,%esp
    2a94:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2a97:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a9b:	78 17                	js     2ab4 <dirfile+0xb8>
    printf(1, "create dirfile/xx succeeded!\n");
    2a9d:	83 ec 08             	sub    $0x8,%esp
    2aa0:	68 ea 52 00 00       	push   $0x52ea
    2aa5:	6a 01                	push   $0x1
    2aa7:	e8 3f 13 00 00       	call   3deb <printf>
    2aac:	83 c4 10             	add    $0x10,%esp
    exit();
    2aaf:	e8 a0 11 00 00       	call   3c54 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2ab4:	83 ec 08             	sub    $0x8,%esp
    2ab7:	68 00 02 00 00       	push   $0x200
    2abc:	68 df 52 00 00       	push   $0x52df
    2ac1:	e8 ce 11 00 00       	call   3c94 <open>
    2ac6:	83 c4 10             	add    $0x10,%esp
    2ac9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2acc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2ad0:	78 17                	js     2ae9 <dirfile+0xed>
    printf(1, "create dirfile/xx succeeded!\n");
    2ad2:	83 ec 08             	sub    $0x8,%esp
    2ad5:	68 ea 52 00 00       	push   $0x52ea
    2ada:	6a 01                	push   $0x1
    2adc:	e8 0a 13 00 00       	call   3deb <printf>
    2ae1:	83 c4 10             	add    $0x10,%esp
    exit();
    2ae4:	e8 6b 11 00 00       	call   3c54 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2ae9:	83 ec 0c             	sub    $0xc,%esp
    2aec:	68 df 52 00 00       	push   $0x52df
    2af1:	e8 c6 11 00 00       	call   3cbc <mkdir>
    2af6:	83 c4 10             	add    $0x10,%esp
    2af9:	85 c0                	test   %eax,%eax
    2afb:	75 17                	jne    2b14 <dirfile+0x118>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2afd:	83 ec 08             	sub    $0x8,%esp
    2b00:	68 08 53 00 00       	push   $0x5308
    2b05:	6a 01                	push   $0x1
    2b07:	e8 df 12 00 00       	call   3deb <printf>
    2b0c:	83 c4 10             	add    $0x10,%esp
    exit();
    2b0f:	e8 40 11 00 00       	call   3c54 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2b14:	83 ec 0c             	sub    $0xc,%esp
    2b17:	68 df 52 00 00       	push   $0x52df
    2b1c:	e8 83 11 00 00       	call   3ca4 <unlink>
    2b21:	83 c4 10             	add    $0x10,%esp
    2b24:	85 c0                	test   %eax,%eax
    2b26:	75 17                	jne    2b3f <dirfile+0x143>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2b28:	83 ec 08             	sub    $0x8,%esp
    2b2b:	68 25 53 00 00       	push   $0x5325
    2b30:	6a 01                	push   $0x1
    2b32:	e8 b4 12 00 00       	call   3deb <printf>
    2b37:	83 c4 10             	add    $0x10,%esp
    exit();
    2b3a:	e8 15 11 00 00       	call   3c54 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2b3f:	83 ec 08             	sub    $0x8,%esp
    2b42:	68 df 52 00 00       	push   $0x52df
    2b47:	68 43 53 00 00       	push   $0x5343
    2b4c:	e8 63 11 00 00       	call   3cb4 <link>
    2b51:	83 c4 10             	add    $0x10,%esp
    2b54:	85 c0                	test   %eax,%eax
    2b56:	75 17                	jne    2b6f <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2b58:	83 ec 08             	sub    $0x8,%esp
    2b5b:	68 4c 53 00 00       	push   $0x534c
    2b60:	6a 01                	push   $0x1
    2b62:	e8 84 12 00 00       	call   3deb <printf>
    2b67:	83 c4 10             	add    $0x10,%esp
    exit();
    2b6a:	e8 e5 10 00 00       	call   3c54 <exit>
  }
  if(unlink("dirfile") != 0){
    2b6f:	83 ec 0c             	sub    $0xc,%esp
    2b72:	68 a6 52 00 00       	push   $0x52a6
    2b77:	e8 28 11 00 00       	call   3ca4 <unlink>
    2b7c:	83 c4 10             	add    $0x10,%esp
    2b7f:	85 c0                	test   %eax,%eax
    2b81:	74 17                	je     2b9a <dirfile+0x19e>
    printf(1, "unlink dirfile failed!\n");
    2b83:	83 ec 08             	sub    $0x8,%esp
    2b86:	68 6b 53 00 00       	push   $0x536b
    2b8b:	6a 01                	push   $0x1
    2b8d:	e8 59 12 00 00       	call   3deb <printf>
    2b92:	83 c4 10             	add    $0x10,%esp
    exit();
    2b95:	e8 ba 10 00 00       	call   3c54 <exit>
  }

  fd = open(".", O_RDWR);
    2b9a:	83 ec 08             	sub    $0x8,%esp
    2b9d:	6a 02                	push   $0x2
    2b9f:	68 13 49 00 00       	push   $0x4913
    2ba4:	e8 eb 10 00 00       	call   3c94 <open>
    2ba9:	83 c4 10             	add    $0x10,%esp
    2bac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2baf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2bb3:	78 17                	js     2bcc <dirfile+0x1d0>
    printf(1, "open . for writing succeeded!\n");
    2bb5:	83 ec 08             	sub    $0x8,%esp
    2bb8:	68 84 53 00 00       	push   $0x5384
    2bbd:	6a 01                	push   $0x1
    2bbf:	e8 27 12 00 00       	call   3deb <printf>
    2bc4:	83 c4 10             	add    $0x10,%esp
    exit();
    2bc7:	e8 88 10 00 00       	call   3c54 <exit>
  }
  fd = open(".", 0);
    2bcc:	83 ec 08             	sub    $0x8,%esp
    2bcf:	6a 00                	push   $0x0
    2bd1:	68 13 49 00 00       	push   $0x4913
    2bd6:	e8 b9 10 00 00       	call   3c94 <open>
    2bdb:	83 c4 10             	add    $0x10,%esp
    2bde:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2be1:	83 ec 04             	sub    $0x4,%esp
    2be4:	6a 01                	push   $0x1
    2be6:	68 4a 45 00 00       	push   $0x454a
    2beb:	ff 75 f4             	pushl  -0xc(%ebp)
    2bee:	e8 81 10 00 00       	call   3c74 <write>
    2bf3:	83 c4 10             	add    $0x10,%esp
    2bf6:	85 c0                	test   %eax,%eax
    2bf8:	7e 17                	jle    2c11 <dirfile+0x215>
    printf(1, "write . succeeded!\n");
    2bfa:	83 ec 08             	sub    $0x8,%esp
    2bfd:	68 a3 53 00 00       	push   $0x53a3
    2c02:	6a 01                	push   $0x1
    2c04:	e8 e2 11 00 00       	call   3deb <printf>
    2c09:	83 c4 10             	add    $0x10,%esp
    exit();
    2c0c:	e8 43 10 00 00       	call   3c54 <exit>
  }
  close(fd);
    2c11:	83 ec 0c             	sub    $0xc,%esp
    2c14:	ff 75 f4             	pushl  -0xc(%ebp)
    2c17:	e8 60 10 00 00       	call   3c7c <close>
    2c1c:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2c1f:	83 ec 08             	sub    $0x8,%esp
    2c22:	68 b7 53 00 00       	push   $0x53b7
    2c27:	6a 01                	push   $0x1
    2c29:	e8 bd 11 00 00       	call   3deb <printf>
    2c2e:	83 c4 10             	add    $0x10,%esp
}
    2c31:	90                   	nop
    2c32:	c9                   	leave  
    2c33:	c3                   	ret    

00002c34 <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2c34:	55                   	push   %ebp
    2c35:	89 e5                	mov    %esp,%ebp
    2c37:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2c3a:	83 ec 08             	sub    $0x8,%esp
    2c3d:	68 c7 53 00 00       	push   $0x53c7
    2c42:	6a 01                	push   $0x1
    2c44:	e8 a2 11 00 00       	call   3deb <printf>
    2c49:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2c4c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2c53:	e9 e7 00 00 00       	jmp    2d3f <iref+0x10b>
    if(mkdir("irefd") != 0){
    2c58:	83 ec 0c             	sub    $0xc,%esp
    2c5b:	68 d8 53 00 00       	push   $0x53d8
    2c60:	e8 57 10 00 00       	call   3cbc <mkdir>
    2c65:	83 c4 10             	add    $0x10,%esp
    2c68:	85 c0                	test   %eax,%eax
    2c6a:	74 17                	je     2c83 <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2c6c:	83 ec 08             	sub    $0x8,%esp
    2c6f:	68 de 53 00 00       	push   $0x53de
    2c74:	6a 01                	push   $0x1
    2c76:	e8 70 11 00 00       	call   3deb <printf>
    2c7b:	83 c4 10             	add    $0x10,%esp
      exit();
    2c7e:	e8 d1 0f 00 00       	call   3c54 <exit>
    }
    if(chdir("irefd") != 0){
    2c83:	83 ec 0c             	sub    $0xc,%esp
    2c86:	68 d8 53 00 00       	push   $0x53d8
    2c8b:	e8 34 10 00 00       	call   3cc4 <chdir>
    2c90:	83 c4 10             	add    $0x10,%esp
    2c93:	85 c0                	test   %eax,%eax
    2c95:	74 17                	je     2cae <iref+0x7a>
      printf(1, "chdir irefd failed\n");
    2c97:	83 ec 08             	sub    $0x8,%esp
    2c9a:	68 f2 53 00 00       	push   $0x53f2
    2c9f:	6a 01                	push   $0x1
    2ca1:	e8 45 11 00 00       	call   3deb <printf>
    2ca6:	83 c4 10             	add    $0x10,%esp
      exit();
    2ca9:	e8 a6 0f 00 00       	call   3c54 <exit>
    }

    mkdir("");
    2cae:	83 ec 0c             	sub    $0xc,%esp
    2cb1:	68 06 54 00 00       	push   $0x5406
    2cb6:	e8 01 10 00 00       	call   3cbc <mkdir>
    2cbb:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2cbe:	83 ec 08             	sub    $0x8,%esp
    2cc1:	68 06 54 00 00       	push   $0x5406
    2cc6:	68 43 53 00 00       	push   $0x5343
    2ccb:	e8 e4 0f 00 00       	call   3cb4 <link>
    2cd0:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    2cd3:	83 ec 08             	sub    $0x8,%esp
    2cd6:	68 00 02 00 00       	push   $0x200
    2cdb:	68 06 54 00 00       	push   $0x5406
    2ce0:	e8 af 0f 00 00       	call   3c94 <open>
    2ce5:	83 c4 10             	add    $0x10,%esp
    2ce8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2ceb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2cef:	78 0e                	js     2cff <iref+0xcb>
      close(fd);
    2cf1:	83 ec 0c             	sub    $0xc,%esp
    2cf4:	ff 75 f0             	pushl  -0x10(%ebp)
    2cf7:	e8 80 0f 00 00       	call   3c7c <close>
    2cfc:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2cff:	83 ec 08             	sub    $0x8,%esp
    2d02:	68 00 02 00 00       	push   $0x200
    2d07:	68 07 54 00 00       	push   $0x5407
    2d0c:	e8 83 0f 00 00       	call   3c94 <open>
    2d11:	83 c4 10             	add    $0x10,%esp
    2d14:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2d17:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d1b:	78 0e                	js     2d2b <iref+0xf7>
      close(fd);
    2d1d:	83 ec 0c             	sub    $0xc,%esp
    2d20:	ff 75 f0             	pushl  -0x10(%ebp)
    2d23:	e8 54 0f 00 00       	call   3c7c <close>
    2d28:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2d2b:	83 ec 0c             	sub    $0xc,%esp
    2d2e:	68 07 54 00 00       	push   $0x5407
    2d33:	e8 6c 0f 00 00       	call   3ca4 <unlink>
    2d38:	83 c4 10             	add    $0x10,%esp
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2d3b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2d3f:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    2d43:	0f 8e 0f ff ff ff    	jle    2c58 <iref+0x24>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2d49:	83 ec 0c             	sub    $0xc,%esp
    2d4c:	68 2a 52 00 00       	push   $0x522a
    2d51:	e8 6e 0f 00 00       	call   3cc4 <chdir>
    2d56:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    2d59:	83 ec 08             	sub    $0x8,%esp
    2d5c:	68 0a 54 00 00       	push   $0x540a
    2d61:	6a 01                	push   $0x1
    2d63:	e8 83 10 00 00       	call   3deb <printf>
    2d68:	83 c4 10             	add    $0x10,%esp
}
    2d6b:	90                   	nop
    2d6c:	c9                   	leave  
    2d6d:	c3                   	ret    

00002d6e <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2d6e:	55                   	push   %ebp
    2d6f:	89 e5                	mov    %esp,%ebp
    2d71:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    2d74:	83 ec 08             	sub    $0x8,%esp
    2d77:	68 1e 54 00 00       	push   $0x541e
    2d7c:	6a 01                	push   $0x1
    2d7e:	e8 68 10 00 00       	call   3deb <printf>
    2d83:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    2d86:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2d8d:	eb 1d                	jmp    2dac <forktest+0x3e>
    pid = fork();
    2d8f:	e8 b8 0e 00 00       	call   3c4c <fork>
    2d94:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    2d97:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2d9b:	78 1a                	js     2db7 <forktest+0x49>
      break;
    if(pid == 0)
    2d9d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2da1:	75 05                	jne    2da8 <forktest+0x3a>
      exit();
    2da3:	e8 ac 0e 00 00       	call   3c54 <exit>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2da8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2dac:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    2db3:	7e da                	jle    2d8f <forktest+0x21>
    2db5:	eb 01                	jmp    2db8 <forktest+0x4a>
    pid = fork();
    if(pid < 0)
      break;
    2db7:	90                   	nop
    if(pid == 0)
      exit();
  }
  
  if(n == 1000){
    2db8:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    2dbf:	75 3b                	jne    2dfc <forktest+0x8e>
    printf(1, "fork claimed to work 1000 times!\n");
    2dc1:	83 ec 08             	sub    $0x8,%esp
    2dc4:	68 2c 54 00 00       	push   $0x542c
    2dc9:	6a 01                	push   $0x1
    2dcb:	e8 1b 10 00 00       	call   3deb <printf>
    2dd0:	83 c4 10             	add    $0x10,%esp
    exit();
    2dd3:	e8 7c 0e 00 00       	call   3c54 <exit>
  }
  
  for(; n > 0; n--){
    if(wait() < 0){
    2dd8:	e8 7f 0e 00 00       	call   3c5c <wait>
    2ddd:	85 c0                	test   %eax,%eax
    2ddf:	79 17                	jns    2df8 <forktest+0x8a>
      printf(1, "wait stopped early\n");
    2de1:	83 ec 08             	sub    $0x8,%esp
    2de4:	68 4e 54 00 00       	push   $0x544e
    2de9:	6a 01                	push   $0x1
    2deb:	e8 fb 0f 00 00       	call   3deb <printf>
    2df0:	83 c4 10             	add    $0x10,%esp
      exit();
    2df3:	e8 5c 0e 00 00       	call   3c54 <exit>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }
  
  for(; n > 0; n--){
    2df8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    2dfc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e00:	7f d6                	jg     2dd8 <forktest+0x6a>
      printf(1, "wait stopped early\n");
      exit();
    }
  }
  
  if(wait() != -1){
    2e02:	e8 55 0e 00 00       	call   3c5c <wait>
    2e07:	83 f8 ff             	cmp    $0xffffffff,%eax
    2e0a:	74 17                	je     2e23 <forktest+0xb5>
    printf(1, "wait got too many\n");
    2e0c:	83 ec 08             	sub    $0x8,%esp
    2e0f:	68 62 54 00 00       	push   $0x5462
    2e14:	6a 01                	push   $0x1
    2e16:	e8 d0 0f 00 00       	call   3deb <printf>
    2e1b:	83 c4 10             	add    $0x10,%esp
    exit();
    2e1e:	e8 31 0e 00 00       	call   3c54 <exit>
  }
  
  printf(1, "fork test OK\n");
    2e23:	83 ec 08             	sub    $0x8,%esp
    2e26:	68 75 54 00 00       	push   $0x5475
    2e2b:	6a 01                	push   $0x1
    2e2d:	e8 b9 0f 00 00       	call   3deb <printf>
    2e32:	83 c4 10             	add    $0x10,%esp
}
    2e35:	90                   	nop
    2e36:	c9                   	leave  
    2e37:	c3                   	ret    

00002e38 <sbrktest>:

void
sbrktest(void)
{
    2e38:	55                   	push   %ebp
    2e39:	89 e5                	mov    %esp,%ebp
    2e3b:	53                   	push   %ebx
    2e3c:	83 ec 64             	sub    $0x64,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2e3f:	a1 28 5f 00 00       	mov    0x5f28,%eax
    2e44:	83 ec 08             	sub    $0x8,%esp
    2e47:	68 83 54 00 00       	push   $0x5483
    2e4c:	50                   	push   %eax
    2e4d:	e8 99 0f 00 00       	call   3deb <printf>
    2e52:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    2e55:	83 ec 0c             	sub    $0xc,%esp
    2e58:	6a 00                	push   $0x0
    2e5a:	e8 7d 0e 00 00       	call   3cdc <sbrk>
    2e5f:	83 c4 10             	add    $0x10,%esp
    2e62:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2e65:	83 ec 0c             	sub    $0xc,%esp
    2e68:	6a 00                	push   $0x0
    2e6a:	e8 6d 0e 00 00       	call   3cdc <sbrk>
    2e6f:	83 c4 10             	add    $0x10,%esp
    2e72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){ 
    2e75:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    2e7c:	eb 4f                	jmp    2ecd <sbrktest+0x95>
    b = sbrk(1);
    2e7e:	83 ec 0c             	sub    $0xc,%esp
    2e81:	6a 01                	push   $0x1
    2e83:	e8 54 0e 00 00       	call   3cdc <sbrk>
    2e88:	83 c4 10             	add    $0x10,%esp
    2e8b:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(b != a){
    2e8e:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2e91:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2e94:	74 24                	je     2eba <sbrktest+0x82>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    2e96:	a1 28 5f 00 00       	mov    0x5f28,%eax
    2e9b:	83 ec 0c             	sub    $0xc,%esp
    2e9e:	ff 75 e8             	pushl  -0x18(%ebp)
    2ea1:	ff 75 f4             	pushl  -0xc(%ebp)
    2ea4:	ff 75 f0             	pushl  -0x10(%ebp)
    2ea7:	68 8e 54 00 00       	push   $0x548e
    2eac:	50                   	push   %eax
    2ead:	e8 39 0f 00 00       	call   3deb <printf>
    2eb2:	83 c4 20             	add    $0x20,%esp
      exit();
    2eb5:	e8 9a 0d 00 00       	call   3c54 <exit>
    }
    *b = 1;
    2eba:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2ebd:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    2ec0:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2ec3:	83 c0 01             	add    $0x1,%eax
    2ec6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){ 
    2ec9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    2ecd:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    2ed4:	7e a8                	jle    2e7e <sbrktest+0x46>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2ed6:	e8 71 0d 00 00       	call   3c4c <fork>
    2edb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    2ede:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2ee2:	79 1b                	jns    2eff <sbrktest+0xc7>
    printf(stdout, "sbrk test fork failed\n");
    2ee4:	a1 28 5f 00 00       	mov    0x5f28,%eax
    2ee9:	83 ec 08             	sub    $0x8,%esp
    2eec:	68 a9 54 00 00       	push   $0x54a9
    2ef1:	50                   	push   %eax
    2ef2:	e8 f4 0e 00 00       	call   3deb <printf>
    2ef7:	83 c4 10             	add    $0x10,%esp
    exit();
    2efa:	e8 55 0d 00 00       	call   3c54 <exit>
  }
  c = sbrk(1);
    2eff:	83 ec 0c             	sub    $0xc,%esp
    2f02:	6a 01                	push   $0x1
    2f04:	e8 d3 0d 00 00       	call   3cdc <sbrk>
    2f09:	83 c4 10             	add    $0x10,%esp
    2f0c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  c = sbrk(1);
    2f0f:	83 ec 0c             	sub    $0xc,%esp
    2f12:	6a 01                	push   $0x1
    2f14:	e8 c3 0d 00 00       	call   3cdc <sbrk>
    2f19:	83 c4 10             	add    $0x10,%esp
    2f1c:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a + 1){
    2f1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f22:	83 c0 01             	add    $0x1,%eax
    2f25:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    2f28:	74 1b                	je     2f45 <sbrktest+0x10d>
    printf(stdout, "sbrk test failed post-fork\n");
    2f2a:	a1 28 5f 00 00       	mov    0x5f28,%eax
    2f2f:	83 ec 08             	sub    $0x8,%esp
    2f32:	68 c0 54 00 00       	push   $0x54c0
    2f37:	50                   	push   %eax
    2f38:	e8 ae 0e 00 00       	call   3deb <printf>
    2f3d:	83 c4 10             	add    $0x10,%esp
    exit();
    2f40:	e8 0f 0d 00 00       	call   3c54 <exit>
  }
  if(pid == 0)
    2f45:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    2f49:	75 05                	jne    2f50 <sbrktest+0x118>
    exit();
    2f4b:	e8 04 0d 00 00       	call   3c54 <exit>
  wait();
    2f50:	e8 07 0d 00 00       	call   3c5c <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2f55:	83 ec 0c             	sub    $0xc,%esp
    2f58:	6a 00                	push   $0x0
    2f5a:	e8 7d 0d 00 00       	call   3cdc <sbrk>
    2f5f:	83 c4 10             	add    $0x10,%esp
    2f62:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    2f65:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2f68:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f6d:	29 c2                	sub    %eax,%edx
    2f6f:	89 d0                	mov    %edx,%eax
    2f71:	89 45 dc             	mov    %eax,-0x24(%ebp)
  p = sbrk(amt);
    2f74:	8b 45 dc             	mov    -0x24(%ebp),%eax
    2f77:	83 ec 0c             	sub    $0xc,%esp
    2f7a:	50                   	push   %eax
    2f7b:	e8 5c 0d 00 00       	call   3cdc <sbrk>
    2f80:	83 c4 10             	add    $0x10,%esp
    2f83:	89 45 d8             	mov    %eax,-0x28(%ebp)
  if (p != a) { 
    2f86:	8b 45 d8             	mov    -0x28(%ebp),%eax
    2f89:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    2f8c:	74 1b                	je     2fa9 <sbrktest+0x171>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    2f8e:	a1 28 5f 00 00       	mov    0x5f28,%eax
    2f93:	83 ec 08             	sub    $0x8,%esp
    2f96:	68 dc 54 00 00       	push   $0x54dc
    2f9b:	50                   	push   %eax
    2f9c:	e8 4a 0e 00 00       	call   3deb <printf>
    2fa1:	83 c4 10             	add    $0x10,%esp
    exit();
    2fa4:	e8 ab 0c 00 00       	call   3c54 <exit>
  }
  lastaddr = (char*) (BIG-1);
    2fa9:	c7 45 d4 ff ff 3f 06 	movl   $0x63fffff,-0x2c(%ebp)
  *lastaddr = 99;
    2fb0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    2fb3:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    2fb6:	83 ec 0c             	sub    $0xc,%esp
    2fb9:	6a 00                	push   $0x0
    2fbb:	e8 1c 0d 00 00       	call   3cdc <sbrk>
    2fc0:	83 c4 10             	add    $0x10,%esp
    2fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    2fc6:	83 ec 0c             	sub    $0xc,%esp
    2fc9:	68 00 f0 ff ff       	push   $0xfffff000
    2fce:	e8 09 0d 00 00       	call   3cdc <sbrk>
    2fd3:	83 c4 10             	add    $0x10,%esp
    2fd6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c == (char*)0xffffffff){
    2fd9:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    2fdd:	75 1b                	jne    2ffa <sbrktest+0x1c2>
    printf(stdout, "sbrk could not deallocate\n");
    2fdf:	a1 28 5f 00 00       	mov    0x5f28,%eax
    2fe4:	83 ec 08             	sub    $0x8,%esp
    2fe7:	68 1a 55 00 00       	push   $0x551a
    2fec:	50                   	push   %eax
    2fed:	e8 f9 0d 00 00       	call   3deb <printf>
    2ff2:	83 c4 10             	add    $0x10,%esp
    exit();
    2ff5:	e8 5a 0c 00 00       	call   3c54 <exit>
  }
  c = sbrk(0);
    2ffa:	83 ec 0c             	sub    $0xc,%esp
    2ffd:	6a 00                	push   $0x0
    2fff:	e8 d8 0c 00 00       	call   3cdc <sbrk>
    3004:	83 c4 10             	add    $0x10,%esp
    3007:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a - 4096){
    300a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    300d:	2d 00 10 00 00       	sub    $0x1000,%eax
    3012:	3b 45 e0             	cmp    -0x20(%ebp),%eax
    3015:	74 1e                	je     3035 <sbrktest+0x1fd>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3017:	a1 28 5f 00 00       	mov    0x5f28,%eax
    301c:	ff 75 e0             	pushl  -0x20(%ebp)
    301f:	ff 75 f4             	pushl  -0xc(%ebp)
    3022:	68 38 55 00 00       	push   $0x5538
    3027:	50                   	push   %eax
    3028:	e8 be 0d 00 00       	call   3deb <printf>
    302d:	83 c4 10             	add    $0x10,%esp
    exit();
    3030:	e8 1f 0c 00 00       	call   3c54 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    3035:	83 ec 0c             	sub    $0xc,%esp
    3038:	6a 00                	push   $0x0
    303a:	e8 9d 0c 00 00       	call   3cdc <sbrk>
    303f:	83 c4 10             	add    $0x10,%esp
    3042:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    3045:	83 ec 0c             	sub    $0xc,%esp
    3048:	68 00 10 00 00       	push   $0x1000
    304d:	e8 8a 0c 00 00       	call   3cdc <sbrk>
    3052:	83 c4 10             	add    $0x10,%esp
    3055:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    3058:	8b 45 e0             	mov    -0x20(%ebp),%eax
    305b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    305e:	75 1b                	jne    307b <sbrktest+0x243>
    3060:	83 ec 0c             	sub    $0xc,%esp
    3063:	6a 00                	push   $0x0
    3065:	e8 72 0c 00 00       	call   3cdc <sbrk>
    306a:	83 c4 10             	add    $0x10,%esp
    306d:	89 c2                	mov    %eax,%edx
    306f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3072:	05 00 10 00 00       	add    $0x1000,%eax
    3077:	39 c2                	cmp    %eax,%edx
    3079:	74 1e                	je     3099 <sbrktest+0x261>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    307b:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3080:	ff 75 e0             	pushl  -0x20(%ebp)
    3083:	ff 75 f4             	pushl  -0xc(%ebp)
    3086:	68 70 55 00 00       	push   $0x5570
    308b:	50                   	push   %eax
    308c:	e8 5a 0d 00 00       	call   3deb <printf>
    3091:	83 c4 10             	add    $0x10,%esp
    exit();
    3094:	e8 bb 0b 00 00       	call   3c54 <exit>
  }
  if(*lastaddr == 99){
    3099:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    309c:	0f b6 00             	movzbl (%eax),%eax
    309f:	3c 63                	cmp    $0x63,%al
    30a1:	75 1b                	jne    30be <sbrktest+0x286>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    30a3:	a1 28 5f 00 00       	mov    0x5f28,%eax
    30a8:	83 ec 08             	sub    $0x8,%esp
    30ab:	68 98 55 00 00       	push   $0x5598
    30b0:	50                   	push   %eax
    30b1:	e8 35 0d 00 00       	call   3deb <printf>
    30b6:	83 c4 10             	add    $0x10,%esp
    exit();
    30b9:	e8 96 0b 00 00       	call   3c54 <exit>
  }

  a = sbrk(0);
    30be:	83 ec 0c             	sub    $0xc,%esp
    30c1:	6a 00                	push   $0x0
    30c3:	e8 14 0c 00 00       	call   3cdc <sbrk>
    30c8:	83 c4 10             	add    $0x10,%esp
    30cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    30ce:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    30d1:	83 ec 0c             	sub    $0xc,%esp
    30d4:	6a 00                	push   $0x0
    30d6:	e8 01 0c 00 00       	call   3cdc <sbrk>
    30db:	83 c4 10             	add    $0x10,%esp
    30de:	29 c3                	sub    %eax,%ebx
    30e0:	89 d8                	mov    %ebx,%eax
    30e2:	83 ec 0c             	sub    $0xc,%esp
    30e5:	50                   	push   %eax
    30e6:	e8 f1 0b 00 00       	call   3cdc <sbrk>
    30eb:	83 c4 10             	add    $0x10,%esp
    30ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(c != a){
    30f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
    30f4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    30f7:	74 1e                	je     3117 <sbrktest+0x2df>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    30f9:	a1 28 5f 00 00       	mov    0x5f28,%eax
    30fe:	ff 75 e0             	pushl  -0x20(%ebp)
    3101:	ff 75 f4             	pushl  -0xc(%ebp)
    3104:	68 c8 55 00 00       	push   $0x55c8
    3109:	50                   	push   %eax
    310a:	e8 dc 0c 00 00       	call   3deb <printf>
    310f:	83 c4 10             	add    $0x10,%esp
    exit();
    3112:	e8 3d 0b 00 00       	call   3c54 <exit>
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3117:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    311e:	eb 76                	jmp    3196 <sbrktest+0x35e>
    ppid = getpid();
    3120:	e8 af 0b 00 00       	call   3cd4 <getpid>
    3125:	89 45 d0             	mov    %eax,-0x30(%ebp)
    pid = fork();
    3128:	e8 1f 0b 00 00       	call   3c4c <fork>
    312d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(pid < 0){
    3130:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3134:	79 1b                	jns    3151 <sbrktest+0x319>
      printf(stdout, "fork failed\n");
    3136:	a1 28 5f 00 00       	mov    0x5f28,%eax
    313b:	83 ec 08             	sub    $0x8,%esp
    313e:	68 91 45 00 00       	push   $0x4591
    3143:	50                   	push   %eax
    3144:	e8 a2 0c 00 00       	call   3deb <printf>
    3149:	83 c4 10             	add    $0x10,%esp
      exit();
    314c:	e8 03 0b 00 00       	call   3c54 <exit>
    }
    if(pid == 0){
    3151:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
    3155:	75 33                	jne    318a <sbrktest+0x352>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    3157:	8b 45 f4             	mov    -0xc(%ebp),%eax
    315a:	0f b6 00             	movzbl (%eax),%eax
    315d:	0f be d0             	movsbl %al,%edx
    3160:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3165:	52                   	push   %edx
    3166:	ff 75 f4             	pushl  -0xc(%ebp)
    3169:	68 e9 55 00 00       	push   $0x55e9
    316e:	50                   	push   %eax
    316f:	e8 77 0c 00 00       	call   3deb <printf>
    3174:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    3177:	83 ec 0c             	sub    $0xc,%esp
    317a:	ff 75 d0             	pushl  -0x30(%ebp)
    317d:	e8 02 0b 00 00       	call   3c84 <kill>
    3182:	83 c4 10             	add    $0x10,%esp
      exit();
    3185:	e8 ca 0a 00 00       	call   3c54 <exit>
    }
    wait();
    318a:	e8 cd 0a 00 00       	call   3c5c <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }
  
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    318f:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    3196:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    319d:	76 81                	jbe    3120 <sbrktest+0x2e8>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    319f:	83 ec 0c             	sub    $0xc,%esp
    31a2:	8d 45 c8             	lea    -0x38(%ebp),%eax
    31a5:	50                   	push   %eax
    31a6:	e8 b9 0a 00 00       	call   3c64 <pipe>
    31ab:	83 c4 10             	add    $0x10,%esp
    31ae:	85 c0                	test   %eax,%eax
    31b0:	74 17                	je     31c9 <sbrktest+0x391>
    printf(1, "pipe() failed\n");
    31b2:	83 ec 08             	sub    $0x8,%esp
    31b5:	68 e5 44 00 00       	push   $0x44e5
    31ba:	6a 01                	push   $0x1
    31bc:	e8 2a 0c 00 00       	call   3deb <printf>
    31c1:	83 c4 10             	add    $0x10,%esp
    exit();
    31c4:	e8 8b 0a 00 00       	call   3c54 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    31c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    31d0:	e9 88 00 00 00       	jmp    325d <sbrktest+0x425>
    if((pids[i] = fork()) == 0){
    31d5:	e8 72 0a 00 00       	call   3c4c <fork>
    31da:	89 c2                	mov    %eax,%edx
    31dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31df:	89 54 85 a0          	mov    %edx,-0x60(%ebp,%eax,4)
    31e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
    31e6:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    31ea:	85 c0                	test   %eax,%eax
    31ec:	75 4a                	jne    3238 <sbrktest+0x400>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    31ee:	83 ec 0c             	sub    $0xc,%esp
    31f1:	6a 00                	push   $0x0
    31f3:	e8 e4 0a 00 00       	call   3cdc <sbrk>
    31f8:	83 c4 10             	add    $0x10,%esp
    31fb:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3200:	29 c2                	sub    %eax,%edx
    3202:	89 d0                	mov    %edx,%eax
    3204:	83 ec 0c             	sub    $0xc,%esp
    3207:	50                   	push   %eax
    3208:	e8 cf 0a 00 00       	call   3cdc <sbrk>
    320d:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    3210:	8b 45 cc             	mov    -0x34(%ebp),%eax
    3213:	83 ec 04             	sub    $0x4,%esp
    3216:	6a 01                	push   $0x1
    3218:	68 4a 45 00 00       	push   $0x454a
    321d:	50                   	push   %eax
    321e:	e8 51 0a 00 00       	call   3c74 <write>
    3223:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    3226:	83 ec 0c             	sub    $0xc,%esp
    3229:	68 e8 03 00 00       	push   $0x3e8
    322e:	e8 b1 0a 00 00       	call   3ce4 <sleep>
    3233:	83 c4 10             	add    $0x10,%esp
    3236:	eb ee                	jmp    3226 <sbrktest+0x3ee>
    }
    if(pids[i] != -1)
    3238:	8b 45 f0             	mov    -0x10(%ebp),%eax
    323b:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    323f:	83 f8 ff             	cmp    $0xffffffff,%eax
    3242:	74 15                	je     3259 <sbrktest+0x421>
      read(fds[0], &scratch, 1);
    3244:	8b 45 c8             	mov    -0x38(%ebp),%eax
    3247:	83 ec 04             	sub    $0x4,%esp
    324a:	6a 01                	push   $0x1
    324c:	8d 55 9f             	lea    -0x61(%ebp),%edx
    324f:	52                   	push   %edx
    3250:	50                   	push   %eax
    3251:	e8 16 0a 00 00       	call   3c6c <read>
    3256:	83 c4 10             	add    $0x10,%esp
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3259:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    325d:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3260:	83 f8 09             	cmp    $0x9,%eax
    3263:	0f 86 6c ff ff ff    	jbe    31d5 <sbrktest+0x39d>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    3269:	83 ec 0c             	sub    $0xc,%esp
    326c:	68 00 10 00 00       	push   $0x1000
    3271:	e8 66 0a 00 00       	call   3cdc <sbrk>
    3276:	83 c4 10             	add    $0x10,%esp
    3279:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    327c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3283:	eb 2b                	jmp    32b0 <sbrktest+0x478>
    if(pids[i] == -1)
    3285:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3288:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    328c:	83 f8 ff             	cmp    $0xffffffff,%eax
    328f:	74 1a                	je     32ab <sbrktest+0x473>
      continue;
    kill(pids[i]);
    3291:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3294:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3298:	83 ec 0c             	sub    $0xc,%esp
    329b:	50                   	push   %eax
    329c:	e8 e3 09 00 00       	call   3c84 <kill>
    32a1:	83 c4 10             	add    $0x10,%esp
    wait();
    32a4:	e8 b3 09 00 00       	call   3c5c <wait>
    32a9:	eb 01                	jmp    32ac <sbrktest+0x474>
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
      continue;
    32ab:	90                   	nop
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    32ac:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    32b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
    32b3:	83 f8 09             	cmp    $0x9,%eax
    32b6:	76 cd                	jbe    3285 <sbrktest+0x44d>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    32b8:	83 7d e0 ff          	cmpl   $0xffffffff,-0x20(%ebp)
    32bc:	75 1b                	jne    32d9 <sbrktest+0x4a1>
    printf(stdout, "failed sbrk leaked memory\n");
    32be:	a1 28 5f 00 00       	mov    0x5f28,%eax
    32c3:	83 ec 08             	sub    $0x8,%esp
    32c6:	68 02 56 00 00       	push   $0x5602
    32cb:	50                   	push   %eax
    32cc:	e8 1a 0b 00 00       	call   3deb <printf>
    32d1:	83 c4 10             	add    $0x10,%esp
    exit();
    32d4:	e8 7b 09 00 00       	call   3c54 <exit>
  }

  if(sbrk(0) > oldbrk)
    32d9:	83 ec 0c             	sub    $0xc,%esp
    32dc:	6a 00                	push   $0x0
    32de:	e8 f9 09 00 00       	call   3cdc <sbrk>
    32e3:	83 c4 10             	add    $0x10,%esp
    32e6:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    32e9:	76 20                	jbe    330b <sbrktest+0x4d3>
    sbrk(-(sbrk(0) - oldbrk));
    32eb:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    32ee:	83 ec 0c             	sub    $0xc,%esp
    32f1:	6a 00                	push   $0x0
    32f3:	e8 e4 09 00 00       	call   3cdc <sbrk>
    32f8:	83 c4 10             	add    $0x10,%esp
    32fb:	29 c3                	sub    %eax,%ebx
    32fd:	89 d8                	mov    %ebx,%eax
    32ff:	83 ec 0c             	sub    $0xc,%esp
    3302:	50                   	push   %eax
    3303:	e8 d4 09 00 00       	call   3cdc <sbrk>
    3308:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    330b:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3310:	83 ec 08             	sub    $0x8,%esp
    3313:	68 1d 56 00 00       	push   $0x561d
    3318:	50                   	push   %eax
    3319:	e8 cd 0a 00 00       	call   3deb <printf>
    331e:	83 c4 10             	add    $0x10,%esp
}
    3321:	90                   	nop
    3322:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3325:	c9                   	leave  
    3326:	c3                   	ret    

00003327 <validateint>:

void
validateint(int *p)
{
    3327:	55                   	push   %ebp
    3328:	89 e5                	mov    %esp,%ebp
    332a:	53                   	push   %ebx
    332b:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    332e:	b8 0d 00 00 00       	mov    $0xd,%eax
    3333:	8b 55 08             	mov    0x8(%ebp),%edx
    3336:	89 d1                	mov    %edx,%ecx
    3338:	89 e3                	mov    %esp,%ebx
    333a:	89 cc                	mov    %ecx,%esp
    333c:	cd 40                	int    $0x40
    333e:	89 dc                	mov    %ebx,%esp
    3340:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3343:	90                   	nop
    3344:	83 c4 10             	add    $0x10,%esp
    3347:	5b                   	pop    %ebx
    3348:	5d                   	pop    %ebp
    3349:	c3                   	ret    

0000334a <validatetest>:

void
validatetest(void)
{
    334a:	55                   	push   %ebp
    334b:	89 e5                	mov    %esp,%ebp
    334d:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3350:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3355:	83 ec 08             	sub    $0x8,%esp
    3358:	68 2b 56 00 00       	push   $0x562b
    335d:	50                   	push   %eax
    335e:	e8 88 0a 00 00       	call   3deb <printf>
    3363:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    3366:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    336d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3374:	e9 8a 00 00 00       	jmp    3403 <validatetest+0xb9>
    if((pid = fork()) == 0){
    3379:	e8 ce 08 00 00       	call   3c4c <fork>
    337e:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3381:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3385:	75 14                	jne    339b <validatetest+0x51>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    3387:	8b 45 f4             	mov    -0xc(%ebp),%eax
    338a:	83 ec 0c             	sub    $0xc,%esp
    338d:	50                   	push   %eax
    338e:	e8 94 ff ff ff       	call   3327 <validateint>
    3393:	83 c4 10             	add    $0x10,%esp
      exit();
    3396:	e8 b9 08 00 00       	call   3c54 <exit>
    }
    sleep(0);
    339b:	83 ec 0c             	sub    $0xc,%esp
    339e:	6a 00                	push   $0x0
    33a0:	e8 3f 09 00 00       	call   3ce4 <sleep>
    33a5:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    33a8:	83 ec 0c             	sub    $0xc,%esp
    33ab:	6a 00                	push   $0x0
    33ad:	e8 32 09 00 00       	call   3ce4 <sleep>
    33b2:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    33b5:	83 ec 0c             	sub    $0xc,%esp
    33b8:	ff 75 ec             	pushl  -0x14(%ebp)
    33bb:	e8 c4 08 00 00       	call   3c84 <kill>
    33c0:	83 c4 10             	add    $0x10,%esp
    wait();
    33c3:	e8 94 08 00 00       	call   3c5c <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    33c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
    33cb:	83 ec 08             	sub    $0x8,%esp
    33ce:	50                   	push   %eax
    33cf:	68 3a 56 00 00       	push   $0x563a
    33d4:	e8 db 08 00 00       	call   3cb4 <link>
    33d9:	83 c4 10             	add    $0x10,%esp
    33dc:	83 f8 ff             	cmp    $0xffffffff,%eax
    33df:	74 1b                	je     33fc <validatetest+0xb2>
      printf(stdout, "link should not succeed\n");
    33e1:	a1 28 5f 00 00       	mov    0x5f28,%eax
    33e6:	83 ec 08             	sub    $0x8,%esp
    33e9:	68 45 56 00 00       	push   $0x5645
    33ee:	50                   	push   %eax
    33ef:	e8 f7 09 00 00       	call   3deb <printf>
    33f4:	83 c4 10             	add    $0x10,%esp
      exit();
    33f7:	e8 58 08 00 00       	call   3c54 <exit>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    33fc:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    3403:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3406:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    3409:	0f 86 6a ff ff ff    	jbe    3379 <validatetest+0x2f>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    340f:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3414:	83 ec 08             	sub    $0x8,%esp
    3417:	68 5e 56 00 00       	push   $0x565e
    341c:	50                   	push   %eax
    341d:	e8 c9 09 00 00       	call   3deb <printf>
    3422:	83 c4 10             	add    $0x10,%esp
}
    3425:	90                   	nop
    3426:	c9                   	leave  
    3427:	c3                   	ret    

00003428 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    3428:	55                   	push   %ebp
    3429:	89 e5                	mov    %esp,%ebp
    342b:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    342e:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3433:	83 ec 08             	sub    $0x8,%esp
    3436:	68 6b 56 00 00       	push   $0x566b
    343b:	50                   	push   %eax
    343c:	e8 aa 09 00 00       	call   3deb <printf>
    3441:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3444:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    344b:	eb 2e                	jmp    347b <bsstest+0x53>
    if(uninit[i] != '\0'){
    344d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3450:	05 20 60 00 00       	add    $0x6020,%eax
    3455:	0f b6 00             	movzbl (%eax),%eax
    3458:	84 c0                	test   %al,%al
    345a:	74 1b                	je     3477 <bsstest+0x4f>
      printf(stdout, "bss test failed\n");
    345c:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3461:	83 ec 08             	sub    $0x8,%esp
    3464:	68 75 56 00 00       	push   $0x5675
    3469:	50                   	push   %eax
    346a:	e8 7c 09 00 00       	call   3deb <printf>
    346f:	83 c4 10             	add    $0x10,%esp
      exit();
    3472:	e8 dd 07 00 00       	call   3c54 <exit>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    3477:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    347b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    347e:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3483:	76 c8                	jbe    344d <bsstest+0x25>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    3485:	a1 28 5f 00 00       	mov    0x5f28,%eax
    348a:	83 ec 08             	sub    $0x8,%esp
    348d:	68 86 56 00 00       	push   $0x5686
    3492:	50                   	push   %eax
    3493:	e8 53 09 00 00       	call   3deb <printf>
    3498:	83 c4 10             	add    $0x10,%esp
}
    349b:	90                   	nop
    349c:	c9                   	leave  
    349d:	c3                   	ret    

0000349e <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    349e:	55                   	push   %ebp
    349f:	89 e5                	mov    %esp,%ebp
    34a1:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    34a4:	83 ec 0c             	sub    $0xc,%esp
    34a7:	68 93 56 00 00       	push   $0x5693
    34ac:	e8 f3 07 00 00       	call   3ca4 <unlink>
    34b1:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    34b4:	e8 93 07 00 00       	call   3c4c <fork>
    34b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    34bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    34c0:	0f 85 97 00 00 00    	jne    355d <bigargtest+0xbf>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    34c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    34cd:	eb 12                	jmp    34e1 <bigargtest+0x43>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    34cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    34d2:	c7 04 85 60 5f 00 00 	movl   $0x56a0,0x5f60(,%eax,4)
    34d9:	a0 56 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    34dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    34e1:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    34e5:	7e e8                	jle    34cf <bigargtest+0x31>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    34e7:	c7 05 dc 5f 00 00 00 	movl   $0x0,0x5fdc
    34ee:	00 00 00 
    printf(stdout, "bigarg test\n");
    34f1:	a1 28 5f 00 00       	mov    0x5f28,%eax
    34f6:	83 ec 08             	sub    $0x8,%esp
    34f9:	68 7d 57 00 00       	push   $0x577d
    34fe:	50                   	push   %eax
    34ff:	e8 e7 08 00 00       	call   3deb <printf>
    3504:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    3507:	83 ec 08             	sub    $0x8,%esp
    350a:	68 60 5f 00 00       	push   $0x5f60
    350f:	68 a4 41 00 00       	push   $0x41a4
    3514:	e8 73 07 00 00       	call   3c8c <exec>
    3519:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    351c:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3521:	83 ec 08             	sub    $0x8,%esp
    3524:	68 8a 57 00 00       	push   $0x578a
    3529:	50                   	push   %eax
    352a:	e8 bc 08 00 00       	call   3deb <printf>
    352f:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    3532:	83 ec 08             	sub    $0x8,%esp
    3535:	68 00 02 00 00       	push   $0x200
    353a:	68 93 56 00 00       	push   $0x5693
    353f:	e8 50 07 00 00       	call   3c94 <open>
    3544:	83 c4 10             	add    $0x10,%esp
    3547:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    354a:	83 ec 0c             	sub    $0xc,%esp
    354d:	ff 75 ec             	pushl  -0x14(%ebp)
    3550:	e8 27 07 00 00       	call   3c7c <close>
    3555:	83 c4 10             	add    $0x10,%esp
    exit();
    3558:	e8 f7 06 00 00       	call   3c54 <exit>
  } else if(pid < 0){
    355d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3561:	79 1b                	jns    357e <bigargtest+0xe0>
    printf(stdout, "bigargtest: fork failed\n");
    3563:	a1 28 5f 00 00       	mov    0x5f28,%eax
    3568:	83 ec 08             	sub    $0x8,%esp
    356b:	68 9a 57 00 00       	push   $0x579a
    3570:	50                   	push   %eax
    3571:	e8 75 08 00 00       	call   3deb <printf>
    3576:	83 c4 10             	add    $0x10,%esp
    exit();
    3579:	e8 d6 06 00 00       	call   3c54 <exit>
  }
  wait();
    357e:	e8 d9 06 00 00       	call   3c5c <wait>
  fd = open("bigarg-ok", 0);
    3583:	83 ec 08             	sub    $0x8,%esp
    3586:	6a 00                	push   $0x0
    3588:	68 93 56 00 00       	push   $0x5693
    358d:	e8 02 07 00 00       	call   3c94 <open>
    3592:	83 c4 10             	add    $0x10,%esp
    3595:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3598:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    359c:	79 1b                	jns    35b9 <bigargtest+0x11b>
    printf(stdout, "bigarg test failed!\n");
    359e:	a1 28 5f 00 00       	mov    0x5f28,%eax
    35a3:	83 ec 08             	sub    $0x8,%esp
    35a6:	68 b3 57 00 00       	push   $0x57b3
    35ab:	50                   	push   %eax
    35ac:	e8 3a 08 00 00       	call   3deb <printf>
    35b1:	83 c4 10             	add    $0x10,%esp
    exit();
    35b4:	e8 9b 06 00 00       	call   3c54 <exit>
  }
  close(fd);
    35b9:	83 ec 0c             	sub    $0xc,%esp
    35bc:	ff 75 ec             	pushl  -0x14(%ebp)
    35bf:	e8 b8 06 00 00       	call   3c7c <close>
    35c4:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    35c7:	83 ec 0c             	sub    $0xc,%esp
    35ca:	68 93 56 00 00       	push   $0x5693
    35cf:	e8 d0 06 00 00       	call   3ca4 <unlink>
    35d4:	83 c4 10             	add    $0x10,%esp
}
    35d7:	90                   	nop
    35d8:	c9                   	leave  
    35d9:	c3                   	ret    

000035da <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    35da:	55                   	push   %ebp
    35db:	89 e5                	mov    %esp,%ebp
    35dd:	53                   	push   %ebx
    35de:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    35e1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    35e8:	83 ec 08             	sub    $0x8,%esp
    35eb:	68 c8 57 00 00       	push   $0x57c8
    35f0:	6a 01                	push   $0x1
    35f2:	e8 f4 07 00 00       	call   3deb <printf>
    35f7:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    35fa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    3601:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3605:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3608:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    360d:	89 c8                	mov    %ecx,%eax
    360f:	f7 ea                	imul   %edx
    3611:	c1 fa 06             	sar    $0x6,%edx
    3614:	89 c8                	mov    %ecx,%eax
    3616:	c1 f8 1f             	sar    $0x1f,%eax
    3619:	29 c2                	sub    %eax,%edx
    361b:	89 d0                	mov    %edx,%eax
    361d:	83 c0 30             	add    $0x30,%eax
    3620:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3623:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3626:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    362b:	89 d8                	mov    %ebx,%eax
    362d:	f7 ea                	imul   %edx
    362f:	c1 fa 06             	sar    $0x6,%edx
    3632:	89 d8                	mov    %ebx,%eax
    3634:	c1 f8 1f             	sar    $0x1f,%eax
    3637:	89 d1                	mov    %edx,%ecx
    3639:	29 c1                	sub    %eax,%ecx
    363b:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3641:	29 c3                	sub    %eax,%ebx
    3643:	89 d9                	mov    %ebx,%ecx
    3645:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    364a:	89 c8                	mov    %ecx,%eax
    364c:	f7 ea                	imul   %edx
    364e:	c1 fa 05             	sar    $0x5,%edx
    3651:	89 c8                	mov    %ecx,%eax
    3653:	c1 f8 1f             	sar    $0x1f,%eax
    3656:	29 c2                	sub    %eax,%edx
    3658:	89 d0                	mov    %edx,%eax
    365a:	83 c0 30             	add    $0x30,%eax
    365d:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3660:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3663:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3668:	89 d8                	mov    %ebx,%eax
    366a:	f7 ea                	imul   %edx
    366c:	c1 fa 05             	sar    $0x5,%edx
    366f:	89 d8                	mov    %ebx,%eax
    3671:	c1 f8 1f             	sar    $0x1f,%eax
    3674:	89 d1                	mov    %edx,%ecx
    3676:	29 c1                	sub    %eax,%ecx
    3678:	6b c1 64             	imul   $0x64,%ecx,%eax
    367b:	29 c3                	sub    %eax,%ebx
    367d:	89 d9                	mov    %ebx,%ecx
    367f:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3684:	89 c8                	mov    %ecx,%eax
    3686:	f7 ea                	imul   %edx
    3688:	c1 fa 02             	sar    $0x2,%edx
    368b:	89 c8                	mov    %ecx,%eax
    368d:	c1 f8 1f             	sar    $0x1f,%eax
    3690:	29 c2                	sub    %eax,%edx
    3692:	89 d0                	mov    %edx,%eax
    3694:	83 c0 30             	add    $0x30,%eax
    3697:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    369a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    369d:	ba 67 66 66 66       	mov    $0x66666667,%edx
    36a2:	89 c8                	mov    %ecx,%eax
    36a4:	f7 ea                	imul   %edx
    36a6:	c1 fa 02             	sar    $0x2,%edx
    36a9:	89 c8                	mov    %ecx,%eax
    36ab:	c1 f8 1f             	sar    $0x1f,%eax
    36ae:	29 c2                	sub    %eax,%edx
    36b0:	89 d0                	mov    %edx,%eax
    36b2:	c1 e0 02             	shl    $0x2,%eax
    36b5:	01 d0                	add    %edx,%eax
    36b7:	01 c0                	add    %eax,%eax
    36b9:	29 c1                	sub    %eax,%ecx
    36bb:	89 ca                	mov    %ecx,%edx
    36bd:	89 d0                	mov    %edx,%eax
    36bf:	83 c0 30             	add    $0x30,%eax
    36c2:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    36c5:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    36c9:	83 ec 04             	sub    $0x4,%esp
    36cc:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36cf:	50                   	push   %eax
    36d0:	68 d5 57 00 00       	push   $0x57d5
    36d5:	6a 01                	push   $0x1
    36d7:	e8 0f 07 00 00       	call   3deb <printf>
    36dc:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    36df:	83 ec 08             	sub    $0x8,%esp
    36e2:	68 02 02 00 00       	push   $0x202
    36e7:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    36ea:	50                   	push   %eax
    36eb:	e8 a4 05 00 00       	call   3c94 <open>
    36f0:	83 c4 10             	add    $0x10,%esp
    36f3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    36f6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    36fa:	79 18                	jns    3714 <fsfull+0x13a>
      printf(1, "open %s failed\n", name);
    36fc:	83 ec 04             	sub    $0x4,%esp
    36ff:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3702:	50                   	push   %eax
    3703:	68 e1 57 00 00       	push   $0x57e1
    3708:	6a 01                	push   $0x1
    370a:	e8 dc 06 00 00       	call   3deb <printf>
    370f:	83 c4 10             	add    $0x10,%esp
      break;
    3712:	eb 6b                	jmp    377f <fsfull+0x1a5>
    }
    int total = 0;
    3714:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    371b:	83 ec 04             	sub    $0x4,%esp
    371e:	68 00 02 00 00       	push   $0x200
    3723:	68 40 87 00 00       	push   $0x8740
    3728:	ff 75 e8             	pushl  -0x18(%ebp)
    372b:	e8 44 05 00 00       	call   3c74 <write>
    3730:	83 c4 10             	add    $0x10,%esp
    3733:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    3736:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    373d:	7e 0c                	jle    374b <fsfull+0x171>
        break;
      total += cc;
    373f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3742:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    3745:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    }
    3749:	eb d0                	jmp    371b <fsfull+0x141>
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
    374b:	90                   	nop
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    374c:	83 ec 04             	sub    $0x4,%esp
    374f:	ff 75 ec             	pushl  -0x14(%ebp)
    3752:	68 f1 57 00 00       	push   $0x57f1
    3757:	6a 01                	push   $0x1
    3759:	e8 8d 06 00 00       	call   3deb <printf>
    375e:	83 c4 10             	add    $0x10,%esp
    close(fd);
    3761:	83 ec 0c             	sub    $0xc,%esp
    3764:	ff 75 e8             	pushl  -0x18(%ebp)
    3767:	e8 10 05 00 00       	call   3c7c <close>
    376c:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    376f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3773:	74 09                	je     377e <fsfull+0x1a4>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    3775:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    3779:	e9 83 fe ff ff       	jmp    3601 <fsfull+0x27>
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
    377e:	90                   	nop
  }

  while(nfiles >= 0){
    377f:	e9 db 00 00 00       	jmp    385f <fsfull+0x285>
    char name[64];
    name[0] = 'f';
    3784:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3788:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    378b:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3790:	89 c8                	mov    %ecx,%eax
    3792:	f7 ea                	imul   %edx
    3794:	c1 fa 06             	sar    $0x6,%edx
    3797:	89 c8                	mov    %ecx,%eax
    3799:	c1 f8 1f             	sar    $0x1f,%eax
    379c:	29 c2                	sub    %eax,%edx
    379e:	89 d0                	mov    %edx,%eax
    37a0:	83 c0 30             	add    $0x30,%eax
    37a3:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    37a6:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    37a9:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    37ae:	89 d8                	mov    %ebx,%eax
    37b0:	f7 ea                	imul   %edx
    37b2:	c1 fa 06             	sar    $0x6,%edx
    37b5:	89 d8                	mov    %ebx,%eax
    37b7:	c1 f8 1f             	sar    $0x1f,%eax
    37ba:	89 d1                	mov    %edx,%ecx
    37bc:	29 c1                	sub    %eax,%ecx
    37be:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    37c4:	29 c3                	sub    %eax,%ebx
    37c6:	89 d9                	mov    %ebx,%ecx
    37c8:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    37cd:	89 c8                	mov    %ecx,%eax
    37cf:	f7 ea                	imul   %edx
    37d1:	c1 fa 05             	sar    $0x5,%edx
    37d4:	89 c8                	mov    %ecx,%eax
    37d6:	c1 f8 1f             	sar    $0x1f,%eax
    37d9:	29 c2                	sub    %eax,%edx
    37db:	89 d0                	mov    %edx,%eax
    37dd:	83 c0 30             	add    $0x30,%eax
    37e0:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    37e3:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    37e6:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    37eb:	89 d8                	mov    %ebx,%eax
    37ed:	f7 ea                	imul   %edx
    37ef:	c1 fa 05             	sar    $0x5,%edx
    37f2:	89 d8                	mov    %ebx,%eax
    37f4:	c1 f8 1f             	sar    $0x1f,%eax
    37f7:	89 d1                	mov    %edx,%ecx
    37f9:	29 c1                	sub    %eax,%ecx
    37fb:	6b c1 64             	imul   $0x64,%ecx,%eax
    37fe:	29 c3                	sub    %eax,%ebx
    3800:	89 d9                	mov    %ebx,%ecx
    3802:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3807:	89 c8                	mov    %ecx,%eax
    3809:	f7 ea                	imul   %edx
    380b:	c1 fa 02             	sar    $0x2,%edx
    380e:	89 c8                	mov    %ecx,%eax
    3810:	c1 f8 1f             	sar    $0x1f,%eax
    3813:	29 c2                	sub    %eax,%edx
    3815:	89 d0                	mov    %edx,%eax
    3817:	83 c0 30             	add    $0x30,%eax
    381a:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    381d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3820:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3825:	89 c8                	mov    %ecx,%eax
    3827:	f7 ea                	imul   %edx
    3829:	c1 fa 02             	sar    $0x2,%edx
    382c:	89 c8                	mov    %ecx,%eax
    382e:	c1 f8 1f             	sar    $0x1f,%eax
    3831:	29 c2                	sub    %eax,%edx
    3833:	89 d0                	mov    %edx,%eax
    3835:	c1 e0 02             	shl    $0x2,%eax
    3838:	01 d0                	add    %edx,%eax
    383a:	01 c0                	add    %eax,%eax
    383c:	29 c1                	sub    %eax,%ecx
    383e:	89 ca                	mov    %ecx,%edx
    3840:	89 d0                	mov    %edx,%eax
    3842:	83 c0 30             	add    $0x30,%eax
    3845:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3848:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    384c:	83 ec 0c             	sub    $0xc,%esp
    384f:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3852:	50                   	push   %eax
    3853:	e8 4c 04 00 00       	call   3ca4 <unlink>
    3858:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    385b:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    385f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3863:	0f 89 1b ff ff ff    	jns    3784 <fsfull+0x1aa>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    3869:	83 ec 08             	sub    $0x8,%esp
    386c:	68 01 58 00 00       	push   $0x5801
    3871:	6a 01                	push   $0x1
    3873:	e8 73 05 00 00       	call   3deb <printf>
    3878:	83 c4 10             	add    $0x10,%esp
}
    387b:	90                   	nop
    387c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    387f:	c9                   	leave  
    3880:	c3                   	ret    

00003881 <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3881:	55                   	push   %ebp
    3882:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3884:	a1 2c 5f 00 00       	mov    0x5f2c,%eax
    3889:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    388f:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3894:	a3 2c 5f 00 00       	mov    %eax,0x5f2c
  return randstate;
    3899:	a1 2c 5f 00 00       	mov    0x5f2c,%eax
}
    389e:	5d                   	pop    %ebp
    389f:	c3                   	ret    

000038a0 <main>:

int
main(int argc, char *argv[])
{
    38a0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    38a4:	83 e4 f0             	and    $0xfffffff0,%esp
    38a7:	ff 71 fc             	pushl  -0x4(%ecx)
    38aa:	55                   	push   %ebp
    38ab:	89 e5                	mov    %esp,%ebp
    38ad:	51                   	push   %ecx
    38ae:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    38b1:	83 ec 08             	sub    $0x8,%esp
    38b4:	68 17 58 00 00       	push   $0x5817
    38b9:	6a 01                	push   $0x1
    38bb:	e8 2b 05 00 00       	call   3deb <printf>
    38c0:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    38c3:	83 ec 08             	sub    $0x8,%esp
    38c6:	6a 00                	push   $0x0
    38c8:	68 2b 58 00 00       	push   $0x582b
    38cd:	e8 c2 03 00 00       	call   3c94 <open>
    38d2:	83 c4 10             	add    $0x10,%esp
    38d5:	85 c0                	test   %eax,%eax
    38d7:	78 17                	js     38f0 <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    38d9:	83 ec 08             	sub    $0x8,%esp
    38dc:	68 3c 58 00 00       	push   $0x583c
    38e1:	6a 01                	push   $0x1
    38e3:	e8 03 05 00 00       	call   3deb <printf>
    38e8:	83 c4 10             	add    $0x10,%esp
    exit();
    38eb:	e8 64 03 00 00       	call   3c54 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    38f0:	83 ec 08             	sub    $0x8,%esp
    38f3:	68 00 02 00 00       	push   $0x200
    38f8:	68 2b 58 00 00       	push   $0x582b
    38fd:	e8 92 03 00 00       	call   3c94 <open>
    3902:	83 c4 10             	add    $0x10,%esp
    3905:	83 ec 0c             	sub    $0xc,%esp
    3908:	50                   	push   %eax
    3909:	e8 6e 03 00 00       	call   3c7c <close>
    390e:	83 c4 10             	add    $0x10,%esp

  bigargtest();
    3911:	e8 88 fb ff ff       	call   349e <bigargtest>
  bigwrite();
    3916:	e8 ea ea ff ff       	call   2405 <bigwrite>
  bigargtest();
    391b:	e8 7e fb ff ff       	call   349e <bigargtest>
  bsstest();
    3920:	e8 03 fb ff ff       	call   3428 <bsstest>
  sbrktest();
    3925:	e8 0e f5 ff ff       	call   2e38 <sbrktest>
  validatetest();
    392a:	e8 1b fa ff ff       	call   334a <validatetest>

  opentest();
    392f:	e8 cc c6 ff ff       	call   0 <opentest>
  writetest();
    3934:	e8 76 c7 ff ff       	call   af <writetest>
  writetest1();
    3939:	e8 81 c9 ff ff       	call   2bf <writetest1>
  createtest();
    393e:	e8 78 cb ff ff       	call   4bb <createtest>

  mem();
    3943:	e8 3e d1 ff ff       	call   a86 <mem>
  pipe1();
    3948:	e8 75 cd ff ff       	call   6c2 <pipe1>
  preempt();
    394d:	e8 59 cf ff ff       	call   8ab <preempt>
  exitwait();
    3952:	e8 b7 d0 ff ff       	call   a0e <exitwait>

  rmdot();
    3957:	e8 1b ef ff ff       	call   2877 <rmdot>
  fourteen();
    395c:	e8 ba ed ff ff       	call   271b <fourteen>
  bigfile();
    3961:	e8 9d eb ff ff       	call   2503 <bigfile>
  subdir();
    3966:	e8 56 e3 ff ff       	call   1cc1 <subdir>
  concreate();
    396b:	e8 f3 dc ff ff       	call   1663 <concreate>
  linkunlink();
    3970:	e8 9e e0 ff ff       	call   1a13 <linkunlink>
  linktest();
    3975:	e8 a7 da ff ff       	call   1421 <linktest>
  unlinkread();
    397a:	e8 e0 d8 ff ff       	call   125f <unlinkread>
  createdelete();
    397f:	e8 35 d6 ff ff       	call   fb9 <createdelete>
  twofiles();
    3984:	e8 d1 d3 ff ff       	call   d5a <twofiles>
  sharedfd();
    3989:	e8 e9 d1 ff ff       	call   b77 <sharedfd>
  dirfile();
    398e:	e8 69 f0 ff ff       	call   29fc <dirfile>
  iref();
    3993:	e8 9c f2 ff ff       	call   2c34 <iref>
  forktest();
    3998:	e8 d1 f3 ff ff       	call   2d6e <forktest>
  bigdir(); // slow
    399d:	e8 aa e1 ff ff       	call   1b4c <bigdir>

  exectest();
    39a2:	e8 c8 cc ff ff       	call   66f <exectest>

  exit();
    39a7:	e8 a8 02 00 00       	call   3c54 <exit>

000039ac <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    39ac:	55                   	push   %ebp
    39ad:	89 e5                	mov    %esp,%ebp
    39af:	57                   	push   %edi
    39b0:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    39b1:	8b 4d 08             	mov    0x8(%ebp),%ecx
    39b4:	8b 55 10             	mov    0x10(%ebp),%edx
    39b7:	8b 45 0c             	mov    0xc(%ebp),%eax
    39ba:	89 cb                	mov    %ecx,%ebx
    39bc:	89 df                	mov    %ebx,%edi
    39be:	89 d1                	mov    %edx,%ecx
    39c0:	fc                   	cld    
    39c1:	f3 aa                	rep stos %al,%es:(%edi)
    39c3:	89 ca                	mov    %ecx,%edx
    39c5:	89 fb                	mov    %edi,%ebx
    39c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
    39ca:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    39cd:	90                   	nop
    39ce:	5b                   	pop    %ebx
    39cf:	5f                   	pop    %edi
    39d0:	5d                   	pop    %ebp
    39d1:	c3                   	ret    

000039d2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    39d2:	55                   	push   %ebp
    39d3:	89 e5                	mov    %esp,%ebp
    39d5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    39d8:	8b 45 08             	mov    0x8(%ebp),%eax
    39db:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    39de:	90                   	nop
    39df:	8b 45 08             	mov    0x8(%ebp),%eax
    39e2:	8d 50 01             	lea    0x1(%eax),%edx
    39e5:	89 55 08             	mov    %edx,0x8(%ebp)
    39e8:	8b 55 0c             	mov    0xc(%ebp),%edx
    39eb:	8d 4a 01             	lea    0x1(%edx),%ecx
    39ee:	89 4d 0c             	mov    %ecx,0xc(%ebp)
    39f1:	0f b6 12             	movzbl (%edx),%edx
    39f4:	88 10                	mov    %dl,(%eax)
    39f6:	0f b6 00             	movzbl (%eax),%eax
    39f9:	84 c0                	test   %al,%al
    39fb:	75 e2                	jne    39df <strcpy+0xd>
    ;
  return os;
    39fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3a00:	c9                   	leave  
    3a01:	c3                   	ret    

00003a02 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3a02:	55                   	push   %ebp
    3a03:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3a05:	eb 08                	jmp    3a0f <strcmp+0xd>
    p++, q++;
    3a07:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3a0b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    3a0f:	8b 45 08             	mov    0x8(%ebp),%eax
    3a12:	0f b6 00             	movzbl (%eax),%eax
    3a15:	84 c0                	test   %al,%al
    3a17:	74 10                	je     3a29 <strcmp+0x27>
    3a19:	8b 45 08             	mov    0x8(%ebp),%eax
    3a1c:	0f b6 10             	movzbl (%eax),%edx
    3a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a22:	0f b6 00             	movzbl (%eax),%eax
    3a25:	38 c2                	cmp    %al,%dl
    3a27:	74 de                	je     3a07 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
    3a29:	8b 45 08             	mov    0x8(%ebp),%eax
    3a2c:	0f b6 00             	movzbl (%eax),%eax
    3a2f:	0f b6 d0             	movzbl %al,%edx
    3a32:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a35:	0f b6 00             	movzbl (%eax),%eax
    3a38:	0f b6 c0             	movzbl %al,%eax
    3a3b:	29 c2                	sub    %eax,%edx
    3a3d:	89 d0                	mov    %edx,%eax
}
    3a3f:	5d                   	pop    %ebp
    3a40:	c3                   	ret    

00003a41 <strlen>:

uint
strlen(char *s)
{
    3a41:	55                   	push   %ebp
    3a42:	89 e5                	mov    %esp,%ebp
    3a44:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3a47:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3a4e:	eb 04                	jmp    3a54 <strlen+0x13>
    3a50:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3a54:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3a57:	8b 45 08             	mov    0x8(%ebp),%eax
    3a5a:	01 d0                	add    %edx,%eax
    3a5c:	0f b6 00             	movzbl (%eax),%eax
    3a5f:	84 c0                	test   %al,%al
    3a61:	75 ed                	jne    3a50 <strlen+0xf>
    ;
  return n;
    3a63:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3a66:	c9                   	leave  
    3a67:	c3                   	ret    

00003a68 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3a68:	55                   	push   %ebp
    3a69:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3a6b:	8b 45 10             	mov    0x10(%ebp),%eax
    3a6e:	50                   	push   %eax
    3a6f:	ff 75 0c             	pushl  0xc(%ebp)
    3a72:	ff 75 08             	pushl  0x8(%ebp)
    3a75:	e8 32 ff ff ff       	call   39ac <stosb>
    3a7a:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3a7d:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3a80:	c9                   	leave  
    3a81:	c3                   	ret    

00003a82 <strchr>:

char*
strchr(const char *s, char c)
{
    3a82:	55                   	push   %ebp
    3a83:	89 e5                	mov    %esp,%ebp
    3a85:	83 ec 04             	sub    $0x4,%esp
    3a88:	8b 45 0c             	mov    0xc(%ebp),%eax
    3a8b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3a8e:	eb 14                	jmp    3aa4 <strchr+0x22>
    if(*s == c)
    3a90:	8b 45 08             	mov    0x8(%ebp),%eax
    3a93:	0f b6 00             	movzbl (%eax),%eax
    3a96:	3a 45 fc             	cmp    -0x4(%ebp),%al
    3a99:	75 05                	jne    3aa0 <strchr+0x1e>
      return (char*)s;
    3a9b:	8b 45 08             	mov    0x8(%ebp),%eax
    3a9e:	eb 13                	jmp    3ab3 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    3aa0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3aa4:	8b 45 08             	mov    0x8(%ebp),%eax
    3aa7:	0f b6 00             	movzbl (%eax),%eax
    3aaa:	84 c0                	test   %al,%al
    3aac:	75 e2                	jne    3a90 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
    3aae:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3ab3:	c9                   	leave  
    3ab4:	c3                   	ret    

00003ab5 <gets>:

char*
gets(char *buf, int max)
{
    3ab5:	55                   	push   %ebp
    3ab6:	89 e5                	mov    %esp,%ebp
    3ab8:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3abb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3ac2:	eb 42                	jmp    3b06 <gets+0x51>
    cc = read(0, &c, 1);
    3ac4:	83 ec 04             	sub    $0x4,%esp
    3ac7:	6a 01                	push   $0x1
    3ac9:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3acc:	50                   	push   %eax
    3acd:	6a 00                	push   $0x0
    3acf:	e8 98 01 00 00       	call   3c6c <read>
    3ad4:	83 c4 10             	add    $0x10,%esp
    3ad7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3ada:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3ade:	7e 33                	jle    3b13 <gets+0x5e>
      break;
    buf[i++] = c;
    3ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ae3:	8d 50 01             	lea    0x1(%eax),%edx
    3ae6:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3ae9:	89 c2                	mov    %eax,%edx
    3aeb:	8b 45 08             	mov    0x8(%ebp),%eax
    3aee:	01 c2                	add    %eax,%edx
    3af0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3af4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3af6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3afa:	3c 0a                	cmp    $0xa,%al
    3afc:	74 16                	je     3b14 <gets+0x5f>
    3afe:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3b02:	3c 0d                	cmp    $0xd,%al
    3b04:	74 0e                	je     3b14 <gets+0x5f>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3b09:	83 c0 01             	add    $0x1,%eax
    3b0c:	3b 45 0c             	cmp    0xc(%ebp),%eax
    3b0f:	7c b3                	jl     3ac4 <gets+0xf>
    3b11:	eb 01                	jmp    3b14 <gets+0x5f>
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    3b13:	90                   	nop
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3b14:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3b17:	8b 45 08             	mov    0x8(%ebp),%eax
    3b1a:	01 d0                	add    %edx,%eax
    3b1c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3b1f:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3b22:	c9                   	leave  
    3b23:	c3                   	ret    

00003b24 <stat>:

int
stat(char *n, struct stat *st)
{
    3b24:	55                   	push   %ebp
    3b25:	89 e5                	mov    %esp,%ebp
    3b27:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3b2a:	83 ec 08             	sub    $0x8,%esp
    3b2d:	6a 00                	push   $0x0
    3b2f:	ff 75 08             	pushl  0x8(%ebp)
    3b32:	e8 5d 01 00 00       	call   3c94 <open>
    3b37:	83 c4 10             	add    $0x10,%esp
    3b3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3b3d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b41:	79 07                	jns    3b4a <stat+0x26>
    return -1;
    3b43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3b48:	eb 25                	jmp    3b6f <stat+0x4b>
  r = fstat(fd, st);
    3b4a:	83 ec 08             	sub    $0x8,%esp
    3b4d:	ff 75 0c             	pushl  0xc(%ebp)
    3b50:	ff 75 f4             	pushl  -0xc(%ebp)
    3b53:	e8 54 01 00 00       	call   3cac <fstat>
    3b58:	83 c4 10             	add    $0x10,%esp
    3b5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3b5e:	83 ec 0c             	sub    $0xc,%esp
    3b61:	ff 75 f4             	pushl  -0xc(%ebp)
    3b64:	e8 13 01 00 00       	call   3c7c <close>
    3b69:	83 c4 10             	add    $0x10,%esp
  return r;
    3b6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3b6f:	c9                   	leave  
    3b70:	c3                   	ret    

00003b71 <atoi>:

int
atoi(const char *s)
{
    3b71:	55                   	push   %ebp
    3b72:	89 e5                	mov    %esp,%ebp
    3b74:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3b77:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3b7e:	eb 25                	jmp    3ba5 <atoi+0x34>
    n = n*10 + *s++ - '0';
    3b80:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3b83:	89 d0                	mov    %edx,%eax
    3b85:	c1 e0 02             	shl    $0x2,%eax
    3b88:	01 d0                	add    %edx,%eax
    3b8a:	01 c0                	add    %eax,%eax
    3b8c:	89 c1                	mov    %eax,%ecx
    3b8e:	8b 45 08             	mov    0x8(%ebp),%eax
    3b91:	8d 50 01             	lea    0x1(%eax),%edx
    3b94:	89 55 08             	mov    %edx,0x8(%ebp)
    3b97:	0f b6 00             	movzbl (%eax),%eax
    3b9a:	0f be c0             	movsbl %al,%eax
    3b9d:	01 c8                	add    %ecx,%eax
    3b9f:	83 e8 30             	sub    $0x30,%eax
    3ba2:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3ba5:	8b 45 08             	mov    0x8(%ebp),%eax
    3ba8:	0f b6 00             	movzbl (%eax),%eax
    3bab:	3c 2f                	cmp    $0x2f,%al
    3bad:	7e 0a                	jle    3bb9 <atoi+0x48>
    3baf:	8b 45 08             	mov    0x8(%ebp),%eax
    3bb2:	0f b6 00             	movzbl (%eax),%eax
    3bb5:	3c 39                	cmp    $0x39,%al
    3bb7:	7e c7                	jle    3b80 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
    3bb9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3bbc:	c9                   	leave  
    3bbd:	c3                   	ret    

00003bbe <itoa>:

char*
itoa(int val, int base){
    3bbe:	55                   	push   %ebp
    3bbf:	89 e5                	mov    %esp,%ebp
    3bc1:	83 ec 10             	sub    $0x10,%esp

    static char buf[32] = {0};

    int i = 30;
    3bc4:	c7 45 fc 1e 00 00 00 	movl   $0x1e,-0x4(%ebp)

    for(; val && i ; --i, val /= base)
    3bcb:	eb 29                	jmp    3bf6 <itoa+0x38>

        buf[i] = "0123456789abcdef"[val % base];
    3bcd:	8b 45 08             	mov    0x8(%ebp),%eax
    3bd0:	99                   	cltd   
    3bd1:	f7 7d 0c             	idivl  0xc(%ebp)
    3bd4:	89 d0                	mov    %edx,%eax
    3bd6:	0f b6 80 66 58 00 00 	movzbl 0x5866(%eax),%eax
    3bdd:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3be0:	81 c2 e0 5f 00 00    	add    $0x5fe0,%edx
    3be6:	88 02                	mov    %al,(%edx)

    static char buf[32] = {0};

    int i = 30;

    for(; val && i ; --i, val /= base)
    3be8:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
    3bec:	8b 45 08             	mov    0x8(%ebp),%eax
    3bef:	99                   	cltd   
    3bf0:	f7 7d 0c             	idivl  0xc(%ebp)
    3bf3:	89 45 08             	mov    %eax,0x8(%ebp)
    3bf6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
    3bfa:	74 06                	je     3c02 <itoa+0x44>
    3bfc:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
    3c00:	75 cb                	jne    3bcd <itoa+0xf>

        buf[i] = "0123456789abcdef"[val % base];

    return &buf[i+1];
    3c02:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3c05:	83 c0 01             	add    $0x1,%eax
    3c08:	05 e0 5f 00 00       	add    $0x5fe0,%eax

}
    3c0d:	c9                   	leave  
    3c0e:	c3                   	ret    

00003c0f <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3c0f:	55                   	push   %ebp
    3c10:	89 e5                	mov    %esp,%ebp
    3c12:	83 ec 10             	sub    $0x10,%esp
  char *dst, *src;

  dst = vdst;
    3c15:	8b 45 08             	mov    0x8(%ebp),%eax
    3c18:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3c1b:	8b 45 0c             	mov    0xc(%ebp),%eax
    3c1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3c21:	eb 17                	jmp    3c3a <memmove+0x2b>
    *dst++ = *src++;
    3c23:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3c26:	8d 50 01             	lea    0x1(%eax),%edx
    3c29:	89 55 fc             	mov    %edx,-0x4(%ebp)
    3c2c:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3c2f:	8d 4a 01             	lea    0x1(%edx),%ecx
    3c32:	89 4d f8             	mov    %ecx,-0x8(%ebp)
    3c35:	0f b6 12             	movzbl (%edx),%edx
    3c38:	88 10                	mov    %dl,(%eax)
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3c3a:	8b 45 10             	mov    0x10(%ebp),%eax
    3c3d:	8d 50 ff             	lea    -0x1(%eax),%edx
    3c40:	89 55 10             	mov    %edx,0x10(%ebp)
    3c43:	85 c0                	test   %eax,%eax
    3c45:	7f dc                	jg     3c23 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
    3c47:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3c4a:	c9                   	leave  
    3c4b:	c3                   	ret    

00003c4c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3c4c:	b8 01 00 00 00       	mov    $0x1,%eax
    3c51:	cd 40                	int    $0x40
    3c53:	c3                   	ret    

00003c54 <exit>:
SYSCALL(exit)
    3c54:	b8 02 00 00 00       	mov    $0x2,%eax
    3c59:	cd 40                	int    $0x40
    3c5b:	c3                   	ret    

00003c5c <wait>:
SYSCALL(wait)
    3c5c:	b8 03 00 00 00       	mov    $0x3,%eax
    3c61:	cd 40                	int    $0x40
    3c63:	c3                   	ret    

00003c64 <pipe>:
SYSCALL(pipe)
    3c64:	b8 04 00 00 00       	mov    $0x4,%eax
    3c69:	cd 40                	int    $0x40
    3c6b:	c3                   	ret    

00003c6c <read>:
SYSCALL(read)
    3c6c:	b8 05 00 00 00       	mov    $0x5,%eax
    3c71:	cd 40                	int    $0x40
    3c73:	c3                   	ret    

00003c74 <write>:
SYSCALL(write)
    3c74:	b8 10 00 00 00       	mov    $0x10,%eax
    3c79:	cd 40                	int    $0x40
    3c7b:	c3                   	ret    

00003c7c <close>:
SYSCALL(close)
    3c7c:	b8 15 00 00 00       	mov    $0x15,%eax
    3c81:	cd 40                	int    $0x40
    3c83:	c3                   	ret    

00003c84 <kill>:
SYSCALL(kill)
    3c84:	b8 06 00 00 00       	mov    $0x6,%eax
    3c89:	cd 40                	int    $0x40
    3c8b:	c3                   	ret    

00003c8c <exec>:
SYSCALL(exec)
    3c8c:	b8 07 00 00 00       	mov    $0x7,%eax
    3c91:	cd 40                	int    $0x40
    3c93:	c3                   	ret    

00003c94 <open>:
SYSCALL(open)
    3c94:	b8 0f 00 00 00       	mov    $0xf,%eax
    3c99:	cd 40                	int    $0x40
    3c9b:	c3                   	ret    

00003c9c <mknod>:
SYSCALL(mknod)
    3c9c:	b8 11 00 00 00       	mov    $0x11,%eax
    3ca1:	cd 40                	int    $0x40
    3ca3:	c3                   	ret    

00003ca4 <unlink>:
SYSCALL(unlink)
    3ca4:	b8 12 00 00 00       	mov    $0x12,%eax
    3ca9:	cd 40                	int    $0x40
    3cab:	c3                   	ret    

00003cac <fstat>:
SYSCALL(fstat)
    3cac:	b8 08 00 00 00       	mov    $0x8,%eax
    3cb1:	cd 40                	int    $0x40
    3cb3:	c3                   	ret    

00003cb4 <link>:
SYSCALL(link)
    3cb4:	b8 13 00 00 00       	mov    $0x13,%eax
    3cb9:	cd 40                	int    $0x40
    3cbb:	c3                   	ret    

00003cbc <mkdir>:
SYSCALL(mkdir)
    3cbc:	b8 14 00 00 00       	mov    $0x14,%eax
    3cc1:	cd 40                	int    $0x40
    3cc3:	c3                   	ret    

00003cc4 <chdir>:
SYSCALL(chdir)
    3cc4:	b8 09 00 00 00       	mov    $0x9,%eax
    3cc9:	cd 40                	int    $0x40
    3ccb:	c3                   	ret    

00003ccc <dup>:
SYSCALL(dup)
    3ccc:	b8 0a 00 00 00       	mov    $0xa,%eax
    3cd1:	cd 40                	int    $0x40
    3cd3:	c3                   	ret    

00003cd4 <getpid>:
SYSCALL(getpid)
    3cd4:	b8 0b 00 00 00       	mov    $0xb,%eax
    3cd9:	cd 40                	int    $0x40
    3cdb:	c3                   	ret    

00003cdc <sbrk>:
SYSCALL(sbrk)
    3cdc:	b8 0c 00 00 00       	mov    $0xc,%eax
    3ce1:	cd 40                	int    $0x40
    3ce3:	c3                   	ret    

00003ce4 <sleep>:
SYSCALL(sleep)
    3ce4:	b8 0d 00 00 00       	mov    $0xd,%eax
    3ce9:	cd 40                	int    $0x40
    3ceb:	c3                   	ret    

00003cec <uptime>:
SYSCALL(uptime)
    3cec:	b8 0e 00 00 00       	mov    $0xe,%eax
    3cf1:	cd 40                	int    $0x40
    3cf3:	c3                   	ret    

00003cf4 <randomX>:
SYSCALL(randomX)
    3cf4:	b8 16 00 00 00       	mov    $0x16,%eax
    3cf9:	cd 40                	int    $0x40
    3cfb:	c3                   	ret    

00003cfc <setSeedX>:
SYSCALL(setSeedX)
    3cfc:	b8 17 00 00 00       	mov    $0x17,%eax
    3d01:	cd 40                	int    $0x40
    3d03:	c3                   	ret    

00003d04 <uniformR>:
SYSCALL(uniformR)
    3d04:	b8 18 00 00 00       	mov    $0x18,%eax
    3d09:	cd 40                	int    $0x40
    3d0b:	c3                   	ret    

00003d0c <setdeadline>:
    3d0c:	b8 19 00 00 00       	mov    $0x19,%eax
    3d11:	cd 40                	int    $0x40
    3d13:	c3                   	ret    

00003d14 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    3d14:	55                   	push   %ebp
    3d15:	89 e5                	mov    %esp,%ebp
    3d17:	83 ec 18             	sub    $0x18,%esp
    3d1a:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d1d:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    3d20:	83 ec 04             	sub    $0x4,%esp
    3d23:	6a 01                	push   $0x1
    3d25:	8d 45 f4             	lea    -0xc(%ebp),%eax
    3d28:	50                   	push   %eax
    3d29:	ff 75 08             	pushl  0x8(%ebp)
    3d2c:	e8 43 ff ff ff       	call   3c74 <write>
    3d31:	83 c4 10             	add    $0x10,%esp
}
    3d34:	90                   	nop
    3d35:	c9                   	leave  
    3d36:	c3                   	ret    

00003d37 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3d37:	55                   	push   %ebp
    3d38:	89 e5                	mov    %esp,%ebp
    3d3a:	53                   	push   %ebx
    3d3b:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3d3e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    3d45:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    3d49:	74 17                	je     3d62 <printint+0x2b>
    3d4b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    3d4f:	79 11                	jns    3d62 <printint+0x2b>
    neg = 1;
    3d51:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    3d58:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d5b:	f7 d8                	neg    %eax
    3d5d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3d60:	eb 06                	jmp    3d68 <printint+0x31>
  } else {
    x = xx;
    3d62:	8b 45 0c             	mov    0xc(%ebp),%eax
    3d65:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    3d68:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    3d6f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3d72:	8d 41 01             	lea    0x1(%ecx),%eax
    3d75:	89 45 f4             	mov    %eax,-0xc(%ebp)
    3d78:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d7e:	ba 00 00 00 00       	mov    $0x0,%edx
    3d83:	f7 f3                	div    %ebx
    3d85:	89 d0                	mov    %edx,%eax
    3d87:	0f b6 80 30 5f 00 00 	movzbl 0x5f30(%eax),%eax
    3d8e:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
    3d92:	8b 5d 10             	mov    0x10(%ebp),%ebx
    3d95:	8b 45 ec             	mov    -0x14(%ebp),%eax
    3d98:	ba 00 00 00 00       	mov    $0x0,%edx
    3d9d:	f7 f3                	div    %ebx
    3d9f:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3da2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3da6:	75 c7                	jne    3d6f <printint+0x38>
  if(neg)
    3da8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3dac:	74 2d                	je     3ddb <printint+0xa4>
    buf[i++] = '-';
    3dae:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3db1:	8d 50 01             	lea    0x1(%eax),%edx
    3db4:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3db7:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    3dbc:	eb 1d                	jmp    3ddb <printint+0xa4>
    putc(fd, buf[i]);
    3dbe:	8d 55 dc             	lea    -0x24(%ebp),%edx
    3dc1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3dc4:	01 d0                	add    %edx,%eax
    3dc6:	0f b6 00             	movzbl (%eax),%eax
    3dc9:	0f be c0             	movsbl %al,%eax
    3dcc:	83 ec 08             	sub    $0x8,%esp
    3dcf:	50                   	push   %eax
    3dd0:	ff 75 08             	pushl  0x8(%ebp)
    3dd3:	e8 3c ff ff ff       	call   3d14 <putc>
    3dd8:	83 c4 10             	add    $0x10,%esp
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3ddb:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    3ddf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3de3:	79 d9                	jns    3dbe <printint+0x87>
    putc(fd, buf[i]);
}
    3de5:	90                   	nop
    3de6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3de9:	c9                   	leave  
    3dea:	c3                   	ret    

00003deb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3deb:	55                   	push   %ebp
    3dec:	89 e5                	mov    %esp,%ebp
    3dee:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    3df1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    3df8:	8d 45 0c             	lea    0xc(%ebp),%eax
    3dfb:	83 c0 04             	add    $0x4,%eax
    3dfe:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    3e01:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3e08:	e9 59 01 00 00       	jmp    3f66 <printf+0x17b>
    c = fmt[i] & 0xff;
    3e0d:	8b 55 0c             	mov    0xc(%ebp),%edx
    3e10:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3e13:	01 d0                	add    %edx,%eax
    3e15:	0f b6 00             	movzbl (%eax),%eax
    3e18:	0f be c0             	movsbl %al,%eax
    3e1b:	25 ff 00 00 00       	and    $0xff,%eax
    3e20:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    3e23:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3e27:	75 2c                	jne    3e55 <printf+0x6a>
      if(c == '%'){
    3e29:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3e2d:	75 0c                	jne    3e3b <printf+0x50>
        state = '%';
    3e2f:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    3e36:	e9 27 01 00 00       	jmp    3f62 <printf+0x177>
      } else {
        putc(fd, c);
    3e3b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3e3e:	0f be c0             	movsbl %al,%eax
    3e41:	83 ec 08             	sub    $0x8,%esp
    3e44:	50                   	push   %eax
    3e45:	ff 75 08             	pushl  0x8(%ebp)
    3e48:	e8 c7 fe ff ff       	call   3d14 <putc>
    3e4d:	83 c4 10             	add    $0x10,%esp
    3e50:	e9 0d 01 00 00       	jmp    3f62 <printf+0x177>
      }
    } else if(state == '%'){
    3e55:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    3e59:	0f 85 03 01 00 00    	jne    3f62 <printf+0x177>
      if(c == 'd'){
    3e5f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    3e63:	75 1e                	jne    3e83 <printf+0x98>
        printint(fd, *ap, 10, 1);
    3e65:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e68:	8b 00                	mov    (%eax),%eax
    3e6a:	6a 01                	push   $0x1
    3e6c:	6a 0a                	push   $0xa
    3e6e:	50                   	push   %eax
    3e6f:	ff 75 08             	pushl  0x8(%ebp)
    3e72:	e8 c0 fe ff ff       	call   3d37 <printint>
    3e77:	83 c4 10             	add    $0x10,%esp
        ap++;
    3e7a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3e7e:	e9 d8 00 00 00       	jmp    3f5b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    3e83:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    3e87:	74 06                	je     3e8f <printf+0xa4>
    3e89:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    3e8d:	75 1e                	jne    3ead <printf+0xc2>
        printint(fd, *ap, 16, 0);
    3e8f:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3e92:	8b 00                	mov    (%eax),%eax
    3e94:	6a 00                	push   $0x0
    3e96:	6a 10                	push   $0x10
    3e98:	50                   	push   %eax
    3e99:	ff 75 08             	pushl  0x8(%ebp)
    3e9c:	e8 96 fe ff ff       	call   3d37 <printint>
    3ea1:	83 c4 10             	add    $0x10,%esp
        ap++;
    3ea4:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3ea8:	e9 ae 00 00 00       	jmp    3f5b <printf+0x170>
      } else if(c == 's'){
    3ead:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    3eb1:	75 43                	jne    3ef6 <printf+0x10b>
        s = (char*)*ap;
    3eb3:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3eb6:	8b 00                	mov    (%eax),%eax
    3eb8:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    3ebb:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    3ebf:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3ec3:	75 25                	jne    3eea <printf+0xff>
          s = "(null)";
    3ec5:	c7 45 f4 77 58 00 00 	movl   $0x5877,-0xc(%ebp)
        while(*s != 0){
    3ecc:	eb 1c                	jmp    3eea <printf+0xff>
          putc(fd, *s);
    3ece:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ed1:	0f b6 00             	movzbl (%eax),%eax
    3ed4:	0f be c0             	movsbl %al,%eax
    3ed7:	83 ec 08             	sub    $0x8,%esp
    3eda:	50                   	push   %eax
    3edb:	ff 75 08             	pushl  0x8(%ebp)
    3ede:	e8 31 fe ff ff       	call   3d14 <putc>
    3ee3:	83 c4 10             	add    $0x10,%esp
          s++;
    3ee6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3eea:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3eed:	0f b6 00             	movzbl (%eax),%eax
    3ef0:	84 c0                	test   %al,%al
    3ef2:	75 da                	jne    3ece <printf+0xe3>
    3ef4:	eb 65                	jmp    3f5b <printf+0x170>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3ef6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    3efa:	75 1d                	jne    3f19 <printf+0x12e>
        putc(fd, *ap);
    3efc:	8b 45 e8             	mov    -0x18(%ebp),%eax
    3eff:	8b 00                	mov    (%eax),%eax
    3f01:	0f be c0             	movsbl %al,%eax
    3f04:	83 ec 08             	sub    $0x8,%esp
    3f07:	50                   	push   %eax
    3f08:	ff 75 08             	pushl  0x8(%ebp)
    3f0b:	e8 04 fe ff ff       	call   3d14 <putc>
    3f10:	83 c4 10             	add    $0x10,%esp
        ap++;
    3f13:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    3f17:	eb 42                	jmp    3f5b <printf+0x170>
      } else if(c == '%'){
    3f19:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    3f1d:	75 17                	jne    3f36 <printf+0x14b>
        putc(fd, c);
    3f1f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3f22:	0f be c0             	movsbl %al,%eax
    3f25:	83 ec 08             	sub    $0x8,%esp
    3f28:	50                   	push   %eax
    3f29:	ff 75 08             	pushl  0x8(%ebp)
    3f2c:	e8 e3 fd ff ff       	call   3d14 <putc>
    3f31:	83 c4 10             	add    $0x10,%esp
    3f34:	eb 25                	jmp    3f5b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3f36:	83 ec 08             	sub    $0x8,%esp
    3f39:	6a 25                	push   $0x25
    3f3b:	ff 75 08             	pushl  0x8(%ebp)
    3f3e:	e8 d1 fd ff ff       	call   3d14 <putc>
    3f43:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    3f46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3f49:	0f be c0             	movsbl %al,%eax
    3f4c:	83 ec 08             	sub    $0x8,%esp
    3f4f:	50                   	push   %eax
    3f50:	ff 75 08             	pushl  0x8(%ebp)
    3f53:	e8 bc fd ff ff       	call   3d14 <putc>
    3f58:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    3f5b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3f62:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3f66:	8b 55 0c             	mov    0xc(%ebp),%edx
    3f69:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3f6c:	01 d0                	add    %edx,%eax
    3f6e:	0f b6 00             	movzbl (%eax),%eax
    3f71:	84 c0                	test   %al,%al
    3f73:	0f 85 94 fe ff ff    	jne    3e0d <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3f79:	90                   	nop
    3f7a:	c9                   	leave  
    3f7b:	c3                   	ret    

00003f7c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3f7c:	55                   	push   %ebp
    3f7d:	89 e5                	mov    %esp,%ebp
    3f7f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3f82:	8b 45 08             	mov    0x8(%ebp),%eax
    3f85:	83 e8 08             	sub    $0x8,%eax
    3f88:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3f8b:	a1 08 60 00 00       	mov    0x6008,%eax
    3f90:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3f93:	eb 24                	jmp    3fb9 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3f95:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3f98:	8b 00                	mov    (%eax),%eax
    3f9a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3f9d:	77 12                	ja     3fb1 <free+0x35>
    3f9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fa2:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3fa5:	77 24                	ja     3fcb <free+0x4f>
    3fa7:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3faa:	8b 00                	mov    (%eax),%eax
    3fac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3faf:	77 1a                	ja     3fcb <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3fb1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fb4:	8b 00                	mov    (%eax),%eax
    3fb6:	89 45 fc             	mov    %eax,-0x4(%ebp)
    3fb9:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fbc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    3fbf:	76 d4                	jbe    3f95 <free+0x19>
    3fc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fc4:	8b 00                	mov    (%eax),%eax
    3fc6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    3fc9:	76 ca                	jbe    3f95 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    3fcb:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fce:	8b 40 04             	mov    0x4(%eax),%eax
    3fd1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    3fd8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fdb:	01 c2                	add    %eax,%edx
    3fdd:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fe0:	8b 00                	mov    (%eax),%eax
    3fe2:	39 c2                	cmp    %eax,%edx
    3fe4:	75 24                	jne    400a <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    3fe6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3fe9:	8b 50 04             	mov    0x4(%eax),%edx
    3fec:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fef:	8b 00                	mov    (%eax),%eax
    3ff1:	8b 40 04             	mov    0x4(%eax),%eax
    3ff4:	01 c2                	add    %eax,%edx
    3ff6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    3ff9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    3ffc:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fff:	8b 00                	mov    (%eax),%eax
    4001:	8b 10                	mov    (%eax),%edx
    4003:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4006:	89 10                	mov    %edx,(%eax)
    4008:	eb 0a                	jmp    4014 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    400a:	8b 45 fc             	mov    -0x4(%ebp),%eax
    400d:	8b 10                	mov    (%eax),%edx
    400f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4012:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4014:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4017:	8b 40 04             	mov    0x4(%eax),%eax
    401a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    4021:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4024:	01 d0                	add    %edx,%eax
    4026:	3b 45 f8             	cmp    -0x8(%ebp),%eax
    4029:	75 20                	jne    404b <free+0xcf>
    p->s.size += bp->s.size;
    402b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    402e:	8b 50 04             	mov    0x4(%eax),%edx
    4031:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4034:	8b 40 04             	mov    0x4(%eax),%eax
    4037:	01 c2                	add    %eax,%edx
    4039:	8b 45 fc             	mov    -0x4(%ebp),%eax
    403c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    403f:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4042:	8b 10                	mov    (%eax),%edx
    4044:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4047:	89 10                	mov    %edx,(%eax)
    4049:	eb 08                	jmp    4053 <free+0xd7>
  } else
    p->s.ptr = bp;
    404b:	8b 45 fc             	mov    -0x4(%ebp),%eax
    404e:	8b 55 f8             	mov    -0x8(%ebp),%edx
    4051:	89 10                	mov    %edx,(%eax)
  freep = p;
    4053:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4056:	a3 08 60 00 00       	mov    %eax,0x6008
}
    405b:	90                   	nop
    405c:	c9                   	leave  
    405d:	c3                   	ret    

0000405e <morecore>:

static Header*
morecore(uint nu)
{
    405e:	55                   	push   %ebp
    405f:	89 e5                	mov    %esp,%ebp
    4061:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    4064:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    406b:	77 07                	ja     4074 <morecore+0x16>
    nu = 4096;
    406d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4074:	8b 45 08             	mov    0x8(%ebp),%eax
    4077:	c1 e0 03             	shl    $0x3,%eax
    407a:	83 ec 0c             	sub    $0xc,%esp
    407d:	50                   	push   %eax
    407e:	e8 59 fc ff ff       	call   3cdc <sbrk>
    4083:	83 c4 10             	add    $0x10,%esp
    4086:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4089:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    408d:	75 07                	jne    4096 <morecore+0x38>
    return 0;
    408f:	b8 00 00 00 00       	mov    $0x0,%eax
    4094:	eb 26                	jmp    40bc <morecore+0x5e>
  hp = (Header*)p;
    4096:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4099:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    409c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    409f:	8b 55 08             	mov    0x8(%ebp),%edx
    40a2:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    40a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40a8:	83 c0 08             	add    $0x8,%eax
    40ab:	83 ec 0c             	sub    $0xc,%esp
    40ae:	50                   	push   %eax
    40af:	e8 c8 fe ff ff       	call   3f7c <free>
    40b4:	83 c4 10             	add    $0x10,%esp
  return freep;
    40b7:	a1 08 60 00 00       	mov    0x6008,%eax
}
    40bc:	c9                   	leave  
    40bd:	c3                   	ret    

000040be <malloc>:

void*
malloc(uint nbytes)
{
    40be:	55                   	push   %ebp
    40bf:	89 e5                	mov    %esp,%ebp
    40c1:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    40c4:	8b 45 08             	mov    0x8(%ebp),%eax
    40c7:	83 c0 07             	add    $0x7,%eax
    40ca:	c1 e8 03             	shr    $0x3,%eax
    40cd:	83 c0 01             	add    $0x1,%eax
    40d0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    40d3:	a1 08 60 00 00       	mov    0x6008,%eax
    40d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    40db:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    40df:	75 23                	jne    4104 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    40e1:	c7 45 f0 00 60 00 00 	movl   $0x6000,-0x10(%ebp)
    40e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
    40eb:	a3 08 60 00 00       	mov    %eax,0x6008
    40f0:	a1 08 60 00 00       	mov    0x6008,%eax
    40f5:	a3 00 60 00 00       	mov    %eax,0x6000
    base.s.size = 0;
    40fa:	c7 05 04 60 00 00 00 	movl   $0x0,0x6004
    4101:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4104:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4107:	8b 00                	mov    (%eax),%eax
    4109:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    410c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    410f:	8b 40 04             	mov    0x4(%eax),%eax
    4112:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4115:	72 4d                	jb     4164 <malloc+0xa6>
      if(p->s.size == nunits)
    4117:	8b 45 f4             	mov    -0xc(%ebp),%eax
    411a:	8b 40 04             	mov    0x4(%eax),%eax
    411d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
    4120:	75 0c                	jne    412e <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    4122:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4125:	8b 10                	mov    (%eax),%edx
    4127:	8b 45 f0             	mov    -0x10(%ebp),%eax
    412a:	89 10                	mov    %edx,(%eax)
    412c:	eb 26                	jmp    4154 <malloc+0x96>
      else {
        p->s.size -= nunits;
    412e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4131:	8b 40 04             	mov    0x4(%eax),%eax
    4134:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4137:	89 c2                	mov    %eax,%edx
    4139:	8b 45 f4             	mov    -0xc(%ebp),%eax
    413c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    413f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4142:	8b 40 04             	mov    0x4(%eax),%eax
    4145:	c1 e0 03             	shl    $0x3,%eax
    4148:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    414b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    414e:	8b 55 ec             	mov    -0x14(%ebp),%edx
    4151:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4154:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4157:	a3 08 60 00 00       	mov    %eax,0x6008
      return (void*)(p + 1);
    415c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    415f:	83 c0 08             	add    $0x8,%eax
    4162:	eb 3b                	jmp    419f <malloc+0xe1>
    }
    if(p == freep)
    4164:	a1 08 60 00 00       	mov    0x6008,%eax
    4169:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    416c:	75 1e                	jne    418c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    416e:	83 ec 0c             	sub    $0xc,%esp
    4171:	ff 75 ec             	pushl  -0x14(%ebp)
    4174:	e8 e5 fe ff ff       	call   405e <morecore>
    4179:	83 c4 10             	add    $0x10,%esp
    417c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    417f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4183:	75 07                	jne    418c <malloc+0xce>
        return 0;
    4185:	b8 00 00 00 00       	mov    $0x0,%eax
    418a:	eb 13                	jmp    419f <malloc+0xe1>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    418c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    418f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    4192:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4195:	8b 00                	mov    (%eax),%eax
    4197:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
    419a:	e9 6d ff ff ff       	jmp    410c <malloc+0x4e>
}
    419f:	c9                   	leave  
    41a0:	c3                   	ret    
