
#define _GNU_SOURCE 1
#define _FILE_OFFSET_BITS 64
#define SYSLOG_NAMES 1
#include <stddef.h>
#include <sys/types.h>

#include <aio.h>
#include <alloca.h>
#include <ar.h>
#include <arpa/ftp.h>
#include <arpa/inet.h>
#include <arpa/nameser.h>
#include <arpa/telnet.h>
#include <arpa/tftp.h>
#include <assert.h>
#include <byteswap.h>
#include <complex.h>
#include <cpio.h>
#include <crypt.h>
#include <ctype.h>
#include <dirent.h>
#include <dlfcn.h>
#include <elf.h>
#include <endian.h>
#include <err.h>
#include <errno.h>
#include <fcntl.h>
#include <features.h>
#include <fenv.h>
#include <float.h>
#include <fmtmsg.h>
#include <fnmatch.h>
#include <ftw.h>
#include <getopt.h>
#include <glob.h>
#include <grp.h>
#include <iconv.h>
#include <ifaddrs.h>
#include <inttypes.h>
#include <iso646.h>
#include <langinfo.h>
#include <libgen.h>
#include <libintl.h>
#include <limits.h>
#include <link.h>
#include <locale.h>
#include <malloc.h>
#include <math.h>
#include <mntent.h>
#include <monetary.h>
#include <mqueue.h>
#include <net/ethernet.h>
#include <net/if.h>
#include <net/if_arp.h>
#include <net/route.h>
#include <netdb.h>
#include <netinet/ether.h>
#include <netinet/icmp6.h>
#include <netinet/if_ether.h>
#include <netinet/igmp.h>
#include <netinet/in.h>
#include <netinet/in_systm.h>
#include <netinet/ip.h>
#include <netinet/ip6.h>
#include <netinet/ip_icmp.h>
#include <netinet/tcp.h>
#include <netinet/udp.h>
#include <netpacket/packet.h>
#include <nl_types.h>
#include <paths.h>
#include <poll.h>
#include <pthread.h>
#include <pty.h>
#include <pwd.h>
#include <regex.h>
#include <resolv.h>
#include <sched.h>
#include <scsi/scsi.h>
#include <scsi/scsi_ioctl.h>
#include <scsi/sg.h>
#include <search.h>
#include <semaphore.h>
#include <setjmp.h>
#include <shadow.h>
#include <signal.h>
#include <spawn.h>
#ifndef __GLIBC__
#include <stdalign.h>
#endif
#include <stdarg.h>
#include <stdbool.h>
#include <stdc-predef.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdio_ext.h>
#include <stdlib.h>
#ifndef __GLIBC__
#include <stdnoreturn.h>
#endif
#include <string.h>
#include <strings.h>
#include <stropts.h>
#include <sys/acct.h>
#include <sys/auxv.h>
//#include <sys/cachectl.h>
#include <sys/dir.h>
#include <sys/epoll.h>
#include <sys/eventfd.h>
#include <sys/fanotify.h>
#include <sys/file.h>
#include <sys/fsuid.h>
#include <sys/inotify.h>
//#include <sys/io.h>
#include <sys/ioctl.h>
#include <sys/ipc.h>
//#include <sys/kd.h>
#include <sys/klog.h>
#include <sys/mman.h>
#include <sys/mount.h>
#include <sys/msg.h>
#include <sys/mtio.h>
#include <sys/param.h>
#include <sys/personality.h>
#include <sys/prctl.h>
#include <sys/procfs.h>
#include <sys/ptrace.h>
#include <sys/quota.h>
#include <sys/reboot.h>
//#include <sys/reg.h>
#include <sys/resource.h>
#include <sys/select.h>
#include <sys/sem.h>
#include <sys/sendfile.h>
#include <sys/shm.h>
#include <sys/signalfd.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/statfs.h>
#include <sys/statvfs.h>
#include <sys/swap.h>
#include <sys/syscall.h>
#include <sys/sysinfo.h>
#include <sys/sysmacros.h>
#include <sys/time.h>
#include <sys/timeb.h>
#include <sys/timerfd.h>
#include <sys/times.h>
#include <sys/timex.h>
#include <sys/ttydefaults.h>
#include <sys/types.h>
#include <sys/uio.h>
#include <sys/un.h>
#include <sys/user.h>
#include <sys/utsname.h>
#include <sys/wait.h>
#include <sys/xattr.h>
#include <sysexits.h>
#include <syslog.h>
#include <tar.h>
#include <termios.h>
#include <tgmath.h>
#ifndef __GLIBC__
#include <threads.h>
#endif
#include <time.h>
#include <uchar.h>
#include <ucontext.h>
#include <ulimit.h>
#include <unistd.h>
#include <utime.h>
#include <utmp.h>
#include <utmpx.h>
#include <values.h>
#include <wchar.h>
#include <wctype.h>
#include <wordexp.h>

