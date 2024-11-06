
/data/usr/jiaoyd/csr_baremental/benchmarks/build/toy_bm/dhrystone.elf:     file format elf32-littleriscv


Disassembly of section .text:

80000000 <__start>:
80000000:	00000093          	li	ra,0
80000004:	00000113          	li	sp,0
80000008:	00000193          	li	gp,0
8000000c:	00000213          	li	tp,0
80000010:	00000293          	li	t0,0
80000014:	00000313          	li	t1,0
80000018:	00000393          	li	t2,0
8000001c:	00000413          	li	s0,0
80000020:	00000493          	li	s1,0
80000024:	00000513          	li	a0,0
80000028:	00000593          	li	a1,0
8000002c:	00000613          	li	a2,0
80000030:	00000693          	li	a3,0
80000034:	00000713          	li	a4,0
80000038:	00000793          	li	a5,0
8000003c:	00000813          	li	a6,0
80000040:	00000893          	li	a7,0
80000044:	00000913          	li	s2,0
80000048:	00000993          	li	s3,0
8000004c:	00000a13          	li	s4,0
80000050:	00000a93          	li	s5,0
80000054:	00000b13          	li	s6,0
80000058:	00000b93          	li	s7,0
8000005c:	00000c13          	li	s8,0
80000060:	00000c93          	li	s9,0
80000064:	00000d13          	li	s10,0
80000068:	00000d93          	li	s11,0
8000006c:	00000e13          	li	t3,0
80000070:	00000e93          	li	t4,0
80000074:	00000f13          	li	t5,0
80000078:	00000f93          	li	t6,0
8000007c:	20010117          	auipc	sp,0x20010
80000080:	f8410113          	add	sp,sp,-124 # a0010000 <__stack_base>
80000084:	20001297          	auipc	t0,0x20001
80000088:	f2428293          	add	t0,t0,-220 # a0000fa8 <Ptr_Glob_inst>
8000008c:	20003317          	auipc	t1,0x20003
80000090:	75430313          	add	t1,t1,1876 # a00037e0 <__bss_end>

80000094 <clear_bss_loop>:
80000094:	0002a023          	sw	zero,0(t0)
80000098:	00428293          	add	t0,t0,4
8000009c:	fe62cce3          	blt	t0,t1,80000094 <clear_bss_loop>
800000a0:	20001297          	auipc	t0,0x20001
800000a4:	ee428293          	add	t0,t0,-284 # a0000f84 <uart>
800000a8:	20001317          	auipc	t1,0x20001
800000ac:	f0030313          	add	t1,t1,-256 # a0000fa8 <Ptr_Glob_inst>

800000b0 <clear_sbss_loop>:
800000b0:	0002a023          	sw	zero,0(t0)
800000b4:	00428293          	add	t0,t0,4
800000b8:	fe62cce3          	blt	t0,t1,800000b0 <clear_sbss_loop>

800000bc <start_warm>:
800000bc:	624030ef          	jal	800036e0 <init>
800000c0:	00800193          	li	gp,8
800000c4:	30019073          	csrw	mstatus,gp
800000c8:	000011b7          	lui	gp,0x1
800000cc:	88818193          	add	gp,gp,-1912 # 888 <__stack_size-0x3778>
800000d0:	30419073          	csrw	mie,gp
800000d4:	00000717          	auipc	a4,0x0
800000d8:	01870713          	add	a4,a4,24 # 800000ec <_trap_handler>
800000dc:	30571073          	csrw	mtvec,a4
800000e0:	0c5050ef          	jal	800059a4 <main>
800000e4:	5cc030ef          	jal	800036b0 <to_host>
800000e8:	10500073          	wfi

800000ec <_trap_handler>:
800000ec:	34021273          	csrrw	tp,mscratch,tp
800000f0:	00010213          	mv	tp,sp
800000f4:	f6222e23          	sw	sp,-132(tp) # ffffff7c <__stack_base+0x5ffeff7c>
800000f8:	f7420113          	add	sp,tp,-140 # ffffff74 <__stack_base+0x5ffeff74>
800000fc:	34021273          	csrrw	tp,mscratch,tp
80000100:	00012023          	sw	zero,0(sp)
80000104:	00112223          	sw	ra,4(sp)
80000108:	00312623          	sw	gp,12(sp)
8000010c:	00412823          	sw	tp,16(sp)
80000110:	00512a23          	sw	t0,20(sp)
80000114:	00712e23          	sw	t2,28(sp)
80000118:	00612c23          	sw	t1,24(sp)
8000011c:	00712e23          	sw	t2,28(sp)
80000120:	02812023          	sw	s0,32(sp)
80000124:	02912223          	sw	s1,36(sp)
80000128:	02a12423          	sw	a0,40(sp)
8000012c:	02b12623          	sw	a1,44(sp)
80000130:	02c12823          	sw	a2,48(sp)
80000134:	02d12a23          	sw	a3,52(sp)
80000138:	02e12c23          	sw	a4,56(sp)
8000013c:	02f12e23          	sw	a5,60(sp)
80000140:	05012023          	sw	a6,64(sp)
80000144:	05112223          	sw	a7,68(sp)
80000148:	05212423          	sw	s2,72(sp)
8000014c:	05312623          	sw	s3,76(sp)
80000150:	05412823          	sw	s4,80(sp)
80000154:	05512a23          	sw	s5,84(sp)
80000158:	05612c23          	sw	s6,88(sp)
8000015c:	05712e23          	sw	s7,92(sp)
80000160:	07812023          	sw	s8,96(sp)
80000164:	07912223          	sw	s9,100(sp)
80000168:	07a12423          	sw	s10,104(sp)
8000016c:	07b12623          	sw	s11,108(sp)
80000170:	07c12823          	sw	t3,112(sp)
80000174:	07d12a23          	sw	t4,116(sp)
80000178:	07e12c23          	sw	t5,120(sp)
8000017c:	07f12e23          	sw	t6,124(sp)
80000180:	00010533          	add	a0,sp,zero
80000184:	6f0030ef          	jal	80003874 <toy_trap_handler>

80000188 <_trap_exit>:
80000188:	00452083          	lw	ra,4(a0)
8000018c:	00852103          	lw	sp,8(a0)
80000190:	00c52183          	lw	gp,12(a0)
80000194:	01052203          	lw	tp,16(a0)
80000198:	01452283          	lw	t0,20(a0)
8000019c:	01852303          	lw	t1,24(a0)
800001a0:	01c52383          	lw	t2,28(a0)
800001a4:	02052403          	lw	s0,32(a0)
800001a8:	02452483          	lw	s1,36(a0)
800001ac:	02c52583          	lw	a1,44(a0)
800001b0:	03052603          	lw	a2,48(a0)
800001b4:	03452683          	lw	a3,52(a0)
800001b8:	03852703          	lw	a4,56(a0)
800001bc:	03c52783          	lw	a5,60(a0)
800001c0:	04052803          	lw	a6,64(a0)
800001c4:	04452883          	lw	a7,68(a0)
800001c8:	04852903          	lw	s2,72(a0)
800001cc:	04c52983          	lw	s3,76(a0)
800001d0:	05052a03          	lw	s4,80(a0)
800001d4:	05452a83          	lw	s5,84(a0)
800001d8:	05852b03          	lw	s6,88(a0)
800001dc:	05c52b83          	lw	s7,92(a0)
800001e0:	06052c03          	lw	s8,96(a0)
800001e4:	06452c83          	lw	s9,100(a0)
800001e8:	06852d03          	lw	s10,104(a0)
800001ec:	06c52d83          	lw	s11,108(a0)
800001f0:	07052e03          	lw	t3,112(a0)
800001f4:	07452e83          	lw	t4,116(a0)
800001f8:	07852f03          	lw	t5,120(a0)
800001fc:	07c52f83          	lw	t6,124(a0)
80000200:	02852503          	lw	a0,40(a0)
80000204:	30200073          	mret

80000208 <strcmp>:
80000208:	00b56733          	or	a4,a0,a1
8000020c:	fff00393          	li	t2,-1
80000210:	00377713          	and	a4,a4,3
80000214:	10071063          	bnez	a4,80000314 <strcmp+0x10c>
80000218:	7f7f87b7          	lui	a5,0x7f7f8
8000021c:	f7f78793          	add	a5,a5,-129 # 7f7f7f7f <__stack_size+0x7f7f3f7f>
80000220:	00052603          	lw	a2,0(a0)
80000224:	0005a683          	lw	a3,0(a1)
80000228:	00f672b3          	and	t0,a2,a5
8000022c:	00f66333          	or	t1,a2,a5
80000230:	00f282b3          	add	t0,t0,a5
80000234:	0062e2b3          	or	t0,t0,t1
80000238:	10729263          	bne	t0,t2,8000033c <strcmp+0x134>
8000023c:	08d61663          	bne	a2,a3,800002c8 <strcmp+0xc0>
80000240:	00452603          	lw	a2,4(a0)
80000244:	0045a683          	lw	a3,4(a1)
80000248:	00f672b3          	and	t0,a2,a5
8000024c:	00f66333          	or	t1,a2,a5
80000250:	00f282b3          	add	t0,t0,a5
80000254:	0062e2b3          	or	t0,t0,t1
80000258:	0c729e63          	bne	t0,t2,80000334 <strcmp+0x12c>
8000025c:	06d61663          	bne	a2,a3,800002c8 <strcmp+0xc0>
80000260:	00852603          	lw	a2,8(a0)
80000264:	0085a683          	lw	a3,8(a1)
80000268:	00f672b3          	and	t0,a2,a5
8000026c:	00f66333          	or	t1,a2,a5
80000270:	00f282b3          	add	t0,t0,a5
80000274:	0062e2b3          	or	t0,t0,t1
80000278:	0c729863          	bne	t0,t2,80000348 <strcmp+0x140>
8000027c:	04d61663          	bne	a2,a3,800002c8 <strcmp+0xc0>
80000280:	00c52603          	lw	a2,12(a0)
80000284:	00c5a683          	lw	a3,12(a1)
80000288:	00f672b3          	and	t0,a2,a5
8000028c:	00f66333          	or	t1,a2,a5
80000290:	00f282b3          	add	t0,t0,a5
80000294:	0062e2b3          	or	t0,t0,t1
80000298:	0c729263          	bne	t0,t2,8000035c <strcmp+0x154>
8000029c:	02d61663          	bne	a2,a3,800002c8 <strcmp+0xc0>
800002a0:	01052603          	lw	a2,16(a0)
800002a4:	0105a683          	lw	a3,16(a1)
800002a8:	00f672b3          	and	t0,a2,a5
800002ac:	00f66333          	or	t1,a2,a5
800002b0:	00f282b3          	add	t0,t0,a5
800002b4:	0062e2b3          	or	t0,t0,t1
800002b8:	0a729c63          	bne	t0,t2,80000370 <strcmp+0x168>
800002bc:	01450513          	add	a0,a0,20
800002c0:	01458593          	add	a1,a1,20
800002c4:	f4d60ee3          	beq	a2,a3,80000220 <strcmp+0x18>
800002c8:	01061713          	sll	a4,a2,0x10
800002cc:	01069793          	sll	a5,a3,0x10
800002d0:	00f71e63          	bne	a4,a5,800002ec <strcmp+0xe4>
800002d4:	01065713          	srl	a4,a2,0x10
800002d8:	0106d793          	srl	a5,a3,0x10
800002dc:	40f70533          	sub	a0,a4,a5
800002e0:	0ff57593          	zext.b	a1,a0
800002e4:	02059063          	bnez	a1,80000304 <strcmp+0xfc>
800002e8:	00008067          	ret
800002ec:	01075713          	srl	a4,a4,0x10
800002f0:	0107d793          	srl	a5,a5,0x10
800002f4:	40f70533          	sub	a0,a4,a5
800002f8:	0ff57593          	zext.b	a1,a0
800002fc:	00059463          	bnez	a1,80000304 <strcmp+0xfc>
80000300:	00008067          	ret
80000304:	0ff77713          	zext.b	a4,a4
80000308:	0ff7f793          	zext.b	a5,a5
8000030c:	40f70533          	sub	a0,a4,a5
80000310:	00008067          	ret
80000314:	00054603          	lbu	a2,0(a0)
80000318:	0005c683          	lbu	a3,0(a1)
8000031c:	00150513          	add	a0,a0,1
80000320:	00158593          	add	a1,a1,1
80000324:	00d61463          	bne	a2,a3,8000032c <strcmp+0x124>
80000328:	fe0616e3          	bnez	a2,80000314 <strcmp+0x10c>
8000032c:	40d60533          	sub	a0,a2,a3
80000330:	00008067          	ret
80000334:	00450513          	add	a0,a0,4
80000338:	00458593          	add	a1,a1,4
8000033c:	fcd61ce3          	bne	a2,a3,80000314 <strcmp+0x10c>
80000340:	00000513          	li	a0,0
80000344:	00008067          	ret
80000348:	00850513          	add	a0,a0,8
8000034c:	00858593          	add	a1,a1,8
80000350:	fcd612e3          	bne	a2,a3,80000314 <strcmp+0x10c>
80000354:	00000513          	li	a0,0
80000358:	00008067          	ret
8000035c:	00c50513          	add	a0,a0,12
80000360:	00c58593          	add	a1,a1,12
80000364:	fad618e3          	bne	a2,a3,80000314 <strcmp+0x10c>
80000368:	00000513          	li	a0,0
8000036c:	00008067          	ret
80000370:	01050513          	add	a0,a0,16
80000374:	01058593          	add	a1,a1,16
80000378:	f8d61ee3          	bne	a2,a3,80000314 <strcmp+0x10c>
8000037c:	00000513          	li	a0,0
80000380:	00008067          	ret

80000384 <__udivdi3>:
#endif

#ifdef L_udivdi3
UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
80000384:	00050893          	mv	a7,a0
80000388:	00058313          	mv	t1,a1
  d0 = dd.s.low;
8000038c:	00060713          	mv	a4,a2
  n0 = nn.s.low;
80000390:	00050813          	mv	a6,a0
  n1 = nn.s.high;
80000394:	00058793          	mv	a5,a1
  if (d1 == 0)
80000398:	28069263          	bnez	a3,8000061c <__udivdi3+0x298>
      if (d0 > n1)
8000039c:	a00005b7          	lui	a1,0xa0000
800003a0:	07858593          	add	a1,a1,120 # a0000078 <__clz_tab>
800003a4:	0ec37663          	bgeu	t1,a2,80000490 <__udivdi3+0x10c>
	  count_leading_zeros (bm, d0);
800003a8:	000106b7          	lui	a3,0x10
800003ac:	0cd67863          	bgeu	a2,a3,8000047c <__udivdi3+0xf8>
800003b0:	10063693          	sltiu	a3,a2,256
800003b4:	0016b693          	seqz	a3,a3
800003b8:	00369693          	sll	a3,a3,0x3
800003bc:	00d65533          	srl	a0,a2,a3
800003c0:	00a585b3          	add	a1,a1,a0
800003c4:	0005c583          	lbu	a1,0(a1)
800003c8:	02000513          	li	a0,32
800003cc:	00d586b3          	add	a3,a1,a3
800003d0:	40d505b3          	sub	a1,a0,a3
	  if (bm != 0)
800003d4:	00d50c63          	beq	a0,a3,800003ec <__udivdi3+0x68>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
800003d8:	00b317b3          	sll	a5,t1,a1
800003dc:	00d8d6b3          	srl	a3,a7,a3
	      d0 = d0 << bm;
800003e0:	00b61733          	sll	a4,a2,a1
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
800003e4:	00f6e7b3          	or	a5,a3,a5
	      n0 = n0 << bm;
800003e8:	00b89833          	sll	a6,a7,a1
	  udiv_qrnnd (q0, n0, n1, n0, d0);
800003ec:	01075593          	srl	a1,a4,0x10
800003f0:	02b7d333          	divu	t1,a5,a1
800003f4:	01071613          	sll	a2,a4,0x10
800003f8:	01065613          	srl	a2,a2,0x10
800003fc:	02b7f7b3          	remu	a5,a5,a1
80000400:	00030513          	mv	a0,t1
80000404:	026608b3          	mul	a7,a2,t1
80000408:	01079693          	sll	a3,a5,0x10
8000040c:	01085793          	srl	a5,a6,0x10
80000410:	00d7e7b3          	or	a5,a5,a3
80000414:	0117fe63          	bgeu	a5,a7,80000430 <__udivdi3+0xac>
80000418:	00f707b3          	add	a5,a4,a5
8000041c:	fff30513          	add	a0,t1,-1
80000420:	00e7e863          	bltu	a5,a4,80000430 <__udivdi3+0xac>
80000424:	0117f663          	bgeu	a5,a7,80000430 <__udivdi3+0xac>
80000428:	ffe30513          	add	a0,t1,-2
8000042c:	00e787b3          	add	a5,a5,a4
80000430:	411787b3          	sub	a5,a5,a7
80000434:	02b7d8b3          	divu	a7,a5,a1
80000438:	01081813          	sll	a6,a6,0x10
8000043c:	01085813          	srl	a6,a6,0x10
80000440:	02b7f7b3          	remu	a5,a5,a1
80000444:	031606b3          	mul	a3,a2,a7
80000448:	01079793          	sll	a5,a5,0x10
8000044c:	00f86833          	or	a6,a6,a5
80000450:	00088793          	mv	a5,a7
80000454:	00d87c63          	bgeu	a6,a3,8000046c <__udivdi3+0xe8>
80000458:	01070833          	add	a6,a4,a6
8000045c:	fff88793          	add	a5,a7,-1
80000460:	00e86663          	bltu	a6,a4,8000046c <__udivdi3+0xe8>
80000464:	00d87463          	bgeu	a6,a3,8000046c <__udivdi3+0xe8>
80000468:	ffe88793          	add	a5,a7,-2
8000046c:	01051513          	sll	a0,a0,0x10
80000470:	00f56533          	or	a0,a0,a5
	      q1 = 0;
80000474:	00000593          	li	a1,0
  return __udivmoddi4 (n, d, (UDWtype *) 0);
}
80000478:	00008067          	ret
	  count_leading_zeros (bm, d0);
8000047c:	01000537          	lui	a0,0x1000
80000480:	01800693          	li	a3,24
80000484:	f2a67ce3          	bgeu	a2,a0,800003bc <__udivdi3+0x38>
80000488:	01000693          	li	a3,16
8000048c:	f31ff06f          	j	800003bc <__udivdi3+0x38>
	  count_leading_zeros (bm, d0);
80000490:	00000693          	li	a3,0
	  if (d0 == 0)
80000494:	00060c63          	beqz	a2,800004ac <__udivdi3+0x128>
	  count_leading_zeros (bm, d0);
80000498:	000107b7          	lui	a5,0x10
8000049c:	0cf67063          	bgeu	a2,a5,8000055c <__udivdi3+0x1d8>
800004a0:	10063693          	sltiu	a3,a2,256
800004a4:	0016b693          	seqz	a3,a3
800004a8:	00369693          	sll	a3,a3,0x3
800004ac:	00d657b3          	srl	a5,a2,a3
800004b0:	00f585b3          	add	a1,a1,a5
800004b4:	0005c783          	lbu	a5,0(a1)
800004b8:	00d787b3          	add	a5,a5,a3
800004bc:	02000693          	li	a3,32
800004c0:	40f685b3          	sub	a1,a3,a5
	  if (bm == 0)
800004c4:	0af69663          	bne	a3,a5,80000570 <__udivdi3+0x1ec>
	      n1 -= d0;
800004c8:	40c307b3          	sub	a5,t1,a2
	      q1 = 1;
800004cc:	00100593          	li	a1,1
	  udiv_qrnnd (q0, n0, n1, n0, d0);
800004d0:	01075893          	srl	a7,a4,0x10
800004d4:	0317de33          	divu	t3,a5,a7
800004d8:	01071613          	sll	a2,a4,0x10
800004dc:	01065613          	srl	a2,a2,0x10
800004e0:	01085693          	srl	a3,a6,0x10
800004e4:	0317f7b3          	remu	a5,a5,a7
800004e8:	000e0513          	mv	a0,t3
800004ec:	03c60333          	mul	t1,a2,t3
800004f0:	01079793          	sll	a5,a5,0x10
800004f4:	00f6e7b3          	or	a5,a3,a5
800004f8:	0067fe63          	bgeu	a5,t1,80000514 <__udivdi3+0x190>
800004fc:	00f707b3          	add	a5,a4,a5
80000500:	fffe0513          	add	a0,t3,-1
80000504:	00e7e863          	bltu	a5,a4,80000514 <__udivdi3+0x190>
80000508:	0067f663          	bgeu	a5,t1,80000514 <__udivdi3+0x190>
8000050c:	ffee0513          	add	a0,t3,-2
80000510:	00e787b3          	add	a5,a5,a4
80000514:	406787b3          	sub	a5,a5,t1
80000518:	0317d333          	divu	t1,a5,a7
8000051c:	01081813          	sll	a6,a6,0x10
80000520:	01085813          	srl	a6,a6,0x10
80000524:	0317f7b3          	remu	a5,a5,a7
80000528:	026606b3          	mul	a3,a2,t1
8000052c:	01079793          	sll	a5,a5,0x10
80000530:	00f86833          	or	a6,a6,a5
80000534:	00030793          	mv	a5,t1
80000538:	00d87c63          	bgeu	a6,a3,80000550 <__udivdi3+0x1cc>
8000053c:	01070833          	add	a6,a4,a6
80000540:	fff30793          	add	a5,t1,-1
80000544:	00e86663          	bltu	a6,a4,80000550 <__udivdi3+0x1cc>
80000548:	00d87463          	bgeu	a6,a3,80000550 <__udivdi3+0x1cc>
8000054c:	ffe30793          	add	a5,t1,-2
80000550:	01051513          	sll	a0,a0,0x10
80000554:	00f56533          	or	a0,a0,a5
80000558:	00008067          	ret
	  count_leading_zeros (bm, d0);
8000055c:	010007b7          	lui	a5,0x1000
80000560:	01800693          	li	a3,24
80000564:	f4f674e3          	bgeu	a2,a5,800004ac <__udivdi3+0x128>
80000568:	01000693          	li	a3,16
8000056c:	f41ff06f          	j	800004ac <__udivdi3+0x128>
	      d0 = d0 << bm;
80000570:	00b61733          	sll	a4,a2,a1
	      n2 = n1 >> b;
80000574:	00f356b3          	srl	a3,t1,a5
	      udiv_qrnnd (q1, n1, n2, n1, d0);
80000578:	01075513          	srl	a0,a4,0x10
	      n1 = (n1 << bm) | (n0 >> b);
8000057c:	00b31333          	sll	t1,t1,a1
80000580:	00f8d7b3          	srl	a5,a7,a5
80000584:	0067e7b3          	or	a5,a5,t1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
80000588:	02a6d333          	divu	t1,a3,a0
8000058c:	01071613          	sll	a2,a4,0x10
80000590:	01065613          	srl	a2,a2,0x10
	      n0 = n0 << bm;
80000594:	00b89833          	sll	a6,a7,a1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
80000598:	02a6f6b3          	remu	a3,a3,a0
8000059c:	026608b3          	mul	a7,a2,t1
800005a0:	01069593          	sll	a1,a3,0x10
800005a4:	0107d693          	srl	a3,a5,0x10
800005a8:	00b6e6b3          	or	a3,a3,a1
800005ac:	00030593          	mv	a1,t1
800005b0:	0116fe63          	bgeu	a3,a7,800005cc <__udivdi3+0x248>
800005b4:	00d706b3          	add	a3,a4,a3
800005b8:	fff30593          	add	a1,t1,-1
800005bc:	00e6e863          	bltu	a3,a4,800005cc <__udivdi3+0x248>
800005c0:	0116f663          	bgeu	a3,a7,800005cc <__udivdi3+0x248>
800005c4:	ffe30593          	add	a1,t1,-2
800005c8:	00e686b3          	add	a3,a3,a4
800005cc:	411686b3          	sub	a3,a3,a7
800005d0:	02a6d8b3          	divu	a7,a3,a0
800005d4:	01079793          	sll	a5,a5,0x10
800005d8:	0107d793          	srl	a5,a5,0x10
800005dc:	02a6f6b3          	remu	a3,a3,a0
800005e0:	03160633          	mul	a2,a2,a7
800005e4:	01069693          	sll	a3,a3,0x10
800005e8:	00d7e7b3          	or	a5,a5,a3
800005ec:	00088693          	mv	a3,a7
800005f0:	00c7fe63          	bgeu	a5,a2,8000060c <__udivdi3+0x288>
800005f4:	00f707b3          	add	a5,a4,a5
800005f8:	fff88693          	add	a3,a7,-1
800005fc:	00e7e863          	bltu	a5,a4,8000060c <__udivdi3+0x288>
80000600:	00c7f663          	bgeu	a5,a2,8000060c <__udivdi3+0x288>
80000604:	ffe88693          	add	a3,a7,-2
80000608:	00e787b3          	add	a5,a5,a4
8000060c:	01059593          	sll	a1,a1,0x10
80000610:	40c787b3          	sub	a5,a5,a2
80000614:	00d5e5b3          	or	a1,a1,a3
80000618:	eb9ff06f          	j	800004d0 <__udivdi3+0x14c>
      if (d1 > n1)
8000061c:	18d5e663          	bltu	a1,a3,800007a8 <__udivdi3+0x424>
	  count_leading_zeros (bm, d1);
80000620:	000107b7          	lui	a5,0x10
80000624:	04f6f463          	bgeu	a3,a5,8000066c <__udivdi3+0x2e8>
80000628:	1006b713          	sltiu	a4,a3,256
8000062c:	00173713          	seqz	a4,a4
80000630:	00371713          	sll	a4,a4,0x3
80000634:	a00007b7          	lui	a5,0xa0000
80000638:	00e6d5b3          	srl	a1,a3,a4
8000063c:	07878793          	add	a5,a5,120 # a0000078 <__clz_tab>
80000640:	00b787b3          	add	a5,a5,a1
80000644:	0007c783          	lbu	a5,0(a5)
80000648:	00e787b3          	add	a5,a5,a4
8000064c:	02000713          	li	a4,32
80000650:	40f705b3          	sub	a1,a4,a5
	  if (bm == 0)
80000654:	02f71663          	bne	a4,a5,80000680 <__udivdi3+0x2fc>
		  q0 = 1;
80000658:	00100513          	li	a0,1
	      if (n1 > d1 || n0 >= d0)
8000065c:	e066eee3          	bltu	a3,t1,80000478 <__udivdi3+0xf4>
80000660:	00c8b533          	sltu	a0,a7,a2
80000664:	00153513          	seqz	a0,a0
80000668:	00008067          	ret
	  count_leading_zeros (bm, d1);
8000066c:	010007b7          	lui	a5,0x1000
80000670:	01800713          	li	a4,24
80000674:	fcf6f0e3          	bgeu	a3,a5,80000634 <__udivdi3+0x2b0>
80000678:	01000713          	li	a4,16
8000067c:	fb9ff06f          	j	80000634 <__udivdi3+0x2b0>
	      d1 = (d1 << bm) | (d0 >> b);
80000680:	00f65733          	srl	a4,a2,a5
80000684:	00b696b3          	sll	a3,a3,a1
80000688:	00d766b3          	or	a3,a4,a3
	      n2 = n1 >> b;
8000068c:	00f35733          	srl	a4,t1,a5
	      n1 = (n1 << bm) | (n0 >> b);
80000690:	00b31333          	sll	t1,t1,a1
80000694:	00f8d7b3          	srl	a5,a7,a5
80000698:	0067e7b3          	or	a5,a5,t1
	      udiv_qrnnd (q0, n1, n2, n1, d1);
8000069c:	0106d313          	srl	t1,a3,0x10
800006a0:	02675eb3          	divu	t4,a4,t1
800006a4:	01069813          	sll	a6,a3,0x10
800006a8:	01085813          	srl	a6,a6,0x10
	      d0 = d0 << bm;
800006ac:	00b61633          	sll	a2,a2,a1
	      udiv_qrnnd (q0, n1, n2, n1, d1);
800006b0:	02677733          	remu	a4,a4,t1
800006b4:	03d80e33          	mul	t3,a6,t4
800006b8:	01071513          	sll	a0,a4,0x10
800006bc:	0107d713          	srl	a4,a5,0x10
800006c0:	00a76733          	or	a4,a4,a0
800006c4:	000e8513          	mv	a0,t4
800006c8:	01c77e63          	bgeu	a4,t3,800006e4 <__udivdi3+0x360>
800006cc:	00e68733          	add	a4,a3,a4
800006d0:	fffe8513          	add	a0,t4,-1
800006d4:	00d76863          	bltu	a4,a3,800006e4 <__udivdi3+0x360>
800006d8:	01c77663          	bgeu	a4,t3,800006e4 <__udivdi3+0x360>
800006dc:	ffee8513          	add	a0,t4,-2
800006e0:	00d70733          	add	a4,a4,a3
800006e4:	41c70733          	sub	a4,a4,t3
800006e8:	02675e33          	divu	t3,a4,t1
800006ec:	01079793          	sll	a5,a5,0x10
800006f0:	0107d793          	srl	a5,a5,0x10
800006f4:	02677733          	remu	a4,a4,t1
800006f8:	03c80833          	mul	a6,a6,t3
800006fc:	01071713          	sll	a4,a4,0x10
80000700:	00e7e7b3          	or	a5,a5,a4
80000704:	000e0713          	mv	a4,t3
80000708:	0107fe63          	bgeu	a5,a6,80000724 <__udivdi3+0x3a0>
8000070c:	00f687b3          	add	a5,a3,a5
80000710:	fffe0713          	add	a4,t3,-1
80000714:	00d7e863          	bltu	a5,a3,80000724 <__udivdi3+0x3a0>
80000718:	0107f663          	bgeu	a5,a6,80000724 <__udivdi3+0x3a0>
8000071c:	ffee0713          	add	a4,t3,-2
80000720:	00d787b3          	add	a5,a5,a3
80000724:	01051513          	sll	a0,a0,0x10
	      umul_ppmm (m1, m0, q0, d0);
80000728:	00010e37          	lui	t3,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
8000072c:	00e56533          	or	a0,a0,a4
	      umul_ppmm (m1, m0, q0, d0);
80000730:	fffe0693          	add	a3,t3,-1 # ffff <__stack_size+0xbfff>
80000734:	00d57733          	and	a4,a0,a3
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000738:	410787b3          	sub	a5,a5,a6
	      umul_ppmm (m1, m0, q0, d0);
8000073c:	00d676b3          	and	a3,a2,a3
80000740:	01055813          	srl	a6,a0,0x10
80000744:	01065613          	srl	a2,a2,0x10
80000748:	02d70333          	mul	t1,a4,a3
8000074c:	02d806b3          	mul	a3,a6,a3
80000750:	02c70733          	mul	a4,a4,a2
80000754:	02c80833          	mul	a6,a6,a2
80000758:	00d70633          	add	a2,a4,a3
8000075c:	01035713          	srl	a4,t1,0x10
80000760:	00c70733          	add	a4,a4,a2
80000764:	00d77463          	bgeu	a4,a3,8000076c <__udivdi3+0x3e8>
80000768:	01c80833          	add	a6,a6,t3
8000076c:	01075693          	srl	a3,a4,0x10
80000770:	010686b3          	add	a3,a3,a6
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
80000774:	02d7e663          	bltu	a5,a3,800007a0 <__udivdi3+0x41c>
80000778:	ced79ee3          	bne	a5,a3,80000474 <__udivdi3+0xf0>
	      umul_ppmm (m1, m0, q0, d0);
8000077c:	000107b7          	lui	a5,0x10
80000780:	fff78793          	add	a5,a5,-1 # ffff <__stack_size+0xbfff>
80000784:	00f77733          	and	a4,a4,a5
80000788:	01071713          	sll	a4,a4,0x10
8000078c:	00f37333          	and	t1,t1,a5
	      n0 = n0 << bm;
80000790:	00b898b3          	sll	a7,a7,a1
	      umul_ppmm (m1, m0, q0, d0);
80000794:	00670733          	add	a4,a4,t1
	      q1 = 0;
80000798:	00000593          	li	a1,0
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
8000079c:	cce8fee3          	bgeu	a7,a4,80000478 <__udivdi3+0xf4>
		  q0--;
800007a0:	fff50513          	add	a0,a0,-1 # ffffff <__stack_size+0xffbfff>
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
800007a4:	cd1ff06f          	j	80000474 <__udivdi3+0xf0>
	  q1 = 0;
800007a8:	00000593          	li	a1,0
	  q0 = 0;
800007ac:	00000513          	li	a0,0
800007b0:	00008067          	ret

800007b4 <__umoddi3>:
  d0 = dd.s.low;
800007b4:	00060813          	mv	a6,a2
  n0 = nn.s.low;
800007b8:	00050793          	mv	a5,a0
  n1 = nn.s.high;
800007bc:	00058713          	mv	a4,a1
  if (d1 == 0)
800007c0:	20069663          	bnez	a3,800009cc <__umoddi3+0x218>
      if (d0 > n1)
800007c4:	a00008b7          	lui	a7,0xa0000
800007c8:	07888893          	add	a7,a7,120 # a0000078 <__clz_tab>
800007cc:	0cc5fc63          	bgeu	a1,a2,800008a4 <__umoddi3+0xf0>
	  count_leading_zeros (bm, d0);
800007d0:	000106b7          	lui	a3,0x10
800007d4:	0ad67e63          	bgeu	a2,a3,80000890 <__umoddi3+0xdc>
800007d8:	10063693          	sltiu	a3,a2,256
800007dc:	0016b693          	seqz	a3,a3
800007e0:	00369693          	sll	a3,a3,0x3
800007e4:	00d65333          	srl	t1,a2,a3
800007e8:	006888b3          	add	a7,a7,t1
800007ec:	0008c883          	lbu	a7,0(a7)
800007f0:	02000313          	li	t1,32
800007f4:	00d886b3          	add	a3,a7,a3
800007f8:	40d308b3          	sub	a7,t1,a3
	  if (bm != 0)
800007fc:	00d30c63          	beq	t1,a3,80000814 <__umoddi3+0x60>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
80000800:	01159733          	sll	a4,a1,a7
80000804:	00d556b3          	srl	a3,a0,a3
	      d0 = d0 << bm;
80000808:	01161833          	sll	a6,a2,a7
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
8000080c:	00e6e733          	or	a4,a3,a4
	      n0 = n0 << bm;
80000810:	011517b3          	sll	a5,a0,a7
	  udiv_qrnnd (q0, n0, n1, n0, d0);
80000814:	01085613          	srl	a2,a6,0x10
80000818:	02c756b3          	divu	a3,a4,a2
8000081c:	01081513          	sll	a0,a6,0x10
80000820:	01055513          	srl	a0,a0,0x10
80000824:	02c77733          	remu	a4,a4,a2
80000828:	02a686b3          	mul	a3,a3,a0
8000082c:	01071593          	sll	a1,a4,0x10
80000830:	0107d713          	srl	a4,a5,0x10
80000834:	00b76733          	or	a4,a4,a1
80000838:	00d77a63          	bgeu	a4,a3,8000084c <__umoddi3+0x98>
8000083c:	00e80733          	add	a4,a6,a4
80000840:	01076663          	bltu	a4,a6,8000084c <__umoddi3+0x98>
80000844:	00d77463          	bgeu	a4,a3,8000084c <__umoddi3+0x98>
80000848:	01070733          	add	a4,a4,a6
8000084c:	40d70733          	sub	a4,a4,a3
80000850:	02c756b3          	divu	a3,a4,a2
80000854:	02c77733          	remu	a4,a4,a2
80000858:	02a686b3          	mul	a3,a3,a0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
8000085c:	01079793          	sll	a5,a5,0x10
80000860:	01071713          	sll	a4,a4,0x10
80000864:	0107d793          	srl	a5,a5,0x10
80000868:	00e7e7b3          	or	a5,a5,a4
8000086c:	00d7fa63          	bgeu	a5,a3,80000880 <__umoddi3+0xcc>
80000870:	00f807b3          	add	a5,a6,a5
80000874:	0107e663          	bltu	a5,a6,80000880 <__umoddi3+0xcc>
80000878:	00d7f463          	bgeu	a5,a3,80000880 <__umoddi3+0xcc>
8000087c:	010787b3          	add	a5,a5,a6
80000880:	40d787b3          	sub	a5,a5,a3
	  rr.s.low = n0 >> bm;
80000884:	0117d533          	srl	a0,a5,a7
	  *rp = rr.ll;
80000888:	00000593          	li	a1,0
8000088c:	00008067          	ret
	  count_leading_zeros (bm, d0);
80000890:	01000337          	lui	t1,0x1000
80000894:	01800693          	li	a3,24
80000898:	f46676e3          	bgeu	a2,t1,800007e4 <__umoddi3+0x30>
8000089c:	01000693          	li	a3,16
800008a0:	f45ff06f          	j	800007e4 <__umoddi3+0x30>
	  count_leading_zeros (bm, d0);
800008a4:	00000693          	li	a3,0
	  if (d0 == 0)
800008a8:	00060c63          	beqz	a2,800008c0 <__umoddi3+0x10c>
	  count_leading_zeros (bm, d0);
800008ac:	00010737          	lui	a4,0x10
800008b0:	06e67e63          	bgeu	a2,a4,8000092c <__umoddi3+0x178>
800008b4:	10063693          	sltiu	a3,a2,256
800008b8:	0016b693          	seqz	a3,a3
800008bc:	00369693          	sll	a3,a3,0x3
800008c0:	00d65733          	srl	a4,a2,a3
800008c4:	00e888b3          	add	a7,a7,a4
800008c8:	0008c703          	lbu	a4,0(a7)
800008cc:	00d70733          	add	a4,a4,a3
800008d0:	02000693          	li	a3,32
800008d4:	40e688b3          	sub	a7,a3,a4
	  if (bm == 0)
800008d8:	06e69463          	bne	a3,a4,80000940 <__umoddi3+0x18c>
	      n1 -= d0;
800008dc:	40c58733          	sub	a4,a1,a2
	  udiv_qrnnd (q0, n0, n1, n0, d0);
800008e0:	01085593          	srl	a1,a6,0x10
800008e4:	02b75633          	divu	a2,a4,a1
800008e8:	01081513          	sll	a0,a6,0x10
800008ec:	01055513          	srl	a0,a0,0x10
800008f0:	0107d693          	srl	a3,a5,0x10
800008f4:	02b77733          	remu	a4,a4,a1
800008f8:	02a60633          	mul	a2,a2,a0
800008fc:	01071713          	sll	a4,a4,0x10
80000900:	00e6e733          	or	a4,a3,a4
80000904:	00c77a63          	bgeu	a4,a2,80000918 <__umoddi3+0x164>
80000908:	00e80733          	add	a4,a6,a4
8000090c:	01076663          	bltu	a4,a6,80000918 <__umoddi3+0x164>
80000910:	00c77463          	bgeu	a4,a2,80000918 <__umoddi3+0x164>
80000914:	01070733          	add	a4,a4,a6
80000918:	40c70733          	sub	a4,a4,a2
8000091c:	02b756b3          	divu	a3,a4,a1
80000920:	02b77733          	remu	a4,a4,a1
80000924:	02a686b3          	mul	a3,a3,a0
80000928:	f35ff06f          	j	8000085c <__umoddi3+0xa8>
	  count_leading_zeros (bm, d0);
8000092c:	01000737          	lui	a4,0x1000
80000930:	01800693          	li	a3,24
80000934:	f8e676e3          	bgeu	a2,a4,800008c0 <__umoddi3+0x10c>
80000938:	01000693          	li	a3,16
8000093c:	f85ff06f          	j	800008c0 <__umoddi3+0x10c>
	      d0 = d0 << bm;
80000940:	01161833          	sll	a6,a2,a7
	      n2 = n1 >> b;
80000944:	00e5d6b3          	srl	a3,a1,a4
	      n0 = n0 << bm;
80000948:	011517b3          	sll	a5,a0,a7
	      n1 = (n1 << bm) | (n0 >> b);
8000094c:	011595b3          	sll	a1,a1,a7
80000950:	00e55733          	srl	a4,a0,a4
	      udiv_qrnnd (q1, n1, n2, n1, d0);
80000954:	01085513          	srl	a0,a6,0x10
	      n1 = (n1 << bm) | (n0 >> b);
80000958:	00b76733          	or	a4,a4,a1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
8000095c:	02a6d5b3          	divu	a1,a3,a0
80000960:	01081313          	sll	t1,a6,0x10
80000964:	01035313          	srl	t1,t1,0x10
80000968:	02a6f6b3          	remu	a3,a3,a0
8000096c:	026585b3          	mul	a1,a1,t1
80000970:	01069613          	sll	a2,a3,0x10
80000974:	01075693          	srl	a3,a4,0x10
80000978:	00c6e6b3          	or	a3,a3,a2
8000097c:	00b6fa63          	bgeu	a3,a1,80000990 <__umoddi3+0x1dc>
80000980:	00d806b3          	add	a3,a6,a3
80000984:	0106e663          	bltu	a3,a6,80000990 <__umoddi3+0x1dc>
80000988:	00b6f463          	bgeu	a3,a1,80000990 <__umoddi3+0x1dc>
8000098c:	010686b3          	add	a3,a3,a6
80000990:	40b686b3          	sub	a3,a3,a1
80000994:	02a6d633          	divu	a2,a3,a0
80000998:	01071713          	sll	a4,a4,0x10
8000099c:	01075713          	srl	a4,a4,0x10
800009a0:	02a6f6b3          	remu	a3,a3,a0
800009a4:	02660633          	mul	a2,a2,t1
800009a8:	01069693          	sll	a3,a3,0x10
800009ac:	00d76733          	or	a4,a4,a3
800009b0:	00c77a63          	bgeu	a4,a2,800009c4 <__umoddi3+0x210>
800009b4:	00e80733          	add	a4,a6,a4
800009b8:	01076663          	bltu	a4,a6,800009c4 <__umoddi3+0x210>
800009bc:	00c77463          	bgeu	a4,a2,800009c4 <__umoddi3+0x210>
800009c0:	01070733          	add	a4,a4,a6
800009c4:	40c70733          	sub	a4,a4,a2
800009c8:	f19ff06f          	j	800008e0 <__umoddi3+0x12c>
      if (d1 > n1)
800009cc:	1cd5e463          	bltu	a1,a3,80000b94 <__umoddi3+0x3e0>
	  count_leading_zeros (bm, d1);
800009d0:	00010837          	lui	a6,0x10
800009d4:	0506fe63          	bgeu	a3,a6,80000a30 <__umoddi3+0x27c>
800009d8:	1006b813          	sltiu	a6,a3,256
800009dc:	00183813          	seqz	a6,a6
800009e0:	00381813          	sll	a6,a6,0x3
800009e4:	a00008b7          	lui	a7,0xa0000
800009e8:	0106d333          	srl	t1,a3,a6
800009ec:	07888893          	add	a7,a7,120 # a0000078 <__clz_tab>
800009f0:	006888b3          	add	a7,a7,t1
800009f4:	0008c883          	lbu	a7,0(a7)
800009f8:	02000313          	li	t1,32
800009fc:	010888b3          	add	a7,a7,a6
80000a00:	41130833          	sub	a6,t1,a7
	  if (bm == 0)
80000a04:	05131063          	bne	t1,a7,80000a44 <__umoddi3+0x290>
	      if (n1 > d1 || n0 >= d0)
80000a08:	00b6e463          	bltu	a3,a1,80000a10 <__umoddi3+0x25c>
80000a0c:	00c56c63          	bltu	a0,a2,80000a24 <__umoddi3+0x270>
		  sub_ddmmss (n1, n0, n1, n0, d1, d0);
80000a10:	40c50633          	sub	a2,a0,a2
80000a14:	40d586b3          	sub	a3,a1,a3
80000a18:	00c53733          	sltu	a4,a0,a2
80000a1c:	00060793          	mv	a5,a2
80000a20:	40e68733          	sub	a4,a3,a4
		  *rp = rr.ll;
80000a24:	00078513          	mv	a0,a5
80000a28:	00070593          	mv	a1,a4
80000a2c:	00008067          	ret
	  count_leading_zeros (bm, d1);
80000a30:	010008b7          	lui	a7,0x1000
80000a34:	01800813          	li	a6,24
80000a38:	fb16f6e3          	bgeu	a3,a7,800009e4 <__umoddi3+0x230>
80000a3c:	01000813          	li	a6,16
80000a40:	fa5ff06f          	j	800009e4 <__umoddi3+0x230>
	      d1 = (d1 << bm) | (d0 >> b);
80000a44:	011657b3          	srl	a5,a2,a7
80000a48:	010696b3          	sll	a3,a3,a6
80000a4c:	00d7e6b3          	or	a3,a5,a3
	      n2 = n1 >> b;
80000a50:	0115d733          	srl	a4,a1,a7
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000a54:	0106de13          	srl	t3,a3,0x10
80000a58:	03c75f33          	divu	t5,a4,t3
80000a5c:	01069313          	sll	t1,a3,0x10
80000a60:	01035313          	srl	t1,t1,0x10
	      n1 = (n1 << bm) | (n0 >> b);
80000a64:	010597b3          	sll	a5,a1,a6
80000a68:	011555b3          	srl	a1,a0,a7
80000a6c:	00f5e5b3          	or	a1,a1,a5
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000a70:	0105d793          	srl	a5,a1,0x10
	      d0 = d0 << bm;
80000a74:	01061633          	sll	a2,a2,a6
	      n0 = n0 << bm;
80000a78:	01051533          	sll	a0,a0,a6
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000a7c:	03c77733          	remu	a4,a4,t3
80000a80:	03e30eb3          	mul	t4,t1,t5
80000a84:	01071713          	sll	a4,a4,0x10
80000a88:	00e7e7b3          	or	a5,a5,a4
80000a8c:	000f0713          	mv	a4,t5
80000a90:	01d7fe63          	bgeu	a5,t4,80000aac <__umoddi3+0x2f8>
80000a94:	00f687b3          	add	a5,a3,a5
80000a98:	ffff0713          	add	a4,t5,-1
80000a9c:	00d7e863          	bltu	a5,a3,80000aac <__umoddi3+0x2f8>
80000aa0:	01d7f663          	bgeu	a5,t4,80000aac <__umoddi3+0x2f8>
80000aa4:	ffef0713          	add	a4,t5,-2
80000aa8:	00d787b3          	add	a5,a5,a3
80000aac:	41d787b3          	sub	a5,a5,t4
80000ab0:	03c7deb3          	divu	t4,a5,t3
80000ab4:	01059593          	sll	a1,a1,0x10
80000ab8:	0105d593          	srl	a1,a1,0x10
80000abc:	03c7f7b3          	remu	a5,a5,t3
80000ac0:	000e8e13          	mv	t3,t4
80000ac4:	03d30333          	mul	t1,t1,t4
80000ac8:	01079793          	sll	a5,a5,0x10
80000acc:	00f5e5b3          	or	a1,a1,a5
80000ad0:	0065fe63          	bgeu	a1,t1,80000aec <__umoddi3+0x338>
80000ad4:	00b685b3          	add	a1,a3,a1
80000ad8:	fffe8e13          	add	t3,t4,-1
80000adc:	00d5e863          	bltu	a1,a3,80000aec <__umoddi3+0x338>
80000ae0:	0065f663          	bgeu	a1,t1,80000aec <__umoddi3+0x338>
80000ae4:	ffee8e13          	add	t3,t4,-2
80000ae8:	00d585b3          	add	a1,a1,a3
80000aec:	01071793          	sll	a5,a4,0x10
	      umul_ppmm (m1, m0, q0, d0);
80000af0:	00010f37          	lui	t5,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000af4:	01c7e7b3          	or	a5,a5,t3
80000af8:	406585b3          	sub	a1,a1,t1
	      umul_ppmm (m1, m0, q0, d0);
80000afc:	ffff0313          	add	t1,t5,-1 # ffff <__stack_size+0xbfff>
80000b00:	0067f733          	and	a4,a5,t1
80000b04:	01065e13          	srl	t3,a2,0x10
80000b08:	0107d793          	srl	a5,a5,0x10
80000b0c:	00667333          	and	t1,a2,t1
80000b10:	02670eb3          	mul	t4,a4,t1
80000b14:	02678333          	mul	t1,a5,t1
80000b18:	03c70733          	mul	a4,a4,t3
80000b1c:	03c787b3          	mul	a5,a5,t3
80000b20:	00670e33          	add	t3,a4,t1
80000b24:	010ed713          	srl	a4,t4,0x10
80000b28:	01c70733          	add	a4,a4,t3
80000b2c:	00677463          	bgeu	a4,t1,80000b34 <__umoddi3+0x380>
80000b30:	01e787b3          	add	a5,a5,t5
80000b34:	01075313          	srl	t1,a4,0x10
80000b38:	00f307b3          	add	a5,t1,a5
80000b3c:	00010337          	lui	t1,0x10
80000b40:	fff30313          	add	t1,t1,-1 # ffff <__stack_size+0xbfff>
80000b44:	00677733          	and	a4,a4,t1
80000b48:	01071713          	sll	a4,a4,0x10
80000b4c:	006efeb3          	and	t4,t4,t1
80000b50:	01d70733          	add	a4,a4,t4
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
80000b54:	00f5e663          	bltu	a1,a5,80000b60 <__umoddi3+0x3ac>
80000b58:	00f59e63          	bne	a1,a5,80000b74 <__umoddi3+0x3c0>
80000b5c:	00e57c63          	bgeu	a0,a4,80000b74 <__umoddi3+0x3c0>
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
80000b60:	40c70633          	sub	a2,a4,a2
80000b64:	00c73333          	sltu	t1,a4,a2
80000b68:	00d306b3          	add	a3,t1,a3
80000b6c:	00060713          	mv	a4,a2
80000b70:	40d787b3          	sub	a5,a5,a3
		  sub_ddmmss (n1, n0, n1, n0, m1, m0);
80000b74:	40e50733          	sub	a4,a0,a4
80000b78:	00e53533          	sltu	a0,a0,a4
80000b7c:	40f585b3          	sub	a1,a1,a5
80000b80:	40a585b3          	sub	a1,a1,a0
		  rr.s.low = (n1 << b) | (n0 >> bm);
80000b84:	011598b3          	sll	a7,a1,a7
80000b88:	01075733          	srl	a4,a4,a6
		  *rp = rr.ll;
80000b8c:	00e8e533          	or	a0,a7,a4
80000b90:	0105d5b3          	srl	a1,a1,a6
}
80000b94:	00008067          	ret

80000b98 <__adddf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
80000b98:	00100837          	lui	a6,0x100
80000b9c:	fff80813          	add	a6,a6,-1 # fffff <__stack_size+0xfbfff>
{
80000ba0:	fe010113          	add	sp,sp,-32
  FP_UNPACK_SEMIRAW_D (A, a);
80000ba4:	00b878b3          	and	a7,a6,a1
80000ba8:	0145d713          	srl	a4,a1,0x14
80000bac:	01d55793          	srl	a5,a0,0x1d
  FP_UNPACK_SEMIRAW_D (B, b);
80000bb0:	00d87833          	and	a6,a6,a3
{
80000bb4:	00912a23          	sw	s1,20(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
80000bb8:	7ff77493          	and	s1,a4,2047
80000bbc:	00389713          	sll	a4,a7,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
80000bc0:	0146d893          	srl	a7,a3,0x14
80000bc4:	00381813          	sll	a6,a6,0x3
{
80000bc8:	01212823          	sw	s2,16(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
80000bcc:	00e7e7b3          	or	a5,a5,a4
  FP_UNPACK_SEMIRAW_D (B, b);
80000bd0:	7ff8f893          	and	a7,a7,2047
80000bd4:	01d65713          	srl	a4,a2,0x1d
{
80000bd8:	00112e23          	sw	ra,28(sp)
80000bdc:	00812c23          	sw	s0,24(sp)
80000be0:	01312623          	sw	s3,12(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
80000be4:	01f5d913          	srl	s2,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
80000be8:	01f6d693          	srl	a3,a3,0x1f
80000bec:	01076733          	or	a4,a4,a6
  FP_UNPACK_SEMIRAW_D (A, a);
80000bf0:	00351513          	sll	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
80000bf4:	00361613          	sll	a2,a2,0x3
  FP_ADD_D (R, A, B);
80000bf8:	41148833          	sub	a6,s1,a7
80000bfc:	2ad91a63          	bne	s2,a3,80000eb0 <__adddf3+0x318>
80000c00:	11005c63          	blez	a6,80000d18 <__adddf3+0x180>
80000c04:	04089063          	bnez	a7,80000c44 <__adddf3+0xac>
80000c08:	00c766b3          	or	a3,a4,a2
80000c0c:	66068063          	beqz	a3,8000126c <__adddf3+0x6d4>
80000c10:	fff80593          	add	a1,a6,-1
80000c14:	02059063          	bnez	a1,80000c34 <__adddf3+0x9c>
80000c18:	00c50633          	add	a2,a0,a2
80000c1c:	00a636b3          	sltu	a3,a2,a0
80000c20:	00e78733          	add	a4,a5,a4
80000c24:	00060513          	mv	a0,a2
80000c28:	00d707b3          	add	a5,a4,a3
80000c2c:	00100493          	li	s1,1
80000c30:	06c0006f          	j	80000c9c <__adddf3+0x104>
80000c34:	7ff00693          	li	a3,2047
80000c38:	02d81063          	bne	a6,a3,80000c58 <__adddf3+0xc0>
80000c3c:	7ff00493          	li	s1,2047
80000c40:	1f80006f          	j	80000e38 <__adddf3+0x2a0>
80000c44:	7ff00693          	li	a3,2047
80000c48:	1ed48863          	beq	s1,a3,80000e38 <__adddf3+0x2a0>
80000c4c:	008006b7          	lui	a3,0x800
80000c50:	00d76733          	or	a4,a4,a3
80000c54:	00080593          	mv	a1,a6
80000c58:	03800693          	li	a3,56
80000c5c:	0ab6c863          	blt	a3,a1,80000d0c <__adddf3+0x174>
80000c60:	01f00693          	li	a3,31
80000c64:	06b6ca63          	blt	a3,a1,80000cd8 <__adddf3+0x140>
80000c68:	02000813          	li	a6,32
80000c6c:	40b80833          	sub	a6,a6,a1
80000c70:	010716b3          	sll	a3,a4,a6
80000c74:	00b658b3          	srl	a7,a2,a1
80000c78:	01061833          	sll	a6,a2,a6
80000c7c:	0116e6b3          	or	a3,a3,a7
80000c80:	01003833          	snez	a6,a6
80000c84:	0106e6b3          	or	a3,a3,a6
80000c88:	00b755b3          	srl	a1,a4,a1
80000c8c:	00a68533          	add	a0,a3,a0
80000c90:	00f585b3          	add	a1,a1,a5
80000c94:	00d536b3          	sltu	a3,a0,a3
80000c98:	00d587b3          	add	a5,a1,a3
80000c9c:	00879713          	sll	a4,a5,0x8
80000ca0:	18075c63          	bgez	a4,80000e38 <__adddf3+0x2a0>
80000ca4:	00148493          	add	s1,s1,1
80000ca8:	7ff00713          	li	a4,2047
80000cac:	5ae48a63          	beq	s1,a4,80001260 <__adddf3+0x6c8>
80000cb0:	ff800737          	lui	a4,0xff800
80000cb4:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80000cb8:	00e7f733          	and	a4,a5,a4
80000cbc:	00155793          	srl	a5,a0,0x1
80000cc0:	00157513          	and	a0,a0,1
80000cc4:	00a7e7b3          	or	a5,a5,a0
80000cc8:	01f71513          	sll	a0,a4,0x1f
80000ccc:	00f56533          	or	a0,a0,a5
80000cd0:	00175793          	srl	a5,a4,0x1
80000cd4:	1640006f          	j	80000e38 <__adddf3+0x2a0>
80000cd8:	fe058693          	add	a3,a1,-32
80000cdc:	02000893          	li	a7,32
80000ce0:	00d756b3          	srl	a3,a4,a3
80000ce4:	00000813          	li	a6,0
80000ce8:	01158863          	beq	a1,a7,80000cf8 <__adddf3+0x160>
80000cec:	04000813          	li	a6,64
80000cf0:	40b80833          	sub	a6,a6,a1
80000cf4:	01071833          	sll	a6,a4,a6
80000cf8:	00c86833          	or	a6,a6,a2
80000cfc:	01003833          	snez	a6,a6
80000d00:	0106e6b3          	or	a3,a3,a6
80000d04:	00000593          	li	a1,0
80000d08:	f85ff06f          	j	80000c8c <__adddf3+0xf4>
80000d0c:	00c766b3          	or	a3,a4,a2
80000d10:	00d036b3          	snez	a3,a3
80000d14:	ff1ff06f          	j	80000d04 <__adddf3+0x16c>
80000d18:	0c080a63          	beqz	a6,80000dec <__adddf3+0x254>
80000d1c:	409886b3          	sub	a3,a7,s1
80000d20:	02049463          	bnez	s1,80000d48 <__adddf3+0x1b0>
80000d24:	00a7e5b3          	or	a1,a5,a0
80000d28:	50058e63          	beqz	a1,80001244 <__adddf3+0x6ac>
80000d2c:	fff68593          	add	a1,a3,-1 # 7fffff <__stack_size+0x7fbfff>
80000d30:	ee0584e3          	beqz	a1,80000c18 <__adddf3+0x80>
80000d34:	7ff00813          	li	a6,2047
80000d38:	03069263          	bne	a3,a6,80000d5c <__adddf3+0x1c4>
80000d3c:	00070793          	mv	a5,a4
80000d40:	00060513          	mv	a0,a2
80000d44:	ef9ff06f          	j	80000c3c <__adddf3+0xa4>
80000d48:	7ff00593          	li	a1,2047
80000d4c:	feb888e3          	beq	a7,a1,80000d3c <__adddf3+0x1a4>
80000d50:	008005b7          	lui	a1,0x800
80000d54:	00b7e7b3          	or	a5,a5,a1
80000d58:	00068593          	mv	a1,a3
80000d5c:	03800693          	li	a3,56
80000d60:	08b6c063          	blt	a3,a1,80000de0 <__adddf3+0x248>
80000d64:	01f00693          	li	a3,31
80000d68:	04b6c263          	blt	a3,a1,80000dac <__adddf3+0x214>
80000d6c:	02000813          	li	a6,32
80000d70:	40b80833          	sub	a6,a6,a1
80000d74:	010796b3          	sll	a3,a5,a6
80000d78:	00b55333          	srl	t1,a0,a1
80000d7c:	01051833          	sll	a6,a0,a6
80000d80:	0066e6b3          	or	a3,a3,t1
80000d84:	01003833          	snez	a6,a6
80000d88:	0106e6b3          	or	a3,a3,a6
80000d8c:	00b7d5b3          	srl	a1,a5,a1
80000d90:	00c68633          	add	a2,a3,a2
80000d94:	00e585b3          	add	a1,a1,a4
80000d98:	00d636b3          	sltu	a3,a2,a3
80000d9c:	00060513          	mv	a0,a2
80000da0:	00d587b3          	add	a5,a1,a3
80000da4:	00088493          	mv	s1,a7
80000da8:	ef5ff06f          	j	80000c9c <__adddf3+0x104>
80000dac:	fe058693          	add	a3,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80000db0:	02000313          	li	t1,32
80000db4:	00d7d6b3          	srl	a3,a5,a3
80000db8:	00000813          	li	a6,0
80000dbc:	00658863          	beq	a1,t1,80000dcc <__adddf3+0x234>
80000dc0:	04000813          	li	a6,64
80000dc4:	40b80833          	sub	a6,a6,a1
80000dc8:	01079833          	sll	a6,a5,a6
80000dcc:	00a86833          	or	a6,a6,a0
80000dd0:	01003833          	snez	a6,a6
80000dd4:	0106e6b3          	or	a3,a3,a6
80000dd8:	00000593          	li	a1,0
80000ddc:	fb5ff06f          	j	80000d90 <__adddf3+0x1f8>
80000de0:	00a7e6b3          	or	a3,a5,a0
80000de4:	00d036b3          	snez	a3,a3
80000de8:	ff1ff06f          	j	80000dd8 <__adddf3+0x240>
80000dec:	00148693          	add	a3,s1,1
80000df0:	7fe6f593          	and	a1,a3,2046
80000df4:	08059663          	bnez	a1,80000e80 <__adddf3+0x2e8>
80000df8:	00a7e6b3          	or	a3,a5,a0
80000dfc:	06049263          	bnez	s1,80000e60 <__adddf3+0x2c8>
80000e00:	44068863          	beqz	a3,80001250 <__adddf3+0x6b8>
80000e04:	00c766b3          	or	a3,a4,a2
80000e08:	02068863          	beqz	a3,80000e38 <__adddf3+0x2a0>
80000e0c:	00c50633          	add	a2,a0,a2
80000e10:	00a636b3          	sltu	a3,a2,a0
80000e14:	00e78733          	add	a4,a5,a4
80000e18:	00d707b3          	add	a5,a4,a3
80000e1c:	00879713          	sll	a4,a5,0x8
80000e20:	00060513          	mv	a0,a2
80000e24:	00075a63          	bgez	a4,80000e38 <__adddf3+0x2a0>
80000e28:	ff800737          	lui	a4,0xff800
80000e2c:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80000e30:	00e7f7b3          	and	a5,a5,a4
80000e34:	00100493          	li	s1,1
  FP_PACK_SEMIRAW_D (r, R);
80000e38:	00757713          	and	a4,a0,7
80000e3c:	44070863          	beqz	a4,8000128c <__adddf3+0x6f4>
80000e40:	00f57713          	and	a4,a0,15
80000e44:	00400693          	li	a3,4
80000e48:	44d70263          	beq	a4,a3,8000128c <__adddf3+0x6f4>
80000e4c:	00450713          	add	a4,a0,4
80000e50:	00a736b3          	sltu	a3,a4,a0
80000e54:	00d787b3          	add	a5,a5,a3
80000e58:	00070513          	mv	a0,a4
80000e5c:	4300006f          	j	8000128c <__adddf3+0x6f4>
  FP_ADD_D (R, A, B);
80000e60:	ec068ee3          	beqz	a3,80000d3c <__adddf3+0x1a4>
80000e64:	00c76633          	or	a2,a4,a2
80000e68:	dc060ae3          	beqz	a2,80000c3c <__adddf3+0xa4>
80000e6c:	00000913          	li	s2,0
80000e70:	004007b7          	lui	a5,0x400
80000e74:	00000513          	li	a0,0
80000e78:	7ff00493          	li	s1,2047
80000e7c:	4100006f          	j	8000128c <__adddf3+0x6f4>
80000e80:	7ff00593          	li	a1,2047
80000e84:	3cb68c63          	beq	a3,a1,8000125c <__adddf3+0x6c4>
80000e88:	00c50633          	add	a2,a0,a2
80000e8c:	00a63533          	sltu	a0,a2,a0
80000e90:	00e78733          	add	a4,a5,a4
80000e94:	00a70733          	add	a4,a4,a0
80000e98:	01f71513          	sll	a0,a4,0x1f
80000e9c:	00165613          	srl	a2,a2,0x1
80000ea0:	00c56533          	or	a0,a0,a2
80000ea4:	00175793          	srl	a5,a4,0x1
80000ea8:	00068493          	mv	s1,a3
80000eac:	f8dff06f          	j	80000e38 <__adddf3+0x2a0>
80000eb0:	0f005c63          	blez	a6,80000fa8 <__adddf3+0x410>
80000eb4:	08089e63          	bnez	a7,80000f50 <__adddf3+0x3b8>
80000eb8:	00c766b3          	or	a3,a4,a2
80000ebc:	3a068863          	beqz	a3,8000126c <__adddf3+0x6d4>
80000ec0:	fff80693          	add	a3,a6,-1
80000ec4:	02069063          	bnez	a3,80000ee4 <__adddf3+0x34c>
80000ec8:	40c50633          	sub	a2,a0,a2
80000ecc:	00c536b3          	sltu	a3,a0,a2
80000ed0:	40e78733          	sub	a4,a5,a4
80000ed4:	00060513          	mv	a0,a2
80000ed8:	40d707b3          	sub	a5,a4,a3
80000edc:	00100493          	li	s1,1
80000ee0:	0540006f          	j	80000f34 <__adddf3+0x39c>
80000ee4:	7ff00593          	li	a1,2047
80000ee8:	d4b80ae3          	beq	a6,a1,80000c3c <__adddf3+0xa4>
80000eec:	03800593          	li	a1,56
80000ef0:	0ad5c663          	blt	a1,a3,80000f9c <__adddf3+0x404>
80000ef4:	01f00593          	li	a1,31
80000ef8:	06d5c863          	blt	a1,a3,80000f68 <__adddf3+0x3d0>
80000efc:	02000813          	li	a6,32
80000f00:	40d80833          	sub	a6,a6,a3
80000f04:	00d658b3          	srl	a7,a2,a3
80000f08:	010715b3          	sll	a1,a4,a6
80000f0c:	01061833          	sll	a6,a2,a6
80000f10:	0115e5b3          	or	a1,a1,a7
80000f14:	01003833          	snez	a6,a6
80000f18:	0105e633          	or	a2,a1,a6
80000f1c:	00d756b3          	srl	a3,a4,a3
80000f20:	40c50633          	sub	a2,a0,a2
80000f24:	00c53733          	sltu	a4,a0,a2
80000f28:	40d786b3          	sub	a3,a5,a3
80000f2c:	00060513          	mv	a0,a2
80000f30:	40e687b3          	sub	a5,a3,a4
80000f34:	00879713          	sll	a4,a5,0x8
80000f38:	f00750e3          	bgez	a4,80000e38 <__adddf3+0x2a0>
80000f3c:	00800437          	lui	s0,0x800
80000f40:	fff40413          	add	s0,s0,-1 # 7fffff <__stack_size+0x7fbfff>
80000f44:	0087f433          	and	s0,a5,s0
80000f48:	00050993          	mv	s3,a0
80000f4c:	2100006f          	j	8000115c <__adddf3+0x5c4>
80000f50:	7ff00693          	li	a3,2047
80000f54:	eed482e3          	beq	s1,a3,80000e38 <__adddf3+0x2a0>
80000f58:	008006b7          	lui	a3,0x800
80000f5c:	00d76733          	or	a4,a4,a3
80000f60:	00080693          	mv	a3,a6
80000f64:	f89ff06f          	j	80000eec <__adddf3+0x354>
80000f68:	fe068593          	add	a1,a3,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80000f6c:	02000893          	li	a7,32
80000f70:	00b755b3          	srl	a1,a4,a1
80000f74:	00000813          	li	a6,0
80000f78:	01168863          	beq	a3,a7,80000f88 <__adddf3+0x3f0>
80000f7c:	04000813          	li	a6,64
80000f80:	40d80833          	sub	a6,a6,a3
80000f84:	01071833          	sll	a6,a4,a6
80000f88:	00c86833          	or	a6,a6,a2
80000f8c:	01003833          	snez	a6,a6
80000f90:	0105e633          	or	a2,a1,a6
80000f94:	00000693          	li	a3,0
80000f98:	f89ff06f          	j	80000f20 <__adddf3+0x388>
80000f9c:	00c76633          	or	a2,a4,a2
80000fa0:	00c03633          	snez	a2,a2
80000fa4:	ff1ff06f          	j	80000f94 <__adddf3+0x3fc>
80000fa8:	0e080863          	beqz	a6,80001098 <__adddf3+0x500>
80000fac:	40988833          	sub	a6,a7,s1
80000fb0:	04049263          	bnez	s1,80000ff4 <__adddf3+0x45c>
80000fb4:	00a7e5b3          	or	a1,a5,a0
80000fb8:	2a058e63          	beqz	a1,80001274 <__adddf3+0x6dc>
80000fbc:	fff80593          	add	a1,a6,-1
80000fc0:	00059e63          	bnez	a1,80000fdc <__adddf3+0x444>
80000fc4:	40a60533          	sub	a0,a2,a0
80000fc8:	40f70733          	sub	a4,a4,a5
80000fcc:	00a63633          	sltu	a2,a2,a0
80000fd0:	40c707b3          	sub	a5,a4,a2
80000fd4:	00068913          	mv	s2,a3
80000fd8:	f05ff06f          	j	80000edc <__adddf3+0x344>
80000fdc:	7ff00313          	li	t1,2047
80000fe0:	02681463          	bne	a6,t1,80001008 <__adddf3+0x470>
80000fe4:	00070793          	mv	a5,a4
80000fe8:	00060513          	mv	a0,a2
80000fec:	7ff00493          	li	s1,2047
80000ff0:	0d00006f          	j	800010c0 <__adddf3+0x528>
80000ff4:	7ff00593          	li	a1,2047
80000ff8:	feb886e3          	beq	a7,a1,80000fe4 <__adddf3+0x44c>
80000ffc:	008005b7          	lui	a1,0x800
80001000:	00b7e7b3          	or	a5,a5,a1
80001004:	00080593          	mv	a1,a6
80001008:	03800813          	li	a6,56
8000100c:	08b84063          	blt	a6,a1,8000108c <__adddf3+0x4f4>
80001010:	01f00813          	li	a6,31
80001014:	04b84263          	blt	a6,a1,80001058 <__adddf3+0x4c0>
80001018:	02000313          	li	t1,32
8000101c:	40b30333          	sub	t1,t1,a1
80001020:	00b55e33          	srl	t3,a0,a1
80001024:	00679833          	sll	a6,a5,t1
80001028:	00651333          	sll	t1,a0,t1
8000102c:	01c86833          	or	a6,a6,t3
80001030:	00603333          	snez	t1,t1
80001034:	00686533          	or	a0,a6,t1
80001038:	00b7d5b3          	srl	a1,a5,a1
8000103c:	40a60533          	sub	a0,a2,a0
80001040:	40b705b3          	sub	a1,a4,a1
80001044:	00a63633          	sltu	a2,a2,a0
80001048:	40c587b3          	sub	a5,a1,a2
8000104c:	00088493          	mv	s1,a7
80001050:	00068913          	mv	s2,a3
80001054:	ee1ff06f          	j	80000f34 <__adddf3+0x39c>
80001058:	fe058813          	add	a6,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
8000105c:	02000e13          	li	t3,32
80001060:	0107d833          	srl	a6,a5,a6
80001064:	00000313          	li	t1,0
80001068:	01c58863          	beq	a1,t3,80001078 <__adddf3+0x4e0>
8000106c:	04000313          	li	t1,64
80001070:	40b30333          	sub	t1,t1,a1
80001074:	00679333          	sll	t1,a5,t1
80001078:	00a36333          	or	t1,t1,a0
8000107c:	00603333          	snez	t1,t1
80001080:	00686533          	or	a0,a6,t1
80001084:	00000593          	li	a1,0
80001088:	fb5ff06f          	j	8000103c <__adddf3+0x4a4>
8000108c:	00a7e533          	or	a0,a5,a0
80001090:	00a03533          	snez	a0,a0
80001094:	ff1ff06f          	j	80001084 <__adddf3+0x4ec>
80001098:	00148593          	add	a1,s1,1
8000109c:	7fe5f593          	and	a1,a1,2046
800010a0:	08059663          	bnez	a1,8000112c <__adddf3+0x594>
800010a4:	00a7e833          	or	a6,a5,a0
800010a8:	00c765b3          	or	a1,a4,a2
800010ac:	06049063          	bnez	s1,8000110c <__adddf3+0x574>
800010b0:	00081c63          	bnez	a6,800010c8 <__adddf3+0x530>
800010b4:	10058e63          	beqz	a1,800011d0 <__adddf3+0x638>
800010b8:	00070793          	mv	a5,a4
800010bc:	00060513          	mv	a0,a2
800010c0:	00068913          	mv	s2,a3
800010c4:	d75ff06f          	j	80000e38 <__adddf3+0x2a0>
800010c8:	d60588e3          	beqz	a1,80000e38 <__adddf3+0x2a0>
800010cc:	40c50833          	sub	a6,a0,a2
800010d0:	010538b3          	sltu	a7,a0,a6
800010d4:	40e785b3          	sub	a1,a5,a4
800010d8:	411585b3          	sub	a1,a1,a7
800010dc:	00859893          	sll	a7,a1,0x8
800010e0:	0008dc63          	bgez	a7,800010f8 <__adddf3+0x560>
800010e4:	40a60533          	sub	a0,a2,a0
800010e8:	40f70733          	sub	a4,a4,a5
800010ec:	00a63633          	sltu	a2,a2,a0
800010f0:	40c707b3          	sub	a5,a4,a2
800010f4:	fcdff06f          	j	800010c0 <__adddf3+0x528>
800010f8:	00b86533          	or	a0,a6,a1
800010fc:	18050463          	beqz	a0,80001284 <__adddf3+0x6ec>
80001100:	00058793          	mv	a5,a1
80001104:	00080513          	mv	a0,a6
80001108:	d31ff06f          	j	80000e38 <__adddf3+0x2a0>
8000110c:	00081c63          	bnez	a6,80001124 <__adddf3+0x58c>
80001110:	d4058ee3          	beqz	a1,80000e6c <__adddf3+0x2d4>
80001114:	00070793          	mv	a5,a4
80001118:	00060513          	mv	a0,a2
8000111c:	00068913          	mv	s2,a3
80001120:	b1dff06f          	j	80000c3c <__adddf3+0xa4>
80001124:	b0058ce3          	beqz	a1,80000c3c <__adddf3+0xa4>
80001128:	d45ff06f          	j	80000e6c <__adddf3+0x2d4>
8000112c:	40c505b3          	sub	a1,a0,a2
80001130:	00b53833          	sltu	a6,a0,a1
80001134:	40e78433          	sub	s0,a5,a4
80001138:	41040433          	sub	s0,s0,a6
8000113c:	00841813          	sll	a6,s0,0x8
80001140:	00058993          	mv	s3,a1
80001144:	08085063          	bgez	a6,800011c4 <__adddf3+0x62c>
80001148:	40a609b3          	sub	s3,a2,a0
8000114c:	40f70433          	sub	s0,a4,a5
80001150:	01363633          	sltu	a2,a2,s3
80001154:	40c40433          	sub	s0,s0,a2
80001158:	00068913          	mv	s2,a3
8000115c:	06040e63          	beqz	s0,800011d8 <__adddf3+0x640>
80001160:	00040513          	mv	a0,s0
80001164:	500020ef          	jal	80003664 <__clzsi2>
80001168:	ff850693          	add	a3,a0,-8
8000116c:	02000793          	li	a5,32
80001170:	40d787b3          	sub	a5,a5,a3
80001174:	00d41433          	sll	s0,s0,a3
80001178:	00f9d7b3          	srl	a5,s3,a5
8000117c:	0087e7b3          	or	a5,a5,s0
80001180:	00d99433          	sll	s0,s3,a3
80001184:	0a96c463          	blt	a3,s1,8000122c <__adddf3+0x694>
80001188:	409686b3          	sub	a3,a3,s1
8000118c:	00168613          	add	a2,a3,1
80001190:	01f00713          	li	a4,31
80001194:	06c74263          	blt	a4,a2,800011f8 <__adddf3+0x660>
80001198:	02000713          	li	a4,32
8000119c:	40c70733          	sub	a4,a4,a2
800011a0:	00e79533          	sll	a0,a5,a4
800011a4:	00c456b3          	srl	a3,s0,a2
800011a8:	00e41733          	sll	a4,s0,a4
800011ac:	00d56533          	or	a0,a0,a3
800011b0:	00e03733          	snez	a4,a4
800011b4:	00e56533          	or	a0,a0,a4
800011b8:	00c7d7b3          	srl	a5,a5,a2
800011bc:	00000493          	li	s1,0
800011c0:	c79ff06f          	j	80000e38 <__adddf3+0x2a0>
800011c4:	0085e5b3          	or	a1,a1,s0
800011c8:	f8059ae3          	bnez	a1,8000115c <__adddf3+0x5c4>
800011cc:	00000493          	li	s1,0
800011d0:	00000913          	li	s2,0
800011d4:	08c0006f          	j	80001260 <__adddf3+0x6c8>
800011d8:	00098513          	mv	a0,s3
800011dc:	488020ef          	jal	80003664 <__clzsi2>
800011e0:	01850693          	add	a3,a0,24
800011e4:	01f00793          	li	a5,31
800011e8:	f8d7d2e3          	bge	a5,a3,8000116c <__adddf3+0x5d4>
800011ec:	ff850793          	add	a5,a0,-8
800011f0:	00f997b3          	sll	a5,s3,a5
800011f4:	f91ff06f          	j	80001184 <__adddf3+0x5ec>
800011f8:	fe168693          	add	a3,a3,-31
800011fc:	00d7d533          	srl	a0,a5,a3
80001200:	02000693          	li	a3,32
80001204:	00000713          	li	a4,0
80001208:	00d60863          	beq	a2,a3,80001218 <__adddf3+0x680>
8000120c:	04000713          	li	a4,64
80001210:	40c70733          	sub	a4,a4,a2
80001214:	00e79733          	sll	a4,a5,a4
80001218:	00e46733          	or	a4,s0,a4
8000121c:	00e03733          	snez	a4,a4
80001220:	00e56533          	or	a0,a0,a4
80001224:	00000793          	li	a5,0
80001228:	f95ff06f          	j	800011bc <__adddf3+0x624>
8000122c:	ff800737          	lui	a4,0xff800
80001230:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80001234:	40d484b3          	sub	s1,s1,a3
80001238:	00e7f7b3          	and	a5,a5,a4
8000123c:	00040513          	mv	a0,s0
80001240:	bf9ff06f          	j	80000e38 <__adddf3+0x2a0>
80001244:	00070793          	mv	a5,a4
80001248:	00060513          	mv	a0,a2
8000124c:	c5dff06f          	j	80000ea8 <__adddf3+0x310>
80001250:	00070793          	mv	a5,a4
80001254:	00060513          	mv	a0,a2
80001258:	be1ff06f          	j	80000e38 <__adddf3+0x2a0>
8000125c:	7ff00493          	li	s1,2047
80001260:	00000793          	li	a5,0
80001264:	00000513          	li	a0,0
80001268:	0240006f          	j	8000128c <__adddf3+0x6f4>
8000126c:	00080493          	mv	s1,a6
80001270:	bc9ff06f          	j	80000e38 <__adddf3+0x2a0>
80001274:	00070793          	mv	a5,a4
80001278:	00060513          	mv	a0,a2
8000127c:	00080493          	mv	s1,a6
80001280:	e41ff06f          	j	800010c0 <__adddf3+0x528>
80001284:	00000793          	li	a5,0
80001288:	00000913          	li	s2,0
  FP_PACK_SEMIRAW_D (r, R);
8000128c:	00879713          	sll	a4,a5,0x8
80001290:	00075e63          	bgez	a4,800012ac <__adddf3+0x714>
80001294:	00148493          	add	s1,s1,1
80001298:	7ff00713          	li	a4,2047
8000129c:	08e48263          	beq	s1,a4,80001320 <__adddf3+0x788>
800012a0:	ff800737          	lui	a4,0xff800
800012a4:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
800012a8:	00e7f7b3          	and	a5,a5,a4
800012ac:	01d79693          	sll	a3,a5,0x1d
800012b0:	00355513          	srl	a0,a0,0x3
800012b4:	7ff00713          	li	a4,2047
800012b8:	00a6e6b3          	or	a3,a3,a0
800012bc:	0037d793          	srl	a5,a5,0x3
800012c0:	00e49e63          	bne	s1,a4,800012dc <__adddf3+0x744>
800012c4:	00f6e6b3          	or	a3,a3,a5
800012c8:	00000793          	li	a5,0
800012cc:	00068863          	beqz	a3,800012dc <__adddf3+0x744>
800012d0:	000807b7          	lui	a5,0x80
800012d4:	00000693          	li	a3,0
800012d8:	00000913          	li	s2,0
800012dc:	01449713          	sll	a4,s1,0x14
800012e0:	7ff00637          	lui	a2,0x7ff00
800012e4:	00c79793          	sll	a5,a5,0xc
800012e8:	00c77733          	and	a4,a4,a2
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800012ec:	01c12083          	lw	ra,28(sp)
800012f0:	01812403          	lw	s0,24(sp)
  FP_PACK_SEMIRAW_D (r, R);
800012f4:	00c7d793          	srl	a5,a5,0xc
800012f8:	00f767b3          	or	a5,a4,a5
800012fc:	01f91713          	sll	a4,s2,0x1f
80001300:	00e7e633          	or	a2,a5,a4
}
80001304:	01412483          	lw	s1,20(sp)
80001308:	01012903          	lw	s2,16(sp)
8000130c:	00c12983          	lw	s3,12(sp)
80001310:	00068513          	mv	a0,a3
80001314:	00060593          	mv	a1,a2
80001318:	02010113          	add	sp,sp,32
8000131c:	00008067          	ret
80001320:	00000793          	li	a5,0
80001324:	00000513          	li	a0,0
80001328:	f85ff06f          	j	800012ac <__adddf3+0x714>

8000132c <__divdf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__divdf3 (DFtype a, DFtype b)
{
8000132c:	fd010113          	add	sp,sp,-48
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
80001330:	0145d813          	srl	a6,a1,0x14
{
80001334:	02912223          	sw	s1,36(sp)
80001338:	03212023          	sw	s2,32(sp)
8000133c:	01312e23          	sw	s3,28(sp)
80001340:	01612823          	sw	s6,16(sp)
80001344:	01712623          	sw	s7,12(sp)
  FP_UNPACK_D (A, a);
80001348:	00c59493          	sll	s1,a1,0xc
{
8000134c:	02112623          	sw	ra,44(sp)
80001350:	02812423          	sw	s0,40(sp)
80001354:	01412c23          	sw	s4,24(sp)
80001358:	01512a23          	sw	s5,20(sp)
  FP_UNPACK_D (A, a);
8000135c:	7ff87813          	and	a6,a6,2047
{
80001360:	00050b13          	mv	s6,a0
80001364:	00060b93          	mv	s7,a2
80001368:	00068913          	mv	s2,a3
  FP_UNPACK_D (A, a);
8000136c:	00c4d493          	srl	s1,s1,0xc
80001370:	01f5d993          	srl	s3,a1,0x1f
80001374:	0a080063          	beqz	a6,80001414 <__divdf3+0xe8>
80001378:	7ff00793          	li	a5,2047
8000137c:	10f80063          	beq	a6,a5,8000147c <__divdf3+0x150>
80001380:	01d55a13          	srl	s4,a0,0x1d
80001384:	00349493          	sll	s1,s1,0x3
80001388:	009a6a33          	or	s4,s4,s1
8000138c:	008007b7          	lui	a5,0x800
80001390:	00fa6a33          	or	s4,s4,a5
80001394:	00351413          	sll	s0,a0,0x3
80001398:	c0180a93          	add	s5,a6,-1023
8000139c:	00000b13          	li	s6,0
  FP_UNPACK_D (B, b);
800013a0:	01495713          	srl	a4,s2,0x14
800013a4:	00c91493          	sll	s1,s2,0xc
800013a8:	7ff77713          	and	a4,a4,2047
800013ac:	00c4d493          	srl	s1,s1,0xc
800013b0:	01f95913          	srl	s2,s2,0x1f
800013b4:	10070263          	beqz	a4,800014b8 <__divdf3+0x18c>
800013b8:	7ff00793          	li	a5,2047
800013bc:	16f70663          	beq	a4,a5,80001528 <__divdf3+0x1fc>
800013c0:	00349493          	sll	s1,s1,0x3
800013c4:	01dbd793          	srl	a5,s7,0x1d
800013c8:	0097e7b3          	or	a5,a5,s1
800013cc:	008004b7          	lui	s1,0x800
800013d0:	0097e4b3          	or	s1,a5,s1
800013d4:	003b9f13          	sll	t5,s7,0x3
800013d8:	c0170713          	add	a4,a4,-1023
800013dc:	00000793          	li	a5,0
  FP_DIV_D (R, A, B);
800013e0:	40ea8833          	sub	a6,s5,a4
800013e4:	002b1713          	sll	a4,s6,0x2
800013e8:	00f76733          	or	a4,a4,a5
800013ec:	fff70713          	add	a4,a4,-1
800013f0:	00e00693          	li	a3,14
800013f4:	0129c633          	xor	a2,s3,s2
800013f8:	16e6e463          	bltu	a3,a4,80001560 <__divdf3+0x234>
800013fc:	a00006b7          	lui	a3,0xa0000
80001400:	00271713          	sll	a4,a4,0x2
80001404:	00068693          	mv	a3,a3
80001408:	00d70733          	add	a4,a4,a3
8000140c:	00072703          	lw	a4,0(a4)
80001410:	00070067          	jr	a4
  FP_UNPACK_D (A, a);
80001414:	00a4ea33          	or	s4,s1,a0
80001418:	060a0e63          	beqz	s4,80001494 <__divdf3+0x168>
8000141c:	02048e63          	beqz	s1,80001458 <__divdf3+0x12c>
80001420:	00048513          	mv	a0,s1
80001424:	240020ef          	jal	80003664 <__clzsi2>
80001428:	ff550793          	add	a5,a0,-11
8000142c:	01d00a13          	li	s4,29
80001430:	ff850713          	add	a4,a0,-8
80001434:	40fa0a33          	sub	s4,s4,a5
80001438:	00e494b3          	sll	s1,s1,a4
8000143c:	014b5a33          	srl	s4,s6,s4
80001440:	009a6a33          	or	s4,s4,s1
80001444:	00eb14b3          	sll	s1,s6,a4
80001448:	c0d00813          	li	a6,-1011
8000144c:	40a80ab3          	sub	s5,a6,a0
80001450:	00048413          	mv	s0,s1
80001454:	f49ff06f          	j	8000139c <__divdf3+0x70>
80001458:	20c020ef          	jal	80003664 <__clzsi2>
8000145c:	00050a13          	mv	s4,a0
80001460:	015a0793          	add	a5,s4,21
80001464:	01c00713          	li	a4,28
80001468:	02050513          	add	a0,a0,32
8000146c:	fcf750e3          	bge	a4,a5,8000142c <__divdf3+0x100>
80001470:	ff8a0a13          	add	s4,s4,-8
80001474:	014b1a33          	sll	s4,s6,s4
80001478:	fd1ff06f          	j	80001448 <__divdf3+0x11c>
8000147c:	00a4ea33          	or	s4,s1,a0
80001480:	020a1263          	bnez	s4,800014a4 <__divdf3+0x178>
80001484:	00000413          	li	s0,0
80001488:	7ff00a93          	li	s5,2047
8000148c:	00200b13          	li	s6,2
80001490:	f11ff06f          	j	800013a0 <__divdf3+0x74>
80001494:	00000413          	li	s0,0
80001498:	00000a93          	li	s5,0
8000149c:	00100b13          	li	s6,1
800014a0:	f01ff06f          	j	800013a0 <__divdf3+0x74>
800014a4:	00050413          	mv	s0,a0
800014a8:	00048a13          	mv	s4,s1
800014ac:	7ff00a93          	li	s5,2047
800014b0:	00300b13          	li	s6,3
800014b4:	eedff06f          	j	800013a0 <__divdf3+0x74>
  FP_UNPACK_D (B, b);
800014b8:	0174ef33          	or	t5,s1,s7
800014bc:	080f0263          	beqz	t5,80001540 <__divdf3+0x214>
800014c0:	04048063          	beqz	s1,80001500 <__divdf3+0x1d4>
800014c4:	00048513          	mv	a0,s1
800014c8:	19c020ef          	jal	80003664 <__clzsi2>
800014cc:	ff550713          	add	a4,a0,-11
800014d0:	01d00793          	li	a5,29
800014d4:	ff850693          	add	a3,a0,-8
800014d8:	40e787b3          	sub	a5,a5,a4
800014dc:	00d494b3          	sll	s1,s1,a3
800014e0:	00fbd7b3          	srl	a5,s7,a5
800014e4:	0097e7b3          	or	a5,a5,s1
800014e8:	00db94b3          	sll	s1,s7,a3
800014ec:	c0d00713          	li	a4,-1011
800014f0:	00048f13          	mv	t5,s1
800014f4:	40a70733          	sub	a4,a4,a0
800014f8:	00078493          	mv	s1,a5
800014fc:	ee1ff06f          	j	800013dc <__divdf3+0xb0>
80001500:	000b8513          	mv	a0,s7
80001504:	160020ef          	jal	80003664 <__clzsi2>
80001508:	00050793          	mv	a5,a0
8000150c:	01578713          	add	a4,a5,21 # 800015 <__stack_size+0x7fc015>
80001510:	01c00693          	li	a3,28
80001514:	02050513          	add	a0,a0,32
80001518:	fae6dce3          	bge	a3,a4,800014d0 <__divdf3+0x1a4>
8000151c:	ff878793          	add	a5,a5,-8
80001520:	00fb97b3          	sll	a5,s7,a5
80001524:	fc9ff06f          	j	800014ec <__divdf3+0x1c0>
80001528:	0174ef33          	or	t5,s1,s7
8000152c:	020f1263          	bnez	t5,80001550 <__divdf3+0x224>
80001530:	00000493          	li	s1,0
80001534:	7ff00713          	li	a4,2047
80001538:	00200793          	li	a5,2
8000153c:	ea5ff06f          	j	800013e0 <__divdf3+0xb4>
80001540:	00000493          	li	s1,0
80001544:	00000713          	li	a4,0
80001548:	00100793          	li	a5,1
8000154c:	e95ff06f          	j	800013e0 <__divdf3+0xb4>
80001550:	000b8f13          	mv	t5,s7
80001554:	7ff00713          	li	a4,2047
80001558:	00300793          	li	a5,3
8000155c:	e85ff06f          	j	800013e0 <__divdf3+0xb4>
  FP_DIV_D (R, A, B);
80001560:	0144e663          	bltu	s1,s4,8000156c <__divdf3+0x240>
80001564:	349a1c63          	bne	s4,s1,800018bc <__divdf3+0x590>
80001568:	35e46a63          	bltu	s0,t5,800018bc <__divdf3+0x590>
8000156c:	01fa1693          	sll	a3,s4,0x1f
80001570:	00145793          	srl	a5,s0,0x1
80001574:	01f41713          	sll	a4,s0,0x1f
80001578:	001a5a13          	srl	s4,s4,0x1
8000157c:	00f6e433          	or	s0,a3,a5
80001580:	00849893          	sll	a7,s1,0x8
80001584:	018f5593          	srl	a1,t5,0x18
80001588:	0115e5b3          	or	a1,a1,a7
8000158c:	0108d893          	srl	a7,a7,0x10
80001590:	031a5eb3          	divu	t4,s4,a7
80001594:	01059313          	sll	t1,a1,0x10
80001598:	01035313          	srl	t1,t1,0x10
8000159c:	01045793          	srl	a5,s0,0x10
800015a0:	008f1513          	sll	a0,t5,0x8
800015a4:	031a7a33          	remu	s4,s4,a7
800015a8:	000e8693          	mv	a3,t4
800015ac:	03d30e33          	mul	t3,t1,t4
800015b0:	010a1a13          	sll	s4,s4,0x10
800015b4:	0147e7b3          	or	a5,a5,s4
800015b8:	01c7fe63          	bgeu	a5,t3,800015d4 <__divdf3+0x2a8>
800015bc:	00f587b3          	add	a5,a1,a5
800015c0:	fffe8693          	add	a3,t4,-1
800015c4:	00b7e863          	bltu	a5,a1,800015d4 <__divdf3+0x2a8>
800015c8:	01c7f663          	bgeu	a5,t3,800015d4 <__divdf3+0x2a8>
800015cc:	ffee8693          	add	a3,t4,-2
800015d0:	00b787b3          	add	a5,a5,a1
800015d4:	41c787b3          	sub	a5,a5,t3
800015d8:	0317df33          	divu	t5,a5,a7
800015dc:	01041413          	sll	s0,s0,0x10
800015e0:	01045413          	srl	s0,s0,0x10
800015e4:	0317f7b3          	remu	a5,a5,a7
800015e8:	000f0e13          	mv	t3,t5
800015ec:	03e30eb3          	mul	t4,t1,t5
800015f0:	01079793          	sll	a5,a5,0x10
800015f4:	00f467b3          	or	a5,s0,a5
800015f8:	01d7fe63          	bgeu	a5,t4,80001614 <__divdf3+0x2e8>
800015fc:	00f587b3          	add	a5,a1,a5
80001600:	ffff0e13          	add	t3,t5,-1
80001604:	00b7e863          	bltu	a5,a1,80001614 <__divdf3+0x2e8>
80001608:	01d7f663          	bgeu	a5,t4,80001614 <__divdf3+0x2e8>
8000160c:	ffef0e13          	add	t3,t5,-2
80001610:	00b787b3          	add	a5,a5,a1
80001614:	01069693          	sll	a3,a3,0x10
80001618:	00010437          	lui	s0,0x10
8000161c:	01c6e2b3          	or	t0,a3,t3
80001620:	fff40e13          	add	t3,s0,-1 # ffff <__stack_size+0xbfff>
80001624:	01c2f6b3          	and	a3,t0,t3
80001628:	0102df93          	srl	t6,t0,0x10
8000162c:	01c57e33          	and	t3,a0,t3
80001630:	41d787b3          	sub	a5,a5,t4
80001634:	01055e93          	srl	t4,a0,0x10
80001638:	02de03b3          	mul	t2,t3,a3
8000163c:	03cf84b3          	mul	s1,t6,t3
80001640:	02de86b3          	mul	a3,t4,a3
80001644:	00968f33          	add	t5,a3,s1
80001648:	0103d693          	srl	a3,t2,0x10
8000164c:	01e686b3          	add	a3,a3,t5
80001650:	03df8fb3          	mul	t6,t6,t4
80001654:	0096f463          	bgeu	a3,s1,8000165c <__divdf3+0x330>
80001658:	008f8fb3          	add	t6,t6,s0
8000165c:	0106df13          	srl	t5,a3,0x10
80001660:	01ff0f33          	add	t5,t5,t6
80001664:	00010fb7          	lui	t6,0x10
80001668:	ffff8f93          	add	t6,t6,-1 # ffff <__stack_size+0xbfff>
8000166c:	01f6f6b3          	and	a3,a3,t6
80001670:	01069693          	sll	a3,a3,0x10
80001674:	01f3f3b3          	and	t2,t2,t6
80001678:	007686b3          	add	a3,a3,t2
8000167c:	01e7e863          	bltu	a5,t5,8000168c <__divdf3+0x360>
80001680:	00028493          	mv	s1,t0
80001684:	05e79863          	bne	a5,t5,800016d4 <__divdf3+0x3a8>
80001688:	04d77663          	bgeu	a4,a3,800016d4 <__divdf3+0x3a8>
8000168c:	00a70fb3          	add	t6,a4,a0
80001690:	00efb3b3          	sltu	t2,t6,a4
80001694:	00b38433          	add	s0,t2,a1
80001698:	008787b3          	add	a5,a5,s0
8000169c:	fff28493          	add	s1,t0,-1
800016a0:	000f8713          	mv	a4,t6
800016a4:	00f5e663          	bltu	a1,a5,800016b0 <__divdf3+0x384>
800016a8:	02f59663          	bne	a1,a5,800016d4 <__divdf3+0x3a8>
800016ac:	02039463          	bnez	t2,800016d4 <__divdf3+0x3a8>
800016b0:	01e7e663          	bltu	a5,t5,800016bc <__divdf3+0x390>
800016b4:	02ff1063          	bne	t5,a5,800016d4 <__divdf3+0x3a8>
800016b8:	00dffe63          	bgeu	t6,a3,800016d4 <__divdf3+0x3a8>
800016bc:	01f50fb3          	add	t6,a0,t6
800016c0:	000f8713          	mv	a4,t6
800016c4:	00afbfb3          	sltu	t6,t6,a0
800016c8:	00bf8fb3          	add	t6,t6,a1
800016cc:	ffe28493          	add	s1,t0,-2
800016d0:	01f787b3          	add	a5,a5,t6
800016d4:	40d706b3          	sub	a3,a4,a3
800016d8:	41e787b3          	sub	a5,a5,t5
800016dc:	00d73733          	sltu	a4,a4,a3
800016e0:	40e787b3          	sub	a5,a5,a4
800016e4:	fff00f13          	li	t5,-1
800016e8:	12f58663          	beq	a1,a5,80001814 <__divdf3+0x4e8>
800016ec:	0317dfb3          	divu	t6,a5,a7
800016f0:	0106d713          	srl	a4,a3,0x10
800016f4:	0317f7b3          	remu	a5,a5,a7
800016f8:	03f30f33          	mul	t5,t1,t6
800016fc:	01079793          	sll	a5,a5,0x10
80001700:	00f767b3          	or	a5,a4,a5
80001704:	000f8713          	mv	a4,t6
80001708:	01e7fe63          	bgeu	a5,t5,80001724 <__divdf3+0x3f8>
8000170c:	00f587b3          	add	a5,a1,a5
80001710:	ffff8713          	add	a4,t6,-1
80001714:	00b7e863          	bltu	a5,a1,80001724 <__divdf3+0x3f8>
80001718:	01e7f663          	bgeu	a5,t5,80001724 <__divdf3+0x3f8>
8000171c:	ffef8713          	add	a4,t6,-2
80001720:	00b787b3          	add	a5,a5,a1
80001724:	41e787b3          	sub	a5,a5,t5
80001728:	0317df33          	divu	t5,a5,a7
8000172c:	01069693          	sll	a3,a3,0x10
80001730:	0106d693          	srl	a3,a3,0x10
80001734:	0317f7b3          	remu	a5,a5,a7
80001738:	000f0893          	mv	a7,t5
8000173c:	03e30333          	mul	t1,t1,t5
80001740:	01079793          	sll	a5,a5,0x10
80001744:	00f6e7b3          	or	a5,a3,a5
80001748:	0067fe63          	bgeu	a5,t1,80001764 <__divdf3+0x438>
8000174c:	00f587b3          	add	a5,a1,a5
80001750:	ffff0893          	add	a7,t5,-1
80001754:	00b7e863          	bltu	a5,a1,80001764 <__divdf3+0x438>
80001758:	0067f663          	bgeu	a5,t1,80001764 <__divdf3+0x438>
8000175c:	ffef0893          	add	a7,t5,-2
80001760:	00b787b3          	add	a5,a5,a1
80001764:	01071693          	sll	a3,a4,0x10
80001768:	0116e6b3          	or	a3,a3,a7
8000176c:	01069713          	sll	a4,a3,0x10
80001770:	01075713          	srl	a4,a4,0x10
80001774:	406787b3          	sub	a5,a5,t1
80001778:	0106d313          	srl	t1,a3,0x10
8000177c:	03c70f33          	mul	t5,a4,t3
80001780:	03c30e33          	mul	t3,t1,t3
80001784:	026e8333          	mul	t1,t4,t1
80001788:	02ee8eb3          	mul	t4,t4,a4
8000178c:	010f5713          	srl	a4,t5,0x10
80001790:	01ce8eb3          	add	t4,t4,t3
80001794:	01d70733          	add	a4,a4,t4
80001798:	01c77663          	bgeu	a4,t3,800017a4 <__divdf3+0x478>
8000179c:	000108b7          	lui	a7,0x10
800017a0:	01130333          	add	t1,t1,a7
800017a4:	01075893          	srl	a7,a4,0x10
800017a8:	006888b3          	add	a7,a7,t1
800017ac:	00010337          	lui	t1,0x10
800017b0:	fff30313          	add	t1,t1,-1 # ffff <__stack_size+0xbfff>
800017b4:	00677733          	and	a4,a4,t1
800017b8:	01071713          	sll	a4,a4,0x10
800017bc:	006f7f33          	and	t5,t5,t1
800017c0:	01e70733          	add	a4,a4,t5
800017c4:	0117e863          	bltu	a5,a7,800017d4 <__divdf3+0x4a8>
800017c8:	23179c63          	bne	a5,a7,80001a00 <__divdf3+0x6d4>
800017cc:	00068f13          	mv	t5,a3
800017d0:	04070263          	beqz	a4,80001814 <__divdf3+0x4e8>
800017d4:	00f587b3          	add	a5,a1,a5
800017d8:	fff68f13          	add	t5,a3,-1 # 9fffffff <Func_2+0x1fff9c9b>
800017dc:	00078313          	mv	t1,a5
800017e0:	02b7e463          	bltu	a5,a1,80001808 <__divdf3+0x4dc>
800017e4:	0117e663          	bltu	a5,a7,800017f0 <__divdf3+0x4c4>
800017e8:	21179a63          	bne	a5,a7,800019fc <__divdf3+0x6d0>
800017ec:	02e57063          	bgeu	a0,a4,8000180c <__divdf3+0x4e0>
800017f0:	ffe68f13          	add	t5,a3,-2
800017f4:	00151693          	sll	a3,a0,0x1
800017f8:	00a6b333          	sltu	t1,a3,a0
800017fc:	00b30333          	add	t1,t1,a1
80001800:	00678333          	add	t1,a5,t1
80001804:	00068513          	mv	a0,a3
80001808:	01131463          	bne	t1,a7,80001810 <__divdf3+0x4e4>
8000180c:	00a70463          	beq	a4,a0,80001814 <__divdf3+0x4e8>
80001810:	001f6f13          	or	t5,t5,1
  FP_PACK_D (r, R);
80001814:	3ff80713          	add	a4,a6,1023
80001818:	10e05263          	blez	a4,8000191c <__divdf3+0x5f0>
8000181c:	007f7793          	and	a5,t5,7
80001820:	02078063          	beqz	a5,80001840 <__divdf3+0x514>
80001824:	00ff7793          	and	a5,t5,15
80001828:	00400693          	li	a3,4
8000182c:	00d78a63          	beq	a5,a3,80001840 <__divdf3+0x514>
80001830:	004f0793          	add	a5,t5,4
80001834:	01e7b6b3          	sltu	a3,a5,t5
80001838:	00d484b3          	add	s1,s1,a3
8000183c:	00078f13          	mv	t5,a5
80001840:	00749793          	sll	a5,s1,0x7
80001844:	0007da63          	bgez	a5,80001858 <__divdf3+0x52c>
80001848:	ff0007b7          	lui	a5,0xff000
8000184c:	fff78793          	add	a5,a5,-1 # feffffff <__stack_base+0x5efeffff>
80001850:	00f4f4b3          	and	s1,s1,a5
80001854:	40080713          	add	a4,a6,1024
80001858:	7fe00793          	li	a5,2046
8000185c:	08e7ca63          	blt	a5,a4,800018f0 <__divdf3+0x5c4>
80001860:	003f5f13          	srl	t5,t5,0x3
80001864:	01d49793          	sll	a5,s1,0x1d
80001868:	01e7ef33          	or	t5,a5,t5
8000186c:	0034d513          	srl	a0,s1,0x3
80001870:	00c51513          	sll	a0,a0,0xc
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80001874:	02c12083          	lw	ra,44(sp)
80001878:	02812403          	lw	s0,40(sp)
  FP_PACK_D (r, R);
8000187c:	00c55513          	srl	a0,a0,0xc
80001880:	01471713          	sll	a4,a4,0x14
80001884:	00a76733          	or	a4,a4,a0
80001888:	01f61613          	sll	a2,a2,0x1f
8000188c:	00c767b3          	or	a5,a4,a2
}
80001890:	02412483          	lw	s1,36(sp)
80001894:	02012903          	lw	s2,32(sp)
80001898:	01c12983          	lw	s3,28(sp)
8000189c:	01812a03          	lw	s4,24(sp)
800018a0:	01412a83          	lw	s5,20(sp)
800018a4:	01012b03          	lw	s6,16(sp)
800018a8:	00c12b83          	lw	s7,12(sp)
800018ac:	000f0513          	mv	a0,t5
800018b0:	00078593          	mv	a1,a5
800018b4:	03010113          	add	sp,sp,48
800018b8:	00008067          	ret
  FP_DIV_D (R, A, B);
800018bc:	fff80813          	add	a6,a6,-1
800018c0:	00000713          	li	a4,0
800018c4:	cbdff06f          	j	80001580 <__divdf3+0x254>
  FP_UNPACK_D (A, a);
800018c8:	00098613          	mv	a2,s3
  FP_DIV_D (R, A, B);
800018cc:	000a0493          	mv	s1,s4
800018d0:	00040f13          	mv	t5,s0
800018d4:	000b0793          	mv	a5,s6
  FP_PACK_D (r, R);
800018d8:	00300713          	li	a4,3
800018dc:	0ee78863          	beq	a5,a4,800019cc <__divdf3+0x6a0>
800018e0:	00100713          	li	a4,1
800018e4:	0ee78e63          	beq	a5,a4,800019e0 <__divdf3+0x6b4>
800018e8:	00200713          	li	a4,2
800018ec:	f2e794e3          	bne	a5,a4,80001814 <__divdf3+0x4e8>
800018f0:	00000513          	li	a0,0
800018f4:	00000f13          	li	t5,0
800018f8:	7ff00713          	li	a4,2047
800018fc:	f75ff06f          	j	80001870 <__divdf3+0x544>
  FP_UNPACK_D (B, b);
80001900:	00090613          	mv	a2,s2
  FP_DIV_D (R, A, B);
80001904:	fd5ff06f          	j	800018d8 <__divdf3+0x5ac>
80001908:	000804b7          	lui	s1,0x80
8000190c:	00000f13          	li	t5,0
80001910:	00000613          	li	a2,0
80001914:	00300793          	li	a5,3
80001918:	fc1ff06f          	j	800018d8 <__divdf3+0x5ac>
  FP_PACK_D (r, R);
8000191c:	00100513          	li	a0,1
80001920:	40e50533          	sub	a0,a0,a4
80001924:	03800793          	li	a5,56
80001928:	0aa7cc63          	blt	a5,a0,800019e0 <__divdf3+0x6b4>
8000192c:	01f00793          	li	a5,31
80001930:	06a7c463          	blt	a5,a0,80001998 <__divdf3+0x66c>
80001934:	41e80813          	add	a6,a6,1054
80001938:	010497b3          	sll	a5,s1,a6
8000193c:	00af5733          	srl	a4,t5,a0
80001940:	010f1833          	sll	a6,t5,a6
80001944:	00e7e7b3          	or	a5,a5,a4
80001948:	01003833          	snez	a6,a6
8000194c:	0107e7b3          	or	a5,a5,a6
80001950:	00a4d533          	srl	a0,s1,a0
80001954:	0077f713          	and	a4,a5,7
80001958:	02070063          	beqz	a4,80001978 <__divdf3+0x64c>
8000195c:	00f7f713          	and	a4,a5,15
80001960:	00400693          	li	a3,4
80001964:	00d70a63          	beq	a4,a3,80001978 <__divdf3+0x64c>
80001968:	00478713          	add	a4,a5,4
8000196c:	00f736b3          	sltu	a3,a4,a5
80001970:	00d50533          	add	a0,a0,a3
80001974:	00070793          	mv	a5,a4
80001978:	00851713          	sll	a4,a0,0x8
8000197c:	06074863          	bltz	a4,800019ec <__divdf3+0x6c0>
80001980:	01d51f13          	sll	t5,a0,0x1d
80001984:	0037d793          	srl	a5,a5,0x3
80001988:	00ff6f33          	or	t5,t5,a5
8000198c:	00355513          	srl	a0,a0,0x3
80001990:	00000713          	li	a4,0
80001994:	eddff06f          	j	80001870 <__divdf3+0x544>
80001998:	fe100793          	li	a5,-31
8000199c:	40e787b3          	sub	a5,a5,a4
800019a0:	02000693          	li	a3,32
800019a4:	00f4d7b3          	srl	a5,s1,a5
800019a8:	00000713          	li	a4,0
800019ac:	00d50663          	beq	a0,a3,800019b8 <__divdf3+0x68c>
800019b0:	43e80713          	add	a4,a6,1086
800019b4:	00e49733          	sll	a4,s1,a4
800019b8:	01e76733          	or	a4,a4,t5
800019bc:	00e03733          	snez	a4,a4
800019c0:	00e7e7b3          	or	a5,a5,a4
800019c4:	00000513          	li	a0,0
800019c8:	f8dff06f          	j	80001954 <__divdf3+0x628>
800019cc:	00080537          	lui	a0,0x80
800019d0:	00000f13          	li	t5,0
800019d4:	7ff00713          	li	a4,2047
800019d8:	00000613          	li	a2,0
800019dc:	e95ff06f          	j	80001870 <__divdf3+0x544>
800019e0:	00000513          	li	a0,0
800019e4:	00000f13          	li	t5,0
800019e8:	fa9ff06f          	j	80001990 <__divdf3+0x664>
800019ec:	00000513          	li	a0,0
800019f0:	00000f13          	li	t5,0
800019f4:	00100713          	li	a4,1
800019f8:	e79ff06f          	j	80001870 <__divdf3+0x544>
  FP_DIV_D (R, A, B);
800019fc:	000f0693          	mv	a3,t5
80001a00:	00068f13          	mv	t5,a3
80001a04:	e0dff06f          	j	80001810 <__divdf3+0x4e4>

80001a08 <__eqdf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
80001a08:	0145d713          	srl	a4,a1,0x14
80001a0c:	001007b7          	lui	a5,0x100
80001a10:	fff78793          	add	a5,a5,-1 # fffff <__stack_size+0xfbfff>
  FP_UNPACK_RAW_D (B, b);
80001a14:	0146d813          	srl	a6,a3,0x14
{
80001a18:	00050313          	mv	t1,a0
80001a1c:	00050e93          	mv	t4,a0
  FP_UNPACK_RAW_D (A, a);
80001a20:	7ff77713          	and	a4,a4,2047
  FP_CMP_EQ_D (r, A, B, 1);
80001a24:	7ff00513          	li	a0,2047
  FP_UNPACK_RAW_D (A, a);
80001a28:	00b7f8b3          	and	a7,a5,a1
80001a2c:	00060f13          	mv	t5,a2
  FP_UNPACK_RAW_D (B, b);
80001a30:	00d7f7b3          	and	a5,a5,a3
  FP_UNPACK_RAW_D (A, a);
80001a34:	01f5d593          	srl	a1,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
80001a38:	7ff87813          	and	a6,a6,2047
80001a3c:	01f6d693          	srl	a3,a3,0x1f
  FP_CMP_EQ_D (r, A, B, 1);
80001a40:	00a71c63          	bne	a4,a0,80001a58 <__eqdf2+0x50>
80001a44:	0068ee33          	or	t3,a7,t1
80001a48:	00100513          	li	a0,1
80001a4c:	000e1463          	bnez	t3,80001a54 <__eqdf2+0x4c>
80001a50:	00e80663          	beq	a6,a4,80001a5c <__eqdf2+0x54>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80001a54:	00008067          	ret
  FP_CMP_EQ_D (r, A, B, 1);
80001a58:	00a81863          	bne	a6,a0,80001a68 <__eqdf2+0x60>
80001a5c:	00c7e633          	or	a2,a5,a2
80001a60:	00100513          	li	a0,1
80001a64:	fe0618e3          	bnez	a2,80001a54 <__eqdf2+0x4c>
80001a68:	00100513          	li	a0,1
80001a6c:	ff0714e3          	bne	a4,a6,80001a54 <__eqdf2+0x4c>
80001a70:	fef892e3          	bne	a7,a5,80001a54 <__eqdf2+0x4c>
80001a74:	ffee90e3          	bne	t4,t5,80001a54 <__eqdf2+0x4c>
80001a78:	00d58a63          	beq	a1,a3,80001a8c <__eqdf2+0x84>
80001a7c:	fc071ce3          	bnez	a4,80001a54 <__eqdf2+0x4c>
80001a80:	0068e8b3          	or	a7,a7,t1
80001a84:	01103533          	snez	a0,a7
80001a88:	00008067          	ret
80001a8c:	00000513          	li	a0,0
80001a90:	00008067          	ret

80001a94 <__gedf2>:
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
  FP_UNPACK_RAW_D (B, b);
80001a94:	0146d793          	srl	a5,a3,0x14
  FP_UNPACK_RAW_D (A, a);
80001a98:	0145d893          	srl	a7,a1,0x14
80001a9c:	00100737          	lui	a4,0x100
80001aa0:	fff70713          	add	a4,a4,-1 # fffff <__stack_size+0xfbfff>
{
80001aa4:	00050813          	mv	a6,a0
80001aa8:	00050e13          	mv	t3,a0
  FP_UNPACK_RAW_D (A, a);
80001aac:	7ff8f893          	and	a7,a7,2047
  FP_UNPACK_RAW_D (B, b);
80001ab0:	7ff7f513          	and	a0,a5,2047
  FP_CMP_D (r, A, B, -2, 2);
80001ab4:	7ff00793          	li	a5,2047
  FP_UNPACK_RAW_D (A, a);
80001ab8:	00b77333          	and	t1,a4,a1
80001abc:	00060e93          	mv	t4,a2
  FP_UNPACK_RAW_D (B, b);
80001ac0:	00d77733          	and	a4,a4,a3
  FP_UNPACK_RAW_D (A, a);
80001ac4:	01f5d593          	srl	a1,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
80001ac8:	01f6d693          	srl	a3,a3,0x1f
  FP_CMP_D (r, A, B, -2, 2);
80001acc:	00f89663          	bne	a7,a5,80001ad8 <__gedf2+0x44>
80001ad0:	010367b3          	or	a5,t1,a6
80001ad4:	06079c63          	bnez	a5,80001b4c <__gedf2+0xb8>
80001ad8:	7ff00793          	li	a5,2047
80001adc:	00f51663          	bne	a0,a5,80001ae8 <__gedf2+0x54>
80001ae0:	00c767b3          	or	a5,a4,a2
80001ae4:	06079463          	bnez	a5,80001b4c <__gedf2+0xb8>
80001ae8:	00000793          	li	a5,0
80001aec:	00089663          	bnez	a7,80001af8 <__gedf2+0x64>
80001af0:	01036833          	or	a6,t1,a6
80001af4:	00183793          	seqz	a5,a6
80001af8:	04051e63          	bnez	a0,80001b54 <__gedf2+0xc0>
80001afc:	00c76633          	or	a2,a4,a2
80001b00:	00078c63          	beqz	a5,80001b18 <__gedf2+0x84>
80001b04:	02060063          	beqz	a2,80001b24 <__gedf2+0x90>
80001b08:	00100513          	li	a0,1
80001b0c:	00069c63          	bnez	a3,80001b24 <__gedf2+0x90>
80001b10:	fff00513          	li	a0,-1
80001b14:	00008067          	ret
80001b18:	04061063          	bnez	a2,80001b58 <__gedf2+0xc4>
80001b1c:	fff00513          	li	a0,-1
80001b20:	04058463          	beqz	a1,80001b68 <__gedf2+0xd4>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80001b24:	00008067          	ret
  FP_CMP_D (r, A, B, -2, 2);
80001b28:	fea8c0e3          	blt	a7,a0,80001b08 <__gedf2+0x74>
80001b2c:	fe6768e3          	bltu	a4,t1,80001b1c <__gedf2+0x88>
80001b30:	00e31863          	bne	t1,a4,80001b40 <__gedf2+0xac>
80001b34:	ffcee4e3          	bltu	t4,t3,80001b1c <__gedf2+0x88>
80001b38:	00000513          	li	a0,0
80001b3c:	ffde74e3          	bgeu	t3,t4,80001b24 <__gedf2+0x90>
80001b40:	00100513          	li	a0,1
80001b44:	fe0590e3          	bnez	a1,80001b24 <__gedf2+0x90>
80001b48:	fc9ff06f          	j	80001b10 <__gedf2+0x7c>
80001b4c:	ffe00513          	li	a0,-2
80001b50:	00008067          	ret
80001b54:	fa079ae3          	bnez	a5,80001b08 <__gedf2+0x74>
80001b58:	fcb692e3          	bne	a3,a1,80001b1c <__gedf2+0x88>
80001b5c:	fd1556e3          	bge	a0,a7,80001b28 <__gedf2+0x94>
80001b60:	fff00513          	li	a0,-1
80001b64:	fc0690e3          	bnez	a3,80001b24 <__gedf2+0x90>
80001b68:	00100513          	li	a0,1
80001b6c:	00008067          	ret

80001b70 <__ledf2>:
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
  FP_UNPACK_RAW_D (B, b);
80001b70:	0146d793          	srl	a5,a3,0x14
  FP_UNPACK_RAW_D (A, a);
80001b74:	0145d893          	srl	a7,a1,0x14
80001b78:	00100737          	lui	a4,0x100
80001b7c:	fff70713          	add	a4,a4,-1 # fffff <__stack_size+0xfbfff>
{
80001b80:	00050813          	mv	a6,a0
80001b84:	00050e13          	mv	t3,a0
  FP_UNPACK_RAW_D (A, a);
80001b88:	7ff8f893          	and	a7,a7,2047
  FP_UNPACK_RAW_D (B, b);
80001b8c:	7ff7f513          	and	a0,a5,2047
  FP_CMP_D (r, A, B, 2, 2);
80001b90:	7ff00793          	li	a5,2047
  FP_UNPACK_RAW_D (A, a);
80001b94:	00b77333          	and	t1,a4,a1
80001b98:	00060e93          	mv	t4,a2
  FP_UNPACK_RAW_D (B, b);
80001b9c:	00d77733          	and	a4,a4,a3
  FP_UNPACK_RAW_D (A, a);
80001ba0:	01f5d593          	srl	a1,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
80001ba4:	01f6d693          	srl	a3,a3,0x1f
  FP_CMP_D (r, A, B, 2, 2);
80001ba8:	00f89663          	bne	a7,a5,80001bb4 <__ledf2+0x44>
80001bac:	010367b3          	or	a5,t1,a6
80001bb0:	06079c63          	bnez	a5,80001c28 <__ledf2+0xb8>
80001bb4:	7ff00793          	li	a5,2047
80001bb8:	00f51663          	bne	a0,a5,80001bc4 <__ledf2+0x54>
80001bbc:	00c767b3          	or	a5,a4,a2
80001bc0:	06079463          	bnez	a5,80001c28 <__ledf2+0xb8>
80001bc4:	00000793          	li	a5,0
80001bc8:	00089663          	bnez	a7,80001bd4 <__ledf2+0x64>
80001bcc:	01036833          	or	a6,t1,a6
80001bd0:	00183793          	seqz	a5,a6
80001bd4:	04051e63          	bnez	a0,80001c30 <__ledf2+0xc0>
80001bd8:	00c76633          	or	a2,a4,a2
80001bdc:	00078c63          	beqz	a5,80001bf4 <__ledf2+0x84>
80001be0:	02060063          	beqz	a2,80001c00 <__ledf2+0x90>
80001be4:	00100513          	li	a0,1
80001be8:	00069c63          	bnez	a3,80001c00 <__ledf2+0x90>
80001bec:	fff00513          	li	a0,-1
80001bf0:	00008067          	ret
80001bf4:	04061063          	bnez	a2,80001c34 <__ledf2+0xc4>
80001bf8:	fff00513          	li	a0,-1
80001bfc:	04058463          	beqz	a1,80001c44 <__ledf2+0xd4>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80001c00:	00008067          	ret
  FP_CMP_D (r, A, B, 2, 2);
80001c04:	fea8c0e3          	blt	a7,a0,80001be4 <__ledf2+0x74>
80001c08:	fe6768e3          	bltu	a4,t1,80001bf8 <__ledf2+0x88>
80001c0c:	00e31863          	bne	t1,a4,80001c1c <__ledf2+0xac>
80001c10:	ffcee4e3          	bltu	t4,t3,80001bf8 <__ledf2+0x88>
80001c14:	00000513          	li	a0,0
80001c18:	ffde74e3          	bgeu	t3,t4,80001c00 <__ledf2+0x90>
80001c1c:	00100513          	li	a0,1
80001c20:	fe0590e3          	bnez	a1,80001c00 <__ledf2+0x90>
80001c24:	fc9ff06f          	j	80001bec <__ledf2+0x7c>
80001c28:	00200513          	li	a0,2
80001c2c:	00008067          	ret
80001c30:	fa079ae3          	bnez	a5,80001be4 <__ledf2+0x74>
80001c34:	fcb692e3          	bne	a3,a1,80001bf8 <__ledf2+0x88>
80001c38:	fd1556e3          	bge	a0,a7,80001c04 <__ledf2+0x94>
80001c3c:	fff00513          	li	a0,-1
80001c40:	fc0690e3          	bnez	a3,80001c00 <__ledf2+0x90>
80001c44:	00100513          	li	a0,1
80001c48:	00008067          	ret

80001c4c <__muldf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__muldf3 (DFtype a, DFtype b)
{
80001c4c:	fd010113          	add	sp,sp,-48
80001c50:	01512a23          	sw	s5,20(sp)
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
80001c54:	0145da93          	srl	s5,a1,0x14
{
80001c58:	02812423          	sw	s0,40(sp)
80001c5c:	02912223          	sw	s1,36(sp)
80001c60:	01312e23          	sw	s3,28(sp)
80001c64:	01412c23          	sw	s4,24(sp)
80001c68:	01612823          	sw	s6,16(sp)
  FP_UNPACK_D (A, a);
80001c6c:	00c59493          	sll	s1,a1,0xc
{
80001c70:	02112623          	sw	ra,44(sp)
80001c74:	03212023          	sw	s2,32(sp)
80001c78:	01712623          	sw	s7,12(sp)
  FP_UNPACK_D (A, a);
80001c7c:	7ffafa93          	and	s5,s5,2047
{
80001c80:	00050413          	mv	s0,a0
80001c84:	00060b13          	mv	s6,a2
80001c88:	00068993          	mv	s3,a3
  FP_UNPACK_D (A, a);
80001c8c:	00c4d493          	srl	s1,s1,0xc
80001c90:	01f5da13          	srl	s4,a1,0x1f
80001c94:	240a8e63          	beqz	s5,80001ef0 <__muldf3+0x2a4>
80001c98:	7ff00793          	li	a5,2047
80001c9c:	2cfa8063          	beq	s5,a5,80001f5c <__muldf3+0x310>
80001ca0:	00349493          	sll	s1,s1,0x3
80001ca4:	01d55793          	srl	a5,a0,0x1d
80001ca8:	0097e7b3          	or	a5,a5,s1
80001cac:	008004b7          	lui	s1,0x800
80001cb0:	0097e4b3          	or	s1,a5,s1
80001cb4:	00351913          	sll	s2,a0,0x3
80001cb8:	c01a8a93          	add	s5,s5,-1023
80001cbc:	00000b93          	li	s7,0
  FP_UNPACK_D (B, b);
80001cc0:	0149d713          	srl	a4,s3,0x14
80001cc4:	00c99413          	sll	s0,s3,0xc
80001cc8:	7ff77713          	and	a4,a4,2047
80001ccc:	00c45413          	srl	s0,s0,0xc
80001cd0:	01f9d993          	srl	s3,s3,0x1f
80001cd4:	2c070063          	beqz	a4,80001f94 <__muldf3+0x348>
80001cd8:	7ff00793          	li	a5,2047
80001cdc:	32f70463          	beq	a4,a5,80002004 <__muldf3+0x3b8>
80001ce0:	00341413          	sll	s0,s0,0x3
80001ce4:	01db5793          	srl	a5,s6,0x1d
80001ce8:	0087e7b3          	or	a5,a5,s0
80001cec:	00800437          	lui	s0,0x800
80001cf0:	0087e433          	or	s0,a5,s0
80001cf4:	c0170693          	add	a3,a4,-1023
80001cf8:	003b1793          	sll	a5,s6,0x3
80001cfc:	00000713          	li	a4,0
  FP_MUL_D (R, A, B);
80001d00:	00da8ab3          	add	s5,s5,a3
80001d04:	002b9693          	sll	a3,s7,0x2
80001d08:	00e6e6b3          	or	a3,a3,a4
80001d0c:	00a00613          	li	a2,10
80001d10:	001a8513          	add	a0,s5,1
80001d14:	40d64663          	blt	a2,a3,80002120 <__muldf3+0x4d4>
80001d18:	00200613          	li	a2,2
80001d1c:	013a45b3          	xor	a1,s4,s3
80001d20:	30d64e63          	blt	a2,a3,8000203c <__muldf3+0x3f0>
80001d24:	fff68693          	add	a3,a3,-1
80001d28:	00100613          	li	a2,1
80001d2c:	32d67a63          	bgeu	a2,a3,80002060 <__muldf3+0x414>
80001d30:	00010337          	lui	t1,0x10
80001d34:	fff30e13          	add	t3,t1,-1 # ffff <__stack_size+0xbfff>
80001d38:	01095713          	srl	a4,s2,0x10
80001d3c:	0107d893          	srl	a7,a5,0x10
80001d40:	01c97933          	and	s2,s2,t3
80001d44:	01c7ff33          	and	t5,a5,t3
80001d48:	03e907b3          	mul	a5,s2,t5
80001d4c:	03e70eb3          	mul	t4,a4,t5
80001d50:	0107d813          	srl	a6,a5,0x10
80001d54:	03288633          	mul	a2,a7,s2
80001d58:	01d60633          	add	a2,a2,t4
80001d5c:	00c80833          	add	a6,a6,a2
80001d60:	031706b3          	mul	a3,a4,a7
80001d64:	01d87463          	bgeu	a6,t4,80001d6c <__muldf3+0x120>
80001d68:	006686b3          	add	a3,a3,t1
80001d6c:	01085293          	srl	t0,a6,0x10
80001d70:	01c87833          	and	a6,a6,t3
80001d74:	01c7f7b3          	and	a5,a5,t3
80001d78:	01045613          	srl	a2,s0,0x10
80001d7c:	01c47e33          	and	t3,s0,t3
80001d80:	01081813          	sll	a6,a6,0x10
80001d84:	00f80833          	add	a6,a6,a5
80001d88:	03c90eb3          	mul	t4,s2,t3
80001d8c:	03c707b3          	mul	a5,a4,t3
80001d90:	03260933          	mul	s2,a2,s2
80001d94:	02c70333          	mul	t1,a4,a2
80001d98:	00f90933          	add	s2,s2,a5
80001d9c:	010ed713          	srl	a4,t4,0x10
80001da0:	01270733          	add	a4,a4,s2
80001da4:	00f77663          	bgeu	a4,a5,80001db0 <__muldf3+0x164>
80001da8:	000107b7          	lui	a5,0x10
80001dac:	00f30333          	add	t1,t1,a5
80001db0:	00010437          	lui	s0,0x10
80001db4:	01075793          	srl	a5,a4,0x10
80001db8:	fff40f93          	add	t6,s0,-1 # ffff <__stack_size+0xbfff>
80001dbc:	00678333          	add	t1,a5,t1
80001dc0:	01f777b3          	and	a5,a4,t6
80001dc4:	01fefeb3          	and	t4,t4,t6
80001dc8:	01079793          	sll	a5,a5,0x10
80001dcc:	01f4ffb3          	and	t6,s1,t6
80001dd0:	01d787b3          	add	a5,a5,t4
80001dd4:	0104de93          	srl	t4,s1,0x10
80001dd8:	03ff03b3          	mul	t2,t5,t6
80001ddc:	00f282b3          	add	t0,t0,a5
80001de0:	03ee8f33          	mul	t5,t4,t5
80001de4:	0103d713          	srl	a4,t2,0x10
80001de8:	03d884b3          	mul	s1,a7,t4
80001dec:	03f888b3          	mul	a7,a7,t6
80001df0:	01e888b3          	add	a7,a7,t5
80001df4:	01170733          	add	a4,a4,a7
80001df8:	01e77463          	bgeu	a4,t5,80001e00 <__muldf3+0x1b4>
80001dfc:	008484b3          	add	s1,s1,s0
80001e00:	01075f13          	srl	t5,a4,0x10
80001e04:	009f0f33          	add	t5,t5,s1
80001e08:	000104b7          	lui	s1,0x10
80001e0c:	fff48413          	add	s0,s1,-1 # ffff <__stack_size+0xbfff>
80001e10:	00877733          	and	a4,a4,s0
80001e14:	0083f3b3          	and	t2,t2,s0
80001e18:	01071713          	sll	a4,a4,0x10
80001e1c:	007708b3          	add	a7,a4,t2
80001e20:	03fe03b3          	mul	t2,t3,t6
80001e24:	03ce8e33          	mul	t3,t4,t3
80001e28:	03d60eb3          	mul	t4,a2,t4
80001e2c:	03f60633          	mul	a2,a2,t6
80001e30:	0103df93          	srl	t6,t2,0x10
80001e34:	01c60633          	add	a2,a2,t3
80001e38:	00cf8fb3          	add	t6,t6,a2
80001e3c:	01cff463          	bgeu	t6,t3,80001e44 <__muldf3+0x1f8>
80001e40:	009e8eb3          	add	t4,t4,s1
80001e44:	008ff733          	and	a4,t6,s0
80001e48:	0083f3b3          	and	t2,t2,s0
80001e4c:	01071713          	sll	a4,a4,0x10
80001e50:	005686b3          	add	a3,a3,t0
80001e54:	00770733          	add	a4,a4,t2
80001e58:	00670333          	add	t1,a4,t1
80001e5c:	00f6b7b3          	sltu	a5,a3,a5
80001e60:	00f307b3          	add	a5,t1,a5
80001e64:	00e33633          	sltu	a2,t1,a4
80001e68:	011688b3          	add	a7,a3,a7
80001e6c:	0067b333          	sltu	t1,a5,t1
80001e70:	00666633          	or	a2,a2,t1
80001e74:	00d8b6b3          	sltu	a3,a7,a3
80001e78:	01e78333          	add	t1,a5,t5
80001e7c:	00d306b3          	add	a3,t1,a3
80001e80:	00f33733          	sltu	a4,t1,a5
80001e84:	010fdf93          	srl	t6,t6,0x10
80001e88:	0066b333          	sltu	t1,a3,t1
80001e8c:	00989793          	sll	a5,a7,0x9
80001e90:	01f60633          	add	a2,a2,t6
80001e94:	00676733          	or	a4,a4,t1
80001e98:	00c70733          	add	a4,a4,a2
80001e9c:	0107e7b3          	or	a5,a5,a6
80001ea0:	01d70733          	add	a4,a4,t4
80001ea4:	00f037b3          	snez	a5,a5
80001ea8:	0178d893          	srl	a7,a7,0x17
80001eac:	00971713          	sll	a4,a4,0x9
80001eb0:	0176d413          	srl	s0,a3,0x17
80001eb4:	0117e7b3          	or	a5,a5,a7
80001eb8:	00969693          	sll	a3,a3,0x9
80001ebc:	00d7e7b3          	or	a5,a5,a3
80001ec0:	00771693          	sll	a3,a4,0x7
80001ec4:	00876433          	or	s0,a4,s0
80001ec8:	0206d063          	bgez	a3,80001ee8 <__muldf3+0x29c>
80001ecc:	0017d713          	srl	a4,a5,0x1
80001ed0:	0017f793          	and	a5,a5,1
80001ed4:	00f76733          	or	a4,a4,a5
80001ed8:	01f41793          	sll	a5,s0,0x1f
80001edc:	00f767b3          	or	a5,a4,a5
80001ee0:	00145413          	srl	s0,s0,0x1
80001ee4:	00050a93          	mv	s5,a0
80001ee8:	000a8513          	mv	a0,s5
80001eec:	18c0006f          	j	80002078 <__muldf3+0x42c>
  FP_UNPACK_D (A, a);
80001ef0:	00a4e933          	or	s2,s1,a0
80001ef4:	08090063          	beqz	s2,80001f74 <__muldf3+0x328>
80001ef8:	04048063          	beqz	s1,80001f38 <__muldf3+0x2ec>
80001efc:	00048513          	mv	a0,s1
80001f00:	764010ef          	jal	80003664 <__clzsi2>
80001f04:	ff550713          	add	a4,a0,-11 # 7fff5 <__stack_size+0x7bff5>
80001f08:	01d00793          	li	a5,29
80001f0c:	ff850693          	add	a3,a0,-8
80001f10:	40e787b3          	sub	a5,a5,a4
80001f14:	00d494b3          	sll	s1,s1,a3
80001f18:	00f457b3          	srl	a5,s0,a5
80001f1c:	0097e7b3          	or	a5,a5,s1
80001f20:	00d414b3          	sll	s1,s0,a3
80001f24:	c0d00a93          	li	s5,-1011
80001f28:	00048913          	mv	s2,s1
80001f2c:	40aa8ab3          	sub	s5,s5,a0
80001f30:	00078493          	mv	s1,a5
80001f34:	d89ff06f          	j	80001cbc <__muldf3+0x70>
80001f38:	72c010ef          	jal	80003664 <__clzsi2>
80001f3c:	00050793          	mv	a5,a0
80001f40:	01578713          	add	a4,a5,21 # 10015 <__stack_size+0xc015>
80001f44:	01c00693          	li	a3,28
80001f48:	02050513          	add	a0,a0,32
80001f4c:	fae6dee3          	bge	a3,a4,80001f08 <__muldf3+0x2bc>
80001f50:	ff878793          	add	a5,a5,-8
80001f54:	00f417b3          	sll	a5,s0,a5
80001f58:	fcdff06f          	j	80001f24 <__muldf3+0x2d8>
80001f5c:	00a4e933          	or	s2,s1,a0
80001f60:	02091263          	bnez	s2,80001f84 <__muldf3+0x338>
80001f64:	00000493          	li	s1,0
80001f68:	7ff00a93          	li	s5,2047
80001f6c:	00200b93          	li	s7,2
80001f70:	d51ff06f          	j	80001cc0 <__muldf3+0x74>
80001f74:	00000493          	li	s1,0
80001f78:	00000a93          	li	s5,0
80001f7c:	00100b93          	li	s7,1
80001f80:	d41ff06f          	j	80001cc0 <__muldf3+0x74>
80001f84:	00050913          	mv	s2,a0
80001f88:	7ff00a93          	li	s5,2047
80001f8c:	00300b93          	li	s7,3
80001f90:	d31ff06f          	j	80001cc0 <__muldf3+0x74>
  FP_UNPACK_D (B, b);
80001f94:	016467b3          	or	a5,s0,s6
80001f98:	08078263          	beqz	a5,8000201c <__muldf3+0x3d0>
80001f9c:	04040063          	beqz	s0,80001fdc <__muldf3+0x390>
80001fa0:	00040513          	mv	a0,s0
80001fa4:	6c0010ef          	jal	80003664 <__clzsi2>
80001fa8:	ff550693          	add	a3,a0,-11
80001fac:	01d00713          	li	a4,29
80001fb0:	ff850793          	add	a5,a0,-8
80001fb4:	40d70733          	sub	a4,a4,a3
80001fb8:	00f41433          	sll	s0,s0,a5
80001fbc:	00eb5733          	srl	a4,s6,a4
80001fc0:	00876733          	or	a4,a4,s0
80001fc4:	00fb1433          	sll	s0,s6,a5
80001fc8:	c0d00693          	li	a3,-1011
80001fcc:	00040793          	mv	a5,s0
80001fd0:	40a686b3          	sub	a3,a3,a0
80001fd4:	00070413          	mv	s0,a4
80001fd8:	d25ff06f          	j	80001cfc <__muldf3+0xb0>
80001fdc:	000b0513          	mv	a0,s6
80001fe0:	684010ef          	jal	80003664 <__clzsi2>
80001fe4:	00050793          	mv	a5,a0
80001fe8:	01578693          	add	a3,a5,21
80001fec:	01c00713          	li	a4,28
80001ff0:	02050513          	add	a0,a0,32
80001ff4:	fad75ce3          	bge	a4,a3,80001fac <__muldf3+0x360>
80001ff8:	ff878793          	add	a5,a5,-8
80001ffc:	00fb1733          	sll	a4,s6,a5
80002000:	fc9ff06f          	j	80001fc8 <__muldf3+0x37c>
80002004:	016467b3          	or	a5,s0,s6
80002008:	02079263          	bnez	a5,8000202c <__muldf3+0x3e0>
8000200c:	00000413          	li	s0,0
80002010:	7ff00693          	li	a3,2047
80002014:	00200713          	li	a4,2
80002018:	ce9ff06f          	j	80001d00 <__muldf3+0xb4>
8000201c:	00000413          	li	s0,0
80002020:	00000693          	li	a3,0
80002024:	00100713          	li	a4,1
80002028:	cd9ff06f          	j	80001d00 <__muldf3+0xb4>
8000202c:	000b0793          	mv	a5,s6
80002030:	7ff00693          	li	a3,2047
80002034:	00300713          	li	a4,3
80002038:	cc9ff06f          	j	80001d00 <__muldf3+0xb4>
8000203c:	00100613          	li	a2,1
80002040:	00d61633          	sll	a2,a2,a3
  FP_MUL_D (R, A, B);
80002044:	53067693          	and	a3,a2,1328
80002048:	0e069663          	bnez	a3,80002134 <__muldf3+0x4e8>
8000204c:	24067813          	and	a6,a2,576
80002050:	1a081a63          	bnez	a6,80002204 <__muldf3+0x5b8>
80002054:	08867613          	and	a2,a2,136
80002058:	cc060ce3          	beqz	a2,80001d30 <__muldf3+0xe4>
  FP_UNPACK_D (B, b);
8000205c:	00098593          	mv	a1,s3
  FP_PACK_D (r, R);
80002060:	00200693          	li	a3,2
80002064:	18d70863          	beq	a4,a3,800021f4 <__muldf3+0x5a8>
80002068:	00300693          	li	a3,3
8000206c:	1ad70463          	beq	a4,a3,80002214 <__muldf3+0x5c8>
80002070:	00100693          	li	a3,1
80002074:	1ad70663          	beq	a4,a3,80002220 <__muldf3+0x5d4>
80002078:	3ff50613          	add	a2,a0,1023
8000207c:	0cc05463          	blez	a2,80002144 <__muldf3+0x4f8>
80002080:	0077f713          	and	a4,a5,7
80002084:	02070063          	beqz	a4,800020a4 <__muldf3+0x458>
80002088:	00f7f713          	and	a4,a5,15
8000208c:	00400693          	li	a3,4
80002090:	00d70a63          	beq	a4,a3,800020a4 <__muldf3+0x458>
80002094:	00478713          	add	a4,a5,4
80002098:	00f736b3          	sltu	a3,a4,a5
8000209c:	00d40433          	add	s0,s0,a3
800020a0:	00070793          	mv	a5,a4
800020a4:	00741713          	sll	a4,s0,0x7
800020a8:	00075a63          	bgez	a4,800020bc <__muldf3+0x470>
800020ac:	ff000737          	lui	a4,0xff000
800020b0:	fff70713          	add	a4,a4,-1 # feffffff <__stack_base+0x5efeffff>
800020b4:	00e47433          	and	s0,s0,a4
800020b8:	40050613          	add	a2,a0,1024
800020bc:	7fe00713          	li	a4,2046
800020c0:	12c74a63          	blt	a4,a2,800021f4 <__muldf3+0x5a8>
800020c4:	0037d793          	srl	a5,a5,0x3
800020c8:	01d41693          	sll	a3,s0,0x1d
800020cc:	00f6e6b3          	or	a3,a3,a5
800020d0:	00345713          	srl	a4,s0,0x3
800020d4:	00c71713          	sll	a4,a4,0xc
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800020d8:	02c12083          	lw	ra,44(sp)
800020dc:	02812403          	lw	s0,40(sp)
  FP_PACK_D (r, R);
800020e0:	01461613          	sll	a2,a2,0x14
800020e4:	00c75713          	srl	a4,a4,0xc
800020e8:	01f59593          	sll	a1,a1,0x1f
800020ec:	00e66633          	or	a2,a2,a4
800020f0:	00b667b3          	or	a5,a2,a1
}
800020f4:	02412483          	lw	s1,36(sp)
800020f8:	02012903          	lw	s2,32(sp)
800020fc:	01c12983          	lw	s3,28(sp)
80002100:	01812a03          	lw	s4,24(sp)
80002104:	01412a83          	lw	s5,20(sp)
80002108:	01012b03          	lw	s6,16(sp)
8000210c:	00c12b83          	lw	s7,12(sp)
80002110:	00068513          	mv	a0,a3
80002114:	00078593          	mv	a1,a5
80002118:	03010113          	add	sp,sp,48
8000211c:	00008067          	ret
  FP_MUL_D (R, A, B);
80002120:	00f00613          	li	a2,15
80002124:	0ec68863          	beq	a3,a2,80002214 <__muldf3+0x5c8>
80002128:	00b00613          	li	a2,11
  FP_UNPACK_D (A, a);
8000212c:	000a0593          	mv	a1,s4
  FP_MUL_D (R, A, B);
80002130:	f2c686e3          	beq	a3,a2,8000205c <__muldf3+0x410>
80002134:	00048413          	mv	s0,s1
80002138:	00090793          	mv	a5,s2
8000213c:	000b8713          	mv	a4,s7
80002140:	f21ff06f          	j	80002060 <__muldf3+0x414>
  FP_PACK_D (r, R);
80002144:	00100713          	li	a4,1
80002148:	40c70733          	sub	a4,a4,a2
8000214c:	03800693          	li	a3,56
80002150:	0ce6c863          	blt	a3,a4,80002220 <__muldf3+0x5d4>
80002154:	01f00693          	li	a3,31
80002158:	06e6c463          	blt	a3,a4,800021c0 <__muldf3+0x574>
8000215c:	41e50513          	add	a0,a0,1054
80002160:	00e7d633          	srl	a2,a5,a4
80002164:	00a416b3          	sll	a3,s0,a0
80002168:	00a79533          	sll	a0,a5,a0
8000216c:	00c6e6b3          	or	a3,a3,a2
80002170:	00a03533          	snez	a0,a0
80002174:	00a6e7b3          	or	a5,a3,a0
80002178:	00e45733          	srl	a4,s0,a4
8000217c:	0077f693          	and	a3,a5,7
80002180:	02068063          	beqz	a3,800021a0 <__muldf3+0x554>
80002184:	00f7f693          	and	a3,a5,15
80002188:	00400613          	li	a2,4
8000218c:	00c68a63          	beq	a3,a2,800021a0 <__muldf3+0x554>
80002190:	00478693          	add	a3,a5,4
80002194:	00f6b633          	sltu	a2,a3,a5
80002198:	00c70733          	add	a4,a4,a2
8000219c:	00068793          	mv	a5,a3
800021a0:	00871693          	sll	a3,a4,0x8
800021a4:	0806c463          	bltz	a3,8000222c <__muldf3+0x5e0>
800021a8:	01d71693          	sll	a3,a4,0x1d
800021ac:	0037d793          	srl	a5,a5,0x3
800021b0:	00f6e6b3          	or	a3,a3,a5
800021b4:	00375713          	srl	a4,a4,0x3
800021b8:	00000613          	li	a2,0
800021bc:	f19ff06f          	j	800020d4 <__muldf3+0x488>
800021c0:	fe100693          	li	a3,-31
800021c4:	40c686b3          	sub	a3,a3,a2
800021c8:	02000813          	li	a6,32
800021cc:	00d456b3          	srl	a3,s0,a3
800021d0:	00000613          	li	a2,0
800021d4:	01070663          	beq	a4,a6,800021e0 <__muldf3+0x594>
800021d8:	43e50613          	add	a2,a0,1086
800021dc:	00c41633          	sll	a2,s0,a2
800021e0:	00f66633          	or	a2,a2,a5
800021e4:	00c03633          	snez	a2,a2
800021e8:	00c6e7b3          	or	a5,a3,a2
800021ec:	00000713          	li	a4,0
800021f0:	f8dff06f          	j	8000217c <__muldf3+0x530>
800021f4:	00000713          	li	a4,0
800021f8:	00000693          	li	a3,0
800021fc:	7ff00613          	li	a2,2047
80002200:	ed5ff06f          	j	800020d4 <__muldf3+0x488>
  FP_MUL_D (R, A, B);
80002204:	00080737          	lui	a4,0x80
  FP_PACK_D (r, R);
80002208:	7ff00613          	li	a2,2047
8000220c:	00000593          	li	a1,0
80002210:	ec5ff06f          	j	800020d4 <__muldf3+0x488>
80002214:	00080737          	lui	a4,0x80
80002218:	00000693          	li	a3,0
8000221c:	fedff06f          	j	80002208 <__muldf3+0x5bc>
80002220:	00000713          	li	a4,0
80002224:	00000693          	li	a3,0
80002228:	f91ff06f          	j	800021b8 <__muldf3+0x56c>
8000222c:	00000713          	li	a4,0
80002230:	00000693          	li	a3,0
80002234:	00100613          	li	a2,1
80002238:	e9dff06f          	j	800020d4 <__muldf3+0x488>

8000223c <__subdf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
8000223c:	00100837          	lui	a6,0x100
80002240:	fff80813          	add	a6,a6,-1 # fffff <__stack_size+0xfbfff>
{
80002244:	fe010113          	add	sp,sp,-32
  FP_UNPACK_SEMIRAW_D (A, a);
80002248:	00b878b3          	and	a7,a6,a1
8000224c:	0145d713          	srl	a4,a1,0x14
80002250:	01d55793          	srl	a5,a0,0x1d
  FP_UNPACK_SEMIRAW_D (B, b);
80002254:	00d87833          	and	a6,a6,a3
{
80002258:	01212823          	sw	s2,16(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
8000225c:	7ff77913          	and	s2,a4,2047
80002260:	00389713          	sll	a4,a7,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
80002264:	0146d893          	srl	a7,a3,0x14
{
80002268:	00912a23          	sw	s1,20(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
8000226c:	00e7e7b3          	or	a5,a5,a4
80002270:	01f5d493          	srl	s1,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
80002274:	01d65713          	srl	a4,a2,0x1d
80002278:	00381813          	sll	a6,a6,0x3
{
8000227c:	00112e23          	sw	ra,28(sp)
80002280:	00812c23          	sw	s0,24(sp)
80002284:	01312623          	sw	s3,12(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
80002288:	7ff8f893          	and	a7,a7,2047
  FP_SUB_D (R, A, B);
8000228c:	7ff00593          	li	a1,2047
  FP_UNPACK_SEMIRAW_D (A, a);
80002290:	00351513          	sll	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
80002294:	01f6d693          	srl	a3,a3,0x1f
80002298:	01076733          	or	a4,a4,a6
8000229c:	00361613          	sll	a2,a2,0x3
  FP_SUB_D (R, A, B);
800022a0:	00b89663          	bne	a7,a1,800022ac <__subdf3+0x70>
800022a4:	00c765b3          	or	a1,a4,a2
800022a8:	00059463          	bnez	a1,800022b0 <__subdf3+0x74>
800022ac:	0016c693          	xor	a3,a3,1
800022b0:	41190833          	sub	a6,s2,a7
800022b4:	2a969a63          	bne	a3,s1,80002568 <__subdf3+0x32c>
800022b8:	11005c63          	blez	a6,800023d0 <__subdf3+0x194>
800022bc:	04089063          	bnez	a7,800022fc <__subdf3+0xc0>
800022c0:	00c766b3          	or	a3,a4,a2
800022c4:	66068063          	beqz	a3,80002924 <__subdf3+0x6e8>
800022c8:	fff80593          	add	a1,a6,-1
800022cc:	02059063          	bnez	a1,800022ec <__subdf3+0xb0>
800022d0:	00c50633          	add	a2,a0,a2
800022d4:	00a636b3          	sltu	a3,a2,a0
800022d8:	00e78733          	add	a4,a5,a4
800022dc:	00060513          	mv	a0,a2
800022e0:	00d707b3          	add	a5,a4,a3
800022e4:	00100913          	li	s2,1
800022e8:	06c0006f          	j	80002354 <__subdf3+0x118>
800022ec:	7ff00693          	li	a3,2047
800022f0:	02d81063          	bne	a6,a3,80002310 <__subdf3+0xd4>
800022f4:	7ff00913          	li	s2,2047
800022f8:	1f80006f          	j	800024f0 <__subdf3+0x2b4>
800022fc:	7ff00693          	li	a3,2047
80002300:	1ed90863          	beq	s2,a3,800024f0 <__subdf3+0x2b4>
80002304:	008006b7          	lui	a3,0x800
80002308:	00d76733          	or	a4,a4,a3
8000230c:	00080593          	mv	a1,a6
80002310:	03800693          	li	a3,56
80002314:	0ab6c863          	blt	a3,a1,800023c4 <__subdf3+0x188>
80002318:	01f00693          	li	a3,31
8000231c:	06b6ca63          	blt	a3,a1,80002390 <__subdf3+0x154>
80002320:	02000813          	li	a6,32
80002324:	40b80833          	sub	a6,a6,a1
80002328:	010716b3          	sll	a3,a4,a6
8000232c:	00b658b3          	srl	a7,a2,a1
80002330:	01061833          	sll	a6,a2,a6
80002334:	0116e6b3          	or	a3,a3,a7
80002338:	01003833          	snez	a6,a6
8000233c:	0106e6b3          	or	a3,a3,a6
80002340:	00b755b3          	srl	a1,a4,a1
80002344:	00a68533          	add	a0,a3,a0
80002348:	00f585b3          	add	a1,a1,a5
8000234c:	00d536b3          	sltu	a3,a0,a3
80002350:	00d587b3          	add	a5,a1,a3
80002354:	00879713          	sll	a4,a5,0x8
80002358:	18075c63          	bgez	a4,800024f0 <__subdf3+0x2b4>
8000235c:	00190913          	add	s2,s2,1
80002360:	7ff00713          	li	a4,2047
80002364:	5ae90a63          	beq	s2,a4,80002918 <__subdf3+0x6dc>
80002368:	ff800737          	lui	a4,0xff800
8000236c:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80002370:	00e7f733          	and	a4,a5,a4
80002374:	00155793          	srl	a5,a0,0x1
80002378:	00157513          	and	a0,a0,1
8000237c:	00a7e7b3          	or	a5,a5,a0
80002380:	01f71513          	sll	a0,a4,0x1f
80002384:	00f56533          	or	a0,a0,a5
80002388:	00175793          	srl	a5,a4,0x1
8000238c:	1640006f          	j	800024f0 <__subdf3+0x2b4>
80002390:	fe058693          	add	a3,a1,-32
80002394:	02000893          	li	a7,32
80002398:	00d756b3          	srl	a3,a4,a3
8000239c:	00000813          	li	a6,0
800023a0:	01158863          	beq	a1,a7,800023b0 <__subdf3+0x174>
800023a4:	04000813          	li	a6,64
800023a8:	40b80833          	sub	a6,a6,a1
800023ac:	01071833          	sll	a6,a4,a6
800023b0:	00c86833          	or	a6,a6,a2
800023b4:	01003833          	snez	a6,a6
800023b8:	0106e6b3          	or	a3,a3,a6
800023bc:	00000593          	li	a1,0
800023c0:	f85ff06f          	j	80002344 <__subdf3+0x108>
800023c4:	00c766b3          	or	a3,a4,a2
800023c8:	00d036b3          	snez	a3,a3
800023cc:	ff1ff06f          	j	800023bc <__subdf3+0x180>
800023d0:	0c080a63          	beqz	a6,800024a4 <__subdf3+0x268>
800023d4:	412886b3          	sub	a3,a7,s2
800023d8:	02091463          	bnez	s2,80002400 <__subdf3+0x1c4>
800023dc:	00a7e5b3          	or	a1,a5,a0
800023e0:	50058e63          	beqz	a1,800028fc <__subdf3+0x6c0>
800023e4:	fff68593          	add	a1,a3,-1 # 7fffff <__stack_size+0x7fbfff>
800023e8:	ee0584e3          	beqz	a1,800022d0 <__subdf3+0x94>
800023ec:	7ff00813          	li	a6,2047
800023f0:	03069263          	bne	a3,a6,80002414 <__subdf3+0x1d8>
800023f4:	00070793          	mv	a5,a4
800023f8:	00060513          	mv	a0,a2
800023fc:	ef9ff06f          	j	800022f4 <__subdf3+0xb8>
80002400:	7ff00593          	li	a1,2047
80002404:	feb888e3          	beq	a7,a1,800023f4 <__subdf3+0x1b8>
80002408:	008005b7          	lui	a1,0x800
8000240c:	00b7e7b3          	or	a5,a5,a1
80002410:	00068593          	mv	a1,a3
80002414:	03800693          	li	a3,56
80002418:	08b6c063          	blt	a3,a1,80002498 <__subdf3+0x25c>
8000241c:	01f00693          	li	a3,31
80002420:	04b6c263          	blt	a3,a1,80002464 <__subdf3+0x228>
80002424:	02000813          	li	a6,32
80002428:	40b80833          	sub	a6,a6,a1
8000242c:	010796b3          	sll	a3,a5,a6
80002430:	00b55333          	srl	t1,a0,a1
80002434:	01051833          	sll	a6,a0,a6
80002438:	0066e6b3          	or	a3,a3,t1
8000243c:	01003833          	snez	a6,a6
80002440:	0106e6b3          	or	a3,a3,a6
80002444:	00b7d5b3          	srl	a1,a5,a1
80002448:	00c68633          	add	a2,a3,a2
8000244c:	00e585b3          	add	a1,a1,a4
80002450:	00d636b3          	sltu	a3,a2,a3
80002454:	00060513          	mv	a0,a2
80002458:	00d587b3          	add	a5,a1,a3
8000245c:	00088913          	mv	s2,a7
80002460:	ef5ff06f          	j	80002354 <__subdf3+0x118>
80002464:	fe058693          	add	a3,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80002468:	02000313          	li	t1,32
8000246c:	00d7d6b3          	srl	a3,a5,a3
80002470:	00000813          	li	a6,0
80002474:	00658863          	beq	a1,t1,80002484 <__subdf3+0x248>
80002478:	04000813          	li	a6,64
8000247c:	40b80833          	sub	a6,a6,a1
80002480:	01079833          	sll	a6,a5,a6
80002484:	00a86833          	or	a6,a6,a0
80002488:	01003833          	snez	a6,a6
8000248c:	0106e6b3          	or	a3,a3,a6
80002490:	00000593          	li	a1,0
80002494:	fb5ff06f          	j	80002448 <__subdf3+0x20c>
80002498:	00a7e6b3          	or	a3,a5,a0
8000249c:	00d036b3          	snez	a3,a3
800024a0:	ff1ff06f          	j	80002490 <__subdf3+0x254>
800024a4:	00190693          	add	a3,s2,1
800024a8:	7fe6f593          	and	a1,a3,2046
800024ac:	08059663          	bnez	a1,80002538 <__subdf3+0x2fc>
800024b0:	00a7e6b3          	or	a3,a5,a0
800024b4:	06091263          	bnez	s2,80002518 <__subdf3+0x2dc>
800024b8:	44068863          	beqz	a3,80002908 <__subdf3+0x6cc>
800024bc:	00c766b3          	or	a3,a4,a2
800024c0:	02068863          	beqz	a3,800024f0 <__subdf3+0x2b4>
800024c4:	00c50633          	add	a2,a0,a2
800024c8:	00a636b3          	sltu	a3,a2,a0
800024cc:	00e78733          	add	a4,a5,a4
800024d0:	00d707b3          	add	a5,a4,a3
800024d4:	00879713          	sll	a4,a5,0x8
800024d8:	00060513          	mv	a0,a2
800024dc:	00075a63          	bgez	a4,800024f0 <__subdf3+0x2b4>
800024e0:	ff800737          	lui	a4,0xff800
800024e4:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
800024e8:	00e7f7b3          	and	a5,a5,a4
800024ec:	00100913          	li	s2,1
  FP_PACK_SEMIRAW_D (r, R);
800024f0:	00757713          	and	a4,a0,7
800024f4:	44070863          	beqz	a4,80002944 <__subdf3+0x708>
800024f8:	00f57713          	and	a4,a0,15
800024fc:	00400693          	li	a3,4
80002500:	44d70263          	beq	a4,a3,80002944 <__subdf3+0x708>
80002504:	00450713          	add	a4,a0,4
80002508:	00a736b3          	sltu	a3,a4,a0
8000250c:	00d787b3          	add	a5,a5,a3
80002510:	00070513          	mv	a0,a4
80002514:	4300006f          	j	80002944 <__subdf3+0x708>
  FP_SUB_D (R, A, B);
80002518:	ec068ee3          	beqz	a3,800023f4 <__subdf3+0x1b8>
8000251c:	00c76633          	or	a2,a4,a2
80002520:	dc060ae3          	beqz	a2,800022f4 <__subdf3+0xb8>
80002524:	00000493          	li	s1,0
80002528:	004007b7          	lui	a5,0x400
8000252c:	00000513          	li	a0,0
80002530:	7ff00913          	li	s2,2047
80002534:	4100006f          	j	80002944 <__subdf3+0x708>
80002538:	7ff00593          	li	a1,2047
8000253c:	3cb68c63          	beq	a3,a1,80002914 <__subdf3+0x6d8>
80002540:	00c50633          	add	a2,a0,a2
80002544:	00a63533          	sltu	a0,a2,a0
80002548:	00e78733          	add	a4,a5,a4
8000254c:	00a70733          	add	a4,a4,a0
80002550:	01f71513          	sll	a0,a4,0x1f
80002554:	00165613          	srl	a2,a2,0x1
80002558:	00c56533          	or	a0,a0,a2
8000255c:	00175793          	srl	a5,a4,0x1
80002560:	00068913          	mv	s2,a3
80002564:	f8dff06f          	j	800024f0 <__subdf3+0x2b4>
80002568:	0f005c63          	blez	a6,80002660 <__subdf3+0x424>
8000256c:	08089e63          	bnez	a7,80002608 <__subdf3+0x3cc>
80002570:	00c766b3          	or	a3,a4,a2
80002574:	3a068863          	beqz	a3,80002924 <__subdf3+0x6e8>
80002578:	fff80693          	add	a3,a6,-1
8000257c:	02069063          	bnez	a3,8000259c <__subdf3+0x360>
80002580:	40c50633          	sub	a2,a0,a2
80002584:	00c536b3          	sltu	a3,a0,a2
80002588:	40e78733          	sub	a4,a5,a4
8000258c:	00060513          	mv	a0,a2
80002590:	40d707b3          	sub	a5,a4,a3
80002594:	00100913          	li	s2,1
80002598:	0540006f          	j	800025ec <__subdf3+0x3b0>
8000259c:	7ff00593          	li	a1,2047
800025a0:	d4b80ae3          	beq	a6,a1,800022f4 <__subdf3+0xb8>
800025a4:	03800593          	li	a1,56
800025a8:	0ad5c663          	blt	a1,a3,80002654 <__subdf3+0x418>
800025ac:	01f00593          	li	a1,31
800025b0:	06d5c863          	blt	a1,a3,80002620 <__subdf3+0x3e4>
800025b4:	02000813          	li	a6,32
800025b8:	40d80833          	sub	a6,a6,a3
800025bc:	00d658b3          	srl	a7,a2,a3
800025c0:	010715b3          	sll	a1,a4,a6
800025c4:	01061833          	sll	a6,a2,a6
800025c8:	0115e5b3          	or	a1,a1,a7
800025cc:	01003833          	snez	a6,a6
800025d0:	0105e633          	or	a2,a1,a6
800025d4:	00d756b3          	srl	a3,a4,a3
800025d8:	40c50633          	sub	a2,a0,a2
800025dc:	00c53733          	sltu	a4,a0,a2
800025e0:	40d786b3          	sub	a3,a5,a3
800025e4:	00060513          	mv	a0,a2
800025e8:	40e687b3          	sub	a5,a3,a4
800025ec:	00879713          	sll	a4,a5,0x8
800025f0:	f00750e3          	bgez	a4,800024f0 <__subdf3+0x2b4>
800025f4:	00800437          	lui	s0,0x800
800025f8:	fff40413          	add	s0,s0,-1 # 7fffff <__stack_size+0x7fbfff>
800025fc:	0087f433          	and	s0,a5,s0
80002600:	00050993          	mv	s3,a0
80002604:	2100006f          	j	80002814 <__subdf3+0x5d8>
80002608:	7ff00693          	li	a3,2047
8000260c:	eed902e3          	beq	s2,a3,800024f0 <__subdf3+0x2b4>
80002610:	008006b7          	lui	a3,0x800
80002614:	00d76733          	or	a4,a4,a3
80002618:	00080693          	mv	a3,a6
8000261c:	f89ff06f          	j	800025a4 <__subdf3+0x368>
80002620:	fe068593          	add	a1,a3,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80002624:	02000893          	li	a7,32
80002628:	00b755b3          	srl	a1,a4,a1
8000262c:	00000813          	li	a6,0
80002630:	01168863          	beq	a3,a7,80002640 <__subdf3+0x404>
80002634:	04000813          	li	a6,64
80002638:	40d80833          	sub	a6,a6,a3
8000263c:	01071833          	sll	a6,a4,a6
80002640:	00c86833          	or	a6,a6,a2
80002644:	01003833          	snez	a6,a6
80002648:	0105e633          	or	a2,a1,a6
8000264c:	00000693          	li	a3,0
80002650:	f89ff06f          	j	800025d8 <__subdf3+0x39c>
80002654:	00c76633          	or	a2,a4,a2
80002658:	00c03633          	snez	a2,a2
8000265c:	ff1ff06f          	j	8000264c <__subdf3+0x410>
80002660:	0e080863          	beqz	a6,80002750 <__subdf3+0x514>
80002664:	41288833          	sub	a6,a7,s2
80002668:	04091263          	bnez	s2,800026ac <__subdf3+0x470>
8000266c:	00a7e5b3          	or	a1,a5,a0
80002670:	2a058e63          	beqz	a1,8000292c <__subdf3+0x6f0>
80002674:	fff80593          	add	a1,a6,-1
80002678:	00059e63          	bnez	a1,80002694 <__subdf3+0x458>
8000267c:	40a60533          	sub	a0,a2,a0
80002680:	40f70733          	sub	a4,a4,a5
80002684:	00a63633          	sltu	a2,a2,a0
80002688:	40c707b3          	sub	a5,a4,a2
8000268c:	00068493          	mv	s1,a3
80002690:	f05ff06f          	j	80002594 <__subdf3+0x358>
80002694:	7ff00313          	li	t1,2047
80002698:	02681463          	bne	a6,t1,800026c0 <__subdf3+0x484>
8000269c:	00070793          	mv	a5,a4
800026a0:	00060513          	mv	a0,a2
800026a4:	7ff00913          	li	s2,2047
800026a8:	0d00006f          	j	80002778 <__subdf3+0x53c>
800026ac:	7ff00593          	li	a1,2047
800026b0:	feb886e3          	beq	a7,a1,8000269c <__subdf3+0x460>
800026b4:	008005b7          	lui	a1,0x800
800026b8:	00b7e7b3          	or	a5,a5,a1
800026bc:	00080593          	mv	a1,a6
800026c0:	03800813          	li	a6,56
800026c4:	08b84063          	blt	a6,a1,80002744 <__subdf3+0x508>
800026c8:	01f00813          	li	a6,31
800026cc:	04b84263          	blt	a6,a1,80002710 <__subdf3+0x4d4>
800026d0:	02000313          	li	t1,32
800026d4:	40b30333          	sub	t1,t1,a1
800026d8:	00b55e33          	srl	t3,a0,a1
800026dc:	00679833          	sll	a6,a5,t1
800026e0:	00651333          	sll	t1,a0,t1
800026e4:	01c86833          	or	a6,a6,t3
800026e8:	00603333          	snez	t1,t1
800026ec:	00686533          	or	a0,a6,t1
800026f0:	00b7d5b3          	srl	a1,a5,a1
800026f4:	40a60533          	sub	a0,a2,a0
800026f8:	40b705b3          	sub	a1,a4,a1
800026fc:	00a63633          	sltu	a2,a2,a0
80002700:	40c587b3          	sub	a5,a1,a2
80002704:	00088913          	mv	s2,a7
80002708:	00068493          	mv	s1,a3
8000270c:	ee1ff06f          	j	800025ec <__subdf3+0x3b0>
80002710:	fe058813          	add	a6,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80002714:	02000e13          	li	t3,32
80002718:	0107d833          	srl	a6,a5,a6
8000271c:	00000313          	li	t1,0
80002720:	01c58863          	beq	a1,t3,80002730 <__subdf3+0x4f4>
80002724:	04000313          	li	t1,64
80002728:	40b30333          	sub	t1,t1,a1
8000272c:	00679333          	sll	t1,a5,t1
80002730:	00a36333          	or	t1,t1,a0
80002734:	00603333          	snez	t1,t1
80002738:	00686533          	or	a0,a6,t1
8000273c:	00000593          	li	a1,0
80002740:	fb5ff06f          	j	800026f4 <__subdf3+0x4b8>
80002744:	00a7e533          	or	a0,a5,a0
80002748:	00a03533          	snez	a0,a0
8000274c:	ff1ff06f          	j	8000273c <__subdf3+0x500>
80002750:	00190593          	add	a1,s2,1
80002754:	7fe5f593          	and	a1,a1,2046
80002758:	08059663          	bnez	a1,800027e4 <__subdf3+0x5a8>
8000275c:	00c765b3          	or	a1,a4,a2
80002760:	00a7e833          	or	a6,a5,a0
80002764:	06091063          	bnez	s2,800027c4 <__subdf3+0x588>
80002768:	00081c63          	bnez	a6,80002780 <__subdf3+0x544>
8000276c:	10058e63          	beqz	a1,80002888 <__subdf3+0x64c>
80002770:	00070793          	mv	a5,a4
80002774:	00060513          	mv	a0,a2
80002778:	00068493          	mv	s1,a3
8000277c:	d75ff06f          	j	800024f0 <__subdf3+0x2b4>
80002780:	d60588e3          	beqz	a1,800024f0 <__subdf3+0x2b4>
80002784:	40c50833          	sub	a6,a0,a2
80002788:	010538b3          	sltu	a7,a0,a6
8000278c:	40e785b3          	sub	a1,a5,a4
80002790:	411585b3          	sub	a1,a1,a7
80002794:	00859893          	sll	a7,a1,0x8
80002798:	0008dc63          	bgez	a7,800027b0 <__subdf3+0x574>
8000279c:	40a60533          	sub	a0,a2,a0
800027a0:	40f70733          	sub	a4,a4,a5
800027a4:	00a63633          	sltu	a2,a2,a0
800027a8:	40c707b3          	sub	a5,a4,a2
800027ac:	fcdff06f          	j	80002778 <__subdf3+0x53c>
800027b0:	00b86533          	or	a0,a6,a1
800027b4:	18050463          	beqz	a0,8000293c <__subdf3+0x700>
800027b8:	00058793          	mv	a5,a1
800027bc:	00080513          	mv	a0,a6
800027c0:	d31ff06f          	j	800024f0 <__subdf3+0x2b4>
800027c4:	00081c63          	bnez	a6,800027dc <__subdf3+0x5a0>
800027c8:	d4058ee3          	beqz	a1,80002524 <__subdf3+0x2e8>
800027cc:	00070793          	mv	a5,a4
800027d0:	00060513          	mv	a0,a2
800027d4:	00068493          	mv	s1,a3
800027d8:	b1dff06f          	j	800022f4 <__subdf3+0xb8>
800027dc:	b0058ce3          	beqz	a1,800022f4 <__subdf3+0xb8>
800027e0:	d45ff06f          	j	80002524 <__subdf3+0x2e8>
800027e4:	40c505b3          	sub	a1,a0,a2
800027e8:	00b53833          	sltu	a6,a0,a1
800027ec:	40e78433          	sub	s0,a5,a4
800027f0:	41040433          	sub	s0,s0,a6
800027f4:	00841813          	sll	a6,s0,0x8
800027f8:	00058993          	mv	s3,a1
800027fc:	08085063          	bgez	a6,8000287c <__subdf3+0x640>
80002800:	40a609b3          	sub	s3,a2,a0
80002804:	40f70433          	sub	s0,a4,a5
80002808:	01363633          	sltu	a2,a2,s3
8000280c:	40c40433          	sub	s0,s0,a2
80002810:	00068493          	mv	s1,a3
80002814:	06040e63          	beqz	s0,80002890 <__subdf3+0x654>
80002818:	00040513          	mv	a0,s0
8000281c:	649000ef          	jal	80003664 <__clzsi2>
80002820:	ff850693          	add	a3,a0,-8
80002824:	02000793          	li	a5,32
80002828:	40d787b3          	sub	a5,a5,a3
8000282c:	00d41433          	sll	s0,s0,a3
80002830:	00f9d7b3          	srl	a5,s3,a5
80002834:	0087e7b3          	or	a5,a5,s0
80002838:	00d99433          	sll	s0,s3,a3
8000283c:	0b26c463          	blt	a3,s2,800028e4 <__subdf3+0x6a8>
80002840:	412686b3          	sub	a3,a3,s2
80002844:	00168613          	add	a2,a3,1
80002848:	01f00713          	li	a4,31
8000284c:	06c74263          	blt	a4,a2,800028b0 <__subdf3+0x674>
80002850:	02000713          	li	a4,32
80002854:	40c70733          	sub	a4,a4,a2
80002858:	00e79533          	sll	a0,a5,a4
8000285c:	00c456b3          	srl	a3,s0,a2
80002860:	00e41733          	sll	a4,s0,a4
80002864:	00d56533          	or	a0,a0,a3
80002868:	00e03733          	snez	a4,a4
8000286c:	00e56533          	or	a0,a0,a4
80002870:	00c7d7b3          	srl	a5,a5,a2
80002874:	00000913          	li	s2,0
80002878:	c79ff06f          	j	800024f0 <__subdf3+0x2b4>
8000287c:	0085e5b3          	or	a1,a1,s0
80002880:	f8059ae3          	bnez	a1,80002814 <__subdf3+0x5d8>
80002884:	00000913          	li	s2,0
80002888:	00000493          	li	s1,0
8000288c:	08c0006f          	j	80002918 <__subdf3+0x6dc>
80002890:	00098513          	mv	a0,s3
80002894:	5d1000ef          	jal	80003664 <__clzsi2>
80002898:	01850693          	add	a3,a0,24
8000289c:	01f00793          	li	a5,31
800028a0:	f8d7d2e3          	bge	a5,a3,80002824 <__subdf3+0x5e8>
800028a4:	ff850793          	add	a5,a0,-8
800028a8:	00f997b3          	sll	a5,s3,a5
800028ac:	f91ff06f          	j	8000283c <__subdf3+0x600>
800028b0:	fe168693          	add	a3,a3,-31
800028b4:	00d7d533          	srl	a0,a5,a3
800028b8:	02000693          	li	a3,32
800028bc:	00000713          	li	a4,0
800028c0:	00d60863          	beq	a2,a3,800028d0 <__subdf3+0x694>
800028c4:	04000713          	li	a4,64
800028c8:	40c70733          	sub	a4,a4,a2
800028cc:	00e79733          	sll	a4,a5,a4
800028d0:	00e46733          	or	a4,s0,a4
800028d4:	00e03733          	snez	a4,a4
800028d8:	00e56533          	or	a0,a0,a4
800028dc:	00000793          	li	a5,0
800028e0:	f95ff06f          	j	80002874 <__subdf3+0x638>
800028e4:	ff800737          	lui	a4,0xff800
800028e8:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
800028ec:	40d90933          	sub	s2,s2,a3
800028f0:	00e7f7b3          	and	a5,a5,a4
800028f4:	00040513          	mv	a0,s0
800028f8:	bf9ff06f          	j	800024f0 <__subdf3+0x2b4>
800028fc:	00070793          	mv	a5,a4
80002900:	00060513          	mv	a0,a2
80002904:	c5dff06f          	j	80002560 <__subdf3+0x324>
80002908:	00070793          	mv	a5,a4
8000290c:	00060513          	mv	a0,a2
80002910:	be1ff06f          	j	800024f0 <__subdf3+0x2b4>
80002914:	7ff00913          	li	s2,2047
80002918:	00000793          	li	a5,0
8000291c:	00000513          	li	a0,0
80002920:	0240006f          	j	80002944 <__subdf3+0x708>
80002924:	00080913          	mv	s2,a6
80002928:	bc9ff06f          	j	800024f0 <__subdf3+0x2b4>
8000292c:	00070793          	mv	a5,a4
80002930:	00060513          	mv	a0,a2
80002934:	00080913          	mv	s2,a6
80002938:	e41ff06f          	j	80002778 <__subdf3+0x53c>
8000293c:	00000793          	li	a5,0
80002940:	00000493          	li	s1,0
  FP_PACK_SEMIRAW_D (r, R);
80002944:	00879713          	sll	a4,a5,0x8
80002948:	00075e63          	bgez	a4,80002964 <__subdf3+0x728>
8000294c:	00190913          	add	s2,s2,1
80002950:	7ff00713          	li	a4,2047
80002954:	08e90263          	beq	s2,a4,800029d8 <__subdf3+0x79c>
80002958:	ff800737          	lui	a4,0xff800
8000295c:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80002960:	00e7f7b3          	and	a5,a5,a4
80002964:	01d79693          	sll	a3,a5,0x1d
80002968:	00355513          	srl	a0,a0,0x3
8000296c:	7ff00713          	li	a4,2047
80002970:	00a6e6b3          	or	a3,a3,a0
80002974:	0037d793          	srl	a5,a5,0x3
80002978:	00e91e63          	bne	s2,a4,80002994 <__subdf3+0x758>
8000297c:	00f6e6b3          	or	a3,a3,a5
80002980:	00000793          	li	a5,0
80002984:	00068863          	beqz	a3,80002994 <__subdf3+0x758>
80002988:	000807b7          	lui	a5,0x80
8000298c:	00000693          	li	a3,0
80002990:	00000493          	li	s1,0
80002994:	01491713          	sll	a4,s2,0x14
80002998:	7ff00637          	lui	a2,0x7ff00
8000299c:	00c79793          	sll	a5,a5,0xc
800029a0:	00c77733          	and	a4,a4,a2
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800029a4:	01c12083          	lw	ra,28(sp)
800029a8:	01812403          	lw	s0,24(sp)
  FP_PACK_SEMIRAW_D (r, R);
800029ac:	00c7d793          	srl	a5,a5,0xc
800029b0:	00f767b3          	or	a5,a4,a5
800029b4:	01f49713          	sll	a4,s1,0x1f
800029b8:	00e7e633          	or	a2,a5,a4
}
800029bc:	01412483          	lw	s1,20(sp)
800029c0:	01012903          	lw	s2,16(sp)
800029c4:	00c12983          	lw	s3,12(sp)
800029c8:	00068513          	mv	a0,a3
800029cc:	00060593          	mv	a1,a2
800029d0:	02010113          	add	sp,sp,32
800029d4:	00008067          	ret
800029d8:	00000793          	li	a5,0
800029dc:	00000513          	li	a0,0
800029e0:	f85ff06f          	j	80002964 <__subdf3+0x728>

800029e4 <__fixdfsi>:
  FP_DECL_EX;
  FP_DECL_D (A);
  USItype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
800029e4:	0145d713          	srl	a4,a1,0x14
800029e8:	001006b7          	lui	a3,0x100
800029ec:	fff68793          	add	a5,a3,-1 # fffff <__stack_size+0xfbfff>
800029f0:	7ff77713          	and	a4,a4,2047
  FP_TO_INT_D (r, A, SI_BITS, 1);
800029f4:	3fe00613          	li	a2,1022
  FP_UNPACK_RAW_D (A, a);
800029f8:	00b7f7b3          	and	a5,a5,a1
800029fc:	01f5d593          	srl	a1,a1,0x1f
  FP_TO_INT_D (r, A, SI_BITS, 1);
80002a00:	04e65e63          	bge	a2,a4,80002a5c <__fixdfsi+0x78>
80002a04:	41d00613          	li	a2,1053
80002a08:	00e65a63          	bge	a2,a4,80002a1c <__fixdfsi+0x38>
80002a0c:	80000537          	lui	a0,0x80000
80002a10:	fff50513          	add	a0,a0,-1 # 7fffffff <__stack_size+0x7fffbfff>
80002a14:	00a58533          	add	a0,a1,a0
80002a18:	00008067          	ret
80002a1c:	00d7e7b3          	or	a5,a5,a3
80002a20:	43300693          	li	a3,1075
80002a24:	40e686b3          	sub	a3,a3,a4
80002a28:	01f00613          	li	a2,31
80002a2c:	02d64063          	blt	a2,a3,80002a4c <__fixdfsi+0x68>
80002a30:	bed70713          	add	a4,a4,-1043
80002a34:	00e797b3          	sll	a5,a5,a4
80002a38:	00d55533          	srl	a0,a0,a3
80002a3c:	00a7e533          	or	a0,a5,a0
80002a40:	02058063          	beqz	a1,80002a60 <__fixdfsi+0x7c>
80002a44:	40a00533          	neg	a0,a0
80002a48:	00008067          	ret
80002a4c:	41300693          	li	a3,1043
80002a50:	40e68733          	sub	a4,a3,a4
80002a54:	00e7d533          	srl	a0,a5,a4
80002a58:	fe9ff06f          	j	80002a40 <__fixdfsi+0x5c>
80002a5c:	00000513          	li	a0,0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80002a60:	00008067          	ret

80002a64 <__fixunsdfsi>:
  FP_DECL_EX;
  FP_DECL_D (A);
  USItype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
80002a64:	0145d713          	srl	a4,a1,0x14
80002a68:	00100837          	lui	a6,0x100
80002a6c:	fff80793          	add	a5,a6,-1 # fffff <__stack_size+0xfbfff>
80002a70:	7ff77713          	and	a4,a4,2047
  FP_TO_INT_D (r, A, SI_BITS, 0);
80002a74:	3fe00613          	li	a2,1022
  FP_UNPACK_RAW_D (A, a);
80002a78:	00b7f7b3          	and	a5,a5,a1
{
80002a7c:	00050693          	mv	a3,a0
  FP_UNPACK_RAW_D (A, a);
80002a80:	01f5d593          	srl	a1,a1,0x1f
  FP_TO_INT_D (r, A, SI_BITS, 0);
80002a84:	04e65a63          	bge	a2,a4,80002ad8 <__fixunsdfsi+0x74>
80002a88:	0015c613          	xor	a2,a1,1
80002a8c:	41e60613          	add	a2,a2,1054 # 7ff0041e <__stack_size+0x7fefc41e>
80002a90:	fff58513          	add	a0,a1,-1
80002a94:	04c75463          	bge	a4,a2,80002adc <__fixunsdfsi+0x78>
80002a98:	00000513          	li	a0,0
80002a9c:	04059063          	bnez	a1,80002adc <__fixunsdfsi+0x78>
80002aa0:	43300613          	li	a2,1075
80002aa4:	40e60633          	sub	a2,a2,a4
80002aa8:	01f00593          	li	a1,31
80002aac:	0107e7b3          	or	a5,a5,a6
80002ab0:	00c5cc63          	blt	a1,a2,80002ac8 <__fixunsdfsi+0x64>
80002ab4:	bed70713          	add	a4,a4,-1043
80002ab8:	00e797b3          	sll	a5,a5,a4
80002abc:	00c6d533          	srl	a0,a3,a2
80002ac0:	00a7e533          	or	a0,a5,a0
80002ac4:	00008067          	ret
80002ac8:	41300693          	li	a3,1043
80002acc:	40e68733          	sub	a4,a3,a4
80002ad0:	00e7d533          	srl	a0,a5,a4
80002ad4:	00008067          	ret
80002ad8:	00000513          	li	a0,0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80002adc:	00008067          	ret

80002ae0 <__floatsidf>:
#include "soft-fp.h"
#include "double.h"

DFtype
__floatsidf (SItype i)
{
80002ae0:	ff010113          	add	sp,sp,-16
80002ae4:	00112623          	sw	ra,12(sp)
80002ae8:	00812423          	sw	s0,8(sp)
80002aec:	00912223          	sw	s1,4(sp)
  FP_DECL_D (A);
  DFtype a;

  FP_FROM_INT_D (A, i, SI_BITS, USItype);
80002af0:	08050663          	beqz	a0,80002b7c <__floatsidf+0x9c>
80002af4:	41f55793          	sra	a5,a0,0x1f
80002af8:	00a7c433          	xor	s0,a5,a0
80002afc:	40f40433          	sub	s0,s0,a5
80002b00:	01f55493          	srl	s1,a0,0x1f
80002b04:	00040513          	mv	a0,s0
80002b08:	35d000ef          	jal	80003664 <__clzsi2>
80002b0c:	41e00713          	li	a4,1054
80002b10:	00a00793          	li	a5,10
80002b14:	40a70733          	sub	a4,a4,a0
80002b18:	04a7c863          	blt	a5,a0,80002b68 <__floatsidf+0x88>
80002b1c:	00b00793          	li	a5,11
80002b20:	40a787b3          	sub	a5,a5,a0
80002b24:	01550513          	add	a0,a0,21
80002b28:	00f457b3          	srl	a5,s0,a5
80002b2c:	00a41433          	sll	s0,s0,a0
80002b30:	00048513          	mv	a0,s1
  FP_PACK_RAW_D (a, A);
80002b34:	00c79793          	sll	a5,a5,0xc
80002b38:	00c7d793          	srl	a5,a5,0xc
80002b3c:	01471713          	sll	a4,a4,0x14
80002b40:	01f51513          	sll	a0,a0,0x1f
80002b44:	00f76733          	or	a4,a4,a5

  return a;
}
80002b48:	00c12083          	lw	ra,12(sp)
  FP_PACK_RAW_D (a, A);
80002b4c:	00a767b3          	or	a5,a4,a0
}
80002b50:	00040513          	mv	a0,s0
80002b54:	00812403          	lw	s0,8(sp)
80002b58:	00412483          	lw	s1,4(sp)
80002b5c:	00078593          	mv	a1,a5
80002b60:	01010113          	add	sp,sp,16
80002b64:	00008067          	ret
  FP_FROM_INT_D (A, i, SI_BITS, USItype);
80002b68:	ff550513          	add	a0,a0,-11
80002b6c:	00a417b3          	sll	a5,s0,a0
80002b70:	00048513          	mv	a0,s1
80002b74:	00000413          	li	s0,0
80002b78:	fbdff06f          	j	80002b34 <__floatsidf+0x54>
80002b7c:	00000713          	li	a4,0
80002b80:	00000793          	li	a5,0
80002b84:	ff1ff06f          	j	80002b74 <__floatsidf+0x94>

80002b88 <__floatunsidf>:
#include "soft-fp.h"
#include "double.h"

DFtype
__floatunsidf (USItype i)
{
80002b88:	ff010113          	add	sp,sp,-16
80002b8c:	00812423          	sw	s0,8(sp)
80002b90:	00112623          	sw	ra,12(sp)
80002b94:	00050413          	mv	s0,a0
  FP_DECL_D (A);
  DFtype a;

  FP_FROM_INT_D (A, i, SI_BITS, USItype);
80002b98:	06050263          	beqz	a0,80002bfc <__floatunsidf+0x74>
80002b9c:	2c9000ef          	jal	80003664 <__clzsi2>
80002ba0:	41e00713          	li	a4,1054
80002ba4:	00a00793          	li	a5,10
80002ba8:	40a70733          	sub	a4,a4,a0
80002bac:	04a7c063          	blt	a5,a0,80002bec <__floatunsidf+0x64>
80002bb0:	00b00793          	li	a5,11
80002bb4:	40a787b3          	sub	a5,a5,a0
80002bb8:	01550513          	add	a0,a0,21
80002bbc:	00f457b3          	srl	a5,s0,a5
80002bc0:	00a41433          	sll	s0,s0,a0
  FP_PACK_RAW_D (a, A);

  return a;
}
80002bc4:	00c12083          	lw	ra,12(sp)
80002bc8:	00040513          	mv	a0,s0
  FP_PACK_RAW_D (a, A);
80002bcc:	00c79793          	sll	a5,a5,0xc
}
80002bd0:	00812403          	lw	s0,8(sp)
  FP_PACK_RAW_D (a, A);
80002bd4:	01471713          	sll	a4,a4,0x14
80002bd8:	00c7d793          	srl	a5,a5,0xc
80002bdc:	00f766b3          	or	a3,a4,a5
}
80002be0:	00068593          	mv	a1,a3
80002be4:	01010113          	add	sp,sp,16
80002be8:	00008067          	ret
  FP_FROM_INT_D (A, i, SI_BITS, USItype);
80002bec:	ff550513          	add	a0,a0,-11
80002bf0:	00a417b3          	sll	a5,s0,a0
80002bf4:	00000413          	li	s0,0
80002bf8:	fcdff06f          	j	80002bc4 <__floatunsidf+0x3c>
80002bfc:	00000793          	li	a5,0
80002c00:	00000713          	li	a4,0
80002c04:	fc1ff06f          	j	80002bc4 <__floatunsidf+0x3c>

80002c08 <__divsf3>:
#include "soft-fp.h"
#include "single.h"

SFtype
__divsf3 (SFtype a, SFtype b)
{
80002c08:	fe010113          	add	sp,sp,-32
80002c0c:	00912a23          	sw	s1,20(sp)
80002c10:	01755493          	srl	s1,a0,0x17
80002c14:	01212823          	sw	s2,16(sp)
80002c18:	01312623          	sw	s3,12(sp)
80002c1c:	01412423          	sw	s4,8(sp)
  FP_DECL_S (B);
  FP_DECL_S (R);
  SFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_S (A, a);
80002c20:	00951993          	sll	s3,a0,0x9
{
80002c24:	00112e23          	sw	ra,28(sp)
80002c28:	00812c23          	sw	s0,24(sp)
80002c2c:	01512223          	sw	s5,4(sp)
80002c30:	0ff4f493          	zext.b	s1,s1
80002c34:	00058a13          	mv	s4,a1
  FP_UNPACK_S (A, a);
80002c38:	0099d993          	srl	s3,s3,0x9
80002c3c:	01f55913          	srl	s2,a0,0x1f
80002c40:	08048463          	beqz	s1,80002cc8 <__divsf3+0xc0>
80002c44:	0ff00793          	li	a5,255
80002c48:	0af48063          	beq	s1,a5,80002ce8 <__divsf3+0xe0>
80002c4c:	00399993          	sll	s3,s3,0x3
80002c50:	040007b7          	lui	a5,0x4000
80002c54:	00f9e9b3          	or	s3,s3,a5
80002c58:	f8148493          	add	s1,s1,-127
80002c5c:	00000a93          	li	s5,0
  FP_UNPACK_S (B, b);
80002c60:	017a5793          	srl	a5,s4,0x17
80002c64:	009a1413          	sll	s0,s4,0x9
80002c68:	0ff7f793          	zext.b	a5,a5
80002c6c:	00945413          	srl	s0,s0,0x9
80002c70:	01fa5a13          	srl	s4,s4,0x1f
80002c74:	08078a63          	beqz	a5,80002d08 <__divsf3+0x100>
80002c78:	0ff00713          	li	a4,255
80002c7c:	0ae78663          	beq	a5,a4,80002d28 <__divsf3+0x120>
80002c80:	00341413          	sll	s0,s0,0x3
80002c84:	04000737          	lui	a4,0x4000
80002c88:	00e46433          	or	s0,s0,a4
80002c8c:	f8178793          	add	a5,a5,-127 # 3ffff81 <__stack_size+0x3ffbf81>
80002c90:	00000713          	li	a4,0
  FP_DIV_S (R, A, B);
80002c94:	40f484b3          	sub	s1,s1,a5
80002c98:	002a9793          	sll	a5,s5,0x2
80002c9c:	00e7e7b3          	or	a5,a5,a4
80002ca0:	fff78793          	add	a5,a5,-1
80002ca4:	00e00613          	li	a2,14
80002ca8:	014946b3          	xor	a3,s2,s4
80002cac:	08f66e63          	bltu	a2,a5,80002d48 <__divsf3+0x140>
80002cb0:	a0000637          	lui	a2,0xa0000
80002cb4:	00279793          	sll	a5,a5,0x2
80002cb8:	03c60613          	add	a2,a2,60 # a000003c <Func_2+0x1fff9cd8>
80002cbc:	00c787b3          	add	a5,a5,a2
80002cc0:	0007a783          	lw	a5,0(a5)
80002cc4:	00078067          	jr	a5
  FP_UNPACK_S (A, a);
80002cc8:	02098a63          	beqz	s3,80002cfc <__divsf3+0xf4>
80002ccc:	00098513          	mv	a0,s3
80002cd0:	195000ef          	jal	80003664 <__clzsi2>
80002cd4:	ffb50793          	add	a5,a0,-5
80002cd8:	f8a00493          	li	s1,-118
80002cdc:	00f999b3          	sll	s3,s3,a5
80002ce0:	40a484b3          	sub	s1,s1,a0
80002ce4:	f79ff06f          	j	80002c5c <__divsf3+0x54>
80002ce8:	0ff00493          	li	s1,255
80002cec:	00200a93          	li	s5,2
80002cf0:	f60988e3          	beqz	s3,80002c60 <__divsf3+0x58>
80002cf4:	00300a93          	li	s5,3
80002cf8:	f69ff06f          	j	80002c60 <__divsf3+0x58>
80002cfc:	00000493          	li	s1,0
80002d00:	00100a93          	li	s5,1
80002d04:	f5dff06f          	j	80002c60 <__divsf3+0x58>
  FP_UNPACK_S (B, b);
80002d08:	02040a63          	beqz	s0,80002d3c <__divsf3+0x134>
80002d0c:	00040513          	mv	a0,s0
80002d10:	155000ef          	jal	80003664 <__clzsi2>
80002d14:	ffb50793          	add	a5,a0,-5
80002d18:	00f41433          	sll	s0,s0,a5
80002d1c:	f8a00793          	li	a5,-118
80002d20:	40a787b3          	sub	a5,a5,a0
80002d24:	f6dff06f          	j	80002c90 <__divsf3+0x88>
80002d28:	0ff00793          	li	a5,255
80002d2c:	00200713          	li	a4,2
80002d30:	f60402e3          	beqz	s0,80002c94 <__divsf3+0x8c>
80002d34:	00300713          	li	a4,3
80002d38:	f5dff06f          	j	80002c94 <__divsf3+0x8c>
80002d3c:	00000793          	li	a5,0
80002d40:	00100713          	li	a4,1
80002d44:	f51ff06f          	j	80002c94 <__divsf3+0x8c>
  FP_DIV_S (R, A, B);
80002d48:	00541613          	sll	a2,s0,0x5
80002d4c:	1289f263          	bgeu	s3,s0,80002e70 <__divsf3+0x268>
80002d50:	fff48493          	add	s1,s1,-1
80002d54:	00000793          	li	a5,0
80002d58:	01065593          	srl	a1,a2,0x10
80002d5c:	02b9d833          	divu	a6,s3,a1
80002d60:	00010737          	lui	a4,0x10
80002d64:	fe070713          	add	a4,a4,-32 # ffe0 <__stack_size+0xbfe0>
80002d68:	00e67733          	and	a4,a2,a4
80002d6c:	0107d793          	srl	a5,a5,0x10
80002d70:	02b9f9b3          	remu	s3,s3,a1
80002d74:	00080413          	mv	s0,a6
80002d78:	03070533          	mul	a0,a4,a6
80002d7c:	01099993          	sll	s3,s3,0x10
80002d80:	0137e7b3          	or	a5,a5,s3
80002d84:	00a7fe63          	bgeu	a5,a0,80002da0 <__divsf3+0x198>
80002d88:	00f607b3          	add	a5,a2,a5
80002d8c:	fff80413          	add	s0,a6,-1
80002d90:	00c7e863          	bltu	a5,a2,80002da0 <__divsf3+0x198>
80002d94:	00a7f663          	bgeu	a5,a0,80002da0 <__divsf3+0x198>
80002d98:	ffe80413          	add	s0,a6,-2
80002d9c:	00c787b3          	add	a5,a5,a2
80002da0:	40a787b3          	sub	a5,a5,a0
80002da4:	02b7d533          	divu	a0,a5,a1
80002da8:	02b7f7b3          	remu	a5,a5,a1
80002dac:	00050593          	mv	a1,a0
80002db0:	02a70733          	mul	a4,a4,a0
80002db4:	01079793          	sll	a5,a5,0x10
80002db8:	02e7f263          	bgeu	a5,a4,80002ddc <__divsf3+0x1d4>
80002dbc:	00c78833          	add	a6,a5,a2
80002dc0:	00f838b3          	sltu	a7,a6,a5
80002dc4:	fff50593          	add	a1,a0,-1
80002dc8:	00080793          	mv	a5,a6
80002dcc:	00089863          	bnez	a7,80002ddc <__divsf3+0x1d4>
80002dd0:	00e87663          	bgeu	a6,a4,80002ddc <__divsf3+0x1d4>
80002dd4:	ffe50593          	add	a1,a0,-2
80002dd8:	00c807b3          	add	a5,a6,a2
80002ddc:	01041413          	sll	s0,s0,0x10
80002de0:	40e787b3          	sub	a5,a5,a4
80002de4:	00b46433          	or	s0,s0,a1
80002de8:	00f037b3          	snez	a5,a5
80002dec:	00f46433          	or	s0,s0,a5
  FP_PACK_S (r, R);
80002df0:	07f48713          	add	a4,s1,127
80002df4:	0ce05863          	blez	a4,80002ec4 <__divsf3+0x2bc>
80002df8:	00747793          	and	a5,s0,7
80002dfc:	00078a63          	beqz	a5,80002e10 <__divsf3+0x208>
80002e00:	00f47793          	and	a5,s0,15
80002e04:	00400613          	li	a2,4
80002e08:	00c78463          	beq	a5,a2,80002e10 <__divsf3+0x208>
80002e0c:	00440413          	add	s0,s0,4
80002e10:	00441793          	sll	a5,s0,0x4
80002e14:	0007da63          	bgez	a5,80002e28 <__divsf3+0x220>
80002e18:	f80007b7          	lui	a5,0xf8000
80002e1c:	fff78793          	add	a5,a5,-1 # f7ffffff <__stack_base+0x57feffff>
80002e20:	00f47433          	and	s0,s0,a5
80002e24:	08048713          	add	a4,s1,128
80002e28:	0fe00793          	li	a5,254
80002e2c:	06e7ca63          	blt	a5,a4,80002ea0 <__divsf3+0x298>
80002e30:	00345793          	srl	a5,s0,0x3
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80002e34:	01c12083          	lw	ra,28(sp)
80002e38:	01812403          	lw	s0,24(sp)
  FP_PACK_S (r, R);
80002e3c:	00979793          	sll	a5,a5,0x9
80002e40:	01771713          	sll	a4,a4,0x17
80002e44:	0097d793          	srl	a5,a5,0x9
80002e48:	00f76733          	or	a4,a4,a5
80002e4c:	01f69513          	sll	a0,a3,0x1f
}
80002e50:	01412483          	lw	s1,20(sp)
80002e54:	01012903          	lw	s2,16(sp)
80002e58:	00c12983          	lw	s3,12(sp)
80002e5c:	00812a03          	lw	s4,8(sp)
80002e60:	00412a83          	lw	s5,4(sp)
80002e64:	00a76533          	or	a0,a4,a0
80002e68:	02010113          	add	sp,sp,32
80002e6c:	00008067          	ret
  FP_DIV_S (R, A, B);
80002e70:	01f99793          	sll	a5,s3,0x1f
80002e74:	0019d993          	srl	s3,s3,0x1
80002e78:	ee1ff06f          	j	80002d58 <__divsf3+0x150>
  FP_UNPACK_S (A, a);
80002e7c:	00090693          	mv	a3,s2
  FP_DIV_S (R, A, B);
80002e80:	00098413          	mv	s0,s3
80002e84:	000a8713          	mv	a4,s5
  FP_PACK_S (r, R);
80002e88:	00300793          	li	a5,3
80002e8c:	08f70663          	beq	a4,a5,80002f18 <__divsf3+0x310>
80002e90:	00100793          	li	a5,1
80002e94:	08f70a63          	beq	a4,a5,80002f28 <__divsf3+0x320>
80002e98:	00200793          	li	a5,2
80002e9c:	f4f71ae3          	bne	a4,a5,80002df0 <__divsf3+0x1e8>
80002ea0:	00000793          	li	a5,0
80002ea4:	0ff00713          	li	a4,255
80002ea8:	f8dff06f          	j	80002e34 <__divsf3+0x22c>
  FP_UNPACK_S (B, b);
80002eac:	000a0693          	mv	a3,s4
  FP_DIV_S (R, A, B);
80002eb0:	fd9ff06f          	j	80002e88 <__divsf3+0x280>
80002eb4:	00400437          	lui	s0,0x400
80002eb8:	00000693          	li	a3,0
80002ebc:	00300713          	li	a4,3
80002ec0:	fc9ff06f          	j	80002e88 <__divsf3+0x280>
  FP_PACK_S (r, R);
80002ec4:	00100793          	li	a5,1
80002ec8:	40e787b3          	sub	a5,a5,a4
80002ecc:	01b00713          	li	a4,27
80002ed0:	04f74c63          	blt	a4,a5,80002f28 <__divsf3+0x320>
80002ed4:	09e48493          	add	s1,s1,158
80002ed8:	00f457b3          	srl	a5,s0,a5
80002edc:	00941433          	sll	s0,s0,s1
80002ee0:	00803433          	snez	s0,s0
80002ee4:	0087e7b3          	or	a5,a5,s0
80002ee8:	0077f713          	and	a4,a5,7
80002eec:	00070a63          	beqz	a4,80002f00 <__divsf3+0x2f8>
80002ef0:	00f7f713          	and	a4,a5,15
80002ef4:	00400613          	li	a2,4
80002ef8:	00c70463          	beq	a4,a2,80002f00 <__divsf3+0x2f8>
80002efc:	00478793          	add	a5,a5,4
80002f00:	00579713          	sll	a4,a5,0x5
80002f04:	0037d793          	srl	a5,a5,0x3
80002f08:	02075263          	bgez	a4,80002f2c <__divsf3+0x324>
80002f0c:	00000793          	li	a5,0
80002f10:	00100713          	li	a4,1
80002f14:	f21ff06f          	j	80002e34 <__divsf3+0x22c>
80002f18:	004007b7          	lui	a5,0x400
80002f1c:	0ff00713          	li	a4,255
80002f20:	00000693          	li	a3,0
80002f24:	f11ff06f          	j	80002e34 <__divsf3+0x22c>
80002f28:	00000793          	li	a5,0
80002f2c:	00000713          	li	a4,0
80002f30:	f05ff06f          	j	80002e34 <__divsf3+0x22c>

80002f34 <__mulsf3>:
#include "soft-fp.h"
#include "single.h"

SFtype
__mulsf3 (SFtype a, SFtype b)
{
80002f34:	fe010113          	add	sp,sp,-32
80002f38:	01212823          	sw	s2,16(sp)
80002f3c:	01755913          	srl	s2,a0,0x17
80002f40:	00912a23          	sw	s1,20(sp)
80002f44:	01312623          	sw	s3,12(sp)
80002f48:	01512223          	sw	s5,4(sp)
  FP_DECL_S (B);
  FP_DECL_S (R);
  SFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_S (A, a);
80002f4c:	00951493          	sll	s1,a0,0x9
{
80002f50:	00112e23          	sw	ra,28(sp)
80002f54:	00812c23          	sw	s0,24(sp)
80002f58:	01412423          	sw	s4,8(sp)
80002f5c:	0ff97913          	zext.b	s2,s2
80002f60:	00058a93          	mv	s5,a1
  FP_UNPACK_S (A, a);
80002f64:	0094d493          	srl	s1,s1,0x9
80002f68:	01f55993          	srl	s3,a0,0x1f
80002f6c:	10090863          	beqz	s2,8000307c <__mulsf3+0x148>
80002f70:	0ff00793          	li	a5,255
80002f74:	12f90463          	beq	s2,a5,8000309c <__mulsf3+0x168>
80002f78:	00349493          	sll	s1,s1,0x3
80002f7c:	040007b7          	lui	a5,0x4000
80002f80:	00f4e4b3          	or	s1,s1,a5
80002f84:	f8190913          	add	s2,s2,-127
80002f88:	00000a13          	li	s4,0
  FP_UNPACK_S (B, b);
80002f8c:	017ad793          	srl	a5,s5,0x17
80002f90:	009a9413          	sll	s0,s5,0x9
80002f94:	0ff7f793          	zext.b	a5,a5
80002f98:	00945413          	srl	s0,s0,0x9
80002f9c:	01fada93          	srl	s5,s5,0x1f
80002fa0:	10078e63          	beqz	a5,800030bc <__mulsf3+0x188>
80002fa4:	0ff00713          	li	a4,255
80002fa8:	12e78a63          	beq	a5,a4,800030dc <__mulsf3+0x1a8>
80002fac:	00341413          	sll	s0,s0,0x3
80002fb0:	04000737          	lui	a4,0x4000
80002fb4:	00e46433          	or	s0,s0,a4
80002fb8:	f8178793          	add	a5,a5,-127 # 3ffff81 <__stack_size+0x3ffbf81>
80002fbc:	00000713          	li	a4,0
  FP_MUL_S (R, A, B);
80002fc0:	00f90933          	add	s2,s2,a5
80002fc4:	002a1793          	sll	a5,s4,0x2
80002fc8:	00e7e7b3          	or	a5,a5,a4
80002fcc:	00a00613          	li	a2,10
80002fd0:	00190693          	add	a3,s2,1
80002fd4:	1ef64263          	blt	a2,a5,800031b8 <__mulsf3+0x284>
80002fd8:	00200613          	li	a2,2
80002fdc:	0159c9b3          	xor	s3,s3,s5
80002fe0:	10f64e63          	blt	a2,a5,800030fc <__mulsf3+0x1c8>
80002fe4:	fff78793          	add	a5,a5,-1
80002fe8:	00100613          	li	a2,1
80002fec:	12f67a63          	bgeu	a2,a5,80003120 <__mulsf3+0x1ec>
80002ff0:	00010837          	lui	a6,0x10
80002ff4:	fff80513          	add	a0,a6,-1 # ffff <__stack_size+0xbfff>
80002ff8:	0104d613          	srl	a2,s1,0x10
80002ffc:	01045793          	srl	a5,s0,0x10
80003000:	00a4f4b3          	and	s1,s1,a0
80003004:	00a47433          	and	s0,s0,a0
80003008:	029405b3          	mul	a1,s0,s1
8000300c:	02860433          	mul	s0,a2,s0
80003010:	02f60633          	mul	a2,a2,a5
80003014:	029787b3          	mul	a5,a5,s1
80003018:	00878733          	add	a4,a5,s0
8000301c:	0105d793          	srl	a5,a1,0x10
80003020:	00e787b3          	add	a5,a5,a4
80003024:	0087f463          	bgeu	a5,s0,8000302c <__mulsf3+0xf8>
80003028:	01060633          	add	a2,a2,a6
8000302c:	00a7f733          	and	a4,a5,a0
80003030:	01071713          	sll	a4,a4,0x10
80003034:	00a5f5b3          	and	a1,a1,a0
80003038:	00b70733          	add	a4,a4,a1
8000303c:	0107d793          	srl	a5,a5,0x10
80003040:	00671413          	sll	s0,a4,0x6
80003044:	00c787b3          	add	a5,a5,a2
80003048:	01a75713          	srl	a4,a4,0x1a
8000304c:	00679793          	sll	a5,a5,0x6
80003050:	00803433          	snez	s0,s0
80003054:	00e46433          	or	s0,s0,a4
80003058:	00479713          	sll	a4,a5,0x4
8000305c:	0087e433          	or	s0,a5,s0
80003060:	00075a63          	bgez	a4,80003074 <__mulsf3+0x140>
80003064:	00145793          	srl	a5,s0,0x1
80003068:	00147413          	and	s0,s0,1
8000306c:	0087e433          	or	s0,a5,s0
80003070:	00068913          	mv	s2,a3
80003074:	00090693          	mv	a3,s2
80003078:	0c00006f          	j	80003138 <__mulsf3+0x204>
  FP_UNPACK_S (A, a);
8000307c:	02048a63          	beqz	s1,800030b0 <__mulsf3+0x17c>
80003080:	00048513          	mv	a0,s1
80003084:	5e0000ef          	jal	80003664 <__clzsi2>
80003088:	ffb50793          	add	a5,a0,-5
8000308c:	f8a00913          	li	s2,-118
80003090:	00f494b3          	sll	s1,s1,a5
80003094:	40a90933          	sub	s2,s2,a0
80003098:	ef1ff06f          	j	80002f88 <__mulsf3+0x54>
8000309c:	0ff00913          	li	s2,255
800030a0:	00200a13          	li	s4,2
800030a4:	ee0484e3          	beqz	s1,80002f8c <__mulsf3+0x58>
800030a8:	00300a13          	li	s4,3
800030ac:	ee1ff06f          	j	80002f8c <__mulsf3+0x58>
800030b0:	00000913          	li	s2,0
800030b4:	00100a13          	li	s4,1
800030b8:	ed5ff06f          	j	80002f8c <__mulsf3+0x58>
  FP_UNPACK_S (B, b);
800030bc:	02040a63          	beqz	s0,800030f0 <__mulsf3+0x1bc>
800030c0:	00040513          	mv	a0,s0
800030c4:	5a0000ef          	jal	80003664 <__clzsi2>
800030c8:	ffb50793          	add	a5,a0,-5
800030cc:	00f41433          	sll	s0,s0,a5
800030d0:	f8a00793          	li	a5,-118
800030d4:	40a787b3          	sub	a5,a5,a0
800030d8:	ee5ff06f          	j	80002fbc <__mulsf3+0x88>
800030dc:	0ff00793          	li	a5,255
800030e0:	00200713          	li	a4,2
800030e4:	ec040ee3          	beqz	s0,80002fc0 <__mulsf3+0x8c>
800030e8:	00300713          	li	a4,3
800030ec:	ed5ff06f          	j	80002fc0 <__mulsf3+0x8c>
800030f0:	00000793          	li	a5,0
800030f4:	00100713          	li	a4,1
800030f8:	ec9ff06f          	j	80002fc0 <__mulsf3+0x8c>
800030fc:	00100613          	li	a2,1
80003100:	00f617b3          	sll	a5,a2,a5
  FP_MUL_S (R, A, B);
80003104:	5307f613          	and	a2,a5,1328
80003108:	0c061063          	bnez	a2,800031c8 <__mulsf3+0x294>
8000310c:	2407f613          	and	a2,a5,576
80003110:	12061263          	bnez	a2,80003234 <__mulsf3+0x300>
80003114:	0887f793          	and	a5,a5,136
80003118:	ec078ce3          	beqz	a5,80002ff0 <__mulsf3+0xbc>
  FP_UNPACK_S (B, b);
8000311c:	000a8993          	mv	s3,s5
  FP_PACK_S (r, R);
80003120:	00200793          	li	a5,2
80003124:	10f70263          	beq	a4,a5,80003228 <__mulsf3+0x2f4>
80003128:	00300793          	li	a5,3
8000312c:	10f70463          	beq	a4,a5,80003234 <__mulsf3+0x300>
80003130:	00100793          	li	a5,1
80003134:	10f70863          	beq	a4,a5,80003244 <__mulsf3+0x310>
80003138:	07f68713          	add	a4,a3,127
8000313c:	08e05c63          	blez	a4,800031d4 <__mulsf3+0x2a0>
80003140:	00747793          	and	a5,s0,7
80003144:	00078a63          	beqz	a5,80003158 <__mulsf3+0x224>
80003148:	00f47793          	and	a5,s0,15
8000314c:	00400613          	li	a2,4
80003150:	00c78463          	beq	a5,a2,80003158 <__mulsf3+0x224>
80003154:	00440413          	add	s0,s0,4 # 400004 <__stack_size+0x3fc004>
80003158:	00441793          	sll	a5,s0,0x4
8000315c:	0007da63          	bgez	a5,80003170 <__mulsf3+0x23c>
80003160:	f80007b7          	lui	a5,0xf8000
80003164:	fff78793          	add	a5,a5,-1 # f7ffffff <__stack_base+0x57feffff>
80003168:	00f47433          	and	s0,s0,a5
8000316c:	08068713          	add	a4,a3,128
80003170:	0fe00793          	li	a5,254
80003174:	0ae7ca63          	blt	a5,a4,80003228 <__mulsf3+0x2f4>
80003178:	00345793          	srl	a5,s0,0x3
  FP_HANDLE_EXCEPTIONS;

  return r;
}
8000317c:	01c12083          	lw	ra,28(sp)
80003180:	01812403          	lw	s0,24(sp)
  FP_PACK_S (r, R);
80003184:	00979793          	sll	a5,a5,0x9
80003188:	01771513          	sll	a0,a4,0x17
8000318c:	0097d793          	srl	a5,a5,0x9
80003190:	01f99993          	sll	s3,s3,0x1f
80003194:	00f56533          	or	a0,a0,a5
}
80003198:	01412483          	lw	s1,20(sp)
8000319c:	01012903          	lw	s2,16(sp)
800031a0:	00812a03          	lw	s4,8(sp)
800031a4:	00412a83          	lw	s5,4(sp)
  FP_PACK_S (r, R);
800031a8:	01356533          	or	a0,a0,s3
}
800031ac:	00c12983          	lw	s3,12(sp)
800031b0:	02010113          	add	sp,sp,32
800031b4:	00008067          	ret
  FP_MUL_S (R, A, B);
800031b8:	00f00613          	li	a2,15
800031bc:	06c78c63          	beq	a5,a2,80003234 <__mulsf3+0x300>
800031c0:	00b00613          	li	a2,11
800031c4:	f4c78ce3          	beq	a5,a2,8000311c <__mulsf3+0x1e8>
800031c8:	00048413          	mv	s0,s1
800031cc:	000a0713          	mv	a4,s4
800031d0:	f51ff06f          	j	80003120 <__mulsf3+0x1ec>
  FP_PACK_S (r, R);
800031d4:	00100793          	li	a5,1
800031d8:	40e787b3          	sub	a5,a5,a4
800031dc:	01b00713          	li	a4,27
800031e0:	06f74263          	blt	a4,a5,80003244 <__mulsf3+0x310>
800031e4:	09e68693          	add	a3,a3,158
800031e8:	00d416b3          	sll	a3,s0,a3
800031ec:	00f457b3          	srl	a5,s0,a5
800031f0:	00d036b3          	snez	a3,a3
800031f4:	00d7e7b3          	or	a5,a5,a3
800031f8:	0077f713          	and	a4,a5,7
800031fc:	00070a63          	beqz	a4,80003210 <__mulsf3+0x2dc>
80003200:	00f7f713          	and	a4,a5,15
80003204:	00400693          	li	a3,4
80003208:	00d70463          	beq	a4,a3,80003210 <__mulsf3+0x2dc>
8000320c:	00478793          	add	a5,a5,4
80003210:	00579713          	sll	a4,a5,0x5
80003214:	0037d793          	srl	a5,a5,0x3
80003218:	02075863          	bgez	a4,80003248 <__mulsf3+0x314>
8000321c:	00000793          	li	a5,0
80003220:	00100713          	li	a4,1
80003224:	f59ff06f          	j	8000317c <__mulsf3+0x248>
80003228:	00000793          	li	a5,0
8000322c:	0ff00713          	li	a4,255
80003230:	f4dff06f          	j	8000317c <__mulsf3+0x248>
80003234:	004007b7          	lui	a5,0x400
80003238:	0ff00713          	li	a4,255
8000323c:	00000993          	li	s3,0
80003240:	f3dff06f          	j	8000317c <__mulsf3+0x248>
80003244:	00000793          	li	a5,0
80003248:	00000713          	li	a4,0
8000324c:	f31ff06f          	j	8000317c <__mulsf3+0x248>

80003250 <__floatunsisf>:
#include "soft-fp.h"
#include "single.h"

SFtype
__floatunsisf (USItype i)
{
80003250:	ff010113          	add	sp,sp,-16
80003254:	00812423          	sw	s0,8(sp)
80003258:	00112623          	sw	ra,12(sp)
8000325c:	00050413          	mv	s0,a0
  FP_DECL_EX;
  FP_DECL_S (A);
  SFtype a;

  FP_INIT_ROUNDMODE;
  FP_FROM_INT_S (A, i, SI_BITS, USItype);
80003260:	00000713          	li	a4,0
80003264:	02050463          	beqz	a0,8000328c <__floatunsisf+0x3c>
80003268:	3fc000ef          	jal	80003664 <__clzsi2>
8000326c:	09e00713          	li	a4,158
80003270:	40a70733          	sub	a4,a4,a0
80003274:	09600793          	li	a5,150
80003278:	02e7ca63          	blt	a5,a4,800032ac <__floatunsisf+0x5c>
8000327c:	00800793          	li	a5,8
80003280:	0af50263          	beq	a0,a5,80003324 <__floatunsisf+0xd4>
80003284:	ff850513          	add	a0,a0,-8
80003288:	00a41433          	sll	s0,s0,a0
  FP_PACK_RAW_S (a, A);
8000328c:	00941413          	sll	s0,s0,0x9
80003290:	00945413          	srl	s0,s0,0x9
80003294:	01771513          	sll	a0,a4,0x17
  FP_HANDLE_EXCEPTIONS;

  return a;
}
80003298:	00c12083          	lw	ra,12(sp)
8000329c:	00856533          	or	a0,a0,s0
800032a0:	00812403          	lw	s0,8(sp)
800032a4:	01010113          	add	sp,sp,16
800032a8:	00008067          	ret
  FP_FROM_INT_S (A, i, SI_BITS, USItype);
800032ac:	09900793          	li	a5,153
800032b0:	06e7d463          	bge	a5,a4,80003318 <__floatunsisf+0xc8>
800032b4:	01b50793          	add	a5,a0,27
800032b8:	00500693          	li	a3,5
800032bc:	00f417b3          	sll	a5,s0,a5
800032c0:	40a686b3          	sub	a3,a3,a0
800032c4:	00f037b3          	snez	a5,a5
800032c8:	00d45433          	srl	s0,s0,a3
800032cc:	0087e7b3          	or	a5,a5,s0
800032d0:	fc000437          	lui	s0,0xfc000
800032d4:	fff40413          	add	s0,s0,-1 # fbffffff <__stack_base+0x5bfeffff>
800032d8:	0077f693          	and	a3,a5,7
800032dc:	0087f433          	and	s0,a5,s0
800032e0:	00068a63          	beqz	a3,800032f4 <__floatunsisf+0xa4>
800032e4:	00f7f793          	and	a5,a5,15
800032e8:	00400693          	li	a3,4
800032ec:	00d78463          	beq	a5,a3,800032f4 <__floatunsisf+0xa4>
800032f0:	00440413          	add	s0,s0,4
800032f4:	00541793          	sll	a5,s0,0x5
800032f8:	0007dc63          	bgez	a5,80003310 <__floatunsisf+0xc0>
800032fc:	fc0007b7          	lui	a5,0xfc000
80003300:	fff78793          	add	a5,a5,-1 # fbffffff <__stack_base+0x5bfeffff>
80003304:	09f00713          	li	a4,159
80003308:	00f47433          	and	s0,s0,a5
8000330c:	40a70733          	sub	a4,a4,a0
80003310:	00345413          	srl	s0,s0,0x3
80003314:	f79ff06f          	j	8000328c <__floatunsisf+0x3c>
80003318:	ffb50793          	add	a5,a0,-5
8000331c:	00f417b3          	sll	a5,s0,a5
80003320:	fb1ff06f          	j	800032d0 <__floatunsisf+0x80>
80003324:	09600713          	li	a4,150
80003328:	f65ff06f          	j	8000328c <__floatunsisf+0x3c>

8000332c <__floatundisf>:
#include "soft-fp.h"
#include "single.h"

SFtype
__floatundisf (UDItype i)
{
8000332c:	fe010113          	add	sp,sp,-32
80003330:	00112e23          	sw	ra,28(sp)
80003334:	00812c23          	sw	s0,24(sp)
80003338:	00912a23          	sw	s1,20(sp)
8000333c:	01212823          	sw	s2,16(sp)
80003340:	01312623          	sw	s3,12(sp)
80003344:	01412423          	sw	s4,8(sp)
  FP_DECL_EX;
  FP_DECL_S (A);
  SFtype a;

  FP_INIT_ROUNDMODE;
  FP_FROM_INT_S (A, i, DI_BITS, UDItype);
80003348:	00b567b3          	or	a5,a0,a1
8000334c:	10078263          	beqz	a5,80003450 <__floatundisf+0x124>
80003350:	00050413          	mv	s0,a0
80003354:	00058a13          	mv	s4,a1
80003358:	06058063          	beqz	a1,800033b8 <__floatundisf+0x8c>
8000335c:	00058513          	mv	a0,a1
80003360:	304000ef          	jal	80003664 <__clzsi2>
80003364:	00050493          	mv	s1,a0
80003368:	0be00993          	li	s3,190
8000336c:	409989b3          	sub	s3,s3,s1
80003370:	09600793          	li	a5,150
80003374:	0537c863          	blt	a5,s3,800033c4 <__floatundisf+0x98>
80003378:	02800793          	li	a5,40
8000337c:	0ef48063          	beq	s1,a5,8000345c <__floatundisf+0x130>
80003380:	fd848493          	add	s1,s1,-40
80003384:	00941433          	sll	s0,s0,s1
  FP_PACK_RAW_S (a, A);
80003388:	00941413          	sll	s0,s0,0x9
8000338c:	01799513          	sll	a0,s3,0x17
80003390:	00945413          	srl	s0,s0,0x9
  FP_HANDLE_EXCEPTIONS;

  return a;
}
80003394:	01c12083          	lw	ra,28(sp)
80003398:	00856533          	or	a0,a0,s0
8000339c:	01812403          	lw	s0,24(sp)
800033a0:	01412483          	lw	s1,20(sp)
800033a4:	01012903          	lw	s2,16(sp)
800033a8:	00c12983          	lw	s3,12(sp)
800033ac:	00812a03          	lw	s4,8(sp)
800033b0:	02010113          	add	sp,sp,32
800033b4:	00008067          	ret
  FP_FROM_INT_S (A, i, DI_BITS, UDItype);
800033b8:	2ac000ef          	jal	80003664 <__clzsi2>
800033bc:	02050493          	add	s1,a0,32
800033c0:	fa9ff06f          	j	80003368 <__floatundisf+0x3c>
800033c4:	09900793          	li	a5,153
800033c8:	0737de63          	bge	a5,s3,80003444 <__floatundisf+0x118>
800033cc:	01b48613          	add	a2,s1,27
800033d0:	00040513          	mv	a0,s0
800033d4:	000a0593          	mv	a1,s4
800033d8:	254000ef          	jal	8000362c <__ashldi3>
800033dc:	00b56533          	or	a0,a0,a1
800033e0:	02500613          	li	a2,37
800033e4:	00a03933          	snez	s2,a0
800033e8:	40960633          	sub	a2,a2,s1
800033ec:	00040513          	mv	a0,s0
800033f0:	000a0593          	mv	a1,s4
800033f4:	200000ef          	jal	800035f4 <__lshrdi3>
800033f8:	00a96533          	or	a0,s2,a0
800033fc:	fc0007b7          	lui	a5,0xfc000
80003400:	fff78793          	add	a5,a5,-1 # fbffffff <__stack_base+0x5bfeffff>
80003404:	00757713          	and	a4,a0,7
80003408:	00f577b3          	and	a5,a0,a5
8000340c:	00070a63          	beqz	a4,80003420 <__floatundisf+0xf4>
80003410:	00f57513          	and	a0,a0,15
80003414:	00400713          	li	a4,4
80003418:	00e50463          	beq	a0,a4,80003420 <__floatundisf+0xf4>
8000341c:	00478793          	add	a5,a5,4
80003420:	00579713          	sll	a4,a5,0x5
80003424:	00075c63          	bgez	a4,8000343c <__floatundisf+0x110>
80003428:	fc000737          	lui	a4,0xfc000
8000342c:	fff70713          	add	a4,a4,-1 # fbffffff <__stack_base+0x5bfeffff>
80003430:	0bf00993          	li	s3,191
80003434:	00e7f7b3          	and	a5,a5,a4
80003438:	409989b3          	sub	s3,s3,s1
8000343c:	0037d413          	srl	s0,a5,0x3
80003440:	f49ff06f          	j	80003388 <__floatundisf+0x5c>
80003444:	fdb48513          	add	a0,s1,-37
80003448:	00a41533          	sll	a0,s0,a0
8000344c:	fb1ff06f          	j	800033fc <__floatundisf+0xd0>
80003450:	00000413          	li	s0,0
80003454:	00000993          	li	s3,0
80003458:	f31ff06f          	j	80003388 <__floatundisf+0x5c>
8000345c:	09600993          	li	s3,150
80003460:	f29ff06f          	j	80003388 <__floatundisf+0x5c>

80003464 <__extendsfdf2>:
  FP_DECL_S (A);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_S (A, a);
80003464:	01755713          	srl	a4,a0,0x17
80003468:	0ff77713          	zext.b	a4,a4
{
8000346c:	ff010113          	add	sp,sp,-16
#if _FP_W_TYPE_SIZE < _FP_FRACBITS_D
  FP_EXTEND (D, S, 2, 1, R, A);
80003470:	00170793          	add	a5,a4,1
{
80003474:	00812423          	sw	s0,8(sp)
80003478:	00912223          	sw	s1,4(sp)
  FP_UNPACK_RAW_S (A, a);
8000347c:	00951413          	sll	s0,a0,0x9
{
80003480:	00112623          	sw	ra,12(sp)
  FP_EXTEND (D, S, 2, 1, R, A);
80003484:	0fe7f793          	and	a5,a5,254
  FP_UNPACK_RAW_S (A, a);
80003488:	00945413          	srl	s0,s0,0x9
8000348c:	01f55493          	srl	s1,a0,0x1f
  FP_EXTEND (D, S, 2, 1, R, A);
80003490:	04078263          	beqz	a5,800034d4 <__extendsfdf2+0x70>
80003494:	00345793          	srl	a5,s0,0x3
80003498:	38070713          	add	a4,a4,896
8000349c:	01d41413          	sll	s0,s0,0x1d
#else
  FP_EXTEND (D, S, 1, 1, R, A);
#endif
  FP_PACK_RAW_D (r, R);
800034a0:	00c79793          	sll	a5,a5,0xc
800034a4:	00c7d793          	srl	a5,a5,0xc
800034a8:	01471713          	sll	a4,a4,0x14
800034ac:	01f49513          	sll	a0,s1,0x1f
800034b0:	00f76733          	or	a4,a4,a5
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800034b4:	00c12083          	lw	ra,12(sp)
  FP_PACK_RAW_D (r, R);
800034b8:	00a767b3          	or	a5,a4,a0
}
800034bc:	00040513          	mv	a0,s0
800034c0:	00812403          	lw	s0,8(sp)
800034c4:	00412483          	lw	s1,4(sp)
800034c8:	00078593          	mv	a1,a5
800034cc:	01010113          	add	sp,sp,16
800034d0:	00008067          	ret
  FP_EXTEND (D, S, 2, 1, R, A);
800034d4:	04071663          	bnez	a4,80003520 <__extendsfdf2+0xbc>
800034d8:	00000793          	li	a5,0
800034dc:	fc0402e3          	beqz	s0,800034a0 <__extendsfdf2+0x3c>
800034e0:	00040513          	mv	a0,s0
800034e4:	180000ef          	jal	80003664 <__clzsi2>
800034e8:	00a00793          	li	a5,10
800034ec:	02a7c263          	blt	a5,a0,80003510 <__extendsfdf2+0xac>
800034f0:	00b00793          	li	a5,11
800034f4:	40a787b3          	sub	a5,a5,a0
800034f8:	01550713          	add	a4,a0,21
800034fc:	00f457b3          	srl	a5,s0,a5
80003500:	00e41433          	sll	s0,s0,a4
80003504:	38900713          	li	a4,905
80003508:	40a70733          	sub	a4,a4,a0
8000350c:	f95ff06f          	j	800034a0 <__extendsfdf2+0x3c>
80003510:	ff550793          	add	a5,a0,-11
80003514:	00f417b3          	sll	a5,s0,a5
80003518:	00000413          	li	s0,0
8000351c:	fe9ff06f          	j	80003504 <__extendsfdf2+0xa0>
80003520:	00000793          	li	a5,0
80003524:	00040a63          	beqz	s0,80003538 <__extendsfdf2+0xd4>
80003528:	00345793          	srl	a5,s0,0x3
8000352c:	00080737          	lui	a4,0x80
80003530:	01d41413          	sll	s0,s0,0x1d
80003534:	00e7e7b3          	or	a5,a5,a4
80003538:	7ff00713          	li	a4,2047
8000353c:	f65ff06f          	j	800034a0 <__extendsfdf2+0x3c>

80003540 <__divsi3>:
  li    t0, -1
  beq   a1, t0, .L20
#endif

FUNC_BEGIN (__divdi3)
  bltz  a0, .L10
80003540:	06054063          	bltz	a0,800035a0 <__umodsi3+0x10>
  bltz  a1, .L11
80003544:	0605c663          	bltz	a1,800035b0 <__umodsi3+0x20>

80003548 <__hidden___udivsi3>:
  /* Since the quotient is positive, fall into __udivdi3.  */

FUNC_BEGIN (__udivdi3)
  mv    a2, a1
80003548:	00058613          	mv	a2,a1
  mv    a1, a0
8000354c:	00050593          	mv	a1,a0
  li    a0, -1
80003550:	fff00513          	li	a0,-1
  beqz  a2, .L5
80003554:	02060c63          	beqz	a2,8000358c <__hidden___udivsi3+0x44>
  li    a3, 1
80003558:	00100693          	li	a3,1
  bgeu  a2, a1, .L2
8000355c:	00b67a63          	bgeu	a2,a1,80003570 <__hidden___udivsi3+0x28>
.L1:
  blez  a2, .L2
80003560:	00c05863          	blez	a2,80003570 <__hidden___udivsi3+0x28>
  slli  a2, a2, 1
80003564:	00161613          	sll	a2,a2,0x1
  slli  a3, a3, 1
80003568:	00169693          	sll	a3,a3,0x1
  bgtu  a1, a2, .L1
8000356c:	feb66ae3          	bltu	a2,a1,80003560 <__hidden___udivsi3+0x18>
.L2:
  li    a0, 0
80003570:	00000513          	li	a0,0
.L3:
  bltu  a1, a2, .L4
80003574:	00c5e663          	bltu	a1,a2,80003580 <__hidden___udivsi3+0x38>
  sub   a1, a1, a2
80003578:	40c585b3          	sub	a1,a1,a2
  or    a0, a0, a3
8000357c:	00d56533          	or	a0,a0,a3
.L4:
  srli  a3, a3, 1
80003580:	0016d693          	srl	a3,a3,0x1
  srli  a2, a2, 1
80003584:	00165613          	srl	a2,a2,0x1
  bnez  a3, .L3
80003588:	fe0696e3          	bnez	a3,80003574 <__hidden___udivsi3+0x2c>
.L5:
  ret
8000358c:	00008067          	ret

80003590 <__umodsi3>:
FUNC_END (__udivdi3)
HIDDEN_DEF (__udivdi3)

FUNC_BEGIN (__umoddi3)
  /* Call __udivdi3(a0, a1), then return the remainder, which is in a1.  */
  move  t0, ra
80003590:	00008293          	mv	t0,ra
  jal   HIDDEN_JUMPTARGET(__udivdi3)
80003594:	fb5ff0ef          	jal	80003548 <__hidden___udivsi3>
  move  a0, a1
80003598:	00058513          	mv	a0,a1
  jr    t0
8000359c:	00028067          	jr	t0
FUNC_END (__umoddi3)

  /* Handle negative arguments to __divdi3.  */
.L10:
  neg   a0, a0
800035a0:	40a00533          	neg	a0,a0
  /* Zero is handled as a negative so that the result will not be inverted.  */
  bgtz  a1, .L12     /* Compute __udivdi3(-a0, a1), then negate the result.  */
800035a4:	00b04863          	bgtz	a1,800035b4 <__umodsi3+0x24>

  neg   a1, a1
800035a8:	40b005b3          	neg	a1,a1
  j     HIDDEN_JUMPTARGET(__udivdi3)     /* Compute __udivdi3(-a0, -a1).  */
800035ac:	f9dff06f          	j	80003548 <__hidden___udivsi3>
.L11:                /* Compute __udivdi3(a0, -a1), then negate the result.  */
  neg   a1, a1
800035b0:	40b005b3          	neg	a1,a1
.L12:
  move  t0, ra
800035b4:	00008293          	mv	t0,ra
  jal   HIDDEN_JUMPTARGET(__udivdi3)
800035b8:	f91ff0ef          	jal	80003548 <__hidden___udivsi3>
  neg   a0, a0
800035bc:	40a00533          	neg	a0,a0
  jr    t0
800035c0:	00028067          	jr	t0

800035c4 <__modsi3>:
FUNC_END (__divdi3)

FUNC_BEGIN (__moddi3)
  move   t0, ra
800035c4:	00008293          	mv	t0,ra
  bltz   a1, .L31
800035c8:	0005ca63          	bltz	a1,800035dc <__modsi3+0x18>
  bltz   a0, .L32
800035cc:	00054c63          	bltz	a0,800035e4 <__modsi3+0x20>
.L30:
  jal    HIDDEN_JUMPTARGET(__udivdi3)    /* The dividend is not negative.  */
800035d0:	f79ff0ef          	jal	80003548 <__hidden___udivsi3>
  move   a0, a1
800035d4:	00058513          	mv	a0,a1
  jr     t0
800035d8:	00028067          	jr	t0
.L31:
  neg    a1, a1
800035dc:	40b005b3          	neg	a1,a1
  bgez   a0, .L30
800035e0:	fe0558e3          	bgez	a0,800035d0 <__modsi3+0xc>
.L32:
  neg    a0, a0
800035e4:	40a00533          	neg	a0,a0
  jal    HIDDEN_JUMPTARGET(__udivdi3)    /* The dividend is hella negative.  */
800035e8:	f61ff0ef          	jal	80003548 <__hidden___udivsi3>
  neg    a0, a1
800035ec:	40b00533          	neg	a0,a1
  jr     t0
800035f0:	00028067          	jr	t0

800035f4 <__lshrdi3>:
  if (b == 0)
800035f4:	02060063          	beqz	a2,80003614 <__lshrdi3+0x20>
  const shift_count_type bm = W_TYPE_SIZE - b;
800035f8:	02000793          	li	a5,32
800035fc:	40c787b3          	sub	a5,a5,a2
  if (bm <= 0)
80003600:	00f04c63          	bgtz	a5,80003618 <__lshrdi3+0x24>
      w.s.low = (UWtype) uu.s.high >> -bm;
80003604:	fe060613          	add	a2,a2,-32
80003608:	00c5d533          	srl	a0,a1,a2
8000360c:	00000713          	li	a4,0
  return w.ll;
80003610:	00070593          	mv	a1,a4
}
80003614:	00008067          	ret
      w.s.high = (UWtype) uu.s.high >> b;
80003618:	00c5d733          	srl	a4,a1,a2
      w.s.low = ((UWtype) uu.s.low >> b) | carries;
8000361c:	00c55533          	srl	a0,a0,a2
      const UWtype carries = (UWtype) uu.s.high << bm;
80003620:	00f595b3          	sll	a1,a1,a5
      w.s.low = ((UWtype) uu.s.low >> b) | carries;
80003624:	00b56533          	or	a0,a0,a1
80003628:	fe9ff06f          	j	80003610 <__lshrdi3+0x1c>

8000362c <__ashldi3>:
  if (b == 0)
8000362c:	02060063          	beqz	a2,8000364c <__ashldi3+0x20>
  const shift_count_type bm = W_TYPE_SIZE - b;
80003630:	02000793          	li	a5,32
80003634:	40c787b3          	sub	a5,a5,a2
  if (bm <= 0)
80003638:	00f04c63          	bgtz	a5,80003650 <__ashldi3+0x24>
      w.s.high = (UWtype) uu.s.low << -bm;
8000363c:	fe060613          	add	a2,a2,-32
80003640:	00c515b3          	sll	a1,a0,a2
80003644:	00000713          	li	a4,0
  return w.ll;
80003648:	00070513          	mv	a0,a4
}
8000364c:	00008067          	ret
      w.s.low = (UWtype) uu.s.low << b;
80003650:	00c51733          	sll	a4,a0,a2
      w.s.high = ((UWtype) uu.s.high << b) | carries;
80003654:	00c595b3          	sll	a1,a1,a2
      const UWtype carries = (UWtype) uu.s.low >> bm;
80003658:	00f55533          	srl	a0,a0,a5
      w.s.high = ((UWtype) uu.s.high << b) | carries;
8000365c:	00a5e5b3          	or	a1,a1,a0
80003660:	fe9ff06f          	j	80003648 <__ashldi3+0x1c>

80003664 <__clzsi2>:
  count_leading_zeros (ret, x);
80003664:	000107b7          	lui	a5,0x10
80003668:	02f57a63          	bgeu	a0,a5,8000369c <__clzsi2+0x38>
8000366c:	10053793          	sltiu	a5,a0,256
80003670:	0017b793          	seqz	a5,a5
80003674:	00379793          	sll	a5,a5,0x3
80003678:	a0000737          	lui	a4,0xa0000
8000367c:	02000693          	li	a3,32
80003680:	40f686b3          	sub	a3,a3,a5
80003684:	00f55533          	srl	a0,a0,a5
80003688:	07870793          	add	a5,a4,120 # a0000078 <__clz_tab>
8000368c:	00a787b3          	add	a5,a5,a0
80003690:	0007c503          	lbu	a0,0(a5) # 10000 <__stack_size+0xc000>
}
80003694:	40a68533          	sub	a0,a3,a0
80003698:	00008067          	ret
  count_leading_zeros (ret, x);
8000369c:	01000737          	lui	a4,0x1000
800036a0:	01800793          	li	a5,24
800036a4:	fce57ae3          	bgeu	a0,a4,80003678 <__clzsi2+0x14>
800036a8:	01000793          	li	a5,16
800036ac:	fcdff06f          	j	80003678 <__clzsi2+0x14>

800036b0 <to_host>:
800036b0:	c00007b7          	lui	a5,0xc0000
800036b4:	00100713          	li	a4,1
800036b8:	00e7a023          	sw	a4,0(a5) # c0000000 <__stack_base+0x1fff0000>
800036bc:	00008067          	ret

800036c0 <to_interrupt>:
800036c0:	d00007b7          	lui	a5,0xd0000
800036c4:	00100713          	li	a4,1
800036c8:	00e7a023          	sw	a4,0(a5) # d0000000 <__stack_base+0x2fff0000>
800036cc:	00008067          	ret

800036d0 <_putchar>:
800036d0:	00050593          	mv	a1,a0
800036d4:	a0001537          	lui	a0,0xa0001
800036d8:	f8450513          	add	a0,a0,-124 # a0000f84 <uart>
800036dc:	34c0006f          	j	80003a28 <uart_put_char>

800036e0 <init>:
800036e0:	a0001537          	lui	a0,0xa0001
800036e4:	ff010113          	add	sp,sp,-16
800036e8:	c00015b7          	lui	a1,0xc0001
800036ec:	f8450513          	add	a0,a0,-124 # a0000f84 <uart>
800036f0:	00112623          	sw	ra,12(sp)
800036f4:	32c000ef          	jal	80003a20 <uart_init>
800036f8:	a0000537          	lui	a0,0xa0000
800036fc:	17850513          	add	a0,a0,376 # a0000178 <__clz_tab+0x100>
80003700:	0d8020ef          	jal	800057d8 <printf_>
80003704:	00c12083          	lw	ra,12(sp)
80003708:	a0000537          	lui	a0,0xa0000
8000370c:	19050513          	add	a0,a0,400 # a0000190 <__clz_tab+0x118>
80003710:	01010113          	add	sp,sp,16
80003714:	0c40206f          	j	800057d8 <printf_>

80003718 <sbi_ecall_handler>:
80003718:	ff010113          	add	sp,sp,-16
8000371c:	00112623          	sw	ra,12(sp)
80003720:	00812423          	sw	s0,8(sp)
80003724:	34102473          	csrr	s0,mepc
80003728:	a0000537          	lui	a0,0xa0000
8000372c:	00040593          	mv	a1,s0
80003730:	1ac50513          	add	a0,a0,428 # a00001ac <__clz_tab+0x134>
80003734:	0a4020ef          	jal	800057d8 <printf_>
80003738:	00440413          	add	s0,s0,4
8000373c:	34141073          	csrw	mepc,s0
80003740:	341025f3          	csrr	a1,mepc
80003744:	00812403          	lw	s0,8(sp)
80003748:	00c12083          	lw	ra,12(sp)
8000374c:	a0000537          	lui	a0,0xa0000
80003750:	1c450513          	add	a0,a0,452 # a00001c4 <__clz_tab+0x14c>
80003754:	01010113          	add	sp,sp,16
80003758:	0800206f          	j	800057d8 <printf_>

8000375c <sbi_illegal_insn_handler>:
8000375c:	ff010113          	add	sp,sp,-16
80003760:	00112623          	sw	ra,12(sp)
80003764:	00812423          	sw	s0,8(sp)
80003768:	341025f3          	csrr	a1,mepc
8000376c:	34302473          	csrr	s0,mtval
80003770:	a0000537          	lui	a0,0xa0000
80003774:	1e050513          	add	a0,a0,480 # a00001e0 <__clz_tab+0x168>
80003778:	060020ef          	jal	800057d8 <printf_>
8000377c:	a0000537          	lui	a0,0xa0000
80003780:	00040593          	mv	a1,s0
80003784:	1f850513          	add	a0,a0,504 # a00001f8 <__clz_tab+0x180>
80003788:	050020ef          	jal	800057d8 <printf_>
8000378c:	00812403          	lw	s0,8(sp)
80003790:	00c12083          	lw	ra,12(sp)
80003794:	a0000537          	lui	a0,0xa0000
80003798:	21850513          	add	a0,a0,536 # a0000218 <__clz_tab+0x1a0>
8000379c:	01010113          	add	sp,sp,16
800037a0:	0380206f          	j	800057d8 <printf_>

800037a4 <sbi_ebreak_handler>:
800037a4:	a0000537          	lui	a0,0xa0000
800037a8:	ff010113          	add	sp,sp,-16
800037ac:	25850513          	add	a0,a0,600 # a0000258 <__clz_tab+0x1e0>
800037b0:	00112623          	sw	ra,12(sp)
800037b4:	00812423          	sw	s0,8(sp)
800037b8:	020020ef          	jal	800057d8 <printf_>
800037bc:	34102473          	csrr	s0,mepc
800037c0:	a0000537          	lui	a0,0xa0000
800037c4:	00040593          	mv	a1,s0
800037c8:	29850513          	add	a0,a0,664 # a0000298 <__clz_tab+0x220>
800037cc:	00c020ef          	jal	800057d8 <printf_>
800037d0:	00440413          	add	s0,s0,4
800037d4:	34141073          	csrw	mepc,s0
800037d8:	341025f3          	csrr	a1,mepc
800037dc:	00812403          	lw	s0,8(sp)
800037e0:	00c12083          	lw	ra,12(sp)
800037e4:	a0000537          	lui	a0,0xa0000
800037e8:	2b050513          	add	a0,a0,688 # a00002b0 <__clz_tab+0x238>
800037ec:	01010113          	add	sp,sp,16
800037f0:	7e90106f          	j	800057d8 <printf_>

800037f4 <sbi_irqchip_process>:
800037f4:	ff010113          	add	sp,sp,-16
800037f8:	00112623          	sw	ra,12(sp)
800037fc:	00812423          	sw	s0,8(sp)
80003800:	00912223          	sw	s1,4(sp)
80003804:	01212023          	sw	s2,0(sp)
80003808:	341025f3          	csrr	a1,mepc
8000380c:	30002973          	csrr	s2,mstatus
80003810:	344024f3          	csrr	s1,mip
80003814:	30402473          	csrr	s0,mie
80003818:	a0000537          	lui	a0,0xa0000
8000381c:	2cc50513          	add	a0,a0,716 # a00002cc <__clz_tab+0x254>
80003820:	7b9010ef          	jal	800057d8 <printf_>
80003824:	a0000537          	lui	a0,0xa0000
80003828:	00090593          	mv	a1,s2
8000382c:	2f450513          	add	a0,a0,756 # a00002f4 <__clz_tab+0x27c>
80003830:	7a9010ef          	jal	800057d8 <printf_>
80003834:	a0000537          	lui	a0,0xa0000
80003838:	00048593          	mv	a1,s1
8000383c:	32050513          	add	a0,a0,800 # a0000320 <__clz_tab+0x2a8>
80003840:	799010ef          	jal	800057d8 <printf_>
80003844:	a0000537          	lui	a0,0xa0000
80003848:	00040593          	mv	a1,s0
8000384c:	34850513          	add	a0,a0,840 # a0000348 <__clz_tab+0x2d0>
80003850:	789010ef          	jal	800057d8 <printf_>
80003854:	00812403          	lw	s0,8(sp)
80003858:	00c12083          	lw	ra,12(sp)
8000385c:	00412483          	lw	s1,4(sp)
80003860:	00012903          	lw	s2,0(sp)
80003864:	a0000537          	lui	a0,0xa0000
80003868:	37050513          	add	a0,a0,880 # a0000370 <__clz_tab+0x2f8>
8000386c:	01010113          	add	sp,sp,16
80003870:	7690106f          	j	800057d8 <printf_>

80003874 <toy_trap_handler>:
80003874:	ff010113          	add	sp,sp,-16
80003878:	00912223          	sw	s1,4(sp)
8000387c:	00050493          	mv	s1,a0
80003880:	a0000537          	lui	a0,0xa0000
80003884:	3c050513          	add	a0,a0,960 # a00003c0 <__clz_tab+0x348>
80003888:	00112623          	sw	ra,12(sp)
8000388c:	00812423          	sw	s0,8(sp)
80003890:	01212023          	sw	s2,0(sp)
80003894:	745010ef          	jal	800057d8 <printf_>
80003898:	341025f3          	csrr	a1,mepc
8000389c:	34202473          	csrr	s0,mcause
800038a0:	34302973          	csrr	s2,mtval
800038a4:	a0000537          	lui	a0,0xa0000
800038a8:	3fc50513          	add	a0,a0,1020 # a00003fc <__clz_tab+0x384>
800038ac:	72d010ef          	jal	800057d8 <printf_>
800038b0:	a0000537          	lui	a0,0xa0000
800038b4:	00040593          	mv	a1,s0
800038b8:	41450513          	add	a0,a0,1044 # a0000414 <__clz_tab+0x39c>
800038bc:	71d010ef          	jal	800057d8 <printf_>
800038c0:	a0000537          	lui	a0,0xa0000
800038c4:	00090593          	mv	a1,s2
800038c8:	42c50513          	add	a0,a0,1068 # a000042c <__clz_tab+0x3b4>
800038cc:	70d010ef          	jal	800057d8 <printf_>
800038d0:	02044263          	bltz	s0,800038f4 <toy_trap_handler+0x80>
800038d4:	00b00793          	li	a5,11
800038d8:	0487ea63          	bltu	a5,s0,8000392c <toy_trap_handler+0xb8>
800038dc:	a00017b7          	lui	a5,0xa0001
800038e0:	cc078793          	add	a5,a5,-832 # a0000cc0 <__clz_tab+0xc48>
800038e4:	00241413          	sll	s0,s0,0x2
800038e8:	00f40433          	add	s0,s0,a5
800038ec:	00042783          	lw	a5,0(s0)
800038f0:	00078067          	jr	a5
800038f4:	00141413          	sll	s0,s0,0x1
800038f8:	00145413          	srl	s0,s0,0x1
800038fc:	00700793          	li	a5,7
80003900:	0ef40263          	beq	s0,a5,800039e4 <toy_trap_handler+0x170>
80003904:	00b00793          	li	a5,11
80003908:	0ef40663          	beq	s0,a5,800039f4 <toy_trap_handler+0x180>
8000390c:	00300793          	li	a5,3
80003910:	00f41863          	bne	s0,a5,80003920 <toy_trap_handler+0xac>
80003914:	a0000537          	lui	a0,0xa0000
80003918:	45850513          	add	a0,a0,1112 # a0000458 <__clz_tab+0x3e0>
8000391c:	6bd010ef          	jal	800057d8 <printf_>
80003920:	a0000537          	lui	a0,0xa0000
80003924:	48850513          	add	a0,a0,1160 # a0000488 <__clz_tab+0x410>
80003928:	6b1010ef          	jal	800057d8 <printf_>
8000392c:	a0000537          	lui	a0,0xa0000
80003930:	5d850513          	add	a0,a0,1496 # a00005d8 <__clz_tab+0x560>
80003934:	6a5010ef          	jal	800057d8 <printf_>
80003938:	00c12083          	lw	ra,12(sp)
8000393c:	00812403          	lw	s0,8(sp)
80003940:	00012903          	lw	s2,0(sp)
80003944:	00048513          	mv	a0,s1
80003948:	00412483          	lw	s1,4(sp)
8000394c:	01010113          	add	sp,sp,16
80003950:	00008067          	ret
80003954:	a0000537          	lui	a0,0xa0000
80003958:	4c450513          	add	a0,a0,1220 # a00004c4 <__clz_tab+0x44c>
8000395c:	67d010ef          	jal	800057d8 <printf_>
80003960:	dfdff0ef          	jal	8000375c <sbi_illegal_insn_handler>
80003964:	d4dff0ef          	jal	800036b0 <to_host>
80003968:	fc5ff06f          	j	8000392c <toy_trap_handler+0xb8>
8000396c:	a0000537          	lui	a0,0xa0000
80003970:	4ec50513          	add	a0,a0,1260 # a00004ec <__clz_tab+0x474>
80003974:	665010ef          	jal	800057d8 <printf_>
80003978:	e2dff0ef          	jal	800037a4 <sbi_ebreak_handler>
8000397c:	fb1ff06f          	j	8000392c <toy_trap_handler+0xb8>
80003980:	a0000537          	lui	a0,0xa0000
80003984:	50c50513          	add	a0,a0,1292 # a000050c <__clz_tab+0x494>
80003988:	651010ef          	jal	800057d8 <printf_>
8000398c:	fa1ff06f          	j	8000392c <toy_trap_handler+0xb8>
80003990:	a0000537          	lui	a0,0xa0000
80003994:	59850513          	add	a0,a0,1432 # a0000598 <__clz_tab+0x520>
80003998:	641010ef          	jal	800057d8 <printf_>
8000399c:	f91ff06f          	j	8000392c <toy_trap_handler+0xb8>
800039a0:	a0000537          	lui	a0,0xa0000
800039a4:	53050513          	add	a0,a0,1328 # a0000530 <__clz_tab+0x4b8>
800039a8:	631010ef          	jal	800057d8 <printf_>
800039ac:	f81ff06f          	j	8000392c <toy_trap_handler+0xb8>
800039b0:	a0000537          	lui	a0,0xa0000
800039b4:	5b850513          	add	a0,a0,1464 # a00005b8 <__clz_tab+0x540>
800039b8:	621010ef          	jal	800057d8 <printf_>
800039bc:	f71ff06f          	j	8000392c <toy_trap_handler+0xb8>
800039c0:	a0000537          	lui	a0,0xa0000
800039c4:	55450513          	add	a0,a0,1364 # a0000554 <__clz_tab+0x4dc>
800039c8:	611010ef          	jal	800057d8 <printf_>
800039cc:	f61ff06f          	j	8000392c <toy_trap_handler+0xb8>
800039d0:	a0000537          	lui	a0,0xa0000
800039d4:	57850513          	add	a0,a0,1400 # a0000578 <__clz_tab+0x500>
800039d8:	601010ef          	jal	800057d8 <printf_>
800039dc:	d3dff0ef          	jal	80003718 <sbi_ecall_handler>
800039e0:	f4dff06f          	j	8000392c <toy_trap_handler+0xb8>
800039e4:	a0000537          	lui	a0,0xa0000
800039e8:	44450513          	add	a0,a0,1092 # a0000444 <__clz_tab+0x3cc>
800039ec:	5ed010ef          	jal	800057d8 <printf_>
800039f0:	f31ff06f          	j	80003920 <toy_trap_handler+0xac>
800039f4:	a0000537          	lui	a0,0xa0000
800039f8:	47050513          	add	a0,a0,1136 # a0000470 <__clz_tab+0x3f8>
800039fc:	5dd010ef          	jal	800057d8 <printf_>
80003a00:	df5ff0ef          	jal	800037f4 <sbi_irqchip_process>
80003a04:	cbdff0ef          	jal	800036c0 <to_interrupt>
80003a08:	f19ff06f          	j	80003920 <toy_trap_handler+0xac>

80003a0c <get_instret>:
80003a0c:	c0202573          	rdinstret	a0
80003a10:	00008067          	ret

80003a14 <get_cycle>:
80003a14:	b0002573          	csrr	a0,mcycle
80003a18:	b80025f3          	csrr	a1,mcycleh
80003a1c:	00008067          	ret

80003a20 <uart_init>:
80003a20:	00b52023          	sw	a1,0(a0)
80003a24:	00008067          	ret

80003a28 <uart_put_char>:
80003a28:	00052783          	lw	a5,0(a0)
80003a2c:	00b7a023          	sw	a1,0(a5)
80003a30:	00000013          	nop
80003a34:	00000013          	nop
80003a38:	00000013          	nop
80003a3c:	00000013          	nop
80003a40:	00000013          	nop
80003a44:	00000013          	nop
80003a48:	00000013          	nop
80003a4c:	00000013          	nop
80003a50:	00000013          	nop
80003a54:	00000013          	nop
80003a58:	00000013          	nop
80003a5c:	00000013          	nop
80003a60:	00000013          	nop
80003a64:	00000013          	nop
80003a68:	00000013          	nop
80003a6c:	00000013          	nop
80003a70:	00000013          	nop
80003a74:	00000013          	nop
80003a78:	00000013          	nop
80003a7c:	00000013          	nop
80003a80:	00000013          	nop
80003a84:	00000013          	nop
80003a88:	00000013          	nop
80003a8c:	00000013          	nop
80003a90:	00000013          	nop
80003a94:	00000013          	nop
80003a98:	00000013          	nop
80003a9c:	00000013          	nop
80003aa0:	00000013          	nop
80003aa4:	00000013          	nop
80003aa8:	00000013          	nop
80003aac:	00000013          	nop
80003ab0:	00000013          	nop
80003ab4:	00000013          	nop
80003ab8:	00000013          	nop
80003abc:	00000013          	nop
80003ac0:	00000013          	nop
80003ac4:	00000013          	nop
80003ac8:	00000013          	nop
80003acc:	00000013          	nop
80003ad0:	00000013          	nop
80003ad4:	00000013          	nop
80003ad8:	00000013          	nop
80003adc:	00000013          	nop
80003ae0:	00000013          	nop
80003ae4:	00000013          	nop
80003ae8:	00000013          	nop
80003aec:	00000013          	nop
80003af0:	00000013          	nop
80003af4:	00000013          	nop
80003af8:	00008067          	ret

80003afc <_out_null>:
80003afc:	00008067          	ret

80003b00 <_out_rev>:
80003b00:	fd010113          	add	sp,sp,-48
80003b04:	02812423          	sw	s0,40(sp)
80003b08:	01312e23          	sw	s3,28(sp)
80003b0c:	01412c23          	sw	s4,24(sp)
80003b10:	01512a23          	sw	s5,20(sp)
80003b14:	01612823          	sw	s6,16(sp)
80003b18:	01712623          	sw	s7,12(sp)
80003b1c:	01812423          	sw	s8,8(sp)
80003b20:	01912223          	sw	s9,4(sp)
80003b24:	02112623          	sw	ra,44(sp)
80003b28:	00088c93          	mv	s9,a7
80003b2c:	02912223          	sw	s1,36(sp)
80003b30:	03212023          	sw	s2,32(sp)
80003b34:	0038f893          	and	a7,a7,3
80003b38:	00050993          	mv	s3,a0
80003b3c:	00058a13          	mv	s4,a1
80003b40:	00060b13          	mv	s6,a2
80003b44:	00068a93          	mv	s5,a3
80003b48:	00070b93          	mv	s7,a4
80003b4c:	00078413          	mv	s0,a5
80003b50:	00080c13          	mv	s8,a6
80003b54:	0c089263          	bnez	a7,80003c18 <_out_rev+0x118>
80003b58:	0d07f863          	bgeu	a5,a6,80003c28 <_out_rev+0x128>
80003b5c:	40f80933          	sub	s2,a6,a5
80003b60:	00c90933          	add	s2,s2,a2
80003b64:	00060493          	mv	s1,a2
80003b68:	00048613          	mv	a2,s1
80003b6c:	000a8693          	mv	a3,s5
80003b70:	00148493          	add	s1,s1,1
80003b74:	000a0593          	mv	a1,s4
80003b78:	02000513          	li	a0,32
80003b7c:	000980e7          	jalr	s3
80003b80:	ff2494e3          	bne	s1,s2,80003b68 <_out_rev+0x68>
80003b84:	04040e63          	beqz	s0,80003be0 <_out_rev+0xe0>
80003b88:	00890933          	add	s2,s2,s0
80003b8c:	40890633          	sub	a2,s2,s0
80003b90:	fff40413          	add	s0,s0,-1
80003b94:	008b87b3          	add	a5,s7,s0
80003b98:	0007c503          	lbu	a0,0(a5)
80003b9c:	000a8693          	mv	a3,s5
80003ba0:	000a0593          	mv	a1,s4
80003ba4:	00090493          	mv	s1,s2
80003ba8:	000980e7          	jalr	s3
80003bac:	fe0410e3          	bnez	s0,80003b8c <_out_rev+0x8c>
80003bb0:	002cfc93          	and	s9,s9,2
80003bb4:	020c8663          	beqz	s9,80003be0 <_out_rev+0xe0>
80003bb8:	41648b33          	sub	s6,s1,s6
80003bbc:	038b7263          	bgeu	s6,s8,80003be0 <_out_rev+0xe0>
80003bc0:	00048613          	mv	a2,s1
80003bc4:	000a8693          	mv	a3,s5
80003bc8:	000a0593          	mv	a1,s4
80003bcc:	02000513          	li	a0,32
80003bd0:	001b0b13          	add	s6,s6,1
80003bd4:	00148493          	add	s1,s1,1
80003bd8:	000980e7          	jalr	s3
80003bdc:	ff8b62e3          	bltu	s6,s8,80003bc0 <_out_rev+0xc0>
80003be0:	02c12083          	lw	ra,44(sp)
80003be4:	02812403          	lw	s0,40(sp)
80003be8:	02012903          	lw	s2,32(sp)
80003bec:	01c12983          	lw	s3,28(sp)
80003bf0:	01812a03          	lw	s4,24(sp)
80003bf4:	01412a83          	lw	s5,20(sp)
80003bf8:	01012b03          	lw	s6,16(sp)
80003bfc:	00c12b83          	lw	s7,12(sp)
80003c00:	00812c03          	lw	s8,8(sp)
80003c04:	00412c83          	lw	s9,4(sp)
80003c08:	00048513          	mv	a0,s1
80003c0c:	02412483          	lw	s1,36(sp)
80003c10:	03010113          	add	sp,sp,48
80003c14:	00008067          	ret
80003c18:	00060913          	mv	s2,a2
80003c1c:	00060493          	mv	s1,a2
80003c20:	f60794e3          	bnez	a5,80003b88 <_out_rev+0x88>
80003c24:	f8dff06f          	j	80003bb0 <_out_rev+0xb0>
80003c28:	00060913          	mv	s2,a2
80003c2c:	f4079ee3          	bnez	a5,80003b88 <_out_rev+0x88>
80003c30:	00060493          	mv	s1,a2
80003c34:	fadff06f          	j	80003be0 <_out_rev+0xe0>

80003c38 <_ntoa_format>:
80003c38:	00812383          	lw	t2,8(sp)
80003c3c:	00012283          	lw	t0,0(sp)
80003c40:	00412f83          	lw	t6,4(sp)
80003c44:	0023f313          	and	t1,t2,2
80003c48:	00080f13          	mv	t5,a6
80003c4c:	06031463          	bnez	t1,80003cb4 <_ntoa_format+0x7c>
80003c50:	100f9c63          	bnez	t6,80003d68 <_ntoa_format+0x130>
80003c54:	0657f063          	bgeu	a5,t0,80003cb4 <_ntoa_format+0x7c>
80003c58:	02000313          	li	t1,32
80003c5c:	0013f813          	and	a6,t2,1
80003c60:	2e678063          	beq	a5,t1,80003f40 <_ntoa_format+0x308>
80003c64:	03000e13          	li	t3,48
80003c68:	02000e93          	li	t4,32
80003c6c:	0080006f          	j	80003c74 <_ntoa_format+0x3c>
80003c70:	15d78a63          	beq	a5,t4,80003dc4 <_ntoa_format+0x18c>
80003c74:	00178793          	add	a5,a5,1
80003c78:	00f70333          	add	t1,a4,a5
80003c7c:	ffc30fa3          	sb	t3,-1(t1)
80003c80:	fe57e8e3          	bltu	a5,t0,80003c70 <_ntoa_format+0x38>
80003c84:	02080863          	beqz	a6,80003cb4 <_ntoa_format+0x7c>
80003c88:	03f7f663          	bgeu	a5,t6,80003cb4 <_ntoa_format+0x7c>
80003c8c:	02000813          	li	a6,32
80003c90:	03000e13          	li	t3,48
80003c94:	02000e93          	li	t4,32
80003c98:	01079663          	bne	a5,a6,80003ca4 <_ntoa_format+0x6c>
80003c9c:	1300006f          	j	80003dcc <_ntoa_format+0x194>
80003ca0:	07d78663          	beq	a5,t4,80003d0c <_ntoa_format+0xd4>
80003ca4:	00178793          	add	a5,a5,1
80003ca8:	00f70333          	add	t1,a4,a5
80003cac:	ffc30fa3          	sb	t3,-1(t1)
80003cb0:	fff798e3          	bne	a5,t6,80003ca0 <_ntoa_format+0x68>
80003cb4:	0103f813          	and	a6,t2,16
80003cb8:	08080e63          	beqz	a6,80003d54 <_ntoa_format+0x11c>
80003cbc:	4003f813          	and	a6,t2,1024
80003cc0:	06081463          	bnez	a6,80003d28 <_ntoa_format+0xf0>
80003cc4:	04079e63          	bnez	a5,80003d20 <_ntoa_format+0xe8>
80003cc8:	01000793          	li	a5,16
80003ccc:	22f88863          	beq	a7,a5,80003efc <_ntoa_format+0x2c4>
80003cd0:	00200793          	li	a5,2
80003cd4:	24f88663          	beq	a7,a5,80003f20 <_ntoa_format+0x2e8>
80003cd8:	03000793          	li	a5,48
80003cdc:	00f70023          	sb	a5,0(a4) # 1000000 <__stack_size+0xffc000>
80003ce0:	00100793          	li	a5,1
80003ce4:	100f1a63          	bnez	t5,80003df8 <_ntoa_format+0x1c0>
80003ce8:	0043f813          	and	a6,t2,4
80003cec:	1c080c63          	beqz	a6,80003ec4 <_ntoa_format+0x28c>
80003cf0:	00f70833          	add	a6,a4,a5
80003cf4:	02b00893          	li	a7,43
80003cf8:	01180023          	sb	a7,0(a6)
80003cfc:	00178793          	add	a5,a5,1
80003d00:	00038893          	mv	a7,t2
80003d04:	000f8813          	mv	a6,t6
80003d08:	df9ff06f          	j	80003b00 <_out_rev>
80003d0c:	0103f813          	and	a6,t2,16
80003d10:	02000793          	li	a5,32
80003d14:	fe0806e3          	beqz	a6,80003d00 <_ntoa_format+0xc8>
80003d18:	4003f813          	and	a6,t2,1024
80003d1c:	00081663          	bnez	a6,80003d28 <_ntoa_format+0xf0>
80003d20:	14f28263          	beq	t0,a5,80003e64 <_ntoa_format+0x22c>
80003d24:	15f78063          	beq	a5,t6,80003e64 <_ntoa_format+0x22c>
80003d28:	01000813          	li	a6,16
80003d2c:	17088a63          	beq	a7,a6,80003ea0 <_ntoa_format+0x268>
80003d30:	00200813          	li	a6,2
80003d34:	11088a63          	beq	a7,a6,80003e48 <_ntoa_format+0x210>
80003d38:	02000813          	li	a6,32
80003d3c:	fd0782e3          	beq	a5,a6,80003d00 <_ntoa_format+0xc8>
80003d40:	00078813          	mv	a6,a5
80003d44:	00178793          	add	a5,a5,1
80003d48:	01070833          	add	a6,a4,a6
80003d4c:	03000893          	li	a7,48
80003d50:	01180023          	sb	a7,0(a6)
80003d54:	02000813          	li	a6,32
80003d58:	f90796e3          	bne	a5,a6,80003ce4 <_ntoa_format+0xac>
80003d5c:	00038893          	mv	a7,t2
80003d60:	000f8813          	mv	a6,t6
80003d64:	d9dff06f          	j	80003b00 <_out_rev>
80003d68:	0013f813          	and	a6,t2,1
80003d6c:	0a080463          	beqz	a6,80003e14 <_ntoa_format+0x1dc>
80003d70:	120f1463          	bnez	t5,80003e98 <_ntoa_format+0x260>
80003d74:	00c3f313          	and	t1,t2,12
80003d78:	12031063          	bnez	t1,80003e98 <_ntoa_format+0x260>
80003d7c:	f057f6e3          	bgeu	a5,t0,80003c88 <_ntoa_format+0x50>
80003d80:	02000313          	li	t1,32
80003d84:	ee6790e3          	bne	a5,t1,80003c64 <_ntoa_format+0x2c>
80003d88:	05f7e263          	bltu	a5,t6,80003dcc <_ntoa_format+0x194>
80003d8c:	0103f813          	and	a6,t2,16
80003d90:	02000793          	li	a5,32
80003d94:	f60806e3          	beqz	a6,80003d00 <_ntoa_format+0xc8>
80003d98:	4003f813          	and	a6,t2,1024
80003d9c:	04081663          	bnez	a6,80003de8 <_ntoa_format+0x1b0>
80003da0:	00f28463          	beq	t0,a5,80003da8 <_ntoa_format+0x170>
80003da4:	f8ff92e3          	bne	t6,a5,80003d28 <_ntoa_format+0xf0>
80003da8:	01f00813          	li	a6,31
80003dac:	01000313          	li	t1,16
80003db0:	18688c63          	beq	a7,t1,80003f48 <_ntoa_format+0x310>
80003db4:	00200793          	li	a5,2
80003db8:	1af88863          	beq	a7,a5,80003f68 <_ntoa_format+0x330>
80003dbc:	00180793          	add	a5,a6,1
80003dc0:	f89ff06f          	j	80003d48 <_ntoa_format+0x110>
80003dc4:	1a080c63          	beqz	a6,80003f7c <_ntoa_format+0x344>
80003dc8:	f5f7f2e3          	bgeu	a5,t6,80003d0c <_ntoa_format+0xd4>
80003dcc:	0103f813          	and	a6,t2,16
80003dd0:	02000793          	li	a5,32
80003dd4:	f20806e3          	beqz	a6,80003d00 <_ntoa_format+0xc8>
80003dd8:	4003f813          	and	a6,t2,1024
80003ddc:	00081663          	bnez	a6,80003de8 <_ntoa_format+0x1b0>
80003de0:	fcf284e3          	beq	t0,a5,80003da8 <_ntoa_format+0x170>
80003de4:	fcff82e3          	beq	t6,a5,80003da8 <_ntoa_format+0x170>
80003de8:	01000813          	li	a6,16
80003dec:	f1089ae3          	bne	a7,a6,80003d00 <_ntoa_format+0xc8>
80003df0:	02000793          	li	a5,32
80003df4:	f0dff06f          	j	80003d00 <_ntoa_format+0xc8>
80003df8:	00f70833          	add	a6,a4,a5
80003dfc:	02d00893          	li	a7,45
80003e00:	01180023          	sb	a7,0(a6)
80003e04:	00178793          	add	a5,a5,1
80003e08:	00038893          	mv	a7,t2
80003e0c:	000f8813          	mv	a6,t6
80003e10:	cf1ff06f          	j	80003b00 <_out_rev>
80003e14:	ea57f0e3          	bgeu	a5,t0,80003cb4 <_ntoa_format+0x7c>
80003e18:	02000313          	li	t1,32
80003e1c:	e46794e3          	bne	a5,t1,80003c64 <_ntoa_format+0x2c>
80003e20:	0103f793          	and	a5,t2,16
80003e24:	fc0786e3          	beqz	a5,80003df0 <_ntoa_format+0x1b8>
80003e28:	4003f793          	and	a5,t2,1024
80003e2c:	fc0792e3          	bnez	a5,80003df0 <_ntoa_format+0x1b8>
80003e30:	02000793          	li	a5,32
80003e34:	00f28463          	beq	t0,a5,80003e3c <_ntoa_format+0x204>
80003e38:	faff9ce3          	bne	t6,a5,80003df0 <_ntoa_format+0x1b8>
80003e3c:	02000793          	li	a5,32
80003e40:	01f00813          	li	a6,31
80003e44:	f69ff06f          	j	80003dac <_ntoa_format+0x174>
80003e48:	02000813          	li	a6,32
80003e4c:	eb078ae3          	beq	a5,a6,80003d00 <_ntoa_format+0xc8>
80003e50:	00f70833          	add	a6,a4,a5
80003e54:	06200893          	li	a7,98
80003e58:	01180023          	sb	a7,0(a6)
80003e5c:	00178793          	add	a5,a5,1
80003e60:	ed9ff06f          	j	80003d38 <_ntoa_format+0x100>
80003e64:	fff78813          	add	a6,a5,-1
80003e68:	f40812e3          	bnez	a6,80003dac <_ntoa_format+0x174>
80003e6c:	01000793          	li	a5,16
80003e70:	e6f890e3          	bne	a7,a5,80003cd0 <_ntoa_format+0x98>
80003e74:	0203f793          	and	a5,t2,32
80003e78:	0c078063          	beqz	a5,80003f38 <_ntoa_format+0x300>
80003e7c:	05800793          	li	a5,88
80003e80:	00f70023          	sb	a5,0(a4)
80003e84:	03000793          	li	a5,48
80003e88:	00f700a3          	sb	a5,1(a4)
80003e8c:	00200793          	li	a5,2
80003e90:	e40f0ce3          	beqz	t5,80003ce8 <_ntoa_format+0xb0>
80003e94:	f65ff06f          	j	80003df8 <_ntoa_format+0x1c0>
80003e98:	ffff8f93          	add	t6,t6,-1
80003e9c:	ee1ff06f          	j	80003d7c <_ntoa_format+0x144>
80003ea0:	0203f813          	and	a6,t2,32
80003ea4:	02081e63          	bnez	a6,80003ee0 <_ntoa_format+0x2a8>
80003ea8:	02000813          	li	a6,32
80003eac:	f50782e3          	beq	a5,a6,80003df0 <_ntoa_format+0x1b8>
80003eb0:	00f70833          	add	a6,a4,a5
80003eb4:	07800893          	li	a7,120
80003eb8:	01180023          	sb	a7,0(a6)
80003ebc:	00178793          	add	a5,a5,1
80003ec0:	e79ff06f          	j	80003d38 <_ntoa_format+0x100>
80003ec4:	0083f813          	and	a6,t2,8
80003ec8:	e2080ce3          	beqz	a6,80003d00 <_ntoa_format+0xc8>
80003ecc:	00f70833          	add	a6,a4,a5
80003ed0:	02000893          	li	a7,32
80003ed4:	01180023          	sb	a7,0(a6)
80003ed8:	00178793          	add	a5,a5,1
80003edc:	e25ff06f          	j	80003d00 <_ntoa_format+0xc8>
80003ee0:	02000813          	li	a6,32
80003ee4:	f10786e3          	beq	a5,a6,80003df0 <_ntoa_format+0x1b8>
80003ee8:	00f70833          	add	a6,a4,a5
80003eec:	05800893          	li	a7,88
80003ef0:	01180023          	sb	a7,0(a6)
80003ef4:	00178793          	add	a5,a5,1
80003ef8:	e41ff06f          	j	80003d38 <_ntoa_format+0x100>
80003efc:	0203f793          	and	a5,t2,32
80003f00:	02078c63          	beqz	a5,80003f38 <_ntoa_format+0x300>
80003f04:	05800793          	li	a5,88
80003f08:	00f70023          	sb	a5,0(a4)
80003f0c:	03000793          	li	a5,48
80003f10:	00f700a3          	sb	a5,1(a4)
80003f14:	00200793          	li	a5,2
80003f18:	dc0f08e3          	beqz	t5,80003ce8 <_ntoa_format+0xb0>
80003f1c:	eddff06f          	j	80003df8 <_ntoa_format+0x1c0>
80003f20:	06200793          	li	a5,98
80003f24:	00f70023          	sb	a5,0(a4)
80003f28:	03000793          	li	a5,48
80003f2c:	00f700a3          	sb	a5,1(a4)
80003f30:	00200793          	li	a5,2
80003f34:	f5dff06f          	j	80003e90 <_ntoa_format+0x258>
80003f38:	07800793          	li	a5,120
80003f3c:	fe9ff06f          	j	80003f24 <_ntoa_format+0x2ec>
80003f40:	e40816e3          	bnez	a6,80003d8c <_ntoa_format+0x154>
80003f44:	eddff06f          	j	80003e20 <_ntoa_format+0x1e8>
80003f48:	ffe78813          	add	a6,a5,-2
80003f4c:	0203f893          	and	a7,t2,32
80003f50:	01070833          	add	a6,a4,a6
80003f54:	fff78793          	add	a5,a5,-1
80003f58:	00089c63          	bnez	a7,80003f70 <_ntoa_format+0x338>
80003f5c:	07800893          	li	a7,120
80003f60:	01180023          	sb	a7,0(a6)
80003f64:	dddff06f          	j	80003d40 <_ntoa_format+0x108>
80003f68:	00080793          	mv	a5,a6
80003f6c:	ee5ff06f          	j	80003e50 <_ntoa_format+0x218>
80003f70:	05800893          	li	a7,88
80003f74:	01180023          	sb	a7,0(a6)
80003f78:	dc9ff06f          	j	80003d40 <_ntoa_format+0x108>
80003f7c:	0103f813          	and	a6,t2,16
80003f80:	d80800e3          	beqz	a6,80003d00 <_ntoa_format+0xc8>
80003f84:	4003f813          	and	a6,t2,1024
80003f88:	e60810e3          	bnez	a6,80003de8 <_ntoa_format+0x1b0>
80003f8c:	d9f79ee3          	bne	a5,t6,80003d28 <_ntoa_format+0xf0>
80003f90:	ed5ff06f          	j	80003e64 <_ntoa_format+0x22c>

80003f94 <_ntoa_long>:
80003f94:	f8010113          	add	sp,sp,-128
80003f98:	06812c23          	sw	s0,120(sp)
80003f9c:	06912a23          	sw	s1,116(sp)
80003fa0:	07612023          	sw	s6,96(sp)
80003fa4:	05812c23          	sw	s8,88(sp)
80003fa8:	05912a23          	sw	s9,84(sp)
80003fac:	05a12823          	sw	s10,80(sp)
80003fb0:	05b12623          	sw	s11,76(sp)
80003fb4:	06112e23          	sw	ra,124(sp)
80003fb8:	07312623          	sw	s3,108(sp)
80003fbc:	05712e23          	sw	s7,92(sp)
80003fc0:	00a12c23          	sw	a0,24(sp)
80003fc4:	00c12e23          	sw	a2,28(sp)
80003fc8:	08412b03          	lw	s6,132(sp)
80003fcc:	00070413          	mv	s0,a4
80003fd0:	00058c13          	mv	s8,a1
80003fd4:	00068c93          	mv	s9,a3
80003fd8:	00078d13          	mv	s10,a5
80003fdc:	00080493          	mv	s1,a6
80003fe0:	00088d93          	mv	s11,a7
80003fe4:	00071863          	bnez	a4,80003ff4 <_ntoa_long+0x60>
80003fe8:	400b7793          	and	a5,s6,1024
80003fec:	fefb7b13          	and	s6,s6,-17
80003ff0:	0e079c63          	bnez	a5,800040e8 <_ntoa_long+0x154>
80003ff4:	005b5793          	srl	a5,s6,0x5
80003ff8:	07212823          	sw	s2,112(sp)
80003ffc:	07412423          	sw	s4,104(sp)
80004000:	07512223          	sw	s5,100(sp)
80004004:	0017f793          	and	a5,a5,1
80004008:	06100913          	li	s2,97
8000400c:	0c079a63          	bnez	a5,800040e0 <_ntoa_long+0x14c>
80004010:	00000b93          	li	s7,0
80004014:	02010993          	add	s3,sp,32
80004018:	00900a13          	li	s4,9
8000401c:	ff690913          	add	s2,s2,-10
80004020:	02000a93          	li	s5,32
80004024:	00c0006f          	j	80004030 <_ntoa_long+0x9c>
80004028:	055b8463          	beq	s7,s5,80004070 <_ntoa_long+0xdc>
8000402c:	00050413          	mv	s0,a0
80004030:	00048593          	mv	a1,s1
80004034:	00040513          	mv	a0,s0
80004038:	d58ff0ef          	jal	80003590 <__umodsi3>
8000403c:	0ff57713          	zext.b	a4,a0
80004040:	03070693          	add	a3,a4,48
80004044:	01270733          	add	a4,a4,s2
80004048:	0ff77713          	zext.b	a4,a4
8000404c:	00aa6463          	bltu	s4,a0,80004054 <_ntoa_long+0xc0>
80004050:	0ff6f713          	zext.b	a4,a3
80004054:	001b8b93          	add	s7,s7,1
80004058:	017986b3          	add	a3,s3,s7
8000405c:	00048593          	mv	a1,s1
80004060:	00040513          	mv	a0,s0
80004064:	fee68fa3          	sb	a4,-1(a3)
80004068:	ce0ff0ef          	jal	80003548 <__hidden___udivsi3>
8000406c:	fa947ee3          	bgeu	s0,s1,80004028 <_ntoa_long+0x94>
80004070:	07012903          	lw	s2,112(sp)
80004074:	06812a03          	lw	s4,104(sp)
80004078:	06412a83          	lw	s5,100(sp)
8000407c:	08012703          	lw	a4,128(sp)
80004080:	01c12603          	lw	a2,28(sp)
80004084:	01812503          	lw	a0,24(sp)
80004088:	01612423          	sw	s6,8(sp)
8000408c:	00e12223          	sw	a4,4(sp)
80004090:	01b12023          	sw	s11,0(sp)
80004094:	00048893          	mv	a7,s1
80004098:	000d0813          	mv	a6,s10
8000409c:	000b8793          	mv	a5,s7
800040a0:	00098713          	mv	a4,s3
800040a4:	000c8693          	mv	a3,s9
800040a8:	000c0593          	mv	a1,s8
800040ac:	b8dff0ef          	jal	80003c38 <_ntoa_format>
800040b0:	07c12083          	lw	ra,124(sp)
800040b4:	07812403          	lw	s0,120(sp)
800040b8:	07412483          	lw	s1,116(sp)
800040bc:	06c12983          	lw	s3,108(sp)
800040c0:	06012b03          	lw	s6,96(sp)
800040c4:	05c12b83          	lw	s7,92(sp)
800040c8:	05812c03          	lw	s8,88(sp)
800040cc:	05412c83          	lw	s9,84(sp)
800040d0:	05012d03          	lw	s10,80(sp)
800040d4:	04c12d83          	lw	s11,76(sp)
800040d8:	08010113          	add	sp,sp,128
800040dc:	00008067          	ret
800040e0:	04100913          	li	s2,65
800040e4:	f2dff06f          	j	80004010 <_ntoa_long+0x7c>
800040e8:	00000b93          	li	s7,0
800040ec:	02010993          	add	s3,sp,32
800040f0:	f8dff06f          	j	8000407c <_ntoa_long+0xe8>

800040f4 <_ntoa_long_long>:
800040f4:	f7010113          	add	sp,sp,-144
800040f8:	06812c23          	sw	s0,120(sp)
800040fc:	06912a23          	sw	s1,116(sp)
80004100:	07612023          	sw	s6,96(sp)
80004104:	05812c23          	sw	s8,88(sp)
80004108:	05912a23          	sw	s9,84(sp)
8000410c:	05a12823          	sw	s10,80(sp)
80004110:	05b12623          	sw	s11,76(sp)
80004114:	00078c13          	mv	s8,a5
80004118:	06112e23          	sw	ra,124(sp)
8000411c:	07312623          	sw	s3,108(sp)
80004120:	05712e23          	sw	s7,92(sp)
80004124:	09112623          	sw	a7,140(sp)
80004128:	00f767b3          	or	a5,a4,a5
8000412c:	00a12a23          	sw	a0,20(sp)
80004130:	00b12c23          	sw	a1,24(sp)
80004134:	00c12e23          	sw	a2,28(sp)
80004138:	09012c83          	lw	s9,144(sp)
8000413c:	09c12b03          	lw	s6,156(sp)
80004140:	00070413          	mv	s0,a4
80004144:	00068d13          	mv	s10,a3
80004148:	00080d93          	mv	s11,a6
8000414c:	00088493          	mv	s1,a7
80004150:	00079863          	bnez	a5,80004160 <_ntoa_long_long+0x6c>
80004154:	400b7793          	and	a5,s6,1024
80004158:	fefb7b13          	and	s6,s6,-17
8000415c:	10079c63          	bnez	a5,80004274 <_ntoa_long_long+0x180>
80004160:	005b5793          	srl	a5,s6,0x5
80004164:	07212823          	sw	s2,112(sp)
80004168:	07412423          	sw	s4,104(sp)
8000416c:	07512223          	sw	s5,100(sp)
80004170:	0017f793          	and	a5,a5,1
80004174:	06100913          	li	s2,97
80004178:	0e079a63          	bnez	a5,8000426c <_ntoa_long_long+0x178>
8000417c:	00000b93          	li	s7,0
80004180:	02010993          	add	s3,sp,32
80004184:	00900a13          	li	s4,9
80004188:	ff690913          	add	s2,s2,-10
8000418c:	02000a93          	li	s5,32
80004190:	000c8693          	mv	a3,s9
80004194:	00048613          	mv	a2,s1
80004198:	00040513          	mv	a0,s0
8000419c:	000c0593          	mv	a1,s8
800041a0:	e14fc0ef          	jal	800007b4 <__umoddi3>
800041a4:	0ff57513          	zext.b	a0,a0
800041a8:	01250833          	add	a6,a0,s2
800041ac:	03050693          	add	a3,a0,48
800041b0:	0ff87813          	zext.b	a6,a6
800041b4:	00aa6463          	bltu	s4,a0,800041bc <_ntoa_long_long+0xc8>
800041b8:	0ff6f813          	zext.b	a6,a3
800041bc:	001b8b93          	add	s7,s7,1
800041c0:	017988b3          	add	a7,s3,s7
800041c4:	00048613          	mv	a2,s1
800041c8:	000c8693          	mv	a3,s9
800041cc:	00040513          	mv	a0,s0
800041d0:	000c0593          	mv	a1,s8
800041d4:	ff088fa3          	sb	a6,-1(a7) # ffff <__stack_size+0xbfff>
800041d8:	9acfc0ef          	jal	80000384 <__udivdi3>
800041dc:	019c6e63          	bltu	s8,s9,800041f8 <_ntoa_long_long+0x104>
800041e0:	018c8a63          	beq	s9,s8,800041f4 <_ntoa_long_long+0x100>
800041e4:	015b8a63          	beq	s7,s5,800041f8 <_ntoa_long_long+0x104>
800041e8:	00050413          	mv	s0,a0
800041ec:	00058c13          	mv	s8,a1
800041f0:	fa1ff06f          	j	80004190 <_ntoa_long_long+0x9c>
800041f4:	fe9478e3          	bgeu	s0,s1,800041e4 <_ntoa_long_long+0xf0>
800041f8:	07012903          	lw	s2,112(sp)
800041fc:	06812a03          	lw	s4,104(sp)
80004200:	06412a83          	lw	s5,100(sp)
80004204:	09812703          	lw	a4,152(sp)
80004208:	01c12603          	lw	a2,28(sp)
8000420c:	01812583          	lw	a1,24(sp)
80004210:	00e12223          	sw	a4,4(sp)
80004214:	09412703          	lw	a4,148(sp)
80004218:	01412503          	lw	a0,20(sp)
8000421c:	01612423          	sw	s6,8(sp)
80004220:	00e12023          	sw	a4,0(sp)
80004224:	00048893          	mv	a7,s1
80004228:	000d8813          	mv	a6,s11
8000422c:	000b8793          	mv	a5,s7
80004230:	00098713          	mv	a4,s3
80004234:	000d0693          	mv	a3,s10
80004238:	a01ff0ef          	jal	80003c38 <_ntoa_format>
8000423c:	07c12083          	lw	ra,124(sp)
80004240:	07812403          	lw	s0,120(sp)
80004244:	07412483          	lw	s1,116(sp)
80004248:	06c12983          	lw	s3,108(sp)
8000424c:	06012b03          	lw	s6,96(sp)
80004250:	05c12b83          	lw	s7,92(sp)
80004254:	05812c03          	lw	s8,88(sp)
80004258:	05412c83          	lw	s9,84(sp)
8000425c:	05012d03          	lw	s10,80(sp)
80004260:	04c12d83          	lw	s11,76(sp)
80004264:	09010113          	add	sp,sp,144
80004268:	00008067          	ret
8000426c:	04100913          	li	s2,65
80004270:	f0dff06f          	j	8000417c <_ntoa_long_long+0x88>
80004274:	00000b93          	li	s7,0
80004278:	02010993          	add	s3,sp,32
8000427c:	f89ff06f          	j	80004204 <_ntoa_long_long+0x110>

80004280 <_etoa>:
80004280:	f8010113          	add	sp,sp,-128
80004284:	07212823          	sw	s2,112(sp)
80004288:	07312623          	sw	s3,108(sp)
8000428c:	07412423          	sw	s4,104(sp)
80004290:	07512223          	sw	s5,100(sp)
80004294:	00050993          	mv	s3,a0
80004298:	00058a13          	mv	s4,a1
8000429c:	00060913          	mv	s2,a2
800042a0:	00068a93          	mv	s5,a3
800042a4:	00070613          	mv	a2,a4
800042a8:	00078693          	mv	a3,a5
800042ac:	00070513          	mv	a0,a4
800042b0:	00078593          	mv	a1,a5
800042b4:	06812c23          	sw	s0,120(sp)
800042b8:	06912a23          	sw	s1,116(sp)
800042bc:	07612023          	sw	s6,96(sp)
800042c0:	05812c23          	sw	s8,88(sp)
800042c4:	05912a23          	sw	s9,84(sp)
800042c8:	06112e23          	sw	ra,124(sp)
800042cc:	08012c83          	lw	s9,128(sp)
800042d0:	00070413          	mv	s0,a4
800042d4:	00078493          	mv	s1,a5
800042d8:	00080c13          	mv	s8,a6
800042dc:	00088b13          	mv	s6,a7
800042e0:	f28fd0ef          	jal	80001a08 <__eqdf2>
800042e4:	4e051e63          	bnez	a0,800047e0 <_etoa+0x560>
800042e8:	a00016b7          	lui	a3,0xa0001
800042ec:	ee06a603          	lw	a2,-288(a3) # a0000ee0 <pow10.0+0x50>
800042f0:	ee46a683          	lw	a3,-284(a3)
800042f4:	00040513          	mv	a0,s0
800042f8:	00048593          	mv	a1,s1
800042fc:	f98fd0ef          	jal	80001a94 <__gedf2>
80004300:	4ea04063          	bgtz	a0,800047e0 <_etoa+0x560>
80004304:	a00016b7          	lui	a3,0xa0001
80004308:	ee86a603          	lw	a2,-280(a3) # a0000ee8 <pow10.0+0x58>
8000430c:	eec6a683          	lw	a3,-276(a3)
80004310:	00040513          	mv	a0,s0
80004314:	00048593          	mv	a1,s1
80004318:	859fd0ef          	jal	80001b70 <__ledf2>
8000431c:	4c054263          	bltz	a0,800047e0 <_etoa+0x560>
80004320:	00040513          	mv	a0,s0
80004324:	00048593          	mv	a1,s1
80004328:	00000613          	li	a2,0
8000432c:	00000693          	li	a3,0
80004330:	05712e23          	sw	s7,92(sp)
80004334:	05a12823          	sw	s10,80(sp)
80004338:	05b12623          	sw	s11,76(sp)
8000433c:	835fd0ef          	jal	80001b70 <__ledf2>
80004340:	02812223          	sw	s0,36(sp)
80004344:	00048b93          	mv	s7,s1
80004348:	00055663          	bgez	a0,80004354 <_etoa+0xd4>
8000434c:	80000bb7          	lui	s7,0x80000
80004350:	009bcbb3          	xor	s7,s7,s1
80004354:	400cf793          	and	a5,s9,1024
80004358:	02f12e23          	sw	a5,60(sp)
8000435c:	00079463          	bnez	a5,80004364 <_etoa+0xe4>
80004360:	00600c13          	li	s8,6
80004364:	014bd513          	srl	a0,s7,0x14
80004368:	7ff57513          	and	a0,a0,2047
8000436c:	c0150513          	add	a0,a0,-1023
80004370:	f70fe0ef          	jal	80002ae0 <__floatsidf>
80004374:	a00017b7          	lui	a5,0xa0001
80004378:	ef07a603          	lw	a2,-272(a5) # a0000ef0 <pow10.0+0x60>
8000437c:	ef47a683          	lw	a3,-268(a5)
80004380:	8cdfd0ef          	jal	80001c4c <__muldf3>
80004384:	a00017b7          	lui	a5,0xa0001
80004388:	ef87a603          	lw	a2,-264(a5) # a0000ef8 <pow10.0+0x68>
8000438c:	efc7a683          	lw	a3,-260(a5)
80004390:	809fc0ef          	jal	80000b98 <__adddf3>
80004394:	00cb9693          	sll	a3,s7,0xc
80004398:	00c6d693          	srl	a3,a3,0xc
8000439c:	3ff007b7          	lui	a5,0x3ff00
800043a0:	00d7e7b3          	or	a5,a5,a3
800043a4:	a00016b7          	lui	a3,0xa0001
800043a8:	f006a603          	lw	a2,-256(a3) # a0000f00 <pow10.0+0x70>
800043ac:	f046a683          	lw	a3,-252(a3)
800043b0:	00050d93          	mv	s11,a0
800043b4:	00058d13          	mv	s10,a1
800043b8:	00040513          	mv	a0,s0
800043bc:	00078593          	mv	a1,a5
800043c0:	e7dfd0ef          	jal	8000223c <__subdf3>
800043c4:	a00017b7          	lui	a5,0xa0001
800043c8:	f087a603          	lw	a2,-248(a5) # a0000f08 <pow10.0+0x78>
800043cc:	f0c7a683          	lw	a3,-244(a5)
800043d0:	87dfd0ef          	jal	80001c4c <__muldf3>
800043d4:	00050613          	mv	a2,a0
800043d8:	00058693          	mv	a3,a1
800043dc:	000d8513          	mv	a0,s11
800043e0:	000d0593          	mv	a1,s10
800043e4:	fb4fc0ef          	jal	80000b98 <__adddf3>
800043e8:	dfcfe0ef          	jal	800029e4 <__fixdfsi>
800043ec:	00050d13          	mv	s10,a0
800043f0:	ef0fe0ef          	jal	80002ae0 <__floatsidf>
800043f4:	a00017b7          	lui	a5,0xa0001
800043f8:	f107a603          	lw	a2,-240(a5) # a0000f10 <pow10.0+0x80>
800043fc:	f147a683          	lw	a3,-236(a5)
80004400:	00058d93          	mv	s11,a1
80004404:	00a12c23          	sw	a0,24(sp)
80004408:	845fd0ef          	jal	80001c4c <__muldf3>
8000440c:	a0001737          	lui	a4,0xa0001
80004410:	f1872603          	lw	a2,-232(a4) # a0000f18 <pow10.0+0x88>
80004414:	f1c72683          	lw	a3,-228(a4)
80004418:	f80fc0ef          	jal	80000b98 <__adddf3>
8000441c:	dc8fe0ef          	jal	800029e4 <__fixdfsi>
80004420:	01812783          	lw	a5,24(sp)
80004424:	a00016b7          	lui	a3,0xa0001
80004428:	f206a603          	lw	a2,-224(a3) # a0000f20 <pow10.0+0x90>
8000442c:	f246a683          	lw	a3,-220(a3)
80004430:	00050713          	mv	a4,a0
80004434:	000d8593          	mv	a1,s11
80004438:	00078513          	mv	a0,a5
8000443c:	00070d93          	mv	s11,a4
80004440:	80dfd0ef          	jal	80001c4c <__muldf3>
80004444:	00050793          	mv	a5,a0
80004448:	000d8513          	mv	a0,s11
8000444c:	00f12c23          	sw	a5,24(sp)
80004450:	03b12423          	sw	s11,40(sp)
80004454:	00058d93          	mv	s11,a1
80004458:	e88fe0ef          	jal	80002ae0 <__floatsidf>
8000445c:	a0001737          	lui	a4,0xa0001
80004460:	f2872603          	lw	a2,-216(a4) # a0000f28 <pow10.0+0x98>
80004464:	f2c72683          	lw	a3,-212(a4)
80004468:	fe4fd0ef          	jal	80001c4c <__muldf3>
8000446c:	01812783          	lw	a5,24(sp)
80004470:	00050613          	mv	a2,a0
80004474:	00058693          	mv	a3,a1
80004478:	00078513          	mv	a0,a5
8000447c:	000d8593          	mv	a1,s11
80004480:	dbdfd0ef          	jal	8000223c <__subdf3>
80004484:	00050613          	mv	a2,a0
80004488:	00058693          	mv	a3,a1
8000448c:	02a12623          	sw	a0,44(sp)
80004490:	00b12c23          	sw	a1,24(sp)
80004494:	fb8fd0ef          	jal	80001c4c <__muldf3>
80004498:	01812783          	lw	a5,24(sp)
8000449c:	02c12703          	lw	a4,44(sp)
800044a0:	00050d93          	mv	s11,a0
800044a4:	00078693          	mv	a3,a5
800044a8:	00070613          	mv	a2,a4
800044ac:	00070513          	mv	a0,a4
800044b0:	00058813          	mv	a6,a1
800044b4:	00078593          	mv	a1,a5
800044b8:	02e12c23          	sw	a4,56(sp)
800044bc:	02f12a23          	sw	a5,52(sp)
800044c0:	01012c23          	sw	a6,24(sp)
800044c4:	ed4fc0ef          	jal	80000b98 <__adddf3>
800044c8:	a00016b7          	lui	a3,0xa0001
800044cc:	00058893          	mv	a7,a1
800044d0:	f306a603          	lw	a2,-208(a3) # a0000f30 <pow10.0+0xa0>
800044d4:	01812583          	lw	a1,24(sp)
800044d8:	f346a683          	lw	a3,-204(a3)
800044dc:	00050313          	mv	t1,a0
800044e0:	000d8513          	mv	a0,s11
800044e4:	02612823          	sw	t1,48(sp)
800044e8:	03112623          	sw	a7,44(sp)
800044ec:	e41fc0ef          	jal	8000132c <__divdf3>
800044f0:	a0001837          	lui	a6,0xa0001
800044f4:	f3882603          	lw	a2,-200(a6) # a0000f38 <pow10.0+0xa8>
800044f8:	f3c82683          	lw	a3,-196(a6)
800044fc:	e9cfc0ef          	jal	80000b98 <__adddf3>
80004500:	00058693          	mv	a3,a1
80004504:	01812583          	lw	a1,24(sp)
80004508:	00050613          	mv	a2,a0
8000450c:	000d8513          	mv	a0,s11
80004510:	e1dfc0ef          	jal	8000132c <__divdf3>
80004514:	a00016b7          	lui	a3,0xa0001
80004518:	f406a603          	lw	a2,-192(a3) # a0000f40 <pow10.0+0xb0>
8000451c:	f446a683          	lw	a3,-188(a3)
80004520:	e78fc0ef          	jal	80000b98 <__adddf3>
80004524:	00058693          	mv	a3,a1
80004528:	01812583          	lw	a1,24(sp)
8000452c:	00050613          	mv	a2,a0
80004530:	000d8513          	mv	a0,s11
80004534:	df9fc0ef          	jal	8000132c <__divdf3>
80004538:	03812703          	lw	a4,56(sp)
8000453c:	03412783          	lw	a5,52(sp)
80004540:	a00016b7          	lui	a3,0xa0001
80004544:	00050e13          	mv	t3,a0
80004548:	00058d93          	mv	s11,a1
8000454c:	f486a503          	lw	a0,-184(a3) # a0000f48 <pow10.0+0xb8>
80004550:	f4c6a583          	lw	a1,-180(a3)
80004554:	00070613          	mv	a2,a4
80004558:	00078693          	mv	a3,a5
8000455c:	01c12c23          	sw	t3,24(sp)
80004560:	cddfd0ef          	jal	8000223c <__subdf3>
80004564:	01812e03          	lw	t3,24(sp)
80004568:	00050613          	mv	a2,a0
8000456c:	00058693          	mv	a3,a1
80004570:	000e0513          	mv	a0,t3
80004574:	000d8593          	mv	a1,s11
80004578:	e20fc0ef          	jal	80000b98 <__adddf3>
8000457c:	03012303          	lw	t1,48(sp)
80004580:	02c12883          	lw	a7,44(sp)
80004584:	00050613          	mv	a2,a0
80004588:	00058693          	mv	a3,a1
8000458c:	00030513          	mv	a0,t1
80004590:	00088593          	mv	a1,a7
80004594:	d99fc0ef          	jal	8000132c <__divdf3>
80004598:	a00017b7          	lui	a5,0xa0001
8000459c:	f507a603          	lw	a2,-176(a5) # a0000f50 <pow10.0+0xc0>
800045a0:	f547a683          	lw	a3,-172(a5)
800045a4:	df4fc0ef          	jal	80000b98 <__adddf3>
800045a8:	02812783          	lw	a5,40(sp)
800045ac:	00000613          	li	a2,0
800045b0:	3ff78793          	add	a5,a5,1023
800045b4:	01479793          	sll	a5,a5,0x14
800045b8:	00078693          	mv	a3,a5
800045bc:	e90fd0ef          	jal	80001c4c <__muldf3>
800045c0:	00040613          	mv	a2,s0
800045c4:	000b8693          	mv	a3,s7
800045c8:	00050d93          	mv	s11,a0
800045cc:	00b12c23          	sw	a1,24(sp)
800045d0:	cc4fd0ef          	jal	80001a94 <__gedf2>
800045d4:	a0001837          	lui	a6,0xa0001
800045d8:	24a04e63          	bgtz	a0,80004834 <_etoa+0x5b4>
800045dc:	01812783          	lw	a5,24(sp)
800045e0:	000d8713          	mv	a4,s11
800045e4:	0c600693          	li	a3,198
800045e8:	063d0d93          	add	s11,s10,99
800045ec:	01b6bdb3          	sltu	s11,a3,s11
800045f0:	014c9693          	sll	a3,s9,0x14
800045f4:	004d8d93          	add	s11,s11,4
800045f8:	0606d263          	bgez	a3,8000465c <_etoa+0x3dc>
800045fc:	a00016b7          	lui	a3,0xa0001
80004600:	f586a603          	lw	a2,-168(a3) # a0000f58 <pow10.0+0xc8>
80004604:	f5c6a683          	lw	a3,-164(a3)
80004608:	00040513          	mv	a0,s0
8000460c:	000b8593          	mv	a1,s7
80004610:	00e12c23          	sw	a4,24(sp)
80004614:	00f12e23          	sw	a5,28(sp)
80004618:	c7cfd0ef          	jal	80001a94 <__gedf2>
8000461c:	01812703          	lw	a4,24(sp)
80004620:	01c12783          	lw	a5,28(sp)
80004624:	02054463          	bltz	a0,8000464c <_etoa+0x3cc>
80004628:	a00016b7          	lui	a3,0xa0001
8000462c:	f606a603          	lw	a2,-160(a3) # a0000f60 <pow10.0+0xd0>
80004630:	f646a683          	lw	a3,-156(a3)
80004634:	00040513          	mv	a0,s0
80004638:	000b8593          	mv	a1,s7
8000463c:	d34fd0ef          	jal	80001b70 <__ledf2>
80004640:	01812703          	lw	a4,24(sp)
80004644:	01c12783          	lw	a5,28(sp)
80004648:	20054863          	bltz	a0,80004858 <_etoa+0x5d8>
8000464c:	000c0863          	beqz	s8,8000465c <_etoa+0x3dc>
80004650:	03c12683          	lw	a3,60(sp)
80004654:	00d036b3          	snez	a3,a3
80004658:	40dc0c33          	sub	s8,s8,a3
8000465c:	00000893          	li	a7,0
80004660:	016df463          	bgeu	s11,s6,80004668 <_etoa+0x3e8>
80004664:	41bb08b3          	sub	a7,s6,s11
80004668:	002cf693          	and	a3,s9,2
8000466c:	02d12423          	sw	a3,40(sp)
80004670:	00068863          	beqz	a3,80004680 <_etoa+0x400>
80004674:	001db693          	seqz	a3,s11
80004678:	40d006b3          	neg	a3,a3
8000467c:	00d8f8b3          	and	a7,a7,a3
80004680:	020d0463          	beqz	s10,800046a8 <_etoa+0x428>
80004684:	000b8593          	mv	a1,s7
80004688:	00040513          	mv	a0,s0
8000468c:	00070613          	mv	a2,a4
80004690:	00078693          	mv	a3,a5
80004694:	01112c23          	sw	a7,24(sp)
80004698:	c95fc0ef          	jal	8000132c <__divdf3>
8000469c:	01812883          	lw	a7,24(sp)
800046a0:	02a12223          	sw	a0,36(sp)
800046a4:	00058b93          	mv	s7,a1
800046a8:	00040513          	mv	a0,s0
800046ac:	00048593          	mv	a1,s1
800046b0:	00000613          	li	a2,0
800046b4:	00000693          	li	a3,0
800046b8:	01112c23          	sw	a7,24(sp)
800046bc:	cb4fd0ef          	jal	80001b70 <__ledf2>
800046c0:	01812883          	lw	a7,24(sp)
800046c4:	00055663          	bgez	a0,800046d0 <_etoa+0x450>
800046c8:	800007b7          	lui	a5,0x80000
800046cc:	0177cbb3          	xor	s7,a5,s7
800046d0:	02412683          	lw	a3,36(sp)
800046d4:	fffff7b7          	lui	a5,0xfffff
800046d8:	7ff78793          	add	a5,a5,2047 # fffff7ff <__stack_base+0x5ffef7ff>
800046dc:	00fcf7b3          	and	a5,s9,a5
800046e0:	00f12023          	sw	a5,0(sp)
800046e4:	00068713          	mv	a4,a3
800046e8:	000c0813          	mv	a6,s8
800046ec:	000b8793          	mv	a5,s7
800046f0:	000a8693          	mv	a3,s5
800046f4:	00090613          	mv	a2,s2
800046f8:	000a0593          	mv	a1,s4
800046fc:	00098513          	mv	a0,s3
80004700:	17c000ef          	jal	8000487c <_ftoa>
80004704:	00050413          	mv	s0,a0
80004708:	080d8c63          	beqz	s11,800047a0 <_etoa+0x520>
8000470c:	020cfc93          	and	s9,s9,32
80004710:	06500513          	li	a0,101
80004714:	000c8463          	beqz	s9,8000471c <_etoa+0x49c>
80004718:	04500513          	li	a0,69
8000471c:	00040613          	mv	a2,s0
80004720:	000a8693          	mv	a3,s5
80004724:	000a0593          	mv	a1,s4
80004728:	000980e7          	jalr	s3
8000472c:	41fd5713          	sra	a4,s10,0x1f
80004730:	00140413          	add	s0,s0,1
80004734:	01a746b3          	xor	a3,a4,s10
80004738:	00500793          	li	a5,5
8000473c:	fffd8d93          	add	s11,s11,-1
80004740:	00f12223          	sw	a5,4(sp)
80004744:	40e68733          	sub	a4,a3,a4
80004748:	01fd5793          	srl	a5,s10,0x1f
8000474c:	00040613          	mv	a2,s0
80004750:	01b12023          	sw	s11,0(sp)
80004754:	00000893          	li	a7,0
80004758:	00a00813          	li	a6,10
8000475c:	000a8693          	mv	a3,s5
80004760:	000a0593          	mv	a1,s4
80004764:	00098513          	mv	a0,s3
80004768:	82dff0ef          	jal	80003f94 <_ntoa_long>
8000476c:	02812783          	lw	a5,40(sp)
80004770:	00050413          	mv	s0,a0
80004774:	02078663          	beqz	a5,800047a0 <_etoa+0x520>
80004778:	41250933          	sub	s2,a0,s2
8000477c:	03697263          	bgeu	s2,s6,800047a0 <_etoa+0x520>
80004780:	00040613          	mv	a2,s0
80004784:	000a8693          	mv	a3,s5
80004788:	000a0593          	mv	a1,s4
8000478c:	02000513          	li	a0,32
80004790:	00190913          	add	s2,s2,1
80004794:	00140413          	add	s0,s0,1
80004798:	000980e7          	jalr	s3
8000479c:	ff6962e3          	bltu	s2,s6,80004780 <_etoa+0x500>
800047a0:	07c12083          	lw	ra,124(sp)
800047a4:	00040513          	mv	a0,s0
800047a8:	07812403          	lw	s0,120(sp)
800047ac:	05c12b83          	lw	s7,92(sp)
800047b0:	05012d03          	lw	s10,80(sp)
800047b4:	04c12d83          	lw	s11,76(sp)
800047b8:	07412483          	lw	s1,116(sp)
800047bc:	07012903          	lw	s2,112(sp)
800047c0:	06c12983          	lw	s3,108(sp)
800047c4:	06812a03          	lw	s4,104(sp)
800047c8:	06412a83          	lw	s5,100(sp)
800047cc:	06012b03          	lw	s6,96(sp)
800047d0:	05812c03          	lw	s8,88(sp)
800047d4:	05412c83          	lw	s9,84(sp)
800047d8:	08010113          	add	sp,sp,128
800047dc:	00008067          	ret
800047e0:	00040713          	mv	a4,s0
800047e4:	07812403          	lw	s0,120(sp)
800047e8:	09912023          	sw	s9,128(sp)
800047ec:	07c12083          	lw	ra,124(sp)
800047f0:	05412c83          	lw	s9,84(sp)
800047f4:	00048793          	mv	a5,s1
800047f8:	000b0893          	mv	a7,s6
800047fc:	07412483          	lw	s1,116(sp)
80004800:	06012b03          	lw	s6,96(sp)
80004804:	000c0813          	mv	a6,s8
80004808:	000a8693          	mv	a3,s5
8000480c:	05812c03          	lw	s8,88(sp)
80004810:	06412a83          	lw	s5,100(sp)
80004814:	00090613          	mv	a2,s2
80004818:	000a0593          	mv	a1,s4
8000481c:	07012903          	lw	s2,112(sp)
80004820:	06812a03          	lw	s4,104(sp)
80004824:	00098513          	mv	a0,s3
80004828:	06c12983          	lw	s3,108(sp)
8000482c:	08010113          	add	sp,sp,128
80004830:	04c0006f          	j	8000487c <_ftoa>
80004834:	f3882603          	lw	a2,-200(a6) # a0000f38 <pow10.0+0xa8>
80004838:	f3c82683          	lw	a3,-196(a6)
8000483c:	01812583          	lw	a1,24(sp)
80004840:	000d8513          	mv	a0,s11
80004844:	fffd0d13          	add	s10,s10,-1
80004848:	ae5fc0ef          	jal	8000132c <__divdf3>
8000484c:	00050713          	mv	a4,a0
80004850:	00058793          	mv	a5,a1
80004854:	d91ff06f          	j	800045e4 <_etoa+0x364>
80004858:	018d5e63          	bge	s10,s8,80004874 <_etoa+0x5f4>
8000485c:	41ac0d33          	sub	s10,s8,s10
80004860:	fffd0c13          	add	s8,s10,-1
80004864:	400cec93          	or	s9,s9,1024
80004868:	00000d93          	li	s11,0
8000486c:	00000d13          	li	s10,0
80004870:	dedff06f          	j	8000465c <_etoa+0x3dc>
80004874:	00000c13          	li	s8,0
80004878:	fedff06f          	j	80004864 <_etoa+0x5e4>

8000487c <_ftoa>:
8000487c:	f8010113          	add	sp,sp,-128
80004880:	07512223          	sw	s5,100(sp)
80004884:	05812c23          	sw	s8,88(sp)
80004888:	05912a23          	sw	s9,84(sp)
8000488c:	05a12823          	sw	s10,80(sp)
80004890:	00050a93          	mv	s5,a0
80004894:	00058c13          	mv	s8,a1
80004898:	00060c93          	mv	s9,a2
8000489c:	00068d13          	mv	s10,a3
800048a0:	00070613          	mv	a2,a4
800048a4:	00078693          	mv	a3,a5
800048a8:	00070513          	mv	a0,a4
800048ac:	00078593          	mv	a1,a5
800048b0:	06812c23          	sw	s0,120(sp)
800048b4:	06912a23          	sw	s1,116(sp)
800048b8:	07212823          	sw	s2,112(sp)
800048bc:	07412423          	sw	s4,104(sp)
800048c0:	05b12623          	sw	s11,76(sp)
800048c4:	06112e23          	sw	ra,124(sp)
800048c8:	08012d83          	lw	s11,128(sp)
800048cc:	00070913          	mv	s2,a4
800048d0:	00078493          	mv	s1,a5
800048d4:	01512823          	sw	s5,16(sp)
800048d8:	00080413          	mv	s0,a6
800048dc:	00088a13          	mv	s4,a7
800048e0:	928fd0ef          	jal	80001a08 <__eqdf2>
800048e4:	2e051863          	bnez	a0,80004bd4 <_ftoa+0x358>
800048e8:	a00017b7          	lui	a5,0xa0001
800048ec:	ee87a603          	lw	a2,-280(a5) # a0000ee8 <pow10.0+0x58>
800048f0:	eec7a683          	lw	a3,-276(a5)
800048f4:	00090513          	mv	a0,s2
800048f8:	00048593          	mv	a1,s1
800048fc:	a74fd0ef          	jal	80001b70 <__ledf2>
80004900:	3a054c63          	bltz	a0,80004cb8 <_ftoa+0x43c>
80004904:	a00017b7          	lui	a5,0xa0001
80004908:	ee07a603          	lw	a2,-288(a5) # a0000ee0 <pow10.0+0x50>
8000490c:	ee47a683          	lw	a3,-284(a5)
80004910:	00090513          	mv	a0,s2
80004914:	00048593          	mv	a1,s1
80004918:	97cfd0ef          	jal	80001a94 <__gedf2>
8000491c:	28a04463          	bgtz	a0,80004ba4 <_ftoa+0x328>
80004920:	07312623          	sw	s3,108(sp)
80004924:	a00019b7          	lui	s3,0xa0001
80004928:	f689a603          	lw	a2,-152(s3) # a0000f68 <pow10.0+0xd8>
8000492c:	f6c9a683          	lw	a3,-148(s3)
80004930:	00090513          	mv	a0,s2
80004934:	00048593          	mv	a1,s1
80004938:	95cfd0ef          	jal	80001a94 <__gedf2>
8000493c:	32a04263          	bgtz	a0,80004c60 <_ftoa+0x3e4>
80004940:	a00017b7          	lui	a5,0xa0001
80004944:	f707a603          	lw	a2,-144(a5) # a0000f70 <pow10.0+0xe0>
80004948:	f747a683          	lw	a3,-140(a5)
8000494c:	00090513          	mv	a0,s2
80004950:	00048593          	mv	a1,s1
80004954:	a1cfd0ef          	jal	80001b70 <__ledf2>
80004958:	30054463          	bltz	a0,80004c60 <_ftoa+0x3e4>
8000495c:	00090513          	mv	a0,s2
80004960:	00048593          	mv	a1,s1
80004964:	00000613          	li	a2,0
80004968:	00000693          	li	a3,0
8000496c:	07612023          	sw	s6,96(sp)
80004970:	05712e23          	sw	s7,92(sp)
80004974:	9fcfd0ef          	jal	80001b70 <__ledf2>
80004978:	2c054063          	bltz	a0,80004c38 <_ftoa+0x3bc>
8000497c:	00012e23          	sw	zero,28(sp)
80004980:	400dfb93          	and	s7,s11,1024
80004984:	3a0b8863          	beqz	s7,80004d34 <_ftoa+0x4b8>
80004988:	00900793          	li	a5,9
8000498c:	4c87fa63          	bgeu	a5,s0,80004e60 <_ftoa+0x5e4>
80004990:	ff740b93          	add	s7,s0,-9
80004994:	00000693          	li	a3,0
80004998:	02010b13          	add	s6,sp,32
8000499c:	03000513          	li	a0,48
800049a0:	02000593          	li	a1,32
800049a4:	00168693          	add	a3,a3,1
800049a8:	00db0633          	add	a2,s6,a3
800049ac:	fea60fa3          	sb	a0,-1(a2)
800049b0:	40d40ab3          	sub	s5,s0,a3
800049b4:	40b68663          	beq	a3,a1,80004dc0 <_ftoa+0x544>
800049b8:	ff7696e3          	bne	a3,s7,800049a4 <_ftoa+0x128>
800049bc:	f689a783          	lw	a5,-152(s3)
800049c0:	f6c9a803          	lw	a6,-148(s3)
800049c4:	00f12423          	sw	a5,8(sp)
800049c8:	01012623          	sw	a6,12(sp)
800049cc:	00048593          	mv	a1,s1
800049d0:	00090513          	mv	a0,s2
800049d4:	810fe0ef          	jal	800029e4 <__fixdfsi>
800049d8:	00050413          	mv	s0,a0
800049dc:	904fe0ef          	jal	80002ae0 <__floatsidf>
800049e0:	00050613          	mv	a2,a0
800049e4:	00058693          	mv	a3,a1
800049e8:	00090513          	mv	a0,s2
800049ec:	00048593          	mv	a1,s1
800049f0:	84dfd0ef          	jal	8000223c <__subdf3>
800049f4:	00812603          	lw	a2,8(sp)
800049f8:	00c12683          	lw	a3,12(sp)
800049fc:	a50fd0ef          	jal	80001c4c <__muldf3>
80004a00:	00b12a23          	sw	a1,20(sp)
80004a04:	00a12c23          	sw	a0,24(sp)
80004a08:	85cfe0ef          	jal	80002a64 <__fixunsdfsi>
80004a0c:	00050993          	mv	s3,a0
80004a10:	978fe0ef          	jal	80002b88 <__floatunsidf>
80004a14:	01812303          	lw	t1,24(sp)
80004a18:	01412883          	lw	a7,20(sp)
80004a1c:	00050613          	mv	a2,a0
80004a20:	00058693          	mv	a3,a1
80004a24:	00030513          	mv	a0,t1
80004a28:	00088593          	mv	a1,a7
80004a2c:	811fd0ef          	jal	8000223c <__subdf3>
80004a30:	a00017b7          	lui	a5,0xa0001
80004a34:	f187a603          	lw	a2,-232(a5) # a0000f18 <pow10.0+0x88>
80004a38:	f1c7a683          	lw	a3,-228(a5)
80004a3c:	00a12a23          	sw	a0,20(sp)
80004a40:	00b12c23          	sw	a1,24(sp)
80004a44:	850fd0ef          	jal	80001a94 <__gedf2>
80004a48:	28a05463          	blez	a0,80004cd0 <_ftoa+0x454>
80004a4c:	00198993          	add	s3,s3,1
80004a50:	00098513          	mv	a0,s3
80004a54:	934fe0ef          	jal	80002b88 <__floatunsidf>
80004a58:	00812603          	lw	a2,8(sp)
80004a5c:	00c12683          	lw	a3,12(sp)
80004a60:	834fd0ef          	jal	80001a94 <__gedf2>
80004a64:	00054663          	bltz	a0,80004a70 <_ftoa+0x1f4>
80004a68:	00140413          	add	s0,s0,1
80004a6c:	00000993          	li	s3,0
80004a70:	280a8463          	beqz	s5,80004cf8 <_ftoa+0x47c>
80004a74:	02000493          	li	s1,32
80004a78:	0300006f          	j	80004aa8 <_ftoa+0x22c>
80004a7c:	b15fe0ef          	jal	80003590 <__umodsi3>
80004a80:	001b8b93          	add	s7,s7,1 # 80000001 <__start+0x1>
80004a84:	03050693          	add	a3,a0,48
80004a88:	017b0933          	add	s2,s6,s7
80004a8c:	00a00593          	li	a1,10
80004a90:	00098513          	mv	a0,s3
80004a94:	fed90fa3          	sb	a3,-1(s2)
80004a98:	ab1fe0ef          	jal	80003548 <__hidden___udivsi3>
80004a9c:	00900793          	li	a5,9
80004aa0:	2f37f663          	bgeu	a5,s3,80004d8c <_ftoa+0x510>
80004aa4:	00050993          	mv	s3,a0
80004aa8:	00a00593          	li	a1,10
80004aac:	00098513          	mv	a0,s3
80004ab0:	fffa8a93          	add	s5,s5,-1
80004ab4:	fc9b94e3          	bne	s7,s1,80004a7c <_ftoa+0x200>
80004ab8:	02000b93          	li	s7,32
80004abc:	02000493          	li	s1,32
80004ac0:	02c0006f          	j	80004aec <_ftoa+0x270>
80004ac4:	b01fe0ef          	jal	800035c4 <__modsi3>
80004ac8:	001b8b93          	add	s7,s7,1
80004acc:	03050693          	add	a3,a0,48
80004ad0:	017b0933          	add	s2,s6,s7
80004ad4:	00040513          	mv	a0,s0
80004ad8:	00a00593          	li	a1,10
80004adc:	fed90fa3          	sb	a3,-1(s2)
80004ae0:	a61fe0ef          	jal	80003540 <__divsi3>
80004ae4:	00050413          	mv	s0,a0
80004ae8:	26050663          	beqz	a0,80004d54 <_ftoa+0x4d8>
80004aec:	00a00593          	li	a1,10
80004af0:	00040513          	mv	a0,s0
80004af4:	fc9b98e3          	bne	s7,s1,80004ac4 <_ftoa+0x248>
80004af8:	003df693          	and	a3,s11,3
80004afc:	00100613          	li	a2,1
80004b00:	04c69263          	bne	a3,a2,80004b44 <_ftoa+0x2c8>
80004b04:	040a0063          	beqz	s4,80004b44 <_ftoa+0x2c8>
80004b08:	01c12783          	lw	a5,28(sp)
80004b0c:	34079463          	bnez	a5,80004e54 <_ftoa+0x5d8>
80004b10:	00cdf693          	and	a3,s11,12
80004b14:	34069063          	bnez	a3,80004e54 <_ftoa+0x5d8>
80004b18:	2d4bf063          	bgeu	s7,s4,80004dd8 <_ftoa+0x55c>
80004b1c:	02000693          	li	a3,32
80004b20:	03000613          	li	a2,48
80004b24:	02000593          	li	a1,32
80004b28:	00db8c63          	beq	s7,a3,80004b40 <_ftoa+0x2c4>
80004b2c:	001b8b93          	add	s7,s7,1
80004b30:	017b06b3          	add	a3,s6,s7
80004b34:	fec68fa3          	sb	a2,-1(a3)
80004b38:	237a0463          	beq	s4,s7,80004d60 <_ftoa+0x4e4>
80004b3c:	febb98e3          	bne	s7,a1,80004b2c <_ftoa+0x2b0>
80004b40:	02000b93          	li	s7,32
80004b44:	01012503          	lw	a0,16(sp)
80004b48:	000d8893          	mv	a7,s11
80004b4c:	000a0813          	mv	a6,s4
80004b50:	000b8793          	mv	a5,s7
80004b54:	000b0713          	mv	a4,s6
80004b58:	000d0693          	mv	a3,s10
80004b5c:	000c8613          	mv	a2,s9
80004b60:	000c0593          	mv	a1,s8
80004b64:	f9dfe0ef          	jal	80003b00 <_out_rev>
80004b68:	07c12083          	lw	ra,124(sp)
80004b6c:	07812403          	lw	s0,120(sp)
80004b70:	06c12983          	lw	s3,108(sp)
80004b74:	06012b03          	lw	s6,96(sp)
80004b78:	05c12b83          	lw	s7,92(sp)
80004b7c:	07412483          	lw	s1,116(sp)
80004b80:	07012903          	lw	s2,112(sp)
80004b84:	06812a03          	lw	s4,104(sp)
80004b88:	06412a83          	lw	s5,100(sp)
80004b8c:	05812c03          	lw	s8,88(sp)
80004b90:	05412c83          	lw	s9,84(sp)
80004b94:	05012d03          	lw	s10,80(sp)
80004b98:	04c12d83          	lw	s11,76(sp)
80004b9c:	08010113          	add	sp,sp,128
80004ba0:	00008067          	ret
80004ba4:	004df793          	and	a5,s11,4
80004ba8:	08079063          	bnez	a5,80004c28 <_ftoa+0x3ac>
80004bac:	a0000737          	lui	a4,0xa0000
80004bb0:	61870713          	add	a4,a4,1560 # a0000618 <__clz_tab+0x5a0>
80004bb4:	00300793          	li	a5,3
80004bb8:	000d8893          	mv	a7,s11
80004bbc:	000a0813          	mv	a6,s4
80004bc0:	01012503          	lw	a0,16(sp)
80004bc4:	000d0693          	mv	a3,s10
80004bc8:	000c8613          	mv	a2,s9
80004bcc:	000c0593          	mv	a1,s8
80004bd0:	0280006f          	j	80004bf8 <_ftoa+0x37c>
80004bd4:	a0000737          	lui	a4,0xa0000
80004bd8:	000d8893          	mv	a7,s11
80004bdc:	000a0813          	mv	a6,s4
80004be0:	00300793          	li	a5,3
80004be4:	61c70713          	add	a4,a4,1564 # a000061c <__clz_tab+0x5a4>
80004be8:	000d0693          	mv	a3,s10
80004bec:	000c8613          	mv	a2,s9
80004bf0:	000c0593          	mv	a1,s8
80004bf4:	000a8513          	mv	a0,s5
80004bf8:	07812403          	lw	s0,120(sp)
80004bfc:	07c12083          	lw	ra,124(sp)
80004c00:	07412483          	lw	s1,116(sp)
80004c04:	07012903          	lw	s2,112(sp)
80004c08:	06812a03          	lw	s4,104(sp)
80004c0c:	06412a83          	lw	s5,100(sp)
80004c10:	05812c03          	lw	s8,88(sp)
80004c14:	05412c83          	lw	s9,84(sp)
80004c18:	05012d03          	lw	s10,80(sp)
80004c1c:	04c12d83          	lw	s11,76(sp)
80004c20:	08010113          	add	sp,sp,128
80004c24:	eddfe06f          	j	80003b00 <_out_rev>
80004c28:	a0000737          	lui	a4,0xa0000
80004c2c:	61070713          	add	a4,a4,1552 # a0000610 <__clz_tab+0x598>
80004c30:	00400793          	li	a5,4
80004c34:	f85ff06f          	j	80004bb8 <_ftoa+0x33c>
80004c38:	00090613          	mv	a2,s2
80004c3c:	00048693          	mv	a3,s1
80004c40:	00000513          	li	a0,0
80004c44:	00000593          	li	a1,0
80004c48:	df4fd0ef          	jal	8000223c <__subdf3>
80004c4c:	00100793          	li	a5,1
80004c50:	00050913          	mv	s2,a0
80004c54:	00058493          	mv	s1,a1
80004c58:	00f12e23          	sw	a5,28(sp)
80004c5c:	d25ff06f          	j	80004980 <_ftoa+0x104>
80004c60:	00040813          	mv	a6,s0
80004c64:	07812403          	lw	s0,120(sp)
80004c68:	09b12023          	sw	s11,128(sp)
80004c6c:	01012503          	lw	a0,16(sp)
80004c70:	06c12983          	lw	s3,108(sp)
80004c74:	07c12083          	lw	ra,124(sp)
80004c78:	06412a83          	lw	s5,100(sp)
80004c7c:	04c12d83          	lw	s11,76(sp)
80004c80:	00090713          	mv	a4,s2
80004c84:	00048793          	mv	a5,s1
80004c88:	07012903          	lw	s2,112(sp)
80004c8c:	07412483          	lw	s1,116(sp)
80004c90:	000a0893          	mv	a7,s4
80004c94:	000d0693          	mv	a3,s10
80004c98:	06812a03          	lw	s4,104(sp)
80004c9c:	05012d03          	lw	s10,80(sp)
80004ca0:	000c8613          	mv	a2,s9
80004ca4:	000c0593          	mv	a1,s8
80004ca8:	05412c83          	lw	s9,84(sp)
80004cac:	05812c03          	lw	s8,88(sp)
80004cb0:	08010113          	add	sp,sp,128
80004cb4:	dccff06f          	j	80004280 <_etoa>
80004cb8:	a0000737          	lui	a4,0xa0000
80004cbc:	000d8893          	mv	a7,s11
80004cc0:	000a0813          	mv	a6,s4
80004cc4:	00400793          	li	a5,4
80004cc8:	62070713          	add	a4,a4,1568 # a0000620 <__clz_tab+0x5a8>
80004ccc:	ef5ff06f          	j	80004bc0 <_ftoa+0x344>
80004cd0:	a00017b7          	lui	a5,0xa0001
80004cd4:	01412503          	lw	a0,20(sp)
80004cd8:	01812583          	lw	a1,24(sp)
80004cdc:	f187a603          	lw	a2,-232(a5) # a0000f18 <pow10.0+0x88>
80004ce0:	f1c7a683          	lw	a3,-228(a5)
80004ce4:	e8dfc0ef          	jal	80001b70 <__ledf2>
80004ce8:	d80544e3          	bltz	a0,80004a70 <_ftoa+0x1f4>
80004cec:	14099c63          	bnez	s3,80004e44 <_ftoa+0x5c8>
80004cf0:	00198993          	add	s3,s3,1
80004cf4:	d80a90e3          	bnez	s5,80004a74 <_ftoa+0x1f8>
80004cf8:	00040513          	mv	a0,s0
80004cfc:	de5fd0ef          	jal	80002ae0 <__floatsidf>
80004d00:	00050613          	mv	a2,a0
80004d04:	00058693          	mv	a3,a1
80004d08:	00090513          	mv	a0,s2
80004d0c:	00048593          	mv	a1,s1
80004d10:	d2cfd0ef          	jal	8000223c <__subdf3>
80004d14:	a00017b7          	lui	a5,0xa0001
80004d18:	f187a603          	lw	a2,-232(a5) # a0000f18 <pow10.0+0x88>
80004d1c:	f1c7a683          	lw	a3,-228(a5)
80004d20:	e51fc0ef          	jal	80001b70 <__ledf2>
80004d24:	d8054ce3          	bltz	a0,80004abc <_ftoa+0x240>
80004d28:	00147693          	and	a3,s0,1
80004d2c:	00d40433          	add	s0,s0,a3
80004d30:	d8dff06f          	j	80004abc <_ftoa+0x240>
80004d34:	a0001737          	lui	a4,0xa0001
80004d38:	f6072783          	lw	a5,-160(a4) # a0000f60 <pow10.0+0xd0>
80004d3c:	f6472803          	lw	a6,-156(a4)
80004d40:	00600a93          	li	s5,6
80004d44:	00f12423          	sw	a5,8(sp)
80004d48:	01012623          	sw	a6,12(sp)
80004d4c:	02010b13          	add	s6,sp,32
80004d50:	c7dff06f          	j	800049cc <_ftoa+0x150>
80004d54:	003df693          	and	a3,s11,3
80004d58:	00100613          	li	a2,1
80004d5c:	12c68a63          	beq	a3,a2,80004e90 <_ftoa+0x614>
80004d60:	02000693          	li	a3,32
80004d64:	dedb80e3          	beq	s7,a3,80004b44 <_ftoa+0x2c8>
80004d68:	01c12783          	lw	a5,28(sp)
80004d6c:	06078a63          	beqz	a5,80004de0 <_ftoa+0x564>
80004d70:	020b8793          	add	a5,s7,32
80004d74:	02010713          	add	a4,sp,32
80004d78:	00e786b3          	add	a3,a5,a4
80004d7c:	02d00613          	li	a2,45
80004d80:	fec68023          	sb	a2,-32(a3)
80004d84:	001b8b93          	add	s7,s7,1
80004d88:	dbdff06f          	j	80004b44 <_ftoa+0x2c8>
80004d8c:	d29b86e3          	beq	s7,s1,80004ab8 <_ftoa+0x23c>
80004d90:	017a8533          	add	a0,s5,s7
80004d94:	03000593          	li	a1,48
80004d98:	02000613          	li	a2,32
80004d9c:	000a9663          	bnez	s5,80004da8 <_ftoa+0x52c>
80004da0:	06c0006f          	j	80004e0c <_ftoa+0x590>
80004da4:	06ab8463          	beq	s7,a0,80004e0c <_ftoa+0x590>
80004da8:	001b8b93          	add	s7,s7,1
80004dac:	017b06b3          	add	a3,s6,s7
80004db0:	feb68fa3          	sb	a1,-1(a3)
80004db4:	fecb98e3          	bne	s7,a2,80004da4 <_ftoa+0x528>
80004db8:	02000b93          	li	s7,32
80004dbc:	d01ff06f          	j	80004abc <_ftoa+0x240>
80004dc0:	f689a783          	lw	a5,-152(s3)
80004dc4:	f6c9a803          	lw	a6,-148(s3)
80004dc8:	02000b93          	li	s7,32
80004dcc:	00f12423          	sw	a5,8(sp)
80004dd0:	01012623          	sw	a6,12(sp)
80004dd4:	bf9ff06f          	j	800049cc <_ftoa+0x150>
80004dd8:	02000693          	li	a3,32
80004ddc:	d6db84e3          	beq	s7,a3,80004b44 <_ftoa+0x2c8>
80004de0:	004df693          	and	a3,s11,4
80004de4:	04069263          	bnez	a3,80004e28 <_ftoa+0x5ac>
80004de8:	008df693          	and	a3,s11,8
80004dec:	d4068ce3          	beqz	a3,80004b44 <_ftoa+0x2c8>
80004df0:	020b8793          	add	a5,s7,32
80004df4:	02010713          	add	a4,sp,32
80004df8:	00e786b3          	add	a3,a5,a4
80004dfc:	02000613          	li	a2,32
80004e00:	fec68023          	sb	a2,-32(a3)
80004e04:	001b8b93          	add	s7,s7,1
80004e08:	d3dff06f          	j	80004b44 <_ftoa+0x2c8>
80004e0c:	020b8793          	add	a5,s7,32
80004e10:	02010713          	add	a4,sp,32
80004e14:	00e786b3          	add	a3,a5,a4
80004e18:	02e00613          	li	a2,46
80004e1c:	fec68023          	sb	a2,-32(a3)
80004e20:	001b8b93          	add	s7,s7,1
80004e24:	c99ff06f          	j	80004abc <_ftoa+0x240>
80004e28:	020b8793          	add	a5,s7,32
80004e2c:	02010713          	add	a4,sp,32
80004e30:	00e786b3          	add	a3,a5,a4
80004e34:	02b00613          	li	a2,43
80004e38:	fec68023          	sb	a2,-32(a3)
80004e3c:	001b8b93          	add	s7,s7,1
80004e40:	d05ff06f          	j	80004b44 <_ftoa+0x2c8>
80004e44:	0019f693          	and	a3,s3,1
80004e48:	c20684e3          	beqz	a3,80004a70 <_ftoa+0x1f4>
80004e4c:	00198993          	add	s3,s3,1
80004e50:	ea5ff06f          	j	80004cf4 <_ftoa+0x478>
80004e54:	fffa0a13          	add	s4,s4,-1
80004e58:	cd4be2e3          	bltu	s7,s4,80004b1c <_ftoa+0x2a0>
80004e5c:	f05ff06f          	j	80004d60 <_ftoa+0x4e4>
80004e60:	a00017b7          	lui	a5,0xa0001
80004e64:	00341713          	sll	a4,s0,0x3
80004e68:	e9078793          	add	a5,a5,-368 # a0000e90 <pow10.0>
80004e6c:	00e787b3          	add	a5,a5,a4
80004e70:	0047a803          	lw	a6,4(a5)
80004e74:	0007a783          	lw	a5,0(a5)
80004e78:	00040a93          	mv	s5,s0
80004e7c:	01012623          	sw	a6,12(sp)
80004e80:	00f12423          	sw	a5,8(sp)
80004e84:	00000b93          	li	s7,0
80004e88:	02010b13          	add	s6,sp,32
80004e8c:	b41ff06f          	j	800049cc <_ftoa+0x150>
80004e90:	ec0a08e3          	beqz	s4,80004d60 <_ftoa+0x4e4>
80004e94:	c75ff06f          	j	80004b08 <_ftoa+0x28c>

80004e98 <_out_char>:
80004e98:	00051463          	bnez	a0,80004ea0 <_out_char+0x8>
80004e9c:	00008067          	ret
80004ea0:	831fe06f          	j	800036d0 <_putchar>

80004ea4 <_vsnprintf>:
80004ea4:	f9010113          	add	sp,sp,-112
80004ea8:	07212023          	sw	s2,96(sp)
80004eac:	05312e23          	sw	s3,92(sp)
80004eb0:	05412c23          	sw	s4,88(sp)
80004eb4:	05712623          	sw	s7,76(sp)
80004eb8:	03b12e23          	sw	s11,60(sp)
80004ebc:	06112623          	sw	ra,108(sp)
80004ec0:	06812423          	sw	s0,104(sp)
80004ec4:	05a12023          	sw	s10,64(sp)
80004ec8:	00058993          	mv	s3,a1
80004ecc:	00060913          	mv	s2,a2
80004ed0:	00068b93          	mv	s7,a3
80004ed4:	00070d93          	mv	s11,a4
80004ed8:	00050a13          	mv	s4,a0
80004edc:	4e058863          	beqz	a1,800053cc <_vsnprintf+0x528>
80004ee0:	000bc503          	lbu	a0,0(s7)
80004ee4:	00000d13          	li	s10,0
80004ee8:	4e050c63          	beqz	a0,800053e0 <_vsnprintf+0x53c>
80004eec:	a00017b7          	lui	a5,0xa0001
80004ef0:	05512a23          	sw	s5,84(sp)
80004ef4:	d3478793          	add	a5,a5,-716 # a0000d34 <__clz_tab+0xcbc>
80004ef8:	a0001ab7          	lui	s5,0xa0001
80004efc:	06912223          	sw	s1,100(sp)
80004f00:	05612823          	sw	s6,80(sp)
80004f04:	05812423          	sw	s8,72(sp)
80004f08:	05912223          	sw	s9,68(sp)
80004f0c:	01000493          	li	s1,16
80004f10:	cf0a8a93          	add	s5,s5,-784 # a0000cf0 <__clz_tab+0xc78>
80004f14:	00900b13          	li	s6,9
80004f18:	02f12223          	sw	a5,36(sp)
80004f1c:	0200006f          	j	80004f3c <_vsnprintf+0x98>
80004f20:	000d0613          	mv	a2,s10
80004f24:	00090693          	mv	a3,s2
80004f28:	00098593          	mv	a1,s3
80004f2c:	001d0d13          	add	s10,s10,1
80004f30:	000a00e7          	jalr	s4
80004f34:	000bc503          	lbu	a0,0(s7)
80004f38:	16050863          	beqz	a0,800050a8 <_vsnprintf+0x204>
80004f3c:	02500793          	li	a5,37
80004f40:	001b8b93          	add	s7,s7,1
80004f44:	fcf51ee3          	bne	a0,a5,80004f20 <_vsnprintf+0x7c>
80004f48:	00000413          	li	s0,0
80004f4c:	000bc503          	lbu	a0,0(s7)
80004f50:	001b8713          	add	a4,s7,1
80004f54:	fe050793          	add	a5,a0,-32
80004f58:	0ff7f793          	zext.b	a5,a5
80004f5c:	00f4ea63          	bltu	s1,a5,80004f70 <_vsnprintf+0xcc>
80004f60:	00279793          	sll	a5,a5,0x2
80004f64:	015787b3          	add	a5,a5,s5
80004f68:	0007a783          	lw	a5,0(a5)
80004f6c:	00078067          	jr	a5
80004f70:	fd050793          	add	a5,a0,-48
80004f74:	0ff7f793          	zext.b	a5,a5
80004f78:	0cfb7263          	bgeu	s6,a5,8000503c <_vsnprintf+0x198>
80004f7c:	02a00793          	li	a5,42
80004f80:	00000e93          	li	t4,0
80004f84:	1ef50e63          	beq	a0,a5,80005180 <_vsnprintf+0x2dc>
80004f88:	02e00793          	li	a5,46
80004f8c:	00000c93          	li	s9,0
80004f90:	0ef50463          	beq	a0,a5,80005078 <_vsnprintf+0x1d4>
80004f94:	f9850793          	add	a5,a0,-104
80004f98:	0ff7f793          	zext.b	a5,a5
80004f9c:	01200693          	li	a3,18
80004fa0:	06f6e063          	bltu	a3,a5,80005000 <_vsnprintf+0x15c>
80004fa4:	02412683          	lw	a3,36(sp)
80004fa8:	00279793          	sll	a5,a5,0x2
80004fac:	00d787b3          	add	a5,a5,a3
80004fb0:	0007a783          	lw	a5,0(a5)
80004fb4:	00078067          	jr	a5
80004fb8:	00146413          	or	s0,s0,1
80004fbc:	00070b93          	mv	s7,a4
80004fc0:	f8dff06f          	j	80004f4c <_vsnprintf+0xa8>
80004fc4:	00246413          	or	s0,s0,2
80004fc8:	00070b93          	mv	s7,a4
80004fcc:	f81ff06f          	j	80004f4c <_vsnprintf+0xa8>
80004fd0:	00446413          	or	s0,s0,4
80004fd4:	00070b93          	mv	s7,a4
80004fd8:	f75ff06f          	j	80004f4c <_vsnprintf+0xa8>
80004fdc:	01046413          	or	s0,s0,16
80004fe0:	00070b93          	mv	s7,a4
80004fe4:	f69ff06f          	j	80004f4c <_vsnprintf+0xa8>
80004fe8:	00846413          	or	s0,s0,8
80004fec:	00070b93          	mv	s7,a4
80004ff0:	f5dff06f          	j	80004f4c <_vsnprintf+0xa8>
80004ff4:	001bc503          	lbu	a0,1(s7)
80004ff8:	10046413          	or	s0,s0,256
80004ffc:	00170713          	add	a4,a4,1
80005000:	06700793          	li	a5,103
80005004:	00070b93          	mv	s7,a4
80005008:	10a7e063          	bltu	a5,a0,80005108 <_vsnprintf+0x264>
8000500c:	02400793          	li	a5,36
80005010:	f0a7f8e3          	bgeu	a5,a0,80004f20 <_vsnprintf+0x7c>
80005014:	fdb50793          	add	a5,a0,-37
80005018:	0ff7f793          	zext.b	a5,a5
8000501c:	04200713          	li	a4,66
80005020:	f0f760e3          	bltu	a4,a5,80004f20 <_vsnprintf+0x7c>
80005024:	a0001737          	lui	a4,0xa0001
80005028:	00279793          	sll	a5,a5,0x2
8000502c:	d8070713          	add	a4,a4,-640 # a0000d80 <__clz_tab+0xd08>
80005030:	00e787b3          	add	a5,a5,a4
80005034:	0007a783          	lw	a5,0(a5)
80005038:	00078067          	jr	a5
8000503c:	00000e93          	li	t4,0
80005040:	002e9793          	sll	a5,t4,0x2
80005044:	01d787b3          	add	a5,a5,t4
80005048:	00179793          	sll	a5,a5,0x1
8000504c:	00a787b3          	add	a5,a5,a0
80005050:	00074503          	lbu	a0,0(a4)
80005054:	fd078e93          	add	t4,a5,-48
80005058:	00070b93          	mv	s7,a4
8000505c:	fd050793          	add	a5,a0,-48
80005060:	0ff7f793          	zext.b	a5,a5
80005064:	00170713          	add	a4,a4,1
80005068:	fcfb7ce3          	bgeu	s6,a5,80005040 <_vsnprintf+0x19c>
8000506c:	02e00793          	li	a5,46
80005070:	00000c93          	li	s9,0
80005074:	f2f510e3          	bne	a0,a5,80004f94 <_vsnprintf+0xf0>
80005078:	001bc503          	lbu	a0,1(s7)
8000507c:	00900613          	li	a2,9
80005080:	00070693          	mv	a3,a4
80005084:	fd050793          	add	a5,a0,-48
80005088:	0ff7f793          	zext.b	a5,a5
8000508c:	40046413          	or	s0,s0,1024
80005090:	34f67e63          	bgeu	a2,a5,800053ec <_vsnprintf+0x548>
80005094:	02a00793          	li	a5,42
80005098:	3af50863          	beq	a0,a5,80005448 <_vsnprintf+0x5a4>
8000509c:	00070b93          	mv	s7,a4
800050a0:	00170713          	add	a4,a4,1
800050a4:	ef1ff06f          	j	80004f94 <_vsnprintf+0xf0>
800050a8:	06412483          	lw	s1,100(sp)
800050ac:	05412a83          	lw	s5,84(sp)
800050b0:	05012b03          	lw	s6,80(sp)
800050b4:	04812c03          	lw	s8,72(sp)
800050b8:	04412c83          	lw	s9,68(sp)
800050bc:	000d0413          	mv	s0,s10
800050c0:	012d6463          	bltu	s10,s2,800050c8 <_vsnprintf+0x224>
800050c4:	fff90d13          	add	s10,s2,-1
800050c8:	00090693          	mv	a3,s2
800050cc:	000d0613          	mv	a2,s10
800050d0:	00098593          	mv	a1,s3
800050d4:	00000513          	li	a0,0
800050d8:	000a00e7          	jalr	s4
800050dc:	06c12083          	lw	ra,108(sp)
800050e0:	00040513          	mv	a0,s0
800050e4:	06812403          	lw	s0,104(sp)
800050e8:	06012903          	lw	s2,96(sp)
800050ec:	05c12983          	lw	s3,92(sp)
800050f0:	05812a03          	lw	s4,88(sp)
800050f4:	04c12b83          	lw	s7,76(sp)
800050f8:	04012d03          	lw	s10,64(sp)
800050fc:	03c12d83          	lw	s11,60(sp)
80005100:	07010113          	add	sp,sp,112
80005104:	00008067          	ret
80005108:	f9750793          	add	a5,a0,-105
8000510c:	0ff7f793          	zext.b	a5,a5
80005110:	00f00713          	li	a4,15
80005114:	e0f766e3          	bltu	a4,a5,80004f20 <_vsnprintf+0x7c>
80005118:	00009737          	lui	a4,0x9
8000511c:	00100c13          	li	s8,1
80005120:	00fc1c33          	sll	s8,s8,a5
80005124:	04170713          	add	a4,a4,65 # 9041 <__stack_size+0x5041>
80005128:	00ec7c33          	and	s8,s8,a4
8000512c:	2e0c1c63          	bnez	s8,80005424 <_vsnprintf+0x580>
80005130:	00a00713          	li	a4,10
80005134:	06e78463          	beq	a5,a4,8000519c <_vsnprintf+0x2f8>
80005138:	00700713          	li	a4,7
8000513c:	dee792e3          	bne	a5,a4,80004f20 <_vsnprintf+0x7c>
80005140:	000da703          	lw	a4,0(s11)
80005144:	00800793          	li	a5,8
80005148:	02146413          	or	s0,s0,33
8000514c:	00f12023          	sw	a5,0(sp)
80005150:	000d0613          	mv	a2,s10
80005154:	00812223          	sw	s0,4(sp)
80005158:	000c8893          	mv	a7,s9
8000515c:	01000813          	li	a6,16
80005160:	00000793          	li	a5,0
80005164:	00090693          	mv	a3,s2
80005168:	00098593          	mv	a1,s3
8000516c:	000a0513          	mv	a0,s4
80005170:	e25fe0ef          	jal	80003f94 <_ntoa_long>
80005174:	004d8d93          	add	s11,s11,4
80005178:	00050d13          	mv	s10,a0
8000517c:	db9ff06f          	j	80004f34 <_vsnprintf+0x90>
80005180:	000dae83          	lw	t4,0(s11)
80005184:	004d8d93          	add	s11,s11,4
80005188:	0c0ecc63          	bltz	t4,80005260 <_vsnprintf+0x3bc>
8000518c:	001bc503          	lbu	a0,1(s7)
80005190:	00070b93          	mv	s7,a4
80005194:	00170713          	add	a4,a4,1
80005198:	df1ff06f          	j	80004f88 <_vsnprintf+0xe4>
8000519c:	000da783          	lw	a5,0(s11)
800051a0:	004d8713          	add	a4,s11,4
800051a4:	02e12623          	sw	a4,44(sp)
800051a8:	0007c683          	lbu	a3,0(a5)
800051ac:	02f12023          	sw	a5,32(sp)
800051b0:	00068513          	mv	a0,a3
800051b4:	2a0c9c63          	bnez	s9,8000546c <_vsnprintf+0x5c8>
800051b8:	02068863          	beqz	a3,800051e8 <_vsnprintf+0x344>
800051bc:	ffe00c13          	li	s8,-2
800051c0:	02012783          	lw	a5,32(sp)
800051c4:	001c0c13          	add	s8,s8,1
800051c8:	01878c33          	add	s8,a5,s8
800051cc:	0080006f          	j	800051d4 <_vsnprintf+0x330>
800051d0:	3afc0463          	beq	s8,a5,80005578 <_vsnprintf+0x6d4>
800051d4:	0017c703          	lbu	a4,1(a5)
800051d8:	00178793          	add	a5,a5,1
800051dc:	fe071ae3          	bnez	a4,800051d0 <_vsnprintf+0x32c>
800051e0:	02012703          	lw	a4,32(sp)
800051e4:	40e78c33          	sub	s8,a5,a4
800051e8:	40047d93          	and	s11,s0,1024
800051ec:	000d8663          	beqz	s11,800051f8 <_vsnprintf+0x354>
800051f0:	018cf463          	bgeu	s9,s8,800051f8 <_vsnprintf+0x354>
800051f4:	000c8c13          	mv	s8,s9
800051f8:	00247793          	and	a5,s0,2
800051fc:	02f12423          	sw	a5,40(sp)
80005200:	38078863          	beqz	a5,80005590 <_vsnprintf+0x6ec>
80005204:	32068263          	beqz	a3,80005528 <_vsnprintf+0x684>
80005208:	000d0413          	mv	s0,s10
8000520c:	000d8863          	beqz	s11,8000521c <_vsnprintf+0x378>
80005210:	fffc8793          	add	a5,s9,-1
80005214:	020c8c63          	beqz	s9,8000524c <_vsnprintf+0x3a8>
80005218:	00078c93          	mv	s9,a5
8000521c:	01d12e23          	sw	t4,28(sp)
80005220:	00040613          	mv	a2,s0
80005224:	00090693          	mv	a3,s2
80005228:	00098593          	mv	a1,s3
8000522c:	000a00e7          	jalr	s4
80005230:	02012783          	lw	a5,32(sp)
80005234:	00140413          	add	s0,s0,1
80005238:	41a40733          	sub	a4,s0,s10
8000523c:	00e78733          	add	a4,a5,a4
80005240:	00074503          	lbu	a0,0(a4)
80005244:	01c12e83          	lw	t4,28(sp)
80005248:	fc0512e3          	bnez	a0,8000520c <_vsnprintf+0x368>
8000524c:	02812783          	lw	a5,40(sp)
80005250:	2c079a63          	bnez	a5,80005524 <_vsnprintf+0x680>
80005254:	02c12d83          	lw	s11,44(sp)
80005258:	00040d13          	mv	s10,s0
8000525c:	cd9ff06f          	j	80004f34 <_vsnprintf+0x90>
80005260:	001bc503          	lbu	a0,1(s7)
80005264:	00246413          	or	s0,s0,2
80005268:	00070b93          	mv	s7,a4
8000526c:	41d00eb3          	neg	t4,t4
80005270:	00170713          	add	a4,a4,1
80005274:	d15ff06f          	j	80004f88 <_vsnprintf+0xe4>
80005278:	001bc503          	lbu	a0,1(s7)
8000527c:	06c00793          	li	a5,108
80005280:	d6f51ce3          	bne	a0,a5,80004ff8 <_vsnprintf+0x154>
80005284:	002bc503          	lbu	a0,2(s7)
80005288:	30046413          	or	s0,s0,768
8000528c:	003b8713          	add	a4,s7,3
80005290:	d71ff06f          	j	80005000 <_vsnprintf+0x15c>
80005294:	001bc503          	lbu	a0,1(s7)
80005298:	20046413          	or	s0,s0,512
8000529c:	00170713          	add	a4,a4,1
800052a0:	d61ff06f          	j	80005000 <_vsnprintf+0x15c>
800052a4:	001bc503          	lbu	a0,1(s7)
800052a8:	06800793          	li	a5,104
800052ac:	2af50e63          	beq	a0,a5,80005568 <_vsnprintf+0x6c4>
800052b0:	08046413          	or	s0,s0,128
800052b4:	00170713          	add	a4,a4,1
800052b8:	d49ff06f          	j	80005000 <_vsnprintf+0x15c>
800052bc:	06700793          	li	a5,103
800052c0:	1cf50063          	beq	a0,a5,80005480 <_vsnprintf+0x5dc>
800052c4:	04700793          	li	a5,71
800052c8:	28f50663          	beq	a0,a5,80005554 <_vsnprintf+0x6b0>
800052cc:	04500793          	li	a5,69
800052d0:	28f50863          	beq	a0,a5,80005560 <_vsnprintf+0x6bc>
800052d4:	007d8d93          	add	s11,s11,7
800052d8:	ff8dfd93          	and	s11,s11,-8
800052dc:	000da703          	lw	a4,0(s11)
800052e0:	004da783          	lw	a5,4(s11)
800052e4:	000d0613          	mv	a2,s10
800052e8:	000e8893          	mv	a7,t4
800052ec:	00812023          	sw	s0,0(sp)
800052f0:	000c8813          	mv	a6,s9
800052f4:	00090693          	mv	a3,s2
800052f8:	00098593          	mv	a1,s3
800052fc:	000a0513          	mv	a0,s4
80005300:	f81fe0ef          	jal	80004280 <_etoa>
80005304:	008d8d93          	add	s11,s11,8
80005308:	00050d13          	mv	s10,a0
8000530c:	c29ff06f          	j	80004f34 <_vsnprintf+0x90>
80005310:	04600793          	li	a5,70
80005314:	16f50263          	beq	a0,a5,80005478 <_vsnprintf+0x5d4>
80005318:	007d8d93          	add	s11,s11,7
8000531c:	ff8dfd93          	and	s11,s11,-8
80005320:	000da703          	lw	a4,0(s11)
80005324:	004da783          	lw	a5,4(s11)
80005328:	000d0613          	mv	a2,s10
8000532c:	000e8893          	mv	a7,t4
80005330:	00812023          	sw	s0,0(sp)
80005334:	000c8813          	mv	a6,s9
80005338:	00090693          	mv	a3,s2
8000533c:	00098593          	mv	a1,s3
80005340:	000a0513          	mv	a0,s4
80005344:	d38ff0ef          	jal	8000487c <_ftoa>
80005348:	008d8d93          	add	s11,s11,8
8000534c:	00050d13          	mv	s10,a0
80005350:	be5ff06f          	j	80004f34 <_vsnprintf+0x90>
80005354:	000d0613          	mv	a2,s10
80005358:	00090693          	mv	a3,s2
8000535c:	00098593          	mv	a1,s3
80005360:	02500513          	li	a0,37
80005364:	001d0d13          	add	s10,s10,1
80005368:	000a00e7          	jalr	s4
8000536c:	bc9ff06f          	j	80004f34 <_vsnprintf+0x90>
80005370:	00247413          	and	s0,s0,2
80005374:	001d0c93          	add	s9,s10,1
80005378:	004d8c13          	add	s8,s11,4
8000537c:	26040063          	beqz	s0,800055dc <_vsnprintf+0x738>
80005380:	000dc503          	lbu	a0,0(s11)
80005384:	01d12e23          	sw	t4,28(sp)
80005388:	000d0613          	mv	a2,s10
8000538c:	00090693          	mv	a3,s2
80005390:	00098593          	mv	a1,s3
80005394:	000a00e7          	jalr	s4
80005398:	01c12e83          	lw	t4,28(sp)
8000539c:	00100793          	li	a5,1
800053a0:	01dd0d33          	add	s10,s10,t4
800053a4:	2bd7f663          	bgeu	a5,t4,80005650 <_vsnprintf+0x7ac>
800053a8:	000c8613          	mv	a2,s9
800053ac:	00090693          	mv	a3,s2
800053b0:	001c8c93          	add	s9,s9,1
800053b4:	00098593          	mv	a1,s3
800053b8:	02000513          	li	a0,32
800053bc:	000a00e7          	jalr	s4
800053c0:	ff9d14e3          	bne	s10,s9,800053a8 <_vsnprintf+0x504>
800053c4:	000c0d93          	mv	s11,s8
800053c8:	b6dff06f          	j	80004f34 <_vsnprintf+0x90>
800053cc:	000bc503          	lbu	a0,0(s7)
800053d0:	80004a37          	lui	s4,0x80004
800053d4:	afca0a13          	add	s4,s4,-1284 # 80003afc <_out_null>
800053d8:	00000d13          	li	s10,0
800053dc:	b00518e3          	bnez	a0,80004eec <_vsnprintf+0x48>
800053e0:	00000413          	li	s0,0
800053e4:	cf2d62e3          	bltu	s10,s2,800050c8 <_vsnprintf+0x224>
800053e8:	cddff06f          	j	800050c4 <_vsnprintf+0x220>
800053ec:	00900713          	li	a4,9
800053f0:	002c9793          	sll	a5,s9,0x2
800053f4:	019787b3          	add	a5,a5,s9
800053f8:	00168693          	add	a3,a3,1
800053fc:	00179793          	sll	a5,a5,0x1
80005400:	00a787b3          	add	a5,a5,a0
80005404:	0006c503          	lbu	a0,0(a3)
80005408:	fd078c93          	add	s9,a5,-48
8000540c:	fd050793          	add	a5,a0,-48
80005410:	0ff7f793          	zext.b	a5,a5
80005414:	fcf77ee3          	bgeu	a4,a5,800053f0 <_vsnprintf+0x54c>
80005418:	00068b93          	mv	s7,a3
8000541c:	00168713          	add	a4,a3,1
80005420:	b75ff06f          	j	80004f94 <_vsnprintf+0xf0>
80005424:	06f00793          	li	a5,111
80005428:	06f50463          	beq	a0,a5,80005490 <_vsnprintf+0x5ec>
8000542c:	28a7f063          	bgeu	a5,a0,800056ac <_vsnprintf+0x808>
80005430:	07800793          	li	a5,120
80005434:	01000813          	li	a6,16
80005438:	04f50e63          	beq	a0,a5,80005494 <_vsnprintf+0x5f0>
8000543c:	fef47413          	and	s0,s0,-17
80005440:	00a00813          	li	a6,10
80005444:	0500006f          	j	80005494 <_vsnprintf+0x5f0>
80005448:	000dac83          	lw	s9,0(s11)
8000544c:	002bc503          	lbu	a0,2(s7)
80005450:	002b8b93          	add	s7,s7,2
80005454:	fffcc793          	not	a5,s9
80005458:	41f7d793          	sra	a5,a5,0x1f
8000545c:	00fcfcb3          	and	s9,s9,a5
80005460:	004d8d93          	add	s11,s11,4
80005464:	001b8713          	add	a4,s7,1
80005468:	b2dff06f          	j	80004f94 <_vsnprintf+0xf0>
8000546c:	d6068ee3          	beqz	a3,800051e8 <_vsnprintf+0x344>
80005470:	fffc8c13          	add	s8,s9,-1
80005474:	d4dff06f          	j	800051c0 <_vsnprintf+0x31c>
80005478:	02046413          	or	s0,s0,32
8000547c:	e9dff06f          	j	80005318 <_vsnprintf+0x474>
80005480:	000017b7          	lui	a5,0x1
80005484:	80078793          	add	a5,a5,-2048 # 800 <__stack_size-0x3800>
80005488:	00f46433          	or	s0,s0,a5
8000548c:	e49ff06f          	j	800052d4 <_vsnprintf+0x430>
80005490:	00800813          	li	a6,8
80005494:	40047713          	and	a4,s0,1024
80005498:	ff347793          	and	a5,s0,-13
8000549c:	00070463          	beqz	a4,800054a4 <_vsnprintf+0x600>
800054a0:	ff247793          	and	a5,s0,-14
800054a4:	2007f713          	and	a4,a5,512
800054a8:	1a071a63          	bnez	a4,8000565c <_vsnprintf+0x7b8>
800054ac:	1007f713          	and	a4,a5,256
800054b0:	004d8413          	add	s0,s11,4
800054b4:	2e071063          	bnez	a4,80005794 <_vsnprintf+0x8f0>
800054b8:	0407f713          	and	a4,a5,64
800054bc:	16071c63          	bnez	a4,80005634 <_vsnprintf+0x790>
800054c0:	0807f713          	and	a4,a5,128
800054c4:	2e070c63          	beqz	a4,800057bc <_vsnprintf+0x918>
800054c8:	000dd703          	lhu	a4,0(s11)
800054cc:	00f12223          	sw	a5,4(sp)
800054d0:	01d12023          	sw	t4,0(sp)
800054d4:	000c8893          	mv	a7,s9
800054d8:	00000793          	li	a5,0
800054dc:	000d0613          	mv	a2,s10
800054e0:	00090693          	mv	a3,s2
800054e4:	00098593          	mv	a1,s3
800054e8:	000a0513          	mv	a0,s4
800054ec:	aa9fe0ef          	jal	80003f94 <_ntoa_long>
800054f0:	00050d13          	mv	s10,a0
800054f4:	00040d93          	mv	s11,s0
800054f8:	a3dff06f          	j	80004f34 <_vsnprintf+0x90>
800054fc:	05800793          	li	a5,88
80005500:	08f50263          	beq	a0,a5,80005584 <_vsnprintf+0x6e0>
80005504:	06200793          	li	a5,98
80005508:	00200813          	li	a6,2
8000550c:	f8f504e3          	beq	a0,a5,80005494 <_vsnprintf+0x5f0>
80005510:	40047793          	and	a5,s0,1024
80005514:	fee47693          	and	a3,s0,-18
80005518:	1a079663          	bnez	a5,800056c4 <_vsnprintf+0x820>
8000551c:	fef47693          	and	a3,s0,-17
80005520:	1a40006f          	j	800056c4 <_vsnprintf+0x820>
80005524:	00040d13          	mv	s10,s0
80005528:	0bdc7663          	bgeu	s8,t4,800055d4 <_vsnprintf+0x730>
8000552c:	01ae87b3          	add	a5,t4,s10
80005530:	41878433          	sub	s0,a5,s8
80005534:	000d0613          	mv	a2,s10
80005538:	00090693          	mv	a3,s2
8000553c:	001d0d13          	add	s10,s10,1
80005540:	00098593          	mv	a1,s3
80005544:	02000513          	li	a0,32
80005548:	000a00e7          	jalr	s4
8000554c:	ffa414e3          	bne	s0,s10,80005534 <_vsnprintf+0x690>
80005550:	d05ff06f          	j	80005254 <_vsnprintf+0x3b0>
80005554:	000017b7          	lui	a5,0x1
80005558:	80078793          	add	a5,a5,-2048 # 800 <__stack_size-0x3800>
8000555c:	00f46433          	or	s0,s0,a5
80005560:	02046413          	or	s0,s0,32
80005564:	d71ff06f          	j	800052d4 <_vsnprintf+0x430>
80005568:	002bc503          	lbu	a0,2(s7)
8000556c:	0c046413          	or	s0,s0,192
80005570:	003b8713          	add	a4,s7,3
80005574:	a8dff06f          	j	80005000 <_vsnprintf+0x15c>
80005578:	02012783          	lw	a5,32(sp)
8000557c:	40fc0c33          	sub	s8,s8,a5
80005580:	c69ff06f          	j	800051e8 <_vsnprintf+0x344>
80005584:	02046413          	or	s0,s0,32
80005588:	01000813          	li	a6,16
8000558c:	f09ff06f          	j	80005494 <_vsnprintf+0x5f0>
80005590:	23dc7a63          	bgeu	s8,t4,800057c4 <_vsnprintf+0x920>
80005594:	01ae87b3          	add	a5,t4,s10
80005598:	41878c33          	sub	s8,a5,s8
8000559c:	01d12e23          	sw	t4,28(sp)
800055a0:	000d0613          	mv	a2,s10
800055a4:	00090693          	mv	a3,s2
800055a8:	00098593          	mv	a1,s3
800055ac:	02000513          	li	a0,32
800055b0:	000a00e7          	jalr	s4
800055b4:	001d0d13          	add	s10,s10,1
800055b8:	01c12e83          	lw	t4,28(sp)
800055bc:	ffac10e3          	bne	s8,s10,8000559c <_vsnprintf+0x6f8>
800055c0:	02012783          	lw	a5,32(sp)
800055c4:	001e8c13          	add	s8,t4,1
800055c8:	0007c683          	lbu	a3,0(a5)
800055cc:	00068513          	mv	a0,a3
800055d0:	c2069ce3          	bnez	a3,80005208 <_vsnprintf+0x364>
800055d4:	000d0413          	mv	s0,s10
800055d8:	c7dff06f          	j	80005254 <_vsnprintf+0x3b0>
800055dc:	00100793          	li	a5,1
800055e0:	05d7fe63          	bgeu	a5,t4,8000563c <_vsnprintf+0x798>
800055e4:	fffd0413          	add	s0,s10,-1
800055e8:	01d40433          	add	s0,s0,t4
800055ec:	000d0c93          	mv	s9,s10
800055f0:	01d12e23          	sw	t4,28(sp)
800055f4:	000c8613          	mv	a2,s9
800055f8:	00090693          	mv	a3,s2
800055fc:	00098593          	mv	a1,s3
80005600:	02000513          	li	a0,32
80005604:	000a00e7          	jalr	s4
80005608:	001c8c93          	add	s9,s9,1
8000560c:	01c12e83          	lw	t4,28(sp)
80005610:	ff9410e3          	bne	s0,s9,800055f0 <_vsnprintf+0x74c>
80005614:	000dc503          	lbu	a0,0(s11)
80005618:	00090693          	mv	a3,s2
8000561c:	00040613          	mv	a2,s0
80005620:	00098593          	mv	a1,s3
80005624:	01dd0d33          	add	s10,s10,t4
80005628:	000c0d93          	mv	s11,s8
8000562c:	000a00e7          	jalr	s4
80005630:	905ff06f          	j	80004f34 <_vsnprintf+0x90>
80005634:	000dc703          	lbu	a4,0(s11)
80005638:	e95ff06f          	j	800054cc <_vsnprintf+0x628>
8000563c:	000dc503          	lbu	a0,0(s11)
80005640:	00090693          	mv	a3,s2
80005644:	000d0613          	mv	a2,s10
80005648:	00098593          	mv	a1,s3
8000564c:	000a00e7          	jalr	s4
80005650:	000c8d13          	mv	s10,s9
80005654:	000c0d93          	mv	s11,s8
80005658:	8ddff06f          	j	80004f34 <_vsnprintf+0x90>
8000565c:	007d8d93          	add	s11,s11,7
80005660:	ff8dfd93          	and	s11,s11,-8
80005664:	000da603          	lw	a2,0(s11)
80005668:	004da683          	lw	a3,4(s11)
8000566c:	00080893          	mv	a7,a6
80005670:	00f12623          	sw	a5,12(sp)
80005674:	01d12423          	sw	t4,8(sp)
80005678:	01912223          	sw	s9,4(sp)
8000567c:	00012023          	sw	zero,0(sp)
80005680:	00000813          	li	a6,0
80005684:	00060713          	mv	a4,a2
80005688:	00068793          	mv	a5,a3
8000568c:	000d0613          	mv	a2,s10
80005690:	00090693          	mv	a3,s2
80005694:	00098593          	mv	a1,s3
80005698:	000a0513          	mv	a0,s4
8000569c:	a59fe0ef          	jal	800040f4 <_ntoa_long_long>
800056a0:	008d8d93          	add	s11,s11,8
800056a4:	00050d13          	mv	s10,a0
800056a8:	88dff06f          	j	80004f34 <_vsnprintf+0x90>
800056ac:	06900793          	li	a5,105
800056b0:	fef47693          	and	a3,s0,-17
800056b4:	10f51c63          	bne	a0,a5,800057cc <_vsnprintf+0x928>
800056b8:	40047793          	and	a5,s0,1024
800056bc:	00078463          	beqz	a5,800056c4 <_vsnprintf+0x820>
800056c0:	fee47693          	and	a3,s0,-18
800056c4:	2006f793          	and	a5,a3,512
800056c8:	02079c63          	bnez	a5,80005700 <_vsnprintf+0x85c>
800056cc:	1006f793          	and	a5,a3,256
800056d0:	004d8413          	add	s0,s11,4
800056d4:	08079c63          	bnez	a5,8000576c <_vsnprintf+0x8c8>
800056d8:	0406f793          	and	a5,a3,64
800056dc:	06078663          	beqz	a5,80005748 <_vsnprintf+0x8a4>
800056e0:	000dc783          	lbu	a5,0(s11)
800056e4:	00078713          	mv	a4,a5
800056e8:	00d12223          	sw	a3,4(sp)
800056ec:	01d12023          	sw	t4,0(sp)
800056f0:	000c8893          	mv	a7,s9
800056f4:	00a00813          	li	a6,10
800056f8:	01f7d793          	srl	a5,a5,0x1f
800056fc:	de1ff06f          	j	800054dc <_vsnprintf+0x638>
80005700:	007d8d93          	add	s11,s11,7
80005704:	ff8dfd93          	and	s11,s11,-8
80005708:	004da803          	lw	a6,4(s11)
8000570c:	000da783          	lw	a5,0(s11)
80005710:	00a00893          	li	a7,10
80005714:	41f85613          	sra	a2,a6,0x1f
80005718:	00f647b3          	xor	a5,a2,a5
8000571c:	40c78733          	sub	a4,a5,a2
80005720:	010645b3          	xor	a1,a2,a6
80005724:	00e7b7b3          	sltu	a5,a5,a4
80005728:	40c58633          	sub	a2,a1,a2
8000572c:	00d12623          	sw	a3,12(sp)
80005730:	01d12423          	sw	t4,8(sp)
80005734:	01912223          	sw	s9,4(sp)
80005738:	00012023          	sw	zero,0(sp)
8000573c:	01f85813          	srl	a6,a6,0x1f
80005740:	40f607b3          	sub	a5,a2,a5
80005744:	f49ff06f          	j	8000568c <_vsnprintf+0x7e8>
80005748:	0806f793          	and	a5,a3,128
8000574c:	04078e63          	beqz	a5,800057a8 <_vsnprintf+0x904>
80005750:	000d9783          	lh	a5,0(s11)
80005754:	40f7d613          	sra	a2,a5,0xf
80005758:	00c7c733          	xor	a4,a5,a2
8000575c:	40c70733          	sub	a4,a4,a2
80005760:	01071713          	sll	a4,a4,0x10
80005764:	01075713          	srl	a4,a4,0x10
80005768:	f81ff06f          	j	800056e8 <_vsnprintf+0x844>
8000576c:	000da783          	lw	a5,0(s11)
80005770:	00d12223          	sw	a3,4(sp)
80005774:	000c8893          	mv	a7,s9
80005778:	41f7d713          	sra	a4,a5,0x1f
8000577c:	00f746b3          	xor	a3,a4,a5
80005780:	01d12023          	sw	t4,0(sp)
80005784:	00a00813          	li	a6,10
80005788:	01f7d793          	srl	a5,a5,0x1f
8000578c:	40e68733          	sub	a4,a3,a4
80005790:	d4dff06f          	j	800054dc <_vsnprintf+0x638>
80005794:	000da703          	lw	a4,0(s11)
80005798:	000c8893          	mv	a7,s9
8000579c:	00f12223          	sw	a5,4(sp)
800057a0:	01d12023          	sw	t4,0(sp)
800057a4:	d35ff06f          	j	800054d8 <_vsnprintf+0x634>
800057a8:	000da783          	lw	a5,0(s11)
800057ac:	41f7d613          	sra	a2,a5,0x1f
800057b0:	00f64733          	xor	a4,a2,a5
800057b4:	40c70733          	sub	a4,a4,a2
800057b8:	f31ff06f          	j	800056e8 <_vsnprintf+0x844>
800057bc:	000da703          	lw	a4,0(s11)
800057c0:	d0dff06f          	j	800054cc <_vsnprintf+0x628>
800057c4:	001c0c13          	add	s8,s8,1
800057c8:	e05ff06f          	j	800055cc <_vsnprintf+0x728>
800057cc:	00068413          	mv	s0,a3
800057d0:	00a00813          	li	a6,10
800057d4:	cc1ff06f          	j	80005494 <_vsnprintf+0x5f0>

800057d8 <printf_>:
800057d8:	fc010113          	add	sp,sp,-64
800057dc:	02410313          	add	t1,sp,36
800057e0:	02d12623          	sw	a3,44(sp)
800057e4:	00050693          	mv	a3,a0
800057e8:	80005537          	lui	a0,0x80005
800057ec:	02b12223          	sw	a1,36(sp)
800057f0:	02c12423          	sw	a2,40(sp)
800057f4:	02e12823          	sw	a4,48(sp)
800057f8:	00810593          	add	a1,sp,8
800057fc:	00030713          	mv	a4,t1
80005800:	fff00613          	li	a2,-1
80005804:	e9850513          	add	a0,a0,-360 # 80004e98 <_out_char>
80005808:	00112e23          	sw	ra,28(sp)
8000580c:	02f12a23          	sw	a5,52(sp)
80005810:	03012c23          	sw	a6,56(sp)
80005814:	03112e23          	sw	a7,60(sp)
80005818:	00612623          	sw	t1,12(sp)
8000581c:	e88ff0ef          	jal	80004ea4 <_vsnprintf>
80005820:	01c12083          	lw	ra,28(sp)
80005824:	04010113          	add	sp,sp,64
80005828:	00008067          	ret

8000582c <Proc_1>:
8000582c:	ff010113          	add	sp,sp,-16
80005830:	01212023          	sw	s2,0(sp)
80005834:	a0001937          	lui	s2,0xa0001
80005838:	fa492783          	lw	a5,-92(s2) # a0000fa4 <Ptr_Glob>
8000583c:	00812423          	sw	s0,8(sp)
80005840:	00052403          	lw	s0,0(a0)
80005844:	0007a703          	lw	a4,0(a5)
80005848:	0047af83          	lw	t6,4(a5)
8000584c:	0087af03          	lw	t5,8(a5)
80005850:	0107ae83          	lw	t4,16(a5)
80005854:	0147ae03          	lw	t3,20(a5)
80005858:	0187a303          	lw	t1,24(a5)
8000585c:	01c7a883          	lw	a7,28(a5)
80005860:	0207a803          	lw	a6,32(a5)
80005864:	02c7a603          	lw	a2,44(a5)
80005868:	0287a583          	lw	a1,40(a5)
8000586c:	00112623          	sw	ra,12(sp)
80005870:	00912223          	sw	s1,4(sp)
80005874:	00050493          	mv	s1,a0
80005878:	0247a503          	lw	a0,36(a5)
8000587c:	00e42023          	sw	a4,0(s0)
80005880:	0004a683          	lw	a3,0(s1)
80005884:	00500713          	li	a4,5
80005888:	01f42223          	sw	t6,4(s0)
8000588c:	01e42423          	sw	t5,8(s0)
80005890:	01d42823          	sw	t4,16(s0)
80005894:	01c42a23          	sw	t3,20(s0)
80005898:	00642c23          	sw	t1,24(s0)
8000589c:	01142e23          	sw	a7,28(s0)
800058a0:	03042023          	sw	a6,32(s0)
800058a4:	02a42223          	sw	a0,36(s0)
800058a8:	02c42623          	sw	a2,44(s0)
800058ac:	02b42423          	sw	a1,40(s0)
800058b0:	00e4a623          	sw	a4,12(s1)
800058b4:	00d42023          	sw	a3,0(s0)
800058b8:	0007a783          	lw	a5,0(a5)
800058bc:	a00016b7          	lui	a3,0xa0001
800058c0:	f9c6a583          	lw	a1,-100(a3) # a0000f9c <Int_Glob>
800058c4:	00f42023          	sw	a5,0(s0)
800058c8:	fa492603          	lw	a2,-92(s2)
800058cc:	00e42623          	sw	a4,12(s0)
800058d0:	00a00513          	li	a0,10
800058d4:	00c60613          	add	a2,a2,12
800058d8:	1e5000ef          	jal	800062bc <Proc_7>
800058dc:	00442783          	lw	a5,4(s0)
800058e0:	08078063          	beqz	a5,80005960 <Proc_1+0x134>
800058e4:	0004a783          	lw	a5,0(s1)
800058e8:	00c12083          	lw	ra,12(sp)
800058ec:	00812403          	lw	s0,8(sp)
800058f0:	0007af83          	lw	t6,0(a5)
800058f4:	0047af03          	lw	t5,4(a5)
800058f8:	0087ae83          	lw	t4,8(a5)
800058fc:	00c7ae03          	lw	t3,12(a5)
80005900:	0107a303          	lw	t1,16(a5)
80005904:	0147a883          	lw	a7,20(a5)
80005908:	0187a803          	lw	a6,24(a5)
8000590c:	01c7a583          	lw	a1,28(a5)
80005910:	0207a603          	lw	a2,32(a5)
80005914:	0247a683          	lw	a3,36(a5)
80005918:	0287a703          	lw	a4,40(a5)
8000591c:	02c7a783          	lw	a5,44(a5)
80005920:	01f4a023          	sw	t6,0(s1)
80005924:	01e4a223          	sw	t5,4(s1)
80005928:	01d4a423          	sw	t4,8(s1)
8000592c:	01c4a623          	sw	t3,12(s1)
80005930:	0064a823          	sw	t1,16(s1)
80005934:	0114aa23          	sw	a7,20(s1)
80005938:	0104ac23          	sw	a6,24(s1)
8000593c:	00b4ae23          	sw	a1,28(s1)
80005940:	02c4a023          	sw	a2,32(s1)
80005944:	02d4a223          	sw	a3,36(s1)
80005948:	02e4a423          	sw	a4,40(s1)
8000594c:	02f4a623          	sw	a5,44(s1)
80005950:	00012903          	lw	s2,0(sp)
80005954:	00412483          	lw	s1,4(sp)
80005958:	01010113          	add	sp,sp,16
8000595c:	00008067          	ret
80005960:	0084a503          	lw	a0,8(s1)
80005964:	00600793          	li	a5,6
80005968:	00f42623          	sw	a5,12(s0)
8000596c:	00840593          	add	a1,s0,8
80005970:	0f9000ef          	jal	80006268 <Proc_6>
80005974:	fa492783          	lw	a5,-92(s2)
80005978:	00c42503          	lw	a0,12(s0)
8000597c:	00c40613          	add	a2,s0,12
80005980:	0007a783          	lw	a5,0(a5)
80005984:	00c12083          	lw	ra,12(sp)
80005988:	00412483          	lw	s1,4(sp)
8000598c:	00f42023          	sw	a5,0(s0)
80005990:	00812403          	lw	s0,8(sp)
80005994:	00012903          	lw	s2,0(sp)
80005998:	00a00593          	li	a1,10
8000599c:	01010113          	add	sp,sp,16
800059a0:	11d0006f          	j	800062bc <Proc_7>

800059a4 <main>:
800059a4:	a00017b7          	lui	a5,0xa0001
800059a8:	c4078793          	add	a5,a5,-960 # a0000c40 <__clz_tab+0xbc8>
800059ac:	f4010113          	add	sp,sp,-192
800059b0:	0007a283          	lw	t0,0(a5)
800059b4:	0047af83          	lw	t6,4(a5)
800059b8:	00c7ae83          	lw	t4,12(a5)
800059bc:	0087af03          	lw	t5,8(a5)
800059c0:	0107ae03          	lw	t3,16(a5)
800059c4:	0147a303          	lw	t1,20(a5)
800059c8:	0187a883          	lw	a7,24(a5)
800059cc:	01c7d803          	lhu	a6,28(a5)
800059d0:	01e7c503          	lbu	a0,30(a5)
800059d4:	a00016b7          	lui	a3,0xa0001
800059d8:	a00017b7          	lui	a5,0xa0001
800059dc:	fa878793          	add	a5,a5,-88 # a0000fa8 <Ptr_Glob_inst>
800059e0:	0a112e23          	sw	ra,188(sp)
800059e4:	0a812c23          	sw	s0,184(sp)
800059e8:	09712e23          	sw	s7,156(sp)
800059ec:	09912a23          	sw	s9,148(sp)
800059f0:	0a912a23          	sw	s1,180(sp)
800059f4:	0b212823          	sw	s2,176(sp)
800059f8:	0b312623          	sw	s3,172(sp)
800059fc:	0b412423          	sw	s4,168(sp)
80005a00:	0b512223          	sw	s5,164(sp)
80005a04:	0b612023          	sw	s6,160(sp)
80005a08:	09812c23          	sw	s8,152(sp)
80005a0c:	09a12823          	sw	s10,144(sp)
80005a10:	09b12623          	sw	s11,140(sp)
80005a14:	a00013b7          	lui	t2,0xa0001
80005a18:	fd868693          	add	a3,a3,-40 # a0000fd8 <Next_Ptr_Glob_inst>
80005a1c:	a0001737          	lui	a4,0xa0001
80005a20:	c6070713          	add	a4,a4,-928 # a0000c60 <__clz_tab+0xbe8>
80005a24:	fad3a023          	sw	a3,-96(t2) # a0000fa0 <Next_Ptr_Glob>
80005a28:	00d7a023          	sw	a3,0(a5)
80005a2c:	00200693          	li	a3,2
80005a30:	00072603          	lw	a2,0(a4)
80005a34:	00d7a423          	sw	a3,8(a5)
80005a38:	a0001bb7          	lui	s7,0xa0001
80005a3c:	02800693          	li	a3,40
80005a40:	0057a823          	sw	t0,16(a5)
80005a44:	01f7aa23          	sw	t6,20(a5)
80005a48:	00d7a623          	sw	a3,12(a5)
80005a4c:	fafba223          	sw	a5,-92(s7) # a0000fa4 <Ptr_Glob>
80005a50:	0007a223          	sw	zero,4(a5)
80005a54:	00472583          	lw	a1,4(a4)
80005a58:	01e7ac23          	sw	t5,24(a5)
80005a5c:	01d7ae23          	sw	t4,28(a5)
80005a60:	03c7a023          	sw	t3,32(a5)
80005a64:	0267a223          	sw	t1,36(a5)
80005a68:	0317a423          	sw	a7,40(a5)
80005a6c:	03079623          	sh	a6,44(a5)
80005a70:	02a78723          	sb	a0,46(a5)
80005a74:	01e74783          	lbu	a5,30(a4)
80005a78:	00872e03          	lw	t3,8(a4)
80005a7c:	00c72303          	lw	t1,12(a4)
80005a80:	01072883          	lw	a7,16(a4)
80005a84:	01472803          	lw	a6,20(a4)
80005a88:	01c75683          	lhu	a3,28(a4)
80005a8c:	04c12023          	sw	a2,64(sp)
80005a90:	01872603          	lw	a2,24(a4)
80005a94:	a0001cb7          	lui	s9,0xa0001
80005a98:	a0000537          	lui	a0,0xa0000
80005a9c:	008c8713          	add	a4,s9,8 # a0001008 <Arr_2_Glob>
80005aa0:	04b12223          	sw	a1,68(sp)
80005aa4:	04f10f23          	sb	a5,94(sp)
80005aa8:	00d00593          	li	a1,13
80005aac:	00a00793          	li	a5,10
80005ab0:	62850513          	add	a0,a0,1576 # a0000628 <__clz_tab+0x5b0>
80005ab4:	64f72e23          	sw	a5,1628(a4)
80005ab8:	05c12423          	sw	t3,72(sp)
80005abc:	04612623          	sw	t1,76(sp)
80005ac0:	05112823          	sw	a7,80(sp)
80005ac4:	05012a23          	sw	a6,84(sp)
80005ac8:	04c12c23          	sw	a2,88(sp)
80005acc:	04d11e23          	sh	a3,92(sp)
80005ad0:	d09ff0ef          	jal	800057d8 <printf_>
80005ad4:	a0000537          	lui	a0,0xa0000
80005ad8:	64050513          	add	a0,a0,1600 # a0000640 <__clz_tab+0x5c8>
80005adc:	cfdff0ef          	jal	800057d8 <printf_>
80005ae0:	a0000437          	lui	s0,0xa0000
80005ae4:	65840513          	add	a0,s0,1624 # a0000658 <__clz_tab+0x5e0>
80005ae8:	cf1ff0ef          	jal	800057d8 <printf_>
80005aec:	a0000537          	lui	a0,0xa0000
80005af0:	65c50513          	add	a0,a0,1628 # a000065c <__clz_tab+0x5e4>
80005af4:	ce5ff0ef          	jal	800057d8 <printf_>
80005af8:	65840513          	add	a0,s0,1624
80005afc:	cddff0ef          	jal	800057d8 <printf_>
80005b00:	a00017b7          	lui	a5,0xa0001
80005b04:	f907a783          	lw	a5,-112(a5) # a0000f90 <Reg>
80005b08:	74078263          	beqz	a5,8000624c <main+0x8a8>
80005b0c:	a0000537          	lui	a0,0xa0000
80005b10:	68c50513          	add	a0,a0,1676 # a000068c <__clz_tab+0x614>
80005b14:	cc5ff0ef          	jal	800057d8 <printf_>
80005b18:	65840513          	add	a0,s0,1624
80005b1c:	cbdff0ef          	jal	800057d8 <printf_>
80005b20:	a0000537          	lui	a0,0xa0000
80005b24:	01400593          	li	a1,20
80005b28:	6e850513          	add	a0,a0,1768 # a00006e8 <__clz_tab+0x670>
80005b2c:	cadff0ef          	jal	800057d8 <printf_>
80005b30:	a0000537          	lui	a0,0xa0000
80005b34:	01400593          	li	a1,20
80005b38:	6f450513          	add	a0,a0,1780 # a00006f4 <__clz_tab+0x67c>
80005b3c:	c9dff0ef          	jal	800057d8 <printf_>
80005b40:	ed5fd0ef          	jal	80003a14 <get_cycle>
80005b44:	41f55793          	sra	a5,a0,0x1f
80005b48:	02f12623          	sw	a5,44(sp)
80005b4c:	02a12423          	sw	a0,40(sp)
80005b50:	ebdfd0ef          	jal	80003a0c <get_instret>
80005b54:	a00017b7          	lui	a5,0xa0001
80005b58:	c8078793          	add	a5,a5,-896 # a0000c80 <__clz_tab+0xc08>
80005b5c:	0047a703          	lw	a4,4(a5)
80005b60:	0007ad83          	lw	s11,0(a5)
80005b64:	02a12223          	sw	a0,36(sp)
80005b68:	00e12223          	sw	a4,4(sp)
80005b6c:	0087a703          	lw	a4,8(a5)
80005b70:	00100493          	li	s1,1
80005b74:	a00019b7          	lui	s3,0xa0001
80005b78:	00e12423          	sw	a4,8(sp)
80005b7c:	00c7a703          	lw	a4,12(a5)
80005b80:	a0001a37          	lui	s4,0xa0001
80005b84:	a0001437          	lui	s0,0xa0001
80005b88:	00e12623          	sw	a4,12(sp)
80005b8c:	0107a703          	lw	a4,16(a5)
80005b90:	a0003c37          	lui	s8,0xa0003
80005b94:	a0001ab7          	lui	s5,0xa0001
80005b98:	00e12823          	sw	a4,16(sp)
80005b9c:	0147a703          	lw	a4,20(a5)
80005ba0:	00e12a23          	sw	a4,20(sp)
80005ba4:	0187a703          	lw	a4,24(a5)
80005ba8:	00e12c23          	sw	a4,24(sp)
80005bac:	01c7d703          	lhu	a4,28(a5)
80005bb0:	01e7c783          	lbu	a5,30(a5)
80005bb4:	00e12e23          	sw	a4,28(sp)
80005bb8:	a0001737          	lui	a4,0xa0001
80005bbc:	02f12023          	sw	a5,32(sp)
80005bc0:	ca070d13          	add	s10,a4,-864 # a0000ca0 <__clz_tab+0xc28>
80005bc4:	04100713          	li	a4,65
80005bc8:	f8e98aa3          	sb	a4,-107(s3) # a0000f95 <Ch_1_Glob>
80005bcc:	04200713          	li	a4,66
80005bd0:	f8e40a23          	sb	a4,-108(s0) # a0000f94 <Ch_2_Glob>
80005bd4:	00412703          	lw	a4,4(sp)
80005bd8:	00100793          	li	a5,1
80005bdc:	06010593          	add	a1,sp,96
80005be0:	06e12223          	sw	a4,100(sp)
80005be4:	00812703          	lw	a4,8(sp)
80005be8:	04010513          	add	a0,sp,64
80005bec:	f8fa2c23          	sw	a5,-104(s4) # a0000f98 <Bool_Glob>
80005bf0:	06e12423          	sw	a4,104(sp)
80005bf4:	00c12703          	lw	a4,12(sp)
80005bf8:	02f12e23          	sw	a5,60(sp)
80005bfc:	07b12023          	sw	s11,96(sp)
80005c00:	06e12623          	sw	a4,108(sp)
80005c04:	01012703          	lw	a4,16(sp)
80005c08:	06e12823          	sw	a4,112(sp)
80005c0c:	01412703          	lw	a4,20(sp)
80005c10:	06e12a23          	sw	a4,116(sp)
80005c14:	01812703          	lw	a4,24(sp)
80005c18:	06e12c23          	sw	a4,120(sp)
80005c1c:	01c12703          	lw	a4,28(sp)
80005c20:	06e11e23          	sh	a4,124(sp)
80005c24:	02012703          	lw	a4,32(sp)
80005c28:	06e10f23          	sb	a4,126(sp)
80005c2c:	738000ef          	jal	80006364 <Func_2>
80005c30:	00153793          	seqz	a5,a0
80005c34:	03810613          	add	a2,sp,56
80005c38:	00300593          	li	a1,3
80005c3c:	f8fa2c23          	sw	a5,-104(s4)
80005c40:	00200513          	li	a0,2
80005c44:	00700793          	li	a5,7
80005c48:	02f12c23          	sw	a5,56(sp)
80005c4c:	670000ef          	jal	800062bc <Proc_7>
80005c50:	03812683          	lw	a3,56(sp)
80005c54:	00300613          	li	a2,3
80005c58:	008c8593          	add	a1,s9,8
80005c5c:	718c0513          	add	a0,s8,1816 # a0003718 <Arr_1_Glob>
80005c60:	66c000ef          	jal	800062cc <Proc_8>
80005c64:	fa4ba503          	lw	a0,-92(s7)
80005c68:	bc5ff0ef          	jal	8000582c <Proc_1>
80005c6c:	f9444703          	lbu	a4,-108(s0)
80005c70:	04000793          	li	a5,64
80005c74:	5ce7f863          	bgeu	a5,a4,80006244 <main+0x8a0>
80005c78:	04100913          	li	s2,65
80005c7c:	00300b13          	li	s6,3
80005c80:	0140006f          	j	80005c94 <main+0x2f0>
80005c84:	f9444783          	lbu	a5,-108(s0)
80005c88:	00190913          	add	s2,s2,1
80005c8c:	0ff97913          	zext.b	s2,s2
80005c90:	0927e263          	bltu	a5,s2,80005d14 <main+0x370>
80005c94:	04300593          	li	a1,67
80005c98:	00090513          	mv	a0,s2
80005c9c:	6a4000ef          	jal	80006340 <Func_1>
80005ca0:	03c12783          	lw	a5,60(sp)
80005ca4:	fef510e3          	bne	a0,a5,80005c84 <main+0x2e0>
80005ca8:	03c10593          	add	a1,sp,60
80005cac:	00000513          	li	a0,0
80005cb0:	5b8000ef          	jal	80006268 <Proc_6>
80005cb4:	01ed4783          	lbu	a5,30(s10)
80005cb8:	000d2303          	lw	t1,0(s10)
80005cbc:	004d2883          	lw	a7,4(s10)
80005cc0:	008d2803          	lw	a6,8(s10)
80005cc4:	00cd2503          	lw	a0,12(s10)
80005cc8:	010d2583          	lw	a1,16(s10)
80005ccc:	014d2603          	lw	a2,20(s10)
80005cd0:	018d2683          	lw	a3,24(s10)
80005cd4:	01cd5703          	lhu	a4,28(s10)
80005cd8:	06f10f23          	sb	a5,126(sp)
80005cdc:	f9444783          	lbu	a5,-108(s0)
80005ce0:	00190913          	add	s2,s2,1
80005ce4:	06612023          	sw	t1,96(sp)
80005ce8:	07112223          	sw	a7,100(sp)
80005cec:	07012423          	sw	a6,104(sp)
80005cf0:	06a12623          	sw	a0,108(sp)
80005cf4:	06b12823          	sw	a1,112(sp)
80005cf8:	06c12a23          	sw	a2,116(sp)
80005cfc:	06d12c23          	sw	a3,120(sp)
80005d00:	06e11e23          	sh	a4,124(sp)
80005d04:	f89aae23          	sw	s1,-100(s5) # a0000f9c <Int_Glob>
80005d08:	0ff97913          	zext.b	s2,s2
80005d0c:	00048b13          	mv	s6,s1
80005d10:	f927f2e3          	bgeu	a5,s2,80005c94 <main+0x2f0>
80005d14:	001b1913          	sll	s2,s6,0x1
80005d18:	01690933          	add	s2,s2,s6
80005d1c:	03812b03          	lw	s6,56(sp)
80005d20:	00090513          	mv	a0,s2
80005d24:	000b0593          	mv	a1,s6
80005d28:	819fd0ef          	jal	80003540 <__divsi3>
80005d2c:	f959c703          	lbu	a4,-107(s3)
80005d30:	04100793          	li	a5,65
80005d34:	00050693          	mv	a3,a0
80005d38:	00f71863          	bne	a4,a5,80005d48 <main+0x3a4>
80005d3c:	f9caa783          	lw	a5,-100(s5)
80005d40:	00950693          	add	a3,a0,9
80005d44:	40f686b3          	sub	a3,a3,a5
80005d48:	00148493          	add	s1,s1,1
80005d4c:	01500793          	li	a5,21
80005d50:	e6f49ae3          	bne	s1,a5,80005bc4 <main+0x220>
80005d54:	00d12223          	sw	a3,4(sp)
80005d58:	00a12423          	sw	a0,8(sp)
80005d5c:	cb1fd0ef          	jal	80003a0c <get_instret>
80005d60:	00050d13          	mv	s10,a0
80005d64:	cb1fd0ef          	jal	80003a14 <get_cycle>
80005d68:	00050c93          	mv	s9,a0
80005d6c:	a0000537          	lui	a0,0xa0000
80005d70:	72450513          	add	a0,a0,1828 # a0000724 <__clz_tab+0x6ac>
80005d74:	a65ff0ef          	jal	800057d8 <printf_>
80005d78:	a0000db7          	lui	s11,0xa0000
80005d7c:	658d8513          	add	a0,s11,1624 # a0000658 <__clz_tab+0x5e0>
80005d80:	a59ff0ef          	jal	800057d8 <printf_>
80005d84:	a0000537          	lui	a0,0xa0000
80005d88:	73450513          	add	a0,a0,1844 # a0000734 <__clz_tab+0x6bc>
80005d8c:	a4dff0ef          	jal	800057d8 <printf_>
80005d90:	658d8513          	add	a0,s11,1624
80005d94:	a45ff0ef          	jal	800057d8 <printf_>
80005d98:	f9caa583          	lw	a1,-100(s5)
80005d9c:	a0000537          	lui	a0,0xa0000
80005da0:	76c50513          	add	a0,a0,1900 # a000076c <__clz_tab+0x6f4>
80005da4:	a0000ab7          	lui	s5,0xa0000
80005da8:	a31ff0ef          	jal	800057d8 <printf_>
80005dac:	00500593          	li	a1,5
80005db0:	788a8513          	add	a0,s5,1928 # a0000788 <__clz_tab+0x710>
80005db4:	a25ff0ef          	jal	800057d8 <printf_>
80005db8:	f98a2583          	lw	a1,-104(s4)
80005dbc:	a0000537          	lui	a0,0xa0000
80005dc0:	7a450513          	add	a0,a0,1956 # a00007a4 <__clz_tab+0x72c>
80005dc4:	a15ff0ef          	jal	800057d8 <printf_>
80005dc8:	00100593          	li	a1,1
80005dcc:	788a8513          	add	a0,s5,1928
80005dd0:	a09ff0ef          	jal	800057d8 <printf_>
80005dd4:	f959c583          	lbu	a1,-107(s3)
80005dd8:	a0000537          	lui	a0,0xa0000
80005ddc:	7c050513          	add	a0,a0,1984 # a00007c0 <__clz_tab+0x748>
80005de0:	9f9ff0ef          	jal	800057d8 <printf_>
80005de4:	a00009b7          	lui	s3,0xa0000
80005de8:	04100593          	li	a1,65
80005dec:	7dc98513          	add	a0,s3,2012 # a00007dc <__clz_tab+0x764>
80005df0:	9e9ff0ef          	jal	800057d8 <printf_>
80005df4:	f9444583          	lbu	a1,-108(s0)
80005df8:	a0000537          	lui	a0,0xa0000
80005dfc:	7f850513          	add	a0,a0,2040 # a00007f8 <__clz_tab+0x780>
80005e00:	9d9ff0ef          	jal	800057d8 <printf_>
80005e04:	04200593          	li	a1,66
80005e08:	7dc98513          	add	a0,s3,2012
80005e0c:	9cdff0ef          	jal	800057d8 <printf_>
80005e10:	718c0c13          	add	s8,s8,1816
80005e14:	020c2583          	lw	a1,32(s8)
80005e18:	a0001537          	lui	a0,0xa0001
80005e1c:	81450513          	add	a0,a0,-2028 # a0000814 <__clz_tab+0x79c>
80005e20:	9b9ff0ef          	jal	800057d8 <printf_>
80005e24:	00700593          	li	a1,7
80005e28:	788a8513          	add	a0,s5,1928
80005e2c:	9adff0ef          	jal	800057d8 <printf_>
80005e30:	a00017b7          	lui	a5,0xa0001
80005e34:	00878793          	add	a5,a5,8 # a0001008 <Arr_2_Glob>
80005e38:	65c7a583          	lw	a1,1628(a5)
80005e3c:	a0001537          	lui	a0,0xa0001
80005e40:	83050513          	add	a0,a0,-2000 # a0000830 <__clz_tab+0x7b8>
80005e44:	995ff0ef          	jal	800057d8 <printf_>
80005e48:	a0001537          	lui	a0,0xa0001
80005e4c:	84c50513          	add	a0,a0,-1972 # a000084c <__clz_tab+0x7d4>
80005e50:	989ff0ef          	jal	800057d8 <printf_>
80005e54:	a0001537          	lui	a0,0xa0001
80005e58:	87850513          	add	a0,a0,-1928 # a0000878 <__clz_tab+0x800>
80005e5c:	97dff0ef          	jal	800057d8 <printf_>
80005e60:	fa4ba603          	lw	a2,-92(s7)
80005e64:	a0001737          	lui	a4,0xa0001
80005e68:	88470513          	add	a0,a4,-1916 # a0000884 <__clz_tab+0x80c>
80005e6c:	00062583          	lw	a1,0(a2)
80005e70:	a0001db7          	lui	s11,0xa0001
80005e74:	a0001c37          	lui	s8,0xa0001
80005e78:	961ff0ef          	jal	800057d8 <printf_>
80005e7c:	a0001537          	lui	a0,0xa0001
80005e80:	8a050513          	add	a0,a0,-1888 # a00008a0 <__clz_tab+0x828>
80005e84:	955ff0ef          	jal	800057d8 <printf_>
80005e88:	fa4ba603          	lw	a2,-92(s7)
80005e8c:	8d4d8513          	add	a0,s11,-1836 # a00008d4 <__clz_tab+0x85c>
80005e90:	a0001a37          	lui	s4,0xa0001
80005e94:	00462583          	lw	a1,4(a2)
80005e98:	a00019b7          	lui	s3,0xa0001
80005e9c:	a0001437          	lui	s0,0xa0001
80005ea0:	939ff0ef          	jal	800057d8 <printf_>
80005ea4:	00000593          	li	a1,0
80005ea8:	788a8513          	add	a0,s5,1928
80005eac:	92dff0ef          	jal	800057d8 <printf_>
80005eb0:	fa4ba603          	lw	a2,-92(s7)
80005eb4:	8f0c0513          	add	a0,s8,-1808 # a00008f0 <__clz_tab+0x878>
80005eb8:	41690933          	sub	s2,s2,s6
80005ebc:	00862583          	lw	a1,8(a2)
80005ec0:	41fcd493          	sra	s1,s9,0x1f
80005ec4:	915ff0ef          	jal	800057d8 <printf_>
80005ec8:	00200593          	li	a1,2
80005ecc:	788a8513          	add	a0,s5,1928
80005ed0:	909ff0ef          	jal	800057d8 <printf_>
80005ed4:	fa4ba603          	lw	a2,-92(s7)
80005ed8:	90ca0513          	add	a0,s4,-1780 # a000090c <__clz_tab+0x894>
80005edc:	00c62583          	lw	a1,12(a2)
80005ee0:	8f9ff0ef          	jal	800057d8 <printf_>
80005ee4:	01100593          	li	a1,17
80005ee8:	788a8513          	add	a0,s5,1928
80005eec:	8edff0ef          	jal	800057d8 <printf_>
80005ef0:	fa4ba583          	lw	a1,-92(s7)
80005ef4:	92898513          	add	a0,s3,-1752 # a0000928 <__clz_tab+0x8b0>
80005ef8:	a0001bb7          	lui	s7,0xa0001
80005efc:	01058593          	add	a1,a1,16 # c0001010 <__stack_base+0x1fff1010>
80005f00:	8d9ff0ef          	jal	800057d8 <printf_>
80005f04:	94440513          	add	a0,s0,-1724 # a0000944 <__clz_tab+0x8cc>
80005f08:	8d1ff0ef          	jal	800057d8 <printf_>
80005f0c:	a0001537          	lui	a0,0xa0001
80005f10:	97c50513          	add	a0,a0,-1668 # a000097c <__clz_tab+0x904>
80005f14:	8c5ff0ef          	jal	800057d8 <printf_>
80005f18:	fa0ba603          	lw	a2,-96(s7) # a0000fa0 <Next_Ptr_Glob>
80005f1c:	a0001737          	lui	a4,0xa0001
80005f20:	88470513          	add	a0,a4,-1916 # a0000884 <__clz_tab+0x80c>
80005f24:	00062583          	lw	a1,0(a2)
80005f28:	8b1ff0ef          	jal	800057d8 <printf_>
80005f2c:	a0001537          	lui	a0,0xa0001
80005f30:	99050513          	add	a0,a0,-1648 # a0000990 <__clz_tab+0x918>
80005f34:	8a5ff0ef          	jal	800057d8 <printf_>
80005f38:	fa0ba703          	lw	a4,-96(s7)
80005f3c:	8d4d8513          	add	a0,s11,-1836
80005f40:	00472583          	lw	a1,4(a4)
80005f44:	895ff0ef          	jal	800057d8 <printf_>
80005f48:	00000593          	li	a1,0
80005f4c:	788a8513          	add	a0,s5,1928
80005f50:	889ff0ef          	jal	800057d8 <printf_>
80005f54:	fa0ba703          	lw	a4,-96(s7)
80005f58:	8f0c0513          	add	a0,s8,-1808
80005f5c:	00872583          	lw	a1,8(a4)
80005f60:	879ff0ef          	jal	800057d8 <printf_>
80005f64:	00100593          	li	a1,1
80005f68:	788a8513          	add	a0,s5,1928
80005f6c:	86dff0ef          	jal	800057d8 <printf_>
80005f70:	fa0ba703          	lw	a4,-96(s7)
80005f74:	90ca0513          	add	a0,s4,-1780
80005f78:	a0000a37          	lui	s4,0xa0000
80005f7c:	00c72583          	lw	a1,12(a4)
80005f80:	859ff0ef          	jal	800057d8 <printf_>
80005f84:	01200593          	li	a1,18
80005f88:	788a8513          	add	a0,s5,1928
80005f8c:	84dff0ef          	jal	800057d8 <printf_>
80005f90:	fa0ba583          	lw	a1,-96(s7)
80005f94:	92898513          	add	a0,s3,-1752
80005f98:	01058593          	add	a1,a1,16
80005f9c:	83dff0ef          	jal	800057d8 <printf_>
80005fa0:	94440513          	add	a0,s0,-1724
80005fa4:	835ff0ef          	jal	800057d8 <printf_>
80005fa8:	00412683          	lw	a3,4(sp)
80005fac:	a0001537          	lui	a0,0xa0001
80005fb0:	9d050513          	add	a0,a0,-1584 # a00009d0 <__clz_tab+0x958>
80005fb4:	00068593          	mv	a1,a3
80005fb8:	821ff0ef          	jal	800057d8 <printf_>
80005fbc:	00500593          	li	a1,5
80005fc0:	788a8513          	add	a0,s5,1928
80005fc4:	815ff0ef          	jal	800057d8 <printf_>
80005fc8:	00812783          	lw	a5,8(sp)
80005fcc:	00391593          	sll	a1,s2,0x3
80005fd0:	412585b3          	sub	a1,a1,s2
80005fd4:	a0001537          	lui	a0,0xa0001
80005fd8:	40f585b3          	sub	a1,a1,a5
80005fdc:	9ec50513          	add	a0,a0,-1556 # a00009ec <__clz_tab+0x974>
80005fe0:	ff8ff0ef          	jal	800057d8 <printf_>
80005fe4:	00d00593          	li	a1,13
80005fe8:	788a8513          	add	a0,s5,1928
80005fec:	fecff0ef          	jal	800057d8 <printf_>
80005ff0:	03812583          	lw	a1,56(sp)
80005ff4:	a0001537          	lui	a0,0xa0001
80005ff8:	a0850513          	add	a0,a0,-1528 # a0000a08 <__clz_tab+0x990>
80005ffc:	fdcff0ef          	jal	800057d8 <printf_>
80006000:	00700593          	li	a1,7
80006004:	788a8513          	add	a0,s5,1928
80006008:	fd0ff0ef          	jal	800057d8 <printf_>
8000600c:	03c12583          	lw	a1,60(sp)
80006010:	a0001537          	lui	a0,0xa0001
80006014:	a2450513          	add	a0,a0,-1500 # a0000a24 <__clz_tab+0x9ac>
80006018:	fc0ff0ef          	jal	800057d8 <printf_>
8000601c:	00100593          	li	a1,1
80006020:	788a8513          	add	a0,s5,1928
80006024:	fb4ff0ef          	jal	800057d8 <printf_>
80006028:	a0001537          	lui	a0,0xa0001
8000602c:	04010593          	add	a1,sp,64
80006030:	a4050513          	add	a0,a0,-1472 # a0000a40 <__clz_tab+0x9c8>
80006034:	fa4ff0ef          	jal	800057d8 <printf_>
80006038:	a0001537          	lui	a0,0xa0001
8000603c:	a5c50513          	add	a0,a0,-1444 # a0000a5c <__clz_tab+0x9e4>
80006040:	f98ff0ef          	jal	800057d8 <printf_>
80006044:	a0001537          	lui	a0,0xa0001
80006048:	06010593          	add	a1,sp,96
8000604c:	a9450513          	add	a0,a0,-1388 # a0000a94 <__clz_tab+0xa1c>
80006050:	f88ff0ef          	jal	800057d8 <printf_>
80006054:	a0001537          	lui	a0,0xa0001
80006058:	ab050513          	add	a0,a0,-1360 # a0000ab0 <__clz_tab+0xa38>
8000605c:	f7cff0ef          	jal	800057d8 <printf_>
80006060:	658a0513          	add	a0,s4,1624 # a0000658 <__clz_tab+0x5e0>
80006064:	f74ff0ef          	jal	800057d8 <printf_>
80006068:	02412703          	lw	a4,36(sp)
8000606c:	02812a83          	lw	s5,40(sp)
80006070:	02c12b03          	lw	s6,44(sp)
80006074:	40ed09b3          	sub	s3,s10,a4
80006078:	415c8933          	sub	s2,s9,s5
8000607c:	a0001537          	lui	a0,0xa0001
80006080:	00070593          	mv	a1,a4
80006084:	012cb7b3          	sltu	a5,s9,s2
80006088:	00098693          	mv	a3,s3
8000608c:	41648433          	sub	s0,s1,s6
80006090:	000d0613          	mv	a2,s10
80006094:	ae850513          	add	a0,a0,-1304 # a0000ae8 <__clz_tab+0xa70>
80006098:	40f40433          	sub	s0,s0,a5
8000609c:	f3cff0ef          	jal	800057d8 <printf_>
800060a0:	a0001537          	lui	a0,0xa0001
800060a4:	000a8613          	mv	a2,s5
800060a8:	000b0593          	mv	a1,s6
800060ac:	b1c50513          	add	a0,a0,-1252 # a0000b1c <__clz_tab+0xaa4>
800060b0:	f28ff0ef          	jal	800057d8 <printf_>
800060b4:	a0001537          	lui	a0,0xa0001
800060b8:	000c8613          	mv	a2,s9
800060bc:	00048593          	mv	a1,s1
800060c0:	b4050513          	add	a0,a0,-1216 # a0000b40 <__clz_tab+0xac8>
800060c4:	f14ff0ef          	jal	800057d8 <printf_>
800060c8:	a0001537          	lui	a0,0xa0001
800060cc:	00090613          	mv	a2,s2
800060d0:	00040593          	mv	a1,s0
800060d4:	b6050513          	add	a0,a0,-1184 # a0000b60 <__clz_tab+0xae8>
800060d8:	f00ff0ef          	jal	800057d8 <printf_>
800060dc:	a0001537          	lui	a0,0xa0001
800060e0:	00090593          	mv	a1,s2
800060e4:	b8050513          	add	a0,a0,-1152 # a0000b80 <__clz_tab+0xb08>
800060e8:	ef0ff0ef          	jal	800057d8 <printf_>
800060ec:	3b9ad5b7          	lui	a1,0x3b9ad
800060f0:	a0001537          	lui	a0,0xa0001
800060f4:	a0058593          	add	a1,a1,-1536 # 3b9aca00 <__stack_size+0x3b9a8a00>
800060f8:	b9850513          	add	a0,a0,-1128 # a0000b98 <__clz_tab+0xb20>
800060fc:	edcff0ef          	jal	800057d8 <printf_>
80006100:	00040593          	mv	a1,s0
80006104:	00090513          	mv	a0,s2
80006108:	a24fd0ef          	jal	8000332c <__floatundisf>
8000610c:	00050493          	mv	s1,a0
80006110:	00098513          	mv	a0,s3
80006114:	93cfd0ef          	jal	80003250 <__floatunsisf>
80006118:	00048593          	mv	a1,s1
8000611c:	aedfc0ef          	jal	80002c08 <__divsf3>
80006120:	b44fd0ef          	jal	80003464 <__extendsfdf2>
80006124:	00050613          	mv	a2,a0
80006128:	a0001537          	lui	a0,0xa0001
8000612c:	00058693          	mv	a3,a1
80006130:	bbc50513          	add	a0,a0,-1092 # a0000bbc <__clz_tab+0xb44>
80006134:	ea4ff0ef          	jal	800057d8 <printf_>
80006138:	a00017b7          	lui	a5,0xa0001
8000613c:	f787a503          	lw	a0,-136(a5) # a0000f78 <pow10.0+0xe8>
80006140:	00048593          	mv	a1,s1
80006144:	a00019b7          	lui	s3,0xa0001
80006148:	ac1fc0ef          	jal	80002c08 <__divsf3>
8000614c:	a00017b7          	lui	a5,0xa0001
80006150:	f7c7a583          	lw	a1,-132(a5) # a0000f7c <pow10.0+0xec>
80006154:	a00014b7          	lui	s1,0xa0001
80006158:	dddfc0ef          	jal	80002f34 <__mulsf3>
8000615c:	a00017b7          	lui	a5,0xa0001
80006160:	f807a583          	lw	a1,-128(a5) # a0000f80 <pow10.0+0xf0>
80006164:	aa5fc0ef          	jal	80002c08 <__divsf3>
80006168:	afcfd0ef          	jal	80003464 <__extendsfdf2>
8000616c:	00050613          	mv	a2,a0
80006170:	a0001537          	lui	a0,0xa0001
80006174:	00058693          	mv	a3,a1
80006178:	bc850513          	add	a0,a0,-1080 # a0000bc8 <__clz_tab+0xb50>
8000617c:	e5cff0ef          	jal	800057d8 <printf_>
80006180:	00005637          	lui	a2,0x5
80006184:	e2060613          	add	a2,a2,-480 # 4e20 <__stack_size+0xe20>
80006188:	00000693          	li	a3,0
8000618c:	00090513          	mv	a0,s2
80006190:	00040593          	mv	a1,s0
80006194:	9f0fa0ef          	jal	80000384 <__udivdi3>
80006198:	00050793          	mv	a5,a0
8000619c:	3b9ad537          	lui	a0,0x3b9ad
800061a0:	00090613          	mv	a2,s2
800061a4:	00040693          	mv	a3,s0
800061a8:	a0050513          	add	a0,a0,-1536 # 3b9aca00 <__stack_size+0x3b9a8a00>
800061ac:	00000593          	li	a1,0
800061b0:	f8f9a623          	sw	a5,-116(s3) # a0000f8c <Microseconds>
800061b4:	9d0fa0ef          	jal	80000384 <__udivdi3>
800061b8:	00251793          	sll	a5,a0,0x2
800061bc:	00a787b3          	add	a5,a5,a0
800061c0:	a0001537          	lui	a0,0xa0001
800061c4:	00279793          	sll	a5,a5,0x2
800061c8:	bd850513          	add	a0,a0,-1064 # a0000bd8 <__clz_tab+0xb60>
800061cc:	f8f4a423          	sw	a5,-120(s1) # a0000f88 <Dhrystones_Per_Second>
800061d0:	e08ff0ef          	jal	800057d8 <printf_>
800061d4:	f8c9a583          	lw	a1,-116(s3)
800061d8:	a0001437          	lui	s0,0xa0001
800061dc:	c0840513          	add	a0,s0,-1016 # a0000c08 <__clz_tab+0xb90>
800061e0:	df8ff0ef          	jal	800057d8 <printf_>
800061e4:	a0001537          	lui	a0,0xa0001
800061e8:	c1050513          	add	a0,a0,-1008 # a0000c10 <__clz_tab+0xb98>
800061ec:	decff0ef          	jal	800057d8 <printf_>
800061f0:	f884a583          	lw	a1,-120(s1)
800061f4:	c0840513          	add	a0,s0,-1016
800061f8:	de0ff0ef          	jal	800057d8 <printf_>
800061fc:	658a0513          	add	a0,s4,1624
80006200:	dd8ff0ef          	jal	800057d8 <printf_>
80006204:	0bc12083          	lw	ra,188(sp)
80006208:	0b812403          	lw	s0,184(sp)
8000620c:	0b412483          	lw	s1,180(sp)
80006210:	0b012903          	lw	s2,176(sp)
80006214:	0ac12983          	lw	s3,172(sp)
80006218:	0a812a03          	lw	s4,168(sp)
8000621c:	0a412a83          	lw	s5,164(sp)
80006220:	0a012b03          	lw	s6,160(sp)
80006224:	09c12b83          	lw	s7,156(sp)
80006228:	09812c03          	lw	s8,152(sp)
8000622c:	09412c83          	lw	s9,148(sp)
80006230:	09012d03          	lw	s10,144(sp)
80006234:	08c12d83          	lw	s11,140(sp)
80006238:	00000513          	li	a0,0
8000623c:	0c010113          	add	sp,sp,192
80006240:	00008067          	ret
80006244:	00900913          	li	s2,9
80006248:	ad5ff06f          	j	80005d1c <main+0x378>
8000624c:	a0000537          	lui	a0,0xa0000
80006250:	6b850513          	add	a0,a0,1720 # a00006b8 <__clz_tab+0x640>
80006254:	d84ff0ef          	jal	800057d8 <printf_>
80006258:	a00007b7          	lui	a5,0xa0000
8000625c:	65878513          	add	a0,a5,1624 # a0000658 <__clz_tab+0x5e0>
80006260:	d78ff0ef          	jal	800057d8 <printf_>
80006264:	8bdff06f          	j	80005b20 <main+0x17c>

80006268 <Proc_6>:
80006268:	00200793          	li	a5,2
8000626c:	02f50e63          	beq	a0,a5,800062a8 <Proc_6+0x40>
80006270:	00300713          	li	a4,3
80006274:	00e5a023          	sw	a4,0(a1)
80006278:	00100713          	li	a4,1
8000627c:	00e50a63          	beq	a0,a4,80006290 <Proc_6+0x28>
80006280:	00400713          	li	a4,4
80006284:	02e50863          	beq	a0,a4,800062b4 <Proc_6+0x4c>
80006288:	00050c63          	beqz	a0,800062a0 <Proc_6+0x38>
8000628c:	00008067          	ret
80006290:	a00017b7          	lui	a5,0xa0001
80006294:	f9c7a703          	lw	a4,-100(a5) # a0000f9c <Int_Glob>
80006298:	06400793          	li	a5,100
8000629c:	fee7d8e3          	bge	a5,a4,8000628c <Proc_6+0x24>
800062a0:	0005a023          	sw	zero,0(a1)
800062a4:	00008067          	ret
800062a8:	00100793          	li	a5,1
800062ac:	00f5a023          	sw	a5,0(a1)
800062b0:	00008067          	ret
800062b4:	00f5a023          	sw	a5,0(a1)
800062b8:	00008067          	ret

800062bc <Proc_7>:
800062bc:	00250513          	add	a0,a0,2
800062c0:	00b505b3          	add	a1,a0,a1
800062c4:	00b62023          	sw	a1,0(a2)
800062c8:	00008067          	ret

800062cc <Proc_8>:
800062cc:	00560713          	add	a4,a2,5
800062d0:	00171793          	sll	a5,a4,0x1
800062d4:	00e787b3          	add	a5,a5,a4
800062d8:	00379793          	sll	a5,a5,0x3
800062dc:	00e787b3          	add	a5,a5,a4
800062e0:	00379793          	sll	a5,a5,0x3
800062e4:	00261613          	sll	a2,a2,0x2
800062e8:	00271813          	sll	a6,a4,0x2
800062ec:	01050533          	add	a0,a0,a6
800062f0:	00f60833          	add	a6,a2,a5
800062f4:	00d52023          	sw	a3,0(a0)
800062f8:	00d52223          	sw	a3,4(a0)
800062fc:	06e52c23          	sw	a4,120(a0)
80006300:	010586b3          	add	a3,a1,a6
80006304:	0106a803          	lw	a6,16(a3)
80006308:	00e6aa23          	sw	a4,20(a3)
8000630c:	00e6ac23          	sw	a4,24(a3)
80006310:	00180713          	add	a4,a6,1
80006314:	00e6a823          	sw	a4,16(a3)
80006318:	00052703          	lw	a4,0(a0)
8000631c:	00c585b3          	add	a1,a1,a2
80006320:	00f585b3          	add	a1,a1,a5
80006324:	000017b7          	lui	a5,0x1
80006328:	00b787b3          	add	a5,a5,a1
8000632c:	fae7aa23          	sw	a4,-76(a5) # fb4 <__stack_size-0x304c>
80006330:	a00017b7          	lui	a5,0xa0001
80006334:	00500713          	li	a4,5
80006338:	f8e7ae23          	sw	a4,-100(a5) # a0000f9c <Int_Glob>
8000633c:	00008067          	ret

80006340 <Func_1>:
80006340:	0ff57513          	zext.b	a0,a0
80006344:	0ff5f593          	zext.b	a1,a1
80006348:	00b50663          	beq	a0,a1,80006354 <Func_1+0x14>
8000634c:	00000513          	li	a0,0
80006350:	00008067          	ret
80006354:	a00017b7          	lui	a5,0xa0001
80006358:	f8a78aa3          	sb	a0,-107(a5) # a0000f95 <Ch_1_Glob>
8000635c:	00100513          	li	a0,1
80006360:	00008067          	ret

80006364 <Func_2>:
80006364:	ff010113          	add	sp,sp,-16
80006368:	00112623          	sw	ra,12(sp)
8000636c:	00254703          	lbu	a4,2(a0)
80006370:	0035c783          	lbu	a5,3(a1)
80006374:	a00016b7          	lui	a3,0xa0001
80006378:	02e78863          	beq	a5,a4,800063a8 <Func_2+0x44>
8000637c:	e8df90ef          	jal	80000208 <strcmp>
80006380:	00000793          	li	a5,0
80006384:	00a05a63          	blez	a0,80006398 <Func_2+0x34>
80006388:	a00017b7          	lui	a5,0xa0001
8000638c:	00a00713          	li	a4,10
80006390:	f8e7ae23          	sw	a4,-100(a5) # a0000f9c <Int_Glob>
80006394:	00100793          	li	a5,1
80006398:	00c12083          	lw	ra,12(sp)
8000639c:	00078513          	mv	a0,a5
800063a0:	01010113          	add	sp,sp,16
800063a4:	00008067          	ret
800063a8:	f8f68aa3          	sb	a5,-107(a3) # a0000f95 <Ch_1_Glob>
800063ac:	fcdff06f          	j	80006378 <Func_2+0x14>
