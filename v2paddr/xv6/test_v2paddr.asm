
_test_v2paddr:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    printf(1, "\n");
}

int Global = 9876;
	
int main(int argc, char *argv[]) {
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx

    // First Test
    int firstTest = 0123;  // A test local for variable
    uint* VA = (uint*)(&firstTest);
    getResults(VA);
  12:	8d 45 f4             	lea    -0xc(%ebp),%eax
int main(int argc, char *argv[]) {
  15:	83 ec 20             	sub    $0x20,%esp
    int firstTest = 0123;  // A test local for variable
  18:	c7 45 f4 53 00 00 00 	movl   $0x53,-0xc(%ebp)
    getResults(VA);
  1f:	50                   	push   %eax
  20:	e8 2b 00 00 00       	call   50 <getResults>

    // Second Test
    VA = (void*)(KERNBASE + 0x555); // A test for Kernel space
    getResults(VA);
  25:	c7 04 24 55 05 00 80 	movl   $0x80000555,(%esp)
  2c:	e8 1f 00 00 00       	call   50 <getResults>

    // Third Test
    VA = (uint*)(&Global);  // A test for global variable
    getResults(VA);
  31:	c7 04 24 d4 0a 00 00 	movl   $0xad4,(%esp)
  38:	e8 13 00 00 00       	call   50 <getResults>

    exit();
  3d:	e8 d1 02 00 00       	call   313 <exit>
  42:	66 90                	xchg   %ax,%ax
  44:	66 90                	xchg   %ax,%ax
  46:	66 90                	xchg   %ax,%ax
  48:	66 90                	xchg   %ax,%ax
  4a:	66 90                	xchg   %ax,%ax
  4c:	66 90                	xchg   %ax,%ax
  4e:	66 90                	xchg   %ax,%ax

00000050 <getResults>:
void getResults(uint *VA) {
  50:	f3 0f 1e fb          	endbr32 
  54:	55                   	push   %ebp
  55:	89 e5                	mov    %esp,%ebp
  57:	53                   	push   %ebx
    int PA = v2paddr(VA, &valid);  // Getting address and printing
  58:	8d 45 f4             	lea    -0xc(%ebp),%eax
void getResults(uint *VA) {
  5b:	83 ec 1c             	sub    $0x1c,%esp
  5e:	8b 5d 08             	mov    0x8(%ebp),%ebx
    int PA = v2paddr(VA, &valid);  // Getting address and printing
  61:	50                   	push   %eax
  62:	53                   	push   %ebx
  63:	e8 4b 03 00 00       	call   3b3 <v2paddr>
    if(valid == 1) {
  68:	83 c4 10             	add    $0x10,%esp
  6b:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
  6f:	74 1f                	je     90 <getResults+0x40>
    printf(1, "\n");
  71:	83 ec 08             	sub    $0x8,%esp
  74:	68 f9 07 00 00       	push   $0x7f9
  79:	6a 01                	push   $0x1
  7b:	e8 f0 03 00 00       	call   470 <printf>
}
  80:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  83:	83 c4 10             	add    $0x10,%esp
  86:	c9                   	leave  
  87:	c3                   	ret    
  88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  8f:	90                   	nop
        printf(1, "Physical Address of 0x%x : 0x%x\n", VA, PA);
  90:	50                   	push   %eax
  91:	53                   	push   %ebx
  92:	68 d8 07 00 00       	push   $0x7d8
  97:	6a 01                	push   $0x1
  99:	e8 d2 03 00 00       	call   470 <printf>
  9e:	83 c4 10             	add    $0x10,%esp
  a1:	eb ce                	jmp    71 <getResults+0x21>
  a3:	66 90                	xchg   %ax,%ax
  a5:	66 90                	xchg   %ax,%ax
  a7:	66 90                	xchg   %ax,%ax
  a9:	66 90                	xchg   %ax,%ax
  ab:	66 90                	xchg   %ax,%ax
  ad:	66 90                	xchg   %ax,%ax
  af:	90                   	nop

000000b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  b0:	f3 0f 1e fb          	endbr32 
  b4:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  b5:	31 c0                	xor    %eax,%eax
{
  b7:	89 e5                	mov    %esp,%ebp
  b9:	53                   	push   %ebx
  ba:	8b 4d 08             	mov    0x8(%ebp),%ecx
  bd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
  c0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  c4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  c7:	83 c0 01             	add    $0x1,%eax
  ca:	84 d2                	test   %dl,%dl
  cc:	75 f2                	jne    c0 <strcpy+0x10>
    ;
  return os;
}
  ce:	89 c8                	mov    %ecx,%eax
  d0:	5b                   	pop    %ebx
  d1:	5d                   	pop    %ebp
  d2:	c3                   	ret    
  d3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e0:	f3 0f 1e fb          	endbr32 
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	53                   	push   %ebx
  e8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ee:	0f b6 01             	movzbl (%ecx),%eax
  f1:	0f b6 1a             	movzbl (%edx),%ebx
  f4:	84 c0                	test   %al,%al
  f6:	75 19                	jne    111 <strcmp+0x31>
  f8:	eb 26                	jmp    120 <strcmp+0x40>
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 100:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 104:	83 c1 01             	add    $0x1,%ecx
 107:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 10a:	0f b6 1a             	movzbl (%edx),%ebx
 10d:	84 c0                	test   %al,%al
 10f:	74 0f                	je     120 <strcmp+0x40>
 111:	38 d8                	cmp    %bl,%al
 113:	74 eb                	je     100 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 115:	29 d8                	sub    %ebx,%eax
}
 117:	5b                   	pop    %ebx
 118:	5d                   	pop    %ebp
 119:	c3                   	ret    
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 120:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 122:	29 d8                	sub    %ebx,%eax
}
 124:	5b                   	pop    %ebx
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax

00000130 <strlen>:

uint
strlen(const char *s)
{
 130:	f3 0f 1e fb          	endbr32 
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 13a:	80 3a 00             	cmpb   $0x0,(%edx)
 13d:	74 21                	je     160 <strlen+0x30>
 13f:	31 c0                	xor    %eax,%eax
 141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 148:	83 c0 01             	add    $0x1,%eax
 14b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 14f:	89 c1                	mov    %eax,%ecx
 151:	75 f5                	jne    148 <strlen+0x18>
    ;
  return n;
}
 153:	89 c8                	mov    %ecx,%eax
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 160:	31 c9                	xor    %ecx,%ecx
}
 162:	5d                   	pop    %ebp
 163:	89 c8                	mov    %ecx,%eax
 165:	c3                   	ret    
 166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16d:	8d 76 00             	lea    0x0(%esi),%esi

00000170 <memset>:

void*
memset(void *dst, int c, uint n)
{
 170:	f3 0f 1e fb          	endbr32 
 174:	55                   	push   %ebp
 175:	89 e5                	mov    %esp,%ebp
 177:	57                   	push   %edi
 178:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 17b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 17e:	8b 45 0c             	mov    0xc(%ebp),%eax
 181:	89 d7                	mov    %edx,%edi
 183:	fc                   	cld    
 184:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 186:	89 d0                	mov    %edx,%eax
 188:	5f                   	pop    %edi
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 18f:	90                   	nop

00000190 <strchr>:

char*
strchr(const char *s, char c)
{
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 19e:	0f b6 10             	movzbl (%eax),%edx
 1a1:	84 d2                	test   %dl,%dl
 1a3:	75 16                	jne    1bb <strchr+0x2b>
 1a5:	eb 21                	jmp    1c8 <strchr+0x38>
 1a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ae:	66 90                	xchg   %ax,%ax
 1b0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1b4:	83 c0 01             	add    $0x1,%eax
 1b7:	84 d2                	test   %dl,%dl
 1b9:	74 0d                	je     1c8 <strchr+0x38>
    if(*s == c)
 1bb:	38 d1                	cmp    %dl,%cl
 1bd:	75 f1                	jne    1b0 <strchr+0x20>
      return (char*)s;
  return 0;
}
 1bf:	5d                   	pop    %ebp
 1c0:	c3                   	ret    
 1c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 1c8:	31 c0                	xor    %eax,%eax
}
 1ca:	5d                   	pop    %ebp
 1cb:	c3                   	ret    
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001d0 <gets>:

char*
gets(char *buf, int max)
{
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	57                   	push   %edi
 1d8:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d9:	31 f6                	xor    %esi,%esi
{
 1db:	53                   	push   %ebx
 1dc:	89 f3                	mov    %esi,%ebx
 1de:	83 ec 1c             	sub    $0x1c,%esp
 1e1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1e4:	eb 33                	jmp    219 <gets+0x49>
 1e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1f0:	83 ec 04             	sub    $0x4,%esp
 1f3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1f6:	6a 01                	push   $0x1
 1f8:	50                   	push   %eax
 1f9:	6a 00                	push   $0x0
 1fb:	e8 2b 01 00 00       	call   32b <read>
    if(cc < 1)
 200:	83 c4 10             	add    $0x10,%esp
 203:	85 c0                	test   %eax,%eax
 205:	7e 1c                	jle    223 <gets+0x53>
      break;
    buf[i++] = c;
 207:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 20b:	83 c7 01             	add    $0x1,%edi
 20e:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 211:	3c 0a                	cmp    $0xa,%al
 213:	74 23                	je     238 <gets+0x68>
 215:	3c 0d                	cmp    $0xd,%al
 217:	74 1f                	je     238 <gets+0x68>
  for(i=0; i+1 < max; ){
 219:	83 c3 01             	add    $0x1,%ebx
 21c:	89 fe                	mov    %edi,%esi
 21e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 221:	7c cd                	jl     1f0 <gets+0x20>
 223:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 225:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 228:	c6 03 00             	movb   $0x0,(%ebx)
}
 22b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 22e:	5b                   	pop    %ebx
 22f:	5e                   	pop    %esi
 230:	5f                   	pop    %edi
 231:	5d                   	pop    %ebp
 232:	c3                   	ret    
 233:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 237:	90                   	nop
 238:	8b 75 08             	mov    0x8(%ebp),%esi
 23b:	8b 45 08             	mov    0x8(%ebp),%eax
 23e:	01 de                	add    %ebx,%esi
 240:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 242:	c6 03 00             	movb   $0x0,(%ebx)
}
 245:	8d 65 f4             	lea    -0xc(%ebp),%esp
 248:	5b                   	pop    %ebx
 249:	5e                   	pop    %esi
 24a:	5f                   	pop    %edi
 24b:	5d                   	pop    %ebp
 24c:	c3                   	ret    
 24d:	8d 76 00             	lea    0x0(%esi),%esi

00000250 <stat>:

int
stat(const char *n, struct stat *st)
{
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	56                   	push   %esi
 258:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 259:	83 ec 08             	sub    $0x8,%esp
 25c:	6a 00                	push   $0x0
 25e:	ff 75 08             	pushl  0x8(%ebp)
 261:	e8 ed 00 00 00       	call   353 <open>
  if(fd < 0)
 266:	83 c4 10             	add    $0x10,%esp
 269:	85 c0                	test   %eax,%eax
 26b:	78 2b                	js     298 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 26d:	83 ec 08             	sub    $0x8,%esp
 270:	ff 75 0c             	pushl  0xc(%ebp)
 273:	89 c3                	mov    %eax,%ebx
 275:	50                   	push   %eax
 276:	e8 f0 00 00 00       	call   36b <fstat>
  close(fd);
 27b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 27e:	89 c6                	mov    %eax,%esi
  close(fd);
 280:	e8 b6 00 00 00       	call   33b <close>
  return r;
 285:	83 c4 10             	add    $0x10,%esp
}
 288:	8d 65 f8             	lea    -0x8(%ebp),%esp
 28b:	89 f0                	mov    %esi,%eax
 28d:	5b                   	pop    %ebx
 28e:	5e                   	pop    %esi
 28f:	5d                   	pop    %ebp
 290:	c3                   	ret    
 291:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 298:	be ff ff ff ff       	mov    $0xffffffff,%esi
 29d:	eb e9                	jmp    288 <stat+0x38>
 29f:	90                   	nop

000002a0 <atoi>:

int
atoi(const char *s)
{
 2a0:	f3 0f 1e fb          	endbr32 
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	53                   	push   %ebx
 2a8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2ab:	0f be 02             	movsbl (%edx),%eax
 2ae:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2b1:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2b4:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2b9:	77 1a                	ja     2d5 <atoi+0x35>
 2bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2bf:	90                   	nop
    n = n*10 + *s++ - '0';
 2c0:	83 c2 01             	add    $0x1,%edx
 2c3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2c6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2ca:	0f be 02             	movsbl (%edx),%eax
 2cd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2d0:	80 fb 09             	cmp    $0x9,%bl
 2d3:	76 eb                	jbe    2c0 <atoi+0x20>
  return n;
}
 2d5:	89 c8                	mov    %ecx,%eax
 2d7:	5b                   	pop    %ebx
 2d8:	5d                   	pop    %ebp
 2d9:	c3                   	ret    
 2da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002e0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2e0:	f3 0f 1e fb          	endbr32 
 2e4:	55                   	push   %ebp
 2e5:	89 e5                	mov    %esp,%ebp
 2e7:	57                   	push   %edi
 2e8:	8b 45 10             	mov    0x10(%ebp),%eax
 2eb:	8b 55 08             	mov    0x8(%ebp),%edx
 2ee:	56                   	push   %esi
 2ef:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2f2:	85 c0                	test   %eax,%eax
 2f4:	7e 0f                	jle    305 <memmove+0x25>
 2f6:	01 d0                	add    %edx,%eax
  dst = vdst;
 2f8:	89 d7                	mov    %edx,%edi
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 300:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 301:	39 f8                	cmp    %edi,%eax
 303:	75 fb                	jne    300 <memmove+0x20>
  return vdst;
}
 305:	5e                   	pop    %esi
 306:	89 d0                	mov    %edx,%eax
 308:	5f                   	pop    %edi
 309:	5d                   	pop    %ebp
 30a:	c3                   	ret    

0000030b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 30b:	b8 01 00 00 00       	mov    $0x1,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <exit>:
SYSCALL(exit)
 313:	b8 02 00 00 00       	mov    $0x2,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <wait>:
SYSCALL(wait)
 31b:	b8 03 00 00 00       	mov    $0x3,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <pipe>:
SYSCALL(pipe)
 323:	b8 04 00 00 00       	mov    $0x4,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <read>:
SYSCALL(read)
 32b:	b8 05 00 00 00       	mov    $0x5,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <write>:
SYSCALL(write)
 333:	b8 10 00 00 00       	mov    $0x10,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <close>:
SYSCALL(close)
 33b:	b8 15 00 00 00       	mov    $0x15,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <kill>:
SYSCALL(kill)
 343:	b8 06 00 00 00       	mov    $0x6,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <exec>:
SYSCALL(exec)
 34b:	b8 07 00 00 00       	mov    $0x7,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <open>:
SYSCALL(open)
 353:	b8 0f 00 00 00       	mov    $0xf,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <mknod>:
SYSCALL(mknod)
 35b:	b8 11 00 00 00       	mov    $0x11,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <unlink>:
SYSCALL(unlink)
 363:	b8 12 00 00 00       	mov    $0x12,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <fstat>:
SYSCALL(fstat)
 36b:	b8 08 00 00 00       	mov    $0x8,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <link>:
SYSCALL(link)
 373:	b8 13 00 00 00       	mov    $0x13,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <mkdir>:
SYSCALL(mkdir)
 37b:	b8 14 00 00 00       	mov    $0x14,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <chdir>:
SYSCALL(chdir)
 383:	b8 09 00 00 00       	mov    $0x9,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <dup>:
SYSCALL(dup)
 38b:	b8 0a 00 00 00       	mov    $0xa,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <getpid>:
SYSCALL(getpid)
 393:	b8 0b 00 00 00       	mov    $0xb,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <sbrk>:
SYSCALL(sbrk)
 39b:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <sleep>:
SYSCALL(sleep)
 3a3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <uptime>:
SYSCALL(uptime)
 3ab:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <v2paddr>:
SYSCALL(v2paddr)
 3b3:	b8 16 00 00 00       	mov    $0x16,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    
 3bb:	66 90                	xchg   %ax,%ax
 3bd:	66 90                	xchg   %ax,%ax
 3bf:	90                   	nop

000003c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	57                   	push   %edi
 3c4:	56                   	push   %esi
 3c5:	53                   	push   %ebx
 3c6:	83 ec 3c             	sub    $0x3c,%esp
 3c9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 3cc:	89 d1                	mov    %edx,%ecx
{
 3ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 3d1:	85 d2                	test   %edx,%edx
 3d3:	0f 89 7f 00 00 00    	jns    458 <printint+0x98>
 3d9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3dd:	74 79                	je     458 <printint+0x98>
    neg = 1;
 3df:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 3e6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 3e8:	31 db                	xor    %ebx,%ebx
 3ea:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3ed:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 3f0:	89 c8                	mov    %ecx,%eax
 3f2:	31 d2                	xor    %edx,%edx
 3f4:	89 cf                	mov    %ecx,%edi
 3f6:	f7 75 c4             	divl   -0x3c(%ebp)
 3f9:	0f b6 92 04 08 00 00 	movzbl 0x804(%edx),%edx
 400:	89 45 c0             	mov    %eax,-0x40(%ebp)
 403:	89 d8                	mov    %ebx,%eax
 405:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 408:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 40b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 40e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 411:	76 dd                	jbe    3f0 <printint+0x30>
  if(neg)
 413:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 416:	85 c9                	test   %ecx,%ecx
 418:	74 0c                	je     426 <printint+0x66>
    buf[i++] = '-';
 41a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 41f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 421:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 426:	8b 7d b8             	mov    -0x48(%ebp),%edi
 429:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 42d:	eb 07                	jmp    436 <printint+0x76>
 42f:	90                   	nop
 430:	0f b6 13             	movzbl (%ebx),%edx
 433:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 436:	83 ec 04             	sub    $0x4,%esp
 439:	88 55 d7             	mov    %dl,-0x29(%ebp)
 43c:	6a 01                	push   $0x1
 43e:	56                   	push   %esi
 43f:	57                   	push   %edi
 440:	e8 ee fe ff ff       	call   333 <write>
  while(--i >= 0)
 445:	83 c4 10             	add    $0x10,%esp
 448:	39 de                	cmp    %ebx,%esi
 44a:	75 e4                	jne    430 <printint+0x70>
    putc(fd, buf[i]);
}
 44c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 44f:	5b                   	pop    %ebx
 450:	5e                   	pop    %esi
 451:	5f                   	pop    %edi
 452:	5d                   	pop    %ebp
 453:	c3                   	ret    
 454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 458:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 45f:	eb 87                	jmp    3e8 <printint+0x28>
 461:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 468:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 46f:	90                   	nop

00000470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 470:	f3 0f 1e fb          	endbr32 
 474:	55                   	push   %ebp
 475:	89 e5                	mov    %esp,%ebp
 477:	57                   	push   %edi
 478:	56                   	push   %esi
 479:	53                   	push   %ebx
 47a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 47d:	8b 75 0c             	mov    0xc(%ebp),%esi
 480:	0f b6 1e             	movzbl (%esi),%ebx
 483:	84 db                	test   %bl,%bl
 485:	0f 84 b4 00 00 00    	je     53f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 48b:	8d 45 10             	lea    0x10(%ebp),%eax
 48e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 491:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 494:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 496:	89 45 d0             	mov    %eax,-0x30(%ebp)
 499:	eb 33                	jmp    4ce <printf+0x5e>
 49b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 49f:	90                   	nop
 4a0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4a3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 4a8:	83 f8 25             	cmp    $0x25,%eax
 4ab:	74 17                	je     4c4 <printf+0x54>
  write(fd, &c, 1);
 4ad:	83 ec 04             	sub    $0x4,%esp
 4b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4b3:	6a 01                	push   $0x1
 4b5:	57                   	push   %edi
 4b6:	ff 75 08             	pushl  0x8(%ebp)
 4b9:	e8 75 fe ff ff       	call   333 <write>
 4be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 4c1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4c4:	0f b6 1e             	movzbl (%esi),%ebx
 4c7:	83 c6 01             	add    $0x1,%esi
 4ca:	84 db                	test   %bl,%bl
 4cc:	74 71                	je     53f <printf+0xcf>
    c = fmt[i] & 0xff;
 4ce:	0f be cb             	movsbl %bl,%ecx
 4d1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4d4:	85 d2                	test   %edx,%edx
 4d6:	74 c8                	je     4a0 <printf+0x30>
      }
    } else if(state == '%'){
 4d8:	83 fa 25             	cmp    $0x25,%edx
 4db:	75 e7                	jne    4c4 <printf+0x54>
      if(c == 'd'){
 4dd:	83 f8 64             	cmp    $0x64,%eax
 4e0:	0f 84 9a 00 00 00    	je     580 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4e6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4ec:	83 f9 70             	cmp    $0x70,%ecx
 4ef:	74 5f                	je     550 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4f1:	83 f8 73             	cmp    $0x73,%eax
 4f4:	0f 84 d6 00 00 00    	je     5d0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4fa:	83 f8 63             	cmp    $0x63,%eax
 4fd:	0f 84 8d 00 00 00    	je     590 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 503:	83 f8 25             	cmp    $0x25,%eax
 506:	0f 84 b4 00 00 00    	je     5c0 <printf+0x150>
  write(fd, &c, 1);
 50c:	83 ec 04             	sub    $0x4,%esp
 50f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 513:	6a 01                	push   $0x1
 515:	57                   	push   %edi
 516:	ff 75 08             	pushl  0x8(%ebp)
 519:	e8 15 fe ff ff       	call   333 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 51e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 521:	83 c4 0c             	add    $0xc,%esp
 524:	6a 01                	push   $0x1
 526:	83 c6 01             	add    $0x1,%esi
 529:	57                   	push   %edi
 52a:	ff 75 08             	pushl  0x8(%ebp)
 52d:	e8 01 fe ff ff       	call   333 <write>
  for(i = 0; fmt[i]; i++){
 532:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 536:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 539:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 53b:	84 db                	test   %bl,%bl
 53d:	75 8f                	jne    4ce <printf+0x5e>
    }
  }
}
 53f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 542:	5b                   	pop    %ebx
 543:	5e                   	pop    %esi
 544:	5f                   	pop    %edi
 545:	5d                   	pop    %ebp
 546:	c3                   	ret    
 547:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	b9 10 00 00 00       	mov    $0x10,%ecx
 558:	6a 00                	push   $0x0
 55a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 55d:	8b 45 08             	mov    0x8(%ebp),%eax
 560:	8b 13                	mov    (%ebx),%edx
 562:	e8 59 fe ff ff       	call   3c0 <printint>
        ap++;
 567:	89 d8                	mov    %ebx,%eax
 569:	83 c4 10             	add    $0x10,%esp
      state = 0;
 56c:	31 d2                	xor    %edx,%edx
        ap++;
 56e:	83 c0 04             	add    $0x4,%eax
 571:	89 45 d0             	mov    %eax,-0x30(%ebp)
 574:	e9 4b ff ff ff       	jmp    4c4 <printf+0x54>
 579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 580:	83 ec 0c             	sub    $0xc,%esp
 583:	b9 0a 00 00 00       	mov    $0xa,%ecx
 588:	6a 01                	push   $0x1
 58a:	eb ce                	jmp    55a <printf+0xea>
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 590:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 593:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 596:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 598:	6a 01                	push   $0x1
        ap++;
 59a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 59d:	57                   	push   %edi
 59e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 5a1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5a4:	e8 8a fd ff ff       	call   333 <write>
        ap++;
 5a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5af:	31 d2                	xor    %edx,%edx
 5b1:	e9 0e ff ff ff       	jmp    4c4 <printf+0x54>
 5b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 5c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5c3:	83 ec 04             	sub    $0x4,%esp
 5c6:	e9 59 ff ff ff       	jmp    524 <printf+0xb4>
 5cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5cf:	90                   	nop
        s = (char*)*ap;
 5d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5d3:	8b 18                	mov    (%eax),%ebx
        ap++;
 5d5:	83 c0 04             	add    $0x4,%eax
 5d8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5db:	85 db                	test   %ebx,%ebx
 5dd:	74 17                	je     5f6 <printf+0x186>
        while(*s != 0){
 5df:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5e2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5e4:	84 c0                	test   %al,%al
 5e6:	0f 84 d8 fe ff ff    	je     4c4 <printf+0x54>
 5ec:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5ef:	89 de                	mov    %ebx,%esi
 5f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5f4:	eb 1a                	jmp    610 <printf+0x1a0>
          s = "(null)";
 5f6:	bb fb 07 00 00       	mov    $0x7fb,%ebx
        while(*s != 0){
 5fb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5fe:	b8 28 00 00 00       	mov    $0x28,%eax
 603:	89 de                	mov    %ebx,%esi
 605:	8b 5d 08             	mov    0x8(%ebp),%ebx
 608:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 60f:	90                   	nop
  write(fd, &c, 1);
 610:	83 ec 04             	sub    $0x4,%esp
          s++;
 613:	83 c6 01             	add    $0x1,%esi
 616:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 619:	6a 01                	push   $0x1
 61b:	57                   	push   %edi
 61c:	53                   	push   %ebx
 61d:	e8 11 fd ff ff       	call   333 <write>
        while(*s != 0){
 622:	0f b6 06             	movzbl (%esi),%eax
 625:	83 c4 10             	add    $0x10,%esp
 628:	84 c0                	test   %al,%al
 62a:	75 e4                	jne    610 <printf+0x1a0>
 62c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 62f:	31 d2                	xor    %edx,%edx
 631:	e9 8e fe ff ff       	jmp    4c4 <printf+0x54>
 636:	66 90                	xchg   %ax,%ax
 638:	66 90                	xchg   %ax,%ax
 63a:	66 90                	xchg   %ax,%ax
 63c:	66 90                	xchg   %ax,%ax
 63e:	66 90                	xchg   %ax,%ax

00000640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 640:	f3 0f 1e fb          	endbr32 
 644:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 645:	a1 d8 0a 00 00       	mov    0xad8,%eax
{
 64a:	89 e5                	mov    %esp,%ebp
 64c:	57                   	push   %edi
 64d:	56                   	push   %esi
 64e:	53                   	push   %ebx
 64f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 652:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 654:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 657:	39 c8                	cmp    %ecx,%eax
 659:	73 15                	jae    670 <free+0x30>
 65b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 65f:	90                   	nop
 660:	39 d1                	cmp    %edx,%ecx
 662:	72 14                	jb     678 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 664:	39 d0                	cmp    %edx,%eax
 666:	73 10                	jae    678 <free+0x38>
{
 668:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66a:	8b 10                	mov    (%eax),%edx
 66c:	39 c8                	cmp    %ecx,%eax
 66e:	72 f0                	jb     660 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 670:	39 d0                	cmp    %edx,%eax
 672:	72 f4                	jb     668 <free+0x28>
 674:	39 d1                	cmp    %edx,%ecx
 676:	73 f0                	jae    668 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 678:	8b 73 fc             	mov    -0x4(%ebx),%esi
 67b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 67e:	39 fa                	cmp    %edi,%edx
 680:	74 1e                	je     6a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 682:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 685:	8b 50 04             	mov    0x4(%eax),%edx
 688:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 68b:	39 f1                	cmp    %esi,%ecx
 68d:	74 28                	je     6b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 68f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 691:	5b                   	pop    %ebx
  freep = p;
 692:	a3 d8 0a 00 00       	mov    %eax,0xad8
}
 697:	5e                   	pop    %esi
 698:	5f                   	pop    %edi
 699:	5d                   	pop    %ebp
 69a:	c3                   	ret    
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 6a0:	03 72 04             	add    0x4(%edx),%esi
 6a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6a6:	8b 10                	mov    (%eax),%edx
 6a8:	8b 12                	mov    (%edx),%edx
 6aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ad:	8b 50 04             	mov    0x4(%eax),%edx
 6b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b3:	39 f1                	cmp    %esi,%ecx
 6b5:	75 d8                	jne    68f <free+0x4f>
    p->s.size += bp->s.size;
 6b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6ba:	a3 d8 0a 00 00       	mov    %eax,0xad8
    p->s.size += bp->s.size;
 6bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6c5:	89 10                	mov    %edx,(%eax)
}
 6c7:	5b                   	pop    %ebx
 6c8:	5e                   	pop    %esi
 6c9:	5f                   	pop    %edi
 6ca:	5d                   	pop    %ebp
 6cb:	c3                   	ret    
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6d0:	f3 0f 1e fb          	endbr32 
 6d4:	55                   	push   %ebp
 6d5:	89 e5                	mov    %esp,%ebp
 6d7:	57                   	push   %edi
 6d8:	56                   	push   %esi
 6d9:	53                   	push   %ebx
 6da:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6dd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6e0:	8b 3d d8 0a 00 00    	mov    0xad8,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6e6:	8d 70 07             	lea    0x7(%eax),%esi
 6e9:	c1 ee 03             	shr    $0x3,%esi
 6ec:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 6ef:	85 ff                	test   %edi,%edi
 6f1:	0f 84 a9 00 00 00    	je     7a0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6f7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 6f9:	8b 48 04             	mov    0x4(%eax),%ecx
 6fc:	39 f1                	cmp    %esi,%ecx
 6fe:	73 6d                	jae    76d <malloc+0x9d>
 700:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 706:	bb 00 10 00 00       	mov    $0x1000,%ebx
 70b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 70e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 715:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 718:	eb 17                	jmp    731 <malloc+0x61>
 71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 720:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 722:	8b 4a 04             	mov    0x4(%edx),%ecx
 725:	39 f1                	cmp    %esi,%ecx
 727:	73 4f                	jae    778 <malloc+0xa8>
 729:	8b 3d d8 0a 00 00    	mov    0xad8,%edi
 72f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 731:	39 c7                	cmp    %eax,%edi
 733:	75 eb                	jne    720 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 735:	83 ec 0c             	sub    $0xc,%esp
 738:	ff 75 e4             	pushl  -0x1c(%ebp)
 73b:	e8 5b fc ff ff       	call   39b <sbrk>
  if(p == (char*)-1)
 740:	83 c4 10             	add    $0x10,%esp
 743:	83 f8 ff             	cmp    $0xffffffff,%eax
 746:	74 1b                	je     763 <malloc+0x93>
  hp->s.size = nu;
 748:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 74b:	83 ec 0c             	sub    $0xc,%esp
 74e:	83 c0 08             	add    $0x8,%eax
 751:	50                   	push   %eax
 752:	e8 e9 fe ff ff       	call   640 <free>
  return freep;
 757:	a1 d8 0a 00 00       	mov    0xad8,%eax
      if((p = morecore(nunits)) == 0)
 75c:	83 c4 10             	add    $0x10,%esp
 75f:	85 c0                	test   %eax,%eax
 761:	75 bd                	jne    720 <malloc+0x50>
        return 0;
  }
}
 763:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 766:	31 c0                	xor    %eax,%eax
}
 768:	5b                   	pop    %ebx
 769:	5e                   	pop    %esi
 76a:	5f                   	pop    %edi
 76b:	5d                   	pop    %ebp
 76c:	c3                   	ret    
    if(p->s.size >= nunits){
 76d:	89 c2                	mov    %eax,%edx
 76f:	89 f8                	mov    %edi,%eax
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 778:	39 ce                	cmp    %ecx,%esi
 77a:	74 54                	je     7d0 <malloc+0x100>
        p->s.size -= nunits;
 77c:	29 f1                	sub    %esi,%ecx
 77e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 781:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 784:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 787:	a3 d8 0a 00 00       	mov    %eax,0xad8
}
 78c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 78f:	8d 42 08             	lea    0x8(%edx),%eax
}
 792:	5b                   	pop    %ebx
 793:	5e                   	pop    %esi
 794:	5f                   	pop    %edi
 795:	5d                   	pop    %ebp
 796:	c3                   	ret    
 797:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 79e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 7a0:	c7 05 d8 0a 00 00 dc 	movl   $0xadc,0xad8
 7a7:	0a 00 00 
    base.s.size = 0;
 7aa:	bf dc 0a 00 00       	mov    $0xadc,%edi
    base.s.ptr = freep = prevp = &base;
 7af:	c7 05 dc 0a 00 00 dc 	movl   $0xadc,0xadc
 7b6:	0a 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 7bb:	c7 05 e0 0a 00 00 00 	movl   $0x0,0xae0
 7c2:	00 00 00 
    if(p->s.size >= nunits){
 7c5:	e9 36 ff ff ff       	jmp    700 <malloc+0x30>
 7ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 7d0:	8b 0a                	mov    (%edx),%ecx
 7d2:	89 08                	mov    %ecx,(%eax)
 7d4:	eb b1                	jmp    787 <malloc+0xb7>
