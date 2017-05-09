
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 c6 10 80       	mov    $0x8010c670,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 7d 34 10 80       	mov    $0x8010347d,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 80 81 10 80       	push   $0x80108180
80100042:	68 80 c6 10 80       	push   $0x8010c680
80100047:	e8 7b 4b 00 00       	call   80104bc7 <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 b0 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb0
80100056:	db 10 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 b4 db 10 80 a4 	movl   $0x8010dba4,0x8010dbb4
80100060:	db 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 b4 c6 10 80 	movl   $0x8010c6b4,-0xc(%ebp)
8010006a:	eb 3a                	jmp    801000a6 <binit+0x72>
    b->next = bcache.head.next;
8010006c:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 10             	mov    %edx,0x10(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
    b->dev = -1;
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	c7 40 04 ff ff ff ff 	movl   $0xffffffff,0x4(%eax)
    bcache.head.next->prev = b;
8010008c:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
80100091:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100094:	89 50 0c             	mov    %edx,0xc(%eax)
    bcache.head.next = b;
80100097:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010009a:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010009f:	81 45 f4 18 02 00 00 	addl   $0x218,-0xc(%ebp)
801000a6:	b8 a4 db 10 80       	mov    $0x8010dba4,%eax
801000ab:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000ae:	72 bc                	jb     8010006c <binit+0x38>
    b->prev = &bcache.head;
    b->dev = -1;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000b0:	90                   	nop
801000b1:	c9                   	leave  
801000b2:	c3                   	ret    

801000b3 <bget>:
// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf*
bget(uint dev, uint sector)
{
801000b3:	55                   	push   %ebp
801000b4:	89 e5                	mov    %esp,%ebp
801000b6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000b9:	83 ec 0c             	sub    $0xc,%esp
801000bc:	68 80 c6 10 80       	push   $0x8010c680
801000c1:	e8 23 4b 00 00       	call   80104be9 <acquire>
801000c6:	83 c4 10             	add    $0x10,%esp

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000c9:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
801000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000d1:	eb 67                	jmp    8010013a <bget+0x87>
    if(b->dev == dev && b->sector == sector){
801000d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000d6:	8b 40 04             	mov    0x4(%eax),%eax
801000d9:	3b 45 08             	cmp    0x8(%ebp),%eax
801000dc:	75 53                	jne    80100131 <bget+0x7e>
801000de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e1:	8b 40 08             	mov    0x8(%eax),%eax
801000e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
801000e7:	75 48                	jne    80100131 <bget+0x7e>
      if(!(b->flags & B_BUSY)){
801000e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ec:	8b 00                	mov    (%eax),%eax
801000ee:	83 e0 01             	and    $0x1,%eax
801000f1:	85 c0                	test   %eax,%eax
801000f3:	75 27                	jne    8010011c <bget+0x69>
        b->flags |= B_BUSY;
801000f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000f8:	8b 00                	mov    (%eax),%eax
801000fa:	83 c8 01             	or     $0x1,%eax
801000fd:	89 c2                	mov    %eax,%edx
801000ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100102:	89 10                	mov    %edx,(%eax)
        release(&bcache.lock);
80100104:	83 ec 0c             	sub    $0xc,%esp
80100107:	68 80 c6 10 80       	push   $0x8010c680
8010010c:	e8 3f 4b 00 00       	call   80104c50 <release>
80100111:	83 c4 10             	add    $0x10,%esp
        return b;
80100114:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100117:	e9 98 00 00 00       	jmp    801001b4 <bget+0x101>
      }
      sleep(b, &bcache.lock);
8010011c:	83 ec 08             	sub    $0x8,%esp
8010011f:	68 80 c6 10 80       	push   $0x8010c680
80100124:	ff 75 f4             	pushl  -0xc(%ebp)
80100127:	e8 8e 47 00 00       	call   801048ba <sleep>
8010012c:	83 c4 10             	add    $0x10,%esp
      goto loop;
8010012f:	eb 98                	jmp    801000c9 <bget+0x16>

  acquire(&bcache.lock);

 loop:
  // Is the sector already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100131:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100134:	8b 40 10             	mov    0x10(%eax),%eax
80100137:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010013a:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
80100141:	75 90                	jne    801000d3 <bget+0x20>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100143:	a1 b0 db 10 80       	mov    0x8010dbb0,%eax
80100148:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010014b:	eb 51                	jmp    8010019e <bget+0xeb>
    if((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0){
8010014d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100150:	8b 00                	mov    (%eax),%eax
80100152:	83 e0 01             	and    $0x1,%eax
80100155:	85 c0                	test   %eax,%eax
80100157:	75 3c                	jne    80100195 <bget+0xe2>
80100159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010015c:	8b 00                	mov    (%eax),%eax
8010015e:	83 e0 04             	and    $0x4,%eax
80100161:	85 c0                	test   %eax,%eax
80100163:	75 30                	jne    80100195 <bget+0xe2>
      b->dev = dev;
80100165:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100168:	8b 55 08             	mov    0x8(%ebp),%edx
8010016b:	89 50 04             	mov    %edx,0x4(%eax)
      b->sector = sector;
8010016e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100171:	8b 55 0c             	mov    0xc(%ebp),%edx
80100174:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = B_BUSY;
80100177:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010017a:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
      release(&bcache.lock);
80100180:	83 ec 0c             	sub    $0xc,%esp
80100183:	68 80 c6 10 80       	push   $0x8010c680
80100188:	e8 c3 4a 00 00       	call   80104c50 <release>
8010018d:	83 c4 10             	add    $0x10,%esp
      return b;
80100190:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100193:	eb 1f                	jmp    801001b4 <bget+0x101>
      goto loop;
    }
  }

  // Not cached; recycle some non-busy and clean buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100195:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100198:	8b 40 0c             	mov    0xc(%eax),%eax
8010019b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010019e:	81 7d f4 a4 db 10 80 	cmpl   $0x8010dba4,-0xc(%ebp)
801001a5:	75 a6                	jne    8010014d <bget+0x9a>
      b->flags = B_BUSY;
      release(&bcache.lock);
      return b;
    }
  }
  panic("bget: no buffers");
801001a7:	83 ec 0c             	sub    $0xc,%esp
801001aa:	68 87 81 10 80       	push   $0x80108187
801001af:	e8 b2 03 00 00       	call   80100566 <panic>
}
801001b4:	c9                   	leave  
801001b5:	c3                   	ret    

801001b6 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf*
bread(uint dev, uint sector)
{
801001b6:	55                   	push   %ebp
801001b7:	89 e5                	mov    %esp,%ebp
801001b9:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, sector);
801001bc:	83 ec 08             	sub    $0x8,%esp
801001bf:	ff 75 0c             	pushl  0xc(%ebp)
801001c2:	ff 75 08             	pushl  0x8(%ebp)
801001c5:	e8 e9 fe ff ff       	call   801000b3 <bget>
801001ca:	83 c4 10             	add    $0x10,%esp
801001cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(!(b->flags & B_VALID))
801001d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001d3:	8b 00                	mov    (%eax),%eax
801001d5:	83 e0 02             	and    $0x2,%eax
801001d8:	85 c0                	test   %eax,%eax
801001da:	75 0e                	jne    801001ea <bread+0x34>
    iderw(b);
801001dc:	83 ec 0c             	sub    $0xc,%esp
801001df:	ff 75 f4             	pushl  -0xc(%ebp)
801001e2:	e8 71 26 00 00       	call   80102858 <iderw>
801001e7:	83 c4 10             	add    $0x10,%esp
  return b;
801001ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801001ed:	c9                   	leave  
801001ee:	c3                   	ret    

801001ef <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void
bwrite(struct buf *b)
{
801001ef:	55                   	push   %ebp
801001f0:	89 e5                	mov    %esp,%ebp
801001f2:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
801001f5:	8b 45 08             	mov    0x8(%ebp),%eax
801001f8:	8b 00                	mov    (%eax),%eax
801001fa:	83 e0 01             	and    $0x1,%eax
801001fd:	85 c0                	test   %eax,%eax
801001ff:	75 0d                	jne    8010020e <bwrite+0x1f>
    panic("bwrite");
80100201:	83 ec 0c             	sub    $0xc,%esp
80100204:	68 98 81 10 80       	push   $0x80108198
80100209:	e8 58 03 00 00       	call   80100566 <panic>
  b->flags |= B_DIRTY;
8010020e:	8b 45 08             	mov    0x8(%ebp),%eax
80100211:	8b 00                	mov    (%eax),%eax
80100213:	83 c8 04             	or     $0x4,%eax
80100216:	89 c2                	mov    %eax,%edx
80100218:	8b 45 08             	mov    0x8(%ebp),%eax
8010021b:	89 10                	mov    %edx,(%eax)
  iderw(b);
8010021d:	83 ec 0c             	sub    $0xc,%esp
80100220:	ff 75 08             	pushl  0x8(%ebp)
80100223:	e8 30 26 00 00       	call   80102858 <iderw>
80100228:	83 c4 10             	add    $0x10,%esp
}
8010022b:	90                   	nop
8010022c:	c9                   	leave  
8010022d:	c3                   	ret    

8010022e <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
8010022e:	55                   	push   %ebp
8010022f:	89 e5                	mov    %esp,%ebp
80100231:	83 ec 08             	sub    $0x8,%esp
  if((b->flags & B_BUSY) == 0)
80100234:	8b 45 08             	mov    0x8(%ebp),%eax
80100237:	8b 00                	mov    (%eax),%eax
80100239:	83 e0 01             	and    $0x1,%eax
8010023c:	85 c0                	test   %eax,%eax
8010023e:	75 0d                	jne    8010024d <brelse+0x1f>
    panic("brelse");
80100240:	83 ec 0c             	sub    $0xc,%esp
80100243:	68 9f 81 10 80       	push   $0x8010819f
80100248:	e8 19 03 00 00       	call   80100566 <panic>

  acquire(&bcache.lock);
8010024d:	83 ec 0c             	sub    $0xc,%esp
80100250:	68 80 c6 10 80       	push   $0x8010c680
80100255:	e8 8f 49 00 00       	call   80104be9 <acquire>
8010025a:	83 c4 10             	add    $0x10,%esp

  b->next->prev = b->prev;
8010025d:	8b 45 08             	mov    0x8(%ebp),%eax
80100260:	8b 40 10             	mov    0x10(%eax),%eax
80100263:	8b 55 08             	mov    0x8(%ebp),%edx
80100266:	8b 52 0c             	mov    0xc(%edx),%edx
80100269:	89 50 0c             	mov    %edx,0xc(%eax)
  b->prev->next = b->next;
8010026c:	8b 45 08             	mov    0x8(%ebp),%eax
8010026f:	8b 40 0c             	mov    0xc(%eax),%eax
80100272:	8b 55 08             	mov    0x8(%ebp),%edx
80100275:	8b 52 10             	mov    0x10(%edx),%edx
80100278:	89 50 10             	mov    %edx,0x10(%eax)
  b->next = bcache.head.next;
8010027b:	8b 15 b4 db 10 80    	mov    0x8010dbb4,%edx
80100281:	8b 45 08             	mov    0x8(%ebp),%eax
80100284:	89 50 10             	mov    %edx,0x10(%eax)
  b->prev = &bcache.head;
80100287:	8b 45 08             	mov    0x8(%ebp),%eax
8010028a:	c7 40 0c a4 db 10 80 	movl   $0x8010dba4,0xc(%eax)
  bcache.head.next->prev = b;
80100291:	a1 b4 db 10 80       	mov    0x8010dbb4,%eax
80100296:	8b 55 08             	mov    0x8(%ebp),%edx
80100299:	89 50 0c             	mov    %edx,0xc(%eax)
  bcache.head.next = b;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	a3 b4 db 10 80       	mov    %eax,0x8010dbb4

  b->flags &= ~B_BUSY;
801002a4:	8b 45 08             	mov    0x8(%ebp),%eax
801002a7:	8b 00                	mov    (%eax),%eax
801002a9:	83 e0 fe             	and    $0xfffffffe,%eax
801002ac:	89 c2                	mov    %eax,%edx
801002ae:	8b 45 08             	mov    0x8(%ebp),%eax
801002b1:	89 10                	mov    %edx,(%eax)
  wakeup(b);
801002b3:	83 ec 0c             	sub    $0xc,%esp
801002b6:	ff 75 08             	pushl  0x8(%ebp)
801002b9:	e8 e7 46 00 00       	call   801049a5 <wakeup>
801002be:	83 c4 10             	add    $0x10,%esp

  release(&bcache.lock);
801002c1:	83 ec 0c             	sub    $0xc,%esp
801002c4:	68 80 c6 10 80       	push   $0x8010c680
801002c9:	e8 82 49 00 00       	call   80104c50 <release>
801002ce:	83 c4 10             	add    $0x10,%esp
}
801002d1:	90                   	nop
801002d2:	c9                   	leave  
801002d3:	c3                   	ret    

801002d4 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801002d4:	55                   	push   %ebp
801002d5:	89 e5                	mov    %esp,%ebp
801002d7:	83 ec 14             	sub    $0x14,%esp
801002da:	8b 45 08             	mov    0x8(%ebp),%eax
801002dd:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801002e1:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801002e5:	89 c2                	mov    %eax,%edx
801002e7:	ec                   	in     (%dx),%al
801002e8:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801002eb:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801002ef:	c9                   	leave  
801002f0:	c3                   	ret    

801002f1 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801002f1:	55                   	push   %ebp
801002f2:	89 e5                	mov    %esp,%ebp
801002f4:	83 ec 08             	sub    $0x8,%esp
801002f7:	8b 55 08             	mov    0x8(%ebp),%edx
801002fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801002fd:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80100301:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100304:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100308:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
8010030c:	ee                   	out    %al,(%dx)
}
8010030d:	90                   	nop
8010030e:	c9                   	leave  
8010030f:	c3                   	ret    

80100310 <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80100310:	55                   	push   %ebp
80100311:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100313:	fa                   	cli    
}
80100314:	90                   	nop
80100315:	5d                   	pop    %ebp
80100316:	c3                   	ret    

80100317 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100317:	55                   	push   %ebp
80100318:	89 e5                	mov    %esp,%ebp
8010031a:	53                   	push   %ebx
8010031b:	83 ec 24             	sub    $0x24,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010031e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100322:	74 1c                	je     80100340 <printint+0x29>
80100324:	8b 45 08             	mov    0x8(%ebp),%eax
80100327:	c1 e8 1f             	shr    $0x1f,%eax
8010032a:	0f b6 c0             	movzbl %al,%eax
8010032d:	89 45 10             	mov    %eax,0x10(%ebp)
80100330:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100334:	74 0a                	je     80100340 <printint+0x29>
    x = -xx;
80100336:	8b 45 08             	mov    0x8(%ebp),%eax
80100339:	f7 d8                	neg    %eax
8010033b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010033e:	eb 06                	jmp    80100346 <printint+0x2f>
  else
    x = xx;
80100340:	8b 45 08             	mov    0x8(%ebp),%eax
80100343:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100346:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
8010034d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100350:	8d 41 01             	lea    0x1(%ecx),%eax
80100353:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100356:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100359:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010035c:	ba 00 00 00 00       	mov    $0x0,%edx
80100361:	f7 f3                	div    %ebx
80100363:	89 d0                	mov    %edx,%eax
80100365:	0f b6 80 04 90 10 80 	movzbl -0x7fef6ffc(%eax),%eax
8010036c:	88 44 0d e0          	mov    %al,-0x20(%ebp,%ecx,1)
  }while((x /= base) != 0);
80100370:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80100373:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100376:	ba 00 00 00 00       	mov    $0x0,%edx
8010037b:	f7 f3                	div    %ebx
8010037d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100380:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100384:	75 c7                	jne    8010034d <printint+0x36>

  if(sign)
80100386:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010038a:	74 2a                	je     801003b6 <printint+0x9f>
    buf[i++] = '-';
8010038c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010038f:	8d 50 01             	lea    0x1(%eax),%edx
80100392:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100395:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
8010039a:	eb 1a                	jmp    801003b6 <printint+0x9f>
    consputc(buf[i]);
8010039c:	8d 55 e0             	lea    -0x20(%ebp),%edx
8010039f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003a2:	01 d0                	add    %edx,%eax
801003a4:	0f b6 00             	movzbl (%eax),%eax
801003a7:	0f be c0             	movsbl %al,%eax
801003aa:	83 ec 0c             	sub    $0xc,%esp
801003ad:	50                   	push   %eax
801003ae:	e8 c3 03 00 00       	call   80100776 <consputc>
801003b3:	83 c4 10             	add    $0x10,%esp
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801003b6:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003ba:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003be:	79 dc                	jns    8010039c <printint+0x85>
    consputc(buf[i]);
}
801003c0:	90                   	nop
801003c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801003c4:	c9                   	leave  
801003c5:	c3                   	ret    

801003c6 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
801003c6:	55                   	push   %ebp
801003c7:	89 e5                	mov    %esp,%ebp
801003c9:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
801003cc:	a1 14 b6 10 80       	mov    0x8010b614,%eax
801003d1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
801003d4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801003d8:	74 10                	je     801003ea <cprintf+0x24>
    acquire(&cons.lock);
801003da:	83 ec 0c             	sub    $0xc,%esp
801003dd:	68 e0 b5 10 80       	push   $0x8010b5e0
801003e2:	e8 02 48 00 00       	call   80104be9 <acquire>
801003e7:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
801003ea:	8b 45 08             	mov    0x8(%ebp),%eax
801003ed:	85 c0                	test   %eax,%eax
801003ef:	75 0d                	jne    801003fe <cprintf+0x38>
    panic("null fmt");
801003f1:	83 ec 0c             	sub    $0xc,%esp
801003f4:	68 a6 81 10 80       	push   $0x801081a6
801003f9:	e8 68 01 00 00       	call   80100566 <panic>

  argp = (uint*)(void*)(&fmt + 1);
801003fe:	8d 45 0c             	lea    0xc(%ebp),%eax
80100401:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100404:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010040b:	e9 1a 01 00 00       	jmp    8010052a <cprintf+0x164>
    if(c != '%'){
80100410:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
80100414:	74 13                	je     80100429 <cprintf+0x63>
      consputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	ff 75 e4             	pushl  -0x1c(%ebp)
8010041c:	e8 55 03 00 00       	call   80100776 <consputc>
80100421:	83 c4 10             	add    $0x10,%esp
      continue;
80100424:	e9 fd 00 00 00       	jmp    80100526 <cprintf+0x160>
    }
    c = fmt[++i] & 0xff;
80100429:	8b 55 08             	mov    0x8(%ebp),%edx
8010042c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100430:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100433:	01 d0                	add    %edx,%eax
80100435:	0f b6 00             	movzbl (%eax),%eax
80100438:	0f be c0             	movsbl %al,%eax
8010043b:	25 ff 00 00 00       	and    $0xff,%eax
80100440:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
80100443:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100447:	0f 84 ff 00 00 00    	je     8010054c <cprintf+0x186>
      break;
    switch(c){
8010044d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100450:	83 f8 70             	cmp    $0x70,%eax
80100453:	74 47                	je     8010049c <cprintf+0xd6>
80100455:	83 f8 70             	cmp    $0x70,%eax
80100458:	7f 13                	jg     8010046d <cprintf+0xa7>
8010045a:	83 f8 25             	cmp    $0x25,%eax
8010045d:	0f 84 98 00 00 00    	je     801004fb <cprintf+0x135>
80100463:	83 f8 64             	cmp    $0x64,%eax
80100466:	74 14                	je     8010047c <cprintf+0xb6>
80100468:	e9 9d 00 00 00       	jmp    8010050a <cprintf+0x144>
8010046d:	83 f8 73             	cmp    $0x73,%eax
80100470:	74 47                	je     801004b9 <cprintf+0xf3>
80100472:	83 f8 78             	cmp    $0x78,%eax
80100475:	74 25                	je     8010049c <cprintf+0xd6>
80100477:	e9 8e 00 00 00       	jmp    8010050a <cprintf+0x144>
    case 'd':
      printint(*argp++, 10, 1);
8010047c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010047f:	8d 50 04             	lea    0x4(%eax),%edx
80100482:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100485:	8b 00                	mov    (%eax),%eax
80100487:	83 ec 04             	sub    $0x4,%esp
8010048a:	6a 01                	push   $0x1
8010048c:	6a 0a                	push   $0xa
8010048e:	50                   	push   %eax
8010048f:	e8 83 fe ff ff       	call   80100317 <printint>
80100494:	83 c4 10             	add    $0x10,%esp
      break;
80100497:	e9 8a 00 00 00       	jmp    80100526 <cprintf+0x160>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010049c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010049f:	8d 50 04             	lea    0x4(%eax),%edx
801004a2:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004a5:	8b 00                	mov    (%eax),%eax
801004a7:	83 ec 04             	sub    $0x4,%esp
801004aa:	6a 00                	push   $0x0
801004ac:	6a 10                	push   $0x10
801004ae:	50                   	push   %eax
801004af:	e8 63 fe ff ff       	call   80100317 <printint>
801004b4:	83 c4 10             	add    $0x10,%esp
      break;
801004b7:	eb 6d                	jmp    80100526 <cprintf+0x160>
    case 's':
      if((s = (char*)*argp++) == 0)
801004b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004bc:	8d 50 04             	lea    0x4(%eax),%edx
801004bf:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004c2:	8b 00                	mov    (%eax),%eax
801004c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
801004c7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801004cb:	75 22                	jne    801004ef <cprintf+0x129>
        s = "(null)";
801004cd:	c7 45 ec af 81 10 80 	movl   $0x801081af,-0x14(%ebp)
      for(; *s; s++)
801004d4:	eb 19                	jmp    801004ef <cprintf+0x129>
        consputc(*s);
801004d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004d9:	0f b6 00             	movzbl (%eax),%eax
801004dc:	0f be c0             	movsbl %al,%eax
801004df:	83 ec 0c             	sub    $0xc,%esp
801004e2:	50                   	push   %eax
801004e3:	e8 8e 02 00 00       	call   80100776 <consputc>
801004e8:	83 c4 10             	add    $0x10,%esp
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801004eb:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
801004ef:	8b 45 ec             	mov    -0x14(%ebp),%eax
801004f2:	0f b6 00             	movzbl (%eax),%eax
801004f5:	84 c0                	test   %al,%al
801004f7:	75 dd                	jne    801004d6 <cprintf+0x110>
        consputc(*s);
      break;
801004f9:	eb 2b                	jmp    80100526 <cprintf+0x160>
    case '%':
      consputc('%');
801004fb:	83 ec 0c             	sub    $0xc,%esp
801004fe:	6a 25                	push   $0x25
80100500:	e8 71 02 00 00       	call   80100776 <consputc>
80100505:	83 c4 10             	add    $0x10,%esp
      break;
80100508:	eb 1c                	jmp    80100526 <cprintf+0x160>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
8010050a:	83 ec 0c             	sub    $0xc,%esp
8010050d:	6a 25                	push   $0x25
8010050f:	e8 62 02 00 00       	call   80100776 <consputc>
80100514:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100517:	83 ec 0c             	sub    $0xc,%esp
8010051a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010051d:	e8 54 02 00 00       	call   80100776 <consputc>
80100522:	83 c4 10             	add    $0x10,%esp
      break;
80100525:	90                   	nop

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100526:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010052a:	8b 55 08             	mov    0x8(%ebp),%edx
8010052d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100530:	01 d0                	add    %edx,%eax
80100532:	0f b6 00             	movzbl (%eax),%eax
80100535:	0f be c0             	movsbl %al,%eax
80100538:	25 ff 00 00 00       	and    $0xff,%eax
8010053d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100540:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100544:	0f 85 c6 fe ff ff    	jne    80100410 <cprintf+0x4a>
8010054a:	eb 01                	jmp    8010054d <cprintf+0x187>
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
8010054c:	90                   	nop
      consputc(c);
      break;
    }
  }

  if(locking)
8010054d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100551:	74 10                	je     80100563 <cprintf+0x19d>
    release(&cons.lock);
80100553:	83 ec 0c             	sub    $0xc,%esp
80100556:	68 e0 b5 10 80       	push   $0x8010b5e0
8010055b:	e8 f0 46 00 00       	call   80104c50 <release>
80100560:	83 c4 10             	add    $0x10,%esp
}
80100563:	90                   	nop
80100564:	c9                   	leave  
80100565:	c3                   	ret    

80100566 <panic>:

void
panic(char *s)
{
80100566:	55                   	push   %ebp
80100567:	89 e5                	mov    %esp,%ebp
80100569:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];
  
  cli();
8010056c:	e8 9f fd ff ff       	call   80100310 <cli>
  cons.locking = 0;
80100571:	c7 05 14 b6 10 80 00 	movl   $0x0,0x8010b614
80100578:	00 00 00 
  cprintf("cpu%d: panic: ", cpu->id);
8010057b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80100581:	0f b6 00             	movzbl (%eax),%eax
80100584:	0f b6 c0             	movzbl %al,%eax
80100587:	83 ec 08             	sub    $0x8,%esp
8010058a:	50                   	push   %eax
8010058b:	68 b6 81 10 80       	push   $0x801081b6
80100590:	e8 31 fe ff ff       	call   801003c6 <cprintf>
80100595:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
80100598:	8b 45 08             	mov    0x8(%ebp),%eax
8010059b:	83 ec 0c             	sub    $0xc,%esp
8010059e:	50                   	push   %eax
8010059f:	e8 22 fe ff ff       	call   801003c6 <cprintf>
801005a4:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005a7:	83 ec 0c             	sub    $0xc,%esp
801005aa:	68 c5 81 10 80       	push   $0x801081c5
801005af:	e8 12 fe ff ff       	call   801003c6 <cprintf>
801005b4:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005b7:	83 ec 08             	sub    $0x8,%esp
801005ba:	8d 45 cc             	lea    -0x34(%ebp),%eax
801005bd:	50                   	push   %eax
801005be:	8d 45 08             	lea    0x8(%ebp),%eax
801005c1:	50                   	push   %eax
801005c2:	e8 db 46 00 00       	call   80104ca2 <getcallerpcs>
801005c7:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
801005ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801005d1:	eb 1c                	jmp    801005ef <panic+0x89>
    cprintf(" %p", pcs[i]);
801005d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801005d6:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
801005da:	83 ec 08             	sub    $0x8,%esp
801005dd:	50                   	push   %eax
801005de:	68 c7 81 10 80       	push   $0x801081c7
801005e3:	e8 de fd ff ff       	call   801003c6 <cprintf>
801005e8:	83 c4 10             	add    $0x10,%esp
  cons.locking = 0;
  cprintf("cpu%d: panic: ", cpu->id);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801005eb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801005ef:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801005f3:	7e de                	jle    801005d3 <panic+0x6d>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801005f5:	c7 05 c0 b5 10 80 01 	movl   $0x1,0x8010b5c0
801005fc:	00 00 00 
  for(;;)
    ;
801005ff:	eb fe                	jmp    801005ff <panic+0x99>

80100601 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100601:	55                   	push   %ebp
80100602:	89 e5                	mov    %esp,%ebp
80100604:	83 ec 18             	sub    $0x18,%esp
  int pos;
  
  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100607:	6a 0e                	push   $0xe
80100609:	68 d4 03 00 00       	push   $0x3d4
8010060e:	e8 de fc ff ff       	call   801002f1 <outb>
80100613:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
80100616:	68 d5 03 00 00       	push   $0x3d5
8010061b:	e8 b4 fc ff ff       	call   801002d4 <inb>
80100620:	83 c4 04             	add    $0x4,%esp
80100623:	0f b6 c0             	movzbl %al,%eax
80100626:	c1 e0 08             	shl    $0x8,%eax
80100629:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
8010062c:	6a 0f                	push   $0xf
8010062e:	68 d4 03 00 00       	push   $0x3d4
80100633:	e8 b9 fc ff ff       	call   801002f1 <outb>
80100638:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
8010063b:	68 d5 03 00 00       	push   $0x3d5
80100640:	e8 8f fc ff ff       	call   801002d4 <inb>
80100645:	83 c4 04             	add    $0x4,%esp
80100648:	0f b6 c0             	movzbl %al,%eax
8010064b:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
8010064e:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
80100652:	75 30                	jne    80100684 <cgaputc+0x83>
    pos += 80 - pos%80;
80100654:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80100657:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010065c:	89 c8                	mov    %ecx,%eax
8010065e:	f7 ea                	imul   %edx
80100660:	c1 fa 05             	sar    $0x5,%edx
80100663:	89 c8                	mov    %ecx,%eax
80100665:	c1 f8 1f             	sar    $0x1f,%eax
80100668:	29 c2                	sub    %eax,%edx
8010066a:	89 d0                	mov    %edx,%eax
8010066c:	c1 e0 02             	shl    $0x2,%eax
8010066f:	01 d0                	add    %edx,%eax
80100671:	c1 e0 04             	shl    $0x4,%eax
80100674:	29 c1                	sub    %eax,%ecx
80100676:	89 ca                	mov    %ecx,%edx
80100678:	b8 50 00 00 00       	mov    $0x50,%eax
8010067d:	29 d0                	sub    %edx,%eax
8010067f:	01 45 f4             	add    %eax,-0xc(%ebp)
80100682:	eb 34                	jmp    801006b8 <cgaputc+0xb7>
  else if(c == BACKSPACE){
80100684:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
8010068b:	75 0c                	jne    80100699 <cgaputc+0x98>
    if(pos > 0) --pos;
8010068d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100691:	7e 25                	jle    801006b8 <cgaputc+0xb7>
80100693:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
80100697:	eb 1f                	jmp    801006b8 <cgaputc+0xb7>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100699:	8b 0d 00 90 10 80    	mov    0x80109000,%ecx
8010069f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006a2:	8d 50 01             	lea    0x1(%eax),%edx
801006a5:	89 55 f4             	mov    %edx,-0xc(%ebp)
801006a8:	01 c0                	add    %eax,%eax
801006aa:	01 c8                	add    %ecx,%eax
801006ac:	8b 55 08             	mov    0x8(%ebp),%edx
801006af:	0f b6 d2             	movzbl %dl,%edx
801006b2:	80 ce 07             	or     $0x7,%dh
801006b5:	66 89 10             	mov    %dx,(%eax)
  
  if((pos/80) >= 24){  // Scroll up.
801006b8:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
801006bf:	7e 4c                	jle    8010070d <cgaputc+0x10c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801006c1:	a1 00 90 10 80       	mov    0x80109000,%eax
801006c6:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
801006cc:	a1 00 90 10 80       	mov    0x80109000,%eax
801006d1:	83 ec 04             	sub    $0x4,%esp
801006d4:	68 60 0e 00 00       	push   $0xe60
801006d9:	52                   	push   %edx
801006da:	50                   	push   %eax
801006db:	e8 2b 48 00 00       	call   80104f0b <memmove>
801006e0:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
801006e3:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801006e7:	b8 80 07 00 00       	mov    $0x780,%eax
801006ec:	2b 45 f4             	sub    -0xc(%ebp),%eax
801006ef:	8d 14 00             	lea    (%eax,%eax,1),%edx
801006f2:	a1 00 90 10 80       	mov    0x80109000,%eax
801006f7:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006fa:	01 c9                	add    %ecx,%ecx
801006fc:	01 c8                	add    %ecx,%eax
801006fe:	83 ec 04             	sub    $0x4,%esp
80100701:	52                   	push   %edx
80100702:	6a 00                	push   $0x0
80100704:	50                   	push   %eax
80100705:	e8 42 47 00 00       	call   80104e4c <memset>
8010070a:	83 c4 10             	add    $0x10,%esp
  }
  
  outb(CRTPORT, 14);
8010070d:	83 ec 08             	sub    $0x8,%esp
80100710:	6a 0e                	push   $0xe
80100712:	68 d4 03 00 00       	push   $0x3d4
80100717:	e8 d5 fb ff ff       	call   801002f1 <outb>
8010071c:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010071f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100722:	c1 f8 08             	sar    $0x8,%eax
80100725:	0f b6 c0             	movzbl %al,%eax
80100728:	83 ec 08             	sub    $0x8,%esp
8010072b:	50                   	push   %eax
8010072c:	68 d5 03 00 00       	push   $0x3d5
80100731:	e8 bb fb ff ff       	call   801002f1 <outb>
80100736:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
80100739:	83 ec 08             	sub    $0x8,%esp
8010073c:	6a 0f                	push   $0xf
8010073e:	68 d4 03 00 00       	push   $0x3d4
80100743:	e8 a9 fb ff ff       	call   801002f1 <outb>
80100748:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
8010074b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010074e:	0f b6 c0             	movzbl %al,%eax
80100751:	83 ec 08             	sub    $0x8,%esp
80100754:	50                   	push   %eax
80100755:	68 d5 03 00 00       	push   $0x3d5
8010075a:	e8 92 fb ff ff       	call   801002f1 <outb>
8010075f:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
80100762:	a1 00 90 10 80       	mov    0x80109000,%eax
80100767:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010076a:	01 d2                	add    %edx,%edx
8010076c:	01 d0                	add    %edx,%eax
8010076e:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
80100773:	90                   	nop
80100774:	c9                   	leave  
80100775:	c3                   	ret    

80100776 <consputc>:

void
consputc(int c)
{
80100776:	55                   	push   %ebp
80100777:	89 e5                	mov    %esp,%ebp
80100779:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
8010077c:	a1 c0 b5 10 80       	mov    0x8010b5c0,%eax
80100781:	85 c0                	test   %eax,%eax
80100783:	74 07                	je     8010078c <consputc+0x16>
    cli();
80100785:	e8 86 fb ff ff       	call   80100310 <cli>
    for(;;)
      ;
8010078a:	eb fe                	jmp    8010078a <consputc+0x14>
  }

  if(c == BACKSPACE){
8010078c:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100793:	75 29                	jne    801007be <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100795:	83 ec 0c             	sub    $0xc,%esp
80100798:	6a 08                	push   $0x8
8010079a:	e8 7a 60 00 00       	call   80106819 <uartputc>
8010079f:	83 c4 10             	add    $0x10,%esp
801007a2:	83 ec 0c             	sub    $0xc,%esp
801007a5:	6a 20                	push   $0x20
801007a7:	e8 6d 60 00 00       	call   80106819 <uartputc>
801007ac:	83 c4 10             	add    $0x10,%esp
801007af:	83 ec 0c             	sub    $0xc,%esp
801007b2:	6a 08                	push   $0x8
801007b4:	e8 60 60 00 00       	call   80106819 <uartputc>
801007b9:	83 c4 10             	add    $0x10,%esp
801007bc:	eb 0e                	jmp    801007cc <consputc+0x56>
  } else
    uartputc(c);
801007be:	83 ec 0c             	sub    $0xc,%esp
801007c1:	ff 75 08             	pushl  0x8(%ebp)
801007c4:	e8 50 60 00 00       	call   80106819 <uartputc>
801007c9:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
801007cc:	83 ec 0c             	sub    $0xc,%esp
801007cf:	ff 75 08             	pushl  0x8(%ebp)
801007d2:	e8 2a fe ff ff       	call   80100601 <cgaputc>
801007d7:	83 c4 10             	add    $0x10,%esp
}
801007da:	90                   	nop
801007db:	c9                   	leave  
801007dc:	c3                   	ret    

801007dd <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007dd:	55                   	push   %ebp
801007de:	89 e5                	mov    %esp,%ebp
801007e0:	83 ec 18             	sub    $0x18,%esp
  int c;

  acquire(&input.lock);
801007e3:	83 ec 0c             	sub    $0xc,%esp
801007e6:	68 c0 dd 10 80       	push   $0x8010ddc0
801007eb:	e8 f9 43 00 00       	call   80104be9 <acquire>
801007f0:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
801007f3:	e9 42 01 00 00       	jmp    8010093a <consoleintr+0x15d>
    switch(c){
801007f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007fb:	83 f8 10             	cmp    $0x10,%eax
801007fe:	74 1e                	je     8010081e <consoleintr+0x41>
80100800:	83 f8 10             	cmp    $0x10,%eax
80100803:	7f 0a                	jg     8010080f <consoleintr+0x32>
80100805:	83 f8 08             	cmp    $0x8,%eax
80100808:	74 69                	je     80100873 <consoleintr+0x96>
8010080a:	e9 99 00 00 00       	jmp    801008a8 <consoleintr+0xcb>
8010080f:	83 f8 15             	cmp    $0x15,%eax
80100812:	74 31                	je     80100845 <consoleintr+0x68>
80100814:	83 f8 7f             	cmp    $0x7f,%eax
80100817:	74 5a                	je     80100873 <consoleintr+0x96>
80100819:	e9 8a 00 00 00       	jmp    801008a8 <consoleintr+0xcb>
    case C('P'):  // Process listing.
      procdump();
8010081e:	e8 3d 42 00 00       	call   80104a60 <procdump>
      break;
80100823:	e9 12 01 00 00       	jmp    8010093a <consoleintr+0x15d>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100828:	a1 7c de 10 80       	mov    0x8010de7c,%eax
8010082d:	83 e8 01             	sub    $0x1,%eax
80100830:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 00 01 00 00       	push   $0x100
8010083d:	e8 34 ff ff ff       	call   80100776 <consputc>
80100842:	83 c4 10             	add    $0x10,%esp
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100845:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
8010084b:	a1 78 de 10 80       	mov    0x8010de78,%eax
80100850:	39 c2                	cmp    %eax,%edx
80100852:	0f 84 e2 00 00 00    	je     8010093a <consoleintr+0x15d>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100858:	a1 7c de 10 80       	mov    0x8010de7c,%eax
8010085d:	83 e8 01             	sub    $0x1,%eax
80100860:	83 e0 7f             	and    $0x7f,%eax
80100863:	0f b6 80 f4 dd 10 80 	movzbl -0x7fef220c(%eax),%eax
    switch(c){
    case C('P'):  // Process listing.
      procdump();
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010086a:	3c 0a                	cmp    $0xa,%al
8010086c:	75 ba                	jne    80100828 <consoleintr+0x4b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
        consputc(BACKSPACE);
      }
      break;
8010086e:	e9 c7 00 00 00       	jmp    8010093a <consoleintr+0x15d>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100873:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
80100879:	a1 78 de 10 80       	mov    0x8010de78,%eax
8010087e:	39 c2                	cmp    %eax,%edx
80100880:	0f 84 b4 00 00 00    	je     8010093a <consoleintr+0x15d>
        input.e--;
80100886:	a1 7c de 10 80       	mov    0x8010de7c,%eax
8010088b:	83 e8 01             	sub    $0x1,%eax
8010088e:	a3 7c de 10 80       	mov    %eax,0x8010de7c
        consputc(BACKSPACE);
80100893:	83 ec 0c             	sub    $0xc,%esp
80100896:	68 00 01 00 00       	push   $0x100
8010089b:	e8 d6 fe ff ff       	call   80100776 <consputc>
801008a0:	83 c4 10             	add    $0x10,%esp
      }
      break;
801008a3:	e9 92 00 00 00       	jmp    8010093a <consoleintr+0x15d>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801008ac:	0f 84 87 00 00 00    	je     80100939 <consoleintr+0x15c>
801008b2:	8b 15 7c de 10 80    	mov    0x8010de7c,%edx
801008b8:	a1 74 de 10 80       	mov    0x8010de74,%eax
801008bd:	29 c2                	sub    %eax,%edx
801008bf:	89 d0                	mov    %edx,%eax
801008c1:	83 f8 7f             	cmp    $0x7f,%eax
801008c4:	77 73                	ja     80100939 <consoleintr+0x15c>
        c = (c == '\r') ? '\n' : c;
801008c6:	83 7d f4 0d          	cmpl   $0xd,-0xc(%ebp)
801008ca:	74 05                	je     801008d1 <consoleintr+0xf4>
801008cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801008cf:	eb 05                	jmp    801008d6 <consoleintr+0xf9>
801008d1:	b8 0a 00 00 00       	mov    $0xa,%eax
801008d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
801008d9:	a1 7c de 10 80       	mov    0x8010de7c,%eax
801008de:	8d 50 01             	lea    0x1(%eax),%edx
801008e1:	89 15 7c de 10 80    	mov    %edx,0x8010de7c
801008e7:	83 e0 7f             	and    $0x7f,%eax
801008ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
801008ed:	88 90 f4 dd 10 80    	mov    %dl,-0x7fef220c(%eax)
        consputc(c);
801008f3:	83 ec 0c             	sub    $0xc,%esp
801008f6:	ff 75 f4             	pushl  -0xc(%ebp)
801008f9:	e8 78 fe ff ff       	call   80100776 <consputc>
801008fe:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100901:	83 7d f4 0a          	cmpl   $0xa,-0xc(%ebp)
80100905:	74 18                	je     8010091f <consoleintr+0x142>
80100907:	83 7d f4 04          	cmpl   $0x4,-0xc(%ebp)
8010090b:	74 12                	je     8010091f <consoleintr+0x142>
8010090d:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100912:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
80100918:	83 ea 80             	sub    $0xffffff80,%edx
8010091b:	39 d0                	cmp    %edx,%eax
8010091d:	75 1a                	jne    80100939 <consoleintr+0x15c>
          input.w = input.e;
8010091f:	a1 7c de 10 80       	mov    0x8010de7c,%eax
80100924:	a3 78 de 10 80       	mov    %eax,0x8010de78
          wakeup(&input.r);
80100929:	83 ec 0c             	sub    $0xc,%esp
8010092c:	68 74 de 10 80       	push   $0x8010de74
80100931:	e8 6f 40 00 00       	call   801049a5 <wakeup>
80100936:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
80100939:	90                   	nop
consoleintr(int (*getc)(void))
{
  int c;

  acquire(&input.lock);
  while((c = getc()) >= 0){
8010093a:	8b 45 08             	mov    0x8(%ebp),%eax
8010093d:	ff d0                	call   *%eax
8010093f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100942:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80100946:	0f 89 ac fe ff ff    	jns    801007f8 <consoleintr+0x1b>
        }
      }
      break;
    }
  }
  release(&input.lock);
8010094c:	83 ec 0c             	sub    $0xc,%esp
8010094f:	68 c0 dd 10 80       	push   $0x8010ddc0
80100954:	e8 f7 42 00 00       	call   80104c50 <release>
80100959:	83 c4 10             	add    $0x10,%esp
}
8010095c:	90                   	nop
8010095d:	c9                   	leave  
8010095e:	c3                   	ret    

8010095f <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
8010095f:	55                   	push   %ebp
80100960:	89 e5                	mov    %esp,%ebp
80100962:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
80100965:	83 ec 0c             	sub    $0xc,%esp
80100968:	ff 75 08             	pushl  0x8(%ebp)
8010096b:	e8 df 10 00 00       	call   80101a4f <iunlock>
80100970:	83 c4 10             	add    $0x10,%esp
  target = n;
80100973:	8b 45 10             	mov    0x10(%ebp),%eax
80100976:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&input.lock);
80100979:	83 ec 0c             	sub    $0xc,%esp
8010097c:	68 c0 dd 10 80       	push   $0x8010ddc0
80100981:	e8 63 42 00 00       	call   80104be9 <acquire>
80100986:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100989:	e9 ac 00 00 00       	jmp    80100a3a <consoleread+0xdb>
    while(input.r == input.w){
      if(proc->killed){
8010098e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100994:	8b 40 24             	mov    0x24(%eax),%eax
80100997:	85 c0                	test   %eax,%eax
80100999:	74 28                	je     801009c3 <consoleread+0x64>
        release(&input.lock);
8010099b:	83 ec 0c             	sub    $0xc,%esp
8010099e:	68 c0 dd 10 80       	push   $0x8010ddc0
801009a3:	e8 a8 42 00 00       	call   80104c50 <release>
801009a8:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
801009ab:	83 ec 0c             	sub    $0xc,%esp
801009ae:	ff 75 08             	pushl  0x8(%ebp)
801009b1:	e8 41 0f 00 00       	call   801018f7 <ilock>
801009b6:	83 c4 10             	add    $0x10,%esp
        return -1;
801009b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801009be:	e9 ab 00 00 00       	jmp    80100a6e <consoleread+0x10f>
      }
      sleep(&input.r, &input.lock);
801009c3:	83 ec 08             	sub    $0x8,%esp
801009c6:	68 c0 dd 10 80       	push   $0x8010ddc0
801009cb:	68 74 de 10 80       	push   $0x8010de74
801009d0:	e8 e5 3e 00 00       	call   801048ba <sleep>
801009d5:	83 c4 10             	add    $0x10,%esp

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
    while(input.r == input.w){
801009d8:	8b 15 74 de 10 80    	mov    0x8010de74,%edx
801009de:	a1 78 de 10 80       	mov    0x8010de78,%eax
801009e3:	39 c2                	cmp    %eax,%edx
801009e5:	74 a7                	je     8010098e <consoleread+0x2f>
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &input.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
801009e7:	a1 74 de 10 80       	mov    0x8010de74,%eax
801009ec:	8d 50 01             	lea    0x1(%eax),%edx
801009ef:	89 15 74 de 10 80    	mov    %edx,0x8010de74
801009f5:	83 e0 7f             	and    $0x7f,%eax
801009f8:	0f b6 80 f4 dd 10 80 	movzbl -0x7fef220c(%eax),%eax
801009ff:	0f be c0             	movsbl %al,%eax
80100a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a05:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a09:	75 17                	jne    80100a22 <consoleread+0xc3>
      if(n < target){
80100a0b:	8b 45 10             	mov    0x10(%ebp),%eax
80100a0e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80100a11:	73 2f                	jae    80100a42 <consoleread+0xe3>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100a13:	a1 74 de 10 80       	mov    0x8010de74,%eax
80100a18:	83 e8 01             	sub    $0x1,%eax
80100a1b:	a3 74 de 10 80       	mov    %eax,0x8010de74
      }
      break;
80100a20:	eb 20                	jmp    80100a42 <consoleread+0xe3>
    }
    *dst++ = c;
80100a22:	8b 45 0c             	mov    0xc(%ebp),%eax
80100a25:	8d 50 01             	lea    0x1(%eax),%edx
80100a28:	89 55 0c             	mov    %edx,0xc(%ebp)
80100a2b:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100a2e:	88 10                	mov    %dl,(%eax)
    --n;
80100a30:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100a34:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100a38:	74 0b                	je     80100a45 <consoleread+0xe6>
  int c;

  iunlock(ip);
  target = n;
  acquire(&input.lock);
  while(n > 0){
80100a3a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100a3e:	7f 98                	jg     801009d8 <consoleread+0x79>
80100a40:	eb 04                	jmp    80100a46 <consoleread+0xe7>
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
80100a42:	90                   	nop
80100a43:	eb 01                	jmp    80100a46 <consoleread+0xe7>
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
80100a45:	90                   	nop
  }
  release(&input.lock);
80100a46:	83 ec 0c             	sub    $0xc,%esp
80100a49:	68 c0 dd 10 80       	push   $0x8010ddc0
80100a4e:	e8 fd 41 00 00       	call   80104c50 <release>
80100a53:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100a56:	83 ec 0c             	sub    $0xc,%esp
80100a59:	ff 75 08             	pushl  0x8(%ebp)
80100a5c:	e8 96 0e 00 00       	call   801018f7 <ilock>
80100a61:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100a64:	8b 45 10             	mov    0x10(%ebp),%eax
80100a67:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100a6a:	29 c2                	sub    %eax,%edx
80100a6c:	89 d0                	mov    %edx,%eax
}
80100a6e:	c9                   	leave  
80100a6f:	c3                   	ret    

80100a70 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100a70:	55                   	push   %ebp
80100a71:	89 e5                	mov    %esp,%ebp
80100a73:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100a76:	83 ec 0c             	sub    $0xc,%esp
80100a79:	ff 75 08             	pushl  0x8(%ebp)
80100a7c:	e8 ce 0f 00 00       	call   80101a4f <iunlock>
80100a81:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100a84:	83 ec 0c             	sub    $0xc,%esp
80100a87:	68 e0 b5 10 80       	push   $0x8010b5e0
80100a8c:	e8 58 41 00 00       	call   80104be9 <acquire>
80100a91:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100a94:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100a9b:	eb 21                	jmp    80100abe <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100a9d:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100aa0:	8b 45 0c             	mov    0xc(%ebp),%eax
80100aa3:	01 d0                	add    %edx,%eax
80100aa5:	0f b6 00             	movzbl (%eax),%eax
80100aa8:	0f be c0             	movsbl %al,%eax
80100aab:	0f b6 c0             	movzbl %al,%eax
80100aae:	83 ec 0c             	sub    $0xc,%esp
80100ab1:	50                   	push   %eax
80100ab2:	e8 bf fc ff ff       	call   80100776 <consputc>
80100ab7:	83 c4 10             	add    $0x10,%esp
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
80100aba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100abe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100ac1:	3b 45 10             	cmp    0x10(%ebp),%eax
80100ac4:	7c d7                	jl     80100a9d <consolewrite+0x2d>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
80100ac6:	83 ec 0c             	sub    $0xc,%esp
80100ac9:	68 e0 b5 10 80       	push   $0x8010b5e0
80100ace:	e8 7d 41 00 00       	call   80104c50 <release>
80100ad3:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ad6:	83 ec 0c             	sub    $0xc,%esp
80100ad9:	ff 75 08             	pushl  0x8(%ebp)
80100adc:	e8 16 0e 00 00       	call   801018f7 <ilock>
80100ae1:	83 c4 10             	add    $0x10,%esp

  return n;
80100ae4:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100ae7:	c9                   	leave  
80100ae8:	c3                   	ret    

80100ae9 <consoleinit>:

void
consoleinit(void)
{
80100ae9:	55                   	push   %ebp
80100aea:	89 e5                	mov    %esp,%ebp
80100aec:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100aef:	83 ec 08             	sub    $0x8,%esp
80100af2:	68 cb 81 10 80       	push   $0x801081cb
80100af7:	68 e0 b5 10 80       	push   $0x8010b5e0
80100afc:	e8 c6 40 00 00       	call   80104bc7 <initlock>
80100b01:	83 c4 10             	add    $0x10,%esp
  initlock(&input.lock, "input");
80100b04:	83 ec 08             	sub    $0x8,%esp
80100b07:	68 d3 81 10 80       	push   $0x801081d3
80100b0c:	68 c0 dd 10 80       	push   $0x8010ddc0
80100b11:	e8 b1 40 00 00       	call   80104bc7 <initlock>
80100b16:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b19:	c7 05 2c e8 10 80 70 	movl   $0x80100a70,0x8010e82c
80100b20:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b23:	c7 05 28 e8 10 80 5f 	movl   $0x8010095f,0x8010e828
80100b2a:	09 10 80 
  cons.locking = 1;
80100b2d:	c7 05 14 b6 10 80 01 	movl   $0x1,0x8010b614
80100b34:	00 00 00 

  picenable(IRQ_KBD);
80100b37:	83 ec 0c             	sub    $0xc,%esp
80100b3a:	6a 01                	push   $0x1
80100b3c:	e8 dd 2f 00 00       	call   80103b1e <picenable>
80100b41:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_KBD, 0);
80100b44:	83 ec 08             	sub    $0x8,%esp
80100b47:	6a 00                	push   $0x0
80100b49:	6a 01                	push   $0x1
80100b4b:	e8 d5 1e 00 00       	call   80102a25 <ioapicenable>
80100b50:	83 c4 10             	add    $0x10,%esp
}
80100b53:	90                   	nop
80100b54:	c9                   	leave  
80100b55:	c3                   	ret    

80100b56 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b56:	55                   	push   %ebp
80100b57:	89 e5                	mov    %esp,%ebp
80100b59:	81 ec 18 01 00 00    	sub    $0x118,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  if((ip = namei(path)) == 0)
80100b5f:	83 ec 0c             	sub    $0xc,%esp
80100b62:	ff 75 08             	pushl  0x8(%ebp)
80100b65:	e8 45 19 00 00       	call   801024af <namei>
80100b6a:	83 c4 10             	add    $0x10,%esp
80100b6d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b70:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100b74:	75 0a                	jne    80100b80 <exec+0x2a>
    return -1;
80100b76:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100b7b:	e9 c4 03 00 00       	jmp    80100f44 <exec+0x3ee>
  ilock(ip);
80100b80:	83 ec 0c             	sub    $0xc,%esp
80100b83:	ff 75 d8             	pushl  -0x28(%ebp)
80100b86:	e8 6c 0d 00 00       	call   801018f7 <ilock>
80100b8b:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100b8e:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
80100b95:	6a 34                	push   $0x34
80100b97:	6a 00                	push   $0x0
80100b99:	8d 85 0c ff ff ff    	lea    -0xf4(%ebp),%eax
80100b9f:	50                   	push   %eax
80100ba0:	ff 75 d8             	pushl  -0x28(%ebp)
80100ba3:	e8 b7 12 00 00       	call   80101e5f <readi>
80100ba8:	83 c4 10             	add    $0x10,%esp
80100bab:	83 f8 33             	cmp    $0x33,%eax
80100bae:	0f 86 44 03 00 00    	jbe    80100ef8 <exec+0x3a2>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100bb4:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100bba:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100bbf:	0f 85 36 03 00 00    	jne    80100efb <exec+0x3a5>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100bc5:	e8 a4 6d 00 00       	call   8010796e <setupkvm>
80100bca:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100bcd:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100bd1:	0f 84 27 03 00 00    	je     80100efe <exec+0x3a8>
    goto bad;

  // Load program into memory.
  sz = 0;
80100bd7:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bde:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100be5:	8b 85 28 ff ff ff    	mov    -0xd8(%ebp),%eax
80100beb:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100bee:	e9 ab 00 00 00       	jmp    80100c9e <exec+0x148>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100bf3:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100bf6:	6a 20                	push   $0x20
80100bf8:	50                   	push   %eax
80100bf9:	8d 85 ec fe ff ff    	lea    -0x114(%ebp),%eax
80100bff:	50                   	push   %eax
80100c00:	ff 75 d8             	pushl  -0x28(%ebp)
80100c03:	e8 57 12 00 00       	call   80101e5f <readi>
80100c08:	83 c4 10             	add    $0x10,%esp
80100c0b:	83 f8 20             	cmp    $0x20,%eax
80100c0e:	0f 85 ed 02 00 00    	jne    80100f01 <exec+0x3ab>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c14:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100c1a:	83 f8 01             	cmp    $0x1,%eax
80100c1d:	75 71                	jne    80100c90 <exec+0x13a>
      continue;
    if(ph.memsz < ph.filesz)
80100c1f:	8b 95 00 ff ff ff    	mov    -0x100(%ebp),%edx
80100c25:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100c2b:	39 c2                	cmp    %eax,%edx
80100c2d:	0f 82 d1 02 00 00    	jb     80100f04 <exec+0x3ae>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c33:	8b 95 f4 fe ff ff    	mov    -0x10c(%ebp),%edx
80100c39:	8b 85 00 ff ff ff    	mov    -0x100(%ebp),%eax
80100c3f:	01 d0                	add    %edx,%eax
80100c41:	83 ec 04             	sub    $0x4,%esp
80100c44:	50                   	push   %eax
80100c45:	ff 75 e0             	pushl  -0x20(%ebp)
80100c48:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c4b:	e8 c5 70 00 00       	call   80107d15 <allocuvm>
80100c50:	83 c4 10             	add    $0x10,%esp
80100c53:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100c56:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100c5a:	0f 84 a7 02 00 00    	je     80100f07 <exec+0x3b1>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c60:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100c66:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100c6c:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
80100c72:	83 ec 0c             	sub    $0xc,%esp
80100c75:	52                   	push   %edx
80100c76:	50                   	push   %eax
80100c77:	ff 75 d8             	pushl  -0x28(%ebp)
80100c7a:	51                   	push   %ecx
80100c7b:	ff 75 d4             	pushl  -0x2c(%ebp)
80100c7e:	e8 bb 6f 00 00       	call   80107c3e <loaduvm>
80100c83:	83 c4 20             	add    $0x20,%esp
80100c86:	85 c0                	test   %eax,%eax
80100c88:	0f 88 7c 02 00 00    	js     80100f0a <exec+0x3b4>
80100c8e:	eb 01                	jmp    80100c91 <exec+0x13b>
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
      continue;
80100c90:	90                   	nop
  if((pgdir = setupkvm()) == 0)
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c91:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100c95:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c98:	83 c0 20             	add    $0x20,%eax
80100c9b:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c9e:	0f b7 85 38 ff ff ff 	movzwl -0xc8(%ebp),%eax
80100ca5:	0f b7 c0             	movzwl %ax,%eax
80100ca8:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80100cab:	0f 8f 42 ff ff ff    	jg     80100bf3 <exec+0x9d>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100cb1:	83 ec 0c             	sub    $0xc,%esp
80100cb4:	ff 75 d8             	pushl  -0x28(%ebp)
80100cb7:	e8 f5 0e 00 00       	call   80101bb1 <iunlockput>
80100cbc:	83 c4 10             	add    $0x10,%esp
  ip = 0;
80100cbf:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100cc6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cc9:	05 ff 0f 00 00       	add    $0xfff,%eax
80100cce:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100cd3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100cd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100cd9:	05 00 20 00 00       	add    $0x2000,%eax
80100cde:	83 ec 04             	sub    $0x4,%esp
80100ce1:	50                   	push   %eax
80100ce2:	ff 75 e0             	pushl  -0x20(%ebp)
80100ce5:	ff 75 d4             	pushl  -0x2c(%ebp)
80100ce8:	e8 28 70 00 00       	call   80107d15 <allocuvm>
80100ced:	83 c4 10             	add    $0x10,%esp
80100cf0:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100cf3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100cf7:	0f 84 10 02 00 00    	je     80100f0d <exec+0x3b7>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100cfd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d00:	2d 00 20 00 00       	sub    $0x2000,%eax
80100d05:	83 ec 08             	sub    $0x8,%esp
80100d08:	50                   	push   %eax
80100d09:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d0c:	e8 2a 72 00 00       	call   80107f3b <clearpteu>
80100d11:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100d14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d17:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100d1a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100d21:	e9 96 00 00 00       	jmp    80100dbc <exec+0x266>
    if(argc >= MAXARG)
80100d26:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100d2a:	0f 87 e0 01 00 00    	ja     80100f10 <exec+0x3ba>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d30:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d33:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d3a:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d3d:	01 d0                	add    %edx,%eax
80100d3f:	8b 00                	mov    (%eax),%eax
80100d41:	83 ec 0c             	sub    $0xc,%esp
80100d44:	50                   	push   %eax
80100d45:	e8 4f 43 00 00       	call   80105099 <strlen>
80100d4a:	83 c4 10             	add    $0x10,%esp
80100d4d:	89 c2                	mov    %eax,%edx
80100d4f:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100d52:	29 d0                	sub    %edx,%eax
80100d54:	83 e8 01             	sub    $0x1,%eax
80100d57:	83 e0 fc             	and    $0xfffffffc,%eax
80100d5a:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100d5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d60:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d67:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d6a:	01 d0                	add    %edx,%eax
80100d6c:	8b 00                	mov    (%eax),%eax
80100d6e:	83 ec 0c             	sub    $0xc,%esp
80100d71:	50                   	push   %eax
80100d72:	e8 22 43 00 00       	call   80105099 <strlen>
80100d77:	83 c4 10             	add    $0x10,%esp
80100d7a:	83 c0 01             	add    $0x1,%eax
80100d7d:	89 c1                	mov    %eax,%ecx
80100d7f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100d89:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d8c:	01 d0                	add    %edx,%eax
80100d8e:	8b 00                	mov    (%eax),%eax
80100d90:	51                   	push   %ecx
80100d91:	50                   	push   %eax
80100d92:	ff 75 dc             	pushl  -0x24(%ebp)
80100d95:	ff 75 d4             	pushl  -0x2c(%ebp)
80100d98:	e8 42 73 00 00       	call   801080df <copyout>
80100d9d:	83 c4 10             	add    $0x10,%esp
80100da0:	85 c0                	test   %eax,%eax
80100da2:	0f 88 6b 01 00 00    	js     80100f13 <exec+0x3bd>
      goto bad;
    ustack[3+argc] = sp;
80100da8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dab:	8d 50 03             	lea    0x3(%eax),%edx
80100dae:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100db1:	89 84 95 40 ff ff ff 	mov    %eax,-0xc0(%ebp,%edx,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100db8:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100dbc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dbf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100dc6:	8b 45 0c             	mov    0xc(%ebp),%eax
80100dc9:	01 d0                	add    %edx,%eax
80100dcb:	8b 00                	mov    (%eax),%eax
80100dcd:	85 c0                	test   %eax,%eax
80100dcf:	0f 85 51 ff ff ff    	jne    80100d26 <exec+0x1d0>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100dd5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dd8:	83 c0 03             	add    $0x3,%eax
80100ddb:	c7 84 85 40 ff ff ff 	movl   $0x0,-0xc0(%ebp,%eax,4)
80100de2:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100de6:	c7 85 40 ff ff ff ff 	movl   $0xffffffff,-0xc0(%ebp)
80100ded:	ff ff ff 
  ustack[1] = argc;
80100df0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100df3:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100df9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfc:	83 c0 01             	add    $0x1,%eax
80100dff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e06:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e09:	29 d0                	sub    %edx,%eax
80100e0b:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)

  sp -= (3+argc+1) * 4;
80100e11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e14:	83 c0 04             	add    $0x4,%eax
80100e17:	c1 e0 02             	shl    $0x2,%eax
80100e1a:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e1d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e20:	83 c0 04             	add    $0x4,%eax
80100e23:	c1 e0 02             	shl    $0x2,%eax
80100e26:	50                   	push   %eax
80100e27:	8d 85 40 ff ff ff    	lea    -0xc0(%ebp),%eax
80100e2d:	50                   	push   %eax
80100e2e:	ff 75 dc             	pushl  -0x24(%ebp)
80100e31:	ff 75 d4             	pushl  -0x2c(%ebp)
80100e34:	e8 a6 72 00 00       	call   801080df <copyout>
80100e39:	83 c4 10             	add    $0x10,%esp
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	0f 88 d2 00 00 00    	js     80100f16 <exec+0x3c0>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e44:	8b 45 08             	mov    0x8(%ebp),%eax
80100e47:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100e4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100e50:	eb 17                	jmp    80100e69 <exec+0x313>
    if(*s == '/')
80100e52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e55:	0f b6 00             	movzbl (%eax),%eax
80100e58:	3c 2f                	cmp    $0x2f,%al
80100e5a:	75 09                	jne    80100e65 <exec+0x30f>
      last = s+1;
80100e5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e5f:	83 c0 01             	add    $0x1,%eax
80100e62:	89 45 f0             	mov    %eax,-0x10(%ebp)
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100e65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100e69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100e6c:	0f b6 00             	movzbl (%eax),%eax
80100e6f:	84 c0                	test   %al,%al
80100e71:	75 df                	jne    80100e52 <exec+0x2fc>
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100e73:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e79:	83 c0 6c             	add    $0x6c,%eax
80100e7c:	83 ec 04             	sub    $0x4,%esp
80100e7f:	6a 10                	push   $0x10
80100e81:	ff 75 f0             	pushl  -0x10(%ebp)
80100e84:	50                   	push   %eax
80100e85:	e8 c5 41 00 00       	call   8010504f <safestrcpy>
80100e8a:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100e8d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e93:	8b 40 04             	mov    0x4(%eax),%eax
80100e96:	89 45 d0             	mov    %eax,-0x30(%ebp)
  proc->pgdir = pgdir;
80100e99:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100e9f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100ea2:	89 50 04             	mov    %edx,0x4(%eax)
  proc->sz = sz;
80100ea5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eab:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100eae:	89 10                	mov    %edx,(%eax)
  proc->tf->eip = elf.entry;  // main
80100eb0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100eb6:	8b 40 18             	mov    0x18(%eax),%eax
80100eb9:	8b 95 24 ff ff ff    	mov    -0xdc(%ebp),%edx
80100ebf:	89 50 38             	mov    %edx,0x38(%eax)
  proc->tf->esp = sp;
80100ec2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ec8:	8b 40 18             	mov    0x18(%eax),%eax
80100ecb:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100ece:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(proc);
80100ed1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100ed7:	83 ec 0c             	sub    $0xc,%esp
80100eda:	50                   	push   %eax
80100edb:	e8 75 6b 00 00       	call   80107a55 <switchuvm>
80100ee0:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100ee3:	83 ec 0c             	sub    $0xc,%esp
80100ee6:	ff 75 d0             	pushl  -0x30(%ebp)
80100ee9:	e8 ad 6f 00 00       	call   80107e9b <freevm>
80100eee:	83 c4 10             	add    $0x10,%esp
  return 0;
80100ef1:	b8 00 00 00 00       	mov    $0x0,%eax
80100ef6:	eb 4c                	jmp    80100f44 <exec+0x3ee>
  ilock(ip);
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) < sizeof(elf))
    goto bad;
80100ef8:	90                   	nop
80100ef9:	eb 1c                	jmp    80100f17 <exec+0x3c1>
  if(elf.magic != ELF_MAGIC)
    goto bad;
80100efb:	90                   	nop
80100efc:	eb 19                	jmp    80100f17 <exec+0x3c1>

  if((pgdir = setupkvm()) == 0)
    goto bad;
80100efe:	90                   	nop
80100eff:	eb 16                	jmp    80100f17 <exec+0x3c1>

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
80100f01:	90                   	nop
80100f02:	eb 13                	jmp    80100f17 <exec+0x3c1>
    if(ph.type != ELF_PROG_LOAD)
      continue;
    if(ph.memsz < ph.filesz)
      goto bad;
80100f04:	90                   	nop
80100f05:	eb 10                	jmp    80100f17 <exec+0x3c1>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
      goto bad;
80100f07:	90                   	nop
80100f08:	eb 0d                	jmp    80100f17 <exec+0x3c1>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
80100f0a:	90                   	nop
80100f0b:	eb 0a                	jmp    80100f17 <exec+0x3c1>

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
80100f0d:	90                   	nop
80100f0e:	eb 07                	jmp    80100f17 <exec+0x3c1>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
80100f10:	90                   	nop
80100f11:	eb 04                	jmp    80100f17 <exec+0x3c1>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
80100f13:	90                   	nop
80100f14:	eb 01                	jmp    80100f17 <exec+0x3c1>
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;
80100f16:	90                   	nop
  switchuvm(proc);
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
80100f17:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100f1b:	74 0e                	je     80100f2b <exec+0x3d5>
    freevm(pgdir);
80100f1d:	83 ec 0c             	sub    $0xc,%esp
80100f20:	ff 75 d4             	pushl  -0x2c(%ebp)
80100f23:	e8 73 6f 00 00       	call   80107e9b <freevm>
80100f28:	83 c4 10             	add    $0x10,%esp
  if(ip)
80100f2b:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100f2f:	74 0e                	je     80100f3f <exec+0x3e9>
    iunlockput(ip);
80100f31:	83 ec 0c             	sub    $0xc,%esp
80100f34:	ff 75 d8             	pushl  -0x28(%ebp)
80100f37:	e8 75 0c 00 00       	call   80101bb1 <iunlockput>
80100f3c:	83 c4 10             	add    $0x10,%esp
  return -1;
80100f3f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f44:	c9                   	leave  
80100f45:	c3                   	ret    

80100f46 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f46:	55                   	push   %ebp
80100f47:	89 e5                	mov    %esp,%ebp
80100f49:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80100f4c:	83 ec 08             	sub    $0x8,%esp
80100f4f:	68 d9 81 10 80       	push   $0x801081d9
80100f54:	68 80 de 10 80       	push   $0x8010de80
80100f59:	e8 69 3c 00 00       	call   80104bc7 <initlock>
80100f5e:	83 c4 10             	add    $0x10,%esp
}
80100f61:	90                   	nop
80100f62:	c9                   	leave  
80100f63:	c3                   	ret    

80100f64 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f64:	55                   	push   %ebp
80100f65:	89 e5                	mov    %esp,%ebp
80100f67:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80100f6a:	83 ec 0c             	sub    $0xc,%esp
80100f6d:	68 80 de 10 80       	push   $0x8010de80
80100f72:	e8 72 3c 00 00       	call   80104be9 <acquire>
80100f77:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f7a:	c7 45 f4 b4 de 10 80 	movl   $0x8010deb4,-0xc(%ebp)
80100f81:	eb 2d                	jmp    80100fb0 <filealloc+0x4c>
    if(f->ref == 0){
80100f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f86:	8b 40 04             	mov    0x4(%eax),%eax
80100f89:	85 c0                	test   %eax,%eax
80100f8b:	75 1f                	jne    80100fac <filealloc+0x48>
      f->ref = 1;
80100f8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f90:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80100f97:	83 ec 0c             	sub    $0xc,%esp
80100f9a:	68 80 de 10 80       	push   $0x8010de80
80100f9f:	e8 ac 3c 00 00       	call   80104c50 <release>
80100fa4:	83 c4 10             	add    $0x10,%esp
      return f;
80100fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100faa:	eb 23                	jmp    80100fcf <filealloc+0x6b>
filealloc(void)
{
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100fac:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
80100fb0:	b8 14 e8 10 80       	mov    $0x8010e814,%eax
80100fb5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100fb8:	72 c9                	jb     80100f83 <filealloc+0x1f>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100fba:	83 ec 0c             	sub    $0xc,%esp
80100fbd:	68 80 de 10 80       	push   $0x8010de80
80100fc2:	e8 89 3c 00 00       	call   80104c50 <release>
80100fc7:	83 c4 10             	add    $0x10,%esp
  return 0;
80100fca:	b8 00 00 00 00       	mov    $0x0,%eax
}
80100fcf:	c9                   	leave  
80100fd0:	c3                   	ret    

80100fd1 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100fd1:	55                   	push   %ebp
80100fd2:	89 e5                	mov    %esp,%ebp
80100fd4:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80100fd7:	83 ec 0c             	sub    $0xc,%esp
80100fda:	68 80 de 10 80       	push   $0x8010de80
80100fdf:	e8 05 3c 00 00       	call   80104be9 <acquire>
80100fe4:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80100fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80100fea:	8b 40 04             	mov    0x4(%eax),%eax
80100fed:	85 c0                	test   %eax,%eax
80100fef:	7f 0d                	jg     80100ffe <filedup+0x2d>
    panic("filedup");
80100ff1:	83 ec 0c             	sub    $0xc,%esp
80100ff4:	68 e0 81 10 80       	push   $0x801081e0
80100ff9:	e8 68 f5 ff ff       	call   80100566 <panic>
  f->ref++;
80100ffe:	8b 45 08             	mov    0x8(%ebp),%eax
80101001:	8b 40 04             	mov    0x4(%eax),%eax
80101004:	8d 50 01             	lea    0x1(%eax),%edx
80101007:	8b 45 08             	mov    0x8(%ebp),%eax
8010100a:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
8010100d:	83 ec 0c             	sub    $0xc,%esp
80101010:	68 80 de 10 80       	push   $0x8010de80
80101015:	e8 36 3c 00 00       	call   80104c50 <release>
8010101a:	83 c4 10             	add    $0x10,%esp
  return f;
8010101d:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101020:	c9                   	leave  
80101021:	c3                   	ret    

80101022 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101022:	55                   	push   %ebp
80101023:	89 e5                	mov    %esp,%ebp
80101025:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
80101028:	83 ec 0c             	sub    $0xc,%esp
8010102b:	68 80 de 10 80       	push   $0x8010de80
80101030:	e8 b4 3b 00 00       	call   80104be9 <acquire>
80101035:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
80101038:	8b 45 08             	mov    0x8(%ebp),%eax
8010103b:	8b 40 04             	mov    0x4(%eax),%eax
8010103e:	85 c0                	test   %eax,%eax
80101040:	7f 0d                	jg     8010104f <fileclose+0x2d>
    panic("fileclose");
80101042:	83 ec 0c             	sub    $0xc,%esp
80101045:	68 e8 81 10 80       	push   $0x801081e8
8010104a:	e8 17 f5 ff ff       	call   80100566 <panic>
  if(--f->ref > 0){
8010104f:	8b 45 08             	mov    0x8(%ebp),%eax
80101052:	8b 40 04             	mov    0x4(%eax),%eax
80101055:	8d 50 ff             	lea    -0x1(%eax),%edx
80101058:	8b 45 08             	mov    0x8(%ebp),%eax
8010105b:	89 50 04             	mov    %edx,0x4(%eax)
8010105e:	8b 45 08             	mov    0x8(%ebp),%eax
80101061:	8b 40 04             	mov    0x4(%eax),%eax
80101064:	85 c0                	test   %eax,%eax
80101066:	7e 15                	jle    8010107d <fileclose+0x5b>
    release(&ftable.lock);
80101068:	83 ec 0c             	sub    $0xc,%esp
8010106b:	68 80 de 10 80       	push   $0x8010de80
80101070:	e8 db 3b 00 00       	call   80104c50 <release>
80101075:	83 c4 10             	add    $0x10,%esp
80101078:	e9 8b 00 00 00       	jmp    80101108 <fileclose+0xe6>
    return;
  }
  ff = *f;
8010107d:	8b 45 08             	mov    0x8(%ebp),%eax
80101080:	8b 10                	mov    (%eax),%edx
80101082:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101085:	8b 50 04             	mov    0x4(%eax),%edx
80101088:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010108b:	8b 50 08             	mov    0x8(%eax),%edx
8010108e:	89 55 e8             	mov    %edx,-0x18(%ebp)
80101091:	8b 50 0c             	mov    0xc(%eax),%edx
80101094:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101097:	8b 50 10             	mov    0x10(%eax),%edx
8010109a:	89 55 f0             	mov    %edx,-0x10(%ebp)
8010109d:	8b 40 14             	mov    0x14(%eax),%eax
801010a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
801010a3:	8b 45 08             	mov    0x8(%ebp),%eax
801010a6:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
801010ad:	8b 45 08             	mov    0x8(%ebp),%eax
801010b0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
801010b6:	83 ec 0c             	sub    $0xc,%esp
801010b9:	68 80 de 10 80       	push   $0x8010de80
801010be:	e8 8d 3b 00 00       	call   80104c50 <release>
801010c3:	83 c4 10             	add    $0x10,%esp
  
  if(ff.type == FD_PIPE)
801010c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010c9:	83 f8 01             	cmp    $0x1,%eax
801010cc:	75 19                	jne    801010e7 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
801010ce:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
801010d2:	0f be d0             	movsbl %al,%edx
801010d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801010d8:	83 ec 08             	sub    $0x8,%esp
801010db:	52                   	push   %edx
801010dc:	50                   	push   %eax
801010dd:	e8 a5 2c 00 00       	call   80103d87 <pipeclose>
801010e2:	83 c4 10             	add    $0x10,%esp
801010e5:	eb 21                	jmp    80101108 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801010e7:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010ea:	83 f8 02             	cmp    $0x2,%eax
801010ed:	75 19                	jne    80101108 <fileclose+0xe6>
    begin_trans();
801010ef:	e8 87 21 00 00       	call   8010327b <begin_trans>
    iput(ff.ip);
801010f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801010f7:	83 ec 0c             	sub    $0xc,%esp
801010fa:	50                   	push   %eax
801010fb:	e8 c1 09 00 00       	call   80101ac1 <iput>
80101100:	83 c4 10             	add    $0x10,%esp
    commit_trans();
80101103:	e8 c6 21 00 00       	call   801032ce <commit_trans>
  }
}
80101108:	c9                   	leave  
80101109:	c3                   	ret    

8010110a <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
8010110a:	55                   	push   %ebp
8010110b:	89 e5                	mov    %esp,%ebp
8010110d:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
80101110:	8b 45 08             	mov    0x8(%ebp),%eax
80101113:	8b 00                	mov    (%eax),%eax
80101115:	83 f8 02             	cmp    $0x2,%eax
80101118:	75 40                	jne    8010115a <filestat+0x50>
    ilock(f->ip);
8010111a:	8b 45 08             	mov    0x8(%ebp),%eax
8010111d:	8b 40 10             	mov    0x10(%eax),%eax
80101120:	83 ec 0c             	sub    $0xc,%esp
80101123:	50                   	push   %eax
80101124:	e8 ce 07 00 00       	call   801018f7 <ilock>
80101129:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
8010112c:	8b 45 08             	mov    0x8(%ebp),%eax
8010112f:	8b 40 10             	mov    0x10(%eax),%eax
80101132:	83 ec 08             	sub    $0x8,%esp
80101135:	ff 75 0c             	pushl  0xc(%ebp)
80101138:	50                   	push   %eax
80101139:	e8 db 0c 00 00       	call   80101e19 <stati>
8010113e:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
80101141:	8b 45 08             	mov    0x8(%ebp),%eax
80101144:	8b 40 10             	mov    0x10(%eax),%eax
80101147:	83 ec 0c             	sub    $0xc,%esp
8010114a:	50                   	push   %eax
8010114b:	e8 ff 08 00 00       	call   80101a4f <iunlock>
80101150:	83 c4 10             	add    $0x10,%esp
    return 0;
80101153:	b8 00 00 00 00       	mov    $0x0,%eax
80101158:	eb 05                	jmp    8010115f <filestat+0x55>
  }
  return -1;
8010115a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010115f:	c9                   	leave  
80101160:	c3                   	ret    

80101161 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101161:	55                   	push   %ebp
80101162:	89 e5                	mov    %esp,%ebp
80101164:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101167:	8b 45 08             	mov    0x8(%ebp),%eax
8010116a:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010116e:	84 c0                	test   %al,%al
80101170:	75 0a                	jne    8010117c <fileread+0x1b>
    return -1;
80101172:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101177:	e9 9b 00 00 00       	jmp    80101217 <fileread+0xb6>
  if(f->type == FD_PIPE)
8010117c:	8b 45 08             	mov    0x8(%ebp),%eax
8010117f:	8b 00                	mov    (%eax),%eax
80101181:	83 f8 01             	cmp    $0x1,%eax
80101184:	75 1a                	jne    801011a0 <fileread+0x3f>
    return piperead(f->pipe, addr, n);
80101186:	8b 45 08             	mov    0x8(%ebp),%eax
80101189:	8b 40 0c             	mov    0xc(%eax),%eax
8010118c:	83 ec 04             	sub    $0x4,%esp
8010118f:	ff 75 10             	pushl  0x10(%ebp)
80101192:	ff 75 0c             	pushl  0xc(%ebp)
80101195:	50                   	push   %eax
80101196:	e8 94 2d 00 00       	call   80103f2f <piperead>
8010119b:	83 c4 10             	add    $0x10,%esp
8010119e:	eb 77                	jmp    80101217 <fileread+0xb6>
  if(f->type == FD_INODE){
801011a0:	8b 45 08             	mov    0x8(%ebp),%eax
801011a3:	8b 00                	mov    (%eax),%eax
801011a5:	83 f8 02             	cmp    $0x2,%eax
801011a8:	75 60                	jne    8010120a <fileread+0xa9>
    ilock(f->ip);
801011aa:	8b 45 08             	mov    0x8(%ebp),%eax
801011ad:	8b 40 10             	mov    0x10(%eax),%eax
801011b0:	83 ec 0c             	sub    $0xc,%esp
801011b3:	50                   	push   %eax
801011b4:	e8 3e 07 00 00       	call   801018f7 <ilock>
801011b9:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801011bc:	8b 4d 10             	mov    0x10(%ebp),%ecx
801011bf:	8b 45 08             	mov    0x8(%ebp),%eax
801011c2:	8b 50 14             	mov    0x14(%eax),%edx
801011c5:	8b 45 08             	mov    0x8(%ebp),%eax
801011c8:	8b 40 10             	mov    0x10(%eax),%eax
801011cb:	51                   	push   %ecx
801011cc:	52                   	push   %edx
801011cd:	ff 75 0c             	pushl  0xc(%ebp)
801011d0:	50                   	push   %eax
801011d1:	e8 89 0c 00 00       	call   80101e5f <readi>
801011d6:	83 c4 10             	add    $0x10,%esp
801011d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801011dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801011e0:	7e 11                	jle    801011f3 <fileread+0x92>
      f->off += r;
801011e2:	8b 45 08             	mov    0x8(%ebp),%eax
801011e5:	8b 50 14             	mov    0x14(%eax),%edx
801011e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801011eb:	01 c2                	add    %eax,%edx
801011ed:	8b 45 08             	mov    0x8(%ebp),%eax
801011f0:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801011f3:	8b 45 08             	mov    0x8(%ebp),%eax
801011f6:	8b 40 10             	mov    0x10(%eax),%eax
801011f9:	83 ec 0c             	sub    $0xc,%esp
801011fc:	50                   	push   %eax
801011fd:	e8 4d 08 00 00       	call   80101a4f <iunlock>
80101202:	83 c4 10             	add    $0x10,%esp
    return r;
80101205:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101208:	eb 0d                	jmp    80101217 <fileread+0xb6>
  }
  panic("fileread");
8010120a:	83 ec 0c             	sub    $0xc,%esp
8010120d:	68 f2 81 10 80       	push   $0x801081f2
80101212:	e8 4f f3 ff ff       	call   80100566 <panic>
}
80101217:	c9                   	leave  
80101218:	c3                   	ret    

80101219 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101219:	55                   	push   %ebp
8010121a:	89 e5                	mov    %esp,%ebp
8010121c:	53                   	push   %ebx
8010121d:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
80101220:	8b 45 08             	mov    0x8(%ebp),%eax
80101223:	0f b6 40 09          	movzbl 0x9(%eax),%eax
80101227:	84 c0                	test   %al,%al
80101229:	75 0a                	jne    80101235 <filewrite+0x1c>
    return -1;
8010122b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101230:	e9 1b 01 00 00       	jmp    80101350 <filewrite+0x137>
  if(f->type == FD_PIPE)
80101235:	8b 45 08             	mov    0x8(%ebp),%eax
80101238:	8b 00                	mov    (%eax),%eax
8010123a:	83 f8 01             	cmp    $0x1,%eax
8010123d:	75 1d                	jne    8010125c <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
8010123f:	8b 45 08             	mov    0x8(%ebp),%eax
80101242:	8b 40 0c             	mov    0xc(%eax),%eax
80101245:	83 ec 04             	sub    $0x4,%esp
80101248:	ff 75 10             	pushl  0x10(%ebp)
8010124b:	ff 75 0c             	pushl  0xc(%ebp)
8010124e:	50                   	push   %eax
8010124f:	e8 dd 2b 00 00       	call   80103e31 <pipewrite>
80101254:	83 c4 10             	add    $0x10,%esp
80101257:	e9 f4 00 00 00       	jmp    80101350 <filewrite+0x137>
  if(f->type == FD_INODE){
8010125c:	8b 45 08             	mov    0x8(%ebp),%eax
8010125f:	8b 00                	mov    (%eax),%eax
80101261:	83 f8 02             	cmp    $0x2,%eax
80101264:	0f 85 d9 00 00 00    	jne    80101343 <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
8010126a:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
80101271:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101278:	e9 a3 00 00 00       	jmp    80101320 <filewrite+0x107>
      int n1 = n - i;
8010127d:	8b 45 10             	mov    0x10(%ebp),%eax
80101280:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101283:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101286:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101289:	3b 45 ec             	cmp    -0x14(%ebp),%eax
8010128c:	7e 06                	jle    80101294 <filewrite+0x7b>
        n1 = max;
8010128e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101291:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_trans();
80101294:	e8 e2 1f 00 00       	call   8010327b <begin_trans>
      ilock(f->ip);
80101299:	8b 45 08             	mov    0x8(%ebp),%eax
8010129c:	8b 40 10             	mov    0x10(%eax),%eax
8010129f:	83 ec 0c             	sub    $0xc,%esp
801012a2:	50                   	push   %eax
801012a3:	e8 4f 06 00 00       	call   801018f7 <ilock>
801012a8:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801012ab:	8b 4d f0             	mov    -0x10(%ebp),%ecx
801012ae:	8b 45 08             	mov    0x8(%ebp),%eax
801012b1:	8b 50 14             	mov    0x14(%eax),%edx
801012b4:	8b 5d f4             	mov    -0xc(%ebp),%ebx
801012b7:	8b 45 0c             	mov    0xc(%ebp),%eax
801012ba:	01 c3                	add    %eax,%ebx
801012bc:	8b 45 08             	mov    0x8(%ebp),%eax
801012bf:	8b 40 10             	mov    0x10(%eax),%eax
801012c2:	51                   	push   %ecx
801012c3:	52                   	push   %edx
801012c4:	53                   	push   %ebx
801012c5:	50                   	push   %eax
801012c6:	e8 eb 0c 00 00       	call   80101fb6 <writei>
801012cb:	83 c4 10             	add    $0x10,%esp
801012ce:	89 45 e8             	mov    %eax,-0x18(%ebp)
801012d1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801012d5:	7e 11                	jle    801012e8 <filewrite+0xcf>
        f->off += r;
801012d7:	8b 45 08             	mov    0x8(%ebp),%eax
801012da:	8b 50 14             	mov    0x14(%eax),%edx
801012dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
801012e0:	01 c2                	add    %eax,%edx
801012e2:	8b 45 08             	mov    0x8(%ebp),%eax
801012e5:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801012e8:	8b 45 08             	mov    0x8(%ebp),%eax
801012eb:	8b 40 10             	mov    0x10(%eax),%eax
801012ee:	83 ec 0c             	sub    $0xc,%esp
801012f1:	50                   	push   %eax
801012f2:	e8 58 07 00 00       	call   80101a4f <iunlock>
801012f7:	83 c4 10             	add    $0x10,%esp
      commit_trans();
801012fa:	e8 cf 1f 00 00       	call   801032ce <commit_trans>

      if(r < 0)
801012ff:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101303:	78 29                	js     8010132e <filewrite+0x115>
        break;
      if(r != n1)
80101305:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101308:	3b 45 f0             	cmp    -0x10(%ebp),%eax
8010130b:	74 0d                	je     8010131a <filewrite+0x101>
        panic("short filewrite");
8010130d:	83 ec 0c             	sub    $0xc,%esp
80101310:	68 fb 81 10 80       	push   $0x801081fb
80101315:	e8 4c f2 ff ff       	call   80100566 <panic>
      i += r;
8010131a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010131d:	01 45 f4             	add    %eax,-0xc(%ebp)
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101320:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101323:	3b 45 10             	cmp    0x10(%ebp),%eax
80101326:	0f 8c 51 ff ff ff    	jl     8010127d <filewrite+0x64>
8010132c:	eb 01                	jmp    8010132f <filewrite+0x116>
        f->off += r;
      iunlock(f->ip);
      commit_trans();

      if(r < 0)
        break;
8010132e:	90                   	nop
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010132f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101332:	3b 45 10             	cmp    0x10(%ebp),%eax
80101335:	75 05                	jne    8010133c <filewrite+0x123>
80101337:	8b 45 10             	mov    0x10(%ebp),%eax
8010133a:	eb 14                	jmp    80101350 <filewrite+0x137>
8010133c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101341:	eb 0d                	jmp    80101350 <filewrite+0x137>
  }
  panic("filewrite");
80101343:	83 ec 0c             	sub    $0xc,%esp
80101346:	68 0b 82 10 80       	push   $0x8010820b
8010134b:	e8 16 f2 ff ff       	call   80100566 <panic>
}
80101350:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101353:	c9                   	leave  
80101354:	c3                   	ret    

80101355 <readsb>:
static void itrunc(struct inode*);

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101355:	55                   	push   %ebp
80101356:	89 e5                	mov    %esp,%ebp
80101358:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, 1);
8010135b:	8b 45 08             	mov    0x8(%ebp),%eax
8010135e:	83 ec 08             	sub    $0x8,%esp
80101361:	6a 01                	push   $0x1
80101363:	50                   	push   %eax
80101364:	e8 4d ee ff ff       	call   801001b6 <bread>
80101369:	83 c4 10             	add    $0x10,%esp
8010136c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010136f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101372:	83 c0 18             	add    $0x18,%eax
80101375:	83 ec 04             	sub    $0x4,%esp
80101378:	6a 10                	push   $0x10
8010137a:	50                   	push   %eax
8010137b:	ff 75 0c             	pushl  0xc(%ebp)
8010137e:	e8 88 3b 00 00       	call   80104f0b <memmove>
80101383:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101386:	83 ec 0c             	sub    $0xc,%esp
80101389:	ff 75 f4             	pushl  -0xc(%ebp)
8010138c:	e8 9d ee ff ff       	call   8010022e <brelse>
80101391:	83 c4 10             	add    $0x10,%esp
}
80101394:	90                   	nop
80101395:	c9                   	leave  
80101396:	c3                   	ret    

80101397 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101397:	55                   	push   %ebp
80101398:	89 e5                	mov    %esp,%ebp
8010139a:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  
  bp = bread(dev, bno);
8010139d:	8b 55 0c             	mov    0xc(%ebp),%edx
801013a0:	8b 45 08             	mov    0x8(%ebp),%eax
801013a3:	83 ec 08             	sub    $0x8,%esp
801013a6:	52                   	push   %edx
801013a7:	50                   	push   %eax
801013a8:	e8 09 ee ff ff       	call   801001b6 <bread>
801013ad:	83 c4 10             	add    $0x10,%esp
801013b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
801013b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013b6:	83 c0 18             	add    $0x18,%eax
801013b9:	83 ec 04             	sub    $0x4,%esp
801013bc:	68 00 02 00 00       	push   $0x200
801013c1:	6a 00                	push   $0x0
801013c3:	50                   	push   %eax
801013c4:	e8 83 3a 00 00       	call   80104e4c <memset>
801013c9:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801013cc:	83 ec 0c             	sub    $0xc,%esp
801013cf:	ff 75 f4             	pushl  -0xc(%ebp)
801013d2:	e8 5c 1f 00 00       	call   80103333 <log_write>
801013d7:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801013da:	83 ec 0c             	sub    $0xc,%esp
801013dd:	ff 75 f4             	pushl  -0xc(%ebp)
801013e0:	e8 49 ee ff ff       	call   8010022e <brelse>
801013e5:	83 c4 10             	add    $0x10,%esp
}
801013e8:	90                   	nop
801013e9:	c9                   	leave  
801013ea:	c3                   	ret    

801013eb <balloc>:
// Blocks. 

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013eb:	55                   	push   %ebp
801013ec:	89 e5                	mov    %esp,%ebp
801013ee:	83 ec 28             	sub    $0x28,%esp
  int b, bi, m;
  struct buf *bp;
  struct superblock sb;

  bp = 0;
801013f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  readsb(dev, &sb);
801013f8:	8b 45 08             	mov    0x8(%ebp),%eax
801013fb:	83 ec 08             	sub    $0x8,%esp
801013fe:	8d 55 d8             	lea    -0x28(%ebp),%edx
80101401:	52                   	push   %edx
80101402:	50                   	push   %eax
80101403:	e8 4d ff ff ff       	call   80101355 <readsb>
80101408:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
8010140b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101412:	e9 15 01 00 00       	jmp    8010152c <balloc+0x141>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
80101417:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010141a:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
80101420:	85 c0                	test   %eax,%eax
80101422:	0f 48 c2             	cmovs  %edx,%eax
80101425:	c1 f8 0c             	sar    $0xc,%eax
80101428:	89 c2                	mov    %eax,%edx
8010142a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010142d:	c1 e8 03             	shr    $0x3,%eax
80101430:	01 d0                	add    %edx,%eax
80101432:	83 c0 03             	add    $0x3,%eax
80101435:	83 ec 08             	sub    $0x8,%esp
80101438:	50                   	push   %eax
80101439:	ff 75 08             	pushl  0x8(%ebp)
8010143c:	e8 75 ed ff ff       	call   801001b6 <bread>
80101441:	83 c4 10             	add    $0x10,%esp
80101444:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101447:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
8010144e:	e9 a6 00 00 00       	jmp    801014f9 <balloc+0x10e>
      m = 1 << (bi % 8);
80101453:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101456:	99                   	cltd   
80101457:	c1 ea 1d             	shr    $0x1d,%edx
8010145a:	01 d0                	add    %edx,%eax
8010145c:	83 e0 07             	and    $0x7,%eax
8010145f:	29 d0                	sub    %edx,%eax
80101461:	ba 01 00 00 00       	mov    $0x1,%edx
80101466:	89 c1                	mov    %eax,%ecx
80101468:	d3 e2                	shl    %cl,%edx
8010146a:	89 d0                	mov    %edx,%eax
8010146c:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010146f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101472:	8d 50 07             	lea    0x7(%eax),%edx
80101475:	85 c0                	test   %eax,%eax
80101477:	0f 48 c2             	cmovs  %edx,%eax
8010147a:	c1 f8 03             	sar    $0x3,%eax
8010147d:	89 c2                	mov    %eax,%edx
8010147f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101482:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
80101487:	0f b6 c0             	movzbl %al,%eax
8010148a:	23 45 e8             	and    -0x18(%ebp),%eax
8010148d:	85 c0                	test   %eax,%eax
8010148f:	75 64                	jne    801014f5 <balloc+0x10a>
        bp->data[bi/8] |= m;  // Mark block in use.
80101491:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101494:	8d 50 07             	lea    0x7(%eax),%edx
80101497:	85 c0                	test   %eax,%eax
80101499:	0f 48 c2             	cmovs  %edx,%eax
8010149c:	c1 f8 03             	sar    $0x3,%eax
8010149f:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014a2:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801014a7:	89 d1                	mov    %edx,%ecx
801014a9:	8b 55 e8             	mov    -0x18(%ebp),%edx
801014ac:	09 ca                	or     %ecx,%edx
801014ae:	89 d1                	mov    %edx,%ecx
801014b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
801014b3:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
        log_write(bp);
801014b7:	83 ec 0c             	sub    $0xc,%esp
801014ba:	ff 75 ec             	pushl  -0x14(%ebp)
801014bd:	e8 71 1e 00 00       	call   80103333 <log_write>
801014c2:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
801014c5:	83 ec 0c             	sub    $0xc,%esp
801014c8:	ff 75 ec             	pushl  -0x14(%ebp)
801014cb:	e8 5e ed ff ff       	call   8010022e <brelse>
801014d0:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
801014d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014d9:	01 c2                	add    %eax,%edx
801014db:	8b 45 08             	mov    0x8(%ebp),%eax
801014de:	83 ec 08             	sub    $0x8,%esp
801014e1:	52                   	push   %edx
801014e2:	50                   	push   %eax
801014e3:	e8 af fe ff ff       	call   80101397 <bzero>
801014e8:	83 c4 10             	add    $0x10,%esp
        return b + bi;
801014eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801014ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014f1:	01 d0                	add    %edx,%eax
801014f3:	eb 52                	jmp    80101547 <balloc+0x15c>

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb.ninodes));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014f5:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
801014f9:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
80101500:	7f 15                	jg     80101517 <balloc+0x12c>
80101502:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101505:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101508:	01 d0                	add    %edx,%eax
8010150a:	89 c2                	mov    %eax,%edx
8010150c:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010150f:	39 c2                	cmp    %eax,%edx
80101511:	0f 82 3c ff ff ff    	jb     80101453 <balloc+0x68>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101517:	83 ec 0c             	sub    $0xc,%esp
8010151a:	ff 75 ec             	pushl  -0x14(%ebp)
8010151d:	e8 0c ed ff ff       	call   8010022e <brelse>
80101522:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct superblock sb;

  bp = 0;
  readsb(dev, &sb);
  for(b = 0; b < sb.size; b += BPB){
80101525:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010152c:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010152f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101532:	39 c2                	cmp    %eax,%edx
80101534:	0f 87 dd fe ff ff    	ja     80101417 <balloc+0x2c>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010153a:	83 ec 0c             	sub    $0xc,%esp
8010153d:	68 15 82 10 80       	push   $0x80108215
80101542:	e8 1f f0 ff ff       	call   80100566 <panic>
}
80101547:	c9                   	leave  
80101548:	c3                   	ret    

80101549 <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101549:	55                   	push   %ebp
8010154a:	89 e5                	mov    %esp,%ebp
8010154c:	83 ec 28             	sub    $0x28,%esp
  struct buf *bp;
  struct superblock sb;
  int bi, m;

  readsb(dev, &sb);
8010154f:	83 ec 08             	sub    $0x8,%esp
80101552:	8d 45 dc             	lea    -0x24(%ebp),%eax
80101555:	50                   	push   %eax
80101556:	ff 75 08             	pushl  0x8(%ebp)
80101559:	e8 f7 fd ff ff       	call   80101355 <readsb>
8010155e:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb.ninodes));
80101561:	8b 45 0c             	mov    0xc(%ebp),%eax
80101564:	c1 e8 0c             	shr    $0xc,%eax
80101567:	89 c2                	mov    %eax,%edx
80101569:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	01 d0                	add    %edx,%eax
80101571:	8d 50 03             	lea    0x3(%eax),%edx
80101574:	8b 45 08             	mov    0x8(%ebp),%eax
80101577:	83 ec 08             	sub    $0x8,%esp
8010157a:	52                   	push   %edx
8010157b:	50                   	push   %eax
8010157c:	e8 35 ec ff ff       	call   801001b6 <bread>
80101581:	83 c4 10             	add    $0x10,%esp
80101584:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101587:	8b 45 0c             	mov    0xc(%ebp),%eax
8010158a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010158f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
80101592:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101595:	99                   	cltd   
80101596:	c1 ea 1d             	shr    $0x1d,%edx
80101599:	01 d0                	add    %edx,%eax
8010159b:	83 e0 07             	and    $0x7,%eax
8010159e:	29 d0                	sub    %edx,%eax
801015a0:	ba 01 00 00 00       	mov    $0x1,%edx
801015a5:	89 c1                	mov    %eax,%ecx
801015a7:	d3 e2                	shl    %cl,%edx
801015a9:	89 d0                	mov    %edx,%eax
801015ab:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
801015ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015b1:	8d 50 07             	lea    0x7(%eax),%edx
801015b4:	85 c0                	test   %eax,%eax
801015b6:	0f 48 c2             	cmovs  %edx,%eax
801015b9:	c1 f8 03             	sar    $0x3,%eax
801015bc:	89 c2                	mov    %eax,%edx
801015be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015c1:	0f b6 44 10 18       	movzbl 0x18(%eax,%edx,1),%eax
801015c6:	0f b6 c0             	movzbl %al,%eax
801015c9:	23 45 ec             	and    -0x14(%ebp),%eax
801015cc:	85 c0                	test   %eax,%eax
801015ce:	75 0d                	jne    801015dd <bfree+0x94>
    panic("freeing free block");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 2b 82 10 80       	push   $0x8010822b
801015d8:	e8 89 ef ff ff       	call   80100566 <panic>
  bp->data[bi/8] &= ~m;
801015dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015e0:	8d 50 07             	lea    0x7(%eax),%edx
801015e3:	85 c0                	test   %eax,%eax
801015e5:	0f 48 c2             	cmovs  %edx,%eax
801015e8:	c1 f8 03             	sar    $0x3,%eax
801015eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015ee:	0f b6 54 02 18       	movzbl 0x18(%edx,%eax,1),%edx
801015f3:	89 d1                	mov    %edx,%ecx
801015f5:	8b 55 ec             	mov    -0x14(%ebp),%edx
801015f8:	f7 d2                	not    %edx
801015fa:	21 ca                	and    %ecx,%edx
801015fc:	89 d1                	mov    %edx,%ecx
801015fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101601:	88 4c 02 18          	mov    %cl,0x18(%edx,%eax,1)
  log_write(bp);
80101605:	83 ec 0c             	sub    $0xc,%esp
80101608:	ff 75 f4             	pushl  -0xc(%ebp)
8010160b:	e8 23 1d 00 00       	call   80103333 <log_write>
80101610:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101613:	83 ec 0c             	sub    $0xc,%esp
80101616:	ff 75 f4             	pushl  -0xc(%ebp)
80101619:	e8 10 ec ff ff       	call   8010022e <brelse>
8010161e:	83 c4 10             	add    $0x10,%esp
}
80101621:	90                   	nop
80101622:	c9                   	leave  
80101623:	c3                   	ret    

80101624 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(void)
{
80101624:	55                   	push   %ebp
80101625:	89 e5                	mov    %esp,%ebp
80101627:	83 ec 08             	sub    $0x8,%esp
  initlock(&icache.lock, "icache");
8010162a:	83 ec 08             	sub    $0x8,%esp
8010162d:	68 3e 82 10 80       	push   $0x8010823e
80101632:	68 80 e8 10 80       	push   $0x8010e880
80101637:	e8 8b 35 00 00       	call   80104bc7 <initlock>
8010163c:	83 c4 10             	add    $0x10,%esp
}
8010163f:	90                   	nop
80101640:	c9                   	leave  
80101641:	c3                   	ret    

80101642 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
80101642:	55                   	push   %ebp
80101643:	89 e5                	mov    %esp,%ebp
80101645:	83 ec 38             	sub    $0x38,%esp
80101648:	8b 45 0c             	mov    0xc(%ebp),%eax
8010164b:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);
8010164f:	8b 45 08             	mov    0x8(%ebp),%eax
80101652:	83 ec 08             	sub    $0x8,%esp
80101655:	8d 55 dc             	lea    -0x24(%ebp),%edx
80101658:	52                   	push   %edx
80101659:	50                   	push   %eax
8010165a:	e8 f6 fc ff ff       	call   80101355 <readsb>
8010165f:	83 c4 10             	add    $0x10,%esp

  for(inum = 1; inum < sb.ninodes; inum++){
80101662:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
80101669:	e9 98 00 00 00       	jmp    80101706 <ialloc+0xc4>
    bp = bread(dev, IBLOCK(inum));
8010166e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101671:	c1 e8 03             	shr    $0x3,%eax
80101674:	83 c0 02             	add    $0x2,%eax
80101677:	83 ec 08             	sub    $0x8,%esp
8010167a:	50                   	push   %eax
8010167b:	ff 75 08             	pushl  0x8(%ebp)
8010167e:	e8 33 eb ff ff       	call   801001b6 <bread>
80101683:	83 c4 10             	add    $0x10,%esp
80101686:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
80101689:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010168c:	8d 50 18             	lea    0x18(%eax),%edx
8010168f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101692:	83 e0 07             	and    $0x7,%eax
80101695:	c1 e0 06             	shl    $0x6,%eax
80101698:	01 d0                	add    %edx,%eax
8010169a:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
8010169d:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016a0:	0f b7 00             	movzwl (%eax),%eax
801016a3:	66 85 c0             	test   %ax,%ax
801016a6:	75 4c                	jne    801016f4 <ialloc+0xb2>
      memset(dip, 0, sizeof(*dip));
801016a8:	83 ec 04             	sub    $0x4,%esp
801016ab:	6a 40                	push   $0x40
801016ad:	6a 00                	push   $0x0
801016af:	ff 75 ec             	pushl  -0x14(%ebp)
801016b2:	e8 95 37 00 00       	call   80104e4c <memset>
801016b7:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801016ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801016bd:	0f b7 55 d4          	movzwl -0x2c(%ebp),%edx
801016c1:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801016c4:	83 ec 0c             	sub    $0xc,%esp
801016c7:	ff 75 f0             	pushl  -0x10(%ebp)
801016ca:	e8 64 1c 00 00       	call   80103333 <log_write>
801016cf:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801016d2:	83 ec 0c             	sub    $0xc,%esp
801016d5:	ff 75 f0             	pushl  -0x10(%ebp)
801016d8:	e8 51 eb ff ff       	call   8010022e <brelse>
801016dd:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
801016e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801016e3:	83 ec 08             	sub    $0x8,%esp
801016e6:	50                   	push   %eax
801016e7:	ff 75 08             	pushl  0x8(%ebp)
801016ea:	e8 ef 00 00 00       	call   801017de <iget>
801016ef:	83 c4 10             	add    $0x10,%esp
801016f2:	eb 2d                	jmp    80101721 <ialloc+0xdf>
    }
    brelse(bp);
801016f4:	83 ec 0c             	sub    $0xc,%esp
801016f7:	ff 75 f0             	pushl  -0x10(%ebp)
801016fa:	e8 2f eb ff ff       	call   8010022e <brelse>
801016ff:	83 c4 10             	add    $0x10,%esp
  struct dinode *dip;
  struct superblock sb;

  readsb(dev, &sb);

  for(inum = 1; inum < sb.ninodes; inum++){
80101702:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101706:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101709:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010170c:	39 c2                	cmp    %eax,%edx
8010170e:	0f 87 5a ff ff ff    	ja     8010166e <ialloc+0x2c>
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101714:	83 ec 0c             	sub    $0xc,%esp
80101717:	68 45 82 10 80       	push   $0x80108245
8010171c:	e8 45 ee ff ff       	call   80100566 <panic>
}
80101721:	c9                   	leave  
80101722:	c3                   	ret    

80101723 <iupdate>:

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
80101723:	55                   	push   %ebp
80101724:	89 e5                	mov    %esp,%ebp
80101726:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum));
80101729:	8b 45 08             	mov    0x8(%ebp),%eax
8010172c:	8b 40 04             	mov    0x4(%eax),%eax
8010172f:	c1 e8 03             	shr    $0x3,%eax
80101732:	8d 50 02             	lea    0x2(%eax),%edx
80101735:	8b 45 08             	mov    0x8(%ebp),%eax
80101738:	8b 00                	mov    (%eax),%eax
8010173a:	83 ec 08             	sub    $0x8,%esp
8010173d:	52                   	push   %edx
8010173e:	50                   	push   %eax
8010173f:	e8 72 ea ff ff       	call   801001b6 <bread>
80101744:	83 c4 10             	add    $0x10,%esp
80101747:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010174a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010174d:	8d 50 18             	lea    0x18(%eax),%edx
80101750:	8b 45 08             	mov    0x8(%ebp),%eax
80101753:	8b 40 04             	mov    0x4(%eax),%eax
80101756:	83 e0 07             	and    $0x7,%eax
80101759:	c1 e0 06             	shl    $0x6,%eax
8010175c:	01 d0                	add    %edx,%eax
8010175e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101761:	8b 45 08             	mov    0x8(%ebp),%eax
80101764:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101768:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010176b:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010176e:	8b 45 08             	mov    0x8(%ebp),%eax
80101771:	0f b7 50 12          	movzwl 0x12(%eax),%edx
80101775:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101778:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010177c:	8b 45 08             	mov    0x8(%ebp),%eax
8010177f:	0f b7 50 14          	movzwl 0x14(%eax),%edx
80101783:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101786:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
8010178a:	8b 45 08             	mov    0x8(%ebp),%eax
8010178d:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101791:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101794:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
80101798:	8b 45 08             	mov    0x8(%ebp),%eax
8010179b:	8b 50 18             	mov    0x18(%eax),%edx
8010179e:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a1:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017a4:	8b 45 08             	mov    0x8(%ebp),%eax
801017a7:	8d 50 1c             	lea    0x1c(%eax),%edx
801017aa:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017ad:	83 c0 0c             	add    $0xc,%eax
801017b0:	83 ec 04             	sub    $0x4,%esp
801017b3:	6a 34                	push   $0x34
801017b5:	52                   	push   %edx
801017b6:	50                   	push   %eax
801017b7:	e8 4f 37 00 00       	call   80104f0b <memmove>
801017bc:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801017bf:	83 ec 0c             	sub    $0xc,%esp
801017c2:	ff 75 f4             	pushl  -0xc(%ebp)
801017c5:	e8 69 1b 00 00       	call   80103333 <log_write>
801017ca:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801017cd:	83 ec 0c             	sub    $0xc,%esp
801017d0:	ff 75 f4             	pushl  -0xc(%ebp)
801017d3:	e8 56 ea ff ff       	call   8010022e <brelse>
801017d8:	83 c4 10             	add    $0x10,%esp
}
801017db:	90                   	nop
801017dc:	c9                   	leave  
801017dd:	c3                   	ret    

801017de <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801017de:	55                   	push   %ebp
801017df:	89 e5                	mov    %esp,%ebp
801017e1:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
801017e4:	83 ec 0c             	sub    $0xc,%esp
801017e7:	68 80 e8 10 80       	push   $0x8010e880
801017ec:	e8 f8 33 00 00       	call   80104be9 <acquire>
801017f1:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
801017f4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801017fb:	c7 45 f4 b4 e8 10 80 	movl   $0x8010e8b4,-0xc(%ebp)
80101802:	eb 5d                	jmp    80101861 <iget+0x83>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101804:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101807:	8b 40 08             	mov    0x8(%eax),%eax
8010180a:	85 c0                	test   %eax,%eax
8010180c:	7e 39                	jle    80101847 <iget+0x69>
8010180e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101811:	8b 00                	mov    (%eax),%eax
80101813:	3b 45 08             	cmp    0x8(%ebp),%eax
80101816:	75 2f                	jne    80101847 <iget+0x69>
80101818:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010181b:	8b 40 04             	mov    0x4(%eax),%eax
8010181e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80101821:	75 24                	jne    80101847 <iget+0x69>
      ip->ref++;
80101823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101826:	8b 40 08             	mov    0x8(%eax),%eax
80101829:	8d 50 01             	lea    0x1(%eax),%edx
8010182c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010182f:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101832:	83 ec 0c             	sub    $0xc,%esp
80101835:	68 80 e8 10 80       	push   $0x8010e880
8010183a:	e8 11 34 00 00       	call   80104c50 <release>
8010183f:	83 c4 10             	add    $0x10,%esp
      return ip;
80101842:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101845:	eb 74                	jmp    801018bb <iget+0xdd>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101847:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010184b:	75 10                	jne    8010185d <iget+0x7f>
8010184d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101850:	8b 40 08             	mov    0x8(%eax),%eax
80101853:	85 c0                	test   %eax,%eax
80101855:	75 06                	jne    8010185d <iget+0x7f>
      empty = ip;
80101857:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010185a:	89 45 f0             	mov    %eax,-0x10(%ebp)

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010185d:	83 45 f4 50          	addl   $0x50,-0xc(%ebp)
80101861:	81 7d f4 54 f8 10 80 	cmpl   $0x8010f854,-0xc(%ebp)
80101868:	72 9a                	jb     80101804 <iget+0x26>
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
8010186a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010186e:	75 0d                	jne    8010187d <iget+0x9f>
    panic("iget: no inodes");
80101870:	83 ec 0c             	sub    $0xc,%esp
80101873:	68 57 82 10 80       	push   $0x80108257
80101878:	e8 e9 ec ff ff       	call   80100566 <panic>

  ip = empty;
8010187d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101880:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
80101883:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101886:	8b 55 08             	mov    0x8(%ebp),%edx
80101889:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
8010188b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010188e:	8b 55 0c             	mov    0xc(%ebp),%edx
80101891:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
80101894:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101897:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->flags = 0;
8010189e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801018a1:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  release(&icache.lock);
801018a8:	83 ec 0c             	sub    $0xc,%esp
801018ab:	68 80 e8 10 80       	push   $0x8010e880
801018b0:	e8 9b 33 00 00       	call   80104c50 <release>
801018b5:	83 c4 10             	add    $0x10,%esp

  return ip;
801018b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801018bb:	c9                   	leave  
801018bc:	c3                   	ret    

801018bd <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801018bd:	55                   	push   %ebp
801018be:	89 e5                	mov    %esp,%ebp
801018c0:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801018c3:	83 ec 0c             	sub    $0xc,%esp
801018c6:	68 80 e8 10 80       	push   $0x8010e880
801018cb:	e8 19 33 00 00       	call   80104be9 <acquire>
801018d0:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801018d3:	8b 45 08             	mov    0x8(%ebp),%eax
801018d6:	8b 40 08             	mov    0x8(%eax),%eax
801018d9:	8d 50 01             	lea    0x1(%eax),%edx
801018dc:	8b 45 08             	mov    0x8(%ebp),%eax
801018df:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
801018e2:	83 ec 0c             	sub    $0xc,%esp
801018e5:	68 80 e8 10 80       	push   $0x8010e880
801018ea:	e8 61 33 00 00       	call   80104c50 <release>
801018ef:	83 c4 10             	add    $0x10,%esp
  return ip;
801018f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
801018f5:	c9                   	leave  
801018f6:	c3                   	ret    

801018f7 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
801018f7:	55                   	push   %ebp
801018f8:	89 e5                	mov    %esp,%ebp
801018fa:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
801018fd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101901:	74 0a                	je     8010190d <ilock+0x16>
80101903:	8b 45 08             	mov    0x8(%ebp),%eax
80101906:	8b 40 08             	mov    0x8(%eax),%eax
80101909:	85 c0                	test   %eax,%eax
8010190b:	7f 0d                	jg     8010191a <ilock+0x23>
    panic("ilock");
8010190d:	83 ec 0c             	sub    $0xc,%esp
80101910:	68 67 82 10 80       	push   $0x80108267
80101915:	e8 4c ec ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
8010191a:	83 ec 0c             	sub    $0xc,%esp
8010191d:	68 80 e8 10 80       	push   $0x8010e880
80101922:	e8 c2 32 00 00       	call   80104be9 <acquire>
80101927:	83 c4 10             	add    $0x10,%esp
  while(ip->flags & I_BUSY)
8010192a:	eb 13                	jmp    8010193f <ilock+0x48>
    sleep(ip, &icache.lock);
8010192c:	83 ec 08             	sub    $0x8,%esp
8010192f:	68 80 e8 10 80       	push   $0x8010e880
80101934:	ff 75 08             	pushl  0x8(%ebp)
80101937:	e8 7e 2f 00 00       	call   801048ba <sleep>
8010193c:	83 c4 10             	add    $0x10,%esp

  if(ip == 0 || ip->ref < 1)
    panic("ilock");

  acquire(&icache.lock);
  while(ip->flags & I_BUSY)
8010193f:	8b 45 08             	mov    0x8(%ebp),%eax
80101942:	8b 40 0c             	mov    0xc(%eax),%eax
80101945:	83 e0 01             	and    $0x1,%eax
80101948:	85 c0                	test   %eax,%eax
8010194a:	75 e0                	jne    8010192c <ilock+0x35>
    sleep(ip, &icache.lock);
  ip->flags |= I_BUSY;
8010194c:	8b 45 08             	mov    0x8(%ebp),%eax
8010194f:	8b 40 0c             	mov    0xc(%eax),%eax
80101952:	83 c8 01             	or     $0x1,%eax
80101955:	89 c2                	mov    %eax,%edx
80101957:	8b 45 08             	mov    0x8(%ebp),%eax
8010195a:	89 50 0c             	mov    %edx,0xc(%eax)
  release(&icache.lock);
8010195d:	83 ec 0c             	sub    $0xc,%esp
80101960:	68 80 e8 10 80       	push   $0x8010e880
80101965:	e8 e6 32 00 00       	call   80104c50 <release>
8010196a:	83 c4 10             	add    $0x10,%esp

  if(!(ip->flags & I_VALID)){
8010196d:	8b 45 08             	mov    0x8(%ebp),%eax
80101970:	8b 40 0c             	mov    0xc(%eax),%eax
80101973:	83 e0 02             	and    $0x2,%eax
80101976:	85 c0                	test   %eax,%eax
80101978:	0f 85 ce 00 00 00    	jne    80101a4c <ilock+0x155>
    bp = bread(ip->dev, IBLOCK(ip->inum));
8010197e:	8b 45 08             	mov    0x8(%ebp),%eax
80101981:	8b 40 04             	mov    0x4(%eax),%eax
80101984:	c1 e8 03             	shr    $0x3,%eax
80101987:	8d 50 02             	lea    0x2(%eax),%edx
8010198a:	8b 45 08             	mov    0x8(%ebp),%eax
8010198d:	8b 00                	mov    (%eax),%eax
8010198f:	83 ec 08             	sub    $0x8,%esp
80101992:	52                   	push   %edx
80101993:	50                   	push   %eax
80101994:	e8 1d e8 ff ff       	call   801001b6 <bread>
80101999:	83 c4 10             	add    $0x10,%esp
8010199c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010199f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019a2:	8d 50 18             	lea    0x18(%eax),%edx
801019a5:	8b 45 08             	mov    0x8(%ebp),%eax
801019a8:	8b 40 04             	mov    0x4(%eax),%eax
801019ab:	83 e0 07             	and    $0x7,%eax
801019ae:	c1 e0 06             	shl    $0x6,%eax
801019b1:	01 d0                	add    %edx,%eax
801019b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
801019b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019b9:	0f b7 10             	movzwl (%eax),%edx
801019bc:	8b 45 08             	mov    0x8(%ebp),%eax
801019bf:	66 89 50 10          	mov    %dx,0x10(%eax)
    ip->major = dip->major;
801019c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019c6:	0f b7 50 02          	movzwl 0x2(%eax),%edx
801019ca:	8b 45 08             	mov    0x8(%ebp),%eax
801019cd:	66 89 50 12          	mov    %dx,0x12(%eax)
    ip->minor = dip->minor;
801019d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019d4:	0f b7 50 04          	movzwl 0x4(%eax),%edx
801019d8:	8b 45 08             	mov    0x8(%ebp),%eax
801019db:	66 89 50 14          	mov    %dx,0x14(%eax)
    ip->nlink = dip->nlink;
801019df:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019e2:	0f b7 50 06          	movzwl 0x6(%eax),%edx
801019e6:	8b 45 08             	mov    0x8(%ebp),%eax
801019e9:	66 89 50 16          	mov    %dx,0x16(%eax)
    ip->size = dip->size;
801019ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019f0:	8b 50 08             	mov    0x8(%eax),%edx
801019f3:	8b 45 08             	mov    0x8(%ebp),%eax
801019f6:	89 50 18             	mov    %edx,0x18(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019fc:	8d 50 0c             	lea    0xc(%eax),%edx
801019ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101a02:	83 c0 1c             	add    $0x1c,%eax
80101a05:	83 ec 04             	sub    $0x4,%esp
80101a08:	6a 34                	push   $0x34
80101a0a:	52                   	push   %edx
80101a0b:	50                   	push   %eax
80101a0c:	e8 fa 34 00 00       	call   80104f0b <memmove>
80101a11:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101a14:	83 ec 0c             	sub    $0xc,%esp
80101a17:	ff 75 f4             	pushl  -0xc(%ebp)
80101a1a:	e8 0f e8 ff ff       	call   8010022e <brelse>
80101a1f:	83 c4 10             	add    $0x10,%esp
    ip->flags |= I_VALID;
80101a22:	8b 45 08             	mov    0x8(%ebp),%eax
80101a25:	8b 40 0c             	mov    0xc(%eax),%eax
80101a28:	83 c8 02             	or     $0x2,%eax
80101a2b:	89 c2                	mov    %eax,%edx
80101a2d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a30:	89 50 0c             	mov    %edx,0xc(%eax)
    if(ip->type == 0)
80101a33:	8b 45 08             	mov    0x8(%ebp),%eax
80101a36:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101a3a:	66 85 c0             	test   %ax,%ax
80101a3d:	75 0d                	jne    80101a4c <ilock+0x155>
      panic("ilock: no type");
80101a3f:	83 ec 0c             	sub    $0xc,%esp
80101a42:	68 6d 82 10 80       	push   $0x8010826d
80101a47:	e8 1a eb ff ff       	call   80100566 <panic>
  }
}
80101a4c:	90                   	nop
80101a4d:	c9                   	leave  
80101a4e:	c3                   	ret    

80101a4f <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101a4f:	55                   	push   %ebp
80101a50:	89 e5                	mov    %esp,%ebp
80101a52:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1)
80101a55:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a59:	74 17                	je     80101a72 <iunlock+0x23>
80101a5b:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5e:	8b 40 0c             	mov    0xc(%eax),%eax
80101a61:	83 e0 01             	and    $0x1,%eax
80101a64:	85 c0                	test   %eax,%eax
80101a66:	74 0a                	je     80101a72 <iunlock+0x23>
80101a68:	8b 45 08             	mov    0x8(%ebp),%eax
80101a6b:	8b 40 08             	mov    0x8(%eax),%eax
80101a6e:	85 c0                	test   %eax,%eax
80101a70:	7f 0d                	jg     80101a7f <iunlock+0x30>
    panic("iunlock");
80101a72:	83 ec 0c             	sub    $0xc,%esp
80101a75:	68 7c 82 10 80       	push   $0x8010827c
80101a7a:	e8 e7 ea ff ff       	call   80100566 <panic>

  acquire(&icache.lock);
80101a7f:	83 ec 0c             	sub    $0xc,%esp
80101a82:	68 80 e8 10 80       	push   $0x8010e880
80101a87:	e8 5d 31 00 00       	call   80104be9 <acquire>
80101a8c:	83 c4 10             	add    $0x10,%esp
  ip->flags &= ~I_BUSY;
80101a8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a92:	8b 40 0c             	mov    0xc(%eax),%eax
80101a95:	83 e0 fe             	and    $0xfffffffe,%eax
80101a98:	89 c2                	mov    %eax,%edx
80101a9a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a9d:	89 50 0c             	mov    %edx,0xc(%eax)
  wakeup(ip);
80101aa0:	83 ec 0c             	sub    $0xc,%esp
80101aa3:	ff 75 08             	pushl  0x8(%ebp)
80101aa6:	e8 fa 2e 00 00       	call   801049a5 <wakeup>
80101aab:	83 c4 10             	add    $0x10,%esp
  release(&icache.lock);
80101aae:	83 ec 0c             	sub    $0xc,%esp
80101ab1:	68 80 e8 10 80       	push   $0x8010e880
80101ab6:	e8 95 31 00 00       	call   80104c50 <release>
80101abb:	83 c4 10             	add    $0x10,%esp
}
80101abe:	90                   	nop
80101abf:	c9                   	leave  
80101ac0:	c3                   	ret    

80101ac1 <iput>:
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void
iput(struct inode *ip)
{
80101ac1:	55                   	push   %ebp
80101ac2:	89 e5                	mov    %esp,%ebp
80101ac4:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
80101ac7:	83 ec 0c             	sub    $0xc,%esp
80101aca:	68 80 e8 10 80       	push   $0x8010e880
80101acf:	e8 15 31 00 00       	call   80104be9 <acquire>
80101ad4:	83 c4 10             	add    $0x10,%esp
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101ad7:	8b 45 08             	mov    0x8(%ebp),%eax
80101ada:	8b 40 08             	mov    0x8(%eax),%eax
80101add:	83 f8 01             	cmp    $0x1,%eax
80101ae0:	0f 85 a9 00 00 00    	jne    80101b8f <iput+0xce>
80101ae6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae9:	8b 40 0c             	mov    0xc(%eax),%eax
80101aec:	83 e0 02             	and    $0x2,%eax
80101aef:	85 c0                	test   %eax,%eax
80101af1:	0f 84 98 00 00 00    	je     80101b8f <iput+0xce>
80101af7:	8b 45 08             	mov    0x8(%ebp),%eax
80101afa:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80101afe:	66 85 c0             	test   %ax,%ax
80101b01:	0f 85 88 00 00 00    	jne    80101b8f <iput+0xce>
    // inode has no links: truncate and free inode.
    if(ip->flags & I_BUSY)
80101b07:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0a:	8b 40 0c             	mov    0xc(%eax),%eax
80101b0d:	83 e0 01             	and    $0x1,%eax
80101b10:	85 c0                	test   %eax,%eax
80101b12:	74 0d                	je     80101b21 <iput+0x60>
      panic("iput busy");
80101b14:	83 ec 0c             	sub    $0xc,%esp
80101b17:	68 84 82 10 80       	push   $0x80108284
80101b1c:	e8 45 ea ff ff       	call   80100566 <panic>
    ip->flags |= I_BUSY;
80101b21:	8b 45 08             	mov    0x8(%ebp),%eax
80101b24:	8b 40 0c             	mov    0xc(%eax),%eax
80101b27:	83 c8 01             	or     $0x1,%eax
80101b2a:	89 c2                	mov    %eax,%edx
80101b2c:	8b 45 08             	mov    0x8(%ebp),%eax
80101b2f:	89 50 0c             	mov    %edx,0xc(%eax)
    release(&icache.lock);
80101b32:	83 ec 0c             	sub    $0xc,%esp
80101b35:	68 80 e8 10 80       	push   $0x8010e880
80101b3a:	e8 11 31 00 00       	call   80104c50 <release>
80101b3f:	83 c4 10             	add    $0x10,%esp
    itrunc(ip);
80101b42:	83 ec 0c             	sub    $0xc,%esp
80101b45:	ff 75 08             	pushl  0x8(%ebp)
80101b48:	e8 a8 01 00 00       	call   80101cf5 <itrunc>
80101b4d:	83 c4 10             	add    $0x10,%esp
    ip->type = 0;
80101b50:	8b 45 08             	mov    0x8(%ebp),%eax
80101b53:	66 c7 40 10 00 00    	movw   $0x0,0x10(%eax)
    iupdate(ip);
80101b59:	83 ec 0c             	sub    $0xc,%esp
80101b5c:	ff 75 08             	pushl  0x8(%ebp)
80101b5f:	e8 bf fb ff ff       	call   80101723 <iupdate>
80101b64:	83 c4 10             	add    $0x10,%esp
    acquire(&icache.lock);
80101b67:	83 ec 0c             	sub    $0xc,%esp
80101b6a:	68 80 e8 10 80       	push   $0x8010e880
80101b6f:	e8 75 30 00 00       	call   80104be9 <acquire>
80101b74:	83 c4 10             	add    $0x10,%esp
    ip->flags = 0;
80101b77:	8b 45 08             	mov    0x8(%ebp),%eax
80101b7a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    wakeup(ip);
80101b81:	83 ec 0c             	sub    $0xc,%esp
80101b84:	ff 75 08             	pushl  0x8(%ebp)
80101b87:	e8 19 2e 00 00       	call   801049a5 <wakeup>
80101b8c:	83 c4 10             	add    $0x10,%esp
  }
  ip->ref--;
80101b8f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b92:	8b 40 08             	mov    0x8(%eax),%eax
80101b95:	8d 50 ff             	lea    -0x1(%eax),%edx
80101b98:	8b 45 08             	mov    0x8(%ebp),%eax
80101b9b:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101b9e:	83 ec 0c             	sub    $0xc,%esp
80101ba1:	68 80 e8 10 80       	push   $0x8010e880
80101ba6:	e8 a5 30 00 00       	call   80104c50 <release>
80101bab:	83 c4 10             	add    $0x10,%esp
}
80101bae:	90                   	nop
80101baf:	c9                   	leave  
80101bb0:	c3                   	ret    

80101bb1 <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101bb1:	55                   	push   %ebp
80101bb2:	89 e5                	mov    %esp,%ebp
80101bb4:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101bb7:	83 ec 0c             	sub    $0xc,%esp
80101bba:	ff 75 08             	pushl  0x8(%ebp)
80101bbd:	e8 8d fe ff ff       	call   80101a4f <iunlock>
80101bc2:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101bc5:	83 ec 0c             	sub    $0xc,%esp
80101bc8:	ff 75 08             	pushl  0x8(%ebp)
80101bcb:	e8 f1 fe ff ff       	call   80101ac1 <iput>
80101bd0:	83 c4 10             	add    $0x10,%esp
}
80101bd3:	90                   	nop
80101bd4:	c9                   	leave  
80101bd5:	c3                   	ret    

80101bd6 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101bd6:	55                   	push   %ebp
80101bd7:	89 e5                	mov    %esp,%ebp
80101bd9:	53                   	push   %ebx
80101bda:	83 ec 14             	sub    $0x14,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101bdd:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101be1:	77 42                	ja     80101c25 <bmap+0x4f>
    if((addr = ip->addrs[bn]) == 0)
80101be3:	8b 45 08             	mov    0x8(%ebp),%eax
80101be6:	8b 55 0c             	mov    0xc(%ebp),%edx
80101be9:	83 c2 04             	add    $0x4,%edx
80101bec:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101bf0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101bf3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101bf7:	75 24                	jne    80101c1d <bmap+0x47>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101bf9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bfc:	8b 00                	mov    (%eax),%eax
80101bfe:	83 ec 0c             	sub    $0xc,%esp
80101c01:	50                   	push   %eax
80101c02:	e8 e4 f7 ff ff       	call   801013eb <balloc>
80101c07:	83 c4 10             	add    $0x10,%esp
80101c0a:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c0d:	8b 45 08             	mov    0x8(%ebp),%eax
80101c10:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c13:	8d 4a 04             	lea    0x4(%edx),%ecx
80101c16:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c19:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101c1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101c20:	e9 cb 00 00 00       	jmp    80101cf0 <bmap+0x11a>
  }
  bn -= NDIRECT;
80101c25:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101c29:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101c2d:	0f 87 b0 00 00 00    	ja     80101ce3 <bmap+0x10d>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101c33:	8b 45 08             	mov    0x8(%ebp),%eax
80101c36:	8b 40 4c             	mov    0x4c(%eax),%eax
80101c39:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c3c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c40:	75 1d                	jne    80101c5f <bmap+0x89>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101c42:	8b 45 08             	mov    0x8(%ebp),%eax
80101c45:	8b 00                	mov    (%eax),%eax
80101c47:	83 ec 0c             	sub    $0xc,%esp
80101c4a:	50                   	push   %eax
80101c4b:	e8 9b f7 ff ff       	call   801013eb <balloc>
80101c50:	83 c4 10             	add    $0x10,%esp
80101c53:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c56:	8b 45 08             	mov    0x8(%ebp),%eax
80101c59:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101c5c:	89 50 4c             	mov    %edx,0x4c(%eax)
    bp = bread(ip->dev, addr);
80101c5f:	8b 45 08             	mov    0x8(%ebp),%eax
80101c62:	8b 00                	mov    (%eax),%eax
80101c64:	83 ec 08             	sub    $0x8,%esp
80101c67:	ff 75 f4             	pushl  -0xc(%ebp)
80101c6a:	50                   	push   %eax
80101c6b:	e8 46 e5 ff ff       	call   801001b6 <bread>
80101c70:	83 c4 10             	add    $0x10,%esp
80101c73:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101c76:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101c79:	83 c0 18             	add    $0x18,%eax
80101c7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101c7f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c82:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101c89:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101c8c:	01 d0                	add    %edx,%eax
80101c8e:	8b 00                	mov    (%eax),%eax
80101c90:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c93:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c97:	75 37                	jne    80101cd0 <bmap+0xfa>
      a[bn] = addr = balloc(ip->dev);
80101c99:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c9c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101ca3:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101ca6:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80101ca9:	8b 45 08             	mov    0x8(%ebp),%eax
80101cac:	8b 00                	mov    (%eax),%eax
80101cae:	83 ec 0c             	sub    $0xc,%esp
80101cb1:	50                   	push   %eax
80101cb2:	e8 34 f7 ff ff       	call   801013eb <balloc>
80101cb7:	83 c4 10             	add    $0x10,%esp
80101cba:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cc0:	89 03                	mov    %eax,(%ebx)
      log_write(bp);
80101cc2:	83 ec 0c             	sub    $0xc,%esp
80101cc5:	ff 75 f0             	pushl  -0x10(%ebp)
80101cc8:	e8 66 16 00 00       	call   80103333 <log_write>
80101ccd:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101cd0:	83 ec 0c             	sub    $0xc,%esp
80101cd3:	ff 75 f0             	pushl  -0x10(%ebp)
80101cd6:	e8 53 e5 ff ff       	call   8010022e <brelse>
80101cdb:	83 c4 10             	add    $0x10,%esp
    return addr;
80101cde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ce1:	eb 0d                	jmp    80101cf0 <bmap+0x11a>
  }

  panic("bmap: out of range");
80101ce3:	83 ec 0c             	sub    $0xc,%esp
80101ce6:	68 8e 82 10 80       	push   $0x8010828e
80101ceb:	e8 76 e8 ff ff       	call   80100566 <panic>
}
80101cf0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101cf3:	c9                   	leave  
80101cf4:	c3                   	ret    

80101cf5 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101cf5:	55                   	push   %ebp
80101cf6:	89 e5                	mov    %esp,%ebp
80101cf8:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101cfb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d02:	eb 45                	jmp    80101d49 <itrunc+0x54>
    if(ip->addrs[i]){
80101d04:	8b 45 08             	mov    0x8(%ebp),%eax
80101d07:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d0a:	83 c2 04             	add    $0x4,%edx
80101d0d:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d11:	85 c0                	test   %eax,%eax
80101d13:	74 30                	je     80101d45 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101d15:	8b 45 08             	mov    0x8(%ebp),%eax
80101d18:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d1b:	83 c2 04             	add    $0x4,%edx
80101d1e:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101d22:	8b 55 08             	mov    0x8(%ebp),%edx
80101d25:	8b 12                	mov    (%edx),%edx
80101d27:	83 ec 08             	sub    $0x8,%esp
80101d2a:	50                   	push   %eax
80101d2b:	52                   	push   %edx
80101d2c:	e8 18 f8 ff ff       	call   80101549 <bfree>
80101d31:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101d34:	8b 45 08             	mov    0x8(%ebp),%eax
80101d37:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101d3a:	83 c2 04             	add    $0x4,%edx
80101d3d:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101d44:	00 
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d45:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101d49:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101d4d:	7e b5                	jle    80101d04 <itrunc+0xf>
      bfree(ip->dev, ip->addrs[i]);
      ip->addrs[i] = 0;
    }
  }
  
  if(ip->addrs[NDIRECT]){
80101d4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101d52:	8b 40 4c             	mov    0x4c(%eax),%eax
80101d55:	85 c0                	test   %eax,%eax
80101d57:	0f 84 a1 00 00 00    	je     80101dfe <itrunc+0x109>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101d5d:	8b 45 08             	mov    0x8(%ebp),%eax
80101d60:	8b 50 4c             	mov    0x4c(%eax),%edx
80101d63:	8b 45 08             	mov    0x8(%ebp),%eax
80101d66:	8b 00                	mov    (%eax),%eax
80101d68:	83 ec 08             	sub    $0x8,%esp
80101d6b:	52                   	push   %edx
80101d6c:	50                   	push   %eax
80101d6d:	e8 44 e4 ff ff       	call   801001b6 <bread>
80101d72:	83 c4 10             	add    $0x10,%esp
80101d75:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101d78:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d7b:	83 c0 18             	add    $0x18,%eax
80101d7e:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101d81:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101d88:	eb 3c                	jmp    80101dc6 <itrunc+0xd1>
      if(a[j])
80101d8a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d8d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d94:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101d97:	01 d0                	add    %edx,%eax
80101d99:	8b 00                	mov    (%eax),%eax
80101d9b:	85 c0                	test   %eax,%eax
80101d9d:	74 23                	je     80101dc2 <itrunc+0xcd>
        bfree(ip->dev, a[j]);
80101d9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101da2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101da9:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101dac:	01 d0                	add    %edx,%eax
80101dae:	8b 00                	mov    (%eax),%eax
80101db0:	8b 55 08             	mov    0x8(%ebp),%edx
80101db3:	8b 12                	mov    (%edx),%edx
80101db5:	83 ec 08             	sub    $0x8,%esp
80101db8:	50                   	push   %eax
80101db9:	52                   	push   %edx
80101dba:	e8 8a f7 ff ff       	call   80101549 <bfree>
80101dbf:	83 c4 10             	add    $0x10,%esp
  }
  
  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
    a = (uint*)bp->data;
    for(j = 0; j < NINDIRECT; j++){
80101dc2:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101dc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101dc9:	83 f8 7f             	cmp    $0x7f,%eax
80101dcc:	76 bc                	jbe    80101d8a <itrunc+0x95>
      if(a[j])
        bfree(ip->dev, a[j]);
    }
    brelse(bp);
80101dce:	83 ec 0c             	sub    $0xc,%esp
80101dd1:	ff 75 ec             	pushl  -0x14(%ebp)
80101dd4:	e8 55 e4 ff ff       	call   8010022e <brelse>
80101dd9:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ddc:	8b 45 08             	mov    0x8(%ebp),%eax
80101ddf:	8b 40 4c             	mov    0x4c(%eax),%eax
80101de2:	8b 55 08             	mov    0x8(%ebp),%edx
80101de5:	8b 12                	mov    (%edx),%edx
80101de7:	83 ec 08             	sub    $0x8,%esp
80101dea:	50                   	push   %eax
80101deb:	52                   	push   %edx
80101dec:	e8 58 f7 ff ff       	call   80101549 <bfree>
80101df1:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101df4:	8b 45 08             	mov    0x8(%ebp),%eax
80101df7:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  }

  ip->size = 0;
80101dfe:	8b 45 08             	mov    0x8(%ebp),%eax
80101e01:	c7 40 18 00 00 00 00 	movl   $0x0,0x18(%eax)
  iupdate(ip);
80101e08:	83 ec 0c             	sub    $0xc,%esp
80101e0b:	ff 75 08             	pushl  0x8(%ebp)
80101e0e:	e8 10 f9 ff ff       	call   80101723 <iupdate>
80101e13:	83 c4 10             	add    $0x10,%esp
}
80101e16:	90                   	nop
80101e17:	c9                   	leave  
80101e18:	c3                   	ret    

80101e19 <stati>:

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
80101e19:	55                   	push   %ebp
80101e1a:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101e1c:	8b 45 08             	mov    0x8(%ebp),%eax
80101e1f:	8b 00                	mov    (%eax),%eax
80101e21:	89 c2                	mov    %eax,%edx
80101e23:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e26:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101e29:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2c:	8b 50 04             	mov    0x4(%eax),%edx
80101e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e32:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101e35:	8b 45 08             	mov    0x8(%ebp),%eax
80101e38:	0f b7 50 10          	movzwl 0x10(%eax),%edx
80101e3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e3f:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101e42:	8b 45 08             	mov    0x8(%ebp),%eax
80101e45:	0f b7 50 16          	movzwl 0x16(%eax),%edx
80101e49:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e4c:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101e50:	8b 45 08             	mov    0x8(%ebp),%eax
80101e53:	8b 50 18             	mov    0x18(%eax),%edx
80101e56:	8b 45 0c             	mov    0xc(%ebp),%eax
80101e59:	89 50 10             	mov    %edx,0x10(%eax)
}
80101e5c:	90                   	nop
80101e5d:	5d                   	pop    %ebp
80101e5e:	c3                   	ret    

80101e5f <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101e5f:	55                   	push   %ebp
80101e60:	89 e5                	mov    %esp,%ebp
80101e62:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e65:	8b 45 08             	mov    0x8(%ebp),%eax
80101e68:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101e6c:	66 83 f8 03          	cmp    $0x3,%ax
80101e70:	75 5c                	jne    80101ece <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101e72:	8b 45 08             	mov    0x8(%ebp),%eax
80101e75:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e79:	66 85 c0             	test   %ax,%ax
80101e7c:	78 20                	js     80101e9e <readi+0x3f>
80101e7e:	8b 45 08             	mov    0x8(%ebp),%eax
80101e81:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e85:	66 83 f8 09          	cmp    $0x9,%ax
80101e89:	7f 13                	jg     80101e9e <readi+0x3f>
80101e8b:	8b 45 08             	mov    0x8(%ebp),%eax
80101e8e:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101e92:	98                   	cwtl   
80101e93:	8b 04 c5 20 e8 10 80 	mov    -0x7fef17e0(,%eax,8),%eax
80101e9a:	85 c0                	test   %eax,%eax
80101e9c:	75 0a                	jne    80101ea8 <readi+0x49>
      return -1;
80101e9e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ea3:	e9 0c 01 00 00       	jmp    80101fb4 <readi+0x155>
    return devsw[ip->major].read(ip, dst, n);
80101ea8:	8b 45 08             	mov    0x8(%ebp),%eax
80101eab:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101eaf:	98                   	cwtl   
80101eb0:	8b 04 c5 20 e8 10 80 	mov    -0x7fef17e0(,%eax,8),%eax
80101eb7:	8b 55 14             	mov    0x14(%ebp),%edx
80101eba:	83 ec 04             	sub    $0x4,%esp
80101ebd:	52                   	push   %edx
80101ebe:	ff 75 0c             	pushl  0xc(%ebp)
80101ec1:	ff 75 08             	pushl  0x8(%ebp)
80101ec4:	ff d0                	call   *%eax
80101ec6:	83 c4 10             	add    $0x10,%esp
80101ec9:	e9 e6 00 00 00       	jmp    80101fb4 <readi+0x155>
  }

  if(off > ip->size || off + n < off)
80101ece:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed1:	8b 40 18             	mov    0x18(%eax),%eax
80101ed4:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ed7:	72 0d                	jb     80101ee6 <readi+0x87>
80101ed9:	8b 55 10             	mov    0x10(%ebp),%edx
80101edc:	8b 45 14             	mov    0x14(%ebp),%eax
80101edf:	01 d0                	add    %edx,%eax
80101ee1:	3b 45 10             	cmp    0x10(%ebp),%eax
80101ee4:	73 0a                	jae    80101ef0 <readi+0x91>
    return -1;
80101ee6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eeb:	e9 c4 00 00 00       	jmp    80101fb4 <readi+0x155>
  if(off + n > ip->size)
80101ef0:	8b 55 10             	mov    0x10(%ebp),%edx
80101ef3:	8b 45 14             	mov    0x14(%ebp),%eax
80101ef6:	01 c2                	add    %eax,%edx
80101ef8:	8b 45 08             	mov    0x8(%ebp),%eax
80101efb:	8b 40 18             	mov    0x18(%eax),%eax
80101efe:	39 c2                	cmp    %eax,%edx
80101f00:	76 0c                	jbe    80101f0e <readi+0xaf>
    n = ip->size - off;
80101f02:	8b 45 08             	mov    0x8(%ebp),%eax
80101f05:	8b 40 18             	mov    0x18(%eax),%eax
80101f08:	2b 45 10             	sub    0x10(%ebp),%eax
80101f0b:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f0e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101f15:	e9 8b 00 00 00       	jmp    80101fa5 <readi+0x146>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f1a:	8b 45 10             	mov    0x10(%ebp),%eax
80101f1d:	c1 e8 09             	shr    $0x9,%eax
80101f20:	83 ec 08             	sub    $0x8,%esp
80101f23:	50                   	push   %eax
80101f24:	ff 75 08             	pushl  0x8(%ebp)
80101f27:	e8 aa fc ff ff       	call   80101bd6 <bmap>
80101f2c:	83 c4 10             	add    $0x10,%esp
80101f2f:	89 c2                	mov    %eax,%edx
80101f31:	8b 45 08             	mov    0x8(%ebp),%eax
80101f34:	8b 00                	mov    (%eax),%eax
80101f36:	83 ec 08             	sub    $0x8,%esp
80101f39:	52                   	push   %edx
80101f3a:	50                   	push   %eax
80101f3b:	e8 76 e2 ff ff       	call   801001b6 <bread>
80101f40:	83 c4 10             	add    $0x10,%esp
80101f43:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101f46:	8b 45 10             	mov    0x10(%ebp),%eax
80101f49:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f4e:	ba 00 02 00 00       	mov    $0x200,%edx
80101f53:	29 c2                	sub    %eax,%edx
80101f55:	8b 45 14             	mov    0x14(%ebp),%eax
80101f58:	2b 45 f4             	sub    -0xc(%ebp),%eax
80101f5b:	39 c2                	cmp    %eax,%edx
80101f5d:	0f 46 c2             	cmovbe %edx,%eax
80101f60:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80101f63:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101f66:	8d 50 18             	lea    0x18(%eax),%edx
80101f69:	8b 45 10             	mov    0x10(%ebp),%eax
80101f6c:	25 ff 01 00 00       	and    $0x1ff,%eax
80101f71:	01 d0                	add    %edx,%eax
80101f73:	83 ec 04             	sub    $0x4,%esp
80101f76:	ff 75 ec             	pushl  -0x14(%ebp)
80101f79:	50                   	push   %eax
80101f7a:	ff 75 0c             	pushl  0xc(%ebp)
80101f7d:	e8 89 2f 00 00       	call   80104f0b <memmove>
80101f82:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101f85:	83 ec 0c             	sub    $0xc,%esp
80101f88:	ff 75 f0             	pushl  -0x10(%ebp)
80101f8b:	e8 9e e2 ff ff       	call   8010022e <brelse>
80101f90:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f93:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f96:	01 45 f4             	add    %eax,-0xc(%ebp)
80101f99:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101f9c:	01 45 10             	add    %eax,0x10(%ebp)
80101f9f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101fa2:	01 45 0c             	add    %eax,0xc(%ebp)
80101fa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fa8:	3b 45 14             	cmp    0x14(%ebp),%eax
80101fab:	0f 82 69 ff ff ff    	jb     80101f1a <readi+0xbb>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
    memmove(dst, bp->data + off%BSIZE, m);
    brelse(bp);
  }
  return n;
80101fb1:	8b 45 14             	mov    0x14(%ebp),%eax
}
80101fb4:	c9                   	leave  
80101fb5:	c3                   	ret    

80101fb6 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101fb6:	55                   	push   %ebp
80101fb7:	89 e5                	mov    %esp,%ebp
80101fb9:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101fbc:	8b 45 08             	mov    0x8(%ebp),%eax
80101fbf:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80101fc3:	66 83 f8 03          	cmp    $0x3,%ax
80101fc7:	75 5c                	jne    80102025 <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101fc9:	8b 45 08             	mov    0x8(%ebp),%eax
80101fcc:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fd0:	66 85 c0             	test   %ax,%ax
80101fd3:	78 20                	js     80101ff5 <writei+0x3f>
80101fd5:	8b 45 08             	mov    0x8(%ebp),%eax
80101fd8:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fdc:	66 83 f8 09          	cmp    $0x9,%ax
80101fe0:	7f 13                	jg     80101ff5 <writei+0x3f>
80101fe2:	8b 45 08             	mov    0x8(%ebp),%eax
80101fe5:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80101fe9:	98                   	cwtl   
80101fea:	8b 04 c5 24 e8 10 80 	mov    -0x7fef17dc(,%eax,8),%eax
80101ff1:	85 c0                	test   %eax,%eax
80101ff3:	75 0a                	jne    80101fff <writei+0x49>
      return -1;
80101ff5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ffa:	e9 3d 01 00 00       	jmp    8010213c <writei+0x186>
    return devsw[ip->major].write(ip, src, n);
80101fff:	8b 45 08             	mov    0x8(%ebp),%eax
80102002:	0f b7 40 12          	movzwl 0x12(%eax),%eax
80102006:	98                   	cwtl   
80102007:	8b 04 c5 24 e8 10 80 	mov    -0x7fef17dc(,%eax,8),%eax
8010200e:	8b 55 14             	mov    0x14(%ebp),%edx
80102011:	83 ec 04             	sub    $0x4,%esp
80102014:	52                   	push   %edx
80102015:	ff 75 0c             	pushl  0xc(%ebp)
80102018:	ff 75 08             	pushl  0x8(%ebp)
8010201b:	ff d0                	call   *%eax
8010201d:	83 c4 10             	add    $0x10,%esp
80102020:	e9 17 01 00 00       	jmp    8010213c <writei+0x186>
  }

  if(off > ip->size || off + n < off)
80102025:	8b 45 08             	mov    0x8(%ebp),%eax
80102028:	8b 40 18             	mov    0x18(%eax),%eax
8010202b:	3b 45 10             	cmp    0x10(%ebp),%eax
8010202e:	72 0d                	jb     8010203d <writei+0x87>
80102030:	8b 55 10             	mov    0x10(%ebp),%edx
80102033:	8b 45 14             	mov    0x14(%ebp),%eax
80102036:	01 d0                	add    %edx,%eax
80102038:	3b 45 10             	cmp    0x10(%ebp),%eax
8010203b:	73 0a                	jae    80102047 <writei+0x91>
    return -1;
8010203d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102042:	e9 f5 00 00 00       	jmp    8010213c <writei+0x186>
  if(off + n > MAXFILE*BSIZE)
80102047:	8b 55 10             	mov    0x10(%ebp),%edx
8010204a:	8b 45 14             	mov    0x14(%ebp),%eax
8010204d:	01 d0                	add    %edx,%eax
8010204f:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102054:	76 0a                	jbe    80102060 <writei+0xaa>
    return -1;
80102056:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010205b:	e9 dc 00 00 00       	jmp    8010213c <writei+0x186>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102060:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102067:	e9 99 00 00 00       	jmp    80102105 <writei+0x14f>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
8010206c:	8b 45 10             	mov    0x10(%ebp),%eax
8010206f:	c1 e8 09             	shr    $0x9,%eax
80102072:	83 ec 08             	sub    $0x8,%esp
80102075:	50                   	push   %eax
80102076:	ff 75 08             	pushl  0x8(%ebp)
80102079:	e8 58 fb ff ff       	call   80101bd6 <bmap>
8010207e:	83 c4 10             	add    $0x10,%esp
80102081:	89 c2                	mov    %eax,%edx
80102083:	8b 45 08             	mov    0x8(%ebp),%eax
80102086:	8b 00                	mov    (%eax),%eax
80102088:	83 ec 08             	sub    $0x8,%esp
8010208b:	52                   	push   %edx
8010208c:	50                   	push   %eax
8010208d:	e8 24 e1 ff ff       	call   801001b6 <bread>
80102092:	83 c4 10             	add    $0x10,%esp
80102095:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80102098:	8b 45 10             	mov    0x10(%ebp),%eax
8010209b:	25 ff 01 00 00       	and    $0x1ff,%eax
801020a0:	ba 00 02 00 00       	mov    $0x200,%edx
801020a5:	29 c2                	sub    %eax,%edx
801020a7:	8b 45 14             	mov    0x14(%ebp),%eax
801020aa:	2b 45 f4             	sub    -0xc(%ebp),%eax
801020ad:	39 c2                	cmp    %eax,%edx
801020af:	0f 46 c2             	cmovbe %edx,%eax
801020b2:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
801020b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801020b8:	8d 50 18             	lea    0x18(%eax),%edx
801020bb:	8b 45 10             	mov    0x10(%ebp),%eax
801020be:	25 ff 01 00 00       	and    $0x1ff,%eax
801020c3:	01 d0                	add    %edx,%eax
801020c5:	83 ec 04             	sub    $0x4,%esp
801020c8:	ff 75 ec             	pushl  -0x14(%ebp)
801020cb:	ff 75 0c             	pushl  0xc(%ebp)
801020ce:	50                   	push   %eax
801020cf:	e8 37 2e 00 00       	call   80104f0b <memmove>
801020d4:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
801020d7:	83 ec 0c             	sub    $0xc,%esp
801020da:	ff 75 f0             	pushl  -0x10(%ebp)
801020dd:	e8 51 12 00 00       	call   80103333 <log_write>
801020e2:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
801020e5:	83 ec 0c             	sub    $0xc,%esp
801020e8:	ff 75 f0             	pushl  -0x10(%ebp)
801020eb:	e8 3e e1 ff ff       	call   8010022e <brelse>
801020f0:	83 c4 10             	add    $0x10,%esp
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020f6:	01 45 f4             	add    %eax,-0xc(%ebp)
801020f9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801020fc:	01 45 10             	add    %eax,0x10(%ebp)
801020ff:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102102:	01 45 0c             	add    %eax,0xc(%ebp)
80102105:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102108:	3b 45 14             	cmp    0x14(%ebp),%eax
8010210b:	0f 82 5b ff ff ff    	jb     8010206c <writei+0xb6>
    memmove(bp->data + off%BSIZE, src, m);
    log_write(bp);
    brelse(bp);
  }

  if(n > 0 && off > ip->size){
80102111:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80102115:	74 22                	je     80102139 <writei+0x183>
80102117:	8b 45 08             	mov    0x8(%ebp),%eax
8010211a:	8b 40 18             	mov    0x18(%eax),%eax
8010211d:	3b 45 10             	cmp    0x10(%ebp),%eax
80102120:	73 17                	jae    80102139 <writei+0x183>
    ip->size = off;
80102122:	8b 45 08             	mov    0x8(%ebp),%eax
80102125:	8b 55 10             	mov    0x10(%ebp),%edx
80102128:	89 50 18             	mov    %edx,0x18(%eax)
    iupdate(ip);
8010212b:	83 ec 0c             	sub    $0xc,%esp
8010212e:	ff 75 08             	pushl  0x8(%ebp)
80102131:	e8 ed f5 ff ff       	call   80101723 <iupdate>
80102136:	83 c4 10             	add    $0x10,%esp
  }
  return n;
80102139:	8b 45 14             	mov    0x14(%ebp),%eax
}
8010213c:	c9                   	leave  
8010213d:	c3                   	ret    

8010213e <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
8010213e:	55                   	push   %ebp
8010213f:	89 e5                	mov    %esp,%ebp
80102141:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
80102144:	83 ec 04             	sub    $0x4,%esp
80102147:	6a 0e                	push   $0xe
80102149:	ff 75 0c             	pushl  0xc(%ebp)
8010214c:	ff 75 08             	pushl  0x8(%ebp)
8010214f:	e8 4d 2e 00 00       	call   80104fa1 <strncmp>
80102154:	83 c4 10             	add    $0x10,%esp
}
80102157:	c9                   	leave  
80102158:	c3                   	ret    

80102159 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102159:	55                   	push   %ebp
8010215a:	89 e5                	mov    %esp,%ebp
8010215c:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
8010215f:	8b 45 08             	mov    0x8(%ebp),%eax
80102162:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80102166:	66 83 f8 01          	cmp    $0x1,%ax
8010216a:	74 0d                	je     80102179 <dirlookup+0x20>
    panic("dirlookup not DIR");
8010216c:	83 ec 0c             	sub    $0xc,%esp
8010216f:	68 a1 82 10 80       	push   $0x801082a1
80102174:	e8 ed e3 ff ff       	call   80100566 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
80102179:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102180:	eb 7b                	jmp    801021fd <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102182:	6a 10                	push   $0x10
80102184:	ff 75 f4             	pushl  -0xc(%ebp)
80102187:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010218a:	50                   	push   %eax
8010218b:	ff 75 08             	pushl  0x8(%ebp)
8010218e:	e8 cc fc ff ff       	call   80101e5f <readi>
80102193:	83 c4 10             	add    $0x10,%esp
80102196:	83 f8 10             	cmp    $0x10,%eax
80102199:	74 0d                	je     801021a8 <dirlookup+0x4f>
      panic("dirlink read");
8010219b:	83 ec 0c             	sub    $0xc,%esp
8010219e:	68 b3 82 10 80       	push   $0x801082b3
801021a3:	e8 be e3 ff ff       	call   80100566 <panic>
    if(de.inum == 0)
801021a8:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021ac:	66 85 c0             	test   %ax,%ax
801021af:	74 47                	je     801021f8 <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
801021b1:	83 ec 08             	sub    $0x8,%esp
801021b4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801021b7:	83 c0 02             	add    $0x2,%eax
801021ba:	50                   	push   %eax
801021bb:	ff 75 0c             	pushl  0xc(%ebp)
801021be:	e8 7b ff ff ff       	call   8010213e <namecmp>
801021c3:	83 c4 10             	add    $0x10,%esp
801021c6:	85 c0                	test   %eax,%eax
801021c8:	75 2f                	jne    801021f9 <dirlookup+0xa0>
      // entry matches path element
      if(poff)
801021ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801021ce:	74 08                	je     801021d8 <dirlookup+0x7f>
        *poff = off;
801021d0:	8b 45 10             	mov    0x10(%ebp),%eax
801021d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801021d6:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
801021d8:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
801021dc:	0f b7 c0             	movzwl %ax,%eax
801021df:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
801021e2:	8b 45 08             	mov    0x8(%ebp),%eax
801021e5:	8b 00                	mov    (%eax),%eax
801021e7:	83 ec 08             	sub    $0x8,%esp
801021ea:	ff 75 f0             	pushl  -0x10(%ebp)
801021ed:	50                   	push   %eax
801021ee:	e8 eb f5 ff ff       	call   801017de <iget>
801021f3:	83 c4 10             	add    $0x10,%esp
801021f6:	eb 19                	jmp    80102211 <dirlookup+0xb8>

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
801021f8:	90                   	nop
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801021f9:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801021fd:	8b 45 08             	mov    0x8(%ebp),%eax
80102200:	8b 40 18             	mov    0x18(%eax),%eax
80102203:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80102206:	0f 87 76 ff ff ff    	ja     80102182 <dirlookup+0x29>
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
8010220c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102211:	c9                   	leave  
80102212:	c3                   	ret    

80102213 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80102213:	55                   	push   %ebp
80102214:	89 e5                	mov    %esp,%ebp
80102216:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80102219:	83 ec 04             	sub    $0x4,%esp
8010221c:	6a 00                	push   $0x0
8010221e:	ff 75 0c             	pushl  0xc(%ebp)
80102221:	ff 75 08             	pushl  0x8(%ebp)
80102224:	e8 30 ff ff ff       	call   80102159 <dirlookup>
80102229:	83 c4 10             	add    $0x10,%esp
8010222c:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010222f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102233:	74 18                	je     8010224d <dirlink+0x3a>
    iput(ip);
80102235:	83 ec 0c             	sub    $0xc,%esp
80102238:	ff 75 f0             	pushl  -0x10(%ebp)
8010223b:	e8 81 f8 ff ff       	call   80101ac1 <iput>
80102240:	83 c4 10             	add    $0x10,%esp
    return -1;
80102243:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102248:	e9 9c 00 00 00       	jmp    801022e9 <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
8010224d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102254:	eb 39                	jmp    8010228f <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102256:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102259:	6a 10                	push   $0x10
8010225b:	50                   	push   %eax
8010225c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010225f:	50                   	push   %eax
80102260:	ff 75 08             	pushl  0x8(%ebp)
80102263:	e8 f7 fb ff ff       	call   80101e5f <readi>
80102268:	83 c4 10             	add    $0x10,%esp
8010226b:	83 f8 10             	cmp    $0x10,%eax
8010226e:	74 0d                	je     8010227d <dirlink+0x6a>
      panic("dirlink read");
80102270:	83 ec 0c             	sub    $0xc,%esp
80102273:	68 b3 82 10 80       	push   $0x801082b3
80102278:	e8 e9 e2 ff ff       	call   80100566 <panic>
    if(de.inum == 0)
8010227d:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102281:	66 85 c0             	test   %ax,%ax
80102284:	74 18                	je     8010229e <dirlink+0x8b>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80102286:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102289:	83 c0 10             	add    $0x10,%eax
8010228c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010228f:	8b 45 08             	mov    0x8(%ebp),%eax
80102292:	8b 50 18             	mov    0x18(%eax),%edx
80102295:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102298:	39 c2                	cmp    %eax,%edx
8010229a:	77 ba                	ja     80102256 <dirlink+0x43>
8010229c:	eb 01                	jmp    8010229f <dirlink+0x8c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      break;
8010229e:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
8010229f:	83 ec 04             	sub    $0x4,%esp
801022a2:	6a 0e                	push   $0xe
801022a4:	ff 75 0c             	pushl  0xc(%ebp)
801022a7:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022aa:	83 c0 02             	add    $0x2,%eax
801022ad:	50                   	push   %eax
801022ae:	e8 44 2d 00 00       	call   80104ff7 <strncpy>
801022b3:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
801022b6:	8b 45 10             	mov    0x10(%ebp),%eax
801022b9:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022c0:	6a 10                	push   $0x10
801022c2:	50                   	push   %eax
801022c3:	8d 45 e0             	lea    -0x20(%ebp),%eax
801022c6:	50                   	push   %eax
801022c7:	ff 75 08             	pushl  0x8(%ebp)
801022ca:	e8 e7 fc ff ff       	call   80101fb6 <writei>
801022cf:	83 c4 10             	add    $0x10,%esp
801022d2:	83 f8 10             	cmp    $0x10,%eax
801022d5:	74 0d                	je     801022e4 <dirlink+0xd1>
    panic("dirlink");
801022d7:	83 ec 0c             	sub    $0xc,%esp
801022da:	68 c0 82 10 80       	push   $0x801082c0
801022df:	e8 82 e2 ff ff       	call   80100566 <panic>
  
  return 0;
801022e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022e9:	c9                   	leave  
801022ea:	c3                   	ret    

801022eb <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
801022eb:	55                   	push   %ebp
801022ec:	89 e5                	mov    %esp,%ebp
801022ee:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
801022f1:	eb 04                	jmp    801022f7 <skipelem+0xc>
    path++;
801022f3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
801022f7:	8b 45 08             	mov    0x8(%ebp),%eax
801022fa:	0f b6 00             	movzbl (%eax),%eax
801022fd:	3c 2f                	cmp    $0x2f,%al
801022ff:	74 f2                	je     801022f3 <skipelem+0x8>
    path++;
  if(*path == 0)
80102301:	8b 45 08             	mov    0x8(%ebp),%eax
80102304:	0f b6 00             	movzbl (%eax),%eax
80102307:	84 c0                	test   %al,%al
80102309:	75 07                	jne    80102312 <skipelem+0x27>
    return 0;
8010230b:	b8 00 00 00 00       	mov    $0x0,%eax
80102310:	eb 7b                	jmp    8010238d <skipelem+0xa2>
  s = path;
80102312:	8b 45 08             	mov    0x8(%ebp),%eax
80102315:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
80102318:	eb 04                	jmp    8010231e <skipelem+0x33>
    path++;
8010231a:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
8010231e:	8b 45 08             	mov    0x8(%ebp),%eax
80102321:	0f b6 00             	movzbl (%eax),%eax
80102324:	3c 2f                	cmp    $0x2f,%al
80102326:	74 0a                	je     80102332 <skipelem+0x47>
80102328:	8b 45 08             	mov    0x8(%ebp),%eax
8010232b:	0f b6 00             	movzbl (%eax),%eax
8010232e:	84 c0                	test   %al,%al
80102330:	75 e8                	jne    8010231a <skipelem+0x2f>
    path++;
  len = path - s;
80102332:	8b 55 08             	mov    0x8(%ebp),%edx
80102335:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102338:	29 c2                	sub    %eax,%edx
8010233a:	89 d0                	mov    %edx,%eax
8010233c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
8010233f:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80102343:	7e 15                	jle    8010235a <skipelem+0x6f>
    memmove(name, s, DIRSIZ);
80102345:	83 ec 04             	sub    $0x4,%esp
80102348:	6a 0e                	push   $0xe
8010234a:	ff 75 f4             	pushl  -0xc(%ebp)
8010234d:	ff 75 0c             	pushl  0xc(%ebp)
80102350:	e8 b6 2b 00 00       	call   80104f0b <memmove>
80102355:	83 c4 10             	add    $0x10,%esp
80102358:	eb 26                	jmp    80102380 <skipelem+0x95>
  else {
    memmove(name, s, len);
8010235a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010235d:	83 ec 04             	sub    $0x4,%esp
80102360:	50                   	push   %eax
80102361:	ff 75 f4             	pushl  -0xc(%ebp)
80102364:	ff 75 0c             	pushl  0xc(%ebp)
80102367:	e8 9f 2b 00 00       	call   80104f0b <memmove>
8010236c:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
8010236f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102372:	8b 45 0c             	mov    0xc(%ebp),%eax
80102375:	01 d0                	add    %edx,%eax
80102377:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
8010237a:	eb 04                	jmp    80102380 <skipelem+0x95>
    path++;
8010237c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80102380:	8b 45 08             	mov    0x8(%ebp),%eax
80102383:	0f b6 00             	movzbl (%eax),%eax
80102386:	3c 2f                	cmp    $0x2f,%al
80102388:	74 f2                	je     8010237c <skipelem+0x91>
    path++;
  return path;
8010238a:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010238d:	c9                   	leave  
8010238e:	c3                   	ret    

8010238f <namex>:
// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010238f:	55                   	push   %ebp
80102390:	89 e5                	mov    %esp,%ebp
80102392:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102395:	8b 45 08             	mov    0x8(%ebp),%eax
80102398:	0f b6 00             	movzbl (%eax),%eax
8010239b:	3c 2f                	cmp    $0x2f,%al
8010239d:	75 17                	jne    801023b6 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
8010239f:	83 ec 08             	sub    $0x8,%esp
801023a2:	6a 01                	push   $0x1
801023a4:	6a 01                	push   $0x1
801023a6:	e8 33 f4 ff ff       	call   801017de <iget>
801023ab:	83 c4 10             	add    $0x10,%esp
801023ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
801023b1:	e9 bb 00 00 00       	jmp    80102471 <namex+0xe2>
  else
    ip = idup(proc->cwd);
801023b6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801023bc:	8b 40 68             	mov    0x68(%eax),%eax
801023bf:	83 ec 0c             	sub    $0xc,%esp
801023c2:	50                   	push   %eax
801023c3:	e8 f5 f4 ff ff       	call   801018bd <idup>
801023c8:	83 c4 10             	add    $0x10,%esp
801023cb:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
801023ce:	e9 9e 00 00 00       	jmp    80102471 <namex+0xe2>
    ilock(ip);
801023d3:	83 ec 0c             	sub    $0xc,%esp
801023d6:	ff 75 f4             	pushl  -0xc(%ebp)
801023d9:	e8 19 f5 ff ff       	call   801018f7 <ilock>
801023de:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
801023e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801023e4:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801023e8:	66 83 f8 01          	cmp    $0x1,%ax
801023ec:	74 18                	je     80102406 <namex+0x77>
      iunlockput(ip);
801023ee:	83 ec 0c             	sub    $0xc,%esp
801023f1:	ff 75 f4             	pushl  -0xc(%ebp)
801023f4:	e8 b8 f7 ff ff       	call   80101bb1 <iunlockput>
801023f9:	83 c4 10             	add    $0x10,%esp
      return 0;
801023fc:	b8 00 00 00 00       	mov    $0x0,%eax
80102401:	e9 a7 00 00 00       	jmp    801024ad <namex+0x11e>
    }
    if(nameiparent && *path == '\0'){
80102406:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010240a:	74 20                	je     8010242c <namex+0x9d>
8010240c:	8b 45 08             	mov    0x8(%ebp),%eax
8010240f:	0f b6 00             	movzbl (%eax),%eax
80102412:	84 c0                	test   %al,%al
80102414:	75 16                	jne    8010242c <namex+0x9d>
      // Stop one level early.
      iunlock(ip);
80102416:	83 ec 0c             	sub    $0xc,%esp
80102419:	ff 75 f4             	pushl  -0xc(%ebp)
8010241c:	e8 2e f6 ff ff       	call   80101a4f <iunlock>
80102421:	83 c4 10             	add    $0x10,%esp
      return ip;
80102424:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102427:	e9 81 00 00 00       	jmp    801024ad <namex+0x11e>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
8010242c:	83 ec 04             	sub    $0x4,%esp
8010242f:	6a 00                	push   $0x0
80102431:	ff 75 10             	pushl  0x10(%ebp)
80102434:	ff 75 f4             	pushl  -0xc(%ebp)
80102437:	e8 1d fd ff ff       	call   80102159 <dirlookup>
8010243c:	83 c4 10             	add    $0x10,%esp
8010243f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80102442:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80102446:	75 15                	jne    8010245d <namex+0xce>
      iunlockput(ip);
80102448:	83 ec 0c             	sub    $0xc,%esp
8010244b:	ff 75 f4             	pushl  -0xc(%ebp)
8010244e:	e8 5e f7 ff ff       	call   80101bb1 <iunlockput>
80102453:	83 c4 10             	add    $0x10,%esp
      return 0;
80102456:	b8 00 00 00 00       	mov    $0x0,%eax
8010245b:	eb 50                	jmp    801024ad <namex+0x11e>
    }
    iunlockput(ip);
8010245d:	83 ec 0c             	sub    $0xc,%esp
80102460:	ff 75 f4             	pushl  -0xc(%ebp)
80102463:	e8 49 f7 ff ff       	call   80101bb1 <iunlockput>
80102468:	83 c4 10             	add    $0x10,%esp
    ip = next;
8010246b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010246e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
80102471:	83 ec 08             	sub    $0x8,%esp
80102474:	ff 75 10             	pushl  0x10(%ebp)
80102477:	ff 75 08             	pushl  0x8(%ebp)
8010247a:	e8 6c fe ff ff       	call   801022eb <skipelem>
8010247f:	83 c4 10             	add    $0x10,%esp
80102482:	89 45 08             	mov    %eax,0x8(%ebp)
80102485:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102489:	0f 85 44 ff ff ff    	jne    801023d3 <namex+0x44>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
8010248f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102493:	74 15                	je     801024aa <namex+0x11b>
    iput(ip);
80102495:	83 ec 0c             	sub    $0xc,%esp
80102498:	ff 75 f4             	pushl  -0xc(%ebp)
8010249b:	e8 21 f6 ff ff       	call   80101ac1 <iput>
801024a0:	83 c4 10             	add    $0x10,%esp
    return 0;
801024a3:	b8 00 00 00 00       	mov    $0x0,%eax
801024a8:	eb 03                	jmp    801024ad <namex+0x11e>
  }
  return ip;
801024aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801024ad:	c9                   	leave  
801024ae:	c3                   	ret    

801024af <namei>:

struct inode*
namei(char *path)
{
801024af:	55                   	push   %ebp
801024b0:	89 e5                	mov    %esp,%ebp
801024b2:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
801024b5:	83 ec 04             	sub    $0x4,%esp
801024b8:	8d 45 ea             	lea    -0x16(%ebp),%eax
801024bb:	50                   	push   %eax
801024bc:	6a 00                	push   $0x0
801024be:	ff 75 08             	pushl  0x8(%ebp)
801024c1:	e8 c9 fe ff ff       	call   8010238f <namex>
801024c6:	83 c4 10             	add    $0x10,%esp
}
801024c9:	c9                   	leave  
801024ca:	c3                   	ret    

801024cb <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
801024cb:	55                   	push   %ebp
801024cc:	89 e5                	mov    %esp,%ebp
801024ce:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
801024d1:	83 ec 04             	sub    $0x4,%esp
801024d4:	ff 75 0c             	pushl  0xc(%ebp)
801024d7:	6a 01                	push   $0x1
801024d9:	ff 75 08             	pushl  0x8(%ebp)
801024dc:	e8 ae fe ff ff       	call   8010238f <namex>
801024e1:	83 c4 10             	add    $0x10,%esp
}
801024e4:	c9                   	leave  
801024e5:	c3                   	ret    

801024e6 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801024e6:	55                   	push   %ebp
801024e7:	89 e5                	mov    %esp,%ebp
801024e9:	83 ec 14             	sub    $0x14,%esp
801024ec:	8b 45 08             	mov    0x8(%ebp),%eax
801024ef:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024f3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801024f7:	89 c2                	mov    %eax,%edx
801024f9:	ec                   	in     (%dx),%al
801024fa:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801024fd:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102501:	c9                   	leave  
80102502:	c3                   	ret    

80102503 <insl>:

static inline void
insl(int port, void *addr, int cnt)
{
80102503:	55                   	push   %ebp
80102504:	89 e5                	mov    %esp,%ebp
80102506:	57                   	push   %edi
80102507:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
80102508:	8b 55 08             	mov    0x8(%ebp),%edx
8010250b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010250e:	8b 45 10             	mov    0x10(%ebp),%eax
80102511:	89 cb                	mov    %ecx,%ebx
80102513:	89 df                	mov    %ebx,%edi
80102515:	89 c1                	mov    %eax,%ecx
80102517:	fc                   	cld    
80102518:	f3 6d                	rep insl (%dx),%es:(%edi)
8010251a:	89 c8                	mov    %ecx,%eax
8010251c:	89 fb                	mov    %edi,%ebx
8010251e:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102521:	89 45 10             	mov    %eax,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "memory", "cc");
}
80102524:	90                   	nop
80102525:	5b                   	pop    %ebx
80102526:	5f                   	pop    %edi
80102527:	5d                   	pop    %ebp
80102528:	c3                   	ret    

80102529 <outb>:

static inline void
outb(ushort port, uchar data)
{
80102529:	55                   	push   %ebp
8010252a:	89 e5                	mov    %esp,%ebp
8010252c:	83 ec 08             	sub    $0x8,%esp
8010252f:	8b 55 08             	mov    0x8(%ebp),%edx
80102532:	8b 45 0c             	mov    0xc(%ebp),%eax
80102535:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102539:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010253c:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102540:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102544:	ee                   	out    %al,(%dx)
}
80102545:	90                   	nop
80102546:	c9                   	leave  
80102547:	c3                   	ret    

80102548 <outsl>:
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
}

static inline void
outsl(int port, const void *addr, int cnt)
{
80102548:	55                   	push   %ebp
80102549:	89 e5                	mov    %esp,%ebp
8010254b:	56                   	push   %esi
8010254c:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
8010254d:	8b 55 08             	mov    0x8(%ebp),%edx
80102550:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102553:	8b 45 10             	mov    0x10(%ebp),%eax
80102556:	89 cb                	mov    %ecx,%ebx
80102558:	89 de                	mov    %ebx,%esi
8010255a:	89 c1                	mov    %eax,%ecx
8010255c:	fc                   	cld    
8010255d:	f3 6f                	rep outsl %ds:(%esi),(%dx)
8010255f:	89 c8                	mov    %ecx,%eax
80102561:	89 f3                	mov    %esi,%ebx
80102563:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102566:	89 45 10             	mov    %eax,0x10(%ebp)
               "=S" (addr), "=c" (cnt) :
               "d" (port), "0" (addr), "1" (cnt) :
               "cc");
}
80102569:	90                   	nop
8010256a:	5b                   	pop    %ebx
8010256b:	5e                   	pop    %esi
8010256c:	5d                   	pop    %ebp
8010256d:	c3                   	ret    

8010256e <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
8010256e:	55                   	push   %ebp
8010256f:	89 e5                	mov    %esp,%ebp
80102571:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY) 
80102574:	90                   	nop
80102575:	68 f7 01 00 00       	push   $0x1f7
8010257a:	e8 67 ff ff ff       	call   801024e6 <inb>
8010257f:	83 c4 04             	add    $0x4,%esp
80102582:	0f b6 c0             	movzbl %al,%eax
80102585:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102588:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010258b:	25 c0 00 00 00       	and    $0xc0,%eax
80102590:	83 f8 40             	cmp    $0x40,%eax
80102593:	75 e0                	jne    80102575 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102595:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102599:	74 11                	je     801025ac <idewait+0x3e>
8010259b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010259e:	83 e0 21             	and    $0x21,%eax
801025a1:	85 c0                	test   %eax,%eax
801025a3:	74 07                	je     801025ac <idewait+0x3e>
    return -1;
801025a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801025aa:	eb 05                	jmp    801025b1 <idewait+0x43>
  return 0;
801025ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
801025b1:	c9                   	leave  
801025b2:	c3                   	ret    

801025b3 <ideinit>:

void
ideinit(void)
{
801025b3:	55                   	push   %ebp
801025b4:	89 e5                	mov    %esp,%ebp
801025b6:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
801025b9:	83 ec 08             	sub    $0x8,%esp
801025bc:	68 c8 82 10 80       	push   $0x801082c8
801025c1:	68 20 b6 10 80       	push   $0x8010b620
801025c6:	e8 fc 25 00 00       	call   80104bc7 <initlock>
801025cb:	83 c4 10             	add    $0x10,%esp
  picenable(IRQ_IDE);
801025ce:	83 ec 0c             	sub    $0xc,%esp
801025d1:	6a 0e                	push   $0xe
801025d3:	e8 46 15 00 00       	call   80103b1e <picenable>
801025d8:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
801025db:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801025e0:	83 e8 01             	sub    $0x1,%eax
801025e3:	83 ec 08             	sub    $0x8,%esp
801025e6:	50                   	push   %eax
801025e7:	6a 0e                	push   $0xe
801025e9:	e8 37 04 00 00       	call   80102a25 <ioapicenable>
801025ee:	83 c4 10             	add    $0x10,%esp
  idewait(0);
801025f1:	83 ec 0c             	sub    $0xc,%esp
801025f4:	6a 00                	push   $0x0
801025f6:	e8 73 ff ff ff       	call   8010256e <idewait>
801025fb:	83 c4 10             	add    $0x10,%esp
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
801025fe:	83 ec 08             	sub    $0x8,%esp
80102601:	68 f0 00 00 00       	push   $0xf0
80102606:	68 f6 01 00 00       	push   $0x1f6
8010260b:	e8 19 ff ff ff       	call   80102529 <outb>
80102610:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
80102613:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010261a:	eb 24                	jmp    80102640 <ideinit+0x8d>
    if(inb(0x1f7) != 0){
8010261c:	83 ec 0c             	sub    $0xc,%esp
8010261f:	68 f7 01 00 00       	push   $0x1f7
80102624:	e8 bd fe ff ff       	call   801024e6 <inb>
80102629:	83 c4 10             	add    $0x10,%esp
8010262c:	84 c0                	test   %al,%al
8010262e:	74 0c                	je     8010263c <ideinit+0x89>
      havedisk1 = 1;
80102630:	c7 05 58 b6 10 80 01 	movl   $0x1,0x8010b658
80102637:	00 00 00 
      break;
8010263a:	eb 0d                	jmp    80102649 <ideinit+0x96>
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);
  
  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
8010263c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102640:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
80102647:	7e d3                	jle    8010261c <ideinit+0x69>
      break;
    }
  }
  
  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
80102649:	83 ec 08             	sub    $0x8,%esp
8010264c:	68 e0 00 00 00       	push   $0xe0
80102651:	68 f6 01 00 00       	push   $0x1f6
80102656:	e8 ce fe ff ff       	call   80102529 <outb>
8010265b:	83 c4 10             	add    $0x10,%esp
}
8010265e:	90                   	nop
8010265f:	c9                   	leave  
80102660:	c3                   	ret    

80102661 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102661:	55                   	push   %ebp
80102662:	89 e5                	mov    %esp,%ebp
80102664:	83 ec 08             	sub    $0x8,%esp
  if(b == 0)
80102667:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010266b:	75 0d                	jne    8010267a <idestart+0x19>
    panic("idestart");
8010266d:	83 ec 0c             	sub    $0xc,%esp
80102670:	68 cc 82 10 80       	push   $0x801082cc
80102675:	e8 ec de ff ff       	call   80100566 <panic>

  idewait(0);
8010267a:	83 ec 0c             	sub    $0xc,%esp
8010267d:	6a 00                	push   $0x0
8010267f:	e8 ea fe ff ff       	call   8010256e <idewait>
80102684:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102687:	83 ec 08             	sub    $0x8,%esp
8010268a:	6a 00                	push   $0x0
8010268c:	68 f6 03 00 00       	push   $0x3f6
80102691:	e8 93 fe ff ff       	call   80102529 <outb>
80102696:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, 1);  // number of sectors
80102699:	83 ec 08             	sub    $0x8,%esp
8010269c:	6a 01                	push   $0x1
8010269e:	68 f2 01 00 00       	push   $0x1f2
801026a3:	e8 81 fe ff ff       	call   80102529 <outb>
801026a8:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, b->sector & 0xff);
801026ab:	8b 45 08             	mov    0x8(%ebp),%eax
801026ae:	8b 40 08             	mov    0x8(%eax),%eax
801026b1:	0f b6 c0             	movzbl %al,%eax
801026b4:	83 ec 08             	sub    $0x8,%esp
801026b7:	50                   	push   %eax
801026b8:	68 f3 01 00 00       	push   $0x1f3
801026bd:	e8 67 fe ff ff       	call   80102529 <outb>
801026c2:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (b->sector >> 8) & 0xff);
801026c5:	8b 45 08             	mov    0x8(%ebp),%eax
801026c8:	8b 40 08             	mov    0x8(%eax),%eax
801026cb:	c1 e8 08             	shr    $0x8,%eax
801026ce:	0f b6 c0             	movzbl %al,%eax
801026d1:	83 ec 08             	sub    $0x8,%esp
801026d4:	50                   	push   %eax
801026d5:	68 f4 01 00 00       	push   $0x1f4
801026da:	e8 4a fe ff ff       	call   80102529 <outb>
801026df:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (b->sector >> 16) & 0xff);
801026e2:	8b 45 08             	mov    0x8(%ebp),%eax
801026e5:	8b 40 08             	mov    0x8(%eax),%eax
801026e8:	c1 e8 10             	shr    $0x10,%eax
801026eb:	0f b6 c0             	movzbl %al,%eax
801026ee:	83 ec 08             	sub    $0x8,%esp
801026f1:	50                   	push   %eax
801026f2:	68 f5 01 00 00       	push   $0x1f5
801026f7:	e8 2d fe ff ff       	call   80102529 <outb>
801026fc:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
801026ff:	8b 45 08             	mov    0x8(%ebp),%eax
80102702:	8b 40 04             	mov    0x4(%eax),%eax
80102705:	83 e0 01             	and    $0x1,%eax
80102708:	c1 e0 04             	shl    $0x4,%eax
8010270b:	89 c2                	mov    %eax,%edx
8010270d:	8b 45 08             	mov    0x8(%ebp),%eax
80102710:	8b 40 08             	mov    0x8(%eax),%eax
80102713:	c1 e8 18             	shr    $0x18,%eax
80102716:	83 e0 0f             	and    $0xf,%eax
80102719:	09 d0                	or     %edx,%eax
8010271b:	83 c8 e0             	or     $0xffffffe0,%eax
8010271e:	0f b6 c0             	movzbl %al,%eax
80102721:	83 ec 08             	sub    $0x8,%esp
80102724:	50                   	push   %eax
80102725:	68 f6 01 00 00       	push   $0x1f6
8010272a:	e8 fa fd ff ff       	call   80102529 <outb>
8010272f:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
80102732:	8b 45 08             	mov    0x8(%ebp),%eax
80102735:	8b 00                	mov    (%eax),%eax
80102737:	83 e0 04             	and    $0x4,%eax
8010273a:	85 c0                	test   %eax,%eax
8010273c:	74 30                	je     8010276e <idestart+0x10d>
    outb(0x1f7, IDE_CMD_WRITE);
8010273e:	83 ec 08             	sub    $0x8,%esp
80102741:	6a 30                	push   $0x30
80102743:	68 f7 01 00 00       	push   $0x1f7
80102748:	e8 dc fd ff ff       	call   80102529 <outb>
8010274d:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, 512/4);
80102750:	8b 45 08             	mov    0x8(%ebp),%eax
80102753:	83 c0 18             	add    $0x18,%eax
80102756:	83 ec 04             	sub    $0x4,%esp
80102759:	68 80 00 00 00       	push   $0x80
8010275e:	50                   	push   %eax
8010275f:	68 f0 01 00 00       	push   $0x1f0
80102764:	e8 df fd ff ff       	call   80102548 <outsl>
80102769:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, IDE_CMD_READ);
  }
}
8010276c:	eb 12                	jmp    80102780 <idestart+0x11f>
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((b->sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, IDE_CMD_WRITE);
    outsl(0x1f0, b->data, 512/4);
  } else {
    outb(0x1f7, IDE_CMD_READ);
8010276e:	83 ec 08             	sub    $0x8,%esp
80102771:	6a 20                	push   $0x20
80102773:	68 f7 01 00 00       	push   $0x1f7
80102778:	e8 ac fd ff ff       	call   80102529 <outb>
8010277d:	83 c4 10             	add    $0x10,%esp
  }
}
80102780:	90                   	nop
80102781:	c9                   	leave  
80102782:	c3                   	ret    

80102783 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102783:	55                   	push   %ebp
80102784:	89 e5                	mov    %esp,%ebp
80102786:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102789:	83 ec 0c             	sub    $0xc,%esp
8010278c:	68 20 b6 10 80       	push   $0x8010b620
80102791:	e8 53 24 00 00       	call   80104be9 <acquire>
80102796:	83 c4 10             	add    $0x10,%esp
  if((b = idequeue) == 0){
80102799:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010279e:	89 45 f4             	mov    %eax,-0xc(%ebp)
801027a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801027a5:	75 15                	jne    801027bc <ideintr+0x39>
    release(&idelock);
801027a7:	83 ec 0c             	sub    $0xc,%esp
801027aa:	68 20 b6 10 80       	push   $0x8010b620
801027af:	e8 9c 24 00 00       	call   80104c50 <release>
801027b4:	83 c4 10             	add    $0x10,%esp
    // cprintf("spurious IDE interrupt\n");
    return;
801027b7:	e9 9a 00 00 00       	jmp    80102856 <ideintr+0xd3>
  }
  idequeue = b->qnext;
801027bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027bf:	8b 40 14             	mov    0x14(%eax),%eax
801027c2:	a3 54 b6 10 80       	mov    %eax,0x8010b654

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801027c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027ca:	8b 00                	mov    (%eax),%eax
801027cc:	83 e0 04             	and    $0x4,%eax
801027cf:	85 c0                	test   %eax,%eax
801027d1:	75 2d                	jne    80102800 <ideintr+0x7d>
801027d3:	83 ec 0c             	sub    $0xc,%esp
801027d6:	6a 01                	push   $0x1
801027d8:	e8 91 fd ff ff       	call   8010256e <idewait>
801027dd:	83 c4 10             	add    $0x10,%esp
801027e0:	85 c0                	test   %eax,%eax
801027e2:	78 1c                	js     80102800 <ideintr+0x7d>
    insl(0x1f0, b->data, 512/4);
801027e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801027e7:	83 c0 18             	add    $0x18,%eax
801027ea:	83 ec 04             	sub    $0x4,%esp
801027ed:	68 80 00 00 00       	push   $0x80
801027f2:	50                   	push   %eax
801027f3:	68 f0 01 00 00       	push   $0x1f0
801027f8:	e8 06 fd ff ff       	call   80102503 <insl>
801027fd:	83 c4 10             	add    $0x10,%esp
  
  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102800:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102803:	8b 00                	mov    (%eax),%eax
80102805:	83 c8 02             	or     $0x2,%eax
80102808:	89 c2                	mov    %eax,%edx
8010280a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010280d:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
8010280f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102812:	8b 00                	mov    (%eax),%eax
80102814:	83 e0 fb             	and    $0xfffffffb,%eax
80102817:	89 c2                	mov    %eax,%edx
80102819:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010281c:	89 10                	mov    %edx,(%eax)
  wakeup(b);
8010281e:	83 ec 0c             	sub    $0xc,%esp
80102821:	ff 75 f4             	pushl  -0xc(%ebp)
80102824:	e8 7c 21 00 00       	call   801049a5 <wakeup>
80102829:	83 c4 10             	add    $0x10,%esp
  
  // Start disk on next buf in queue.
  if(idequeue != 0)
8010282c:	a1 54 b6 10 80       	mov    0x8010b654,%eax
80102831:	85 c0                	test   %eax,%eax
80102833:	74 11                	je     80102846 <ideintr+0xc3>
    idestart(idequeue);
80102835:	a1 54 b6 10 80       	mov    0x8010b654,%eax
8010283a:	83 ec 0c             	sub    $0xc,%esp
8010283d:	50                   	push   %eax
8010283e:	e8 1e fe ff ff       	call   80102661 <idestart>
80102843:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102846:	83 ec 0c             	sub    $0xc,%esp
80102849:	68 20 b6 10 80       	push   $0x8010b620
8010284e:	e8 fd 23 00 00       	call   80104c50 <release>
80102853:	83 c4 10             	add    $0x10,%esp
}
80102856:	c9                   	leave  
80102857:	c3                   	ret    

80102858 <iderw>:
// Sync buf with disk. 
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102858:	55                   	push   %ebp
80102859:	89 e5                	mov    %esp,%ebp
8010285b:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!(b->flags & B_BUSY))
8010285e:	8b 45 08             	mov    0x8(%ebp),%eax
80102861:	8b 00                	mov    (%eax),%eax
80102863:	83 e0 01             	and    $0x1,%eax
80102866:	85 c0                	test   %eax,%eax
80102868:	75 0d                	jne    80102877 <iderw+0x1f>
    panic("iderw: buf not busy");
8010286a:	83 ec 0c             	sub    $0xc,%esp
8010286d:	68 d5 82 10 80       	push   $0x801082d5
80102872:	e8 ef dc ff ff       	call   80100566 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102877:	8b 45 08             	mov    0x8(%ebp),%eax
8010287a:	8b 00                	mov    (%eax),%eax
8010287c:	83 e0 06             	and    $0x6,%eax
8010287f:	83 f8 02             	cmp    $0x2,%eax
80102882:	75 0d                	jne    80102891 <iderw+0x39>
    panic("iderw: nothing to do");
80102884:	83 ec 0c             	sub    $0xc,%esp
80102887:	68 e9 82 10 80       	push   $0x801082e9
8010288c:	e8 d5 dc ff ff       	call   80100566 <panic>
  if(b->dev != 0 && !havedisk1)
80102891:	8b 45 08             	mov    0x8(%ebp),%eax
80102894:	8b 40 04             	mov    0x4(%eax),%eax
80102897:	85 c0                	test   %eax,%eax
80102899:	74 16                	je     801028b1 <iderw+0x59>
8010289b:	a1 58 b6 10 80       	mov    0x8010b658,%eax
801028a0:	85 c0                	test   %eax,%eax
801028a2:	75 0d                	jne    801028b1 <iderw+0x59>
    panic("iderw: ide disk 1 not present");
801028a4:	83 ec 0c             	sub    $0xc,%esp
801028a7:	68 fe 82 10 80       	push   $0x801082fe
801028ac:	e8 b5 dc ff ff       	call   80100566 <panic>

  acquire(&idelock);  //DOC:acquire-lock
801028b1:	83 ec 0c             	sub    $0xc,%esp
801028b4:	68 20 b6 10 80       	push   $0x8010b620
801028b9:	e8 2b 23 00 00       	call   80104be9 <acquire>
801028be:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801028c1:	8b 45 08             	mov    0x8(%ebp),%eax
801028c4:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801028cb:	c7 45 f4 54 b6 10 80 	movl   $0x8010b654,-0xc(%ebp)
801028d2:	eb 0b                	jmp    801028df <iderw+0x87>
801028d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028d7:	8b 00                	mov    (%eax),%eax
801028d9:	83 c0 14             	add    $0x14,%eax
801028dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028df:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028e2:	8b 00                	mov    (%eax),%eax
801028e4:	85 c0                	test   %eax,%eax
801028e6:	75 ec                	jne    801028d4 <iderw+0x7c>
    ;
  *pp = b;
801028e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028eb:	8b 55 08             	mov    0x8(%ebp),%edx
801028ee:	89 10                	mov    %edx,(%eax)
  
  // Start disk if necessary.
  if(idequeue == b)
801028f0:	a1 54 b6 10 80       	mov    0x8010b654,%eax
801028f5:	3b 45 08             	cmp    0x8(%ebp),%eax
801028f8:	75 23                	jne    8010291d <iderw+0xc5>
    idestart(b);
801028fa:	83 ec 0c             	sub    $0xc,%esp
801028fd:	ff 75 08             	pushl  0x8(%ebp)
80102900:	e8 5c fd ff ff       	call   80102661 <idestart>
80102905:	83 c4 10             	add    $0x10,%esp
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102908:	eb 13                	jmp    8010291d <iderw+0xc5>
    sleep(b, &idelock);
8010290a:	83 ec 08             	sub    $0x8,%esp
8010290d:	68 20 b6 10 80       	push   $0x8010b620
80102912:	ff 75 08             	pushl  0x8(%ebp)
80102915:	e8 a0 1f 00 00       	call   801048ba <sleep>
8010291a:	83 c4 10             	add    $0x10,%esp
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010291d:	8b 45 08             	mov    0x8(%ebp),%eax
80102920:	8b 00                	mov    (%eax),%eax
80102922:	83 e0 06             	and    $0x6,%eax
80102925:	83 f8 02             	cmp    $0x2,%eax
80102928:	75 e0                	jne    8010290a <iderw+0xb2>
    sleep(b, &idelock);
  }

  release(&idelock);
8010292a:	83 ec 0c             	sub    $0xc,%esp
8010292d:	68 20 b6 10 80       	push   $0x8010b620
80102932:	e8 19 23 00 00       	call   80104c50 <release>
80102937:	83 c4 10             	add    $0x10,%esp
}
8010293a:	90                   	nop
8010293b:	c9                   	leave  
8010293c:	c3                   	ret    

8010293d <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
8010293d:	55                   	push   %ebp
8010293e:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102940:	a1 54 f8 10 80       	mov    0x8010f854,%eax
80102945:	8b 55 08             	mov    0x8(%ebp),%edx
80102948:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
8010294a:	a1 54 f8 10 80       	mov    0x8010f854,%eax
8010294f:	8b 40 10             	mov    0x10(%eax),%eax
}
80102952:	5d                   	pop    %ebp
80102953:	c3                   	ret    

80102954 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102954:	55                   	push   %ebp
80102955:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102957:	a1 54 f8 10 80       	mov    0x8010f854,%eax
8010295c:	8b 55 08             	mov    0x8(%ebp),%edx
8010295f:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102961:	a1 54 f8 10 80       	mov    0x8010f854,%eax
80102966:	8b 55 0c             	mov    0xc(%ebp),%edx
80102969:	89 50 10             	mov    %edx,0x10(%eax)
}
8010296c:	90                   	nop
8010296d:	5d                   	pop    %ebp
8010296e:	c3                   	ret    

8010296f <ioapicinit>:

void
ioapicinit(void)
{
8010296f:	55                   	push   %ebp
80102970:	89 e5                	mov    %esp,%ebp
80102972:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  if(!ismp)
80102975:	a1 24 f9 10 80       	mov    0x8010f924,%eax
8010297a:	85 c0                	test   %eax,%eax
8010297c:	0f 84 a0 00 00 00    	je     80102a22 <ioapicinit+0xb3>
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102982:	c7 05 54 f8 10 80 00 	movl   $0xfec00000,0x8010f854
80102989:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010298c:	6a 01                	push   $0x1
8010298e:	e8 aa ff ff ff       	call   8010293d <ioapicread>
80102993:	83 c4 04             	add    $0x4,%esp
80102996:	c1 e8 10             	shr    $0x10,%eax
80102999:	25 ff 00 00 00       	and    $0xff,%eax
8010299e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
801029a1:	6a 00                	push   $0x0
801029a3:	e8 95 ff ff ff       	call   8010293d <ioapicread>
801029a8:	83 c4 04             	add    $0x4,%esp
801029ab:	c1 e8 18             	shr    $0x18,%eax
801029ae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
801029b1:	0f b6 05 20 f9 10 80 	movzbl 0x8010f920,%eax
801029b8:	0f b6 c0             	movzbl %al,%eax
801029bb:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801029be:	74 10                	je     801029d0 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801029c0:	83 ec 0c             	sub    $0xc,%esp
801029c3:	68 1c 83 10 80       	push   $0x8010831c
801029c8:	e8 f9 d9 ff ff       	call   801003c6 <cprintf>
801029cd:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801029d0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801029d7:	eb 3f                	jmp    80102a18 <ioapicinit+0xa9>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801029d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029dc:	83 c0 20             	add    $0x20,%eax
801029df:	0d 00 00 01 00       	or     $0x10000,%eax
801029e4:	89 c2                	mov    %eax,%edx
801029e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029e9:	83 c0 08             	add    $0x8,%eax
801029ec:	01 c0                	add    %eax,%eax
801029ee:	83 ec 08             	sub    $0x8,%esp
801029f1:	52                   	push   %edx
801029f2:	50                   	push   %eax
801029f3:	e8 5c ff ff ff       	call   80102954 <ioapicwrite>
801029f8:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
801029fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029fe:	83 c0 08             	add    $0x8,%eax
80102a01:	01 c0                	add    %eax,%eax
80102a03:	83 c0 01             	add    $0x1,%eax
80102a06:	83 ec 08             	sub    $0x8,%esp
80102a09:	6a 00                	push   $0x0
80102a0b:	50                   	push   %eax
80102a0c:	e8 43 ff ff ff       	call   80102954 <ioapicwrite>
80102a11:	83 c4 10             	add    $0x10,%esp
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102a14:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102a18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102a1b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102a1e:	7e b9                	jle    801029d9 <ioapicinit+0x6a>
80102a20:	eb 01                	jmp    80102a23 <ioapicinit+0xb4>
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
    return;
80102a22:	90                   	nop
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102a23:	c9                   	leave  
80102a24:	c3                   	ret    

80102a25 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102a25:	55                   	push   %ebp
80102a26:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102a28:	a1 24 f9 10 80       	mov    0x8010f924,%eax
80102a2d:	85 c0                	test   %eax,%eax
80102a2f:	74 39                	je     80102a6a <ioapicenable+0x45>
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102a31:	8b 45 08             	mov    0x8(%ebp),%eax
80102a34:	83 c0 20             	add    $0x20,%eax
80102a37:	89 c2                	mov    %eax,%edx
80102a39:	8b 45 08             	mov    0x8(%ebp),%eax
80102a3c:	83 c0 08             	add    $0x8,%eax
80102a3f:	01 c0                	add    %eax,%eax
80102a41:	52                   	push   %edx
80102a42:	50                   	push   %eax
80102a43:	e8 0c ff ff ff       	call   80102954 <ioapicwrite>
80102a48:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80102a4e:	c1 e0 18             	shl    $0x18,%eax
80102a51:	89 c2                	mov    %eax,%edx
80102a53:	8b 45 08             	mov    0x8(%ebp),%eax
80102a56:	83 c0 08             	add    $0x8,%eax
80102a59:	01 c0                	add    %eax,%eax
80102a5b:	83 c0 01             	add    $0x1,%eax
80102a5e:	52                   	push   %edx
80102a5f:	50                   	push   %eax
80102a60:	e8 ef fe ff ff       	call   80102954 <ioapicwrite>
80102a65:	83 c4 08             	add    $0x8,%esp
80102a68:	eb 01                	jmp    80102a6b <ioapicenable+0x46>

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
    return;
80102a6a:	90                   	nop
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
80102a6b:	c9                   	leave  
80102a6c:	c3                   	ret    

80102a6d <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
80102a6d:	55                   	push   %ebp
80102a6e:	89 e5                	mov    %esp,%ebp
80102a70:	8b 45 08             	mov    0x8(%ebp),%eax
80102a73:	05 00 00 00 80       	add    $0x80000000,%eax
80102a78:	5d                   	pop    %ebp
80102a79:	c3                   	ret    

80102a7a <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102a7a:	55                   	push   %ebp
80102a7b:	89 e5                	mov    %esp,%ebp
80102a7d:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102a80:	83 ec 08             	sub    $0x8,%esp
80102a83:	68 4e 83 10 80       	push   $0x8010834e
80102a88:	68 60 f8 10 80       	push   $0x8010f860
80102a8d:	e8 35 21 00 00       	call   80104bc7 <initlock>
80102a92:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a95:	c7 05 94 f8 10 80 00 	movl   $0x0,0x8010f894
80102a9c:	00 00 00 
  freerange(vstart, vend);
80102a9f:	83 ec 08             	sub    $0x8,%esp
80102aa2:	ff 75 0c             	pushl  0xc(%ebp)
80102aa5:	ff 75 08             	pushl  0x8(%ebp)
80102aa8:	e8 2a 00 00 00       	call   80102ad7 <freerange>
80102aad:	83 c4 10             	add    $0x10,%esp
}
80102ab0:	90                   	nop
80102ab1:	c9                   	leave  
80102ab2:	c3                   	ret    

80102ab3 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102ab3:	55                   	push   %ebp
80102ab4:	89 e5                	mov    %esp,%ebp
80102ab6:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102ab9:	83 ec 08             	sub    $0x8,%esp
80102abc:	ff 75 0c             	pushl  0xc(%ebp)
80102abf:	ff 75 08             	pushl  0x8(%ebp)
80102ac2:	e8 10 00 00 00       	call   80102ad7 <freerange>
80102ac7:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102aca:	c7 05 94 f8 10 80 01 	movl   $0x1,0x8010f894
80102ad1:	00 00 00 
}
80102ad4:	90                   	nop
80102ad5:	c9                   	leave  
80102ad6:	c3                   	ret    

80102ad7 <freerange>:

void
freerange(void *vstart, void *vend)
{
80102ad7:	55                   	push   %ebp
80102ad8:	89 e5                	mov    %esp,%ebp
80102ada:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102add:	8b 45 08             	mov    0x8(%ebp),%eax
80102ae0:	05 ff 0f 00 00       	add    $0xfff,%eax
80102ae5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102aea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102aed:	eb 15                	jmp    80102b04 <freerange+0x2d>
    kfree(p);
80102aef:	83 ec 0c             	sub    $0xc,%esp
80102af2:	ff 75 f4             	pushl  -0xc(%ebp)
80102af5:	e8 1a 00 00 00       	call   80102b14 <kfree>
80102afa:	83 c4 10             	add    $0x10,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102afd:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102b04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b07:	05 00 10 00 00       	add    $0x1000,%eax
80102b0c:	3b 45 0c             	cmp    0xc(%ebp),%eax
80102b0f:	76 de                	jbe    80102aef <freerange+0x18>
    kfree(p);
}
80102b11:	90                   	nop
80102b12:	c9                   	leave  
80102b13:	c3                   	ret    

80102b14 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102b14:	55                   	push   %ebp
80102b15:	89 e5                	mov    %esp,%ebp
80102b17:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || v2p(v) >= PHYSTOP)
80102b1a:	8b 45 08             	mov    0x8(%ebp),%eax
80102b1d:	25 ff 0f 00 00       	and    $0xfff,%eax
80102b22:	85 c0                	test   %eax,%eax
80102b24:	75 1b                	jne    80102b41 <kfree+0x2d>
80102b26:	81 7d 08 1c 27 11 80 	cmpl   $0x8011271c,0x8(%ebp)
80102b2d:	72 12                	jb     80102b41 <kfree+0x2d>
80102b2f:	ff 75 08             	pushl  0x8(%ebp)
80102b32:	e8 36 ff ff ff       	call   80102a6d <v2p>
80102b37:	83 c4 04             	add    $0x4,%esp
80102b3a:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102b3f:	76 0d                	jbe    80102b4e <kfree+0x3a>
    panic("kfree");
80102b41:	83 ec 0c             	sub    $0xc,%esp
80102b44:	68 53 83 10 80       	push   $0x80108353
80102b49:	e8 18 da ff ff       	call   80100566 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102b4e:	83 ec 04             	sub    $0x4,%esp
80102b51:	68 00 10 00 00       	push   $0x1000
80102b56:	6a 01                	push   $0x1
80102b58:	ff 75 08             	pushl  0x8(%ebp)
80102b5b:	e8 ec 22 00 00       	call   80104e4c <memset>
80102b60:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102b63:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102b68:	85 c0                	test   %eax,%eax
80102b6a:	74 10                	je     80102b7c <kfree+0x68>
    acquire(&kmem.lock);
80102b6c:	83 ec 0c             	sub    $0xc,%esp
80102b6f:	68 60 f8 10 80       	push   $0x8010f860
80102b74:	e8 70 20 00 00       	call   80104be9 <acquire>
80102b79:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102b7c:	8b 45 08             	mov    0x8(%ebp),%eax
80102b7f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102b82:	8b 15 98 f8 10 80    	mov    0x8010f898,%edx
80102b88:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b8b:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102b8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b90:	a3 98 f8 10 80       	mov    %eax,0x8010f898
  if(kmem.use_lock)
80102b95:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102b9a:	85 c0                	test   %eax,%eax
80102b9c:	74 10                	je     80102bae <kfree+0x9a>
    release(&kmem.lock);
80102b9e:	83 ec 0c             	sub    $0xc,%esp
80102ba1:	68 60 f8 10 80       	push   $0x8010f860
80102ba6:	e8 a5 20 00 00       	call   80104c50 <release>
80102bab:	83 c4 10             	add    $0x10,%esp
}
80102bae:	90                   	nop
80102baf:	c9                   	leave  
80102bb0:	c3                   	ret    

80102bb1 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102bb1:	55                   	push   %ebp
80102bb2:	89 e5                	mov    %esp,%ebp
80102bb4:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102bb7:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102bbc:	85 c0                	test   %eax,%eax
80102bbe:	74 10                	je     80102bd0 <kalloc+0x1f>
    acquire(&kmem.lock);
80102bc0:	83 ec 0c             	sub    $0xc,%esp
80102bc3:	68 60 f8 10 80       	push   $0x8010f860
80102bc8:	e8 1c 20 00 00       	call   80104be9 <acquire>
80102bcd:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102bd0:	a1 98 f8 10 80       	mov    0x8010f898,%eax
80102bd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102bd8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102bdc:	74 0a                	je     80102be8 <kalloc+0x37>
    kmem.freelist = r->next;
80102bde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102be1:	8b 00                	mov    (%eax),%eax
80102be3:	a3 98 f8 10 80       	mov    %eax,0x8010f898
  if(kmem.use_lock)
80102be8:	a1 94 f8 10 80       	mov    0x8010f894,%eax
80102bed:	85 c0                	test   %eax,%eax
80102bef:	74 10                	je     80102c01 <kalloc+0x50>
    release(&kmem.lock);
80102bf1:	83 ec 0c             	sub    $0xc,%esp
80102bf4:	68 60 f8 10 80       	push   $0x8010f860
80102bf9:	e8 52 20 00 00       	call   80104c50 <release>
80102bfe:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102c01:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102c04:	c9                   	leave  
80102c05:	c3                   	ret    

80102c06 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80102c06:	55                   	push   %ebp
80102c07:	89 e5                	mov    %esp,%ebp
80102c09:	83 ec 14             	sub    $0x14,%esp
80102c0c:	8b 45 08             	mov    0x8(%ebp),%eax
80102c0f:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c13:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102c17:	89 c2                	mov    %eax,%edx
80102c19:	ec                   	in     (%dx),%al
80102c1a:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102c1d:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102c21:	c9                   	leave  
80102c22:	c3                   	ret    

80102c23 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102c23:	55                   	push   %ebp
80102c24:	89 e5                	mov    %esp,%ebp
80102c26:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102c29:	6a 64                	push   $0x64
80102c2b:	e8 d6 ff ff ff       	call   80102c06 <inb>
80102c30:	83 c4 04             	add    $0x4,%esp
80102c33:	0f b6 c0             	movzbl %al,%eax
80102c36:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102c39:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c3c:	83 e0 01             	and    $0x1,%eax
80102c3f:	85 c0                	test   %eax,%eax
80102c41:	75 0a                	jne    80102c4d <kbdgetc+0x2a>
    return -1;
80102c43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c48:	e9 23 01 00 00       	jmp    80102d70 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102c4d:	6a 60                	push   $0x60
80102c4f:	e8 b2 ff ff ff       	call   80102c06 <inb>
80102c54:	83 c4 04             	add    $0x4,%esp
80102c57:	0f b6 c0             	movzbl %al,%eax
80102c5a:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102c5d:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102c64:	75 17                	jne    80102c7d <kbdgetc+0x5a>
    shift |= E0ESC;
80102c66:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c6b:	83 c8 40             	or     $0x40,%eax
80102c6e:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102c73:	b8 00 00 00 00       	mov    $0x0,%eax
80102c78:	e9 f3 00 00 00       	jmp    80102d70 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102c7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c80:	25 80 00 00 00       	and    $0x80,%eax
80102c85:	85 c0                	test   %eax,%eax
80102c87:	74 45                	je     80102cce <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102c89:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102c8e:	83 e0 40             	and    $0x40,%eax
80102c91:	85 c0                	test   %eax,%eax
80102c93:	75 08                	jne    80102c9d <kbdgetc+0x7a>
80102c95:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102c98:	83 e0 7f             	and    $0x7f,%eax
80102c9b:	eb 03                	jmp    80102ca0 <kbdgetc+0x7d>
80102c9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ca0:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102ca3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102ca6:	05 20 90 10 80       	add    $0x80109020,%eax
80102cab:	0f b6 00             	movzbl (%eax),%eax
80102cae:	83 c8 40             	or     $0x40,%eax
80102cb1:	0f b6 c0             	movzbl %al,%eax
80102cb4:	f7 d0                	not    %eax
80102cb6:	89 c2                	mov    %eax,%edx
80102cb8:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cbd:	21 d0                	and    %edx,%eax
80102cbf:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
    return 0;
80102cc4:	b8 00 00 00 00       	mov    $0x0,%eax
80102cc9:	e9 a2 00 00 00       	jmp    80102d70 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102cce:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102cd3:	83 e0 40             	and    $0x40,%eax
80102cd6:	85 c0                	test   %eax,%eax
80102cd8:	74 14                	je     80102cee <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102cda:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102ce1:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102ce6:	83 e0 bf             	and    $0xffffffbf,%eax
80102ce9:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  }

  shift |= shiftcode[data];
80102cee:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102cf1:	05 20 90 10 80       	add    $0x80109020,%eax
80102cf6:	0f b6 00             	movzbl (%eax),%eax
80102cf9:	0f b6 d0             	movzbl %al,%edx
80102cfc:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d01:	09 d0                	or     %edx,%eax
80102d03:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  shift ^= togglecode[data];
80102d08:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d0b:	05 20 91 10 80       	add    $0x80109120,%eax
80102d10:	0f b6 00             	movzbl (%eax),%eax
80102d13:	0f b6 d0             	movzbl %al,%edx
80102d16:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d1b:	31 d0                	xor    %edx,%eax
80102d1d:	a3 5c b6 10 80       	mov    %eax,0x8010b65c
  c = charcode[shift & (CTL | SHIFT)][data];
80102d22:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d27:	83 e0 03             	and    $0x3,%eax
80102d2a:	8b 14 85 20 95 10 80 	mov    -0x7fef6ae0(,%eax,4),%edx
80102d31:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d34:	01 d0                	add    %edx,%eax
80102d36:	0f b6 00             	movzbl (%eax),%eax
80102d39:	0f b6 c0             	movzbl %al,%eax
80102d3c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102d3f:	a1 5c b6 10 80       	mov    0x8010b65c,%eax
80102d44:	83 e0 08             	and    $0x8,%eax
80102d47:	85 c0                	test   %eax,%eax
80102d49:	74 22                	je     80102d6d <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102d4b:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102d4f:	76 0c                	jbe    80102d5d <kbdgetc+0x13a>
80102d51:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102d55:	77 06                	ja     80102d5d <kbdgetc+0x13a>
      c += 'A' - 'a';
80102d57:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102d5b:	eb 10                	jmp    80102d6d <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102d5d:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102d61:	76 0a                	jbe    80102d6d <kbdgetc+0x14a>
80102d63:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102d67:	77 04                	ja     80102d6d <kbdgetc+0x14a>
      c += 'a' - 'A';
80102d69:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102d6d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102d70:	c9                   	leave  
80102d71:	c3                   	ret    

80102d72 <kbdintr>:

void
kbdintr(void)
{
80102d72:	55                   	push   %ebp
80102d73:	89 e5                	mov    %esp,%ebp
80102d75:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102d78:	83 ec 0c             	sub    $0xc,%esp
80102d7b:	68 23 2c 10 80       	push   $0x80102c23
80102d80:	e8 58 da ff ff       	call   801007dd <consoleintr>
80102d85:	83 c4 10             	add    $0x10,%esp
}
80102d88:	90                   	nop
80102d89:	c9                   	leave  
80102d8a:	c3                   	ret    

80102d8b <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80102d8b:	55                   	push   %ebp
80102d8c:	89 e5                	mov    %esp,%ebp
80102d8e:	83 ec 08             	sub    $0x8,%esp
80102d91:	8b 55 08             	mov    0x8(%ebp),%edx
80102d94:	8b 45 0c             	mov    0xc(%ebp),%eax
80102d97:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80102d9b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d9e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102da2:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102da6:	ee                   	out    %al,(%dx)
}
80102da7:	90                   	nop
80102da8:	c9                   	leave  
80102da9:	c3                   	ret    

80102daa <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80102daa:	55                   	push   %ebp
80102dab:	89 e5                	mov    %esp,%ebp
80102dad:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102db0:	9c                   	pushf  
80102db1:	58                   	pop    %eax
80102db2:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80102db5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80102db8:	c9                   	leave  
80102db9:	c3                   	ret    

80102dba <lapicw>:

volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
80102dba:	55                   	push   %ebp
80102dbb:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102dbd:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102dc2:	8b 55 08             	mov    0x8(%ebp),%edx
80102dc5:	c1 e2 02             	shl    $0x2,%edx
80102dc8:	01 c2                	add    %eax,%edx
80102dca:	8b 45 0c             	mov    0xc(%ebp),%eax
80102dcd:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102dcf:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102dd4:	83 c0 20             	add    $0x20,%eax
80102dd7:	8b 00                	mov    (%eax),%eax
}
80102dd9:	90                   	nop
80102dda:	5d                   	pop    %ebp
80102ddb:	c3                   	ret    

80102ddc <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
80102ddc:	55                   	push   %ebp
80102ddd:	89 e5                	mov    %esp,%ebp
  if(!lapic) 
80102ddf:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102de4:	85 c0                	test   %eax,%eax
80102de6:	0f 84 0b 01 00 00    	je     80102ef7 <lapicinit+0x11b>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102dec:	68 3f 01 00 00       	push   $0x13f
80102df1:	6a 3c                	push   $0x3c
80102df3:	e8 c2 ff ff ff       	call   80102dba <lapicw>
80102df8:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.  
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102dfb:	6a 0b                	push   $0xb
80102dfd:	68 f8 00 00 00       	push   $0xf8
80102e02:	e8 b3 ff ff ff       	call   80102dba <lapicw>
80102e07:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102e0a:	68 20 00 02 00       	push   $0x20020
80102e0f:	68 c8 00 00 00       	push   $0xc8
80102e14:	e8 a1 ff ff ff       	call   80102dba <lapicw>
80102e19:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000); 
80102e1c:	68 80 96 98 00       	push   $0x989680
80102e21:	68 e0 00 00 00       	push   $0xe0
80102e26:	e8 8f ff ff ff       	call   80102dba <lapicw>
80102e2b:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102e2e:	68 00 00 01 00       	push   $0x10000
80102e33:	68 d4 00 00 00       	push   $0xd4
80102e38:	e8 7d ff ff ff       	call   80102dba <lapicw>
80102e3d:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102e40:	68 00 00 01 00       	push   $0x10000
80102e45:	68 d8 00 00 00       	push   $0xd8
80102e4a:	e8 6b ff ff ff       	call   80102dba <lapicw>
80102e4f:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102e52:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102e57:	83 c0 30             	add    $0x30,%eax
80102e5a:	8b 00                	mov    (%eax),%eax
80102e5c:	c1 e8 10             	shr    $0x10,%eax
80102e5f:	0f b6 c0             	movzbl %al,%eax
80102e62:	83 f8 03             	cmp    $0x3,%eax
80102e65:	76 12                	jbe    80102e79 <lapicinit+0x9d>
    lapicw(PCINT, MASKED);
80102e67:	68 00 00 01 00       	push   $0x10000
80102e6c:	68 d0 00 00 00       	push   $0xd0
80102e71:	e8 44 ff ff ff       	call   80102dba <lapicw>
80102e76:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102e79:	6a 33                	push   $0x33
80102e7b:	68 dc 00 00 00       	push   $0xdc
80102e80:	e8 35 ff ff ff       	call   80102dba <lapicw>
80102e85:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102e88:	6a 00                	push   $0x0
80102e8a:	68 a0 00 00 00       	push   $0xa0
80102e8f:	e8 26 ff ff ff       	call   80102dba <lapicw>
80102e94:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102e97:	6a 00                	push   $0x0
80102e99:	68 a0 00 00 00       	push   $0xa0
80102e9e:	e8 17 ff ff ff       	call   80102dba <lapicw>
80102ea3:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102ea6:	6a 00                	push   $0x0
80102ea8:	6a 2c                	push   $0x2c
80102eaa:	e8 0b ff ff ff       	call   80102dba <lapicw>
80102eaf:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102eb2:	6a 00                	push   $0x0
80102eb4:	68 c4 00 00 00       	push   $0xc4
80102eb9:	e8 fc fe ff ff       	call   80102dba <lapicw>
80102ebe:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102ec1:	68 00 85 08 00       	push   $0x88500
80102ec6:	68 c0 00 00 00       	push   $0xc0
80102ecb:	e8 ea fe ff ff       	call   80102dba <lapicw>
80102ed0:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102ed3:	90                   	nop
80102ed4:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102ed9:	05 00 03 00 00       	add    $0x300,%eax
80102ede:	8b 00                	mov    (%eax),%eax
80102ee0:	25 00 10 00 00       	and    $0x1000,%eax
80102ee5:	85 c0                	test   %eax,%eax
80102ee7:	75 eb                	jne    80102ed4 <lapicinit+0xf8>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102ee9:	6a 00                	push   $0x0
80102eeb:	6a 20                	push   $0x20
80102eed:	e8 c8 fe ff ff       	call   80102dba <lapicw>
80102ef2:	83 c4 08             	add    $0x8,%esp
80102ef5:	eb 01                	jmp    80102ef8 <lapicinit+0x11c>

void
lapicinit(void)
{
  if(!lapic) 
    return;
80102ef7:	90                   	nop
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102ef8:	c9                   	leave  
80102ef9:	c3                   	ret    

80102efa <cpunum>:

int
cpunum(void)
{
80102efa:	55                   	push   %ebp
80102efb:	89 e5                	mov    %esp,%ebp
80102efd:	83 ec 08             	sub    $0x8,%esp
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102f00:	e8 a5 fe ff ff       	call   80102daa <readeflags>
80102f05:	25 00 02 00 00       	and    $0x200,%eax
80102f0a:	85 c0                	test   %eax,%eax
80102f0c:	74 26                	je     80102f34 <cpunum+0x3a>
    static int n;
    if(n++ == 0)
80102f0e:	a1 60 b6 10 80       	mov    0x8010b660,%eax
80102f13:	8d 50 01             	lea    0x1(%eax),%edx
80102f16:	89 15 60 b6 10 80    	mov    %edx,0x8010b660
80102f1c:	85 c0                	test   %eax,%eax
80102f1e:	75 14                	jne    80102f34 <cpunum+0x3a>
      cprintf("cpu called from %x with interrupts enabled\n",
80102f20:	8b 45 04             	mov    0x4(%ebp),%eax
80102f23:	83 ec 08             	sub    $0x8,%esp
80102f26:	50                   	push   %eax
80102f27:	68 5c 83 10 80       	push   $0x8010835c
80102f2c:	e8 95 d4 ff ff       	call   801003c6 <cprintf>
80102f31:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if(lapic)
80102f34:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102f39:	85 c0                	test   %eax,%eax
80102f3b:	74 0f                	je     80102f4c <cpunum+0x52>
    return lapic[ID]>>24;
80102f3d:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102f42:	83 c0 20             	add    $0x20,%eax
80102f45:	8b 00                	mov    (%eax),%eax
80102f47:	c1 e8 18             	shr    $0x18,%eax
80102f4a:	eb 05                	jmp    80102f51 <cpunum+0x57>
  return 0;
80102f4c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102f51:	c9                   	leave  
80102f52:	c3                   	ret    

80102f53 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102f53:	55                   	push   %ebp
80102f54:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102f56:	a1 9c f8 10 80       	mov    0x8010f89c,%eax
80102f5b:	85 c0                	test   %eax,%eax
80102f5d:	74 0c                	je     80102f6b <lapiceoi+0x18>
    lapicw(EOI, 0);
80102f5f:	6a 00                	push   $0x0
80102f61:	6a 2c                	push   $0x2c
80102f63:	e8 52 fe ff ff       	call   80102dba <lapicw>
80102f68:	83 c4 08             	add    $0x8,%esp
}
80102f6b:	90                   	nop
80102f6c:	c9                   	leave  
80102f6d:	c3                   	ret    

80102f6e <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102f6e:	55                   	push   %ebp
80102f6f:	89 e5                	mov    %esp,%ebp
}
80102f71:	90                   	nop
80102f72:	5d                   	pop    %ebp
80102f73:	c3                   	ret    

80102f74 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102f74:	55                   	push   %ebp
80102f75:	89 e5                	mov    %esp,%ebp
80102f77:	83 ec 14             	sub    $0x14,%esp
80102f7a:	8b 45 08             	mov    0x8(%ebp),%eax
80102f7d:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;
  
  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(IO_RTC, 0xF);  // offset 0xF is shutdown code
80102f80:	6a 0f                	push   $0xf
80102f82:	6a 70                	push   $0x70
80102f84:	e8 02 fe ff ff       	call   80102d8b <outb>
80102f89:	83 c4 08             	add    $0x8,%esp
  outb(IO_RTC+1, 0x0A);
80102f8c:	6a 0a                	push   $0xa
80102f8e:	6a 71                	push   $0x71
80102f90:	e8 f6 fd ff ff       	call   80102d8b <outb>
80102f95:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80102f98:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
80102f9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102fa2:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80102fa7:	8b 45 f8             	mov    -0x8(%ebp),%eax
80102faa:	83 c0 02             	add    $0x2,%eax
80102fad:	8b 55 0c             	mov    0xc(%ebp),%edx
80102fb0:	c1 ea 04             	shr    $0x4,%edx
80102fb3:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102fb6:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80102fba:	c1 e0 18             	shl    $0x18,%eax
80102fbd:	50                   	push   %eax
80102fbe:	68 c4 00 00 00       	push   $0xc4
80102fc3:	e8 f2 fd ff ff       	call   80102dba <lapicw>
80102fc8:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
80102fcb:	68 00 c5 00 00       	push   $0xc500
80102fd0:	68 c0 00 00 00       	push   $0xc0
80102fd5:	e8 e0 fd ff ff       	call   80102dba <lapicw>
80102fda:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
80102fdd:	68 c8 00 00 00       	push   $0xc8
80102fe2:	e8 87 ff ff ff       	call   80102f6e <microdelay>
80102fe7:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
80102fea:	68 00 85 00 00       	push   $0x8500
80102fef:	68 c0 00 00 00       	push   $0xc0
80102ff4:	e8 c1 fd ff ff       	call   80102dba <lapicw>
80102ff9:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
80102ffc:	6a 64                	push   $0x64
80102ffe:	e8 6b ff ff ff       	call   80102f6e <microdelay>
80103003:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103006:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010300d:	eb 3d                	jmp    8010304c <lapicstartap+0xd8>
    lapicw(ICRHI, apicid<<24);
8010300f:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
80103013:	c1 e0 18             	shl    $0x18,%eax
80103016:	50                   	push   %eax
80103017:	68 c4 00 00 00       	push   $0xc4
8010301c:	e8 99 fd ff ff       	call   80102dba <lapicw>
80103021:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
80103024:	8b 45 0c             	mov    0xc(%ebp),%eax
80103027:	c1 e8 0c             	shr    $0xc,%eax
8010302a:	80 cc 06             	or     $0x6,%ah
8010302d:	50                   	push   %eax
8010302e:	68 c0 00 00 00       	push   $0xc0
80103033:	e8 82 fd ff ff       	call   80102dba <lapicw>
80103038:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
8010303b:	68 c8 00 00 00       	push   $0xc8
80103040:	e8 29 ff ff ff       	call   80102f6e <microdelay>
80103045:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
80103048:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010304c:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103050:	7e bd                	jle    8010300f <lapicstartap+0x9b>
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
80103052:	90                   	nop
80103053:	c9                   	leave  
80103054:	c3                   	ret    

80103055 <initlog>:

static void recover_from_log(void);

void
initlog(void)
{
80103055:	55                   	push   %ebp
80103056:	89 e5                	mov    %esp,%ebp
80103058:	83 ec 18             	sub    $0x18,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
8010305b:	83 ec 08             	sub    $0x8,%esp
8010305e:	68 88 83 10 80       	push   $0x80108388
80103063:	68 a0 f8 10 80       	push   $0x8010f8a0
80103068:	e8 5a 1b 00 00       	call   80104bc7 <initlock>
8010306d:	83 c4 10             	add    $0x10,%esp
  readsb(ROOTDEV, &sb);
80103070:	83 ec 08             	sub    $0x8,%esp
80103073:	8d 45 e8             	lea    -0x18(%ebp),%eax
80103076:	50                   	push   %eax
80103077:	6a 01                	push   $0x1
80103079:	e8 d7 e2 ff ff       	call   80101355 <readsb>
8010307e:	83 c4 10             	add    $0x10,%esp
  log.start = sb.size - sb.nlog;
80103081:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103084:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103087:	29 c2                	sub    %eax,%edx
80103089:	89 d0                	mov    %edx,%eax
8010308b:	a3 d4 f8 10 80       	mov    %eax,0x8010f8d4
  log.size = sb.nlog;
80103090:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103093:	a3 d8 f8 10 80       	mov    %eax,0x8010f8d8
  log.dev = ROOTDEV;
80103098:	c7 05 e0 f8 10 80 01 	movl   $0x1,0x8010f8e0
8010309f:	00 00 00 
  recover_from_log();
801030a2:	e8 b2 01 00 00       	call   80103259 <recover_from_log>
}
801030a7:	90                   	nop
801030a8:	c9                   	leave  
801030a9:	c3                   	ret    

801030aa <install_trans>:

// Copy committed blocks from log to their home location
static void 
install_trans(void)
{
801030aa:	55                   	push   %ebp
801030ab:	89 e5                	mov    %esp,%ebp
801030ad:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801030b0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801030b7:	e9 95 00 00 00       	jmp    80103151 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801030bc:	8b 15 d4 f8 10 80    	mov    0x8010f8d4,%edx
801030c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030c5:	01 d0                	add    %edx,%eax
801030c7:	83 c0 01             	add    $0x1,%eax
801030ca:	89 c2                	mov    %eax,%edx
801030cc:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
801030d1:	83 ec 08             	sub    $0x8,%esp
801030d4:	52                   	push   %edx
801030d5:	50                   	push   %eax
801030d6:	e8 db d0 ff ff       	call   801001b6 <bread>
801030db:	83 c4 10             	add    $0x10,%esp
801030de:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
801030e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801030e4:	83 c0 10             	add    $0x10,%eax
801030e7:	8b 04 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%eax
801030ee:	89 c2                	mov    %eax,%edx
801030f0:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
801030f5:	83 ec 08             	sub    $0x8,%esp
801030f8:	52                   	push   %edx
801030f9:	50                   	push   %eax
801030fa:	e8 b7 d0 ff ff       	call   801001b6 <bread>
801030ff:	83 c4 10             	add    $0x10,%esp
80103102:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103105:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103108:	8d 50 18             	lea    0x18(%eax),%edx
8010310b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010310e:	83 c0 18             	add    $0x18,%eax
80103111:	83 ec 04             	sub    $0x4,%esp
80103114:	68 00 02 00 00       	push   $0x200
80103119:	52                   	push   %edx
8010311a:	50                   	push   %eax
8010311b:	e8 eb 1d 00 00       	call   80104f0b <memmove>
80103120:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
80103123:	83 ec 0c             	sub    $0xc,%esp
80103126:	ff 75 ec             	pushl  -0x14(%ebp)
80103129:	e8 c1 d0 ff ff       	call   801001ef <bwrite>
8010312e:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf); 
80103131:	83 ec 0c             	sub    $0xc,%esp
80103134:	ff 75 f0             	pushl  -0x10(%ebp)
80103137:	e8 f2 d0 ff ff       	call   8010022e <brelse>
8010313c:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
8010313f:	83 ec 0c             	sub    $0xc,%esp
80103142:	ff 75 ec             	pushl  -0x14(%ebp)
80103145:	e8 e4 d0 ff ff       	call   8010022e <brelse>
8010314a:	83 c4 10             	add    $0x10,%esp
static void 
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
8010314d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103151:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103156:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103159:	0f 8f 5d ff ff ff    	jg     801030bc <install_trans+0x12>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf); 
    brelse(dbuf);
  }
}
8010315f:	90                   	nop
80103160:	c9                   	leave  
80103161:	c3                   	ret    

80103162 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103162:	55                   	push   %ebp
80103163:	89 e5                	mov    %esp,%ebp
80103165:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103168:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
8010316d:	89 c2                	mov    %eax,%edx
8010316f:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
80103174:	83 ec 08             	sub    $0x8,%esp
80103177:	52                   	push   %edx
80103178:	50                   	push   %eax
80103179:	e8 38 d0 ff ff       	call   801001b6 <bread>
8010317e:	83 c4 10             	add    $0x10,%esp
80103181:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
80103184:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103187:	83 c0 18             	add    $0x18,%eax
8010318a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
8010318d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103190:	8b 00                	mov    (%eax),%eax
80103192:	a3 e4 f8 10 80       	mov    %eax,0x8010f8e4
  for (i = 0; i < log.lh.n; i++) {
80103197:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010319e:	eb 1b                	jmp    801031bb <read_head+0x59>
    log.lh.sector[i] = lh->sector[i];
801031a0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801031a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
801031a6:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
801031aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
801031ad:	83 c2 10             	add    $0x10,%edx
801031b0:	89 04 95 a8 f8 10 80 	mov    %eax,-0x7fef0758(,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
801031b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801031bb:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801031c0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801031c3:	7f db                	jg     801031a0 <read_head+0x3e>
    log.lh.sector[i] = lh->sector[i];
  }
  brelse(buf);
801031c5:	83 ec 0c             	sub    $0xc,%esp
801031c8:	ff 75 f0             	pushl  -0x10(%ebp)
801031cb:	e8 5e d0 ff ff       	call   8010022e <brelse>
801031d0:	83 c4 10             	add    $0x10,%esp
}
801031d3:	90                   	nop
801031d4:	c9                   	leave  
801031d5:	c3                   	ret    

801031d6 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
801031d6:	55                   	push   %ebp
801031d7:	89 e5                	mov    %esp,%ebp
801031d9:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
801031dc:	a1 d4 f8 10 80       	mov    0x8010f8d4,%eax
801031e1:	89 c2                	mov    %eax,%edx
801031e3:	a1 e0 f8 10 80       	mov    0x8010f8e0,%eax
801031e8:	83 ec 08             	sub    $0x8,%esp
801031eb:	52                   	push   %edx
801031ec:	50                   	push   %eax
801031ed:	e8 c4 cf ff ff       	call   801001b6 <bread>
801031f2:	83 c4 10             	add    $0x10,%esp
801031f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801031f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801031fb:	83 c0 18             	add    $0x18,%eax
801031fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
80103201:	8b 15 e4 f8 10 80    	mov    0x8010f8e4,%edx
80103207:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010320a:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
8010320c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103213:	eb 1b                	jmp    80103230 <write_head+0x5a>
    hb->sector[i] = log.lh.sector[i];
80103215:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103218:	83 c0 10             	add    $0x10,%eax
8010321b:	8b 0c 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%ecx
80103222:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103225:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103228:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
8010322c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103230:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103235:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103238:	7f db                	jg     80103215 <write_head+0x3f>
    hb->sector[i] = log.lh.sector[i];
  }
  bwrite(buf);
8010323a:	83 ec 0c             	sub    $0xc,%esp
8010323d:	ff 75 f0             	pushl  -0x10(%ebp)
80103240:	e8 aa cf ff ff       	call   801001ef <bwrite>
80103245:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
80103248:	83 ec 0c             	sub    $0xc,%esp
8010324b:	ff 75 f0             	pushl  -0x10(%ebp)
8010324e:	e8 db cf ff ff       	call   8010022e <brelse>
80103253:	83 c4 10             	add    $0x10,%esp
}
80103256:	90                   	nop
80103257:	c9                   	leave  
80103258:	c3                   	ret    

80103259 <recover_from_log>:

static void
recover_from_log(void)
{
80103259:	55                   	push   %ebp
8010325a:	89 e5                	mov    %esp,%ebp
8010325c:	83 ec 08             	sub    $0x8,%esp
  read_head();      
8010325f:	e8 fe fe ff ff       	call   80103162 <read_head>
  install_trans(); // if committed, copy from log to disk
80103264:	e8 41 fe ff ff       	call   801030aa <install_trans>
  log.lh.n = 0;
80103269:	c7 05 e4 f8 10 80 00 	movl   $0x0,0x8010f8e4
80103270:	00 00 00 
  write_head(); // clear the log
80103273:	e8 5e ff ff ff       	call   801031d6 <write_head>
}
80103278:	90                   	nop
80103279:	c9                   	leave  
8010327a:	c3                   	ret    

8010327b <begin_trans>:

void
begin_trans(void)
{
8010327b:	55                   	push   %ebp
8010327c:	89 e5                	mov    %esp,%ebp
8010327e:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
80103281:	83 ec 0c             	sub    $0xc,%esp
80103284:	68 a0 f8 10 80       	push   $0x8010f8a0
80103289:	e8 5b 19 00 00       	call   80104be9 <acquire>
8010328e:	83 c4 10             	add    $0x10,%esp
  while (log.busy) {
80103291:	eb 15                	jmp    801032a8 <begin_trans+0x2d>
    sleep(&log, &log.lock);
80103293:	83 ec 08             	sub    $0x8,%esp
80103296:	68 a0 f8 10 80       	push   $0x8010f8a0
8010329b:	68 a0 f8 10 80       	push   $0x8010f8a0
801032a0:	e8 15 16 00 00       	call   801048ba <sleep>
801032a5:	83 c4 10             	add    $0x10,%esp

void
begin_trans(void)
{
  acquire(&log.lock);
  while (log.busy) {
801032a8:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
801032ad:	85 c0                	test   %eax,%eax
801032af:	75 e2                	jne    80103293 <begin_trans+0x18>
    sleep(&log, &log.lock);
  }
  log.busy = 1;
801032b1:	c7 05 dc f8 10 80 01 	movl   $0x1,0x8010f8dc
801032b8:	00 00 00 
  release(&log.lock);
801032bb:	83 ec 0c             	sub    $0xc,%esp
801032be:	68 a0 f8 10 80       	push   $0x8010f8a0
801032c3:	e8 88 19 00 00       	call   80104c50 <release>
801032c8:	83 c4 10             	add    $0x10,%esp
}
801032cb:	90                   	nop
801032cc:	c9                   	leave  
801032cd:	c3                   	ret    

801032ce <commit_trans>:

void
commit_trans(void)
{
801032ce:	55                   	push   %ebp
801032cf:	89 e5                	mov    %esp,%ebp
801032d1:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
801032d4:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801032d9:	85 c0                	test   %eax,%eax
801032db:	7e 19                	jle    801032f6 <commit_trans+0x28>
    write_head();    // Write header to disk -- the real commit
801032dd:	e8 f4 fe ff ff       	call   801031d6 <write_head>
    install_trans(); // Now install writes to home locations
801032e2:	e8 c3 fd ff ff       	call   801030aa <install_trans>
    log.lh.n = 0; 
801032e7:	c7 05 e4 f8 10 80 00 	movl   $0x0,0x8010f8e4
801032ee:	00 00 00 
    write_head();    // Erase the transaction from the log
801032f1:	e8 e0 fe ff ff       	call   801031d6 <write_head>
  }
  
  acquire(&log.lock);
801032f6:	83 ec 0c             	sub    $0xc,%esp
801032f9:	68 a0 f8 10 80       	push   $0x8010f8a0
801032fe:	e8 e6 18 00 00       	call   80104be9 <acquire>
80103303:	83 c4 10             	add    $0x10,%esp
  log.busy = 0;
80103306:	c7 05 dc f8 10 80 00 	movl   $0x0,0x8010f8dc
8010330d:	00 00 00 
  wakeup(&log);
80103310:	83 ec 0c             	sub    $0xc,%esp
80103313:	68 a0 f8 10 80       	push   $0x8010f8a0
80103318:	e8 88 16 00 00       	call   801049a5 <wakeup>
8010331d:	83 c4 10             	add    $0x10,%esp
  release(&log.lock);
80103320:	83 ec 0c             	sub    $0xc,%esp
80103323:	68 a0 f8 10 80       	push   $0x8010f8a0
80103328:	e8 23 19 00 00       	call   80104c50 <release>
8010332d:	83 c4 10             	add    $0x10,%esp
}
80103330:	90                   	nop
80103331:	c9                   	leave  
80103332:	c3                   	ret    

80103333 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103333:	55                   	push   %ebp
80103334:	89 e5                	mov    %esp,%ebp
80103336:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103339:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
8010333e:	83 f8 09             	cmp    $0x9,%eax
80103341:	7f 12                	jg     80103355 <log_write+0x22>
80103343:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103348:	8b 15 d8 f8 10 80    	mov    0x8010f8d8,%edx
8010334e:	83 ea 01             	sub    $0x1,%edx
80103351:	39 d0                	cmp    %edx,%eax
80103353:	7c 0d                	jl     80103362 <log_write+0x2f>
    panic("too big a transaction");
80103355:	83 ec 0c             	sub    $0xc,%esp
80103358:	68 8c 83 10 80       	push   $0x8010838c
8010335d:	e8 04 d2 ff ff       	call   80100566 <panic>
  if (!log.busy)
80103362:	a1 dc f8 10 80       	mov    0x8010f8dc,%eax
80103367:	85 c0                	test   %eax,%eax
80103369:	75 0d                	jne    80103378 <log_write+0x45>
    panic("write outside of trans");
8010336b:	83 ec 0c             	sub    $0xc,%esp
8010336e:	68 a2 83 10 80       	push   $0x801083a2
80103373:	e8 ee d1 ff ff       	call   80100566 <panic>

  for (i = 0; i < log.lh.n; i++) {
80103378:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010337f:	eb 1d                	jmp    8010339e <log_write+0x6b>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
80103381:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103384:	83 c0 10             	add    $0x10,%eax
80103387:	8b 04 85 a8 f8 10 80 	mov    -0x7fef0758(,%eax,4),%eax
8010338e:	89 c2                	mov    %eax,%edx
80103390:	8b 45 08             	mov    0x8(%ebp),%eax
80103393:	8b 40 08             	mov    0x8(%eax),%eax
80103396:	39 c2                	cmp    %eax,%edx
80103398:	74 10                	je     801033aa <log_write+0x77>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
  if (!log.busy)
    panic("write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
8010339a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010339e:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
801033a3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801033a6:	7f d9                	jg     80103381 <log_write+0x4e>
801033a8:	eb 01                	jmp    801033ab <log_write+0x78>
    if (log.lh.sector[i] == b->sector)   // log absorbtion?
      break;
801033aa:	90                   	nop
  }
  log.lh.sector[i] = b->sector;
801033ab:	8b 45 08             	mov    0x8(%ebp),%eax
801033ae:	8b 40 08             	mov    0x8(%eax),%eax
801033b1:	89 c2                	mov    %eax,%edx
801033b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033b6:	83 c0 10             	add    $0x10,%eax
801033b9:	89 14 85 a8 f8 10 80 	mov    %edx,-0x7fef0758(,%eax,4)
  struct buf *lbuf = bread(b->dev, log.start+i+1);
801033c0:	8b 15 d4 f8 10 80    	mov    0x8010f8d4,%edx
801033c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801033c9:	01 d0                	add    %edx,%eax
801033cb:	83 c0 01             	add    $0x1,%eax
801033ce:	89 c2                	mov    %eax,%edx
801033d0:	8b 45 08             	mov    0x8(%ebp),%eax
801033d3:	8b 40 04             	mov    0x4(%eax),%eax
801033d6:	83 ec 08             	sub    $0x8,%esp
801033d9:	52                   	push   %edx
801033da:	50                   	push   %eax
801033db:	e8 d6 cd ff ff       	call   801001b6 <bread>
801033e0:	83 c4 10             	add    $0x10,%esp
801033e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(lbuf->data, b->data, BSIZE);
801033e6:	8b 45 08             	mov    0x8(%ebp),%eax
801033e9:	8d 50 18             	lea    0x18(%eax),%edx
801033ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033ef:	83 c0 18             	add    $0x18,%eax
801033f2:	83 ec 04             	sub    $0x4,%esp
801033f5:	68 00 02 00 00       	push   $0x200
801033fa:	52                   	push   %edx
801033fb:	50                   	push   %eax
801033fc:	e8 0a 1b 00 00       	call   80104f0b <memmove>
80103401:	83 c4 10             	add    $0x10,%esp
  bwrite(lbuf);
80103404:	83 ec 0c             	sub    $0xc,%esp
80103407:	ff 75 f0             	pushl  -0x10(%ebp)
8010340a:	e8 e0 cd ff ff       	call   801001ef <bwrite>
8010340f:	83 c4 10             	add    $0x10,%esp
  brelse(lbuf);
80103412:	83 ec 0c             	sub    $0xc,%esp
80103415:	ff 75 f0             	pushl  -0x10(%ebp)
80103418:	e8 11 ce ff ff       	call   8010022e <brelse>
8010341d:	83 c4 10             	add    $0x10,%esp
  if (i == log.lh.n)
80103420:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
80103425:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103428:	75 0d                	jne    80103437 <log_write+0x104>
    log.lh.n++;
8010342a:	a1 e4 f8 10 80       	mov    0x8010f8e4,%eax
8010342f:	83 c0 01             	add    $0x1,%eax
80103432:	a3 e4 f8 10 80       	mov    %eax,0x8010f8e4
  b->flags |= B_DIRTY; // XXX prevent eviction
80103437:	8b 45 08             	mov    0x8(%ebp),%eax
8010343a:	8b 00                	mov    (%eax),%eax
8010343c:	83 c8 04             	or     $0x4,%eax
8010343f:	89 c2                	mov    %eax,%edx
80103441:	8b 45 08             	mov    0x8(%ebp),%eax
80103444:	89 10                	mov    %edx,(%eax)
}
80103446:	90                   	nop
80103447:	c9                   	leave  
80103448:	c3                   	ret    

80103449 <v2p>:
80103449:	55                   	push   %ebp
8010344a:	89 e5                	mov    %esp,%ebp
8010344c:	8b 45 08             	mov    0x8(%ebp),%eax
8010344f:	05 00 00 00 80       	add    $0x80000000,%eax
80103454:	5d                   	pop    %ebp
80103455:	c3                   	ret    

80103456 <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
80103456:	55                   	push   %ebp
80103457:	89 e5                	mov    %esp,%ebp
80103459:	8b 45 08             	mov    0x8(%ebp),%eax
8010345c:	05 00 00 00 80       	add    $0x80000000,%eax
80103461:	5d                   	pop    %ebp
80103462:	c3                   	ret    

80103463 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103463:	55                   	push   %ebp
80103464:	89 e5                	mov    %esp,%ebp
80103466:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103469:	8b 55 08             	mov    0x8(%ebp),%edx
8010346c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010346f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103472:	f0 87 02             	lock xchg %eax,(%edx)
80103475:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103478:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010347b:	c9                   	leave  
8010347c:	c3                   	ret    

8010347d <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
8010347d:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103481:	83 e4 f0             	and    $0xfffffff0,%esp
80103484:	ff 71 fc             	pushl  -0x4(%ecx)
80103487:	55                   	push   %ebp
80103488:	89 e5                	mov    %esp,%ebp
8010348a:	51                   	push   %ecx
8010348b:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010348e:	83 ec 08             	sub    $0x8,%esp
80103491:	68 00 00 40 80       	push   $0x80400000
80103496:	68 1c 27 11 80       	push   $0x8011271c
8010349b:	e8 da f5 ff ff       	call   80102a7a <kinit1>
801034a0:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
801034a3:	e8 78 45 00 00       	call   80107a20 <kvmalloc>
  mpinit();        // collect info about this machine
801034a8:	e8 48 04 00 00       	call   801038f5 <mpinit>
  lapicinit();
801034ad:	e8 2a f9 ff ff       	call   80102ddc <lapicinit>
  seginit();       // set up segments
801034b2:	e8 12 3f 00 00       	call   801073c9 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpu->id);
801034b7:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801034bd:	0f b6 00             	movzbl (%eax),%eax
801034c0:	0f b6 c0             	movzbl %al,%eax
801034c3:	83 ec 08             	sub    $0x8,%esp
801034c6:	50                   	push   %eax
801034c7:	68 b9 83 10 80       	push   $0x801083b9
801034cc:	e8 f5 ce ff ff       	call   801003c6 <cprintf>
801034d1:	83 c4 10             	add    $0x10,%esp
  picinit();       // interrupt controller
801034d4:	e8 72 06 00 00       	call   80103b4b <picinit>
  ioapicinit();    // another interrupt controller
801034d9:	e8 91 f4 ff ff       	call   8010296f <ioapicinit>
  consoleinit();   // I/O devices & their interrupts
801034de:	e8 06 d6 ff ff       	call   80100ae9 <consoleinit>
  uartinit();      // serial port
801034e3:	e8 3d 32 00 00       	call   80106725 <uartinit>
  pinit();         // process table
801034e8:	e8 5b 0b 00 00       	call   80104048 <pinit>
  tvinit();        // trap vectors
801034ed:	e8 fd 2d 00 00       	call   801062ef <tvinit>
  binit();         // buffer cache
801034f2:	e8 3d cb ff ff       	call   80100034 <binit>
  fileinit();      // file table
801034f7:	e8 4a da ff ff       	call   80100f46 <fileinit>
  iinit();         // inode cache
801034fc:	e8 23 e1 ff ff       	call   80101624 <iinit>
  ideinit();       // disk
80103501:	e8 ad f0 ff ff       	call   801025b3 <ideinit>
  if(!ismp)
80103506:	a1 24 f9 10 80       	mov    0x8010f924,%eax
8010350b:	85 c0                	test   %eax,%eax
8010350d:	75 05                	jne    80103514 <main+0x97>
    timerinit();   // uniprocessor timer
8010350f:	e8 38 2d 00 00       	call   8010624c <timerinit>
  startothers();   // start other processors
80103514:	e8 7f 00 00 00       	call   80103598 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103519:	83 ec 08             	sub    $0x8,%esp
8010351c:	68 00 00 00 8e       	push   $0x8e000000
80103521:	68 00 00 40 80       	push   $0x80400000
80103526:	e8 88 f5 ff ff       	call   80102ab3 <kinit2>
8010352b:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
8010352e:	e8 39 0c 00 00       	call   8010416c <userinit>
  // Finish setting up this processor in mpmain.
  mpmain();
80103533:	e8 1a 00 00 00       	call   80103552 <mpmain>

80103538 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80103538:	55                   	push   %ebp
80103539:	89 e5                	mov    %esp,%ebp
8010353b:	83 ec 08             	sub    $0x8,%esp
  switchkvm(); 
8010353e:	e8 f5 44 00 00       	call   80107a38 <switchkvm>
  seginit();
80103543:	e8 81 3e 00 00       	call   801073c9 <seginit>
  lapicinit();
80103548:	e8 8f f8 ff ff       	call   80102ddc <lapicinit>
  mpmain();
8010354d:	e8 00 00 00 00       	call   80103552 <mpmain>

80103552 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103552:	55                   	push   %ebp
80103553:	89 e5                	mov    %esp,%ebp
80103555:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpu->id);
80103558:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
8010355e:	0f b6 00             	movzbl (%eax),%eax
80103561:	0f b6 c0             	movzbl %al,%eax
80103564:	83 ec 08             	sub    $0x8,%esp
80103567:	50                   	push   %eax
80103568:	68 d0 83 10 80       	push   $0x801083d0
8010356d:	e8 54 ce ff ff       	call   801003c6 <cprintf>
80103572:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103575:	e8 eb 2e 00 00       	call   80106465 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
8010357a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80103580:	05 a8 00 00 00       	add    $0xa8,%eax
80103585:	83 ec 08             	sub    $0x8,%esp
80103588:	6a 01                	push   $0x1
8010358a:	50                   	push   %eax
8010358b:	e8 d3 fe ff ff       	call   80103463 <xchg>
80103590:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103593:	e8 55 11 00 00       	call   801046ed <scheduler>

80103598 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103598:	55                   	push   %ebp
80103599:	89 e5                	mov    %esp,%ebp
8010359b:	53                   	push   %ebx
8010359c:	83 ec 14             	sub    $0x14,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
8010359f:	68 00 70 00 00       	push   $0x7000
801035a4:	e8 ad fe ff ff       	call   80103456 <p2v>
801035a9:	83 c4 04             	add    $0x4,%esp
801035ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
801035af:	b8 8a 00 00 00       	mov    $0x8a,%eax
801035b4:	83 ec 04             	sub    $0x4,%esp
801035b7:	50                   	push   %eax
801035b8:	68 2c b5 10 80       	push   $0x8010b52c
801035bd:	ff 75 f0             	pushl  -0x10(%ebp)
801035c0:	e8 46 19 00 00       	call   80104f0b <memmove>
801035c5:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
801035c8:	c7 45 f4 40 f9 10 80 	movl   $0x8010f940,-0xc(%ebp)
801035cf:	e9 90 00 00 00       	jmp    80103664 <startothers+0xcc>
    if(c == cpus+cpunum())  // We've started already.
801035d4:	e8 21 f9 ff ff       	call   80102efa <cpunum>
801035d9:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801035df:	05 40 f9 10 80       	add    $0x8010f940,%eax
801035e4:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801035e7:	74 73                	je     8010365c <startothers+0xc4>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what 
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801035e9:	e8 c3 f5 ff ff       	call   80102bb1 <kalloc>
801035ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
801035f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801035f4:	83 e8 04             	sub    $0x4,%eax
801035f7:	8b 55 ec             	mov    -0x14(%ebp),%edx
801035fa:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103600:	89 10                	mov    %edx,(%eax)
    *(void**)(code-8) = mpenter;
80103602:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103605:	83 e8 08             	sub    $0x8,%eax
80103608:	c7 00 38 35 10 80    	movl   $0x80103538,(%eax)
    *(int**)(code-12) = (void *) v2p(entrypgdir);
8010360e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103611:	8d 58 f4             	lea    -0xc(%eax),%ebx
80103614:	83 ec 0c             	sub    $0xc,%esp
80103617:	68 00 a0 10 80       	push   $0x8010a000
8010361c:	e8 28 fe ff ff       	call   80103449 <v2p>
80103621:	83 c4 10             	add    $0x10,%esp
80103624:	89 03                	mov    %eax,(%ebx)

    lapicstartap(c->id, v2p(code));
80103626:	83 ec 0c             	sub    $0xc,%esp
80103629:	ff 75 f0             	pushl  -0x10(%ebp)
8010362c:	e8 18 fe ff ff       	call   80103449 <v2p>
80103631:	83 c4 10             	add    $0x10,%esp
80103634:	89 c2                	mov    %eax,%edx
80103636:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103639:	0f b6 00             	movzbl (%eax),%eax
8010363c:	0f b6 c0             	movzbl %al,%eax
8010363f:	83 ec 08             	sub    $0x8,%esp
80103642:	52                   	push   %edx
80103643:	50                   	push   %eax
80103644:	e8 2b f9 ff ff       	call   80102f74 <lapicstartap>
80103649:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
8010364c:	90                   	nop
8010364d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103650:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80103656:	85 c0                	test   %eax,%eax
80103658:	74 f3                	je     8010364d <startothers+0xb5>
8010365a:	eb 01                	jmp    8010365d <startothers+0xc5>
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
    if(c == cpus+cpunum())  // We've started already.
      continue;
8010365c:	90                   	nop
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = p2v(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010365d:	81 45 f4 bc 00 00 00 	addl   $0xbc,-0xc(%ebp)
80103664:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80103669:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010366f:	05 40 f9 10 80       	add    $0x8010f940,%eax
80103674:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80103677:	0f 87 57 ff ff ff    	ja     801035d4 <startothers+0x3c>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
      ;
  }
}
8010367d:	90                   	nop
8010367e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103681:	c9                   	leave  
80103682:	c3                   	ret    

80103683 <p2v>:
80103683:	55                   	push   %ebp
80103684:	89 e5                	mov    %esp,%ebp
80103686:	8b 45 08             	mov    0x8(%ebp),%eax
80103689:	05 00 00 00 80       	add    $0x80000000,%eax
8010368e:	5d                   	pop    %ebp
8010368f:	c3                   	ret    

80103690 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	83 ec 14             	sub    $0x14,%esp
80103696:	8b 45 08             	mov    0x8(%ebp),%eax
80103699:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010369d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801036a1:	89 c2                	mov    %eax,%edx
801036a3:	ec                   	in     (%dx),%al
801036a4:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
801036a7:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
801036ab:	c9                   	leave  
801036ac:	c3                   	ret    

801036ad <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
801036ad:	55                   	push   %ebp
801036ae:	89 e5                	mov    %esp,%ebp
801036b0:	83 ec 08             	sub    $0x8,%esp
801036b3:	8b 55 08             	mov    0x8(%ebp),%edx
801036b6:	8b 45 0c             	mov    0xc(%ebp),%eax
801036b9:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
801036bd:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801036c0:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801036c4:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801036c8:	ee                   	out    %al,(%dx)
}
801036c9:	90                   	nop
801036ca:	c9                   	leave  
801036cb:	c3                   	ret    

801036cc <mpbcpu>:
int ncpu;
uchar ioapicid;

int
mpbcpu(void)
{
801036cc:	55                   	push   %ebp
801036cd:	89 e5                	mov    %esp,%ebp
  return bcpu-cpus;
801036cf:	a1 64 b6 10 80       	mov    0x8010b664,%eax
801036d4:	89 c2                	mov    %eax,%edx
801036d6:	b8 40 f9 10 80       	mov    $0x8010f940,%eax
801036db:	29 c2                	sub    %eax,%edx
801036dd:	89 d0                	mov    %edx,%eax
801036df:	c1 f8 02             	sar    $0x2,%eax
801036e2:	69 c0 cf 46 7d 67    	imul   $0x677d46cf,%eax,%eax
}
801036e8:	5d                   	pop    %ebp
801036e9:	c3                   	ret    

801036ea <sum>:

static uchar
sum(uchar *addr, int len)
{
801036ea:	55                   	push   %ebp
801036eb:	89 e5                	mov    %esp,%ebp
801036ed:	83 ec 10             	sub    $0x10,%esp
  int i, sum;
  
  sum = 0;
801036f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
801036f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801036fe:	eb 15                	jmp    80103715 <sum+0x2b>
    sum += addr[i];
80103700:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103703:	8b 45 08             	mov    0x8(%ebp),%eax
80103706:	01 d0                	add    %edx,%eax
80103708:	0f b6 00             	movzbl (%eax),%eax
8010370b:	0f b6 c0             	movzbl %al,%eax
8010370e:	01 45 f8             	add    %eax,-0x8(%ebp)
sum(uchar *addr, int len)
{
  int i, sum;
  
  sum = 0;
  for(i=0; i<len; i++)
80103711:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103715:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103718:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010371b:	7c e3                	jl     80103700 <sum+0x16>
    sum += addr[i];
  return sum;
8010371d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103720:	c9                   	leave  
80103721:	c3                   	ret    

80103722 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103722:	55                   	push   %ebp
80103723:	89 e5                	mov    %esp,%ebp
80103725:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = p2v(a);
80103728:	ff 75 08             	pushl  0x8(%ebp)
8010372b:	e8 53 ff ff ff       	call   80103683 <p2v>
80103730:	83 c4 04             	add    $0x4,%esp
80103733:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103736:	8b 55 0c             	mov    0xc(%ebp),%edx
80103739:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010373c:	01 d0                	add    %edx,%eax
8010373e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103741:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103744:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103747:	eb 36                	jmp    8010377f <mpsearch1+0x5d>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103749:	83 ec 04             	sub    $0x4,%esp
8010374c:	6a 04                	push   $0x4
8010374e:	68 e4 83 10 80       	push   $0x801083e4
80103753:	ff 75 f4             	pushl  -0xc(%ebp)
80103756:	e8 58 17 00 00       	call   80104eb3 <memcmp>
8010375b:	83 c4 10             	add    $0x10,%esp
8010375e:	85 c0                	test   %eax,%eax
80103760:	75 19                	jne    8010377b <mpsearch1+0x59>
80103762:	83 ec 08             	sub    $0x8,%esp
80103765:	6a 10                	push   $0x10
80103767:	ff 75 f4             	pushl  -0xc(%ebp)
8010376a:	e8 7b ff ff ff       	call   801036ea <sum>
8010376f:	83 c4 10             	add    $0x10,%esp
80103772:	84 c0                	test   %al,%al
80103774:	75 05                	jne    8010377b <mpsearch1+0x59>
      return (struct mp*)p;
80103776:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103779:	eb 11                	jmp    8010378c <mpsearch1+0x6a>
{
  uchar *e, *p, *addr;

  addr = p2v(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
8010377b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
8010377f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103782:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103785:	72 c2                	jb     80103749 <mpsearch1+0x27>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103787:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010378c:	c9                   	leave  
8010378d:	c3                   	ret    

8010378e <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
8010378e:	55                   	push   %ebp
8010378f:	89 e5                	mov    %esp,%ebp
80103791:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103794:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
8010379b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010379e:	83 c0 0f             	add    $0xf,%eax
801037a1:	0f b6 00             	movzbl (%eax),%eax
801037a4:	0f b6 c0             	movzbl %al,%eax
801037a7:	c1 e0 08             	shl    $0x8,%eax
801037aa:	89 c2                	mov    %eax,%edx
801037ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037af:	83 c0 0e             	add    $0xe,%eax
801037b2:	0f b6 00             	movzbl (%eax),%eax
801037b5:	0f b6 c0             	movzbl %al,%eax
801037b8:	09 d0                	or     %edx,%eax
801037ba:	c1 e0 04             	shl    $0x4,%eax
801037bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
801037c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801037c4:	74 21                	je     801037e7 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
801037c6:	83 ec 08             	sub    $0x8,%esp
801037c9:	68 00 04 00 00       	push   $0x400
801037ce:	ff 75 f0             	pushl  -0x10(%ebp)
801037d1:	e8 4c ff ff ff       	call   80103722 <mpsearch1>
801037d6:	83 c4 10             	add    $0x10,%esp
801037d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
801037dc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801037e0:	74 51                	je     80103833 <mpsearch+0xa5>
      return mp;
801037e2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801037e5:	eb 61                	jmp    80103848 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801037e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037ea:	83 c0 14             	add    $0x14,%eax
801037ed:	0f b6 00             	movzbl (%eax),%eax
801037f0:	0f b6 c0             	movzbl %al,%eax
801037f3:	c1 e0 08             	shl    $0x8,%eax
801037f6:	89 c2                	mov    %eax,%edx
801037f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037fb:	83 c0 13             	add    $0x13,%eax
801037fe:	0f b6 00             	movzbl (%eax),%eax
80103801:	0f b6 c0             	movzbl %al,%eax
80103804:	09 d0                	or     %edx,%eax
80103806:	c1 e0 0a             	shl    $0xa,%eax
80103809:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
8010380c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010380f:	2d 00 04 00 00       	sub    $0x400,%eax
80103814:	83 ec 08             	sub    $0x8,%esp
80103817:	68 00 04 00 00       	push   $0x400
8010381c:	50                   	push   %eax
8010381d:	e8 00 ff ff ff       	call   80103722 <mpsearch1>
80103822:	83 c4 10             	add    $0x10,%esp
80103825:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103828:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010382c:	74 05                	je     80103833 <mpsearch+0xa5>
      return mp;
8010382e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103831:	eb 15                	jmp    80103848 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103833:	83 ec 08             	sub    $0x8,%esp
80103836:	68 00 00 01 00       	push   $0x10000
8010383b:	68 00 00 0f 00       	push   $0xf0000
80103840:	e8 dd fe ff ff       	call   80103722 <mpsearch1>
80103845:	83 c4 10             	add    $0x10,%esp
}
80103848:	c9                   	leave  
80103849:	c3                   	ret    

8010384a <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
8010384a:	55                   	push   %ebp
8010384b:	89 e5                	mov    %esp,%ebp
8010384d:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103850:	e8 39 ff ff ff       	call   8010378e <mpsearch>
80103855:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103858:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010385c:	74 0a                	je     80103868 <mpconfig+0x1e>
8010385e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103861:	8b 40 04             	mov    0x4(%eax),%eax
80103864:	85 c0                	test   %eax,%eax
80103866:	75 0a                	jne    80103872 <mpconfig+0x28>
    return 0;
80103868:	b8 00 00 00 00       	mov    $0x0,%eax
8010386d:	e9 81 00 00 00       	jmp    801038f3 <mpconfig+0xa9>
  conf = (struct mpconf*) p2v((uint) mp->physaddr);
80103872:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103875:	8b 40 04             	mov    0x4(%eax),%eax
80103878:	83 ec 0c             	sub    $0xc,%esp
8010387b:	50                   	push   %eax
8010387c:	e8 02 fe ff ff       	call   80103683 <p2v>
80103881:	83 c4 10             	add    $0x10,%esp
80103884:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103887:	83 ec 04             	sub    $0x4,%esp
8010388a:	6a 04                	push   $0x4
8010388c:	68 e9 83 10 80       	push   $0x801083e9
80103891:	ff 75 f0             	pushl  -0x10(%ebp)
80103894:	e8 1a 16 00 00       	call   80104eb3 <memcmp>
80103899:	83 c4 10             	add    $0x10,%esp
8010389c:	85 c0                	test   %eax,%eax
8010389e:	74 07                	je     801038a7 <mpconfig+0x5d>
    return 0;
801038a0:	b8 00 00 00 00       	mov    $0x0,%eax
801038a5:	eb 4c                	jmp    801038f3 <mpconfig+0xa9>
  if(conf->version != 1 && conf->version != 4)
801038a7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038aa:	0f b6 40 06          	movzbl 0x6(%eax),%eax
801038ae:	3c 01                	cmp    $0x1,%al
801038b0:	74 12                	je     801038c4 <mpconfig+0x7a>
801038b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038b5:	0f b6 40 06          	movzbl 0x6(%eax),%eax
801038b9:	3c 04                	cmp    $0x4,%al
801038bb:	74 07                	je     801038c4 <mpconfig+0x7a>
    return 0;
801038bd:	b8 00 00 00 00       	mov    $0x0,%eax
801038c2:	eb 2f                	jmp    801038f3 <mpconfig+0xa9>
  if(sum((uchar*)conf, conf->length) != 0)
801038c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801038c7:	0f b7 40 04          	movzwl 0x4(%eax),%eax
801038cb:	0f b7 c0             	movzwl %ax,%eax
801038ce:	83 ec 08             	sub    $0x8,%esp
801038d1:	50                   	push   %eax
801038d2:	ff 75 f0             	pushl  -0x10(%ebp)
801038d5:	e8 10 fe ff ff       	call   801036ea <sum>
801038da:	83 c4 10             	add    $0x10,%esp
801038dd:	84 c0                	test   %al,%al
801038df:	74 07                	je     801038e8 <mpconfig+0x9e>
    return 0;
801038e1:	b8 00 00 00 00       	mov    $0x0,%eax
801038e6:	eb 0b                	jmp    801038f3 <mpconfig+0xa9>
  *pmp = mp;
801038e8:	8b 45 08             	mov    0x8(%ebp),%eax
801038eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
801038ee:	89 10                	mov    %edx,(%eax)
  return conf;
801038f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
801038f3:	c9                   	leave  
801038f4:	c3                   	ret    

801038f5 <mpinit>:

void
mpinit(void)
{
801038f5:	55                   	push   %ebp
801038f6:	89 e5                	mov    %esp,%ebp
801038f8:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
801038fb:	c7 05 64 b6 10 80 40 	movl   $0x8010f940,0x8010b664
80103902:	f9 10 80 
  if((conf = mpconfig(&mp)) == 0)
80103905:	83 ec 0c             	sub    $0xc,%esp
80103908:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010390b:	50                   	push   %eax
8010390c:	e8 39 ff ff ff       	call   8010384a <mpconfig>
80103911:	83 c4 10             	add    $0x10,%esp
80103914:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103917:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010391b:	0f 84 96 01 00 00    	je     80103ab7 <mpinit+0x1c2>
    return;
  ismp = 1;
80103921:	c7 05 24 f9 10 80 01 	movl   $0x1,0x8010f924
80103928:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
8010392b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010392e:	8b 40 24             	mov    0x24(%eax),%eax
80103931:	a3 9c f8 10 80       	mov    %eax,0x8010f89c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103936:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103939:	83 c0 2c             	add    $0x2c,%eax
8010393c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010393f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103942:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103946:	0f b7 d0             	movzwl %ax,%edx
80103949:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010394c:	01 d0                	add    %edx,%eax
8010394e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103951:	e9 f2 00 00 00       	jmp    80103a48 <mpinit+0x153>
    switch(*p){
80103956:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103959:	0f b6 00             	movzbl (%eax),%eax
8010395c:	0f b6 c0             	movzbl %al,%eax
8010395f:	83 f8 04             	cmp    $0x4,%eax
80103962:	0f 87 bc 00 00 00    	ja     80103a24 <mpinit+0x12f>
80103968:	8b 04 85 2c 84 10 80 	mov    -0x7fef7bd4(,%eax,4),%eax
8010396f:	ff e0                	jmp    *%eax
    case MPPROC:
      proc = (struct mpproc*)p;
80103971:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103974:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(ncpu != proc->apicid){
80103977:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010397a:	0f b6 40 01          	movzbl 0x1(%eax),%eax
8010397e:	0f b6 d0             	movzbl %al,%edx
80103981:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80103986:	39 c2                	cmp    %eax,%edx
80103988:	74 2b                	je     801039b5 <mpinit+0xc0>
        cprintf("mpinit: ncpu=%d apicid=%d\n", ncpu, proc->apicid);
8010398a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010398d:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103991:	0f b6 d0             	movzbl %al,%edx
80103994:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
80103999:	83 ec 04             	sub    $0x4,%esp
8010399c:	52                   	push   %edx
8010399d:	50                   	push   %eax
8010399e:	68 ee 83 10 80       	push   $0x801083ee
801039a3:	e8 1e ca ff ff       	call   801003c6 <cprintf>
801039a8:	83 c4 10             	add    $0x10,%esp
        ismp = 0;
801039ab:	c7 05 24 f9 10 80 00 	movl   $0x0,0x8010f924
801039b2:	00 00 00 
      }
      if(proc->flags & MPBOOT)
801039b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801039b8:	0f b6 40 03          	movzbl 0x3(%eax),%eax
801039bc:	0f b6 c0             	movzbl %al,%eax
801039bf:	83 e0 02             	and    $0x2,%eax
801039c2:	85 c0                	test   %eax,%eax
801039c4:	74 15                	je     801039db <mpinit+0xe6>
        bcpu = &cpus[ncpu];
801039c6:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801039cb:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039d1:	05 40 f9 10 80       	add    $0x8010f940,%eax
801039d6:	a3 64 b6 10 80       	mov    %eax,0x8010b664
      cpus[ncpu].id = ncpu;
801039db:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801039e0:	8b 15 20 ff 10 80    	mov    0x8010ff20,%edx
801039e6:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801039ec:	05 40 f9 10 80       	add    $0x8010f940,%eax
801039f1:	88 10                	mov    %dl,(%eax)
      ncpu++;
801039f3:	a1 20 ff 10 80       	mov    0x8010ff20,%eax
801039f8:	83 c0 01             	add    $0x1,%eax
801039fb:	a3 20 ff 10 80       	mov    %eax,0x8010ff20
      p += sizeof(struct mpproc);
80103a00:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103a04:	eb 42                	jmp    80103a48 <mpinit+0x153>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a09:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103a0c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103a0f:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103a13:	a2 20 f9 10 80       	mov    %al,0x8010f920
      p += sizeof(struct mpioapic);
80103a18:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103a1c:	eb 2a                	jmp    80103a48 <mpinit+0x153>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103a1e:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103a22:	eb 24                	jmp    80103a48 <mpinit+0x153>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
80103a24:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a27:	0f b6 00             	movzbl (%eax),%eax
80103a2a:	0f b6 c0             	movzbl %al,%eax
80103a2d:	83 ec 08             	sub    $0x8,%esp
80103a30:	50                   	push   %eax
80103a31:	68 0c 84 10 80       	push   $0x8010840c
80103a36:	e8 8b c9 ff ff       	call   801003c6 <cprintf>
80103a3b:	83 c4 10             	add    $0x10,%esp
      ismp = 0;
80103a3e:	c7 05 24 f9 10 80 00 	movl   $0x0,0x8010f924
80103a45:	00 00 00 
  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103a4b:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103a4e:	0f 82 02 ff ff ff    	jb     80103956 <mpinit+0x61>
    default:
      cprintf("mpinit: unknown config type %x\n", *p);
      ismp = 0;
    }
  }
  if(!ismp){
80103a54:	a1 24 f9 10 80       	mov    0x8010f924,%eax
80103a59:	85 c0                	test   %eax,%eax
80103a5b:	75 1d                	jne    80103a7a <mpinit+0x185>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103a5d:	c7 05 20 ff 10 80 01 	movl   $0x1,0x8010ff20
80103a64:	00 00 00 
    lapic = 0;
80103a67:	c7 05 9c f8 10 80 00 	movl   $0x0,0x8010f89c
80103a6e:	00 00 00 
    ioapicid = 0;
80103a71:	c6 05 20 f9 10 80 00 	movb   $0x0,0x8010f920
    return;
80103a78:	eb 3e                	jmp    80103ab8 <mpinit+0x1c3>
  }

  if(mp->imcrp){
80103a7a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103a7d:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103a81:	84 c0                	test   %al,%al
80103a83:	74 33                	je     80103ab8 <mpinit+0x1c3>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103a85:	83 ec 08             	sub    $0x8,%esp
80103a88:	6a 70                	push   $0x70
80103a8a:	6a 22                	push   $0x22
80103a8c:	e8 1c fc ff ff       	call   801036ad <outb>
80103a91:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103a94:	83 ec 0c             	sub    $0xc,%esp
80103a97:	6a 23                	push   $0x23
80103a99:	e8 f2 fb ff ff       	call   80103690 <inb>
80103a9e:	83 c4 10             	add    $0x10,%esp
80103aa1:	83 c8 01             	or     $0x1,%eax
80103aa4:	0f b6 c0             	movzbl %al,%eax
80103aa7:	83 ec 08             	sub    $0x8,%esp
80103aaa:	50                   	push   %eax
80103aab:	6a 23                	push   $0x23
80103aad:	e8 fb fb ff ff       	call   801036ad <outb>
80103ab2:	83 c4 10             	add    $0x10,%esp
80103ab5:	eb 01                	jmp    80103ab8 <mpinit+0x1c3>
  struct mpproc *proc;
  struct mpioapic *ioapic;

  bcpu = &cpus[0];
  if((conf = mpconfig(&mp)) == 0)
    return;
80103ab7:	90                   	nop
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103ab8:	c9                   	leave  
80103ab9:	c3                   	ret    

80103aba <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80103aba:	55                   	push   %ebp
80103abb:	89 e5                	mov    %esp,%ebp
80103abd:	83 ec 08             	sub    $0x8,%esp
80103ac0:	8b 55 08             	mov    0x8(%ebp),%edx
80103ac3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ac6:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80103aca:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103acd:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103ad1:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103ad5:	ee                   	out    %al,(%dx)
}
80103ad6:	90                   	nop
80103ad7:	c9                   	leave  
80103ad8:	c3                   	ret    

80103ad9 <picsetmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
80103ad9:	55                   	push   %ebp
80103ada:	89 e5                	mov    %esp,%ebp
80103adc:	83 ec 04             	sub    $0x4,%esp
80103adf:	8b 45 08             	mov    0x8(%ebp),%eax
80103ae2:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  irqmask = mask;
80103ae6:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103aea:	66 a3 00 b0 10 80    	mov    %ax,0x8010b000
  outb(IO_PIC1+1, mask);
80103af0:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103af4:	0f b6 c0             	movzbl %al,%eax
80103af7:	50                   	push   %eax
80103af8:	6a 21                	push   $0x21
80103afa:	e8 bb ff ff ff       	call   80103aba <outb>
80103aff:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, mask >> 8);
80103b02:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80103b06:	66 c1 e8 08          	shr    $0x8,%ax
80103b0a:	0f b6 c0             	movzbl %al,%eax
80103b0d:	50                   	push   %eax
80103b0e:	68 a1 00 00 00       	push   $0xa1
80103b13:	e8 a2 ff ff ff       	call   80103aba <outb>
80103b18:	83 c4 08             	add    $0x8,%esp
}
80103b1b:	90                   	nop
80103b1c:	c9                   	leave  
80103b1d:	c3                   	ret    

80103b1e <picenable>:

void
picenable(int irq)
{
80103b1e:	55                   	push   %ebp
80103b1f:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
80103b21:	8b 45 08             	mov    0x8(%ebp),%eax
80103b24:	ba 01 00 00 00       	mov    $0x1,%edx
80103b29:	89 c1                	mov    %eax,%ecx
80103b2b:	d3 e2                	shl    %cl,%edx
80103b2d:	89 d0                	mov    %edx,%eax
80103b2f:	f7 d0                	not    %eax
80103b31:	89 c2                	mov    %eax,%edx
80103b33:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103b3a:	21 d0                	and    %edx,%eax
80103b3c:	0f b7 c0             	movzwl %ax,%eax
80103b3f:	50                   	push   %eax
80103b40:	e8 94 ff ff ff       	call   80103ad9 <picsetmask>
80103b45:	83 c4 04             	add    $0x4,%esp
}
80103b48:	90                   	nop
80103b49:	c9                   	leave  
80103b4a:	c3                   	ret    

80103b4b <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103b4b:	55                   	push   %ebp
80103b4c:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103b4e:	68 ff 00 00 00       	push   $0xff
80103b53:	6a 21                	push   $0x21
80103b55:	e8 60 ff ff ff       	call   80103aba <outb>
80103b5a:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103b5d:	68 ff 00 00 00       	push   $0xff
80103b62:	68 a1 00 00 00       	push   $0xa1
80103b67:	e8 4e ff ff ff       	call   80103aba <outb>
80103b6c:	83 c4 08             	add    $0x8,%esp

  // ICW1:  0001g0hi
  //    g:  0 = edge triggering, 1 = level triggering
  //    h:  0 = cascaded PICs, 1 = master only
  //    i:  0 = no ICW4, 1 = ICW4 required
  outb(IO_PIC1, 0x11);
80103b6f:	6a 11                	push   $0x11
80103b71:	6a 20                	push   $0x20
80103b73:	e8 42 ff ff ff       	call   80103aba <outb>
80103b78:	83 c4 08             	add    $0x8,%esp

  // ICW2:  Vector offset
  outb(IO_PIC1+1, T_IRQ0);
80103b7b:	6a 20                	push   $0x20
80103b7d:	6a 21                	push   $0x21
80103b7f:	e8 36 ff ff ff       	call   80103aba <outb>
80103b84:	83 c4 08             	add    $0x8,%esp

  // ICW3:  (master PIC) bit mask of IR lines connected to slaves
  //        (slave PIC) 3-bit # of slave's connection to master
  outb(IO_PIC1+1, 1<<IRQ_SLAVE);
80103b87:	6a 04                	push   $0x4
80103b89:	6a 21                	push   $0x21
80103b8b:	e8 2a ff ff ff       	call   80103aba <outb>
80103b90:	83 c4 08             	add    $0x8,%esp
  //    m:  0 = slave PIC, 1 = master PIC
  //      (ignored when b is 0, as the master/slave role
  //      can be hardwired).
  //    a:  1 = Automatic EOI mode
  //    p:  0 = MCS-80/85 mode, 1 = intel x86 mode
  outb(IO_PIC1+1, 0x3);
80103b93:	6a 03                	push   $0x3
80103b95:	6a 21                	push   $0x21
80103b97:	e8 1e ff ff ff       	call   80103aba <outb>
80103b9c:	83 c4 08             	add    $0x8,%esp

  // Set up slave (8259A-2)
  outb(IO_PIC2, 0x11);                  // ICW1
80103b9f:	6a 11                	push   $0x11
80103ba1:	68 a0 00 00 00       	push   $0xa0
80103ba6:	e8 0f ff ff ff       	call   80103aba <outb>
80103bab:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, T_IRQ0 + 8);      // ICW2
80103bae:	6a 28                	push   $0x28
80103bb0:	68 a1 00 00 00       	push   $0xa1
80103bb5:	e8 00 ff ff ff       	call   80103aba <outb>
80103bba:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, IRQ_SLAVE);           // ICW3
80103bbd:	6a 02                	push   $0x2
80103bbf:	68 a1 00 00 00       	push   $0xa1
80103bc4:	e8 f1 fe ff ff       	call   80103aba <outb>
80103bc9:	83 c4 08             	add    $0x8,%esp
  // NB Automatic EOI mode doesn't tend to work on the slave.
  // Linux source code says it's "to be investigated".
  outb(IO_PIC2+1, 0x3);                 // ICW4
80103bcc:	6a 03                	push   $0x3
80103bce:	68 a1 00 00 00       	push   $0xa1
80103bd3:	e8 e2 fe ff ff       	call   80103aba <outb>
80103bd8:	83 c4 08             	add    $0x8,%esp

  // OCW3:  0ef01prs
  //   ef:  0x = NOP, 10 = clear specific mask, 11 = set specific mask
  //    p:  0 = no polling, 1 = polling mode
  //   rs:  0x = NOP, 10 = read IRR, 11 = read ISR
  outb(IO_PIC1, 0x68);             // clear specific mask
80103bdb:	6a 68                	push   $0x68
80103bdd:	6a 20                	push   $0x20
80103bdf:	e8 d6 fe ff ff       	call   80103aba <outb>
80103be4:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC1, 0x0a);             // read IRR by default
80103be7:	6a 0a                	push   $0xa
80103be9:	6a 20                	push   $0x20
80103beb:	e8 ca fe ff ff       	call   80103aba <outb>
80103bf0:	83 c4 08             	add    $0x8,%esp

  outb(IO_PIC2, 0x68);             // OCW3
80103bf3:	6a 68                	push   $0x68
80103bf5:	68 a0 00 00 00       	push   $0xa0
80103bfa:	e8 bb fe ff ff       	call   80103aba <outb>
80103bff:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2, 0x0a);             // OCW3
80103c02:	6a 0a                	push   $0xa
80103c04:	68 a0 00 00 00       	push   $0xa0
80103c09:	e8 ac fe ff ff       	call   80103aba <outb>
80103c0e:	83 c4 08             	add    $0x8,%esp

  if(irqmask != 0xFFFF)
80103c11:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103c18:	66 83 f8 ff          	cmp    $0xffff,%ax
80103c1c:	74 13                	je     80103c31 <picinit+0xe6>
    picsetmask(irqmask);
80103c1e:	0f b7 05 00 b0 10 80 	movzwl 0x8010b000,%eax
80103c25:	0f b7 c0             	movzwl %ax,%eax
80103c28:	50                   	push   %eax
80103c29:	e8 ab fe ff ff       	call   80103ad9 <picsetmask>
80103c2e:	83 c4 04             	add    $0x4,%esp
}
80103c31:	90                   	nop
80103c32:	c9                   	leave  
80103c33:	c3                   	ret    

80103c34 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103c34:	55                   	push   %ebp
80103c35:	89 e5                	mov    %esp,%ebp
80103c37:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103c3a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103c41:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c44:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c4d:	8b 10                	mov    (%eax),%edx
80103c4f:	8b 45 08             	mov    0x8(%ebp),%eax
80103c52:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103c54:	e8 0b d3 ff ff       	call   80100f64 <filealloc>
80103c59:	89 c2                	mov    %eax,%edx
80103c5b:	8b 45 08             	mov    0x8(%ebp),%eax
80103c5e:	89 10                	mov    %edx,(%eax)
80103c60:	8b 45 08             	mov    0x8(%ebp),%eax
80103c63:	8b 00                	mov    (%eax),%eax
80103c65:	85 c0                	test   %eax,%eax
80103c67:	0f 84 cb 00 00 00    	je     80103d38 <pipealloc+0x104>
80103c6d:	e8 f2 d2 ff ff       	call   80100f64 <filealloc>
80103c72:	89 c2                	mov    %eax,%edx
80103c74:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c77:	89 10                	mov    %edx,(%eax)
80103c79:	8b 45 0c             	mov    0xc(%ebp),%eax
80103c7c:	8b 00                	mov    (%eax),%eax
80103c7e:	85 c0                	test   %eax,%eax
80103c80:	0f 84 b2 00 00 00    	je     80103d38 <pipealloc+0x104>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103c86:	e8 26 ef ff ff       	call   80102bb1 <kalloc>
80103c8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c8e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103c92:	0f 84 9f 00 00 00    	je     80103d37 <pipealloc+0x103>
    goto bad;
  p->readopen = 1;
80103c98:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103c9b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103ca2:	00 00 00 
  p->writeopen = 1;
80103ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca8:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103caf:	00 00 00 
  p->nwrite = 0;
80103cb2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cb5:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103cbc:	00 00 00 
  p->nread = 0;
80103cbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cc2:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103cc9:	00 00 00 
  initlock(&p->lock, "pipe");
80103ccc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ccf:	83 ec 08             	sub    $0x8,%esp
80103cd2:	68 40 84 10 80       	push   $0x80108440
80103cd7:	50                   	push   %eax
80103cd8:	e8 ea 0e 00 00       	call   80104bc7 <initlock>
80103cdd:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103ce0:	8b 45 08             	mov    0x8(%ebp),%eax
80103ce3:	8b 00                	mov    (%eax),%eax
80103ce5:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103ceb:	8b 45 08             	mov    0x8(%ebp),%eax
80103cee:	8b 00                	mov    (%eax),%eax
80103cf0:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103cf4:	8b 45 08             	mov    0x8(%ebp),%eax
80103cf7:	8b 00                	mov    (%eax),%eax
80103cf9:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103cfd:	8b 45 08             	mov    0x8(%ebp),%eax
80103d00:	8b 00                	mov    (%eax),%eax
80103d02:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d05:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103d08:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d0b:	8b 00                	mov    (%eax),%eax
80103d0d:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103d13:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d16:	8b 00                	mov    (%eax),%eax
80103d18:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103d1c:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d1f:	8b 00                	mov    (%eax),%eax
80103d21:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103d25:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d28:	8b 00                	mov    (%eax),%eax
80103d2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103d2d:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103d30:	b8 00 00 00 00       	mov    $0x0,%eax
80103d35:	eb 4e                	jmp    80103d85 <pipealloc+0x151>
  p = 0;
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
80103d37:	90                   	nop
  (*f1)->pipe = p;
  return 0;

//PAGEBREAK: 20
 bad:
  if(p)
80103d38:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103d3c:	74 0e                	je     80103d4c <pipealloc+0x118>
    kfree((char*)p);
80103d3e:	83 ec 0c             	sub    $0xc,%esp
80103d41:	ff 75 f4             	pushl  -0xc(%ebp)
80103d44:	e8 cb ed ff ff       	call   80102b14 <kfree>
80103d49:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80103d4c:	8b 45 08             	mov    0x8(%ebp),%eax
80103d4f:	8b 00                	mov    (%eax),%eax
80103d51:	85 c0                	test   %eax,%eax
80103d53:	74 11                	je     80103d66 <pipealloc+0x132>
    fileclose(*f0);
80103d55:	8b 45 08             	mov    0x8(%ebp),%eax
80103d58:	8b 00                	mov    (%eax),%eax
80103d5a:	83 ec 0c             	sub    $0xc,%esp
80103d5d:	50                   	push   %eax
80103d5e:	e8 bf d2 ff ff       	call   80101022 <fileclose>
80103d63:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103d66:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d69:	8b 00                	mov    (%eax),%eax
80103d6b:	85 c0                	test   %eax,%eax
80103d6d:	74 11                	je     80103d80 <pipealloc+0x14c>
    fileclose(*f1);
80103d6f:	8b 45 0c             	mov    0xc(%ebp),%eax
80103d72:	8b 00                	mov    (%eax),%eax
80103d74:	83 ec 0c             	sub    $0xc,%esp
80103d77:	50                   	push   %eax
80103d78:	e8 a5 d2 ff ff       	call   80101022 <fileclose>
80103d7d:	83 c4 10             	add    $0x10,%esp
  return -1;
80103d80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103d85:	c9                   	leave  
80103d86:	c3                   	ret    

80103d87 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103d87:	55                   	push   %ebp
80103d88:	89 e5                	mov    %esp,%ebp
80103d8a:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
80103d8d:	8b 45 08             	mov    0x8(%ebp),%eax
80103d90:	83 ec 0c             	sub    $0xc,%esp
80103d93:	50                   	push   %eax
80103d94:	e8 50 0e 00 00       	call   80104be9 <acquire>
80103d99:	83 c4 10             	add    $0x10,%esp
  if(writable){
80103d9c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103da0:	74 23                	je     80103dc5 <pipeclose+0x3e>
    p->writeopen = 0;
80103da2:	8b 45 08             	mov    0x8(%ebp),%eax
80103da5:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103dac:	00 00 00 
    wakeup(&p->nread);
80103daf:	8b 45 08             	mov    0x8(%ebp),%eax
80103db2:	05 34 02 00 00       	add    $0x234,%eax
80103db7:	83 ec 0c             	sub    $0xc,%esp
80103dba:	50                   	push   %eax
80103dbb:	e8 e5 0b 00 00       	call   801049a5 <wakeup>
80103dc0:	83 c4 10             	add    $0x10,%esp
80103dc3:	eb 21                	jmp    80103de6 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80103dc5:	8b 45 08             	mov    0x8(%ebp),%eax
80103dc8:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103dcf:	00 00 00 
    wakeup(&p->nwrite);
80103dd2:	8b 45 08             	mov    0x8(%ebp),%eax
80103dd5:	05 38 02 00 00       	add    $0x238,%eax
80103dda:	83 ec 0c             	sub    $0xc,%esp
80103ddd:	50                   	push   %eax
80103dde:	e8 c2 0b 00 00       	call   801049a5 <wakeup>
80103de3:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103de6:	8b 45 08             	mov    0x8(%ebp),%eax
80103de9:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103def:	85 c0                	test   %eax,%eax
80103df1:	75 2c                	jne    80103e1f <pipeclose+0x98>
80103df3:	8b 45 08             	mov    0x8(%ebp),%eax
80103df6:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103dfc:	85 c0                	test   %eax,%eax
80103dfe:	75 1f                	jne    80103e1f <pipeclose+0x98>
    release(&p->lock);
80103e00:	8b 45 08             	mov    0x8(%ebp),%eax
80103e03:	83 ec 0c             	sub    $0xc,%esp
80103e06:	50                   	push   %eax
80103e07:	e8 44 0e 00 00       	call   80104c50 <release>
80103e0c:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80103e0f:	83 ec 0c             	sub    $0xc,%esp
80103e12:	ff 75 08             	pushl  0x8(%ebp)
80103e15:	e8 fa ec ff ff       	call   80102b14 <kfree>
80103e1a:	83 c4 10             	add    $0x10,%esp
80103e1d:	eb 0f                	jmp    80103e2e <pipeclose+0xa7>
  } else
    release(&p->lock);
80103e1f:	8b 45 08             	mov    0x8(%ebp),%eax
80103e22:	83 ec 0c             	sub    $0xc,%esp
80103e25:	50                   	push   %eax
80103e26:	e8 25 0e 00 00       	call   80104c50 <release>
80103e2b:	83 c4 10             	add    $0x10,%esp
}
80103e2e:	90                   	nop
80103e2f:	c9                   	leave  
80103e30:	c3                   	ret    

80103e31 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103e31:	55                   	push   %ebp
80103e32:	89 e5                	mov    %esp,%ebp
80103e34:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
80103e37:	8b 45 08             	mov    0x8(%ebp),%eax
80103e3a:	83 ec 0c             	sub    $0xc,%esp
80103e3d:	50                   	push   %eax
80103e3e:	e8 a6 0d 00 00       	call   80104be9 <acquire>
80103e43:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80103e46:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103e4d:	e9 ad 00 00 00       	jmp    80103eff <pipewrite+0xce>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
80103e52:	8b 45 08             	mov    0x8(%ebp),%eax
80103e55:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103e5b:	85 c0                	test   %eax,%eax
80103e5d:	74 0d                	je     80103e6c <pipewrite+0x3b>
80103e5f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e65:	8b 40 24             	mov    0x24(%eax),%eax
80103e68:	85 c0                	test   %eax,%eax
80103e6a:	74 19                	je     80103e85 <pipewrite+0x54>
        release(&p->lock);
80103e6c:	8b 45 08             	mov    0x8(%ebp),%eax
80103e6f:	83 ec 0c             	sub    $0xc,%esp
80103e72:	50                   	push   %eax
80103e73:	e8 d8 0d 00 00       	call   80104c50 <release>
80103e78:	83 c4 10             	add    $0x10,%esp
        return -1;
80103e7b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103e80:	e9 a8 00 00 00       	jmp    80103f2d <pipewrite+0xfc>
      }
      wakeup(&p->nread);
80103e85:	8b 45 08             	mov    0x8(%ebp),%eax
80103e88:	05 34 02 00 00       	add    $0x234,%eax
80103e8d:	83 ec 0c             	sub    $0xc,%esp
80103e90:	50                   	push   %eax
80103e91:	e8 0f 0b 00 00       	call   801049a5 <wakeup>
80103e96:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103e99:	8b 45 08             	mov    0x8(%ebp),%eax
80103e9c:	8b 55 08             	mov    0x8(%ebp),%edx
80103e9f:	81 c2 38 02 00 00    	add    $0x238,%edx
80103ea5:	83 ec 08             	sub    $0x8,%esp
80103ea8:	50                   	push   %eax
80103ea9:	52                   	push   %edx
80103eaa:	e8 0b 0a 00 00       	call   801048ba <sleep>
80103eaf:	83 c4 10             	add    $0x10,%esp
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103eb2:	8b 45 08             	mov    0x8(%ebp),%eax
80103eb5:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
80103ebb:	8b 45 08             	mov    0x8(%ebp),%eax
80103ebe:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103ec4:	05 00 02 00 00       	add    $0x200,%eax
80103ec9:	39 c2                	cmp    %eax,%edx
80103ecb:	74 85                	je     80103e52 <pipewrite+0x21>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103ecd:	8b 45 08             	mov    0x8(%ebp),%eax
80103ed0:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103ed6:	8d 48 01             	lea    0x1(%eax),%ecx
80103ed9:	8b 55 08             	mov    0x8(%ebp),%edx
80103edc:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
80103ee2:	25 ff 01 00 00       	and    $0x1ff,%eax
80103ee7:	89 c1                	mov    %eax,%ecx
80103ee9:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103eec:	8b 45 0c             	mov    0xc(%ebp),%eax
80103eef:	01 d0                	add    %edx,%eax
80103ef1:	0f b6 10             	movzbl (%eax),%edx
80103ef4:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef7:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
80103efb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103eff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103f02:	3b 45 10             	cmp    0x10(%ebp),%eax
80103f05:	7c ab                	jl     80103eb2 <pipewrite+0x81>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103f07:	8b 45 08             	mov    0x8(%ebp),%eax
80103f0a:	05 34 02 00 00       	add    $0x234,%eax
80103f0f:	83 ec 0c             	sub    $0xc,%esp
80103f12:	50                   	push   %eax
80103f13:	e8 8d 0a 00 00       	call   801049a5 <wakeup>
80103f18:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
80103f1b:	8b 45 08             	mov    0x8(%ebp),%eax
80103f1e:	83 ec 0c             	sub    $0xc,%esp
80103f21:	50                   	push   %eax
80103f22:	e8 29 0d 00 00       	call   80104c50 <release>
80103f27:	83 c4 10             	add    $0x10,%esp
  return n;
80103f2a:	8b 45 10             	mov    0x10(%ebp),%eax
}
80103f2d:	c9                   	leave  
80103f2e:	c3                   	ret    

80103f2f <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103f2f:	55                   	push   %ebp
80103f30:	89 e5                	mov    %esp,%ebp
80103f32:	53                   	push   %ebx
80103f33:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80103f36:	8b 45 08             	mov    0x8(%ebp),%eax
80103f39:	83 ec 0c             	sub    $0xc,%esp
80103f3c:	50                   	push   %eax
80103f3d:	e8 a7 0c 00 00       	call   80104be9 <acquire>
80103f42:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103f45:	eb 3f                	jmp    80103f86 <piperead+0x57>
    if(proc->killed){
80103f47:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f4d:	8b 40 24             	mov    0x24(%eax),%eax
80103f50:	85 c0                	test   %eax,%eax
80103f52:	74 19                	je     80103f6d <piperead+0x3e>
      release(&p->lock);
80103f54:	8b 45 08             	mov    0x8(%ebp),%eax
80103f57:	83 ec 0c             	sub    $0xc,%esp
80103f5a:	50                   	push   %eax
80103f5b:	e8 f0 0c 00 00       	call   80104c50 <release>
80103f60:	83 c4 10             	add    $0x10,%esp
      return -1;
80103f63:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103f68:	e9 bf 00 00 00       	jmp    8010402c <piperead+0xfd>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103f6d:	8b 45 08             	mov    0x8(%ebp),%eax
80103f70:	8b 55 08             	mov    0x8(%ebp),%edx
80103f73:	81 c2 34 02 00 00    	add    $0x234,%edx
80103f79:	83 ec 08             	sub    $0x8,%esp
80103f7c:	50                   	push   %eax
80103f7d:	52                   	push   %edx
80103f7e:	e8 37 09 00 00       	call   801048ba <sleep>
80103f83:	83 c4 10             	add    $0x10,%esp
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103f86:	8b 45 08             	mov    0x8(%ebp),%eax
80103f89:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103f8f:	8b 45 08             	mov    0x8(%ebp),%eax
80103f92:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103f98:	39 c2                	cmp    %eax,%edx
80103f9a:	75 0d                	jne    80103fa9 <piperead+0x7a>
80103f9c:	8b 45 08             	mov    0x8(%ebp),%eax
80103f9f:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103fa5:	85 c0                	test   %eax,%eax
80103fa7:	75 9e                	jne    80103f47 <piperead+0x18>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103fa9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103fb0:	eb 49                	jmp    80103ffb <piperead+0xcc>
    if(p->nread == p->nwrite)
80103fb2:	8b 45 08             	mov    0x8(%ebp),%eax
80103fb5:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80103fbb:	8b 45 08             	mov    0x8(%ebp),%eax
80103fbe:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80103fc4:	39 c2                	cmp    %eax,%edx
80103fc6:	74 3d                	je     80104005 <piperead+0xd6>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103fc8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
80103fce:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80103fd1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fd4:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80103fda:	8d 48 01             	lea    0x1(%eax),%ecx
80103fdd:	8b 55 08             	mov    0x8(%ebp),%edx
80103fe0:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80103fe6:	25 ff 01 00 00       	and    $0x1ff,%eax
80103feb:	89 c2                	mov    %eax,%edx
80103fed:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff0:	0f b6 44 10 34       	movzbl 0x34(%eax,%edx,1),%eax
80103ff5:	88 03                	mov    %al,(%ebx)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103ff7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103ffb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ffe:	3b 45 10             	cmp    0x10(%ebp),%eax
80104001:	7c af                	jl     80103fb2 <piperead+0x83>
80104003:	eb 01                	jmp    80104006 <piperead+0xd7>
    if(p->nread == p->nwrite)
      break;
80104005:	90                   	nop
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80104006:	8b 45 08             	mov    0x8(%ebp),%eax
80104009:	05 38 02 00 00       	add    $0x238,%eax
8010400e:	83 ec 0c             	sub    $0xc,%esp
80104011:	50                   	push   %eax
80104012:	e8 8e 09 00 00       	call   801049a5 <wakeup>
80104017:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
8010401a:	8b 45 08             	mov    0x8(%ebp),%eax
8010401d:	83 ec 0c             	sub    $0xc,%esp
80104020:	50                   	push   %eax
80104021:	e8 2a 0c 00 00       	call   80104c50 <release>
80104026:	83 c4 10             	add    $0x10,%esp
  return i;
80104029:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010402c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010402f:	c9                   	leave  
80104030:	c3                   	ret    

80104031 <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104031:	55                   	push   %ebp
80104032:	89 e5                	mov    %esp,%ebp
80104034:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104037:	9c                   	pushf  
80104038:	58                   	pop    %eax
80104039:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
8010403c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010403f:	c9                   	leave  
80104040:	c3                   	ret    

80104041 <sti>:
  asm volatile("cli");
}

static inline void
sti(void)
{
80104041:	55                   	push   %ebp
80104042:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104044:	fb                   	sti    
}
80104045:	90                   	nop
80104046:	5d                   	pop    %ebp
80104047:	c3                   	ret    

80104048 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
80104048:	55                   	push   %ebp
80104049:	89 e5                	mov    %esp,%ebp
8010404b:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010404e:	83 ec 08             	sub    $0x8,%esp
80104051:	68 45 84 10 80       	push   $0x80108445
80104056:	68 40 ff 10 80       	push   $0x8010ff40
8010405b:	e8 67 0b 00 00       	call   80104bc7 <initlock>
80104060:	83 c4 10             	add    $0x10,%esp
}
80104063:	90                   	nop
80104064:	c9                   	leave  
80104065:	c3                   	ret    

80104066 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80104066:	55                   	push   %ebp
80104067:	89 e5                	mov    %esp,%ebp
80104069:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
8010406c:	83 ec 0c             	sub    $0xc,%esp
8010406f:	68 40 ff 10 80       	push   $0x8010ff40
80104074:	e8 70 0b 00 00       	call   80104be9 <acquire>
80104079:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010407c:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104083:	eb 0e                	jmp    80104093 <allocproc+0x2d>
    if(p->state == UNUSED)
80104085:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104088:	8b 40 0c             	mov    0xc(%eax),%eax
8010408b:	85 c0                	test   %eax,%eax
8010408d:	74 27                	je     801040b6 <allocproc+0x50>
{
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010408f:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104093:	81 7d f4 74 1e 11 80 	cmpl   $0x80111e74,-0xc(%ebp)
8010409a:	72 e9                	jb     80104085 <allocproc+0x1f>
    if(p->state == UNUSED)
      goto found;
  release(&ptable.lock);
8010409c:	83 ec 0c             	sub    $0xc,%esp
8010409f:	68 40 ff 10 80       	push   $0x8010ff40
801040a4:	e8 a7 0b 00 00       	call   80104c50 <release>
801040a9:	83 c4 10             	add    $0x10,%esp
  return 0;
801040ac:	b8 00 00 00 00       	mov    $0x0,%eax
801040b1:	e9 b4 00 00 00       	jmp    8010416a <allocproc+0x104>
  char *sp;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;
801040b6:	90                   	nop
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801040b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040ba:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
801040c1:	a1 10 b0 10 80       	mov    0x8010b010,%eax
801040c6:	8d 50 01             	lea    0x1(%eax),%edx
801040c9:	89 15 10 b0 10 80    	mov    %edx,0x8010b010
801040cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
801040d2:	89 42 10             	mov    %eax,0x10(%edx)
  release(&ptable.lock);
801040d5:	83 ec 0c             	sub    $0xc,%esp
801040d8:	68 40 ff 10 80       	push   $0x8010ff40
801040dd:	e8 6e 0b 00 00       	call   80104c50 <release>
801040e2:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801040e5:	e8 c7 ea ff ff       	call   80102bb1 <kalloc>
801040ea:	89 c2                	mov    %eax,%edx
801040ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040ef:	89 50 08             	mov    %edx,0x8(%eax)
801040f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040f5:	8b 40 08             	mov    0x8(%eax),%eax
801040f8:	85 c0                	test   %eax,%eax
801040fa:	75 11                	jne    8010410d <allocproc+0xa7>
    p->state = UNUSED;
801040fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040ff:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
80104106:	b8 00 00 00 00       	mov    $0x0,%eax
8010410b:	eb 5d                	jmp    8010416a <allocproc+0x104>
  }
  sp = p->kstack + KSTACKSIZE;
8010410d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104110:	8b 40 08             	mov    0x8(%eax),%eax
80104113:	05 00 10 00 00       	add    $0x1000,%eax
80104118:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
8010411b:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe*)sp;
8010411f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104122:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104125:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104128:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint*)sp = (uint)trapret;
8010412c:	ba a9 62 10 80       	mov    $0x801062a9,%edx
80104131:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104134:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104136:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context*)sp;
8010413a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010413d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104140:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
80104143:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104146:	8b 40 1c             	mov    0x1c(%eax),%eax
80104149:	83 ec 04             	sub    $0x4,%esp
8010414c:	6a 14                	push   $0x14
8010414e:	6a 00                	push   $0x0
80104150:	50                   	push   %eax
80104151:	e8 f6 0c 00 00       	call   80104e4c <memset>
80104156:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104159:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010415c:	8b 40 1c             	mov    0x1c(%eax),%eax
8010415f:	ba 89 48 10 80       	mov    $0x80104889,%edx
80104164:	89 50 10             	mov    %edx,0x10(%eax)

  return p;
80104167:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010416a:	c9                   	leave  
8010416b:	c3                   	ret    

8010416c <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
8010416c:	55                   	push   %ebp
8010416d:	89 e5                	mov    %esp,%ebp
8010416f:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80104172:	e8 ef fe ff ff       	call   80104066 <allocproc>
80104177:	89 45 f4             	mov    %eax,-0xc(%ebp)
  initproc = p;
8010417a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010417d:	a3 68 b6 10 80       	mov    %eax,0x8010b668
  if((p->pgdir = setupkvm()) == 0)
80104182:	e8 e7 37 00 00       	call   8010796e <setupkvm>
80104187:	89 c2                	mov    %eax,%edx
80104189:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010418c:	89 50 04             	mov    %edx,0x4(%eax)
8010418f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104192:	8b 40 04             	mov    0x4(%eax),%eax
80104195:	85 c0                	test   %eax,%eax
80104197:	75 0d                	jne    801041a6 <userinit+0x3a>
    panic("userinit: out of memory?");
80104199:	83 ec 0c             	sub    $0xc,%esp
8010419c:	68 4c 84 10 80       	push   $0x8010844c
801041a1:	e8 c0 c3 ff ff       	call   80100566 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801041a6:	ba 2c 00 00 00       	mov    $0x2c,%edx
801041ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041ae:	8b 40 04             	mov    0x4(%eax),%eax
801041b1:	83 ec 04             	sub    $0x4,%esp
801041b4:	52                   	push   %edx
801041b5:	68 00 b5 10 80       	push   $0x8010b500
801041ba:	50                   	push   %eax
801041bb:	e8 08 3a 00 00       	call   80107bc8 <inituvm>
801041c0:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
801041c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041c6:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
801041cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041cf:	8b 40 18             	mov    0x18(%eax),%eax
801041d2:	83 ec 04             	sub    $0x4,%esp
801041d5:	6a 4c                	push   $0x4c
801041d7:	6a 00                	push   $0x0
801041d9:	50                   	push   %eax
801041da:	e8 6d 0c 00 00       	call   80104e4c <memset>
801041df:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801041e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041e5:	8b 40 18             	mov    0x18(%eax),%eax
801041e8:	66 c7 40 3c 23 00    	movw   $0x23,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801041ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041f1:	8b 40 18             	mov    0x18(%eax),%eax
801041f4:	66 c7 40 2c 2b 00    	movw   $0x2b,0x2c(%eax)
  p->tf->es = p->tf->ds;
801041fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041fd:	8b 40 18             	mov    0x18(%eax),%eax
80104200:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104203:	8b 52 18             	mov    0x18(%edx),%edx
80104206:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010420a:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010420e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104211:	8b 40 18             	mov    0x18(%eax),%eax
80104214:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104217:	8b 52 18             	mov    0x18(%edx),%edx
8010421a:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
8010421e:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104222:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104225:	8b 40 18             	mov    0x18(%eax),%eax
80104228:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
8010422f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104232:	8b 40 18             	mov    0x18(%eax),%eax
80104235:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010423c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010423f:	8b 40 18             	mov    0x18(%eax),%eax
80104242:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104249:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010424c:	83 c0 6c             	add    $0x6c,%eax
8010424f:	83 ec 04             	sub    $0x4,%esp
80104252:	6a 10                	push   $0x10
80104254:	68 65 84 10 80       	push   $0x80108465
80104259:	50                   	push   %eax
8010425a:	e8 f0 0d 00 00       	call   8010504f <safestrcpy>
8010425f:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
80104262:	83 ec 0c             	sub    $0xc,%esp
80104265:	68 6e 84 10 80       	push   $0x8010846e
8010426a:	e8 40 e2 ff ff       	call   801024af <namei>
8010426f:	83 c4 10             	add    $0x10,%esp
80104272:	89 c2                	mov    %eax,%edx
80104274:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104277:	89 50 68             	mov    %edx,0x68(%eax)

  p->state = RUNNABLE;
8010427a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010427d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
}
80104284:	90                   	nop
80104285:	c9                   	leave  
80104286:	c3                   	ret    

80104287 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80104287:	55                   	push   %ebp
80104288:	89 e5                	mov    %esp,%ebp
8010428a:	83 ec 18             	sub    $0x18,%esp
  uint sz;

  sz = proc->sz;
8010428d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104293:	8b 00                	mov    (%eax),%eax
80104295:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(n > 0){
80104298:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010429c:	7e 31                	jle    801042cf <growproc+0x48>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
8010429e:	8b 55 08             	mov    0x8(%ebp),%edx
801042a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042a4:	01 c2                	add    %eax,%edx
801042a6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042ac:	8b 40 04             	mov    0x4(%eax),%eax
801042af:	83 ec 04             	sub    $0x4,%esp
801042b2:	52                   	push   %edx
801042b3:	ff 75 f4             	pushl  -0xc(%ebp)
801042b6:	50                   	push   %eax
801042b7:	e8 59 3a 00 00       	call   80107d15 <allocuvm>
801042bc:	83 c4 10             	add    $0x10,%esp
801042bf:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042c2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042c6:	75 3e                	jne    80104306 <growproc+0x7f>
      return -1;
801042c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042cd:	eb 59                	jmp    80104328 <growproc+0xa1>
  } else if(n < 0){
801042cf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801042d3:	79 31                	jns    80104306 <growproc+0x7f>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
801042d5:	8b 55 08             	mov    0x8(%ebp),%edx
801042d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042db:	01 c2                	add    %eax,%edx
801042dd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801042e3:	8b 40 04             	mov    0x4(%eax),%eax
801042e6:	83 ec 04             	sub    $0x4,%esp
801042e9:	52                   	push   %edx
801042ea:	ff 75 f4             	pushl  -0xc(%ebp)
801042ed:	50                   	push   %eax
801042ee:	e8 eb 3a 00 00       	call   80107dde <deallocuvm>
801042f3:	83 c4 10             	add    $0x10,%esp
801042f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801042f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801042fd:	75 07                	jne    80104306 <growproc+0x7f>
      return -1;
801042ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104304:	eb 22                	jmp    80104328 <growproc+0xa1>
  }
  proc->sz = sz;
80104306:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010430c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010430f:	89 10                	mov    %edx,(%eax)
  switchuvm(proc);
80104311:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104317:	83 ec 0c             	sub    $0xc,%esp
8010431a:	50                   	push   %eax
8010431b:	e8 35 37 00 00       	call   80107a55 <switchuvm>
80104320:	83 c4 10             	add    $0x10,%esp
  return 0;
80104323:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104328:	c9                   	leave  
80104329:	c3                   	ret    

8010432a <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
8010432a:	55                   	push   %ebp
8010432b:	89 e5                	mov    %esp,%ebp
8010432d:	57                   	push   %edi
8010432e:	56                   	push   %esi
8010432f:	53                   	push   %ebx
80104330:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0)
80104333:	e8 2e fd ff ff       	call   80104066 <allocproc>
80104338:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010433b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010433f:	75 0a                	jne    8010434b <fork+0x21>
    return -1;
80104341:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104346:	e9 48 01 00 00       	jmp    80104493 <fork+0x169>

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
8010434b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104351:	8b 10                	mov    (%eax),%edx
80104353:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104359:	8b 40 04             	mov    0x4(%eax),%eax
8010435c:	83 ec 08             	sub    $0x8,%esp
8010435f:	52                   	push   %edx
80104360:	50                   	push   %eax
80104361:	e8 16 3c 00 00       	call   80107f7c <copyuvm>
80104366:	83 c4 10             	add    $0x10,%esp
80104369:	89 c2                	mov    %eax,%edx
8010436b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010436e:	89 50 04             	mov    %edx,0x4(%eax)
80104371:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104374:	8b 40 04             	mov    0x4(%eax),%eax
80104377:	85 c0                	test   %eax,%eax
80104379:	75 30                	jne    801043ab <fork+0x81>
    kfree(np->kstack);
8010437b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010437e:	8b 40 08             	mov    0x8(%eax),%eax
80104381:	83 ec 0c             	sub    $0xc,%esp
80104384:	50                   	push   %eax
80104385:	e8 8a e7 ff ff       	call   80102b14 <kfree>
8010438a:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
8010438d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104390:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
80104397:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010439a:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801043a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801043a6:	e9 e8 00 00 00       	jmp    80104493 <fork+0x169>
  }
  np->sz = proc->sz;
801043ab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043b1:	8b 10                	mov    (%eax),%edx
801043b3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043b6:	89 10                	mov    %edx,(%eax)
  np->parent = proc;
801043b8:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801043bf:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043c2:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *proc->tf;
801043c5:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043c8:	8b 50 18             	mov    0x18(%eax),%edx
801043cb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043d1:	8b 40 18             	mov    0x18(%eax),%eax
801043d4:	89 c3                	mov    %eax,%ebx
801043d6:	b8 13 00 00 00       	mov    $0x13,%eax
801043db:	89 d7                	mov    %edx,%edi
801043dd:	89 de                	mov    %ebx,%esi
801043df:	89 c1                	mov    %eax,%ecx
801043e1:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
801043e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801043e6:	8b 40 18             	mov    0x18(%eax),%eax
801043e9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for(i = 0; i < NOFILE; i++)
801043f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801043f7:	eb 43                	jmp    8010443c <fork+0x112>
    if(proc->ofile[i])
801043f9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801043ff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104402:	83 c2 08             	add    $0x8,%edx
80104405:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104409:	85 c0                	test   %eax,%eax
8010440b:	74 2b                	je     80104438 <fork+0x10e>
      np->ofile[i] = filedup(proc->ofile[i]);
8010440d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104413:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104416:	83 c2 08             	add    $0x8,%edx
80104419:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
8010441d:	83 ec 0c             	sub    $0xc,%esp
80104420:	50                   	push   %eax
80104421:	e8 ab cb ff ff       	call   80100fd1 <filedup>
80104426:	83 c4 10             	add    $0x10,%esp
80104429:	89 c1                	mov    %eax,%ecx
8010442b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010442e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104431:	83 c2 08             	add    $0x8,%edx
80104434:	89 4c 90 08          	mov    %ecx,0x8(%eax,%edx,4)
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80104438:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
8010443c:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104440:	7e b7                	jle    801043f9 <fork+0xcf>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80104442:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104448:	8b 40 68             	mov    0x68(%eax),%eax
8010444b:	83 ec 0c             	sub    $0xc,%esp
8010444e:	50                   	push   %eax
8010444f:	e8 69 d4 ff ff       	call   801018bd <idup>
80104454:	83 c4 10             	add    $0x10,%esp
80104457:	89 c2                	mov    %eax,%edx
80104459:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010445c:	89 50 68             	mov    %edx,0x68(%eax)

  pid = np->pid;
8010445f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104462:	8b 40 10             	mov    0x10(%eax),%eax
80104465:	89 45 dc             	mov    %eax,-0x24(%ebp)
  np->state = RUNNABLE;
80104468:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010446b:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  safestrcpy(np->name, proc->name, sizeof(proc->name));
80104472:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104478:	8d 50 6c             	lea    0x6c(%eax),%edx
8010447b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010447e:	83 c0 6c             	add    $0x6c,%eax
80104481:	83 ec 04             	sub    $0x4,%esp
80104484:	6a 10                	push   $0x10
80104486:	52                   	push   %edx
80104487:	50                   	push   %eax
80104488:	e8 c2 0b 00 00       	call   8010504f <safestrcpy>
8010448d:	83 c4 10             	add    $0x10,%esp
  return pid;
80104490:	8b 45 dc             	mov    -0x24(%ebp),%eax
}
80104493:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104496:	5b                   	pop    %ebx
80104497:	5e                   	pop    %esi
80104498:	5f                   	pop    %edi
80104499:	5d                   	pop    %ebp
8010449a:	c3                   	ret    

8010449b <exit>:
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
8010449b:	55                   	push   %ebp
8010449c:	89 e5                	mov    %esp,%ebp
8010449e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int fd;

  if(proc == initproc)
801044a1:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801044a8:	a1 68 b6 10 80       	mov    0x8010b668,%eax
801044ad:	39 c2                	cmp    %eax,%edx
801044af:	75 0d                	jne    801044be <exit+0x23>
    panic("init exiting");
801044b1:	83 ec 0c             	sub    $0xc,%esp
801044b4:	68 70 84 10 80       	push   $0x80108470
801044b9:	e8 a8 c0 ff ff       	call   80100566 <panic>

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
801044be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801044c5:	eb 48                	jmp    8010450f <exit+0x74>
    if(proc->ofile[fd]){
801044c7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044cd:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044d0:	83 c2 08             	add    $0x8,%edx
801044d3:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801044d7:	85 c0                	test   %eax,%eax
801044d9:	74 30                	je     8010450b <exit+0x70>
      fileclose(proc->ofile[fd]);
801044db:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044e1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801044e4:	83 c2 08             	add    $0x8,%edx
801044e7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801044eb:	83 ec 0c             	sub    $0xc,%esp
801044ee:	50                   	push   %eax
801044ef:	e8 2e cb ff ff       	call   80101022 <fileclose>
801044f4:	83 c4 10             	add    $0x10,%esp
      proc->ofile[fd] = 0;
801044f7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801044fd:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104500:	83 c2 08             	add    $0x8,%edx
80104503:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010450a:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
8010450b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
8010450f:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104513:	7e b2                	jle    801044c7 <exit+0x2c>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  iput(proc->cwd);
80104515:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010451b:	8b 40 68             	mov    0x68(%eax),%eax
8010451e:	83 ec 0c             	sub    $0xc,%esp
80104521:	50                   	push   %eax
80104522:	e8 9a d5 ff ff       	call   80101ac1 <iput>
80104527:	83 c4 10             	add    $0x10,%esp
  proc->cwd = 0;
8010452a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104530:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104537:	83 ec 0c             	sub    $0xc,%esp
8010453a:	68 40 ff 10 80       	push   $0x8010ff40
8010453f:	e8 a5 06 00 00       	call   80104be9 <acquire>
80104544:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80104547:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010454d:	8b 40 14             	mov    0x14(%eax),%eax
80104550:	83 ec 0c             	sub    $0xc,%esp
80104553:	50                   	push   %eax
80104554:	e8 0d 04 00 00       	call   80104966 <wakeup1>
80104559:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010455c:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
80104563:	eb 3c                	jmp    801045a1 <exit+0x106>
    if(p->parent == proc){
80104565:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104568:	8b 50 14             	mov    0x14(%eax),%edx
8010456b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104571:	39 c2                	cmp    %eax,%edx
80104573:	75 28                	jne    8010459d <exit+0x102>
      p->parent = initproc;
80104575:	8b 15 68 b6 10 80    	mov    0x8010b668,%edx
8010457b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010457e:	89 50 14             	mov    %edx,0x14(%eax)
      if(p->state == ZOMBIE)
80104581:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104584:	8b 40 0c             	mov    0xc(%eax),%eax
80104587:	83 f8 05             	cmp    $0x5,%eax
8010458a:	75 11                	jne    8010459d <exit+0x102>
        wakeup1(initproc);
8010458c:	a1 68 b6 10 80       	mov    0x8010b668,%eax
80104591:	83 ec 0c             	sub    $0xc,%esp
80104594:	50                   	push   %eax
80104595:	e8 cc 03 00 00       	call   80104966 <wakeup1>
8010459a:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010459d:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
801045a1:	81 7d f4 74 1e 11 80 	cmpl   $0x80111e74,-0xc(%ebp)
801045a8:	72 bb                	jb     80104565 <exit+0xca>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
801045aa:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045b0:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)
  sched();
801045b7:	e8 d6 01 00 00       	call   80104792 <sched>
  panic("zombie exit");
801045bc:	83 ec 0c             	sub    $0xc,%esp
801045bf:	68 7d 84 10 80       	push   $0x8010847d
801045c4:	e8 9d bf ff ff       	call   80100566 <panic>

801045c9 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
801045c9:	55                   	push   %ebp
801045ca:	89 e5                	mov    %esp,%ebp
801045cc:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
801045cf:	83 ec 0c             	sub    $0xc,%esp
801045d2:	68 40 ff 10 80       	push   $0x8010ff40
801045d7:	e8 0d 06 00 00       	call   80104be9 <acquire>
801045dc:	83 c4 10             	add    $0x10,%esp
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
801045df:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045e6:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
801045ed:	e9 a6 00 00 00       	jmp    80104698 <wait+0xcf>
      if(p->parent != proc)
801045f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045f5:	8b 50 14             	mov    0x14(%eax),%edx
801045f8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801045fe:	39 c2                	cmp    %eax,%edx
80104600:	0f 85 8d 00 00 00    	jne    80104693 <wait+0xca>
        continue;
      havekids = 1;
80104606:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if(p->state == ZOMBIE){
8010460d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104610:	8b 40 0c             	mov    0xc(%eax),%eax
80104613:	83 f8 05             	cmp    $0x5,%eax
80104616:	75 7c                	jne    80104694 <wait+0xcb>
        // Found one.
        pid = p->pid;
80104618:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461b:	8b 40 10             	mov    0x10(%eax),%eax
8010461e:	89 45 ec             	mov    %eax,-0x14(%ebp)
        kfree(p->kstack);
80104621:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104624:	8b 40 08             	mov    0x8(%eax),%eax
80104627:	83 ec 0c             	sub    $0xc,%esp
8010462a:	50                   	push   %eax
8010462b:	e8 e4 e4 ff ff       	call   80102b14 <kfree>
80104630:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104633:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104636:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
8010463d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104640:	8b 40 04             	mov    0x4(%eax),%eax
80104643:	83 ec 0c             	sub    $0xc,%esp
80104646:	50                   	push   %eax
80104647:	e8 4f 38 00 00       	call   80107e9b <freevm>
8010464c:	83 c4 10             	add    $0x10,%esp
        p->state = UNUSED;
8010464f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104652:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        p->pid = 0;
80104659:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010465c:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104663:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104666:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
8010466d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104670:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104674:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104677:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        release(&ptable.lock);
8010467e:	83 ec 0c             	sub    $0xc,%esp
80104681:	68 40 ff 10 80       	push   $0x8010ff40
80104686:	e8 c5 05 00 00       	call   80104c50 <release>
8010468b:	83 c4 10             	add    $0x10,%esp
        return pid;
8010468e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104691:	eb 58                	jmp    801046eb <wait+0x122>
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->parent != proc)
        continue;
80104693:	90                   	nop

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for zombie children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104694:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104698:	81 7d f4 74 1e 11 80 	cmpl   $0x80111e74,-0xc(%ebp)
8010469f:	0f 82 4d ff ff ff    	jb     801045f2 <wait+0x29>
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
801046a5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801046a9:	74 0d                	je     801046b8 <wait+0xef>
801046ab:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046b1:	8b 40 24             	mov    0x24(%eax),%eax
801046b4:	85 c0                	test   %eax,%eax
801046b6:	74 17                	je     801046cf <wait+0x106>
      release(&ptable.lock);
801046b8:	83 ec 0c             	sub    $0xc,%esp
801046bb:	68 40 ff 10 80       	push   $0x8010ff40
801046c0:	e8 8b 05 00 00       	call   80104c50 <release>
801046c5:	83 c4 10             	add    $0x10,%esp
      return -1;
801046c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046cd:	eb 1c                	jmp    801046eb <wait+0x122>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
801046cf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801046d5:	83 ec 08             	sub    $0x8,%esp
801046d8:	68 40 ff 10 80       	push   $0x8010ff40
801046dd:	50                   	push   %eax
801046de:	e8 d7 01 00 00       	call   801048ba <sleep>
801046e3:	83 c4 10             	add    $0x10,%esp
  }
801046e6:	e9 f4 fe ff ff       	jmp    801045df <wait+0x16>
}
801046eb:	c9                   	leave  
801046ec:	c3                   	ret    

801046ed <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
801046ed:	55                   	push   %ebp
801046ee:	89 e5                	mov    %esp,%ebp
801046f0:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  for(;;){
    // Enable interrupts on this processor.
    sti();
801046f3:	e8 49 f9 ff ff       	call   80104041 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
801046f8:	83 ec 0c             	sub    $0xc,%esp
801046fb:	68 40 ff 10 80       	push   $0x8010ff40
80104700:	e8 e4 04 00 00       	call   80104be9 <acquire>
80104705:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104708:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
8010470f:	eb 63                	jmp    80104774 <scheduler+0x87>
      if(p->state != RUNNABLE)
80104711:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104714:	8b 40 0c             	mov    0xc(%eax),%eax
80104717:	83 f8 03             	cmp    $0x3,%eax
8010471a:	75 53                	jne    8010476f <scheduler+0x82>
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
8010471c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010471f:	65 a3 04 00 00 00    	mov    %eax,%gs:0x4
      switchuvm(p);
80104725:	83 ec 0c             	sub    $0xc,%esp
80104728:	ff 75 f4             	pushl  -0xc(%ebp)
8010472b:	e8 25 33 00 00       	call   80107a55 <switchuvm>
80104730:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104733:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104736:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&cpu->scheduler, proc->context);
8010473d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104743:	8b 40 1c             	mov    0x1c(%eax),%eax
80104746:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010474d:	83 c2 04             	add    $0x4,%edx
80104750:	83 ec 08             	sub    $0x8,%esp
80104753:	50                   	push   %eax
80104754:	52                   	push   %edx
80104755:	e8 66 09 00 00       	call   801050c0 <swtch>
8010475a:	83 c4 10             	add    $0x10,%esp
      switchkvm();
8010475d:	e8 d6 32 00 00       	call   80107a38 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80104762:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80104769:	00 00 00 00 
8010476d:	eb 01                	jmp    80104770 <scheduler+0x83>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
      if(p->state != RUNNABLE)
        continue;
8010476f:	90                   	nop
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104770:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104774:	81 7d f4 74 1e 11 80 	cmpl   $0x80111e74,-0xc(%ebp)
8010477b:	72 94                	jb     80104711 <scheduler+0x24>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
8010477d:	83 ec 0c             	sub    $0xc,%esp
80104780:	68 40 ff 10 80       	push   $0x8010ff40
80104785:	e8 c6 04 00 00       	call   80104c50 <release>
8010478a:	83 c4 10             	add    $0x10,%esp

  }
8010478d:	e9 61 ff ff ff       	jmp    801046f3 <scheduler+0x6>

80104792 <sched>:

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void
sched(void)
{
80104792:	55                   	push   %ebp
80104793:	89 e5                	mov    %esp,%ebp
80104795:	83 ec 18             	sub    $0x18,%esp
  int intena;

  if(!holding(&ptable.lock))
80104798:	83 ec 0c             	sub    $0xc,%esp
8010479b:	68 40 ff 10 80       	push   $0x8010ff40
801047a0:	e8 77 05 00 00       	call   80104d1c <holding>
801047a5:	83 c4 10             	add    $0x10,%esp
801047a8:	85 c0                	test   %eax,%eax
801047aa:	75 0d                	jne    801047b9 <sched+0x27>
    panic("sched ptable.lock");
801047ac:	83 ec 0c             	sub    $0xc,%esp
801047af:	68 89 84 10 80       	push   $0x80108489
801047b4:	e8 ad bd ff ff       	call   80100566 <panic>
  if(cpu->ncli != 1)
801047b9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801047bf:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
801047c5:	83 f8 01             	cmp    $0x1,%eax
801047c8:	74 0d                	je     801047d7 <sched+0x45>
    panic("sched locks");
801047ca:	83 ec 0c             	sub    $0xc,%esp
801047cd:	68 9b 84 10 80       	push   $0x8010849b
801047d2:	e8 8f bd ff ff       	call   80100566 <panic>
  if(proc->state == RUNNING)
801047d7:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801047dd:	8b 40 0c             	mov    0xc(%eax),%eax
801047e0:	83 f8 04             	cmp    $0x4,%eax
801047e3:	75 0d                	jne    801047f2 <sched+0x60>
    panic("sched running");
801047e5:	83 ec 0c             	sub    $0xc,%esp
801047e8:	68 a7 84 10 80       	push   $0x801084a7
801047ed:	e8 74 bd ff ff       	call   80100566 <panic>
  if(readeflags()&FL_IF)
801047f2:	e8 3a f8 ff ff       	call   80104031 <readeflags>
801047f7:	25 00 02 00 00       	and    $0x200,%eax
801047fc:	85 c0                	test   %eax,%eax
801047fe:	74 0d                	je     8010480d <sched+0x7b>
    panic("sched interruptible");
80104800:	83 ec 0c             	sub    $0xc,%esp
80104803:	68 b5 84 10 80       	push   $0x801084b5
80104808:	e8 59 bd ff ff       	call   80100566 <panic>
  intena = cpu->intena;
8010480d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104813:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104819:	89 45 f4             	mov    %eax,-0xc(%ebp)
  swtch(&proc->context, cpu->scheduler);
8010481c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104822:	8b 40 04             	mov    0x4(%eax),%eax
80104825:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010482c:	83 c2 1c             	add    $0x1c,%edx
8010482f:	83 ec 08             	sub    $0x8,%esp
80104832:	50                   	push   %eax
80104833:	52                   	push   %edx
80104834:	e8 87 08 00 00       	call   801050c0 <swtch>
80104839:	83 c4 10             	add    $0x10,%esp
  cpu->intena = intena;
8010483c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104842:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104845:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
8010484b:	90                   	nop
8010484c:	c9                   	leave  
8010484d:	c3                   	ret    

8010484e <yield>:

// Give up the CPU for one scheduling round.
void
yield(void)
{
8010484e:	55                   	push   %ebp
8010484f:	89 e5                	mov    %esp,%ebp
80104851:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104854:	83 ec 0c             	sub    $0xc,%esp
80104857:	68 40 ff 10 80       	push   $0x8010ff40
8010485c:	e8 88 03 00 00       	call   80104be9 <acquire>
80104861:	83 c4 10             	add    $0x10,%esp
  proc->state = RUNNABLE;
80104864:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010486a:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80104871:	e8 1c ff ff ff       	call   80104792 <sched>
  release(&ptable.lock);
80104876:	83 ec 0c             	sub    $0xc,%esp
80104879:	68 40 ff 10 80       	push   $0x8010ff40
8010487e:	e8 cd 03 00 00       	call   80104c50 <release>
80104883:	83 c4 10             	add    $0x10,%esp
}
80104886:	90                   	nop
80104887:	c9                   	leave  
80104888:	c3                   	ret    

80104889 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104889:	55                   	push   %ebp
8010488a:	89 e5                	mov    %esp,%ebp
8010488c:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
8010488f:	83 ec 0c             	sub    $0xc,%esp
80104892:	68 40 ff 10 80       	push   $0x8010ff40
80104897:	e8 b4 03 00 00       	call   80104c50 <release>
8010489c:	83 c4 10             	add    $0x10,%esp

  if (first) {
8010489f:	a1 14 b0 10 80       	mov    0x8010b014,%eax
801048a4:	85 c0                	test   %eax,%eax
801048a6:	74 0f                	je     801048b7 <forkret+0x2e>
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801048a8:	c7 05 14 b0 10 80 00 	movl   $0x0,0x8010b014
801048af:	00 00 00 
    initlog();
801048b2:	e8 9e e7 ff ff       	call   80103055 <initlog>
  }

  // Return to "caller", actually trapret (see allocproc).
}
801048b7:	90                   	nop
801048b8:	c9                   	leave  
801048b9:	c3                   	ret    

801048ba <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
801048ba:	55                   	push   %ebp
801048bb:	89 e5                	mov    %esp,%ebp
801048bd:	83 ec 08             	sub    $0x8,%esp
  if(proc == 0)
801048c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801048c6:	85 c0                	test   %eax,%eax
801048c8:	75 0d                	jne    801048d7 <sleep+0x1d>
    panic("sleep");
801048ca:	83 ec 0c             	sub    $0xc,%esp
801048cd:	68 c9 84 10 80       	push   $0x801084c9
801048d2:	e8 8f bc ff ff       	call   80100566 <panic>

  if(lk == 0)
801048d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801048db:	75 0d                	jne    801048ea <sleep+0x30>
    panic("sleep without lk");
801048dd:	83 ec 0c             	sub    $0xc,%esp
801048e0:	68 cf 84 10 80       	push   $0x801084cf
801048e5:	e8 7c bc ff ff       	call   80100566 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
801048ea:	81 7d 0c 40 ff 10 80 	cmpl   $0x8010ff40,0xc(%ebp)
801048f1:	74 1e                	je     80104911 <sleep+0x57>
    acquire(&ptable.lock);  //DOC: sleeplock1
801048f3:	83 ec 0c             	sub    $0xc,%esp
801048f6:	68 40 ff 10 80       	push   $0x8010ff40
801048fb:	e8 e9 02 00 00       	call   80104be9 <acquire>
80104900:	83 c4 10             	add    $0x10,%esp
    release(lk);
80104903:	83 ec 0c             	sub    $0xc,%esp
80104906:	ff 75 0c             	pushl  0xc(%ebp)
80104909:	e8 42 03 00 00       	call   80104c50 <release>
8010490e:	83 c4 10             	add    $0x10,%esp
  }

  // Go to sleep.
  proc->chan = chan;
80104911:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104917:	8b 55 08             	mov    0x8(%ebp),%edx
8010491a:	89 50 20             	mov    %edx,0x20(%eax)
  proc->state = SLEEPING;
8010491d:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104923:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
8010492a:	e8 63 fe ff ff       	call   80104792 <sched>

  // Tidy up.
  proc->chan = 0;
8010492f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80104935:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
8010493c:	81 7d 0c 40 ff 10 80 	cmpl   $0x8010ff40,0xc(%ebp)
80104943:	74 1e                	je     80104963 <sleep+0xa9>
    release(&ptable.lock);
80104945:	83 ec 0c             	sub    $0xc,%esp
80104948:	68 40 ff 10 80       	push   $0x8010ff40
8010494d:	e8 fe 02 00 00       	call   80104c50 <release>
80104952:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
80104955:	83 ec 0c             	sub    $0xc,%esp
80104958:	ff 75 0c             	pushl  0xc(%ebp)
8010495b:	e8 89 02 00 00       	call   80104be9 <acquire>
80104960:	83 c4 10             	add    $0x10,%esp
  }
}
80104963:	90                   	nop
80104964:	c9                   	leave  
80104965:	c3                   	ret    

80104966 <wakeup1>:
//PAGEBREAK!
// Wake up all processes sleeping on chan.
// The ptable lock must be held.
static void
wakeup1(void *chan)
{
80104966:	55                   	push   %ebp
80104967:	89 e5                	mov    %esp,%ebp
80104969:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010496c:	c7 45 fc 74 ff 10 80 	movl   $0x8010ff74,-0x4(%ebp)
80104973:	eb 24                	jmp    80104999 <wakeup1+0x33>
    if(p->state == SLEEPING && p->chan == chan)
80104975:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104978:	8b 40 0c             	mov    0xc(%eax),%eax
8010497b:	83 f8 02             	cmp    $0x2,%eax
8010497e:	75 15                	jne    80104995 <wakeup1+0x2f>
80104980:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104983:	8b 40 20             	mov    0x20(%eax),%eax
80104986:	3b 45 08             	cmp    0x8(%ebp),%eax
80104989:	75 0a                	jne    80104995 <wakeup1+0x2f>
      p->state = RUNNABLE;
8010498b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010498e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104995:	83 45 fc 7c          	addl   $0x7c,-0x4(%ebp)
80104999:	81 7d fc 74 1e 11 80 	cmpl   $0x80111e74,-0x4(%ebp)
801049a0:	72 d3                	jb     80104975 <wakeup1+0xf>
    if(p->state == SLEEPING && p->chan == chan)
      p->state = RUNNABLE;
}
801049a2:	90                   	nop
801049a3:	c9                   	leave  
801049a4:	c3                   	ret    

801049a5 <wakeup>:

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801049a5:	55                   	push   %ebp
801049a6:	89 e5                	mov    %esp,%ebp
801049a8:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
801049ab:	83 ec 0c             	sub    $0xc,%esp
801049ae:	68 40 ff 10 80       	push   $0x8010ff40
801049b3:	e8 31 02 00 00       	call   80104be9 <acquire>
801049b8:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
801049bb:	83 ec 0c             	sub    $0xc,%esp
801049be:	ff 75 08             	pushl  0x8(%ebp)
801049c1:	e8 a0 ff ff ff       	call   80104966 <wakeup1>
801049c6:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
801049c9:	83 ec 0c             	sub    $0xc,%esp
801049cc:	68 40 ff 10 80       	push   $0x8010ff40
801049d1:	e8 7a 02 00 00       	call   80104c50 <release>
801049d6:	83 c4 10             	add    $0x10,%esp
}
801049d9:	90                   	nop
801049da:	c9                   	leave  
801049db:	c3                   	ret    

801049dc <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801049dc:	55                   	push   %ebp
801049dd:	89 e5                	mov    %esp,%ebp
801049df:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
801049e2:	83 ec 0c             	sub    $0xc,%esp
801049e5:	68 40 ff 10 80       	push   $0x8010ff40
801049ea:	e8 fa 01 00 00       	call   80104be9 <acquire>
801049ef:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049f2:	c7 45 f4 74 ff 10 80 	movl   $0x8010ff74,-0xc(%ebp)
801049f9:	eb 45                	jmp    80104a40 <kill+0x64>
    if(p->pid == pid){
801049fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801049fe:	8b 40 10             	mov    0x10(%eax),%eax
80104a01:	3b 45 08             	cmp    0x8(%ebp),%eax
80104a04:	75 36                	jne    80104a3c <kill+0x60>
      p->killed = 1;
80104a06:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a09:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104a10:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a13:	8b 40 0c             	mov    0xc(%eax),%eax
80104a16:	83 f8 02             	cmp    $0x2,%eax
80104a19:	75 0a                	jne    80104a25 <kill+0x49>
        p->state = RUNNABLE;
80104a1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104a1e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104a25:	83 ec 0c             	sub    $0xc,%esp
80104a28:	68 40 ff 10 80       	push   $0x8010ff40
80104a2d:	e8 1e 02 00 00       	call   80104c50 <release>
80104a32:	83 c4 10             	add    $0x10,%esp
      return 0;
80104a35:	b8 00 00 00 00       	mov    $0x0,%eax
80104a3a:	eb 22                	jmp    80104a5e <kill+0x82>
kill(int pid)
{
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a3c:	83 45 f4 7c          	addl   $0x7c,-0xc(%ebp)
80104a40:	81 7d f4 74 1e 11 80 	cmpl   $0x80111e74,-0xc(%ebp)
80104a47:	72 b2                	jb     801049fb <kill+0x1f>
        p->state = RUNNABLE;
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
80104a49:	83 ec 0c             	sub    $0xc,%esp
80104a4c:	68 40 ff 10 80       	push   $0x8010ff40
80104a51:	e8 fa 01 00 00       	call   80104c50 <release>
80104a56:	83 c4 10             	add    $0x10,%esp
  return -1;
80104a59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a5e:	c9                   	leave  
80104a5f:	c3                   	ret    

80104a60 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104a60:	55                   	push   %ebp
80104a61:	89 e5                	mov    %esp,%ebp
80104a63:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a66:	c7 45 f0 74 ff 10 80 	movl   $0x8010ff74,-0x10(%ebp)
80104a6d:	e9 d7 00 00 00       	jmp    80104b49 <procdump+0xe9>
    if(p->state == UNUSED)
80104a72:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a75:	8b 40 0c             	mov    0xc(%eax),%eax
80104a78:	85 c0                	test   %eax,%eax
80104a7a:	0f 84 c4 00 00 00    	je     80104b44 <procdump+0xe4>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a83:	8b 40 0c             	mov    0xc(%eax),%eax
80104a86:	83 f8 05             	cmp    $0x5,%eax
80104a89:	77 23                	ja     80104aae <procdump+0x4e>
80104a8b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a8e:	8b 40 0c             	mov    0xc(%eax),%eax
80104a91:	8b 04 85 18 b0 10 80 	mov    -0x7fef4fe8(,%eax,4),%eax
80104a98:	85 c0                	test   %eax,%eax
80104a9a:	74 12                	je     80104aae <procdump+0x4e>
      state = states[p->state];
80104a9c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104a9f:	8b 40 0c             	mov    0xc(%eax),%eax
80104aa2:	8b 04 85 18 b0 10 80 	mov    -0x7fef4fe8(,%eax,4),%eax
80104aa9:	89 45 ec             	mov    %eax,-0x14(%ebp)
80104aac:	eb 07                	jmp    80104ab5 <procdump+0x55>
    else
      state = "???";
80104aae:	c7 45 ec e0 84 10 80 	movl   $0x801084e0,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80104ab5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ab8:	8d 50 6c             	lea    0x6c(%eax),%edx
80104abb:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104abe:	8b 40 10             	mov    0x10(%eax),%eax
80104ac1:	52                   	push   %edx
80104ac2:	ff 75 ec             	pushl  -0x14(%ebp)
80104ac5:	50                   	push   %eax
80104ac6:	68 e4 84 10 80       	push   $0x801084e4
80104acb:	e8 f6 b8 ff ff       	call   801003c6 <cprintf>
80104ad0:	83 c4 10             	add    $0x10,%esp
    if(p->state == SLEEPING){
80104ad3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ad6:	8b 40 0c             	mov    0xc(%eax),%eax
80104ad9:	83 f8 02             	cmp    $0x2,%eax
80104adc:	75 54                	jne    80104b32 <procdump+0xd2>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ade:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104ae1:	8b 40 1c             	mov    0x1c(%eax),%eax
80104ae4:	8b 40 0c             	mov    0xc(%eax),%eax
80104ae7:	83 c0 08             	add    $0x8,%eax
80104aea:	89 c2                	mov    %eax,%edx
80104aec:	83 ec 08             	sub    $0x8,%esp
80104aef:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104af2:	50                   	push   %eax
80104af3:	52                   	push   %edx
80104af4:	e8 a9 01 00 00       	call   80104ca2 <getcallerpcs>
80104af9:	83 c4 10             	add    $0x10,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104afc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104b03:	eb 1c                	jmp    80104b21 <procdump+0xc1>
        cprintf(" %p", pc[i]);
80104b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b08:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104b0c:	83 ec 08             	sub    $0x8,%esp
80104b0f:	50                   	push   %eax
80104b10:	68 ed 84 10 80       	push   $0x801084ed
80104b15:	e8 ac b8 ff ff       	call   801003c6 <cprintf>
80104b1a:	83 c4 10             	add    $0x10,%esp
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104b1d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104b21:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
80104b25:	7f 0b                	jg     80104b32 <procdump+0xd2>
80104b27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b2a:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80104b2e:	85 c0                	test   %eax,%eax
80104b30:	75 d3                	jne    80104b05 <procdump+0xa5>
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104b32:	83 ec 0c             	sub    $0xc,%esp
80104b35:	68 f1 84 10 80       	push   $0x801084f1
80104b3a:	e8 87 b8 ff ff       	call   801003c6 <cprintf>
80104b3f:	83 c4 10             	add    $0x10,%esp
80104b42:	eb 01                	jmp    80104b45 <procdump+0xe5>
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
80104b44:	90                   	nop
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b45:	83 45 f0 7c          	addl   $0x7c,-0x10(%ebp)
80104b49:	81 7d f0 74 1e 11 80 	cmpl   $0x80111e74,-0x10(%ebp)
80104b50:	0f 82 1c ff ff ff    	jb     80104a72 <procdump+0x12>
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104b56:	90                   	nop
80104b57:	c9                   	leave  
80104b58:	c3                   	ret    

80104b59 <randX>:

int
randX(int x)
{
80104b59:	55                   	push   %ebp
80104b5a:	89 e5                	mov    %esp,%ebp
    return x^(x << 1);
80104b5c:	8b 45 08             	mov    0x8(%ebp),%eax
80104b5f:	01 c0                	add    %eax,%eax
80104b61:	33 45 08             	xor    0x8(%ebp),%eax
}
80104b64:	5d                   	pop    %ebp
80104b65:	c3                   	ret    

80104b66 <u_random>:

int
u_random()
{
80104b66:	55                   	push   %ebp
80104b67:	89 e5                	mov    %esp,%ebp
    return (ur_A*seedX + ur_B)% ur_M;
80104b69:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104b6e:	8b 15 74 1e 11 80    	mov    0x80111e74,%edx
80104b74:	0f af d0             	imul   %eax,%edx
80104b77:	a1 08 b0 10 80       	mov    0x8010b008,%eax
80104b7c:	01 d0                	add    %edx,%eax
80104b7e:	8b 0d 0c b0 10 80    	mov    0x8010b00c,%ecx
80104b84:	ba 00 00 00 00       	mov    $0x0,%edx
80104b89:	f7 f1                	div    %ecx
80104b8b:	89 d0                	mov    %edx,%eax
}
80104b8d:	5d                   	pop    %ebp
80104b8e:	c3                   	ret    

80104b8f <readeflags>:
  asm volatile("ltr %0" : : "r" (sel));
}

static inline uint
readeflags(void)
{
80104b8f:	55                   	push   %ebp
80104b90:	89 e5                	mov    %esp,%ebp
80104b92:	83 ec 10             	sub    $0x10,%esp
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b95:	9c                   	pushf  
80104b96:	58                   	pop    %eax
80104b97:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80104b9a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104b9d:	c9                   	leave  
80104b9e:	c3                   	ret    

80104b9f <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
80104b9f:	55                   	push   %ebp
80104ba0:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80104ba2:	fa                   	cli    
}
80104ba3:	90                   	nop
80104ba4:	5d                   	pop    %ebp
80104ba5:	c3                   	ret    

80104ba6 <sti>:

static inline void
sti(void)
{
80104ba6:	55                   	push   %ebp
80104ba7:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80104ba9:	fb                   	sti    
}
80104baa:	90                   	nop
80104bab:	5d                   	pop    %ebp
80104bac:	c3                   	ret    

80104bad <xchg>:

static inline uint
xchg(volatile uint *addr, uint newval)
{
80104bad:	55                   	push   %ebp
80104bae:	89 e5                	mov    %esp,%ebp
80104bb0:	83 ec 10             	sub    $0x10,%esp
  uint result;
  
  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80104bb3:	8b 55 08             	mov    0x8(%ebp),%edx
80104bb6:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bb9:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104bbc:	f0 87 02             	lock xchg %eax,(%edx)
80104bbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80104bc2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80104bc5:	c9                   	leave  
80104bc6:	c3                   	ret    

80104bc7 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104bc7:	55                   	push   %ebp
80104bc8:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80104bca:	8b 45 08             	mov    0x8(%ebp),%eax
80104bcd:	8b 55 0c             	mov    0xc(%ebp),%edx
80104bd0:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80104bd3:	8b 45 08             	mov    0x8(%ebp),%eax
80104bd6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80104bdc:	8b 45 08             	mov    0x8(%ebp),%eax
80104bdf:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104be6:	90                   	nop
80104be7:	5d                   	pop    %ebp
80104be8:	c3                   	ret    

80104be9 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80104be9:	55                   	push   %ebp
80104bea:	89 e5                	mov    %esp,%ebp
80104bec:	83 ec 08             	sub    $0x8,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104bef:	e8 52 01 00 00       	call   80104d46 <pushcli>
  if(holding(lk))
80104bf4:	8b 45 08             	mov    0x8(%ebp),%eax
80104bf7:	83 ec 0c             	sub    $0xc,%esp
80104bfa:	50                   	push   %eax
80104bfb:	e8 1c 01 00 00       	call   80104d1c <holding>
80104c00:	83 c4 10             	add    $0x10,%esp
80104c03:	85 c0                	test   %eax,%eax
80104c05:	74 0d                	je     80104c14 <acquire+0x2b>
    panic("acquire");
80104c07:	83 ec 0c             	sub    $0xc,%esp
80104c0a:	68 1d 85 10 80       	push   $0x8010851d
80104c0f:	e8 52 b9 ff ff       	call   80100566 <panic>

  // The xchg is atomic.
  // It also serializes, so that reads after acquire are not
  // reordered before it. 
  while(xchg(&lk->locked, 1) != 0)
80104c14:	90                   	nop
80104c15:	8b 45 08             	mov    0x8(%ebp),%eax
80104c18:	83 ec 08             	sub    $0x8,%esp
80104c1b:	6a 01                	push   $0x1
80104c1d:	50                   	push   %eax
80104c1e:	e8 8a ff ff ff       	call   80104bad <xchg>
80104c23:	83 c4 10             	add    $0x10,%esp
80104c26:	85 c0                	test   %eax,%eax
80104c28:	75 eb                	jne    80104c15 <acquire+0x2c>
    ;

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104c2a:	8b 45 08             	mov    0x8(%ebp),%eax
80104c2d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104c34:	89 50 08             	mov    %edx,0x8(%eax)
  getcallerpcs(&lk, lk->pcs);
80104c37:	8b 45 08             	mov    0x8(%ebp),%eax
80104c3a:	83 c0 0c             	add    $0xc,%eax
80104c3d:	83 ec 08             	sub    $0x8,%esp
80104c40:	50                   	push   %eax
80104c41:	8d 45 08             	lea    0x8(%ebp),%eax
80104c44:	50                   	push   %eax
80104c45:	e8 58 00 00 00       	call   80104ca2 <getcallerpcs>
80104c4a:	83 c4 10             	add    $0x10,%esp
}
80104c4d:	90                   	nop
80104c4e:	c9                   	leave  
80104c4f:	c3                   	ret    

80104c50 <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
80104c50:	55                   	push   %ebp
80104c51:	89 e5                	mov    %esp,%ebp
80104c53:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80104c56:	83 ec 0c             	sub    $0xc,%esp
80104c59:	ff 75 08             	pushl  0x8(%ebp)
80104c5c:	e8 bb 00 00 00       	call   80104d1c <holding>
80104c61:	83 c4 10             	add    $0x10,%esp
80104c64:	85 c0                	test   %eax,%eax
80104c66:	75 0d                	jne    80104c75 <release+0x25>
    panic("release");
80104c68:	83 ec 0c             	sub    $0xc,%esp
80104c6b:	68 25 85 10 80       	push   $0x80108525
80104c70:	e8 f1 b8 ff ff       	call   80100566 <panic>

  lk->pcs[0] = 0;
80104c75:	8b 45 08             	mov    0x8(%ebp),%eax
80104c78:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104c7f:	8b 45 08             	mov    0x8(%ebp),%eax
80104c82:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // But the 2007 Intel 64 Architecture Memory Ordering White
  // Paper says that Intel 64 and IA-32 will not move a load
  // after a store. So lock->locked = 0 would work here.
  // The xchg being asm volatile ensures gcc emits it after
  // the above assignments (and after the critical section).
  xchg(&lk->locked, 0);
80104c89:	8b 45 08             	mov    0x8(%ebp),%eax
80104c8c:	83 ec 08             	sub    $0x8,%esp
80104c8f:	6a 00                	push   $0x0
80104c91:	50                   	push   %eax
80104c92:	e8 16 ff ff ff       	call   80104bad <xchg>
80104c97:	83 c4 10             	add    $0x10,%esp

  popcli();
80104c9a:	e8 ec 00 00 00       	call   80104d8b <popcli>
}
80104c9f:	90                   	nop
80104ca0:	c9                   	leave  
80104ca1:	c3                   	ret    

80104ca2 <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104ca2:	55                   	push   %ebp
80104ca3:	89 e5                	mov    %esp,%ebp
80104ca5:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
80104ca8:	8b 45 08             	mov    0x8(%ebp),%eax
80104cab:	83 e8 08             	sub    $0x8,%eax
80104cae:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80104cb1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80104cb8:	eb 38                	jmp    80104cf2 <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104cba:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80104cbe:	74 53                	je     80104d13 <getcallerpcs+0x71>
80104cc0:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80104cc7:	76 4a                	jbe    80104d13 <getcallerpcs+0x71>
80104cc9:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80104ccd:	74 44                	je     80104d13 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104ccf:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104cd2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cdc:	01 c2                	add    %eax,%edx
80104cde:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ce1:	8b 40 04             	mov    0x4(%eax),%eax
80104ce4:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80104ce6:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104ce9:	8b 00                	mov    (%eax),%eax
80104ceb:	89 45 fc             	mov    %eax,-0x4(%ebp)
{
  uint *ebp;
  int i;
  
  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104cee:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104cf2:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104cf6:	7e c2                	jle    80104cba <getcallerpcs+0x18>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104cf8:	eb 19                	jmp    80104d13 <getcallerpcs+0x71>
    pcs[i] = 0;
80104cfa:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104cfd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80104d04:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d07:	01 d0                	add    %edx,%eax
80104d09:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
80104d0f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
80104d13:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80104d17:	7e e1                	jle    80104cfa <getcallerpcs+0x58>
    pcs[i] = 0;
}
80104d19:	90                   	nop
80104d1a:	c9                   	leave  
80104d1b:	c3                   	ret    

80104d1c <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104d1c:	55                   	push   %ebp
80104d1d:	89 e5                	mov    %esp,%ebp
  return lock->locked && lock->cpu == cpu;
80104d1f:	8b 45 08             	mov    0x8(%ebp),%eax
80104d22:	8b 00                	mov    (%eax),%eax
80104d24:	85 c0                	test   %eax,%eax
80104d26:	74 17                	je     80104d3f <holding+0x23>
80104d28:	8b 45 08             	mov    0x8(%ebp),%eax
80104d2b:	8b 50 08             	mov    0x8(%eax),%edx
80104d2e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d34:	39 c2                	cmp    %eax,%edx
80104d36:	75 07                	jne    80104d3f <holding+0x23>
80104d38:	b8 01 00 00 00       	mov    $0x1,%eax
80104d3d:	eb 05                	jmp    80104d44 <holding+0x28>
80104d3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104d44:	5d                   	pop    %ebp
80104d45:	c3                   	ret    

80104d46 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104d46:	55                   	push   %ebp
80104d47:	89 e5                	mov    %esp,%ebp
80104d49:	83 ec 10             	sub    $0x10,%esp
  int eflags;
  
  eflags = readeflags();
80104d4c:	e8 3e fe ff ff       	call   80104b8f <readeflags>
80104d51:	89 45 fc             	mov    %eax,-0x4(%ebp)
  cli();
80104d54:	e8 46 fe ff ff       	call   80104b9f <cli>
  if(cpu->ncli++ == 0)
80104d59:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104d60:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104d66:	8d 48 01             	lea    0x1(%eax),%ecx
80104d69:	89 8a ac 00 00 00    	mov    %ecx,0xac(%edx)
80104d6f:	85 c0                	test   %eax,%eax
80104d71:	75 15                	jne    80104d88 <pushcli+0x42>
    cpu->intena = eflags & FL_IF;
80104d73:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104d79:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104d7c:	81 e2 00 02 00 00    	and    $0x200,%edx
80104d82:	89 90 b0 00 00 00    	mov    %edx,0xb0(%eax)
}
80104d88:	90                   	nop
80104d89:	c9                   	leave  
80104d8a:	c3                   	ret    

80104d8b <popcli>:

void
popcli(void)
{
80104d8b:	55                   	push   %ebp
80104d8c:	89 e5                	mov    %esp,%ebp
80104d8e:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
80104d91:	e8 f9 fd ff ff       	call   80104b8f <readeflags>
80104d96:	25 00 02 00 00       	and    $0x200,%eax
80104d9b:	85 c0                	test   %eax,%eax
80104d9d:	74 0d                	je     80104dac <popcli+0x21>
    panic("popcli - interruptible");
80104d9f:	83 ec 0c             	sub    $0xc,%esp
80104da2:	68 2d 85 10 80       	push   $0x8010852d
80104da7:	e8 ba b7 ff ff       	call   80100566 <panic>
  if(--cpu->ncli < 0)
80104dac:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104db2:	8b 90 ac 00 00 00    	mov    0xac(%eax),%edx
80104db8:	83 ea 01             	sub    $0x1,%edx
80104dbb:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
80104dc1:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104dc7:	85 c0                	test   %eax,%eax
80104dc9:	79 0d                	jns    80104dd8 <popcli+0x4d>
    panic("popcli");
80104dcb:	83 ec 0c             	sub    $0xc,%esp
80104dce:	68 44 85 10 80       	push   $0x80108544
80104dd3:	e8 8e b7 ff ff       	call   80100566 <panic>
  if(cpu->ncli == 0 && cpu->intena)
80104dd8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104dde:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104de4:	85 c0                	test   %eax,%eax
80104de6:	75 15                	jne    80104dfd <popcli+0x72>
80104de8:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104dee:	8b 80 b0 00 00 00    	mov    0xb0(%eax),%eax
80104df4:	85 c0                	test   %eax,%eax
80104df6:	74 05                	je     80104dfd <popcli+0x72>
    sti();
80104df8:	e8 a9 fd ff ff       	call   80104ba6 <sti>
}
80104dfd:	90                   	nop
80104dfe:	c9                   	leave  
80104dff:	c3                   	ret    

80104e00 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
80104e05:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e08:	8b 55 10             	mov    0x10(%ebp),%edx
80104e0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e0e:	89 cb                	mov    %ecx,%ebx
80104e10:	89 df                	mov    %ebx,%edi
80104e12:	89 d1                	mov    %edx,%ecx
80104e14:	fc                   	cld    
80104e15:	f3 aa                	rep stos %al,%es:(%edi)
80104e17:	89 ca                	mov    %ecx,%edx
80104e19:	89 fb                	mov    %edi,%ebx
80104e1b:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104e1e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104e21:	90                   	nop
80104e22:	5b                   	pop    %ebx
80104e23:	5f                   	pop    %edi
80104e24:	5d                   	pop    %ebp
80104e25:	c3                   	ret    

80104e26 <stosl>:

static inline void
stosl(void *addr, int data, int cnt)
{
80104e26:	55                   	push   %ebp
80104e27:	89 e5                	mov    %esp,%ebp
80104e29:	57                   	push   %edi
80104e2a:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80104e2b:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e2e:	8b 55 10             	mov    0x10(%ebp),%edx
80104e31:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e34:	89 cb                	mov    %ecx,%ebx
80104e36:	89 df                	mov    %ebx,%edi
80104e38:	89 d1                	mov    %edx,%ecx
80104e3a:	fc                   	cld    
80104e3b:	f3 ab                	rep stos %eax,%es:(%edi)
80104e3d:	89 ca                	mov    %ecx,%edx
80104e3f:	89 fb                	mov    %edi,%ebx
80104e41:	89 5d 08             	mov    %ebx,0x8(%ebp)
80104e44:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
80104e47:	90                   	nop
80104e48:	5b                   	pop    %ebx
80104e49:	5f                   	pop    %edi
80104e4a:	5d                   	pop    %ebp
80104e4b:	c3                   	ret    

80104e4c <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104e4c:	55                   	push   %ebp
80104e4d:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80104e4f:	8b 45 08             	mov    0x8(%ebp),%eax
80104e52:	83 e0 03             	and    $0x3,%eax
80104e55:	85 c0                	test   %eax,%eax
80104e57:	75 43                	jne    80104e9c <memset+0x50>
80104e59:	8b 45 10             	mov    0x10(%ebp),%eax
80104e5c:	83 e0 03             	and    $0x3,%eax
80104e5f:	85 c0                	test   %eax,%eax
80104e61:	75 39                	jne    80104e9c <memset+0x50>
    c &= 0xFF;
80104e63:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104e6a:	8b 45 10             	mov    0x10(%ebp),%eax
80104e6d:	c1 e8 02             	shr    $0x2,%eax
80104e70:	89 c1                	mov    %eax,%ecx
80104e72:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e75:	c1 e0 18             	shl    $0x18,%eax
80104e78:	89 c2                	mov    %eax,%edx
80104e7a:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e7d:	c1 e0 10             	shl    $0x10,%eax
80104e80:	09 c2                	or     %eax,%edx
80104e82:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e85:	c1 e0 08             	shl    $0x8,%eax
80104e88:	09 d0                	or     %edx,%eax
80104e8a:	0b 45 0c             	or     0xc(%ebp),%eax
80104e8d:	51                   	push   %ecx
80104e8e:	50                   	push   %eax
80104e8f:	ff 75 08             	pushl  0x8(%ebp)
80104e92:	e8 8f ff ff ff       	call   80104e26 <stosl>
80104e97:	83 c4 0c             	add    $0xc,%esp
80104e9a:	eb 12                	jmp    80104eae <memset+0x62>
  } else
    stosb(dst, c, n);
80104e9c:	8b 45 10             	mov    0x10(%ebp),%eax
80104e9f:	50                   	push   %eax
80104ea0:	ff 75 0c             	pushl  0xc(%ebp)
80104ea3:	ff 75 08             	pushl  0x8(%ebp)
80104ea6:	e8 55 ff ff ff       	call   80104e00 <stosb>
80104eab:	83 c4 0c             	add    $0xc,%esp
  return dst;
80104eae:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104eb1:	c9                   	leave  
80104eb2:	c3                   	ret    

80104eb3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104eb3:	55                   	push   %ebp
80104eb4:	89 e5                	mov    %esp,%ebp
80104eb6:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;
  
  s1 = v1;
80104eb9:	8b 45 08             	mov    0x8(%ebp),%eax
80104ebc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80104ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ec2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
80104ec5:	eb 30                	jmp    80104ef7 <memcmp+0x44>
    if(*s1 != *s2)
80104ec7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104eca:	0f b6 10             	movzbl (%eax),%edx
80104ecd:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ed0:	0f b6 00             	movzbl (%eax),%eax
80104ed3:	38 c2                	cmp    %al,%dl
80104ed5:	74 18                	je     80104eef <memcmp+0x3c>
      return *s1 - *s2;
80104ed7:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104eda:	0f b6 00             	movzbl (%eax),%eax
80104edd:	0f b6 d0             	movzbl %al,%edx
80104ee0:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104ee3:	0f b6 00             	movzbl (%eax),%eax
80104ee6:	0f b6 c0             	movzbl %al,%eax
80104ee9:	29 c2                	sub    %eax,%edx
80104eeb:	89 d0                	mov    %edx,%eax
80104eed:	eb 1a                	jmp    80104f09 <memcmp+0x56>
    s1++, s2++;
80104eef:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80104ef3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
{
  const uchar *s1, *s2;
  
  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104ef7:	8b 45 10             	mov    0x10(%ebp),%eax
80104efa:	8d 50 ff             	lea    -0x1(%eax),%edx
80104efd:	89 55 10             	mov    %edx,0x10(%ebp)
80104f00:	85 c0                	test   %eax,%eax
80104f02:	75 c3                	jne    80104ec7 <memcmp+0x14>
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
80104f04:	b8 00 00 00 00       	mov    $0x0,%eax
}
80104f09:	c9                   	leave  
80104f0a:	c3                   	ret    

80104f0b <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104f0b:	55                   	push   %ebp
80104f0c:	89 e5                	mov    %esp,%ebp
80104f0e:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80104f11:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f14:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80104f17:	8b 45 08             	mov    0x8(%ebp),%eax
80104f1a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80104f1d:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f20:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80104f23:	73 54                	jae    80104f79 <memmove+0x6e>
80104f25:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104f28:	8b 45 10             	mov    0x10(%ebp),%eax
80104f2b:	01 d0                	add    %edx,%eax
80104f2d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80104f30:	76 47                	jbe    80104f79 <memmove+0x6e>
    s += n;
80104f32:	8b 45 10             	mov    0x10(%ebp),%eax
80104f35:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80104f38:	8b 45 10             	mov    0x10(%ebp),%eax
80104f3b:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80104f3e:	eb 13                	jmp    80104f53 <memmove+0x48>
      *--d = *--s;
80104f40:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80104f44:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
80104f48:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104f4b:	0f b6 10             	movzbl (%eax),%edx
80104f4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f51:	88 10                	mov    %dl,(%eax)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
80104f53:	8b 45 10             	mov    0x10(%ebp),%eax
80104f56:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f59:	89 55 10             	mov    %edx,0x10(%ebp)
80104f5c:	85 c0                	test   %eax,%eax
80104f5e:	75 e0                	jne    80104f40 <memmove+0x35>
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104f60:	eb 24                	jmp    80104f86 <memmove+0x7b>
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
      *d++ = *s++;
80104f62:	8b 45 f8             	mov    -0x8(%ebp),%eax
80104f65:	8d 50 01             	lea    0x1(%eax),%edx
80104f68:	89 55 f8             	mov    %edx,-0x8(%ebp)
80104f6b:	8b 55 fc             	mov    -0x4(%ebp),%edx
80104f6e:	8d 4a 01             	lea    0x1(%edx),%ecx
80104f71:	89 4d fc             	mov    %ecx,-0x4(%ebp)
80104f74:	0f b6 12             	movzbl (%edx),%edx
80104f77:	88 10                	mov    %dl,(%eax)
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104f79:	8b 45 10             	mov    0x10(%ebp),%eax
80104f7c:	8d 50 ff             	lea    -0x1(%eax),%edx
80104f7f:	89 55 10             	mov    %edx,0x10(%ebp)
80104f82:	85 c0                	test   %eax,%eax
80104f84:	75 dc                	jne    80104f62 <memmove+0x57>
      *d++ = *s++;

  return dst;
80104f86:	8b 45 08             	mov    0x8(%ebp),%eax
}
80104f89:	c9                   	leave  
80104f8a:	c3                   	ret    

80104f8b <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104f8b:	55                   	push   %ebp
80104f8c:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80104f8e:	ff 75 10             	pushl  0x10(%ebp)
80104f91:	ff 75 0c             	pushl  0xc(%ebp)
80104f94:	ff 75 08             	pushl  0x8(%ebp)
80104f97:	e8 6f ff ff ff       	call   80104f0b <memmove>
80104f9c:	83 c4 0c             	add    $0xc,%esp
}
80104f9f:	c9                   	leave  
80104fa0:	c3                   	ret    

80104fa1 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104fa1:	55                   	push   %ebp
80104fa2:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
80104fa4:	eb 0c                	jmp    80104fb2 <strncmp+0x11>
    n--, p++, q++;
80104fa6:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80104faa:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80104fae:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104fb2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104fb6:	74 1a                	je     80104fd2 <strncmp+0x31>
80104fb8:	8b 45 08             	mov    0x8(%ebp),%eax
80104fbb:	0f b6 00             	movzbl (%eax),%eax
80104fbe:	84 c0                	test   %al,%al
80104fc0:	74 10                	je     80104fd2 <strncmp+0x31>
80104fc2:	8b 45 08             	mov    0x8(%ebp),%eax
80104fc5:	0f b6 10             	movzbl (%eax),%edx
80104fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
80104fcb:	0f b6 00             	movzbl (%eax),%eax
80104fce:	38 c2                	cmp    %al,%dl
80104fd0:	74 d4                	je     80104fa6 <strncmp+0x5>
    n--, p++, q++;
  if(n == 0)
80104fd2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80104fd6:	75 07                	jne    80104fdf <strncmp+0x3e>
    return 0;
80104fd8:	b8 00 00 00 00       	mov    $0x0,%eax
80104fdd:	eb 16                	jmp    80104ff5 <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80104fdf:	8b 45 08             	mov    0x8(%ebp),%eax
80104fe2:	0f b6 00             	movzbl (%eax),%eax
80104fe5:	0f b6 d0             	movzbl %al,%edx
80104fe8:	8b 45 0c             	mov    0xc(%ebp),%eax
80104feb:	0f b6 00             	movzbl (%eax),%eax
80104fee:	0f b6 c0             	movzbl %al,%eax
80104ff1:	29 c2                	sub    %eax,%edx
80104ff3:	89 d0                	mov    %edx,%eax
}
80104ff5:	5d                   	pop    %ebp
80104ff6:	c3                   	ret    

80104ff7 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104ff7:	55                   	push   %ebp
80104ff8:	89 e5                	mov    %esp,%ebp
80104ffa:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80104ffd:	8b 45 08             	mov    0x8(%ebp),%eax
80105000:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
80105003:	90                   	nop
80105004:	8b 45 10             	mov    0x10(%ebp),%eax
80105007:	8d 50 ff             	lea    -0x1(%eax),%edx
8010500a:	89 55 10             	mov    %edx,0x10(%ebp)
8010500d:	85 c0                	test   %eax,%eax
8010500f:	7e 2c                	jle    8010503d <strncpy+0x46>
80105011:	8b 45 08             	mov    0x8(%ebp),%eax
80105014:	8d 50 01             	lea    0x1(%eax),%edx
80105017:	89 55 08             	mov    %edx,0x8(%ebp)
8010501a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010501d:	8d 4a 01             	lea    0x1(%edx),%ecx
80105020:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105023:	0f b6 12             	movzbl (%edx),%edx
80105026:	88 10                	mov    %dl,(%eax)
80105028:	0f b6 00             	movzbl (%eax),%eax
8010502b:	84 c0                	test   %al,%al
8010502d:	75 d5                	jne    80105004 <strncpy+0xd>
    ;
  while(n-- > 0)
8010502f:	eb 0c                	jmp    8010503d <strncpy+0x46>
    *s++ = 0;
80105031:	8b 45 08             	mov    0x8(%ebp),%eax
80105034:	8d 50 01             	lea    0x1(%eax),%edx
80105037:	89 55 08             	mov    %edx,0x8(%ebp)
8010503a:	c6 00 00             	movb   $0x0,(%eax)
  char *os;
  
  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010503d:	8b 45 10             	mov    0x10(%ebp),%eax
80105040:	8d 50 ff             	lea    -0x1(%eax),%edx
80105043:	89 55 10             	mov    %edx,0x10(%ebp)
80105046:	85 c0                	test   %eax,%eax
80105048:	7f e7                	jg     80105031 <strncpy+0x3a>
    *s++ = 0;
  return os;
8010504a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
8010504d:	c9                   	leave  
8010504e:	c3                   	ret    

8010504f <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
8010504f:	55                   	push   %ebp
80105050:	89 e5                	mov    %esp,%ebp
80105052:	83 ec 10             	sub    $0x10,%esp
  char *os;
  
  os = s;
80105055:	8b 45 08             	mov    0x8(%ebp),%eax
80105058:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
8010505b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010505f:	7f 05                	jg     80105066 <safestrcpy+0x17>
    return os;
80105061:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105064:	eb 31                	jmp    80105097 <safestrcpy+0x48>
  while(--n > 0 && (*s++ = *t++) != 0)
80105066:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
8010506a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010506e:	7e 1e                	jle    8010508e <safestrcpy+0x3f>
80105070:	8b 45 08             	mov    0x8(%ebp),%eax
80105073:	8d 50 01             	lea    0x1(%eax),%edx
80105076:	89 55 08             	mov    %edx,0x8(%ebp)
80105079:	8b 55 0c             	mov    0xc(%ebp),%edx
8010507c:	8d 4a 01             	lea    0x1(%edx),%ecx
8010507f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
80105082:	0f b6 12             	movzbl (%edx),%edx
80105085:	88 10                	mov    %dl,(%eax)
80105087:	0f b6 00             	movzbl (%eax),%eax
8010508a:	84 c0                	test   %al,%al
8010508c:	75 d8                	jne    80105066 <safestrcpy+0x17>
    ;
  *s = 0;
8010508e:	8b 45 08             	mov    0x8(%ebp),%eax
80105091:	c6 00 00             	movb   $0x0,(%eax)
  return os;
80105094:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105097:	c9                   	leave  
80105098:	c3                   	ret    

80105099 <strlen>:

int
strlen(const char *s)
{
80105099:	55                   	push   %ebp
8010509a:	89 e5                	mov    %esp,%ebp
8010509c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
8010509f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801050a6:	eb 04                	jmp    801050ac <strlen+0x13>
801050a8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801050ac:	8b 55 fc             	mov    -0x4(%ebp),%edx
801050af:	8b 45 08             	mov    0x8(%ebp),%eax
801050b2:	01 d0                	add    %edx,%eax
801050b4:	0f b6 00             	movzbl (%eax),%eax
801050b7:	84 c0                	test   %al,%al
801050b9:	75 ed                	jne    801050a8 <strlen+0xf>
    ;
  return n;
801050bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801050be:	c9                   	leave  
801050bf:	c3                   	ret    

801050c0 <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
801050c0:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801050c4:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
801050c8:	55                   	push   %ebp
  pushl %ebx
801050c9:	53                   	push   %ebx
  pushl %esi
801050ca:	56                   	push   %esi
  pushl %edi
801050cb:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801050cc:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801050ce:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
801050d0:	5f                   	pop    %edi
  popl %esi
801050d1:	5e                   	pop    %esi
  popl %ebx
801050d2:	5b                   	pop    %ebx
  popl %ebp
801050d3:	5d                   	pop    %ebp
  ret
801050d4:	c3                   	ret    

801050d5 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801050d5:	55                   	push   %ebp
801050d6:	89 e5                	mov    %esp,%ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
801050d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050de:	8b 00                	mov    (%eax),%eax
801050e0:	3b 45 08             	cmp    0x8(%ebp),%eax
801050e3:	76 12                	jbe    801050f7 <fetchint+0x22>
801050e5:	8b 45 08             	mov    0x8(%ebp),%eax
801050e8:	8d 50 04             	lea    0x4(%eax),%edx
801050eb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801050f1:	8b 00                	mov    (%eax),%eax
801050f3:	39 c2                	cmp    %eax,%edx
801050f5:	76 07                	jbe    801050fe <fetchint+0x29>
    return -1;
801050f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050fc:	eb 0f                	jmp    8010510d <fetchint+0x38>
  *ip = *(int*)(addr);
801050fe:	8b 45 08             	mov    0x8(%ebp),%eax
80105101:	8b 10                	mov    (%eax),%edx
80105103:	8b 45 0c             	mov    0xc(%ebp),%eax
80105106:	89 10                	mov    %edx,(%eax)
  return 0;
80105108:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010510d:	5d                   	pop    %ebp
8010510e:	c3                   	ret    

8010510f <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010510f:	55                   	push   %ebp
80105110:	89 e5                	mov    %esp,%ebp
80105112:	83 ec 10             	sub    $0x10,%esp
  char *s, *ep;

  if(addr >= proc->sz)
80105115:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010511b:	8b 00                	mov    (%eax),%eax
8010511d:	3b 45 08             	cmp    0x8(%ebp),%eax
80105120:	77 07                	ja     80105129 <fetchstr+0x1a>
    return -1;
80105122:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105127:	eb 46                	jmp    8010516f <fetchstr+0x60>
  *pp = (char*)addr;
80105129:	8b 55 08             	mov    0x8(%ebp),%edx
8010512c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010512f:	89 10                	mov    %edx,(%eax)
  ep = (char*)proc->sz;
80105131:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105137:	8b 00                	mov    (%eax),%eax
80105139:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(s = *pp; s < ep; s++)
8010513c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010513f:	8b 00                	mov    (%eax),%eax
80105141:	89 45 fc             	mov    %eax,-0x4(%ebp)
80105144:	eb 1c                	jmp    80105162 <fetchstr+0x53>
    if(*s == 0)
80105146:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105149:	0f b6 00             	movzbl (%eax),%eax
8010514c:	84 c0                	test   %al,%al
8010514e:	75 0e                	jne    8010515e <fetchstr+0x4f>
      return s - *pp;
80105150:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105153:	8b 45 0c             	mov    0xc(%ebp),%eax
80105156:	8b 00                	mov    (%eax),%eax
80105158:	29 c2                	sub    %eax,%edx
8010515a:	89 d0                	mov    %edx,%eax
8010515c:	eb 11                	jmp    8010516f <fetchstr+0x60>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
8010515e:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105162:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105165:	3b 45 f8             	cmp    -0x8(%ebp),%eax
80105168:	72 dc                	jb     80105146 <fetchstr+0x37>
    if(*s == 0)
      return s - *pp;
  return -1;
8010516a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010516f:	c9                   	leave  
80105170:	c3                   	ret    

80105171 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105171:	55                   	push   %ebp
80105172:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80105174:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010517a:	8b 40 18             	mov    0x18(%eax),%eax
8010517d:	8b 40 44             	mov    0x44(%eax),%eax
80105180:	8b 55 08             	mov    0x8(%ebp),%edx
80105183:	c1 e2 02             	shl    $0x2,%edx
80105186:	01 d0                	add    %edx,%eax
80105188:	83 c0 04             	add    $0x4,%eax
8010518b:	ff 75 0c             	pushl  0xc(%ebp)
8010518e:	50                   	push   %eax
8010518f:	e8 41 ff ff ff       	call   801050d5 <fetchint>
80105194:	83 c4 08             	add    $0x8,%esp
}
80105197:	c9                   	leave  
80105198:	c3                   	ret    

80105199 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105199:	55                   	push   %ebp
8010519a:	89 e5                	mov    %esp,%ebp
8010519c:	83 ec 10             	sub    $0x10,%esp
  int i;

  if(argint(n, &i) < 0)
8010519f:	8d 45 fc             	lea    -0x4(%ebp),%eax
801051a2:	50                   	push   %eax
801051a3:	ff 75 08             	pushl  0x8(%ebp)
801051a6:	e8 c6 ff ff ff       	call   80105171 <argint>
801051ab:	83 c4 08             	add    $0x8,%esp
801051ae:	85 c0                	test   %eax,%eax
801051b0:	79 07                	jns    801051b9 <argptr+0x20>
    return -1;
801051b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051b7:	eb 3b                	jmp    801051f4 <argptr+0x5b>
  if((uint)i >= proc->sz || (uint)i+size > proc->sz)
801051b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051bf:	8b 00                	mov    (%eax),%eax
801051c1:	8b 55 fc             	mov    -0x4(%ebp),%edx
801051c4:	39 d0                	cmp    %edx,%eax
801051c6:	76 16                	jbe    801051de <argptr+0x45>
801051c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051cb:	89 c2                	mov    %eax,%edx
801051cd:	8b 45 10             	mov    0x10(%ebp),%eax
801051d0:	01 c2                	add    %eax,%edx
801051d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801051d8:	8b 00                	mov    (%eax),%eax
801051da:	39 c2                	cmp    %eax,%edx
801051dc:	76 07                	jbe    801051e5 <argptr+0x4c>
    return -1;
801051de:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051e3:	eb 0f                	jmp    801051f4 <argptr+0x5b>
  *pp = (char*)i;
801051e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
801051e8:	89 c2                	mov    %eax,%edx
801051ea:	8b 45 0c             	mov    0xc(%ebp),%eax
801051ed:	89 10                	mov    %edx,(%eax)
  return 0;
801051ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
801051f4:	c9                   	leave  
801051f5:	c3                   	ret    

801051f6 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801051f6:	55                   	push   %ebp
801051f7:	89 e5                	mov    %esp,%ebp
801051f9:	83 ec 10             	sub    $0x10,%esp
  int addr;
  if(argint(n, &addr) < 0)
801051fc:	8d 45 fc             	lea    -0x4(%ebp),%eax
801051ff:	50                   	push   %eax
80105200:	ff 75 08             	pushl  0x8(%ebp)
80105203:	e8 69 ff ff ff       	call   80105171 <argint>
80105208:	83 c4 08             	add    $0x8,%esp
8010520b:	85 c0                	test   %eax,%eax
8010520d:	79 07                	jns    80105216 <argstr+0x20>
    return -1;
8010520f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105214:	eb 0f                	jmp    80105225 <argstr+0x2f>
  return fetchstr(addr, pp);
80105216:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105219:	ff 75 0c             	pushl  0xc(%ebp)
8010521c:	50                   	push   %eax
8010521d:	e8 ed fe ff ff       	call   8010510f <fetchstr>
80105222:	83 c4 08             	add    $0x8,%esp
}
80105225:	c9                   	leave  
80105226:	c3                   	ret    

80105227 <syscall>:
[SYS_uniformR]   sys_uniformR,
};

void
syscall(void)
{
80105227:	55                   	push   %ebp
80105228:	89 e5                	mov    %esp,%ebp
8010522a:	53                   	push   %ebx
8010522b:	83 ec 14             	sub    $0x14,%esp
  int num;

  num = proc->tf->eax;
8010522e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105234:	8b 40 18             	mov    0x18(%eax),%eax
80105237:	8b 40 1c             	mov    0x1c(%eax),%eax
8010523a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
8010523d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105241:	7e 30                	jle    80105273 <syscall+0x4c>
80105243:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105246:	83 f8 18             	cmp    $0x18,%eax
80105249:	77 28                	ja     80105273 <syscall+0x4c>
8010524b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010524e:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
80105255:	85 c0                	test   %eax,%eax
80105257:	74 1a                	je     80105273 <syscall+0x4c>
    proc->tf->eax = syscalls[num]();
80105259:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010525f:	8b 58 18             	mov    0x18(%eax),%ebx
80105262:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105265:	8b 04 85 40 b0 10 80 	mov    -0x7fef4fc0(,%eax,4),%eax
8010526c:	ff d0                	call   *%eax
8010526e:	89 43 1c             	mov    %eax,0x1c(%ebx)
80105271:	eb 34                	jmp    801052a7 <syscall+0x80>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
80105273:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105279:	8d 50 6c             	lea    0x6c(%eax),%edx
8010527c:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  num = proc->tf->eax;
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    proc->tf->eax = syscalls[num]();
  } else {
    cprintf("%d %s: unknown sys call %d\n",
80105282:	8b 40 10             	mov    0x10(%eax),%eax
80105285:	ff 75 f4             	pushl  -0xc(%ebp)
80105288:	52                   	push   %edx
80105289:	50                   	push   %eax
8010528a:	68 4b 85 10 80       	push   $0x8010854b
8010528f:	e8 32 b1 ff ff       	call   801003c6 <cprintf>
80105294:	83 c4 10             	add    $0x10,%esp
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
80105297:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010529d:	8b 40 18             	mov    0x18(%eax),%eax
801052a0:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801052a7:	90                   	nop
801052a8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801052ab:	c9                   	leave  
801052ac:	c3                   	ret    

801052ad <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
801052ad:	55                   	push   %ebp
801052ae:	89 e5                	mov    %esp,%ebp
801052b0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
801052b3:	83 ec 08             	sub    $0x8,%esp
801052b6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801052b9:	50                   	push   %eax
801052ba:	ff 75 08             	pushl  0x8(%ebp)
801052bd:	e8 af fe ff ff       	call   80105171 <argint>
801052c2:	83 c4 10             	add    $0x10,%esp
801052c5:	85 c0                	test   %eax,%eax
801052c7:	79 07                	jns    801052d0 <argfd+0x23>
    return -1;
801052c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052ce:	eb 50                	jmp    80105320 <argfd+0x73>
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
801052d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052d3:	85 c0                	test   %eax,%eax
801052d5:	78 21                	js     801052f8 <argfd+0x4b>
801052d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801052da:	83 f8 0f             	cmp    $0xf,%eax
801052dd:	7f 19                	jg     801052f8 <argfd+0x4b>
801052df:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801052e5:	8b 55 f0             	mov    -0x10(%ebp),%edx
801052e8:	83 c2 08             	add    $0x8,%edx
801052eb:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801052ef:	89 45 f4             	mov    %eax,-0xc(%ebp)
801052f2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801052f6:	75 07                	jne    801052ff <argfd+0x52>
    return -1;
801052f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801052fd:	eb 21                	jmp    80105320 <argfd+0x73>
  if(pfd)
801052ff:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105303:	74 08                	je     8010530d <argfd+0x60>
    *pfd = fd;
80105305:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105308:	8b 45 0c             	mov    0xc(%ebp),%eax
8010530b:	89 10                	mov    %edx,(%eax)
  if(pf)
8010530d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80105311:	74 08                	je     8010531b <argfd+0x6e>
    *pf = f;
80105313:	8b 45 10             	mov    0x10(%ebp),%eax
80105316:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105319:	89 10                	mov    %edx,(%eax)
  return 0;
8010531b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105320:	c9                   	leave  
80105321:	c3                   	ret    

80105322 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
80105322:	55                   	push   %ebp
80105323:	89 e5                	mov    %esp,%ebp
80105325:	83 ec 10             	sub    $0x10,%esp
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105328:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010532f:	eb 30                	jmp    80105361 <fdalloc+0x3f>
    if(proc->ofile[fd] == 0){
80105331:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105337:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010533a:	83 c2 08             	add    $0x8,%edx
8010533d:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80105341:	85 c0                	test   %eax,%eax
80105343:	75 18                	jne    8010535d <fdalloc+0x3b>
      proc->ofile[fd] = f;
80105345:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010534b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010534e:	8d 4a 08             	lea    0x8(%edx),%ecx
80105351:	8b 55 08             	mov    0x8(%ebp),%edx
80105354:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
80105358:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010535b:	eb 0f                	jmp    8010536c <fdalloc+0x4a>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010535d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80105361:	83 7d fc 0f          	cmpl   $0xf,-0x4(%ebp)
80105365:	7e ca                	jle    80105331 <fdalloc+0xf>
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
80105367:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010536c:	c9                   	leave  
8010536d:	c3                   	ret    

8010536e <sys_dup>:

int
sys_dup(void)
{
8010536e:	55                   	push   %ebp
8010536f:	89 e5                	mov    %esp,%ebp
80105371:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;
  
  if(argfd(0, 0, &f) < 0)
80105374:	83 ec 04             	sub    $0x4,%esp
80105377:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010537a:	50                   	push   %eax
8010537b:	6a 00                	push   $0x0
8010537d:	6a 00                	push   $0x0
8010537f:	e8 29 ff ff ff       	call   801052ad <argfd>
80105384:	83 c4 10             	add    $0x10,%esp
80105387:	85 c0                	test   %eax,%eax
80105389:	79 07                	jns    80105392 <sys_dup+0x24>
    return -1;
8010538b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105390:	eb 31                	jmp    801053c3 <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
80105392:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105395:	83 ec 0c             	sub    $0xc,%esp
80105398:	50                   	push   %eax
80105399:	e8 84 ff ff ff       	call   80105322 <fdalloc>
8010539e:	83 c4 10             	add    $0x10,%esp
801053a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801053a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801053a8:	79 07                	jns    801053b1 <sys_dup+0x43>
    return -1;
801053aa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053af:	eb 12                	jmp    801053c3 <sys_dup+0x55>
  filedup(f);
801053b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801053b4:	83 ec 0c             	sub    $0xc,%esp
801053b7:	50                   	push   %eax
801053b8:	e8 14 bc ff ff       	call   80100fd1 <filedup>
801053bd:	83 c4 10             	add    $0x10,%esp
  return fd;
801053c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801053c3:	c9                   	leave  
801053c4:	c3                   	ret    

801053c5 <sys_read>:

int
sys_read(void)
{
801053c5:	55                   	push   %ebp
801053c6:	89 e5                	mov    %esp,%ebp
801053c8:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801053cb:	83 ec 04             	sub    $0x4,%esp
801053ce:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053d1:	50                   	push   %eax
801053d2:	6a 00                	push   $0x0
801053d4:	6a 00                	push   $0x0
801053d6:	e8 d2 fe ff ff       	call   801052ad <argfd>
801053db:	83 c4 10             	add    $0x10,%esp
801053de:	85 c0                	test   %eax,%eax
801053e0:	78 2e                	js     80105410 <sys_read+0x4b>
801053e2:	83 ec 08             	sub    $0x8,%esp
801053e5:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053e8:	50                   	push   %eax
801053e9:	6a 02                	push   $0x2
801053eb:	e8 81 fd ff ff       	call   80105171 <argint>
801053f0:	83 c4 10             	add    $0x10,%esp
801053f3:	85 c0                	test   %eax,%eax
801053f5:	78 19                	js     80105410 <sys_read+0x4b>
801053f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801053fa:	83 ec 04             	sub    $0x4,%esp
801053fd:	50                   	push   %eax
801053fe:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105401:	50                   	push   %eax
80105402:	6a 01                	push   $0x1
80105404:	e8 90 fd ff ff       	call   80105199 <argptr>
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	85 c0                	test   %eax,%eax
8010540e:	79 07                	jns    80105417 <sys_read+0x52>
    return -1;
80105410:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105415:	eb 17                	jmp    8010542e <sys_read+0x69>
  return fileread(f, p, n);
80105417:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010541a:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010541d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105420:	83 ec 04             	sub    $0x4,%esp
80105423:	51                   	push   %ecx
80105424:	52                   	push   %edx
80105425:	50                   	push   %eax
80105426:	e8 36 bd ff ff       	call   80101161 <fileread>
8010542b:	83 c4 10             	add    $0x10,%esp
}
8010542e:	c9                   	leave  
8010542f:	c3                   	ret    

80105430 <sys_write>:

int
sys_write(void)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105436:	83 ec 04             	sub    $0x4,%esp
80105439:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010543c:	50                   	push   %eax
8010543d:	6a 00                	push   $0x0
8010543f:	6a 00                	push   $0x0
80105441:	e8 67 fe ff ff       	call   801052ad <argfd>
80105446:	83 c4 10             	add    $0x10,%esp
80105449:	85 c0                	test   %eax,%eax
8010544b:	78 2e                	js     8010547b <sys_write+0x4b>
8010544d:	83 ec 08             	sub    $0x8,%esp
80105450:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105453:	50                   	push   %eax
80105454:	6a 02                	push   $0x2
80105456:	e8 16 fd ff ff       	call   80105171 <argint>
8010545b:	83 c4 10             	add    $0x10,%esp
8010545e:	85 c0                	test   %eax,%eax
80105460:	78 19                	js     8010547b <sys_write+0x4b>
80105462:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105465:	83 ec 04             	sub    $0x4,%esp
80105468:	50                   	push   %eax
80105469:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010546c:	50                   	push   %eax
8010546d:	6a 01                	push   $0x1
8010546f:	e8 25 fd ff ff       	call   80105199 <argptr>
80105474:	83 c4 10             	add    $0x10,%esp
80105477:	85 c0                	test   %eax,%eax
80105479:	79 07                	jns    80105482 <sys_write+0x52>
    return -1;
8010547b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105480:	eb 17                	jmp    80105499 <sys_write+0x69>
  return filewrite(f, p, n);
80105482:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105485:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105488:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010548b:	83 ec 04             	sub    $0x4,%esp
8010548e:	51                   	push   %ecx
8010548f:	52                   	push   %edx
80105490:	50                   	push   %eax
80105491:	e8 83 bd ff ff       	call   80101219 <filewrite>
80105496:	83 c4 10             	add    $0x10,%esp
}
80105499:	c9                   	leave  
8010549a:	c3                   	ret    

8010549b <sys_close>:

int
sys_close(void)
{
8010549b:	55                   	push   %ebp
8010549c:	89 e5                	mov    %esp,%ebp
8010549e:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;
  
  if(argfd(0, &fd, &f) < 0)
801054a1:	83 ec 04             	sub    $0x4,%esp
801054a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801054a7:	50                   	push   %eax
801054a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ab:	50                   	push   %eax
801054ac:	6a 00                	push   $0x0
801054ae:	e8 fa fd ff ff       	call   801052ad <argfd>
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	85 c0                	test   %eax,%eax
801054b8:	79 07                	jns    801054c1 <sys_close+0x26>
    return -1;
801054ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054bf:	eb 28                	jmp    801054e9 <sys_close+0x4e>
  proc->ofile[fd] = 0;
801054c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801054c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054ca:	83 c2 08             	add    $0x8,%edx
801054cd:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801054d4:	00 
  fileclose(f);
801054d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801054d8:	83 ec 0c             	sub    $0xc,%esp
801054db:	50                   	push   %eax
801054dc:	e8 41 bb ff ff       	call   80101022 <fileclose>
801054e1:	83 c4 10             	add    $0x10,%esp
  return 0;
801054e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
801054e9:	c9                   	leave  
801054ea:	c3                   	ret    

801054eb <sys_fstat>:

int
sys_fstat(void)
{
801054eb:	55                   	push   %ebp
801054ec:	89 e5                	mov    %esp,%ebp
801054ee:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;
  
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801054f1:	83 ec 04             	sub    $0x4,%esp
801054f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054f7:	50                   	push   %eax
801054f8:	6a 00                	push   $0x0
801054fa:	6a 00                	push   $0x0
801054fc:	e8 ac fd ff ff       	call   801052ad <argfd>
80105501:	83 c4 10             	add    $0x10,%esp
80105504:	85 c0                	test   %eax,%eax
80105506:	78 17                	js     8010551f <sys_fstat+0x34>
80105508:	83 ec 04             	sub    $0x4,%esp
8010550b:	6a 14                	push   $0x14
8010550d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105510:	50                   	push   %eax
80105511:	6a 01                	push   $0x1
80105513:	e8 81 fc ff ff       	call   80105199 <argptr>
80105518:	83 c4 10             	add    $0x10,%esp
8010551b:	85 c0                	test   %eax,%eax
8010551d:	79 07                	jns    80105526 <sys_fstat+0x3b>
    return -1;
8010551f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105524:	eb 13                	jmp    80105539 <sys_fstat+0x4e>
  return filestat(f, st);
80105526:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105529:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010552c:	83 ec 08             	sub    $0x8,%esp
8010552f:	52                   	push   %edx
80105530:	50                   	push   %eax
80105531:	e8 d4 bb ff ff       	call   8010110a <filestat>
80105536:	83 c4 10             	add    $0x10,%esp
}
80105539:	c9                   	leave  
8010553a:	c3                   	ret    

8010553b <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
8010553b:	55                   	push   %ebp
8010553c:	89 e5                	mov    %esp,%ebp
8010553e:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105541:	83 ec 08             	sub    $0x8,%esp
80105544:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105547:	50                   	push   %eax
80105548:	6a 00                	push   $0x0
8010554a:	e8 a7 fc ff ff       	call   801051f6 <argstr>
8010554f:	83 c4 10             	add    $0x10,%esp
80105552:	85 c0                	test   %eax,%eax
80105554:	78 15                	js     8010556b <sys_link+0x30>
80105556:	83 ec 08             	sub    $0x8,%esp
80105559:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010555c:	50                   	push   %eax
8010555d:	6a 01                	push   $0x1
8010555f:	e8 92 fc ff ff       	call   801051f6 <argstr>
80105564:	83 c4 10             	add    $0x10,%esp
80105567:	85 c0                	test   %eax,%eax
80105569:	79 0a                	jns    80105575 <sys_link+0x3a>
    return -1;
8010556b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105570:	e9 63 01 00 00       	jmp    801056d8 <sys_link+0x19d>
  if((ip = namei(old)) == 0)
80105575:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105578:	83 ec 0c             	sub    $0xc,%esp
8010557b:	50                   	push   %eax
8010557c:	e8 2e cf ff ff       	call   801024af <namei>
80105581:	83 c4 10             	add    $0x10,%esp
80105584:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105587:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010558b:	75 0a                	jne    80105597 <sys_link+0x5c>
    return -1;
8010558d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105592:	e9 41 01 00 00       	jmp    801056d8 <sys_link+0x19d>

  begin_trans();
80105597:	e8 df dc ff ff       	call   8010327b <begin_trans>

  ilock(ip);
8010559c:	83 ec 0c             	sub    $0xc,%esp
8010559f:	ff 75 f4             	pushl  -0xc(%ebp)
801055a2:	e8 50 c3 ff ff       	call   801018f7 <ilock>
801055a7:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
801055aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055ad:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801055b1:	66 83 f8 01          	cmp    $0x1,%ax
801055b5:	75 1d                	jne    801055d4 <sys_link+0x99>
    iunlockput(ip);
801055b7:	83 ec 0c             	sub    $0xc,%esp
801055ba:	ff 75 f4             	pushl  -0xc(%ebp)
801055bd:	e8 ef c5 ff ff       	call   80101bb1 <iunlockput>
801055c2:	83 c4 10             	add    $0x10,%esp
    commit_trans();
801055c5:	e8 04 dd ff ff       	call   801032ce <commit_trans>
    return -1;
801055ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055cf:	e9 04 01 00 00       	jmp    801056d8 <sys_link+0x19d>
  }

  ip->nlink++;
801055d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055d7:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801055db:	83 c0 01             	add    $0x1,%eax
801055de:	89 c2                	mov    %eax,%edx
801055e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055e3:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801055e7:	83 ec 0c             	sub    $0xc,%esp
801055ea:	ff 75 f4             	pushl  -0xc(%ebp)
801055ed:	e8 31 c1 ff ff       	call   80101723 <iupdate>
801055f2:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
801055f5:	83 ec 0c             	sub    $0xc,%esp
801055f8:	ff 75 f4             	pushl  -0xc(%ebp)
801055fb:	e8 4f c4 ff ff       	call   80101a4f <iunlock>
80105600:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80105603:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105606:	83 ec 08             	sub    $0x8,%esp
80105609:	8d 55 e2             	lea    -0x1e(%ebp),%edx
8010560c:	52                   	push   %edx
8010560d:	50                   	push   %eax
8010560e:	e8 b8 ce ff ff       	call   801024cb <nameiparent>
80105613:	83 c4 10             	add    $0x10,%esp
80105616:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105619:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010561d:	74 71                	je     80105690 <sys_link+0x155>
    goto bad;
  ilock(dp);
8010561f:	83 ec 0c             	sub    $0xc,%esp
80105622:	ff 75 f0             	pushl  -0x10(%ebp)
80105625:	e8 cd c2 ff ff       	call   801018f7 <ilock>
8010562a:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
8010562d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105630:	8b 10                	mov    (%eax),%edx
80105632:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105635:	8b 00                	mov    (%eax),%eax
80105637:	39 c2                	cmp    %eax,%edx
80105639:	75 1d                	jne    80105658 <sys_link+0x11d>
8010563b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010563e:	8b 40 04             	mov    0x4(%eax),%eax
80105641:	83 ec 04             	sub    $0x4,%esp
80105644:	50                   	push   %eax
80105645:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80105648:	50                   	push   %eax
80105649:	ff 75 f0             	pushl  -0x10(%ebp)
8010564c:	e8 c2 cb ff ff       	call   80102213 <dirlink>
80105651:	83 c4 10             	add    $0x10,%esp
80105654:	85 c0                	test   %eax,%eax
80105656:	79 10                	jns    80105668 <sys_link+0x12d>
    iunlockput(dp);
80105658:	83 ec 0c             	sub    $0xc,%esp
8010565b:	ff 75 f0             	pushl  -0x10(%ebp)
8010565e:	e8 4e c5 ff ff       	call   80101bb1 <iunlockput>
80105663:	83 c4 10             	add    $0x10,%esp
    goto bad;
80105666:	eb 29                	jmp    80105691 <sys_link+0x156>
  }
  iunlockput(dp);
80105668:	83 ec 0c             	sub    $0xc,%esp
8010566b:	ff 75 f0             	pushl  -0x10(%ebp)
8010566e:	e8 3e c5 ff ff       	call   80101bb1 <iunlockput>
80105673:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80105676:	83 ec 0c             	sub    $0xc,%esp
80105679:	ff 75 f4             	pushl  -0xc(%ebp)
8010567c:	e8 40 c4 ff ff       	call   80101ac1 <iput>
80105681:	83 c4 10             	add    $0x10,%esp

  commit_trans();
80105684:	e8 45 dc ff ff       	call   801032ce <commit_trans>

  return 0;
80105689:	b8 00 00 00 00       	mov    $0x0,%eax
8010568e:	eb 48                	jmp    801056d8 <sys_link+0x19d>
  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
80105690:	90                   	nop
  commit_trans();

  return 0;

bad:
  ilock(ip);
80105691:	83 ec 0c             	sub    $0xc,%esp
80105694:	ff 75 f4             	pushl  -0xc(%ebp)
80105697:	e8 5b c2 ff ff       	call   801018f7 <ilock>
8010569c:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
8010569f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056a2:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801056a6:	83 e8 01             	sub    $0x1,%eax
801056a9:	89 c2                	mov    %eax,%edx
801056ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056ae:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801056b2:	83 ec 0c             	sub    $0xc,%esp
801056b5:	ff 75 f4             	pushl  -0xc(%ebp)
801056b8:	e8 66 c0 ff ff       	call   80101723 <iupdate>
801056bd:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
801056c0:	83 ec 0c             	sub    $0xc,%esp
801056c3:	ff 75 f4             	pushl  -0xc(%ebp)
801056c6:	e8 e6 c4 ff ff       	call   80101bb1 <iunlockput>
801056cb:	83 c4 10             	add    $0x10,%esp
  commit_trans();
801056ce:	e8 fb db ff ff       	call   801032ce <commit_trans>
  return -1;
801056d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056d8:	c9                   	leave  
801056d9:	c3                   	ret    

801056da <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
801056da:	55                   	push   %ebp
801056db:	89 e5                	mov    %esp,%ebp
801056dd:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801056e0:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
801056e7:	eb 40                	jmp    80105729 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801056e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056ec:	6a 10                	push   $0x10
801056ee:	50                   	push   %eax
801056ef:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801056f2:	50                   	push   %eax
801056f3:	ff 75 08             	pushl  0x8(%ebp)
801056f6:	e8 64 c7 ff ff       	call   80101e5f <readi>
801056fb:	83 c4 10             	add    $0x10,%esp
801056fe:	83 f8 10             	cmp    $0x10,%eax
80105701:	74 0d                	je     80105710 <isdirempty+0x36>
      panic("isdirempty: readi");
80105703:	83 ec 0c             	sub    $0xc,%esp
80105706:	68 67 85 10 80       	push   $0x80108567
8010570b:	e8 56 ae ff ff       	call   80100566 <panic>
    if(de.inum != 0)
80105710:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80105714:	66 85 c0             	test   %ax,%ax
80105717:	74 07                	je     80105720 <isdirempty+0x46>
      return 0;
80105719:	b8 00 00 00 00       	mov    $0x0,%eax
8010571e:	eb 1b                	jmp    8010573b <isdirempty+0x61>
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105720:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105723:	83 c0 10             	add    $0x10,%eax
80105726:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105729:	8b 45 08             	mov    0x8(%ebp),%eax
8010572c:	8b 50 18             	mov    0x18(%eax),%edx
8010572f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105732:	39 c2                	cmp    %eax,%edx
80105734:	77 b3                	ja     801056e9 <isdirempty+0xf>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
80105736:	b8 01 00 00 00       	mov    $0x1,%eax
}
8010573b:	c9                   	leave  
8010573c:	c3                   	ret    

8010573d <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
8010573d:	55                   	push   %ebp
8010573e:	89 e5                	mov    %esp,%ebp
80105740:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80105743:	83 ec 08             	sub    $0x8,%esp
80105746:	8d 45 cc             	lea    -0x34(%ebp),%eax
80105749:	50                   	push   %eax
8010574a:	6a 00                	push   $0x0
8010574c:	e8 a5 fa ff ff       	call   801051f6 <argstr>
80105751:	83 c4 10             	add    $0x10,%esp
80105754:	85 c0                	test   %eax,%eax
80105756:	79 0a                	jns    80105762 <sys_unlink+0x25>
    return -1;
80105758:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010575d:	e9 b7 01 00 00       	jmp    80105919 <sys_unlink+0x1dc>
  if((dp = nameiparent(path, name)) == 0)
80105762:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105765:	83 ec 08             	sub    $0x8,%esp
80105768:	8d 55 d2             	lea    -0x2e(%ebp),%edx
8010576b:	52                   	push   %edx
8010576c:	50                   	push   %eax
8010576d:	e8 59 cd ff ff       	call   801024cb <nameiparent>
80105772:	83 c4 10             	add    $0x10,%esp
80105775:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105778:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010577c:	75 0a                	jne    80105788 <sys_unlink+0x4b>
    return -1;
8010577e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105783:	e9 91 01 00 00       	jmp    80105919 <sys_unlink+0x1dc>

  begin_trans();
80105788:	e8 ee da ff ff       	call   8010327b <begin_trans>

  ilock(dp);
8010578d:	83 ec 0c             	sub    $0xc,%esp
80105790:	ff 75 f4             	pushl  -0xc(%ebp)
80105793:	e8 5f c1 ff ff       	call   801018f7 <ilock>
80105798:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010579b:	83 ec 08             	sub    $0x8,%esp
8010579e:	68 79 85 10 80       	push   $0x80108579
801057a3:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801057a6:	50                   	push   %eax
801057a7:	e8 92 c9 ff ff       	call   8010213e <namecmp>
801057ac:	83 c4 10             	add    $0x10,%esp
801057af:	85 c0                	test   %eax,%eax
801057b1:	0f 84 4a 01 00 00    	je     80105901 <sys_unlink+0x1c4>
801057b7:	83 ec 08             	sub    $0x8,%esp
801057ba:	68 7b 85 10 80       	push   $0x8010857b
801057bf:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801057c2:	50                   	push   %eax
801057c3:	e8 76 c9 ff ff       	call   8010213e <namecmp>
801057c8:	83 c4 10             	add    $0x10,%esp
801057cb:	85 c0                	test   %eax,%eax
801057cd:	0f 84 2e 01 00 00    	je     80105901 <sys_unlink+0x1c4>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
801057d3:	83 ec 04             	sub    $0x4,%esp
801057d6:	8d 45 c8             	lea    -0x38(%ebp),%eax
801057d9:	50                   	push   %eax
801057da:	8d 45 d2             	lea    -0x2e(%ebp),%eax
801057dd:	50                   	push   %eax
801057de:	ff 75 f4             	pushl  -0xc(%ebp)
801057e1:	e8 73 c9 ff ff       	call   80102159 <dirlookup>
801057e6:	83 c4 10             	add    $0x10,%esp
801057e9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801057ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801057f0:	0f 84 0a 01 00 00    	je     80105900 <sys_unlink+0x1c3>
    goto bad;
  ilock(ip);
801057f6:	83 ec 0c             	sub    $0xc,%esp
801057f9:	ff 75 f0             	pushl  -0x10(%ebp)
801057fc:	e8 f6 c0 ff ff       	call   801018f7 <ilock>
80105801:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80105804:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105807:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010580b:	66 85 c0             	test   %ax,%ax
8010580e:	7f 0d                	jg     8010581d <sys_unlink+0xe0>
    panic("unlink: nlink < 1");
80105810:	83 ec 0c             	sub    $0xc,%esp
80105813:	68 7e 85 10 80       	push   $0x8010857e
80105818:	e8 49 ad ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010581d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105820:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105824:	66 83 f8 01          	cmp    $0x1,%ax
80105828:	75 25                	jne    8010584f <sys_unlink+0x112>
8010582a:	83 ec 0c             	sub    $0xc,%esp
8010582d:	ff 75 f0             	pushl  -0x10(%ebp)
80105830:	e8 a5 fe ff ff       	call   801056da <isdirempty>
80105835:	83 c4 10             	add    $0x10,%esp
80105838:	85 c0                	test   %eax,%eax
8010583a:	75 13                	jne    8010584f <sys_unlink+0x112>
    iunlockput(ip);
8010583c:	83 ec 0c             	sub    $0xc,%esp
8010583f:	ff 75 f0             	pushl  -0x10(%ebp)
80105842:	e8 6a c3 ff ff       	call   80101bb1 <iunlockput>
80105847:	83 c4 10             	add    $0x10,%esp
    goto bad;
8010584a:	e9 b2 00 00 00       	jmp    80105901 <sys_unlink+0x1c4>
  }

  memset(&de, 0, sizeof(de));
8010584f:	83 ec 04             	sub    $0x4,%esp
80105852:	6a 10                	push   $0x10
80105854:	6a 00                	push   $0x0
80105856:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105859:	50                   	push   %eax
8010585a:	e8 ed f5 ff ff       	call   80104e4c <memset>
8010585f:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105862:	8b 45 c8             	mov    -0x38(%ebp),%eax
80105865:	6a 10                	push   $0x10
80105867:	50                   	push   %eax
80105868:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010586b:	50                   	push   %eax
8010586c:	ff 75 f4             	pushl  -0xc(%ebp)
8010586f:	e8 42 c7 ff ff       	call   80101fb6 <writei>
80105874:	83 c4 10             	add    $0x10,%esp
80105877:	83 f8 10             	cmp    $0x10,%eax
8010587a:	74 0d                	je     80105889 <sys_unlink+0x14c>
    panic("unlink: writei");
8010587c:	83 ec 0c             	sub    $0xc,%esp
8010587f:	68 90 85 10 80       	push   $0x80108590
80105884:	e8 dd ac ff ff       	call   80100566 <panic>
  if(ip->type == T_DIR){
80105889:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010588c:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105890:	66 83 f8 01          	cmp    $0x1,%ax
80105894:	75 21                	jne    801058b7 <sys_unlink+0x17a>
    dp->nlink--;
80105896:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105899:	0f b7 40 16          	movzwl 0x16(%eax),%eax
8010589d:	83 e8 01             	sub    $0x1,%eax
801058a0:	89 c2                	mov    %eax,%edx
801058a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801058a5:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
801058a9:	83 ec 0c             	sub    $0xc,%esp
801058ac:	ff 75 f4             	pushl  -0xc(%ebp)
801058af:	e8 6f be ff ff       	call   80101723 <iupdate>
801058b4:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
801058b7:	83 ec 0c             	sub    $0xc,%esp
801058ba:	ff 75 f4             	pushl  -0xc(%ebp)
801058bd:	e8 ef c2 ff ff       	call   80101bb1 <iunlockput>
801058c2:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
801058c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058c8:	0f b7 40 16          	movzwl 0x16(%eax),%eax
801058cc:	83 e8 01             	sub    $0x1,%eax
801058cf:	89 c2                	mov    %eax,%edx
801058d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801058d4:	66 89 50 16          	mov    %dx,0x16(%eax)
  iupdate(ip);
801058d8:	83 ec 0c             	sub    $0xc,%esp
801058db:	ff 75 f0             	pushl  -0x10(%ebp)
801058de:	e8 40 be ff ff       	call   80101723 <iupdate>
801058e3:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
801058e6:	83 ec 0c             	sub    $0xc,%esp
801058e9:	ff 75 f0             	pushl  -0x10(%ebp)
801058ec:	e8 c0 c2 ff ff       	call   80101bb1 <iunlockput>
801058f1:	83 c4 10             	add    $0x10,%esp

  commit_trans();
801058f4:	e8 d5 d9 ff ff       	call   801032ce <commit_trans>

  return 0;
801058f9:	b8 00 00 00 00       	mov    $0x0,%eax
801058fe:	eb 19                	jmp    80105919 <sys_unlink+0x1dc>
  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
80105900:	90                   	nop
  commit_trans();

  return 0;

bad:
  iunlockput(dp);
80105901:	83 ec 0c             	sub    $0xc,%esp
80105904:	ff 75 f4             	pushl  -0xc(%ebp)
80105907:	e8 a5 c2 ff ff       	call   80101bb1 <iunlockput>
8010590c:	83 c4 10             	add    $0x10,%esp
  commit_trans();
8010590f:	e8 ba d9 ff ff       	call   801032ce <commit_trans>
  return -1;
80105914:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105919:	c9                   	leave  
8010591a:	c3                   	ret    

8010591b <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
8010591b:	55                   	push   %ebp
8010591c:	89 e5                	mov    %esp,%ebp
8010591e:	83 ec 38             	sub    $0x38,%esp
80105921:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80105924:	8b 55 10             	mov    0x10(%ebp),%edx
80105927:	8b 45 14             	mov    0x14(%ebp),%eax
8010592a:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
8010592e:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80105932:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105936:	83 ec 08             	sub    $0x8,%esp
80105939:	8d 45 de             	lea    -0x22(%ebp),%eax
8010593c:	50                   	push   %eax
8010593d:	ff 75 08             	pushl  0x8(%ebp)
80105940:	e8 86 cb ff ff       	call   801024cb <nameiparent>
80105945:	83 c4 10             	add    $0x10,%esp
80105948:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010594b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010594f:	75 0a                	jne    8010595b <create+0x40>
    return 0;
80105951:	b8 00 00 00 00       	mov    $0x0,%eax
80105956:	e9 90 01 00 00       	jmp    80105aeb <create+0x1d0>
  ilock(dp);
8010595b:	83 ec 0c             	sub    $0xc,%esp
8010595e:	ff 75 f4             	pushl  -0xc(%ebp)
80105961:	e8 91 bf ff ff       	call   801018f7 <ilock>
80105966:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, &off)) != 0){
80105969:	83 ec 04             	sub    $0x4,%esp
8010596c:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010596f:	50                   	push   %eax
80105970:	8d 45 de             	lea    -0x22(%ebp),%eax
80105973:	50                   	push   %eax
80105974:	ff 75 f4             	pushl  -0xc(%ebp)
80105977:	e8 dd c7 ff ff       	call   80102159 <dirlookup>
8010597c:	83 c4 10             	add    $0x10,%esp
8010597f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105982:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105986:	74 50                	je     801059d8 <create+0xbd>
    iunlockput(dp);
80105988:	83 ec 0c             	sub    $0xc,%esp
8010598b:	ff 75 f4             	pushl  -0xc(%ebp)
8010598e:	e8 1e c2 ff ff       	call   80101bb1 <iunlockput>
80105993:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80105996:	83 ec 0c             	sub    $0xc,%esp
80105999:	ff 75 f0             	pushl  -0x10(%ebp)
8010599c:	e8 56 bf ff ff       	call   801018f7 <ilock>
801059a1:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
801059a4:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801059a9:	75 15                	jne    801059c0 <create+0xa5>
801059ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059ae:	0f b7 40 10          	movzwl 0x10(%eax),%eax
801059b2:	66 83 f8 02          	cmp    $0x2,%ax
801059b6:	75 08                	jne    801059c0 <create+0xa5>
      return ip;
801059b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801059bb:	e9 2b 01 00 00       	jmp    80105aeb <create+0x1d0>
    iunlockput(ip);
801059c0:	83 ec 0c             	sub    $0xc,%esp
801059c3:	ff 75 f0             	pushl  -0x10(%ebp)
801059c6:	e8 e6 c1 ff ff       	call   80101bb1 <iunlockput>
801059cb:	83 c4 10             	add    $0x10,%esp
    return 0;
801059ce:	b8 00 00 00 00       	mov    $0x0,%eax
801059d3:	e9 13 01 00 00       	jmp    80105aeb <create+0x1d0>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
801059d8:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
801059dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801059df:	8b 00                	mov    (%eax),%eax
801059e1:	83 ec 08             	sub    $0x8,%esp
801059e4:	52                   	push   %edx
801059e5:	50                   	push   %eax
801059e6:	e8 57 bc ff ff       	call   80101642 <ialloc>
801059eb:	83 c4 10             	add    $0x10,%esp
801059ee:	89 45 f0             	mov    %eax,-0x10(%ebp)
801059f1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801059f5:	75 0d                	jne    80105a04 <create+0xe9>
    panic("create: ialloc");
801059f7:	83 ec 0c             	sub    $0xc,%esp
801059fa:	68 9f 85 10 80       	push   $0x8010859f
801059ff:	e8 62 ab ff ff       	call   80100566 <panic>

  ilock(ip);
80105a04:	83 ec 0c             	sub    $0xc,%esp
80105a07:	ff 75 f0             	pushl  -0x10(%ebp)
80105a0a:	e8 e8 be ff ff       	call   801018f7 <ilock>
80105a0f:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80105a12:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a15:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80105a19:	66 89 50 12          	mov    %dx,0x12(%eax)
  ip->minor = minor;
80105a1d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a20:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80105a24:	66 89 50 14          	mov    %dx,0x14(%eax)
  ip->nlink = 1;
80105a28:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a2b:	66 c7 40 16 01 00    	movw   $0x1,0x16(%eax)
  iupdate(ip);
80105a31:	83 ec 0c             	sub    $0xc,%esp
80105a34:	ff 75 f0             	pushl  -0x10(%ebp)
80105a37:	e8 e7 bc ff ff       	call   80101723 <iupdate>
80105a3c:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80105a3f:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105a44:	75 6a                	jne    80105ab0 <create+0x195>
    dp->nlink++;  // for ".."
80105a46:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a49:	0f b7 40 16          	movzwl 0x16(%eax),%eax
80105a4d:	83 c0 01             	add    $0x1,%eax
80105a50:	89 c2                	mov    %eax,%edx
80105a52:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a55:	66 89 50 16          	mov    %dx,0x16(%eax)
    iupdate(dp);
80105a59:	83 ec 0c             	sub    $0xc,%esp
80105a5c:	ff 75 f4             	pushl  -0xc(%ebp)
80105a5f:	e8 bf bc ff ff       	call   80101723 <iupdate>
80105a64:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105a67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105a6a:	8b 40 04             	mov    0x4(%eax),%eax
80105a6d:	83 ec 04             	sub    $0x4,%esp
80105a70:	50                   	push   %eax
80105a71:	68 79 85 10 80       	push   $0x80108579
80105a76:	ff 75 f0             	pushl  -0x10(%ebp)
80105a79:	e8 95 c7 ff ff       	call   80102213 <dirlink>
80105a7e:	83 c4 10             	add    $0x10,%esp
80105a81:	85 c0                	test   %eax,%eax
80105a83:	78 1e                	js     80105aa3 <create+0x188>
80105a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105a88:	8b 40 04             	mov    0x4(%eax),%eax
80105a8b:	83 ec 04             	sub    $0x4,%esp
80105a8e:	50                   	push   %eax
80105a8f:	68 7b 85 10 80       	push   $0x8010857b
80105a94:	ff 75 f0             	pushl  -0x10(%ebp)
80105a97:	e8 77 c7 ff ff       	call   80102213 <dirlink>
80105a9c:	83 c4 10             	add    $0x10,%esp
80105a9f:	85 c0                	test   %eax,%eax
80105aa1:	79 0d                	jns    80105ab0 <create+0x195>
      panic("create dots");
80105aa3:	83 ec 0c             	sub    $0xc,%esp
80105aa6:	68 ae 85 10 80       	push   $0x801085ae
80105aab:	e8 b6 aa ff ff       	call   80100566 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80105ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ab3:	8b 40 04             	mov    0x4(%eax),%eax
80105ab6:	83 ec 04             	sub    $0x4,%esp
80105ab9:	50                   	push   %eax
80105aba:	8d 45 de             	lea    -0x22(%ebp),%eax
80105abd:	50                   	push   %eax
80105abe:	ff 75 f4             	pushl  -0xc(%ebp)
80105ac1:	e8 4d c7 ff ff       	call   80102213 <dirlink>
80105ac6:	83 c4 10             	add    $0x10,%esp
80105ac9:	85 c0                	test   %eax,%eax
80105acb:	79 0d                	jns    80105ada <create+0x1bf>
    panic("create: dirlink");
80105acd:	83 ec 0c             	sub    $0xc,%esp
80105ad0:	68 ba 85 10 80       	push   $0x801085ba
80105ad5:	e8 8c aa ff ff       	call   80100566 <panic>

  iunlockput(dp);
80105ada:	83 ec 0c             	sub    $0xc,%esp
80105add:	ff 75 f4             	pushl  -0xc(%ebp)
80105ae0:	e8 cc c0 ff ff       	call   80101bb1 <iunlockput>
80105ae5:	83 c4 10             	add    $0x10,%esp

  return ip;
80105ae8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80105aeb:	c9                   	leave  
80105aec:	c3                   	ret    

80105aed <sys_open>:

int
sys_open(void)
{
80105aed:	55                   	push   %ebp
80105aee:	89 e5                	mov    %esp,%ebp
80105af0:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105af3:	83 ec 08             	sub    $0x8,%esp
80105af6:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105af9:	50                   	push   %eax
80105afa:	6a 00                	push   $0x0
80105afc:	e8 f5 f6 ff ff       	call   801051f6 <argstr>
80105b01:	83 c4 10             	add    $0x10,%esp
80105b04:	85 c0                	test   %eax,%eax
80105b06:	78 15                	js     80105b1d <sys_open+0x30>
80105b08:	83 ec 08             	sub    $0x8,%esp
80105b0b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b0e:	50                   	push   %eax
80105b0f:	6a 01                	push   $0x1
80105b11:	e8 5b f6 ff ff       	call   80105171 <argint>
80105b16:	83 c4 10             	add    $0x10,%esp
80105b19:	85 c0                	test   %eax,%eax
80105b1b:	79 0a                	jns    80105b27 <sys_open+0x3a>
    return -1;
80105b1d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b22:	e9 4d 01 00 00       	jmp    80105c74 <sys_open+0x187>
  if(omode & O_CREATE){
80105b27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105b2a:	25 00 02 00 00       	and    $0x200,%eax
80105b2f:	85 c0                	test   %eax,%eax
80105b31:	74 2f                	je     80105b62 <sys_open+0x75>
    begin_trans();
80105b33:	e8 43 d7 ff ff       	call   8010327b <begin_trans>
    ip = create(path, T_FILE, 0, 0);
80105b38:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105b3b:	6a 00                	push   $0x0
80105b3d:	6a 00                	push   $0x0
80105b3f:	6a 02                	push   $0x2
80105b41:	50                   	push   %eax
80105b42:	e8 d4 fd ff ff       	call   8010591b <create>
80105b47:	83 c4 10             	add    $0x10,%esp
80105b4a:	89 45 f4             	mov    %eax,-0xc(%ebp)
    commit_trans();
80105b4d:	e8 7c d7 ff ff       	call   801032ce <commit_trans>
    if(ip == 0)
80105b52:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b56:	75 66                	jne    80105bbe <sys_open+0xd1>
      return -1;
80105b58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b5d:	e9 12 01 00 00       	jmp    80105c74 <sys_open+0x187>
  } else {
    if((ip = namei(path)) == 0)
80105b62:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105b65:	83 ec 0c             	sub    $0xc,%esp
80105b68:	50                   	push   %eax
80105b69:	e8 41 c9 ff ff       	call   801024af <namei>
80105b6e:	83 c4 10             	add    $0x10,%esp
80105b71:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105b74:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105b78:	75 0a                	jne    80105b84 <sys_open+0x97>
      return -1;
80105b7a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b7f:	e9 f0 00 00 00       	jmp    80105c74 <sys_open+0x187>
    ilock(ip);
80105b84:	83 ec 0c             	sub    $0xc,%esp
80105b87:	ff 75 f4             	pushl  -0xc(%ebp)
80105b8a:	e8 68 bd ff ff       	call   801018f7 <ilock>
80105b8f:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
80105b92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b95:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105b99:	66 83 f8 01          	cmp    $0x1,%ax
80105b9d:	75 1f                	jne    80105bbe <sys_open+0xd1>
80105b9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ba2:	85 c0                	test   %eax,%eax
80105ba4:	74 18                	je     80105bbe <sys_open+0xd1>
      iunlockput(ip);
80105ba6:	83 ec 0c             	sub    $0xc,%esp
80105ba9:	ff 75 f4             	pushl  -0xc(%ebp)
80105bac:	e8 00 c0 ff ff       	call   80101bb1 <iunlockput>
80105bb1:	83 c4 10             	add    $0x10,%esp
      return -1;
80105bb4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bb9:	e9 b6 00 00 00       	jmp    80105c74 <sys_open+0x187>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105bbe:	e8 a1 b3 ff ff       	call   80100f64 <filealloc>
80105bc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105bc6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105bca:	74 17                	je     80105be3 <sys_open+0xf6>
80105bcc:	83 ec 0c             	sub    $0xc,%esp
80105bcf:	ff 75 f0             	pushl  -0x10(%ebp)
80105bd2:	e8 4b f7 ff ff       	call   80105322 <fdalloc>
80105bd7:	83 c4 10             	add    $0x10,%esp
80105bda:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105bdd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80105be1:	79 29                	jns    80105c0c <sys_open+0x11f>
    if(f)
80105be3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105be7:	74 0e                	je     80105bf7 <sys_open+0x10a>
      fileclose(f);
80105be9:	83 ec 0c             	sub    $0xc,%esp
80105bec:	ff 75 f0             	pushl  -0x10(%ebp)
80105bef:	e8 2e b4 ff ff       	call   80101022 <fileclose>
80105bf4:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105bf7:	83 ec 0c             	sub    $0xc,%esp
80105bfa:	ff 75 f4             	pushl  -0xc(%ebp)
80105bfd:	e8 af bf ff ff       	call   80101bb1 <iunlockput>
80105c02:	83 c4 10             	add    $0x10,%esp
    return -1;
80105c05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c0a:	eb 68                	jmp    80105c74 <sys_open+0x187>
  }
  iunlock(ip);
80105c0c:	83 ec 0c             	sub    $0xc,%esp
80105c0f:	ff 75 f4             	pushl  -0xc(%ebp)
80105c12:	e8 38 be ff ff       	call   80101a4f <iunlock>
80105c17:	83 c4 10             	add    $0x10,%esp

  f->type = FD_INODE;
80105c1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c1d:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
80105c23:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c26:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c29:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
80105c2c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c2f:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
80105c36:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105c39:	83 e0 01             	and    $0x1,%eax
80105c3c:	85 c0                	test   %eax,%eax
80105c3e:	0f 94 c0             	sete   %al
80105c41:	89 c2                	mov    %eax,%edx
80105c43:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c46:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105c4c:	83 e0 01             	and    $0x1,%eax
80105c4f:	85 c0                	test   %eax,%eax
80105c51:	75 0a                	jne    80105c5d <sys_open+0x170>
80105c53:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105c56:	83 e0 02             	and    $0x2,%eax
80105c59:	85 c0                	test   %eax,%eax
80105c5b:	74 07                	je     80105c64 <sys_open+0x177>
80105c5d:	b8 01 00 00 00       	mov    $0x1,%eax
80105c62:	eb 05                	jmp    80105c69 <sys_open+0x17c>
80105c64:	b8 00 00 00 00       	mov    $0x0,%eax
80105c69:	89 c2                	mov    %eax,%edx
80105c6b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c6e:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
80105c71:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
80105c74:	c9                   	leave  
80105c75:	c3                   	ret    

80105c76 <sys_mkdir>:

int
sys_mkdir(void)
{
80105c76:	55                   	push   %ebp
80105c77:	89 e5                	mov    %esp,%ebp
80105c79:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_trans();
80105c7c:	e8 fa d5 ff ff       	call   8010327b <begin_trans>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105c81:	83 ec 08             	sub    $0x8,%esp
80105c84:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c87:	50                   	push   %eax
80105c88:	6a 00                	push   $0x0
80105c8a:	e8 67 f5 ff ff       	call   801051f6 <argstr>
80105c8f:	83 c4 10             	add    $0x10,%esp
80105c92:	85 c0                	test   %eax,%eax
80105c94:	78 1b                	js     80105cb1 <sys_mkdir+0x3b>
80105c96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105c99:	6a 00                	push   $0x0
80105c9b:	6a 00                	push   $0x0
80105c9d:	6a 01                	push   $0x1
80105c9f:	50                   	push   %eax
80105ca0:	e8 76 fc ff ff       	call   8010591b <create>
80105ca5:	83 c4 10             	add    $0x10,%esp
80105ca8:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105cab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105caf:	75 0c                	jne    80105cbd <sys_mkdir+0x47>
    commit_trans();
80105cb1:	e8 18 d6 ff ff       	call   801032ce <commit_trans>
    return -1;
80105cb6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cbb:	eb 18                	jmp    80105cd5 <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80105cbd:	83 ec 0c             	sub    $0xc,%esp
80105cc0:	ff 75 f4             	pushl  -0xc(%ebp)
80105cc3:	e8 e9 be ff ff       	call   80101bb1 <iunlockput>
80105cc8:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105ccb:	e8 fe d5 ff ff       	call   801032ce <commit_trans>
  return 0;
80105cd0:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105cd5:	c9                   	leave  
80105cd6:	c3                   	ret    

80105cd7 <sys_mknod>:

int
sys_mknod(void)
{
80105cd7:	55                   	push   %ebp
80105cd8:	89 e5                	mov    %esp,%ebp
80105cda:	83 ec 28             	sub    $0x28,%esp
  struct inode *ip;
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
80105cdd:	e8 99 d5 ff ff       	call   8010327b <begin_trans>
  if((len=argstr(0, &path)) < 0 ||
80105ce2:	83 ec 08             	sub    $0x8,%esp
80105ce5:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ce8:	50                   	push   %eax
80105ce9:	6a 00                	push   $0x0
80105ceb:	e8 06 f5 ff ff       	call   801051f6 <argstr>
80105cf0:	83 c4 10             	add    $0x10,%esp
80105cf3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105cf6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105cfa:	78 4f                	js     80105d4b <sys_mknod+0x74>
     argint(1, &major) < 0 ||
80105cfc:	83 ec 08             	sub    $0x8,%esp
80105cff:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105d02:	50                   	push   %eax
80105d03:	6a 01                	push   $0x1
80105d05:	e8 67 f4 ff ff       	call   80105171 <argint>
80105d0a:	83 c4 10             	add    $0x10,%esp
  char *path;
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
80105d0d:	85 c0                	test   %eax,%eax
80105d0f:	78 3a                	js     80105d4b <sys_mknod+0x74>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105d11:	83 ec 08             	sub    $0x8,%esp
80105d14:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d17:	50                   	push   %eax
80105d18:	6a 02                	push   $0x2
80105d1a:	e8 52 f4 ff ff       	call   80105171 <argint>
80105d1f:	83 c4 10             	add    $0x10,%esp
  int len;
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105d22:	85 c0                	test   %eax,%eax
80105d24:	78 25                	js     80105d4b <sys_mknod+0x74>
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105d29:	0f bf c8             	movswl %ax,%ecx
80105d2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105d2f:	0f bf d0             	movswl %ax,%edx
80105d32:	8b 45 ec             	mov    -0x14(%ebp),%eax
  int major, minor;
  
  begin_trans();
  if((len=argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105d35:	51                   	push   %ecx
80105d36:	52                   	push   %edx
80105d37:	6a 03                	push   $0x3
80105d39:	50                   	push   %eax
80105d3a:	e8 dc fb ff ff       	call   8010591b <create>
80105d3f:	83 c4 10             	add    $0x10,%esp
80105d42:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105d45:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105d49:	75 0c                	jne    80105d57 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    commit_trans();
80105d4b:	e8 7e d5 ff ff       	call   801032ce <commit_trans>
    return -1;
80105d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d55:	eb 18                	jmp    80105d6f <sys_mknod+0x98>
  }
  iunlockput(ip);
80105d57:	83 ec 0c             	sub    $0xc,%esp
80105d5a:	ff 75 f0             	pushl  -0x10(%ebp)
80105d5d:	e8 4f be ff ff       	call   80101bb1 <iunlockput>
80105d62:	83 c4 10             	add    $0x10,%esp
  commit_trans();
80105d65:	e8 64 d5 ff ff       	call   801032ce <commit_trans>
  return 0;
80105d6a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105d6f:	c9                   	leave  
80105d70:	c3                   	ret    

80105d71 <sys_chdir>:

int
sys_chdir(void)
{
80105d71:	55                   	push   %ebp
80105d72:	89 e5                	mov    %esp,%ebp
80105d74:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0)
80105d77:	83 ec 08             	sub    $0x8,%esp
80105d7a:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d7d:	50                   	push   %eax
80105d7e:	6a 00                	push   $0x0
80105d80:	e8 71 f4 ff ff       	call   801051f6 <argstr>
80105d85:	83 c4 10             	add    $0x10,%esp
80105d88:	85 c0                	test   %eax,%eax
80105d8a:	78 18                	js     80105da4 <sys_chdir+0x33>
80105d8c:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105d8f:	83 ec 0c             	sub    $0xc,%esp
80105d92:	50                   	push   %eax
80105d93:	e8 17 c7 ff ff       	call   801024af <namei>
80105d98:	83 c4 10             	add    $0x10,%esp
80105d9b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105d9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105da2:	75 07                	jne    80105dab <sys_chdir+0x3a>
    return -1;
80105da4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105da9:	eb 64                	jmp    80105e0f <sys_chdir+0x9e>
  ilock(ip);
80105dab:	83 ec 0c             	sub    $0xc,%esp
80105dae:	ff 75 f4             	pushl  -0xc(%ebp)
80105db1:	e8 41 bb ff ff       	call   801018f7 <ilock>
80105db6:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80105db9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dbc:	0f b7 40 10          	movzwl 0x10(%eax),%eax
80105dc0:	66 83 f8 01          	cmp    $0x1,%ax
80105dc4:	74 15                	je     80105ddb <sys_chdir+0x6a>
    iunlockput(ip);
80105dc6:	83 ec 0c             	sub    $0xc,%esp
80105dc9:	ff 75 f4             	pushl  -0xc(%ebp)
80105dcc:	e8 e0 bd ff ff       	call   80101bb1 <iunlockput>
80105dd1:	83 c4 10             	add    $0x10,%esp
    return -1;
80105dd4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105dd9:	eb 34                	jmp    80105e0f <sys_chdir+0x9e>
  }
  iunlock(ip);
80105ddb:	83 ec 0c             	sub    $0xc,%esp
80105dde:	ff 75 f4             	pushl  -0xc(%ebp)
80105de1:	e8 69 bc ff ff       	call   80101a4f <iunlock>
80105de6:	83 c4 10             	add    $0x10,%esp
  iput(proc->cwd);
80105de9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105def:	8b 40 68             	mov    0x68(%eax),%eax
80105df2:	83 ec 0c             	sub    $0xc,%esp
80105df5:	50                   	push   %eax
80105df6:	e8 c6 bc ff ff       	call   80101ac1 <iput>
80105dfb:	83 c4 10             	add    $0x10,%esp
  proc->cwd = ip;
80105dfe:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105e04:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105e07:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
80105e0a:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105e0f:	c9                   	leave  
80105e10:	c3                   	ret    

80105e11 <sys_exec>:

int
sys_exec(void)
{
80105e11:	55                   	push   %ebp
80105e12:	89 e5                	mov    %esp,%ebp
80105e14:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e1a:	83 ec 08             	sub    $0x8,%esp
80105e1d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e20:	50                   	push   %eax
80105e21:	6a 00                	push   $0x0
80105e23:	e8 ce f3 ff ff       	call   801051f6 <argstr>
80105e28:	83 c4 10             	add    $0x10,%esp
80105e2b:	85 c0                	test   %eax,%eax
80105e2d:	78 18                	js     80105e47 <sys_exec+0x36>
80105e2f:	83 ec 08             	sub    $0x8,%esp
80105e32:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80105e38:	50                   	push   %eax
80105e39:	6a 01                	push   $0x1
80105e3b:	e8 31 f3 ff ff       	call   80105171 <argint>
80105e40:	83 c4 10             	add    $0x10,%esp
80105e43:	85 c0                	test   %eax,%eax
80105e45:	79 0a                	jns    80105e51 <sys_exec+0x40>
    return -1;
80105e47:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e4c:	e9 c6 00 00 00       	jmp    80105f17 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
80105e51:	83 ec 04             	sub    $0x4,%esp
80105e54:	68 80 00 00 00       	push   $0x80
80105e59:	6a 00                	push   $0x0
80105e5b:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80105e61:	50                   	push   %eax
80105e62:	e8 e5 ef ff ff       	call   80104e4c <memset>
80105e67:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80105e6a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
80105e71:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e74:	83 f8 1f             	cmp    $0x1f,%eax
80105e77:	76 0a                	jbe    80105e83 <sys_exec+0x72>
      return -1;
80105e79:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e7e:	e9 94 00 00 00       	jmp    80105f17 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105e83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e86:	c1 e0 02             	shl    $0x2,%eax
80105e89:	89 c2                	mov    %eax,%edx
80105e8b:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
80105e91:	01 c2                	add    %eax,%edx
80105e93:	83 ec 08             	sub    $0x8,%esp
80105e96:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105e9c:	50                   	push   %eax
80105e9d:	52                   	push   %edx
80105e9e:	e8 32 f2 ff ff       	call   801050d5 <fetchint>
80105ea3:	83 c4 10             	add    $0x10,%esp
80105ea6:	85 c0                	test   %eax,%eax
80105ea8:	79 07                	jns    80105eb1 <sys_exec+0xa0>
      return -1;
80105eaa:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105eaf:	eb 66                	jmp    80105f17 <sys_exec+0x106>
    if(uarg == 0){
80105eb1:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80105eb7:	85 c0                	test   %eax,%eax
80105eb9:	75 27                	jne    80105ee2 <sys_exec+0xd1>
      argv[i] = 0;
80105ebb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ebe:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80105ec5:	00 00 00 00 
      break;
80105ec9:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105eca:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105ecd:	83 ec 08             	sub    $0x8,%esp
80105ed0:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80105ed6:	52                   	push   %edx
80105ed7:	50                   	push   %eax
80105ed8:	e8 79 ac ff ff       	call   80100b56 <exec>
80105edd:	83 c4 10             	add    $0x10,%esp
80105ee0:	eb 35                	jmp    80105f17 <sys_exec+0x106>
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105ee2:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
80105ee8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105eeb:	c1 e2 02             	shl    $0x2,%edx
80105eee:	01 c2                	add    %eax,%edx
80105ef0:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80105ef6:	83 ec 08             	sub    $0x8,%esp
80105ef9:	52                   	push   %edx
80105efa:	50                   	push   %eax
80105efb:	e8 0f f2 ff ff       	call   8010510f <fetchstr>
80105f00:	83 c4 10             	add    $0x10,%esp
80105f03:	85 c0                	test   %eax,%eax
80105f05:	79 07                	jns    80105f0e <sys_exec+0xfd>
      return -1;
80105f07:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f0c:	eb 09                	jmp    80105f17 <sys_exec+0x106>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105f0e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
80105f12:	e9 5a ff ff ff       	jmp    80105e71 <sys_exec+0x60>
  return exec(path, argv);
}
80105f17:	c9                   	leave  
80105f18:	c3                   	ret    

80105f19 <sys_pipe>:

int
sys_pipe(void)
{
80105f19:	55                   	push   %ebp
80105f1a:	89 e5                	mov    %esp,%ebp
80105f1c:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f1f:	83 ec 04             	sub    $0x4,%esp
80105f22:	6a 08                	push   $0x8
80105f24:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105f27:	50                   	push   %eax
80105f28:	6a 00                	push   $0x0
80105f2a:	e8 6a f2 ff ff       	call   80105199 <argptr>
80105f2f:	83 c4 10             	add    $0x10,%esp
80105f32:	85 c0                	test   %eax,%eax
80105f34:	79 0a                	jns    80105f40 <sys_pipe+0x27>
    return -1;
80105f36:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f3b:	e9 af 00 00 00       	jmp    80105fef <sys_pipe+0xd6>
  if(pipealloc(&rf, &wf) < 0)
80105f40:	83 ec 08             	sub    $0x8,%esp
80105f43:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f46:	50                   	push   %eax
80105f47:	8d 45 e8             	lea    -0x18(%ebp),%eax
80105f4a:	50                   	push   %eax
80105f4b:	e8 e4 dc ff ff       	call   80103c34 <pipealloc>
80105f50:	83 c4 10             	add    $0x10,%esp
80105f53:	85 c0                	test   %eax,%eax
80105f55:	79 0a                	jns    80105f61 <sys_pipe+0x48>
    return -1;
80105f57:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f5c:	e9 8e 00 00 00       	jmp    80105fef <sys_pipe+0xd6>
  fd0 = -1;
80105f61:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f68:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105f6b:	83 ec 0c             	sub    $0xc,%esp
80105f6e:	50                   	push   %eax
80105f6f:	e8 ae f3 ff ff       	call   80105322 <fdalloc>
80105f74:	83 c4 10             	add    $0x10,%esp
80105f77:	89 45 f4             	mov    %eax,-0xc(%ebp)
80105f7a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f7e:	78 18                	js     80105f98 <sys_pipe+0x7f>
80105f80:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105f83:	83 ec 0c             	sub    $0xc,%esp
80105f86:	50                   	push   %eax
80105f87:	e8 96 f3 ff ff       	call   80105322 <fdalloc>
80105f8c:	83 c4 10             	add    $0x10,%esp
80105f8f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80105f92:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80105f96:	79 3f                	jns    80105fd7 <sys_pipe+0xbe>
    if(fd0 >= 0)
80105f98:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105f9c:	78 14                	js     80105fb2 <sys_pipe+0x99>
      proc->ofile[fd0] = 0;
80105f9e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105fa4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105fa7:	83 c2 08             	add    $0x8,%edx
80105faa:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80105fb1:	00 
    fileclose(rf);
80105fb2:	8b 45 e8             	mov    -0x18(%ebp),%eax
80105fb5:	83 ec 0c             	sub    $0xc,%esp
80105fb8:	50                   	push   %eax
80105fb9:	e8 64 b0 ff ff       	call   80101022 <fileclose>
80105fbe:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
80105fc1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105fc4:	83 ec 0c             	sub    $0xc,%esp
80105fc7:	50                   	push   %eax
80105fc8:	e8 55 b0 ff ff       	call   80101022 <fileclose>
80105fcd:	83 c4 10             	add    $0x10,%esp
    return -1;
80105fd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fd5:	eb 18                	jmp    80105fef <sys_pipe+0xd6>
  }
  fd[0] = fd0;
80105fd7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105fda:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105fdd:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80105fdf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105fe2:	8d 50 04             	lea    0x4(%eax),%edx
80105fe5:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105fe8:	89 02                	mov    %eax,(%edx)
  return 0;
80105fea:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105fef:	c9                   	leave  
80105ff0:	c3                   	ret    

80105ff1 <sys_fork>:

extern int seedX;

int
sys_fork(void)
{
80105ff1:	55                   	push   %ebp
80105ff2:	89 e5                	mov    %esp,%ebp
80105ff4:	83 ec 08             	sub    $0x8,%esp
  return fork();
80105ff7:	e8 2e e3 ff ff       	call   8010432a <fork>
}
80105ffc:	c9                   	leave  
80105ffd:	c3                   	ret    

80105ffe <sys_exit>:

int
sys_exit(void)
{
80105ffe:	55                   	push   %ebp
80105fff:	89 e5                	mov    %esp,%ebp
80106001:	83 ec 08             	sub    $0x8,%esp
  exit();
80106004:	e8 92 e4 ff ff       	call   8010449b <exit>
  return 0;  // not reached
80106009:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010600e:	c9                   	leave  
8010600f:	c3                   	ret    

80106010 <sys_wait>:

int
sys_wait(void)
{
80106010:	55                   	push   %ebp
80106011:	89 e5                	mov    %esp,%ebp
80106013:	83 ec 08             	sub    $0x8,%esp
  return wait();
80106016:	e8 ae e5 ff ff       	call   801045c9 <wait>
}
8010601b:	c9                   	leave  
8010601c:	c3                   	ret    

8010601d <sys_kill>:

int
sys_kill(void)
{
8010601d:	55                   	push   %ebp
8010601e:	89 e5                	mov    %esp,%ebp
80106020:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106023:	83 ec 08             	sub    $0x8,%esp
80106026:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106029:	50                   	push   %eax
8010602a:	6a 00                	push   $0x0
8010602c:	e8 40 f1 ff ff       	call   80105171 <argint>
80106031:	83 c4 10             	add    $0x10,%esp
80106034:	85 c0                	test   %eax,%eax
80106036:	79 07                	jns    8010603f <sys_kill+0x22>
    return -1;
80106038:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010603d:	eb 0f                	jmp    8010604e <sys_kill+0x31>
  return kill(pid);
8010603f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106042:	83 ec 0c             	sub    $0xc,%esp
80106045:	50                   	push   %eax
80106046:	e8 91 e9 ff ff       	call   801049dc <kill>
8010604b:	83 c4 10             	add    $0x10,%esp
}
8010604e:	c9                   	leave  
8010604f:	c3                   	ret    

80106050 <sys_getpid>:

int
sys_getpid(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80106053:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106059:	8b 40 10             	mov    0x10(%eax),%eax
}
8010605c:	5d                   	pop    %ebp
8010605d:	c3                   	ret    

8010605e <sys_sbrk>:

int
sys_sbrk(void)
{
8010605e:	55                   	push   %ebp
8010605f:	89 e5                	mov    %esp,%ebp
80106061:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106064:	83 ec 08             	sub    $0x8,%esp
80106067:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010606a:	50                   	push   %eax
8010606b:	6a 00                	push   $0x0
8010606d:	e8 ff f0 ff ff       	call   80105171 <argint>
80106072:	83 c4 10             	add    $0x10,%esp
80106075:	85 c0                	test   %eax,%eax
80106077:	79 07                	jns    80106080 <sys_sbrk+0x22>
    return -1;
80106079:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010607e:	eb 28                	jmp    801060a8 <sys_sbrk+0x4a>
  addr = proc->sz;
80106080:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106086:	8b 00                	mov    (%eax),%eax
80106088:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
8010608b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010608e:	83 ec 0c             	sub    $0xc,%esp
80106091:	50                   	push   %eax
80106092:	e8 f0 e1 ff ff       	call   80104287 <growproc>
80106097:	83 c4 10             	add    $0x10,%esp
8010609a:	85 c0                	test   %eax,%eax
8010609c:	79 07                	jns    801060a5 <sys_sbrk+0x47>
    return -1;
8010609e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060a3:	eb 03                	jmp    801060a8 <sys_sbrk+0x4a>
  return addr;
801060a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801060a8:	c9                   	leave  
801060a9:	c3                   	ret    

801060aa <sys_sleep>:

int
sys_sleep(void)
{
801060aa:	55                   	push   %ebp
801060ab:	89 e5                	mov    %esp,%ebp
801060ad:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801060b0:	83 ec 08             	sub    $0x8,%esp
801060b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801060b6:	50                   	push   %eax
801060b7:	6a 00                	push   $0x0
801060b9:	e8 b3 f0 ff ff       	call   80105171 <argint>
801060be:	83 c4 10             	add    $0x10,%esp
801060c1:	85 c0                	test   %eax,%eax
801060c3:	79 07                	jns    801060cc <sys_sleep+0x22>
    return -1;
801060c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060ca:	eb 77                	jmp    80106143 <sys_sleep+0x99>
  acquire(&tickslock);
801060cc:	83 ec 0c             	sub    $0xc,%esp
801060cf:	68 80 1e 11 80       	push   $0x80111e80
801060d4:	e8 10 eb ff ff       	call   80104be9 <acquire>
801060d9:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
801060dc:	a1 c0 26 11 80       	mov    0x801126c0,%eax
801060e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
801060e4:	eb 39                	jmp    8010611f <sys_sleep+0x75>
    if(proc->killed){
801060e6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801060ec:	8b 40 24             	mov    0x24(%eax),%eax
801060ef:	85 c0                	test   %eax,%eax
801060f1:	74 17                	je     8010610a <sys_sleep+0x60>
      release(&tickslock);
801060f3:	83 ec 0c             	sub    $0xc,%esp
801060f6:	68 80 1e 11 80       	push   $0x80111e80
801060fb:	e8 50 eb ff ff       	call   80104c50 <release>
80106100:	83 c4 10             	add    $0x10,%esp
      return -1;
80106103:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106108:	eb 39                	jmp    80106143 <sys_sleep+0x99>
    }
    sleep(&ticks, &tickslock);
8010610a:	83 ec 08             	sub    $0x8,%esp
8010610d:	68 80 1e 11 80       	push   $0x80111e80
80106112:	68 c0 26 11 80       	push   $0x801126c0
80106117:	e8 9e e7 ff ff       	call   801048ba <sleep>
8010611c:	83 c4 10             	add    $0x10,%esp

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010611f:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80106124:	2b 45 f4             	sub    -0xc(%ebp),%eax
80106127:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010612a:	39 d0                	cmp    %edx,%eax
8010612c:	72 b8                	jb     801060e6 <sys_sleep+0x3c>
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
8010612e:	83 ec 0c             	sub    $0xc,%esp
80106131:	68 80 1e 11 80       	push   $0x80111e80
80106136:	e8 15 eb ff ff       	call   80104c50 <release>
8010613b:	83 c4 10             	add    $0x10,%esp
  return 0;
8010613e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106143:	c9                   	leave  
80106144:	c3                   	ret    

80106145 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106145:	55                   	push   %ebp
80106146:	89 e5                	mov    %esp,%ebp
80106148:	83 ec 18             	sub    $0x18,%esp
  uint xticks;

  acquire(&tickslock);
8010614b:	83 ec 0c             	sub    $0xc,%esp
8010614e:	68 80 1e 11 80       	push   $0x80111e80
80106153:	e8 91 ea ff ff       	call   80104be9 <acquire>
80106158:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
8010615b:	a1 c0 26 11 80       	mov    0x801126c0,%eax
80106160:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
80106163:	83 ec 0c             	sub    $0xc,%esp
80106166:	68 80 1e 11 80       	push   $0x80111e80
8010616b:	e8 e0 ea ff ff       	call   80104c50 <release>
80106170:	83 c4 10             	add    $0x10,%esp
  return xticks;
80106173:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106176:	c9                   	leave  
80106177:	c3                   	ret    

80106178 <sys_randomX>:


int
sys_randomX(void)
{
80106178:	55                   	push   %ebp
80106179:	89 e5                	mov    %esp,%ebp
8010617b:	83 ec 08             	sub    $0x8,%esp

    seedX = randX(seedX);
8010617e:	a1 74 1e 11 80       	mov    0x80111e74,%eax
80106183:	83 ec 0c             	sub    $0xc,%esp
80106186:	50                   	push   %eax
80106187:	e8 cd e9 ff ff       	call   80104b59 <randX>
8010618c:	83 c4 10             	add    $0x10,%esp
8010618f:	a3 74 1e 11 80       	mov    %eax,0x80111e74
    return seedX;
80106194:	a1 74 1e 11 80       	mov    0x80111e74,%eax
}
80106199:	c9                   	leave  
8010619a:	c3                   	ret    

8010619b <sys_setSeedX>:

int
sys_setSeedX(void)
{
8010619b:	55                   	push   %ebp
8010619c:	89 e5                	mov    %esp,%ebp
8010619e:	83 ec 18             	sub    $0x18,%esp
    int x;
    if(argint(0, &x) < 0)
801061a1:	83 ec 08             	sub    $0x8,%esp
801061a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061a7:	50                   	push   %eax
801061a8:	6a 00                	push   $0x0
801061aa:	e8 c2 ef ff ff       	call   80105171 <argint>
801061af:	83 c4 10             	add    $0x10,%esp
801061b2:	85 c0                	test   %eax,%eax
801061b4:	79 07                	jns    801061bd <sys_setSeedX+0x22>
        return -1;
801061b6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801061bb:	eb 0d                	jmp    801061ca <sys_setSeedX+0x2f>
    seedX = x;
801061bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801061c0:	a3 74 1e 11 80       	mov    %eax,0x80111e74
    return 23;
801061c5:	b8 17 00 00 00       	mov    $0x17,%eax
}
801061ca:	c9                   	leave  
801061cb:	c3                   	ret    

801061cc <sys_uniformR>:

int
sys_uniformR(void)
{
801061cc:	55                   	push   %ebp
801061cd:	89 e5                	mov    %esp,%ebp
801061cf:	83 ec 18             	sub    $0x18,%esp

    int a, b;
    if(argint(0, &a) < 0 || argint(1, &b) < 0)
801061d2:	83 ec 08             	sub    $0x8,%esp
801061d5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061d8:	50                   	push   %eax
801061d9:	6a 00                	push   $0x0
801061db:	e8 91 ef ff ff       	call   80105171 <argint>
801061e0:	83 c4 10             	add    $0x10,%esp
801061e3:	85 c0                	test   %eax,%eax
801061e5:	78 15                	js     801061fc <sys_uniformR+0x30>
801061e7:	83 ec 08             	sub    $0x8,%esp
801061ea:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061ed:	50                   	push   %eax
801061ee:	6a 01                	push   $0x1
801061f0:	e8 7c ef ff ff       	call   80105171 <argint>
801061f5:	83 c4 10             	add    $0x10,%esp
801061f8:	85 c0                	test   %eax,%eax
801061fa:	79 07                	jns    80106203 <sys_uniformR+0x37>
        return -1;
801061fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106201:	eb 28                	jmp    8010622b <sys_uniformR+0x5f>
    b = b + 1;
80106203:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106206:	83 c0 01             	add    $0x1,%eax
80106209:	89 45 f0             	mov    %eax,-0x10(%ebp)
    seedX = u_random();
8010620c:	e8 55 e9 ff ff       	call   80104b66 <u_random>
80106211:	a3 74 1e 11 80       	mov    %eax,0x80111e74
    return a + seedX % (b-a);
80106216:	a1 74 1e 11 80       	mov    0x80111e74,%eax
8010621b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010621e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106221:	29 d1                	sub    %edx,%ecx
80106223:	99                   	cltd   
80106224:	f7 f9                	idiv   %ecx
80106226:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106229:	01 d0                	add    %edx,%eax

}
8010622b:	c9                   	leave  
8010622c:	c3                   	ret    

8010622d <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010622d:	55                   	push   %ebp
8010622e:	89 e5                	mov    %esp,%ebp
80106230:	83 ec 08             	sub    $0x8,%esp
80106233:	8b 55 08             	mov    0x8(%ebp),%edx
80106236:	8b 45 0c             	mov    0xc(%ebp),%eax
80106239:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
8010623d:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106240:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80106244:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106248:	ee                   	out    %al,(%dx)
}
80106249:	90                   	nop
8010624a:	c9                   	leave  
8010624b:	c3                   	ret    

8010624c <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
8010624c:	55                   	push   %ebp
8010624d:	89 e5                	mov    %esp,%ebp
8010624f:	83 ec 08             	sub    $0x8,%esp
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
80106252:	6a 34                	push   $0x34
80106254:	6a 43                	push   $0x43
80106256:	e8 d2 ff ff ff       	call   8010622d <outb>
8010625b:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
8010625e:	68 9c 00 00 00       	push   $0x9c
80106263:	6a 40                	push   $0x40
80106265:	e8 c3 ff ff ff       	call   8010622d <outb>
8010626a:	83 c4 08             	add    $0x8,%esp
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
8010626d:	6a 2e                	push   $0x2e
8010626f:	6a 40                	push   $0x40
80106271:	e8 b7 ff ff ff       	call   8010622d <outb>
80106276:	83 c4 08             	add    $0x8,%esp
  picenable(IRQ_TIMER);
80106279:	83 ec 0c             	sub    $0xc,%esp
8010627c:	6a 00                	push   $0x0
8010627e:	e8 9b d8 ff ff       	call   80103b1e <picenable>
80106283:	83 c4 10             	add    $0x10,%esp
}
80106286:	90                   	nop
80106287:	c9                   	leave  
80106288:	c3                   	ret    

80106289 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106289:	1e                   	push   %ds
  pushl %es
8010628a:	06                   	push   %es
  pushl %fs
8010628b:	0f a0                	push   %fs
  pushl %gs
8010628d:	0f a8                	push   %gs
  pushal
8010628f:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80106290:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106294:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106296:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80106298:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
8010629c:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
8010629e:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
801062a0:	54                   	push   %esp
  call trap
801062a1:	e8 d7 01 00 00       	call   8010647d <trap>
  addl $4, %esp
801062a6:	83 c4 04             	add    $0x4,%esp

801062a9 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801062a9:	61                   	popa   
  popl %gs
801062aa:	0f a9                	pop    %gs
  popl %fs
801062ac:	0f a1                	pop    %fs
  popl %es
801062ae:	07                   	pop    %es
  popl %ds
801062af:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801062b0:	83 c4 08             	add    $0x8,%esp
  iret
801062b3:	cf                   	iret   

801062b4 <lidt>:

struct gatedesc;

static inline void
lidt(struct gatedesc *p, int size)
{
801062b4:	55                   	push   %ebp
801062b5:	89 e5                	mov    %esp,%ebp
801062b7:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
801062ba:	8b 45 0c             	mov    0xc(%ebp),%eax
801062bd:	83 e8 01             	sub    $0x1,%eax
801062c0:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801062c4:	8b 45 08             	mov    0x8(%ebp),%eax
801062c7:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801062cb:	8b 45 08             	mov    0x8(%ebp),%eax
801062ce:	c1 e8 10             	shr    $0x10,%eax
801062d1:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
801062d5:	8d 45 fa             	lea    -0x6(%ebp),%eax
801062d8:	0f 01 18             	lidtl  (%eax)
}
801062db:	90                   	nop
801062dc:	c9                   	leave  
801062dd:	c3                   	ret    

801062de <rcr2>:
  return result;
}

static inline uint
rcr2(void)
{
801062de:	55                   	push   %ebp
801062df:	89 e5                	mov    %esp,%ebp
801062e1:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801062e4:	0f 20 d0             	mov    %cr2,%eax
801062e7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
801062ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801062ed:	c9                   	leave  
801062ee:	c3                   	ret    

801062ef <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801062ef:	55                   	push   %ebp
801062f0:	89 e5                	mov    %esp,%ebp
801062f2:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
801062f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801062fc:	e9 c3 00 00 00       	jmp    801063c4 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106301:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106304:	8b 04 85 a4 b0 10 80 	mov    -0x7fef4f5c(,%eax,4),%eax
8010630b:	89 c2                	mov    %eax,%edx
8010630d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106310:	66 89 14 c5 c0 1e 11 	mov    %dx,-0x7feee140(,%eax,8)
80106317:	80 
80106318:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010631b:	66 c7 04 c5 c2 1e 11 	movw   $0x8,-0x7feee13e(,%eax,8)
80106322:	80 08 00 
80106325:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106328:	0f b6 14 c5 c4 1e 11 	movzbl -0x7feee13c(,%eax,8),%edx
8010632f:	80 
80106330:	83 e2 e0             	and    $0xffffffe0,%edx
80106333:	88 14 c5 c4 1e 11 80 	mov    %dl,-0x7feee13c(,%eax,8)
8010633a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010633d:	0f b6 14 c5 c4 1e 11 	movzbl -0x7feee13c(,%eax,8),%edx
80106344:	80 
80106345:	83 e2 1f             	and    $0x1f,%edx
80106348:	88 14 c5 c4 1e 11 80 	mov    %dl,-0x7feee13c(,%eax,8)
8010634f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106352:	0f b6 14 c5 c5 1e 11 	movzbl -0x7feee13b(,%eax,8),%edx
80106359:	80 
8010635a:	83 e2 f0             	and    $0xfffffff0,%edx
8010635d:	83 ca 0e             	or     $0xe,%edx
80106360:	88 14 c5 c5 1e 11 80 	mov    %dl,-0x7feee13b(,%eax,8)
80106367:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010636a:	0f b6 14 c5 c5 1e 11 	movzbl -0x7feee13b(,%eax,8),%edx
80106371:	80 
80106372:	83 e2 ef             	and    $0xffffffef,%edx
80106375:	88 14 c5 c5 1e 11 80 	mov    %dl,-0x7feee13b(,%eax,8)
8010637c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010637f:	0f b6 14 c5 c5 1e 11 	movzbl -0x7feee13b(,%eax,8),%edx
80106386:	80 
80106387:	83 e2 9f             	and    $0xffffff9f,%edx
8010638a:	88 14 c5 c5 1e 11 80 	mov    %dl,-0x7feee13b(,%eax,8)
80106391:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106394:	0f b6 14 c5 c5 1e 11 	movzbl -0x7feee13b(,%eax,8),%edx
8010639b:	80 
8010639c:	83 ca 80             	or     $0xffffff80,%edx
8010639f:	88 14 c5 c5 1e 11 80 	mov    %dl,-0x7feee13b(,%eax,8)
801063a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063a9:	8b 04 85 a4 b0 10 80 	mov    -0x7fef4f5c(,%eax,4),%eax
801063b0:	c1 e8 10             	shr    $0x10,%eax
801063b3:	89 c2                	mov    %eax,%edx
801063b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801063b8:	66 89 14 c5 c6 1e 11 	mov    %dx,-0x7feee13a(,%eax,8)
801063bf:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
801063c0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801063c4:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801063cb:	0f 8e 30 ff ff ff    	jle    80106301 <tvinit+0x12>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801063d1:	a1 a4 b1 10 80       	mov    0x8010b1a4,%eax
801063d6:	66 a3 c0 20 11 80    	mov    %ax,0x801120c0
801063dc:	66 c7 05 c2 20 11 80 	movw   $0x8,0x801120c2
801063e3:	08 00 
801063e5:	0f b6 05 c4 20 11 80 	movzbl 0x801120c4,%eax
801063ec:	83 e0 e0             	and    $0xffffffe0,%eax
801063ef:	a2 c4 20 11 80       	mov    %al,0x801120c4
801063f4:	0f b6 05 c4 20 11 80 	movzbl 0x801120c4,%eax
801063fb:	83 e0 1f             	and    $0x1f,%eax
801063fe:	a2 c4 20 11 80       	mov    %al,0x801120c4
80106403:	0f b6 05 c5 20 11 80 	movzbl 0x801120c5,%eax
8010640a:	83 c8 0f             	or     $0xf,%eax
8010640d:	a2 c5 20 11 80       	mov    %al,0x801120c5
80106412:	0f b6 05 c5 20 11 80 	movzbl 0x801120c5,%eax
80106419:	83 e0 ef             	and    $0xffffffef,%eax
8010641c:	a2 c5 20 11 80       	mov    %al,0x801120c5
80106421:	0f b6 05 c5 20 11 80 	movzbl 0x801120c5,%eax
80106428:	83 c8 60             	or     $0x60,%eax
8010642b:	a2 c5 20 11 80       	mov    %al,0x801120c5
80106430:	0f b6 05 c5 20 11 80 	movzbl 0x801120c5,%eax
80106437:	83 c8 80             	or     $0xffffff80,%eax
8010643a:	a2 c5 20 11 80       	mov    %al,0x801120c5
8010643f:	a1 a4 b1 10 80       	mov    0x8010b1a4,%eax
80106444:	c1 e8 10             	shr    $0x10,%eax
80106447:	66 a3 c6 20 11 80    	mov    %ax,0x801120c6
  
  initlock(&tickslock, "time");
8010644d:	83 ec 08             	sub    $0x8,%esp
80106450:	68 cc 85 10 80       	push   $0x801085cc
80106455:	68 80 1e 11 80       	push   $0x80111e80
8010645a:	e8 68 e7 ff ff       	call   80104bc7 <initlock>
8010645f:	83 c4 10             	add    $0x10,%esp
}
80106462:	90                   	nop
80106463:	c9                   	leave  
80106464:	c3                   	ret    

80106465 <idtinit>:

void
idtinit(void)
{
80106465:	55                   	push   %ebp
80106466:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80106468:	68 00 08 00 00       	push   $0x800
8010646d:	68 c0 1e 11 80       	push   $0x80111ec0
80106472:	e8 3d fe ff ff       	call   801062b4 <lidt>
80106477:	83 c4 08             	add    $0x8,%esp
}
8010647a:	90                   	nop
8010647b:	c9                   	leave  
8010647c:	c3                   	ret    

8010647d <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
8010647d:	55                   	push   %ebp
8010647e:	89 e5                	mov    %esp,%ebp
80106480:	57                   	push   %edi
80106481:	56                   	push   %esi
80106482:	53                   	push   %ebx
80106483:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
80106486:	8b 45 08             	mov    0x8(%ebp),%eax
80106489:	8b 40 30             	mov    0x30(%eax),%eax
8010648c:	83 f8 40             	cmp    $0x40,%eax
8010648f:	75 3e                	jne    801064cf <trap+0x52>
    if(proc->killed)
80106491:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106497:	8b 40 24             	mov    0x24(%eax),%eax
8010649a:	85 c0                	test   %eax,%eax
8010649c:	74 05                	je     801064a3 <trap+0x26>
      exit();
8010649e:	e8 f8 df ff ff       	call   8010449b <exit>
    proc->tf = tf;
801064a3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064a9:	8b 55 08             	mov    0x8(%ebp),%edx
801064ac:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801064af:	e8 73 ed ff ff       	call   80105227 <syscall>
    if(proc->killed)
801064b4:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801064ba:	8b 40 24             	mov    0x24(%eax),%eax
801064bd:	85 c0                	test   %eax,%eax
801064bf:	0f 84 1b 02 00 00    	je     801066e0 <trap+0x263>
      exit();
801064c5:	e8 d1 df ff ff       	call   8010449b <exit>
    return;
801064ca:	e9 11 02 00 00       	jmp    801066e0 <trap+0x263>
  }

  switch(tf->trapno){
801064cf:	8b 45 08             	mov    0x8(%ebp),%eax
801064d2:	8b 40 30             	mov    0x30(%eax),%eax
801064d5:	83 e8 20             	sub    $0x20,%eax
801064d8:	83 f8 1f             	cmp    $0x1f,%eax
801064db:	0f 87 c0 00 00 00    	ja     801065a1 <trap+0x124>
801064e1:	8b 04 85 74 86 10 80 	mov    -0x7fef798c(,%eax,4),%eax
801064e8:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpu->id == 0){
801064ea:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801064f0:	0f b6 00             	movzbl (%eax),%eax
801064f3:	84 c0                	test   %al,%al
801064f5:	75 3d                	jne    80106534 <trap+0xb7>
      acquire(&tickslock);
801064f7:	83 ec 0c             	sub    $0xc,%esp
801064fa:	68 80 1e 11 80       	push   $0x80111e80
801064ff:	e8 e5 e6 ff ff       	call   80104be9 <acquire>
80106504:	83 c4 10             	add    $0x10,%esp
      ticks++;
80106507:	a1 c0 26 11 80       	mov    0x801126c0,%eax
8010650c:	83 c0 01             	add    $0x1,%eax
8010650f:	a3 c0 26 11 80       	mov    %eax,0x801126c0
      wakeup(&ticks);
80106514:	83 ec 0c             	sub    $0xc,%esp
80106517:	68 c0 26 11 80       	push   $0x801126c0
8010651c:	e8 84 e4 ff ff       	call   801049a5 <wakeup>
80106521:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80106524:	83 ec 0c             	sub    $0xc,%esp
80106527:	68 80 1e 11 80       	push   $0x80111e80
8010652c:	e8 1f e7 ff ff       	call   80104c50 <release>
80106531:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80106534:	e8 1a ca ff ff       	call   80102f53 <lapiceoi>
    break;
80106539:	e9 1c 01 00 00       	jmp    8010665a <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
8010653e:	e8 40 c2 ff ff       	call   80102783 <ideintr>
    lapiceoi();
80106543:	e8 0b ca ff ff       	call   80102f53 <lapiceoi>
    break;
80106548:	e9 0d 01 00 00       	jmp    8010665a <trap+0x1dd>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
8010654d:	e8 20 c8 ff ff       	call   80102d72 <kbdintr>
    lapiceoi();
80106552:	e8 fc c9 ff ff       	call   80102f53 <lapiceoi>
    break;
80106557:	e9 fe 00 00 00       	jmp    8010665a <trap+0x1dd>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
8010655c:	e8 60 03 00 00       	call   801068c1 <uartintr>
    lapiceoi();
80106561:	e8 ed c9 ff ff       	call   80102f53 <lapiceoi>
    break;
80106566:	e9 ef 00 00 00       	jmp    8010665a <trap+0x1dd>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010656b:	8b 45 08             	mov    0x8(%ebp),%eax
8010656e:	8b 48 38             	mov    0x38(%eax),%ecx
            cpu->id, tf->cs, tf->eip);
80106571:	8b 45 08             	mov    0x8(%ebp),%eax
80106574:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106578:	0f b7 d0             	movzwl %ax,%edx
            cpu->id, tf->cs, tf->eip);
8010657b:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106581:	0f b6 00             	movzbl (%eax),%eax
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106584:	0f b6 c0             	movzbl %al,%eax
80106587:	51                   	push   %ecx
80106588:	52                   	push   %edx
80106589:	50                   	push   %eax
8010658a:	68 d4 85 10 80       	push   $0x801085d4
8010658f:	e8 32 9e ff ff       	call   801003c6 <cprintf>
80106594:	83 c4 10             	add    $0x10,%esp
            cpu->id, tf->cs, tf->eip);
    lapiceoi();
80106597:	e8 b7 c9 ff ff       	call   80102f53 <lapiceoi>
    break;
8010659c:	e9 b9 00 00 00       	jmp    8010665a <trap+0x1dd>
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
801065a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801065a7:	85 c0                	test   %eax,%eax
801065a9:	74 11                	je     801065bc <trap+0x13f>
801065ab:	8b 45 08             	mov    0x8(%ebp),%eax
801065ae:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801065b2:	0f b7 c0             	movzwl %ax,%eax
801065b5:	83 e0 03             	and    $0x3,%eax
801065b8:	85 c0                	test   %eax,%eax
801065ba:	75 40                	jne    801065fc <trap+0x17f>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801065bc:	e8 1d fd ff ff       	call   801062de <rcr2>
801065c1:	89 c3                	mov    %eax,%ebx
801065c3:	8b 45 08             	mov    0x8(%ebp),%eax
801065c6:	8b 48 38             	mov    0x38(%eax),%ecx
              tf->trapno, cpu->id, tf->eip, rcr2());
801065c9:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
801065cf:	0f b6 00             	movzbl (%eax),%eax
   
  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801065d2:	0f b6 d0             	movzbl %al,%edx
801065d5:	8b 45 08             	mov    0x8(%ebp),%eax
801065d8:	8b 40 30             	mov    0x30(%eax),%eax
801065db:	83 ec 0c             	sub    $0xc,%esp
801065de:	53                   	push   %ebx
801065df:	51                   	push   %ecx
801065e0:	52                   	push   %edx
801065e1:	50                   	push   %eax
801065e2:	68 f8 85 10 80       	push   $0x801085f8
801065e7:	e8 da 9d ff ff       	call   801003c6 <cprintf>
801065ec:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
801065ef:	83 ec 0c             	sub    $0xc,%esp
801065f2:	68 2a 86 10 80       	push   $0x8010862a
801065f7:	e8 6a 9f ff ff       	call   80100566 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801065fc:	e8 dd fc ff ff       	call   801062de <rcr2>
80106601:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106604:	8b 45 08             	mov    0x8(%ebp),%eax
80106607:	8b 70 38             	mov    0x38(%eax),%esi
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
8010660a:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106610:	0f b6 00             	movzbl (%eax),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106613:	0f b6 d8             	movzbl %al,%ebx
80106616:	8b 45 08             	mov    0x8(%ebp),%eax
80106619:	8b 48 34             	mov    0x34(%eax),%ecx
8010661c:	8b 45 08             	mov    0x8(%ebp),%eax
8010661f:	8b 50 30             	mov    0x30(%eax),%edx
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
80106622:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106628:	8d 78 6c             	lea    0x6c(%eax),%edi
8010662b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpu->id, tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106631:	8b 40 10             	mov    0x10(%eax),%eax
80106634:	ff 75 e4             	pushl  -0x1c(%ebp)
80106637:	56                   	push   %esi
80106638:	53                   	push   %ebx
80106639:	51                   	push   %ecx
8010663a:	52                   	push   %edx
8010663b:	57                   	push   %edi
8010663c:	50                   	push   %eax
8010663d:	68 30 86 10 80       	push   $0x80108630
80106642:	e8 7f 9d ff ff       	call   801003c6 <cprintf>
80106647:	83 c4 20             	add    $0x20,%esp
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpu->id, tf->eip, 
            rcr2());
    proc->killed = 1;
8010664a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106650:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80106657:	eb 01                	jmp    8010665a <trap+0x1dd>
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
80106659:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running 
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
8010665a:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106660:	85 c0                	test   %eax,%eax
80106662:	74 24                	je     80106688 <trap+0x20b>
80106664:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010666a:	8b 40 24             	mov    0x24(%eax),%eax
8010666d:	85 c0                	test   %eax,%eax
8010666f:	74 17                	je     80106688 <trap+0x20b>
80106671:	8b 45 08             	mov    0x8(%ebp),%eax
80106674:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80106678:	0f b7 c0             	movzwl %ax,%eax
8010667b:	83 e0 03             	and    $0x3,%eax
8010667e:	83 f8 03             	cmp    $0x3,%eax
80106681:	75 05                	jne    80106688 <trap+0x20b>
    exit();
80106683:	e8 13 de ff ff       	call   8010449b <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80106688:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010668e:	85 c0                	test   %eax,%eax
80106690:	74 1e                	je     801066b0 <trap+0x233>
80106692:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80106698:	8b 40 0c             	mov    0xc(%eax),%eax
8010669b:	83 f8 04             	cmp    $0x4,%eax
8010669e:	75 10                	jne    801066b0 <trap+0x233>
801066a0:	8b 45 08             	mov    0x8(%ebp),%eax
801066a3:	8b 40 30             	mov    0x30(%eax),%eax
801066a6:	83 f8 20             	cmp    $0x20,%eax
801066a9:	75 05                	jne    801066b0 <trap+0x233>
    yield();
801066ab:	e8 9e e1 ff ff       	call   8010484e <yield>

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
801066b0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066b6:	85 c0                	test   %eax,%eax
801066b8:	74 27                	je     801066e1 <trap+0x264>
801066ba:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801066c0:	8b 40 24             	mov    0x24(%eax),%eax
801066c3:	85 c0                	test   %eax,%eax
801066c5:	74 1a                	je     801066e1 <trap+0x264>
801066c7:	8b 45 08             	mov    0x8(%ebp),%eax
801066ca:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801066ce:	0f b7 c0             	movzwl %ax,%eax
801066d1:	83 e0 03             	and    $0x3,%eax
801066d4:	83 f8 03             	cmp    $0x3,%eax
801066d7:	75 08                	jne    801066e1 <trap+0x264>
    exit();
801066d9:	e8 bd dd ff ff       	call   8010449b <exit>
801066de:	eb 01                	jmp    801066e1 <trap+0x264>
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
    return;
801066e0:	90                   	nop
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
801066e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066e4:	5b                   	pop    %ebx
801066e5:	5e                   	pop    %esi
801066e6:	5f                   	pop    %edi
801066e7:	5d                   	pop    %ebp
801066e8:	c3                   	ret    

801066e9 <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
801066e9:	55                   	push   %ebp
801066ea:	89 e5                	mov    %esp,%ebp
801066ec:	83 ec 14             	sub    $0x14,%esp
801066ef:	8b 45 08             	mov    0x8(%ebp),%eax
801066f2:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801066f6:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
801066fa:	89 c2                	mov    %eax,%edx
801066fc:	ec                   	in     (%dx),%al
801066fd:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80106700:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80106704:	c9                   	leave  
80106705:	c3                   	ret    

80106706 <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
80106706:	55                   	push   %ebp
80106707:	89 e5                	mov    %esp,%ebp
80106709:	83 ec 08             	sub    $0x8,%esp
8010670c:	8b 55 08             	mov    0x8(%ebp),%edx
8010670f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106712:	66 89 55 fc          	mov    %dx,-0x4(%ebp)
80106716:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106719:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
8010671d:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80106721:	ee                   	out    %al,(%dx)
}
80106722:	90                   	nop
80106723:	c9                   	leave  
80106724:	c3                   	ret    

80106725 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80106725:	55                   	push   %ebp
80106726:	89 e5                	mov    %esp,%ebp
80106728:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
8010672b:	6a 00                	push   $0x0
8010672d:	68 fa 03 00 00       	push   $0x3fa
80106732:	e8 cf ff ff ff       	call   80106706 <outb>
80106737:	83 c4 08             	add    $0x8,%esp
  
  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
8010673a:	68 80 00 00 00       	push   $0x80
8010673f:	68 fb 03 00 00       	push   $0x3fb
80106744:	e8 bd ff ff ff       	call   80106706 <outb>
80106749:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
8010674c:	6a 0c                	push   $0xc
8010674e:	68 f8 03 00 00       	push   $0x3f8
80106753:	e8 ae ff ff ff       	call   80106706 <outb>
80106758:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
8010675b:	6a 00                	push   $0x0
8010675d:	68 f9 03 00 00       	push   $0x3f9
80106762:	e8 9f ff ff ff       	call   80106706 <outb>
80106767:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
8010676a:	6a 03                	push   $0x3
8010676c:	68 fb 03 00 00       	push   $0x3fb
80106771:	e8 90 ff ff ff       	call   80106706 <outb>
80106776:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80106779:	6a 00                	push   $0x0
8010677b:	68 fc 03 00 00       	push   $0x3fc
80106780:	e8 81 ff ff ff       	call   80106706 <outb>
80106785:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80106788:	6a 01                	push   $0x1
8010678a:	68 f9 03 00 00       	push   $0x3f9
8010678f:	e8 72 ff ff ff       	call   80106706 <outb>
80106794:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80106797:	68 fd 03 00 00       	push   $0x3fd
8010679c:	e8 48 ff ff ff       	call   801066e9 <inb>
801067a1:	83 c4 04             	add    $0x4,%esp
801067a4:	3c ff                	cmp    $0xff,%al
801067a6:	74 6e                	je     80106816 <uartinit+0xf1>
    return;
  uart = 1;
801067a8:	c7 05 6c b6 10 80 01 	movl   $0x1,0x8010b66c
801067af:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
801067b2:	68 fa 03 00 00       	push   $0x3fa
801067b7:	e8 2d ff ff ff       	call   801066e9 <inb>
801067bc:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
801067bf:	68 f8 03 00 00       	push   $0x3f8
801067c4:	e8 20 ff ff ff       	call   801066e9 <inb>
801067c9:	83 c4 04             	add    $0x4,%esp
  picenable(IRQ_COM1);
801067cc:	83 ec 0c             	sub    $0xc,%esp
801067cf:	6a 04                	push   $0x4
801067d1:	e8 48 d3 ff ff       	call   80103b1e <picenable>
801067d6:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_COM1, 0);
801067d9:	83 ec 08             	sub    $0x8,%esp
801067dc:	6a 00                	push   $0x0
801067de:	6a 04                	push   $0x4
801067e0:	e8 40 c2 ff ff       	call   80102a25 <ioapicenable>
801067e5:	83 c4 10             	add    $0x10,%esp
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
801067e8:	c7 45 f4 f4 86 10 80 	movl   $0x801086f4,-0xc(%ebp)
801067ef:	eb 19                	jmp    8010680a <uartinit+0xe5>
    uartputc(*p);
801067f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067f4:	0f b6 00             	movzbl (%eax),%eax
801067f7:	0f be c0             	movsbl %al,%eax
801067fa:	83 ec 0c             	sub    $0xc,%esp
801067fd:	50                   	push   %eax
801067fe:	e8 16 00 00 00       	call   80106819 <uartputc>
80106803:	83 c4 10             	add    $0x10,%esp
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80106806:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010680a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010680d:	0f b6 00             	movzbl (%eax),%eax
80106810:	84 c0                	test   %al,%al
80106812:	75 dd                	jne    801067f1 <uartinit+0xcc>
80106814:	eb 01                	jmp    80106817 <uartinit+0xf2>
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
    return;
80106816:	90                   	nop
  ioapicenable(IRQ_COM1, 0);
  
  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}
80106817:	c9                   	leave  
80106818:	c3                   	ret    

80106819 <uartputc>:

void
uartputc(int c)
{
80106819:	55                   	push   %ebp
8010681a:	89 e5                	mov    %esp,%ebp
8010681c:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
8010681f:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106824:	85 c0                	test   %eax,%eax
80106826:	74 53                	je     8010687b <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106828:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010682f:	eb 11                	jmp    80106842 <uartputc+0x29>
    microdelay(10);
80106831:	83 ec 0c             	sub    $0xc,%esp
80106834:	6a 0a                	push   $0xa
80106836:	e8 33 c7 ff ff       	call   80102f6e <microdelay>
8010683b:	83 c4 10             	add    $0x10,%esp
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010683e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106842:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80106846:	7f 1a                	jg     80106862 <uartputc+0x49>
80106848:	83 ec 0c             	sub    $0xc,%esp
8010684b:	68 fd 03 00 00       	push   $0x3fd
80106850:	e8 94 fe ff ff       	call   801066e9 <inb>
80106855:	83 c4 10             	add    $0x10,%esp
80106858:	0f b6 c0             	movzbl %al,%eax
8010685b:	83 e0 20             	and    $0x20,%eax
8010685e:	85 c0                	test   %eax,%eax
80106860:	74 cf                	je     80106831 <uartputc+0x18>
    microdelay(10);
  outb(COM1+0, c);
80106862:	8b 45 08             	mov    0x8(%ebp),%eax
80106865:	0f b6 c0             	movzbl %al,%eax
80106868:	83 ec 08             	sub    $0x8,%esp
8010686b:	50                   	push   %eax
8010686c:	68 f8 03 00 00       	push   $0x3f8
80106871:	e8 90 fe ff ff       	call   80106706 <outb>
80106876:	83 c4 10             	add    $0x10,%esp
80106879:	eb 01                	jmp    8010687c <uartputc+0x63>
uartputc(int c)
{
  int i;

  if(!uart)
    return;
8010687b:	90                   	nop
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
8010687c:	c9                   	leave  
8010687d:	c3                   	ret    

8010687e <uartgetc>:

static int
uartgetc(void)
{
8010687e:	55                   	push   %ebp
8010687f:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106881:	a1 6c b6 10 80       	mov    0x8010b66c,%eax
80106886:	85 c0                	test   %eax,%eax
80106888:	75 07                	jne    80106891 <uartgetc+0x13>
    return -1;
8010688a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010688f:	eb 2e                	jmp    801068bf <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80106891:	68 fd 03 00 00       	push   $0x3fd
80106896:	e8 4e fe ff ff       	call   801066e9 <inb>
8010689b:	83 c4 04             	add    $0x4,%esp
8010689e:	0f b6 c0             	movzbl %al,%eax
801068a1:	83 e0 01             	and    $0x1,%eax
801068a4:	85 c0                	test   %eax,%eax
801068a6:	75 07                	jne    801068af <uartgetc+0x31>
    return -1;
801068a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068ad:	eb 10                	jmp    801068bf <uartgetc+0x41>
  return inb(COM1+0);
801068af:	68 f8 03 00 00       	push   $0x3f8
801068b4:	e8 30 fe ff ff       	call   801066e9 <inb>
801068b9:	83 c4 04             	add    $0x4,%esp
801068bc:	0f b6 c0             	movzbl %al,%eax
}
801068bf:	c9                   	leave  
801068c0:	c3                   	ret    

801068c1 <uartintr>:

void
uartintr(void)
{
801068c1:	55                   	push   %ebp
801068c2:	89 e5                	mov    %esp,%ebp
801068c4:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
801068c7:	83 ec 0c             	sub    $0xc,%esp
801068ca:	68 7e 68 10 80       	push   $0x8010687e
801068cf:	e8 09 9f ff ff       	call   801007dd <consoleintr>
801068d4:	83 c4 10             	add    $0x10,%esp
}
801068d7:	90                   	nop
801068d8:	c9                   	leave  
801068d9:	c3                   	ret    

801068da <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801068da:	6a 00                	push   $0x0
  pushl $0
801068dc:	6a 00                	push   $0x0
  jmp alltraps
801068de:	e9 a6 f9 ff ff       	jmp    80106289 <alltraps>

801068e3 <vector1>:
.globl vector1
vector1:
  pushl $0
801068e3:	6a 00                	push   $0x0
  pushl $1
801068e5:	6a 01                	push   $0x1
  jmp alltraps
801068e7:	e9 9d f9 ff ff       	jmp    80106289 <alltraps>

801068ec <vector2>:
.globl vector2
vector2:
  pushl $0
801068ec:	6a 00                	push   $0x0
  pushl $2
801068ee:	6a 02                	push   $0x2
  jmp alltraps
801068f0:	e9 94 f9 ff ff       	jmp    80106289 <alltraps>

801068f5 <vector3>:
.globl vector3
vector3:
  pushl $0
801068f5:	6a 00                	push   $0x0
  pushl $3
801068f7:	6a 03                	push   $0x3
  jmp alltraps
801068f9:	e9 8b f9 ff ff       	jmp    80106289 <alltraps>

801068fe <vector4>:
.globl vector4
vector4:
  pushl $0
801068fe:	6a 00                	push   $0x0
  pushl $4
80106900:	6a 04                	push   $0x4
  jmp alltraps
80106902:	e9 82 f9 ff ff       	jmp    80106289 <alltraps>

80106907 <vector5>:
.globl vector5
vector5:
  pushl $0
80106907:	6a 00                	push   $0x0
  pushl $5
80106909:	6a 05                	push   $0x5
  jmp alltraps
8010690b:	e9 79 f9 ff ff       	jmp    80106289 <alltraps>

80106910 <vector6>:
.globl vector6
vector6:
  pushl $0
80106910:	6a 00                	push   $0x0
  pushl $6
80106912:	6a 06                	push   $0x6
  jmp alltraps
80106914:	e9 70 f9 ff ff       	jmp    80106289 <alltraps>

80106919 <vector7>:
.globl vector7
vector7:
  pushl $0
80106919:	6a 00                	push   $0x0
  pushl $7
8010691b:	6a 07                	push   $0x7
  jmp alltraps
8010691d:	e9 67 f9 ff ff       	jmp    80106289 <alltraps>

80106922 <vector8>:
.globl vector8
vector8:
  pushl $8
80106922:	6a 08                	push   $0x8
  jmp alltraps
80106924:	e9 60 f9 ff ff       	jmp    80106289 <alltraps>

80106929 <vector9>:
.globl vector9
vector9:
  pushl $0
80106929:	6a 00                	push   $0x0
  pushl $9
8010692b:	6a 09                	push   $0x9
  jmp alltraps
8010692d:	e9 57 f9 ff ff       	jmp    80106289 <alltraps>

80106932 <vector10>:
.globl vector10
vector10:
  pushl $10
80106932:	6a 0a                	push   $0xa
  jmp alltraps
80106934:	e9 50 f9 ff ff       	jmp    80106289 <alltraps>

80106939 <vector11>:
.globl vector11
vector11:
  pushl $11
80106939:	6a 0b                	push   $0xb
  jmp alltraps
8010693b:	e9 49 f9 ff ff       	jmp    80106289 <alltraps>

80106940 <vector12>:
.globl vector12
vector12:
  pushl $12
80106940:	6a 0c                	push   $0xc
  jmp alltraps
80106942:	e9 42 f9 ff ff       	jmp    80106289 <alltraps>

80106947 <vector13>:
.globl vector13
vector13:
  pushl $13
80106947:	6a 0d                	push   $0xd
  jmp alltraps
80106949:	e9 3b f9 ff ff       	jmp    80106289 <alltraps>

8010694e <vector14>:
.globl vector14
vector14:
  pushl $14
8010694e:	6a 0e                	push   $0xe
  jmp alltraps
80106950:	e9 34 f9 ff ff       	jmp    80106289 <alltraps>

80106955 <vector15>:
.globl vector15
vector15:
  pushl $0
80106955:	6a 00                	push   $0x0
  pushl $15
80106957:	6a 0f                	push   $0xf
  jmp alltraps
80106959:	e9 2b f9 ff ff       	jmp    80106289 <alltraps>

8010695e <vector16>:
.globl vector16
vector16:
  pushl $0
8010695e:	6a 00                	push   $0x0
  pushl $16
80106960:	6a 10                	push   $0x10
  jmp alltraps
80106962:	e9 22 f9 ff ff       	jmp    80106289 <alltraps>

80106967 <vector17>:
.globl vector17
vector17:
  pushl $17
80106967:	6a 11                	push   $0x11
  jmp alltraps
80106969:	e9 1b f9 ff ff       	jmp    80106289 <alltraps>

8010696e <vector18>:
.globl vector18
vector18:
  pushl $0
8010696e:	6a 00                	push   $0x0
  pushl $18
80106970:	6a 12                	push   $0x12
  jmp alltraps
80106972:	e9 12 f9 ff ff       	jmp    80106289 <alltraps>

80106977 <vector19>:
.globl vector19
vector19:
  pushl $0
80106977:	6a 00                	push   $0x0
  pushl $19
80106979:	6a 13                	push   $0x13
  jmp alltraps
8010697b:	e9 09 f9 ff ff       	jmp    80106289 <alltraps>

80106980 <vector20>:
.globl vector20
vector20:
  pushl $0
80106980:	6a 00                	push   $0x0
  pushl $20
80106982:	6a 14                	push   $0x14
  jmp alltraps
80106984:	e9 00 f9 ff ff       	jmp    80106289 <alltraps>

80106989 <vector21>:
.globl vector21
vector21:
  pushl $0
80106989:	6a 00                	push   $0x0
  pushl $21
8010698b:	6a 15                	push   $0x15
  jmp alltraps
8010698d:	e9 f7 f8 ff ff       	jmp    80106289 <alltraps>

80106992 <vector22>:
.globl vector22
vector22:
  pushl $0
80106992:	6a 00                	push   $0x0
  pushl $22
80106994:	6a 16                	push   $0x16
  jmp alltraps
80106996:	e9 ee f8 ff ff       	jmp    80106289 <alltraps>

8010699b <vector23>:
.globl vector23
vector23:
  pushl $0
8010699b:	6a 00                	push   $0x0
  pushl $23
8010699d:	6a 17                	push   $0x17
  jmp alltraps
8010699f:	e9 e5 f8 ff ff       	jmp    80106289 <alltraps>

801069a4 <vector24>:
.globl vector24
vector24:
  pushl $0
801069a4:	6a 00                	push   $0x0
  pushl $24
801069a6:	6a 18                	push   $0x18
  jmp alltraps
801069a8:	e9 dc f8 ff ff       	jmp    80106289 <alltraps>

801069ad <vector25>:
.globl vector25
vector25:
  pushl $0
801069ad:	6a 00                	push   $0x0
  pushl $25
801069af:	6a 19                	push   $0x19
  jmp alltraps
801069b1:	e9 d3 f8 ff ff       	jmp    80106289 <alltraps>

801069b6 <vector26>:
.globl vector26
vector26:
  pushl $0
801069b6:	6a 00                	push   $0x0
  pushl $26
801069b8:	6a 1a                	push   $0x1a
  jmp alltraps
801069ba:	e9 ca f8 ff ff       	jmp    80106289 <alltraps>

801069bf <vector27>:
.globl vector27
vector27:
  pushl $0
801069bf:	6a 00                	push   $0x0
  pushl $27
801069c1:	6a 1b                	push   $0x1b
  jmp alltraps
801069c3:	e9 c1 f8 ff ff       	jmp    80106289 <alltraps>

801069c8 <vector28>:
.globl vector28
vector28:
  pushl $0
801069c8:	6a 00                	push   $0x0
  pushl $28
801069ca:	6a 1c                	push   $0x1c
  jmp alltraps
801069cc:	e9 b8 f8 ff ff       	jmp    80106289 <alltraps>

801069d1 <vector29>:
.globl vector29
vector29:
  pushl $0
801069d1:	6a 00                	push   $0x0
  pushl $29
801069d3:	6a 1d                	push   $0x1d
  jmp alltraps
801069d5:	e9 af f8 ff ff       	jmp    80106289 <alltraps>

801069da <vector30>:
.globl vector30
vector30:
  pushl $0
801069da:	6a 00                	push   $0x0
  pushl $30
801069dc:	6a 1e                	push   $0x1e
  jmp alltraps
801069de:	e9 a6 f8 ff ff       	jmp    80106289 <alltraps>

801069e3 <vector31>:
.globl vector31
vector31:
  pushl $0
801069e3:	6a 00                	push   $0x0
  pushl $31
801069e5:	6a 1f                	push   $0x1f
  jmp alltraps
801069e7:	e9 9d f8 ff ff       	jmp    80106289 <alltraps>

801069ec <vector32>:
.globl vector32
vector32:
  pushl $0
801069ec:	6a 00                	push   $0x0
  pushl $32
801069ee:	6a 20                	push   $0x20
  jmp alltraps
801069f0:	e9 94 f8 ff ff       	jmp    80106289 <alltraps>

801069f5 <vector33>:
.globl vector33
vector33:
  pushl $0
801069f5:	6a 00                	push   $0x0
  pushl $33
801069f7:	6a 21                	push   $0x21
  jmp alltraps
801069f9:	e9 8b f8 ff ff       	jmp    80106289 <alltraps>

801069fe <vector34>:
.globl vector34
vector34:
  pushl $0
801069fe:	6a 00                	push   $0x0
  pushl $34
80106a00:	6a 22                	push   $0x22
  jmp alltraps
80106a02:	e9 82 f8 ff ff       	jmp    80106289 <alltraps>

80106a07 <vector35>:
.globl vector35
vector35:
  pushl $0
80106a07:	6a 00                	push   $0x0
  pushl $35
80106a09:	6a 23                	push   $0x23
  jmp alltraps
80106a0b:	e9 79 f8 ff ff       	jmp    80106289 <alltraps>

80106a10 <vector36>:
.globl vector36
vector36:
  pushl $0
80106a10:	6a 00                	push   $0x0
  pushl $36
80106a12:	6a 24                	push   $0x24
  jmp alltraps
80106a14:	e9 70 f8 ff ff       	jmp    80106289 <alltraps>

80106a19 <vector37>:
.globl vector37
vector37:
  pushl $0
80106a19:	6a 00                	push   $0x0
  pushl $37
80106a1b:	6a 25                	push   $0x25
  jmp alltraps
80106a1d:	e9 67 f8 ff ff       	jmp    80106289 <alltraps>

80106a22 <vector38>:
.globl vector38
vector38:
  pushl $0
80106a22:	6a 00                	push   $0x0
  pushl $38
80106a24:	6a 26                	push   $0x26
  jmp alltraps
80106a26:	e9 5e f8 ff ff       	jmp    80106289 <alltraps>

80106a2b <vector39>:
.globl vector39
vector39:
  pushl $0
80106a2b:	6a 00                	push   $0x0
  pushl $39
80106a2d:	6a 27                	push   $0x27
  jmp alltraps
80106a2f:	e9 55 f8 ff ff       	jmp    80106289 <alltraps>

80106a34 <vector40>:
.globl vector40
vector40:
  pushl $0
80106a34:	6a 00                	push   $0x0
  pushl $40
80106a36:	6a 28                	push   $0x28
  jmp alltraps
80106a38:	e9 4c f8 ff ff       	jmp    80106289 <alltraps>

80106a3d <vector41>:
.globl vector41
vector41:
  pushl $0
80106a3d:	6a 00                	push   $0x0
  pushl $41
80106a3f:	6a 29                	push   $0x29
  jmp alltraps
80106a41:	e9 43 f8 ff ff       	jmp    80106289 <alltraps>

80106a46 <vector42>:
.globl vector42
vector42:
  pushl $0
80106a46:	6a 00                	push   $0x0
  pushl $42
80106a48:	6a 2a                	push   $0x2a
  jmp alltraps
80106a4a:	e9 3a f8 ff ff       	jmp    80106289 <alltraps>

80106a4f <vector43>:
.globl vector43
vector43:
  pushl $0
80106a4f:	6a 00                	push   $0x0
  pushl $43
80106a51:	6a 2b                	push   $0x2b
  jmp alltraps
80106a53:	e9 31 f8 ff ff       	jmp    80106289 <alltraps>

80106a58 <vector44>:
.globl vector44
vector44:
  pushl $0
80106a58:	6a 00                	push   $0x0
  pushl $44
80106a5a:	6a 2c                	push   $0x2c
  jmp alltraps
80106a5c:	e9 28 f8 ff ff       	jmp    80106289 <alltraps>

80106a61 <vector45>:
.globl vector45
vector45:
  pushl $0
80106a61:	6a 00                	push   $0x0
  pushl $45
80106a63:	6a 2d                	push   $0x2d
  jmp alltraps
80106a65:	e9 1f f8 ff ff       	jmp    80106289 <alltraps>

80106a6a <vector46>:
.globl vector46
vector46:
  pushl $0
80106a6a:	6a 00                	push   $0x0
  pushl $46
80106a6c:	6a 2e                	push   $0x2e
  jmp alltraps
80106a6e:	e9 16 f8 ff ff       	jmp    80106289 <alltraps>

80106a73 <vector47>:
.globl vector47
vector47:
  pushl $0
80106a73:	6a 00                	push   $0x0
  pushl $47
80106a75:	6a 2f                	push   $0x2f
  jmp alltraps
80106a77:	e9 0d f8 ff ff       	jmp    80106289 <alltraps>

80106a7c <vector48>:
.globl vector48
vector48:
  pushl $0
80106a7c:	6a 00                	push   $0x0
  pushl $48
80106a7e:	6a 30                	push   $0x30
  jmp alltraps
80106a80:	e9 04 f8 ff ff       	jmp    80106289 <alltraps>

80106a85 <vector49>:
.globl vector49
vector49:
  pushl $0
80106a85:	6a 00                	push   $0x0
  pushl $49
80106a87:	6a 31                	push   $0x31
  jmp alltraps
80106a89:	e9 fb f7 ff ff       	jmp    80106289 <alltraps>

80106a8e <vector50>:
.globl vector50
vector50:
  pushl $0
80106a8e:	6a 00                	push   $0x0
  pushl $50
80106a90:	6a 32                	push   $0x32
  jmp alltraps
80106a92:	e9 f2 f7 ff ff       	jmp    80106289 <alltraps>

80106a97 <vector51>:
.globl vector51
vector51:
  pushl $0
80106a97:	6a 00                	push   $0x0
  pushl $51
80106a99:	6a 33                	push   $0x33
  jmp alltraps
80106a9b:	e9 e9 f7 ff ff       	jmp    80106289 <alltraps>

80106aa0 <vector52>:
.globl vector52
vector52:
  pushl $0
80106aa0:	6a 00                	push   $0x0
  pushl $52
80106aa2:	6a 34                	push   $0x34
  jmp alltraps
80106aa4:	e9 e0 f7 ff ff       	jmp    80106289 <alltraps>

80106aa9 <vector53>:
.globl vector53
vector53:
  pushl $0
80106aa9:	6a 00                	push   $0x0
  pushl $53
80106aab:	6a 35                	push   $0x35
  jmp alltraps
80106aad:	e9 d7 f7 ff ff       	jmp    80106289 <alltraps>

80106ab2 <vector54>:
.globl vector54
vector54:
  pushl $0
80106ab2:	6a 00                	push   $0x0
  pushl $54
80106ab4:	6a 36                	push   $0x36
  jmp alltraps
80106ab6:	e9 ce f7 ff ff       	jmp    80106289 <alltraps>

80106abb <vector55>:
.globl vector55
vector55:
  pushl $0
80106abb:	6a 00                	push   $0x0
  pushl $55
80106abd:	6a 37                	push   $0x37
  jmp alltraps
80106abf:	e9 c5 f7 ff ff       	jmp    80106289 <alltraps>

80106ac4 <vector56>:
.globl vector56
vector56:
  pushl $0
80106ac4:	6a 00                	push   $0x0
  pushl $56
80106ac6:	6a 38                	push   $0x38
  jmp alltraps
80106ac8:	e9 bc f7 ff ff       	jmp    80106289 <alltraps>

80106acd <vector57>:
.globl vector57
vector57:
  pushl $0
80106acd:	6a 00                	push   $0x0
  pushl $57
80106acf:	6a 39                	push   $0x39
  jmp alltraps
80106ad1:	e9 b3 f7 ff ff       	jmp    80106289 <alltraps>

80106ad6 <vector58>:
.globl vector58
vector58:
  pushl $0
80106ad6:	6a 00                	push   $0x0
  pushl $58
80106ad8:	6a 3a                	push   $0x3a
  jmp alltraps
80106ada:	e9 aa f7 ff ff       	jmp    80106289 <alltraps>

80106adf <vector59>:
.globl vector59
vector59:
  pushl $0
80106adf:	6a 00                	push   $0x0
  pushl $59
80106ae1:	6a 3b                	push   $0x3b
  jmp alltraps
80106ae3:	e9 a1 f7 ff ff       	jmp    80106289 <alltraps>

80106ae8 <vector60>:
.globl vector60
vector60:
  pushl $0
80106ae8:	6a 00                	push   $0x0
  pushl $60
80106aea:	6a 3c                	push   $0x3c
  jmp alltraps
80106aec:	e9 98 f7 ff ff       	jmp    80106289 <alltraps>

80106af1 <vector61>:
.globl vector61
vector61:
  pushl $0
80106af1:	6a 00                	push   $0x0
  pushl $61
80106af3:	6a 3d                	push   $0x3d
  jmp alltraps
80106af5:	e9 8f f7 ff ff       	jmp    80106289 <alltraps>

80106afa <vector62>:
.globl vector62
vector62:
  pushl $0
80106afa:	6a 00                	push   $0x0
  pushl $62
80106afc:	6a 3e                	push   $0x3e
  jmp alltraps
80106afe:	e9 86 f7 ff ff       	jmp    80106289 <alltraps>

80106b03 <vector63>:
.globl vector63
vector63:
  pushl $0
80106b03:	6a 00                	push   $0x0
  pushl $63
80106b05:	6a 3f                	push   $0x3f
  jmp alltraps
80106b07:	e9 7d f7 ff ff       	jmp    80106289 <alltraps>

80106b0c <vector64>:
.globl vector64
vector64:
  pushl $0
80106b0c:	6a 00                	push   $0x0
  pushl $64
80106b0e:	6a 40                	push   $0x40
  jmp alltraps
80106b10:	e9 74 f7 ff ff       	jmp    80106289 <alltraps>

80106b15 <vector65>:
.globl vector65
vector65:
  pushl $0
80106b15:	6a 00                	push   $0x0
  pushl $65
80106b17:	6a 41                	push   $0x41
  jmp alltraps
80106b19:	e9 6b f7 ff ff       	jmp    80106289 <alltraps>

80106b1e <vector66>:
.globl vector66
vector66:
  pushl $0
80106b1e:	6a 00                	push   $0x0
  pushl $66
80106b20:	6a 42                	push   $0x42
  jmp alltraps
80106b22:	e9 62 f7 ff ff       	jmp    80106289 <alltraps>

80106b27 <vector67>:
.globl vector67
vector67:
  pushl $0
80106b27:	6a 00                	push   $0x0
  pushl $67
80106b29:	6a 43                	push   $0x43
  jmp alltraps
80106b2b:	e9 59 f7 ff ff       	jmp    80106289 <alltraps>

80106b30 <vector68>:
.globl vector68
vector68:
  pushl $0
80106b30:	6a 00                	push   $0x0
  pushl $68
80106b32:	6a 44                	push   $0x44
  jmp alltraps
80106b34:	e9 50 f7 ff ff       	jmp    80106289 <alltraps>

80106b39 <vector69>:
.globl vector69
vector69:
  pushl $0
80106b39:	6a 00                	push   $0x0
  pushl $69
80106b3b:	6a 45                	push   $0x45
  jmp alltraps
80106b3d:	e9 47 f7 ff ff       	jmp    80106289 <alltraps>

80106b42 <vector70>:
.globl vector70
vector70:
  pushl $0
80106b42:	6a 00                	push   $0x0
  pushl $70
80106b44:	6a 46                	push   $0x46
  jmp alltraps
80106b46:	e9 3e f7 ff ff       	jmp    80106289 <alltraps>

80106b4b <vector71>:
.globl vector71
vector71:
  pushl $0
80106b4b:	6a 00                	push   $0x0
  pushl $71
80106b4d:	6a 47                	push   $0x47
  jmp alltraps
80106b4f:	e9 35 f7 ff ff       	jmp    80106289 <alltraps>

80106b54 <vector72>:
.globl vector72
vector72:
  pushl $0
80106b54:	6a 00                	push   $0x0
  pushl $72
80106b56:	6a 48                	push   $0x48
  jmp alltraps
80106b58:	e9 2c f7 ff ff       	jmp    80106289 <alltraps>

80106b5d <vector73>:
.globl vector73
vector73:
  pushl $0
80106b5d:	6a 00                	push   $0x0
  pushl $73
80106b5f:	6a 49                	push   $0x49
  jmp alltraps
80106b61:	e9 23 f7 ff ff       	jmp    80106289 <alltraps>

80106b66 <vector74>:
.globl vector74
vector74:
  pushl $0
80106b66:	6a 00                	push   $0x0
  pushl $74
80106b68:	6a 4a                	push   $0x4a
  jmp alltraps
80106b6a:	e9 1a f7 ff ff       	jmp    80106289 <alltraps>

80106b6f <vector75>:
.globl vector75
vector75:
  pushl $0
80106b6f:	6a 00                	push   $0x0
  pushl $75
80106b71:	6a 4b                	push   $0x4b
  jmp alltraps
80106b73:	e9 11 f7 ff ff       	jmp    80106289 <alltraps>

80106b78 <vector76>:
.globl vector76
vector76:
  pushl $0
80106b78:	6a 00                	push   $0x0
  pushl $76
80106b7a:	6a 4c                	push   $0x4c
  jmp alltraps
80106b7c:	e9 08 f7 ff ff       	jmp    80106289 <alltraps>

80106b81 <vector77>:
.globl vector77
vector77:
  pushl $0
80106b81:	6a 00                	push   $0x0
  pushl $77
80106b83:	6a 4d                	push   $0x4d
  jmp alltraps
80106b85:	e9 ff f6 ff ff       	jmp    80106289 <alltraps>

80106b8a <vector78>:
.globl vector78
vector78:
  pushl $0
80106b8a:	6a 00                	push   $0x0
  pushl $78
80106b8c:	6a 4e                	push   $0x4e
  jmp alltraps
80106b8e:	e9 f6 f6 ff ff       	jmp    80106289 <alltraps>

80106b93 <vector79>:
.globl vector79
vector79:
  pushl $0
80106b93:	6a 00                	push   $0x0
  pushl $79
80106b95:	6a 4f                	push   $0x4f
  jmp alltraps
80106b97:	e9 ed f6 ff ff       	jmp    80106289 <alltraps>

80106b9c <vector80>:
.globl vector80
vector80:
  pushl $0
80106b9c:	6a 00                	push   $0x0
  pushl $80
80106b9e:	6a 50                	push   $0x50
  jmp alltraps
80106ba0:	e9 e4 f6 ff ff       	jmp    80106289 <alltraps>

80106ba5 <vector81>:
.globl vector81
vector81:
  pushl $0
80106ba5:	6a 00                	push   $0x0
  pushl $81
80106ba7:	6a 51                	push   $0x51
  jmp alltraps
80106ba9:	e9 db f6 ff ff       	jmp    80106289 <alltraps>

80106bae <vector82>:
.globl vector82
vector82:
  pushl $0
80106bae:	6a 00                	push   $0x0
  pushl $82
80106bb0:	6a 52                	push   $0x52
  jmp alltraps
80106bb2:	e9 d2 f6 ff ff       	jmp    80106289 <alltraps>

80106bb7 <vector83>:
.globl vector83
vector83:
  pushl $0
80106bb7:	6a 00                	push   $0x0
  pushl $83
80106bb9:	6a 53                	push   $0x53
  jmp alltraps
80106bbb:	e9 c9 f6 ff ff       	jmp    80106289 <alltraps>

80106bc0 <vector84>:
.globl vector84
vector84:
  pushl $0
80106bc0:	6a 00                	push   $0x0
  pushl $84
80106bc2:	6a 54                	push   $0x54
  jmp alltraps
80106bc4:	e9 c0 f6 ff ff       	jmp    80106289 <alltraps>

80106bc9 <vector85>:
.globl vector85
vector85:
  pushl $0
80106bc9:	6a 00                	push   $0x0
  pushl $85
80106bcb:	6a 55                	push   $0x55
  jmp alltraps
80106bcd:	e9 b7 f6 ff ff       	jmp    80106289 <alltraps>

80106bd2 <vector86>:
.globl vector86
vector86:
  pushl $0
80106bd2:	6a 00                	push   $0x0
  pushl $86
80106bd4:	6a 56                	push   $0x56
  jmp alltraps
80106bd6:	e9 ae f6 ff ff       	jmp    80106289 <alltraps>

80106bdb <vector87>:
.globl vector87
vector87:
  pushl $0
80106bdb:	6a 00                	push   $0x0
  pushl $87
80106bdd:	6a 57                	push   $0x57
  jmp alltraps
80106bdf:	e9 a5 f6 ff ff       	jmp    80106289 <alltraps>

80106be4 <vector88>:
.globl vector88
vector88:
  pushl $0
80106be4:	6a 00                	push   $0x0
  pushl $88
80106be6:	6a 58                	push   $0x58
  jmp alltraps
80106be8:	e9 9c f6 ff ff       	jmp    80106289 <alltraps>

80106bed <vector89>:
.globl vector89
vector89:
  pushl $0
80106bed:	6a 00                	push   $0x0
  pushl $89
80106bef:	6a 59                	push   $0x59
  jmp alltraps
80106bf1:	e9 93 f6 ff ff       	jmp    80106289 <alltraps>

80106bf6 <vector90>:
.globl vector90
vector90:
  pushl $0
80106bf6:	6a 00                	push   $0x0
  pushl $90
80106bf8:	6a 5a                	push   $0x5a
  jmp alltraps
80106bfa:	e9 8a f6 ff ff       	jmp    80106289 <alltraps>

80106bff <vector91>:
.globl vector91
vector91:
  pushl $0
80106bff:	6a 00                	push   $0x0
  pushl $91
80106c01:	6a 5b                	push   $0x5b
  jmp alltraps
80106c03:	e9 81 f6 ff ff       	jmp    80106289 <alltraps>

80106c08 <vector92>:
.globl vector92
vector92:
  pushl $0
80106c08:	6a 00                	push   $0x0
  pushl $92
80106c0a:	6a 5c                	push   $0x5c
  jmp alltraps
80106c0c:	e9 78 f6 ff ff       	jmp    80106289 <alltraps>

80106c11 <vector93>:
.globl vector93
vector93:
  pushl $0
80106c11:	6a 00                	push   $0x0
  pushl $93
80106c13:	6a 5d                	push   $0x5d
  jmp alltraps
80106c15:	e9 6f f6 ff ff       	jmp    80106289 <alltraps>

80106c1a <vector94>:
.globl vector94
vector94:
  pushl $0
80106c1a:	6a 00                	push   $0x0
  pushl $94
80106c1c:	6a 5e                	push   $0x5e
  jmp alltraps
80106c1e:	e9 66 f6 ff ff       	jmp    80106289 <alltraps>

80106c23 <vector95>:
.globl vector95
vector95:
  pushl $0
80106c23:	6a 00                	push   $0x0
  pushl $95
80106c25:	6a 5f                	push   $0x5f
  jmp alltraps
80106c27:	e9 5d f6 ff ff       	jmp    80106289 <alltraps>

80106c2c <vector96>:
.globl vector96
vector96:
  pushl $0
80106c2c:	6a 00                	push   $0x0
  pushl $96
80106c2e:	6a 60                	push   $0x60
  jmp alltraps
80106c30:	e9 54 f6 ff ff       	jmp    80106289 <alltraps>

80106c35 <vector97>:
.globl vector97
vector97:
  pushl $0
80106c35:	6a 00                	push   $0x0
  pushl $97
80106c37:	6a 61                	push   $0x61
  jmp alltraps
80106c39:	e9 4b f6 ff ff       	jmp    80106289 <alltraps>

80106c3e <vector98>:
.globl vector98
vector98:
  pushl $0
80106c3e:	6a 00                	push   $0x0
  pushl $98
80106c40:	6a 62                	push   $0x62
  jmp alltraps
80106c42:	e9 42 f6 ff ff       	jmp    80106289 <alltraps>

80106c47 <vector99>:
.globl vector99
vector99:
  pushl $0
80106c47:	6a 00                	push   $0x0
  pushl $99
80106c49:	6a 63                	push   $0x63
  jmp alltraps
80106c4b:	e9 39 f6 ff ff       	jmp    80106289 <alltraps>

80106c50 <vector100>:
.globl vector100
vector100:
  pushl $0
80106c50:	6a 00                	push   $0x0
  pushl $100
80106c52:	6a 64                	push   $0x64
  jmp alltraps
80106c54:	e9 30 f6 ff ff       	jmp    80106289 <alltraps>

80106c59 <vector101>:
.globl vector101
vector101:
  pushl $0
80106c59:	6a 00                	push   $0x0
  pushl $101
80106c5b:	6a 65                	push   $0x65
  jmp alltraps
80106c5d:	e9 27 f6 ff ff       	jmp    80106289 <alltraps>

80106c62 <vector102>:
.globl vector102
vector102:
  pushl $0
80106c62:	6a 00                	push   $0x0
  pushl $102
80106c64:	6a 66                	push   $0x66
  jmp alltraps
80106c66:	e9 1e f6 ff ff       	jmp    80106289 <alltraps>

80106c6b <vector103>:
.globl vector103
vector103:
  pushl $0
80106c6b:	6a 00                	push   $0x0
  pushl $103
80106c6d:	6a 67                	push   $0x67
  jmp alltraps
80106c6f:	e9 15 f6 ff ff       	jmp    80106289 <alltraps>

80106c74 <vector104>:
.globl vector104
vector104:
  pushl $0
80106c74:	6a 00                	push   $0x0
  pushl $104
80106c76:	6a 68                	push   $0x68
  jmp alltraps
80106c78:	e9 0c f6 ff ff       	jmp    80106289 <alltraps>

80106c7d <vector105>:
.globl vector105
vector105:
  pushl $0
80106c7d:	6a 00                	push   $0x0
  pushl $105
80106c7f:	6a 69                	push   $0x69
  jmp alltraps
80106c81:	e9 03 f6 ff ff       	jmp    80106289 <alltraps>

80106c86 <vector106>:
.globl vector106
vector106:
  pushl $0
80106c86:	6a 00                	push   $0x0
  pushl $106
80106c88:	6a 6a                	push   $0x6a
  jmp alltraps
80106c8a:	e9 fa f5 ff ff       	jmp    80106289 <alltraps>

80106c8f <vector107>:
.globl vector107
vector107:
  pushl $0
80106c8f:	6a 00                	push   $0x0
  pushl $107
80106c91:	6a 6b                	push   $0x6b
  jmp alltraps
80106c93:	e9 f1 f5 ff ff       	jmp    80106289 <alltraps>

80106c98 <vector108>:
.globl vector108
vector108:
  pushl $0
80106c98:	6a 00                	push   $0x0
  pushl $108
80106c9a:	6a 6c                	push   $0x6c
  jmp alltraps
80106c9c:	e9 e8 f5 ff ff       	jmp    80106289 <alltraps>

80106ca1 <vector109>:
.globl vector109
vector109:
  pushl $0
80106ca1:	6a 00                	push   $0x0
  pushl $109
80106ca3:	6a 6d                	push   $0x6d
  jmp alltraps
80106ca5:	e9 df f5 ff ff       	jmp    80106289 <alltraps>

80106caa <vector110>:
.globl vector110
vector110:
  pushl $0
80106caa:	6a 00                	push   $0x0
  pushl $110
80106cac:	6a 6e                	push   $0x6e
  jmp alltraps
80106cae:	e9 d6 f5 ff ff       	jmp    80106289 <alltraps>

80106cb3 <vector111>:
.globl vector111
vector111:
  pushl $0
80106cb3:	6a 00                	push   $0x0
  pushl $111
80106cb5:	6a 6f                	push   $0x6f
  jmp alltraps
80106cb7:	e9 cd f5 ff ff       	jmp    80106289 <alltraps>

80106cbc <vector112>:
.globl vector112
vector112:
  pushl $0
80106cbc:	6a 00                	push   $0x0
  pushl $112
80106cbe:	6a 70                	push   $0x70
  jmp alltraps
80106cc0:	e9 c4 f5 ff ff       	jmp    80106289 <alltraps>

80106cc5 <vector113>:
.globl vector113
vector113:
  pushl $0
80106cc5:	6a 00                	push   $0x0
  pushl $113
80106cc7:	6a 71                	push   $0x71
  jmp alltraps
80106cc9:	e9 bb f5 ff ff       	jmp    80106289 <alltraps>

80106cce <vector114>:
.globl vector114
vector114:
  pushl $0
80106cce:	6a 00                	push   $0x0
  pushl $114
80106cd0:	6a 72                	push   $0x72
  jmp alltraps
80106cd2:	e9 b2 f5 ff ff       	jmp    80106289 <alltraps>

80106cd7 <vector115>:
.globl vector115
vector115:
  pushl $0
80106cd7:	6a 00                	push   $0x0
  pushl $115
80106cd9:	6a 73                	push   $0x73
  jmp alltraps
80106cdb:	e9 a9 f5 ff ff       	jmp    80106289 <alltraps>

80106ce0 <vector116>:
.globl vector116
vector116:
  pushl $0
80106ce0:	6a 00                	push   $0x0
  pushl $116
80106ce2:	6a 74                	push   $0x74
  jmp alltraps
80106ce4:	e9 a0 f5 ff ff       	jmp    80106289 <alltraps>

80106ce9 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ce9:	6a 00                	push   $0x0
  pushl $117
80106ceb:	6a 75                	push   $0x75
  jmp alltraps
80106ced:	e9 97 f5 ff ff       	jmp    80106289 <alltraps>

80106cf2 <vector118>:
.globl vector118
vector118:
  pushl $0
80106cf2:	6a 00                	push   $0x0
  pushl $118
80106cf4:	6a 76                	push   $0x76
  jmp alltraps
80106cf6:	e9 8e f5 ff ff       	jmp    80106289 <alltraps>

80106cfb <vector119>:
.globl vector119
vector119:
  pushl $0
80106cfb:	6a 00                	push   $0x0
  pushl $119
80106cfd:	6a 77                	push   $0x77
  jmp alltraps
80106cff:	e9 85 f5 ff ff       	jmp    80106289 <alltraps>

80106d04 <vector120>:
.globl vector120
vector120:
  pushl $0
80106d04:	6a 00                	push   $0x0
  pushl $120
80106d06:	6a 78                	push   $0x78
  jmp alltraps
80106d08:	e9 7c f5 ff ff       	jmp    80106289 <alltraps>

80106d0d <vector121>:
.globl vector121
vector121:
  pushl $0
80106d0d:	6a 00                	push   $0x0
  pushl $121
80106d0f:	6a 79                	push   $0x79
  jmp alltraps
80106d11:	e9 73 f5 ff ff       	jmp    80106289 <alltraps>

80106d16 <vector122>:
.globl vector122
vector122:
  pushl $0
80106d16:	6a 00                	push   $0x0
  pushl $122
80106d18:	6a 7a                	push   $0x7a
  jmp alltraps
80106d1a:	e9 6a f5 ff ff       	jmp    80106289 <alltraps>

80106d1f <vector123>:
.globl vector123
vector123:
  pushl $0
80106d1f:	6a 00                	push   $0x0
  pushl $123
80106d21:	6a 7b                	push   $0x7b
  jmp alltraps
80106d23:	e9 61 f5 ff ff       	jmp    80106289 <alltraps>

80106d28 <vector124>:
.globl vector124
vector124:
  pushl $0
80106d28:	6a 00                	push   $0x0
  pushl $124
80106d2a:	6a 7c                	push   $0x7c
  jmp alltraps
80106d2c:	e9 58 f5 ff ff       	jmp    80106289 <alltraps>

80106d31 <vector125>:
.globl vector125
vector125:
  pushl $0
80106d31:	6a 00                	push   $0x0
  pushl $125
80106d33:	6a 7d                	push   $0x7d
  jmp alltraps
80106d35:	e9 4f f5 ff ff       	jmp    80106289 <alltraps>

80106d3a <vector126>:
.globl vector126
vector126:
  pushl $0
80106d3a:	6a 00                	push   $0x0
  pushl $126
80106d3c:	6a 7e                	push   $0x7e
  jmp alltraps
80106d3e:	e9 46 f5 ff ff       	jmp    80106289 <alltraps>

80106d43 <vector127>:
.globl vector127
vector127:
  pushl $0
80106d43:	6a 00                	push   $0x0
  pushl $127
80106d45:	6a 7f                	push   $0x7f
  jmp alltraps
80106d47:	e9 3d f5 ff ff       	jmp    80106289 <alltraps>

80106d4c <vector128>:
.globl vector128
vector128:
  pushl $0
80106d4c:	6a 00                	push   $0x0
  pushl $128
80106d4e:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106d53:	e9 31 f5 ff ff       	jmp    80106289 <alltraps>

80106d58 <vector129>:
.globl vector129
vector129:
  pushl $0
80106d58:	6a 00                	push   $0x0
  pushl $129
80106d5a:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106d5f:	e9 25 f5 ff ff       	jmp    80106289 <alltraps>

80106d64 <vector130>:
.globl vector130
vector130:
  pushl $0
80106d64:	6a 00                	push   $0x0
  pushl $130
80106d66:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106d6b:	e9 19 f5 ff ff       	jmp    80106289 <alltraps>

80106d70 <vector131>:
.globl vector131
vector131:
  pushl $0
80106d70:	6a 00                	push   $0x0
  pushl $131
80106d72:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106d77:	e9 0d f5 ff ff       	jmp    80106289 <alltraps>

80106d7c <vector132>:
.globl vector132
vector132:
  pushl $0
80106d7c:	6a 00                	push   $0x0
  pushl $132
80106d7e:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106d83:	e9 01 f5 ff ff       	jmp    80106289 <alltraps>

80106d88 <vector133>:
.globl vector133
vector133:
  pushl $0
80106d88:	6a 00                	push   $0x0
  pushl $133
80106d8a:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106d8f:	e9 f5 f4 ff ff       	jmp    80106289 <alltraps>

80106d94 <vector134>:
.globl vector134
vector134:
  pushl $0
80106d94:	6a 00                	push   $0x0
  pushl $134
80106d96:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106d9b:	e9 e9 f4 ff ff       	jmp    80106289 <alltraps>

80106da0 <vector135>:
.globl vector135
vector135:
  pushl $0
80106da0:	6a 00                	push   $0x0
  pushl $135
80106da2:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106da7:	e9 dd f4 ff ff       	jmp    80106289 <alltraps>

80106dac <vector136>:
.globl vector136
vector136:
  pushl $0
80106dac:	6a 00                	push   $0x0
  pushl $136
80106dae:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106db3:	e9 d1 f4 ff ff       	jmp    80106289 <alltraps>

80106db8 <vector137>:
.globl vector137
vector137:
  pushl $0
80106db8:	6a 00                	push   $0x0
  pushl $137
80106dba:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106dbf:	e9 c5 f4 ff ff       	jmp    80106289 <alltraps>

80106dc4 <vector138>:
.globl vector138
vector138:
  pushl $0
80106dc4:	6a 00                	push   $0x0
  pushl $138
80106dc6:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106dcb:	e9 b9 f4 ff ff       	jmp    80106289 <alltraps>

80106dd0 <vector139>:
.globl vector139
vector139:
  pushl $0
80106dd0:	6a 00                	push   $0x0
  pushl $139
80106dd2:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106dd7:	e9 ad f4 ff ff       	jmp    80106289 <alltraps>

80106ddc <vector140>:
.globl vector140
vector140:
  pushl $0
80106ddc:	6a 00                	push   $0x0
  pushl $140
80106dde:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106de3:	e9 a1 f4 ff ff       	jmp    80106289 <alltraps>

80106de8 <vector141>:
.globl vector141
vector141:
  pushl $0
80106de8:	6a 00                	push   $0x0
  pushl $141
80106dea:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106def:	e9 95 f4 ff ff       	jmp    80106289 <alltraps>

80106df4 <vector142>:
.globl vector142
vector142:
  pushl $0
80106df4:	6a 00                	push   $0x0
  pushl $142
80106df6:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106dfb:	e9 89 f4 ff ff       	jmp    80106289 <alltraps>

80106e00 <vector143>:
.globl vector143
vector143:
  pushl $0
80106e00:	6a 00                	push   $0x0
  pushl $143
80106e02:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106e07:	e9 7d f4 ff ff       	jmp    80106289 <alltraps>

80106e0c <vector144>:
.globl vector144
vector144:
  pushl $0
80106e0c:	6a 00                	push   $0x0
  pushl $144
80106e0e:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106e13:	e9 71 f4 ff ff       	jmp    80106289 <alltraps>

80106e18 <vector145>:
.globl vector145
vector145:
  pushl $0
80106e18:	6a 00                	push   $0x0
  pushl $145
80106e1a:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106e1f:	e9 65 f4 ff ff       	jmp    80106289 <alltraps>

80106e24 <vector146>:
.globl vector146
vector146:
  pushl $0
80106e24:	6a 00                	push   $0x0
  pushl $146
80106e26:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106e2b:	e9 59 f4 ff ff       	jmp    80106289 <alltraps>

80106e30 <vector147>:
.globl vector147
vector147:
  pushl $0
80106e30:	6a 00                	push   $0x0
  pushl $147
80106e32:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106e37:	e9 4d f4 ff ff       	jmp    80106289 <alltraps>

80106e3c <vector148>:
.globl vector148
vector148:
  pushl $0
80106e3c:	6a 00                	push   $0x0
  pushl $148
80106e3e:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106e43:	e9 41 f4 ff ff       	jmp    80106289 <alltraps>

80106e48 <vector149>:
.globl vector149
vector149:
  pushl $0
80106e48:	6a 00                	push   $0x0
  pushl $149
80106e4a:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106e4f:	e9 35 f4 ff ff       	jmp    80106289 <alltraps>

80106e54 <vector150>:
.globl vector150
vector150:
  pushl $0
80106e54:	6a 00                	push   $0x0
  pushl $150
80106e56:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106e5b:	e9 29 f4 ff ff       	jmp    80106289 <alltraps>

80106e60 <vector151>:
.globl vector151
vector151:
  pushl $0
80106e60:	6a 00                	push   $0x0
  pushl $151
80106e62:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106e67:	e9 1d f4 ff ff       	jmp    80106289 <alltraps>

80106e6c <vector152>:
.globl vector152
vector152:
  pushl $0
80106e6c:	6a 00                	push   $0x0
  pushl $152
80106e6e:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106e73:	e9 11 f4 ff ff       	jmp    80106289 <alltraps>

80106e78 <vector153>:
.globl vector153
vector153:
  pushl $0
80106e78:	6a 00                	push   $0x0
  pushl $153
80106e7a:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106e7f:	e9 05 f4 ff ff       	jmp    80106289 <alltraps>

80106e84 <vector154>:
.globl vector154
vector154:
  pushl $0
80106e84:	6a 00                	push   $0x0
  pushl $154
80106e86:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106e8b:	e9 f9 f3 ff ff       	jmp    80106289 <alltraps>

80106e90 <vector155>:
.globl vector155
vector155:
  pushl $0
80106e90:	6a 00                	push   $0x0
  pushl $155
80106e92:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106e97:	e9 ed f3 ff ff       	jmp    80106289 <alltraps>

80106e9c <vector156>:
.globl vector156
vector156:
  pushl $0
80106e9c:	6a 00                	push   $0x0
  pushl $156
80106e9e:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106ea3:	e9 e1 f3 ff ff       	jmp    80106289 <alltraps>

80106ea8 <vector157>:
.globl vector157
vector157:
  pushl $0
80106ea8:	6a 00                	push   $0x0
  pushl $157
80106eaa:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106eaf:	e9 d5 f3 ff ff       	jmp    80106289 <alltraps>

80106eb4 <vector158>:
.globl vector158
vector158:
  pushl $0
80106eb4:	6a 00                	push   $0x0
  pushl $158
80106eb6:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106ebb:	e9 c9 f3 ff ff       	jmp    80106289 <alltraps>

80106ec0 <vector159>:
.globl vector159
vector159:
  pushl $0
80106ec0:	6a 00                	push   $0x0
  pushl $159
80106ec2:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106ec7:	e9 bd f3 ff ff       	jmp    80106289 <alltraps>

80106ecc <vector160>:
.globl vector160
vector160:
  pushl $0
80106ecc:	6a 00                	push   $0x0
  pushl $160
80106ece:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106ed3:	e9 b1 f3 ff ff       	jmp    80106289 <alltraps>

80106ed8 <vector161>:
.globl vector161
vector161:
  pushl $0
80106ed8:	6a 00                	push   $0x0
  pushl $161
80106eda:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106edf:	e9 a5 f3 ff ff       	jmp    80106289 <alltraps>

80106ee4 <vector162>:
.globl vector162
vector162:
  pushl $0
80106ee4:	6a 00                	push   $0x0
  pushl $162
80106ee6:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106eeb:	e9 99 f3 ff ff       	jmp    80106289 <alltraps>

80106ef0 <vector163>:
.globl vector163
vector163:
  pushl $0
80106ef0:	6a 00                	push   $0x0
  pushl $163
80106ef2:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106ef7:	e9 8d f3 ff ff       	jmp    80106289 <alltraps>

80106efc <vector164>:
.globl vector164
vector164:
  pushl $0
80106efc:	6a 00                	push   $0x0
  pushl $164
80106efe:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106f03:	e9 81 f3 ff ff       	jmp    80106289 <alltraps>

80106f08 <vector165>:
.globl vector165
vector165:
  pushl $0
80106f08:	6a 00                	push   $0x0
  pushl $165
80106f0a:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106f0f:	e9 75 f3 ff ff       	jmp    80106289 <alltraps>

80106f14 <vector166>:
.globl vector166
vector166:
  pushl $0
80106f14:	6a 00                	push   $0x0
  pushl $166
80106f16:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106f1b:	e9 69 f3 ff ff       	jmp    80106289 <alltraps>

80106f20 <vector167>:
.globl vector167
vector167:
  pushl $0
80106f20:	6a 00                	push   $0x0
  pushl $167
80106f22:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106f27:	e9 5d f3 ff ff       	jmp    80106289 <alltraps>

80106f2c <vector168>:
.globl vector168
vector168:
  pushl $0
80106f2c:	6a 00                	push   $0x0
  pushl $168
80106f2e:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106f33:	e9 51 f3 ff ff       	jmp    80106289 <alltraps>

80106f38 <vector169>:
.globl vector169
vector169:
  pushl $0
80106f38:	6a 00                	push   $0x0
  pushl $169
80106f3a:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106f3f:	e9 45 f3 ff ff       	jmp    80106289 <alltraps>

80106f44 <vector170>:
.globl vector170
vector170:
  pushl $0
80106f44:	6a 00                	push   $0x0
  pushl $170
80106f46:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106f4b:	e9 39 f3 ff ff       	jmp    80106289 <alltraps>

80106f50 <vector171>:
.globl vector171
vector171:
  pushl $0
80106f50:	6a 00                	push   $0x0
  pushl $171
80106f52:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106f57:	e9 2d f3 ff ff       	jmp    80106289 <alltraps>

80106f5c <vector172>:
.globl vector172
vector172:
  pushl $0
80106f5c:	6a 00                	push   $0x0
  pushl $172
80106f5e:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106f63:	e9 21 f3 ff ff       	jmp    80106289 <alltraps>

80106f68 <vector173>:
.globl vector173
vector173:
  pushl $0
80106f68:	6a 00                	push   $0x0
  pushl $173
80106f6a:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106f6f:	e9 15 f3 ff ff       	jmp    80106289 <alltraps>

80106f74 <vector174>:
.globl vector174
vector174:
  pushl $0
80106f74:	6a 00                	push   $0x0
  pushl $174
80106f76:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106f7b:	e9 09 f3 ff ff       	jmp    80106289 <alltraps>

80106f80 <vector175>:
.globl vector175
vector175:
  pushl $0
80106f80:	6a 00                	push   $0x0
  pushl $175
80106f82:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106f87:	e9 fd f2 ff ff       	jmp    80106289 <alltraps>

80106f8c <vector176>:
.globl vector176
vector176:
  pushl $0
80106f8c:	6a 00                	push   $0x0
  pushl $176
80106f8e:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106f93:	e9 f1 f2 ff ff       	jmp    80106289 <alltraps>

80106f98 <vector177>:
.globl vector177
vector177:
  pushl $0
80106f98:	6a 00                	push   $0x0
  pushl $177
80106f9a:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106f9f:	e9 e5 f2 ff ff       	jmp    80106289 <alltraps>

80106fa4 <vector178>:
.globl vector178
vector178:
  pushl $0
80106fa4:	6a 00                	push   $0x0
  pushl $178
80106fa6:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106fab:	e9 d9 f2 ff ff       	jmp    80106289 <alltraps>

80106fb0 <vector179>:
.globl vector179
vector179:
  pushl $0
80106fb0:	6a 00                	push   $0x0
  pushl $179
80106fb2:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106fb7:	e9 cd f2 ff ff       	jmp    80106289 <alltraps>

80106fbc <vector180>:
.globl vector180
vector180:
  pushl $0
80106fbc:	6a 00                	push   $0x0
  pushl $180
80106fbe:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106fc3:	e9 c1 f2 ff ff       	jmp    80106289 <alltraps>

80106fc8 <vector181>:
.globl vector181
vector181:
  pushl $0
80106fc8:	6a 00                	push   $0x0
  pushl $181
80106fca:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106fcf:	e9 b5 f2 ff ff       	jmp    80106289 <alltraps>

80106fd4 <vector182>:
.globl vector182
vector182:
  pushl $0
80106fd4:	6a 00                	push   $0x0
  pushl $182
80106fd6:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106fdb:	e9 a9 f2 ff ff       	jmp    80106289 <alltraps>

80106fe0 <vector183>:
.globl vector183
vector183:
  pushl $0
80106fe0:	6a 00                	push   $0x0
  pushl $183
80106fe2:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106fe7:	e9 9d f2 ff ff       	jmp    80106289 <alltraps>

80106fec <vector184>:
.globl vector184
vector184:
  pushl $0
80106fec:	6a 00                	push   $0x0
  pushl $184
80106fee:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106ff3:	e9 91 f2 ff ff       	jmp    80106289 <alltraps>

80106ff8 <vector185>:
.globl vector185
vector185:
  pushl $0
80106ff8:	6a 00                	push   $0x0
  pushl $185
80106ffa:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106fff:	e9 85 f2 ff ff       	jmp    80106289 <alltraps>

80107004 <vector186>:
.globl vector186
vector186:
  pushl $0
80107004:	6a 00                	push   $0x0
  pushl $186
80107006:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
8010700b:	e9 79 f2 ff ff       	jmp    80106289 <alltraps>

80107010 <vector187>:
.globl vector187
vector187:
  pushl $0
80107010:	6a 00                	push   $0x0
  pushl $187
80107012:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107017:	e9 6d f2 ff ff       	jmp    80106289 <alltraps>

8010701c <vector188>:
.globl vector188
vector188:
  pushl $0
8010701c:	6a 00                	push   $0x0
  pushl $188
8010701e:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107023:	e9 61 f2 ff ff       	jmp    80106289 <alltraps>

80107028 <vector189>:
.globl vector189
vector189:
  pushl $0
80107028:	6a 00                	push   $0x0
  pushl $189
8010702a:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010702f:	e9 55 f2 ff ff       	jmp    80106289 <alltraps>

80107034 <vector190>:
.globl vector190
vector190:
  pushl $0
80107034:	6a 00                	push   $0x0
  pushl $190
80107036:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010703b:	e9 49 f2 ff ff       	jmp    80106289 <alltraps>

80107040 <vector191>:
.globl vector191
vector191:
  pushl $0
80107040:	6a 00                	push   $0x0
  pushl $191
80107042:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107047:	e9 3d f2 ff ff       	jmp    80106289 <alltraps>

8010704c <vector192>:
.globl vector192
vector192:
  pushl $0
8010704c:	6a 00                	push   $0x0
  pushl $192
8010704e:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107053:	e9 31 f2 ff ff       	jmp    80106289 <alltraps>

80107058 <vector193>:
.globl vector193
vector193:
  pushl $0
80107058:	6a 00                	push   $0x0
  pushl $193
8010705a:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010705f:	e9 25 f2 ff ff       	jmp    80106289 <alltraps>

80107064 <vector194>:
.globl vector194
vector194:
  pushl $0
80107064:	6a 00                	push   $0x0
  pushl $194
80107066:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010706b:	e9 19 f2 ff ff       	jmp    80106289 <alltraps>

80107070 <vector195>:
.globl vector195
vector195:
  pushl $0
80107070:	6a 00                	push   $0x0
  pushl $195
80107072:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107077:	e9 0d f2 ff ff       	jmp    80106289 <alltraps>

8010707c <vector196>:
.globl vector196
vector196:
  pushl $0
8010707c:	6a 00                	push   $0x0
  pushl $196
8010707e:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107083:	e9 01 f2 ff ff       	jmp    80106289 <alltraps>

80107088 <vector197>:
.globl vector197
vector197:
  pushl $0
80107088:	6a 00                	push   $0x0
  pushl $197
8010708a:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010708f:	e9 f5 f1 ff ff       	jmp    80106289 <alltraps>

80107094 <vector198>:
.globl vector198
vector198:
  pushl $0
80107094:	6a 00                	push   $0x0
  pushl $198
80107096:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010709b:	e9 e9 f1 ff ff       	jmp    80106289 <alltraps>

801070a0 <vector199>:
.globl vector199
vector199:
  pushl $0
801070a0:	6a 00                	push   $0x0
  pushl $199
801070a2:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801070a7:	e9 dd f1 ff ff       	jmp    80106289 <alltraps>

801070ac <vector200>:
.globl vector200
vector200:
  pushl $0
801070ac:	6a 00                	push   $0x0
  pushl $200
801070ae:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801070b3:	e9 d1 f1 ff ff       	jmp    80106289 <alltraps>

801070b8 <vector201>:
.globl vector201
vector201:
  pushl $0
801070b8:	6a 00                	push   $0x0
  pushl $201
801070ba:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801070bf:	e9 c5 f1 ff ff       	jmp    80106289 <alltraps>

801070c4 <vector202>:
.globl vector202
vector202:
  pushl $0
801070c4:	6a 00                	push   $0x0
  pushl $202
801070c6:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801070cb:	e9 b9 f1 ff ff       	jmp    80106289 <alltraps>

801070d0 <vector203>:
.globl vector203
vector203:
  pushl $0
801070d0:	6a 00                	push   $0x0
  pushl $203
801070d2:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801070d7:	e9 ad f1 ff ff       	jmp    80106289 <alltraps>

801070dc <vector204>:
.globl vector204
vector204:
  pushl $0
801070dc:	6a 00                	push   $0x0
  pushl $204
801070de:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801070e3:	e9 a1 f1 ff ff       	jmp    80106289 <alltraps>

801070e8 <vector205>:
.globl vector205
vector205:
  pushl $0
801070e8:	6a 00                	push   $0x0
  pushl $205
801070ea:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801070ef:	e9 95 f1 ff ff       	jmp    80106289 <alltraps>

801070f4 <vector206>:
.globl vector206
vector206:
  pushl $0
801070f4:	6a 00                	push   $0x0
  pushl $206
801070f6:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801070fb:	e9 89 f1 ff ff       	jmp    80106289 <alltraps>

80107100 <vector207>:
.globl vector207
vector207:
  pushl $0
80107100:	6a 00                	push   $0x0
  pushl $207
80107102:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107107:	e9 7d f1 ff ff       	jmp    80106289 <alltraps>

8010710c <vector208>:
.globl vector208
vector208:
  pushl $0
8010710c:	6a 00                	push   $0x0
  pushl $208
8010710e:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107113:	e9 71 f1 ff ff       	jmp    80106289 <alltraps>

80107118 <vector209>:
.globl vector209
vector209:
  pushl $0
80107118:	6a 00                	push   $0x0
  pushl $209
8010711a:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010711f:	e9 65 f1 ff ff       	jmp    80106289 <alltraps>

80107124 <vector210>:
.globl vector210
vector210:
  pushl $0
80107124:	6a 00                	push   $0x0
  pushl $210
80107126:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010712b:	e9 59 f1 ff ff       	jmp    80106289 <alltraps>

80107130 <vector211>:
.globl vector211
vector211:
  pushl $0
80107130:	6a 00                	push   $0x0
  pushl $211
80107132:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107137:	e9 4d f1 ff ff       	jmp    80106289 <alltraps>

8010713c <vector212>:
.globl vector212
vector212:
  pushl $0
8010713c:	6a 00                	push   $0x0
  pushl $212
8010713e:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107143:	e9 41 f1 ff ff       	jmp    80106289 <alltraps>

80107148 <vector213>:
.globl vector213
vector213:
  pushl $0
80107148:	6a 00                	push   $0x0
  pushl $213
8010714a:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010714f:	e9 35 f1 ff ff       	jmp    80106289 <alltraps>

80107154 <vector214>:
.globl vector214
vector214:
  pushl $0
80107154:	6a 00                	push   $0x0
  pushl $214
80107156:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
8010715b:	e9 29 f1 ff ff       	jmp    80106289 <alltraps>

80107160 <vector215>:
.globl vector215
vector215:
  pushl $0
80107160:	6a 00                	push   $0x0
  pushl $215
80107162:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107167:	e9 1d f1 ff ff       	jmp    80106289 <alltraps>

8010716c <vector216>:
.globl vector216
vector216:
  pushl $0
8010716c:	6a 00                	push   $0x0
  pushl $216
8010716e:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107173:	e9 11 f1 ff ff       	jmp    80106289 <alltraps>

80107178 <vector217>:
.globl vector217
vector217:
  pushl $0
80107178:	6a 00                	push   $0x0
  pushl $217
8010717a:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010717f:	e9 05 f1 ff ff       	jmp    80106289 <alltraps>

80107184 <vector218>:
.globl vector218
vector218:
  pushl $0
80107184:	6a 00                	push   $0x0
  pushl $218
80107186:	68 da 00 00 00       	push   $0xda
  jmp alltraps
8010718b:	e9 f9 f0 ff ff       	jmp    80106289 <alltraps>

80107190 <vector219>:
.globl vector219
vector219:
  pushl $0
80107190:	6a 00                	push   $0x0
  pushl $219
80107192:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107197:	e9 ed f0 ff ff       	jmp    80106289 <alltraps>

8010719c <vector220>:
.globl vector220
vector220:
  pushl $0
8010719c:	6a 00                	push   $0x0
  pushl $220
8010719e:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801071a3:	e9 e1 f0 ff ff       	jmp    80106289 <alltraps>

801071a8 <vector221>:
.globl vector221
vector221:
  pushl $0
801071a8:	6a 00                	push   $0x0
  pushl $221
801071aa:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801071af:	e9 d5 f0 ff ff       	jmp    80106289 <alltraps>

801071b4 <vector222>:
.globl vector222
vector222:
  pushl $0
801071b4:	6a 00                	push   $0x0
  pushl $222
801071b6:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801071bb:	e9 c9 f0 ff ff       	jmp    80106289 <alltraps>

801071c0 <vector223>:
.globl vector223
vector223:
  pushl $0
801071c0:	6a 00                	push   $0x0
  pushl $223
801071c2:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801071c7:	e9 bd f0 ff ff       	jmp    80106289 <alltraps>

801071cc <vector224>:
.globl vector224
vector224:
  pushl $0
801071cc:	6a 00                	push   $0x0
  pushl $224
801071ce:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801071d3:	e9 b1 f0 ff ff       	jmp    80106289 <alltraps>

801071d8 <vector225>:
.globl vector225
vector225:
  pushl $0
801071d8:	6a 00                	push   $0x0
  pushl $225
801071da:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801071df:	e9 a5 f0 ff ff       	jmp    80106289 <alltraps>

801071e4 <vector226>:
.globl vector226
vector226:
  pushl $0
801071e4:	6a 00                	push   $0x0
  pushl $226
801071e6:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801071eb:	e9 99 f0 ff ff       	jmp    80106289 <alltraps>

801071f0 <vector227>:
.globl vector227
vector227:
  pushl $0
801071f0:	6a 00                	push   $0x0
  pushl $227
801071f2:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801071f7:	e9 8d f0 ff ff       	jmp    80106289 <alltraps>

801071fc <vector228>:
.globl vector228
vector228:
  pushl $0
801071fc:	6a 00                	push   $0x0
  pushl $228
801071fe:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107203:	e9 81 f0 ff ff       	jmp    80106289 <alltraps>

80107208 <vector229>:
.globl vector229
vector229:
  pushl $0
80107208:	6a 00                	push   $0x0
  pushl $229
8010720a:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010720f:	e9 75 f0 ff ff       	jmp    80106289 <alltraps>

80107214 <vector230>:
.globl vector230
vector230:
  pushl $0
80107214:	6a 00                	push   $0x0
  pushl $230
80107216:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
8010721b:	e9 69 f0 ff ff       	jmp    80106289 <alltraps>

80107220 <vector231>:
.globl vector231
vector231:
  pushl $0
80107220:	6a 00                	push   $0x0
  pushl $231
80107222:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107227:	e9 5d f0 ff ff       	jmp    80106289 <alltraps>

8010722c <vector232>:
.globl vector232
vector232:
  pushl $0
8010722c:	6a 00                	push   $0x0
  pushl $232
8010722e:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107233:	e9 51 f0 ff ff       	jmp    80106289 <alltraps>

80107238 <vector233>:
.globl vector233
vector233:
  pushl $0
80107238:	6a 00                	push   $0x0
  pushl $233
8010723a:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010723f:	e9 45 f0 ff ff       	jmp    80106289 <alltraps>

80107244 <vector234>:
.globl vector234
vector234:
  pushl $0
80107244:	6a 00                	push   $0x0
  pushl $234
80107246:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
8010724b:	e9 39 f0 ff ff       	jmp    80106289 <alltraps>

80107250 <vector235>:
.globl vector235
vector235:
  pushl $0
80107250:	6a 00                	push   $0x0
  pushl $235
80107252:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107257:	e9 2d f0 ff ff       	jmp    80106289 <alltraps>

8010725c <vector236>:
.globl vector236
vector236:
  pushl $0
8010725c:	6a 00                	push   $0x0
  pushl $236
8010725e:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107263:	e9 21 f0 ff ff       	jmp    80106289 <alltraps>

80107268 <vector237>:
.globl vector237
vector237:
  pushl $0
80107268:	6a 00                	push   $0x0
  pushl $237
8010726a:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010726f:	e9 15 f0 ff ff       	jmp    80106289 <alltraps>

80107274 <vector238>:
.globl vector238
vector238:
  pushl $0
80107274:	6a 00                	push   $0x0
  pushl $238
80107276:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
8010727b:	e9 09 f0 ff ff       	jmp    80106289 <alltraps>

80107280 <vector239>:
.globl vector239
vector239:
  pushl $0
80107280:	6a 00                	push   $0x0
  pushl $239
80107282:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107287:	e9 fd ef ff ff       	jmp    80106289 <alltraps>

8010728c <vector240>:
.globl vector240
vector240:
  pushl $0
8010728c:	6a 00                	push   $0x0
  pushl $240
8010728e:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107293:	e9 f1 ef ff ff       	jmp    80106289 <alltraps>

80107298 <vector241>:
.globl vector241
vector241:
  pushl $0
80107298:	6a 00                	push   $0x0
  pushl $241
8010729a:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010729f:	e9 e5 ef ff ff       	jmp    80106289 <alltraps>

801072a4 <vector242>:
.globl vector242
vector242:
  pushl $0
801072a4:	6a 00                	push   $0x0
  pushl $242
801072a6:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801072ab:	e9 d9 ef ff ff       	jmp    80106289 <alltraps>

801072b0 <vector243>:
.globl vector243
vector243:
  pushl $0
801072b0:	6a 00                	push   $0x0
  pushl $243
801072b2:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801072b7:	e9 cd ef ff ff       	jmp    80106289 <alltraps>

801072bc <vector244>:
.globl vector244
vector244:
  pushl $0
801072bc:	6a 00                	push   $0x0
  pushl $244
801072be:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801072c3:	e9 c1 ef ff ff       	jmp    80106289 <alltraps>

801072c8 <vector245>:
.globl vector245
vector245:
  pushl $0
801072c8:	6a 00                	push   $0x0
  pushl $245
801072ca:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801072cf:	e9 b5 ef ff ff       	jmp    80106289 <alltraps>

801072d4 <vector246>:
.globl vector246
vector246:
  pushl $0
801072d4:	6a 00                	push   $0x0
  pushl $246
801072d6:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801072db:	e9 a9 ef ff ff       	jmp    80106289 <alltraps>

801072e0 <vector247>:
.globl vector247
vector247:
  pushl $0
801072e0:	6a 00                	push   $0x0
  pushl $247
801072e2:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801072e7:	e9 9d ef ff ff       	jmp    80106289 <alltraps>

801072ec <vector248>:
.globl vector248
vector248:
  pushl $0
801072ec:	6a 00                	push   $0x0
  pushl $248
801072ee:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801072f3:	e9 91 ef ff ff       	jmp    80106289 <alltraps>

801072f8 <vector249>:
.globl vector249
vector249:
  pushl $0
801072f8:	6a 00                	push   $0x0
  pushl $249
801072fa:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801072ff:	e9 85 ef ff ff       	jmp    80106289 <alltraps>

80107304 <vector250>:
.globl vector250
vector250:
  pushl $0
80107304:	6a 00                	push   $0x0
  pushl $250
80107306:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
8010730b:	e9 79 ef ff ff       	jmp    80106289 <alltraps>

80107310 <vector251>:
.globl vector251
vector251:
  pushl $0
80107310:	6a 00                	push   $0x0
  pushl $251
80107312:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107317:	e9 6d ef ff ff       	jmp    80106289 <alltraps>

8010731c <vector252>:
.globl vector252
vector252:
  pushl $0
8010731c:	6a 00                	push   $0x0
  pushl $252
8010731e:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107323:	e9 61 ef ff ff       	jmp    80106289 <alltraps>

80107328 <vector253>:
.globl vector253
vector253:
  pushl $0
80107328:	6a 00                	push   $0x0
  pushl $253
8010732a:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010732f:	e9 55 ef ff ff       	jmp    80106289 <alltraps>

80107334 <vector254>:
.globl vector254
vector254:
  pushl $0
80107334:	6a 00                	push   $0x0
  pushl $254
80107336:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
8010733b:	e9 49 ef ff ff       	jmp    80106289 <alltraps>

80107340 <vector255>:
.globl vector255
vector255:
  pushl $0
80107340:	6a 00                	push   $0x0
  pushl $255
80107342:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107347:	e9 3d ef ff ff       	jmp    80106289 <alltraps>

8010734c <lgdt>:

struct segdesc;

static inline void
lgdt(struct segdesc *p, int size)
{
8010734c:	55                   	push   %ebp
8010734d:	89 e5                	mov    %esp,%ebp
8010734f:	83 ec 10             	sub    $0x10,%esp
  volatile ushort pd[3];

  pd[0] = size-1;
80107352:	8b 45 0c             	mov    0xc(%ebp),%eax
80107355:	83 e8 01             	sub    $0x1,%eax
80107358:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010735c:	8b 45 08             	mov    0x8(%ebp),%eax
8010735f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80107363:	8b 45 08             	mov    0x8(%ebp),%eax
80107366:	c1 e8 10             	shr    $0x10,%eax
80107369:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
8010736d:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107370:	0f 01 10             	lgdtl  (%eax)
}
80107373:	90                   	nop
80107374:	c9                   	leave  
80107375:	c3                   	ret    

80107376 <ltr>:
  asm volatile("lidt (%0)" : : "r" (pd));
}

static inline void
ltr(ushort sel)
{
80107376:	55                   	push   %ebp
80107377:	89 e5                	mov    %esp,%ebp
80107379:	83 ec 04             	sub    $0x4,%esp
8010737c:	8b 45 08             	mov    0x8(%ebp),%eax
8010737f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80107383:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80107387:	0f 00 d8             	ltr    %ax
}
8010738a:	90                   	nop
8010738b:	c9                   	leave  
8010738c:	c3                   	ret    

8010738d <loadgs>:
  return eflags;
}

static inline void
loadgs(ushort v)
{
8010738d:	55                   	push   %ebp
8010738e:	89 e5                	mov    %esp,%ebp
80107390:	83 ec 04             	sub    $0x4,%esp
80107393:	8b 45 08             	mov    0x8(%ebp),%eax
80107396:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("movw %0, %%gs" : : "r" (v));
8010739a:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
8010739e:	8e e8                	mov    %eax,%gs
}
801073a0:	90                   	nop
801073a1:	c9                   	leave  
801073a2:	c3                   	ret    

801073a3 <lcr3>:
  return val;
}

static inline void
lcr3(uint val) 
{
801073a3:	55                   	push   %ebp
801073a4:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
801073a6:	8b 45 08             	mov    0x8(%ebp),%eax
801073a9:	0f 22 d8             	mov    %eax,%cr3
}
801073ac:	90                   	nop
801073ad:	5d                   	pop    %ebp
801073ae:	c3                   	ret    

801073af <v2p>:
#define KERNBASE 0x80000000         // First kernel virtual address
#define KERNLINK (KERNBASE+EXTMEM)  // Address where kernel is linked

#ifndef __ASSEMBLER__

static inline uint v2p(void *a) { return ((uint) (a))  - KERNBASE; }
801073af:	55                   	push   %ebp
801073b0:	89 e5                	mov    %esp,%ebp
801073b2:	8b 45 08             	mov    0x8(%ebp),%eax
801073b5:	05 00 00 00 80       	add    $0x80000000,%eax
801073ba:	5d                   	pop    %ebp
801073bb:	c3                   	ret    

801073bc <p2v>:
static inline void *p2v(uint a) { return (void *) ((a) + KERNBASE); }
801073bc:	55                   	push   %ebp
801073bd:	89 e5                	mov    %esp,%ebp
801073bf:	8b 45 08             	mov    0x8(%ebp),%eax
801073c2:	05 00 00 00 80       	add    $0x80000000,%eax
801073c7:	5d                   	pop    %ebp
801073c8:	c3                   	ret    

801073c9 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
801073c9:	55                   	push   %ebp
801073ca:	89 e5                	mov    %esp,%ebp
801073cc:	53                   	push   %ebx
801073cd:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
801073d0:	e8 25 bb ff ff       	call   80102efa <cpunum>
801073d5:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
801073db:	05 40 f9 10 80       	add    $0x8010f940,%eax
801073e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801073e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073e6:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801073ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073ef:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801073f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073f8:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801073fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801073ff:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107403:	83 e2 f0             	and    $0xfffffff0,%edx
80107406:	83 ca 0a             	or     $0xa,%edx
80107409:	88 50 7d             	mov    %dl,0x7d(%eax)
8010740c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010740f:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107413:	83 ca 10             	or     $0x10,%edx
80107416:	88 50 7d             	mov    %dl,0x7d(%eax)
80107419:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010741c:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80107420:	83 e2 9f             	and    $0xffffff9f,%edx
80107423:	88 50 7d             	mov    %dl,0x7d(%eax)
80107426:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107429:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010742d:	83 ca 80             	or     $0xffffff80,%edx
80107430:	88 50 7d             	mov    %dl,0x7d(%eax)
80107433:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107436:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010743a:	83 ca 0f             	or     $0xf,%edx
8010743d:	88 50 7e             	mov    %dl,0x7e(%eax)
80107440:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107443:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107447:	83 e2 ef             	and    $0xffffffef,%edx
8010744a:	88 50 7e             	mov    %dl,0x7e(%eax)
8010744d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107450:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107454:	83 e2 df             	and    $0xffffffdf,%edx
80107457:	88 50 7e             	mov    %dl,0x7e(%eax)
8010745a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010745d:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80107461:	83 ca 40             	or     $0x40,%edx
80107464:	88 50 7e             	mov    %dl,0x7e(%eax)
80107467:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010746a:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010746e:	83 ca 80             	or     $0xffffff80,%edx
80107471:	88 50 7e             	mov    %dl,0x7e(%eax)
80107474:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107477:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010747b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010747e:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80107485:	ff ff 
80107487:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010748a:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80107491:	00 00 
80107493:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107496:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
8010749d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074a0:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801074a7:	83 e2 f0             	and    $0xfffffff0,%edx
801074aa:	83 ca 02             	or     $0x2,%edx
801074ad:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801074b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074b6:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801074bd:	83 ca 10             	or     $0x10,%edx
801074c0:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801074c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074c9:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801074d0:	83 e2 9f             	and    $0xffffff9f,%edx
801074d3:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801074d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074dc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801074e3:	83 ca 80             	or     $0xffffff80,%edx
801074e6:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801074ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074ef:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801074f6:	83 ca 0f             	or     $0xf,%edx
801074f9:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801074ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107502:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107509:	83 e2 ef             	and    $0xffffffef,%edx
8010750c:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107515:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010751c:	83 e2 df             	and    $0xffffffdf,%edx
8010751f:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107525:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107528:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
8010752f:	83 ca 40             	or     $0x40,%edx
80107532:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80107538:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010753b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80107542:	83 ca 80             	or     $0xffffff80,%edx
80107545:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010754b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010754e:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107555:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107558:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
8010755f:	ff ff 
80107561:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107564:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
8010756b:	00 00 
8010756d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107570:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80107577:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010757a:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107581:	83 e2 f0             	and    $0xfffffff0,%edx
80107584:	83 ca 0a             	or     $0xa,%edx
80107587:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
8010758d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107590:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80107597:	83 ca 10             	or     $0x10,%edx
8010759a:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801075a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075a3:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801075aa:	83 ca 60             	or     $0x60,%edx
801075ad:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801075b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075b6:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
801075bd:	83 ca 80             	or     $0xffffff80,%edx
801075c0:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
801075c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075c9:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801075d0:	83 ca 0f             	or     $0xf,%edx
801075d3:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801075d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075dc:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801075e3:	83 e2 ef             	and    $0xffffffef,%edx
801075e6:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801075ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075ef:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
801075f6:	83 e2 df             	and    $0xffffffdf,%edx
801075f9:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
801075ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107602:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80107609:	83 ca 40             	or     $0x40,%edx
8010760c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107612:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107615:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
8010761c:	83 ca 80             	or     $0xffffff80,%edx
8010761f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80107625:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107628:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010762f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107632:	66 c7 80 98 00 00 00 	movw   $0xffff,0x98(%eax)
80107639:	ff ff 
8010763b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010763e:	66 c7 80 9a 00 00 00 	movw   $0x0,0x9a(%eax)
80107645:	00 00 
80107647:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010764a:	c6 80 9c 00 00 00 00 	movb   $0x0,0x9c(%eax)
80107651:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107654:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
8010765b:	83 e2 f0             	and    $0xfffffff0,%edx
8010765e:	83 ca 02             	or     $0x2,%edx
80107661:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80107667:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010766a:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107671:	83 ca 10             	or     $0x10,%edx
80107674:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010767a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010767d:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107684:	83 ca 60             	or     $0x60,%edx
80107687:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
8010768d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107690:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80107697:	83 ca 80             	or     $0xffffff80,%edx
8010769a:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
801076a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a3:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801076aa:	83 ca 0f             	or     $0xf,%edx
801076ad:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801076b3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b6:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801076bd:	83 e2 ef             	and    $0xffffffef,%edx
801076c0:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801076c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076c9:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801076d0:	83 e2 df             	and    $0xffffffdf,%edx
801076d3:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801076d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076dc:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801076e3:	83 ca 40             	or     $0x40,%edx
801076e6:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801076ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ef:	0f b6 90 9e 00 00 00 	movzbl 0x9e(%eax),%edx
801076f6:	83 ca 80             	or     $0xffffff80,%edx
801076f9:	88 90 9e 00 00 00    	mov    %dl,0x9e(%eax)
801076ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107702:	c6 80 9f 00 00 00 00 	movb   $0x0,0x9f(%eax)

  // Map cpu, and curproc
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80107709:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010770c:	05 b4 00 00 00       	add    $0xb4,%eax
80107711:	89 c3                	mov    %eax,%ebx
80107713:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107716:	05 b4 00 00 00       	add    $0xb4,%eax
8010771b:	c1 e8 10             	shr    $0x10,%eax
8010771e:	89 c2                	mov    %eax,%edx
80107720:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107723:	05 b4 00 00 00       	add    $0xb4,%eax
80107728:	c1 e8 18             	shr    $0x18,%eax
8010772b:	89 c1                	mov    %eax,%ecx
8010772d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107730:	66 c7 80 88 00 00 00 	movw   $0x0,0x88(%eax)
80107737:	00 00 
80107739:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773c:	66 89 98 8a 00 00 00 	mov    %bx,0x8a(%eax)
80107743:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107746:	88 90 8c 00 00 00    	mov    %dl,0x8c(%eax)
8010774c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010774f:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107756:	83 e2 f0             	and    $0xfffffff0,%edx
80107759:	83 ca 02             	or     $0x2,%edx
8010775c:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107762:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107765:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010776c:	83 ca 10             	or     $0x10,%edx
8010776f:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107775:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107778:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010777f:	83 e2 9f             	and    $0xffffff9f,%edx
80107782:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80107788:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010778b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80107792:	83 ca 80             	or     $0xffffff80,%edx
80107795:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010779b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010779e:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801077a5:	83 e2 f0             	and    $0xfffffff0,%edx
801077a8:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801077ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077b1:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801077b8:	83 e2 ef             	and    $0xffffffef,%edx
801077bb:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801077c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077c4:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801077cb:	83 e2 df             	and    $0xffffffdf,%edx
801077ce:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801077d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077d7:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801077de:	83 ca 40             	or     $0x40,%edx
801077e1:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801077e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ea:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801077f1:	83 ca 80             	or     $0xffffff80,%edx
801077f4:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801077fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077fd:	88 88 8f 00 00 00    	mov    %cl,0x8f(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80107803:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107806:	83 c0 70             	add    $0x70,%eax
80107809:	83 ec 08             	sub    $0x8,%esp
8010780c:	6a 38                	push   $0x38
8010780e:	50                   	push   %eax
8010780f:	e8 38 fb ff ff       	call   8010734c <lgdt>
80107814:	83 c4 10             	add    $0x10,%esp
  loadgs(SEG_KCPU << 3);
80107817:	83 ec 0c             	sub    $0xc,%esp
8010781a:	6a 18                	push   $0x18
8010781c:	e8 6c fb ff ff       	call   8010738d <loadgs>
80107821:	83 c4 10             	add    $0x10,%esp
  
  // Initialize cpu-local storage.
  cpu = c;
80107824:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107827:	65 a3 00 00 00 00    	mov    %eax,%gs:0x0
  proc = 0;
8010782d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80107834:	00 00 00 00 
}
80107838:	90                   	nop
80107839:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010783c:	c9                   	leave  
8010783d:	c3                   	ret    

8010783e <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010783e:	55                   	push   %ebp
8010783f:	89 e5                	mov    %esp,%ebp
80107841:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107844:	8b 45 0c             	mov    0xc(%ebp),%eax
80107847:	c1 e8 16             	shr    $0x16,%eax
8010784a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107851:	8b 45 08             	mov    0x8(%ebp),%eax
80107854:	01 d0                	add    %edx,%eax
80107856:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80107859:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010785c:	8b 00                	mov    (%eax),%eax
8010785e:	83 e0 01             	and    $0x1,%eax
80107861:	85 c0                	test   %eax,%eax
80107863:	74 18                	je     8010787d <walkpgdir+0x3f>
    pgtab = (pte_t*)p2v(PTE_ADDR(*pde));
80107865:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107868:	8b 00                	mov    (%eax),%eax
8010786a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010786f:	50                   	push   %eax
80107870:	e8 47 fb ff ff       	call   801073bc <p2v>
80107875:	83 c4 04             	add    $0x4,%esp
80107878:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010787b:	eb 48                	jmp    801078c5 <walkpgdir+0x87>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010787d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80107881:	74 0e                	je     80107891 <walkpgdir+0x53>
80107883:	e8 29 b3 ff ff       	call   80102bb1 <kalloc>
80107888:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010788b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010788f:	75 07                	jne    80107898 <walkpgdir+0x5a>
      return 0;
80107891:	b8 00 00 00 00       	mov    $0x0,%eax
80107896:	eb 44                	jmp    801078dc <walkpgdir+0x9e>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80107898:	83 ec 04             	sub    $0x4,%esp
8010789b:	68 00 10 00 00       	push   $0x1000
801078a0:	6a 00                	push   $0x0
801078a2:	ff 75 f4             	pushl  -0xc(%ebp)
801078a5:	e8 a2 d5 ff ff       	call   80104e4c <memset>
801078aa:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table 
    // entries, if necessary.
    *pde = v2p(pgtab) | PTE_P | PTE_W | PTE_U;
801078ad:	83 ec 0c             	sub    $0xc,%esp
801078b0:	ff 75 f4             	pushl  -0xc(%ebp)
801078b3:	e8 f7 fa ff ff       	call   801073af <v2p>
801078b8:	83 c4 10             	add    $0x10,%esp
801078bb:	83 c8 07             	or     $0x7,%eax
801078be:	89 c2                	mov    %eax,%edx
801078c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801078c3:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
801078c5:	8b 45 0c             	mov    0xc(%ebp),%eax
801078c8:	c1 e8 0c             	shr    $0xc,%eax
801078cb:	25 ff 03 00 00       	and    $0x3ff,%eax
801078d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801078d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078da:	01 d0                	add    %edx,%eax
}
801078dc:	c9                   	leave  
801078dd:	c3                   	ret    

801078de <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801078de:	55                   	push   %ebp
801078df:	89 e5                	mov    %esp,%ebp
801078e1:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;
  
  a = (char*)PGROUNDDOWN((uint)va);
801078e4:	8b 45 0c             	mov    0xc(%ebp),%eax
801078e7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801078ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801078ef:	8b 55 0c             	mov    0xc(%ebp),%edx
801078f2:	8b 45 10             	mov    0x10(%ebp),%eax
801078f5:	01 d0                	add    %edx,%eax
801078f7:	83 e8 01             	sub    $0x1,%eax
801078fa:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801078ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107902:	83 ec 04             	sub    $0x4,%esp
80107905:	6a 01                	push   $0x1
80107907:	ff 75 f4             	pushl  -0xc(%ebp)
8010790a:	ff 75 08             	pushl  0x8(%ebp)
8010790d:	e8 2c ff ff ff       	call   8010783e <walkpgdir>
80107912:	83 c4 10             	add    $0x10,%esp
80107915:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107918:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010791c:	75 07                	jne    80107925 <mappages+0x47>
      return -1;
8010791e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107923:	eb 47                	jmp    8010796c <mappages+0x8e>
    if(*pte & PTE_P)
80107925:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107928:	8b 00                	mov    (%eax),%eax
8010792a:	83 e0 01             	and    $0x1,%eax
8010792d:	85 c0                	test   %eax,%eax
8010792f:	74 0d                	je     8010793e <mappages+0x60>
      panic("remap");
80107931:	83 ec 0c             	sub    $0xc,%esp
80107934:	68 fc 86 10 80       	push   $0x801086fc
80107939:	e8 28 8c ff ff       	call   80100566 <panic>
    *pte = pa | perm | PTE_P;
8010793e:	8b 45 18             	mov    0x18(%ebp),%eax
80107941:	0b 45 14             	or     0x14(%ebp),%eax
80107944:	83 c8 01             	or     $0x1,%eax
80107947:	89 c2                	mov    %eax,%edx
80107949:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010794c:	89 10                	mov    %edx,(%eax)
    if(a == last)
8010794e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107951:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107954:	74 10                	je     80107966 <mappages+0x88>
      break;
    a += PGSIZE;
80107956:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
8010795d:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
  }
80107964:	eb 9c                	jmp    80107902 <mappages+0x24>
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
    if(a == last)
      break;
80107966:	90                   	nop
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80107967:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010796c:	c9                   	leave  
8010796d:	c3                   	ret    

8010796e <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
8010796e:	55                   	push   %ebp
8010796f:	89 e5                	mov    %esp,%ebp
80107971:	53                   	push   %ebx
80107972:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80107975:	e8 37 b2 ff ff       	call   80102bb1 <kalloc>
8010797a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010797d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107981:	75 0a                	jne    8010798d <setupkvm+0x1f>
    return 0;
80107983:	b8 00 00 00 00       	mov    $0x0,%eax
80107988:	e9 8e 00 00 00       	jmp    80107a1b <setupkvm+0xad>
  memset(pgdir, 0, PGSIZE);
8010798d:	83 ec 04             	sub    $0x4,%esp
80107990:	68 00 10 00 00       	push   $0x1000
80107995:	6a 00                	push   $0x0
80107997:	ff 75 f0             	pushl  -0x10(%ebp)
8010799a:	e8 ad d4 ff ff       	call   80104e4c <memset>
8010799f:	83 c4 10             	add    $0x10,%esp
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
801079a2:	83 ec 0c             	sub    $0xc,%esp
801079a5:	68 00 00 00 0e       	push   $0xe000000
801079aa:	e8 0d fa ff ff       	call   801073bc <p2v>
801079af:	83 c4 10             	add    $0x10,%esp
801079b2:	3d 00 00 00 fe       	cmp    $0xfe000000,%eax
801079b7:	76 0d                	jbe    801079c6 <setupkvm+0x58>
    panic("PHYSTOP too high");
801079b9:	83 ec 0c             	sub    $0xc,%esp
801079bc:	68 02 87 10 80       	push   $0x80108702
801079c1:	e8 a0 8b ff ff       	call   80100566 <panic>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801079c6:	c7 45 f4 c0 b4 10 80 	movl   $0x8010b4c0,-0xc(%ebp)
801079cd:	eb 40                	jmp    80107a0f <setupkvm+0xa1>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
801079cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d2:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0)
801079d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079d8:	8b 50 04             	mov    0x4(%eax),%edx
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
801079db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079de:	8b 58 08             	mov    0x8(%eax),%ebx
801079e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079e4:	8b 40 04             	mov    0x4(%eax),%eax
801079e7:	29 c3                	sub    %eax,%ebx
801079e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801079ec:	8b 00                	mov    (%eax),%eax
801079ee:	83 ec 0c             	sub    $0xc,%esp
801079f1:	51                   	push   %ecx
801079f2:	52                   	push   %edx
801079f3:	53                   	push   %ebx
801079f4:	50                   	push   %eax
801079f5:	ff 75 f0             	pushl  -0x10(%ebp)
801079f8:	e8 e1 fe ff ff       	call   801078de <mappages>
801079fd:	83 c4 20             	add    $0x20,%esp
80107a00:	85 c0                	test   %eax,%eax
80107a02:	79 07                	jns    80107a0b <setupkvm+0x9d>
                (uint)k->phys_start, k->perm) < 0)
      return 0;
80107a04:	b8 00 00 00 00       	mov    $0x0,%eax
80107a09:	eb 10                	jmp    80107a1b <setupkvm+0xad>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (p2v(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107a0b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80107a0f:	81 7d f4 00 b5 10 80 	cmpl   $0x8010b500,-0xc(%ebp)
80107a16:	72 b7                	jb     801079cf <setupkvm+0x61>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start, 
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
80107a18:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80107a1b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107a1e:	c9                   	leave  
80107a1f:	c3                   	ret    

80107a20 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80107a20:	55                   	push   %ebp
80107a21:	89 e5                	mov    %esp,%ebp
80107a23:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107a26:	e8 43 ff ff ff       	call   8010796e <setupkvm>
80107a2b:	a3 18 27 11 80       	mov    %eax,0x80112718
  switchkvm();
80107a30:	e8 03 00 00 00       	call   80107a38 <switchkvm>
}
80107a35:	90                   	nop
80107a36:	c9                   	leave  
80107a37:	c3                   	ret    

80107a38 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80107a38:	55                   	push   %ebp
80107a39:	89 e5                	mov    %esp,%ebp
  lcr3(v2p(kpgdir));   // switch to the kernel page table
80107a3b:	a1 18 27 11 80       	mov    0x80112718,%eax
80107a40:	50                   	push   %eax
80107a41:	e8 69 f9 ff ff       	call   801073af <v2p>
80107a46:	83 c4 04             	add    $0x4,%esp
80107a49:	50                   	push   %eax
80107a4a:	e8 54 f9 ff ff       	call   801073a3 <lcr3>
80107a4f:	83 c4 04             	add    $0x4,%esp
}
80107a52:	90                   	nop
80107a53:	c9                   	leave  
80107a54:	c3                   	ret    

80107a55 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80107a55:	55                   	push   %ebp
80107a56:	89 e5                	mov    %esp,%ebp
80107a58:	56                   	push   %esi
80107a59:	53                   	push   %ebx
  pushcli();
80107a5a:	e8 e7 d2 ff ff       	call   80104d46 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80107a5f:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107a65:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107a6c:	83 c2 08             	add    $0x8,%edx
80107a6f:	89 d6                	mov    %edx,%esi
80107a71:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107a78:	83 c2 08             	add    $0x8,%edx
80107a7b:	c1 ea 10             	shr    $0x10,%edx
80107a7e:	89 d3                	mov    %edx,%ebx
80107a80:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80107a87:	83 c2 08             	add    $0x8,%edx
80107a8a:	c1 ea 18             	shr    $0x18,%edx
80107a8d:	89 d1                	mov    %edx,%ecx
80107a8f:	66 c7 80 a0 00 00 00 	movw   $0x67,0xa0(%eax)
80107a96:	67 00 
80107a98:	66 89 b0 a2 00 00 00 	mov    %si,0xa2(%eax)
80107a9f:	88 98 a4 00 00 00    	mov    %bl,0xa4(%eax)
80107aa5:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107aac:	83 e2 f0             	and    $0xfffffff0,%edx
80107aaf:	83 ca 09             	or     $0x9,%edx
80107ab2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ab8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107abf:	83 ca 10             	or     $0x10,%edx
80107ac2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ac8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107acf:	83 e2 9f             	and    $0xffffff9f,%edx
80107ad2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ad8:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107adf:	83 ca 80             	or     $0xffffff80,%edx
80107ae2:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
80107ae8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107aef:	83 e2 f0             	and    $0xfffffff0,%edx
80107af2:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107af8:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107aff:	83 e2 ef             	and    $0xffffffef,%edx
80107b02:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107b08:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107b0f:	83 e2 df             	and    $0xffffffdf,%edx
80107b12:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107b18:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107b1f:	83 ca 40             	or     $0x40,%edx
80107b22:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107b28:	0f b6 90 a6 00 00 00 	movzbl 0xa6(%eax),%edx
80107b2f:	83 e2 7f             	and    $0x7f,%edx
80107b32:	88 90 a6 00 00 00    	mov    %dl,0xa6(%eax)
80107b38:	88 88 a7 00 00 00    	mov    %cl,0xa7(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80107b3e:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107b44:	0f b6 90 a5 00 00 00 	movzbl 0xa5(%eax),%edx
80107b4b:	83 e2 ef             	and    $0xffffffef,%edx
80107b4e:	88 90 a5 00 00 00    	mov    %dl,0xa5(%eax)
  cpu->ts.ss0 = SEG_KDATA << 3;
80107b54:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107b5a:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  cpu->ts.esp0 = (uint)proc->kstack + KSTACKSIZE;
80107b60:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80107b66:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80107b6d:	8b 52 08             	mov    0x8(%edx),%edx
80107b70:	81 c2 00 10 00 00    	add    $0x1000,%edx
80107b76:	89 50 0c             	mov    %edx,0xc(%eax)
  ltr(SEG_TSS << 3);
80107b79:	83 ec 0c             	sub    $0xc,%esp
80107b7c:	6a 30                	push   $0x30
80107b7e:	e8 f3 f7 ff ff       	call   80107376 <ltr>
80107b83:	83 c4 10             	add    $0x10,%esp
  if(p->pgdir == 0)
80107b86:	8b 45 08             	mov    0x8(%ebp),%eax
80107b89:	8b 40 04             	mov    0x4(%eax),%eax
80107b8c:	85 c0                	test   %eax,%eax
80107b8e:	75 0d                	jne    80107b9d <switchuvm+0x148>
    panic("switchuvm: no pgdir");
80107b90:	83 ec 0c             	sub    $0xc,%esp
80107b93:	68 13 87 10 80       	push   $0x80108713
80107b98:	e8 c9 89 ff ff       	call   80100566 <panic>
  lcr3(v2p(p->pgdir));  // switch to new address space
80107b9d:	8b 45 08             	mov    0x8(%ebp),%eax
80107ba0:	8b 40 04             	mov    0x4(%eax),%eax
80107ba3:	83 ec 0c             	sub    $0xc,%esp
80107ba6:	50                   	push   %eax
80107ba7:	e8 03 f8 ff ff       	call   801073af <v2p>
80107bac:	83 c4 10             	add    $0x10,%esp
80107baf:	83 ec 0c             	sub    $0xc,%esp
80107bb2:	50                   	push   %eax
80107bb3:	e8 eb f7 ff ff       	call   801073a3 <lcr3>
80107bb8:	83 c4 10             	add    $0x10,%esp
  popcli();
80107bbb:	e8 cb d1 ff ff       	call   80104d8b <popcli>
}
80107bc0:	90                   	nop
80107bc1:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bc4:	5b                   	pop    %ebx
80107bc5:	5e                   	pop    %esi
80107bc6:	5d                   	pop    %ebp
80107bc7:	c3                   	ret    

80107bc8 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80107bc8:	55                   	push   %ebp
80107bc9:	89 e5                	mov    %esp,%ebp
80107bcb:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  
  if(sz >= PGSIZE)
80107bce:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80107bd5:	76 0d                	jbe    80107be4 <inituvm+0x1c>
    panic("inituvm: more than a page");
80107bd7:	83 ec 0c             	sub    $0xc,%esp
80107bda:	68 27 87 10 80       	push   $0x80108727
80107bdf:	e8 82 89 ff ff       	call   80100566 <panic>
  mem = kalloc();
80107be4:	e8 c8 af ff ff       	call   80102bb1 <kalloc>
80107be9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
80107bec:	83 ec 04             	sub    $0x4,%esp
80107bef:	68 00 10 00 00       	push   $0x1000
80107bf4:	6a 00                	push   $0x0
80107bf6:	ff 75 f4             	pushl  -0xc(%ebp)
80107bf9:	e8 4e d2 ff ff       	call   80104e4c <memset>
80107bfe:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107c01:	83 ec 0c             	sub    $0xc,%esp
80107c04:	ff 75 f4             	pushl  -0xc(%ebp)
80107c07:	e8 a3 f7 ff ff       	call   801073af <v2p>
80107c0c:	83 c4 10             	add    $0x10,%esp
80107c0f:	83 ec 0c             	sub    $0xc,%esp
80107c12:	6a 06                	push   $0x6
80107c14:	50                   	push   %eax
80107c15:	68 00 10 00 00       	push   $0x1000
80107c1a:	6a 00                	push   $0x0
80107c1c:	ff 75 08             	pushl  0x8(%ebp)
80107c1f:	e8 ba fc ff ff       	call   801078de <mappages>
80107c24:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80107c27:	83 ec 04             	sub    $0x4,%esp
80107c2a:	ff 75 10             	pushl  0x10(%ebp)
80107c2d:	ff 75 0c             	pushl  0xc(%ebp)
80107c30:	ff 75 f4             	pushl  -0xc(%ebp)
80107c33:	e8 d3 d2 ff ff       	call   80104f0b <memmove>
80107c38:	83 c4 10             	add    $0x10,%esp
}
80107c3b:	90                   	nop
80107c3c:	c9                   	leave  
80107c3d:	c3                   	ret    

80107c3e <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80107c3e:	55                   	push   %ebp
80107c3f:	89 e5                	mov    %esp,%ebp
80107c41:	53                   	push   %ebx
80107c42:	83 ec 14             	sub    $0x14,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80107c45:	8b 45 0c             	mov    0xc(%ebp),%eax
80107c48:	25 ff 0f 00 00       	and    $0xfff,%eax
80107c4d:	85 c0                	test   %eax,%eax
80107c4f:	74 0d                	je     80107c5e <loaduvm+0x20>
    panic("loaduvm: addr must be page aligned");
80107c51:	83 ec 0c             	sub    $0xc,%esp
80107c54:	68 44 87 10 80       	push   $0x80108744
80107c59:	e8 08 89 ff ff       	call   80100566 <panic>
  for(i = 0; i < sz; i += PGSIZE){
80107c5e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107c65:	e9 95 00 00 00       	jmp    80107cff <loaduvm+0xc1>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107c6a:	8b 55 0c             	mov    0xc(%ebp),%edx
80107c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107c70:	01 d0                	add    %edx,%eax
80107c72:	83 ec 04             	sub    $0x4,%esp
80107c75:	6a 00                	push   $0x0
80107c77:	50                   	push   %eax
80107c78:	ff 75 08             	pushl  0x8(%ebp)
80107c7b:	e8 be fb ff ff       	call   8010783e <walkpgdir>
80107c80:	83 c4 10             	add    $0x10,%esp
80107c83:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107c86:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107c8a:	75 0d                	jne    80107c99 <loaduvm+0x5b>
      panic("loaduvm: address should exist");
80107c8c:	83 ec 0c             	sub    $0xc,%esp
80107c8f:	68 67 87 10 80       	push   $0x80108767
80107c94:	e8 cd 88 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80107c99:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107c9c:	8b 00                	mov    (%eax),%eax
80107c9e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ca3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
80107ca6:	8b 45 18             	mov    0x18(%ebp),%eax
80107ca9:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107cac:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80107cb1:	77 0b                	ja     80107cbe <loaduvm+0x80>
      n = sz - i;
80107cb3:	8b 45 18             	mov    0x18(%ebp),%eax
80107cb6:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107cb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107cbc:	eb 07                	jmp    80107cc5 <loaduvm+0x87>
    else
      n = PGSIZE;
80107cbe:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, p2v(pa), offset+i, n) != n)
80107cc5:	8b 55 14             	mov    0x14(%ebp),%edx
80107cc8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ccb:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80107cce:	83 ec 0c             	sub    $0xc,%esp
80107cd1:	ff 75 e8             	pushl  -0x18(%ebp)
80107cd4:	e8 e3 f6 ff ff       	call   801073bc <p2v>
80107cd9:	83 c4 10             	add    $0x10,%esp
80107cdc:	ff 75 f0             	pushl  -0x10(%ebp)
80107cdf:	53                   	push   %ebx
80107ce0:	50                   	push   %eax
80107ce1:	ff 75 10             	pushl  0x10(%ebp)
80107ce4:	e8 76 a1 ff ff       	call   80101e5f <readi>
80107ce9:	83 c4 10             	add    $0x10,%esp
80107cec:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80107cef:	74 07                	je     80107cf8 <loaduvm+0xba>
      return -1;
80107cf1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107cf6:	eb 18                	jmp    80107d10 <loaduvm+0xd2>
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80107cf8:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107cff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d02:	3b 45 18             	cmp    0x18(%ebp),%eax
80107d05:	0f 82 5f ff ff ff    	jb     80107c6a <loaduvm+0x2c>
    else
      n = PGSIZE;
    if(readi(ip, p2v(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80107d0b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107d10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80107d13:	c9                   	leave  
80107d14:	c3                   	ret    

80107d15 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107d15:	55                   	push   %ebp
80107d16:	89 e5                	mov    %esp,%ebp
80107d18:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80107d1b:	8b 45 10             	mov    0x10(%ebp),%eax
80107d1e:	85 c0                	test   %eax,%eax
80107d20:	79 0a                	jns    80107d2c <allocuvm+0x17>
    return 0;
80107d22:	b8 00 00 00 00       	mov    $0x0,%eax
80107d27:	e9 b0 00 00 00       	jmp    80107ddc <allocuvm+0xc7>
  if(newsz < oldsz)
80107d2c:	8b 45 10             	mov    0x10(%ebp),%eax
80107d2f:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107d32:	73 08                	jae    80107d3c <allocuvm+0x27>
    return oldsz;
80107d34:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d37:	e9 a0 00 00 00       	jmp    80107ddc <allocuvm+0xc7>

  a = PGROUNDUP(oldsz);
80107d3c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107d3f:	05 ff 0f 00 00       	add    $0xfff,%eax
80107d44:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d49:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
80107d4c:	eb 7f                	jmp    80107dcd <allocuvm+0xb8>
    mem = kalloc();
80107d4e:	e8 5e ae ff ff       	call   80102bb1 <kalloc>
80107d53:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
80107d56:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107d5a:	75 2b                	jne    80107d87 <allocuvm+0x72>
      cprintf("allocuvm out of memory\n");
80107d5c:	83 ec 0c             	sub    $0xc,%esp
80107d5f:	68 85 87 10 80       	push   $0x80108785
80107d64:	e8 5d 86 ff ff       	call   801003c6 <cprintf>
80107d69:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
80107d6c:	83 ec 04             	sub    $0x4,%esp
80107d6f:	ff 75 0c             	pushl  0xc(%ebp)
80107d72:	ff 75 10             	pushl  0x10(%ebp)
80107d75:	ff 75 08             	pushl  0x8(%ebp)
80107d78:	e8 61 00 00 00       	call   80107dde <deallocuvm>
80107d7d:	83 c4 10             	add    $0x10,%esp
      return 0;
80107d80:	b8 00 00 00 00       	mov    $0x0,%eax
80107d85:	eb 55                	jmp    80107ddc <allocuvm+0xc7>
    }
    memset(mem, 0, PGSIZE);
80107d87:	83 ec 04             	sub    $0x4,%esp
80107d8a:	68 00 10 00 00       	push   $0x1000
80107d8f:	6a 00                	push   $0x0
80107d91:	ff 75 f0             	pushl  -0x10(%ebp)
80107d94:	e8 b3 d0 ff ff       	call   80104e4c <memset>
80107d99:	83 c4 10             	add    $0x10,%esp
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
80107d9c:	83 ec 0c             	sub    $0xc,%esp
80107d9f:	ff 75 f0             	pushl  -0x10(%ebp)
80107da2:	e8 08 f6 ff ff       	call   801073af <v2p>
80107da7:	83 c4 10             	add    $0x10,%esp
80107daa:	89 c2                	mov    %eax,%edx
80107dac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107daf:	83 ec 0c             	sub    $0xc,%esp
80107db2:	6a 06                	push   $0x6
80107db4:	52                   	push   %edx
80107db5:	68 00 10 00 00       	push   $0x1000
80107dba:	50                   	push   %eax
80107dbb:	ff 75 08             	pushl  0x8(%ebp)
80107dbe:	e8 1b fb ff ff       	call   801078de <mappages>
80107dc3:	83 c4 20             	add    $0x20,%esp
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80107dc6:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107dcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107dd0:	3b 45 10             	cmp    0x10(%ebp),%eax
80107dd3:	0f 82 75 ff ff ff    	jb     80107d4e <allocuvm+0x39>
      return 0;
    }
    memset(mem, 0, PGSIZE);
    mappages(pgdir, (char*)a, PGSIZE, v2p(mem), PTE_W|PTE_U);
  }
  return newsz;
80107dd9:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107ddc:	c9                   	leave  
80107ddd:	c3                   	ret    

80107dde <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107dde:	55                   	push   %ebp
80107ddf:	89 e5                	mov    %esp,%ebp
80107de1:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80107de4:	8b 45 10             	mov    0x10(%ebp),%eax
80107de7:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107dea:	72 08                	jb     80107df4 <deallocuvm+0x16>
    return oldsz;
80107dec:	8b 45 0c             	mov    0xc(%ebp),%eax
80107def:	e9 a5 00 00 00       	jmp    80107e99 <deallocuvm+0xbb>

  a = PGROUNDUP(newsz);
80107df4:	8b 45 10             	mov    0x10(%ebp),%eax
80107df7:	05 ff 0f 00 00       	add    $0xfff,%eax
80107dfc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e01:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107e04:	e9 81 00 00 00       	jmp    80107e8a <deallocuvm+0xac>
    pte = walkpgdir(pgdir, (char*)a, 0);
80107e09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e0c:	83 ec 04             	sub    $0x4,%esp
80107e0f:	6a 00                	push   $0x0
80107e11:	50                   	push   %eax
80107e12:	ff 75 08             	pushl  0x8(%ebp)
80107e15:	e8 24 fa ff ff       	call   8010783e <walkpgdir>
80107e1a:	83 c4 10             	add    $0x10,%esp
80107e1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
80107e20:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107e24:	75 09                	jne    80107e2f <deallocuvm+0x51>
      a += (NPTENTRIES - 1) * PGSIZE;
80107e26:	81 45 f4 00 f0 3f 00 	addl   $0x3ff000,-0xc(%ebp)
80107e2d:	eb 54                	jmp    80107e83 <deallocuvm+0xa5>
    else if((*pte & PTE_P) != 0){
80107e2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e32:	8b 00                	mov    (%eax),%eax
80107e34:	83 e0 01             	and    $0x1,%eax
80107e37:	85 c0                	test   %eax,%eax
80107e39:	74 48                	je     80107e83 <deallocuvm+0xa5>
      pa = PTE_ADDR(*pte);
80107e3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e3e:	8b 00                	mov    (%eax),%eax
80107e40:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107e45:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
80107e48:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107e4c:	75 0d                	jne    80107e5b <deallocuvm+0x7d>
        panic("kfree");
80107e4e:	83 ec 0c             	sub    $0xc,%esp
80107e51:	68 9d 87 10 80       	push   $0x8010879d
80107e56:	e8 0b 87 ff ff       	call   80100566 <panic>
      char *v = p2v(pa);
80107e5b:	83 ec 0c             	sub    $0xc,%esp
80107e5e:	ff 75 ec             	pushl  -0x14(%ebp)
80107e61:	e8 56 f5 ff ff       	call   801073bc <p2v>
80107e66:	83 c4 10             	add    $0x10,%esp
80107e69:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
80107e6c:	83 ec 0c             	sub    $0xc,%esp
80107e6f:	ff 75 e8             	pushl  -0x18(%ebp)
80107e72:	e8 9d ac ff ff       	call   80102b14 <kfree>
80107e77:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80107e7a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107e7d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80107e83:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80107e8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107e8d:	3b 45 0c             	cmp    0xc(%ebp),%eax
80107e90:	0f 82 73 ff ff ff    	jb     80107e09 <deallocuvm+0x2b>
      char *v = p2v(pa);
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
80107e96:	8b 45 10             	mov    0x10(%ebp),%eax
}
80107e99:	c9                   	leave  
80107e9a:	c3                   	ret    

80107e9b <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107e9b:	55                   	push   %ebp
80107e9c:	89 e5                	mov    %esp,%ebp
80107e9e:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80107ea1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80107ea5:	75 0d                	jne    80107eb4 <freevm+0x19>
    panic("freevm: no pgdir");
80107ea7:	83 ec 0c             	sub    $0xc,%esp
80107eaa:	68 a3 87 10 80       	push   $0x801087a3
80107eaf:	e8 b2 86 ff ff       	call   80100566 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
80107eb4:	83 ec 04             	sub    $0x4,%esp
80107eb7:	6a 00                	push   $0x0
80107eb9:	68 00 00 00 80       	push   $0x80000000
80107ebe:	ff 75 08             	pushl  0x8(%ebp)
80107ec1:	e8 18 ff ff ff       	call   80107dde <deallocuvm>
80107ec6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107ec9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107ed0:	eb 4f                	jmp    80107f21 <freevm+0x86>
    if(pgdir[i] & PTE_P){
80107ed2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107ed5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107edc:	8b 45 08             	mov    0x8(%ebp),%eax
80107edf:	01 d0                	add    %edx,%eax
80107ee1:	8b 00                	mov    (%eax),%eax
80107ee3:	83 e0 01             	and    $0x1,%eax
80107ee6:	85 c0                	test   %eax,%eax
80107ee8:	74 33                	je     80107f1d <freevm+0x82>
      char * v = p2v(PTE_ADDR(pgdir[i]));
80107eea:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107eed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80107ef4:	8b 45 08             	mov    0x8(%ebp),%eax
80107ef7:	01 d0                	add    %edx,%eax
80107ef9:	8b 00                	mov    (%eax),%eax
80107efb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107f00:	83 ec 0c             	sub    $0xc,%esp
80107f03:	50                   	push   %eax
80107f04:	e8 b3 f4 ff ff       	call   801073bc <p2v>
80107f09:	83 c4 10             	add    $0x10,%esp
80107f0c:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
80107f0f:	83 ec 0c             	sub    $0xc,%esp
80107f12:	ff 75 f0             	pushl  -0x10(%ebp)
80107f15:	e8 fa ab ff ff       	call   80102b14 <kfree>
80107f1a:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107f1d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107f21:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80107f28:	76 a8                	jbe    80107ed2 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = p2v(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
80107f2a:	83 ec 0c             	sub    $0xc,%esp
80107f2d:	ff 75 08             	pushl  0x8(%ebp)
80107f30:	e8 df ab ff ff       	call   80102b14 <kfree>
80107f35:	83 c4 10             	add    $0x10,%esp
}
80107f38:	90                   	nop
80107f39:	c9                   	leave  
80107f3a:	c3                   	ret    

80107f3b <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107f3b:	55                   	push   %ebp
80107f3c:	89 e5                	mov    %esp,%ebp
80107f3e:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107f41:	83 ec 04             	sub    $0x4,%esp
80107f44:	6a 00                	push   $0x0
80107f46:	ff 75 0c             	pushl  0xc(%ebp)
80107f49:	ff 75 08             	pushl  0x8(%ebp)
80107f4c:	e8 ed f8 ff ff       	call   8010783e <walkpgdir>
80107f51:	83 c4 10             	add    $0x10,%esp
80107f54:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
80107f57:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107f5b:	75 0d                	jne    80107f6a <clearpteu+0x2f>
    panic("clearpteu");
80107f5d:	83 ec 0c             	sub    $0xc,%esp
80107f60:	68 b4 87 10 80       	push   $0x801087b4
80107f65:	e8 fc 85 ff ff       	call   80100566 <panic>
  *pte &= ~PTE_U;
80107f6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f6d:	8b 00                	mov    (%eax),%eax
80107f6f:	83 e0 fb             	and    $0xfffffffb,%eax
80107f72:	89 c2                	mov    %eax,%edx
80107f74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107f77:	89 10                	mov    %edx,(%eax)
}
80107f79:	90                   	nop
80107f7a:	c9                   	leave  
80107f7b:	c3                   	ret    

80107f7c <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107f7c:	55                   	push   %ebp
80107f7d:	89 e5                	mov    %esp,%ebp
80107f7f:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
80107f82:	e8 e7 f9 ff ff       	call   8010796e <setupkvm>
80107f87:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107f8a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107f8e:	75 0a                	jne    80107f9a <copyuvm+0x1e>
    return 0;
80107f90:	b8 00 00 00 00       	mov    $0x0,%eax
80107f95:	e9 e9 00 00 00       	jmp    80108083 <copyuvm+0x107>
  for(i = 0; i < sz; i += PGSIZE){
80107f9a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107fa1:	e9 b5 00 00 00       	jmp    8010805b <copyuvm+0xdf>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107fa6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107fa9:	83 ec 04             	sub    $0x4,%esp
80107fac:	6a 00                	push   $0x0
80107fae:	50                   	push   %eax
80107faf:	ff 75 08             	pushl  0x8(%ebp)
80107fb2:	e8 87 f8 ff ff       	call   8010783e <walkpgdir>
80107fb7:	83 c4 10             	add    $0x10,%esp
80107fba:	89 45 ec             	mov    %eax,-0x14(%ebp)
80107fbd:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107fc1:	75 0d                	jne    80107fd0 <copyuvm+0x54>
      panic("copyuvm: pte should exist");
80107fc3:	83 ec 0c             	sub    $0xc,%esp
80107fc6:	68 be 87 10 80       	push   $0x801087be
80107fcb:	e8 96 85 ff ff       	call   80100566 <panic>
    if(!(*pte & PTE_P))
80107fd0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107fd3:	8b 00                	mov    (%eax),%eax
80107fd5:	83 e0 01             	and    $0x1,%eax
80107fd8:	85 c0                	test   %eax,%eax
80107fda:	75 0d                	jne    80107fe9 <copyuvm+0x6d>
      panic("copyuvm: page not present");
80107fdc:	83 ec 0c             	sub    $0xc,%esp
80107fdf:	68 d8 87 10 80       	push   $0x801087d8
80107fe4:	e8 7d 85 ff ff       	call   80100566 <panic>
    pa = PTE_ADDR(*pte);
80107fe9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107fec:	8b 00                	mov    (%eax),%eax
80107fee:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107ff3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if((mem = kalloc()) == 0)
80107ff6:	e8 b6 ab ff ff       	call   80102bb1 <kalloc>
80107ffb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107ffe:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80108002:	74 68                	je     8010806c <copyuvm+0xf0>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
80108004:	83 ec 0c             	sub    $0xc,%esp
80108007:	ff 75 e8             	pushl  -0x18(%ebp)
8010800a:	e8 ad f3 ff ff       	call   801073bc <p2v>
8010800f:	83 c4 10             	add    $0x10,%esp
80108012:	83 ec 04             	sub    $0x4,%esp
80108015:	68 00 10 00 00       	push   $0x1000
8010801a:	50                   	push   %eax
8010801b:	ff 75 e4             	pushl  -0x1c(%ebp)
8010801e:	e8 e8 ce ff ff       	call   80104f0b <memmove>
80108023:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
80108026:	83 ec 0c             	sub    $0xc,%esp
80108029:	ff 75 e4             	pushl  -0x1c(%ebp)
8010802c:	e8 7e f3 ff ff       	call   801073af <v2p>
80108031:	83 c4 10             	add    $0x10,%esp
80108034:	89 c2                	mov    %eax,%edx
80108036:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108039:	83 ec 0c             	sub    $0xc,%esp
8010803c:	6a 06                	push   $0x6
8010803e:	52                   	push   %edx
8010803f:	68 00 10 00 00       	push   $0x1000
80108044:	50                   	push   %eax
80108045:	ff 75 f0             	pushl  -0x10(%ebp)
80108048:	e8 91 f8 ff ff       	call   801078de <mappages>
8010804d:	83 c4 20             	add    $0x20,%esp
80108050:	85 c0                	test   %eax,%eax
80108052:	78 1b                	js     8010806f <copyuvm+0xf3>
  uint pa, i;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80108054:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010805b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010805e:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108061:	0f 82 3f ff ff ff    	jb     80107fa6 <copyuvm+0x2a>
      goto bad;
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
  }
  return d;
80108067:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010806a:	eb 17                	jmp    80108083 <copyuvm+0x107>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
8010806c:	90                   	nop
8010806d:	eb 01                	jmp    80108070 <copyuvm+0xf4>
    memmove(mem, (char*)p2v(pa), PGSIZE);
    if(mappages(d, (void*)i, PGSIZE, v2p(mem), PTE_W|PTE_U) < 0)
      goto bad;
8010806f:	90                   	nop
  }
  return d;

bad:
  freevm(d);
80108070:	83 ec 0c             	sub    $0xc,%esp
80108073:	ff 75 f0             	pushl  -0x10(%ebp)
80108076:	e8 20 fe ff ff       	call   80107e9b <freevm>
8010807b:	83 c4 10             	add    $0x10,%esp
  return 0;
8010807e:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108083:	c9                   	leave  
80108084:	c3                   	ret    

80108085 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80108085:	55                   	push   %ebp
80108086:	89 e5                	mov    %esp,%ebp
80108088:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
8010808b:	83 ec 04             	sub    $0x4,%esp
8010808e:	6a 00                	push   $0x0
80108090:	ff 75 0c             	pushl  0xc(%ebp)
80108093:	ff 75 08             	pushl  0x8(%ebp)
80108096:	e8 a3 f7 ff ff       	call   8010783e <walkpgdir>
8010809b:	83 c4 10             	add    $0x10,%esp
8010809e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
801080a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080a4:	8b 00                	mov    (%eax),%eax
801080a6:	83 e0 01             	and    $0x1,%eax
801080a9:	85 c0                	test   %eax,%eax
801080ab:	75 07                	jne    801080b4 <uva2ka+0x2f>
    return 0;
801080ad:	b8 00 00 00 00       	mov    $0x0,%eax
801080b2:	eb 29                	jmp    801080dd <uva2ka+0x58>
  if((*pte & PTE_U) == 0)
801080b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080b7:	8b 00                	mov    (%eax),%eax
801080b9:	83 e0 04             	and    $0x4,%eax
801080bc:	85 c0                	test   %eax,%eax
801080be:	75 07                	jne    801080c7 <uva2ka+0x42>
    return 0;
801080c0:	b8 00 00 00 00       	mov    $0x0,%eax
801080c5:	eb 16                	jmp    801080dd <uva2ka+0x58>
  return (char*)p2v(PTE_ADDR(*pte));
801080c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801080ca:	8b 00                	mov    (%eax),%eax
801080cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080d1:	83 ec 0c             	sub    $0xc,%esp
801080d4:	50                   	push   %eax
801080d5:	e8 e2 f2 ff ff       	call   801073bc <p2v>
801080da:	83 c4 10             	add    $0x10,%esp
}
801080dd:	c9                   	leave  
801080de:	c3                   	ret    

801080df <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
801080df:	55                   	push   %ebp
801080e0:	89 e5                	mov    %esp,%ebp
801080e2:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
801080e5:	8b 45 10             	mov    0x10(%ebp),%eax
801080e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
801080eb:	eb 7f                	jmp    8010816c <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
801080ed:	8b 45 0c             	mov    0xc(%ebp),%eax
801080f0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801080f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
801080f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801080fb:	83 ec 08             	sub    $0x8,%esp
801080fe:	50                   	push   %eax
801080ff:	ff 75 08             	pushl  0x8(%ebp)
80108102:	e8 7e ff ff ff       	call   80108085 <uva2ka>
80108107:	83 c4 10             	add    $0x10,%esp
8010810a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
8010810d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80108111:	75 07                	jne    8010811a <copyout+0x3b>
      return -1;
80108113:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108118:	eb 61                	jmp    8010817b <copyout+0x9c>
    n = PGSIZE - (va - va0);
8010811a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010811d:	2b 45 0c             	sub    0xc(%ebp),%eax
80108120:	05 00 10 00 00       	add    $0x1000,%eax
80108125:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
80108128:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010812b:	3b 45 14             	cmp    0x14(%ebp),%eax
8010812e:	76 06                	jbe    80108136 <copyout+0x57>
      n = len;
80108130:	8b 45 14             	mov    0x14(%ebp),%eax
80108133:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
80108136:	8b 45 0c             	mov    0xc(%ebp),%eax
80108139:	2b 45 ec             	sub    -0x14(%ebp),%eax
8010813c:	89 c2                	mov    %eax,%edx
8010813e:	8b 45 e8             	mov    -0x18(%ebp),%eax
80108141:	01 d0                	add    %edx,%eax
80108143:	83 ec 04             	sub    $0x4,%esp
80108146:	ff 75 f0             	pushl  -0x10(%ebp)
80108149:	ff 75 f4             	pushl  -0xc(%ebp)
8010814c:	50                   	push   %eax
8010814d:	e8 b9 cd ff ff       	call   80104f0b <memmove>
80108152:	83 c4 10             	add    $0x10,%esp
    len -= n;
80108155:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108158:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
8010815b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010815e:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
80108161:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108164:	05 00 10 00 00       	add    $0x1000,%eax
80108169:	89 45 0c             	mov    %eax,0xc(%ebp)
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
8010816c:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
80108170:	0f 85 77 ff ff ff    	jne    801080ed <copyout+0xe>
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
80108176:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010817b:	c9                   	leave  
8010817c:	c3                   	ret    
