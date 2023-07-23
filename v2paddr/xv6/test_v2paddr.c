#include "types.h"
#include "user.h"
#include "syscall.h"
#include "memlayout.h"

// Function that takes a virtual address as argument and calls v2paddr() syscall to obtain the corresponding physical address
void getResults(uint *VA) {
    int valid;  // For checking valid PA
    int PA = v2paddr(VA, &valid);  // Getting address and printing
    if(valid == 1) {
        printf(1, "Physical Address of 0x%x : 0x%x\n", VA, PA);
    }
    printf(1, "\n");
}

int Global = 9876;
	
int main(int argc, char *argv[]) {

    // First Test
    int firstTest = 0123;  // A test local for variable
    uint* VA = (uint*)(&firstTest);
    getResults(VA);

    // Second Test
    VA = (void*)(KERNBASE + 0x555); // A test for Kernel space
    getResults(VA);

    // Third Test
    VA = (uint*)(&Global);  // A test for global variable
    getResults(VA);

    exit();
}
