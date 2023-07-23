#include "types.h"
#include "user.h"
#include "syscall.h"
int main(int argc, char *argv[])
{
if (fork() == 0) {
printf(1, "child write count %d\n", getcount(SYS_write));
printf(1, "child fork count %d\n", getcount(SYS_fork));
printf(1, "child read count %d\n", getcount(SYS_read));
} 
else {
    wait();
    printf(1, "parent fork count %d\n", getcount(SYS_fork));
    printf(1, "parent write count %d\n", getcount(SYS_write));
    printf(1, "parent read count %d\n", getcount(SYS_read));
}
printf(1, "wait count %d\n", getcount(SYS_wait));
exit();
}
