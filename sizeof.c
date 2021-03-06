#define _GNU_SOURCE 1
#define _LARGEFILE64_SOURCE 1
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
#include <arpa/nameser_compat.h>
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
#include <lastlog.h>
#include <libgen.h>
#include <libintl.h>
#include <limits.h>
#include <link.h>
#include <locale.h>
#include <malloc.h>
#include <math.h>
#include <memory.h>
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
//#include <stdalign.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <stdio.h>
#include <stdio_ext.h>
#include <stdlib.h>
//#include <stdnoreturn.h>
#include <string.h>
#include <strings.h>
#include <stropts.h>
#include <sys/acct.h>
//#include <sys/cachectl.h>
#include <sys/dir.h>
#include <sys/epoll.h>
//#include <sys/errno.h>
#include <sys/eventfd.h>
#include <sys/fanotify.h>
//#include <sys/fcntl.h>
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
//#include <sys/poll.h>
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
//#include <sys/signal.h>
#include <sys/signalfd.h>
#include <sys/socket.h>
//#include <sys/soundcard.h>
#include <sys/stat.h>
#include <sys/statfs.h>
#include <sys/statvfs.h>
#include <sys/stropts.h>
#include <sys/swap.h>
#include <sys/syscall.h>
//#include <sys/sysctl.h>
#include <sys/sysinfo.h>
#include <sys/syslog.h>
#include <sys/sysmacros.h>
//#include <sys/termios.h>
#include <sys/time.h>
#include <sys/timeb.h>
#include <sys/timerfd.h>
#include <sys/times.h>
#include <sys/timex.h>
#include <sys/ttydefaults.h>
#include <sys/types.h>
#include <sys/ucontext.h>
#include <sys/uio.h>
#include <sys/un.h>
#include <sys/user.h>
#include <sys/utsname.h>
#include <sys/vfs.h>
//#include <sys/vt.h>
#include <sys/wait.h>
#include <sys/xattr.h>
#include <syscall.h>
#include <sysexits.h>
#include <syslog.h>
#include <tar.h>
#include <termios.h>
#include <tgmath.h>
#include <time.h>
#include <ucontext.h>
#include <ulimit.h>
#include <unistd.h>
#include <utime.h>
#include <utmp.h>
#include <utmpx.h>
#include <values.h>
//#include <wait.h>
#include <wchar.h>
#include <wctype.h>
#include <wordexp.h>
#define p(x) printf("%s\t%u\n", #x, sizeof(x));
int main(){
p(ACTION)
p(CODE)
//p(DIR)
p(Dl_info)
p(ENTRY)
p(Elf32_Addr)
p(Elf32_Conflict)
p(Elf32_Dyn)
p(Elf32_Ehdr)
p(Elf32_Half)
p(Elf32_Lib)
p(Elf32_Move)
p(Elf32_Nhdr)
p(Elf32_Off)
p(Elf32_Phdr)
p(Elf32_RegInfo)
p(Elf32_Rel)
p(Elf32_Rela)
p(Elf32_Section)
p(Elf32_Shdr)
p(Elf32_Sword)
p(Elf32_Sxword)
p(Elf32_Sym)
p(Elf32_Syminfo)
p(Elf32_Verdaux)
p(Elf32_Verdef)
p(Elf32_Vernaux)
p(Elf32_Verneed)
p(Elf32_Versym)
p(Elf32_Word)
p(Elf32_Xword)
p(Elf32_auxv_t)
p(Elf32_gptab)
p(Elf64_Addr)
p(Elf64_Dyn)
p(Elf64_Ehdr)
p(Elf64_Half)
p(Elf64_Lib)
p(Elf64_Move)
p(Elf64_Nhdr)
p(Elf64_Off)
p(Elf64_Phdr)
p(Elf64_Rel)
p(Elf64_Rela)
p(Elf64_Section)
p(Elf64_Shdr)
p(Elf64_Sword)
p(Elf64_Sxword)
p(Elf64_Sym)
p(Elf64_Syminfo)
p(Elf64_Verdaux)
p(Elf64_Verdef)
p(Elf64_Vernaux)
p(Elf64_Verneed)
p(Elf64_Versym)
p(Elf64_Word)
p(Elf64_Xword)
p(Elf64_auxv_t)
p(Elf_Options)
p(Elf_Options_Hw)
p(Elf_Symndx)
//p(FILE)
p(HEADER)
p(Sg_io_hdr)
//p(Sg_io_vec)
p(Sg_req_info)
p(Sg_scsi_id)
p(VISIT)
p(_Bool)
//p(__isoc_va_list)
p(__jmp_buf)
p(blkcnt_t)
p(blksize_t)
p(caddr_t)
p(cc_t)
p(clock_t)
p(clockid_t)
p(comp_t)
p(cpu_set_t)
p(dev_t)
p(div_t)
p(double)
p(double_t)
p(elf_fpregset_t)
//p(elf_fpxregset_t)
p(elf_greg_t)
p(elf_gregset_t)
p(epoll_data_t)
p(eventfd_t)
p(fd_mask)
p(fd_set)
p(fenv_t)
p(fexcept_t)
p(float)
p(float_t)
p(fpos_t)
p(fpregset_t)
p(fsblkcnt_t)
p(fsfilcnt_t)
p(fsid_t)
p(gid_t)
p(glob_t)
p(greg_t)
p(gregset_t)
p(iconv_t)
p(id_t)
p(idtype_t)
p(imaxdiv_t)
p(in_addr_t)
p(in_port_t)
p(ino_t)
p(int)
p(int16_t)
p(int32_t)
p(int64_t)
p(int8_t)
p(int_fast16_t)
p(int_fast32_t)
p(int_fast64_t)
p(int_fast8_t)
p(int_least16_t)
p(int_least32_t)
p(int_least64_t)
p(int_least8_t)
p(intmax_t)
p(intptr_t)
p(jmp_buf)
p(key_t)
p(ldiv_t)
p(lldiv_t)
p(locale_t)
p(long)
p(long double)
p(long long)
p(lwpid_t)
p(mbstate_t)
p(mcontext_t)
p(mode_t)
p(mqd_t)
p(msglen_t)
p(msgqnum_t)
p(n_long)
p(n_short)
p(n_time)
p(nfds_t)
p(nl_catd)
p(nl_item)
p(nlink_t)
p(ns_cert_types)
p(ns_class)
p(ns_flag)
p(ns_key_types)
p(ns_msg)
p(ns_opcode)
p(ns_rcode)
p(ns_rr)
p(ns_sect)
p(ns_tcp_tsig_state)
p(ns_tsig_key)
p(ns_type)
p(ns_update_operation)
p(off_t)
p(pid_t)
p(posix_spawn_file_actions_t)
p(posix_spawnattr_t)
p(prfpregset_t)
p(prgregset_t)
p(prpsinfo_t)
p(prstatus_t)
p(psaddr_t)
p(pthread_attr_t)
p(pthread_barrier_t)
p(pthread_barrierattr_t)
p(pthread_cond_t)
p(pthread_condattr_t)
p(pthread_key_t)
p(pthread_mutex_t)
p(pthread_mutexattr_t)
p(pthread_once_t)
p(pthread_rwlock_t)
p(pthread_rwlockattr_t)
p(pthread_spinlock_t)
p(pthread_t)
p(ptrdiff_t)
p(quad_t)
p(regex_t)
p(register_t)
p(regmatch_t)
p(regoff_t)
p(res_state)
p(rlim_t)
p(sa_family_t)
p(sem_t)
p(sg_io_hdr_t)
p(sg_iovec_t)
p(sg_req_info_t)
p(shmatt_t)
p(short)
p(sig_atomic_t)
p(sig_t)
p(sighandler_t)
p(siginfo_t)
p(sigjmp_buf)
p(sigset_t)
p(size_t)
p(socklen_t)
p(speed_t)
p(ssize_t)
p(stack_t)
p(struct FTW)
//p(struct __CODE)
//p(struct __fsid_t)
p(struct __jmp_buf_tag)
//p(struct __mbstate_t)
p(struct __ns_msg)
p(struct __ns_rr)
//p(struct __ptcb)
p(struct __res_state)
//p(struct __sigset_t)
//p(struct __ucontext)
//p(struct _fpstate)
p(struct _ns_flagdata)
p(struct acct)
p(struct acct_v3)
p(struct addrinfo)
p(struct aiocb)
p(struct ar_hdr)
p(struct arpd_request)
p(struct arphdr)
p(struct arpreq)
p(struct arpreq_old)
p(struct bandinfo)
p(struct ccs_modesel_head)
p(struct cmsghdr)
//p(struct cpu_set_t)
p(struct crypt_data)
p(struct dirent)
p(struct dl_phdr_info)
p(struct dqblk)
p(struct dqinfo)
p(struct elf_prpsinfo)
p(struct elf_prstatus)
p(struct elf_siginfo)
p(struct entry)
p(struct epoll_event)
p(struct ether_addr)
p(struct ether_arp)
p(struct ether_header)
p(struct ethhdr)
p(struct f_owner_ex)
p(struct fanotify_event_metadata)
p(struct fanotify_response)
p(struct flock)
p(struct group)
p(struct group_filter)
p(struct group_req)
p(struct group_source_req)
p(struct hostent)
p(struct icmp)
p(struct icmp6_filter)
p(struct icmp6_hdr)
p(struct icmp6_router_renum)
p(struct icmp_ra_addr)
p(struct icmphdr)
p(struct if_nameindex)
p(struct ifaddr)
p(struct ifaddrs)
p(struct ifconf)
p(struct ifmap)
p(struct ifreq)
p(struct igmp)
p(struct ih_idseq)
p(struct ih_pmtu)
p(struct ih_rtradv)
p(struct in6_addr)
p(struct in6_pktinfo)
p(struct in6_rtmsg)
p(struct in_addr)
p(struct in_pktinfo)
p(struct inotify_event)
p(struct iovec)
p(struct ip)
p(struct ip6_dest)
p(struct ip6_ext)
p(struct ip6_frag)
p(struct ip6_hbh)
p(struct ip6_hdr)
p(struct ip6_hdrctl)
p(struct ip6_mtuinfo)
p(struct ip6_opt)
p(struct ip6_opt_jumbo)
p(struct ip6_opt_nsap)
p(struct ip6_opt_router)
p(struct ip6_opt_tunnel)
p(struct ip6_rthdr)
p(struct ip6_rthdr0)
p(struct ip_mreq)
p(struct ip_mreq_source)
p(struct ip_mreqn)
p(struct ip_msfilter)
p(struct ip_opts)
p(struct ip_timestamp)
p(struct ipc_perm)
p(struct iphdr)
p(struct ipv6_mreq)
p(struct itimerspec)
p(struct itimerval)
p(struct lastlog)
p(struct lconv)
p(struct linger)
p(struct link_map)
p(struct mld_hdr)
p(struct mntent)
p(struct mq_attr)
p(struct msgbuf)
p(struct msghdr)
p(struct msginfo)
p(struct msqid_ds)
p(struct mt_tape_info)
p(struct mtconfiginfo)
p(struct mtget)
p(struct mtop)
p(struct mtpos)
p(struct nd_neighbor_advert)
p(struct nd_neighbor_solicit)
p(struct nd_opt_adv_interval)
p(struct nd_opt_hdr)
p(struct nd_opt_home_agent_info)
p(struct nd_opt_mtu)
p(struct nd_opt_prefix_info)
p(struct nd_opt_rd_hdr)
p(struct nd_redirect)
p(struct nd_router_advert)
p(struct nd_router_solicit)
p(struct netent)
p(struct ns_tcp_tsig_state)
p(struct ns_tsig_key)
p(struct ntptimeval)
p(struct option)
p(struct packet_mreq)
p(struct passwd)
p(struct pollfd)
p(struct protoent)
//p(struct ptrace_peeksiginfo_args)
p(struct qelem)
p(struct r_debug)
p(struct re_pattern_buffer)
p(struct res_sym)
p(struct rlimit)
p(struct rr_pco_match)
p(struct rr_pco_use)
p(struct rr_result)
p(struct rtentry)
p(struct rusage)
p(struct sched_param)
p(struct sembuf)
p(struct semid_ds)
p(struct seminfo)
p(struct servent)
p(struct sg_header)
p(struct sg_io_hdr)
p(struct sg_iovec)
p(struct sg_req_info)
p(struct sg_scsi_id)
p(struct shm_info)
p(struct shmid_ds)
p(struct shminfo)
p(struct sigaction)
p(struct sigaltstack)
p(struct sigcontext)
p(struct sigevent)
p(struct signalfd_siginfo)
p(struct sockaddr)
p(struct sockaddr_in)
p(struct sockaddr_in6)
p(struct sockaddr_ll)
p(struct sockaddr_storage)
p(struct sockaddr_un)
p(struct spwd)
p(struct stat)
p(struct statfs)
p(struct statvfs)
p(struct str_list)
p(struct str_mlist)
p(struct strbuf)
p(struct strfdinsert)
p(struct strioctl)
p(struct strpeek)
p(struct strrecvfd)
p(struct sysinfo)
p(struct tcp_info)
p(struct tcp_md5sig)
p(struct tcphdr)
p(struct termios)
p(struct tftphdr)
p(struct timeb)
p(struct timespec)
p(struct timestamp)
p(struct timeval)
p(struct timex)
p(struct timezone)
p(struct tm)
p(struct tms)
p(struct ucred)
p(struct udphdr)
p(struct user)
p(struct user_fpregs_struct)
//p(struct user_fpxregs_struct)
p(struct user_regs_struct)
p(struct utimbuf)
p(struct utmpx)
p(struct utsname)
p(struct winsize)
p(suseconds_t)
p(tcflag_t)
p(time_t)
p(timer_t)
p(u_char)
p(u_int)
p(u_int16_t)
p(u_int32_t)
p(u_int64_t)
p(u_int8_t)
p(u_long)
p(u_quad_t)
p(u_short)
p(ucontext_t)
p(uid_t)
p(uint)
p(uint16_t)
p(uint32_t)
p(uint64_t)
p(uint8_t)
p(uint_fast16_t)
p(uint_fast32_t)
p(uint_fast64_t)
p(uint_fast8_t)
p(uint_least16_t)
p(uint_least32_t)
p(uint_least64_t)
p(uint_least8_t)
p(uintmax_t)
p(uintptr_t)
p(ulong)
//p(union _G_fpos64_t)
p(union epoll_data)
p(union sigval)
p(useconds_t)
p(ushort)
p(va_list)
p(void*)
p(wchar_t)
p(wctrans_t)
p(wctype_t)
p(wint_t)
p(wordexp_t)
return 0;}