typedef long long long_long;
typedef long double long_double;
typedef void *object_pointer;
typedef void (*function_pointer)();
struct size {char c;};
struct align {char c;};
struct incomplete {char c;};
#define T(s,t) void x_##t(s t x, s t* ptr, size(*y)[sizeof(s t)], align(*z)[__alignof__(s t)]){}
#define P(s,t) void x_##t(incomplete x, s t* ptr, incomplete y, incomplete z){}
#ifdef __GLIBC__
#define M(x)
#else
#define M(x) x
#endif

T(,ACTION)
T(,CODE)
P(,DIR)
T(,Dl_info)
T(,ENTRY)
T(,Elf32_Addr)
T(,Elf32_Chdr)
T(,Elf32_Conflict)
T(,Elf32_Dyn)
T(,Elf32_Ehdr)
T(,Elf32_Half)
T(,Elf32_Lib)
T(,Elf32_Move)
T(,Elf32_Nhdr)
T(,Elf32_Off)
T(,Elf32_Phdr)
T(,Elf32_RegInfo)
T(,Elf32_Rel)
T(,Elf32_Rela)
T(,Elf32_Section)
T(,Elf32_Shdr)
T(,Elf32_Sword)
T(,Elf32_Sxword)
T(,Elf32_Sym)
T(,Elf32_Syminfo)
T(,Elf32_Verdaux)
T(,Elf32_Verdef)
T(,Elf32_Vernaux)
T(,Elf32_Verneed)
T(,Elf32_Versym)
T(,Elf32_Word)
T(,Elf32_Xword)
T(,Elf32_auxv_t)
T(,Elf32_gptab)
T(,Elf64_Addr)
T(,Elf64_Chdr)
T(,Elf64_Dyn)
T(,Elf64_Ehdr)
T(,Elf64_Half)
T(,Elf64_Lib)
T(,Elf64_Move)
T(,Elf64_Nhdr)
T(,Elf64_Off)
T(,Elf64_Phdr)
T(,Elf64_Rel)
T(,Elf64_Rela)
T(,Elf64_Section)
T(,Elf64_Shdr)
T(,Elf64_Sword)
T(,Elf64_Sxword)
T(,Elf64_Sym)
T(,Elf64_Syminfo)
T(,Elf64_Verdaux)
T(,Elf64_Verdef)
T(,Elf64_Vernaux)
T(,Elf64_Verneed)
T(,Elf64_Versym)
T(,Elf64_Word)
T(,Elf64_Xword)
T(,Elf64_auxv_t)
T(,Elf_MIPS_ABIFlags_v0)
T(,Elf_Options)
T(,Elf_Options_Hw)
T(,Elf_Symndx)
P(,FILE)
T(,HEADER)
T(,Sg_io_hdr)
//T(,Sg_io_vec)
T(,Sg_req_info)
T(,Sg_scsi_id)
T(,VISIT)
//T(,__isoc_va_list)
T(,__jmp_buf)
T(,blkcnt_t)
T(,blksize_t)
T(,bool)
T(,caddr_t)
T(,cc_t)
T(,char)
T(,char16_t)
T(,char32_t)
T(,clock_t)
T(,clockid_t)
M(T(,cnd_t))
T(,comp_t)
T(,cpu_set_t)
T(,dev_t)
T(,div_t)
T(,double)
T(,double_t)
T(,elf_fpreg_t)
T(,elf_fpregset_t)
T(,elf_greg_t)
T(,elf_gregset_t)
T(,elf_vrreg_t)
T(,elf_vrregset_t)
T(,epoll_data_t)
T(,eventfd_t)
T(,fd_mask)
T(,fd_set)
T(,fenv_t)
T(,fexcept_t)
T(,float)
T(,float_t)
T(,fpos_t)
T(,fpregset_t)
T(,fsblkcnt_t)
T(,fsfilcnt_t)
T(,fsid_t)
T(,function_pointer)
T(,gid_t)
T(,glob_t)
T(,greg_t)
T(,gregset_t)
T(,iconv_t)
T(,id_t)
T(,idtype_t)
T(,imaxdiv_t)
T(,in_addr_t)
T(,in_port_t)
T(,ino_t)
T(,int)
T(,int16_t)
T(,int32_t)
T(,int64_t)
T(,int8_t)
T(,int_fast16_t)
T(,int_fast32_t)
T(,int_fast64_t)
T(,int_fast8_t)
T(,int_least16_t)
T(,int_least32_t)
T(,int_least64_t)
T(,int_least8_t)
T(,intmax_t)
T(,intptr_t)
T(,jmp_buf)
T(,key_t)
T(,ldiv_t)
T(,lldiv_t)
T(,locale_t)
T(,long)
T(,long_double)
T(,long_long)
T(,lwpid_t)
T(,max_align_t)
T(,mbstate_t)
T(,mcontext_t)
T(,mode_t)
T(,mqd_t)
T(,msglen_t)
T(,msgqnum_t)
M(T(,mtx_t))
T(,n_long)
T(,n_short)
T(,n_time)
T(,nfds_t)
T(,nl_catd)
T(,nl_item)
T(,nlink_t)
T(,ns_cert_types)
T(,ns_class)
T(,ns_flag)
T(,ns_key_types)
T(,ns_msg)
T(,ns_opcode)
T(,ns_rcode)
T(,ns_rr)
T(,ns_sect)
//T(,ns_tcp_tsig_state)
//T(,ns_tsig_key)
T(,ns_type)
T(,ns_update_operation)
T(,object_pointer)
T(,off_t)
M(T(,once_flag))
T(,pid_t)
T(,posix_spawn_file_actions_t)
T(,posix_spawnattr_t)
T(,prfpregset_t)
T(,prgregset_t)
T(,prpsinfo_t)
T(,prstatus_t)
T(,psaddr_t)
T(,pthread_attr_t)
T(,pthread_barrier_t)
T(,pthread_barrierattr_t)
T(,pthread_cond_t)
T(,pthread_condattr_t)
T(,pthread_key_t)
T(,pthread_mutex_t)
T(,pthread_mutexattr_t)
T(,pthread_once_t)
T(,pthread_rwlock_t)
T(,pthread_rwlockattr_t)
T(,pthread_spinlock_t)
T(,pthread_t)
T(,ptrdiff_t)
T(,quad_t)
T(,regex_t)
T(,register_t)
T(,regmatch_t)
T(,regoff_t)
T(,res_state)
T(,rlim_t)
T(,sa_family_t)
T(,sem_t)
T(,sg_io_hdr_t)
T(,sg_iovec_t)
T(,sg_req_info_t)
T(,shmatt_t)
T(,short)
T(,sig_atomic_t)
T(,sig_t)
T(,sighandler_t)
T(,siginfo_t)
T(,sigjmp_buf)
T(,sigset_t)
T(,size_t)
T(,socklen_t)
T(,speed_t)
T(,ssize_t)
T(,stack_t)
T(struct,FTW)
//T(struct,__fsid_t)
T(struct,__jmp_buf_tag)
//T(struct,__locale_struct)
//T(struct,__mbstate_t)
T(struct,__ns_msg)
T(struct,__ns_rr)
//T(struct,__ptcb)
T(struct,__res_state)
//T(struct,__sigset_t)
//T(struct,__ucontext)
T(struct,_ns_flagdata)
T(struct,acct)
T(struct,acct_v3)
T(struct,addrinfo)
T(struct,aiocb)
T(struct,ar_hdr)
T(struct,arpd_request)
T(struct,arphdr)
T(struct,arpreq)
T(struct,arpreq_old)
T(struct,bandinfo)
T(struct,ccs_modesel_head)
T(struct,cmsghdr)
//T(struct,cpu_set_t)
T(struct,crypt_data)
T(struct,dirent)
T(struct,dl_phdr_info)
T(struct,dqblk)
T(struct,dqinfo)
T(struct,elf_prpsinfo)
T(struct,elf_prstatus)
T(struct,elf_siginfo)
T(struct,entry)
T(struct,epoll_event)
T(struct,ether_addr)
T(struct,ether_arp)
T(struct,ether_header)
T(struct,ethhdr)
T(struct,f_owner_ex)
T(struct,fanotify_event_metadata)
T(struct,fanotify_response)
T(struct,flock)
T(struct,group)
T(struct,group_filter)
T(struct,group_req)
T(struct,group_source_req)
T(struct,hostent)
T(struct,hsearch_data)
T(struct,icmp)
T(struct,icmp6_filter)
T(struct,icmp6_hdr)
T(struct,icmp6_router_renum)
T(struct,icmp_ra_addr)
T(struct,icmphdr)
T(struct,if_nameindex)
T(struct,ifaddr)
T(struct,ifaddrs)
T(struct,ifconf)
T(struct,ifmap)
T(struct,ifreq)
T(struct,igmp)
//T(struct,ih_idseq)
//T(struct,ih_pmtu)
//T(struct,ih_rtradv)
T(struct,in6_addr)
T(struct,in6_pktinfo)
T(struct,in6_rtmsg)
T(struct,in_addr)
T(struct,in_pktinfo)
T(struct,inotify_event)
T(struct,iovec)
T(struct,ip)
T(struct,ip6_dest)
T(struct,ip6_ext)
T(struct,ip6_frag)
T(struct,ip6_hbh)
T(struct,ip6_hdr)
//T(struct,ip6_hdrctl)
T(struct,ip6_mtuinfo)
T(struct,ip6_opt)
T(struct,ip6_opt_jumbo)
T(struct,ip6_opt_nsap)
T(struct,ip6_opt_router)
T(struct,ip6_opt_tunnel)
T(struct,ip6_rthdr)
T(struct,ip6_rthdr0)
T(struct,ip_mreq)
T(struct,ip_mreq_source)
T(struct,ip_mreqn)
T(struct,ip_msfilter)
T(struct,ip_opts)
T(struct,ip_timestamp)
T(struct,ipc_perm)
T(struct,iphdr)
T(struct,ipv6_mreq)
T(struct,itimerspec)
T(struct,itimerval)
T(struct,lastlog)
T(struct,lconv)
T(struct,linger)
T(struct,link_map)
T(struct,mld_hdr)
T(struct,mmsghdr)
T(struct,mntent)
T(struct,mq_attr)
T(struct,msgbuf)
T(struct,msghdr)
T(struct,msginfo)
T(struct,msqid_ds)
T(struct,mt_tape_info)
T(struct,mtconfiginfo)
T(struct,mtget)
T(struct,mtop)
T(struct,mtpos)
T(struct,nd_neighbor_advert)
T(struct,nd_neighbor_solicit)
T(struct,nd_opt_adv_interval)
T(struct,nd_opt_hdr)
T(struct,nd_opt_home_agent_info)
T(struct,nd_opt_mtu)
T(struct,nd_opt_prefix_info)
T(struct,nd_opt_rd_hdr)
T(struct,nd_redirect)
T(struct,nd_router_advert)
T(struct,nd_router_solicit)
T(struct,netent)
T(struct,ns_tcp_tsig_state)
T(struct,ns_tsig_key)
T(struct,ntptimeval)
T(struct,option)
T(struct,packet_mreq)
T(struct,passwd)
T(struct,pollfd)
T(struct,prctl_mm_map)
T(struct,protoent)
T(struct,pt_regs)
//T(struct,ptrace_peeksiginfo_args)
T(struct,qelem)
T(struct,r_debug)
T(struct,re_pattern_buffer)
T(struct,res_sym)
T(struct,rlimit)
T(struct,rr_pco_match)
T(struct,rr_pco_use)
T(struct,rr_result)
T(struct,rtentry)
T(struct,rusage)
T(struct,sched_param)
T(struct,sembuf)
T(struct,semid_ds)
T(struct,seminfo)
T(struct,servent)
T(struct,sg_header)
T(struct,sg_io_hdr)
T(struct,sg_iovec)
T(struct,sg_req_info)
T(struct,sg_scsi_id)
T(struct,shm_info)
T(struct,shmid_ds)
T(struct,shminfo)
T(struct,sigaction)
T(struct,sigaltstack)
T(struct,sigcontext)
T(struct,sigevent)
T(struct,signalfd_siginfo)
T(struct,sockaddr)
T(struct,sockaddr_in)
T(struct,sockaddr_in6)
T(struct,sockaddr_ll)
T(struct,sockaddr_storage)
T(struct,sockaddr_un)
T(struct,spwd)
T(struct,stat)
T(struct,statfs)
T(struct,statvfs)
T(struct,str_list)
T(struct,str_mlist)
T(struct,strbuf)
T(struct,strfdinsert)
T(struct,strioctl)
T(struct,strpeek)
T(struct,strrecvfd)
T(struct,sysinfo)
T(struct,tcp_info)
T(struct,tcp_md5sig)
T(struct,tcp_repair_window)
T(struct,tcphdr)
T(struct,termios)
T(struct,tftphdr)
T(struct,timeb)
T(struct,timespec)
T(struct,timestamp)
T(struct,timeval)
T(struct,timex)
T(struct,timezone)
T(struct,tm)
T(struct,tms)
T(struct,ucred)
T(struct,udphdr)
T(struct,user)
T(struct,utimbuf)
T(struct,utmpx)
T(struct,utsname)
T(struct,winsize)
T(,suseconds_t)
T(,tcflag_t)
//T(,tcp_seq)
M(T(,thrd_start_t))
M(T(,thrd_t))
T(,time_t)
T(,timer_t)
M(T(,tss_dtor_t))
M(T(,tss_t))
T(,u_char)
T(,u_int)
T(,u_int16_t)
T(,u_int32_t)
T(,u_int64_t)
T(,u_int8_t)
T(,u_long)
T(,u_quad_t)
T(,u_short)
T(,ucontext_t)
T(,uid_t)
T(,uint)
T(,uint16_t)
T(,uint32_t)
T(,uint64_t)
T(,uint8_t)
T(,uint_fast16_t)
T(,uint_fast32_t)
T(,uint_fast64_t)
T(,uint_fast8_t)
T(,uint_least16_t)
T(,uint_least32_t)
T(,uint_least64_t)
T(,uint_least8_t)
T(,uintmax_t)
T(,uintptr_t)
T(,ulong)
//T(union,_G_fpos64_t)
T(union,epoll_data)
T(union,sigval)
T(,useconds_t)
T(,ushort)
T(,va_list)
T(,vrregset_t)
T(,wchar_t)
T(,wctrans_t)
T(,wctype_t)
T(,wint_t)
T(,wordexp_t)
