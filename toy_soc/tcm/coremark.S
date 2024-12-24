
/data/usr/jiaoyd/csr_baremental/benchmarks/build/toy_bm/coremark.elf:     file format elf32-littleriscv


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
80000088:	d2828293          	add	t0,t0,-728 # a0000dac <__bss_end>
8000008c:	20001317          	auipc	t1,0x20001
80000090:	d2030313          	add	t1,t1,-736 # a0000dac <__bss_end>

80000094 <clear_bss_loop>:
80000094:	0002a023          	sw	zero,0(t0)
80000098:	00428293          	add	t0,t0,4
8000009c:	fe62cce3          	blt	t0,t1,80000094 <clear_bss_loop>
800000a0:	20001297          	auipc	t0,0x20001
800000a4:	ce428293          	add	t0,t0,-796 # a0000d84 <__sbss_start>
800000a8:	20001317          	auipc	t1,0x20001
800000ac:	d0430313          	add	t1,t1,-764 # a0000dac <__bss_end>

800000b0 <clear_sbss_loop>:
800000b0:	0002a023          	sw	zero,0(t0)
800000b4:	00428293          	add	t0,t0,4
800000b8:	fe62cce3          	blt	t0,t1,800000b0 <clear_sbss_loop>

800000bc <start_warm>:
800000bc:	621020ef          	jal	80002edc <init>
800000c0:	00800193          	li	gp,8
800000c4:	30019073          	csrw	mstatus,gp
800000c8:	000011b7          	lui	gp,0x1
800000cc:	88818193          	add	gp,gp,-1912 # 888 <__stack_size-0x3778>
800000d0:	30419073          	csrw	mie,gp
800000d4:	00000717          	auipc	a4,0x0
800000d8:	01870713          	add	a4,a4,24 # 800000ec <_trap_handler>
800000dc:	30571073          	csrw	mtvec,a4
800000e0:	509050ef          	jal	80005de8 <main>
800000e4:	5c9020ef          	jal	80002eac <to_host>
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
80000184:	6ed020ef          	jal	80003070 <toy_trap_handler>

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

80000208 <__udivdi3>:
#endif

#ifdef L_udivdi3
UDWtype
__udivdi3 (UDWtype n, UDWtype d)
{
80000208:	00050893          	mv	a7,a0
8000020c:	00058313          	mv	t1,a1
  d0 = dd.s.low;
80000210:	00060713          	mv	a4,a2
  n0 = nn.s.low;
80000214:	00050813          	mv	a6,a0
  n1 = nn.s.high;
80000218:	00058793          	mv	a5,a1
  if (d1 == 0)
8000021c:	28069263          	bnez	a3,800004a0 <__udivdi3+0x298>
      if (d0 > n1)
80000220:	a00005b7          	lui	a1,0xa0000
80000224:	03c58593          	add	a1,a1,60 # a000003c <__clz_tab>
80000228:	0ec37663          	bgeu	t1,a2,80000314 <__udivdi3+0x10c>
	  count_leading_zeros (bm, d0);
8000022c:	000106b7          	lui	a3,0x10
80000230:	0cd67863          	bgeu	a2,a3,80000300 <__udivdi3+0xf8>
80000234:	10063693          	sltiu	a3,a2,256
80000238:	0016b693          	seqz	a3,a3
8000023c:	00369693          	sll	a3,a3,0x3
80000240:	00d65533          	srl	a0,a2,a3
80000244:	00a585b3          	add	a1,a1,a0
80000248:	0005c583          	lbu	a1,0(a1)
8000024c:	02000513          	li	a0,32
80000250:	00d586b3          	add	a3,a1,a3
80000254:	40d505b3          	sub	a1,a0,a3
	  if (bm != 0)
80000258:	00d50c63          	beq	a0,a3,80000270 <__udivdi3+0x68>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
8000025c:	00b317b3          	sll	a5,t1,a1
80000260:	00d8d6b3          	srl	a3,a7,a3
	      d0 = d0 << bm;
80000264:	00b61733          	sll	a4,a2,a1
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
80000268:	00f6e7b3          	or	a5,a3,a5
	      n0 = n0 << bm;
8000026c:	00b89833          	sll	a6,a7,a1
	  udiv_qrnnd (q0, n0, n1, n0, d0);
80000270:	01075593          	srl	a1,a4,0x10
80000274:	02b7d333          	divu	t1,a5,a1
80000278:	01071613          	sll	a2,a4,0x10
8000027c:	01065613          	srl	a2,a2,0x10
80000280:	02b7f7b3          	remu	a5,a5,a1
80000284:	00030513          	mv	a0,t1
80000288:	026608b3          	mul	a7,a2,t1
8000028c:	01079693          	sll	a3,a5,0x10
80000290:	01085793          	srl	a5,a6,0x10
80000294:	00d7e7b3          	or	a5,a5,a3
80000298:	0117fe63          	bgeu	a5,a7,800002b4 <__udivdi3+0xac>
8000029c:	00f707b3          	add	a5,a4,a5
800002a0:	fff30513          	add	a0,t1,-1
800002a4:	00e7e863          	bltu	a5,a4,800002b4 <__udivdi3+0xac>
800002a8:	0117f663          	bgeu	a5,a7,800002b4 <__udivdi3+0xac>
800002ac:	ffe30513          	add	a0,t1,-2
800002b0:	00e787b3          	add	a5,a5,a4
800002b4:	411787b3          	sub	a5,a5,a7
800002b8:	02b7d8b3          	divu	a7,a5,a1
800002bc:	01081813          	sll	a6,a6,0x10
800002c0:	01085813          	srl	a6,a6,0x10
800002c4:	02b7f7b3          	remu	a5,a5,a1
800002c8:	031606b3          	mul	a3,a2,a7
800002cc:	01079793          	sll	a5,a5,0x10
800002d0:	00f86833          	or	a6,a6,a5
800002d4:	00088793          	mv	a5,a7
800002d8:	00d87c63          	bgeu	a6,a3,800002f0 <__udivdi3+0xe8>
800002dc:	01070833          	add	a6,a4,a6
800002e0:	fff88793          	add	a5,a7,-1
800002e4:	00e86663          	bltu	a6,a4,800002f0 <__udivdi3+0xe8>
800002e8:	00d87463          	bgeu	a6,a3,800002f0 <__udivdi3+0xe8>
800002ec:	ffe88793          	add	a5,a7,-2
800002f0:	01051513          	sll	a0,a0,0x10
800002f4:	00f56533          	or	a0,a0,a5
	      q1 = 0;
800002f8:	00000593          	li	a1,0
  return __udivmoddi4 (n, d, (UDWtype *) 0);
}
800002fc:	00008067          	ret
	  count_leading_zeros (bm, d0);
80000300:	01000537          	lui	a0,0x1000
80000304:	01800693          	li	a3,24
80000308:	f2a67ce3          	bgeu	a2,a0,80000240 <__udivdi3+0x38>
8000030c:	01000693          	li	a3,16
80000310:	f31ff06f          	j	80000240 <__udivdi3+0x38>
	  count_leading_zeros (bm, d0);
80000314:	00000693          	li	a3,0
	  if (d0 == 0)
80000318:	00060c63          	beqz	a2,80000330 <__udivdi3+0x128>
	  count_leading_zeros (bm, d0);
8000031c:	000107b7          	lui	a5,0x10
80000320:	0cf67063          	bgeu	a2,a5,800003e0 <__udivdi3+0x1d8>
80000324:	10063693          	sltiu	a3,a2,256
80000328:	0016b693          	seqz	a3,a3
8000032c:	00369693          	sll	a3,a3,0x3
80000330:	00d657b3          	srl	a5,a2,a3
80000334:	00f585b3          	add	a1,a1,a5
80000338:	0005c783          	lbu	a5,0(a1)
8000033c:	00d787b3          	add	a5,a5,a3
80000340:	02000693          	li	a3,32
80000344:	40f685b3          	sub	a1,a3,a5
	  if (bm == 0)
80000348:	0af69663          	bne	a3,a5,800003f4 <__udivdi3+0x1ec>
	      n1 -= d0;
8000034c:	40c307b3          	sub	a5,t1,a2
	      q1 = 1;
80000350:	00100593          	li	a1,1
	  udiv_qrnnd (q0, n0, n1, n0, d0);
80000354:	01075893          	srl	a7,a4,0x10
80000358:	0317de33          	divu	t3,a5,a7
8000035c:	01071613          	sll	a2,a4,0x10
80000360:	01065613          	srl	a2,a2,0x10
80000364:	01085693          	srl	a3,a6,0x10
80000368:	0317f7b3          	remu	a5,a5,a7
8000036c:	000e0513          	mv	a0,t3
80000370:	03c60333          	mul	t1,a2,t3
80000374:	01079793          	sll	a5,a5,0x10
80000378:	00f6e7b3          	or	a5,a3,a5
8000037c:	0067fe63          	bgeu	a5,t1,80000398 <__udivdi3+0x190>
80000380:	00f707b3          	add	a5,a4,a5
80000384:	fffe0513          	add	a0,t3,-1
80000388:	00e7e863          	bltu	a5,a4,80000398 <__udivdi3+0x190>
8000038c:	0067f663          	bgeu	a5,t1,80000398 <__udivdi3+0x190>
80000390:	ffee0513          	add	a0,t3,-2
80000394:	00e787b3          	add	a5,a5,a4
80000398:	406787b3          	sub	a5,a5,t1
8000039c:	0317d333          	divu	t1,a5,a7
800003a0:	01081813          	sll	a6,a6,0x10
800003a4:	01085813          	srl	a6,a6,0x10
800003a8:	0317f7b3          	remu	a5,a5,a7
800003ac:	026606b3          	mul	a3,a2,t1
800003b0:	01079793          	sll	a5,a5,0x10
800003b4:	00f86833          	or	a6,a6,a5
800003b8:	00030793          	mv	a5,t1
800003bc:	00d87c63          	bgeu	a6,a3,800003d4 <__udivdi3+0x1cc>
800003c0:	01070833          	add	a6,a4,a6
800003c4:	fff30793          	add	a5,t1,-1
800003c8:	00e86663          	bltu	a6,a4,800003d4 <__udivdi3+0x1cc>
800003cc:	00d87463          	bgeu	a6,a3,800003d4 <__udivdi3+0x1cc>
800003d0:	ffe30793          	add	a5,t1,-2
800003d4:	01051513          	sll	a0,a0,0x10
800003d8:	00f56533          	or	a0,a0,a5
800003dc:	00008067          	ret
	  count_leading_zeros (bm, d0);
800003e0:	010007b7          	lui	a5,0x1000
800003e4:	01800693          	li	a3,24
800003e8:	f4f674e3          	bgeu	a2,a5,80000330 <__udivdi3+0x128>
800003ec:	01000693          	li	a3,16
800003f0:	f41ff06f          	j	80000330 <__udivdi3+0x128>
	      d0 = d0 << bm;
800003f4:	00b61733          	sll	a4,a2,a1
	      n2 = n1 >> b;
800003f8:	00f356b3          	srl	a3,t1,a5
	      udiv_qrnnd (q1, n1, n2, n1, d0);
800003fc:	01075513          	srl	a0,a4,0x10
	      n1 = (n1 << bm) | (n0 >> b);
80000400:	00b31333          	sll	t1,t1,a1
80000404:	00f8d7b3          	srl	a5,a7,a5
80000408:	0067e7b3          	or	a5,a5,t1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
8000040c:	02a6d333          	divu	t1,a3,a0
80000410:	01071613          	sll	a2,a4,0x10
80000414:	01065613          	srl	a2,a2,0x10
	      n0 = n0 << bm;
80000418:	00b89833          	sll	a6,a7,a1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
8000041c:	02a6f6b3          	remu	a3,a3,a0
80000420:	026608b3          	mul	a7,a2,t1
80000424:	01069593          	sll	a1,a3,0x10
80000428:	0107d693          	srl	a3,a5,0x10
8000042c:	00b6e6b3          	or	a3,a3,a1
80000430:	00030593          	mv	a1,t1
80000434:	0116fe63          	bgeu	a3,a7,80000450 <__udivdi3+0x248>
80000438:	00d706b3          	add	a3,a4,a3
8000043c:	fff30593          	add	a1,t1,-1
80000440:	00e6e863          	bltu	a3,a4,80000450 <__udivdi3+0x248>
80000444:	0116f663          	bgeu	a3,a7,80000450 <__udivdi3+0x248>
80000448:	ffe30593          	add	a1,t1,-2
8000044c:	00e686b3          	add	a3,a3,a4
80000450:	411686b3          	sub	a3,a3,a7
80000454:	02a6d8b3          	divu	a7,a3,a0
80000458:	01079793          	sll	a5,a5,0x10
8000045c:	0107d793          	srl	a5,a5,0x10
80000460:	02a6f6b3          	remu	a3,a3,a0
80000464:	03160633          	mul	a2,a2,a7
80000468:	01069693          	sll	a3,a3,0x10
8000046c:	00d7e7b3          	or	a5,a5,a3
80000470:	00088693          	mv	a3,a7
80000474:	00c7fe63          	bgeu	a5,a2,80000490 <__udivdi3+0x288>
80000478:	00f707b3          	add	a5,a4,a5
8000047c:	fff88693          	add	a3,a7,-1
80000480:	00e7e863          	bltu	a5,a4,80000490 <__udivdi3+0x288>
80000484:	00c7f663          	bgeu	a5,a2,80000490 <__udivdi3+0x288>
80000488:	ffe88693          	add	a3,a7,-2
8000048c:	00e787b3          	add	a5,a5,a4
80000490:	01059593          	sll	a1,a1,0x10
80000494:	40c787b3          	sub	a5,a5,a2
80000498:	00d5e5b3          	or	a1,a1,a3
8000049c:	eb9ff06f          	j	80000354 <__udivdi3+0x14c>
      if (d1 > n1)
800004a0:	18d5e663          	bltu	a1,a3,8000062c <__udivdi3+0x424>
	  count_leading_zeros (bm, d1);
800004a4:	000107b7          	lui	a5,0x10
800004a8:	04f6f463          	bgeu	a3,a5,800004f0 <__udivdi3+0x2e8>
800004ac:	1006b713          	sltiu	a4,a3,256
800004b0:	00173713          	seqz	a4,a4
800004b4:	00371713          	sll	a4,a4,0x3
800004b8:	a00007b7          	lui	a5,0xa0000
800004bc:	00e6d5b3          	srl	a1,a3,a4
800004c0:	03c78793          	add	a5,a5,60 # a000003c <__clz_tab>
800004c4:	00b787b3          	add	a5,a5,a1
800004c8:	0007c783          	lbu	a5,0(a5)
800004cc:	00e787b3          	add	a5,a5,a4
800004d0:	02000713          	li	a4,32
800004d4:	40f705b3          	sub	a1,a4,a5
	  if (bm == 0)
800004d8:	02f71663          	bne	a4,a5,80000504 <__udivdi3+0x2fc>
		  q0 = 1;
800004dc:	00100513          	li	a0,1
	      if (n1 > d1 || n0 >= d0)
800004e0:	e066eee3          	bltu	a3,t1,800002fc <__udivdi3+0xf4>
800004e4:	00c8b533          	sltu	a0,a7,a2
800004e8:	00153513          	seqz	a0,a0
800004ec:	00008067          	ret
	  count_leading_zeros (bm, d1);
800004f0:	010007b7          	lui	a5,0x1000
800004f4:	01800713          	li	a4,24
800004f8:	fcf6f0e3          	bgeu	a3,a5,800004b8 <__udivdi3+0x2b0>
800004fc:	01000713          	li	a4,16
80000500:	fb9ff06f          	j	800004b8 <__udivdi3+0x2b0>
	      d1 = (d1 << bm) | (d0 >> b);
80000504:	00f65733          	srl	a4,a2,a5
80000508:	00b696b3          	sll	a3,a3,a1
8000050c:	00d766b3          	or	a3,a4,a3
	      n2 = n1 >> b;
80000510:	00f35733          	srl	a4,t1,a5
	      n1 = (n1 << bm) | (n0 >> b);
80000514:	00b31333          	sll	t1,t1,a1
80000518:	00f8d7b3          	srl	a5,a7,a5
8000051c:	0067e7b3          	or	a5,a5,t1
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000520:	0106d313          	srl	t1,a3,0x10
80000524:	02675eb3          	divu	t4,a4,t1
80000528:	01069813          	sll	a6,a3,0x10
8000052c:	01085813          	srl	a6,a6,0x10
	      d0 = d0 << bm;
80000530:	00b61633          	sll	a2,a2,a1
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000534:	02677733          	remu	a4,a4,t1
80000538:	03d80e33          	mul	t3,a6,t4
8000053c:	01071513          	sll	a0,a4,0x10
80000540:	0107d713          	srl	a4,a5,0x10
80000544:	00a76733          	or	a4,a4,a0
80000548:	000e8513          	mv	a0,t4
8000054c:	01c77e63          	bgeu	a4,t3,80000568 <__udivdi3+0x360>
80000550:	00e68733          	add	a4,a3,a4
80000554:	fffe8513          	add	a0,t4,-1
80000558:	00d76863          	bltu	a4,a3,80000568 <__udivdi3+0x360>
8000055c:	01c77663          	bgeu	a4,t3,80000568 <__udivdi3+0x360>
80000560:	ffee8513          	add	a0,t4,-2
80000564:	00d70733          	add	a4,a4,a3
80000568:	41c70733          	sub	a4,a4,t3
8000056c:	02675e33          	divu	t3,a4,t1
80000570:	01079793          	sll	a5,a5,0x10
80000574:	0107d793          	srl	a5,a5,0x10
80000578:	02677733          	remu	a4,a4,t1
8000057c:	03c80833          	mul	a6,a6,t3
80000580:	01071713          	sll	a4,a4,0x10
80000584:	00e7e7b3          	or	a5,a5,a4
80000588:	000e0713          	mv	a4,t3
8000058c:	0107fe63          	bgeu	a5,a6,800005a8 <__udivdi3+0x3a0>
80000590:	00f687b3          	add	a5,a3,a5
80000594:	fffe0713          	add	a4,t3,-1
80000598:	00d7e863          	bltu	a5,a3,800005a8 <__udivdi3+0x3a0>
8000059c:	0107f663          	bgeu	a5,a6,800005a8 <__udivdi3+0x3a0>
800005a0:	ffee0713          	add	a4,t3,-2
800005a4:	00d787b3          	add	a5,a5,a3
800005a8:	01051513          	sll	a0,a0,0x10
	      umul_ppmm (m1, m0, q0, d0);
800005ac:	00010e37          	lui	t3,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
800005b0:	00e56533          	or	a0,a0,a4
	      umul_ppmm (m1, m0, q0, d0);
800005b4:	fffe0693          	add	a3,t3,-1 # ffff <__stack_size+0xbfff>
800005b8:	00d57733          	and	a4,a0,a3
	      udiv_qrnnd (q0, n1, n2, n1, d1);
800005bc:	410787b3          	sub	a5,a5,a6
	      umul_ppmm (m1, m0, q0, d0);
800005c0:	00d676b3          	and	a3,a2,a3
800005c4:	01055813          	srl	a6,a0,0x10
800005c8:	01065613          	srl	a2,a2,0x10
800005cc:	02d70333          	mul	t1,a4,a3
800005d0:	02d806b3          	mul	a3,a6,a3
800005d4:	02c70733          	mul	a4,a4,a2
800005d8:	02c80833          	mul	a6,a6,a2
800005dc:	00d70633          	add	a2,a4,a3
800005e0:	01035713          	srl	a4,t1,0x10
800005e4:	00c70733          	add	a4,a4,a2
800005e8:	00d77463          	bgeu	a4,a3,800005f0 <__udivdi3+0x3e8>
800005ec:	01c80833          	add	a6,a6,t3
800005f0:	01075693          	srl	a3,a4,0x10
800005f4:	010686b3          	add	a3,a3,a6
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
800005f8:	02d7e663          	bltu	a5,a3,80000624 <__udivdi3+0x41c>
800005fc:	ced79ee3          	bne	a5,a3,800002f8 <__udivdi3+0xf0>
	      umul_ppmm (m1, m0, q0, d0);
80000600:	000107b7          	lui	a5,0x10
80000604:	fff78793          	add	a5,a5,-1 # ffff <__stack_size+0xbfff>
80000608:	00f77733          	and	a4,a4,a5
8000060c:	01071713          	sll	a4,a4,0x10
80000610:	00f37333          	and	t1,t1,a5
	      n0 = n0 << bm;
80000614:	00b898b3          	sll	a7,a7,a1
	      umul_ppmm (m1, m0, q0, d0);
80000618:	00670733          	add	a4,a4,t1
	      q1 = 0;
8000061c:	00000593          	li	a1,0
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
80000620:	cce8fee3          	bgeu	a7,a4,800002fc <__udivdi3+0xf4>
		  q0--;
80000624:	fff50513          	add	a0,a0,-1 # ffffff <__stack_size+0xffbfff>
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
80000628:	cd1ff06f          	j	800002f8 <__udivdi3+0xf0>
	  q1 = 0;
8000062c:	00000593          	li	a1,0
	  q0 = 0;
80000630:	00000513          	li	a0,0
80000634:	00008067          	ret

80000638 <__umoddi3>:
  d0 = dd.s.low;
80000638:	00060813          	mv	a6,a2
  n0 = nn.s.low;
8000063c:	00050793          	mv	a5,a0
  n1 = nn.s.high;
80000640:	00058713          	mv	a4,a1
  if (d1 == 0)
80000644:	20069663          	bnez	a3,80000850 <__umoddi3+0x218>
      if (d0 > n1)
80000648:	a00008b7          	lui	a7,0xa0000
8000064c:	03c88893          	add	a7,a7,60 # a000003c <__clz_tab>
80000650:	0cc5fc63          	bgeu	a1,a2,80000728 <__umoddi3+0xf0>
	  count_leading_zeros (bm, d0);
80000654:	000106b7          	lui	a3,0x10
80000658:	0ad67e63          	bgeu	a2,a3,80000714 <__umoddi3+0xdc>
8000065c:	10063693          	sltiu	a3,a2,256
80000660:	0016b693          	seqz	a3,a3
80000664:	00369693          	sll	a3,a3,0x3
80000668:	00d65333          	srl	t1,a2,a3
8000066c:	006888b3          	add	a7,a7,t1
80000670:	0008c883          	lbu	a7,0(a7)
80000674:	02000313          	li	t1,32
80000678:	00d886b3          	add	a3,a7,a3
8000067c:	40d308b3          	sub	a7,t1,a3
	  if (bm != 0)
80000680:	00d30c63          	beq	t1,a3,80000698 <__umoddi3+0x60>
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
80000684:	01159733          	sll	a4,a1,a7
80000688:	00d556b3          	srl	a3,a0,a3
	      d0 = d0 << bm;
8000068c:	01161833          	sll	a6,a2,a7
	      n1 = (n1 << bm) | (n0 >> (W_TYPE_SIZE - bm));
80000690:	00e6e733          	or	a4,a3,a4
	      n0 = n0 << bm;
80000694:	011517b3          	sll	a5,a0,a7
	  udiv_qrnnd (q0, n0, n1, n0, d0);
80000698:	01085613          	srl	a2,a6,0x10
8000069c:	02c756b3          	divu	a3,a4,a2
800006a0:	01081513          	sll	a0,a6,0x10
800006a4:	01055513          	srl	a0,a0,0x10
800006a8:	02c77733          	remu	a4,a4,a2
800006ac:	02a686b3          	mul	a3,a3,a0
800006b0:	01071593          	sll	a1,a4,0x10
800006b4:	0107d713          	srl	a4,a5,0x10
800006b8:	00b76733          	or	a4,a4,a1
800006bc:	00d77a63          	bgeu	a4,a3,800006d0 <__umoddi3+0x98>
800006c0:	00e80733          	add	a4,a6,a4
800006c4:	01076663          	bltu	a4,a6,800006d0 <__umoddi3+0x98>
800006c8:	00d77463          	bgeu	a4,a3,800006d0 <__umoddi3+0x98>
800006cc:	01070733          	add	a4,a4,a6
800006d0:	40d70733          	sub	a4,a4,a3
800006d4:	02c756b3          	divu	a3,a4,a2
800006d8:	02c77733          	remu	a4,a4,a2
800006dc:	02a686b3          	mul	a3,a3,a0
	  udiv_qrnnd (q0, n0, n1, n0, d0);
800006e0:	01079793          	sll	a5,a5,0x10
800006e4:	01071713          	sll	a4,a4,0x10
800006e8:	0107d793          	srl	a5,a5,0x10
800006ec:	00e7e7b3          	or	a5,a5,a4
800006f0:	00d7fa63          	bgeu	a5,a3,80000704 <__umoddi3+0xcc>
800006f4:	00f807b3          	add	a5,a6,a5
800006f8:	0107e663          	bltu	a5,a6,80000704 <__umoddi3+0xcc>
800006fc:	00d7f463          	bgeu	a5,a3,80000704 <__umoddi3+0xcc>
80000700:	010787b3          	add	a5,a5,a6
80000704:	40d787b3          	sub	a5,a5,a3
	  rr.s.low = n0 >> bm;
80000708:	0117d533          	srl	a0,a5,a7
	  *rp = rr.ll;
8000070c:	00000593          	li	a1,0
80000710:	00008067          	ret
	  count_leading_zeros (bm, d0);
80000714:	01000337          	lui	t1,0x1000
80000718:	01800693          	li	a3,24
8000071c:	f46676e3          	bgeu	a2,t1,80000668 <__umoddi3+0x30>
80000720:	01000693          	li	a3,16
80000724:	f45ff06f          	j	80000668 <__umoddi3+0x30>
	  count_leading_zeros (bm, d0);
80000728:	00000693          	li	a3,0
	  if (d0 == 0)
8000072c:	00060c63          	beqz	a2,80000744 <__umoddi3+0x10c>
	  count_leading_zeros (bm, d0);
80000730:	00010737          	lui	a4,0x10
80000734:	06e67e63          	bgeu	a2,a4,800007b0 <__umoddi3+0x178>
80000738:	10063693          	sltiu	a3,a2,256
8000073c:	0016b693          	seqz	a3,a3
80000740:	00369693          	sll	a3,a3,0x3
80000744:	00d65733          	srl	a4,a2,a3
80000748:	00e888b3          	add	a7,a7,a4
8000074c:	0008c703          	lbu	a4,0(a7)
80000750:	00d70733          	add	a4,a4,a3
80000754:	02000693          	li	a3,32
80000758:	40e688b3          	sub	a7,a3,a4
	  if (bm == 0)
8000075c:	06e69463          	bne	a3,a4,800007c4 <__umoddi3+0x18c>
	      n1 -= d0;
80000760:	40c58733          	sub	a4,a1,a2
	  udiv_qrnnd (q0, n0, n1, n0, d0);
80000764:	01085593          	srl	a1,a6,0x10
80000768:	02b75633          	divu	a2,a4,a1
8000076c:	01081513          	sll	a0,a6,0x10
80000770:	01055513          	srl	a0,a0,0x10
80000774:	0107d693          	srl	a3,a5,0x10
80000778:	02b77733          	remu	a4,a4,a1
8000077c:	02a60633          	mul	a2,a2,a0
80000780:	01071713          	sll	a4,a4,0x10
80000784:	00e6e733          	or	a4,a3,a4
80000788:	00c77a63          	bgeu	a4,a2,8000079c <__umoddi3+0x164>
8000078c:	00e80733          	add	a4,a6,a4
80000790:	01076663          	bltu	a4,a6,8000079c <__umoddi3+0x164>
80000794:	00c77463          	bgeu	a4,a2,8000079c <__umoddi3+0x164>
80000798:	01070733          	add	a4,a4,a6
8000079c:	40c70733          	sub	a4,a4,a2
800007a0:	02b756b3          	divu	a3,a4,a1
800007a4:	02b77733          	remu	a4,a4,a1
800007a8:	02a686b3          	mul	a3,a3,a0
800007ac:	f35ff06f          	j	800006e0 <__umoddi3+0xa8>
	  count_leading_zeros (bm, d0);
800007b0:	01000737          	lui	a4,0x1000
800007b4:	01800693          	li	a3,24
800007b8:	f8e676e3          	bgeu	a2,a4,80000744 <__umoddi3+0x10c>
800007bc:	01000693          	li	a3,16
800007c0:	f85ff06f          	j	80000744 <__umoddi3+0x10c>
	      d0 = d0 << bm;
800007c4:	01161833          	sll	a6,a2,a7
	      n2 = n1 >> b;
800007c8:	00e5d6b3          	srl	a3,a1,a4
	      n0 = n0 << bm;
800007cc:	011517b3          	sll	a5,a0,a7
	      n1 = (n1 << bm) | (n0 >> b);
800007d0:	011595b3          	sll	a1,a1,a7
800007d4:	00e55733          	srl	a4,a0,a4
	      udiv_qrnnd (q1, n1, n2, n1, d0);
800007d8:	01085513          	srl	a0,a6,0x10
	      n1 = (n1 << bm) | (n0 >> b);
800007dc:	00b76733          	or	a4,a4,a1
	      udiv_qrnnd (q1, n1, n2, n1, d0);
800007e0:	02a6d5b3          	divu	a1,a3,a0
800007e4:	01081313          	sll	t1,a6,0x10
800007e8:	01035313          	srl	t1,t1,0x10
800007ec:	02a6f6b3          	remu	a3,a3,a0
800007f0:	026585b3          	mul	a1,a1,t1
800007f4:	01069613          	sll	a2,a3,0x10
800007f8:	01075693          	srl	a3,a4,0x10
800007fc:	00c6e6b3          	or	a3,a3,a2
80000800:	00b6fa63          	bgeu	a3,a1,80000814 <__umoddi3+0x1dc>
80000804:	00d806b3          	add	a3,a6,a3
80000808:	0106e663          	bltu	a3,a6,80000814 <__umoddi3+0x1dc>
8000080c:	00b6f463          	bgeu	a3,a1,80000814 <__umoddi3+0x1dc>
80000810:	010686b3          	add	a3,a3,a6
80000814:	40b686b3          	sub	a3,a3,a1
80000818:	02a6d633          	divu	a2,a3,a0
8000081c:	01071713          	sll	a4,a4,0x10
80000820:	01075713          	srl	a4,a4,0x10
80000824:	02a6f6b3          	remu	a3,a3,a0
80000828:	02660633          	mul	a2,a2,t1
8000082c:	01069693          	sll	a3,a3,0x10
80000830:	00d76733          	or	a4,a4,a3
80000834:	00c77a63          	bgeu	a4,a2,80000848 <__umoddi3+0x210>
80000838:	00e80733          	add	a4,a6,a4
8000083c:	01076663          	bltu	a4,a6,80000848 <__umoddi3+0x210>
80000840:	00c77463          	bgeu	a4,a2,80000848 <__umoddi3+0x210>
80000844:	01070733          	add	a4,a4,a6
80000848:	40c70733          	sub	a4,a4,a2
8000084c:	f19ff06f          	j	80000764 <__umoddi3+0x12c>
      if (d1 > n1)
80000850:	1cd5e463          	bltu	a1,a3,80000a18 <__umoddi3+0x3e0>
	  count_leading_zeros (bm, d1);
80000854:	00010837          	lui	a6,0x10
80000858:	0506fe63          	bgeu	a3,a6,800008b4 <__umoddi3+0x27c>
8000085c:	1006b813          	sltiu	a6,a3,256
80000860:	00183813          	seqz	a6,a6
80000864:	00381813          	sll	a6,a6,0x3
80000868:	a00008b7          	lui	a7,0xa0000
8000086c:	0106d333          	srl	t1,a3,a6
80000870:	03c88893          	add	a7,a7,60 # a000003c <__clz_tab>
80000874:	006888b3          	add	a7,a7,t1
80000878:	0008c883          	lbu	a7,0(a7)
8000087c:	02000313          	li	t1,32
80000880:	010888b3          	add	a7,a7,a6
80000884:	41130833          	sub	a6,t1,a7
	  if (bm == 0)
80000888:	05131063          	bne	t1,a7,800008c8 <__umoddi3+0x290>
	      if (n1 > d1 || n0 >= d0)
8000088c:	00b6e463          	bltu	a3,a1,80000894 <__umoddi3+0x25c>
80000890:	00c56c63          	bltu	a0,a2,800008a8 <__umoddi3+0x270>
		  sub_ddmmss (n1, n0, n1, n0, d1, d0);
80000894:	40c50633          	sub	a2,a0,a2
80000898:	40d586b3          	sub	a3,a1,a3
8000089c:	00c53733          	sltu	a4,a0,a2
800008a0:	00060793          	mv	a5,a2
800008a4:	40e68733          	sub	a4,a3,a4
		  *rp = rr.ll;
800008a8:	00078513          	mv	a0,a5
800008ac:	00070593          	mv	a1,a4
800008b0:	00008067          	ret
	  count_leading_zeros (bm, d1);
800008b4:	010008b7          	lui	a7,0x1000
800008b8:	01800813          	li	a6,24
800008bc:	fb16f6e3          	bgeu	a3,a7,80000868 <__umoddi3+0x230>
800008c0:	01000813          	li	a6,16
800008c4:	fa5ff06f          	j	80000868 <__umoddi3+0x230>
	      d1 = (d1 << bm) | (d0 >> b);
800008c8:	011657b3          	srl	a5,a2,a7
800008cc:	010696b3          	sll	a3,a3,a6
800008d0:	00d7e6b3          	or	a3,a5,a3
	      n2 = n1 >> b;
800008d4:	0115d733          	srl	a4,a1,a7
	      udiv_qrnnd (q0, n1, n2, n1, d1);
800008d8:	0106de13          	srl	t3,a3,0x10
800008dc:	03c75f33          	divu	t5,a4,t3
800008e0:	01069313          	sll	t1,a3,0x10
800008e4:	01035313          	srl	t1,t1,0x10
	      n1 = (n1 << bm) | (n0 >> b);
800008e8:	010597b3          	sll	a5,a1,a6
800008ec:	011555b3          	srl	a1,a0,a7
800008f0:	00f5e5b3          	or	a1,a1,a5
	      udiv_qrnnd (q0, n1, n2, n1, d1);
800008f4:	0105d793          	srl	a5,a1,0x10
	      d0 = d0 << bm;
800008f8:	01061633          	sll	a2,a2,a6
	      n0 = n0 << bm;
800008fc:	01051533          	sll	a0,a0,a6
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000900:	03c77733          	remu	a4,a4,t3
80000904:	03e30eb3          	mul	t4,t1,t5
80000908:	01071713          	sll	a4,a4,0x10
8000090c:	00e7e7b3          	or	a5,a5,a4
80000910:	000f0713          	mv	a4,t5
80000914:	01d7fe63          	bgeu	a5,t4,80000930 <__umoddi3+0x2f8>
80000918:	00f687b3          	add	a5,a3,a5
8000091c:	ffff0713          	add	a4,t5,-1
80000920:	00d7e863          	bltu	a5,a3,80000930 <__umoddi3+0x2f8>
80000924:	01d7f663          	bgeu	a5,t4,80000930 <__umoddi3+0x2f8>
80000928:	ffef0713          	add	a4,t5,-2
8000092c:	00d787b3          	add	a5,a5,a3
80000930:	41d787b3          	sub	a5,a5,t4
80000934:	03c7deb3          	divu	t4,a5,t3
80000938:	01059593          	sll	a1,a1,0x10
8000093c:	0105d593          	srl	a1,a1,0x10
80000940:	03c7f7b3          	remu	a5,a5,t3
80000944:	000e8e13          	mv	t3,t4
80000948:	03d30333          	mul	t1,t1,t4
8000094c:	01079793          	sll	a5,a5,0x10
80000950:	00f5e5b3          	or	a1,a1,a5
80000954:	0065fe63          	bgeu	a1,t1,80000970 <__umoddi3+0x338>
80000958:	00b685b3          	add	a1,a3,a1
8000095c:	fffe8e13          	add	t3,t4,-1
80000960:	00d5e863          	bltu	a1,a3,80000970 <__umoddi3+0x338>
80000964:	0065f663          	bgeu	a1,t1,80000970 <__umoddi3+0x338>
80000968:	ffee8e13          	add	t3,t4,-2
8000096c:	00d585b3          	add	a1,a1,a3
80000970:	01071793          	sll	a5,a4,0x10
	      umul_ppmm (m1, m0, q0, d0);
80000974:	00010f37          	lui	t5,0x10
	      udiv_qrnnd (q0, n1, n2, n1, d1);
80000978:	01c7e7b3          	or	a5,a5,t3
8000097c:	406585b3          	sub	a1,a1,t1
	      umul_ppmm (m1, m0, q0, d0);
80000980:	ffff0313          	add	t1,t5,-1 # ffff <__stack_size+0xbfff>
80000984:	0067f733          	and	a4,a5,t1
80000988:	01065e13          	srl	t3,a2,0x10
8000098c:	0107d793          	srl	a5,a5,0x10
80000990:	00667333          	and	t1,a2,t1
80000994:	02670eb3          	mul	t4,a4,t1
80000998:	02678333          	mul	t1,a5,t1
8000099c:	03c70733          	mul	a4,a4,t3
800009a0:	03c787b3          	mul	a5,a5,t3
800009a4:	00670e33          	add	t3,a4,t1
800009a8:	010ed713          	srl	a4,t4,0x10
800009ac:	01c70733          	add	a4,a4,t3
800009b0:	00677463          	bgeu	a4,t1,800009b8 <__umoddi3+0x380>
800009b4:	01e787b3          	add	a5,a5,t5
800009b8:	01075313          	srl	t1,a4,0x10
800009bc:	00f307b3          	add	a5,t1,a5
800009c0:	00010337          	lui	t1,0x10
800009c4:	fff30313          	add	t1,t1,-1 # ffff <__stack_size+0xbfff>
800009c8:	00677733          	and	a4,a4,t1
800009cc:	01071713          	sll	a4,a4,0x10
800009d0:	006efeb3          	and	t4,t4,t1
800009d4:	01d70733          	add	a4,a4,t4
	      if (m1 > n1 || (m1 == n1 && m0 > n0))
800009d8:	00f5e663          	bltu	a1,a5,800009e4 <__umoddi3+0x3ac>
800009dc:	00f59e63          	bne	a1,a5,800009f8 <__umoddi3+0x3c0>
800009e0:	00e57c63          	bgeu	a0,a4,800009f8 <__umoddi3+0x3c0>
		  sub_ddmmss (m1, m0, m1, m0, d1, d0);
800009e4:	40c70633          	sub	a2,a4,a2
800009e8:	00c73333          	sltu	t1,a4,a2
800009ec:	00d306b3          	add	a3,t1,a3
800009f0:	00060713          	mv	a4,a2
800009f4:	40d787b3          	sub	a5,a5,a3
		  sub_ddmmss (n1, n0, n1, n0, m1, m0);
800009f8:	40e50733          	sub	a4,a0,a4
800009fc:	00e53533          	sltu	a0,a0,a4
80000a00:	40f585b3          	sub	a1,a1,a5
80000a04:	40a585b3          	sub	a1,a1,a0
		  rr.s.low = (n1 << b) | (n0 >> bm);
80000a08:	011598b3          	sll	a7,a1,a7
80000a0c:	01075733          	srl	a4,a4,a6
		  *rp = rr.ll;
80000a10:	00e8e533          	or	a0,a7,a4
80000a14:	0105d5b3          	srl	a1,a1,a6
}
80000a18:	00008067          	ret

80000a1c <__adddf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
80000a1c:	00100837          	lui	a6,0x100
80000a20:	fff80813          	add	a6,a6,-1 # fffff <__stack_size+0xfbfff>
{
80000a24:	fe010113          	add	sp,sp,-32
  FP_UNPACK_SEMIRAW_D (A, a);
80000a28:	00b878b3          	and	a7,a6,a1
80000a2c:	0145d713          	srl	a4,a1,0x14
80000a30:	01d55793          	srl	a5,a0,0x1d
  FP_UNPACK_SEMIRAW_D (B, b);
80000a34:	00d87833          	and	a6,a6,a3
{
80000a38:	00912a23          	sw	s1,20(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
80000a3c:	7ff77493          	and	s1,a4,2047
80000a40:	00389713          	sll	a4,a7,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
80000a44:	0146d893          	srl	a7,a3,0x14
80000a48:	00381813          	sll	a6,a6,0x3
{
80000a4c:	01212823          	sw	s2,16(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
80000a50:	00e7e7b3          	or	a5,a5,a4
  FP_UNPACK_SEMIRAW_D (B, b);
80000a54:	7ff8f893          	and	a7,a7,2047
80000a58:	01d65713          	srl	a4,a2,0x1d
{
80000a5c:	00112e23          	sw	ra,28(sp)
80000a60:	00812c23          	sw	s0,24(sp)
80000a64:	01312623          	sw	s3,12(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
80000a68:	01f5d913          	srl	s2,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
80000a6c:	01f6d693          	srl	a3,a3,0x1f
80000a70:	01076733          	or	a4,a4,a6
  FP_UNPACK_SEMIRAW_D (A, a);
80000a74:	00351513          	sll	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
80000a78:	00361613          	sll	a2,a2,0x3
  FP_ADD_D (R, A, B);
80000a7c:	41148833          	sub	a6,s1,a7
80000a80:	2ad91a63          	bne	s2,a3,80000d34 <__adddf3+0x318>
80000a84:	11005c63          	blez	a6,80000b9c <__adddf3+0x180>
80000a88:	04089063          	bnez	a7,80000ac8 <__adddf3+0xac>
80000a8c:	00c766b3          	or	a3,a4,a2
80000a90:	66068063          	beqz	a3,800010f0 <__adddf3+0x6d4>
80000a94:	fff80593          	add	a1,a6,-1
80000a98:	02059063          	bnez	a1,80000ab8 <__adddf3+0x9c>
80000a9c:	00c50633          	add	a2,a0,a2
80000aa0:	00a636b3          	sltu	a3,a2,a0
80000aa4:	00e78733          	add	a4,a5,a4
80000aa8:	00060513          	mv	a0,a2
80000aac:	00d707b3          	add	a5,a4,a3
80000ab0:	00100493          	li	s1,1
80000ab4:	06c0006f          	j	80000b20 <__adddf3+0x104>
80000ab8:	7ff00693          	li	a3,2047
80000abc:	02d81063          	bne	a6,a3,80000adc <__adddf3+0xc0>
80000ac0:	7ff00493          	li	s1,2047
80000ac4:	1f80006f          	j	80000cbc <__adddf3+0x2a0>
80000ac8:	7ff00693          	li	a3,2047
80000acc:	1ed48863          	beq	s1,a3,80000cbc <__adddf3+0x2a0>
80000ad0:	008006b7          	lui	a3,0x800
80000ad4:	00d76733          	or	a4,a4,a3
80000ad8:	00080593          	mv	a1,a6
80000adc:	03800693          	li	a3,56
80000ae0:	0ab6c863          	blt	a3,a1,80000b90 <__adddf3+0x174>
80000ae4:	01f00693          	li	a3,31
80000ae8:	06b6ca63          	blt	a3,a1,80000b5c <__adddf3+0x140>
80000aec:	02000813          	li	a6,32
80000af0:	40b80833          	sub	a6,a6,a1
80000af4:	010716b3          	sll	a3,a4,a6
80000af8:	00b658b3          	srl	a7,a2,a1
80000afc:	01061833          	sll	a6,a2,a6
80000b00:	0116e6b3          	or	a3,a3,a7
80000b04:	01003833          	snez	a6,a6
80000b08:	0106e6b3          	or	a3,a3,a6
80000b0c:	00b755b3          	srl	a1,a4,a1
80000b10:	00a68533          	add	a0,a3,a0
80000b14:	00f585b3          	add	a1,a1,a5
80000b18:	00d536b3          	sltu	a3,a0,a3
80000b1c:	00d587b3          	add	a5,a1,a3
80000b20:	00879713          	sll	a4,a5,0x8
80000b24:	18075c63          	bgez	a4,80000cbc <__adddf3+0x2a0>
80000b28:	00148493          	add	s1,s1,1
80000b2c:	7ff00713          	li	a4,2047
80000b30:	5ae48a63          	beq	s1,a4,800010e4 <__adddf3+0x6c8>
80000b34:	ff800737          	lui	a4,0xff800
80000b38:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80000b3c:	00e7f733          	and	a4,a5,a4
80000b40:	00155793          	srl	a5,a0,0x1
80000b44:	00157513          	and	a0,a0,1
80000b48:	00a7e7b3          	or	a5,a5,a0
80000b4c:	01f71513          	sll	a0,a4,0x1f
80000b50:	00f56533          	or	a0,a0,a5
80000b54:	00175793          	srl	a5,a4,0x1
80000b58:	1640006f          	j	80000cbc <__adddf3+0x2a0>
80000b5c:	fe058693          	add	a3,a1,-32
80000b60:	02000893          	li	a7,32
80000b64:	00d756b3          	srl	a3,a4,a3
80000b68:	00000813          	li	a6,0
80000b6c:	01158863          	beq	a1,a7,80000b7c <__adddf3+0x160>
80000b70:	04000813          	li	a6,64
80000b74:	40b80833          	sub	a6,a6,a1
80000b78:	01071833          	sll	a6,a4,a6
80000b7c:	00c86833          	or	a6,a6,a2
80000b80:	01003833          	snez	a6,a6
80000b84:	0106e6b3          	or	a3,a3,a6
80000b88:	00000593          	li	a1,0
80000b8c:	f85ff06f          	j	80000b10 <__adddf3+0xf4>
80000b90:	00c766b3          	or	a3,a4,a2
80000b94:	00d036b3          	snez	a3,a3
80000b98:	ff1ff06f          	j	80000b88 <__adddf3+0x16c>
80000b9c:	0c080a63          	beqz	a6,80000c70 <__adddf3+0x254>
80000ba0:	409886b3          	sub	a3,a7,s1
80000ba4:	02049463          	bnez	s1,80000bcc <__adddf3+0x1b0>
80000ba8:	00a7e5b3          	or	a1,a5,a0
80000bac:	50058e63          	beqz	a1,800010c8 <__adddf3+0x6ac>
80000bb0:	fff68593          	add	a1,a3,-1 # 7fffff <__stack_size+0x7fbfff>
80000bb4:	ee0584e3          	beqz	a1,80000a9c <__adddf3+0x80>
80000bb8:	7ff00813          	li	a6,2047
80000bbc:	03069263          	bne	a3,a6,80000be0 <__adddf3+0x1c4>
80000bc0:	00070793          	mv	a5,a4
80000bc4:	00060513          	mv	a0,a2
80000bc8:	ef9ff06f          	j	80000ac0 <__adddf3+0xa4>
80000bcc:	7ff00593          	li	a1,2047
80000bd0:	feb888e3          	beq	a7,a1,80000bc0 <__adddf3+0x1a4>
80000bd4:	008005b7          	lui	a1,0x800
80000bd8:	00b7e7b3          	or	a5,a5,a1
80000bdc:	00068593          	mv	a1,a3
80000be0:	03800693          	li	a3,56
80000be4:	08b6c063          	blt	a3,a1,80000c64 <__adddf3+0x248>
80000be8:	01f00693          	li	a3,31
80000bec:	04b6c263          	blt	a3,a1,80000c30 <__adddf3+0x214>
80000bf0:	02000813          	li	a6,32
80000bf4:	40b80833          	sub	a6,a6,a1
80000bf8:	010796b3          	sll	a3,a5,a6
80000bfc:	00b55333          	srl	t1,a0,a1
80000c00:	01051833          	sll	a6,a0,a6
80000c04:	0066e6b3          	or	a3,a3,t1
80000c08:	01003833          	snez	a6,a6
80000c0c:	0106e6b3          	or	a3,a3,a6
80000c10:	00b7d5b3          	srl	a1,a5,a1
80000c14:	00c68633          	add	a2,a3,a2
80000c18:	00e585b3          	add	a1,a1,a4
80000c1c:	00d636b3          	sltu	a3,a2,a3
80000c20:	00060513          	mv	a0,a2
80000c24:	00d587b3          	add	a5,a1,a3
80000c28:	00088493          	mv	s1,a7
80000c2c:	ef5ff06f          	j	80000b20 <__adddf3+0x104>
80000c30:	fe058693          	add	a3,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80000c34:	02000313          	li	t1,32
80000c38:	00d7d6b3          	srl	a3,a5,a3
80000c3c:	00000813          	li	a6,0
80000c40:	00658863          	beq	a1,t1,80000c50 <__adddf3+0x234>
80000c44:	04000813          	li	a6,64
80000c48:	40b80833          	sub	a6,a6,a1
80000c4c:	01079833          	sll	a6,a5,a6
80000c50:	00a86833          	or	a6,a6,a0
80000c54:	01003833          	snez	a6,a6
80000c58:	0106e6b3          	or	a3,a3,a6
80000c5c:	00000593          	li	a1,0
80000c60:	fb5ff06f          	j	80000c14 <__adddf3+0x1f8>
80000c64:	00a7e6b3          	or	a3,a5,a0
80000c68:	00d036b3          	snez	a3,a3
80000c6c:	ff1ff06f          	j	80000c5c <__adddf3+0x240>
80000c70:	00148693          	add	a3,s1,1
80000c74:	7fe6f593          	and	a1,a3,2046
80000c78:	08059663          	bnez	a1,80000d04 <__adddf3+0x2e8>
80000c7c:	00a7e6b3          	or	a3,a5,a0
80000c80:	06049263          	bnez	s1,80000ce4 <__adddf3+0x2c8>
80000c84:	44068863          	beqz	a3,800010d4 <__adddf3+0x6b8>
80000c88:	00c766b3          	or	a3,a4,a2
80000c8c:	02068863          	beqz	a3,80000cbc <__adddf3+0x2a0>
80000c90:	00c50633          	add	a2,a0,a2
80000c94:	00a636b3          	sltu	a3,a2,a0
80000c98:	00e78733          	add	a4,a5,a4
80000c9c:	00d707b3          	add	a5,a4,a3
80000ca0:	00879713          	sll	a4,a5,0x8
80000ca4:	00060513          	mv	a0,a2
80000ca8:	00075a63          	bgez	a4,80000cbc <__adddf3+0x2a0>
80000cac:	ff800737          	lui	a4,0xff800
80000cb0:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80000cb4:	00e7f7b3          	and	a5,a5,a4
80000cb8:	00100493          	li	s1,1
  FP_PACK_SEMIRAW_D (r, R);
80000cbc:	00757713          	and	a4,a0,7
80000cc0:	44070863          	beqz	a4,80001110 <__adddf3+0x6f4>
80000cc4:	00f57713          	and	a4,a0,15
80000cc8:	00400693          	li	a3,4
80000ccc:	44d70263          	beq	a4,a3,80001110 <__adddf3+0x6f4>
80000cd0:	00450713          	add	a4,a0,4
80000cd4:	00a736b3          	sltu	a3,a4,a0
80000cd8:	00d787b3          	add	a5,a5,a3
80000cdc:	00070513          	mv	a0,a4
80000ce0:	4300006f          	j	80001110 <__adddf3+0x6f4>
  FP_ADD_D (R, A, B);
80000ce4:	ec068ee3          	beqz	a3,80000bc0 <__adddf3+0x1a4>
80000ce8:	00c76633          	or	a2,a4,a2
80000cec:	dc060ae3          	beqz	a2,80000ac0 <__adddf3+0xa4>
80000cf0:	00000913          	li	s2,0
80000cf4:	004007b7          	lui	a5,0x400
80000cf8:	00000513          	li	a0,0
80000cfc:	7ff00493          	li	s1,2047
80000d00:	4100006f          	j	80001110 <__adddf3+0x6f4>
80000d04:	7ff00593          	li	a1,2047
80000d08:	3cb68c63          	beq	a3,a1,800010e0 <__adddf3+0x6c4>
80000d0c:	00c50633          	add	a2,a0,a2
80000d10:	00a63533          	sltu	a0,a2,a0
80000d14:	00e78733          	add	a4,a5,a4
80000d18:	00a70733          	add	a4,a4,a0
80000d1c:	01f71513          	sll	a0,a4,0x1f
80000d20:	00165613          	srl	a2,a2,0x1
80000d24:	00c56533          	or	a0,a0,a2
80000d28:	00175793          	srl	a5,a4,0x1
80000d2c:	00068493          	mv	s1,a3
80000d30:	f8dff06f          	j	80000cbc <__adddf3+0x2a0>
80000d34:	0f005c63          	blez	a6,80000e2c <__adddf3+0x410>
80000d38:	08089e63          	bnez	a7,80000dd4 <__adddf3+0x3b8>
80000d3c:	00c766b3          	or	a3,a4,a2
80000d40:	3a068863          	beqz	a3,800010f0 <__adddf3+0x6d4>
80000d44:	fff80693          	add	a3,a6,-1
80000d48:	02069063          	bnez	a3,80000d68 <__adddf3+0x34c>
80000d4c:	40c50633          	sub	a2,a0,a2
80000d50:	00c536b3          	sltu	a3,a0,a2
80000d54:	40e78733          	sub	a4,a5,a4
80000d58:	00060513          	mv	a0,a2
80000d5c:	40d707b3          	sub	a5,a4,a3
80000d60:	00100493          	li	s1,1
80000d64:	0540006f          	j	80000db8 <__adddf3+0x39c>
80000d68:	7ff00593          	li	a1,2047
80000d6c:	d4b80ae3          	beq	a6,a1,80000ac0 <__adddf3+0xa4>
80000d70:	03800593          	li	a1,56
80000d74:	0ad5c663          	blt	a1,a3,80000e20 <__adddf3+0x404>
80000d78:	01f00593          	li	a1,31
80000d7c:	06d5c863          	blt	a1,a3,80000dec <__adddf3+0x3d0>
80000d80:	02000813          	li	a6,32
80000d84:	40d80833          	sub	a6,a6,a3
80000d88:	00d658b3          	srl	a7,a2,a3
80000d8c:	010715b3          	sll	a1,a4,a6
80000d90:	01061833          	sll	a6,a2,a6
80000d94:	0115e5b3          	or	a1,a1,a7
80000d98:	01003833          	snez	a6,a6
80000d9c:	0105e633          	or	a2,a1,a6
80000da0:	00d756b3          	srl	a3,a4,a3
80000da4:	40c50633          	sub	a2,a0,a2
80000da8:	00c53733          	sltu	a4,a0,a2
80000dac:	40d786b3          	sub	a3,a5,a3
80000db0:	00060513          	mv	a0,a2
80000db4:	40e687b3          	sub	a5,a3,a4
80000db8:	00879713          	sll	a4,a5,0x8
80000dbc:	f00750e3          	bgez	a4,80000cbc <__adddf3+0x2a0>
80000dc0:	00800437          	lui	s0,0x800
80000dc4:	fff40413          	add	s0,s0,-1 # 7fffff <__stack_size+0x7fbfff>
80000dc8:	0087f433          	and	s0,a5,s0
80000dcc:	00050993          	mv	s3,a0
80000dd0:	2100006f          	j	80000fe0 <__adddf3+0x5c4>
80000dd4:	7ff00693          	li	a3,2047
80000dd8:	eed482e3          	beq	s1,a3,80000cbc <__adddf3+0x2a0>
80000ddc:	008006b7          	lui	a3,0x800
80000de0:	00d76733          	or	a4,a4,a3
80000de4:	00080693          	mv	a3,a6
80000de8:	f89ff06f          	j	80000d70 <__adddf3+0x354>
80000dec:	fe068593          	add	a1,a3,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80000df0:	02000893          	li	a7,32
80000df4:	00b755b3          	srl	a1,a4,a1
80000df8:	00000813          	li	a6,0
80000dfc:	01168863          	beq	a3,a7,80000e0c <__adddf3+0x3f0>
80000e00:	04000813          	li	a6,64
80000e04:	40d80833          	sub	a6,a6,a3
80000e08:	01071833          	sll	a6,a4,a6
80000e0c:	00c86833          	or	a6,a6,a2
80000e10:	01003833          	snez	a6,a6
80000e14:	0105e633          	or	a2,a1,a6
80000e18:	00000693          	li	a3,0
80000e1c:	f89ff06f          	j	80000da4 <__adddf3+0x388>
80000e20:	00c76633          	or	a2,a4,a2
80000e24:	00c03633          	snez	a2,a2
80000e28:	ff1ff06f          	j	80000e18 <__adddf3+0x3fc>
80000e2c:	0e080863          	beqz	a6,80000f1c <__adddf3+0x500>
80000e30:	40988833          	sub	a6,a7,s1
80000e34:	04049263          	bnez	s1,80000e78 <__adddf3+0x45c>
80000e38:	00a7e5b3          	or	a1,a5,a0
80000e3c:	2a058e63          	beqz	a1,800010f8 <__adddf3+0x6dc>
80000e40:	fff80593          	add	a1,a6,-1
80000e44:	00059e63          	bnez	a1,80000e60 <__adddf3+0x444>
80000e48:	40a60533          	sub	a0,a2,a0
80000e4c:	40f70733          	sub	a4,a4,a5
80000e50:	00a63633          	sltu	a2,a2,a0
80000e54:	40c707b3          	sub	a5,a4,a2
80000e58:	00068913          	mv	s2,a3
80000e5c:	f05ff06f          	j	80000d60 <__adddf3+0x344>
80000e60:	7ff00313          	li	t1,2047
80000e64:	02681463          	bne	a6,t1,80000e8c <__adddf3+0x470>
80000e68:	00070793          	mv	a5,a4
80000e6c:	00060513          	mv	a0,a2
80000e70:	7ff00493          	li	s1,2047
80000e74:	0d00006f          	j	80000f44 <__adddf3+0x528>
80000e78:	7ff00593          	li	a1,2047
80000e7c:	feb886e3          	beq	a7,a1,80000e68 <__adddf3+0x44c>
80000e80:	008005b7          	lui	a1,0x800
80000e84:	00b7e7b3          	or	a5,a5,a1
80000e88:	00080593          	mv	a1,a6
80000e8c:	03800813          	li	a6,56
80000e90:	08b84063          	blt	a6,a1,80000f10 <__adddf3+0x4f4>
80000e94:	01f00813          	li	a6,31
80000e98:	04b84263          	blt	a6,a1,80000edc <__adddf3+0x4c0>
80000e9c:	02000313          	li	t1,32
80000ea0:	40b30333          	sub	t1,t1,a1
80000ea4:	00b55e33          	srl	t3,a0,a1
80000ea8:	00679833          	sll	a6,a5,t1
80000eac:	00651333          	sll	t1,a0,t1
80000eb0:	01c86833          	or	a6,a6,t3
80000eb4:	00603333          	snez	t1,t1
80000eb8:	00686533          	or	a0,a6,t1
80000ebc:	00b7d5b3          	srl	a1,a5,a1
80000ec0:	40a60533          	sub	a0,a2,a0
80000ec4:	40b705b3          	sub	a1,a4,a1
80000ec8:	00a63633          	sltu	a2,a2,a0
80000ecc:	40c587b3          	sub	a5,a1,a2
80000ed0:	00088493          	mv	s1,a7
80000ed4:	00068913          	mv	s2,a3
80000ed8:	ee1ff06f          	j	80000db8 <__adddf3+0x39c>
80000edc:	fe058813          	add	a6,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80000ee0:	02000e13          	li	t3,32
80000ee4:	0107d833          	srl	a6,a5,a6
80000ee8:	00000313          	li	t1,0
80000eec:	01c58863          	beq	a1,t3,80000efc <__adddf3+0x4e0>
80000ef0:	04000313          	li	t1,64
80000ef4:	40b30333          	sub	t1,t1,a1
80000ef8:	00679333          	sll	t1,a5,t1
80000efc:	00a36333          	or	t1,t1,a0
80000f00:	00603333          	snez	t1,t1
80000f04:	00686533          	or	a0,a6,t1
80000f08:	00000593          	li	a1,0
80000f0c:	fb5ff06f          	j	80000ec0 <__adddf3+0x4a4>
80000f10:	00a7e533          	or	a0,a5,a0
80000f14:	00a03533          	snez	a0,a0
80000f18:	ff1ff06f          	j	80000f08 <__adddf3+0x4ec>
80000f1c:	00148593          	add	a1,s1,1
80000f20:	7fe5f593          	and	a1,a1,2046
80000f24:	08059663          	bnez	a1,80000fb0 <__adddf3+0x594>
80000f28:	00a7e833          	or	a6,a5,a0
80000f2c:	00c765b3          	or	a1,a4,a2
80000f30:	06049063          	bnez	s1,80000f90 <__adddf3+0x574>
80000f34:	00081c63          	bnez	a6,80000f4c <__adddf3+0x530>
80000f38:	10058e63          	beqz	a1,80001054 <__adddf3+0x638>
80000f3c:	00070793          	mv	a5,a4
80000f40:	00060513          	mv	a0,a2
80000f44:	00068913          	mv	s2,a3
80000f48:	d75ff06f          	j	80000cbc <__adddf3+0x2a0>
80000f4c:	d60588e3          	beqz	a1,80000cbc <__adddf3+0x2a0>
80000f50:	40c50833          	sub	a6,a0,a2
80000f54:	010538b3          	sltu	a7,a0,a6
80000f58:	40e785b3          	sub	a1,a5,a4
80000f5c:	411585b3          	sub	a1,a1,a7
80000f60:	00859893          	sll	a7,a1,0x8
80000f64:	0008dc63          	bgez	a7,80000f7c <__adddf3+0x560>
80000f68:	40a60533          	sub	a0,a2,a0
80000f6c:	40f70733          	sub	a4,a4,a5
80000f70:	00a63633          	sltu	a2,a2,a0
80000f74:	40c707b3          	sub	a5,a4,a2
80000f78:	fcdff06f          	j	80000f44 <__adddf3+0x528>
80000f7c:	00b86533          	or	a0,a6,a1
80000f80:	18050463          	beqz	a0,80001108 <__adddf3+0x6ec>
80000f84:	00058793          	mv	a5,a1
80000f88:	00080513          	mv	a0,a6
80000f8c:	d31ff06f          	j	80000cbc <__adddf3+0x2a0>
80000f90:	00081c63          	bnez	a6,80000fa8 <__adddf3+0x58c>
80000f94:	d4058ee3          	beqz	a1,80000cf0 <__adddf3+0x2d4>
80000f98:	00070793          	mv	a5,a4
80000f9c:	00060513          	mv	a0,a2
80000fa0:	00068913          	mv	s2,a3
80000fa4:	b1dff06f          	j	80000ac0 <__adddf3+0xa4>
80000fa8:	b0058ce3          	beqz	a1,80000ac0 <__adddf3+0xa4>
80000fac:	d45ff06f          	j	80000cf0 <__adddf3+0x2d4>
80000fb0:	40c505b3          	sub	a1,a0,a2
80000fb4:	00b53833          	sltu	a6,a0,a1
80000fb8:	40e78433          	sub	s0,a5,a4
80000fbc:	41040433          	sub	s0,s0,a6
80000fc0:	00841813          	sll	a6,s0,0x8
80000fc4:	00058993          	mv	s3,a1
80000fc8:	08085063          	bgez	a6,80001048 <__adddf3+0x62c>
80000fcc:	40a609b3          	sub	s3,a2,a0
80000fd0:	40f70433          	sub	s0,a4,a5
80000fd4:	01363633          	sltu	a2,a2,s3
80000fd8:	40c40433          	sub	s0,s0,a2
80000fdc:	00068913          	mv	s2,a3
80000fe0:	06040e63          	beqz	s0,8000105c <__adddf3+0x640>
80000fe4:	00040513          	mv	a0,s0
80000fe8:	59d010ef          	jal	80002d84 <__clzsi2>
80000fec:	ff850693          	add	a3,a0,-8
80000ff0:	02000793          	li	a5,32
80000ff4:	40d787b3          	sub	a5,a5,a3
80000ff8:	00d41433          	sll	s0,s0,a3
80000ffc:	00f9d7b3          	srl	a5,s3,a5
80001000:	0087e7b3          	or	a5,a5,s0
80001004:	00d99433          	sll	s0,s3,a3
80001008:	0a96c463          	blt	a3,s1,800010b0 <__adddf3+0x694>
8000100c:	409686b3          	sub	a3,a3,s1
80001010:	00168613          	add	a2,a3,1
80001014:	01f00713          	li	a4,31
80001018:	06c74263          	blt	a4,a2,8000107c <__adddf3+0x660>
8000101c:	02000713          	li	a4,32
80001020:	40c70733          	sub	a4,a4,a2
80001024:	00e79533          	sll	a0,a5,a4
80001028:	00c456b3          	srl	a3,s0,a2
8000102c:	00e41733          	sll	a4,s0,a4
80001030:	00d56533          	or	a0,a0,a3
80001034:	00e03733          	snez	a4,a4
80001038:	00e56533          	or	a0,a0,a4
8000103c:	00c7d7b3          	srl	a5,a5,a2
80001040:	00000493          	li	s1,0
80001044:	c79ff06f          	j	80000cbc <__adddf3+0x2a0>
80001048:	0085e5b3          	or	a1,a1,s0
8000104c:	f8059ae3          	bnez	a1,80000fe0 <__adddf3+0x5c4>
80001050:	00000493          	li	s1,0
80001054:	00000913          	li	s2,0
80001058:	08c0006f          	j	800010e4 <__adddf3+0x6c8>
8000105c:	00098513          	mv	a0,s3
80001060:	525010ef          	jal	80002d84 <__clzsi2>
80001064:	01850693          	add	a3,a0,24
80001068:	01f00793          	li	a5,31
8000106c:	f8d7d2e3          	bge	a5,a3,80000ff0 <__adddf3+0x5d4>
80001070:	ff850793          	add	a5,a0,-8
80001074:	00f997b3          	sll	a5,s3,a5
80001078:	f91ff06f          	j	80001008 <__adddf3+0x5ec>
8000107c:	fe168693          	add	a3,a3,-31
80001080:	00d7d533          	srl	a0,a5,a3
80001084:	02000693          	li	a3,32
80001088:	00000713          	li	a4,0
8000108c:	00d60863          	beq	a2,a3,8000109c <__adddf3+0x680>
80001090:	04000713          	li	a4,64
80001094:	40c70733          	sub	a4,a4,a2
80001098:	00e79733          	sll	a4,a5,a4
8000109c:	00e46733          	or	a4,s0,a4
800010a0:	00e03733          	snez	a4,a4
800010a4:	00e56533          	or	a0,a0,a4
800010a8:	00000793          	li	a5,0
800010ac:	f95ff06f          	j	80001040 <__adddf3+0x624>
800010b0:	ff800737          	lui	a4,0xff800
800010b4:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
800010b8:	40d484b3          	sub	s1,s1,a3
800010bc:	00e7f7b3          	and	a5,a5,a4
800010c0:	00040513          	mv	a0,s0
800010c4:	bf9ff06f          	j	80000cbc <__adddf3+0x2a0>
800010c8:	00070793          	mv	a5,a4
800010cc:	00060513          	mv	a0,a2
800010d0:	c5dff06f          	j	80000d2c <__adddf3+0x310>
800010d4:	00070793          	mv	a5,a4
800010d8:	00060513          	mv	a0,a2
800010dc:	be1ff06f          	j	80000cbc <__adddf3+0x2a0>
800010e0:	7ff00493          	li	s1,2047
800010e4:	00000793          	li	a5,0
800010e8:	00000513          	li	a0,0
800010ec:	0240006f          	j	80001110 <__adddf3+0x6f4>
800010f0:	00080493          	mv	s1,a6
800010f4:	bc9ff06f          	j	80000cbc <__adddf3+0x2a0>
800010f8:	00070793          	mv	a5,a4
800010fc:	00060513          	mv	a0,a2
80001100:	00080493          	mv	s1,a6
80001104:	e41ff06f          	j	80000f44 <__adddf3+0x528>
80001108:	00000793          	li	a5,0
8000110c:	00000913          	li	s2,0
  FP_PACK_SEMIRAW_D (r, R);
80001110:	00879713          	sll	a4,a5,0x8
80001114:	00075e63          	bgez	a4,80001130 <__adddf3+0x714>
80001118:	00148493          	add	s1,s1,1
8000111c:	7ff00713          	li	a4,2047
80001120:	08e48263          	beq	s1,a4,800011a4 <__adddf3+0x788>
80001124:	ff800737          	lui	a4,0xff800
80001128:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
8000112c:	00e7f7b3          	and	a5,a5,a4
80001130:	01d79693          	sll	a3,a5,0x1d
80001134:	00355513          	srl	a0,a0,0x3
80001138:	7ff00713          	li	a4,2047
8000113c:	00a6e6b3          	or	a3,a3,a0
80001140:	0037d793          	srl	a5,a5,0x3
80001144:	00e49e63          	bne	s1,a4,80001160 <__adddf3+0x744>
80001148:	00f6e6b3          	or	a3,a3,a5
8000114c:	00000793          	li	a5,0
80001150:	00068863          	beqz	a3,80001160 <__adddf3+0x744>
80001154:	000807b7          	lui	a5,0x80
80001158:	00000693          	li	a3,0
8000115c:	00000913          	li	s2,0
80001160:	01449713          	sll	a4,s1,0x14
80001164:	7ff00637          	lui	a2,0x7ff00
80001168:	00c79793          	sll	a5,a5,0xc
8000116c:	00c77733          	and	a4,a4,a2
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80001170:	01c12083          	lw	ra,28(sp)
80001174:	01812403          	lw	s0,24(sp)
  FP_PACK_SEMIRAW_D (r, R);
80001178:	00c7d793          	srl	a5,a5,0xc
8000117c:	00f767b3          	or	a5,a4,a5
80001180:	01f91713          	sll	a4,s2,0x1f
80001184:	00e7e633          	or	a2,a5,a4
}
80001188:	01412483          	lw	s1,20(sp)
8000118c:	01012903          	lw	s2,16(sp)
80001190:	00c12983          	lw	s3,12(sp)
80001194:	00068513          	mv	a0,a3
80001198:	00060593          	mv	a1,a2
8000119c:	02010113          	add	sp,sp,32
800011a0:	00008067          	ret
800011a4:	00000793          	li	a5,0
800011a8:	00000513          	li	a0,0
800011ac:	f85ff06f          	j	80001130 <__adddf3+0x714>

800011b0 <__divdf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__divdf3 (DFtype a, DFtype b)
{
800011b0:	fd010113          	add	sp,sp,-48
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
800011b4:	0145d813          	srl	a6,a1,0x14
{
800011b8:	02912223          	sw	s1,36(sp)
800011bc:	03212023          	sw	s2,32(sp)
800011c0:	01312e23          	sw	s3,28(sp)
800011c4:	01612823          	sw	s6,16(sp)
800011c8:	01712623          	sw	s7,12(sp)
  FP_UNPACK_D (A, a);
800011cc:	00c59493          	sll	s1,a1,0xc
{
800011d0:	02112623          	sw	ra,44(sp)
800011d4:	02812423          	sw	s0,40(sp)
800011d8:	01412c23          	sw	s4,24(sp)
800011dc:	01512a23          	sw	s5,20(sp)
  FP_UNPACK_D (A, a);
800011e0:	7ff87813          	and	a6,a6,2047
{
800011e4:	00050b13          	mv	s6,a0
800011e8:	00060b93          	mv	s7,a2
800011ec:	00068913          	mv	s2,a3
  FP_UNPACK_D (A, a);
800011f0:	00c4d493          	srl	s1,s1,0xc
800011f4:	01f5d993          	srl	s3,a1,0x1f
800011f8:	0a080063          	beqz	a6,80001298 <__divdf3+0xe8>
800011fc:	7ff00793          	li	a5,2047
80001200:	10f80063          	beq	a6,a5,80001300 <__divdf3+0x150>
80001204:	01d55a13          	srl	s4,a0,0x1d
80001208:	00349493          	sll	s1,s1,0x3
8000120c:	009a6a33          	or	s4,s4,s1
80001210:	008007b7          	lui	a5,0x800
80001214:	00fa6a33          	or	s4,s4,a5
80001218:	00351413          	sll	s0,a0,0x3
8000121c:	c0180a93          	add	s5,a6,-1023
80001220:	00000b13          	li	s6,0
  FP_UNPACK_D (B, b);
80001224:	01495713          	srl	a4,s2,0x14
80001228:	00c91493          	sll	s1,s2,0xc
8000122c:	7ff77713          	and	a4,a4,2047
80001230:	00c4d493          	srl	s1,s1,0xc
80001234:	01f95913          	srl	s2,s2,0x1f
80001238:	10070263          	beqz	a4,8000133c <__divdf3+0x18c>
8000123c:	7ff00793          	li	a5,2047
80001240:	16f70663          	beq	a4,a5,800013ac <__divdf3+0x1fc>
80001244:	00349493          	sll	s1,s1,0x3
80001248:	01dbd793          	srl	a5,s7,0x1d
8000124c:	0097e7b3          	or	a5,a5,s1
80001250:	008004b7          	lui	s1,0x800
80001254:	0097e4b3          	or	s1,a5,s1
80001258:	003b9f13          	sll	t5,s7,0x3
8000125c:	c0170713          	add	a4,a4,-1023
80001260:	00000793          	li	a5,0
  FP_DIV_D (R, A, B);
80001264:	40ea8833          	sub	a6,s5,a4
80001268:	002b1713          	sll	a4,s6,0x2
8000126c:	00f76733          	or	a4,a4,a5
80001270:	fff70713          	add	a4,a4,-1
80001274:	00e00693          	li	a3,14
80001278:	0129c633          	xor	a2,s3,s2
8000127c:	16e6e463          	bltu	a3,a4,800013e4 <__divdf3+0x234>
80001280:	a00006b7          	lui	a3,0xa0000
80001284:	00271713          	sll	a4,a4,0x2
80001288:	00068693          	mv	a3,a3
8000128c:	00d70733          	add	a4,a4,a3
80001290:	00072703          	lw	a4,0(a4)
80001294:	00070067          	jr	a4
  FP_UNPACK_D (A, a);
80001298:	00a4ea33          	or	s4,s1,a0
8000129c:	060a0e63          	beqz	s4,80001318 <__divdf3+0x168>
800012a0:	02048e63          	beqz	s1,800012dc <__divdf3+0x12c>
800012a4:	00048513          	mv	a0,s1
800012a8:	2dd010ef          	jal	80002d84 <__clzsi2>
800012ac:	ff550793          	add	a5,a0,-11
800012b0:	01d00a13          	li	s4,29
800012b4:	ff850713          	add	a4,a0,-8
800012b8:	40fa0a33          	sub	s4,s4,a5
800012bc:	00e494b3          	sll	s1,s1,a4
800012c0:	014b5a33          	srl	s4,s6,s4
800012c4:	009a6a33          	or	s4,s4,s1
800012c8:	00eb14b3          	sll	s1,s6,a4
800012cc:	c0d00813          	li	a6,-1011
800012d0:	40a80ab3          	sub	s5,a6,a0
800012d4:	00048413          	mv	s0,s1
800012d8:	f49ff06f          	j	80001220 <__divdf3+0x70>
800012dc:	2a9010ef          	jal	80002d84 <__clzsi2>
800012e0:	00050a13          	mv	s4,a0
800012e4:	015a0793          	add	a5,s4,21
800012e8:	01c00713          	li	a4,28
800012ec:	02050513          	add	a0,a0,32
800012f0:	fcf750e3          	bge	a4,a5,800012b0 <__divdf3+0x100>
800012f4:	ff8a0a13          	add	s4,s4,-8
800012f8:	014b1a33          	sll	s4,s6,s4
800012fc:	fd1ff06f          	j	800012cc <__divdf3+0x11c>
80001300:	00a4ea33          	or	s4,s1,a0
80001304:	020a1263          	bnez	s4,80001328 <__divdf3+0x178>
80001308:	00000413          	li	s0,0
8000130c:	7ff00a93          	li	s5,2047
80001310:	00200b13          	li	s6,2
80001314:	f11ff06f          	j	80001224 <__divdf3+0x74>
80001318:	00000413          	li	s0,0
8000131c:	00000a93          	li	s5,0
80001320:	00100b13          	li	s6,1
80001324:	f01ff06f          	j	80001224 <__divdf3+0x74>
80001328:	00050413          	mv	s0,a0
8000132c:	00048a13          	mv	s4,s1
80001330:	7ff00a93          	li	s5,2047
80001334:	00300b13          	li	s6,3
80001338:	eedff06f          	j	80001224 <__divdf3+0x74>
  FP_UNPACK_D (B, b);
8000133c:	0174ef33          	or	t5,s1,s7
80001340:	080f0263          	beqz	t5,800013c4 <__divdf3+0x214>
80001344:	04048063          	beqz	s1,80001384 <__divdf3+0x1d4>
80001348:	00048513          	mv	a0,s1
8000134c:	239010ef          	jal	80002d84 <__clzsi2>
80001350:	ff550713          	add	a4,a0,-11
80001354:	01d00793          	li	a5,29
80001358:	ff850693          	add	a3,a0,-8
8000135c:	40e787b3          	sub	a5,a5,a4
80001360:	00d494b3          	sll	s1,s1,a3
80001364:	00fbd7b3          	srl	a5,s7,a5
80001368:	0097e7b3          	or	a5,a5,s1
8000136c:	00db94b3          	sll	s1,s7,a3
80001370:	c0d00713          	li	a4,-1011
80001374:	00048f13          	mv	t5,s1
80001378:	40a70733          	sub	a4,a4,a0
8000137c:	00078493          	mv	s1,a5
80001380:	ee1ff06f          	j	80001260 <__divdf3+0xb0>
80001384:	000b8513          	mv	a0,s7
80001388:	1fd010ef          	jal	80002d84 <__clzsi2>
8000138c:	00050793          	mv	a5,a0
80001390:	01578713          	add	a4,a5,21 # 800015 <__stack_size+0x7fc015>
80001394:	01c00693          	li	a3,28
80001398:	02050513          	add	a0,a0,32
8000139c:	fae6dce3          	bge	a3,a4,80001354 <__divdf3+0x1a4>
800013a0:	ff878793          	add	a5,a5,-8
800013a4:	00fb97b3          	sll	a5,s7,a5
800013a8:	fc9ff06f          	j	80001370 <__divdf3+0x1c0>
800013ac:	0174ef33          	or	t5,s1,s7
800013b0:	020f1263          	bnez	t5,800013d4 <__divdf3+0x224>
800013b4:	00000493          	li	s1,0
800013b8:	7ff00713          	li	a4,2047
800013bc:	00200793          	li	a5,2
800013c0:	ea5ff06f          	j	80001264 <__divdf3+0xb4>
800013c4:	00000493          	li	s1,0
800013c8:	00000713          	li	a4,0
800013cc:	00100793          	li	a5,1
800013d0:	e95ff06f          	j	80001264 <__divdf3+0xb4>
800013d4:	000b8f13          	mv	t5,s7
800013d8:	7ff00713          	li	a4,2047
800013dc:	00300793          	li	a5,3
800013e0:	e85ff06f          	j	80001264 <__divdf3+0xb4>
  FP_DIV_D (R, A, B);
800013e4:	0144e663          	bltu	s1,s4,800013f0 <__divdf3+0x240>
800013e8:	349a1c63          	bne	s4,s1,80001740 <__divdf3+0x590>
800013ec:	35e46a63          	bltu	s0,t5,80001740 <__divdf3+0x590>
800013f0:	01fa1693          	sll	a3,s4,0x1f
800013f4:	00145793          	srl	a5,s0,0x1
800013f8:	01f41713          	sll	a4,s0,0x1f
800013fc:	001a5a13          	srl	s4,s4,0x1
80001400:	00f6e433          	or	s0,a3,a5
80001404:	00849893          	sll	a7,s1,0x8
80001408:	018f5593          	srl	a1,t5,0x18
8000140c:	0115e5b3          	or	a1,a1,a7
80001410:	0108d893          	srl	a7,a7,0x10
80001414:	031a5eb3          	divu	t4,s4,a7
80001418:	01059313          	sll	t1,a1,0x10
8000141c:	01035313          	srl	t1,t1,0x10
80001420:	01045793          	srl	a5,s0,0x10
80001424:	008f1513          	sll	a0,t5,0x8
80001428:	031a7a33          	remu	s4,s4,a7
8000142c:	000e8693          	mv	a3,t4
80001430:	03d30e33          	mul	t3,t1,t4
80001434:	010a1a13          	sll	s4,s4,0x10
80001438:	0147e7b3          	or	a5,a5,s4
8000143c:	01c7fe63          	bgeu	a5,t3,80001458 <__divdf3+0x2a8>
80001440:	00f587b3          	add	a5,a1,a5
80001444:	fffe8693          	add	a3,t4,-1
80001448:	00b7e863          	bltu	a5,a1,80001458 <__divdf3+0x2a8>
8000144c:	01c7f663          	bgeu	a5,t3,80001458 <__divdf3+0x2a8>
80001450:	ffee8693          	add	a3,t4,-2
80001454:	00b787b3          	add	a5,a5,a1
80001458:	41c787b3          	sub	a5,a5,t3
8000145c:	0317df33          	divu	t5,a5,a7
80001460:	01041413          	sll	s0,s0,0x10
80001464:	01045413          	srl	s0,s0,0x10
80001468:	0317f7b3          	remu	a5,a5,a7
8000146c:	000f0e13          	mv	t3,t5
80001470:	03e30eb3          	mul	t4,t1,t5
80001474:	01079793          	sll	a5,a5,0x10
80001478:	00f467b3          	or	a5,s0,a5
8000147c:	01d7fe63          	bgeu	a5,t4,80001498 <__divdf3+0x2e8>
80001480:	00f587b3          	add	a5,a1,a5
80001484:	ffff0e13          	add	t3,t5,-1
80001488:	00b7e863          	bltu	a5,a1,80001498 <__divdf3+0x2e8>
8000148c:	01d7f663          	bgeu	a5,t4,80001498 <__divdf3+0x2e8>
80001490:	ffef0e13          	add	t3,t5,-2
80001494:	00b787b3          	add	a5,a5,a1
80001498:	01069693          	sll	a3,a3,0x10
8000149c:	00010437          	lui	s0,0x10
800014a0:	01c6e2b3          	or	t0,a3,t3
800014a4:	fff40e13          	add	t3,s0,-1 # ffff <__stack_size+0xbfff>
800014a8:	01c2f6b3          	and	a3,t0,t3
800014ac:	0102df93          	srl	t6,t0,0x10
800014b0:	01c57e33          	and	t3,a0,t3
800014b4:	41d787b3          	sub	a5,a5,t4
800014b8:	01055e93          	srl	t4,a0,0x10
800014bc:	02de03b3          	mul	t2,t3,a3
800014c0:	03cf84b3          	mul	s1,t6,t3
800014c4:	02de86b3          	mul	a3,t4,a3
800014c8:	00968f33          	add	t5,a3,s1
800014cc:	0103d693          	srl	a3,t2,0x10
800014d0:	01e686b3          	add	a3,a3,t5
800014d4:	03df8fb3          	mul	t6,t6,t4
800014d8:	0096f463          	bgeu	a3,s1,800014e0 <__divdf3+0x330>
800014dc:	008f8fb3          	add	t6,t6,s0
800014e0:	0106df13          	srl	t5,a3,0x10
800014e4:	01ff0f33          	add	t5,t5,t6
800014e8:	00010fb7          	lui	t6,0x10
800014ec:	ffff8f93          	add	t6,t6,-1 # ffff <__stack_size+0xbfff>
800014f0:	01f6f6b3          	and	a3,a3,t6
800014f4:	01069693          	sll	a3,a3,0x10
800014f8:	01f3f3b3          	and	t2,t2,t6
800014fc:	007686b3          	add	a3,a3,t2
80001500:	01e7e863          	bltu	a5,t5,80001510 <__divdf3+0x360>
80001504:	00028493          	mv	s1,t0
80001508:	05e79863          	bne	a5,t5,80001558 <__divdf3+0x3a8>
8000150c:	04d77663          	bgeu	a4,a3,80001558 <__divdf3+0x3a8>
80001510:	00a70fb3          	add	t6,a4,a0
80001514:	00efb3b3          	sltu	t2,t6,a4
80001518:	00b38433          	add	s0,t2,a1
8000151c:	008787b3          	add	a5,a5,s0
80001520:	fff28493          	add	s1,t0,-1
80001524:	000f8713          	mv	a4,t6
80001528:	00f5e663          	bltu	a1,a5,80001534 <__divdf3+0x384>
8000152c:	02f59663          	bne	a1,a5,80001558 <__divdf3+0x3a8>
80001530:	02039463          	bnez	t2,80001558 <__divdf3+0x3a8>
80001534:	01e7e663          	bltu	a5,t5,80001540 <__divdf3+0x390>
80001538:	02ff1063          	bne	t5,a5,80001558 <__divdf3+0x3a8>
8000153c:	00dffe63          	bgeu	t6,a3,80001558 <__divdf3+0x3a8>
80001540:	01f50fb3          	add	t6,a0,t6
80001544:	000f8713          	mv	a4,t6
80001548:	00afbfb3          	sltu	t6,t6,a0
8000154c:	00bf8fb3          	add	t6,t6,a1
80001550:	ffe28493          	add	s1,t0,-2
80001554:	01f787b3          	add	a5,a5,t6
80001558:	40d706b3          	sub	a3,a4,a3
8000155c:	41e787b3          	sub	a5,a5,t5
80001560:	00d73733          	sltu	a4,a4,a3
80001564:	40e787b3          	sub	a5,a5,a4
80001568:	fff00f13          	li	t5,-1
8000156c:	12f58663          	beq	a1,a5,80001698 <__divdf3+0x4e8>
80001570:	0317dfb3          	divu	t6,a5,a7
80001574:	0106d713          	srl	a4,a3,0x10
80001578:	0317f7b3          	remu	a5,a5,a7
8000157c:	03f30f33          	mul	t5,t1,t6
80001580:	01079793          	sll	a5,a5,0x10
80001584:	00f767b3          	or	a5,a4,a5
80001588:	000f8713          	mv	a4,t6
8000158c:	01e7fe63          	bgeu	a5,t5,800015a8 <__divdf3+0x3f8>
80001590:	00f587b3          	add	a5,a1,a5
80001594:	ffff8713          	add	a4,t6,-1
80001598:	00b7e863          	bltu	a5,a1,800015a8 <__divdf3+0x3f8>
8000159c:	01e7f663          	bgeu	a5,t5,800015a8 <__divdf3+0x3f8>
800015a0:	ffef8713          	add	a4,t6,-2
800015a4:	00b787b3          	add	a5,a5,a1
800015a8:	41e787b3          	sub	a5,a5,t5
800015ac:	0317df33          	divu	t5,a5,a7
800015b0:	01069693          	sll	a3,a3,0x10
800015b4:	0106d693          	srl	a3,a3,0x10
800015b8:	0317f7b3          	remu	a5,a5,a7
800015bc:	000f0893          	mv	a7,t5
800015c0:	03e30333          	mul	t1,t1,t5
800015c4:	01079793          	sll	a5,a5,0x10
800015c8:	00f6e7b3          	or	a5,a3,a5
800015cc:	0067fe63          	bgeu	a5,t1,800015e8 <__divdf3+0x438>
800015d0:	00f587b3          	add	a5,a1,a5
800015d4:	ffff0893          	add	a7,t5,-1
800015d8:	00b7e863          	bltu	a5,a1,800015e8 <__divdf3+0x438>
800015dc:	0067f663          	bgeu	a5,t1,800015e8 <__divdf3+0x438>
800015e0:	ffef0893          	add	a7,t5,-2
800015e4:	00b787b3          	add	a5,a5,a1
800015e8:	01071693          	sll	a3,a4,0x10
800015ec:	0116e6b3          	or	a3,a3,a7
800015f0:	01069713          	sll	a4,a3,0x10
800015f4:	01075713          	srl	a4,a4,0x10
800015f8:	406787b3          	sub	a5,a5,t1
800015fc:	0106d313          	srl	t1,a3,0x10
80001600:	03c70f33          	mul	t5,a4,t3
80001604:	03c30e33          	mul	t3,t1,t3
80001608:	026e8333          	mul	t1,t4,t1
8000160c:	02ee8eb3          	mul	t4,t4,a4
80001610:	010f5713          	srl	a4,t5,0x10
80001614:	01ce8eb3          	add	t4,t4,t3
80001618:	01d70733          	add	a4,a4,t4
8000161c:	01c77663          	bgeu	a4,t3,80001628 <__divdf3+0x478>
80001620:	000108b7          	lui	a7,0x10
80001624:	01130333          	add	t1,t1,a7
80001628:	01075893          	srl	a7,a4,0x10
8000162c:	006888b3          	add	a7,a7,t1
80001630:	00010337          	lui	t1,0x10
80001634:	fff30313          	add	t1,t1,-1 # ffff <__stack_size+0xbfff>
80001638:	00677733          	and	a4,a4,t1
8000163c:	01071713          	sll	a4,a4,0x10
80001640:	006f7f33          	and	t5,t5,t1
80001644:	01e70733          	add	a4,a4,t5
80001648:	0117e863          	bltu	a5,a7,80001658 <__divdf3+0x4a8>
8000164c:	23179c63          	bne	a5,a7,80001884 <__divdf3+0x6d4>
80001650:	00068f13          	mv	t5,a3
80001654:	04070263          	beqz	a4,80001698 <__divdf3+0x4e8>
80001658:	00f587b3          	add	a5,a1,a5
8000165c:	fff68f13          	add	t5,a3,-1 # 9fffffff <portable_fini+0x1fff7ce7>
80001660:	00078313          	mv	t1,a5
80001664:	02b7e463          	bltu	a5,a1,8000168c <__divdf3+0x4dc>
80001668:	0117e663          	bltu	a5,a7,80001674 <__divdf3+0x4c4>
8000166c:	21179a63          	bne	a5,a7,80001880 <__divdf3+0x6d0>
80001670:	02e57063          	bgeu	a0,a4,80001690 <__divdf3+0x4e0>
80001674:	ffe68f13          	add	t5,a3,-2
80001678:	00151693          	sll	a3,a0,0x1
8000167c:	00a6b333          	sltu	t1,a3,a0
80001680:	00b30333          	add	t1,t1,a1
80001684:	00678333          	add	t1,a5,t1
80001688:	00068513          	mv	a0,a3
8000168c:	01131463          	bne	t1,a7,80001694 <__divdf3+0x4e4>
80001690:	00a70463          	beq	a4,a0,80001698 <__divdf3+0x4e8>
80001694:	001f6f13          	or	t5,t5,1
  FP_PACK_D (r, R);
80001698:	3ff80713          	add	a4,a6,1023
8000169c:	10e05263          	blez	a4,800017a0 <__divdf3+0x5f0>
800016a0:	007f7793          	and	a5,t5,7
800016a4:	02078063          	beqz	a5,800016c4 <__divdf3+0x514>
800016a8:	00ff7793          	and	a5,t5,15
800016ac:	00400693          	li	a3,4
800016b0:	00d78a63          	beq	a5,a3,800016c4 <__divdf3+0x514>
800016b4:	004f0793          	add	a5,t5,4
800016b8:	01e7b6b3          	sltu	a3,a5,t5
800016bc:	00d484b3          	add	s1,s1,a3
800016c0:	00078f13          	mv	t5,a5
800016c4:	00749793          	sll	a5,s1,0x7
800016c8:	0007da63          	bgez	a5,800016dc <__divdf3+0x52c>
800016cc:	ff0007b7          	lui	a5,0xff000
800016d0:	fff78793          	add	a5,a5,-1 # feffffff <__stack_base+0x5efeffff>
800016d4:	00f4f4b3          	and	s1,s1,a5
800016d8:	40080713          	add	a4,a6,1024
800016dc:	7fe00793          	li	a5,2046
800016e0:	08e7ca63          	blt	a5,a4,80001774 <__divdf3+0x5c4>
800016e4:	003f5f13          	srl	t5,t5,0x3
800016e8:	01d49793          	sll	a5,s1,0x1d
800016ec:	01e7ef33          	or	t5,a5,t5
800016f0:	0034d513          	srl	a0,s1,0x3
800016f4:	00c51513          	sll	a0,a0,0xc
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800016f8:	02c12083          	lw	ra,44(sp)
800016fc:	02812403          	lw	s0,40(sp)
  FP_PACK_D (r, R);
80001700:	00c55513          	srl	a0,a0,0xc
80001704:	01471713          	sll	a4,a4,0x14
80001708:	00a76733          	or	a4,a4,a0
8000170c:	01f61613          	sll	a2,a2,0x1f
80001710:	00c767b3          	or	a5,a4,a2
}
80001714:	02412483          	lw	s1,36(sp)
80001718:	02012903          	lw	s2,32(sp)
8000171c:	01c12983          	lw	s3,28(sp)
80001720:	01812a03          	lw	s4,24(sp)
80001724:	01412a83          	lw	s5,20(sp)
80001728:	01012b03          	lw	s6,16(sp)
8000172c:	00c12b83          	lw	s7,12(sp)
80001730:	000f0513          	mv	a0,t5
80001734:	00078593          	mv	a1,a5
80001738:	03010113          	add	sp,sp,48
8000173c:	00008067          	ret
  FP_DIV_D (R, A, B);
80001740:	fff80813          	add	a6,a6,-1
80001744:	00000713          	li	a4,0
80001748:	cbdff06f          	j	80001404 <__divdf3+0x254>
  FP_UNPACK_D (A, a);
8000174c:	00098613          	mv	a2,s3
  FP_DIV_D (R, A, B);
80001750:	000a0493          	mv	s1,s4
80001754:	00040f13          	mv	t5,s0
80001758:	000b0793          	mv	a5,s6
  FP_PACK_D (r, R);
8000175c:	00300713          	li	a4,3
80001760:	0ee78863          	beq	a5,a4,80001850 <__divdf3+0x6a0>
80001764:	00100713          	li	a4,1
80001768:	0ee78e63          	beq	a5,a4,80001864 <__divdf3+0x6b4>
8000176c:	00200713          	li	a4,2
80001770:	f2e794e3          	bne	a5,a4,80001698 <__divdf3+0x4e8>
80001774:	00000513          	li	a0,0
80001778:	00000f13          	li	t5,0
8000177c:	7ff00713          	li	a4,2047
80001780:	f75ff06f          	j	800016f4 <__divdf3+0x544>
  FP_UNPACK_D (B, b);
80001784:	00090613          	mv	a2,s2
  FP_DIV_D (R, A, B);
80001788:	fd5ff06f          	j	8000175c <__divdf3+0x5ac>
8000178c:	000804b7          	lui	s1,0x80
80001790:	00000f13          	li	t5,0
80001794:	00000613          	li	a2,0
80001798:	00300793          	li	a5,3
8000179c:	fc1ff06f          	j	8000175c <__divdf3+0x5ac>
  FP_PACK_D (r, R);
800017a0:	00100513          	li	a0,1
800017a4:	40e50533          	sub	a0,a0,a4
800017a8:	03800793          	li	a5,56
800017ac:	0aa7cc63          	blt	a5,a0,80001864 <__divdf3+0x6b4>
800017b0:	01f00793          	li	a5,31
800017b4:	06a7c463          	blt	a5,a0,8000181c <__divdf3+0x66c>
800017b8:	41e80813          	add	a6,a6,1054
800017bc:	010497b3          	sll	a5,s1,a6
800017c0:	00af5733          	srl	a4,t5,a0
800017c4:	010f1833          	sll	a6,t5,a6
800017c8:	00e7e7b3          	or	a5,a5,a4
800017cc:	01003833          	snez	a6,a6
800017d0:	0107e7b3          	or	a5,a5,a6
800017d4:	00a4d533          	srl	a0,s1,a0
800017d8:	0077f713          	and	a4,a5,7
800017dc:	02070063          	beqz	a4,800017fc <__divdf3+0x64c>
800017e0:	00f7f713          	and	a4,a5,15
800017e4:	00400693          	li	a3,4
800017e8:	00d70a63          	beq	a4,a3,800017fc <__divdf3+0x64c>
800017ec:	00478713          	add	a4,a5,4
800017f0:	00f736b3          	sltu	a3,a4,a5
800017f4:	00d50533          	add	a0,a0,a3
800017f8:	00070793          	mv	a5,a4
800017fc:	00851713          	sll	a4,a0,0x8
80001800:	06074863          	bltz	a4,80001870 <__divdf3+0x6c0>
80001804:	01d51f13          	sll	t5,a0,0x1d
80001808:	0037d793          	srl	a5,a5,0x3
8000180c:	00ff6f33          	or	t5,t5,a5
80001810:	00355513          	srl	a0,a0,0x3
80001814:	00000713          	li	a4,0
80001818:	eddff06f          	j	800016f4 <__divdf3+0x544>
8000181c:	fe100793          	li	a5,-31
80001820:	40e787b3          	sub	a5,a5,a4
80001824:	02000693          	li	a3,32
80001828:	00f4d7b3          	srl	a5,s1,a5
8000182c:	00000713          	li	a4,0
80001830:	00d50663          	beq	a0,a3,8000183c <__divdf3+0x68c>
80001834:	43e80713          	add	a4,a6,1086
80001838:	00e49733          	sll	a4,s1,a4
8000183c:	01e76733          	or	a4,a4,t5
80001840:	00e03733          	snez	a4,a4
80001844:	00e7e7b3          	or	a5,a5,a4
80001848:	00000513          	li	a0,0
8000184c:	f8dff06f          	j	800017d8 <__divdf3+0x628>
80001850:	00080537          	lui	a0,0x80
80001854:	00000f13          	li	t5,0
80001858:	7ff00713          	li	a4,2047
8000185c:	00000613          	li	a2,0
80001860:	e95ff06f          	j	800016f4 <__divdf3+0x544>
80001864:	00000513          	li	a0,0
80001868:	00000f13          	li	t5,0
8000186c:	fa9ff06f          	j	80001814 <__divdf3+0x664>
80001870:	00000513          	li	a0,0
80001874:	00000f13          	li	t5,0
80001878:	00100713          	li	a4,1
8000187c:	e79ff06f          	j	800016f4 <__divdf3+0x544>
  FP_DIV_D (R, A, B);
80001880:	000f0693          	mv	a3,t5
80001884:	00068f13          	mv	t5,a3
80001888:	e0dff06f          	j	80001694 <__divdf3+0x4e4>

8000188c <__eqdf2>:
  FP_DECL_D (A);
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
8000188c:	0145d713          	srl	a4,a1,0x14
80001890:	001007b7          	lui	a5,0x100
80001894:	fff78793          	add	a5,a5,-1 # fffff <__stack_size+0xfbfff>
  FP_UNPACK_RAW_D (B, b);
80001898:	0146d813          	srl	a6,a3,0x14
{
8000189c:	00050313          	mv	t1,a0
800018a0:	00050e93          	mv	t4,a0
  FP_UNPACK_RAW_D (A, a);
800018a4:	7ff77713          	and	a4,a4,2047
  FP_CMP_EQ_D (r, A, B, 1);
800018a8:	7ff00513          	li	a0,2047
  FP_UNPACK_RAW_D (A, a);
800018ac:	00b7f8b3          	and	a7,a5,a1
800018b0:	00060f13          	mv	t5,a2
  FP_UNPACK_RAW_D (B, b);
800018b4:	00d7f7b3          	and	a5,a5,a3
  FP_UNPACK_RAW_D (A, a);
800018b8:	01f5d593          	srl	a1,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
800018bc:	7ff87813          	and	a6,a6,2047
800018c0:	01f6d693          	srl	a3,a3,0x1f
  FP_CMP_EQ_D (r, A, B, 1);
800018c4:	00a71c63          	bne	a4,a0,800018dc <__eqdf2+0x50>
800018c8:	0068ee33          	or	t3,a7,t1
800018cc:	00100513          	li	a0,1
800018d0:	000e1463          	bnez	t3,800018d8 <__eqdf2+0x4c>
800018d4:	00e80663          	beq	a6,a4,800018e0 <__eqdf2+0x54>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800018d8:	00008067          	ret
  FP_CMP_EQ_D (r, A, B, 1);
800018dc:	00a81863          	bne	a6,a0,800018ec <__eqdf2+0x60>
800018e0:	00c7e633          	or	a2,a5,a2
800018e4:	00100513          	li	a0,1
800018e8:	fe0618e3          	bnez	a2,800018d8 <__eqdf2+0x4c>
800018ec:	00100513          	li	a0,1
800018f0:	ff0714e3          	bne	a4,a6,800018d8 <__eqdf2+0x4c>
800018f4:	fef892e3          	bne	a7,a5,800018d8 <__eqdf2+0x4c>
800018f8:	ffee90e3          	bne	t4,t5,800018d8 <__eqdf2+0x4c>
800018fc:	00d58a63          	beq	a1,a3,80001910 <__eqdf2+0x84>
80001900:	fc071ce3          	bnez	a4,800018d8 <__eqdf2+0x4c>
80001904:	0068e8b3          	or	a7,a7,t1
80001908:	01103533          	snez	a0,a7
8000190c:	00008067          	ret
80001910:	00000513          	li	a0,0
80001914:	00008067          	ret

80001918 <__gedf2>:
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
  FP_UNPACK_RAW_D (B, b);
80001918:	0146d793          	srl	a5,a3,0x14
  FP_UNPACK_RAW_D (A, a);
8000191c:	0145d893          	srl	a7,a1,0x14
80001920:	00100737          	lui	a4,0x100
80001924:	fff70713          	add	a4,a4,-1 # fffff <__stack_size+0xfbfff>
{
80001928:	00050813          	mv	a6,a0
8000192c:	00050e13          	mv	t3,a0
  FP_UNPACK_RAW_D (A, a);
80001930:	7ff8f893          	and	a7,a7,2047
  FP_UNPACK_RAW_D (B, b);
80001934:	7ff7f513          	and	a0,a5,2047
  FP_CMP_D (r, A, B, -2, 2);
80001938:	7ff00793          	li	a5,2047
  FP_UNPACK_RAW_D (A, a);
8000193c:	00b77333          	and	t1,a4,a1
80001940:	00060e93          	mv	t4,a2
  FP_UNPACK_RAW_D (B, b);
80001944:	00d77733          	and	a4,a4,a3
  FP_UNPACK_RAW_D (A, a);
80001948:	01f5d593          	srl	a1,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
8000194c:	01f6d693          	srl	a3,a3,0x1f
  FP_CMP_D (r, A, B, -2, 2);
80001950:	00f89663          	bne	a7,a5,8000195c <__gedf2+0x44>
80001954:	010367b3          	or	a5,t1,a6
80001958:	06079c63          	bnez	a5,800019d0 <__gedf2+0xb8>
8000195c:	7ff00793          	li	a5,2047
80001960:	00f51663          	bne	a0,a5,8000196c <__gedf2+0x54>
80001964:	00c767b3          	or	a5,a4,a2
80001968:	06079463          	bnez	a5,800019d0 <__gedf2+0xb8>
8000196c:	00000793          	li	a5,0
80001970:	00089663          	bnez	a7,8000197c <__gedf2+0x64>
80001974:	01036833          	or	a6,t1,a6
80001978:	00183793          	seqz	a5,a6
8000197c:	04051e63          	bnez	a0,800019d8 <__gedf2+0xc0>
80001980:	00c76633          	or	a2,a4,a2
80001984:	00078c63          	beqz	a5,8000199c <__gedf2+0x84>
80001988:	02060063          	beqz	a2,800019a8 <__gedf2+0x90>
8000198c:	00100513          	li	a0,1
80001990:	00069c63          	bnez	a3,800019a8 <__gedf2+0x90>
80001994:	fff00513          	li	a0,-1
80001998:	00008067          	ret
8000199c:	04061063          	bnez	a2,800019dc <__gedf2+0xc4>
800019a0:	fff00513          	li	a0,-1
800019a4:	04058463          	beqz	a1,800019ec <__gedf2+0xd4>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800019a8:	00008067          	ret
  FP_CMP_D (r, A, B, -2, 2);
800019ac:	fea8c0e3          	blt	a7,a0,8000198c <__gedf2+0x74>
800019b0:	fe6768e3          	bltu	a4,t1,800019a0 <__gedf2+0x88>
800019b4:	00e31863          	bne	t1,a4,800019c4 <__gedf2+0xac>
800019b8:	ffcee4e3          	bltu	t4,t3,800019a0 <__gedf2+0x88>
800019bc:	00000513          	li	a0,0
800019c0:	ffde74e3          	bgeu	t3,t4,800019a8 <__gedf2+0x90>
800019c4:	00100513          	li	a0,1
800019c8:	fe0590e3          	bnez	a1,800019a8 <__gedf2+0x90>
800019cc:	fc9ff06f          	j	80001994 <__gedf2+0x7c>
800019d0:	ffe00513          	li	a0,-2
800019d4:	00008067          	ret
800019d8:	fa079ae3          	bnez	a5,8000198c <__gedf2+0x74>
800019dc:	fcb692e3          	bne	a3,a1,800019a0 <__gedf2+0x88>
800019e0:	fd1556e3          	bge	a0,a7,800019ac <__gedf2+0x94>
800019e4:	fff00513          	li	a0,-1
800019e8:	fc0690e3          	bnez	a3,800019a8 <__gedf2+0x90>
800019ec:	00100513          	li	a0,1
800019f0:	00008067          	ret

800019f4 <__ledf2>:
  FP_DECL_D (B);
  CMPtype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
  FP_UNPACK_RAW_D (B, b);
800019f4:	0146d793          	srl	a5,a3,0x14
  FP_UNPACK_RAW_D (A, a);
800019f8:	0145d893          	srl	a7,a1,0x14
800019fc:	00100737          	lui	a4,0x100
80001a00:	fff70713          	add	a4,a4,-1 # fffff <__stack_size+0xfbfff>
{
80001a04:	00050813          	mv	a6,a0
80001a08:	00050e13          	mv	t3,a0
  FP_UNPACK_RAW_D (A, a);
80001a0c:	7ff8f893          	and	a7,a7,2047
  FP_UNPACK_RAW_D (B, b);
80001a10:	7ff7f513          	and	a0,a5,2047
  FP_CMP_D (r, A, B, 2, 2);
80001a14:	7ff00793          	li	a5,2047
  FP_UNPACK_RAW_D (A, a);
80001a18:	00b77333          	and	t1,a4,a1
80001a1c:	00060e93          	mv	t4,a2
  FP_UNPACK_RAW_D (B, b);
80001a20:	00d77733          	and	a4,a4,a3
  FP_UNPACK_RAW_D (A, a);
80001a24:	01f5d593          	srl	a1,a1,0x1f
  FP_UNPACK_RAW_D (B, b);
80001a28:	01f6d693          	srl	a3,a3,0x1f
  FP_CMP_D (r, A, B, 2, 2);
80001a2c:	00f89663          	bne	a7,a5,80001a38 <__ledf2+0x44>
80001a30:	010367b3          	or	a5,t1,a6
80001a34:	06079c63          	bnez	a5,80001aac <__ledf2+0xb8>
80001a38:	7ff00793          	li	a5,2047
80001a3c:	00f51663          	bne	a0,a5,80001a48 <__ledf2+0x54>
80001a40:	00c767b3          	or	a5,a4,a2
80001a44:	06079463          	bnez	a5,80001aac <__ledf2+0xb8>
80001a48:	00000793          	li	a5,0
80001a4c:	00089663          	bnez	a7,80001a58 <__ledf2+0x64>
80001a50:	01036833          	or	a6,t1,a6
80001a54:	00183793          	seqz	a5,a6
80001a58:	04051e63          	bnez	a0,80001ab4 <__ledf2+0xc0>
80001a5c:	00c76633          	or	a2,a4,a2
80001a60:	00078c63          	beqz	a5,80001a78 <__ledf2+0x84>
80001a64:	02060063          	beqz	a2,80001a84 <__ledf2+0x90>
80001a68:	00100513          	li	a0,1
80001a6c:	00069c63          	bnez	a3,80001a84 <__ledf2+0x90>
80001a70:	fff00513          	li	a0,-1
80001a74:	00008067          	ret
80001a78:	04061063          	bnez	a2,80001ab8 <__ledf2+0xc4>
80001a7c:	fff00513          	li	a0,-1
80001a80:	04058463          	beqz	a1,80001ac8 <__ledf2+0xd4>
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80001a84:	00008067          	ret
  FP_CMP_D (r, A, B, 2, 2);
80001a88:	fea8c0e3          	blt	a7,a0,80001a68 <__ledf2+0x74>
80001a8c:	fe6768e3          	bltu	a4,t1,80001a7c <__ledf2+0x88>
80001a90:	00e31863          	bne	t1,a4,80001aa0 <__ledf2+0xac>
80001a94:	ffcee4e3          	bltu	t4,t3,80001a7c <__ledf2+0x88>
80001a98:	00000513          	li	a0,0
80001a9c:	ffde74e3          	bgeu	t3,t4,80001a84 <__ledf2+0x90>
80001aa0:	00100513          	li	a0,1
80001aa4:	fe0590e3          	bnez	a1,80001a84 <__ledf2+0x90>
80001aa8:	fc9ff06f          	j	80001a70 <__ledf2+0x7c>
80001aac:	00200513          	li	a0,2
80001ab0:	00008067          	ret
80001ab4:	fa079ae3          	bnez	a5,80001a68 <__ledf2+0x74>
80001ab8:	fcb692e3          	bne	a3,a1,80001a7c <__ledf2+0x88>
80001abc:	fd1556e3          	bge	a0,a7,80001a88 <__ledf2+0x94>
80001ac0:	fff00513          	li	a0,-1
80001ac4:	fc0690e3          	bnez	a3,80001a84 <__ledf2+0x90>
80001ac8:	00100513          	li	a0,1
80001acc:	00008067          	ret

80001ad0 <__muldf3>:
#include "soft-fp.h"
#include "double.h"

DFtype
__muldf3 (DFtype a, DFtype b)
{
80001ad0:	fd010113          	add	sp,sp,-48
80001ad4:	01512a23          	sw	s5,20(sp)
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_D (A, a);
80001ad8:	0145da93          	srl	s5,a1,0x14
{
80001adc:	02812423          	sw	s0,40(sp)
80001ae0:	02912223          	sw	s1,36(sp)
80001ae4:	01312e23          	sw	s3,28(sp)
80001ae8:	01412c23          	sw	s4,24(sp)
80001aec:	01612823          	sw	s6,16(sp)
  FP_UNPACK_D (A, a);
80001af0:	00c59493          	sll	s1,a1,0xc
{
80001af4:	02112623          	sw	ra,44(sp)
80001af8:	03212023          	sw	s2,32(sp)
80001afc:	01712623          	sw	s7,12(sp)
  FP_UNPACK_D (A, a);
80001b00:	7ffafa93          	and	s5,s5,2047
{
80001b04:	00050413          	mv	s0,a0
80001b08:	00060b13          	mv	s6,a2
80001b0c:	00068993          	mv	s3,a3
  FP_UNPACK_D (A, a);
80001b10:	00c4d493          	srl	s1,s1,0xc
80001b14:	01f5da13          	srl	s4,a1,0x1f
80001b18:	240a8e63          	beqz	s5,80001d74 <__muldf3+0x2a4>
80001b1c:	7ff00793          	li	a5,2047
80001b20:	2cfa8063          	beq	s5,a5,80001de0 <__muldf3+0x310>
80001b24:	00349493          	sll	s1,s1,0x3
80001b28:	01d55793          	srl	a5,a0,0x1d
80001b2c:	0097e7b3          	or	a5,a5,s1
80001b30:	008004b7          	lui	s1,0x800
80001b34:	0097e4b3          	or	s1,a5,s1
80001b38:	00351913          	sll	s2,a0,0x3
80001b3c:	c01a8a93          	add	s5,s5,-1023
80001b40:	00000b93          	li	s7,0
  FP_UNPACK_D (B, b);
80001b44:	0149d713          	srl	a4,s3,0x14
80001b48:	00c99413          	sll	s0,s3,0xc
80001b4c:	7ff77713          	and	a4,a4,2047
80001b50:	00c45413          	srl	s0,s0,0xc
80001b54:	01f9d993          	srl	s3,s3,0x1f
80001b58:	2c070063          	beqz	a4,80001e18 <__muldf3+0x348>
80001b5c:	7ff00793          	li	a5,2047
80001b60:	32f70463          	beq	a4,a5,80001e88 <__muldf3+0x3b8>
80001b64:	00341413          	sll	s0,s0,0x3
80001b68:	01db5793          	srl	a5,s6,0x1d
80001b6c:	0087e7b3          	or	a5,a5,s0
80001b70:	00800437          	lui	s0,0x800
80001b74:	0087e433          	or	s0,a5,s0
80001b78:	c0170693          	add	a3,a4,-1023
80001b7c:	003b1793          	sll	a5,s6,0x3
80001b80:	00000713          	li	a4,0
  FP_MUL_D (R, A, B);
80001b84:	00da8ab3          	add	s5,s5,a3
80001b88:	002b9693          	sll	a3,s7,0x2
80001b8c:	00e6e6b3          	or	a3,a3,a4
80001b90:	00a00613          	li	a2,10
80001b94:	001a8513          	add	a0,s5,1
80001b98:	40d64663          	blt	a2,a3,80001fa4 <__muldf3+0x4d4>
80001b9c:	00200613          	li	a2,2
80001ba0:	013a45b3          	xor	a1,s4,s3
80001ba4:	30d64e63          	blt	a2,a3,80001ec0 <__muldf3+0x3f0>
80001ba8:	fff68693          	add	a3,a3,-1
80001bac:	00100613          	li	a2,1
80001bb0:	32d67a63          	bgeu	a2,a3,80001ee4 <__muldf3+0x414>
80001bb4:	00010337          	lui	t1,0x10
80001bb8:	fff30e13          	add	t3,t1,-1 # ffff <__stack_size+0xbfff>
80001bbc:	01095713          	srl	a4,s2,0x10
80001bc0:	0107d893          	srl	a7,a5,0x10
80001bc4:	01c97933          	and	s2,s2,t3
80001bc8:	01c7ff33          	and	t5,a5,t3
80001bcc:	03e907b3          	mul	a5,s2,t5
80001bd0:	03e70eb3          	mul	t4,a4,t5
80001bd4:	0107d813          	srl	a6,a5,0x10
80001bd8:	03288633          	mul	a2,a7,s2
80001bdc:	01d60633          	add	a2,a2,t4
80001be0:	00c80833          	add	a6,a6,a2
80001be4:	031706b3          	mul	a3,a4,a7
80001be8:	01d87463          	bgeu	a6,t4,80001bf0 <__muldf3+0x120>
80001bec:	006686b3          	add	a3,a3,t1
80001bf0:	01085293          	srl	t0,a6,0x10
80001bf4:	01c87833          	and	a6,a6,t3
80001bf8:	01c7f7b3          	and	a5,a5,t3
80001bfc:	01045613          	srl	a2,s0,0x10
80001c00:	01c47e33          	and	t3,s0,t3
80001c04:	01081813          	sll	a6,a6,0x10
80001c08:	00f80833          	add	a6,a6,a5
80001c0c:	03c90eb3          	mul	t4,s2,t3
80001c10:	03c707b3          	mul	a5,a4,t3
80001c14:	03260933          	mul	s2,a2,s2
80001c18:	02c70333          	mul	t1,a4,a2
80001c1c:	00f90933          	add	s2,s2,a5
80001c20:	010ed713          	srl	a4,t4,0x10
80001c24:	01270733          	add	a4,a4,s2
80001c28:	00f77663          	bgeu	a4,a5,80001c34 <__muldf3+0x164>
80001c2c:	000107b7          	lui	a5,0x10
80001c30:	00f30333          	add	t1,t1,a5
80001c34:	00010437          	lui	s0,0x10
80001c38:	01075793          	srl	a5,a4,0x10
80001c3c:	fff40f93          	add	t6,s0,-1 # ffff <__stack_size+0xbfff>
80001c40:	00678333          	add	t1,a5,t1
80001c44:	01f777b3          	and	a5,a4,t6
80001c48:	01fefeb3          	and	t4,t4,t6
80001c4c:	01079793          	sll	a5,a5,0x10
80001c50:	01f4ffb3          	and	t6,s1,t6
80001c54:	01d787b3          	add	a5,a5,t4
80001c58:	0104de93          	srl	t4,s1,0x10
80001c5c:	03ff03b3          	mul	t2,t5,t6
80001c60:	00f282b3          	add	t0,t0,a5
80001c64:	03ee8f33          	mul	t5,t4,t5
80001c68:	0103d713          	srl	a4,t2,0x10
80001c6c:	03d884b3          	mul	s1,a7,t4
80001c70:	03f888b3          	mul	a7,a7,t6
80001c74:	01e888b3          	add	a7,a7,t5
80001c78:	01170733          	add	a4,a4,a7
80001c7c:	01e77463          	bgeu	a4,t5,80001c84 <__muldf3+0x1b4>
80001c80:	008484b3          	add	s1,s1,s0
80001c84:	01075f13          	srl	t5,a4,0x10
80001c88:	009f0f33          	add	t5,t5,s1
80001c8c:	000104b7          	lui	s1,0x10
80001c90:	fff48413          	add	s0,s1,-1 # ffff <__stack_size+0xbfff>
80001c94:	00877733          	and	a4,a4,s0
80001c98:	0083f3b3          	and	t2,t2,s0
80001c9c:	01071713          	sll	a4,a4,0x10
80001ca0:	007708b3          	add	a7,a4,t2
80001ca4:	03fe03b3          	mul	t2,t3,t6
80001ca8:	03ce8e33          	mul	t3,t4,t3
80001cac:	03d60eb3          	mul	t4,a2,t4
80001cb0:	03f60633          	mul	a2,a2,t6
80001cb4:	0103df93          	srl	t6,t2,0x10
80001cb8:	01c60633          	add	a2,a2,t3
80001cbc:	00cf8fb3          	add	t6,t6,a2
80001cc0:	01cff463          	bgeu	t6,t3,80001cc8 <__muldf3+0x1f8>
80001cc4:	009e8eb3          	add	t4,t4,s1
80001cc8:	008ff733          	and	a4,t6,s0
80001ccc:	0083f3b3          	and	t2,t2,s0
80001cd0:	01071713          	sll	a4,a4,0x10
80001cd4:	005686b3          	add	a3,a3,t0
80001cd8:	00770733          	add	a4,a4,t2
80001cdc:	00670333          	add	t1,a4,t1
80001ce0:	00f6b7b3          	sltu	a5,a3,a5
80001ce4:	00f307b3          	add	a5,t1,a5
80001ce8:	00e33633          	sltu	a2,t1,a4
80001cec:	011688b3          	add	a7,a3,a7
80001cf0:	0067b333          	sltu	t1,a5,t1
80001cf4:	00666633          	or	a2,a2,t1
80001cf8:	00d8b6b3          	sltu	a3,a7,a3
80001cfc:	01e78333          	add	t1,a5,t5
80001d00:	00d306b3          	add	a3,t1,a3
80001d04:	00f33733          	sltu	a4,t1,a5
80001d08:	010fdf93          	srl	t6,t6,0x10
80001d0c:	0066b333          	sltu	t1,a3,t1
80001d10:	00989793          	sll	a5,a7,0x9
80001d14:	01f60633          	add	a2,a2,t6
80001d18:	00676733          	or	a4,a4,t1
80001d1c:	00c70733          	add	a4,a4,a2
80001d20:	0107e7b3          	or	a5,a5,a6
80001d24:	01d70733          	add	a4,a4,t4
80001d28:	00f037b3          	snez	a5,a5
80001d2c:	0178d893          	srl	a7,a7,0x17
80001d30:	00971713          	sll	a4,a4,0x9
80001d34:	0176d413          	srl	s0,a3,0x17
80001d38:	0117e7b3          	or	a5,a5,a7
80001d3c:	00969693          	sll	a3,a3,0x9
80001d40:	00d7e7b3          	or	a5,a5,a3
80001d44:	00771693          	sll	a3,a4,0x7
80001d48:	00876433          	or	s0,a4,s0
80001d4c:	0206d063          	bgez	a3,80001d6c <__muldf3+0x29c>
80001d50:	0017d713          	srl	a4,a5,0x1
80001d54:	0017f793          	and	a5,a5,1
80001d58:	00f76733          	or	a4,a4,a5
80001d5c:	01f41793          	sll	a5,s0,0x1f
80001d60:	00f767b3          	or	a5,a4,a5
80001d64:	00145413          	srl	s0,s0,0x1
80001d68:	00050a93          	mv	s5,a0
80001d6c:	000a8513          	mv	a0,s5
80001d70:	18c0006f          	j	80001efc <__muldf3+0x42c>
  FP_UNPACK_D (A, a);
80001d74:	00a4e933          	or	s2,s1,a0
80001d78:	08090063          	beqz	s2,80001df8 <__muldf3+0x328>
80001d7c:	04048063          	beqz	s1,80001dbc <__muldf3+0x2ec>
80001d80:	00048513          	mv	a0,s1
80001d84:	000010ef          	jal	80002d84 <__clzsi2>
80001d88:	ff550713          	add	a4,a0,-11 # 7fff5 <__stack_size+0x7bff5>
80001d8c:	01d00793          	li	a5,29
80001d90:	ff850693          	add	a3,a0,-8
80001d94:	40e787b3          	sub	a5,a5,a4
80001d98:	00d494b3          	sll	s1,s1,a3
80001d9c:	00f457b3          	srl	a5,s0,a5
80001da0:	0097e7b3          	or	a5,a5,s1
80001da4:	00d414b3          	sll	s1,s0,a3
80001da8:	c0d00a93          	li	s5,-1011
80001dac:	00048913          	mv	s2,s1
80001db0:	40aa8ab3          	sub	s5,s5,a0
80001db4:	00078493          	mv	s1,a5
80001db8:	d89ff06f          	j	80001b40 <__muldf3+0x70>
80001dbc:	7c9000ef          	jal	80002d84 <__clzsi2>
80001dc0:	00050793          	mv	a5,a0
80001dc4:	01578713          	add	a4,a5,21 # 10015 <__stack_size+0xc015>
80001dc8:	01c00693          	li	a3,28
80001dcc:	02050513          	add	a0,a0,32
80001dd0:	fae6dee3          	bge	a3,a4,80001d8c <__muldf3+0x2bc>
80001dd4:	ff878793          	add	a5,a5,-8
80001dd8:	00f417b3          	sll	a5,s0,a5
80001ddc:	fcdff06f          	j	80001da8 <__muldf3+0x2d8>
80001de0:	00a4e933          	or	s2,s1,a0
80001de4:	02091263          	bnez	s2,80001e08 <__muldf3+0x338>
80001de8:	00000493          	li	s1,0
80001dec:	7ff00a93          	li	s5,2047
80001df0:	00200b93          	li	s7,2
80001df4:	d51ff06f          	j	80001b44 <__muldf3+0x74>
80001df8:	00000493          	li	s1,0
80001dfc:	00000a93          	li	s5,0
80001e00:	00100b93          	li	s7,1
80001e04:	d41ff06f          	j	80001b44 <__muldf3+0x74>
80001e08:	00050913          	mv	s2,a0
80001e0c:	7ff00a93          	li	s5,2047
80001e10:	00300b93          	li	s7,3
80001e14:	d31ff06f          	j	80001b44 <__muldf3+0x74>
  FP_UNPACK_D (B, b);
80001e18:	016467b3          	or	a5,s0,s6
80001e1c:	08078263          	beqz	a5,80001ea0 <__muldf3+0x3d0>
80001e20:	04040063          	beqz	s0,80001e60 <__muldf3+0x390>
80001e24:	00040513          	mv	a0,s0
80001e28:	75d000ef          	jal	80002d84 <__clzsi2>
80001e2c:	ff550693          	add	a3,a0,-11
80001e30:	01d00713          	li	a4,29
80001e34:	ff850793          	add	a5,a0,-8
80001e38:	40d70733          	sub	a4,a4,a3
80001e3c:	00f41433          	sll	s0,s0,a5
80001e40:	00eb5733          	srl	a4,s6,a4
80001e44:	00876733          	or	a4,a4,s0
80001e48:	00fb1433          	sll	s0,s6,a5
80001e4c:	c0d00693          	li	a3,-1011
80001e50:	00040793          	mv	a5,s0
80001e54:	40a686b3          	sub	a3,a3,a0
80001e58:	00070413          	mv	s0,a4
80001e5c:	d25ff06f          	j	80001b80 <__muldf3+0xb0>
80001e60:	000b0513          	mv	a0,s6
80001e64:	721000ef          	jal	80002d84 <__clzsi2>
80001e68:	00050793          	mv	a5,a0
80001e6c:	01578693          	add	a3,a5,21
80001e70:	01c00713          	li	a4,28
80001e74:	02050513          	add	a0,a0,32
80001e78:	fad75ce3          	bge	a4,a3,80001e30 <__muldf3+0x360>
80001e7c:	ff878793          	add	a5,a5,-8
80001e80:	00fb1733          	sll	a4,s6,a5
80001e84:	fc9ff06f          	j	80001e4c <__muldf3+0x37c>
80001e88:	016467b3          	or	a5,s0,s6
80001e8c:	02079263          	bnez	a5,80001eb0 <__muldf3+0x3e0>
80001e90:	00000413          	li	s0,0
80001e94:	7ff00693          	li	a3,2047
80001e98:	00200713          	li	a4,2
80001e9c:	ce9ff06f          	j	80001b84 <__muldf3+0xb4>
80001ea0:	00000413          	li	s0,0
80001ea4:	00000693          	li	a3,0
80001ea8:	00100713          	li	a4,1
80001eac:	cd9ff06f          	j	80001b84 <__muldf3+0xb4>
80001eb0:	000b0793          	mv	a5,s6
80001eb4:	7ff00693          	li	a3,2047
80001eb8:	00300713          	li	a4,3
80001ebc:	cc9ff06f          	j	80001b84 <__muldf3+0xb4>
80001ec0:	00100613          	li	a2,1
80001ec4:	00d61633          	sll	a2,a2,a3
  FP_MUL_D (R, A, B);
80001ec8:	53067693          	and	a3,a2,1328
80001ecc:	0e069663          	bnez	a3,80001fb8 <__muldf3+0x4e8>
80001ed0:	24067813          	and	a6,a2,576
80001ed4:	1a081a63          	bnez	a6,80002088 <__muldf3+0x5b8>
80001ed8:	08867613          	and	a2,a2,136
80001edc:	cc060ce3          	beqz	a2,80001bb4 <__muldf3+0xe4>
  FP_UNPACK_D (B, b);
80001ee0:	00098593          	mv	a1,s3
  FP_PACK_D (r, R);
80001ee4:	00200693          	li	a3,2
80001ee8:	18d70863          	beq	a4,a3,80002078 <__muldf3+0x5a8>
80001eec:	00300693          	li	a3,3
80001ef0:	1ad70463          	beq	a4,a3,80002098 <__muldf3+0x5c8>
80001ef4:	00100693          	li	a3,1
80001ef8:	1ad70663          	beq	a4,a3,800020a4 <__muldf3+0x5d4>
80001efc:	3ff50613          	add	a2,a0,1023
80001f00:	0cc05463          	blez	a2,80001fc8 <__muldf3+0x4f8>
80001f04:	0077f713          	and	a4,a5,7
80001f08:	02070063          	beqz	a4,80001f28 <__muldf3+0x458>
80001f0c:	00f7f713          	and	a4,a5,15
80001f10:	00400693          	li	a3,4
80001f14:	00d70a63          	beq	a4,a3,80001f28 <__muldf3+0x458>
80001f18:	00478713          	add	a4,a5,4
80001f1c:	00f736b3          	sltu	a3,a4,a5
80001f20:	00d40433          	add	s0,s0,a3
80001f24:	00070793          	mv	a5,a4
80001f28:	00741713          	sll	a4,s0,0x7
80001f2c:	00075a63          	bgez	a4,80001f40 <__muldf3+0x470>
80001f30:	ff000737          	lui	a4,0xff000
80001f34:	fff70713          	add	a4,a4,-1 # feffffff <__stack_base+0x5efeffff>
80001f38:	00e47433          	and	s0,s0,a4
80001f3c:	40050613          	add	a2,a0,1024
80001f40:	7fe00713          	li	a4,2046
80001f44:	12c74a63          	blt	a4,a2,80002078 <__muldf3+0x5a8>
80001f48:	0037d793          	srl	a5,a5,0x3
80001f4c:	01d41693          	sll	a3,s0,0x1d
80001f50:	00f6e6b3          	or	a3,a3,a5
80001f54:	00345713          	srl	a4,s0,0x3
80001f58:	00c71713          	sll	a4,a4,0xc
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80001f5c:	02c12083          	lw	ra,44(sp)
80001f60:	02812403          	lw	s0,40(sp)
  FP_PACK_D (r, R);
80001f64:	01461613          	sll	a2,a2,0x14
80001f68:	00c75713          	srl	a4,a4,0xc
80001f6c:	01f59593          	sll	a1,a1,0x1f
80001f70:	00e66633          	or	a2,a2,a4
80001f74:	00b667b3          	or	a5,a2,a1
}
80001f78:	02412483          	lw	s1,36(sp)
80001f7c:	02012903          	lw	s2,32(sp)
80001f80:	01c12983          	lw	s3,28(sp)
80001f84:	01812a03          	lw	s4,24(sp)
80001f88:	01412a83          	lw	s5,20(sp)
80001f8c:	01012b03          	lw	s6,16(sp)
80001f90:	00c12b83          	lw	s7,12(sp)
80001f94:	00068513          	mv	a0,a3
80001f98:	00078593          	mv	a1,a5
80001f9c:	03010113          	add	sp,sp,48
80001fa0:	00008067          	ret
  FP_MUL_D (R, A, B);
80001fa4:	00f00613          	li	a2,15
80001fa8:	0ec68863          	beq	a3,a2,80002098 <__muldf3+0x5c8>
80001fac:	00b00613          	li	a2,11
  FP_UNPACK_D (A, a);
80001fb0:	000a0593          	mv	a1,s4
  FP_MUL_D (R, A, B);
80001fb4:	f2c686e3          	beq	a3,a2,80001ee0 <__muldf3+0x410>
80001fb8:	00048413          	mv	s0,s1
80001fbc:	00090793          	mv	a5,s2
80001fc0:	000b8713          	mv	a4,s7
80001fc4:	f21ff06f          	j	80001ee4 <__muldf3+0x414>
  FP_PACK_D (r, R);
80001fc8:	00100713          	li	a4,1
80001fcc:	40c70733          	sub	a4,a4,a2
80001fd0:	03800693          	li	a3,56
80001fd4:	0ce6c863          	blt	a3,a4,800020a4 <__muldf3+0x5d4>
80001fd8:	01f00693          	li	a3,31
80001fdc:	06e6c463          	blt	a3,a4,80002044 <__muldf3+0x574>
80001fe0:	41e50513          	add	a0,a0,1054
80001fe4:	00e7d633          	srl	a2,a5,a4
80001fe8:	00a416b3          	sll	a3,s0,a0
80001fec:	00a79533          	sll	a0,a5,a0
80001ff0:	00c6e6b3          	or	a3,a3,a2
80001ff4:	00a03533          	snez	a0,a0
80001ff8:	00a6e7b3          	or	a5,a3,a0
80001ffc:	00e45733          	srl	a4,s0,a4
80002000:	0077f693          	and	a3,a5,7
80002004:	02068063          	beqz	a3,80002024 <__muldf3+0x554>
80002008:	00f7f693          	and	a3,a5,15
8000200c:	00400613          	li	a2,4
80002010:	00c68a63          	beq	a3,a2,80002024 <__muldf3+0x554>
80002014:	00478693          	add	a3,a5,4
80002018:	00f6b633          	sltu	a2,a3,a5
8000201c:	00c70733          	add	a4,a4,a2
80002020:	00068793          	mv	a5,a3
80002024:	00871693          	sll	a3,a4,0x8
80002028:	0806c463          	bltz	a3,800020b0 <__muldf3+0x5e0>
8000202c:	01d71693          	sll	a3,a4,0x1d
80002030:	0037d793          	srl	a5,a5,0x3
80002034:	00f6e6b3          	or	a3,a3,a5
80002038:	00375713          	srl	a4,a4,0x3
8000203c:	00000613          	li	a2,0
80002040:	f19ff06f          	j	80001f58 <__muldf3+0x488>
80002044:	fe100693          	li	a3,-31
80002048:	40c686b3          	sub	a3,a3,a2
8000204c:	02000813          	li	a6,32
80002050:	00d456b3          	srl	a3,s0,a3
80002054:	00000613          	li	a2,0
80002058:	01070663          	beq	a4,a6,80002064 <__muldf3+0x594>
8000205c:	43e50613          	add	a2,a0,1086
80002060:	00c41633          	sll	a2,s0,a2
80002064:	00f66633          	or	a2,a2,a5
80002068:	00c03633          	snez	a2,a2
8000206c:	00c6e7b3          	or	a5,a3,a2
80002070:	00000713          	li	a4,0
80002074:	f8dff06f          	j	80002000 <__muldf3+0x530>
80002078:	00000713          	li	a4,0
8000207c:	00000693          	li	a3,0
80002080:	7ff00613          	li	a2,2047
80002084:	ed5ff06f          	j	80001f58 <__muldf3+0x488>
  FP_MUL_D (R, A, B);
80002088:	00080737          	lui	a4,0x80
  FP_PACK_D (r, R);
8000208c:	7ff00613          	li	a2,2047
80002090:	00000593          	li	a1,0
80002094:	ec5ff06f          	j	80001f58 <__muldf3+0x488>
80002098:	00080737          	lui	a4,0x80
8000209c:	00000693          	li	a3,0
800020a0:	fedff06f          	j	8000208c <__muldf3+0x5bc>
800020a4:	00000713          	li	a4,0
800020a8:	00000693          	li	a3,0
800020ac:	f91ff06f          	j	8000203c <__muldf3+0x56c>
800020b0:	00000713          	li	a4,0
800020b4:	00000693          	li	a3,0
800020b8:	00100613          	li	a2,1
800020bc:	e9dff06f          	j	80001f58 <__muldf3+0x488>

800020c0 <__subdf3>:
  FP_DECL_D (B);
  FP_DECL_D (R);
  DFtype r;

  FP_INIT_ROUNDMODE;
  FP_UNPACK_SEMIRAW_D (A, a);
800020c0:	00100837          	lui	a6,0x100
800020c4:	fff80813          	add	a6,a6,-1 # fffff <__stack_size+0xfbfff>
{
800020c8:	fe010113          	add	sp,sp,-32
  FP_UNPACK_SEMIRAW_D (A, a);
800020cc:	00b878b3          	and	a7,a6,a1
800020d0:	0145d713          	srl	a4,a1,0x14
800020d4:	01d55793          	srl	a5,a0,0x1d
  FP_UNPACK_SEMIRAW_D (B, b);
800020d8:	00d87833          	and	a6,a6,a3
{
800020dc:	01212823          	sw	s2,16(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
800020e0:	7ff77913          	and	s2,a4,2047
800020e4:	00389713          	sll	a4,a7,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
800020e8:	0146d893          	srl	a7,a3,0x14
{
800020ec:	00912a23          	sw	s1,20(sp)
  FP_UNPACK_SEMIRAW_D (A, a);
800020f0:	00e7e7b3          	or	a5,a5,a4
800020f4:	01f5d493          	srl	s1,a1,0x1f
  FP_UNPACK_SEMIRAW_D (B, b);
800020f8:	01d65713          	srl	a4,a2,0x1d
800020fc:	00381813          	sll	a6,a6,0x3
{
80002100:	00112e23          	sw	ra,28(sp)
80002104:	00812c23          	sw	s0,24(sp)
80002108:	01312623          	sw	s3,12(sp)
  FP_UNPACK_SEMIRAW_D (B, b);
8000210c:	7ff8f893          	and	a7,a7,2047
  FP_SUB_D (R, A, B);
80002110:	7ff00593          	li	a1,2047
  FP_UNPACK_SEMIRAW_D (A, a);
80002114:	00351513          	sll	a0,a0,0x3
  FP_UNPACK_SEMIRAW_D (B, b);
80002118:	01f6d693          	srl	a3,a3,0x1f
8000211c:	01076733          	or	a4,a4,a6
80002120:	00361613          	sll	a2,a2,0x3
  FP_SUB_D (R, A, B);
80002124:	00b89663          	bne	a7,a1,80002130 <__subdf3+0x70>
80002128:	00c765b3          	or	a1,a4,a2
8000212c:	00059463          	bnez	a1,80002134 <__subdf3+0x74>
80002130:	0016c693          	xor	a3,a3,1
80002134:	41190833          	sub	a6,s2,a7
80002138:	2a969a63          	bne	a3,s1,800023ec <__subdf3+0x32c>
8000213c:	11005c63          	blez	a6,80002254 <__subdf3+0x194>
80002140:	04089063          	bnez	a7,80002180 <__subdf3+0xc0>
80002144:	00c766b3          	or	a3,a4,a2
80002148:	66068063          	beqz	a3,800027a8 <__subdf3+0x6e8>
8000214c:	fff80593          	add	a1,a6,-1
80002150:	02059063          	bnez	a1,80002170 <__subdf3+0xb0>
80002154:	00c50633          	add	a2,a0,a2
80002158:	00a636b3          	sltu	a3,a2,a0
8000215c:	00e78733          	add	a4,a5,a4
80002160:	00060513          	mv	a0,a2
80002164:	00d707b3          	add	a5,a4,a3
80002168:	00100913          	li	s2,1
8000216c:	06c0006f          	j	800021d8 <__subdf3+0x118>
80002170:	7ff00693          	li	a3,2047
80002174:	02d81063          	bne	a6,a3,80002194 <__subdf3+0xd4>
80002178:	7ff00913          	li	s2,2047
8000217c:	1f80006f          	j	80002374 <__subdf3+0x2b4>
80002180:	7ff00693          	li	a3,2047
80002184:	1ed90863          	beq	s2,a3,80002374 <__subdf3+0x2b4>
80002188:	008006b7          	lui	a3,0x800
8000218c:	00d76733          	or	a4,a4,a3
80002190:	00080593          	mv	a1,a6
80002194:	03800693          	li	a3,56
80002198:	0ab6c863          	blt	a3,a1,80002248 <__subdf3+0x188>
8000219c:	01f00693          	li	a3,31
800021a0:	06b6ca63          	blt	a3,a1,80002214 <__subdf3+0x154>
800021a4:	02000813          	li	a6,32
800021a8:	40b80833          	sub	a6,a6,a1
800021ac:	010716b3          	sll	a3,a4,a6
800021b0:	00b658b3          	srl	a7,a2,a1
800021b4:	01061833          	sll	a6,a2,a6
800021b8:	0116e6b3          	or	a3,a3,a7
800021bc:	01003833          	snez	a6,a6
800021c0:	0106e6b3          	or	a3,a3,a6
800021c4:	00b755b3          	srl	a1,a4,a1
800021c8:	00a68533          	add	a0,a3,a0
800021cc:	00f585b3          	add	a1,a1,a5
800021d0:	00d536b3          	sltu	a3,a0,a3
800021d4:	00d587b3          	add	a5,a1,a3
800021d8:	00879713          	sll	a4,a5,0x8
800021dc:	18075c63          	bgez	a4,80002374 <__subdf3+0x2b4>
800021e0:	00190913          	add	s2,s2,1
800021e4:	7ff00713          	li	a4,2047
800021e8:	5ae90a63          	beq	s2,a4,8000279c <__subdf3+0x6dc>
800021ec:	ff800737          	lui	a4,0xff800
800021f0:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
800021f4:	00e7f733          	and	a4,a5,a4
800021f8:	00155793          	srl	a5,a0,0x1
800021fc:	00157513          	and	a0,a0,1
80002200:	00a7e7b3          	or	a5,a5,a0
80002204:	01f71513          	sll	a0,a4,0x1f
80002208:	00f56533          	or	a0,a0,a5
8000220c:	00175793          	srl	a5,a4,0x1
80002210:	1640006f          	j	80002374 <__subdf3+0x2b4>
80002214:	fe058693          	add	a3,a1,-32
80002218:	02000893          	li	a7,32
8000221c:	00d756b3          	srl	a3,a4,a3
80002220:	00000813          	li	a6,0
80002224:	01158863          	beq	a1,a7,80002234 <__subdf3+0x174>
80002228:	04000813          	li	a6,64
8000222c:	40b80833          	sub	a6,a6,a1
80002230:	01071833          	sll	a6,a4,a6
80002234:	00c86833          	or	a6,a6,a2
80002238:	01003833          	snez	a6,a6
8000223c:	0106e6b3          	or	a3,a3,a6
80002240:	00000593          	li	a1,0
80002244:	f85ff06f          	j	800021c8 <__subdf3+0x108>
80002248:	00c766b3          	or	a3,a4,a2
8000224c:	00d036b3          	snez	a3,a3
80002250:	ff1ff06f          	j	80002240 <__subdf3+0x180>
80002254:	0c080a63          	beqz	a6,80002328 <__subdf3+0x268>
80002258:	412886b3          	sub	a3,a7,s2
8000225c:	02091463          	bnez	s2,80002284 <__subdf3+0x1c4>
80002260:	00a7e5b3          	or	a1,a5,a0
80002264:	50058e63          	beqz	a1,80002780 <__subdf3+0x6c0>
80002268:	fff68593          	add	a1,a3,-1 # 7fffff <__stack_size+0x7fbfff>
8000226c:	ee0584e3          	beqz	a1,80002154 <__subdf3+0x94>
80002270:	7ff00813          	li	a6,2047
80002274:	03069263          	bne	a3,a6,80002298 <__subdf3+0x1d8>
80002278:	00070793          	mv	a5,a4
8000227c:	00060513          	mv	a0,a2
80002280:	ef9ff06f          	j	80002178 <__subdf3+0xb8>
80002284:	7ff00593          	li	a1,2047
80002288:	feb888e3          	beq	a7,a1,80002278 <__subdf3+0x1b8>
8000228c:	008005b7          	lui	a1,0x800
80002290:	00b7e7b3          	or	a5,a5,a1
80002294:	00068593          	mv	a1,a3
80002298:	03800693          	li	a3,56
8000229c:	08b6c063          	blt	a3,a1,8000231c <__subdf3+0x25c>
800022a0:	01f00693          	li	a3,31
800022a4:	04b6c263          	blt	a3,a1,800022e8 <__subdf3+0x228>
800022a8:	02000813          	li	a6,32
800022ac:	40b80833          	sub	a6,a6,a1
800022b0:	010796b3          	sll	a3,a5,a6
800022b4:	00b55333          	srl	t1,a0,a1
800022b8:	01051833          	sll	a6,a0,a6
800022bc:	0066e6b3          	or	a3,a3,t1
800022c0:	01003833          	snez	a6,a6
800022c4:	0106e6b3          	or	a3,a3,a6
800022c8:	00b7d5b3          	srl	a1,a5,a1
800022cc:	00c68633          	add	a2,a3,a2
800022d0:	00e585b3          	add	a1,a1,a4
800022d4:	00d636b3          	sltu	a3,a2,a3
800022d8:	00060513          	mv	a0,a2
800022dc:	00d587b3          	add	a5,a1,a3
800022e0:	00088913          	mv	s2,a7
800022e4:	ef5ff06f          	j	800021d8 <__subdf3+0x118>
800022e8:	fe058693          	add	a3,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
800022ec:	02000313          	li	t1,32
800022f0:	00d7d6b3          	srl	a3,a5,a3
800022f4:	00000813          	li	a6,0
800022f8:	00658863          	beq	a1,t1,80002308 <__subdf3+0x248>
800022fc:	04000813          	li	a6,64
80002300:	40b80833          	sub	a6,a6,a1
80002304:	01079833          	sll	a6,a5,a6
80002308:	00a86833          	or	a6,a6,a0
8000230c:	01003833          	snez	a6,a6
80002310:	0106e6b3          	or	a3,a3,a6
80002314:	00000593          	li	a1,0
80002318:	fb5ff06f          	j	800022cc <__subdf3+0x20c>
8000231c:	00a7e6b3          	or	a3,a5,a0
80002320:	00d036b3          	snez	a3,a3
80002324:	ff1ff06f          	j	80002314 <__subdf3+0x254>
80002328:	00190693          	add	a3,s2,1
8000232c:	7fe6f593          	and	a1,a3,2046
80002330:	08059663          	bnez	a1,800023bc <__subdf3+0x2fc>
80002334:	00a7e6b3          	or	a3,a5,a0
80002338:	06091263          	bnez	s2,8000239c <__subdf3+0x2dc>
8000233c:	44068863          	beqz	a3,8000278c <__subdf3+0x6cc>
80002340:	00c766b3          	or	a3,a4,a2
80002344:	02068863          	beqz	a3,80002374 <__subdf3+0x2b4>
80002348:	00c50633          	add	a2,a0,a2
8000234c:	00a636b3          	sltu	a3,a2,a0
80002350:	00e78733          	add	a4,a5,a4
80002354:	00d707b3          	add	a5,a4,a3
80002358:	00879713          	sll	a4,a5,0x8
8000235c:	00060513          	mv	a0,a2
80002360:	00075a63          	bgez	a4,80002374 <__subdf3+0x2b4>
80002364:	ff800737          	lui	a4,0xff800
80002368:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
8000236c:	00e7f7b3          	and	a5,a5,a4
80002370:	00100913          	li	s2,1
  FP_PACK_SEMIRAW_D (r, R);
80002374:	00757713          	and	a4,a0,7
80002378:	44070863          	beqz	a4,800027c8 <__subdf3+0x708>
8000237c:	00f57713          	and	a4,a0,15
80002380:	00400693          	li	a3,4
80002384:	44d70263          	beq	a4,a3,800027c8 <__subdf3+0x708>
80002388:	00450713          	add	a4,a0,4
8000238c:	00a736b3          	sltu	a3,a4,a0
80002390:	00d787b3          	add	a5,a5,a3
80002394:	00070513          	mv	a0,a4
80002398:	4300006f          	j	800027c8 <__subdf3+0x708>
  FP_SUB_D (R, A, B);
8000239c:	ec068ee3          	beqz	a3,80002278 <__subdf3+0x1b8>
800023a0:	00c76633          	or	a2,a4,a2
800023a4:	dc060ae3          	beqz	a2,80002178 <__subdf3+0xb8>
800023a8:	00000493          	li	s1,0
800023ac:	004007b7          	lui	a5,0x400
800023b0:	00000513          	li	a0,0
800023b4:	7ff00913          	li	s2,2047
800023b8:	4100006f          	j	800027c8 <__subdf3+0x708>
800023bc:	7ff00593          	li	a1,2047
800023c0:	3cb68c63          	beq	a3,a1,80002798 <__subdf3+0x6d8>
800023c4:	00c50633          	add	a2,a0,a2
800023c8:	00a63533          	sltu	a0,a2,a0
800023cc:	00e78733          	add	a4,a5,a4
800023d0:	00a70733          	add	a4,a4,a0
800023d4:	01f71513          	sll	a0,a4,0x1f
800023d8:	00165613          	srl	a2,a2,0x1
800023dc:	00c56533          	or	a0,a0,a2
800023e0:	00175793          	srl	a5,a4,0x1
800023e4:	00068913          	mv	s2,a3
800023e8:	f8dff06f          	j	80002374 <__subdf3+0x2b4>
800023ec:	0f005c63          	blez	a6,800024e4 <__subdf3+0x424>
800023f0:	08089e63          	bnez	a7,8000248c <__subdf3+0x3cc>
800023f4:	00c766b3          	or	a3,a4,a2
800023f8:	3a068863          	beqz	a3,800027a8 <__subdf3+0x6e8>
800023fc:	fff80693          	add	a3,a6,-1
80002400:	02069063          	bnez	a3,80002420 <__subdf3+0x360>
80002404:	40c50633          	sub	a2,a0,a2
80002408:	00c536b3          	sltu	a3,a0,a2
8000240c:	40e78733          	sub	a4,a5,a4
80002410:	00060513          	mv	a0,a2
80002414:	40d707b3          	sub	a5,a4,a3
80002418:	00100913          	li	s2,1
8000241c:	0540006f          	j	80002470 <__subdf3+0x3b0>
80002420:	7ff00593          	li	a1,2047
80002424:	d4b80ae3          	beq	a6,a1,80002178 <__subdf3+0xb8>
80002428:	03800593          	li	a1,56
8000242c:	0ad5c663          	blt	a1,a3,800024d8 <__subdf3+0x418>
80002430:	01f00593          	li	a1,31
80002434:	06d5c863          	blt	a1,a3,800024a4 <__subdf3+0x3e4>
80002438:	02000813          	li	a6,32
8000243c:	40d80833          	sub	a6,a6,a3
80002440:	00d658b3          	srl	a7,a2,a3
80002444:	010715b3          	sll	a1,a4,a6
80002448:	01061833          	sll	a6,a2,a6
8000244c:	0115e5b3          	or	a1,a1,a7
80002450:	01003833          	snez	a6,a6
80002454:	0105e633          	or	a2,a1,a6
80002458:	00d756b3          	srl	a3,a4,a3
8000245c:	40c50633          	sub	a2,a0,a2
80002460:	00c53733          	sltu	a4,a0,a2
80002464:	40d786b3          	sub	a3,a5,a3
80002468:	00060513          	mv	a0,a2
8000246c:	40e687b3          	sub	a5,a3,a4
80002470:	00879713          	sll	a4,a5,0x8
80002474:	f00750e3          	bgez	a4,80002374 <__subdf3+0x2b4>
80002478:	00800437          	lui	s0,0x800
8000247c:	fff40413          	add	s0,s0,-1 # 7fffff <__stack_size+0x7fbfff>
80002480:	0087f433          	and	s0,a5,s0
80002484:	00050993          	mv	s3,a0
80002488:	2100006f          	j	80002698 <__subdf3+0x5d8>
8000248c:	7ff00693          	li	a3,2047
80002490:	eed902e3          	beq	s2,a3,80002374 <__subdf3+0x2b4>
80002494:	008006b7          	lui	a3,0x800
80002498:	00d76733          	or	a4,a4,a3
8000249c:	00080693          	mv	a3,a6
800024a0:	f89ff06f          	j	80002428 <__subdf3+0x368>
800024a4:	fe068593          	add	a1,a3,-32 # 7fffe0 <__stack_size+0x7fbfe0>
800024a8:	02000893          	li	a7,32
800024ac:	00b755b3          	srl	a1,a4,a1
800024b0:	00000813          	li	a6,0
800024b4:	01168863          	beq	a3,a7,800024c4 <__subdf3+0x404>
800024b8:	04000813          	li	a6,64
800024bc:	40d80833          	sub	a6,a6,a3
800024c0:	01071833          	sll	a6,a4,a6
800024c4:	00c86833          	or	a6,a6,a2
800024c8:	01003833          	snez	a6,a6
800024cc:	0105e633          	or	a2,a1,a6
800024d0:	00000693          	li	a3,0
800024d4:	f89ff06f          	j	8000245c <__subdf3+0x39c>
800024d8:	00c76633          	or	a2,a4,a2
800024dc:	00c03633          	snez	a2,a2
800024e0:	ff1ff06f          	j	800024d0 <__subdf3+0x410>
800024e4:	0e080863          	beqz	a6,800025d4 <__subdf3+0x514>
800024e8:	41288833          	sub	a6,a7,s2
800024ec:	04091263          	bnez	s2,80002530 <__subdf3+0x470>
800024f0:	00a7e5b3          	or	a1,a5,a0
800024f4:	2a058e63          	beqz	a1,800027b0 <__subdf3+0x6f0>
800024f8:	fff80593          	add	a1,a6,-1
800024fc:	00059e63          	bnez	a1,80002518 <__subdf3+0x458>
80002500:	40a60533          	sub	a0,a2,a0
80002504:	40f70733          	sub	a4,a4,a5
80002508:	00a63633          	sltu	a2,a2,a0
8000250c:	40c707b3          	sub	a5,a4,a2
80002510:	00068493          	mv	s1,a3
80002514:	f05ff06f          	j	80002418 <__subdf3+0x358>
80002518:	7ff00313          	li	t1,2047
8000251c:	02681463          	bne	a6,t1,80002544 <__subdf3+0x484>
80002520:	00070793          	mv	a5,a4
80002524:	00060513          	mv	a0,a2
80002528:	7ff00913          	li	s2,2047
8000252c:	0d00006f          	j	800025fc <__subdf3+0x53c>
80002530:	7ff00593          	li	a1,2047
80002534:	feb886e3          	beq	a7,a1,80002520 <__subdf3+0x460>
80002538:	008005b7          	lui	a1,0x800
8000253c:	00b7e7b3          	or	a5,a5,a1
80002540:	00080593          	mv	a1,a6
80002544:	03800813          	li	a6,56
80002548:	08b84063          	blt	a6,a1,800025c8 <__subdf3+0x508>
8000254c:	01f00813          	li	a6,31
80002550:	04b84263          	blt	a6,a1,80002594 <__subdf3+0x4d4>
80002554:	02000313          	li	t1,32
80002558:	40b30333          	sub	t1,t1,a1
8000255c:	00b55e33          	srl	t3,a0,a1
80002560:	00679833          	sll	a6,a5,t1
80002564:	00651333          	sll	t1,a0,t1
80002568:	01c86833          	or	a6,a6,t3
8000256c:	00603333          	snez	t1,t1
80002570:	00686533          	or	a0,a6,t1
80002574:	00b7d5b3          	srl	a1,a5,a1
80002578:	40a60533          	sub	a0,a2,a0
8000257c:	40b705b3          	sub	a1,a4,a1
80002580:	00a63633          	sltu	a2,a2,a0
80002584:	40c587b3          	sub	a5,a1,a2
80002588:	00088913          	mv	s2,a7
8000258c:	00068493          	mv	s1,a3
80002590:	ee1ff06f          	j	80002470 <__subdf3+0x3b0>
80002594:	fe058813          	add	a6,a1,-32 # 7fffe0 <__stack_size+0x7fbfe0>
80002598:	02000e13          	li	t3,32
8000259c:	0107d833          	srl	a6,a5,a6
800025a0:	00000313          	li	t1,0
800025a4:	01c58863          	beq	a1,t3,800025b4 <__subdf3+0x4f4>
800025a8:	04000313          	li	t1,64
800025ac:	40b30333          	sub	t1,t1,a1
800025b0:	00679333          	sll	t1,a5,t1
800025b4:	00a36333          	or	t1,t1,a0
800025b8:	00603333          	snez	t1,t1
800025bc:	00686533          	or	a0,a6,t1
800025c0:	00000593          	li	a1,0
800025c4:	fb5ff06f          	j	80002578 <__subdf3+0x4b8>
800025c8:	00a7e533          	or	a0,a5,a0
800025cc:	00a03533          	snez	a0,a0
800025d0:	ff1ff06f          	j	800025c0 <__subdf3+0x500>
800025d4:	00190593          	add	a1,s2,1
800025d8:	7fe5f593          	and	a1,a1,2046
800025dc:	08059663          	bnez	a1,80002668 <__subdf3+0x5a8>
800025e0:	00c765b3          	or	a1,a4,a2
800025e4:	00a7e833          	or	a6,a5,a0
800025e8:	06091063          	bnez	s2,80002648 <__subdf3+0x588>
800025ec:	00081c63          	bnez	a6,80002604 <__subdf3+0x544>
800025f0:	10058e63          	beqz	a1,8000270c <__subdf3+0x64c>
800025f4:	00070793          	mv	a5,a4
800025f8:	00060513          	mv	a0,a2
800025fc:	00068493          	mv	s1,a3
80002600:	d75ff06f          	j	80002374 <__subdf3+0x2b4>
80002604:	d60588e3          	beqz	a1,80002374 <__subdf3+0x2b4>
80002608:	40c50833          	sub	a6,a0,a2
8000260c:	010538b3          	sltu	a7,a0,a6
80002610:	40e785b3          	sub	a1,a5,a4
80002614:	411585b3          	sub	a1,a1,a7
80002618:	00859893          	sll	a7,a1,0x8
8000261c:	0008dc63          	bgez	a7,80002634 <__subdf3+0x574>
80002620:	40a60533          	sub	a0,a2,a0
80002624:	40f70733          	sub	a4,a4,a5
80002628:	00a63633          	sltu	a2,a2,a0
8000262c:	40c707b3          	sub	a5,a4,a2
80002630:	fcdff06f          	j	800025fc <__subdf3+0x53c>
80002634:	00b86533          	or	a0,a6,a1
80002638:	18050463          	beqz	a0,800027c0 <__subdf3+0x700>
8000263c:	00058793          	mv	a5,a1
80002640:	00080513          	mv	a0,a6
80002644:	d31ff06f          	j	80002374 <__subdf3+0x2b4>
80002648:	00081c63          	bnez	a6,80002660 <__subdf3+0x5a0>
8000264c:	d4058ee3          	beqz	a1,800023a8 <__subdf3+0x2e8>
80002650:	00070793          	mv	a5,a4
80002654:	00060513          	mv	a0,a2
80002658:	00068493          	mv	s1,a3
8000265c:	b1dff06f          	j	80002178 <__subdf3+0xb8>
80002660:	b0058ce3          	beqz	a1,80002178 <__subdf3+0xb8>
80002664:	d45ff06f          	j	800023a8 <__subdf3+0x2e8>
80002668:	40c505b3          	sub	a1,a0,a2
8000266c:	00b53833          	sltu	a6,a0,a1
80002670:	40e78433          	sub	s0,a5,a4
80002674:	41040433          	sub	s0,s0,a6
80002678:	00841813          	sll	a6,s0,0x8
8000267c:	00058993          	mv	s3,a1
80002680:	08085063          	bgez	a6,80002700 <__subdf3+0x640>
80002684:	40a609b3          	sub	s3,a2,a0
80002688:	40f70433          	sub	s0,a4,a5
8000268c:	01363633          	sltu	a2,a2,s3
80002690:	40c40433          	sub	s0,s0,a2
80002694:	00068493          	mv	s1,a3
80002698:	06040e63          	beqz	s0,80002714 <__subdf3+0x654>
8000269c:	00040513          	mv	a0,s0
800026a0:	6e4000ef          	jal	80002d84 <__clzsi2>
800026a4:	ff850693          	add	a3,a0,-8
800026a8:	02000793          	li	a5,32
800026ac:	40d787b3          	sub	a5,a5,a3
800026b0:	00d41433          	sll	s0,s0,a3
800026b4:	00f9d7b3          	srl	a5,s3,a5
800026b8:	0087e7b3          	or	a5,a5,s0
800026bc:	00d99433          	sll	s0,s3,a3
800026c0:	0b26c463          	blt	a3,s2,80002768 <__subdf3+0x6a8>
800026c4:	412686b3          	sub	a3,a3,s2
800026c8:	00168613          	add	a2,a3,1
800026cc:	01f00713          	li	a4,31
800026d0:	06c74263          	blt	a4,a2,80002734 <__subdf3+0x674>
800026d4:	02000713          	li	a4,32
800026d8:	40c70733          	sub	a4,a4,a2
800026dc:	00e79533          	sll	a0,a5,a4
800026e0:	00c456b3          	srl	a3,s0,a2
800026e4:	00e41733          	sll	a4,s0,a4
800026e8:	00d56533          	or	a0,a0,a3
800026ec:	00e03733          	snez	a4,a4
800026f0:	00e56533          	or	a0,a0,a4
800026f4:	00c7d7b3          	srl	a5,a5,a2
800026f8:	00000913          	li	s2,0
800026fc:	c79ff06f          	j	80002374 <__subdf3+0x2b4>
80002700:	0085e5b3          	or	a1,a1,s0
80002704:	f8059ae3          	bnez	a1,80002698 <__subdf3+0x5d8>
80002708:	00000913          	li	s2,0
8000270c:	00000493          	li	s1,0
80002710:	08c0006f          	j	8000279c <__subdf3+0x6dc>
80002714:	00098513          	mv	a0,s3
80002718:	66c000ef          	jal	80002d84 <__clzsi2>
8000271c:	01850693          	add	a3,a0,24
80002720:	01f00793          	li	a5,31
80002724:	f8d7d2e3          	bge	a5,a3,800026a8 <__subdf3+0x5e8>
80002728:	ff850793          	add	a5,a0,-8
8000272c:	00f997b3          	sll	a5,s3,a5
80002730:	f91ff06f          	j	800026c0 <__subdf3+0x600>
80002734:	fe168693          	add	a3,a3,-31
80002738:	00d7d533          	srl	a0,a5,a3
8000273c:	02000693          	li	a3,32
80002740:	00000713          	li	a4,0
80002744:	00d60863          	beq	a2,a3,80002754 <__subdf3+0x694>
80002748:	04000713          	li	a4,64
8000274c:	40c70733          	sub	a4,a4,a2
80002750:	00e79733          	sll	a4,a5,a4
80002754:	00e46733          	or	a4,s0,a4
80002758:	00e03733          	snez	a4,a4
8000275c:	00e56533          	or	a0,a0,a4
80002760:	00000793          	li	a5,0
80002764:	f95ff06f          	j	800026f8 <__subdf3+0x638>
80002768:	ff800737          	lui	a4,0xff800
8000276c:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
80002770:	40d90933          	sub	s2,s2,a3
80002774:	00e7f7b3          	and	a5,a5,a4
80002778:	00040513          	mv	a0,s0
8000277c:	bf9ff06f          	j	80002374 <__subdf3+0x2b4>
80002780:	00070793          	mv	a5,a4
80002784:	00060513          	mv	a0,a2
80002788:	c5dff06f          	j	800023e4 <__subdf3+0x324>
8000278c:	00070793          	mv	a5,a4
80002790:	00060513          	mv	a0,a2
80002794:	be1ff06f          	j	80002374 <__subdf3+0x2b4>
80002798:	7ff00913          	li	s2,2047
8000279c:	00000793          	li	a5,0
800027a0:	00000513          	li	a0,0
800027a4:	0240006f          	j	800027c8 <__subdf3+0x708>
800027a8:	00080913          	mv	s2,a6
800027ac:	bc9ff06f          	j	80002374 <__subdf3+0x2b4>
800027b0:	00070793          	mv	a5,a4
800027b4:	00060513          	mv	a0,a2
800027b8:	00080913          	mv	s2,a6
800027bc:	e41ff06f          	j	800025fc <__subdf3+0x53c>
800027c0:	00000793          	li	a5,0
800027c4:	00000493          	li	s1,0
  FP_PACK_SEMIRAW_D (r, R);
800027c8:	00879713          	sll	a4,a5,0x8
800027cc:	00075e63          	bgez	a4,800027e8 <__subdf3+0x728>
800027d0:	00190913          	add	s2,s2,1
800027d4:	7ff00713          	li	a4,2047
800027d8:	08e90263          	beq	s2,a4,8000285c <__subdf3+0x79c>
800027dc:	ff800737          	lui	a4,0xff800
800027e0:	fff70713          	add	a4,a4,-1 # ff7fffff <__stack_base+0x5f7effff>
800027e4:	00e7f7b3          	and	a5,a5,a4
800027e8:	01d79693          	sll	a3,a5,0x1d
800027ec:	00355513          	srl	a0,a0,0x3
800027f0:	7ff00713          	li	a4,2047
800027f4:	00a6e6b3          	or	a3,a3,a0
800027f8:	0037d793          	srl	a5,a5,0x3
800027fc:	00e91e63          	bne	s2,a4,80002818 <__subdf3+0x758>
80002800:	00f6e6b3          	or	a3,a3,a5
80002804:	00000793          	li	a5,0
80002808:	00068863          	beqz	a3,80002818 <__subdf3+0x758>
8000280c:	000807b7          	lui	a5,0x80
80002810:	00000693          	li	a3,0
80002814:	00000493          	li	s1,0
80002818:	01491713          	sll	a4,s2,0x14
8000281c:	7ff00637          	lui	a2,0x7ff00
80002820:	00c79793          	sll	a5,a5,0xc
80002824:	00c77733          	and	a4,a4,a2
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80002828:	01c12083          	lw	ra,28(sp)
8000282c:	01812403          	lw	s0,24(sp)
  FP_PACK_SEMIRAW_D (r, R);
80002830:	00c7d793          	srl	a5,a5,0xc
80002834:	00f767b3          	or	a5,a4,a5
80002838:	01f49713          	sll	a4,s1,0x1f
8000283c:	00e7e633          	or	a2,a5,a4
}
80002840:	01412483          	lw	s1,20(sp)
80002844:	01012903          	lw	s2,16(sp)
80002848:	00c12983          	lw	s3,12(sp)
8000284c:	00068513          	mv	a0,a3
80002850:	00060593          	mv	a1,a2
80002854:	02010113          	add	sp,sp,32
80002858:	00008067          	ret
8000285c:	00000793          	li	a5,0
80002860:	00000513          	li	a0,0
80002864:	f85ff06f          	j	800027e8 <__subdf3+0x728>

80002868 <__fixdfsi>:
  FP_DECL_EX;
  FP_DECL_D (A);
  USItype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
80002868:	0145d713          	srl	a4,a1,0x14
8000286c:	001006b7          	lui	a3,0x100
80002870:	fff68793          	add	a5,a3,-1 # fffff <__stack_size+0xfbfff>
80002874:	7ff77713          	and	a4,a4,2047
  FP_TO_INT_D (r, A, SI_BITS, 1);
80002878:	3fe00613          	li	a2,1022
  FP_UNPACK_RAW_D (A, a);
8000287c:	00b7f7b3          	and	a5,a5,a1
80002880:	01f5d593          	srl	a1,a1,0x1f
  FP_TO_INT_D (r, A, SI_BITS, 1);
80002884:	04e65e63          	bge	a2,a4,800028e0 <__fixdfsi+0x78>
80002888:	41d00613          	li	a2,1053
8000288c:	00e65a63          	bge	a2,a4,800028a0 <__fixdfsi+0x38>
80002890:	80000537          	lui	a0,0x80000
80002894:	fff50513          	add	a0,a0,-1 # 7fffffff <__stack_size+0x7fffbfff>
80002898:	00a58533          	add	a0,a1,a0
8000289c:	00008067          	ret
800028a0:	00d7e7b3          	or	a5,a5,a3
800028a4:	43300693          	li	a3,1075
800028a8:	40e686b3          	sub	a3,a3,a4
800028ac:	01f00613          	li	a2,31
800028b0:	02d64063          	blt	a2,a3,800028d0 <__fixdfsi+0x68>
800028b4:	bed70713          	add	a4,a4,-1043
800028b8:	00e797b3          	sll	a5,a5,a4
800028bc:	00d55533          	srl	a0,a0,a3
800028c0:	00a7e533          	or	a0,a5,a0
800028c4:	02058063          	beqz	a1,800028e4 <__fixdfsi+0x7c>
800028c8:	40a00533          	neg	a0,a0
800028cc:	00008067          	ret
800028d0:	41300693          	li	a3,1043
800028d4:	40e68733          	sub	a4,a3,a4
800028d8:	00e7d533          	srl	a0,a5,a4
800028dc:	fe9ff06f          	j	800028c4 <__fixdfsi+0x5c>
800028e0:	00000513          	li	a0,0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
800028e4:	00008067          	ret

800028e8 <__fixunsdfsi>:
  FP_DECL_EX;
  FP_DECL_D (A);
  USItype r;

  FP_INIT_EXCEPTIONS;
  FP_UNPACK_RAW_D (A, a);
800028e8:	0145d713          	srl	a4,a1,0x14
800028ec:	00100837          	lui	a6,0x100
800028f0:	fff80793          	add	a5,a6,-1 # fffff <__stack_size+0xfbfff>
800028f4:	7ff77713          	and	a4,a4,2047
  FP_TO_INT_D (r, A, SI_BITS, 0);
800028f8:	3fe00613          	li	a2,1022
  FP_UNPACK_RAW_D (A, a);
800028fc:	00b7f7b3          	and	a5,a5,a1
{
80002900:	00050693          	mv	a3,a0
  FP_UNPACK_RAW_D (A, a);
80002904:	01f5d593          	srl	a1,a1,0x1f
  FP_TO_INT_D (r, A, SI_BITS, 0);
80002908:	04e65a63          	bge	a2,a4,8000295c <__fixunsdfsi+0x74>
8000290c:	0015c613          	xor	a2,a1,1
80002910:	41e60613          	add	a2,a2,1054 # 7ff0041e <__stack_size+0x7fefc41e>
80002914:	fff58513          	add	a0,a1,-1
80002918:	04c75463          	bge	a4,a2,80002960 <__fixunsdfsi+0x78>
8000291c:	00000513          	li	a0,0
80002920:	04059063          	bnez	a1,80002960 <__fixunsdfsi+0x78>
80002924:	43300613          	li	a2,1075
80002928:	40e60633          	sub	a2,a2,a4
8000292c:	01f00593          	li	a1,31
80002930:	0107e7b3          	or	a5,a5,a6
80002934:	00c5cc63          	blt	a1,a2,8000294c <__fixunsdfsi+0x64>
80002938:	bed70713          	add	a4,a4,-1043
8000293c:	00e797b3          	sll	a5,a5,a4
80002940:	00c6d533          	srl	a0,a3,a2
80002944:	00a7e533          	or	a0,a5,a0
80002948:	00008067          	ret
8000294c:	41300693          	li	a3,1043
80002950:	40e68733          	sub	a4,a3,a4
80002954:	00e7d533          	srl	a0,a5,a4
80002958:	00008067          	ret
8000295c:	00000513          	li	a0,0
  FP_HANDLE_EXCEPTIONS;

  return r;
}
80002960:	00008067          	ret

80002964 <__floatsidf>:
#include "soft-fp.h"
#include "double.h"

DFtype
__floatsidf (SItype i)
{
80002964:	ff010113          	add	sp,sp,-16
80002968:	00112623          	sw	ra,12(sp)
8000296c:	00812423          	sw	s0,8(sp)
80002970:	00912223          	sw	s1,4(sp)
  FP_DECL_D (A);
  DFtype a;

  FP_FROM_INT_D (A, i, SI_BITS, USItype);
80002974:	08050663          	beqz	a0,80002a00 <__floatsidf+0x9c>
80002978:	41f55793          	sra	a5,a0,0x1f
8000297c:	00a7c433          	xor	s0,a5,a0
80002980:	40f40433          	sub	s0,s0,a5
80002984:	01f55493          	srl	s1,a0,0x1f
80002988:	00040513          	mv	a0,s0
8000298c:	3f8000ef          	jal	80002d84 <__clzsi2>
80002990:	41e00713          	li	a4,1054
80002994:	00a00793          	li	a5,10
80002998:	40a70733          	sub	a4,a4,a0
8000299c:	04a7c863          	blt	a5,a0,800029ec <__floatsidf+0x88>
800029a0:	00b00793          	li	a5,11
800029a4:	40a787b3          	sub	a5,a5,a0
800029a8:	01550513          	add	a0,a0,21
800029ac:	00f457b3          	srl	a5,s0,a5
800029b0:	00a41433          	sll	s0,s0,a0
800029b4:	00048513          	mv	a0,s1
  FP_PACK_RAW_D (a, A);
800029b8:	00c79793          	sll	a5,a5,0xc
800029bc:	00c7d793          	srl	a5,a5,0xc
800029c0:	01471713          	sll	a4,a4,0x14
800029c4:	01f51513          	sll	a0,a0,0x1f
800029c8:	00f76733          	or	a4,a4,a5

  return a;
}
800029cc:	00c12083          	lw	ra,12(sp)
  FP_PACK_RAW_D (a, A);
800029d0:	00a767b3          	or	a5,a4,a0
}
800029d4:	00040513          	mv	a0,s0
800029d8:	00812403          	lw	s0,8(sp)
800029dc:	00412483          	lw	s1,4(sp)
800029e0:	00078593          	mv	a1,a5
800029e4:	01010113          	add	sp,sp,16
800029e8:	00008067          	ret
  FP_FROM_INT_D (A, i, SI_BITS, USItype);
800029ec:	ff550513          	add	a0,a0,-11
800029f0:	00a417b3          	sll	a5,s0,a0
800029f4:	00048513          	mv	a0,s1
800029f8:	00000413          	li	s0,0
800029fc:	fbdff06f          	j	800029b8 <__floatsidf+0x54>
80002a00:	00000713          	li	a4,0
80002a04:	00000793          	li	a5,0
80002a08:	ff1ff06f          	j	800029f8 <__floatsidf+0x94>

80002a0c <__floatunsidf>:
#include "soft-fp.h"
#include "double.h"

DFtype
__floatunsidf (USItype i)
{
80002a0c:	ff010113          	add	sp,sp,-16
80002a10:	00812423          	sw	s0,8(sp)
80002a14:	00112623          	sw	ra,12(sp)
80002a18:	00050413          	mv	s0,a0
  FP_DECL_D (A);
  DFtype a;

  FP_FROM_INT_D (A, i, SI_BITS, USItype);
80002a1c:	06050263          	beqz	a0,80002a80 <__floatunsidf+0x74>
80002a20:	364000ef          	jal	80002d84 <__clzsi2>
80002a24:	41e00713          	li	a4,1054
80002a28:	00a00793          	li	a5,10
80002a2c:	40a70733          	sub	a4,a4,a0
80002a30:	04a7c063          	blt	a5,a0,80002a70 <__floatunsidf+0x64>
80002a34:	00b00793          	li	a5,11
80002a38:	40a787b3          	sub	a5,a5,a0
80002a3c:	01550513          	add	a0,a0,21
80002a40:	00f457b3          	srl	a5,s0,a5
80002a44:	00a41433          	sll	s0,s0,a0
  FP_PACK_RAW_D (a, A);

  return a;
}
80002a48:	00c12083          	lw	ra,12(sp)
80002a4c:	00040513          	mv	a0,s0
  FP_PACK_RAW_D (a, A);
80002a50:	00c79793          	sll	a5,a5,0xc
}
80002a54:	00812403          	lw	s0,8(sp)
  FP_PACK_RAW_D (a, A);
80002a58:	01471713          	sll	a4,a4,0x14
80002a5c:	00c7d793          	srl	a5,a5,0xc
80002a60:	00f766b3          	or	a3,a4,a5
}
80002a64:	00068593          	mv	a1,a3
80002a68:	01010113          	add	sp,sp,16
80002a6c:	00008067          	ret
  FP_FROM_INT_D (A, i, SI_BITS, USItype);
80002a70:	ff550513          	add	a0,a0,-11
80002a74:	00a417b3          	sll	a5,s0,a0
80002a78:	00000413          	li	s0,0
80002a7c:	fcdff06f          	j	80002a48 <__floatunsidf+0x3c>
80002a80:	00000793          	li	a5,0
80002a84:	00000713          	li	a4,0
80002a88:	fc1ff06f          	j	80002a48 <__floatunsidf+0x3c>

80002a8c <__floatundidf>:
#include "soft-fp.h"
#include "double.h"

DFtype
__floatundidf (UDItype i)
{
80002a8c:	fe010113          	add	sp,sp,-32
80002a90:	00112e23          	sw	ra,28(sp)
80002a94:	00812c23          	sw	s0,24(sp)
80002a98:	00912a23          	sw	s1,20(sp)
80002a9c:	01212823          	sw	s2,16(sp)
80002aa0:	01312623          	sw	s3,12(sp)
80002aa4:	01412423          	sw	s4,8(sp)
  FP_DECL_EX;
  FP_DECL_D (A);
  DFtype a;

  FP_INIT_ROUNDMODE;
  FP_FROM_INT_D (A, i, DI_BITS, UDItype);
80002aa8:	00b567b3          	or	a5,a0,a1
80002aac:	16078c63          	beqz	a5,80002c24 <__floatundidf+0x198>
80002ab0:	00050493          	mv	s1,a0
80002ab4:	00058913          	mv	s2,a1
80002ab8:	00058413          	mv	s0,a1
80002abc:	08058463          	beqz	a1,80002b44 <__floatundidf+0xb8>
80002ac0:	00058513          	mv	a0,a1
80002ac4:	2c0000ef          	jal	80002d84 <__clzsi2>
80002ac8:	00050993          	mv	s3,a0
80002acc:	43e00a13          	li	s4,1086
80002ad0:	413a0a33          	sub	s4,s4,s3
80002ad4:	43300793          	li	a5,1075
80002ad8:	0947c463          	blt	a5,s4,80002b60 <__floatundidf+0xd4>
80002adc:	00b00793          	li	a5,11
80002ae0:	00048713          	mv	a4,s1
80002ae4:	14f98863          	beq	s3,a5,80002c34 <__floatundidf+0x1a8>
80002ae8:	02a00793          	li	a5,42
80002aec:	0737c263          	blt	a5,s3,80002b50 <__floatundidf+0xc4>
80002af0:	02b00413          	li	s0,43
80002af4:	ff598793          	add	a5,s3,-11
80002af8:	41340433          	sub	s0,s0,s3
80002afc:	0084d433          	srl	s0,s1,s0
80002b00:	00f91933          	sll	s2,s2,a5
80002b04:	01246433          	or	s0,s0,s2
80002b08:	00f49733          	sll	a4,s1,a5
  FP_PACK_RAW_D (a, A);
  FP_HANDLE_EXCEPTIONS;

  return a;
}
80002b0c:	01c12083          	lw	ra,28(sp)
  FP_PACK_RAW_D (a, A);
80002b10:	00c41593          	sll	a1,s0,0xc
}
80002b14:	01812403          	lw	s0,24(sp)
  FP_PACK_RAW_D (a, A);
80002b18:	014a1a13          	sll	s4,s4,0x14
80002b1c:	00c5d593          	srl	a1,a1,0xc
80002b20:	00ba67b3          	or	a5,s4,a1
}
80002b24:	01412483          	lw	s1,20(sp)
80002b28:	01012903          	lw	s2,16(sp)
80002b2c:	00c12983          	lw	s3,12(sp)
80002b30:	00812a03          	lw	s4,8(sp)
80002b34:	00070513          	mv	a0,a4
80002b38:	00078593          	mv	a1,a5
80002b3c:	02010113          	add	sp,sp,32
80002b40:	00008067          	ret
  FP_FROM_INT_D (A, i, DI_BITS, UDItype);
80002b44:	240000ef          	jal	80002d84 <__clzsi2>
80002b48:	02050993          	add	s3,a0,32
80002b4c:	f81ff06f          	j	80002acc <__floatundidf+0x40>
80002b50:	fd598593          	add	a1,s3,-43
80002b54:	00b49433          	sll	s0,s1,a1
80002b58:	00000713          	li	a4,0
80002b5c:	fb1ff06f          	j	80002b0c <__floatundidf+0x80>
80002b60:	43600793          	li	a5,1078
80002b64:	0347dc63          	bge	a5,s4,80002b9c <__floatundidf+0x110>
80002b68:	03898613          	add	a2,s3,56
80002b6c:	00048513          	mv	a0,s1
80002b70:	00090593          	mv	a1,s2
80002b74:	1d8000ef          	jal	80002d4c <__ashldi3>
80002b78:	00b56533          	or	a0,a0,a1
80002b7c:	00800613          	li	a2,8
80002b80:	00a03433          	snez	s0,a0
80002b84:	00090593          	mv	a1,s2
80002b88:	00048513          	mv	a0,s1
80002b8c:	41360633          	sub	a2,a2,s3
80002b90:	184000ef          	jal	80002d14 <__lshrdi3>
80002b94:	00a464b3          	or	s1,s0,a0
80002b98:	00058913          	mv	s2,a1
80002b9c:	00800793          	li	a5,8
80002ba0:	00048713          	mv	a4,s1
80002ba4:	0337d063          	bge	a5,s3,80002bc4 <__floatundidf+0x138>
80002ba8:	02800793          	li	a5,40
80002bac:	ff898693          	add	a3,s3,-8
80002bb0:	413787b3          	sub	a5,a5,s3
80002bb4:	00d91933          	sll	s2,s2,a3
80002bb8:	00f4d7b3          	srl	a5,s1,a5
80002bbc:	0127e933          	or	s2,a5,s2
80002bc0:	00d49733          	sll	a4,s1,a3
80002bc4:	ff8007b7          	lui	a5,0xff800
80002bc8:	fff78793          	add	a5,a5,-1 # ff7fffff <__stack_base+0x5f7effff>
80002bcc:	00f975b3          	and	a1,s2,a5
80002bd0:	00777793          	and	a5,a4,7
80002bd4:	02078063          	beqz	a5,80002bf4 <__floatundidf+0x168>
80002bd8:	00f77793          	and	a5,a4,15
80002bdc:	00400693          	li	a3,4
80002be0:	00d78a63          	beq	a5,a3,80002bf4 <__floatundidf+0x168>
80002be4:	00470793          	add	a5,a4,4
80002be8:	00e7b6b3          	sltu	a3,a5,a4
80002bec:	00d585b3          	add	a1,a1,a3
80002bf0:	00078713          	mv	a4,a5
80002bf4:	00859793          	sll	a5,a1,0x8
80002bf8:	0007dc63          	bgez	a5,80002c10 <__floatundidf+0x184>
80002bfc:	ff8007b7          	lui	a5,0xff800
80002c00:	fff78793          	add	a5,a5,-1 # ff7fffff <__stack_base+0x5f7effff>
80002c04:	43f00a13          	li	s4,1087
80002c08:	00f5f5b3          	and	a1,a1,a5
80002c0c:	413a0a33          	sub	s4,s4,s3
80002c10:	00375713          	srl	a4,a4,0x3
80002c14:	01d59793          	sll	a5,a1,0x1d
80002c18:	00e7e733          	or	a4,a5,a4
80002c1c:	0035d413          	srl	s0,a1,0x3
80002c20:	eedff06f          	j	80002b0c <__floatundidf+0x80>
80002c24:	00000413          	li	s0,0
80002c28:	00000713          	li	a4,0
80002c2c:	00000a13          	li	s4,0
80002c30:	eddff06f          	j	80002b0c <__floatundidf+0x80>
80002c34:	43300a13          	li	s4,1075
80002c38:	ed5ff06f          	j	80002b0c <__floatundidf+0x80>

80002c3c <__mulsi3>:
/* Our RV64 64-bit routine is equivalent to our RV32 32-bit routine.  */
# define __muldi3 __mulsi3
#endif

FUNC_BEGIN (__muldi3)
  mv     a2, a0
80002c3c:	00050613          	mv	a2,a0
  li     a0, 0
80002c40:	00000513          	li	a0,0
.L1:
  andi   a3, a1, 1
80002c44:	0015f693          	and	a3,a1,1
  beqz   a3, .L2
80002c48:	00068463          	beqz	a3,80002c50 <__mulsi3+0x14>
  add    a0, a0, a2
80002c4c:	00c50533          	add	a0,a0,a2
.L2:
  srli   a1, a1, 1
80002c50:	0015d593          	srl	a1,a1,0x1
  slli   a2, a2, 1
80002c54:	00161613          	sll	a2,a2,0x1
  bnez   a1, .L1
80002c58:	fe0596e3          	bnez	a1,80002c44 <__mulsi3+0x8>
  ret
80002c5c:	00008067          	ret

80002c60 <__divsi3>:
  li    t0, -1
  beq   a1, t0, .L20
#endif

FUNC_BEGIN (__divdi3)
  bltz  a0, .L10
80002c60:	06054063          	bltz	a0,80002cc0 <__umodsi3+0x10>
  bltz  a1, .L11
80002c64:	0605c663          	bltz	a1,80002cd0 <__umodsi3+0x20>

80002c68 <__hidden___udivsi3>:
  /* Since the quotient is positive, fall into __udivdi3.  */

FUNC_BEGIN (__udivdi3)
  mv    a2, a1
80002c68:	00058613          	mv	a2,a1
  mv    a1, a0
80002c6c:	00050593          	mv	a1,a0
  li    a0, -1
80002c70:	fff00513          	li	a0,-1
  beqz  a2, .L5
80002c74:	02060c63          	beqz	a2,80002cac <__hidden___udivsi3+0x44>
  li    a3, 1
80002c78:	00100693          	li	a3,1
  bgeu  a2, a1, .L2
80002c7c:	00b67a63          	bgeu	a2,a1,80002c90 <__hidden___udivsi3+0x28>
.L1:
  blez  a2, .L2
80002c80:	00c05863          	blez	a2,80002c90 <__hidden___udivsi3+0x28>
  slli  a2, a2, 1
80002c84:	00161613          	sll	a2,a2,0x1
  slli  a3, a3, 1
80002c88:	00169693          	sll	a3,a3,0x1
  bgtu  a1, a2, .L1
80002c8c:	feb66ae3          	bltu	a2,a1,80002c80 <__hidden___udivsi3+0x18>
.L2:
  li    a0, 0
80002c90:	00000513          	li	a0,0
.L3:
  bltu  a1, a2, .L4
80002c94:	00c5e663          	bltu	a1,a2,80002ca0 <__hidden___udivsi3+0x38>
  sub   a1, a1, a2
80002c98:	40c585b3          	sub	a1,a1,a2
  or    a0, a0, a3
80002c9c:	00d56533          	or	a0,a0,a3
.L4:
  srli  a3, a3, 1
80002ca0:	0016d693          	srl	a3,a3,0x1
  srli  a2, a2, 1
80002ca4:	00165613          	srl	a2,a2,0x1
  bnez  a3, .L3
80002ca8:	fe0696e3          	bnez	a3,80002c94 <__hidden___udivsi3+0x2c>
.L5:
  ret
80002cac:	00008067          	ret

80002cb0 <__umodsi3>:
FUNC_END (__udivdi3)
HIDDEN_DEF (__udivdi3)

FUNC_BEGIN (__umoddi3)
  /* Call __udivdi3(a0, a1), then return the remainder, which is in a1.  */
  move  t0, ra
80002cb0:	00008293          	mv	t0,ra
  jal   HIDDEN_JUMPTARGET(__udivdi3)
80002cb4:	fb5ff0ef          	jal	80002c68 <__hidden___udivsi3>
  move  a0, a1
80002cb8:	00058513          	mv	a0,a1
  jr    t0
80002cbc:	00028067          	jr	t0
FUNC_END (__umoddi3)

  /* Handle negative arguments to __divdi3.  */
.L10:
  neg   a0, a0
80002cc0:	40a00533          	neg	a0,a0
  /* Zero is handled as a negative so that the result will not be inverted.  */
  bgtz  a1, .L12     /* Compute __udivdi3(-a0, a1), then negate the result.  */
80002cc4:	00b04863          	bgtz	a1,80002cd4 <__umodsi3+0x24>

  neg   a1, a1
80002cc8:	40b005b3          	neg	a1,a1
  j     HIDDEN_JUMPTARGET(__udivdi3)     /* Compute __udivdi3(-a0, -a1).  */
80002ccc:	f9dff06f          	j	80002c68 <__hidden___udivsi3>
.L11:                /* Compute __udivdi3(a0, -a1), then negate the result.  */
  neg   a1, a1
80002cd0:	40b005b3          	neg	a1,a1
.L12:
  move  t0, ra
80002cd4:	00008293          	mv	t0,ra
  jal   HIDDEN_JUMPTARGET(__udivdi3)
80002cd8:	f91ff0ef          	jal	80002c68 <__hidden___udivsi3>
  neg   a0, a0
80002cdc:	40a00533          	neg	a0,a0
  jr    t0
80002ce0:	00028067          	jr	t0

80002ce4 <__modsi3>:
FUNC_END (__divdi3)

FUNC_BEGIN (__moddi3)
  move   t0, ra
80002ce4:	00008293          	mv	t0,ra
  bltz   a1, .L31
80002ce8:	0005ca63          	bltz	a1,80002cfc <__modsi3+0x18>
  bltz   a0, .L32
80002cec:	00054c63          	bltz	a0,80002d04 <__modsi3+0x20>
.L30:
  jal    HIDDEN_JUMPTARGET(__udivdi3)    /* The dividend is not negative.  */
80002cf0:	f79ff0ef          	jal	80002c68 <__hidden___udivsi3>
  move   a0, a1
80002cf4:	00058513          	mv	a0,a1
  jr     t0
80002cf8:	00028067          	jr	t0
.L31:
  neg    a1, a1
80002cfc:	40b005b3          	neg	a1,a1
  bgez   a0, .L30
80002d00:	fe0558e3          	bgez	a0,80002cf0 <__modsi3+0xc>
.L32:
  neg    a0, a0
80002d04:	40a00533          	neg	a0,a0
  jal    HIDDEN_JUMPTARGET(__udivdi3)    /* The dividend is hella negative.  */
80002d08:	f61ff0ef          	jal	80002c68 <__hidden___udivsi3>
  neg    a0, a1
80002d0c:	40b00533          	neg	a0,a1
  jr     t0
80002d10:	00028067          	jr	t0

80002d14 <__lshrdi3>:
  if (b == 0)
80002d14:	02060063          	beqz	a2,80002d34 <__lshrdi3+0x20>
  const shift_count_type bm = W_TYPE_SIZE - b;
80002d18:	02000793          	li	a5,32
80002d1c:	40c787b3          	sub	a5,a5,a2
  if (bm <= 0)
80002d20:	00f04c63          	bgtz	a5,80002d38 <__lshrdi3+0x24>
      w.s.low = (UWtype) uu.s.high >> -bm;
80002d24:	fe060613          	add	a2,a2,-32
80002d28:	00c5d533          	srl	a0,a1,a2
80002d2c:	00000713          	li	a4,0
  return w.ll;
80002d30:	00070593          	mv	a1,a4
}
80002d34:	00008067          	ret
      w.s.high = (UWtype) uu.s.high >> b;
80002d38:	00c5d733          	srl	a4,a1,a2
      w.s.low = ((UWtype) uu.s.low >> b) | carries;
80002d3c:	00c55533          	srl	a0,a0,a2
      const UWtype carries = (UWtype) uu.s.high << bm;
80002d40:	00f595b3          	sll	a1,a1,a5
      w.s.low = ((UWtype) uu.s.low >> b) | carries;
80002d44:	00b56533          	or	a0,a0,a1
80002d48:	fe9ff06f          	j	80002d30 <__lshrdi3+0x1c>

80002d4c <__ashldi3>:
  if (b == 0)
80002d4c:	02060063          	beqz	a2,80002d6c <__ashldi3+0x20>
  const shift_count_type bm = W_TYPE_SIZE - b;
80002d50:	02000793          	li	a5,32
80002d54:	40c787b3          	sub	a5,a5,a2
  if (bm <= 0)
80002d58:	00f04c63          	bgtz	a5,80002d70 <__ashldi3+0x24>
      w.s.high = (UWtype) uu.s.low << -bm;
80002d5c:	fe060613          	add	a2,a2,-32
80002d60:	00c515b3          	sll	a1,a0,a2
80002d64:	00000713          	li	a4,0
  return w.ll;
80002d68:	00070513          	mv	a0,a4
}
80002d6c:	00008067          	ret
      w.s.low = (UWtype) uu.s.low << b;
80002d70:	00c51733          	sll	a4,a0,a2
      w.s.high = ((UWtype) uu.s.high << b) | carries;
80002d74:	00c595b3          	sll	a1,a1,a2
      const UWtype carries = (UWtype) uu.s.low >> bm;
80002d78:	00f55533          	srl	a0,a0,a5
      w.s.high = ((UWtype) uu.s.high << b) | carries;
80002d7c:	00a5e5b3          	or	a1,a1,a0
80002d80:	fe9ff06f          	j	80002d68 <__ashldi3+0x1c>

80002d84 <__clzsi2>:
  count_leading_zeros (ret, x);
80002d84:	000107b7          	lui	a5,0x10
80002d88:	02f57a63          	bgeu	a0,a5,80002dbc <__clzsi2+0x38>
80002d8c:	10053793          	sltiu	a5,a0,256
80002d90:	0017b793          	seqz	a5,a5
80002d94:	00379793          	sll	a5,a5,0x3
80002d98:	a0000737          	lui	a4,0xa0000
80002d9c:	02000693          	li	a3,32
80002da0:	40f686b3          	sub	a3,a3,a5
80002da4:	00f55533          	srl	a0,a0,a5
80002da8:	03c70793          	add	a5,a4,60 # a000003c <__clz_tab>
80002dac:	00a787b3          	add	a5,a5,a0
80002db0:	0007c503          	lbu	a0,0(a5) # 10000 <__stack_size+0xc000>
}
80002db4:	40a68533          	sub	a0,a3,a0
80002db8:	00008067          	ret
  count_leading_zeros (ret, x);
80002dbc:	01000737          	lui	a4,0x1000
80002dc0:	01800793          	li	a5,24
80002dc4:	fce57ae3          	bgeu	a0,a4,80002d98 <__clzsi2+0x14>
80002dc8:	01000793          	li	a5,16
80002dcc:	fcdff06f          	j	80002d98 <__clzsi2+0x14>

80002dd0 <memset>:
80002dd0:	00f00313          	li	t1,15
80002dd4:	00050713          	mv	a4,a0
80002dd8:	02c37e63          	bgeu	t1,a2,80002e14 <memset+0x44>
80002ddc:	00f77793          	and	a5,a4,15
80002de0:	0a079063          	bnez	a5,80002e80 <memset+0xb0>
80002de4:	08059263          	bnez	a1,80002e68 <memset+0x98>
80002de8:	ff067693          	and	a3,a2,-16
80002dec:	00f67613          	and	a2,a2,15
80002df0:	00e686b3          	add	a3,a3,a4
80002df4:	00b72023          	sw	a1,0(a4) # 1000000 <__stack_size+0xffc000>
80002df8:	00b72223          	sw	a1,4(a4)
80002dfc:	00b72423          	sw	a1,8(a4)
80002e00:	00b72623          	sw	a1,12(a4)
80002e04:	01070713          	add	a4,a4,16
80002e08:	fed766e3          	bltu	a4,a3,80002df4 <memset+0x24>
80002e0c:	00061463          	bnez	a2,80002e14 <memset+0x44>
80002e10:	00008067          	ret
80002e14:	40c306b3          	sub	a3,t1,a2
80002e18:	00269693          	sll	a3,a3,0x2
80002e1c:	00000297          	auipc	t0,0x0
80002e20:	005686b3          	add	a3,a3,t0
80002e24:	00c68067          	jr	12(a3)
80002e28:	00b70723          	sb	a1,14(a4)
80002e2c:	00b706a3          	sb	a1,13(a4)
80002e30:	00b70623          	sb	a1,12(a4)
80002e34:	00b705a3          	sb	a1,11(a4)
80002e38:	00b70523          	sb	a1,10(a4)
80002e3c:	00b704a3          	sb	a1,9(a4)
80002e40:	00b70423          	sb	a1,8(a4)
80002e44:	00b703a3          	sb	a1,7(a4)
80002e48:	00b70323          	sb	a1,6(a4)
80002e4c:	00b702a3          	sb	a1,5(a4)
80002e50:	00b70223          	sb	a1,4(a4)
80002e54:	00b701a3          	sb	a1,3(a4)
80002e58:	00b70123          	sb	a1,2(a4)
80002e5c:	00b700a3          	sb	a1,1(a4)
80002e60:	00b70023          	sb	a1,0(a4)
80002e64:	00008067          	ret
80002e68:	0ff5f593          	zext.b	a1,a1
80002e6c:	00859693          	sll	a3,a1,0x8
80002e70:	00d5e5b3          	or	a1,a1,a3
80002e74:	01059693          	sll	a3,a1,0x10
80002e78:	00d5e5b3          	or	a1,a1,a3
80002e7c:	f6dff06f          	j	80002de8 <memset+0x18>
80002e80:	00279693          	sll	a3,a5,0x2
80002e84:	00000297          	auipc	t0,0x0
80002e88:	005686b3          	add	a3,a3,t0
80002e8c:	00008293          	mv	t0,ra
80002e90:	fa0680e7          	jalr	-96(a3)
80002e94:	00028093          	mv	ra,t0
80002e98:	ff078793          	add	a5,a5,-16
80002e9c:	40f70733          	sub	a4,a4,a5
80002ea0:	00f60633          	add	a2,a2,a5
80002ea4:	f6c378e3          	bgeu	t1,a2,80002e14 <memset+0x44>
80002ea8:	f3dff06f          	j	80002de4 <memset+0x14>

80002eac <to_host>:
80002eac:	c00007b7          	lui	a5,0xc0000
80002eb0:	00100713          	li	a4,1
80002eb4:	00e7a023          	sw	a4,0(a5) # c0000000 <__stack_base+0x1fff0000>
80002eb8:	00008067          	ret

80002ebc <to_interrupt>:
80002ebc:	d00007b7          	lui	a5,0xd0000
80002ec0:	00100713          	li	a4,1
80002ec4:	00e7a023          	sw	a4,0(a5) # d0000000 <__stack_base+0x2fff0000>
80002ec8:	00008067          	ret

80002ecc <_putchar>:
80002ecc:	00050593          	mv	a1,a0
80002ed0:	a0001537          	lui	a0,0xa0001
80002ed4:	d8850513          	add	a0,a0,-632 # a0000d88 <uart>
80002ed8:	3440006f          	j	8000321c <uart_put_char>

80002edc <init>:
80002edc:	a0001537          	lui	a0,0xa0001
80002ee0:	ff010113          	add	sp,sp,-16
80002ee4:	c00015b7          	lui	a1,0xc0001
80002ee8:	d8850513          	add	a0,a0,-632 # a0000d88 <uart>
80002eec:	00112623          	sw	ra,12(sp)
80002ef0:	324000ef          	jal	80003214 <uart_init>
80002ef4:	a0000537          	lui	a0,0xa0000
80002ef8:	13c50513          	add	a0,a0,316 # a000013c <__clz_tab+0x100>
80002efc:	47c020ef          	jal	80005378 <printf_>
80002f00:	00c12083          	lw	ra,12(sp)
80002f04:	a0000537          	lui	a0,0xa0000
80002f08:	15450513          	add	a0,a0,340 # a0000154 <__clz_tab+0x118>
80002f0c:	01010113          	add	sp,sp,16
80002f10:	4680206f          	j	80005378 <printf_>

80002f14 <sbi_ecall_handler>:
80002f14:	ff010113          	add	sp,sp,-16
80002f18:	00112623          	sw	ra,12(sp)
80002f1c:	00812423          	sw	s0,8(sp)
80002f20:	34102473          	csrr	s0,mepc
80002f24:	a0000537          	lui	a0,0xa0000
80002f28:	00040593          	mv	a1,s0
80002f2c:	17050513          	add	a0,a0,368 # a0000170 <__clz_tab+0x134>
80002f30:	448020ef          	jal	80005378 <printf_>
80002f34:	00440413          	add	s0,s0,4
80002f38:	34141073          	csrw	mepc,s0
80002f3c:	341025f3          	csrr	a1,mepc
80002f40:	00812403          	lw	s0,8(sp)
80002f44:	00c12083          	lw	ra,12(sp)
80002f48:	a0000537          	lui	a0,0xa0000
80002f4c:	18850513          	add	a0,a0,392 # a0000188 <__clz_tab+0x14c>
80002f50:	01010113          	add	sp,sp,16
80002f54:	4240206f          	j	80005378 <printf_>

80002f58 <sbi_illegal_insn_handler>:
80002f58:	ff010113          	add	sp,sp,-16
80002f5c:	00112623          	sw	ra,12(sp)
80002f60:	00812423          	sw	s0,8(sp)
80002f64:	341025f3          	csrr	a1,mepc
80002f68:	34302473          	csrr	s0,mtval
80002f6c:	a0000537          	lui	a0,0xa0000
80002f70:	1a450513          	add	a0,a0,420 # a00001a4 <__clz_tab+0x168>
80002f74:	404020ef          	jal	80005378 <printf_>
80002f78:	a0000537          	lui	a0,0xa0000
80002f7c:	00040593          	mv	a1,s0
80002f80:	1bc50513          	add	a0,a0,444 # a00001bc <__clz_tab+0x180>
80002f84:	3f4020ef          	jal	80005378 <printf_>
80002f88:	00812403          	lw	s0,8(sp)
80002f8c:	00c12083          	lw	ra,12(sp)
80002f90:	a0000537          	lui	a0,0xa0000
80002f94:	1dc50513          	add	a0,a0,476 # a00001dc <__clz_tab+0x1a0>
80002f98:	01010113          	add	sp,sp,16
80002f9c:	3dc0206f          	j	80005378 <printf_>

80002fa0 <sbi_ebreak_handler>:
80002fa0:	a0000537          	lui	a0,0xa0000
80002fa4:	ff010113          	add	sp,sp,-16
80002fa8:	21c50513          	add	a0,a0,540 # a000021c <__clz_tab+0x1e0>
80002fac:	00112623          	sw	ra,12(sp)
80002fb0:	00812423          	sw	s0,8(sp)
80002fb4:	3c4020ef          	jal	80005378 <printf_>
80002fb8:	34102473          	csrr	s0,mepc
80002fbc:	a0000537          	lui	a0,0xa0000
80002fc0:	00040593          	mv	a1,s0
80002fc4:	25c50513          	add	a0,a0,604 # a000025c <__clz_tab+0x220>
80002fc8:	3b0020ef          	jal	80005378 <printf_>
80002fcc:	00440413          	add	s0,s0,4
80002fd0:	34141073          	csrw	mepc,s0
80002fd4:	341025f3          	csrr	a1,mepc
80002fd8:	00812403          	lw	s0,8(sp)
80002fdc:	00c12083          	lw	ra,12(sp)
80002fe0:	a0000537          	lui	a0,0xa0000
80002fe4:	27450513          	add	a0,a0,628 # a0000274 <__clz_tab+0x238>
80002fe8:	01010113          	add	sp,sp,16
80002fec:	38c0206f          	j	80005378 <printf_>

80002ff0 <sbi_irqchip_process>:
80002ff0:	ff010113          	add	sp,sp,-16
80002ff4:	00112623          	sw	ra,12(sp)
80002ff8:	00812423          	sw	s0,8(sp)
80002ffc:	00912223          	sw	s1,4(sp)
80003000:	01212023          	sw	s2,0(sp)
80003004:	341025f3          	csrr	a1,mepc
80003008:	30002973          	csrr	s2,mstatus
8000300c:	344024f3          	csrr	s1,mip
80003010:	30402473          	csrr	s0,mie
80003014:	a0000537          	lui	a0,0xa0000
80003018:	29050513          	add	a0,a0,656 # a0000290 <__clz_tab+0x254>
8000301c:	35c020ef          	jal	80005378 <printf_>
80003020:	a0000537          	lui	a0,0xa0000
80003024:	00090593          	mv	a1,s2
80003028:	2b850513          	add	a0,a0,696 # a00002b8 <__clz_tab+0x27c>
8000302c:	34c020ef          	jal	80005378 <printf_>
80003030:	a0000537          	lui	a0,0xa0000
80003034:	00048593          	mv	a1,s1
80003038:	2e450513          	add	a0,a0,740 # a00002e4 <__clz_tab+0x2a8>
8000303c:	33c020ef          	jal	80005378 <printf_>
80003040:	a0000537          	lui	a0,0xa0000
80003044:	00040593          	mv	a1,s0
80003048:	30c50513          	add	a0,a0,780 # a000030c <__clz_tab+0x2d0>
8000304c:	32c020ef          	jal	80005378 <printf_>
80003050:	00812403          	lw	s0,8(sp)
80003054:	00c12083          	lw	ra,12(sp)
80003058:	00412483          	lw	s1,4(sp)
8000305c:	00012903          	lw	s2,0(sp)
80003060:	a0000537          	lui	a0,0xa0000
80003064:	33450513          	add	a0,a0,820 # a0000334 <__clz_tab+0x2f8>
80003068:	01010113          	add	sp,sp,16
8000306c:	30c0206f          	j	80005378 <printf_>

80003070 <toy_trap_handler>:
80003070:	ff010113          	add	sp,sp,-16
80003074:	00912223          	sw	s1,4(sp)
80003078:	00050493          	mv	s1,a0
8000307c:	a0000537          	lui	a0,0xa0000
80003080:	38450513          	add	a0,a0,900 # a0000384 <__clz_tab+0x348>
80003084:	00112623          	sw	ra,12(sp)
80003088:	00812423          	sw	s0,8(sp)
8000308c:	01212023          	sw	s2,0(sp)
80003090:	2e8020ef          	jal	80005378 <printf_>
80003094:	341025f3          	csrr	a1,mepc
80003098:	34202473          	csrr	s0,mcause
8000309c:	34302973          	csrr	s2,mtval
800030a0:	a0000537          	lui	a0,0xa0000
800030a4:	3c050513          	add	a0,a0,960 # a00003c0 <__clz_tab+0x384>
800030a8:	2d0020ef          	jal	80005378 <printf_>
800030ac:	a0000537          	lui	a0,0xa0000
800030b0:	00040593          	mv	a1,s0
800030b4:	3d850513          	add	a0,a0,984 # a00003d8 <__clz_tab+0x39c>
800030b8:	2c0020ef          	jal	80005378 <printf_>
800030bc:	a0000537          	lui	a0,0xa0000
800030c0:	00090593          	mv	a1,s2
800030c4:	3f050513          	add	a0,a0,1008 # a00003f0 <__clz_tab+0x3b4>
800030c8:	2b0020ef          	jal	80005378 <printf_>
800030cc:	02044263          	bltz	s0,800030f0 <toy_trap_handler+0x80>
800030d0:	00b00793          	li	a5,11
800030d4:	0487ea63          	bltu	a5,s0,80003128 <toy_trap_handler+0xb8>
800030d8:	a00017b7          	lui	a5,0xa0001
800030dc:	a6c78793          	add	a5,a5,-1428 # a0000a6c <__clz_tab+0xa30>
800030e0:	00241413          	sll	s0,s0,0x2
800030e4:	00f40433          	add	s0,s0,a5
800030e8:	00042783          	lw	a5,0(s0)
800030ec:	00078067          	jr	a5
800030f0:	00141413          	sll	s0,s0,0x1
800030f4:	00145413          	srl	s0,s0,0x1
800030f8:	00700793          	li	a5,7
800030fc:	0ef40263          	beq	s0,a5,800031e0 <toy_trap_handler+0x170>
80003100:	00b00793          	li	a5,11
80003104:	0ef40663          	beq	s0,a5,800031f0 <toy_trap_handler+0x180>
80003108:	00300793          	li	a5,3
8000310c:	00f41863          	bne	s0,a5,8000311c <toy_trap_handler+0xac>
80003110:	a0000537          	lui	a0,0xa0000
80003114:	41c50513          	add	a0,a0,1052 # a000041c <__clz_tab+0x3e0>
80003118:	260020ef          	jal	80005378 <printf_>
8000311c:	a0000537          	lui	a0,0xa0000
80003120:	44c50513          	add	a0,a0,1100 # a000044c <__clz_tab+0x410>
80003124:	254020ef          	jal	80005378 <printf_>
80003128:	a0000537          	lui	a0,0xa0000
8000312c:	59c50513          	add	a0,a0,1436 # a000059c <__clz_tab+0x560>
80003130:	248020ef          	jal	80005378 <printf_>
80003134:	00c12083          	lw	ra,12(sp)
80003138:	00812403          	lw	s0,8(sp)
8000313c:	00012903          	lw	s2,0(sp)
80003140:	00048513          	mv	a0,s1
80003144:	00412483          	lw	s1,4(sp)
80003148:	01010113          	add	sp,sp,16
8000314c:	00008067          	ret
80003150:	a0000537          	lui	a0,0xa0000
80003154:	48850513          	add	a0,a0,1160 # a0000488 <__clz_tab+0x44c>
80003158:	220020ef          	jal	80005378 <printf_>
8000315c:	dfdff0ef          	jal	80002f58 <sbi_illegal_insn_handler>
80003160:	d4dff0ef          	jal	80002eac <to_host>
80003164:	fc5ff06f          	j	80003128 <toy_trap_handler+0xb8>
80003168:	a0000537          	lui	a0,0xa0000
8000316c:	4b050513          	add	a0,a0,1200 # a00004b0 <__clz_tab+0x474>
80003170:	208020ef          	jal	80005378 <printf_>
80003174:	e2dff0ef          	jal	80002fa0 <sbi_ebreak_handler>
80003178:	fb1ff06f          	j	80003128 <toy_trap_handler+0xb8>
8000317c:	a0000537          	lui	a0,0xa0000
80003180:	4d050513          	add	a0,a0,1232 # a00004d0 <__clz_tab+0x494>
80003184:	1f4020ef          	jal	80005378 <printf_>
80003188:	fa1ff06f          	j	80003128 <toy_trap_handler+0xb8>
8000318c:	a0000537          	lui	a0,0xa0000
80003190:	55c50513          	add	a0,a0,1372 # a000055c <__clz_tab+0x520>
80003194:	1e4020ef          	jal	80005378 <printf_>
80003198:	f91ff06f          	j	80003128 <toy_trap_handler+0xb8>
8000319c:	a0000537          	lui	a0,0xa0000
800031a0:	4f450513          	add	a0,a0,1268 # a00004f4 <__clz_tab+0x4b8>
800031a4:	1d4020ef          	jal	80005378 <printf_>
800031a8:	f81ff06f          	j	80003128 <toy_trap_handler+0xb8>
800031ac:	a0000537          	lui	a0,0xa0000
800031b0:	57c50513          	add	a0,a0,1404 # a000057c <__clz_tab+0x540>
800031b4:	1c4020ef          	jal	80005378 <printf_>
800031b8:	f71ff06f          	j	80003128 <toy_trap_handler+0xb8>
800031bc:	a0000537          	lui	a0,0xa0000
800031c0:	51850513          	add	a0,a0,1304 # a0000518 <__clz_tab+0x4dc>
800031c4:	1b4020ef          	jal	80005378 <printf_>
800031c8:	f61ff06f          	j	80003128 <toy_trap_handler+0xb8>
800031cc:	a0000537          	lui	a0,0xa0000
800031d0:	53c50513          	add	a0,a0,1340 # a000053c <__clz_tab+0x500>
800031d4:	1a4020ef          	jal	80005378 <printf_>
800031d8:	d3dff0ef          	jal	80002f14 <sbi_ecall_handler>
800031dc:	f4dff06f          	j	80003128 <toy_trap_handler+0xb8>
800031e0:	a0000537          	lui	a0,0xa0000
800031e4:	40850513          	add	a0,a0,1032 # a0000408 <__clz_tab+0x3cc>
800031e8:	190020ef          	jal	80005378 <printf_>
800031ec:	f31ff06f          	j	8000311c <toy_trap_handler+0xac>
800031f0:	a0000537          	lui	a0,0xa0000
800031f4:	43450513          	add	a0,a0,1076 # a0000434 <__clz_tab+0x3f8>
800031f8:	180020ef          	jal	80005378 <printf_>
800031fc:	df5ff0ef          	jal	80002ff0 <sbi_irqchip_process>
80003200:	cbdff0ef          	jal	80002ebc <to_interrupt>
80003204:	f19ff06f          	j	8000311c <toy_trap_handler+0xac>

80003208 <get_cycle>:
80003208:	b0002573          	csrr	a0,mcycle
8000320c:	b80025f3          	csrr	a1,mcycleh
80003210:	00008067          	ret

80003214 <uart_init>:
80003214:	00b52023          	sw	a1,0(a0)
80003218:	00008067          	ret

8000321c <uart_put_char>:
8000321c:	00052783          	lw	a5,0(a0)
80003220:	00b7a023          	sw	a1,0(a5)
80003224:	00000013          	nop
80003228:	00000013          	nop
8000322c:	00000013          	nop
80003230:	00000013          	nop
80003234:	00000013          	nop
80003238:	00000013          	nop
8000323c:	00000013          	nop
80003240:	00000013          	nop
80003244:	00000013          	nop
80003248:	00000013          	nop
8000324c:	00000013          	nop
80003250:	00000013          	nop
80003254:	00000013          	nop
80003258:	00000013          	nop
8000325c:	00000013          	nop
80003260:	00000013          	nop
80003264:	00000013          	nop
80003268:	00000013          	nop
8000326c:	00000013          	nop
80003270:	00000013          	nop
80003274:	00000013          	nop
80003278:	00000013          	nop
8000327c:	00000013          	nop
80003280:	00000013          	nop
80003284:	00000013          	nop
80003288:	00000013          	nop
8000328c:	00000013          	nop
80003290:	00000013          	nop
80003294:	00000013          	nop
80003298:	00000013          	nop
8000329c:	00000013          	nop
800032a0:	00000013          	nop
800032a4:	00000013          	nop
800032a8:	00000013          	nop
800032ac:	00000013          	nop
800032b0:	00000013          	nop
800032b4:	00000013          	nop
800032b8:	00000013          	nop
800032bc:	00000013          	nop
800032c0:	00000013          	nop
800032c4:	00000013          	nop
800032c8:	00000013          	nop
800032cc:	00000013          	nop
800032d0:	00000013          	nop
800032d4:	00000013          	nop
800032d8:	00000013          	nop
800032dc:	00000013          	nop
800032e0:	00000013          	nop
800032e4:	00000013          	nop
800032e8:	00000013          	nop
800032ec:	00008067          	ret

800032f0 <_out_null>:
800032f0:	00008067          	ret

800032f4 <_out_rev>:
800032f4:	fd010113          	add	sp,sp,-48
800032f8:	02812423          	sw	s0,40(sp)
800032fc:	01312e23          	sw	s3,28(sp)
80003300:	01412c23          	sw	s4,24(sp)
80003304:	01512a23          	sw	s5,20(sp)
80003308:	01612823          	sw	s6,16(sp)
8000330c:	01712623          	sw	s7,12(sp)
80003310:	01812423          	sw	s8,8(sp)
80003314:	01912223          	sw	s9,4(sp)
80003318:	02112623          	sw	ra,44(sp)
8000331c:	00088c93          	mv	s9,a7
80003320:	02912223          	sw	s1,36(sp)
80003324:	03212023          	sw	s2,32(sp)
80003328:	0038f893          	and	a7,a7,3
8000332c:	00050993          	mv	s3,a0
80003330:	00058a13          	mv	s4,a1
80003334:	00060b13          	mv	s6,a2
80003338:	00068a93          	mv	s5,a3
8000333c:	00070b93          	mv	s7,a4
80003340:	00078413          	mv	s0,a5
80003344:	00080c13          	mv	s8,a6
80003348:	0c089263          	bnez	a7,8000340c <_out_rev+0x118>
8000334c:	0d07f863          	bgeu	a5,a6,8000341c <_out_rev+0x128>
80003350:	40f80933          	sub	s2,a6,a5
80003354:	00c90933          	add	s2,s2,a2
80003358:	00060493          	mv	s1,a2
8000335c:	00048613          	mv	a2,s1
80003360:	000a8693          	mv	a3,s5
80003364:	00148493          	add	s1,s1,1
80003368:	000a0593          	mv	a1,s4
8000336c:	02000513          	li	a0,32
80003370:	000980e7          	jalr	s3
80003374:	ff2494e3          	bne	s1,s2,8000335c <_out_rev+0x68>
80003378:	04040e63          	beqz	s0,800033d4 <_out_rev+0xe0>
8000337c:	00890933          	add	s2,s2,s0
80003380:	40890633          	sub	a2,s2,s0
80003384:	fff40413          	add	s0,s0,-1
80003388:	008b87b3          	add	a5,s7,s0
8000338c:	0007c503          	lbu	a0,0(a5)
80003390:	000a8693          	mv	a3,s5
80003394:	000a0593          	mv	a1,s4
80003398:	00090493          	mv	s1,s2
8000339c:	000980e7          	jalr	s3
800033a0:	fe0410e3          	bnez	s0,80003380 <_out_rev+0x8c>
800033a4:	002cfc93          	and	s9,s9,2
800033a8:	020c8663          	beqz	s9,800033d4 <_out_rev+0xe0>
800033ac:	41648b33          	sub	s6,s1,s6
800033b0:	038b7263          	bgeu	s6,s8,800033d4 <_out_rev+0xe0>
800033b4:	00048613          	mv	a2,s1
800033b8:	000a8693          	mv	a3,s5
800033bc:	000a0593          	mv	a1,s4
800033c0:	02000513          	li	a0,32
800033c4:	001b0b13          	add	s6,s6,1
800033c8:	00148493          	add	s1,s1,1
800033cc:	000980e7          	jalr	s3
800033d0:	ff8b62e3          	bltu	s6,s8,800033b4 <_out_rev+0xc0>
800033d4:	02c12083          	lw	ra,44(sp)
800033d8:	02812403          	lw	s0,40(sp)
800033dc:	02012903          	lw	s2,32(sp)
800033e0:	01c12983          	lw	s3,28(sp)
800033e4:	01812a03          	lw	s4,24(sp)
800033e8:	01412a83          	lw	s5,20(sp)
800033ec:	01012b03          	lw	s6,16(sp)
800033f0:	00c12b83          	lw	s7,12(sp)
800033f4:	00812c03          	lw	s8,8(sp)
800033f8:	00412c83          	lw	s9,4(sp)
800033fc:	00048513          	mv	a0,s1
80003400:	02412483          	lw	s1,36(sp)
80003404:	03010113          	add	sp,sp,48
80003408:	00008067          	ret
8000340c:	00060913          	mv	s2,a2
80003410:	00060493          	mv	s1,a2
80003414:	f60794e3          	bnez	a5,8000337c <_out_rev+0x88>
80003418:	f8dff06f          	j	800033a4 <_out_rev+0xb0>
8000341c:	00060913          	mv	s2,a2
80003420:	f4079ee3          	bnez	a5,8000337c <_out_rev+0x88>
80003424:	00060493          	mv	s1,a2
80003428:	fadff06f          	j	800033d4 <_out_rev+0xe0>

8000342c <_ntoa_format>:
8000342c:	00812383          	lw	t2,8(sp)
80003430:	00012283          	lw	t0,0(sp)
80003434:	00412f83          	lw	t6,4(sp)
80003438:	0023f313          	and	t1,t2,2
8000343c:	00080f13          	mv	t5,a6
80003440:	06031463          	bnez	t1,800034a8 <_ntoa_format+0x7c>
80003444:	100f9c63          	bnez	t6,8000355c <_ntoa_format+0x130>
80003448:	0657f063          	bgeu	a5,t0,800034a8 <_ntoa_format+0x7c>
8000344c:	02000313          	li	t1,32
80003450:	0013f813          	and	a6,t2,1
80003454:	2e678063          	beq	a5,t1,80003734 <_ntoa_format+0x308>
80003458:	03000e13          	li	t3,48
8000345c:	02000e93          	li	t4,32
80003460:	0080006f          	j	80003468 <_ntoa_format+0x3c>
80003464:	15d78e63          	beq	a5,t4,800035c0 <_ntoa_format+0x194>
80003468:	00178793          	add	a5,a5,1
8000346c:	00f70333          	add	t1,a4,a5
80003470:	ffc30fa3          	sb	t3,-1(t1)
80003474:	fe57e8e3          	bltu	a5,t0,80003464 <_ntoa_format+0x38>
80003478:	02080863          	beqz	a6,800034a8 <_ntoa_format+0x7c>
8000347c:	03f7f663          	bgeu	a5,t6,800034a8 <_ntoa_format+0x7c>
80003480:	02000813          	li	a6,32
80003484:	03000e13          	li	t3,48
80003488:	02000e93          	li	t4,32
8000348c:	01079663          	bne	a5,a6,80003498 <_ntoa_format+0x6c>
80003490:	1380006f          	j	800035c8 <_ntoa_format+0x19c>
80003494:	07d78663          	beq	a5,t4,80003500 <_ntoa_format+0xd4>
80003498:	00178793          	add	a5,a5,1
8000349c:	00f70333          	add	t1,a4,a5
800034a0:	ffc30fa3          	sb	t3,-1(t1)
800034a4:	fff798e3          	bne	a5,t6,80003494 <_ntoa_format+0x68>
800034a8:	0103f813          	and	a6,t2,16
800034ac:	08080e63          	beqz	a6,80003548 <_ntoa_format+0x11c>
800034b0:	4003f813          	and	a6,t2,1024
800034b4:	06081463          	bnez	a6,8000351c <_ntoa_format+0xf0>
800034b8:	04079e63          	bnez	a5,80003514 <_ntoa_format+0xe8>
800034bc:	01000793          	li	a5,16
800034c0:	22f88863          	beq	a7,a5,800036f0 <_ntoa_format+0x2c4>
800034c4:	00200793          	li	a5,2
800034c8:	24f88663          	beq	a7,a5,80003714 <_ntoa_format+0x2e8>
800034cc:	03000793          	li	a5,48
800034d0:	00f70023          	sb	a5,0(a4)
800034d4:	00100793          	li	a5,1
800034d8:	100f1e63          	bnez	t5,800035f4 <_ntoa_format+0x1c8>
800034dc:	0043f813          	and	a6,t2,4
800034e0:	1c080c63          	beqz	a6,800036b8 <_ntoa_format+0x28c>
800034e4:	00f70833          	add	a6,a4,a5
800034e8:	02b00893          	li	a7,43
800034ec:	01180023          	sb	a7,0(a6)
800034f0:	00178793          	add	a5,a5,1
800034f4:	00038893          	mv	a7,t2
800034f8:	000f8813          	mv	a6,t6
800034fc:	df9ff06f          	j	800032f4 <_out_rev>
80003500:	0103f813          	and	a6,t2,16
80003504:	02000793          	li	a5,32
80003508:	fe0806e3          	beqz	a6,800034f4 <_ntoa_format+0xc8>
8000350c:	4003f813          	and	a6,t2,1024
80003510:	00081663          	bnez	a6,8000351c <_ntoa_format+0xf0>
80003514:	14f28263          	beq	t0,a5,80003658 <_ntoa_format+0x22c>
80003518:	15f78063          	beq	a5,t6,80003658 <_ntoa_format+0x22c>
8000351c:	01000813          	li	a6,16
80003520:	17088a63          	beq	a7,a6,80003694 <_ntoa_format+0x268>
80003524:	00200813          	li	a6,2
80003528:	11088e63          	beq	a7,a6,80003644 <_ntoa_format+0x218>
8000352c:	02000813          	li	a6,32
80003530:	fd0782e3          	beq	a5,a6,800034f4 <_ntoa_format+0xc8>
80003534:	00078813          	mv	a6,a5
80003538:	00178793          	add	a5,a5,1
8000353c:	01070833          	add	a6,a4,a6
80003540:	03000893          	li	a7,48
80003544:	01180023          	sb	a7,0(a6)
80003548:	02000813          	li	a6,32
8000354c:	f90796e3          	bne	a5,a6,800034d8 <_ntoa_format+0xac>
80003550:	00038893          	mv	a7,t2
80003554:	000f8813          	mv	a6,t6
80003558:	d9dff06f          	j	800032f4 <_out_rev>
8000355c:	0013f813          	and	a6,t2,1
80003560:	0a080863          	beqz	a6,80003610 <_ntoa_format+0x1e4>
80003564:	120f1463          	bnez	t5,8000368c <_ntoa_format+0x260>
80003568:	00c3f313          	and	t1,t2,12
8000356c:	12031063          	bnez	t1,8000368c <_ntoa_format+0x260>
80003570:	f057f6e3          	bgeu	a5,t0,8000347c <_ntoa_format+0x50>
80003574:	02000313          	li	t1,32
80003578:	ee6790e3          	bne	a5,t1,80003458 <_ntoa_format+0x2c>
8000357c:	05f7e663          	bltu	a5,t6,800035c8 <_ntoa_format+0x19c>
80003580:	0103f813          	and	a6,t2,16
80003584:	02000793          	li	a5,32
80003588:	f60806e3          	beqz	a6,800034f4 <_ntoa_format+0xc8>
8000358c:	4003f813          	and	a6,t2,1024
80003590:	04081a63          	bnez	a6,800035e4 <_ntoa_format+0x1b8>
80003594:	00f28463          	beq	t0,a5,8000359c <_ntoa_format+0x170>
80003598:	f8ff92e3          	bne	t6,a5,8000351c <_ntoa_format+0xf0>
8000359c:	01f00813          	li	a6,31
800035a0:	01000313          	li	t1,16
800035a4:	18688c63          	beq	a7,t1,8000373c <_ntoa_format+0x310>
800035a8:	00200313          	li	t1,2
800035ac:	f86898e3          	bne	a7,t1,8000353c <_ntoa_format+0x110>
800035b0:	01070833          	add	a6,a4,a6
800035b4:	06200893          	li	a7,98
800035b8:	01180023          	sb	a7,0(a6)
800035bc:	f71ff06f          	j	8000352c <_ntoa_format+0x100>
800035c0:	1a080463          	beqz	a6,80003768 <_ntoa_format+0x33c>
800035c4:	f3f7fee3          	bgeu	a5,t6,80003500 <_ntoa_format+0xd4>
800035c8:	0103f813          	and	a6,t2,16
800035cc:	02000793          	li	a5,32
800035d0:	f20802e3          	beqz	a6,800034f4 <_ntoa_format+0xc8>
800035d4:	4003f813          	and	a6,t2,1024
800035d8:	00081663          	bnez	a6,800035e4 <_ntoa_format+0x1b8>
800035dc:	fcf280e3          	beq	t0,a5,8000359c <_ntoa_format+0x170>
800035e0:	faff8ee3          	beq	t6,a5,8000359c <_ntoa_format+0x170>
800035e4:	01000813          	li	a6,16
800035e8:	f10896e3          	bne	a7,a6,800034f4 <_ntoa_format+0xc8>
800035ec:	02000793          	li	a5,32
800035f0:	f05ff06f          	j	800034f4 <_ntoa_format+0xc8>
800035f4:	00f70833          	add	a6,a4,a5
800035f8:	02d00893          	li	a7,45
800035fc:	01180023          	sb	a7,0(a6)
80003600:	00178793          	add	a5,a5,1
80003604:	00038893          	mv	a7,t2
80003608:	000f8813          	mv	a6,t6
8000360c:	ce9ff06f          	j	800032f4 <_out_rev>
80003610:	e857fce3          	bgeu	a5,t0,800034a8 <_ntoa_format+0x7c>
80003614:	02000313          	li	t1,32
80003618:	e46790e3          	bne	a5,t1,80003458 <_ntoa_format+0x2c>
8000361c:	0103f793          	and	a5,t2,16
80003620:	fc0786e3          	beqz	a5,800035ec <_ntoa_format+0x1c0>
80003624:	4003f793          	and	a5,t2,1024
80003628:	fc0792e3          	bnez	a5,800035ec <_ntoa_format+0x1c0>
8000362c:	02000793          	li	a5,32
80003630:	00f28463          	beq	t0,a5,80003638 <_ntoa_format+0x20c>
80003634:	faff9ce3          	bne	t6,a5,800035ec <_ntoa_format+0x1c0>
80003638:	02000793          	li	a5,32
8000363c:	01f00813          	li	a6,31
80003640:	f61ff06f          	j	800035a0 <_ntoa_format+0x174>
80003644:	02000813          	li	a6,32
80003648:	eb0786e3          	beq	a5,a6,800034f4 <_ntoa_format+0xc8>
8000364c:	00078813          	mv	a6,a5
80003650:	00178793          	add	a5,a5,1
80003654:	f5dff06f          	j	800035b0 <_ntoa_format+0x184>
80003658:	fff78813          	add	a6,a5,-1
8000365c:	f40812e3          	bnez	a6,800035a0 <_ntoa_format+0x174>
80003660:	01000793          	li	a5,16
80003664:	e6f890e3          	bne	a7,a5,800034c4 <_ntoa_format+0x98>
80003668:	0203f793          	and	a5,t2,32
8000366c:	0c078063          	beqz	a5,8000372c <_ntoa_format+0x300>
80003670:	05800793          	li	a5,88
80003674:	00f70023          	sb	a5,0(a4)
80003678:	03000793          	li	a5,48
8000367c:	00f700a3          	sb	a5,1(a4)
80003680:	00200793          	li	a5,2
80003684:	e40f0ce3          	beqz	t5,800034dc <_ntoa_format+0xb0>
80003688:	f6dff06f          	j	800035f4 <_ntoa_format+0x1c8>
8000368c:	ffff8f93          	add	t6,t6,-1
80003690:	ee1ff06f          	j	80003570 <_ntoa_format+0x144>
80003694:	0203f813          	and	a6,t2,32
80003698:	02081e63          	bnez	a6,800036d4 <_ntoa_format+0x2a8>
8000369c:	02000813          	li	a6,32
800036a0:	f50786e3          	beq	a5,a6,800035ec <_ntoa_format+0x1c0>
800036a4:	00f70833          	add	a6,a4,a5
800036a8:	07800893          	li	a7,120
800036ac:	01180023          	sb	a7,0(a6)
800036b0:	00178793          	add	a5,a5,1
800036b4:	e79ff06f          	j	8000352c <_ntoa_format+0x100>
800036b8:	0083f813          	and	a6,t2,8
800036bc:	e2080ce3          	beqz	a6,800034f4 <_ntoa_format+0xc8>
800036c0:	00f70833          	add	a6,a4,a5
800036c4:	02000893          	li	a7,32
800036c8:	01180023          	sb	a7,0(a6)
800036cc:	00178793          	add	a5,a5,1
800036d0:	e25ff06f          	j	800034f4 <_ntoa_format+0xc8>
800036d4:	02000813          	li	a6,32
800036d8:	f1078ae3          	beq	a5,a6,800035ec <_ntoa_format+0x1c0>
800036dc:	00f70833          	add	a6,a4,a5
800036e0:	05800893          	li	a7,88
800036e4:	01180023          	sb	a7,0(a6)
800036e8:	00178793          	add	a5,a5,1
800036ec:	e41ff06f          	j	8000352c <_ntoa_format+0x100>
800036f0:	0203f793          	and	a5,t2,32
800036f4:	02078c63          	beqz	a5,8000372c <_ntoa_format+0x300>
800036f8:	05800793          	li	a5,88
800036fc:	00f70023          	sb	a5,0(a4)
80003700:	03000793          	li	a5,48
80003704:	00f700a3          	sb	a5,1(a4)
80003708:	00200793          	li	a5,2
8000370c:	dc0f08e3          	beqz	t5,800034dc <_ntoa_format+0xb0>
80003710:	ee5ff06f          	j	800035f4 <_ntoa_format+0x1c8>
80003714:	06200793          	li	a5,98
80003718:	00f70023          	sb	a5,0(a4)
8000371c:	03000793          	li	a5,48
80003720:	00f700a3          	sb	a5,1(a4)
80003724:	00200793          	li	a5,2
80003728:	f5dff06f          	j	80003684 <_ntoa_format+0x258>
8000372c:	07800793          	li	a5,120
80003730:	fe9ff06f          	j	80003718 <_ntoa_format+0x2ec>
80003734:	e40816e3          	bnez	a6,80003580 <_ntoa_format+0x154>
80003738:	ee5ff06f          	j	8000361c <_ntoa_format+0x1f0>
8000373c:	ffe78813          	add	a6,a5,-2
80003740:	0203f893          	and	a7,t2,32
80003744:	01070833          	add	a6,a4,a6
80003748:	fff78793          	add	a5,a5,-1
8000374c:	00089863          	bnez	a7,8000375c <_ntoa_format+0x330>
80003750:	07800893          	li	a7,120
80003754:	01180023          	sb	a7,0(a6)
80003758:	dddff06f          	j	80003534 <_ntoa_format+0x108>
8000375c:	05800893          	li	a7,88
80003760:	01180023          	sb	a7,0(a6)
80003764:	dd1ff06f          	j	80003534 <_ntoa_format+0x108>
80003768:	0103f813          	and	a6,t2,16
8000376c:	d80804e3          	beqz	a6,800034f4 <_ntoa_format+0xc8>
80003770:	4003f813          	and	a6,t2,1024
80003774:	e60818e3          	bnez	a6,800035e4 <_ntoa_format+0x1b8>
80003778:	dbf792e3          	bne	a5,t6,8000351c <_ntoa_format+0xf0>
8000377c:	eddff06f          	j	80003658 <_ntoa_format+0x22c>

80003780 <_out_char>:
80003780:	00051463          	bnez	a0,80003788 <_out_char+0x8>
80003784:	00008067          	ret
80003788:	f44ff06f          	j	80002ecc <_putchar>

8000378c <_etoa>:
8000378c:	f7010113          	add	sp,sp,-144
80003790:	09212023          	sw	s2,128(sp)
80003794:	07312e23          	sw	s3,124(sp)
80003798:	07412c23          	sw	s4,120(sp)
8000379c:	07512a23          	sw	s5,116(sp)
800037a0:	00050993          	mv	s3,a0
800037a4:	00058a13          	mv	s4,a1
800037a8:	00060913          	mv	s2,a2
800037ac:	00068a93          	mv	s5,a3
800037b0:	00070613          	mv	a2,a4
800037b4:	00078693          	mv	a3,a5
800037b8:	00070513          	mv	a0,a4
800037bc:	00078593          	mv	a1,a5
800037c0:	08812423          	sw	s0,136(sp)
800037c4:	08912223          	sw	s1,132(sp)
800037c8:	07612823          	sw	s6,112(sp)
800037cc:	07812423          	sw	s8,104(sp)
800037d0:	07912223          	sw	s9,100(sp)
800037d4:	08112623          	sw	ra,140(sp)
800037d8:	09012c83          	lw	s9,144(sp)
800037dc:	00070413          	mv	s0,a4
800037e0:	00078493          	mv	s1,a5
800037e4:	00080c13          	mv	s8,a6
800037e8:	00088b13          	mv	s6,a7
800037ec:	8a0fe0ef          	jal	8000188c <__eqdf2>
800037f0:	56051263          	bnez	a0,80003d54 <_etoa+0x5c8>
800037f4:	a00016b7          	lui	a3,0xa0001
800037f8:	ce06a603          	lw	a2,-800(a3) # a0000ce0 <intpat+0x28>
800037fc:	ce46a683          	lw	a3,-796(a3)
80003800:	00040513          	mv	a0,s0
80003804:	00048593          	mv	a1,s1
80003808:	910fe0ef          	jal	80001918 <__gedf2>
8000380c:	54a04463          	bgtz	a0,80003d54 <_etoa+0x5c8>
80003810:	a00016b7          	lui	a3,0xa0001
80003814:	ce86a603          	lw	a2,-792(a3) # a0000ce8 <intpat+0x30>
80003818:	cec6a683          	lw	a3,-788(a3)
8000381c:	00040513          	mv	a0,s0
80003820:	00048593          	mv	a1,s1
80003824:	9d0fe0ef          	jal	800019f4 <__ledf2>
80003828:	52054663          	bltz	a0,80003d54 <_etoa+0x5c8>
8000382c:	00040513          	mv	a0,s0
80003830:	00048593          	mv	a1,s1
80003834:	00000613          	li	a2,0
80003838:	00000693          	li	a3,0
8000383c:	07712623          	sw	s7,108(sp)
80003840:	07a12023          	sw	s10,96(sp)
80003844:	05b12e23          	sw	s11,92(sp)
80003848:	9acfe0ef          	jal	800019f4 <__ledf2>
8000384c:	00812a23          	sw	s0,20(sp)
80003850:	00048b93          	mv	s7,s1
80003854:	00055663          	bgez	a0,80003860 <_etoa+0xd4>
80003858:	80000bb7          	lui	s7,0x80000
8000385c:	009bcbb3          	xor	s7,s7,s1
80003860:	400cf793          	and	a5,s9,1024
80003864:	02f12623          	sw	a5,44(sp)
80003868:	00079463          	bnez	a5,80003870 <_etoa+0xe4>
8000386c:	00600c13          	li	s8,6
80003870:	014bd513          	srl	a0,s7,0x14
80003874:	7ff57513          	and	a0,a0,2047
80003878:	c0150513          	add	a0,a0,-1023
8000387c:	8e8ff0ef          	jal	80002964 <__floatsidf>
80003880:	a00017b7          	lui	a5,0xa0001
80003884:	cf07a603          	lw	a2,-784(a5) # a0000cf0 <intpat+0x38>
80003888:	cf47a683          	lw	a3,-780(a5)
8000388c:	a44fe0ef          	jal	80001ad0 <__muldf3>
80003890:	a00017b7          	lui	a5,0xa0001
80003894:	cf87a603          	lw	a2,-776(a5) # a0000cf8 <intpat+0x40>
80003898:	cfc7a683          	lw	a3,-772(a5)
8000389c:	980fd0ef          	jal	80000a1c <__adddf3>
800038a0:	00cb9693          	sll	a3,s7,0xc
800038a4:	00c6d693          	srl	a3,a3,0xc
800038a8:	3ff007b7          	lui	a5,0x3ff00
800038ac:	00d7e7b3          	or	a5,a5,a3
800038b0:	a00016b7          	lui	a3,0xa0001
800038b4:	d006a603          	lw	a2,-768(a3) # a0000d00 <intpat+0x48>
800038b8:	d046a683          	lw	a3,-764(a3)
800038bc:	00050d93          	mv	s11,a0
800038c0:	00058d13          	mv	s10,a1
800038c4:	00040513          	mv	a0,s0
800038c8:	00078593          	mv	a1,a5
800038cc:	ff4fe0ef          	jal	800020c0 <__subdf3>
800038d0:	a00017b7          	lui	a5,0xa0001
800038d4:	d087a603          	lw	a2,-760(a5) # a0000d08 <intpat+0x50>
800038d8:	d0c7a683          	lw	a3,-756(a5)
800038dc:	9f4fe0ef          	jal	80001ad0 <__muldf3>
800038e0:	00050613          	mv	a2,a0
800038e4:	00058693          	mv	a3,a1
800038e8:	000d8513          	mv	a0,s11
800038ec:	000d0593          	mv	a1,s10
800038f0:	92cfd0ef          	jal	80000a1c <__adddf3>
800038f4:	f75fe0ef          	jal	80002868 <__fixdfsi>
800038f8:	00050d13          	mv	s10,a0
800038fc:	868ff0ef          	jal	80002964 <__floatsidf>
80003900:	a00017b7          	lui	a5,0xa0001
80003904:	d107a603          	lw	a2,-752(a5) # a0000d10 <intpat+0x58>
80003908:	d147a683          	lw	a3,-748(a5)
8000390c:	00058d93          	mv	s11,a1
80003910:	00a12823          	sw	a0,16(sp)
80003914:	9bcfe0ef          	jal	80001ad0 <__muldf3>
80003918:	a0001737          	lui	a4,0xa0001
8000391c:	d1872603          	lw	a2,-744(a4) # a0000d18 <intpat+0x60>
80003920:	d1c72683          	lw	a3,-740(a4)
80003924:	8f8fd0ef          	jal	80000a1c <__adddf3>
80003928:	f41fe0ef          	jal	80002868 <__fixdfsi>
8000392c:	01012783          	lw	a5,16(sp)
80003930:	a00016b7          	lui	a3,0xa0001
80003934:	d206a603          	lw	a2,-736(a3) # a0000d20 <intpat+0x68>
80003938:	d246a683          	lw	a3,-732(a3)
8000393c:	00050713          	mv	a4,a0
80003940:	000d8593          	mv	a1,s11
80003944:	00078513          	mv	a0,a5
80003948:	00070d93          	mv	s11,a4
8000394c:	984fe0ef          	jal	80001ad0 <__muldf3>
80003950:	00050793          	mv	a5,a0
80003954:	000d8513          	mv	a0,s11
80003958:	00f12823          	sw	a5,16(sp)
8000395c:	01b12c23          	sw	s11,24(sp)
80003960:	00058d93          	mv	s11,a1
80003964:	800ff0ef          	jal	80002964 <__floatsidf>
80003968:	a0001737          	lui	a4,0xa0001
8000396c:	d2872603          	lw	a2,-728(a4) # a0000d28 <intpat+0x70>
80003970:	d2c72683          	lw	a3,-724(a4)
80003974:	95cfe0ef          	jal	80001ad0 <__muldf3>
80003978:	01012783          	lw	a5,16(sp)
8000397c:	00050613          	mv	a2,a0
80003980:	00058693          	mv	a3,a1
80003984:	00078513          	mv	a0,a5
80003988:	000d8593          	mv	a1,s11
8000398c:	f34fe0ef          	jal	800020c0 <__subdf3>
80003990:	00050613          	mv	a2,a0
80003994:	00058693          	mv	a3,a1
80003998:	00a12e23          	sw	a0,28(sp)
8000399c:	00b12823          	sw	a1,16(sp)
800039a0:	930fe0ef          	jal	80001ad0 <__muldf3>
800039a4:	01012783          	lw	a5,16(sp)
800039a8:	01c12703          	lw	a4,28(sp)
800039ac:	00050d93          	mv	s11,a0
800039b0:	00078693          	mv	a3,a5
800039b4:	00070613          	mv	a2,a4
800039b8:	00070513          	mv	a0,a4
800039bc:	00058813          	mv	a6,a1
800039c0:	00078593          	mv	a1,a5
800039c4:	02e12423          	sw	a4,40(sp)
800039c8:	02f12223          	sw	a5,36(sp)
800039cc:	01012823          	sw	a6,16(sp)
800039d0:	84cfd0ef          	jal	80000a1c <__adddf3>
800039d4:	a00016b7          	lui	a3,0xa0001
800039d8:	00058893          	mv	a7,a1
800039dc:	d306a603          	lw	a2,-720(a3) # a0000d30 <intpat+0x78>
800039e0:	01012583          	lw	a1,16(sp)
800039e4:	d346a683          	lw	a3,-716(a3)
800039e8:	00050313          	mv	t1,a0
800039ec:	000d8513          	mv	a0,s11
800039f0:	02612023          	sw	t1,32(sp)
800039f4:	01112e23          	sw	a7,28(sp)
800039f8:	fb8fd0ef          	jal	800011b0 <__divdf3>
800039fc:	a0001837          	lui	a6,0xa0001
80003a00:	d3882603          	lw	a2,-712(a6) # a0000d38 <intpat+0x80>
80003a04:	d3c82683          	lw	a3,-708(a6)
80003a08:	814fd0ef          	jal	80000a1c <__adddf3>
80003a0c:	00058693          	mv	a3,a1
80003a10:	01012583          	lw	a1,16(sp)
80003a14:	00050613          	mv	a2,a0
80003a18:	000d8513          	mv	a0,s11
80003a1c:	f94fd0ef          	jal	800011b0 <__divdf3>
80003a20:	a00016b7          	lui	a3,0xa0001
80003a24:	d406a603          	lw	a2,-704(a3) # a0000d40 <intpat+0x88>
80003a28:	d446a683          	lw	a3,-700(a3)
80003a2c:	ff1fc0ef          	jal	80000a1c <__adddf3>
80003a30:	00058693          	mv	a3,a1
80003a34:	01012583          	lw	a1,16(sp)
80003a38:	00050613          	mv	a2,a0
80003a3c:	000d8513          	mv	a0,s11
80003a40:	f70fd0ef          	jal	800011b0 <__divdf3>
80003a44:	02812703          	lw	a4,40(sp)
80003a48:	02412783          	lw	a5,36(sp)
80003a4c:	a00016b7          	lui	a3,0xa0001
80003a50:	00050e13          	mv	t3,a0
80003a54:	00058d93          	mv	s11,a1
80003a58:	d486a503          	lw	a0,-696(a3) # a0000d48 <intpat+0x90>
80003a5c:	d4c6a583          	lw	a1,-692(a3)
80003a60:	00070613          	mv	a2,a4
80003a64:	00078693          	mv	a3,a5
80003a68:	01c12823          	sw	t3,16(sp)
80003a6c:	e54fe0ef          	jal	800020c0 <__subdf3>
80003a70:	01012e03          	lw	t3,16(sp)
80003a74:	00050613          	mv	a2,a0
80003a78:	00058693          	mv	a3,a1
80003a7c:	000e0513          	mv	a0,t3
80003a80:	000d8593          	mv	a1,s11
80003a84:	f99fc0ef          	jal	80000a1c <__adddf3>
80003a88:	02012303          	lw	t1,32(sp)
80003a8c:	01c12883          	lw	a7,28(sp)
80003a90:	00050613          	mv	a2,a0
80003a94:	00058693          	mv	a3,a1
80003a98:	00030513          	mv	a0,t1
80003a9c:	00088593          	mv	a1,a7
80003aa0:	f10fd0ef          	jal	800011b0 <__divdf3>
80003aa4:	a00017b7          	lui	a5,0xa0001
80003aa8:	d507a603          	lw	a2,-688(a5) # a0000d50 <intpat+0x98>
80003aac:	d547a683          	lw	a3,-684(a5)
80003ab0:	f6dfc0ef          	jal	80000a1c <__adddf3>
80003ab4:	01812783          	lw	a5,24(sp)
80003ab8:	00000613          	li	a2,0
80003abc:	3ff78793          	add	a5,a5,1023
80003ac0:	01479793          	sll	a5,a5,0x14
80003ac4:	00078693          	mv	a3,a5
80003ac8:	808fe0ef          	jal	80001ad0 <__muldf3>
80003acc:	00050613          	mv	a2,a0
80003ad0:	00a12c23          	sw	a0,24(sp)
80003ad4:	00058693          	mv	a3,a1
80003ad8:	00b12823          	sw	a1,16(sp)
80003adc:	00040513          	mv	a0,s0
80003ae0:	000b8593          	mv	a1,s7
80003ae4:	f11fd0ef          	jal	800019f4 <__ledf2>
80003ae8:	01012783          	lw	a5,16(sp)
80003aec:	01812703          	lw	a4,24(sp)
80003af0:	02055463          	bgez	a0,80003b18 <_etoa+0x38c>
80003af4:	a0001837          	lui	a6,0xa0001
80003af8:	d3882603          	lw	a2,-712(a6) # a0000d38 <intpat+0x80>
80003afc:	d3c82683          	lw	a3,-708(a6)
80003b00:	00070513          	mv	a0,a4
80003b04:	00078593          	mv	a1,a5
80003b08:	ea8fd0ef          	jal	800011b0 <__divdf3>
80003b0c:	fffd0d13          	add	s10,s10,-1
80003b10:	00050713          	mv	a4,a0
80003b14:	00058793          	mv	a5,a1
80003b18:	0c600693          	li	a3,198
80003b1c:	063d0d93          	add	s11,s10,99
80003b20:	01b6bdb3          	sltu	s11,a3,s11
80003b24:	014c9693          	sll	a3,s9,0x14
80003b28:	004d8d93          	add	s11,s11,4
80003b2c:	0606d663          	bgez	a3,80003b98 <_etoa+0x40c>
80003b30:	a00016b7          	lui	a3,0xa0001
80003b34:	d586a603          	lw	a2,-680(a3) # a0000d58 <intpat+0xa0>
80003b38:	d5c6a683          	lw	a3,-676(a3)
80003b3c:	00040513          	mv	a0,s0
80003b40:	000b8593          	mv	a1,s7
80003b44:	00f12c23          	sw	a5,24(sp)
80003b48:	00e12823          	sw	a4,16(sp)
80003b4c:	dcdfd0ef          	jal	80001918 <__gedf2>
80003b50:	01012703          	lw	a4,16(sp)
80003b54:	01812783          	lw	a5,24(sp)
80003b58:	26054c63          	bltz	a0,80003dd0 <_etoa+0x644>
80003b5c:	a00016b7          	lui	a3,0xa0001
80003b60:	d606a603          	lw	a2,-672(a3) # a0000d60 <intpat+0xa8>
80003b64:	d646a683          	lw	a3,-668(a3)
80003b68:	00040513          	mv	a0,s0
80003b6c:	000b8593          	mv	a1,s7
80003b70:	e85fd0ef          	jal	800019f4 <__ledf2>
80003b74:	01012703          	lw	a4,16(sp)
80003b78:	01812783          	lw	a5,24(sp)
80003b7c:	24055a63          	bgez	a0,80003dd0 <_etoa+0x644>
80003b80:	278d5263          	bge	s10,s8,80003de4 <_etoa+0x658>
80003b84:	41ac0d33          	sub	s10,s8,s10
80003b88:	fffd0c13          	add	s8,s10,-1
80003b8c:	400cec93          	or	s9,s9,1024
80003b90:	00000d93          	li	s11,0
80003b94:	00000d13          	li	s10,0
80003b98:	00000893          	li	a7,0
80003b9c:	016df463          	bgeu	s11,s6,80003ba4 <_etoa+0x418>
80003ba0:	41bb08b3          	sub	a7,s6,s11
80003ba4:	002cf693          	and	a3,s9,2
80003ba8:	00d12c23          	sw	a3,24(sp)
80003bac:	00068863          	beqz	a3,80003bbc <_etoa+0x430>
80003bb0:	001db693          	seqz	a3,s11
80003bb4:	40d006b3          	neg	a3,a3
80003bb8:	00d8f8b3          	and	a7,a7,a3
80003bbc:	1e0d1663          	bnez	s10,80003da8 <_etoa+0x61c>
80003bc0:	00040513          	mv	a0,s0
80003bc4:	00048593          	mv	a1,s1
80003bc8:	00000613          	li	a2,0
80003bcc:	00000693          	li	a3,0
80003bd0:	01112823          	sw	a7,16(sp)
80003bd4:	e21fd0ef          	jal	800019f4 <__ledf2>
80003bd8:	01012883          	lw	a7,16(sp)
80003bdc:	00055663          	bgez	a0,80003be8 <_etoa+0x45c>
80003be0:	800007b7          	lui	a5,0x80000
80003be4:	0177cbb3          	xor	s7,a5,s7
80003be8:	01412683          	lw	a3,20(sp)
80003bec:	fffff7b7          	lui	a5,0xfffff
80003bf0:	7ff78793          	add	a5,a5,2047 # fffff7ff <__stack_base+0x5ffef7ff>
80003bf4:	00fcf7b3          	and	a5,s9,a5
80003bf8:	00f12023          	sw	a5,0(sp)
80003bfc:	00068713          	mv	a4,a3
80003c00:	000c0813          	mv	a6,s8
80003c04:	000b8793          	mv	a5,s7
80003c08:	000a8693          	mv	a3,s5
80003c0c:	00090613          	mv	a2,s2
80003c10:	000a0593          	mv	a1,s4
80003c14:	00098513          	mv	a0,s3
80003c18:	1d4000ef          	jal	80003dec <_ftoa>
80003c1c:	00050493          	mv	s1,a0
80003c20:	0e0d8a63          	beqz	s11,80003d14 <_etoa+0x588>
80003c24:	020cfc93          	and	s9,s9,32
80003c28:	06500513          	li	a0,101
80003c2c:	000c8463          	beqz	s9,80003c34 <_etoa+0x4a8>
80003c30:	04500513          	li	a0,69
80003c34:	00148793          	add	a5,s1,1
80003c38:	00f12823          	sw	a5,16(sp)
80003c3c:	000a8693          	mv	a3,s5
80003c40:	00048613          	mv	a2,s1
80003c44:	000a0593          	mv	a1,s4
80003c48:	000980e7          	jalr	s3
80003c4c:	41fd5793          	sra	a5,s10,0x1f
80003c50:	01a7c433          	xor	s0,a5,s10
80003c54:	40f40433          	sub	s0,s0,a5
80003c58:	01fd5d13          	srl	s10,s10,0x1f
80003c5c:	fffd8d93          	add	s11,s11,-1
80003c60:	00000c93          	li	s9,0
80003c64:	00900b93          	li	s7,9
80003c68:	02000c13          	li	s8,32
80003c6c:	0080006f          	j	80003c74 <_etoa+0x4e8>
80003c70:	038c8e63          	beq	s9,s8,80003cac <_etoa+0x520>
80003c74:	03010793          	add	a5,sp,48
80003c78:	00a00593          	li	a1,10
80003c7c:	00040513          	mv	a0,s0
80003c80:	001c8c93          	add	s9,s9,1
80003c84:	019784b3          	add	s1,a5,s9
80003c88:	828ff0ef          	jal	80002cb0 <__umodsi3>
80003c8c:	03050793          	add	a5,a0,48
80003c90:	fef48fa3          	sb	a5,-1(s1)
80003c94:	00040513          	mv	a0,s0
80003c98:	00a00593          	li	a1,10
80003c9c:	00040493          	mv	s1,s0
80003ca0:	fc9fe0ef          	jal	80002c68 <__hidden___udivsi3>
80003ca4:	00050413          	mv	s0,a0
80003ca8:	fc9be4e3          	bltu	s7,s1,80003c70 <_etoa+0x4e4>
80003cac:	01012603          	lw	a2,16(sp)
80003cb0:	00500793          	li	a5,5
80003cb4:	00f12423          	sw	a5,8(sp)
80003cb8:	01b12223          	sw	s11,4(sp)
80003cbc:	000c8793          	mv	a5,s9
80003cc0:	00012023          	sw	zero,0(sp)
80003cc4:	00a00893          	li	a7,10
80003cc8:	000d0813          	mv	a6,s10
80003ccc:	03010713          	add	a4,sp,48
80003cd0:	000a8693          	mv	a3,s5
80003cd4:	000a0593          	mv	a1,s4
80003cd8:	00098513          	mv	a0,s3
80003cdc:	f50ff0ef          	jal	8000342c <_ntoa_format>
80003ce0:	01812783          	lw	a5,24(sp)
80003ce4:	00050493          	mv	s1,a0
80003ce8:	02078663          	beqz	a5,80003d14 <_etoa+0x588>
80003cec:	41250933          	sub	s2,a0,s2
80003cf0:	03697263          	bgeu	s2,s6,80003d14 <_etoa+0x588>
80003cf4:	00048613          	mv	a2,s1
80003cf8:	000a8693          	mv	a3,s5
80003cfc:	000a0593          	mv	a1,s4
80003d00:	02000513          	li	a0,32
80003d04:	00190913          	add	s2,s2,1
80003d08:	00148493          	add	s1,s1,1
80003d0c:	000980e7          	jalr	s3
80003d10:	ff6962e3          	bltu	s2,s6,80003cf4 <_etoa+0x568>
80003d14:	08c12083          	lw	ra,140(sp)
80003d18:	08812403          	lw	s0,136(sp)
80003d1c:	06c12b83          	lw	s7,108(sp)
80003d20:	06012d03          	lw	s10,96(sp)
80003d24:	05c12d83          	lw	s11,92(sp)
80003d28:	08012903          	lw	s2,128(sp)
80003d2c:	07c12983          	lw	s3,124(sp)
80003d30:	07812a03          	lw	s4,120(sp)
80003d34:	07412a83          	lw	s5,116(sp)
80003d38:	07012b03          	lw	s6,112(sp)
80003d3c:	06812c03          	lw	s8,104(sp)
80003d40:	06412c83          	lw	s9,100(sp)
80003d44:	00048513          	mv	a0,s1
80003d48:	08412483          	lw	s1,132(sp)
80003d4c:	09010113          	add	sp,sp,144
80003d50:	00008067          	ret
80003d54:	00040713          	mv	a4,s0
80003d58:	08812403          	lw	s0,136(sp)
80003d5c:	09912823          	sw	s9,144(sp)
80003d60:	08c12083          	lw	ra,140(sp)
80003d64:	06412c83          	lw	s9,100(sp)
80003d68:	00048793          	mv	a5,s1
80003d6c:	000b0893          	mv	a7,s6
80003d70:	08412483          	lw	s1,132(sp)
80003d74:	07012b03          	lw	s6,112(sp)
80003d78:	000c0813          	mv	a6,s8
80003d7c:	000a8693          	mv	a3,s5
80003d80:	06812c03          	lw	s8,104(sp)
80003d84:	07412a83          	lw	s5,116(sp)
80003d88:	00090613          	mv	a2,s2
80003d8c:	000a0593          	mv	a1,s4
80003d90:	08012903          	lw	s2,128(sp)
80003d94:	07812a03          	lw	s4,120(sp)
80003d98:	00098513          	mv	a0,s3
80003d9c:	07c12983          	lw	s3,124(sp)
80003da0:	09010113          	add	sp,sp,144
80003da4:	0480006f          	j	80003dec <_ftoa>
80003da8:	000b8593          	mv	a1,s7
80003dac:	00070613          	mv	a2,a4
80003db0:	00040513          	mv	a0,s0
80003db4:	00078693          	mv	a3,a5
80003db8:	01112823          	sw	a7,16(sp)
80003dbc:	bf4fd0ef          	jal	800011b0 <__divdf3>
80003dc0:	01012883          	lw	a7,16(sp)
80003dc4:	00a12a23          	sw	a0,20(sp)
80003dc8:	00058b93          	mv	s7,a1
80003dcc:	df5ff06f          	j	80003bc0 <_etoa+0x434>
80003dd0:	dc0c04e3          	beqz	s8,80003b98 <_etoa+0x40c>
80003dd4:	02c12683          	lw	a3,44(sp)
80003dd8:	00d036b3          	snez	a3,a3
80003ddc:	40dc0c33          	sub	s8,s8,a3
80003de0:	db9ff06f          	j	80003b98 <_etoa+0x40c>
80003de4:	00000c13          	li	s8,0
80003de8:	da5ff06f          	j	80003b8c <_etoa+0x400>

80003dec <_ftoa>:
80003dec:	f8010113          	add	sp,sp,-128
80003df0:	07512223          	sw	s5,100(sp)
80003df4:	05812c23          	sw	s8,88(sp)
80003df8:	05912a23          	sw	s9,84(sp)
80003dfc:	05a12823          	sw	s10,80(sp)
80003e00:	00050a93          	mv	s5,a0
80003e04:	00058c13          	mv	s8,a1
80003e08:	00060c93          	mv	s9,a2
80003e0c:	00068d13          	mv	s10,a3
80003e10:	00070613          	mv	a2,a4
80003e14:	00078693          	mv	a3,a5
80003e18:	00070513          	mv	a0,a4
80003e1c:	00078593          	mv	a1,a5
80003e20:	06812c23          	sw	s0,120(sp)
80003e24:	06912a23          	sw	s1,116(sp)
80003e28:	07212823          	sw	s2,112(sp)
80003e2c:	07412423          	sw	s4,104(sp)
80003e30:	05b12623          	sw	s11,76(sp)
80003e34:	06112e23          	sw	ra,124(sp)
80003e38:	08012d83          	lw	s11,128(sp)
80003e3c:	00070913          	mv	s2,a4
80003e40:	00078493          	mv	s1,a5
80003e44:	01512823          	sw	s5,16(sp)
80003e48:	00080413          	mv	s0,a6
80003e4c:	00088a13          	mv	s4,a7
80003e50:	a3dfd0ef          	jal	8000188c <__eqdf2>
80003e54:	2e051863          	bnez	a0,80004144 <_ftoa+0x358>
80003e58:	a00017b7          	lui	a5,0xa0001
80003e5c:	ce87a603          	lw	a2,-792(a5) # a0000ce8 <intpat+0x30>
80003e60:	cec7a683          	lw	a3,-788(a5)
80003e64:	00090513          	mv	a0,s2
80003e68:	00048593          	mv	a1,s1
80003e6c:	b89fd0ef          	jal	800019f4 <__ledf2>
80003e70:	3a054e63          	bltz	a0,8000422c <_ftoa+0x440>
80003e74:	a00017b7          	lui	a5,0xa0001
80003e78:	ce07a603          	lw	a2,-800(a5) # a0000ce0 <intpat+0x28>
80003e7c:	ce47a683          	lw	a3,-796(a5)
80003e80:	00090513          	mv	a0,s2
80003e84:	00048593          	mv	a1,s1
80003e88:	a91fd0ef          	jal	80001918 <__gedf2>
80003e8c:	28a04463          	bgtz	a0,80004114 <_ftoa+0x328>
80003e90:	07312623          	sw	s3,108(sp)
80003e94:	a00019b7          	lui	s3,0xa0001
80003e98:	d689a603          	lw	a2,-664(s3) # a0000d68 <intpat+0xb0>
80003e9c:	d6c9a683          	lw	a3,-660(s3)
80003ea0:	00090513          	mv	a0,s2
80003ea4:	00048593          	mv	a1,s1
80003ea8:	a71fd0ef          	jal	80001918 <__gedf2>
80003eac:	32a04463          	bgtz	a0,800041d4 <_ftoa+0x3e8>
80003eb0:	a00017b7          	lui	a5,0xa0001
80003eb4:	d707a603          	lw	a2,-656(a5) # a0000d70 <intpat+0xb8>
80003eb8:	d747a683          	lw	a3,-652(a5)
80003ebc:	00090513          	mv	a0,s2
80003ec0:	00048593          	mv	a1,s1
80003ec4:	b31fd0ef          	jal	800019f4 <__ledf2>
80003ec8:	30054663          	bltz	a0,800041d4 <_ftoa+0x3e8>
80003ecc:	00090513          	mv	a0,s2
80003ed0:	00048593          	mv	a1,s1
80003ed4:	00000613          	li	a2,0
80003ed8:	00000693          	li	a3,0
80003edc:	07612023          	sw	s6,96(sp)
80003ee0:	05712e23          	sw	s7,92(sp)
80003ee4:	b11fd0ef          	jal	800019f4 <__ledf2>
80003ee8:	2c054263          	bltz	a0,800041ac <_ftoa+0x3c0>
80003eec:	00012e23          	sw	zero,28(sp)
80003ef0:	400dfb93          	and	s7,s11,1024
80003ef4:	3a0b8c63          	beqz	s7,800042ac <_ftoa+0x4c0>
80003ef8:	00900793          	li	a5,9
80003efc:	4c87fe63          	bgeu	a5,s0,800043d8 <_ftoa+0x5ec>
80003f00:	ff740b93          	add	s7,s0,-9
80003f04:	00000693          	li	a3,0
80003f08:	02010b13          	add	s6,sp,32
80003f0c:	03000513          	li	a0,48
80003f10:	02000593          	li	a1,32
80003f14:	00168693          	add	a3,a3,1
80003f18:	00db0633          	add	a2,s6,a3
80003f1c:	fea60fa3          	sb	a0,-1(a2)
80003f20:	40d40ab3          	sub	s5,s0,a3
80003f24:	40b68a63          	beq	a3,a1,80004338 <_ftoa+0x54c>
80003f28:	ff7696e3          	bne	a3,s7,80003f14 <_ftoa+0x128>
80003f2c:	d689a783          	lw	a5,-664(s3)
80003f30:	d6c9a803          	lw	a6,-660(s3)
80003f34:	00f12423          	sw	a5,8(sp)
80003f38:	01012623          	sw	a6,12(sp)
80003f3c:	00048593          	mv	a1,s1
80003f40:	00090513          	mv	a0,s2
80003f44:	925fe0ef          	jal	80002868 <__fixdfsi>
80003f48:	00050413          	mv	s0,a0
80003f4c:	a19fe0ef          	jal	80002964 <__floatsidf>
80003f50:	00050613          	mv	a2,a0
80003f54:	00058693          	mv	a3,a1
80003f58:	00090513          	mv	a0,s2
80003f5c:	00048593          	mv	a1,s1
80003f60:	960fe0ef          	jal	800020c0 <__subdf3>
80003f64:	00812603          	lw	a2,8(sp)
80003f68:	00c12683          	lw	a3,12(sp)
80003f6c:	b65fd0ef          	jal	80001ad0 <__muldf3>
80003f70:	00b12a23          	sw	a1,20(sp)
80003f74:	00a12c23          	sw	a0,24(sp)
80003f78:	971fe0ef          	jal	800028e8 <__fixunsdfsi>
80003f7c:	00050993          	mv	s3,a0
80003f80:	a8dfe0ef          	jal	80002a0c <__floatunsidf>
80003f84:	01812303          	lw	t1,24(sp)
80003f88:	01412883          	lw	a7,20(sp)
80003f8c:	00050613          	mv	a2,a0
80003f90:	00058693          	mv	a3,a1
80003f94:	00030513          	mv	a0,t1
80003f98:	00088593          	mv	a1,a7
80003f9c:	924fe0ef          	jal	800020c0 <__subdf3>
80003fa0:	a00017b7          	lui	a5,0xa0001
80003fa4:	d187a603          	lw	a2,-744(a5) # a0000d18 <intpat+0x60>
80003fa8:	d1c7a683          	lw	a3,-740(a5)
80003fac:	00a12a23          	sw	a0,20(sp)
80003fb0:	00b12c23          	sw	a1,24(sp)
80003fb4:	965fd0ef          	jal	80001918 <__gedf2>
80003fb8:	28a05863          	blez	a0,80004248 <_ftoa+0x45c>
80003fbc:	00198993          	add	s3,s3,1
80003fc0:	00098513          	mv	a0,s3
80003fc4:	a49fe0ef          	jal	80002a0c <__floatunsidf>
80003fc8:	00812603          	lw	a2,8(sp)
80003fcc:	00c12683          	lw	a3,12(sp)
80003fd0:	949fd0ef          	jal	80001918 <__gedf2>
80003fd4:	00054663          	bltz	a0,80003fe0 <_ftoa+0x1f4>
80003fd8:	00140413          	add	s0,s0,1
80003fdc:	00000993          	li	s3,0
80003fe0:	280a8863          	beqz	s5,80004270 <_ftoa+0x484>
80003fe4:	02000493          	li	s1,32
80003fe8:	0300006f          	j	80004018 <_ftoa+0x22c>
80003fec:	cc5fe0ef          	jal	80002cb0 <__umodsi3>
80003ff0:	001b8b93          	add	s7,s7,1 # 80000001 <__start+0x1>
80003ff4:	03050693          	add	a3,a0,48
80003ff8:	017b0933          	add	s2,s6,s7
80003ffc:	00a00593          	li	a1,10
80004000:	00098513          	mv	a0,s3
80004004:	fed90fa3          	sb	a3,-1(s2)
80004008:	c61fe0ef          	jal	80002c68 <__hidden___udivsi3>
8000400c:	00900793          	li	a5,9
80004010:	2f37fa63          	bgeu	a5,s3,80004304 <_ftoa+0x518>
80004014:	00050993          	mv	s3,a0
80004018:	00a00593          	li	a1,10
8000401c:	00098513          	mv	a0,s3
80004020:	fffa8a93          	add	s5,s5,-1
80004024:	fc9b94e3          	bne	s7,s1,80003fec <_ftoa+0x200>
80004028:	02000b93          	li	s7,32
8000402c:	02000493          	li	s1,32
80004030:	02c0006f          	j	8000405c <_ftoa+0x270>
80004034:	cb1fe0ef          	jal	80002ce4 <__modsi3>
80004038:	001b8b93          	add	s7,s7,1
8000403c:	03050693          	add	a3,a0,48
80004040:	017b0933          	add	s2,s6,s7
80004044:	00040513          	mv	a0,s0
80004048:	00a00593          	li	a1,10
8000404c:	fed90fa3          	sb	a3,-1(s2)
80004050:	c11fe0ef          	jal	80002c60 <__divsi3>
80004054:	00050413          	mv	s0,a0
80004058:	26050a63          	beqz	a0,800042cc <_ftoa+0x4e0>
8000405c:	00a00593          	li	a1,10
80004060:	00040513          	mv	a0,s0
80004064:	fc9b98e3          	bne	s7,s1,80004034 <_ftoa+0x248>
80004068:	003df693          	and	a3,s11,3
8000406c:	00100613          	li	a2,1
80004070:	04c69263          	bne	a3,a2,800040b4 <_ftoa+0x2c8>
80004074:	040a0063          	beqz	s4,800040b4 <_ftoa+0x2c8>
80004078:	01c12783          	lw	a5,28(sp)
8000407c:	34079863          	bnez	a5,800043cc <_ftoa+0x5e0>
80004080:	00cdf693          	and	a3,s11,12
80004084:	34069463          	bnez	a3,800043cc <_ftoa+0x5e0>
80004088:	2d4bf463          	bgeu	s7,s4,80004350 <_ftoa+0x564>
8000408c:	02000693          	li	a3,32
80004090:	03000613          	li	a2,48
80004094:	02000593          	li	a1,32
80004098:	00db8c63          	beq	s7,a3,800040b0 <_ftoa+0x2c4>
8000409c:	001b8b93          	add	s7,s7,1
800040a0:	017b06b3          	add	a3,s6,s7
800040a4:	fec68fa3          	sb	a2,-1(a3)
800040a8:	234b8863          	beq	s7,s4,800042d8 <_ftoa+0x4ec>
800040ac:	febb98e3          	bne	s7,a1,8000409c <_ftoa+0x2b0>
800040b0:	02000b93          	li	s7,32
800040b4:	01012503          	lw	a0,16(sp)
800040b8:	000d8893          	mv	a7,s11
800040bc:	000a0813          	mv	a6,s4
800040c0:	000b8793          	mv	a5,s7
800040c4:	000b0713          	mv	a4,s6
800040c8:	000d0693          	mv	a3,s10
800040cc:	000c8613          	mv	a2,s9
800040d0:	000c0593          	mv	a1,s8
800040d4:	a20ff0ef          	jal	800032f4 <_out_rev>
800040d8:	07c12083          	lw	ra,124(sp)
800040dc:	07812403          	lw	s0,120(sp)
800040e0:	06c12983          	lw	s3,108(sp)
800040e4:	06012b03          	lw	s6,96(sp)
800040e8:	05c12b83          	lw	s7,92(sp)
800040ec:	07412483          	lw	s1,116(sp)
800040f0:	07012903          	lw	s2,112(sp)
800040f4:	06812a03          	lw	s4,104(sp)
800040f8:	06412a83          	lw	s5,100(sp)
800040fc:	05812c03          	lw	s8,88(sp)
80004100:	05412c83          	lw	s9,84(sp)
80004104:	05012d03          	lw	s10,80(sp)
80004108:	04c12d83          	lw	s11,76(sp)
8000410c:	08010113          	add	sp,sp,128
80004110:	00008067          	ret
80004114:	004df793          	and	a5,s11,4
80004118:	08079063          	bnez	a5,80004198 <_ftoa+0x3ac>
8000411c:	a0000737          	lui	a4,0xa0000
80004120:	5dc70713          	add	a4,a4,1500 # a00005dc <__clz_tab+0x5a0>
80004124:	00300793          	li	a5,3
80004128:	000a8513          	mv	a0,s5
8000412c:	000d8893          	mv	a7,s11
80004130:	000a0813          	mv	a6,s4
80004134:	000d0693          	mv	a3,s10
80004138:	000c8613          	mv	a2,s9
8000413c:	000c0593          	mv	a1,s8
80004140:	0280006f          	j	80004168 <_ftoa+0x37c>
80004144:	a0000737          	lui	a4,0xa0000
80004148:	000d8893          	mv	a7,s11
8000414c:	000a0813          	mv	a6,s4
80004150:	00300793          	li	a5,3
80004154:	5e070713          	add	a4,a4,1504 # a00005e0 <__clz_tab+0x5a4>
80004158:	000d0693          	mv	a3,s10
8000415c:	000c8613          	mv	a2,s9
80004160:	000c0593          	mv	a1,s8
80004164:	000a8513          	mv	a0,s5
80004168:	07812403          	lw	s0,120(sp)
8000416c:	07c12083          	lw	ra,124(sp)
80004170:	07412483          	lw	s1,116(sp)
80004174:	07012903          	lw	s2,112(sp)
80004178:	06812a03          	lw	s4,104(sp)
8000417c:	06412a83          	lw	s5,100(sp)
80004180:	05812c03          	lw	s8,88(sp)
80004184:	05412c83          	lw	s9,84(sp)
80004188:	05012d03          	lw	s10,80(sp)
8000418c:	04c12d83          	lw	s11,76(sp)
80004190:	08010113          	add	sp,sp,128
80004194:	960ff06f          	j	800032f4 <_out_rev>
80004198:	a0000737          	lui	a4,0xa0000
8000419c:	5d470713          	add	a4,a4,1492 # a00005d4 <__clz_tab+0x598>
800041a0:	00400793          	li	a5,4
800041a4:	000a8513          	mv	a0,s5
800041a8:	f85ff06f          	j	8000412c <_ftoa+0x340>
800041ac:	00090613          	mv	a2,s2
800041b0:	00048693          	mv	a3,s1
800041b4:	00000513          	li	a0,0
800041b8:	00000593          	li	a1,0
800041bc:	f05fd0ef          	jal	800020c0 <__subdf3>
800041c0:	00100793          	li	a5,1
800041c4:	00050913          	mv	s2,a0
800041c8:	00058493          	mv	s1,a1
800041cc:	00f12e23          	sw	a5,28(sp)
800041d0:	d21ff06f          	j	80003ef0 <_ftoa+0x104>
800041d4:	00040813          	mv	a6,s0
800041d8:	07812403          	lw	s0,120(sp)
800041dc:	09b12023          	sw	s11,128(sp)
800041e0:	01012503          	lw	a0,16(sp)
800041e4:	06c12983          	lw	s3,108(sp)
800041e8:	07c12083          	lw	ra,124(sp)
800041ec:	06412a83          	lw	s5,100(sp)
800041f0:	04c12d83          	lw	s11,76(sp)
800041f4:	00090713          	mv	a4,s2
800041f8:	00048793          	mv	a5,s1
800041fc:	07012903          	lw	s2,112(sp)
80004200:	07412483          	lw	s1,116(sp)
80004204:	000a0893          	mv	a7,s4
80004208:	000d0693          	mv	a3,s10
8000420c:	06812a03          	lw	s4,104(sp)
80004210:	05012d03          	lw	s10,80(sp)
80004214:	000c8613          	mv	a2,s9
80004218:	000c0593          	mv	a1,s8
8000421c:	05412c83          	lw	s9,84(sp)
80004220:	05812c03          	lw	s8,88(sp)
80004224:	08010113          	add	sp,sp,128
80004228:	d64ff06f          	j	8000378c <_etoa>
8000422c:	a0000737          	lui	a4,0xa0000
80004230:	000a8513          	mv	a0,s5
80004234:	000d8893          	mv	a7,s11
80004238:	000a0813          	mv	a6,s4
8000423c:	00400793          	li	a5,4
80004240:	5e470713          	add	a4,a4,1508 # a00005e4 <__clz_tab+0x5a8>
80004244:	ef1ff06f          	j	80004134 <_ftoa+0x348>
80004248:	a00017b7          	lui	a5,0xa0001
8000424c:	01412503          	lw	a0,20(sp)
80004250:	01812583          	lw	a1,24(sp)
80004254:	d187a603          	lw	a2,-744(a5) # a0000d18 <intpat+0x60>
80004258:	d1c7a683          	lw	a3,-740(a5)
8000425c:	f98fd0ef          	jal	800019f4 <__ledf2>
80004260:	d80540e3          	bltz	a0,80003fe0 <_ftoa+0x1f4>
80004264:	14099c63          	bnez	s3,800043bc <_ftoa+0x5d0>
80004268:	00198993          	add	s3,s3,1
8000426c:	d60a9ce3          	bnez	s5,80003fe4 <_ftoa+0x1f8>
80004270:	00040513          	mv	a0,s0
80004274:	ef0fe0ef          	jal	80002964 <__floatsidf>
80004278:	00050613          	mv	a2,a0
8000427c:	00058693          	mv	a3,a1
80004280:	00090513          	mv	a0,s2
80004284:	00048593          	mv	a1,s1
80004288:	e39fd0ef          	jal	800020c0 <__subdf3>
8000428c:	a00017b7          	lui	a5,0xa0001
80004290:	d187a603          	lw	a2,-744(a5) # a0000d18 <intpat+0x60>
80004294:	d1c7a683          	lw	a3,-740(a5)
80004298:	f5cfd0ef          	jal	800019f4 <__ledf2>
8000429c:	d80548e3          	bltz	a0,8000402c <_ftoa+0x240>
800042a0:	00147693          	and	a3,s0,1
800042a4:	00d40433          	add	s0,s0,a3
800042a8:	d85ff06f          	j	8000402c <_ftoa+0x240>
800042ac:	a0001737          	lui	a4,0xa0001
800042b0:	d6072783          	lw	a5,-672(a4) # a0000d60 <intpat+0xa8>
800042b4:	d6472803          	lw	a6,-668(a4)
800042b8:	00600a93          	li	s5,6
800042bc:	00f12423          	sw	a5,8(sp)
800042c0:	01012623          	sw	a6,12(sp)
800042c4:	02010b13          	add	s6,sp,32
800042c8:	c75ff06f          	j	80003f3c <_ftoa+0x150>
800042cc:	003df693          	and	a3,s11,3
800042d0:	00100613          	li	a2,1
800042d4:	12c68a63          	beq	a3,a2,80004408 <_ftoa+0x61c>
800042d8:	02000693          	li	a3,32
800042dc:	dcdb8ce3          	beq	s7,a3,800040b4 <_ftoa+0x2c8>
800042e0:	01c12783          	lw	a5,28(sp)
800042e4:	06078a63          	beqz	a5,80004358 <_ftoa+0x56c>
800042e8:	020b8793          	add	a5,s7,32
800042ec:	02010713          	add	a4,sp,32
800042f0:	00e786b3          	add	a3,a5,a4
800042f4:	02d00613          	li	a2,45
800042f8:	fec68023          	sb	a2,-32(a3)
800042fc:	001b8b93          	add	s7,s7,1
80004300:	db5ff06f          	j	800040b4 <_ftoa+0x2c8>
80004304:	d29b82e3          	beq	s7,s1,80004028 <_ftoa+0x23c>
80004308:	017a8533          	add	a0,s5,s7
8000430c:	03000593          	li	a1,48
80004310:	02000613          	li	a2,32
80004314:	000a9663          	bnez	s5,80004320 <_ftoa+0x534>
80004318:	06c0006f          	j	80004384 <_ftoa+0x598>
8000431c:	06ab8463          	beq	s7,a0,80004384 <_ftoa+0x598>
80004320:	001b8b93          	add	s7,s7,1
80004324:	017b06b3          	add	a3,s6,s7
80004328:	feb68fa3          	sb	a1,-1(a3)
8000432c:	fecb98e3          	bne	s7,a2,8000431c <_ftoa+0x530>
80004330:	02000b93          	li	s7,32
80004334:	cf9ff06f          	j	8000402c <_ftoa+0x240>
80004338:	d689a783          	lw	a5,-664(s3)
8000433c:	d6c9a803          	lw	a6,-660(s3)
80004340:	02000b93          	li	s7,32
80004344:	00f12423          	sw	a5,8(sp)
80004348:	01012623          	sw	a6,12(sp)
8000434c:	bf1ff06f          	j	80003f3c <_ftoa+0x150>
80004350:	02000693          	li	a3,32
80004354:	d6db80e3          	beq	s7,a3,800040b4 <_ftoa+0x2c8>
80004358:	004df693          	and	a3,s11,4
8000435c:	04069263          	bnez	a3,800043a0 <_ftoa+0x5b4>
80004360:	008df693          	and	a3,s11,8
80004364:	d40688e3          	beqz	a3,800040b4 <_ftoa+0x2c8>
80004368:	020b8793          	add	a5,s7,32
8000436c:	02010713          	add	a4,sp,32
80004370:	00e786b3          	add	a3,a5,a4
80004374:	02000613          	li	a2,32
80004378:	fec68023          	sb	a2,-32(a3)
8000437c:	001b8b93          	add	s7,s7,1
80004380:	d35ff06f          	j	800040b4 <_ftoa+0x2c8>
80004384:	020b8793          	add	a5,s7,32
80004388:	02010713          	add	a4,sp,32
8000438c:	00e786b3          	add	a3,a5,a4
80004390:	02e00613          	li	a2,46
80004394:	fec68023          	sb	a2,-32(a3)
80004398:	001b8b93          	add	s7,s7,1
8000439c:	c91ff06f          	j	8000402c <_ftoa+0x240>
800043a0:	020b8793          	add	a5,s7,32
800043a4:	02010713          	add	a4,sp,32
800043a8:	00e786b3          	add	a3,a5,a4
800043ac:	02b00613          	li	a2,43
800043b0:	fec68023          	sb	a2,-32(a3)
800043b4:	001b8b93          	add	s7,s7,1
800043b8:	cfdff06f          	j	800040b4 <_ftoa+0x2c8>
800043bc:	0019f693          	and	a3,s3,1
800043c0:	c20680e3          	beqz	a3,80003fe0 <_ftoa+0x1f4>
800043c4:	00198993          	add	s3,s3,1
800043c8:	ea5ff06f          	j	8000426c <_ftoa+0x480>
800043cc:	fffa0a13          	add	s4,s4,-1
800043d0:	cb4beee3          	bltu	s7,s4,8000408c <_ftoa+0x2a0>
800043d4:	f05ff06f          	j	800042d8 <_ftoa+0x4ec>
800043d8:	a00017b7          	lui	a5,0xa0001
800043dc:	00341713          	sll	a4,s0,0x3
800043e0:	c3878793          	add	a5,a5,-968 # a0000c38 <pow10.0>
800043e4:	00e787b3          	add	a5,a5,a4
800043e8:	0047a803          	lw	a6,4(a5)
800043ec:	0007a783          	lw	a5,0(a5)
800043f0:	00040a93          	mv	s5,s0
800043f4:	01012623          	sw	a6,12(sp)
800043f8:	00f12423          	sw	a5,8(sp)
800043fc:	00000b93          	li	s7,0
80004400:	02010b13          	add	s6,sp,32
80004404:	b39ff06f          	j	80003f3c <_ftoa+0x150>
80004408:	ec0a08e3          	beqz	s4,800042d8 <_ftoa+0x4ec>
8000440c:	c6dff06f          	j	80004078 <_ftoa+0x28c>

80004410 <_vsnprintf>:
80004410:	f6010113          	add	sp,sp,-160
80004414:	09212823          	sw	s2,144(sp)
80004418:	09612023          	sw	s6,128(sp)
8000441c:	07712e23          	sw	s7,124(sp)
80004420:	07912a23          	sw	s9,116(sp)
80004424:	08112e23          	sw	ra,156(sp)
80004428:	08812c23          	sw	s0,152(sp)
8000442c:	08912a23          	sw	s1,148(sp)
80004430:	00068913          	mv	s2,a3
80004434:	00058b13          	mv	s6,a1
80004438:	00060693          	mv	a3,a2
8000443c:	00070c93          	mv	s9,a4
80004440:	00050b93          	mv	s7,a0
80004444:	52058663          	beqz	a1,80004970 <_vsnprintf+0x560>
80004448:	00094503          	lbu	a0,0(s2)
8000444c:	00000413          	li	s0,0
80004450:	52050a63          	beqz	a0,80004984 <_vsnprintf+0x574>
80004454:	a00017b7          	lui	a5,0xa0001
80004458:	09412423          	sw	s4,136(sp)
8000445c:	ae078793          	add	a5,a5,-1312 # a0000ae0 <__clz_tab+0xaa4>
80004460:	a0001a37          	lui	s4,0xa0001
80004464:	09312623          	sw	s3,140(sp)
80004468:	09512223          	sw	s5,132(sp)
8000446c:	07812c23          	sw	s8,120(sp)
80004470:	07a12823          	sw	s10,112(sp)
80004474:	01000993          	li	s3,16
80004478:	a9ca0a13          	add	s4,s4,-1380 # a0000a9c <__clz_tab+0xa60>
8000447c:	00900a93          	li	s5,9
80004480:	02f12023          	sw	a5,32(sp)
80004484:	00d12e23          	sw	a3,28(sp)
80004488:	0200006f          	j	800044a8 <_vsnprintf+0x98>
8000448c:	01c12683          	lw	a3,28(sp)
80004490:	00040613          	mv	a2,s0
80004494:	000b0593          	mv	a1,s6
80004498:	00140413          	add	s0,s0,1
8000449c:	000b80e7          	jalr	s7
800044a0:	00094503          	lbu	a0,0(s2)
800044a4:	18050063          	beqz	a0,80004624 <_vsnprintf+0x214>
800044a8:	02500793          	li	a5,37
800044ac:	00190913          	add	s2,s2,1
800044b0:	fcf51ee3          	bne	a0,a5,8000448c <_vsnprintf+0x7c>
800044b4:	00000693          	li	a3,0
800044b8:	00094503          	lbu	a0,0(s2)
800044bc:	00190713          	add	a4,s2,1
800044c0:	fe050793          	add	a5,a0,-32
800044c4:	0ff7f793          	zext.b	a5,a5
800044c8:	00f9ea63          	bltu	s3,a5,800044dc <_vsnprintf+0xcc>
800044cc:	00279793          	sll	a5,a5,0x2
800044d0:	014787b3          	add	a5,a5,s4
800044d4:	0007a783          	lw	a5,0(a5)
800044d8:	00078067          	jr	a5
800044dc:	fd050793          	add	a5,a0,-48
800044e0:	0ff7f793          	zext.b	a5,a5
800044e4:	0cfaf263          	bgeu	s5,a5,800045a8 <_vsnprintf+0x198>
800044e8:	02a00793          	li	a5,42
800044ec:	00000893          	li	a7,0
800044f0:	24f50a63          	beq	a0,a5,80004744 <_vsnprintf+0x334>
800044f4:	02e00793          	li	a5,46
800044f8:	00000813          	li	a6,0
800044fc:	0ef50c63          	beq	a0,a5,800045f4 <_vsnprintf+0x1e4>
80004500:	f9850793          	add	a5,a0,-104
80004504:	0ff7f793          	zext.b	a5,a5
80004508:	01200613          	li	a2,18
8000450c:	06f66063          	bltu	a2,a5,8000456c <_vsnprintf+0x15c>
80004510:	02012603          	lw	a2,32(sp)
80004514:	00279793          	sll	a5,a5,0x2
80004518:	00c787b3          	add	a5,a5,a2
8000451c:	0007a783          	lw	a5,0(a5)
80004520:	00078067          	jr	a5
80004524:	0016e693          	or	a3,a3,1
80004528:	00070913          	mv	s2,a4
8000452c:	f8dff06f          	j	800044b8 <_vsnprintf+0xa8>
80004530:	0026e693          	or	a3,a3,2
80004534:	00070913          	mv	s2,a4
80004538:	f81ff06f          	j	800044b8 <_vsnprintf+0xa8>
8000453c:	0046e693          	or	a3,a3,4
80004540:	00070913          	mv	s2,a4
80004544:	f75ff06f          	j	800044b8 <_vsnprintf+0xa8>
80004548:	0106e693          	or	a3,a3,16
8000454c:	00070913          	mv	s2,a4
80004550:	f69ff06f          	j	800044b8 <_vsnprintf+0xa8>
80004554:	0086e693          	or	a3,a3,8
80004558:	00070913          	mv	s2,a4
8000455c:	f5dff06f          	j	800044b8 <_vsnprintf+0xa8>
80004560:	00194503          	lbu	a0,1(s2)
80004564:	1006e693          	or	a3,a3,256
80004568:	00170713          	add	a4,a4,1
8000456c:	06700793          	li	a5,103
80004570:	00070913          	mv	s2,a4
80004574:	10a7e663          	bltu	a5,a0,80004680 <_vsnprintf+0x270>
80004578:	02400793          	li	a5,36
8000457c:	f0a7f8e3          	bgeu	a5,a0,8000448c <_vsnprintf+0x7c>
80004580:	fdb50793          	add	a5,a0,-37
80004584:	0ff7f793          	zext.b	a5,a5
80004588:	04200713          	li	a4,66
8000458c:	f0f760e3          	bltu	a4,a5,8000448c <_vsnprintf+0x7c>
80004590:	a0001737          	lui	a4,0xa0001
80004594:	00279793          	sll	a5,a5,0x2
80004598:	b2c70713          	add	a4,a4,-1236 # a0000b2c <__clz_tab+0xaf0>
8000459c:	00e787b3          	add	a5,a5,a4
800045a0:	0007a783          	lw	a5,0(a5)
800045a4:	00078067          	jr	a5
800045a8:	00000893          	li	a7,0
800045ac:	00088613          	mv	a2,a7
800045b0:	0080006f          	j	800045b8 <_vsnprintf+0x1a8>
800045b4:	00170713          	add	a4,a4,1
800045b8:	00261893          	sll	a7,a2,0x2
800045bc:	00c888b3          	add	a7,a7,a2
800045c0:	00189893          	sll	a7,a7,0x1
800045c4:	00a888b3          	add	a7,a7,a0
800045c8:	00074503          	lbu	a0,0(a4)
800045cc:	00070913          	mv	s2,a4
800045d0:	fd088613          	add	a2,a7,-48 # ffd0 <__stack_size+0xbfd0>
800045d4:	fd050793          	add	a5,a0,-48
800045d8:	0ff7f793          	zext.b	a5,a5
800045dc:	fcfafce3          	bgeu	s5,a5,800045b4 <_vsnprintf+0x1a4>
800045e0:	02e00793          	li	a5,46
800045e4:	00060893          	mv	a7,a2
800045e8:	00170713          	add	a4,a4,1
800045ec:	00000813          	li	a6,0
800045f0:	f0f518e3          	bne	a0,a5,80004500 <_vsnprintf+0xf0>
800045f4:	00194503          	lbu	a0,1(s2)
800045f8:	00900593          	li	a1,9
800045fc:	00070613          	mv	a2,a4
80004600:	fd050793          	add	a5,a0,-48
80004604:	0ff7f793          	zext.b	a5,a5
80004608:	4006e693          	or	a3,a3,1024
8000460c:	3af5f863          	bgeu	a1,a5,800049bc <_vsnprintf+0x5ac>
80004610:	02a00793          	li	a5,42
80004614:	3ef50063          	beq	a0,a5,800049f4 <_vsnprintf+0x5e4>
80004618:	00070913          	mv	s2,a4
8000461c:	00170713          	add	a4,a4,1
80004620:	ee1ff06f          	j	80004500 <_vsnprintf+0xf0>
80004624:	01c12683          	lw	a3,28(sp)
80004628:	08c12983          	lw	s3,140(sp)
8000462c:	08812a03          	lw	s4,136(sp)
80004630:	08412a83          	lw	s5,132(sp)
80004634:	07812c03          	lw	s8,120(sp)
80004638:	07012d03          	lw	s10,112(sp)
8000463c:	00040493          	mv	s1,s0
80004640:	00d46463          	bltu	s0,a3,80004648 <_vsnprintf+0x238>
80004644:	fff68413          	add	s0,a3,-1
80004648:	00040613          	mv	a2,s0
8000464c:	000b0593          	mv	a1,s6
80004650:	00000513          	li	a0,0
80004654:	000b80e7          	jalr	s7
80004658:	09c12083          	lw	ra,156(sp)
8000465c:	09812403          	lw	s0,152(sp)
80004660:	09012903          	lw	s2,144(sp)
80004664:	08012b03          	lw	s6,128(sp)
80004668:	07c12b83          	lw	s7,124(sp)
8000466c:	07412c83          	lw	s9,116(sp)
80004670:	00048513          	mv	a0,s1
80004674:	09412483          	lw	s1,148(sp)
80004678:	0a010113          	add	sp,sp,160
8000467c:	00008067          	ret
80004680:	f9750793          	add	a5,a0,-105
80004684:	0ff7f793          	zext.b	a5,a5
80004688:	00f00713          	li	a4,15
8000468c:	e0f760e3          	bltu	a4,a5,8000448c <_vsnprintf+0x7c>
80004690:	00009737          	lui	a4,0x9
80004694:	00100c13          	li	s8,1
80004698:	00fc1c33          	sll	s8,s8,a5
8000469c:	04170713          	add	a4,a4,65 # 9041 <__stack_size+0x5041>
800046a0:	00ec7c33          	and	s8,s8,a4
800046a4:	2e0c1663          	bnez	s8,80004990 <_vsnprintf+0x580>
800046a8:	00a00713          	li	a4,10
800046ac:	0ae78a63          	beq	a5,a4,80004760 <_vsnprintf+0x350>
800046b0:	00700713          	li	a4,7
800046b4:	dce79ce3          	bne	a5,a4,8000448c <_vsnprintf+0x7c>
800046b8:	000ca783          	lw	a5,0(s9)
800046bc:	0216e613          	or	a2,a3,33
800046c0:	004c8c93          	add	s9,s9,4
800046c4:	36078063          	beqz	a5,80004a24 <_vsnprintf+0x614>
800046c8:	04010d13          	add	s10,sp,64
800046cc:	00900893          	li	a7,9
800046d0:	00f00513          	li	a0,15
800046d4:	02000313          	li	t1,32
800046d8:	00c0006f          	j	800046e4 <_vsnprintf+0x2d4>
800046dc:	026c0663          	beq	s8,t1,80004708 <_vsnprintf+0x2f8>
800046e0:	00070793          	mv	a5,a4
800046e4:	00f7f593          	and	a1,a5,15
800046e8:	03758693          	add	a3,a1,55 # c0001037 <__stack_base+0x1fff1037>
800046ec:	00b8e463          	bltu	a7,a1,800046f4 <_vsnprintf+0x2e4>
800046f0:	03058693          	add	a3,a1,48
800046f4:	001c0c13          	add	s8,s8,1
800046f8:	018d0733          	add	a4,s10,s8
800046fc:	fed70fa3          	sb	a3,-1(a4)
80004700:	0047d713          	srl	a4,a5,0x4
80004704:	fcf56ce3          	bltu	a0,a5,800046dc <_vsnprintf+0x2cc>
80004708:	01c12683          	lw	a3,28(sp)
8000470c:	00800793          	li	a5,8
80004710:	00c12423          	sw	a2,8(sp)
80004714:	00f12223          	sw	a5,4(sp)
80004718:	01012023          	sw	a6,0(sp)
8000471c:	00040613          	mv	a2,s0
80004720:	01000893          	li	a7,16
80004724:	00000813          	li	a6,0
80004728:	000c0793          	mv	a5,s8
8000472c:	000d0713          	mv	a4,s10
80004730:	000b0593          	mv	a1,s6
80004734:	000b8513          	mv	a0,s7
80004738:	cf5fe0ef          	jal	8000342c <_ntoa_format>
8000473c:	00050413          	mv	s0,a0
80004740:	d61ff06f          	j	800044a0 <_vsnprintf+0x90>
80004744:	000ca883          	lw	a7,0(s9)
80004748:	004c8c93          	add	s9,s9,4
8000474c:	0c08c263          	bltz	a7,80004810 <_vsnprintf+0x400>
80004750:	00194503          	lbu	a0,1(s2)
80004754:	00070913          	mv	s2,a4
80004758:	00170713          	add	a4,a4,1
8000475c:	d99ff06f          	j	800044f4 <_vsnprintf+0xe4>
80004760:	07b12623          	sw	s11,108(sp)
80004764:	000cad83          	lw	s11,0(s9)
80004768:	004c8493          	add	s1,s9,4
8000476c:	000dc603          	lbu	a2,0(s11)
80004770:	00060513          	mv	a0,a2
80004774:	2a081263          	bnez	a6,80004a18 <_vsnprintf+0x608>
80004778:	02060663          	beqz	a2,800047a4 <_vsnprintf+0x394>
8000477c:	ffe00713          	li	a4,-2
80004780:	00170713          	add	a4,a4,1
80004784:	00ed8733          	add	a4,s11,a4
80004788:	000d8c13          	mv	s8,s11
8000478c:	0080006f          	j	80004794 <_vsnprintf+0x384>
80004790:	00ec0863          	beq	s8,a4,800047a0 <_vsnprintf+0x390>
80004794:	001c4783          	lbu	a5,1(s8)
80004798:	001c0c13          	add	s8,s8,1
8000479c:	fe079ae3          	bnez	a5,80004790 <_vsnprintf+0x380>
800047a0:	41bc0c33          	sub	s8,s8,s11
800047a4:	4006fd13          	and	s10,a3,1024
800047a8:	000d0663          	beqz	s10,800047b4 <_vsnprintf+0x3a4>
800047ac:	01887463          	bgeu	a6,s8,800047b4 <_vsnprintf+0x3a4>
800047b0:	00080c13          	mv	s8,a6
800047b4:	0026f693          	and	a3,a3,2
800047b8:	46068463          	beqz	a3,80004c20 <_vsnprintf+0x810>
800047bc:	3a060c63          	beqz	a2,80004b74 <_vsnprintf+0x764>
800047c0:	340d0a63          	beqz	s10,80004b14 <_vsnprintf+0x704>
800047c4:	02912423          	sw	s1,40(sp)
800047c8:	01c12483          	lw	s1,28(sp)
800047cc:	00880cb3          	add	s9,a6,s0
800047d0:	03112223          	sw	a7,36(sp)
800047d4:	00040793          	mv	a5,s0
800047d8:	00068d13          	mv	s10,a3
800047dc:	03212623          	sw	s2,44(sp)
800047e0:	40fc8463          	beq	s9,a5,80004be8 <_vsnprintf+0x7d8>
800047e4:	00048693          	mv	a3,s1
800047e8:	00078613          	mv	a2,a5
800047ec:	000b0593          	mv	a1,s6
800047f0:	00178913          	add	s2,a5,1
800047f4:	000b80e7          	jalr	s7
800047f8:	40890733          	sub	a4,s2,s0
800047fc:	00ed8733          	add	a4,s11,a4
80004800:	00074503          	lbu	a0,0(a4)
80004804:	40050063          	beqz	a0,80004c04 <_vsnprintf+0x7f4>
80004808:	00090793          	mv	a5,s2
8000480c:	fd5ff06f          	j	800047e0 <_vsnprintf+0x3d0>
80004810:	00194503          	lbu	a0,1(s2)
80004814:	0026e693          	or	a3,a3,2
80004818:	00070913          	mv	s2,a4
8000481c:	411008b3          	neg	a7,a7
80004820:	00170713          	add	a4,a4,1
80004824:	cd1ff06f          	j	800044f4 <_vsnprintf+0xe4>
80004828:	00194503          	lbu	a0,1(s2)
8000482c:	06c00793          	li	a5,108
80004830:	d2f51ae3          	bne	a0,a5,80004564 <_vsnprintf+0x154>
80004834:	00294503          	lbu	a0,2(s2)
80004838:	3006e693          	or	a3,a3,768
8000483c:	00390713          	add	a4,s2,3
80004840:	d2dff06f          	j	8000456c <_vsnprintf+0x15c>
80004844:	00194503          	lbu	a0,1(s2)
80004848:	2006e693          	or	a3,a3,512
8000484c:	00170713          	add	a4,a4,1
80004850:	d1dff06f          	j	8000456c <_vsnprintf+0x15c>
80004854:	00194503          	lbu	a0,1(s2)
80004858:	06800793          	li	a5,104
8000485c:	36f50463          	beq	a0,a5,80004bc4 <_vsnprintf+0x7b4>
80004860:	0806e693          	or	a3,a3,128
80004864:	00170713          	add	a4,a4,1
80004868:	d05ff06f          	j	8000456c <_vsnprintf+0x15c>
8000486c:	06700793          	li	a5,103
80004870:	1cf50a63          	beq	a0,a5,80004a44 <_vsnprintf+0x634>
80004874:	04700793          	li	a5,71
80004878:	32f50c63          	beq	a0,a5,80004bb0 <_vsnprintf+0x7a0>
8000487c:	04500793          	li	a5,69
80004880:	32f50e63          	beq	a0,a5,80004bbc <_vsnprintf+0x7ac>
80004884:	007c8c93          	add	s9,s9,7
80004888:	ff8cfc93          	and	s9,s9,-8
8000488c:	000ca703          	lw	a4,0(s9)
80004890:	004ca783          	lw	a5,4(s9)
80004894:	00d12023          	sw	a3,0(sp)
80004898:	01c12683          	lw	a3,28(sp)
8000489c:	00040613          	mv	a2,s0
800048a0:	000b0593          	mv	a1,s6
800048a4:	000b8513          	mv	a0,s7
800048a8:	ee5fe0ef          	jal	8000378c <_etoa>
800048ac:	008c8c93          	add	s9,s9,8
800048b0:	00050413          	mv	s0,a0
800048b4:	bedff06f          	j	800044a0 <_vsnprintf+0x90>
800048b8:	04600793          	li	a5,70
800048bc:	18f50063          	beq	a0,a5,80004a3c <_vsnprintf+0x62c>
800048c0:	007c8c93          	add	s9,s9,7
800048c4:	ff8cfc93          	and	s9,s9,-8
800048c8:	000ca703          	lw	a4,0(s9)
800048cc:	004ca783          	lw	a5,4(s9)
800048d0:	00d12023          	sw	a3,0(sp)
800048d4:	01c12683          	lw	a3,28(sp)
800048d8:	00040613          	mv	a2,s0
800048dc:	000b0593          	mv	a1,s6
800048e0:	000b8513          	mv	a0,s7
800048e4:	d08ff0ef          	jal	80003dec <_ftoa>
800048e8:	008c8c93          	add	s9,s9,8
800048ec:	00050413          	mv	s0,a0
800048f0:	bb1ff06f          	j	800044a0 <_vsnprintf+0x90>
800048f4:	01c12683          	lw	a3,28(sp)
800048f8:	00040613          	mv	a2,s0
800048fc:	000b0593          	mv	a1,s6
80004900:	02500513          	li	a0,37
80004904:	00140413          	add	s0,s0,1
80004908:	000b80e7          	jalr	s7
8000490c:	b95ff06f          	j	800044a0 <_vsnprintf+0x90>
80004910:	0026f693          	and	a3,a3,2
80004914:	004c8d13          	add	s10,s9,4
80004918:	00140c13          	add	s8,s0,1
8000491c:	36068263          	beqz	a3,80004c80 <_vsnprintf+0x870>
80004920:	000cc503          	lbu	a0,0(s9)
80004924:	01c12683          	lw	a3,28(sp)
80004928:	03112223          	sw	a7,36(sp)
8000492c:	00040613          	mv	a2,s0
80004930:	000b0593          	mv	a1,s6
80004934:	000b80e7          	jalr	s7
80004938:	02412883          	lw	a7,36(sp)
8000493c:	00100793          	li	a5,1
80004940:	01140433          	add	s0,s0,a7
80004944:	3f17f263          	bgeu	a5,a7,80004d28 <_vsnprintf+0x918>
80004948:	01c12483          	lw	s1,28(sp)
8000494c:	000c0613          	mv	a2,s8
80004950:	00048693          	mv	a3,s1
80004954:	001c0c13          	add	s8,s8,1
80004958:	000b0593          	mv	a1,s6
8000495c:	02000513          	li	a0,32
80004960:	000b80e7          	jalr	s7
80004964:	fe8c14e3          	bne	s8,s0,8000494c <_vsnprintf+0x53c>
80004968:	000d0c93          	mv	s9,s10
8000496c:	b35ff06f          	j	800044a0 <_vsnprintf+0x90>
80004970:	00094503          	lbu	a0,0(s2)
80004974:	80003337          	lui	t1,0x80003
80004978:	2f030b93          	add	s7,t1,752 # 800032f0 <_out_null>
8000497c:	00000413          	li	s0,0
80004980:	ac051ae3          	bnez	a0,80004454 <_vsnprintf+0x44>
80004984:	00000493          	li	s1,0
80004988:	ccd460e3          	bltu	s0,a3,80004648 <_vsnprintf+0x238>
8000498c:	cb9ff06f          	j	80004644 <_vsnprintf+0x234>
80004990:	07b12623          	sw	s11,108(sp)
80004994:	06f00793          	li	a5,111
80004998:	0af50e63          	beq	a0,a5,80004a54 <_vsnprintf+0x644>
8000499c:	4aa7f663          	bgeu	a5,a0,80004e48 <_vsnprintf+0xa38>
800049a0:	07800793          	li	a5,120
800049a4:	34f50c63          	beq	a0,a5,80004cfc <_vsnprintf+0x8ec>
800049a8:	fef6f693          	and	a3,a3,-17
800049ac:	00a00613          	li	a2,10
800049b0:	00000f13          	li	t5,0
800049b4:	00a00c13          	li	s8,10
800049b8:	0a80006f          	j	80004a60 <_vsnprintf+0x650>
800049bc:	00900713          	li	a4,9
800049c0:	00281793          	sll	a5,a6,0x2
800049c4:	010787b3          	add	a5,a5,a6
800049c8:	00160613          	add	a2,a2,1
800049cc:	00179793          	sll	a5,a5,0x1
800049d0:	00a787b3          	add	a5,a5,a0
800049d4:	00064503          	lbu	a0,0(a2)
800049d8:	fd078813          	add	a6,a5,-48
800049dc:	fd050793          	add	a5,a0,-48
800049e0:	0ff7f793          	zext.b	a5,a5
800049e4:	fcf77ee3          	bgeu	a4,a5,800049c0 <_vsnprintf+0x5b0>
800049e8:	00060913          	mv	s2,a2
800049ec:	00160713          	add	a4,a2,1
800049f0:	b11ff06f          	j	80004500 <_vsnprintf+0xf0>
800049f4:	000ca803          	lw	a6,0(s9)
800049f8:	00294503          	lbu	a0,2(s2)
800049fc:	00290913          	add	s2,s2,2
80004a00:	fff84793          	not	a5,a6
80004a04:	41f7d793          	sra	a5,a5,0x1f
80004a08:	00f87833          	and	a6,a6,a5
80004a0c:	004c8c93          	add	s9,s9,4
80004a10:	00190713          	add	a4,s2,1
80004a14:	aedff06f          	j	80004500 <_vsnprintf+0xf0>
80004a18:	d80606e3          	beqz	a2,800047a4 <_vsnprintf+0x394>
80004a1c:	fff80713          	add	a4,a6,-1
80004a20:	d61ff06f          	j	80004780 <_vsnprintf+0x370>
80004a24:	fef6f613          	and	a2,a3,-17
80004a28:	4006f793          	and	a5,a3,1024
80004a2c:	02166613          	or	a2,a2,33
80004a30:	04010d13          	add	s10,sp,64
80004a34:	cc079ae3          	bnez	a5,80004708 <_vsnprintf+0x2f8>
80004a38:	c91ff06f          	j	800046c8 <_vsnprintf+0x2b8>
80004a3c:	0206e693          	or	a3,a3,32
80004a40:	e81ff06f          	j	800048c0 <_vsnprintf+0x4b0>
80004a44:	000017b7          	lui	a5,0x1
80004a48:	80078793          	add	a5,a5,-2048 # 800 <__stack_size-0x3800>
80004a4c:	00f6e6b3          	or	a3,a3,a5
80004a50:	e35ff06f          	j	80004884 <_vsnprintf+0x474>
80004a54:	00800613          	li	a2,8
80004a58:	00000f13          	li	t5,0
80004a5c:	00800c13          	li	s8,8
80004a60:	4006f593          	and	a1,a3,1024
80004a64:	ff36fe93          	and	t4,a3,-13
80004a68:	00058463          	beqz	a1,80004a70 <_vsnprintf+0x660>
80004a6c:	ff26fe93          	and	t4,a3,-14
80004a70:	200ef313          	and	t1,t4,512
80004a74:	34031863          	bnez	t1,80004dc4 <_vsnprintf+0x9b4>
80004a78:	004c8793          	add	a5,s9,4
80004a7c:	100efd93          	and	s11,t4,256
80004a80:	02f12223          	sw	a5,36(sp)
80004a84:	780d9c63          	bnez	s11,8000521c <_vsnprintf+0xe0c>
80004a88:	040ef713          	and	a4,t4,64
80004a8c:	28071063          	bnez	a4,80004d0c <_vsnprintf+0x8fc>
80004a90:	080ef713          	and	a4,t4,128
80004a94:	0a070ae3          	beqz	a4,80005348 <_vsnprintf+0xf38>
80004a98:	000cdc83          	lhu	s9,0(s9)
80004a9c:	280c9c63          	bnez	s9,80004d34 <_vsnprintf+0x924>
80004aa0:	fefefe93          	and	t4,t4,-17
80004aa4:	28058863          	beqz	a1,80004d34 <_vsnprintf+0x924>
80004aa8:	00000d93          	li	s11,0
80004aac:	04010d13          	add	s10,sp,64
80004ab0:	01112223          	sw	a7,4(sp)
80004ab4:	01012023          	sw	a6,0(sp)
80004ab8:	01d12423          	sw	t4,8(sp)
80004abc:	000c0893          	mv	a7,s8
80004ac0:	00000813          	li	a6,0
80004ac4:	000d8793          	mv	a5,s11
80004ac8:	01c12683          	lw	a3,28(sp)
80004acc:	00040613          	mv	a2,s0
80004ad0:	000d0713          	mv	a4,s10
80004ad4:	000b0593          	mv	a1,s6
80004ad8:	000b8513          	mv	a0,s7
80004adc:	951fe0ef          	jal	8000342c <_ntoa_format>
80004ae0:	00050413          	mv	s0,a0
80004ae4:	02412c83          	lw	s9,36(sp)
80004ae8:	06c12d83          	lw	s11,108(sp)
80004aec:	9b5ff06f          	j	800044a0 <_vsnprintf+0x90>
80004af0:	07b12623          	sw	s11,108(sp)
80004af4:	05800793          	li	a5,88
80004af8:	0cf50e63          	beq	a0,a5,80004bd4 <_vsnprintf+0x7c4>
80004afc:	06200793          	li	a5,98
80004b00:	7ef51463          	bne	a0,a5,800052e8 <_vsnprintf+0xed8>
80004b04:	00200613          	li	a2,2
80004b08:	00000f13          	li	t5,0
80004b0c:	00200c13          	li	s8,2
80004b10:	f51ff06f          	j	80004a60 <_vsnprintf+0x650>
80004b14:	01c12c83          	lw	s9,28(sp)
80004b18:	00090793          	mv	a5,s2
80004b1c:	02d12223          	sw	a3,36(sp)
80004b20:	00048913          	mv	s2,s1
80004b24:	03112423          	sw	a7,40(sp)
80004b28:	00040493          	mv	s1,s0
80004b2c:	00078d13          	mv	s10,a5
80004b30:	00048613          	mv	a2,s1
80004b34:	000c8693          	mv	a3,s9
80004b38:	000b0593          	mv	a1,s6
80004b3c:	000b80e7          	jalr	s7
80004b40:	00148493          	add	s1,s1,1
80004b44:	40848733          	sub	a4,s1,s0
80004b48:	00ed8733          	add	a4,s11,a4
80004b4c:	00074503          	lbu	a0,0(a4)
80004b50:	fe0510e3          	bnez	a0,80004b30 <_vsnprintf+0x720>
80004b54:	02412683          	lw	a3,36(sp)
80004b58:	02812883          	lw	a7,40(sp)
80004b5c:	000d0793          	mv	a5,s10
80004b60:	00048d13          	mv	s10,s1
80004b64:	000d0413          	mv	s0,s10
80004b68:	00090493          	mv	s1,s2
80004b6c:	00078913          	mv	s2,a5
80004b70:	02068a63          	beqz	a3,80004ba4 <_vsnprintf+0x794>
80004b74:	00040d13          	mv	s10,s0
80004b78:	031c7663          	bgeu	s8,a7,80004ba4 <_vsnprintf+0x794>
80004b7c:	008888b3          	add	a7,a7,s0
80004b80:	41888433          	sub	s0,a7,s8
80004b84:	01c12c03          	lw	s8,28(sp)
80004b88:	000d0613          	mv	a2,s10
80004b8c:	000c0693          	mv	a3,s8
80004b90:	001d0d13          	add	s10,s10,1
80004b94:	000b0593          	mv	a1,s6
80004b98:	02000513          	li	a0,32
80004b9c:	000b80e7          	jalr	s7
80004ba0:	fe8d14e3          	bne	s10,s0,80004b88 <_vsnprintf+0x778>
80004ba4:	06c12d83          	lw	s11,108(sp)
80004ba8:	00048c93          	mv	s9,s1
80004bac:	8f5ff06f          	j	800044a0 <_vsnprintf+0x90>
80004bb0:	000017b7          	lui	a5,0x1
80004bb4:	80078793          	add	a5,a5,-2048 # 800 <__stack_size-0x3800>
80004bb8:	00f6e6b3          	or	a3,a3,a5
80004bbc:	0206e693          	or	a3,a3,32
80004bc0:	cc5ff06f          	j	80004884 <_vsnprintf+0x474>
80004bc4:	00294503          	lbu	a0,2(s2)
80004bc8:	0c06e693          	or	a3,a3,192
80004bcc:	00390713          	add	a4,s2,3
80004bd0:	99dff06f          	j	8000456c <_vsnprintf+0x15c>
80004bd4:	0206e693          	or	a3,a3,32
80004bd8:	01000613          	li	a2,16
80004bdc:	00000f13          	li	t5,0
80004be0:	01000c13          	li	s8,16
80004be4:	e7dff06f          	j	80004a60 <_vsnprintf+0x650>
80004be8:	000d0693          	mv	a3,s10
80004bec:	02412883          	lw	a7,36(sp)
80004bf0:	02812483          	lw	s1,40(sp)
80004bf4:	02c12903          	lw	s2,44(sp)
80004bf8:	000c8413          	mv	s0,s9
80004bfc:	fa0684e3          	beqz	a3,80004ba4 <_vsnprintf+0x794>
80004c00:	f75ff06f          	j	80004b74 <_vsnprintf+0x764>
80004c04:	000d0693          	mv	a3,s10
80004c08:	00090d13          	mv	s10,s2
80004c0c:	02412883          	lw	a7,36(sp)
80004c10:	02812483          	lw	s1,40(sp)
80004c14:	02c12903          	lw	s2,44(sp)
80004c18:	000d0413          	mv	s0,s10
80004c1c:	f55ff06f          	j	80004b70 <_vsnprintf+0x760>
80004c20:	731c7e63          	bgeu	s8,a7,8000535c <_vsnprintf+0xf4c>
80004c24:	02912623          	sw	s1,44(sp)
80004c28:	01c12483          	lw	s1,28(sp)
80004c2c:	011407b3          	add	a5,s0,a7
80004c30:	41878c33          	sub	s8,a5,s8
80004c34:	00068c93          	mv	s9,a3
80004c38:	03112223          	sw	a7,36(sp)
80004c3c:	03012423          	sw	a6,40(sp)
80004c40:	00040613          	mv	a2,s0
80004c44:	00048693          	mv	a3,s1
80004c48:	00140413          	add	s0,s0,1
80004c4c:	000b0593          	mv	a1,s6
80004c50:	02000513          	li	a0,32
80004c54:	000b80e7          	jalr	s7
80004c58:	ff8414e3          	bne	s0,s8,80004c40 <_vsnprintf+0x830>
80004c5c:	02412883          	lw	a7,36(sp)
80004c60:	02812803          	lw	a6,40(sp)
80004c64:	02c12483          	lw	s1,44(sp)
80004c68:	000dc603          	lbu	a2,0(s11)
80004c6c:	000c8693          	mv	a3,s9
80004c70:	00188c13          	add	s8,a7,1
80004c74:	00060513          	mv	a0,a2
80004c78:	b40614e3          	bnez	a2,800047c0 <_vsnprintf+0x3b0>
80004c7c:	f29ff06f          	j	80004ba4 <_vsnprintf+0x794>
80004c80:	00100793          	li	a5,1
80004c84:	0917f863          	bgeu	a5,a7,80004d14 <_vsnprintf+0x904>
80004c88:	01c12483          	lw	s1,28(sp)
80004c8c:	fff40c13          	add	s8,s0,-1
80004c90:	07b12623          	sw	s11,108(sp)
80004c94:	011c0c33          	add	s8,s8,a7
80004c98:	000c8d93          	mv	s11,s9
80004c9c:	02812223          	sw	s0,36(sp)
80004ca0:	00090c93          	mv	s9,s2
80004ca4:	00088913          	mv	s2,a7
80004ca8:	00040613          	mv	a2,s0
80004cac:	00048693          	mv	a3,s1
80004cb0:	00140413          	add	s0,s0,1
80004cb4:	000b0593          	mv	a1,s6
80004cb8:	02000513          	li	a0,32
80004cbc:	000b80e7          	jalr	s7
80004cc0:	ff8414e3          	bne	s0,s8,80004ca8 <_vsnprintf+0x898>
80004cc4:	00090893          	mv	a7,s2
80004cc8:	000c8913          	mv	s2,s9
80004ccc:	000d8c93          	mv	s9,s11
80004cd0:	000cc503          	lbu	a0,0(s9)
80004cd4:	00040d93          	mv	s11,s0
80004cd8:	01c12683          	lw	a3,28(sp)
80004cdc:	02412403          	lw	s0,36(sp)
80004ce0:	000d8613          	mv	a2,s11
80004ce4:	000b0593          	mv	a1,s6
80004ce8:	01140433          	add	s0,s0,a7
80004cec:	000d0c93          	mv	s9,s10
80004cf0:	000b80e7          	jalr	s7
80004cf4:	06c12d83          	lw	s11,108(sp)
80004cf8:	fa8ff06f          	j	800044a0 <_vsnprintf+0x90>
80004cfc:	01000613          	li	a2,16
80004d00:	00000f13          	li	t5,0
80004d04:	01000c13          	li	s8,16
80004d08:	d59ff06f          	j	80004a60 <_vsnprintf+0x650>
80004d0c:	000ccc83          	lbu	s9,0(s9)
80004d10:	d8dff06f          	j	80004a9c <_vsnprintf+0x68c>
80004d14:	000cc503          	lbu	a0,0(s9)
80004d18:	01c12683          	lw	a3,28(sp)
80004d1c:	00040613          	mv	a2,s0
80004d20:	000b0593          	mv	a1,s6
80004d24:	000b80e7          	jalr	s7
80004d28:	000c0413          	mv	s0,s8
80004d2c:	000d0c93          	mv	s9,s10
80004d30:	f70ff06f          	j	800044a0 <_vsnprintf+0x90>
80004d34:	005ed693          	srl	a3,t4,0x5
80004d38:	0016f693          	and	a3,a3,1
80004d3c:	06100713          	li	a4,97
80004d40:	00068463          	beqz	a3,80004d48 <_vsnprintf+0x938>
80004d44:	04100713          	li	a4,65
80004d48:	0ff77793          	zext.b	a5,a4
80004d4c:	02812423          	sw	s0,40(sp)
80004d50:	04010d13          	add	s10,sp,64
80004d54:	000d8413          	mv	s0,s11
80004d58:	ff678493          	add	s1,a5,-10
80004d5c:	00090d93          	mv	s11,s2
80004d60:	03112623          	sw	a7,44(sp)
80004d64:	03012823          	sw	a6,48(sp)
80004d68:	000e8913          	mv	s2,t4
80004d6c:	0340006f          	j	80004da0 <_vsnprintf+0x990>
80004d70:	03078793          	add	a5,a5,48
80004d74:	0ff7f793          	zext.b	a5,a5
80004d78:	00140413          	add	s0,s0,1
80004d7c:	008d06b3          	add	a3,s10,s0
80004d80:	000c0593          	mv	a1,s8
80004d84:	000c8513          	mv	a0,s9
80004d88:	fef68fa3          	sb	a5,-1(a3)
80004d8c:	eddfd0ef          	jal	80002c68 <__hidden___udivsi3>
80004d90:	098cee63          	bltu	s9,s8,80004e2c <_vsnprintf+0xa1c>
80004d94:	02000793          	li	a5,32
80004d98:	08f40a63          	beq	s0,a5,80004e2c <_vsnprintf+0xa1c>
80004d9c:	00050c93          	mv	s9,a0
80004da0:	000c0593          	mv	a1,s8
80004da4:	000c8513          	mv	a0,s9
80004da8:	f09fd0ef          	jal	80002cb0 <__umodsi3>
80004dac:	00900713          	li	a4,9
80004db0:	0ff57793          	zext.b	a5,a0
80004db4:	faa77ee3          	bgeu	a4,a0,80004d70 <_vsnprintf+0x960>
80004db8:	009787b3          	add	a5,a5,s1
80004dbc:	0ff7f793          	zext.b	a5,a5
80004dc0:	fb9ff06f          	j	80004d78 <_vsnprintf+0x968>
80004dc4:	007c8c93          	add	s9,s9,7
80004dc8:	ff8cfc93          	and	s9,s9,-8
80004dcc:	000caf83          	lw	t6,0(s9)
80004dd0:	004ca083          	lw	ra,4(s9)
80004dd4:	008c8c93          	add	s9,s9,8
80004dd8:	001fe7b3          	or	a5,t6,ra
80004ddc:	36079463          	bnez	a5,80005144 <_vsnprintf+0xd34>
80004de0:	fefefe93          	and	t4,t4,-17
80004de4:	36058063          	beqz	a1,80005144 <_vsnprintf+0xd34>
80004de8:	00000d93          	li	s11,0
80004dec:	04010d13          	add	s10,sp,64
80004df0:	01112223          	sw	a7,4(sp)
80004df4:	01012023          	sw	a6,0(sp)
80004df8:	01d12423          	sw	t4,8(sp)
80004dfc:	000c0893          	mv	a7,s8
80004e00:	00000813          	li	a6,0
80004e04:	000d8793          	mv	a5,s11
80004e08:	01c12683          	lw	a3,28(sp)
80004e0c:	00040613          	mv	a2,s0
80004e10:	000d0713          	mv	a4,s10
80004e14:	000b0593          	mv	a1,s6
80004e18:	000b8513          	mv	a0,s7
80004e1c:	e10fe0ef          	jal	8000342c <_ntoa_format>
80004e20:	00050413          	mv	s0,a0
80004e24:	06c12d83          	lw	s11,108(sp)
80004e28:	e78ff06f          	j	800044a0 <_vsnprintf+0x90>
80004e2c:	00090e93          	mv	t4,s2
80004e30:	02c12883          	lw	a7,44(sp)
80004e34:	000d8913          	mv	s2,s11
80004e38:	03012803          	lw	a6,48(sp)
80004e3c:	00040d93          	mv	s11,s0
80004e40:	02812403          	lw	s0,40(sp)
80004e44:	c6dff06f          	j	80004ab0 <_vsnprintf+0x6a0>
80004e48:	06900793          	li	a5,105
80004e4c:	fef6f593          	and	a1,a3,-17
80004e50:	50f51a63          	bne	a0,a5,80005364 <_vsnprintf+0xf54>
80004e54:	4006fc13          	and	s8,a3,1024
80004e58:	000c0663          	beqz	s8,80004e64 <_vsnprintf+0xa54>
80004e5c:	fee6f593          	and	a1,a3,-18
80004e60:	40000c13          	li	s8,1024
80004e64:	2005f793          	and	a5,a1,512
80004e68:	0c079e63          	bnez	a5,80004f44 <_vsnprintf+0xb34>
80004e6c:	004c8713          	add	a4,s9,4
80004e70:	1005fd93          	and	s11,a1,256
80004e74:	02e12223          	sw	a4,36(sp)
80004e78:	200d9663          	bnez	s11,80005084 <_vsnprintf+0xc74>
80004e7c:	0405f793          	and	a5,a1,64
80004e80:	1e078063          	beqz	a5,80005060 <_vsnprintf+0xc50>
80004e84:	000cc783          	lbu	a5,0(s9)
80004e88:	00078713          	mv	a4,a5
80004e8c:	01f7d693          	srl	a3,a5,0x1f
80004e90:	2a078463          	beqz	a5,80005138 <_vsnprintf+0xd28>
80004e94:	00070c13          	mv	s8,a4
80004e98:	00090793          	mv	a5,s2
80004e9c:	02812423          	sw	s0,40(sp)
80004ea0:	000d8913          	mv	s2,s11
80004ea4:	000c0413          	mv	s0,s8
80004ea8:	04010d13          	add	s10,sp,64
80004eac:	00900493          	li	s1,9
80004eb0:	02000c93          	li	s9,32
80004eb4:	02d12623          	sw	a3,44(sp)
80004eb8:	03112823          	sw	a7,48(sp)
80004ebc:	03012a23          	sw	a6,52(sp)
80004ec0:	00058c13          	mv	s8,a1
80004ec4:	03612c23          	sw	s6,56(sp)
80004ec8:	00078d93          	mv	s11,a5
80004ecc:	0080006f          	j	80004ed4 <_vsnprintf+0xac4>
80004ed0:	03990c63          	beq	s2,s9,80004f08 <_vsnprintf+0xaf8>
80004ed4:	00a00593          	li	a1,10
80004ed8:	00040513          	mv	a0,s0
80004edc:	dd5fd0ef          	jal	80002cb0 <__umodsi3>
80004ee0:	00190913          	add	s2,s2,1
80004ee4:	03050713          	add	a4,a0,48
80004ee8:	012d0b33          	add	s6,s10,s2
80004eec:	00040513          	mv	a0,s0
80004ef0:	feeb0fa3          	sb	a4,-1(s6)
80004ef4:	00a00593          	li	a1,10
80004ef8:	00040b13          	mv	s6,s0
80004efc:	d6dfd0ef          	jal	80002c68 <__hidden___udivsi3>
80004f00:	00050413          	mv	s0,a0
80004f04:	fd64e6e3          	bltu	s1,s6,80004ed0 <_vsnprintf+0xac0>
80004f08:	02812403          	lw	s0,40(sp)
80004f0c:	02c12683          	lw	a3,44(sp)
80004f10:	03012883          	lw	a7,48(sp)
80004f14:	03412803          	lw	a6,52(sp)
80004f18:	03812b03          	lw	s6,56(sp)
80004f1c:	000d8793          	mv	a5,s11
80004f20:	000c0593          	mv	a1,s8
80004f24:	00090d93          	mv	s11,s2
80004f28:	00078913          	mv	s2,a5
80004f2c:	01112223          	sw	a7,4(sp)
80004f30:	01012023          	sw	a6,0(sp)
80004f34:	00b12423          	sw	a1,8(sp)
80004f38:	00a00893          	li	a7,10
80004f3c:	00068813          	mv	a6,a3
80004f40:	b85ff06f          	j	80004ac4 <_vsnprintf+0x6b4>
80004f44:	007c8c93          	add	s9,s9,7
80004f48:	ff8cfc93          	and	s9,s9,-8
80004f4c:	004cad83          	lw	s11,4(s9)
80004f50:	000ca303          	lw	t1,0(s9)
80004f54:	008c8c93          	add	s9,s9,8
80004f58:	01fdd493          	srl	s1,s11,0x1f
80004f5c:	01b367b3          	or	a5,t1,s11
80004f60:	2a078663          	beqz	a5,8000520c <_vsnprintf+0xdfc>
80004f64:	41fdd793          	sra	a5,s11,0x1f
80004f68:	0067c333          	xor	t1,a5,t1
80004f6c:	40f30733          	sub	a4,t1,a5
80004f70:	01b7cdb3          	xor	s11,a5,s11
80004f74:	00e336b3          	sltu	a3,t1,a4
80004f78:	40fd87b3          	sub	a5,s11,a5
80004f7c:	00070313          	mv	t1,a4
80004f80:	40d78db3          	sub	s11,a5,a3
80004f84:	00000c13          	li	s8,0
80004f88:	02912623          	sw	s1,44(sp)
80004f8c:	04010d13          	add	s10,sp,64
80004f90:	000c0493          	mv	s1,s8
80004f94:	02b12223          	sw	a1,36(sp)
80004f98:	000b0c13          	mv	s8,s6
80004f9c:	02812423          	sw	s0,40(sp)
80004fa0:	000d8b13          	mv	s6,s11
80004fa4:	03112823          	sw	a7,48(sp)
80004fa8:	000c8d93          	mv	s11,s9
80004fac:	03012a23          	sw	a6,52(sp)
80004fb0:	00090c93          	mv	s9,s2
80004fb4:	03712c23          	sw	s7,56(sp)
80004fb8:	00030913          	mv	s2,t1
80004fbc:	00c0006f          	j	80004fc8 <_vsnprintf+0xbb8>
80004fc0:	02000793          	li	a5,32
80004fc4:	04f48c63          	beq	s1,a5,8000501c <_vsnprintf+0xc0c>
80004fc8:	00a00613          	li	a2,10
80004fcc:	00000693          	li	a3,0
80004fd0:	00090513          	mv	a0,s2
80004fd4:	000b0593          	mv	a1,s6
80004fd8:	e60fb0ef          	jal	80000638 <__umoddi3>
80004fdc:	00148493          	add	s1,s1,1
80004fe0:	03050713          	add	a4,a0,48
80004fe4:	009d0433          	add	s0,s10,s1
80004fe8:	00090513          	mv	a0,s2
80004fec:	000b0593          	mv	a1,s6
80004ff0:	fee40fa3          	sb	a4,-1(s0)
80004ff4:	00a00613          	li	a2,10
80004ff8:	00000693          	li	a3,0
80004ffc:	a0cfb0ef          	jal	80000208 <__udivdi3>
80005000:	000b0b93          	mv	s7,s6
80005004:	00090413          	mv	s0,s2
80005008:	00058b13          	mv	s6,a1
8000500c:	00050913          	mv	s2,a0
80005010:	fa0b98e3          	bnez	s7,80004fc0 <_vsnprintf+0xbb0>
80005014:	00900713          	li	a4,9
80005018:	fa8764e3          	bltu	a4,s0,80004fc0 <_vsnprintf+0xbb0>
8000501c:	000c0b13          	mv	s6,s8
80005020:	02412583          	lw	a1,36(sp)
80005024:	00048c13          	mv	s8,s1
80005028:	02812403          	lw	s0,40(sp)
8000502c:	03012883          	lw	a7,48(sp)
80005030:	03412803          	lw	a6,52(sp)
80005034:	03812b83          	lw	s7,56(sp)
80005038:	02c12483          	lw	s1,44(sp)
8000503c:	000c8913          	mv	s2,s9
80005040:	000d8c93          	mv	s9,s11
80005044:	01112223          	sw	a7,4(sp)
80005048:	01012023          	sw	a6,0(sp)
8000504c:	00b12423          	sw	a1,8(sp)
80005050:	00a00893          	li	a7,10
80005054:	00048813          	mv	a6,s1
80005058:	000c0793          	mv	a5,s8
8000505c:	dadff06f          	j	80004e08 <_vsnprintf+0x9f8>
80005060:	0805f793          	and	a5,a1,128
80005064:	28078a63          	beqz	a5,800052f8 <_vsnprintf+0xee8>
80005068:	000c9783          	lh	a5,0(s9)
8000506c:	40f7d693          	sra	a3,a5,0xf
80005070:	00d7c733          	xor	a4,a5,a3
80005074:	40d70733          	sub	a4,a4,a3
80005078:	01071713          	sll	a4,a4,0x10
8000507c:	01075713          	srl	a4,a4,0x10
80005080:	e0dff06f          	j	80004e8c <_vsnprintf+0xa7c>
80005084:	000ca703          	lw	a4,0(s9)
80005088:	01f75493          	srl	s1,a4,0x1f
8000508c:	2a070863          	beqz	a4,8000533c <_vsnprintf+0xf2c>
80005090:	41f75693          	sra	a3,a4,0x1f
80005094:	00e6cc33          	xor	s8,a3,a4
80005098:	40dc0c33          	sub	s8,s8,a3
8000509c:	02812623          	sw	s0,44(sp)
800050a0:	02912823          	sw	s1,48(sp)
800050a4:	04010d13          	add	s10,sp,64
800050a8:	000c0493          	mv	s1,s8
800050ac:	00900d93          	li	s11,9
800050b0:	02000c93          	li	s9,32
800050b4:	02b12423          	sw	a1,40(sp)
800050b8:	03112a23          	sw	a7,52(sp)
800050bc:	03012c23          	sw	a6,56(sp)
800050c0:	00078413          	mv	s0,a5
800050c4:	00090c13          	mv	s8,s2
800050c8:	0080006f          	j	800050d0 <_vsnprintf+0xcc0>
800050cc:	03940c63          	beq	s0,s9,80005104 <_vsnprintf+0xcf4>
800050d0:	00a00593          	li	a1,10
800050d4:	00048513          	mv	a0,s1
800050d8:	bd9fd0ef          	jal	80002cb0 <__umodsi3>
800050dc:	00140413          	add	s0,s0,1
800050e0:	03050693          	add	a3,a0,48
800050e4:	008d0933          	add	s2,s10,s0
800050e8:	00048513          	mv	a0,s1
800050ec:	fed90fa3          	sb	a3,-1(s2)
800050f0:	00a00593          	li	a1,10
800050f4:	00048913          	mv	s2,s1
800050f8:	b71fd0ef          	jal	80002c68 <__hidden___udivsi3>
800050fc:	00050493          	mv	s1,a0
80005100:	fd2de6e3          	bltu	s11,s2,800050cc <_vsnprintf+0xcbc>
80005104:	00040793          	mv	a5,s0
80005108:	02812583          	lw	a1,40(sp)
8000510c:	03012483          	lw	s1,48(sp)
80005110:	03412883          	lw	a7,52(sp)
80005114:	03812803          	lw	a6,56(sp)
80005118:	02c12403          	lw	s0,44(sp)
8000511c:	000c0913          	mv	s2,s8
80005120:	01112223          	sw	a7,4(sp)
80005124:	01012023          	sw	a6,0(sp)
80005128:	00b12423          	sw	a1,8(sp)
8000512c:	00a00893          	li	a7,10
80005130:	00048813          	mv	a6,s1
80005134:	995ff06f          	j	80004ac8 <_vsnprintf+0x6b8>
80005138:	04010d13          	add	s10,sp,64
8000513c:	de0c18e3          	bnez	s8,80004f2c <_vsnprintf+0xb1c>
80005140:	d59ff06f          	j	80004e98 <_vsnprintf+0xa88>
80005144:	005ed713          	srl	a4,t4,0x5
80005148:	00177713          	and	a4,a4,1
8000514c:	06100793          	li	a5,97
80005150:	00070463          	beqz	a4,80005158 <_vsnprintf+0xd48>
80005154:	04100793          	li	a5,65
80005158:	00000d93          	li	s11,0
8000515c:	ff678493          	add	s1,a5,-10
80005160:	02812223          	sw	s0,36(sp)
80005164:	03812a23          	sw	s8,52(sp)
80005168:	03712c23          	sw	s7,56(sp)
8000516c:	03612e23          	sw	s6,60(sp)
80005170:	04010d13          	add	s10,sp,64
80005174:	000d8b13          	mv	s6,s11
80005178:	03112423          	sw	a7,40(sp)
8000517c:	000c8d93          	mv	s11,s9
80005180:	03012623          	sw	a6,44(sp)
80005184:	00090c93          	mv	s9,s2
80005188:	03d12823          	sw	t4,48(sp)
8000518c:	00048913          	mv	s2,s1
80005190:	000f8b93          	mv	s7,t6
80005194:	00008413          	mv	s0,ra
80005198:	00060c13          	mv	s8,a2
8000519c:	000f0493          	mv	s1,t5
800051a0:	0400006f          	j	800051e0 <_vsnprintf+0xdd0>
800051a4:	03050793          	add	a5,a0,48
800051a8:	0ff7f793          	zext.b	a5,a5
800051ac:	001b0b13          	add	s6,s6,1
800051b0:	016d0833          	add	a6,s10,s6
800051b4:	000c0613          	mv	a2,s8
800051b8:	00000693          	li	a3,0
800051bc:	000b8513          	mv	a0,s7
800051c0:	00040593          	mv	a1,s0
800051c4:	fef80fa3          	sb	a5,-1(a6)
800051c8:	840fb0ef          	jal	80000208 <__udivdi3>
800051cc:	14848063          	beq	s1,s0,8000530c <_vsnprintf+0xefc>
800051d0:	02000793          	li	a5,32
800051d4:	12fb0e63          	beq	s6,a5,80005310 <_vsnprintf+0xf00>
800051d8:	00050b93          	mv	s7,a0
800051dc:	00058413          	mv	s0,a1
800051e0:	000c0613          	mv	a2,s8
800051e4:	00000693          	li	a3,0
800051e8:	000b8513          	mv	a0,s7
800051ec:	00040593          	mv	a1,s0
800051f0:	c48fb0ef          	jal	80000638 <__umoddi3>
800051f4:	0ff57513          	zext.b	a0,a0
800051f8:	00900793          	li	a5,9
800051fc:	faa7f4e3          	bgeu	a5,a0,800051a4 <_vsnprintf+0xd94>
80005200:	012507b3          	add	a5,a0,s2
80005204:	0ff7f793          	zext.b	a5,a5
80005208:	fa5ff06f          	j	800051ac <_vsnprintf+0xd9c>
8000520c:	140c1263          	bnez	s8,80005350 <_vsnprintf+0xf40>
80005210:	00000313          	li	t1,0
80005214:	00000d93          	li	s11,0
80005218:	d6dff06f          	j	80004f84 <_vsnprintf+0xb74>
8000521c:	000cac83          	lw	s9,0(s9)
80005220:	000c9863          	bnez	s9,80005230 <_vsnprintf+0xe20>
80005224:	fefefe93          	and	t4,t4,-17
80005228:	04010d13          	add	s10,sp,64
8000522c:	0a059063          	bnez	a1,800052cc <_vsnprintf+0xebc>
80005230:	005ed713          	srl	a4,t4,0x5
80005234:	00177713          	and	a4,a4,1
80005238:	06100793          	li	a5,97
8000523c:	00070463          	beqz	a4,80005244 <_vsnprintf+0xe34>
80005240:	04100793          	li	a5,65
80005244:	02812423          	sw	s0,40(sp)
80005248:	04010d13          	add	s10,sp,64
8000524c:	ff678493          	add	s1,a5,-10
80005250:	02000d93          	li	s11,32
80005254:	03112623          	sw	a7,44(sp)
80005258:	03012823          	sw	a6,48(sp)
8000525c:	00030413          	mv	s0,t1
80005260:	03d12a23          	sw	t4,52(sp)
80005264:	0300006f          	j	80005294 <_vsnprintf+0xe84>
80005268:	03078793          	add	a5,a5,48
8000526c:	0ff7f793          	zext.b	a5,a5
80005270:	00140413          	add	s0,s0,1
80005274:	008d0733          	add	a4,s10,s0
80005278:	000c0593          	mv	a1,s8
8000527c:	000c8513          	mv	a0,s9
80005280:	fef70fa3          	sb	a5,-1(a4)
80005284:	9e5fd0ef          	jal	80002c68 <__hidden___udivsi3>
80005288:	038ce863          	bltu	s9,s8,800052b8 <_vsnprintf+0xea8>
8000528c:	03b40663          	beq	s0,s11,800052b8 <_vsnprintf+0xea8>
80005290:	00050c93          	mv	s9,a0
80005294:	000c0593          	mv	a1,s8
80005298:	000c8513          	mv	a0,s9
8000529c:	a15fd0ef          	jal	80002cb0 <__umodsi3>
800052a0:	00900713          	li	a4,9
800052a4:	0ff57793          	zext.b	a5,a0
800052a8:	fca770e3          	bgeu	a4,a0,80005268 <_vsnprintf+0xe58>
800052ac:	009787b3          	add	a5,a5,s1
800052b0:	0ff7f793          	zext.b	a5,a5
800052b4:	fbdff06f          	j	80005270 <_vsnprintf+0xe60>
800052b8:	00040313          	mv	t1,s0
800052bc:	02c12883          	lw	a7,44(sp)
800052c0:	03012803          	lw	a6,48(sp)
800052c4:	02812403          	lw	s0,40(sp)
800052c8:	03412e83          	lw	t4,52(sp)
800052cc:	01112223          	sw	a7,4(sp)
800052d0:	01012023          	sw	a6,0(sp)
800052d4:	01d12423          	sw	t4,8(sp)
800052d8:	000c0893          	mv	a7,s8
800052dc:	00000813          	li	a6,0
800052e0:	00030793          	mv	a5,t1
800052e4:	fe4ff06f          	j	80004ac8 <_vsnprintf+0x6b8>
800052e8:	4006fc13          	and	s8,a3,1024
800052ec:	fef6f593          	and	a1,a3,-17
800052f0:	b60c0ae3          	beqz	s8,80004e64 <_vsnprintf+0xa54>
800052f4:	b69ff06f          	j	80004e5c <_vsnprintf+0xa4c>
800052f8:	000ca783          	lw	a5,0(s9)
800052fc:	41f7d693          	sra	a3,a5,0x1f
80005300:	00f6c733          	xor	a4,a3,a5
80005304:	40d70733          	sub	a4,a4,a3
80005308:	b85ff06f          	j	80004e8c <_vsnprintf+0xa7c>
8000530c:	ed8bf2e3          	bgeu	s7,s8,800051d0 <_vsnprintf+0xdc0>
80005310:	000c8913          	mv	s2,s9
80005314:	02412403          	lw	s0,36(sp)
80005318:	000d8c93          	mv	s9,s11
8000531c:	02812883          	lw	a7,40(sp)
80005320:	000b0d93          	mv	s11,s6
80005324:	02c12803          	lw	a6,44(sp)
80005328:	03012e83          	lw	t4,48(sp)
8000532c:	03412c03          	lw	s8,52(sp)
80005330:	03812b83          	lw	s7,56(sp)
80005334:	03c12b03          	lw	s6,60(sp)
80005338:	ab9ff06f          	j	80004df0 <_vsnprintf+0x9e0>
8000533c:	04010d13          	add	s10,sp,64
80005340:	de0c10e3          	bnez	s8,80005120 <_vsnprintf+0xd10>
80005344:	d59ff06f          	j	8000509c <_vsnprintf+0xc8c>
80005348:	000cac83          	lw	s9,0(s9)
8000534c:	f50ff06f          	j	80004a9c <_vsnprintf+0x68c>
80005350:	00000c13          	li	s8,0
80005354:	04010d13          	add	s10,sp,64
80005358:	cedff06f          	j	80005044 <_vsnprintf+0xc34>
8000535c:	001c0c13          	add	s8,s8,1
80005360:	915ff06f          	j	80004c74 <_vsnprintf+0x864>
80005364:	00058693          	mv	a3,a1
80005368:	00a00613          	li	a2,10
8000536c:	00000f13          	li	t5,0
80005370:	00a00c13          	li	s8,10
80005374:	eecff06f          	j	80004a60 <_vsnprintf+0x650>

80005378 <printf_>:
80005378:	fc010113          	add	sp,sp,-64
8000537c:	02410313          	add	t1,sp,36
80005380:	02d12623          	sw	a3,44(sp)
80005384:	00050693          	mv	a3,a0
80005388:	80003537          	lui	a0,0x80003
8000538c:	02b12223          	sw	a1,36(sp)
80005390:	02c12423          	sw	a2,40(sp)
80005394:	02e12823          	sw	a4,48(sp)
80005398:	00810593          	add	a1,sp,8
8000539c:	00030713          	mv	a4,t1
800053a0:	fff00613          	li	a2,-1
800053a4:	78050513          	add	a0,a0,1920 # 80003780 <_out_char>
800053a8:	00112e23          	sw	ra,28(sp)
800053ac:	02f12a23          	sw	a5,52(sp)
800053b0:	03012c23          	sw	a6,56(sp)
800053b4:	03112e23          	sw	a7,60(sp)
800053b8:	00612623          	sw	t1,12(sp)
800053bc:	854ff0ef          	jal	80004410 <_vsnprintf>
800053c0:	01c12083          	lw	ra,28(sp)
800053c4:	04010113          	add	sp,sp,64
800053c8:	00008067          	ret

800053cc <cmp_complex>:
800053cc:	fe010113          	add	sp,sp,-32
800053d0:	00912a23          	sw	s1,20(sp)
800053d4:	00051483          	lh	s1,0(a0)
800053d8:	00812c23          	sw	s0,24(sp)
800053dc:	01212823          	sw	s2,16(sp)
800053e0:	4074d793          	sra	a5,s1,0x7
800053e4:	01412423          	sw	s4,8(sp)
800053e8:	00112e23          	sw	ra,28(sp)
800053ec:	01312623          	sw	s3,12(sp)
800053f0:	0017f793          	and	a5,a5,1
800053f4:	00058913          	mv	s2,a1
800053f8:	00060413          	mv	s0,a2
800053fc:	07f4fa13          	and	s4,s1,127
80005400:	06079a63          	bnez	a5,80005474 <cmp_complex+0xa8>
80005404:	4034d713          	sra	a4,s1,0x3
80005408:	00f77713          	and	a4,a4,15
8000540c:	00471693          	sll	a3,a4,0x4
80005410:	00d705b3          	add	a1,a4,a3
80005414:	0074f613          	and	a2,s1,7
80005418:	03845783          	lhu	a5,56(s0)
8000541c:	00050993          	mv	s3,a0
80005420:	00058713          	mv	a4,a1
80005424:	14060863          	beqz	a2,80005574 <cmp_complex+0x1a8>
80005428:	00100693          	li	a3,1
8000542c:	0ed61663          	bne	a2,a3,80005518 <cmp_complex+0x14c>
80005430:	00078613          	mv	a2,a5
80005434:	02840513          	add	a0,s0,40
80005438:	319010ef          	jal	80006f50 <core_bench_matrix>
8000543c:	03c45783          	lhu	a5,60(s0)
80005440:	01051a13          	sll	s4,a0,0x10
80005444:	410a5a13          	sra	s4,s4,0x10
80005448:	16079463          	bnez	a5,800055b0 <cmp_complex+0x1e4>
8000544c:	03845783          	lhu	a5,56(s0)
80005450:	02a41e23          	sh	a0,60(s0)
80005454:	00078593          	mv	a1,a5
80005458:	07fa7a13          	and	s4,s4,127
8000545c:	f004f493          	and	s1,s1,-256
80005460:	4c8020ef          	jal	80007928 <crcu16>
80005464:	009a64b3          	or	s1,s4,s1
80005468:	02a41c23          	sh	a0,56(s0)
8000546c:	0804e493          	or	s1,s1,128
80005470:	00999023          	sh	s1,0(s3)
80005474:	00091483          	lh	s1,0(s2)
80005478:	4074d793          	sra	a5,s1,0x7
8000547c:	0017f793          	and	a5,a5,1
80005480:	07f4f993          	and	s3,s1,127
80005484:	06079863          	bnez	a5,800054f4 <cmp_complex+0x128>
80005488:	4034d713          	sra	a4,s1,0x3
8000548c:	00f77713          	and	a4,a4,15
80005490:	00471693          	sll	a3,a4,0x4
80005494:	00d705b3          	add	a1,a4,a3
80005498:	0074f613          	and	a2,s1,7
8000549c:	03845783          	lhu	a5,56(s0)
800054a0:	00058713          	mv	a4,a1
800054a4:	08060a63          	beqz	a2,80005538 <cmp_complex+0x16c>
800054a8:	00100693          	li	a3,1
800054ac:	06d61e63          	bne	a2,a3,80005528 <cmp_complex+0x15c>
800054b0:	00078613          	mv	a2,a5
800054b4:	02840513          	add	a0,s0,40
800054b8:	299010ef          	jal	80006f50 <core_bench_matrix>
800054bc:	03c45783          	lhu	a5,60(s0)
800054c0:	01051993          	sll	s3,a0,0x10
800054c4:	4109d993          	sra	s3,s3,0x10
800054c8:	0e079863          	bnez	a5,800055b8 <cmp_complex+0x1ec>
800054cc:	03845783          	lhu	a5,56(s0)
800054d0:	02a41e23          	sh	a0,60(s0)
800054d4:	00078593          	mv	a1,a5
800054d8:	07f9f993          	and	s3,s3,127
800054dc:	f004f493          	and	s1,s1,-256
800054e0:	448020ef          	jal	80007928 <crcu16>
800054e4:	0099e4b3          	or	s1,s3,s1
800054e8:	02a41c23          	sh	a0,56(s0)
800054ec:	0804e493          	or	s1,s1,128
800054f0:	00991023          	sh	s1,0(s2)
800054f4:	01c12083          	lw	ra,28(sp)
800054f8:	01812403          	lw	s0,24(sp)
800054fc:	413a0533          	sub	a0,s4,s3
80005500:	01412483          	lw	s1,20(sp)
80005504:	01012903          	lw	s2,16(sp)
80005508:	00c12983          	lw	s3,12(sp)
8000550c:	00812a03          	lw	s4,8(sp)
80005510:	02010113          	add	sp,sp,32
80005514:	00008067          	ret
80005518:	01049513          	sll	a0,s1,0x10
8000551c:	01055513          	srl	a0,a0,0x10
80005520:	00048a13          	mv	s4,s1
80005524:	f31ff06f          	j	80005454 <cmp_complex+0x88>
80005528:	01049513          	sll	a0,s1,0x10
8000552c:	01055513          	srl	a0,a0,0x10
80005530:	00048993          	mv	s3,s1
80005534:	fa1ff06f          	j	800054d4 <cmp_complex+0x108>
80005538:	02100693          	li	a3,33
8000553c:	00b6e463          	bltu	a3,a1,80005544 <cmp_complex+0x178>
80005540:	02200713          	li	a4,34
80005544:	00241683          	lh	a3,2(s0)
80005548:	00041603          	lh	a2,0(s0)
8000554c:	01442583          	lw	a1,20(s0)
80005550:	01842503          	lw	a0,24(s0)
80005554:	148020ef          	jal	8000769c <core_bench_state>
80005558:	03e45783          	lhu	a5,62(s0)
8000555c:	01051993          	sll	s3,a0,0x10
80005560:	4109d993          	sra	s3,s3,0x10
80005564:	04079a63          	bnez	a5,800055b8 <cmp_complex+0x1ec>
80005568:	03845783          	lhu	a5,56(s0)
8000556c:	02a41f23          	sh	a0,62(s0)
80005570:	f65ff06f          	j	800054d4 <cmp_complex+0x108>
80005574:	02100693          	li	a3,33
80005578:	00b6e463          	bltu	a3,a1,80005580 <cmp_complex+0x1b4>
8000557c:	02200713          	li	a4,34
80005580:	00241683          	lh	a3,2(s0)
80005584:	00041603          	lh	a2,0(s0)
80005588:	01442583          	lw	a1,20(s0)
8000558c:	01842503          	lw	a0,24(s0)
80005590:	10c020ef          	jal	8000769c <core_bench_state>
80005594:	03e45783          	lhu	a5,62(s0)
80005598:	01051a13          	sll	s4,a0,0x10
8000559c:	410a5a13          	sra	s4,s4,0x10
800055a0:	00079863          	bnez	a5,800055b0 <cmp_complex+0x1e4>
800055a4:	03845783          	lhu	a5,56(s0)
800055a8:	02a41f23          	sh	a0,62(s0)
800055ac:	ea9ff06f          	j	80005454 <cmp_complex+0x88>
800055b0:	03845783          	lhu	a5,56(s0)
800055b4:	ea1ff06f          	j	80005454 <cmp_complex+0x88>
800055b8:	03845783          	lhu	a5,56(s0)
800055bc:	f19ff06f          	j	800054d4 <cmp_complex+0x108>

800055c0 <core_bench_list>:
800055c0:	00451883          	lh	a7,4(a0)
800055c4:	fc010113          	add	sp,sp,-64
800055c8:	02812c23          	sw	s0,56(sp)
800055cc:	03612023          	sw	s6,32(sp)
800055d0:	01712e23          	sw	s7,28(sp)
800055d4:	02112e23          	sw	ra,60(sp)
800055d8:	02912a23          	sw	s1,52(sp)
800055dc:	03212823          	sw	s2,48(sp)
800055e0:	03312623          	sw	s3,44(sp)
800055e4:	03412423          	sw	s4,40(sp)
800055e8:	03512223          	sw	s5,36(sp)
800055ec:	01812c23          	sw	s8,24(sp)
800055f0:	01912a23          	sw	s9,20(sp)
800055f4:	01a12823          	sw	s10,16(sp)
800055f8:	01b12623          	sw	s11,12(sp)
800055fc:	02452403          	lw	s0,36(a0)
80005600:	00050b13          	mv	s6,a0
80005604:	00058b93          	mv	s7,a1
80005608:	00058513          	mv	a0,a1
8000560c:	43105e63          	blez	a7,80005a48 <core_bench_list+0x488>
80005610:	00000613          	li	a2,0
80005614:	00000813          	li	a6,0
80005618:	00000593          	li	a1,0
8000561c:	00000493          	li	s1,0
80005620:	0ff67c93          	zext.b	s9,a2
80005624:	260bca63          	bltz	s7,80005898 <core_bench_list+0x2d8>
80005628:	42040663          	beqz	s0,80005a54 <core_bench_list+0x494>
8000562c:	00040793          	mv	a5,s0
80005630:	00c0006f          	j	8000563c <core_bench_list+0x7c>
80005634:	0007a783          	lw	a5,0(a5)
80005638:	00078863          	beqz	a5,80005648 <core_bench_list+0x88>
8000563c:	0047a703          	lw	a4,4(a5)
80005640:	00271703          	lh	a4,2(a4)
80005644:	ff7718e3          	bne	a4,s7,80005634 <core_bench_list+0x74>
80005648:	00000693          	li	a3,0
8000564c:	0080006f          	j	80005654 <core_bench_list+0x94>
80005650:	00070413          	mv	s0,a4
80005654:	00042703          	lw	a4,0(s0)
80005658:	00d42023          	sw	a3,0(s0)
8000565c:	00040693          	mv	a3,s0
80005660:	fe0718e3          	bnez	a4,80005650 <core_bench_list+0x90>
80005664:	24078c63          	beqz	a5,800058bc <core_bench_list+0x2fc>
80005668:	0047a703          	lw	a4,4(a5)
8000566c:	00071703          	lh	a4,0(a4)
80005670:	00177693          	and	a3,a4,1
80005674:	00068c63          	beqz	a3,8000568c <core_bench_list+0xcc>
80005678:	40975713          	sra	a4,a4,0x9
8000567c:	00177713          	and	a4,a4,1
80005680:	00e48733          	add	a4,s1,a4
80005684:	01071493          	sll	s1,a4,0x10
80005688:	0104d493          	srl	s1,s1,0x10
8000568c:	0007a703          	lw	a4,0(a5)
80005690:	00070c63          	beqz	a4,800056a8 <core_bench_list+0xe8>
80005694:	00072683          	lw	a3,0(a4)
80005698:	00d7a023          	sw	a3,0(a5)
8000569c:	00042783          	lw	a5,0(s0)
800056a0:	00f72023          	sw	a5,0(a4)
800056a4:	00e42023          	sw	a4,0(s0)
800056a8:	00158793          	add	a5,a1,1
800056ac:	01079593          	sll	a1,a5,0x10
800056b0:	0105d593          	srl	a1,a1,0x10
800056b4:	000bc863          	bltz	s7,800056c4 <core_bench_list+0x104>
800056b8:	001b8b93          	add	s7,s7,1
800056bc:	010b9b93          	sll	s7,s7,0x10
800056c0:	410bdb93          	sra	s7,s7,0x10
800056c4:	00160613          	add	a2,a2,1
800056c8:	01061613          	sll	a2,a2,0x10
800056cc:	41065613          	sra	a2,a2,0x10
800056d0:	f4c898e3          	bne	a7,a2,80005620 <core_bench_list+0x60>
800056d4:	00259793          	sll	a5,a1,0x2
800056d8:	410787b3          	sub	a5,a5,a6
800056dc:	00f484b3          	add	s1,s1,a5
800056e0:	01049493          	sll	s1,s1,0x10
800056e4:	0104d493          	srl	s1,s1,0x10
800056e8:	26a04263          	bgtz	a0,8000594c <core_bench_list+0x38c>
800056ec:	00042783          	lw	a5,0(s0)
800056f0:	00040913          	mv	s2,s0
800056f4:	0007a983          	lw	s3,0(a5)
800056f8:	0047a703          	lw	a4,4(a5)
800056fc:	0049a603          	lw	a2,4(s3)
80005700:	0009a683          	lw	a3,0(s3)
80005704:	00c7a223          	sw	a2,4(a5)
80005708:	00e9a223          	sw	a4,4(s3)
8000570c:	00d7a023          	sw	a3,0(a5)
80005710:	0009a023          	sw	zero,0(s3)
80005714:	0e0bca63          	bltz	s7,80005808 <core_bench_list+0x248>
80005718:	00492783          	lw	a5,4(s2)
8000571c:	00279783          	lh	a5,2(a5)
80005720:	01778c63          	beq	a5,s7,80005738 <core_bench_list+0x178>
80005724:	00092903          	lw	s2,0(s2)
80005728:	2e090863          	beqz	s2,80005a18 <core_bench_list+0x458>
8000572c:	00492783          	lw	a5,4(s2)
80005730:	00279783          	lh	a5,2(a5)
80005734:	ff7798e3          	bne	a5,s7,80005724 <core_bench_list+0x164>
80005738:	00442783          	lw	a5,4(s0)
8000573c:	00048593          	mv	a1,s1
80005740:	00079503          	lh	a0,0(a5)
80005744:	0c9020ef          	jal	8000800c <crc16>
80005748:	00092903          	lw	s2,0(s2)
8000574c:	00050493          	mv	s1,a0
80005750:	fe0914e3          	bnez	s2,80005738 <core_bench_list+0x178>
80005754:	00042903          	lw	s2,0(s0)
80005758:	0049a703          	lw	a4,4(s3)
8000575c:	00492683          	lw	a3,4(s2)
80005760:	00092783          	lw	a5,0(s2)
80005764:	00100e93          	li	t4,1
80005768:	00d9a223          	sw	a3,4(s3)
8000576c:	00e92223          	sw	a4,4(s2)
80005770:	00f9a023          	sw	a5,0(s3)
80005774:	01392023          	sw	s3,0(s2)
80005778:	00100f93          	li	t6,1
8000577c:	10040a63          	beqz	s0,80005890 <core_bench_list+0x2d0>
80005780:	00000693          	li	a3,0
80005784:	00000913          	li	s2,0
80005788:	00000f13          	li	t5,0
8000578c:	001f0f13          	add	t5,t5,1
80005790:	00040713          	mv	a4,s0
80005794:	00000793          	li	a5,0
80005798:	01d7d863          	bge	a5,t4,800057a8 <core_bench_list+0x1e8>
8000579c:	00072703          	lw	a4,0(a4)
800057a0:	00178793          	add	a5,a5,1
800057a4:	fe071ae3          	bnez	a4,80005798 <core_bench_list+0x1d8>
800057a8:	00040613          	mv	a2,s0
800057ac:	000e8593          	mv	a1,t4
800057b0:	00070413          	mv	s0,a4
800057b4:	02f05263          	blez	a5,800057d8 <core_bench_list+0x218>
800057b8:	06059063          	bnez	a1,80005818 <core_bench_list+0x258>
800057bc:	00060713          	mv	a4,a2
800057c0:	00062603          	lw	a2,0(a2)
800057c4:	fff78793          	add	a5,a5,-1
800057c8:	02068663          	beqz	a3,800057f4 <core_bench_list+0x234>
800057cc:	00e6a023          	sw	a4,0(a3)
800057d0:	00070693          	mv	a3,a4
800057d4:	fef042e3          	bgtz	a5,800057b8 <core_bench_list+0x1f8>
800057d8:	0ab05063          	blez	a1,80005878 <core_bench_list+0x2b8>
800057dc:	0a040063          	beqz	s0,8000587c <core_bench_list+0x2bc>
800057e0:	02079e63          	bnez	a5,8000581c <core_bench_list+0x25c>
800057e4:	00040713          	mv	a4,s0
800057e8:	fff58593          	add	a1,a1,-1
800057ec:	00042403          	lw	s0,0(s0)
800057f0:	fc069ee3          	bnez	a3,800057cc <core_bench_list+0x20c>
800057f4:	00070913          	mv	s2,a4
800057f8:	00070693          	mv	a3,a4
800057fc:	fd9ff06f          	j	800057d4 <core_bench_list+0x214>
80005800:	00092903          	lw	s2,0(s2)
80005804:	20090a63          	beqz	s2,80005a18 <core_bench_list+0x458>
80005808:	00492783          	lw	a5,4(s2)
8000580c:	0007c783          	lbu	a5,0(a5)
80005810:	fefc98e3          	bne	s9,a5,80005800 <core_bench_list+0x240>
80005814:	f25ff06f          	j	80005738 <core_bench_list+0x178>
80005818:	fa0402e3          	beqz	s0,800057bc <core_bench_list+0x1fc>
8000581c:	00462803          	lw	a6,4(a2)
80005820:	00442503          	lw	a0,4(s0)
80005824:	00081703          	lh	a4,0(a6)
80005828:	00251303          	lh	t1,2(a0)
8000582c:	00281e03          	lh	t3,2(a6)
80005830:	01071893          	sll	a7,a4,0x10
80005834:	0108d893          	srl	a7,a7,0x10
80005838:	f0077713          	and	a4,a4,-256
8000583c:	0088d893          	srl	a7,a7,0x8
80005840:	01176733          	or	a4,a4,a7
80005844:	00e81023          	sh	a4,0(a6)
80005848:	00051703          	lh	a4,0(a0)
8000584c:	01071813          	sll	a6,a4,0x10
80005850:	01085813          	srl	a6,a6,0x10
80005854:	f0077713          	and	a4,a4,-256
80005858:	00885813          	srl	a6,a6,0x8
8000585c:	01076733          	or	a4,a4,a6
80005860:	00e51023          	sh	a4,0(a0)
80005864:	f5c35ce3          	bge	t1,t3,800057bc <core_bench_list+0x1fc>
80005868:	00040713          	mv	a4,s0
8000586c:	fff58593          	add	a1,a1,-1
80005870:	00042403          	lw	s0,0(s0)
80005874:	f55ff06f          	j	800057c8 <core_bench_list+0x208>
80005878:	f0041ae3          	bnez	s0,8000578c <core_bench_list+0x1cc>
8000587c:	0006a023          	sw	zero,0(a3)
80005880:	07ff0463          	beq	t5,t6,800058e8 <core_bench_list+0x328>
80005884:	00090413          	mv	s0,s2
80005888:	001e9e93          	sll	t4,t4,0x1
8000588c:	ee041ae3          	bnez	s0,80005780 <core_bench_list+0x1c0>
80005890:	00002023          	sw	zero,0(zero) # 0 <__stack_size-0x4000>
80005894:	00100073          	ebreak
80005898:	1a040e63          	beqz	s0,80005a54 <core_bench_list+0x494>
8000589c:	00040793          	mv	a5,s0
800058a0:	00c0006f          	j	800058ac <core_bench_list+0x2ec>
800058a4:	0007a783          	lw	a5,0(a5)
800058a8:	da0780e3          	beqz	a5,80005648 <core_bench_list+0x88>
800058ac:	0047a703          	lw	a4,4(a5)
800058b0:	00074703          	lbu	a4,0(a4)
800058b4:	feec98e3          	bne	s9,a4,800058a4 <core_bench_list+0x2e4>
800058b8:	d91ff06f          	j	80005648 <core_bench_list+0x88>
800058bc:	00042783          	lw	a5,0(s0)
800058c0:	00180813          	add	a6,a6,1
800058c4:	01081813          	sll	a6,a6,0x10
800058c8:	0047a783          	lw	a5,4(a5)
800058cc:	01085813          	srl	a6,a6,0x10
800058d0:	00178783          	lb	a5,1(a5)
800058d4:	0017f793          	and	a5,a5,1
800058d8:	00f487b3          	add	a5,s1,a5
800058dc:	01079493          	sll	s1,a5,0x10
800058e0:	0104d493          	srl	s1,s1,0x10
800058e4:	dd1ff06f          	j	800056b4 <core_bench_list+0xf4>
800058e8:	00092403          	lw	s0,0(s2)
800058ec:	02040063          	beqz	s0,8000590c <core_bench_list+0x34c>
800058f0:	00492783          	lw	a5,4(s2)
800058f4:	00048593          	mv	a1,s1
800058f8:	00079503          	lh	a0,0(a5)
800058fc:	710020ef          	jal	8000800c <crc16>
80005900:	00042403          	lw	s0,0(s0)
80005904:	00050493          	mv	s1,a0
80005908:	fe0414e3          	bnez	s0,800058f0 <core_bench_list+0x330>
8000590c:	03c12083          	lw	ra,60(sp)
80005910:	03812403          	lw	s0,56(sp)
80005914:	03012903          	lw	s2,48(sp)
80005918:	02c12983          	lw	s3,44(sp)
8000591c:	02812a03          	lw	s4,40(sp)
80005920:	02412a83          	lw	s5,36(sp)
80005924:	02012b03          	lw	s6,32(sp)
80005928:	01c12b83          	lw	s7,28(sp)
8000592c:	01812c03          	lw	s8,24(sp)
80005930:	01412c83          	lw	s9,20(sp)
80005934:	01012d03          	lw	s10,16(sp)
80005938:	00c12d83          	lw	s11,12(sp)
8000593c:	00048513          	mv	a0,s1
80005940:	03412483          	lw	s1,52(sp)
80005944:	04010113          	add	sp,sp,64
80005948:	00008067          	ret
8000594c:	00100a13          	li	s4,1
80005950:	f40400e3          	beqz	s0,80005890 <core_bench_list+0x2d0>
80005954:	00000993          	li	s3,0
80005958:	00000a93          	li	s5,0
8000595c:	00000c13          	li	s8,0
80005960:	001c0c13          	add	s8,s8,1
80005964:	00040793          	mv	a5,s0
80005968:	00000913          	li	s2,0
8000596c:	01495863          	bge	s2,s4,8000597c <core_bench_list+0x3bc>
80005970:	0007a783          	lw	a5,0(a5)
80005974:	00190913          	add	s2,s2,1
80005978:	fe079ae3          	bnez	a5,8000596c <core_bench_list+0x3ac>
8000597c:	00040d93          	mv	s11,s0
80005980:	000a0d13          	mv	s10,s4
80005984:	00078413          	mv	s0,a5
80005988:	03205263          	blez	s2,800059ac <core_bench_list+0x3ec>
8000598c:	040d1463          	bnez	s10,800059d4 <core_bench_list+0x414>
80005990:	000d8793          	mv	a5,s11
80005994:	000dad83          	lw	s11,0(s11)
80005998:	fff90913          	add	s2,s2,-1
8000599c:	02098663          	beqz	s3,800059c8 <core_bench_list+0x408>
800059a0:	00f9a023          	sw	a5,0(s3)
800059a4:	00078993          	mv	s3,a5
800059a8:	ff2042e3          	bgtz	s2,8000598c <core_bench_list+0x3cc>
800059ac:	05a05863          	blez	s10,800059fc <core_bench_list+0x43c>
800059b0:	04040863          	beqz	s0,80005a00 <core_bench_list+0x440>
800059b4:	02091263          	bnez	s2,800059d8 <core_bench_list+0x418>
800059b8:	00040793          	mv	a5,s0
800059bc:	fffd0d13          	add	s10,s10,-1
800059c0:	00042403          	lw	s0,0(s0)
800059c4:	fc099ee3          	bnez	s3,800059a0 <core_bench_list+0x3e0>
800059c8:	00078a93          	mv	s5,a5
800059cc:	00078993          	mv	s3,a5
800059d0:	fd9ff06f          	j	800059a8 <core_bench_list+0x3e8>
800059d4:	fa040ee3          	beqz	s0,80005990 <core_bench_list+0x3d0>
800059d8:	00442583          	lw	a1,4(s0)
800059dc:	004da503          	lw	a0,4(s11)
800059e0:	000b0613          	mv	a2,s6
800059e4:	9e9ff0ef          	jal	800053cc <cmp_complex>
800059e8:	faa054e3          	blez	a0,80005990 <core_bench_list+0x3d0>
800059ec:	00040793          	mv	a5,s0
800059f0:	fffd0d13          	add	s10,s10,-1
800059f4:	00042403          	lw	s0,0(s0)
800059f8:	fa5ff06f          	j	8000599c <core_bench_list+0x3dc>
800059fc:	f60412e3          	bnez	s0,80005960 <core_bench_list+0x3a0>
80005a00:	0009a023          	sw	zero,0(s3)
80005a04:	00100793          	li	a5,1
80005a08:	02fc0c63          	beq	s8,a5,80005a40 <core_bench_list+0x480>
80005a0c:	001a1a13          	sll	s4,s4,0x1
80005a10:	000a8413          	mv	s0,s5
80005a14:	f3dff06f          	j	80005950 <core_bench_list+0x390>
80005a18:	00042903          	lw	s2,0(s0)
80005a1c:	d40900e3          	beqz	s2,8000575c <core_bench_list+0x19c>
80005a20:	00442783          	lw	a5,4(s0)
80005a24:	00048593          	mv	a1,s1
80005a28:	00079503          	lh	a0,0(a5)
80005a2c:	5e0020ef          	jal	8000800c <crc16>
80005a30:	00092903          	lw	s2,0(s2)
80005a34:	00050493          	mv	s1,a0
80005a38:	d00910e3          	bnez	s2,80005738 <core_bench_list+0x178>
80005a3c:	d19ff06f          	j	80005754 <core_bench_list+0x194>
80005a40:	000a8413          	mv	s0,s5
80005a44:	ca9ff06f          	j	800056ec <core_bench_list+0x12c>
80005a48:	00000493          	li	s1,0
80005a4c:	00000c93          	li	s9,0
80005a50:	c99ff06f          	j	800056e8 <core_bench_list+0x128>
80005a54:	00002783          	lw	a5,0(zero) # 0 <__stack_size-0x4000>
80005a58:	00100073          	ebreak

80005a5c <core_list_init>:
80005a5c:	fe010113          	add	sp,sp,-32
80005a60:	00812c23          	sw	s0,24(sp)
80005a64:	00058413          	mv	s0,a1
80005a68:	01400593          	li	a1,20
80005a6c:	01312623          	sw	s3,12(sp)
80005a70:	00112e23          	sw	ra,28(sp)
80005a74:	00060993          	mv	s3,a2
80005a78:	00912a23          	sw	s1,20(sp)
80005a7c:	01212823          	sw	s2,16(sp)
80005a80:	9e8fd0ef          	jal	80002c68 <__hidden___udivsi3>
80005a84:	ffe50513          	add	a0,a0,-2
80005a88:	00351593          	sll	a1,a0,0x3
80005a8c:	00b405b3          	add	a1,s0,a1
80005a90:	ffff87b7          	lui	a5,0xffff8
80005a94:	00042023          	sw	zero,0(s0)
80005a98:	00b42223          	sw	a1,4(s0)
80005a9c:	08078793          	add	a5,a5,128 # ffff8080 <__stack_base+0x5ffe8080>
80005aa0:	00251e13          	sll	t3,a0,0x2
80005aa4:	00059123          	sh	zero,2(a1)
80005aa8:	00f59023          	sh	a5,0(a1)
80005aac:	01040613          	add	a2,s0,16
80005ab0:	01c58e33          	add	t3,a1,t3
80005ab4:	00840713          	add	a4,s0,8
80005ab8:	00458693          	add	a3,a1,4
80005abc:	26b67a63          	bgeu	a2,a1,80005d30 <core_list_init+0x2d4>
80005ac0:	00858813          	add	a6,a1,8
80005ac4:	27c87663          	bgeu	a6,t3,80005d30 <core_list_init+0x2d4>
80005ac8:	ffff87b7          	lui	a5,0xffff8
80005acc:	00e42023          	sw	a4,0(s0)
80005ad0:	00d42623          	sw	a3,12(s0)
80005ad4:	00042423          	sw	zero,8(s0)
80005ad8:	00070493          	mv	s1,a4
80005adc:	fff7c793          	not	a5,a5
80005ae0:	fff00713          	li	a4,-1
80005ae4:	00e59223          	sh	a4,4(a1)
80005ae8:	00f59323          	sh	a5,6(a1)
80005aec:	00080693          	mv	a3,a6
80005af0:	00060713          	mv	a4,a2
80005af4:	06050e63          	beqz	a0,80005b70 <core_list_init+0x114>
80005af8:	01099f13          	sll	t5,s3,0x10
80005afc:	ffff8eb7          	lui	t4,0xffff8
80005b00:	00870893          	add	a7,a4,8
80005b04:	010f5f13          	srl	t5,t5,0x10
80005b08:	00000613          	li	a2,0
80005b0c:	fffece93          	not	t4,t4
80005b10:	06b8f063          	bgeu	a7,a1,80005b70 <core_list_init+0x114>
80005b14:	00468313          	add	t1,a3,4
80005b18:	23c37063          	bgeu	t1,t3,80005d38 <core_list_init+0x2dc>
80005b1c:	01061813          	sll	a6,a2,0x10
80005b20:	01085813          	srl	a6,a6,0x10
80005b24:	01e847b3          	xor	a5,a6,t5
80005b28:	00379793          	sll	a5,a5,0x3
80005b2c:	00787813          	and	a6,a6,7
80005b30:	0787f793          	and	a5,a5,120
80005b34:	00972023          	sw	s1,0(a4)
80005b38:	0107e7b3          	or	a5,a5,a6
80005b3c:	00e42023          	sw	a4,0(s0)
80005b40:	00879813          	sll	a6,a5,0x8
80005b44:	00d72223          	sw	a3,4(a4)
80005b48:	010787b3          	add	a5,a5,a6
80005b4c:	00f69023          	sh	a5,0(a3)
80005b50:	01d69123          	sh	t4,2(a3)
80005b54:	00160613          	add	a2,a2,1
80005b58:	1cc50863          	beq	a0,a2,80005d28 <core_list_init+0x2cc>
80005b5c:	00070493          	mv	s1,a4
80005b60:	00088713          	mv	a4,a7
80005b64:	00870893          	add	a7,a4,8
80005b68:	00030693          	mv	a3,t1
80005b6c:	fab8e4e3          	bltu	a7,a1,80005b14 <core_list_init+0xb8>
80005b70:	0004a903          	lw	s2,0(s1)
80005b74:	06090c63          	beqz	s2,80005bec <core_list_init+0x190>
80005b78:	00500593          	li	a1,5
80005b7c:	8ecfd0ef          	jal	80002c68 <__hidden___udivsi3>
80005b80:	00004837          	lui	a6,0x4
80005b84:	20000793          	li	a5,512
80005b88:	00100713          	li	a4,1
80005b8c:	fff80813          	add	a6,a6,-1 # 3fff <__stack_size-0x1>
80005b90:	0280006f          	j	80005bb8 <core_list_init+0x15c>
80005b94:	00092683          	lw	a3,0(s2)
80005b98:	10078793          	add	a5,a5,256 # ffff8100 <__stack_base+0x5ffe8100>
80005b9c:	00e59123          	sh	a4,2(a1)
80005ba0:	01079793          	sll	a5,a5,0x10
80005ba4:	00170713          	add	a4,a4,1
80005ba8:	0107d793          	srl	a5,a5,0x10
80005bac:	04068063          	beqz	a3,80005bec <core_list_init+0x190>
80005bb0:	00090493          	mv	s1,s2
80005bb4:	00068913          	mv	s2,a3
80005bb8:	0044a583          	lw	a1,4(s1)
80005bbc:	fca76ce3          	bltu	a4,a0,80005b94 <core_list_init+0x138>
80005bc0:	013746b3          	xor	a3,a4,s3
80005bc4:	7007f613          	and	a2,a5,1792
80005bc8:	00d66633          	or	a2,a2,a3
80005bcc:	00092683          	lw	a3,0(s2)
80005bd0:	01067633          	and	a2,a2,a6
80005bd4:	10078793          	add	a5,a5,256
80005bd8:	01079793          	sll	a5,a5,0x10
80005bdc:	00c59123          	sh	a2,2(a1)
80005be0:	00170713          	add	a4,a4,1
80005be4:	0107d793          	srl	a5,a5,0x10
80005be8:	fc0694e3          	bnez	a3,80005bb0 <core_list_init+0x154>
80005bec:	00100f13          	li	t5,1
80005bf0:	00000593          	li	a1,0
80005bf4:	00000513          	li	a0,0
80005bf8:	00000f93          	li	t6,0
80005bfc:	00100293          	li	t0,1
80005c00:	001f8f93          	add	t6,t6,1
80005c04:	00040793          	mv	a5,s0
80005c08:	00000713          	li	a4,0
80005c0c:	01e75863          	bge	a4,t5,80005c1c <core_list_init+0x1c0>
80005c10:	0007a783          	lw	a5,0(a5)
80005c14:	00170713          	add	a4,a4,1
80005c18:	fe079ae3          	bnez	a5,80005c0c <core_list_init+0x1b0>
80005c1c:	000f0613          	mv	a2,t5
80005c20:	02e05263          	blez	a4,80005c44 <core_list_init+0x1e8>
80005c24:	04061463          	bnez	a2,80005c6c <core_list_init+0x210>
80005c28:	00042683          	lw	a3,0(s0)
80005c2c:	fff70713          	add	a4,a4,-1
80005c30:	02058a63          	beqz	a1,80005c64 <core_list_init+0x208>
80005c34:	0085a023          	sw	s0,0(a1)
80005c38:	00040593          	mv	a1,s0
80005c3c:	00068413          	mv	s0,a3
80005c40:	fee042e3          	bgtz	a4,80005c24 <core_list_init+0x1c8>
80005c44:	08c05663          	blez	a2,80005cd0 <core_list_init+0x274>
80005c48:	08078a63          	beqz	a5,80005cdc <core_list_init+0x280>
80005c4c:	02071263          	bnez	a4,80005c70 <core_list_init+0x214>
80005c50:	00040693          	mv	a3,s0
80005c54:	fff60613          	add	a2,a2,-1
80005c58:	00078413          	mv	s0,a5
80005c5c:	0007a783          	lw	a5,0(a5)
80005c60:	fc059ae3          	bnez	a1,80005c34 <core_list_init+0x1d8>
80005c64:	00040513          	mv	a0,s0
80005c68:	fd1ff06f          	j	80005c38 <core_list_init+0x1dc>
80005c6c:	fa078ee3          	beqz	a5,80005c28 <core_list_init+0x1cc>
80005c70:	00442883          	lw	a7,4(s0)
80005c74:	0047a803          	lw	a6,4(a5)
80005c78:	00089683          	lh	a3,0(a7)
80005c7c:	00281e03          	lh	t3,2(a6)
80005c80:	00289e83          	lh	t4,2(a7)
80005c84:	01069313          	sll	t1,a3,0x10
80005c88:	01035313          	srl	t1,t1,0x10
80005c8c:	f006f693          	and	a3,a3,-256
80005c90:	00835313          	srl	t1,t1,0x8
80005c94:	0066e6b3          	or	a3,a3,t1
80005c98:	00d89023          	sh	a3,0(a7)
80005c9c:	00081683          	lh	a3,0(a6)
80005ca0:	01069893          	sll	a7,a3,0x10
80005ca4:	0108d893          	srl	a7,a7,0x10
80005ca8:	f006f693          	and	a3,a3,-256
80005cac:	0088d893          	srl	a7,a7,0x8
80005cb0:	0116e6b3          	or	a3,a3,a7
80005cb4:	00d81023          	sh	a3,0(a6)
80005cb8:	f7de58e3          	bge	t3,t4,80005c28 <core_list_init+0x1cc>
80005cbc:	00040693          	mv	a3,s0
80005cc0:	fff60613          	add	a2,a2,-1
80005cc4:	00078413          	mv	s0,a5
80005cc8:	0007a783          	lw	a5,0(a5)
80005ccc:	f65ff06f          	j	80005c30 <core_list_init+0x1d4>
80005cd0:	00078663          	beqz	a5,80005cdc <core_list_init+0x280>
80005cd4:	00078413          	mv	s0,a5
80005cd8:	f29ff06f          	j	80005c00 <core_list_init+0x1a4>
80005cdc:	0005a023          	sw	zero,0(a1)
80005ce0:	025f8263          	beq	t6,t0,80005d04 <core_list_init+0x2a8>
80005ce4:	001f1f13          	sll	t5,t5,0x1
80005ce8:	02050c63          	beqz	a0,80005d20 <core_list_init+0x2c4>
80005cec:	00050793          	mv	a5,a0
80005cf0:	00000593          	li	a1,0
80005cf4:	00000513          	li	a0,0
80005cf8:	00000f93          	li	t6,0
80005cfc:	00078413          	mv	s0,a5
80005d00:	f01ff06f          	j	80005c00 <core_list_init+0x1a4>
80005d04:	01c12083          	lw	ra,28(sp)
80005d08:	01812403          	lw	s0,24(sp)
80005d0c:	01412483          	lw	s1,20(sp)
80005d10:	01012903          	lw	s2,16(sp)
80005d14:	00c12983          	lw	s3,12(sp)
80005d18:	02010113          	add	sp,sp,32
80005d1c:	00008067          	ret
80005d20:	00002023          	sw	zero,0(zero) # 0 <__stack_size-0x4000>
80005d24:	00100073          	ebreak
80005d28:	00070493          	mv	s1,a4
80005d2c:	e45ff06f          	j	80005b70 <core_list_init+0x114>
80005d30:	00000493          	li	s1,0
80005d34:	dc1ff06f          	j	80005af4 <core_list_init+0x98>
80005d38:	00160613          	add	a2,a2,1
80005d3c:	e2c50ae3          	beq	a0,a2,80005b70 <core_list_init+0x114>
80005d40:	00070893          	mv	a7,a4
80005d44:	00068313          	mv	t1,a3
80005d48:	00048713          	mv	a4,s1
80005d4c:	e11ff06f          	j	80005b5c <core_list_init+0x100>

80005d50 <iterate>:
80005d50:	ff010113          	add	sp,sp,-16
80005d54:	01212023          	sw	s2,0(sp)
80005d58:	01c52903          	lw	s2,28(a0)
80005d5c:	00112623          	sw	ra,12(sp)
80005d60:	02052c23          	sw	zero,56(a0)
80005d64:	02052e23          	sw	zero,60(a0)
80005d68:	04090c63          	beqz	s2,80005dc0 <iterate+0x70>
80005d6c:	00812423          	sw	s0,8(sp)
80005d70:	00912223          	sw	s1,4(sp)
80005d74:	00050413          	mv	s0,a0
80005d78:	00000493          	li	s1,0
80005d7c:	00100593          	li	a1,1
80005d80:	00040513          	mv	a0,s0
80005d84:	83dff0ef          	jal	800055c0 <core_bench_list>
80005d88:	03845583          	lhu	a1,56(s0)
80005d8c:	39d010ef          	jal	80007928 <crcu16>
80005d90:	02a41c23          	sh	a0,56(s0)
80005d94:	fff00593          	li	a1,-1
80005d98:	00040513          	mv	a0,s0
80005d9c:	825ff0ef          	jal	800055c0 <core_bench_list>
80005da0:	03845583          	lhu	a1,56(s0)
80005da4:	385010ef          	jal	80007928 <crcu16>
80005da8:	02a41c23          	sh	a0,56(s0)
80005dac:	02048463          	beqz	s1,80005dd4 <iterate+0x84>
80005db0:	00148493          	add	s1,s1,1
80005db4:	fc9914e3          	bne	s2,s1,80005d7c <iterate+0x2c>
80005db8:	00812403          	lw	s0,8(sp)
80005dbc:	00412483          	lw	s1,4(sp)
80005dc0:	00c12083          	lw	ra,12(sp)
80005dc4:	00012903          	lw	s2,0(sp)
80005dc8:	00000513          	li	a0,0
80005dcc:	01010113          	add	sp,sp,16
80005dd0:	00008067          	ret
80005dd4:	02a41d23          	sh	a0,58(s0)
80005dd8:	00100793          	li	a5,1
80005ddc:	fcf90ee3          	beq	s2,a5,80005db8 <iterate+0x68>
80005de0:	00100493          	li	s1,1
80005de4:	f99ff06f          	j	80005d7c <iterate+0x2c>

80005de8 <main>:
80005de8:	81010113          	add	sp,sp,-2032
80005dec:	00001737          	lui	a4,0x1
80005df0:	7e112623          	sw	ra,2028(sp)
80005df4:	7e812423          	sw	s0,2024(sp)
80005df8:	7e912223          	sw	s1,2020(sp)
80005dfc:	7f212023          	sw	s2,2016(sp)
80005e00:	7d312e23          	sw	s3,2012(sp)
80005e04:	7d412c23          	sw	s4,2008(sp)
80005e08:	7d512a23          	sw	s5,2004(sp)
80005e0c:	7d612823          	sw	s6,2000(sp)
80005e10:	7d712623          	sw	s7,1996(sp)
80005e14:	7d812423          	sw	s8,1992(sp)
80005e18:	7d912223          	sw	s9,1988(sp)
80005e1c:	7da12023          	sw	s10,1984(sp)
80005e20:	7bb12e23          	sw	s11,1980(sp)
80005e24:	82070693          	add	a3,a4,-2016 # 820 <__stack_size-0x37e0>
80005e28:	f7010113          	add	sp,sp,-144
80005e2c:	fffff7b7          	lui	a5,0xfffff
80005e30:	00f686b3          	add	a3,a3,a5
80005e34:	02010793          	add	a5,sp,32
80005e38:	00f687b3          	add	a5,a3,a5
80005e3c:	fffff637          	lui	a2,0xfffff
80005e40:	00f12623          	sw	a5,12(sp)
80005e44:	7e860613          	add	a2,a2,2024 # fffff7e8 <__stack_base+0x5ffef7e8>
80005e48:	82070793          	add	a5,a4,-2016
80005e4c:	02010693          	add	a3,sp,32
80005e50:	00c787b3          	add	a5,a5,a2
80005e54:	fffff5b7          	lui	a1,0xfffff
80005e58:	00d78633          	add	a2,a5,a3
80005e5c:	7e458593          	add	a1,a1,2020 # fffff7e4 <__stack_base+0x5ffef7e4>
80005e60:	82070793          	add	a5,a4,-2016
80005e64:	00b787b3          	add	a5,a5,a1
80005e68:	00d785b3          	add	a1,a5,a3
80005e6c:	00c12783          	lw	a5,12(sp)
80005e70:	06e10513          	add	a0,sp,110
80005e74:	7e07a223          	sw	zero,2020(a5) # fffff7e4 <__stack_base+0x5ffef7e4>
80005e78:	494020ef          	jal	8000830c <portable_init>
80005e7c:	00100513          	li	a0,1
80005e80:	245010ef          	jal	800078c4 <get_seed_32>
80005e84:	00c12703          	lw	a4,12(sp)
80005e88:	00050793          	mv	a5,a0
80005e8c:	00200513          	li	a0,2
80005e90:	7ef71623          	sh	a5,2028(a4)
80005e94:	231010ef          	jal	800078c4 <get_seed_32>
80005e98:	00c12703          	lw	a4,12(sp)
80005e9c:	00050793          	mv	a5,a0
80005ea0:	00300513          	li	a0,3
80005ea4:	7ef71723          	sh	a5,2030(a4)
80005ea8:	21d010ef          	jal	800078c4 <get_seed_32>
80005eac:	00c12703          	lw	a4,12(sp)
80005eb0:	00050793          	mv	a5,a0
80005eb4:	00400513          	li	a0,4
80005eb8:	7ef71823          	sh	a5,2032(a4)
80005ebc:	209010ef          	jal	800078c4 <get_seed_32>
80005ec0:	00050793          	mv	a5,a0
80005ec4:	00500513          	li	a0,5
80005ec8:	04f12423          	sw	a5,72(sp)
80005ecc:	1f9010ef          	jal	800078c4 <get_seed_32>
80005ed0:	00051463          	bnez	a0,80005ed8 <main+0xf0>
80005ed4:	00700513          	li	a0,7
80005ed8:	00001737          	lui	a4,0x1
80005edc:	fffff7b7          	lui	a5,0xfffff
80005ee0:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
80005ee4:	00f70733          	add	a4,a4,a5
80005ee8:	02010793          	add	a5,sp,32
80005eec:	00f707b3          	add	a5,a4,a5
80005ef0:	00f12623          	sw	a5,12(sp)
80005ef4:	7ec7a783          	lw	a5,2028(a5) # fffff7ec <__stack_base+0x5ffef7ec>
80005ef8:	04a12623          	sw	a0,76(sp)
80005efc:	36079863          	bnez	a5,8000626c <main+0x484>
80005f00:	00c12783          	lw	a5,12(sp)
80005f04:	7f079783          	lh	a5,2032(a5)
80005f08:	54078a63          	beqz	a5,8000645c <main+0x674>
80005f0c:	00001737          	lui	a4,0x1
80005f10:	fffff7b7          	lui	a5,0xfffff
80005f14:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
80005f18:	00f70733          	add	a4,a4,a5
80005f1c:	02010793          	add	a5,sp,32
80005f20:	00f707b3          	add	a5,a4,a5
80005f24:	00257993          	and	s3,a0,2
80005f28:	07010713          	add	a4,sp,112
80005f2c:	00157913          	and	s2,a0,1
80005f30:	013035b3          	snez	a1,s3
80005f34:	00f12623          	sw	a5,12(sp)
80005f38:	7ee7aa23          	sw	a4,2036(a5) # fffff7f4 <__stack_base+0x5ffef7f4>
80005f3c:	06011623          	sh	zero,108(sp)
80005f40:	00457a13          	and	s4,a0,4
80005f44:	00b904b3          	add	s1,s2,a1
80005f48:	2e0a1863          	bnez	s4,80006238 <main+0x450>
80005f4c:	00048593          	mv	a1,s1
80005f50:	7d000513          	li	a0,2000
80005f54:	d15fc0ef          	jal	80002c68 <__hidden___udivsi3>
80005f58:	04a12223          	sw	a0,68(sp)
80005f5c:	00050593          	mv	a1,a0
80005f60:	fffff737          	lui	a4,0xfffff
80005f64:	52091a63          	bnez	s2,80006498 <main+0x6b0>
80005f68:	50099263          	bnez	s3,8000646c <main+0x684>
80005f6c:	000016b7          	lui	a3,0x1
80005f70:	fffff737          	lui	a4,0xfffff
80005f74:	04c12783          	lw	a5,76(sp)
80005f78:	82068693          	add	a3,a3,-2016 # 820 <__stack_size-0x37e0>
80005f7c:	00e686b3          	add	a3,a3,a4
80005f80:	02010713          	add	a4,sp,32
80005f84:	00e68733          	add	a4,a3,a4
80005f88:	00e12623          	sw	a4,12(sp)
80005f8c:	0017f713          	and	a4,a5,1
80005f90:	02070063          	beqz	a4,80005fb0 <main+0x1c8>
80005f94:	00c12783          	lw	a5,12(sp)
80005f98:	04412503          	lw	a0,68(sp)
80005f9c:	7ec79603          	lh	a2,2028(a5)
80005fa0:	7f87a583          	lw	a1,2040(a5)
80005fa4:	ab9ff0ef          	jal	80005a5c <core_list_init>
80005fa8:	04c12783          	lw	a5,76(sp)
80005fac:	04a12823          	sw	a0,80(sp)
80005fb0:	0027f713          	and	a4,a5,2
80005fb4:	22071a63          	bnez	a4,800061e8 <main+0x400>
80005fb8:	0047f793          	and	a5,a5,4
80005fbc:	02078863          	beqz	a5,80005fec <main+0x204>
80005fc0:	00001737          	lui	a4,0x1
80005fc4:	fffff7b7          	lui	a5,0xfffff
80005fc8:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
80005fcc:	00f70733          	add	a4,a4,a5
80005fd0:	02010793          	add	a5,sp,32
80005fd4:	00f707b3          	add	a5,a4,a5
80005fd8:	04012603          	lw	a2,64(sp)
80005fdc:	7ec79583          	lh	a1,2028(a5) # fffff7ec <__stack_base+0x5ffef7ec>
80005fe0:	04412503          	lw	a0,68(sp)
80005fe4:	00f12623          	sw	a5,12(sp)
80005fe8:	1a4010ef          	jal	8000718c <core_init_state>
80005fec:	04812783          	lw	a5,72(sp)
80005ff0:	0e079863          	bnez	a5,800060e0 <main+0x2f8>
80005ff4:	a00017b7          	lui	a5,0xa0001
80005ff8:	d507a903          	lw	s2,-688(a5) # a0000d50 <intpat+0x98>
80005ffc:	d547a983          	lw	s3,-684(a5)
80006000:	00100793          	li	a5,1
80006004:	fffff4b7          	lui	s1,0xfffff
80006008:	04f12423          	sw	a5,72(sp)
8000600c:	000017b7          	lui	a5,0x1
80006010:	7ec48493          	add	s1,s1,2028 # fffff7ec <__stack_base+0x5ffef7ec>
80006014:	82078793          	add	a5,a5,-2016 # 820 <__stack_size-0x37e0>
80006018:	009787b3          	add	a5,a5,s1
8000601c:	02010713          	add	a4,sp,32
80006020:	00e784b3          	add	s1,a5,a4
80006024:	04812703          	lw	a4,72(sp)
80006028:	00000413          	li	s0,0
8000602c:	00271793          	sll	a5,a4,0x2
80006030:	00e787b3          	add	a5,a5,a4
80006034:	00179793          	sll	a5,a5,0x1
80006038:	04f12423          	sw	a5,72(sp)
8000603c:	22c020ef          	jal	80008268 <start_time>
80006040:	04812a03          	lw	s4,72(sp)
80006044:	06012223          	sw	zero,100(sp)
80006048:	06012423          	sw	zero,104(sp)
8000604c:	040a0263          	beqz	s4,80006090 <main+0x2a8>
80006050:	00100593          	li	a1,1
80006054:	00048513          	mv	a0,s1
80006058:	d68ff0ef          	jal	800055c0 <core_bench_list>
8000605c:	06415583          	lhu	a1,100(sp)
80006060:	0c9010ef          	jal	80007928 <crcu16>
80006064:	00050793          	mv	a5,a0
80006068:	fff00593          	li	a1,-1
8000606c:	00048513          	mv	a0,s1
80006070:	06f11223          	sh	a5,100(sp)
80006074:	d4cff0ef          	jal	800055c0 <core_bench_list>
80006078:	06415583          	lhu	a1,100(sp)
8000607c:	0ad010ef          	jal	80007928 <crcu16>
80006080:	06a11223          	sh	a0,100(sp)
80006084:	14040863          	beqz	s0,800061d4 <main+0x3ec>
80006088:	00140413          	add	s0,s0,1
8000608c:	fc8a12e3          	bne	s4,s0,80006050 <main+0x268>
80006090:	200020ef          	jal	80008290 <stop_time>
80006094:	224020ef          	jal	800082b8 <get_time>
80006098:	24c020ef          	jal	800082e4 <time_in_secs>
8000609c:	00090613          	mv	a2,s2
800060a0:	00098693          	mv	a3,s3
800060a4:	00050a13          	mv	s4,a0
800060a8:	00058413          	mv	s0,a1
800060ac:	949fb0ef          	jal	800019f4 <__ledf2>
800060b0:	f6054ae3          	bltz	a0,80006024 <main+0x23c>
800060b4:	00040593          	mv	a1,s0
800060b8:	000a0513          	mv	a0,s4
800060bc:	82dfc0ef          	jal	800028e8 <__fixunsdfsi>
800060c0:	00050593          	mv	a1,a0
800060c4:	38050863          	beqz	a0,80006454 <main+0x66c>
800060c8:	00a00513          	li	a0,10
800060cc:	b9dfc0ef          	jal	80002c68 <__hidden___udivsi3>
800060d0:	04812583          	lw	a1,72(sp)
800060d4:	00150513          	add	a0,a0,1
800060d8:	b65fc0ef          	jal	80002c3c <__mulsi3>
800060dc:	04a12423          	sw	a0,72(sp)
800060e0:	188020ef          	jal	80008268 <start_time>
800060e4:	00001437          	lui	s0,0x1
800060e8:	fffff537          	lui	a0,0xfffff
800060ec:	7ec50513          	add	a0,a0,2028 # fffff7ec <__stack_base+0x5ffef7ec>
800060f0:	82040793          	add	a5,s0,-2016 # 820 <__stack_size-0x37e0>
800060f4:	00a787b3          	add	a5,a5,a0
800060f8:	02010713          	add	a4,sp,32
800060fc:	00e78533          	add	a0,a5,a4
80006100:	c51ff0ef          	jal	80005d50 <iterate>
80006104:	18c020ef          	jal	80008290 <stop_time>
80006108:	1b0020ef          	jal	800082b8 <get_time>
8000610c:	fffff7b7          	lui	a5,0xfffff
80006110:	82040713          	add	a4,s0,-2016
80006114:	00f70733          	add	a4,a4,a5
80006118:	02010793          	add	a5,sp,32
8000611c:	00f707b3          	add	a5,a4,a5
80006120:	00050493          	mv	s1,a0
80006124:	7ec79503          	lh	a0,2028(a5) # fffff7ec <__stack_base+0x5ffef7ec>
80006128:	00058913          	mv	s2,a1
8000612c:	00000593          	li	a1,0
80006130:	00f12623          	sw	a5,12(sp)
80006134:	00912a23          	sw	s1,20(sp)
80006138:	01212c23          	sw	s2,24(sp)
8000613c:	6d1010ef          	jal	8000800c <crc16>
80006140:	00c12783          	lw	a5,12(sp)
80006144:	00050593          	mv	a1,a0
80006148:	7ee79503          	lh	a0,2030(a5)
8000614c:	6c1010ef          	jal	8000800c <crc16>
80006150:	00c12783          	lw	a5,12(sp)
80006154:	00050593          	mv	a1,a0
80006158:	7f079503          	lh	a0,2032(a5)
8000615c:	6b1010ef          	jal	8000800c <crc16>
80006160:	00050593          	mv	a1,a0
80006164:	04411503          	lh	a0,68(sp)
80006168:	6a5010ef          	jal	8000800c <crc16>
8000616c:	000087b7          	lui	a5,0x8
80006170:	b0578793          	add	a5,a5,-1275 # 7b05 <__stack_size+0x3b05>
80006174:	00050413          	mv	s0,a0
80006178:	76f50463          	beq	a0,a5,800068e0 <main+0xaf8>
8000617c:	12a7f063          	bgeu	a5,a0,8000629c <main+0x4b4>
80006180:	000097b7          	lui	a5,0x9
80006184:	a0278793          	add	a5,a5,-1534 # 8a02 <__stack_size+0x4a02>
80006188:	7cf50663          	beq	a0,a5,80006954 <main+0xb6c>
8000618c:	0000f7b7          	lui	a5,0xf
80006190:	9f578793          	add	a5,a5,-1547 # e9f5 <__stack_size+0xa9f5>
80006194:	32f51a63          	bne	a0,a5,800064c8 <main+0x6e0>
80006198:	a0000537          	lui	a0,0xa0000
8000619c:	67c50513          	add	a0,a0,1660 # a000067c <__clz_tab+0x640>
800061a0:	9d8ff0ef          	jal	80005378 <printf_>
800061a4:	00009a37          	lui	s4,0x9
800061a8:	00002ab7          	lui	s5,0x2
800061ac:	0000e9b7          	lui	s3,0xe
800061b0:	e3aa0a13          	add	s4,s4,-454 # 8e3a <__stack_size+0x4e3a>
800061b4:	fd7a8a93          	add	s5,s5,-41 # 1fd7 <__stack_size-0x2029>
800061b8:	71498993          	add	s3,s3,1812 # e714 <__stack_size+0xa714>
800061bc:	00300793          	li	a5,3
800061c0:	000a0c13          	mv	s8,s4
800061c4:	000a8b93          	mv	s7,s5
800061c8:	00098b13          	mv	s6,s3
800061cc:	00f12e23          	sw	a5,28(sp)
800061d0:	11c0006f          	j	800062ec <main+0x504>
800061d4:	06a11323          	sh	a0,102(sp)
800061d8:	00100793          	li	a5,1
800061dc:	eafa0ae3          	beq	s4,a5,80006090 <main+0x2a8>
800061e0:	00100413          	li	s0,1
800061e4:	e6dff06f          	j	80006050 <main+0x268>
800061e8:	00001737          	lui	a4,0x1
800061ec:	fffff7b7          	lui	a5,0xfffff
800061f0:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
800061f4:	00f70733          	add	a4,a4,a5
800061f8:	02010793          	add	a5,sp,32
800061fc:	00f707b3          	add	a5,a4,a5
80006200:	00f12623          	sw	a5,12(sp)
80006204:	00c12703          	lw	a4,12(sp)
80006208:	7ee79783          	lh	a5,2030(a5) # fffff7ee <__stack_base+0x5ffef7ee>
8000620c:	04412503          	lw	a0,68(sp)
80006210:	7ec71603          	lh	a2,2028(a4)
80006214:	7fc72583          	lw	a1,2044(a4)
80006218:	01079793          	sll	a5,a5,0x10
8000621c:	00c7e633          	or	a2,a5,a2
80006220:	05410693          	add	a3,sp,84
80006224:	569000ef          	jal	80006f8c <core_init_matrix>
80006228:	04c12783          	lw	a5,76(sp)
8000622c:	0047f793          	and	a5,a5,4
80006230:	d80798e3          	bnez	a5,80005fc0 <main+0x1d8>
80006234:	db9ff06f          	j	80005fec <main+0x204>
80006238:	00148593          	add	a1,s1,1
8000623c:	7d000513          	li	a0,2000
80006240:	a29fc0ef          	jal	80002c68 <__hidden___udivsi3>
80006244:	04a12223          	sw	a0,68(sp)
80006248:	00050593          	mv	a1,a0
8000624c:	24091663          	bnez	s2,80006498 <main+0x6b0>
80006250:	74099863          	bnez	s3,800069a0 <main+0xbb8>
80006254:	00048513          	mv	a0,s1
80006258:	9e5fc0ef          	jal	80002c3c <__mulsi3>
8000625c:	07010793          	add	a5,sp,112
80006260:	00a787b3          	add	a5,a5,a0
80006264:	04f12023          	sw	a5,64(sp)
80006268:	d05ff06f          	j	80005f6c <main+0x184>
8000626c:	00100713          	li	a4,1
80006270:	c8e79ee3          	bne	a5,a4,80005f0c <main+0x124>
80006274:	00c12783          	lw	a5,12(sp)
80006278:	7f079783          	lh	a5,2032(a5)
8000627c:	c80798e3          	bnez	a5,80005f0c <main+0x124>
80006280:	00c12703          	lw	a4,12(sp)
80006284:	341537b7          	lui	a5,0x34153
80006288:	41578793          	add	a5,a5,1045 # 34153415 <__stack_size+0x3414f415>
8000628c:	7ef72623          	sw	a5,2028(a4)
80006290:	06600793          	li	a5,102
80006294:	7ef71823          	sh	a5,2032(a4)
80006298:	c75ff06f          	j	80005f0c <main+0x124>
8000629c:	000027b7          	lui	a5,0x2
800062a0:	8f278793          	add	a5,a5,-1806 # 18f2 <__stack_size-0x270e>
800062a4:	66f50c63          	beq	a0,a5,8000691c <main+0xb34>
800062a8:	000057b7          	lui	a5,0x5
800062ac:	eaf78793          	add	a5,a5,-337 # 4eaf <__stack_size+0xeaf>
800062b0:	20f51c63          	bne	a0,a5,800064c8 <main+0x6e0>
800062b4:	a0000537          	lui	a0,0xa0000
800062b8:	64850513          	add	a0,a0,1608 # a0000648 <__clz_tab+0x60c>
800062bc:	8bcff0ef          	jal	80005378 <printf_>
800062c0:	0000ea37          	lui	s4,0xe
800062c4:	00005ab7          	lui	s5,0x5
800062c8:	000079b7          	lui	s3,0x7
800062cc:	5a4a0a13          	add	s4,s4,1444 # e5a4 <__stack_size+0xa5a4>
800062d0:	608a8a93          	add	s5,s5,1544 # 5608 <__stack_size+0x1608>
800062d4:	a7998993          	add	s3,s3,-1415 # 6a79 <__stack_size+0x2a79>
800062d8:	00200793          	li	a5,2
800062dc:	000a0c13          	mv	s8,s4
800062e0:	000a8b93          	mv	s7,s5
800062e4:	00098b13          	mv	s6,s3
800062e8:	00f12e23          	sw	a5,28(sp)
800062ec:	a0001cb7          	lui	s9,0xa0001
800062f0:	d78ca783          	lw	a5,-648(s9) # a0000d78 <default_num_contexts>
800062f4:	68078c63          	beqz	a5,8000698c <main+0xba4>
800062f8:	00001737          	lui	a4,0x1
800062fc:	fffff7b7          	lui	a5,0xfffff
80006300:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
80006304:	00f70733          	add	a4,a4,a5
80006308:	02010793          	add	a5,sp,32
8000630c:	00f707b3          	add	a5,a4,a5
80006310:	00000913          	li	s2,0
80006314:	00000d93          	li	s11,0
80006318:	00f12623          	sw	a5,12(sp)
8000631c:	00001d37          	lui	s10,0x1
80006320:	0640006f          	j	80006384 <main+0x59c>
80006324:	82a7d603          	lhu	a2,-2006(a5) # ffffe82a <__stack_base+0x5ffee82a>
80006328:	13860263          	beq	a2,s8,8000644c <main+0x664>
8000632c:	00f12823          	sw	a5,16(sp)
80006330:	a00007b7          	lui	a5,0xa0000
80006334:	73c78513          	add	a0,a5,1852 # a000073c <__clz_tab+0x700>
80006338:	000a0693          	mv	a3,s4
8000633c:	000d8593          	mv	a1,s11
80006340:	838ff0ef          	jal	80005378 <printf_>
80006344:	01012783          	lw	a5,16(sp)
80006348:	82c7d703          	lhu	a4,-2004(a5)
8000634c:	00170713          	add	a4,a4,1
80006350:	01071713          	sll	a4,a4,0x10
80006354:	01075713          	srl	a4,a4,0x10
80006358:	82e79623          	sh	a4,-2004(a5)
8000635c:	001d8593          	add	a1,s11,1
80006360:	d78ca683          	lw	a3,-648(s9)
80006364:	012707b3          	add	a5,a4,s2
80006368:	01059d93          	sll	s11,a1,0x10
8000636c:	01079713          	sll	a4,a5,0x10
80006370:	01079913          	sll	s2,a5,0x10
80006374:	010ddd93          	srl	s11,s11,0x10
80006378:	01075713          	srl	a4,a4,0x10
8000637c:	41095913          	sra	s2,s2,0x10
80006380:	14ddfe63          	bgeu	s11,a3,800064dc <main+0x6f4>
80006384:	00c12783          	lw	a5,12(sp)
80006388:	004d9493          	sll	s1,s11,0x4
8000638c:	01b48733          	add	a4,s1,s11
80006390:	00271713          	sll	a4,a4,0x2
80006394:	00e78733          	add	a4,a5,a4
80006398:	00ed0733          	add	a4,s10,a4
8000639c:	80c72683          	lw	a3,-2036(a4)
800063a0:	82071623          	sh	zero,-2004(a4)
800063a4:	0016f613          	and	a2,a3,1
800063a8:	02060c63          	beqz	a2,800063e0 <main+0x5f8>
800063ac:	82675603          	lhu	a2,-2010(a4)
800063b0:	00e12823          	sw	a4,16(sp)
800063b4:	03660663          	beq	a2,s6,800063e0 <main+0x5f8>
800063b8:	a00007b7          	lui	a5,0xa0000
800063bc:	00098693          	mv	a3,s3
800063c0:	000d8593          	mv	a1,s11
800063c4:	6d878513          	add	a0,a5,1752 # a00006d8 <__clz_tab+0x69c>
800063c8:	fb1fe0ef          	jal	80005378 <printf_>
800063cc:	01012703          	lw	a4,16(sp)
800063d0:	82c75603          	lhu	a2,-2004(a4)
800063d4:	80c72683          	lw	a3,-2036(a4)
800063d8:	00160613          	add	a2,a2,1
800063dc:	82c71623          	sh	a2,-2004(a4)
800063e0:	0026f713          	and	a4,a3,2
800063e4:	04070663          	beqz	a4,80006430 <main+0x648>
800063e8:	00c12783          	lw	a5,12(sp)
800063ec:	01b48733          	add	a4,s1,s11
800063f0:	00271713          	sll	a4,a4,0x2
800063f4:	00e78733          	add	a4,a5,a4
800063f8:	00ed0733          	add	a4,s10,a4
800063fc:	82875603          	lhu	a2,-2008(a4)
80006400:	00e12823          	sw	a4,16(sp)
80006404:	03760663          	beq	a2,s7,80006430 <main+0x648>
80006408:	a00007b7          	lui	a5,0xa0000
8000640c:	000a8693          	mv	a3,s5
80006410:	000d8593          	mv	a1,s11
80006414:	70878513          	add	a0,a5,1800 # a0000708 <__clz_tab+0x6cc>
80006418:	f61fe0ef          	jal	80005378 <printf_>
8000641c:	01012703          	lw	a4,16(sp)
80006420:	82c75603          	lhu	a2,-2004(a4)
80006424:	80c72683          	lw	a3,-2036(a4)
80006428:	00160613          	add	a2,a2,1
8000642c:	82c71623          	sh	a2,-2004(a4)
80006430:	00c12703          	lw	a4,12(sp)
80006434:	01b487b3          	add	a5,s1,s11
80006438:	00279793          	sll	a5,a5,0x2
8000643c:	00f707b3          	add	a5,a4,a5
80006440:	0046f693          	and	a3,a3,4
80006444:	00fd07b3          	add	a5,s10,a5
80006448:	ec069ee3          	bnez	a3,80006324 <main+0x53c>
8000644c:	82c7d703          	lhu	a4,-2004(a5)
80006450:	f0dff06f          	j	8000635c <main+0x574>
80006454:	00100593          	li	a1,1
80006458:	c71ff06f          	j	800060c8 <main+0x2e0>
8000645c:	00c12703          	lw	a4,12(sp)
80006460:	06600793          	li	a5,102
80006464:	7ef71823          	sh	a5,2032(a4)
80006468:	aa5ff06f          	j	80005f0c <main+0x124>
8000646c:	412007b3          	neg	a5,s2
80006470:	07010693          	add	a3,sp,112
80006474:	00a7f7b3          	and	a5,a5,a0
80006478:	00f687b3          	add	a5,a3,a5
8000647c:	000016b7          	lui	a3,0x1
80006480:	82068693          	add	a3,a3,-2016 # 820 <__stack_size-0x37e0>
80006484:	00e686b3          	add	a3,a3,a4
80006488:	02010713          	add	a4,sp,32
8000648c:	00e68733          	add	a4,a3,a4
80006490:	7ef72e23          	sw	a5,2044(a4)
80006494:	ad9ff06f          	j	80005f6c <main+0x184>
80006498:	00001737          	lui	a4,0x1
8000649c:	fffff7b7          	lui	a5,0xfffff
800064a0:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
800064a4:	00f70733          	add	a4,a4,a5
800064a8:	02010793          	add	a5,sp,32
800064ac:	00f707b3          	add	a5,a4,a5
800064b0:	07010713          	add	a4,sp,112
800064b4:	00f12623          	sw	a5,12(sp)
800064b8:	7ee7ac23          	sw	a4,2040(a5) # fffff7f8 <__stack_base+0x5ffef7f8>
800064bc:	4e099263          	bnez	s3,800069a0 <main+0xbb8>
800064c0:	d80a1ae3          	bnez	s4,80006254 <main+0x46c>
800064c4:	aa9ff06f          	j	80005f6c <main+0x184>
800064c8:	00010737          	lui	a4,0x10
800064cc:	fff00793          	li	a5,-1
800064d0:	fff70713          	add	a4,a4,-1 # ffff <__stack_size+0xbfff>
800064d4:	00f12e23          	sw	a5,28(sp)
800064d8:	a0001cb7          	lui	s9,0xa0001
800064dc:	00e12623          	sw	a4,12(sp)
800064e0:	581010ef          	jal	80008260 <check_data_types>
800064e4:	00c12703          	lw	a4,12(sp)
800064e8:	04412583          	lw	a1,68(sp)
800064ec:	00e509b3          	add	s3,a0,a4
800064f0:	a0000537          	lui	a0,0xa0000
800064f4:	76c50513          	add	a0,a0,1900 # a000076c <__clz_tab+0x730>
800064f8:	e81fe0ef          	jal	80005378 <printf_>
800064fc:	01412483          	lw	s1,20(sp)
80006500:	a0000537          	lui	a0,0xa0000
80006504:	78450513          	add	a0,a0,1924 # a0000784 <__clz_tab+0x748>
80006508:	00048593          	mv	a1,s1
8000650c:	e6dfe0ef          	jal	80005378 <printf_>
80006510:	01812903          	lw	s2,24(sp)
80006514:	00048513          	mv	a0,s1
80006518:	01099993          	sll	s3,s3,0x10
8000651c:	00090593          	mv	a1,s2
80006520:	5c5010ef          	jal	800082e4 <time_in_secs>
80006524:	00050613          	mv	a2,a0
80006528:	a0000537          	lui	a0,0xa0000
8000652c:	00058693          	mv	a3,a1
80006530:	79c50513          	add	a0,a0,1948 # a000079c <__clz_tab+0x760>
80006534:	e45fe0ef          	jal	80005378 <printf_>
80006538:	00048513          	mv	a0,s1
8000653c:	00090593          	mv	a1,s2
80006540:	5a5010ef          	jal	800082e4 <time_in_secs>
80006544:	00000613          	li	a2,0
80006548:	00000693          	li	a3,0
8000654c:	4109d993          	sra	s3,s3,0x10
80006550:	bc8fb0ef          	jal	80001918 <__gedf2>
80006554:	04a05863          	blez	a0,800065a4 <main+0x7bc>
80006558:	d78ca583          	lw	a1,-648(s9) # a0000d78 <default_num_contexts>
8000655c:	04812503          	lw	a0,72(sp)
80006560:	edcfc0ef          	jal	80002c3c <__mulsi3>
80006564:	ca8fc0ef          	jal	80002a0c <__floatunsidf>
80006568:	00050a93          	mv	s5,a0
8000656c:	00058a13          	mv	s4,a1
80006570:	00048513          	mv	a0,s1
80006574:	00090593          	mv	a1,s2
80006578:	56d010ef          	jal	800082e4 <time_in_secs>
8000657c:	00050613          	mv	a2,a0
80006580:	00058693          	mv	a3,a1
80006584:	000a8513          	mv	a0,s5
80006588:	000a0593          	mv	a1,s4
8000658c:	c25fa0ef          	jal	800011b0 <__divdf3>
80006590:	00050613          	mv	a2,a0
80006594:	a0000537          	lui	a0,0xa0000
80006598:	00058693          	mv	a3,a1
8000659c:	7b450513          	add	a0,a0,1972 # a00007b4 <__clz_tab+0x778>
800065a0:	dd9fe0ef          	jal	80005378 <printf_>
800065a4:	d78ca583          	lw	a1,-648(s9)
800065a8:	04812503          	lw	a0,72(sp)
800065ac:	a0000ab7          	lui	s5,0xa0000
800065b0:	a0001b37          	lui	s6,0xa0001
800065b4:	e88fc0ef          	jal	80002c3c <__mulsi3>
800065b8:	00050593          	mv	a1,a0
800065bc:	a0000537          	lui	a0,0xa0000
800065c0:	7cc50513          	add	a0,a0,1996 # a00007cc <__clz_tab+0x790>
800065c4:	db5fe0ef          	jal	80005378 <printf_>
800065c8:	a0000537          	lui	a0,0xa0000
800065cc:	7e4a8593          	add	a1,s5,2020 # a00007e4 <__clz_tab+0x7a8>
800065d0:	7f050513          	add	a0,a0,2032 # a00007f0 <__clz_tab+0x7b4>
800065d4:	da5fe0ef          	jal	80005378 <printf_>
800065d8:	a0001537          	lui	a0,0xa0001
800065dc:	808b0593          	add	a1,s6,-2040 # a0000808 <__clz_tab+0x7cc>
800065e0:	80c50513          	add	a0,a0,-2036 # a000080c <__clz_tab+0x7d0>
800065e4:	d95fe0ef          	jal	80005378 <printf_>
800065e8:	a0001a37          	lui	s4,0xa0001
800065ec:	a0001537          	lui	a0,0xa0001
800065f0:	824a0593          	add	a1,s4,-2012 # a0000824 <__clz_tab+0x7e8>
800065f4:	82c50513          	add	a0,a0,-2004 # a000082c <__clz_tab+0x7f0>
800065f8:	d81fe0ef          	jal	80005378 <printf_>
800065fc:	a0001537          	lui	a0,0xa0001
80006600:	00040593          	mv	a1,s0
80006604:	84450513          	add	a0,a0,-1980 # a0000844 <__clz_tab+0x808>
80006608:	d71fe0ef          	jal	80005378 <printf_>
8000660c:	04c12783          	lw	a5,76(sp)
80006610:	0017f713          	and	a4,a5,1
80006614:	06070a63          	beqz	a4,80006688 <main+0x8a0>
80006618:	d78ca703          	lw	a4,-648(s9)
8000661c:	06070663          	beqz	a4,80006688 <main+0x8a0>
80006620:	00001737          	lui	a4,0x1
80006624:	fffff7b7          	lui	a5,0xfffff
80006628:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
8000662c:	00f70733          	add	a4,a4,a5
80006630:	02010793          	add	a5,sp,32
80006634:	00f707b3          	add	a5,a4,a5
80006638:	00000c13          	li	s8,0
8000663c:	a0001bb7          	lui	s7,0xa0001
80006640:	00f12623          	sw	a5,12(sp)
80006644:	00001437          	lui	s0,0x1
80006648:	00c12703          	lw	a4,12(sp)
8000664c:	004c1793          	sll	a5,s8,0x4
80006650:	018787b3          	add	a5,a5,s8
80006654:	00279793          	sll	a5,a5,0x2
80006658:	00f707b3          	add	a5,a4,a5
8000665c:	00f407b3          	add	a5,s0,a5
80006660:	8267d603          	lhu	a2,-2010(a5) # ffffe826 <__stack_base+0x5ffee826>
80006664:	000c0593          	mv	a1,s8
80006668:	860b8513          	add	a0,s7,-1952 # a0000860 <__clz_tab+0x824>
8000666c:	d0dfe0ef          	jal	80005378 <printf_>
80006670:	001c0c13          	add	s8,s8,1
80006674:	d78ca783          	lw	a5,-648(s9)
80006678:	010c1c13          	sll	s8,s8,0x10
8000667c:	010c5c13          	srl	s8,s8,0x10
80006680:	fcfc64e3          	bltu	s8,a5,80006648 <main+0x860>
80006684:	04c12783          	lw	a5,76(sp)
80006688:	0027f713          	and	a4,a5,2
8000668c:	06070a63          	beqz	a4,80006700 <main+0x918>
80006690:	d78ca703          	lw	a4,-648(s9)
80006694:	30070063          	beqz	a4,80006994 <main+0xbac>
80006698:	00001737          	lui	a4,0x1
8000669c:	fffff7b7          	lui	a5,0xfffff
800066a0:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
800066a4:	00f70733          	add	a4,a4,a5
800066a8:	02010793          	add	a5,sp,32
800066ac:	00f707b3          	add	a5,a4,a5
800066b0:	00000c13          	li	s8,0
800066b4:	a0001bb7          	lui	s7,0xa0001
800066b8:	00f12623          	sw	a5,12(sp)
800066bc:	00001437          	lui	s0,0x1
800066c0:	00c12703          	lw	a4,12(sp)
800066c4:	004c1793          	sll	a5,s8,0x4
800066c8:	018787b3          	add	a5,a5,s8
800066cc:	00279793          	sll	a5,a5,0x2
800066d0:	00f707b3          	add	a5,a4,a5
800066d4:	00f407b3          	add	a5,s0,a5
800066d8:	8287d603          	lhu	a2,-2008(a5) # ffffe828 <__stack_base+0x5ffee828>
800066dc:	000c0593          	mv	a1,s8
800066e0:	87cb8513          	add	a0,s7,-1924 # a000087c <__clz_tab+0x840>
800066e4:	c95fe0ef          	jal	80005378 <printf_>
800066e8:	001c0c13          	add	s8,s8,1
800066ec:	d78ca783          	lw	a5,-648(s9)
800066f0:	010c1c13          	sll	s8,s8,0x10
800066f4:	010c5c13          	srl	s8,s8,0x10
800066f8:	fcfc64e3          	bltu	s8,a5,800066c0 <main+0x8d8>
800066fc:	04c12783          	lw	a5,76(sp)
80006700:	0047f793          	and	a5,a5,4
80006704:	d78ca703          	lw	a4,-648(s9)
80006708:	06078663          	beqz	a5,80006774 <main+0x98c>
8000670c:	0c070a63          	beqz	a4,800067e0 <main+0x9f8>
80006710:	00001737          	lui	a4,0x1
80006714:	fffff7b7          	lui	a5,0xfffff
80006718:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
8000671c:	00f70733          	add	a4,a4,a5
80006720:	02010793          	add	a5,sp,32
80006724:	00f707b3          	add	a5,a4,a5
80006728:	00000c13          	li	s8,0
8000672c:	a0001bb7          	lui	s7,0xa0001
80006730:	00f12623          	sw	a5,12(sp)
80006734:	00001437          	lui	s0,0x1
80006738:	00c12703          	lw	a4,12(sp)
8000673c:	004c1793          	sll	a5,s8,0x4
80006740:	018787b3          	add	a5,a5,s8
80006744:	00279793          	sll	a5,a5,0x2
80006748:	00f707b3          	add	a5,a4,a5
8000674c:	00f407b3          	add	a5,s0,a5
80006750:	82a7d603          	lhu	a2,-2006(a5) # ffffe82a <__stack_base+0x5ffee82a>
80006754:	000c0593          	mv	a1,s8
80006758:	898b8513          	add	a0,s7,-1896 # a0000898 <__clz_tab+0x85c>
8000675c:	c1dfe0ef          	jal	80005378 <printf_>
80006760:	001c0c13          	add	s8,s8,1
80006764:	d78ca783          	lw	a5,-648(s9)
80006768:	010c1c13          	sll	s8,s8,0x10
8000676c:	010c5c13          	srl	s8,s8,0x10
80006770:	fcfc64e3          	bltu	s8,a5,80006738 <main+0x950>
80006774:	d78ca783          	lw	a5,-648(s9)
80006778:	06078463          	beqz	a5,800067e0 <main+0x9f8>
8000677c:	00001737          	lui	a4,0x1
80006780:	fffff7b7          	lui	a5,0xfffff
80006784:	82070713          	add	a4,a4,-2016 # 820 <__stack_size-0x37e0>
80006788:	00f70733          	add	a4,a4,a5
8000678c:	02010793          	add	a5,sp,32
80006790:	00f707b3          	add	a5,a4,a5
80006794:	00000c13          	li	s8,0
80006798:	a0001bb7          	lui	s7,0xa0001
8000679c:	00f12623          	sw	a5,12(sp)
800067a0:	00001437          	lui	s0,0x1
800067a4:	00c12703          	lw	a4,12(sp)
800067a8:	004c1793          	sll	a5,s8,0x4
800067ac:	018787b3          	add	a5,a5,s8
800067b0:	00279793          	sll	a5,a5,0x2
800067b4:	00f707b3          	add	a5,a4,a5
800067b8:	00f407b3          	add	a5,s0,a5
800067bc:	8247d603          	lhu	a2,-2012(a5) # ffffe824 <__stack_base+0x5ffee824>
800067c0:	000c0593          	mv	a1,s8
800067c4:	8b4b8513          	add	a0,s7,-1868 # a00008b4 <__clz_tab+0x878>
800067c8:	bb1fe0ef          	jal	80005378 <printf_>
800067cc:	001c0c13          	add	s8,s8,1
800067d0:	d78ca783          	lw	a5,-648(s9)
800067d4:	010c1c13          	sll	s8,s8,0x10
800067d8:	010c5c13          	srl	s8,s8,0x10
800067dc:	fcfc64e3          	bltu	s8,a5,800067a4 <main+0x9bc>
800067e0:	06098863          	beqz	s3,80006850 <main+0xa68>
800067e4:	05304e63          	bgtz	s3,80006840 <main+0xa58>
800067e8:	a0001537          	lui	a0,0xa0001
800067ec:	94450513          	add	a0,a0,-1724 # a0000944 <__clz_tab+0x908>
800067f0:	b89fe0ef          	jal	80005378 <printf_>
800067f4:	06e10513          	add	a0,sp,110
800067f8:	321010ef          	jal	80008318 <portable_fini>
800067fc:	09010113          	add	sp,sp,144
80006800:	7ec12083          	lw	ra,2028(sp)
80006804:	7e812403          	lw	s0,2024(sp)
80006808:	7e412483          	lw	s1,2020(sp)
8000680c:	7e012903          	lw	s2,2016(sp)
80006810:	7dc12983          	lw	s3,2012(sp)
80006814:	7d812a03          	lw	s4,2008(sp)
80006818:	7d412a83          	lw	s5,2004(sp)
8000681c:	7d012b03          	lw	s6,2000(sp)
80006820:	7cc12b83          	lw	s7,1996(sp)
80006824:	7c812c03          	lw	s8,1992(sp)
80006828:	7c412c83          	lw	s9,1988(sp)
8000682c:	7c012d03          	lw	s10,1984(sp)
80006830:	7bc12d83          	lw	s11,1980(sp)
80006834:	00000513          	li	a0,0
80006838:	7f010113          	add	sp,sp,2032
8000683c:	00008067          	ret
80006840:	a0001537          	lui	a0,0xa0001
80006844:	9a850513          	add	a0,a0,-1624 # a00009a8 <__clz_tab+0x96c>
80006848:	b31fe0ef          	jal	80005378 <printf_>
8000684c:	fa9ff06f          	j	800067f4 <main+0xa0c>
80006850:	a0001537          	lui	a0,0xa0001
80006854:	8d050513          	add	a0,a0,-1840 # a00008d0 <__clz_tab+0x894>
80006858:	b21fe0ef          	jal	80005378 <printf_>
8000685c:	01c12703          	lw	a4,28(sp)
80006860:	00300793          	li	a5,3
80006864:	f8f718e3          	bne	a4,a5,800067f4 <main+0xa0c>
80006868:	d78ca583          	lw	a1,-648(s9)
8000686c:	04812503          	lw	a0,72(sp)
80006870:	bccfc0ef          	jal	80002c3c <__mulsi3>
80006874:	998fc0ef          	jal	80002a0c <__floatunsidf>
80006878:	00050793          	mv	a5,a0
8000687c:	00058413          	mv	s0,a1
80006880:	01412503          	lw	a0,20(sp)
80006884:	01812583          	lw	a1,24(sp)
80006888:	00078493          	mv	s1,a5
8000688c:	259010ef          	jal	800082e4 <time_in_secs>
80006890:	00050613          	mv	a2,a0
80006894:	00058693          	mv	a3,a1
80006898:	00048513          	mv	a0,s1
8000689c:	00040593          	mv	a1,s0
800068a0:	911fa0ef          	jal	800011b0 <__divdf3>
800068a4:	00050613          	mv	a2,a0
800068a8:	a0001537          	lui	a0,0xa0001
800068ac:	00058693          	mv	a3,a1
800068b0:	808b0793          	add	a5,s6,-2040
800068b4:	7e4a8713          	add	a4,s5,2020
800068b8:	91c50513          	add	a0,a0,-1764 # a000091c <__clz_tab+0x8e0>
800068bc:	abdfe0ef          	jal	80005378 <printf_>
800068c0:	a0001537          	lui	a0,0xa0001
800068c4:	824a0593          	add	a1,s4,-2012
800068c8:	93850513          	add	a0,a0,-1736 # a0000938 <__clz_tab+0x8fc>
800068cc:	aadfe0ef          	jal	80005378 <printf_>
800068d0:	a0001537          	lui	a0,0xa0001
800068d4:	94050513          	add	a0,a0,-1728 # a0000940 <__clz_tab+0x904>
800068d8:	aa1fe0ef          	jal	80005378 <printf_>
800068dc:	f19ff06f          	j	800067f4 <main+0xa0c>
800068e0:	a0000537          	lui	a0,0xa0000
800068e4:	61c50513          	add	a0,a0,1564 # a000061c <__clz_tab+0x5e0>
800068e8:	a91fe0ef          	jal	80005378 <printf_>
800068ec:	00004a37          	lui	s4,0x4
800068f0:	00001ab7          	lui	s5,0x1
800068f4:	000039b7          	lui	s3,0x3
800068f8:	9bfa0a13          	add	s4,s4,-1601 # 39bf <__stack_size-0x641>
800068fc:	199a8a93          	add	s5,s5,409 # 1199 <__stack_size-0x2e67>
80006900:	34098993          	add	s3,s3,832 # 3340 <__stack_size-0xcc0>
80006904:	00100793          	li	a5,1
80006908:	000a0c13          	mv	s8,s4
8000690c:	000a8b93          	mv	s7,s5
80006910:	00098b13          	mv	s6,s3
80006914:	00f12e23          	sw	a5,28(sp)
80006918:	9d5ff06f          	j	800062ec <main+0x504>
8000691c:	a0000537          	lui	a0,0xa0000
80006920:	6ac50513          	add	a0,a0,1708 # a00006ac <__clz_tab+0x670>
80006924:	a55fe0ef          	jal	80005378 <printf_>
80006928:	00009a37          	lui	s4,0x9
8000692c:	0000e9b7          	lui	s3,0xe
80006930:	d84a0a13          	add	s4,s4,-636 # 8d84 <__stack_size+0x4d84>
80006934:	3c198993          	add	s3,s3,961 # e3c1 <__stack_size+0xa3c1>
80006938:	00400793          	li	a5,4
8000693c:	000a0c13          	mv	s8,s4
80006940:	74700a93          	li	s5,1863
80006944:	74700b93          	li	s7,1863
80006948:	00098b13          	mv	s6,s3
8000694c:	00f12e23          	sw	a5,28(sp)
80006950:	99dff06f          	j	800062ec <main+0x504>
80006954:	a0000537          	lui	a0,0xa0000
80006958:	00006a37          	lui	s4,0x6
8000695c:	0000cab7          	lui	s5,0xc
80006960:	0000d9b7          	lui	s3,0xd
80006964:	5ec50513          	add	a0,a0,1516 # a00005ec <__clz_tab+0x5b0>
80006968:	e47a0a13          	add	s4,s4,-441 # 5e47 <__stack_size+0x1e47>
8000696c:	e52a8a93          	add	s5,s5,-430 # be52 <__stack_size+0x7e52>
80006970:	4b098993          	add	s3,s3,1200 # d4b0 <__stack_size+0x94b0>
80006974:	a05fe0ef          	jal	80005378 <printf_>
80006978:	000a0c13          	mv	s8,s4
8000697c:	000a8b93          	mv	s7,s5
80006980:	00098b13          	mv	s6,s3
80006984:	00012e23          	sw	zero,28(sp)
80006988:	965ff06f          	j	800062ec <main+0x504>
8000698c:	00000713          	li	a4,0
80006990:	b4dff06f          	j	800064dc <main+0x6f4>
80006994:	0047f793          	and	a5,a5,4
80006998:	dc078ee3          	beqz	a5,80006774 <main+0x98c>
8000699c:	e45ff06f          	j	800067e0 <main+0x9f8>
800069a0:	412007b3          	neg	a5,s2
800069a4:	07010693          	add	a3,sp,112
800069a8:	00b7f7b3          	and	a5,a5,a1
800069ac:	00f687b3          	add	a5,a3,a5
800069b0:	000016b7          	lui	a3,0x1
800069b4:	fffff737          	lui	a4,0xfffff
800069b8:	82068693          	add	a3,a3,-2016 # 820 <__stack_size-0x37e0>
800069bc:	00e686b3          	add	a3,a3,a4
800069c0:	02010713          	add	a4,sp,32
800069c4:	00e68733          	add	a4,a3,a4
800069c8:	00e12623          	sw	a4,12(sp)
800069cc:	7ef72e23          	sw	a5,2044(a4) # fffff7fc <__stack_base+0x5ffef7fc>
800069d0:	880a12e3          	bnez	s4,80006254 <main+0x46c>
800069d4:	d98ff06f          	j	80005f6c <main+0x184>

800069d8 <matrix_test>:
800069d8:	fa010113          	add	sp,sp,-96
800069dc:	04112e23          	sw	ra,92(sp)
800069e0:	00b12423          	sw	a1,8(sp)
800069e4:	00c12a23          	sw	a2,20(sp)
800069e8:	00d12623          	sw	a3,12(sp)
800069ec:	52050263          	beqz	a0,80006f10 <matrix_test+0x538>
800069f0:	04912a23          	sw	s1,84(sp)
800069f4:	03812c23          	sw	s8,56(sp)
800069f8:	00151493          	sll	s1,a0,0x1
800069fc:	40a00c33          	neg	s8,a0
80006a00:	05312623          	sw	s3,76(sp)
80006a04:	05612023          	sw	s6,64(sp)
80006a08:	009609b3          	add	s3,a2,s1
80006a0c:	01071b13          	sll	s6,a4,0x10
80006a10:	002c1793          	sll	a5,s8,0x2
80006a14:	05212823          	sw	s2,80(sp)
80006a18:	05412423          	sw	s4,72(sp)
80006a1c:	04812c23          	sw	s0,88(sp)
80006a20:	05512223          	sw	s5,68(sp)
80006a24:	03712e23          	sw	s7,60(sp)
80006a28:	03912a23          	sw	s9,52(sp)
80006a2c:	03a12823          	sw	s10,48(sp)
80006a30:	03b12623          	sw	s11,44(sp)
80006a34:	00050813          	mv	a6,a0
80006a38:	00070913          	mv	s2,a4
80006a3c:	010b5b13          	srl	s6,s6,0x10
80006a40:	00098693          	mv	a3,s3
80006a44:	00000a13          	li	s4,0
80006a48:	00f12223          	sw	a5,4(sp)
80006a4c:	40968633          	sub	a2,a3,s1
80006a50:	00060793          	mv	a5,a2
80006a54:	0007d703          	lhu	a4,0(a5)
80006a58:	00278793          	add	a5,a5,2
80006a5c:	00eb0733          	add	a4,s6,a4
80006a60:	fee79f23          	sh	a4,-2(a5)
80006a64:	fed798e3          	bne	a5,a3,80006a54 <matrix_test+0x7c>
80006a68:	00412783          	lw	a5,4(sp)
80006a6c:	001a0413          	add	s0,s4,1
80006a70:	40f606b3          	sub	a3,a2,a5
80006a74:	00880663          	beq	a6,s0,80006a80 <matrix_test+0xa8>
80006a78:	00040a13          	mv	s4,s0
80006a7c:	fd1ff06f          	j	80006a4c <matrix_test+0x74>
80006a80:	00000a93          	li	s5,0
80006a84:	00000d93          	li	s11,0
80006a88:	00812783          	lw	a5,8(sp)
80006a8c:	40998bb3          	sub	s7,s3,s1
80006a90:	002a9713          	sll	a4,s5,0x2
80006a94:	00f70cb3          	add	s9,a4,a5
80006a98:	000b8c13          	mv	s8,s7
80006a9c:	000c1503          	lh	a0,0(s8)
80006aa0:	00090593          	mv	a1,s2
80006aa4:	002c0c13          	add	s8,s8,2
80006aa8:	994fc0ef          	jal	80002c3c <__mulsi3>
80006aac:	00aca023          	sw	a0,0(s9)
80006ab0:	004c8c93          	add	s9,s9,4
80006ab4:	ff8994e3          	bne	s3,s8,80006a9c <matrix_test+0xc4>
80006ab8:	00412703          	lw	a4,4(sp)
80006abc:	001d8793          	add	a5,s11,1
80006ac0:	008a8ab3          	add	s5,s5,s0
80006ac4:	40eb89b3          	sub	s3,s7,a4
80006ac8:	014d8663          	beq	s11,s4,80006ad4 <matrix_test+0xfc>
80006acc:	00078d93          	mv	s11,a5
80006ad0:	fb9ff06f          	j	80006a88 <matrix_test+0xb0>
80006ad4:	00812783          	lw	a5,8(sp)
80006ad8:	40800e33          	neg	t3,s0
80006adc:	00000513          	li	a0,0
80006ae0:	40e78ab3          	sub	s5,a5,a4
80006ae4:	fffff7b7          	lui	a5,0xfffff
80006ae8:	00f96933          	or	s2,s2,a5
80006aec:	000a8813          	mv	a6,s5
80006af0:	00000713          	li	a4,0
80006af4:	00000613          	li	a2,0
80006af8:	00000313          	li	t1,0
80006afc:	003e1e13          	sll	t3,t3,0x3
80006b00:	00412783          	lw	a5,4(sp)
80006b04:	00f808b3          	add	a7,a6,a5
80006b08:	00088793          	mv	a5,a7
80006b0c:	0140006f          	j	80006b20 <matrix_test+0x148>
80006b10:	01051513          	sll	a0,a0,0x10
80006b14:	00478793          	add	a5,a5,4 # fffff004 <__stack_base+0x5ffef004>
80006b18:	41055513          	sra	a0,a0,0x10
80006b1c:	02f80e63          	beq	a6,a5,80006b58 <matrix_test+0x180>
80006b20:	00070693          	mv	a3,a4
80006b24:	0007a703          	lw	a4,0(a5)
80006b28:	01051513          	sll	a0,a0,0x10
80006b2c:	01055513          	srl	a0,a0,0x10
80006b30:	00e6a6b3          	slt	a3,a3,a4
80006b34:	00e60633          	add	a2,a2,a4
80006b38:	00a50593          	add	a1,a0,10
80006b3c:	00d50533          	add	a0,a0,a3
80006b40:	fcc958e3          	bge	s2,a2,80006b10 <matrix_test+0x138>
80006b44:	01059513          	sll	a0,a1,0x10
80006b48:	00478793          	add	a5,a5,4
80006b4c:	41055513          	sra	a0,a0,0x10
80006b50:	00000613          	li	a2,0
80006b54:	fcf816e3          	bne	a6,a5,80006b20 <matrix_test+0x148>
80006b58:	00130793          	add	a5,t1,1
80006b5c:	41c88833          	sub	a6,a7,t3
80006b60:	006a0663          	beq	s4,t1,80006b6c <matrix_test+0x194>
80006b64:	00078313          	mv	t1,a5
80006b68:	f99ff06f          	j	80006b00 <matrix_test+0x128>
80006b6c:	00000593          	li	a1,0
80006b70:	49c010ef          	jal	8000800c <crc16>
80006b74:	00c12783          	lw	a5,12(sp)
80006b78:	00812a03          	lw	s4,8(sp)
80006b7c:	00050d93          	mv	s11,a0
80006b80:	009789b3          	add	s3,a5,s1
80006b84:	00000b93          	li	s7,0
80006b88:	01412783          	lw	a5,20(sp)
80006b8c:	00c12c83          	lw	s9,12(sp)
80006b90:	001b9713          	sll	a4,s7,0x1
80006b94:	00e78d33          	add	s10,a5,a4
80006b98:	00000c13          	li	s8,0
80006b9c:	000c9583          	lh	a1,0(s9)
80006ba0:	000d1503          	lh	a0,0(s10) # 1000 <__stack_size-0x3000>
80006ba4:	002c8c93          	add	s9,s9,2
80006ba8:	002d0d13          	add	s10,s10,2
80006bac:	890fc0ef          	jal	80002c3c <__mulsi3>
80006bb0:	00ac0c33          	add	s8,s8,a0
80006bb4:	ff3c94e3          	bne	s9,s3,80006b9c <matrix_test+0x1c4>
80006bb8:	018a2023          	sw	s8,0(s4)
80006bbc:	004a0a13          	add	s4,s4,4
80006bc0:	008b8bb3          	add	s7,s7,s0
80006bc4:	fd5a12e3          	bne	s4,s5,80006b88 <matrix_test+0x1b0>
80006bc8:	00000893          	li	a7,0
80006bcc:	00000513          	li	a0,0
80006bd0:	00000793          	li	a5,0
80006bd4:	00000693          	li	a3,0
80006bd8:	00000313          	li	t1,0
80006bdc:	00812703          	lw	a4,8(sp)
80006be0:	00289613          	sll	a2,a7,0x2
80006be4:	00000593          	li	a1,0
80006be8:	00c70633          	add	a2,a4,a2
80006bec:	0180006f          	j	80006c04 <matrix_test+0x22c>
80006bf0:	01051513          	sll	a0,a0,0x10
80006bf4:	00158593          	add	a1,a1,1
80006bf8:	41055513          	sra	a0,a0,0x10
80006bfc:	00460613          	add	a2,a2,4
80006c00:	0485f063          	bgeu	a1,s0,80006c40 <matrix_test+0x268>
80006c04:	00078713          	mv	a4,a5
80006c08:	00062783          	lw	a5,0(a2)
80006c0c:	01051513          	sll	a0,a0,0x10
80006c10:	01055513          	srl	a0,a0,0x10
80006c14:	00f72733          	slt	a4,a4,a5
80006c18:	00f686b3          	add	a3,a3,a5
80006c1c:	00a50813          	add	a6,a0,10
80006c20:	00e50533          	add	a0,a0,a4
80006c24:	fcd956e3          	bge	s2,a3,80006bf0 <matrix_test+0x218>
80006c28:	01081513          	sll	a0,a6,0x10
80006c2c:	00158593          	add	a1,a1,1
80006c30:	41055513          	sra	a0,a0,0x10
80006c34:	00000693          	li	a3,0
80006c38:	00460613          	add	a2,a2,4
80006c3c:	fc85e4e3          	bltu	a1,s0,80006c04 <matrix_test+0x22c>
80006c40:	00130313          	add	t1,t1,1
80006c44:	008888b3          	add	a7,a7,s0
80006c48:	f8836ae3          	bltu	t1,s0,80006bdc <matrix_test+0x204>
80006c4c:	000d8593          	mv	a1,s11
80006c50:	3bc010ef          	jal	8000800c <crc16>
80006c54:	00812783          	lw	a5,8(sp)
80006c58:	01412b83          	lw	s7,20(sp)
80006c5c:	00a12e23          	sw	a0,28(sp)
80006c60:	00f12823          	sw	a5,16(sp)
80006c64:	00012c23          	sw	zero,24(sp)
80006c68:	00c12983          	lw	s3,12(sp)
80006c6c:	01012a83          	lw	s5,16(sp)
80006c70:	00000a13          	li	s4,0
80006c74:	00098d93          	mv	s11,s3
80006c78:	000b8d13          	mv	s10,s7
80006c7c:	00000c13          	li	s8,0
80006c80:	00000c93          	li	s9,0
80006c84:	000d9583          	lh	a1,0(s11)
80006c88:	000d1503          	lh	a0,0(s10)
80006c8c:	001c8c93          	add	s9,s9,1
80006c90:	002d0d13          	add	s10,s10,2
80006c94:	fa9fb0ef          	jal	80002c3c <__mulsi3>
80006c98:	00ac0c33          	add	s8,s8,a0
80006c9c:	009d8db3          	add	s11,s11,s1
80006ca0:	fe8ce2e3          	bltu	s9,s0,80006c84 <matrix_test+0x2ac>
80006ca4:	018aa023          	sw	s8,0(s5)
80006ca8:	001a0a13          	add	s4,s4,1
80006cac:	004a8a93          	add	s5,s5,4
80006cb0:	00298993          	add	s3,s3,2
80006cb4:	fc8a60e3          	bltu	s4,s0,80006c74 <matrix_test+0x29c>
80006cb8:	01812783          	lw	a5,24(sp)
80006cbc:	01012703          	lw	a4,16(sp)
80006cc0:	00412683          	lw	a3,4(sp)
80006cc4:	00178793          	add	a5,a5,1
80006cc8:	00f12c23          	sw	a5,24(sp)
80006ccc:	40d70733          	sub	a4,a4,a3
80006cd0:	00e12823          	sw	a4,16(sp)
80006cd4:	009b8bb3          	add	s7,s7,s1
80006cd8:	f887e8e3          	bltu	a5,s0,80006c68 <matrix_test+0x290>
80006cdc:	00000893          	li	a7,0
80006ce0:	00000513          	li	a0,0
80006ce4:	00000793          	li	a5,0
80006ce8:	00000693          	li	a3,0
80006cec:	00000313          	li	t1,0
80006cf0:	00812703          	lw	a4,8(sp)
80006cf4:	00289613          	sll	a2,a7,0x2
80006cf8:	00000593          	li	a1,0
80006cfc:	00c70633          	add	a2,a4,a2
80006d00:	0180006f          	j	80006d18 <matrix_test+0x340>
80006d04:	01051513          	sll	a0,a0,0x10
80006d08:	00158593          	add	a1,a1,1
80006d0c:	41055513          	sra	a0,a0,0x10
80006d10:	00460613          	add	a2,a2,4
80006d14:	0485f063          	bgeu	a1,s0,80006d54 <matrix_test+0x37c>
80006d18:	00078713          	mv	a4,a5
80006d1c:	00062783          	lw	a5,0(a2)
80006d20:	01051513          	sll	a0,a0,0x10
80006d24:	01055513          	srl	a0,a0,0x10
80006d28:	00f72733          	slt	a4,a4,a5
80006d2c:	00f686b3          	add	a3,a3,a5
80006d30:	00a50813          	add	a6,a0,10
80006d34:	00e50533          	add	a0,a0,a4
80006d38:	fcd956e3          	bge	s2,a3,80006d04 <matrix_test+0x32c>
80006d3c:	01081513          	sll	a0,a6,0x10
80006d40:	00158593          	add	a1,a1,1
80006d44:	41055513          	sra	a0,a0,0x10
80006d48:	00000693          	li	a3,0
80006d4c:	00460613          	add	a2,a2,4
80006d50:	fc85e4e3          	bltu	a1,s0,80006d18 <matrix_test+0x340>
80006d54:	00130313          	add	t1,t1,1
80006d58:	008888b3          	add	a7,a7,s0
80006d5c:	f8836ae3          	bltu	t1,s0,80006cf0 <matrix_test+0x318>
80006d60:	01c12583          	lw	a1,28(sp)
80006d64:	2a8010ef          	jal	8000800c <crc16>
80006d68:	00812783          	lw	a5,8(sp)
80006d6c:	01412b83          	lw	s7,20(sp)
80006d70:	00a12e23          	sw	a0,28(sp)
80006d74:	00f12823          	sw	a5,16(sp)
80006d78:	00012c23          	sw	zero,24(sp)
80006d7c:	00c12983          	lw	s3,12(sp)
80006d80:	01012a83          	lw	s5,16(sp)
80006d84:	00000a13          	li	s4,0
80006d88:	00098c13          	mv	s8,s3
80006d8c:	000b8c93          	mv	s9,s7
80006d90:	00000d93          	li	s11,0
80006d94:	00000d13          	li	s10,0
80006d98:	000c1583          	lh	a1,0(s8)
80006d9c:	000c9503          	lh	a0,0(s9)
80006da0:	001d0d13          	add	s10,s10,1
80006da4:	002c8c93          	add	s9,s9,2
80006da8:	e95fb0ef          	jal	80002c3c <__mulsi3>
80006dac:	40255813          	sra	a6,a0,0x2
80006db0:	40555593          	sra	a1,a0,0x5
80006db4:	07f5f593          	and	a1,a1,127
80006db8:	00f87513          	and	a0,a6,15
80006dbc:	e81fb0ef          	jal	80002c3c <__mulsi3>
80006dc0:	00ad8db3          	add	s11,s11,a0
80006dc4:	009c0c33          	add	s8,s8,s1
80006dc8:	fc8d68e3          	bltu	s10,s0,80006d98 <matrix_test+0x3c0>
80006dcc:	01baa023          	sw	s11,0(s5)
80006dd0:	001a0a13          	add	s4,s4,1
80006dd4:	004a8a93          	add	s5,s5,4
80006dd8:	00298993          	add	s3,s3,2
80006ddc:	fa8a66e3          	bltu	s4,s0,80006d88 <matrix_test+0x3b0>
80006de0:	01812783          	lw	a5,24(sp)
80006de4:	01012703          	lw	a4,16(sp)
80006de8:	00412683          	lw	a3,4(sp)
80006dec:	00178793          	add	a5,a5,1
80006df0:	00f12c23          	sw	a5,24(sp)
80006df4:	40d70733          	sub	a4,a4,a3
80006df8:	00e12823          	sw	a4,16(sp)
80006dfc:	009b8bb3          	add	s7,s7,s1
80006e00:	f687eee3          	bltu	a5,s0,80006d7c <matrix_test+0x3a4>
80006e04:	00000893          	li	a7,0
80006e08:	00000513          	li	a0,0
80006e0c:	00000793          	li	a5,0
80006e10:	00000693          	li	a3,0
80006e14:	00000313          	li	t1,0
80006e18:	00812703          	lw	a4,8(sp)
80006e1c:	00289613          	sll	a2,a7,0x2
80006e20:	00000593          	li	a1,0
80006e24:	00c70633          	add	a2,a4,a2
80006e28:	0180006f          	j	80006e40 <matrix_test+0x468>
80006e2c:	01051513          	sll	a0,a0,0x10
80006e30:	00158593          	add	a1,a1,1
80006e34:	41055513          	sra	a0,a0,0x10
80006e38:	00460613          	add	a2,a2,4
80006e3c:	0485f063          	bgeu	a1,s0,80006e7c <matrix_test+0x4a4>
80006e40:	00078713          	mv	a4,a5
80006e44:	00062783          	lw	a5,0(a2)
80006e48:	01051513          	sll	a0,a0,0x10
80006e4c:	01055513          	srl	a0,a0,0x10
80006e50:	00f72733          	slt	a4,a4,a5
80006e54:	00f686b3          	add	a3,a3,a5
80006e58:	00a50813          	add	a6,a0,10
80006e5c:	00e50533          	add	a0,a0,a4
80006e60:	fcd956e3          	bge	s2,a3,80006e2c <matrix_test+0x454>
80006e64:	01081513          	sll	a0,a6,0x10
80006e68:	00158593          	add	a1,a1,1
80006e6c:	41055513          	sra	a0,a0,0x10
80006e70:	00000693          	li	a3,0
80006e74:	00460613          	add	a2,a2,4
80006e78:	fc85e4e3          	bltu	a1,s0,80006e40 <matrix_test+0x468>
80006e7c:	00130313          	add	t1,t1,1
80006e80:	008888b3          	add	a7,a7,s0
80006e84:	f8836ae3          	bltu	t1,s0,80006e18 <matrix_test+0x440>
80006e88:	01c12583          	lw	a1,28(sp)
80006e8c:	180010ef          	jal	8000800c <crc16>
80006e90:	00000613          	li	a2,0
80006e94:	00000593          	li	a1,0
80006e98:	01412703          	lw	a4,20(sp)
80006e9c:	00161793          	sll	a5,a2,0x1
80006ea0:	00000693          	li	a3,0
80006ea4:	00f707b3          	add	a5,a4,a5
80006ea8:	0007d703          	lhu	a4,0(a5)
80006eac:	00278793          	add	a5,a5,2
80006eb0:	00168693          	add	a3,a3,1
80006eb4:	41670733          	sub	a4,a4,s6
80006eb8:	fee79f23          	sh	a4,-2(a5)
80006ebc:	fe86e6e3          	bltu	a3,s0,80006ea8 <matrix_test+0x4d0>
80006ec0:	00158593          	add	a1,a1,1
80006ec4:	00860633          	add	a2,a2,s0
80006ec8:	fc85e8e3          	bltu	a1,s0,80006e98 <matrix_test+0x4c0>
80006ecc:	05812403          	lw	s0,88(sp)
80006ed0:	05c12083          	lw	ra,92(sp)
80006ed4:	01051513          	sll	a0,a0,0x10
80006ed8:	05412483          	lw	s1,84(sp)
80006edc:	05012903          	lw	s2,80(sp)
80006ee0:	04c12983          	lw	s3,76(sp)
80006ee4:	04812a03          	lw	s4,72(sp)
80006ee8:	04412a83          	lw	s5,68(sp)
80006eec:	04012b03          	lw	s6,64(sp)
80006ef0:	03c12b83          	lw	s7,60(sp)
80006ef4:	03812c03          	lw	s8,56(sp)
80006ef8:	03412c83          	lw	s9,52(sp)
80006efc:	03012d03          	lw	s10,48(sp)
80006f00:	02c12d83          	lw	s11,44(sp)
80006f04:	41055513          	sra	a0,a0,0x10
80006f08:	06010113          	add	sp,sp,96
80006f0c:	00008067          	ret
80006f10:	00000593          	li	a1,0
80006f14:	0f8010ef          	jal	8000800c <crc16>
80006f18:	00050593          	mv	a1,a0
80006f1c:	00000513          	li	a0,0
80006f20:	0ec010ef          	jal	8000800c <crc16>
80006f24:	00050593          	mv	a1,a0
80006f28:	00000513          	li	a0,0
80006f2c:	0e0010ef          	jal	8000800c <crc16>
80006f30:	00050593          	mv	a1,a0
80006f34:	00000513          	li	a0,0
80006f38:	0d4010ef          	jal	8000800c <crc16>
80006f3c:	05c12083          	lw	ra,92(sp)
80006f40:	01051513          	sll	a0,a0,0x10
80006f44:	41055513          	sra	a0,a0,0x10
80006f48:	06010113          	add	sp,sp,96
80006f4c:	00008067          	ret

80006f50 <core_bench_matrix>:
80006f50:	ff010113          	add	sp,sp,-16
80006f54:	00812423          	sw	s0,8(sp)
80006f58:	00852683          	lw	a3,8(a0)
80006f5c:	00060413          	mv	s0,a2
80006f60:	00058713          	mv	a4,a1
80006f64:	00452603          	lw	a2,4(a0)
80006f68:	00c52583          	lw	a1,12(a0)
80006f6c:	00052503          	lw	a0,0(a0)
80006f70:	00112623          	sw	ra,12(sp)
80006f74:	a65ff0ef          	jal	800069d8 <matrix_test>
80006f78:	00040593          	mv	a1,s0
80006f7c:	00812403          	lw	s0,8(sp)
80006f80:	00c12083          	lw	ra,12(sp)
80006f84:	01010113          	add	sp,sp,16
80006f88:	0840106f          	j	8000800c <crc16>

80006f8c <core_init_matrix>:
80006f8c:	fb010113          	add	sp,sp,-80
80006f90:	04912223          	sw	s1,68(sp)
80006f94:	03712623          	sw	s7,44(sp)
80006f98:	03a12023          	sw	s10,32(sp)
80006f9c:	01b12e23          	sw	s11,28(sp)
80006fa0:	04112623          	sw	ra,76(sp)
80006fa4:	04812423          	sw	s0,72(sp)
80006fa8:	03312e23          	sw	s3,60(sp)
80006fac:	00050493          	mv	s1,a0
80006fb0:	00058b93          	mv	s7,a1
80006fb4:	00068d13          	mv	s10,a3
80006fb8:	00060d93          	mv	s11,a2
80006fbc:	00061463          	bnez	a2,80006fc4 <core_init_matrix+0x38>
80006fc0:	00100d93          	li	s11,1
80006fc4:	00000413          	li	s0,0
80006fc8:	16048e63          	beqz	s1,80007144 <core_init_matrix+0x1b8>
80006fcc:	00040993          	mv	s3,s0
80006fd0:	00140413          	add	s0,s0,1 # 1001 <__stack_size-0x2fff>
80006fd4:	00040593          	mv	a1,s0
80006fd8:	00040513          	mv	a0,s0
80006fdc:	c61fb0ef          	jal	80002c3c <__mulsi3>
80006fe0:	00351513          	sll	a0,a0,0x3
80006fe4:	fe9564e3          	bltu	a0,s1,80006fcc <core_init_matrix+0x40>
80006fe8:	00098593          	mv	a1,s3
80006fec:	00098513          	mv	a0,s3
80006ff0:	c4dfb0ef          	jal	80002c3c <__mulsi3>
80006ff4:	fffb8793          	add	a5,s7,-1
80006ff8:	ffc7f793          	and	a5,a5,-4
80006ffc:	00478793          	add	a5,a5,4
80007000:	00151713          	sll	a4,a0,0x1
80007004:	00f12423          	sw	a5,8(sp)
80007008:	00078493          	mv	s1,a5
8000700c:	00e787b3          	add	a5,a5,a4
80007010:	00e12223          	sw	a4,4(sp)
80007014:	01312623          	sw	s3,12(sp)
80007018:	00f12023          	sw	a5,0(sp)
8000701c:	12098063          	beqz	s3,8000713c <core_init_matrix+0x1b0>
80007020:	05212023          	sw	s2,64(sp)
80007024:	03412c23          	sw	s4,56(sp)
80007028:	03512a23          	sw	s5,52(sp)
8000702c:	03612823          	sw	s6,48(sp)
80007030:	03812423          	sw	s8,40(sp)
80007034:	03912223          	sw	s9,36(sp)
80007038:	00012783          	lw	a5,0(sp)
8000703c:	00010937          	lui	s2,0x10
80007040:	00198413          	add	s0,s3,1
80007044:	00199c93          	sll	s9,s3,0x1
80007048:	00078a13          	mv	s4,a5
8000704c:	00000a93          	li	s5,0
80007050:	00100c13          	li	s8,1
80007054:	40f484b3          	sub	s1,s1,a5
80007058:	fff90913          	add	s2,s2,-1 # ffff <__stack_size+0xbfff>
8000705c:	000c0b13          	mv	s6,s8
80007060:	000a0b93          	mv	s7,s4
80007064:	000c0593          	mv	a1,s8
80007068:	000d8513          	mv	a0,s11
8000706c:	bd1fb0ef          	jal	80002c3c <__mulsi3>
80007070:	41f55713          	sra	a4,a0,0x1f
80007074:	01075713          	srl	a4,a4,0x10
80007078:	00e50633          	add	a2,a0,a4
8000707c:	010c1793          	sll	a5,s8,0x10
80007080:	01267633          	and	a2,a2,s2
80007084:	0107d793          	srl	a5,a5,0x10
80007088:	40e60db3          	sub	s11,a2,a4
8000708c:	01b78733          	add	a4,a5,s11
80007090:	01071713          	sll	a4,a4,0x10
80007094:	01075713          	srl	a4,a4,0x10
80007098:	00f707b3          	add	a5,a4,a5
8000709c:	00eb9023          	sh	a4,0(s7)
800070a0:	0ff7f793          	zext.b	a5,a5
800070a4:	01748733          	add	a4,s1,s7
800070a8:	00f71023          	sh	a5,0(a4)
800070ac:	001c0c13          	add	s8,s8,1
800070b0:	002b8b93          	add	s7,s7,2
800070b4:	fa8c18e3          	bne	s8,s0,80007064 <core_init_matrix+0xd8>
800070b8:	001a8a93          	add	s5,s5,1
800070bc:	01698c33          	add	s8,s3,s6
800070c0:	01340433          	add	s0,s0,s3
800070c4:	019a0a33          	add	s4,s4,s9
800070c8:	f93a9ae3          	bne	s5,s3,8000705c <core_init_matrix+0xd0>
800070cc:	04012903          	lw	s2,64(sp)
800070d0:	03812a03          	lw	s4,56(sp)
800070d4:	03412a83          	lw	s5,52(sp)
800070d8:	03012b03          	lw	s6,48(sp)
800070dc:	02812c03          	lw	s8,40(sp)
800070e0:	02412c83          	lw	s9,36(sp)
800070e4:	00012703          	lw	a4,0(sp)
800070e8:	00412783          	lw	a5,4(sp)
800070ec:	00812683          	lw	a3,8(sp)
800070f0:	04c12083          	lw	ra,76(sp)
800070f4:	00f707b3          	add	a5,a4,a5
800070f8:	fff78793          	add	a5,a5,-1
800070fc:	ffc7f793          	and	a5,a5,-4
80007100:	00478793          	add	a5,a5,4
80007104:	00fd2623          	sw	a5,12(s10)
80007108:	00c12783          	lw	a5,12(sp)
8000710c:	04812403          	lw	s0,72(sp)
80007110:	00dd2223          	sw	a3,4(s10)
80007114:	00ed2423          	sw	a4,8(s10)
80007118:	00fd2023          	sw	a5,0(s10)
8000711c:	04412483          	lw	s1,68(sp)
80007120:	02c12b83          	lw	s7,44(sp)
80007124:	02012d03          	lw	s10,32(sp)
80007128:	01c12d83          	lw	s11,28(sp)
8000712c:	00098513          	mv	a0,s3
80007130:	03c12983          	lw	s3,60(sp)
80007134:	05010113          	add	sp,sp,80
80007138:	00008067          	ret
8000713c:	00012223          	sw	zero,4(sp)
80007140:	fa5ff06f          	j	800070e4 <core_init_matrix+0x158>
80007144:	fffb8b93          	add	s7,s7,-1
80007148:	ffcbfb93          	and	s7,s7,-4
8000714c:	006b8793          	add	a5,s7,6
80007150:	00f12023          	sw	a5,0(sp)
80007154:	fff00793          	li	a5,-1
80007158:	004b8493          	add	s1,s7,4
8000715c:	00f12623          	sw	a5,12(sp)
80007160:	00200793          	li	a5,2
80007164:	05212023          	sw	s2,64(sp)
80007168:	03412c23          	sw	s4,56(sp)
8000716c:	03512a23          	sw	s5,52(sp)
80007170:	03612823          	sw	s6,48(sp)
80007174:	03812423          	sw	s8,40(sp)
80007178:	03912223          	sw	s9,36(sp)
8000717c:	00912423          	sw	s1,8(sp)
80007180:	00f12223          	sw	a5,4(sp)
80007184:	fff00993          	li	s3,-1
80007188:	eb1ff06f          	j	80007038 <core_init_matrix+0xac>

8000718c <core_init_state>:
8000718c:	fff50313          	add	t1,a0,-1
80007190:	00100793          	li	a5,1
80007194:	00060893          	mv	a7,a2
80007198:	1e67fc63          	bgeu	a5,t1,80007390 <core_init_state+0x204>
8000719c:	00158593          	add	a1,a1,1
800071a0:	01059713          	sll	a4,a1,0x10
800071a4:	ff010113          	add	sp,sp,-16
800071a8:	01075713          	srl	a4,a4,0x10
800071ac:	a0001fb7          	lui	t6,0xa0001
800071b0:	a0001f37          	lui	t5,0xa0001
800071b4:	a0001eb7          	lui	t4,0xa0001
800071b8:	a0001e37          	lui	t3,0xa0001
800071bc:	00375793          	srl	a5,a4,0x3
800071c0:	00812623          	sw	s0,12(sp)
800071c4:	00912423          	sw	s1,8(sp)
800071c8:	01212223          	sw	s2,4(sp)
800071cc:	01312023          	sw	s3,0(sp)
800071d0:	00700613          	li	a2,7
800071d4:	00777693          	and	a3,a4,7
800071d8:	00000813          	li	a6,0
800071dc:	c88f8f93          	add	t6,t6,-888 # a0000c88 <errpat>
800071e0:	00400593          	li	a1,4
800071e4:	c98f0f13          	add	t5,t5,-872 # a0000c98 <scipat>
800071e8:	00100293          	li	t0,1
800071ec:	ca8e8e93          	add	t4,t4,-856 # a0000ca8 <floatpat>
800071f0:	cb8e0e13          	add	t3,t3,-840 # a0000cb8 <intpat>
800071f4:	02c00393          	li	t2,44
800071f8:	0037f793          	and	a5,a5,3
800071fc:	08c68463          	beq	a3,a2,80007284 <core_init_state+0xf8>
80007200:	14d5e663          	bltu	a1,a3,8000734c <core_init_state+0x1c0>
80007204:	ffd68693          	add	a3,a3,-3
80007208:	01069693          	sll	a3,a3,0x10
8000720c:	0106d693          	srl	a3,a3,0x10
80007210:	00279793          	sll	a5,a5,0x2
80007214:	0cd2e063          	bltu	t0,a3,800072d4 <core_init_state+0x148>
80007218:	00fe87b3          	add	a5,t4,a5
8000721c:	0007a683          	lw	a3,0(a5)
80007220:	00170713          	add	a4,a4,1
80007224:	01071713          	sll	a4,a4,0x10
80007228:	00980493          	add	s1,a6,9
8000722c:	01075713          	srl	a4,a4,0x10
80007230:	0664fa63          	bgeu	s1,t1,800072a4 <core_init_state+0x118>
80007234:	01088433          	add	s0,a7,a6
80007238:	00168793          	add	a5,a3,1
8000723c:	40f407b3          	sub	a5,s0,a5
80007240:	0037b793          	sltiu	a5,a5,3
80007244:	12079063          	bnez	a5,80007364 <core_init_state+0x1d8>
80007248:	0086e7b3          	or	a5,a3,s0
8000724c:	0037f793          	and	a5,a5,3
80007250:	10079a63          	bnez	a5,80007364 <core_init_state+0x1d8>
80007254:	0006a803          	lw	a6,0(a3)
80007258:	00800793          	li	a5,8
8000725c:	01042023          	sw	a6,0(s0)
80007260:	0046a683          	lw	a3,4(a3)
80007264:	00d42223          	sw	a3,4(s0)
80007268:	00f407b3          	add	a5,s0,a5
8000726c:	00778023          	sb	t2,0(a5)
80007270:	00777693          	and	a3,a4,7
80007274:	00375793          	srl	a5,a4,0x3
80007278:	00048813          	mv	a6,s1
8000727c:	0037f793          	and	a5,a5,3
80007280:	f8c690e3          	bne	a3,a2,80007200 <core_init_state+0x74>
80007284:	00279793          	sll	a5,a5,0x2
80007288:	00170713          	add	a4,a4,1
8000728c:	00ff87b3          	add	a5,t6,a5
80007290:	01071713          	sll	a4,a4,0x10
80007294:	00980493          	add	s1,a6,9
80007298:	0007a683          	lw	a3,0(a5)
8000729c:	01075713          	srl	a4,a4,0x10
800072a0:	f864eae3          	bltu	s1,t1,80007234 <core_init_state+0xa8>
800072a4:	0ca87a63          	bgeu	a6,a0,80007378 <core_init_state+0x1ec>
800072a8:	00180793          	add	a5,a6,1
800072ac:	00100613          	li	a2,1
800072b0:	0af57663          	bgeu	a0,a5,8000735c <core_init_state+0x1d0>
800072b4:	00c12403          	lw	s0,12(sp)
800072b8:	00812483          	lw	s1,8(sp)
800072bc:	00412903          	lw	s2,4(sp)
800072c0:	00012983          	lw	s3,0(sp)
800072c4:	00000593          	li	a1,0
800072c8:	01088533          	add	a0,a7,a6
800072cc:	01010113          	add	sp,sp,16
800072d0:	b01fb06f          	j	80002dd0 <memset>
800072d4:	00170713          	add	a4,a4,1
800072d8:	00fe07b3          	add	a5,t3,a5
800072dc:	01071713          	sll	a4,a4,0x10
800072e0:	00580493          	add	s1,a6,5
800072e4:	0007a683          	lw	a3,0(a5)
800072e8:	00180913          	add	s2,a6,1
800072ec:	01075713          	srl	a4,a4,0x10
800072f0:	fa64fae3          	bgeu	s1,t1,800072a4 <core_init_state+0x118>
800072f4:	0006c983          	lbu	s3,0(a3)
800072f8:	01088433          	add	s0,a7,a6
800072fc:	00400793          	li	a5,4
80007300:	01340023          	sb	s3,0(s0)
80007304:	0016c803          	lbu	a6,1(a3)
80007308:	01288933          	add	s2,a7,s2
8000730c:	01090023          	sb	a6,0(s2)
80007310:	0026c803          	lbu	a6,2(a3)
80007314:	01040123          	sb	a6,2(s0)
80007318:	0036c803          	lbu	a6,3(a3)
8000731c:	010401a3          	sb	a6,3(s0)
80007320:	f4b784e3          	beq	a5,a1,80007268 <core_init_state+0xdc>
80007324:	0046c803          	lbu	a6,4(a3)
80007328:	00800793          	li	a5,8
8000732c:	01040223          	sb	a6,4(s0)
80007330:	0056c803          	lbu	a6,5(a3)
80007334:	010402a3          	sb	a6,5(s0)
80007338:	0066c803          	lbu	a6,6(a3)
8000733c:	01040323          	sb	a6,6(s0)
80007340:	0076c683          	lbu	a3,7(a3)
80007344:	00d403a3          	sb	a3,7(s0)
80007348:	f21ff06f          	j	80007268 <core_init_state+0xdc>
8000734c:	00279793          	sll	a5,a5,0x2
80007350:	00ff07b3          	add	a5,t5,a5
80007354:	0007a683          	lw	a3,0(a5)
80007358:	ec9ff06f          	j	80007220 <core_init_state+0x94>
8000735c:	41050633          	sub	a2,a0,a6
80007360:	f55ff06f          	j	800072b4 <core_init_state+0x128>
80007364:	0006c983          	lbu	s3,0(a3)
80007368:	00180913          	add	s2,a6,1
8000736c:	00800793          	li	a5,8
80007370:	01340023          	sb	s3,0(s0)
80007374:	f91ff06f          	j	80007304 <core_init_state+0x178>
80007378:	00c12403          	lw	s0,12(sp)
8000737c:	00812483          	lw	s1,8(sp)
80007380:	00412903          	lw	s2,4(sp)
80007384:	00012983          	lw	s3,0(sp)
80007388:	01010113          	add	sp,sp,16
8000738c:	00008067          	ret
80007390:	00000813          	li	a6,0
80007394:	00180793          	add	a5,a6,1
80007398:	00100613          	li	a2,1
8000739c:	00f56463          	bltu	a0,a5,800073a4 <core_init_state+0x218>
800073a0:	41050633          	sub	a2,a0,a6
800073a4:	00000593          	li	a1,0
800073a8:	01088533          	add	a0,a7,a6
800073ac:	a25fb06f          	j	80002dd0 <memset>

800073b0 <core_state_transition>:
800073b0:	00052783          	lw	a5,0(a0)
800073b4:	00050813          	mv	a6,a0
800073b8:	0007c703          	lbu	a4,0(a5)
800073bc:	28070463          	beqz	a4,80007644 <core_state_transition+0x294>
800073c0:	02c00693          	li	a3,44
800073c4:	00000513          	li	a0,0
800073c8:	20d70c63          	beq	a4,a3,800075e0 <core_state_transition+0x230>
800073cc:	02e00513          	li	a0,46
800073d0:	22a70863          	beq	a4,a0,80007600 <core_state_transition+0x250>
800073d4:	1ce56c63          	bltu	a0,a4,800075ac <core_state_transition+0x1fc>
800073d8:	fd570713          	add	a4,a4,-43
800073dc:	0fd77713          	and	a4,a4,253
800073e0:	02070663          	beqz	a4,8000740c <core_state_transition+0x5c>
800073e4:	0045a683          	lw	a3,4(a1)
800073e8:	0005a703          	lw	a4,0(a1)
800073ec:	00178793          	add	a5,a5,1
800073f0:	00168693          	add	a3,a3,1
800073f4:	00170713          	add	a4,a4,1
800073f8:	00d5a223          	sw	a3,4(a1)
800073fc:	00e5a023          	sw	a4,0(a1)
80007400:	00100513          	li	a0,1
80007404:	00f82023          	sw	a5,0(a6)
80007408:	00008067          	ret
8000740c:	0005a703          	lw	a4,0(a1)
80007410:	00178613          	add	a2,a5,1
80007414:	00170713          	add	a4,a4,1
80007418:	00e5a023          	sw	a4,0(a1)
8000741c:	0017c883          	lbu	a7,1(a5)
80007420:	26088863          	beqz	a7,80007690 <core_state_transition+0x2e0>
80007424:	20d88863          	beq	a7,a3,80007634 <core_state_transition+0x284>
80007428:	0085a683          	lw	a3,8(a1)
8000742c:	fd088713          	add	a4,a7,-48
80007430:	0ff77713          	zext.b	a4,a4
80007434:	00900313          	li	t1,9
80007438:	00168693          	add	a3,a3,1
8000743c:	00e37e63          	bgeu	t1,a4,80007458 <core_state_transition+0xa8>
80007440:	1ea88663          	beq	a7,a0,8000762c <core_state_transition+0x27c>
80007444:	00d5a423          	sw	a3,8(a1)
80007448:	00278793          	add	a5,a5,2
8000744c:	00100513          	li	a0,1
80007450:	00f82023          	sw	a5,0(a6)
80007454:	00008067          	ret
80007458:	00d5a423          	sw	a3,8(a1)
8000745c:	00164783          	lbu	a5,1(a2)
80007460:	00160613          	add	a2,a2,1
80007464:	1e078463          	beqz	a5,8000764c <core_state_transition+0x29c>
80007468:	02c00713          	li	a4,44
8000746c:	16e78663          	beq	a5,a4,800075d8 <core_state_transition+0x228>
80007470:	02e00713          	li	a4,46
80007474:	02e78863          	beq	a5,a4,800074a4 <core_state_transition+0xf4>
80007478:	fd078793          	add	a5,a5,-48
8000747c:	0ff7f793          	zext.b	a5,a5
80007480:	00900713          	li	a4,9
80007484:	fcf77ce3          	bgeu	a4,a5,8000745c <core_state_transition+0xac>
80007488:	0105a703          	lw	a4,16(a1)
8000748c:	00160793          	add	a5,a2,1
80007490:	00100513          	li	a0,1
80007494:	00170713          	add	a4,a4,1
80007498:	00e5a823          	sw	a4,16(a1)
8000749c:	00f82023          	sw	a5,0(a6)
800074a0:	00008067          	ret
800074a4:	0105a783          	lw	a5,16(a1)
800074a8:	00178793          	add	a5,a5,1
800074ac:	00f5a823          	sw	a5,16(a1)
800074b0:	0140006f          	j	800074c4 <core_state_transition+0x114>
800074b4:	fd078793          	add	a5,a5,-48
800074b8:	0ff7f793          	zext.b	a5,a5
800074bc:	00900713          	li	a4,9
800074c0:	12f76463          	bltu	a4,a5,800075e8 <core_state_transition+0x238>
800074c4:	00164783          	lbu	a5,1(a2)
800074c8:	00160613          	add	a2,a2,1
800074cc:	1a078c63          	beqz	a5,80007684 <core_state_transition+0x2d4>
800074d0:	02c00713          	li	a4,44
800074d4:	14e78463          	beq	a5,a4,8000761c <core_state_transition+0x26c>
800074d8:	0df7f713          	and	a4,a5,223
800074dc:	04500693          	li	a3,69
800074e0:	fcd71ae3          	bne	a4,a3,800074b4 <core_state_transition+0x104>
800074e4:	0145a703          	lw	a4,20(a1)
800074e8:	00160793          	add	a5,a2,1
800074ec:	00300513          	li	a0,3
800074f0:	00170713          	add	a4,a4,1
800074f4:	00e5aa23          	sw	a4,20(a1)
800074f8:	00164703          	lbu	a4,1(a2)
800074fc:	f00704e3          	beqz	a4,80007404 <core_state_transition+0x54>
80007500:	02c00693          	li	a3,44
80007504:	14d70a63          	beq	a4,a3,80007658 <core_state_transition+0x2a8>
80007508:	00c5a783          	lw	a5,12(a1)
8000750c:	fd570713          	add	a4,a4,-43
80007510:	0fd77713          	and	a4,a4,253
80007514:	00178793          	add	a5,a5,1
80007518:	00f5a623          	sw	a5,12(a1)
8000751c:	00070a63          	beqz	a4,80007530 <core_state_transition+0x180>
80007520:	00260793          	add	a5,a2,2
80007524:	00100513          	li	a0,1
80007528:	00f82023          	sw	a5,0(a6)
8000752c:	00008067          	ret
80007530:	00264703          	lbu	a4,2(a2)
80007534:	00260793          	add	a5,a2,2
80007538:	00600513          	li	a0,6
8000753c:	ec0704e3          	beqz	a4,80007404 <core_state_transition+0x54>
80007540:	12d70263          	beq	a4,a3,80007664 <core_state_transition+0x2b4>
80007544:	0185a683          	lw	a3,24(a1)
80007548:	fd070713          	add	a4,a4,-48
8000754c:	0ff77713          	zext.b	a4,a4
80007550:	00168693          	add	a3,a3,1
80007554:	00900513          	li	a0,9
80007558:	00d5ac23          	sw	a3,24(a1)
8000755c:	00e57863          	bgeu	a0,a4,8000756c <core_state_transition+0x1bc>
80007560:	00360793          	add	a5,a2,3
80007564:	00100513          	li	a0,1
80007568:	e9dff06f          	j	80007404 <core_state_transition+0x54>
8000756c:	00900613          	li	a2,9
80007570:	0017c683          	lbu	a3,1(a5)
80007574:	00078513          	mv	a0,a5
80007578:	02c00893          	li	a7,44
8000757c:	fd068713          	add	a4,a3,-48
80007580:	00178793          	add	a5,a5,1
80007584:	0ff77713          	zext.b	a4,a4
80007588:	0e068463          	beqz	a3,80007670 <core_state_transition+0x2c0>
8000758c:	0f168663          	beq	a3,a7,80007678 <core_state_transition+0x2c8>
80007590:	fee670e3          	bgeu	a2,a4,80007570 <core_state_transition+0x1c0>
80007594:	0045a703          	lw	a4,4(a1)
80007598:	00250793          	add	a5,a0,2
8000759c:	00100513          	li	a0,1
800075a0:	00170713          	add	a4,a4,1
800075a4:	00e5a223          	sw	a4,4(a1)
800075a8:	e5dff06f          	j	80007404 <core_state_transition+0x54>
800075ac:	fd070713          	add	a4,a4,-48
800075b0:	0ff77713          	zext.b	a4,a4
800075b4:	00900613          	li	a2,9
800075b8:	e2e666e3          	bltu	a2,a4,800073e4 <core_state_transition+0x34>
800075bc:	0005a703          	lw	a4,0(a1)
800075c0:	00178613          	add	a2,a5,1
800075c4:	00170713          	add	a4,a4,1
800075c8:	00e5a023          	sw	a4,0(a1)
800075cc:	0017c783          	lbu	a5,1(a5)
800075d0:	06078e63          	beqz	a5,8000764c <core_state_transition+0x29c>
800075d4:	e8d79ee3          	bne	a5,a3,80007470 <core_state_transition+0xc0>
800075d8:	00060793          	mv	a5,a2
800075dc:	00400513          	li	a0,4
800075e0:	00178793          	add	a5,a5,1
800075e4:	e21ff06f          	j	80007404 <core_state_transition+0x54>
800075e8:	0145a703          	lw	a4,20(a1)
800075ec:	00160793          	add	a5,a2,1
800075f0:	00100513          	li	a0,1
800075f4:	00170713          	add	a4,a4,1
800075f8:	00e5aa23          	sw	a4,20(a1)
800075fc:	e09ff06f          	j	80007404 <core_state_transition+0x54>
80007600:	0005a703          	lw	a4,0(a1)
80007604:	00178613          	add	a2,a5,1
80007608:	00170713          	add	a4,a4,1
8000760c:	00e5a023          	sw	a4,0(a1)
80007610:	0017c783          	lbu	a5,1(a5)
80007614:	06078863          	beqz	a5,80007684 <core_state_transition+0x2d4>
80007618:	ecd790e3          	bne	a5,a3,800074d8 <core_state_transition+0x128>
8000761c:	00060793          	mv	a5,a2
80007620:	00500513          	li	a0,5
80007624:	00178793          	add	a5,a5,1
80007628:	dddff06f          	j	80007404 <core_state_transition+0x54>
8000762c:	00d5a423          	sw	a3,8(a1)
80007630:	e95ff06f          	j	800074c4 <core_state_transition+0x114>
80007634:	00060793          	mv	a5,a2
80007638:	00200513          	li	a0,2
8000763c:	00178793          	add	a5,a5,1
80007640:	dc5ff06f          	j	80007404 <core_state_transition+0x54>
80007644:	00000513          	li	a0,0
80007648:	dbdff06f          	j	80007404 <core_state_transition+0x54>
8000764c:	00060793          	mv	a5,a2
80007650:	00400513          	li	a0,4
80007654:	db1ff06f          	j	80007404 <core_state_transition+0x54>
80007658:	00300513          	li	a0,3
8000765c:	00178793          	add	a5,a5,1
80007660:	da5ff06f          	j	80007404 <core_state_transition+0x54>
80007664:	00600513          	li	a0,6
80007668:	00178793          	add	a5,a5,1
8000766c:	d99ff06f          	j	80007404 <core_state_transition+0x54>
80007670:	00700513          	li	a0,7
80007674:	d91ff06f          	j	80007404 <core_state_transition+0x54>
80007678:	00700513          	li	a0,7
8000767c:	00178793          	add	a5,a5,1
80007680:	d85ff06f          	j	80007404 <core_state_transition+0x54>
80007684:	00060793          	mv	a5,a2
80007688:	00500513          	li	a0,5
8000768c:	d79ff06f          	j	80007404 <core_state_transition+0x54>
80007690:	00060793          	mv	a5,a2
80007694:	00200513          	li	a0,2
80007698:	d6dff06f          	j	80007404 <core_state_transition+0x54>

8000769c <core_bench_state>:
8000769c:	f8010113          	add	sp,sp,-128
800076a0:	06812c23          	sw	s0,120(sp)
800076a4:	06912a23          	sw	s1,116(sp)
800076a8:	07212823          	sw	s2,112(sp)
800076ac:	07312623          	sw	s3,108(sp)
800076b0:	07412423          	sw	s4,104(sp)
800076b4:	07512223          	sw	s5,100(sp)
800076b8:	07612023          	sw	s6,96(sp)
800076bc:	05712e23          	sw	s7,92(sp)
800076c0:	06112e23          	sw	ra,124(sp)
800076c4:	00058413          	mv	s0,a1
800076c8:	0005c583          	lbu	a1,0(a1)
800076cc:	00812623          	sw	s0,12(sp)
800076d0:	02012823          	sw	zero,48(sp)
800076d4:	00012823          	sw	zero,16(sp)
800076d8:	02012a23          	sw	zero,52(sp)
800076dc:	02012c23          	sw	zero,56(sp)
800076e0:	02012e23          	sw	zero,60(sp)
800076e4:	04012023          	sw	zero,64(sp)
800076e8:	04012223          	sw	zero,68(sp)
800076ec:	04012423          	sw	zero,72(sp)
800076f0:	04012623          	sw	zero,76(sp)
800076f4:	00012a23          	sw	zero,20(sp)
800076f8:	00012c23          	sw	zero,24(sp)
800076fc:	00012e23          	sw	zero,28(sp)
80007700:	02012023          	sw	zero,32(sp)
80007704:	02012223          	sw	zero,36(sp)
80007708:	02012423          	sw	zero,40(sp)
8000770c:	02012623          	sw	zero,44(sp)
80007710:	03010913          	add	s2,sp,48
80007714:	00050b13          	mv	s6,a0
80007718:	00060b93          	mv	s7,a2
8000771c:	00068a13          	mv	s4,a3
80007720:	00070a93          	mv	s5,a4
80007724:	00078493          	mv	s1,a5
80007728:	00c10993          	add	s3,sp,12
8000772c:	18058663          	beqz	a1,800078b8 <core_bench_state+0x21c>
80007730:	00090593          	mv	a1,s2
80007734:	00098513          	mv	a0,s3
80007738:	c79ff0ef          	jal	800073b0 <core_state_transition>
8000773c:	00251813          	sll	a6,a0,0x2
80007740:	05080793          	add	a5,a6,80
80007744:	00278833          	add	a6,a5,sp
80007748:	00c12703          	lw	a4,12(sp)
8000774c:	fc082783          	lw	a5,-64(a6)
80007750:	00074703          	lbu	a4,0(a4)
80007754:	00178793          	add	a5,a5,1
80007758:	fcf82023          	sw	a5,-64(a6)
8000775c:	fc071ae3          	bnez	a4,80007730 <core_bench_state+0x94>
80007760:	00812623          	sw	s0,12(sp)
80007764:	01640b33          	add	s6,s0,s6
80007768:	03647c63          	bgeu	s0,s6,800077a0 <core_bench_state+0x104>
8000776c:	00100713          	li	a4,1
80007770:	00040793          	mv	a5,s0
80007774:	02c00613          	li	a2,44
80007778:	0eea9263          	bne	s5,a4,8000785c <core_bench_state+0x1c0>
8000777c:	0007c703          	lbu	a4,0(a5)
80007780:	017746b3          	xor	a3,a4,s7
80007784:	00c70463          	beq	a4,a2,8000778c <core_bench_state+0xf0>
80007788:	00d78023          	sb	a3,0(a5)
8000778c:	00178793          	add	a5,a5,1
80007790:	ff67e6e3          	bltu	a5,s6,8000777c <core_bench_state+0xe0>
80007794:	00044783          	lbu	a5,0(s0)
80007798:	00c10993          	add	s3,sp,12
8000779c:	10078863          	beqz	a5,800078ac <core_bench_state+0x210>
800077a0:	00090593          	mv	a1,s2
800077a4:	00098513          	mv	a0,s3
800077a8:	c09ff0ef          	jal	800073b0 <core_state_transition>
800077ac:	00251613          	sll	a2,a0,0x2
800077b0:	05060793          	add	a5,a2,80
800077b4:	00278633          	add	a2,a5,sp
800077b8:	00c12703          	lw	a4,12(sp)
800077bc:	fc062783          	lw	a5,-64(a2)
800077c0:	00074703          	lbu	a4,0(a4)
800077c4:	00178793          	add	a5,a5,1
800077c8:	fcf62023          	sw	a5,-64(a2)
800077cc:	fc071ae3          	bnez	a4,800077a0 <core_bench_state+0x104>
800077d0:	00812623          	sw	s0,12(sp)
800077d4:	03647663          	bgeu	s0,s6,80007800 <core_bench_state+0x164>
800077d8:	00100793          	li	a5,1
800077dc:	0afa9663          	bne	s5,a5,80007888 <core_bench_state+0x1ec>
800077e0:	00040713          	mv	a4,s0
800077e4:	02c00613          	li	a2,44
800077e8:	00074783          	lbu	a5,0(a4)
800077ec:	0147c6b3          	xor	a3,a5,s4
800077f0:	00c78463          	beq	a5,a2,800077f8 <core_bench_state+0x15c>
800077f4:	00d70023          	sb	a3,0(a4)
800077f8:	00170713          	add	a4,a4,1
800077fc:	ff6766e3          	bltu	a4,s6,800077e8 <core_bench_state+0x14c>
80007800:	01010413          	add	s0,sp,16
80007804:	00090993          	mv	s3,s2
80007808:	00042503          	lw	a0,0(s0)
8000780c:	00048593          	mv	a1,s1
80007810:	00440413          	add	s0,s0,4
80007814:	360000ef          	jal	80007b74 <crcu32>
80007818:	00050593          	mv	a1,a0
8000781c:	0009a503          	lw	a0,0(s3)
80007820:	00498993          	add	s3,s3,4
80007824:	350000ef          	jal	80007b74 <crcu32>
80007828:	00050493          	mv	s1,a0
8000782c:	fc891ee3          	bne	s2,s0,80007808 <core_bench_state+0x16c>
80007830:	07c12083          	lw	ra,124(sp)
80007834:	07812403          	lw	s0,120(sp)
80007838:	07412483          	lw	s1,116(sp)
8000783c:	07012903          	lw	s2,112(sp)
80007840:	06c12983          	lw	s3,108(sp)
80007844:	06812a03          	lw	s4,104(sp)
80007848:	06412a83          	lw	s5,100(sp)
8000784c:	06012b03          	lw	s6,96(sp)
80007850:	05c12b83          	lw	s7,92(sp)
80007854:	08010113          	add	sp,sp,128
80007858:	00008067          	ret
8000785c:	0007c703          	lbu	a4,0(a5)
80007860:	017746b3          	xor	a3,a4,s7
80007864:	00c70463          	beq	a4,a2,8000786c <core_bench_state+0x1d0>
80007868:	00d78023          	sb	a3,0(a5)
8000786c:	015787b3          	add	a5,a5,s5
80007870:	ff67e6e3          	bltu	a5,s6,8000785c <core_bench_state+0x1c0>
80007874:	00044783          	lbu	a5,0(s0)
80007878:	00c10993          	add	s3,sp,12
8000787c:	f20792e3          	bnez	a5,800077a0 <core_bench_state+0x104>
80007880:	00812623          	sw	s0,12(sp)
80007884:	f7647ee3          	bgeu	s0,s6,80007800 <core_bench_state+0x164>
80007888:	00040713          	mv	a4,s0
8000788c:	02c00613          	li	a2,44
80007890:	00074783          	lbu	a5,0(a4)
80007894:	0147c6b3          	xor	a3,a5,s4
80007898:	00c78463          	beq	a5,a2,800078a0 <core_bench_state+0x204>
8000789c:	00d70023          	sb	a3,0(a4)
800078a0:	01570733          	add	a4,a4,s5
800078a4:	ff6766e3          	bltu	a4,s6,80007890 <core_bench_state+0x1f4>
800078a8:	f59ff06f          	j	80007800 <core_bench_state+0x164>
800078ac:	00812623          	sw	s0,12(sp)
800078b0:	f36468e3          	bltu	s0,s6,800077e0 <core_bench_state+0x144>
800078b4:	f4dff06f          	j	80007800 <core_bench_state+0x164>
800078b8:	00a40b33          	add	s6,s0,a0
800078bc:	eb6468e3          	bltu	s0,s6,8000776c <core_bench_state+0xd0>
800078c0:	f41ff06f          	j	80007800 <core_bench_state+0x164>

800078c4 <get_seed_32>:
800078c4:	00500793          	li	a5,5
800078c8:	04a7ec63          	bltu	a5,a0,80007920 <get_seed_32+0x5c>
800078cc:	a00017b7          	lui	a5,0xa0001
800078d0:	cc878793          	add	a5,a5,-824 # a0000cc8 <intpat+0x10>
800078d4:	00251513          	sll	a0,a0,0x2
800078d8:	00f50533          	add	a0,a0,a5
800078dc:	00052783          	lw	a5,0(a0)
800078e0:	00078067          	jr	a5
800078e4:	a00017b7          	lui	a5,0xa0001
800078e8:	da07a503          	lw	a0,-608(a5) # a0000da0 <seed5_volatile>
800078ec:	00008067          	ret
800078f0:	a00017b7          	lui	a5,0xa0001
800078f4:	da87a503          	lw	a0,-600(a5) # a0000da8 <seed1_volatile>
800078f8:	00008067          	ret
800078fc:	a00017b7          	lui	a5,0xa0001
80007900:	da47a503          	lw	a0,-604(a5) # a0000da4 <seed2_volatile>
80007904:	00008067          	ret
80007908:	a00017b7          	lui	a5,0xa0001
8000790c:	d807a503          	lw	a0,-640(a5) # a0000d80 <seed3_volatile>
80007910:	00008067          	ret
80007914:	a00017b7          	lui	a5,0xa0001
80007918:	d7c7a503          	lw	a0,-644(a5) # a0000d7c <seed4_volatile>
8000791c:	00008067          	ret
80007920:	00000513          	li	a0,0
80007924:	00008067          	ret

80007928 <crcu16>:
80007928:	0ff57793          	zext.b	a5,a0
8000792c:	00b7c6b3          	xor	a3,a5,a1
80007930:	0016f693          	and	a3,a3,1
80007934:	ffffa737          	lui	a4,0xffffa
80007938:	00170713          	add	a4,a4,1 # ffffa001 <__stack_base+0x5ffea001>
8000793c:	40d006b3          	neg	a3,a3
80007940:	00e6f6b3          	and	a3,a3,a4
80007944:	0015d593          	srl	a1,a1,0x1
80007948:	00b6c6b3          	xor	a3,a3,a1
8000794c:	01069693          	sll	a3,a3,0x10
80007950:	0106d693          	srl	a3,a3,0x10
80007954:	0017d613          	srl	a2,a5,0x1
80007958:	00d64633          	xor	a2,a2,a3
8000795c:	00167613          	and	a2,a2,1
80007960:	40c00633          	neg	a2,a2
80007964:	00e67633          	and	a2,a2,a4
80007968:	0016d693          	srl	a3,a3,0x1
8000796c:	00d64633          	xor	a2,a2,a3
80007970:	01061613          	sll	a2,a2,0x10
80007974:	01065613          	srl	a2,a2,0x10
80007978:	0027d693          	srl	a3,a5,0x2
8000797c:	00c6c6b3          	xor	a3,a3,a2
80007980:	0016f693          	and	a3,a3,1
80007984:	40d006b3          	neg	a3,a3
80007988:	00e6f6b3          	and	a3,a3,a4
8000798c:	00165613          	srl	a2,a2,0x1
80007990:	00c6c6b3          	xor	a3,a3,a2
80007994:	01069693          	sll	a3,a3,0x10
80007998:	0106d693          	srl	a3,a3,0x10
8000799c:	0037d613          	srl	a2,a5,0x3
800079a0:	00d64633          	xor	a2,a2,a3
800079a4:	00167613          	and	a2,a2,1
800079a8:	40c00633          	neg	a2,a2
800079ac:	00e67633          	and	a2,a2,a4
800079b0:	0016d693          	srl	a3,a3,0x1
800079b4:	00d64633          	xor	a2,a2,a3
800079b8:	01061613          	sll	a2,a2,0x10
800079bc:	01065613          	srl	a2,a2,0x10
800079c0:	0047d693          	srl	a3,a5,0x4
800079c4:	00c6c6b3          	xor	a3,a3,a2
800079c8:	0016f693          	and	a3,a3,1
800079cc:	40d006b3          	neg	a3,a3
800079d0:	00e6f6b3          	and	a3,a3,a4
800079d4:	00165613          	srl	a2,a2,0x1
800079d8:	00c6c6b3          	xor	a3,a3,a2
800079dc:	01069693          	sll	a3,a3,0x10
800079e0:	0106d693          	srl	a3,a3,0x10
800079e4:	0057d613          	srl	a2,a5,0x5
800079e8:	00d64633          	xor	a2,a2,a3
800079ec:	00167613          	and	a2,a2,1
800079f0:	40c00633          	neg	a2,a2
800079f4:	00e67633          	and	a2,a2,a4
800079f8:	0016d693          	srl	a3,a3,0x1
800079fc:	00d64633          	xor	a2,a2,a3
80007a00:	01061613          	sll	a2,a2,0x10
80007a04:	01065613          	srl	a2,a2,0x10
80007a08:	0067d693          	srl	a3,a5,0x6
80007a0c:	00c6c6b3          	xor	a3,a3,a2
80007a10:	0016f693          	and	a3,a3,1
80007a14:	40d006b3          	neg	a3,a3
80007a18:	00e6f6b3          	and	a3,a3,a4
80007a1c:	00165613          	srl	a2,a2,0x1
80007a20:	00c6c6b3          	xor	a3,a3,a2
80007a24:	01069693          	sll	a3,a3,0x10
80007a28:	0106d693          	srl	a3,a3,0x10
80007a2c:	0077d793          	srl	a5,a5,0x7
80007a30:	00d7c7b3          	xor	a5,a5,a3
80007a34:	0017f793          	and	a5,a5,1
80007a38:	40f007b3          	neg	a5,a5
80007a3c:	00e7f7b3          	and	a5,a5,a4
80007a40:	0016d693          	srl	a3,a3,0x1
80007a44:	00d7c7b3          	xor	a5,a5,a3
80007a48:	01079793          	sll	a5,a5,0x10
80007a4c:	00855513          	srl	a0,a0,0x8
80007a50:	0107d793          	srl	a5,a5,0x10
80007a54:	00f546b3          	xor	a3,a0,a5
80007a58:	0016f693          	and	a3,a3,1
80007a5c:	40d006b3          	neg	a3,a3
80007a60:	00e6f6b3          	and	a3,a3,a4
80007a64:	0017d793          	srl	a5,a5,0x1
80007a68:	00f6c7b3          	xor	a5,a3,a5
80007a6c:	01079793          	sll	a5,a5,0x10
80007a70:	0107d793          	srl	a5,a5,0x10
80007a74:	00155693          	srl	a3,a0,0x1
80007a78:	00f6c6b3          	xor	a3,a3,a5
80007a7c:	0016f693          	and	a3,a3,1
80007a80:	40d006b3          	neg	a3,a3
80007a84:	00e6f6b3          	and	a3,a3,a4
80007a88:	0017d793          	srl	a5,a5,0x1
80007a8c:	00f6c6b3          	xor	a3,a3,a5
80007a90:	01069693          	sll	a3,a3,0x10
80007a94:	0106d693          	srl	a3,a3,0x10
80007a98:	00255793          	srl	a5,a0,0x2
80007a9c:	00d7c7b3          	xor	a5,a5,a3
80007aa0:	0017f793          	and	a5,a5,1
80007aa4:	40f007b3          	neg	a5,a5
80007aa8:	00e7f7b3          	and	a5,a5,a4
80007aac:	0016d693          	srl	a3,a3,0x1
80007ab0:	00d7c7b3          	xor	a5,a5,a3
80007ab4:	01079793          	sll	a5,a5,0x10
80007ab8:	0107d793          	srl	a5,a5,0x10
80007abc:	00355693          	srl	a3,a0,0x3
80007ac0:	00f6c6b3          	xor	a3,a3,a5
80007ac4:	0016f693          	and	a3,a3,1
80007ac8:	40d006b3          	neg	a3,a3
80007acc:	00e6f6b3          	and	a3,a3,a4
80007ad0:	0017d793          	srl	a5,a5,0x1
80007ad4:	00f6c6b3          	xor	a3,a3,a5
80007ad8:	01069693          	sll	a3,a3,0x10
80007adc:	0106d693          	srl	a3,a3,0x10
80007ae0:	00455793          	srl	a5,a0,0x4
80007ae4:	00d7c7b3          	xor	a5,a5,a3
80007ae8:	0017f793          	and	a5,a5,1
80007aec:	40f007b3          	neg	a5,a5
80007af0:	00e7f7b3          	and	a5,a5,a4
80007af4:	0016d693          	srl	a3,a3,0x1
80007af8:	00d7c7b3          	xor	a5,a5,a3
80007afc:	01079793          	sll	a5,a5,0x10
80007b00:	0107d793          	srl	a5,a5,0x10
80007b04:	00555693          	srl	a3,a0,0x5
80007b08:	00f6c6b3          	xor	a3,a3,a5
80007b0c:	0016f693          	and	a3,a3,1
80007b10:	40d006b3          	neg	a3,a3
80007b14:	00e6f6b3          	and	a3,a3,a4
80007b18:	0017d793          	srl	a5,a5,0x1
80007b1c:	00f6c6b3          	xor	a3,a3,a5
80007b20:	01069693          	sll	a3,a3,0x10
80007b24:	0106d693          	srl	a3,a3,0x10
80007b28:	00655793          	srl	a5,a0,0x6
80007b2c:	00d7c7b3          	xor	a5,a5,a3
80007b30:	0017f793          	and	a5,a5,1
80007b34:	40f007b3          	neg	a5,a5
80007b38:	00e7f7b3          	and	a5,a5,a4
80007b3c:	0016d693          	srl	a3,a3,0x1
80007b40:	00d7c7b3          	xor	a5,a5,a3
80007b44:	01079793          	sll	a5,a5,0x10
80007b48:	0107d793          	srl	a5,a5,0x10
80007b4c:	00755513          	srl	a0,a0,0x7
80007b50:	00f54533          	xor	a0,a0,a5
80007b54:	00157513          	and	a0,a0,1
80007b58:	40a00533          	neg	a0,a0
80007b5c:	00e57533          	and	a0,a0,a4
80007b60:	0017d793          	srl	a5,a5,0x1
80007b64:	00f54533          	xor	a0,a0,a5
80007b68:	01051513          	sll	a0,a0,0x10
80007b6c:	01055513          	srl	a0,a0,0x10
80007b70:	00008067          	ret

80007b74 <crcu32>:
80007b74:	0ff57713          	zext.b	a4,a0
80007b78:	00b74633          	xor	a2,a4,a1
80007b7c:	00167613          	and	a2,a2,1
80007b80:	ffffa7b7          	lui	a5,0xffffa
80007b84:	00178793          	add	a5,a5,1 # ffffa001 <__stack_base+0x5ffea001>
80007b88:	40c00633          	neg	a2,a2
80007b8c:	00f67633          	and	a2,a2,a5
80007b90:	0015d593          	srl	a1,a1,0x1
80007b94:	00b64633          	xor	a2,a2,a1
80007b98:	01061613          	sll	a2,a2,0x10
80007b9c:	01065613          	srl	a2,a2,0x10
80007ba0:	00175693          	srl	a3,a4,0x1
80007ba4:	00c6c6b3          	xor	a3,a3,a2
80007ba8:	0016f693          	and	a3,a3,1
80007bac:	40d006b3          	neg	a3,a3
80007bb0:	00f6f6b3          	and	a3,a3,a5
80007bb4:	00165613          	srl	a2,a2,0x1
80007bb8:	00c6c6b3          	xor	a3,a3,a2
80007bbc:	01069693          	sll	a3,a3,0x10
80007bc0:	0106d693          	srl	a3,a3,0x10
80007bc4:	00275613          	srl	a2,a4,0x2
80007bc8:	00d64633          	xor	a2,a2,a3
80007bcc:	00167613          	and	a2,a2,1
80007bd0:	40c00633          	neg	a2,a2
80007bd4:	00f67633          	and	a2,a2,a5
80007bd8:	0016d693          	srl	a3,a3,0x1
80007bdc:	00d64633          	xor	a2,a2,a3
80007be0:	01061613          	sll	a2,a2,0x10
80007be4:	01065613          	srl	a2,a2,0x10
80007be8:	00375693          	srl	a3,a4,0x3
80007bec:	00c6c6b3          	xor	a3,a3,a2
80007bf0:	0016f693          	and	a3,a3,1
80007bf4:	40d006b3          	neg	a3,a3
80007bf8:	00f6f6b3          	and	a3,a3,a5
80007bfc:	00165613          	srl	a2,a2,0x1
80007c00:	00c6c6b3          	xor	a3,a3,a2
80007c04:	01069693          	sll	a3,a3,0x10
80007c08:	0106d693          	srl	a3,a3,0x10
80007c0c:	00475613          	srl	a2,a4,0x4
80007c10:	00d64633          	xor	a2,a2,a3
80007c14:	00167613          	and	a2,a2,1
80007c18:	40c00633          	neg	a2,a2
80007c1c:	00f67633          	and	a2,a2,a5
80007c20:	0016d693          	srl	a3,a3,0x1
80007c24:	00d64633          	xor	a2,a2,a3
80007c28:	01061613          	sll	a2,a2,0x10
80007c2c:	01065613          	srl	a2,a2,0x10
80007c30:	00575693          	srl	a3,a4,0x5
80007c34:	00c6c6b3          	xor	a3,a3,a2
80007c38:	0016f693          	and	a3,a3,1
80007c3c:	40d006b3          	neg	a3,a3
80007c40:	00f6f6b3          	and	a3,a3,a5
80007c44:	00165613          	srl	a2,a2,0x1
80007c48:	00c6c6b3          	xor	a3,a3,a2
80007c4c:	01069693          	sll	a3,a3,0x10
80007c50:	0106d693          	srl	a3,a3,0x10
80007c54:	00675613          	srl	a2,a4,0x6
80007c58:	00d64633          	xor	a2,a2,a3
80007c5c:	00167613          	and	a2,a2,1
80007c60:	40c00633          	neg	a2,a2
80007c64:	00f67633          	and	a2,a2,a5
80007c68:	0016d693          	srl	a3,a3,0x1
80007c6c:	00d64633          	xor	a2,a2,a3
80007c70:	01061613          	sll	a2,a2,0x10
80007c74:	01065613          	srl	a2,a2,0x10
80007c78:	00775693          	srl	a3,a4,0x7
80007c7c:	00c6c6b3          	xor	a3,a3,a2
80007c80:	0016f693          	and	a3,a3,1
80007c84:	40d006b3          	neg	a3,a3
80007c88:	00f6f6b3          	and	a3,a3,a5
80007c8c:	00165613          	srl	a2,a2,0x1
80007c90:	00c6c6b3          	xor	a3,a3,a2
80007c94:	01051713          	sll	a4,a0,0x10
80007c98:	01075713          	srl	a4,a4,0x10
80007c9c:	01069693          	sll	a3,a3,0x10
80007ca0:	00875713          	srl	a4,a4,0x8
80007ca4:	0106d693          	srl	a3,a3,0x10
80007ca8:	00d74633          	xor	a2,a4,a3
80007cac:	00167613          	and	a2,a2,1
80007cb0:	40c00633          	neg	a2,a2
80007cb4:	00f67633          	and	a2,a2,a5
80007cb8:	0016d693          	srl	a3,a3,0x1
80007cbc:	00d64633          	xor	a2,a2,a3
80007cc0:	01061613          	sll	a2,a2,0x10
80007cc4:	01065613          	srl	a2,a2,0x10
80007cc8:	00175693          	srl	a3,a4,0x1
80007ccc:	00c6c6b3          	xor	a3,a3,a2
80007cd0:	0016f693          	and	a3,a3,1
80007cd4:	40d006b3          	neg	a3,a3
80007cd8:	00f6f6b3          	and	a3,a3,a5
80007cdc:	00165613          	srl	a2,a2,0x1
80007ce0:	00c6c6b3          	xor	a3,a3,a2
80007ce4:	01069693          	sll	a3,a3,0x10
80007ce8:	0106d693          	srl	a3,a3,0x10
80007cec:	00275613          	srl	a2,a4,0x2
80007cf0:	00d64633          	xor	a2,a2,a3
80007cf4:	00167613          	and	a2,a2,1
80007cf8:	40c00633          	neg	a2,a2
80007cfc:	00f67633          	and	a2,a2,a5
80007d00:	0016d693          	srl	a3,a3,0x1
80007d04:	00d64633          	xor	a2,a2,a3
80007d08:	01061613          	sll	a2,a2,0x10
80007d0c:	01065613          	srl	a2,a2,0x10
80007d10:	00375693          	srl	a3,a4,0x3
80007d14:	00c6c6b3          	xor	a3,a3,a2
80007d18:	0016f693          	and	a3,a3,1
80007d1c:	40d006b3          	neg	a3,a3
80007d20:	00f6f6b3          	and	a3,a3,a5
80007d24:	00165613          	srl	a2,a2,0x1
80007d28:	00c6c6b3          	xor	a3,a3,a2
80007d2c:	01069693          	sll	a3,a3,0x10
80007d30:	0106d693          	srl	a3,a3,0x10
80007d34:	00475613          	srl	a2,a4,0x4
80007d38:	00d64633          	xor	a2,a2,a3
80007d3c:	00167613          	and	a2,a2,1
80007d40:	40c00633          	neg	a2,a2
80007d44:	00f67633          	and	a2,a2,a5
80007d48:	0016d693          	srl	a3,a3,0x1
80007d4c:	00d64633          	xor	a2,a2,a3
80007d50:	01061613          	sll	a2,a2,0x10
80007d54:	01065613          	srl	a2,a2,0x10
80007d58:	00575693          	srl	a3,a4,0x5
80007d5c:	00c6c6b3          	xor	a3,a3,a2
80007d60:	0016f693          	and	a3,a3,1
80007d64:	40d006b3          	neg	a3,a3
80007d68:	00f6f6b3          	and	a3,a3,a5
80007d6c:	00165613          	srl	a2,a2,0x1
80007d70:	00c6c6b3          	xor	a3,a3,a2
80007d74:	01069693          	sll	a3,a3,0x10
80007d78:	0106d693          	srl	a3,a3,0x10
80007d7c:	00675613          	srl	a2,a4,0x6
80007d80:	00d64633          	xor	a2,a2,a3
80007d84:	00167613          	and	a2,a2,1
80007d88:	40c00633          	neg	a2,a2
80007d8c:	00f67633          	and	a2,a2,a5
80007d90:	0016d693          	srl	a3,a3,0x1
80007d94:	00d64633          	xor	a2,a2,a3
80007d98:	01061613          	sll	a2,a2,0x10
80007d9c:	01065613          	srl	a2,a2,0x10
80007da0:	00775693          	srl	a3,a4,0x7
80007da4:	00c6c6b3          	xor	a3,a3,a2
80007da8:	0016f693          	and	a3,a3,1
80007dac:	40d006b3          	neg	a3,a3
80007db0:	00f6f6b3          	and	a3,a3,a5
80007db4:	00165613          	srl	a2,a2,0x1
80007db8:	00c6c6b3          	xor	a3,a3,a2
80007dbc:	01055513          	srl	a0,a0,0x10
80007dc0:	01069693          	sll	a3,a3,0x10
80007dc4:	0ff57713          	zext.b	a4,a0
80007dc8:	0106d693          	srl	a3,a3,0x10
80007dcc:	00d74633          	xor	a2,a4,a3
80007dd0:	00167613          	and	a2,a2,1
80007dd4:	40c00633          	neg	a2,a2
80007dd8:	00f67633          	and	a2,a2,a5
80007ddc:	0016d693          	srl	a3,a3,0x1
80007de0:	00d646b3          	xor	a3,a2,a3
80007de4:	01069693          	sll	a3,a3,0x10
80007de8:	0106d693          	srl	a3,a3,0x10
80007dec:	00175613          	srl	a2,a4,0x1
80007df0:	00d64633          	xor	a2,a2,a3
80007df4:	00167613          	and	a2,a2,1
80007df8:	40c00633          	neg	a2,a2
80007dfc:	00f67633          	and	a2,a2,a5
80007e00:	0016d693          	srl	a3,a3,0x1
80007e04:	00d64633          	xor	a2,a2,a3
80007e08:	01061613          	sll	a2,a2,0x10
80007e0c:	01065613          	srl	a2,a2,0x10
80007e10:	00275693          	srl	a3,a4,0x2
80007e14:	00c6c6b3          	xor	a3,a3,a2
80007e18:	0016f693          	and	a3,a3,1
80007e1c:	40d006b3          	neg	a3,a3
80007e20:	00f6f6b3          	and	a3,a3,a5
80007e24:	00165613          	srl	a2,a2,0x1
80007e28:	00c6c6b3          	xor	a3,a3,a2
80007e2c:	01069693          	sll	a3,a3,0x10
80007e30:	0106d693          	srl	a3,a3,0x10
80007e34:	00375613          	srl	a2,a4,0x3
80007e38:	00d64633          	xor	a2,a2,a3
80007e3c:	00167613          	and	a2,a2,1
80007e40:	40c00633          	neg	a2,a2
80007e44:	00f67633          	and	a2,a2,a5
80007e48:	0016d693          	srl	a3,a3,0x1
80007e4c:	00d64633          	xor	a2,a2,a3
80007e50:	01061613          	sll	a2,a2,0x10
80007e54:	01065613          	srl	a2,a2,0x10
80007e58:	00475693          	srl	a3,a4,0x4
80007e5c:	00c6c6b3          	xor	a3,a3,a2
80007e60:	0016f693          	and	a3,a3,1
80007e64:	40d006b3          	neg	a3,a3
80007e68:	00f6f6b3          	and	a3,a3,a5
80007e6c:	00165613          	srl	a2,a2,0x1
80007e70:	00c6c6b3          	xor	a3,a3,a2
80007e74:	01069693          	sll	a3,a3,0x10
80007e78:	0106d693          	srl	a3,a3,0x10
80007e7c:	00575613          	srl	a2,a4,0x5
80007e80:	00d64633          	xor	a2,a2,a3
80007e84:	00167613          	and	a2,a2,1
80007e88:	40c00633          	neg	a2,a2
80007e8c:	00f67633          	and	a2,a2,a5
80007e90:	0016d693          	srl	a3,a3,0x1
80007e94:	00d64633          	xor	a2,a2,a3
80007e98:	01061613          	sll	a2,a2,0x10
80007e9c:	01065613          	srl	a2,a2,0x10
80007ea0:	00675693          	srl	a3,a4,0x6
80007ea4:	00c6c6b3          	xor	a3,a3,a2
80007ea8:	0016f693          	and	a3,a3,1
80007eac:	40d006b3          	neg	a3,a3
80007eb0:	00f6f6b3          	and	a3,a3,a5
80007eb4:	00165613          	srl	a2,a2,0x1
80007eb8:	00c6c6b3          	xor	a3,a3,a2
80007ebc:	01069693          	sll	a3,a3,0x10
80007ec0:	0106d693          	srl	a3,a3,0x10
80007ec4:	00775713          	srl	a4,a4,0x7
80007ec8:	00d74733          	xor	a4,a4,a3
80007ecc:	00177713          	and	a4,a4,1
80007ed0:	40e00733          	neg	a4,a4
80007ed4:	00f77733          	and	a4,a4,a5
80007ed8:	0016d693          	srl	a3,a3,0x1
80007edc:	00d74733          	xor	a4,a4,a3
80007ee0:	01071713          	sll	a4,a4,0x10
80007ee4:	00855513          	srl	a0,a0,0x8
80007ee8:	01075713          	srl	a4,a4,0x10
80007eec:	00e546b3          	xor	a3,a0,a4
80007ef0:	0016f693          	and	a3,a3,1
80007ef4:	40d006b3          	neg	a3,a3
80007ef8:	00f6f6b3          	and	a3,a3,a5
80007efc:	00175713          	srl	a4,a4,0x1
80007f00:	00e6c733          	xor	a4,a3,a4
80007f04:	01071713          	sll	a4,a4,0x10
80007f08:	01075713          	srl	a4,a4,0x10
80007f0c:	00155693          	srl	a3,a0,0x1
80007f10:	00e6c6b3          	xor	a3,a3,a4
80007f14:	0016f693          	and	a3,a3,1
80007f18:	40d006b3          	neg	a3,a3
80007f1c:	00f6f6b3          	and	a3,a3,a5
80007f20:	00175713          	srl	a4,a4,0x1
80007f24:	00e6c6b3          	xor	a3,a3,a4
80007f28:	01069693          	sll	a3,a3,0x10
80007f2c:	0106d693          	srl	a3,a3,0x10
80007f30:	00255713          	srl	a4,a0,0x2
80007f34:	00d74733          	xor	a4,a4,a3
80007f38:	00177713          	and	a4,a4,1
80007f3c:	40e00733          	neg	a4,a4
80007f40:	00f77733          	and	a4,a4,a5
80007f44:	0016d693          	srl	a3,a3,0x1
80007f48:	00d74733          	xor	a4,a4,a3
80007f4c:	01071713          	sll	a4,a4,0x10
80007f50:	01075713          	srl	a4,a4,0x10
80007f54:	00355693          	srl	a3,a0,0x3
80007f58:	00e6c6b3          	xor	a3,a3,a4
80007f5c:	0016f693          	and	a3,a3,1
80007f60:	40d006b3          	neg	a3,a3
80007f64:	00f6f6b3          	and	a3,a3,a5
80007f68:	00175713          	srl	a4,a4,0x1
80007f6c:	00e6c6b3          	xor	a3,a3,a4
80007f70:	01069693          	sll	a3,a3,0x10
80007f74:	0106d693          	srl	a3,a3,0x10
80007f78:	00455713          	srl	a4,a0,0x4
80007f7c:	00d74733          	xor	a4,a4,a3
80007f80:	00177713          	and	a4,a4,1
80007f84:	40e00733          	neg	a4,a4
80007f88:	00f77733          	and	a4,a4,a5
80007f8c:	0016d693          	srl	a3,a3,0x1
80007f90:	00d74733          	xor	a4,a4,a3
80007f94:	01071713          	sll	a4,a4,0x10
80007f98:	01075713          	srl	a4,a4,0x10
80007f9c:	00555693          	srl	a3,a0,0x5
80007fa0:	00e6c6b3          	xor	a3,a3,a4
80007fa4:	0016f693          	and	a3,a3,1
80007fa8:	40d006b3          	neg	a3,a3
80007fac:	00f6f6b3          	and	a3,a3,a5
80007fb0:	00175713          	srl	a4,a4,0x1
80007fb4:	00e6c6b3          	xor	a3,a3,a4
80007fb8:	01069693          	sll	a3,a3,0x10
80007fbc:	0106d693          	srl	a3,a3,0x10
80007fc0:	00655713          	srl	a4,a0,0x6
80007fc4:	00d74733          	xor	a4,a4,a3
80007fc8:	00177713          	and	a4,a4,1
80007fcc:	40e00733          	neg	a4,a4
80007fd0:	00f77733          	and	a4,a4,a5
80007fd4:	0016d693          	srl	a3,a3,0x1
80007fd8:	00d74733          	xor	a4,a4,a3
80007fdc:	01071713          	sll	a4,a4,0x10
80007fe0:	01075713          	srl	a4,a4,0x10
80007fe4:	00755513          	srl	a0,a0,0x7
80007fe8:	00e54533          	xor	a0,a0,a4
80007fec:	00157513          	and	a0,a0,1
80007ff0:	40a00533          	neg	a0,a0
80007ff4:	00f57533          	and	a0,a0,a5
80007ff8:	00175713          	srl	a4,a4,0x1
80007ffc:	00e54533          	xor	a0,a0,a4
80008000:	01051513          	sll	a0,a0,0x10
80008004:	01055513          	srl	a0,a0,0x10
80008008:	00008067          	ret

8000800c <crc16>:
8000800c:	0ff57793          	zext.b	a5,a0
80008010:	00b7c6b3          	xor	a3,a5,a1
80008014:	0016f693          	and	a3,a3,1
80008018:	ffffa737          	lui	a4,0xffffa
8000801c:	00170713          	add	a4,a4,1 # ffffa001 <__stack_base+0x5ffea001>
80008020:	40d006b3          	neg	a3,a3
80008024:	00e6f6b3          	and	a3,a3,a4
80008028:	0015d593          	srl	a1,a1,0x1
8000802c:	00b6c6b3          	xor	a3,a3,a1
80008030:	01069693          	sll	a3,a3,0x10
80008034:	0106d693          	srl	a3,a3,0x10
80008038:	0017d613          	srl	a2,a5,0x1
8000803c:	00d64633          	xor	a2,a2,a3
80008040:	00167613          	and	a2,a2,1
80008044:	40c00633          	neg	a2,a2
80008048:	00e67633          	and	a2,a2,a4
8000804c:	0016d693          	srl	a3,a3,0x1
80008050:	00d64633          	xor	a2,a2,a3
80008054:	01061613          	sll	a2,a2,0x10
80008058:	01065613          	srl	a2,a2,0x10
8000805c:	0027d693          	srl	a3,a5,0x2
80008060:	00c6c6b3          	xor	a3,a3,a2
80008064:	0016f693          	and	a3,a3,1
80008068:	40d006b3          	neg	a3,a3
8000806c:	00e6f6b3          	and	a3,a3,a4
80008070:	00165613          	srl	a2,a2,0x1
80008074:	00c6c6b3          	xor	a3,a3,a2
80008078:	01069693          	sll	a3,a3,0x10
8000807c:	0106d693          	srl	a3,a3,0x10
80008080:	0037d613          	srl	a2,a5,0x3
80008084:	00d64633          	xor	a2,a2,a3
80008088:	00167613          	and	a2,a2,1
8000808c:	40c00633          	neg	a2,a2
80008090:	00e67633          	and	a2,a2,a4
80008094:	0016d693          	srl	a3,a3,0x1
80008098:	00d64633          	xor	a2,a2,a3
8000809c:	01061613          	sll	a2,a2,0x10
800080a0:	01065613          	srl	a2,a2,0x10
800080a4:	0047d693          	srl	a3,a5,0x4
800080a8:	00c6c6b3          	xor	a3,a3,a2
800080ac:	0016f693          	and	a3,a3,1
800080b0:	40d006b3          	neg	a3,a3
800080b4:	00e6f6b3          	and	a3,a3,a4
800080b8:	00165613          	srl	a2,a2,0x1
800080bc:	00c6c6b3          	xor	a3,a3,a2
800080c0:	01069693          	sll	a3,a3,0x10
800080c4:	0106d693          	srl	a3,a3,0x10
800080c8:	0057d613          	srl	a2,a5,0x5
800080cc:	00d64633          	xor	a2,a2,a3
800080d0:	00167613          	and	a2,a2,1
800080d4:	40c00633          	neg	a2,a2
800080d8:	00e67633          	and	a2,a2,a4
800080dc:	0016d693          	srl	a3,a3,0x1
800080e0:	00d64633          	xor	a2,a2,a3
800080e4:	01061613          	sll	a2,a2,0x10
800080e8:	01065613          	srl	a2,a2,0x10
800080ec:	0067d693          	srl	a3,a5,0x6
800080f0:	00c6c6b3          	xor	a3,a3,a2
800080f4:	0016f693          	and	a3,a3,1
800080f8:	40d006b3          	neg	a3,a3
800080fc:	00e6f6b3          	and	a3,a3,a4
80008100:	00165613          	srl	a2,a2,0x1
80008104:	00c6c6b3          	xor	a3,a3,a2
80008108:	01069693          	sll	a3,a3,0x10
8000810c:	0106d693          	srl	a3,a3,0x10
80008110:	0077d793          	srl	a5,a5,0x7
80008114:	00d7c7b3          	xor	a5,a5,a3
80008118:	0017f793          	and	a5,a5,1
8000811c:	40f007b3          	neg	a5,a5
80008120:	00e7f7b3          	and	a5,a5,a4
80008124:	0016d693          	srl	a3,a3,0x1
80008128:	00d7c7b3          	xor	a5,a5,a3
8000812c:	01051513          	sll	a0,a0,0x10
80008130:	01055513          	srl	a0,a0,0x10
80008134:	01079793          	sll	a5,a5,0x10
80008138:	00855513          	srl	a0,a0,0x8
8000813c:	0107d793          	srl	a5,a5,0x10
80008140:	00f546b3          	xor	a3,a0,a5
80008144:	0016f693          	and	a3,a3,1
80008148:	40d006b3          	neg	a3,a3
8000814c:	00e6f6b3          	and	a3,a3,a4
80008150:	0017d793          	srl	a5,a5,0x1
80008154:	00f6c7b3          	xor	a5,a3,a5
80008158:	01079793          	sll	a5,a5,0x10
8000815c:	0107d793          	srl	a5,a5,0x10
80008160:	00155693          	srl	a3,a0,0x1
80008164:	00f6c6b3          	xor	a3,a3,a5
80008168:	0016f693          	and	a3,a3,1
8000816c:	40d006b3          	neg	a3,a3
80008170:	00e6f6b3          	and	a3,a3,a4
80008174:	0017d793          	srl	a5,a5,0x1
80008178:	00f6c6b3          	xor	a3,a3,a5
8000817c:	01069693          	sll	a3,a3,0x10
80008180:	0106d693          	srl	a3,a3,0x10
80008184:	00255793          	srl	a5,a0,0x2
80008188:	00d7c7b3          	xor	a5,a5,a3
8000818c:	0017f793          	and	a5,a5,1
80008190:	40f007b3          	neg	a5,a5
80008194:	00e7f7b3          	and	a5,a5,a4
80008198:	0016d693          	srl	a3,a3,0x1
8000819c:	00d7c7b3          	xor	a5,a5,a3
800081a0:	01079793          	sll	a5,a5,0x10
800081a4:	0107d793          	srl	a5,a5,0x10
800081a8:	00355693          	srl	a3,a0,0x3
800081ac:	00f6c6b3          	xor	a3,a3,a5
800081b0:	0016f693          	and	a3,a3,1
800081b4:	40d006b3          	neg	a3,a3
800081b8:	00e6f6b3          	and	a3,a3,a4
800081bc:	0017d793          	srl	a5,a5,0x1
800081c0:	00f6c6b3          	xor	a3,a3,a5
800081c4:	01069693          	sll	a3,a3,0x10
800081c8:	0106d693          	srl	a3,a3,0x10
800081cc:	00455793          	srl	a5,a0,0x4
800081d0:	00d7c7b3          	xor	a5,a5,a3
800081d4:	0017f793          	and	a5,a5,1
800081d8:	40f007b3          	neg	a5,a5
800081dc:	00e7f7b3          	and	a5,a5,a4
800081e0:	0016d693          	srl	a3,a3,0x1
800081e4:	00d7c7b3          	xor	a5,a5,a3
800081e8:	01079793          	sll	a5,a5,0x10
800081ec:	0107d793          	srl	a5,a5,0x10
800081f0:	00555693          	srl	a3,a0,0x5
800081f4:	00f6c6b3          	xor	a3,a3,a5
800081f8:	0016f693          	and	a3,a3,1
800081fc:	40d006b3          	neg	a3,a3
80008200:	00e6f6b3          	and	a3,a3,a4
80008204:	0017d793          	srl	a5,a5,0x1
80008208:	00f6c6b3          	xor	a3,a3,a5
8000820c:	01069693          	sll	a3,a3,0x10
80008210:	0106d693          	srl	a3,a3,0x10
80008214:	00655793          	srl	a5,a0,0x6
80008218:	00d7c7b3          	xor	a5,a5,a3
8000821c:	0017f793          	and	a5,a5,1
80008220:	40f007b3          	neg	a5,a5
80008224:	00e7f7b3          	and	a5,a5,a4
80008228:	0016d693          	srl	a3,a3,0x1
8000822c:	00d7c7b3          	xor	a5,a5,a3
80008230:	01079793          	sll	a5,a5,0x10
80008234:	0107d793          	srl	a5,a5,0x10
80008238:	00755513          	srl	a0,a0,0x7
8000823c:	00f54533          	xor	a0,a0,a5
80008240:	00157513          	and	a0,a0,1
80008244:	40a00533          	neg	a0,a0
80008248:	00e57533          	and	a0,a0,a4
8000824c:	0017d793          	srl	a5,a5,0x1
80008250:	00f54533          	xor	a0,a0,a5
80008254:	01051513          	sll	a0,a0,0x10
80008258:	01055513          	srl	a0,a0,0x10
8000825c:	00008067          	ret

80008260 <check_data_types>:
80008260:	00000513          	li	a0,0
80008264:	00008067          	ret

80008268 <start_time>:
80008268:	ff010113          	add	sp,sp,-16
8000826c:	00112623          	sw	ra,12(sp)
80008270:	f99fa0ef          	jal	80003208 <get_cycle>
80008274:	00c12083          	lw	ra,12(sp)
80008278:	a00017b7          	lui	a5,0xa0001
8000827c:	41f55713          	sra	a4,a0,0x1f
80008280:	d8a7ac23          	sw	a0,-616(a5) # a0000d98 <start_time_val>
80008284:	d8e7ae23          	sw	a4,-612(a5)
80008288:	01010113          	add	sp,sp,16
8000828c:	00008067          	ret

80008290 <stop_time>:
80008290:	ff010113          	add	sp,sp,-16
80008294:	00112623          	sw	ra,12(sp)
80008298:	f71fa0ef          	jal	80003208 <get_cycle>
8000829c:	00c12083          	lw	ra,12(sp)
800082a0:	a00017b7          	lui	a5,0xa0001
800082a4:	41f55713          	sra	a4,a0,0x1f
800082a8:	d8a7a823          	sw	a0,-624(a5) # a0000d90 <stop_time_val>
800082ac:	d8e7aa23          	sw	a4,-620(a5)
800082b0:	01010113          	add	sp,sp,16
800082b4:	00008067          	ret

800082b8 <get_time>:
800082b8:	a00016b7          	lui	a3,0xa0001
800082bc:	a0001737          	lui	a4,0xa0001
800082c0:	d906a783          	lw	a5,-624(a3) # a0000d90 <stop_time_val>
800082c4:	d9872503          	lw	a0,-616(a4) # a0000d98 <start_time_val>
800082c8:	d946a583          	lw	a1,-620(a3)
800082cc:	d9c72703          	lw	a4,-612(a4)
800082d0:	40a78533          	sub	a0,a5,a0
800082d4:	00a7b7b3          	sltu	a5,a5,a0
800082d8:	40e585b3          	sub	a1,a1,a4
800082dc:	40f585b3          	sub	a1,a1,a5
800082e0:	00008067          	ret

800082e4 <time_in_secs>:
800082e4:	ff010113          	add	sp,sp,-16
800082e8:	00112623          	sw	ra,12(sp)
800082ec:	fa0fa0ef          	jal	80002a8c <__floatundidf>
800082f0:	a00017b7          	lui	a5,0xa0001
800082f4:	d687a603          	lw	a2,-664(a5) # a0000d68 <intpat+0xb0>
800082f8:	d6c7a683          	lw	a3,-660(a5)
800082fc:	eb5f80ef          	jal	800011b0 <__divdf3>
80008300:	00c12083          	lw	ra,12(sp)
80008304:	01010113          	add	sp,sp,16
80008308:	00008067          	ret

8000830c <portable_init>:
8000830c:	00100793          	li	a5,1
80008310:	00f50023          	sb	a5,0(a0)
80008314:	00008067          	ret

80008318 <portable_fini>:
80008318:	00050023          	sb	zero,0(a0)
8000831c:	00008067          	ret
