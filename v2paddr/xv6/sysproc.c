#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

long sys_v2paddr(void) {
    uint *vpn;
    int *valid, ppn;
    
    argptr(1, (void*) &valid, sizeof(*valid));
    *valid = 1;
    // Checking, is VA is valid or invalid
    if(argptr(0, (void*) &vpn, sizeof(*vpn)) < 0) {
        cprintf("Invalid virtual address : 0x%x\n", (*vpn));
        *valid = 0;
        return -1; 
    }

    struct proc *currProcess = myproc();  // Getting the current process

    pde_t *cr3 = currProcess->pgdir;  // Getting base of the page directory from %cr3
    pde_t *PDE = &cr3[PDX(vpn)];  // Getting the page directory entry from the VA

    // Checking, if page directory entry is not present or can't be accessable
    if(!(*PDE & PTE_P)) {
        cprintf("Page directory entry not present for virtual address : 0x%x\n", (*vpn));
        *valid = 0;
        return -1;
    }
   if(!(*PDE & PTE_U)) {
        cprintf("Page directory entry can't be accessable for virtual address : 0x%x\n", (*vpn));
        *valid = 0;
        return -1;
    }

    pde_t *pgtab = (pte_t *)P2V(PTE_ADDR(*PDE));  // Getting base of the page table from page directory entry
    pde_t *PTE = &pgtab[PTX(vpn)];  // Getting the page table entry obtained from the VA

    // Checking if page table entry is not present or can't be accessable
    if(!(*PTE & PTE_P)) {
        cprintf("Page table entry not present for virtual address : 0x%x\n", (*vpn));
        *valid = 0;
        return -1;
    }
    if(!(*PTE & PTE_U)) {
        cprintf("Page table entry can't be accessable for virtual address : 0x%x\n", (*vpn));
        *valid = 0;
        return -1;
    }

    // Getting page frame or physical page n. (ppn) from page directory entry
    ppn = PTE_ADDR(*PTE);
    return (ppn + PTE_FLAGS(vpn));  // Returning the Physical Address
}
