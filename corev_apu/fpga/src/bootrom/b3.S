
bootrom_64.elf:     file format elf64-littleriscv


Disassembly of section .text.init:

0000000000010000 <_prog_start>:
   10000:	00800913          	li	s2,8
   10004:	30491073          	csrw	mie,s2
   10008:	00000493          	li	s1,0
   1000c:	f1402973          	csrr	s2,mhartid
   10010:	03249663          	bne	s1,s2,1003c <_prog_start+0x3c>
   10014:	0210011b          	addiw	sp,zero,33
   10018:	01a11113          	slli	sp,sp,0x1a
   1001c:	353000ef          	jal	ra,10b6e <_TEXT_END_>
   10020:	020004b7          	lui	s1,0x2000
   10024:	00100913          	li	s2,1
   10028:	0124a023          	sw	s2,0(s1) # 2000000 <_RODATA_END_+0x1fee208>
   1002c:	00448493          	addi	s1,s1,4
   10030:	02000937          	lui	s2,0x2000
   10034:	4009091b          	addiw	s2,s2,1024
   10038:	ff24c6e3          	blt	s1,s2,10024 <_prog_start+0x24>
   1003c:	10500073          	wfi
   10040:	34402973          	csrr	s2,mip
   10044:	00897913          	andi	s2,s2,8
   10048:	fe090ae3          	beqz	s2,1003c <_prog_start+0x3c>
   1004c:	020004b7          	lui	s1,0x2000
   10050:	f1402973          	csrr	s2,mhartid
   10054:	00291913          	slli	s2,s2,0x2
   10058:	00990933          	add	s2,s2,s1
   1005c:	00092023          	sw	zero,0(s2) # 2000000 <_RODATA_END_+0x1fee208>
   10060:	0004a903          	lw	s2,0(s1) # 2000000 <_RODATA_END_+0x1fee208>
   10064:	fe091ee3          	bnez	s2,10060 <_prog_start+0x60>
   10068:	00448493          	addi	s1,s1,4
   1006c:	02000937          	lui	s2,0x2000
   10070:	4009091b          	addiw	s2,s2,1024
   10074:	ff24c6e3          	blt	s1,s2,10060 <_prog_start+0x60>
   10078:	f1402573          	csrr	a0,mhartid
   1007c:	00001597          	auipc	a1,0x1
   10080:	e8458593          	addi	a1,a1,-380 # 10f00 <_RODATA_START_>
   10084:	0010049b          	addiw	s1,zero,1
   10088:	01f49493          	slli	s1,s1,0x1f
   1008c:	00048067          	jr	s1

Disassembly of section .text:

0000000000010100 <handle_trap>:
   10100:	8082                	ret

0000000000010102 <write_reg_u8>:
   10102:	00b50023          	sb	a1,0(a0)
   10106:	8082                	ret

0000000000010108 <read_reg_u8>:
   10108:	00054503          	lbu	a0,0(a0)
   1010c:	8082                	ret

000000000001010e <is_transmit_empty>:
   1010e:	100007b7          	lui	a5,0x10000
   10112:	0147c503          	lbu	a0,20(a5) # 10000014 <_RODATA_END_+0xffee21c>
   10116:	02057513          	andi	a0,a0,32
   1011a:	8082                	ret

000000000001011c <write_serial>:
   1011c:	10000737          	lui	a4,0x10000
   10120:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee21c>
   10124:	0207f793          	andi	a5,a5,32
   10128:	dfe5                	beqz	a5,10120 <write_serial+0x4>
   1012a:	00a70023          	sb	a0,0(a4)
   1012e:	8082                	ret

0000000000010130 <init_uart>:
   10130:	0045959b          	slliw	a1,a1,0x4
   10134:	02b5553b          	divuw	a0,a0,a1
   10138:	100007b7          	lui	a5,0x10000
   1013c:	00078223          	sb	zero,4(a5) # 10000004 <_RODATA_END_+0xffee20c>
   10140:	f8000713          	li	a4,-128
   10144:	00e78623          	sb	a4,12(a5)
   10148:	0ff57713          	andi	a4,a0,255
   1014c:	0085551b          	srliw	a0,a0,0x8
   10150:	00e78023          	sb	a4,0(a5)
   10154:	0ff57513          	andi	a0,a0,255
   10158:	00a78223          	sb	a0,4(a5)
   1015c:	470d                	li	a4,3
   1015e:	00e78623          	sb	a4,12(a5)
   10162:	fc700713          	li	a4,-57
   10166:	00e78423          	sb	a4,8(a5)
   1016a:	02000713          	li	a4,32
   1016e:	00e78823          	sb	a4,16(a5)
   10172:	8082                	ret

0000000000010174 <print_uart>:
   10174:	00054683          	lbu	a3,0(a0)
   10178:	ce91                	beqz	a3,10194 <print_uart+0x20>
   1017a:	10000737          	lui	a4,0x10000
   1017e:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee21c>
   10182:	0207f793          	andi	a5,a5,32
   10186:	dfe5                	beqz	a5,1017e <print_uart+0xa>
   10188:	00d70023          	sb	a3,0(a4)
   1018c:	0505                	addi	a0,a0,1
   1018e:	00054683          	lbu	a3,0(a0)
   10192:	f6f5                	bnez	a3,1017e <print_uart+0xa>
   10194:	8082                	ret

0000000000010196 <bin_to_hex>:
   10196:	00001797          	auipc	a5,0x1
   1019a:	b6a78793          	addi	a5,a5,-1174 # 10d00 <bin_to_hex_table>
   1019e:	00f57713          	andi	a4,a0,15
   101a2:	973e                	add	a4,a4,a5
   101a4:	00074703          	lbu	a4,0(a4)
   101a8:	8111                	srli	a0,a0,0x4
   101aa:	97aa                	add	a5,a5,a0
   101ac:	00e580a3          	sb	a4,1(a1)
   101b0:	0007c783          	lbu	a5,0(a5)
   101b4:	00f58023          	sb	a5,0(a1)
   101b8:	8082                	ret

00000000000101ba <print_uart_int>:
   101ba:	00001597          	auipc	a1,0x1
   101be:	46e1                	li	a3,24
   101c0:	b4658593          	addi	a1,a1,-1210 # 10d00 <bin_to_hex_table>
   101c4:	10000737          	lui	a4,0x10000
   101c8:	58e1                	li	a7,-8
   101ca:	00d557bb          	srlw	a5,a0,a3
   101ce:	0ff7f793          	andi	a5,a5,255
   101d2:	00f7f613          	andi	a2,a5,15
   101d6:	8391                	srli	a5,a5,0x4
   101d8:	962e                	add	a2,a2,a1
   101da:	97ae                	add	a5,a5,a1
   101dc:	00064603          	lbu	a2,0(a2)
   101e0:	0007c803          	lbu	a6,0(a5)
   101e4:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee21c>
   101e8:	0207f793          	andi	a5,a5,32
   101ec:	dfe5                	beqz	a5,101e4 <print_uart_int+0x2a>
   101ee:	01070023          	sb	a6,0(a4)
   101f2:	01474783          	lbu	a5,20(a4)
   101f6:	0207f793          	andi	a5,a5,32
   101fa:	dfe5                	beqz	a5,101f2 <print_uart_int+0x38>
   101fc:	00c70023          	sb	a2,0(a4)
   10200:	36e1                	addiw	a3,a3,-8
   10202:	fd1694e3          	bne	a3,a7,101ca <print_uart_int+0x10>
   10206:	8082                	ret

0000000000010208 <print_uart_addr>:
   10208:	00001597          	auipc	a1,0x1
   1020c:	03800693          	li	a3,56
   10210:	af858593          	addi	a1,a1,-1288 # 10d00 <bin_to_hex_table>
   10214:	10000737          	lui	a4,0x10000
   10218:	58e1                	li	a7,-8
   1021a:	00d557b3          	srl	a5,a0,a3
   1021e:	0ff7f793          	andi	a5,a5,255
   10222:	00f7f613          	andi	a2,a5,15
   10226:	8391                	srli	a5,a5,0x4
   10228:	962e                	add	a2,a2,a1
   1022a:	97ae                	add	a5,a5,a1
   1022c:	00064603          	lbu	a2,0(a2)
   10230:	0007c803          	lbu	a6,0(a5)
   10234:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee21c>
   10238:	0207f793          	andi	a5,a5,32
   1023c:	dfe5                	beqz	a5,10234 <print_uart_addr+0x2c>
   1023e:	01070023          	sb	a6,0(a4)
   10242:	01474783          	lbu	a5,20(a4)
   10246:	0207f793          	andi	a5,a5,32
   1024a:	dfe5                	beqz	a5,10242 <print_uart_addr+0x3a>
   1024c:	00c70023          	sb	a2,0(a4)
   10250:	36e1                	addiw	a3,a3,-8
   10252:	fd1694e3          	bne	a3,a7,1021a <print_uart_addr+0x12>
   10256:	8082                	ret

0000000000010258 <print_uart_byte>:
   10258:	00001797          	auipc	a5,0x1
   1025c:	aa878793          	addi	a5,a5,-1368 # 10d00 <bin_to_hex_table>
   10260:	00f57713          	andi	a4,a0,15
   10264:	8111                	srli	a0,a0,0x4
   10266:	973e                	add	a4,a4,a5
   10268:	97aa                	add	a5,a5,a0
   1026a:	0007c603          	lbu	a2,0(a5)
   1026e:	00074683          	lbu	a3,0(a4)
   10272:	10000737          	lui	a4,0x10000
   10276:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee21c>
   1027a:	0207f793          	andi	a5,a5,32
   1027e:	dfe5                	beqz	a5,10276 <print_uart_byte+0x1e>
   10280:	00c70023          	sb	a2,0(a4)
   10284:	10000737          	lui	a4,0x10000
   10288:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee21c>
   1028c:	0207f793          	andi	a5,a5,32
   10290:	dfe5                	beqz	a5,10288 <print_uart_byte+0x30>
   10292:	00d70023          	sb	a3,0(a4)
   10296:	8082                	ret

0000000000010298 <write_reg>:
   10298:	c10c                	sw	a1,0(a0)
   1029a:	8082                	ret

000000000001029c <read_reg>:
   1029c:	4108                	lw	a0,0(a0)
   1029e:	2501                	sext.w	a0,a0
   102a0:	8082                	ret

00000000000102a2 <spi_init>:
   102a2:	00002517          	auipc	a0,0x2
   102a6:	1101                	addi	sp,sp,-32
   102a8:	86650513          	addi	a0,a0,-1946 # 11b08 <_RODATA_START_+0xc08>
   102ac:	ec06                	sd	ra,24(sp)
   102ae:	e822                	sd	s0,16(sp)
   102b0:	e426                	sd	s1,8(sp)
   102b2:	ec3ff0ef          	jal	ra,10174 <print_uart>
   102b6:	200007b7          	lui	a5,0x20000
   102ba:	4729                	li	a4,10
   102bc:	c3b8                	sw	a4,64(a5)
   102be:	47a9                	li	a5,10
   102c0:	0001                	nop
   102c2:	37fd                	addiw	a5,a5,-1
   102c4:	fff5                	bnez	a5,102c0 <spi_init+0x1e>
   102c6:	20000437          	lui	s0,0x20000
   102ca:	10400793          	li	a5,260
   102ce:	d03c                	sw	a5,96(s0)
   102d0:	5064                	lw	s1,100(s0)
   102d2:	00002517          	auipc	a0,0x2
   102d6:	84650513          	addi	a0,a0,-1978 # 11b18 <_RODATA_START_+0xc18>
   102da:	e9bff0ef          	jal	ra,10174 <print_uart>
   102de:	2481                	sext.w	s1,s1
   102e0:	02049513          	slli	a0,s1,0x20
   102e4:	9101                	srli	a0,a0,0x20
   102e6:	f23ff0ef          	jal	ra,10208 <print_uart_addr>
   102ea:	00002517          	auipc	a0,0x2
   102ee:	84e50513          	addi	a0,a0,-1970 # 11b38 <_RODATA_START_+0xc38>
   102f2:	e83ff0ef          	jal	ra,10174 <print_uart>
   102f6:	16600793          	li	a5,358
   102fa:	d03c                	sw	a5,96(s0)
   102fc:	5064                	lw	s1,100(s0)
   102fe:	00002517          	auipc	a0,0x2
   10302:	81a50513          	addi	a0,a0,-2022 # 11b18 <_RODATA_START_+0xc18>
   10306:	e6fff0ef          	jal	ra,10174 <print_uart>
   1030a:	2481                	sext.w	s1,s1
   1030c:	02049513          	slli	a0,s1,0x20
   10310:	9101                	srli	a0,a0,0x20
   10312:	ef7ff0ef          	jal	ra,10208 <print_uart_addr>
   10316:	00002517          	auipc	a0,0x2
   1031a:	82250513          	addi	a0,a0,-2014 # 11b38 <_RODATA_START_+0xc38>
   1031e:	e57ff0ef          	jal	ra,10174 <print_uart>
   10322:	4799                	li	a5,6
   10324:	d03c                	sw	a5,96(s0)
   10326:	6442                	ld	s0,16(sp)
   10328:	60e2                	ld	ra,24(sp)
   1032a:	64a2                	ld	s1,8(sp)
   1032c:	00001517          	auipc	a0,0x1
   10330:	7fc50513          	addi	a0,a0,2044 # 11b28 <_RODATA_START_+0xc28>
   10334:	6105                	addi	sp,sp,32
   10336:	bd3d                	j	10174 <print_uart>

0000000000010338 <spi_txrx>:
   10338:	1101                	addi	sp,sp,-32
   1033a:	200007b7          	lui	a5,0x20000
   1033e:	ec06                	sd	ra,24(sp)
   10340:	e822                	sd	s0,16(sp)
   10342:	e426                	sd	s1,8(sp)
   10344:	5779                	li	a4,-2
   10346:	dbb8                	sw	a4,112(a5)
   10348:	d7a8                	sw	a0,104(a5)
   1034a:	06400793          	li	a5,100
   1034e:	0001                	nop
   10350:	37fd                	addiw	a5,a5,-1
   10352:	fff5                	bnez	a5,1034e <spi_txrx+0x16>
   10354:	10600713          	li	a4,262
   10358:	200007b7          	lui	a5,0x20000
   1035c:	d3b8                	sw	a4,96(a5)
   1035e:	20000737          	lui	a4,0x20000
   10362:	537c                	lw	a5,100(a4)
   10364:	06470413          	addi	s0,a4,100 # 20000064 <_RODATA_END_+0x1ffee26c>
   10368:	8b85                	andi	a5,a5,1
   1036a:	ffe5                	bnez	a5,10362 <spi_txrx+0x2a>
   1036c:	5764                	lw	s1,108(a4)
   1036e:	537c                	lw	a5,100(a4)
   10370:	2481                	sext.w	s1,s1
   10372:	8b85                	andi	a5,a5,1
   10374:	cf91                	beqz	a5,10390 <spi_txrx+0x58>
   10376:	200007b7          	lui	a5,0x20000
   1037a:	577d                	li	a4,-1
   1037c:	60e2                	ld	ra,24(sp)
   1037e:	6442                	ld	s0,16(sp)
   10380:	dbb8                	sw	a4,112(a5)
   10382:	4719                	li	a4,6
   10384:	d3b8                	sw	a4,96(a5)
   10386:	0ff4f513          	andi	a0,s1,255
   1038a:	64a2                	ld	s1,8(sp)
   1038c:	6105                	addi	sp,sp,32
   1038e:	8082                	ret
   10390:	00001517          	auipc	a0,0x1
   10394:	7b050513          	addi	a0,a0,1968 # 11b40 <_RODATA_START_+0xc40>
   10398:	dddff0ef          	jal	ra,10174 <print_uart>
   1039c:	4008                	lw	a0,0(s0)
   1039e:	1502                	slli	a0,a0,0x20
   103a0:	9101                	srli	a0,a0,0x20
   103a2:	e67ff0ef          	jal	ra,10208 <print_uart_addr>
   103a6:	00001517          	auipc	a0,0x1
   103aa:	79250513          	addi	a0,a0,1938 # 11b38 <_RODATA_START_+0xc38>
   103ae:	dc7ff0ef          	jal	ra,10174 <print_uart>
   103b2:	b7d1                	j	10376 <spi_txrx+0x3e>

00000000000103b4 <spi_write_bytes>:
   103b4:	10000793          	li	a5,256
   103b8:	08b7e063          	bltu	a5,a1,10438 <spi_write_bytes+0x84>
   103bc:	200007b7          	lui	a5,0x20000
   103c0:	5779                	li	a4,-2
   103c2:	dbb8                	sw	a4,112(a5)
   103c4:	c185                	beqz	a1,103e4 <spi_write_bytes+0x30>
   103c6:	fff5871b          	addiw	a4,a1,-1
   103ca:	1702                	slli	a4,a4,0x20
   103cc:	00150793          	addi	a5,a0,1
   103d0:	9301                	srli	a4,a4,0x20
   103d2:	973e                	add	a4,a4,a5
   103d4:	200006b7          	lui	a3,0x20000
   103d8:	00054783          	lbu	a5,0(a0)
   103dc:	0505                	addi	a0,a0,1
   103de:	d6bc                	sw	a5,104(a3)
   103e0:	fee51ce3          	bne	a0,a4,103d8 <spi_write_bytes+0x24>
   103e4:	03200793          	li	a5,50
   103e8:	0001                	nop
   103ea:	37fd                	addiw	a5,a5,-1
   103ec:	fff5                	bnez	a5,103e8 <spi_write_bytes+0x34>
   103ee:	10600713          	li	a4,262
   103f2:	200007b7          	lui	a5,0x20000
   103f6:	d3b8                	sw	a4,96(a5)
   103f8:	20000737          	lui	a4,0x20000
   103fc:	537c                	lw	a5,100(a4)
   103fe:	8b85                	andi	a5,a5,1
   10400:	fff5                	bnez	a5,103fc <spi_write_bytes+0x48>
   10402:	02059713          	slli	a4,a1,0x20
   10406:	9301                	srli	a4,a4,0x20
   10408:	9732                	add	a4,a4,a2
   1040a:	200006b7          	lui	a3,0x20000
   1040e:	200005b7          	lui	a1,0x20000
   10412:	00e60b63          	beq	a2,a4,10428 <spi_write_bytes+0x74>
   10416:	52fc                	lw	a5,100(a3)
   10418:	8b85                	andi	a5,a5,1
   1041a:	ffe5                	bnez	a5,10412 <spi_write_bytes+0x5e>
   1041c:	55fc                	lw	a5,108(a1)
   1041e:	0605                	addi	a2,a2,1
   10420:	fef60fa3          	sb	a5,-1(a2)
   10424:	fee619e3          	bne	a2,a4,10416 <spi_write_bytes+0x62>
   10428:	200007b7          	lui	a5,0x20000
   1042c:	577d                	li	a4,-1
   1042e:	dbb8                	sw	a4,112(a5)
   10430:	4719                	li	a4,6
   10432:	d3b8                	sw	a4,96(a5)
   10434:	4501                	li	a0,0
   10436:	8082                	ret
   10438:	557d                	li	a0,-1
   1043a:	8082                	ret

000000000001043c <sd_dummy>:
   1043c:	0ff00513          	li	a0,255
   10440:	bde5                	j	10338 <spi_txrx>

0000000000010442 <sd_cmd>:
   10442:	1101                	addi	sp,sp,-32
   10444:	e04a                	sd	s2,0(sp)
   10446:	892a                	mv	s2,a0
   10448:	0ff00513          	li	a0,255
   1044c:	ec06                	sd	ra,24(sp)
   1044e:	e822                	sd	s0,16(sp)
   10450:	e426                	sd	s1,8(sp)
   10452:	842e                	mv	s0,a1
   10454:	84b2                	mv	s1,a2
   10456:	ee3ff0ef          	jal	ra,10338 <spi_txrx>
   1045a:	04096513          	ori	a0,s2,64
   1045e:	edbff0ef          	jal	ra,10338 <spi_txrx>
   10462:	0184551b          	srliw	a0,s0,0x18
   10466:	ed3ff0ef          	jal	ra,10338 <spi_txrx>
   1046a:	0104551b          	srliw	a0,s0,0x10
   1046e:	0ff57513          	andi	a0,a0,255
   10472:	ec7ff0ef          	jal	ra,10338 <spi_txrx>
   10476:	0084551b          	srliw	a0,s0,0x8
   1047a:	0ff57513          	andi	a0,a0,255
   1047e:	ebbff0ef          	jal	ra,10338 <spi_txrx>
   10482:	0ff47513          	andi	a0,s0,255
   10486:	eb3ff0ef          	jal	ra,10338 <spi_txrx>
   1048a:	8526                	mv	a0,s1
   1048c:	eadff0ef          	jal	ra,10338 <spi_txrx>
   10490:	06400413          	li	s0,100
   10494:	a011                	j	10498 <sd_cmd+0x56>
   10496:	cc01                	beqz	s0,104ae <sd_cmd+0x6c>
   10498:	0ff00513          	li	a0,255
   1049c:	e9dff0ef          	jal	ra,10338 <spi_txrx>
   104a0:	0185179b          	slliw	a5,a0,0x18
   104a4:	4187d79b          	sraiw	a5,a5,0x18
   104a8:	147d                	addi	s0,s0,-1
   104aa:	fe07c6e3          	bltz	a5,10496 <sd_cmd+0x54>
   104ae:	60e2                	ld	ra,24(sp)
   104b0:	6442                	ld	s0,16(sp)
   104b2:	64a2                	ld	s1,8(sp)
   104b4:	6902                	ld	s2,0(sp)
   104b6:	6105                	addi	sp,sp,32
   104b8:	8082                	ret

00000000000104ba <print_status>:
   104ba:	1101                	addi	sp,sp,-32
   104bc:	e426                	sd	s1,8(sp)
   104be:	84aa                	mv	s1,a0
   104c0:	00001517          	auipc	a0,0x1
   104c4:	69850513          	addi	a0,a0,1688 # 11b58 <_RODATA_START_+0xc58>
   104c8:	ec06                	sd	ra,24(sp)
   104ca:	e822                	sd	s0,16(sp)
   104cc:	842e                	mv	s0,a1
   104ce:	ca7ff0ef          	jal	ra,10174 <print_uart>
   104d2:	8526                	mv	a0,s1
   104d4:	ca1ff0ef          	jal	ra,10174 <print_uart>
   104d8:	00001517          	auipc	a0,0x1
   104dc:	69050513          	addi	a0,a0,1680 # 11b68 <_RODATA_START_+0xc68>
   104e0:	c95ff0ef          	jal	ra,10174 <print_uart>
   104e4:	8522                	mv	a0,s0
   104e6:	d73ff0ef          	jal	ra,10258 <print_uart_byte>
   104ea:	6442                	ld	s0,16(sp)
   104ec:	60e2                	ld	ra,24(sp)
   104ee:	64a2                	ld	s1,8(sp)
   104f0:	00001517          	auipc	a0,0x1
   104f4:	64850513          	addi	a0,a0,1608 # 11b38 <_RODATA_START_+0xc38>
   104f8:	6105                	addi	sp,sp,32
   104fa:	b9ad                	j	10174 <print_uart>

00000000000104fc <sd_cmd0>:
   104fc:	1101                	addi	sp,sp,-32
   104fe:	09500613          	li	a2,149
   10502:	4581                	li	a1,0
   10504:	4501                	li	a0,0
   10506:	ec06                	sd	ra,24(sp)
   10508:	e822                	sd	s0,16(sp)
   1050a:	e426                	sd	s1,8(sp)
   1050c:	e04a                	sd	s2,0(sp)
   1050e:	f35ff0ef          	jal	ra,10442 <sd_cmd>
   10512:	84aa                	mv	s1,a0
   10514:	6409                	lui	s0,0x2
   10516:	0ff00513          	li	a0,255
   1051a:	e1fff0ef          	jal	ra,10338 <spi_txrx>
   1051e:	70f40413          	addi	s0,s0,1807 # 270f <ROM_BASE-0xd8f1>
   10522:	4905                	li	s2,1
   10524:	a809                	j	10536 <sd_cmd0+0x3a>
   10526:	f1dff0ef          	jal	ra,10442 <sd_cmd>
   1052a:	84aa                	mv	s1,a0
   1052c:	0ff00513          	li	a0,255
   10530:	e09ff0ef          	jal	ra,10338 <spi_txrx>
   10534:	c415                	beqz	s0,10560 <sd_cmd0+0x64>
   10536:	09500613          	li	a2,149
   1053a:	4581                	li	a1,0
   1053c:	4501                	li	a0,0
   1053e:	347d                	addiw	s0,s0,-1
   10540:	ff2493e3          	bne	s1,s2,10526 <sd_cmd0+0x2a>
   10544:	00001517          	auipc	a0,0x1
   10548:	63450513          	addi	a0,a0,1588 # 11b78 <_RODATA_START_+0xc78>
   1054c:	4585                	li	a1,1
   1054e:	f6dff0ef          	jal	ra,104ba <print_status>
   10552:	60e2                	ld	ra,24(sp)
   10554:	6442                	ld	s0,16(sp)
   10556:	64a2                	ld	s1,8(sp)
   10558:	6902                	ld	s2,0(sp)
   1055a:	4505                	li	a0,1
   1055c:	6105                	addi	sp,sp,32
   1055e:	8082                	ret
   10560:	60e2                	ld	ra,24(sp)
   10562:	6442                	ld	s0,16(sp)
   10564:	64a2                	ld	s1,8(sp)
   10566:	6902                	ld	s2,0(sp)
   10568:	4501                	li	a0,0
   1056a:	6105                	addi	sp,sp,32
   1056c:	8082                	ret

000000000001056e <sd_cmd8>:
   1056e:	1101                	addi	sp,sp,-32
   10570:	08700613          	li	a2,135
   10574:	1aa00593          	li	a1,426
   10578:	4521                	li	a0,8
   1057a:	ec06                	sd	ra,24(sp)
   1057c:	e822                	sd	s0,16(sp)
   1057e:	e426                	sd	s1,8(sp)
   10580:	e04a                	sd	s2,0(sp)
   10582:	ec1ff0ef          	jal	ra,10442 <sd_cmd>
   10586:	842a                	mv	s0,a0
   10588:	0ff00513          	li	a0,255
   1058c:	dadff0ef          	jal	ra,10338 <spi_txrx>
   10590:	0ff00513          	li	a0,255
   10594:	da5ff0ef          	jal	ra,10338 <spi_txrx>
   10598:	0ff00513          	li	a0,255
   1059c:	d9dff0ef          	jal	ra,10338 <spi_txrx>
   105a0:	84aa                	mv	s1,a0
   105a2:	0ff00513          	li	a0,255
   105a6:	d93ff0ef          	jal	ra,10338 <spi_txrx>
   105aa:	892a                	mv	s2,a0
   105ac:	0ff00513          	li	a0,255
   105b0:	d89ff0ef          	jal	ra,10338 <spi_txrx>
   105b4:	0ff00513          	li	a0,255
   105b8:	d81ff0ef          	jal	ra,10338 <spi_txrx>
   105bc:	4785                	li	a5,1
   105be:	4501                	li	a0,0
   105c0:	00f40863          	beq	s0,a5,105d0 <sd_cmd8+0x62>
   105c4:	60e2                	ld	ra,24(sp)
   105c6:	6442                	ld	s0,16(sp)
   105c8:	64a2                	ld	s1,8(sp)
   105ca:	6902                	ld	s2,0(sp)
   105cc:	6105                	addi	sp,sp,32
   105ce:	8082                	ret
   105d0:	88bd                	andi	s1,s1,15
   105d2:	fe8499e3          	bne	s1,s0,105c4 <sd_cmd8+0x56>
   105d6:	60e2                	ld	ra,24(sp)
   105d8:	6442                	ld	s0,16(sp)
   105da:	0009051b          	sext.w	a0,s2
   105de:	f5650513          	addi	a0,a0,-170
   105e2:	64a2                	ld	s1,8(sp)
   105e4:	6902                	ld	s2,0(sp)
   105e6:	00153513          	seqz	a0,a0
   105ea:	6105                	addi	sp,sp,32
   105ec:	8082                	ret

00000000000105ee <sd_cmd55>:
   105ee:	1141                	addi	sp,sp,-16
   105f0:	06500613          	li	a2,101
   105f4:	4581                	li	a1,0
   105f6:	03700513          	li	a0,55
   105fa:	e406                	sd	ra,8(sp)
   105fc:	e022                	sd	s0,0(sp)
   105fe:	e45ff0ef          	jal	ra,10442 <sd_cmd>
   10602:	842a                	mv	s0,a0
   10604:	0ff00513          	li	a0,255
   10608:	d31ff0ef          	jal	ra,10338 <spi_txrx>
   1060c:	00001517          	auipc	a0,0x1
   10610:	85a2                	mv	a1,s0
   10612:	57450513          	addi	a0,a0,1396 # 11b80 <_RODATA_START_+0xc80>
   10616:	ea5ff0ef          	jal	ra,104ba <print_status>
   1061a:	0004051b          	sext.w	a0,s0
   1061e:	60a2                	ld	ra,8(sp)
   10620:	6402                	ld	s0,0(sp)
   10622:	157d                	addi	a0,a0,-1
   10624:	00153513          	seqz	a0,a0
   10628:	0141                	addi	sp,sp,16
   1062a:	8082                	ret

000000000001062c <sd_acmd41>:
   1062c:	1101                	addi	sp,sp,-32
   1062e:	e426                	sd	s1,8(sp)
   10630:	ec06                	sd	ra,24(sp)
   10632:	e822                	sd	s0,16(sp)
   10634:	4485                	li	s1,1
   10636:	fb9ff0ef          	jal	ra,105ee <sd_cmd55>
   1063a:	07700613          	li	a2,119
   1063e:	400005b7          	lui	a1,0x40000
   10642:	02900513          	li	a0,41
   10646:	dfdff0ef          	jal	ra,10442 <sd_cmd>
   1064a:	842a                	mv	s0,a0
   1064c:	85aa                	mv	a1,a0
   1064e:	00001517          	auipc	a0,0x1
   10652:	53a50513          	addi	a0,a0,1338 # 11b88 <_RODATA_START_+0xc88>
   10656:	e65ff0ef          	jal	ra,104ba <print_status>
   1065a:	0ff00513          	li	a0,255
   1065e:	cdbff0ef          	jal	ra,10338 <spi_txrx>
   10662:	fc940ae3          	beq	s0,s1,10636 <sd_acmd41+0xa>
   10666:	0004051b          	sext.w	a0,s0
   1066a:	60e2                	ld	ra,24(sp)
   1066c:	6442                	ld	s0,16(sp)
   1066e:	64a2                	ld	s1,8(sp)
   10670:	00153513          	seqz	a0,a0
   10674:	6105                	addi	sp,sp,32
   10676:	8082                	ret

0000000000010678 <init_sd>:
   10678:	1141                	addi	sp,sp,-16
   1067a:	e406                	sd	ra,8(sp)
   1067c:	e022                	sd	s0,0(sp)
   1067e:	c25ff0ef          	jal	ra,102a2 <spi_init>
   10682:	00001517          	auipc	a0,0x1
   10686:	50e50513          	addi	a0,a0,1294 # 11b90 <_RODATA_START_+0xc90>
   1068a:	aebff0ef          	jal	ra,10174 <print_uart>
   1068e:	4429                	li	s0,10
   10690:	347d                	addiw	s0,s0,-1
   10692:	0ff00513          	li	a0,255
   10696:	ca3ff0ef          	jal	ra,10338 <spi_txrx>
   1069a:	f87d                	bnez	s0,10690 <init_sd+0x18>
   1069c:	e61ff0ef          	jal	ra,104fc <sd_cmd0>
   106a0:	cd09                	beqz	a0,106ba <init_sd+0x42>
   106a2:	ecdff0ef          	jal	ra,1056e <sd_cmd8>
   106a6:	cd01                	beqz	a0,106be <init_sd+0x46>
   106a8:	f85ff0ef          	jal	ra,1062c <sd_acmd41>
   106ac:	4781                	li	a5,0
   106ae:	c911                	beqz	a0,106c2 <init_sd+0x4a>
   106b0:	60a2                	ld	ra,8(sp)
   106b2:	6402                	ld	s0,0(sp)
   106b4:	853e                	mv	a0,a5
   106b6:	0141                	addi	sp,sp,16
   106b8:	8082                	ret
   106ba:	57fd                	li	a5,-1
   106bc:	bfd5                	j	106b0 <init_sd+0x38>
   106be:	57f9                	li	a5,-2
   106c0:	bfc5                	j	106b0 <init_sd+0x38>
   106c2:	57f5                	li	a5,-3
   106c4:	b7f5                	j	106b0 <init_sd+0x38>

00000000000106c6 <crc7>:
   106c6:	8de9                	and	a1,a1,a0
   106c8:	0075d79b          	srliw	a5,a1,0x7
   106cc:	0045d51b          	srliw	a0,a1,0x4
   106d0:	8d3d                	xor	a0,a0,a5
   106d2:	8d2d                	xor	a0,a0,a1
   106d4:	00451593          	slli	a1,a0,0x4
   106d8:	8d2d                	xor	a0,a0,a1
   106da:	07f57513          	andi	a0,a0,127
   106de:	8082                	ret

00000000000106e0 <crc16>:
   106e0:	0085579b          	srliw	a5,a0,0x8
   106e4:	0522                	slli	a0,a0,0x8
   106e6:	8d5d                	or	a0,a0,a5
   106e8:	1542                	slli	a0,a0,0x30
   106ea:	9141                	srli	a0,a0,0x30
   106ec:	8da9                	xor	a1,a1,a0
   106ee:	0045d51b          	srliw	a0,a1,0x4
   106f2:	893d                	andi	a0,a0,15
   106f4:	8da9                	xor	a1,a1,a0
   106f6:	00c59513          	slli	a0,a1,0xc
   106fa:	8d2d                	xor	a0,a0,a1
   106fc:	0105151b          	slliw	a0,a0,0x10
   10700:	4105551b          	sraiw	a0,a0,0x10
   10704:	0105179b          	slliw	a5,a0,0x10
   10708:	0107d79b          	srliw	a5,a5,0x10
   1070c:	6709                	lui	a4,0x2
   1070e:	1701                	addi	a4,a4,-32
   10710:	0057979b          	slliw	a5,a5,0x5
   10714:	8ff9                	and	a5,a5,a4
   10716:	8d3d                	xor	a0,a0,a5
   10718:	1542                	slli	a0,a0,0x30
   1071a:	9141                	srli	a0,a0,0x30
   1071c:	8082                	ret

000000000001071e <sd_copy>:
   1071e:	7155                	addi	sp,sp,-208
   10720:	f94a                	sd	s2,176(sp)
   10722:	02061913          	slli	s2,a2,0x20
   10726:	e1a2                	sd	s0,192(sp)
   10728:	e586                	sd	ra,200(sp)
   1072a:	fd26                	sd	s1,184(sp)
   1072c:	f54e                	sd	s3,168(sp)
   1072e:	f152                	sd	s4,160(sp)
   10730:	ed56                	sd	s5,152(sp)
   10732:	e95a                	sd	s6,144(sp)
   10734:	842a                	mv	s0,a0
   10736:	02095913          	srli	s2,s2,0x20
   1073a:	081c                	addi	a5,sp,16
   1073c:	0914                	addi	a3,sp,144
   1073e:	577d                	li	a4,-1
   10740:	00e78023          	sb	a4,0(a5) # 20000000 <_RODATA_END_+0x1ffee208>
   10744:	0785                	addi	a5,a5,1
   10746:	fed79de3          	bne	a5,a3,10740 <sd_copy+0x22>
   1074a:	4605                	li	a2,1
   1074c:	4549                	li	a0,18
   1074e:	cf5ff0ef          	jal	ra,10442 <sd_cmd>
   10752:	20040413          	addi	s0,s0,512
   10756:	10051063          	bnez	a0,10856 <sd_copy+0x138>
   1075a:	6a89                	lui	s5,0x2
   1075c:	0fe00493          	li	s1,254
   10760:	1a81                	addi	s5,s5,-32
   10762:	3e800993          	li	s3,1000
   10766:	e0040b13          	addi	s6,s0,-512
   1076a:	0ff00513          	li	a0,255
   1076e:	bcbff0ef          	jal	ra,10338 <spi_txrx>
   10772:	fe951ce3          	bne	a0,s1,1076a <sd_copy+0x4c>
   10776:	e4040a13          	addi	s4,s0,-448
   1077a:	4781                	li	a5,0
   1077c:	865a                	mv	a2,s6
   1077e:	04000593          	li	a1,64
   10782:	0808                	addi	a0,sp,16
   10784:	e43e                	sd	a5,8(sp)
   10786:	c2fff0ef          	jal	ra,103b4 <spi_write_bytes>
   1078a:	67a2                	ld	a5,8(sp)
   1078c:	86da                	mv	a3,s6
   1078e:	0006c703          	lbu	a4,0(a3) # 20000000 <_RODATA_END_+0x1ffee208>
   10792:	0087d61b          	srliw	a2,a5,0x8
   10796:	07a2                	slli	a5,a5,0x8
   10798:	8fd1                	or	a5,a5,a2
   1079a:	8fb9                	xor	a5,a5,a4
   1079c:	03079713          	slli	a4,a5,0x30
   107a0:	9341                	srli	a4,a4,0x30
   107a2:	0047579b          	srliw	a5,a4,0x4
   107a6:	8bbd                	andi	a5,a5,15
   107a8:	8fb9                	xor	a5,a5,a4
   107aa:	00c79713          	slli	a4,a5,0xc
   107ae:	8fb9                	xor	a5,a5,a4
   107b0:	0107979b          	slliw	a5,a5,0x10
   107b4:	4107d79b          	sraiw	a5,a5,0x10
   107b8:	0107971b          	slliw	a4,a5,0x10
   107bc:	0107571b          	srliw	a4,a4,0x10
   107c0:	0057171b          	slliw	a4,a4,0x5
   107c4:	01577733          	and	a4,a4,s5
   107c8:	8fb9                	xor	a5,a5,a4
   107ca:	17c2                	slli	a5,a5,0x30
   107cc:	0685                	addi	a3,a3,1
   107ce:	93c1                	srli	a5,a5,0x30
   107d0:	fb469fe3          	bne	a3,s4,1078e <sd_copy+0x70>
   107d4:	040b0b13          	addi	s6,s6,64
   107d8:	04068a13          	addi	s4,a3,64
   107dc:	fa8b10e3          	bne	s6,s0,1077c <sd_copy+0x5e>
   107e0:	0ff00513          	li	a0,255
   107e4:	e43e                	sd	a5,8(sp)
   107e6:	b53ff0ef          	jal	ra,10338 <spi_txrx>
   107ea:	00851a1b          	slliw	s4,a0,0x8
   107ee:	1a42                	slli	s4,s4,0x30
   107f0:	0ff00513          	li	a0,255
   107f4:	b45ff0ef          	jal	ra,10338 <spi_txrx>
   107f8:	030a5a13          	srli	s4,s4,0x30
   107fc:	00aa6733          	or	a4,s4,a0
   10800:	67a2                	ld	a5,8(sp)
   10802:	1742                	slli	a4,a4,0x30
   10804:	9341                	srli	a4,a4,0x30
   10806:	02f71363          	bne	a4,a5,1082c <sd_copy+0x10e>
   1080a:	033967b3          	rem	a5,s2,s3
   1080e:	cb81                	beqz	a5,1081e <sd_copy+0x100>
   10810:	197d                	addi	s2,s2,-1
   10812:	20040413          	addi	s0,s0,512
   10816:	f52048e3          	bgtz	s2,10766 <sd_copy+0x48>
   1081a:	4401                	li	s0,0
   1081c:	a809                	j	1082e <sd_copy+0x110>
   1081e:	00001517          	auipc	a0,0x1
   10822:	3aa50513          	addi	a0,a0,938 # 11bc8 <_RODATA_START_+0xcc8>
   10826:	94fff0ef          	jal	ra,10174 <print_uart>
   1082a:	b7dd                	j	10810 <sd_copy+0xf2>
   1082c:	5479                	li	s0,-2
   1082e:	4605                	li	a2,1
   10830:	4581                	li	a1,0
   10832:	4531                	li	a0,12
   10834:	c0fff0ef          	jal	ra,10442 <sd_cmd>
   10838:	0ff00513          	li	a0,255
   1083c:	afdff0ef          	jal	ra,10338 <spi_txrx>
   10840:	8522                	mv	a0,s0
   10842:	60ae                	ld	ra,200(sp)
   10844:	640e                	ld	s0,192(sp)
   10846:	74ea                	ld	s1,184(sp)
   10848:	794a                	ld	s2,176(sp)
   1084a:	79aa                	ld	s3,168(sp)
   1084c:	7a0a                	ld	s4,160(sp)
   1084e:	6aea                	ld	s5,152(sp)
   10850:	6b4a                	ld	s6,144(sp)
   10852:	6169                	addi	sp,sp,208
   10854:	8082                	ret
   10856:	4421                	li	s0,8
   10858:	347d                	addiw	s0,s0,-1
   1085a:	0ff00513          	li	a0,255
   1085e:	adbff0ef          	jal	ra,10338 <spi_txrx>
   10862:	f87d                	bnez	s0,10858 <sd_copy+0x13a>
   10864:	00001517          	auipc	a0,0x1
   10868:	34450513          	addi	a0,a0,836 # 11ba8 <_RODATA_START_+0xca8>
   1086c:	909ff0ef          	jal	ra,10174 <print_uart>
   10870:	547d                	li	s0,-1
   10872:	b7f9                	j	10840 <sd_copy+0x122>

0000000000010874 <gpt_find_boot_partition>:
   10874:	715d                	addi	sp,sp,-80
   10876:	e0a2                	sd	s0,64(sp)
   10878:	e45e                	sd	s7,8(sp)
   1087a:	e486                	sd	ra,72(sp)
   1087c:	fc26                	sd	s1,56(sp)
   1087e:	f84a                	sd	s2,48(sp)
   10880:	f44e                	sd	s3,40(sp)
   10882:	f052                	sd	s4,32(sp)
   10884:	ec56                	sd	s5,24(sp)
   10886:	e85a                	sd	s6,16(sp)
   10888:	e062                	sd	s8,0(sp)
   1088a:	0880                	addi	s0,sp,80
   1088c:	8baa                	mv	s7,a0
   1088e:	debff0ef          	jal	ra,10678 <init_sd>
   10892:	22051363          	bnez	a0,10ab8 <gpt_find_boot_partition+0x244>
   10896:	00001517          	auipc	a0,0x1
   1089a:	36250513          	addi	a0,a0,866 # 11bf8 <_RODATA_START_+0xcf8>
   1089e:	8d7ff0ef          	jal	ra,10174 <print_uart>
   108a2:	7101                	addi	sp,sp,-512
   108a4:	4605                	li	a2,1
   108a6:	4585                	li	a1,1
   108a8:	850a                	mv	a0,sp
   108aa:	e75ff0ef          	jal	ra,1071e <sd_copy>
   108ae:	890a                	mv	s2,sp
   108b0:	84aa                	mv	s1,a0
   108b2:	26051963          	bnez	a0,10b24 <gpt_find_boot_partition+0x2b0>
   108b6:	00001517          	auipc	a0,0x1
   108ba:	38a50513          	addi	a0,a0,906 # 11c40 <_RODATA_START_+0xd40>
   108be:	8b7ff0ef          	jal	ra,10174 <print_uart>
   108c2:	00001517          	auipc	a0,0x1
   108c6:	39e50513          	addi	a0,a0,926 # 11c60 <_RODATA_START_+0xd60>
   108ca:	8abff0ef          	jal	ra,10174 <print_uart>
   108ce:	6502                	ld	a0,0(sp)
   108d0:	939ff0ef          	jal	ra,10208 <print_uart_addr>
   108d4:	00001517          	auipc	a0,0x1
   108d8:	39c50513          	addi	a0,a0,924 # 11c70 <_RODATA_START_+0xd70>
   108dc:	899ff0ef          	jal	ra,10174 <print_uart>
   108e0:	4522                	lw	a0,8(sp)
   108e2:	8d9ff0ef          	jal	ra,101ba <print_uart_int>
   108e6:	00001517          	auipc	a0,0x1
   108ea:	39a50513          	addi	a0,a0,922 # 11c80 <_RODATA_START_+0xd80>
   108ee:	887ff0ef          	jal	ra,10174 <print_uart>
   108f2:	4532                	lw	a0,12(sp)
   108f4:	8c7ff0ef          	jal	ra,101ba <print_uart_int>
   108f8:	00001517          	auipc	a0,0x1
   108fc:	39850513          	addi	a0,a0,920 # 11c90 <_RODATA_START_+0xd90>
   10900:	875ff0ef          	jal	ra,10174 <print_uart>
   10904:	4542                	lw	a0,16(sp)
   10906:	8b5ff0ef          	jal	ra,101ba <print_uart_int>
   1090a:	00001517          	auipc	a0,0x1
   1090e:	39650513          	addi	a0,a0,918 # 11ca0 <_RODATA_START_+0xda0>
   10912:	863ff0ef          	jal	ra,10174 <print_uart>
   10916:	4552                	lw	a0,20(sp)
   10918:	8a3ff0ef          	jal	ra,101ba <print_uart_int>
   1091c:	00001517          	auipc	a0,0x1
   10920:	39450513          	addi	a0,a0,916 # 11cb0 <_RODATA_START_+0xdb0>
   10924:	851ff0ef          	jal	ra,10174 <print_uart>
   10928:	6562                	ld	a0,24(sp)
   1092a:	8dfff0ef          	jal	ra,10208 <print_uart_addr>
   1092e:	00001517          	auipc	a0,0x1
   10932:	39a50513          	addi	a0,a0,922 # 11cc8 <_RODATA_START_+0xdc8>
   10936:	83fff0ef          	jal	ra,10174 <print_uart>
   1093a:	7502                	ld	a0,32(sp)
   1093c:	8cdff0ef          	jal	ra,10208 <print_uart_addr>
   10940:	00001517          	auipc	a0,0x1
   10944:	39850513          	addi	a0,a0,920 # 11cd8 <_RODATA_START_+0xdd8>
   10948:	82dff0ef          	jal	ra,10174 <print_uart>
   1094c:	6526                	ld	a0,72(sp)
   1094e:	8bbff0ef          	jal	ra,10208 <print_uart_addr>
   10952:	00001517          	auipc	a0,0x1
   10956:	3a650513          	addi	a0,a0,934 # 11cf8 <_RODATA_START_+0xdf8>
   1095a:	81bff0ef          	jal	ra,10174 <print_uart>
   1095e:	4546                	lw	a0,80(sp)
   10960:	85bff0ef          	jal	ra,101ba <print_uart_int>
   10964:	00001517          	auipc	a0,0x1
   10968:	3b450513          	addi	a0,a0,948 # 11d18 <_RODATA_START_+0xe18>
   1096c:	809ff0ef          	jal	ra,10174 <print_uart>
   10970:	4556                	lw	a0,84(sp)
   10972:	849ff0ef          	jal	ra,101ba <print_uart_int>
   10976:	00001517          	auipc	a0,0x1
   1097a:	1c250513          	addi	a0,a0,450 # 11b38 <_RODATA_START_+0xc38>
   1097e:	ff6ff0ef          	jal	ra,10174 <print_uart>
   10982:	04892583          	lw	a1,72(s2) # 2000048 <_RODATA_END_+0x1fee250>
   10986:	7101                	addi	sp,sp,-512
   10988:	4605                	li	a2,1
   1098a:	850a                	mv	a0,sp
   1098c:	d93ff0ef          	jal	ra,1071e <sd_copy>
   10990:	8c0a                	mv	s8,sp
   10992:	8aaa                	mv	s5,a0
   10994:	16051163          	bnez	a0,10af6 <gpt_find_boot_partition+0x282>
   10998:	08010913          	addi	s2,sp,128
   1099c:	02010993          	addi	s3,sp,32
   109a0:	01010a13          	addi	s4,sp,16
   109a4:	4b11                	li	s6,4
   109a6:	00001517          	auipc	a0,0x1
   109aa:	39250513          	addi	a0,a0,914 # 11d38 <_RODATA_START_+0xe38>
   109ae:	fc6ff0ef          	jal	ra,10174 <print_uart>
   109b2:	0ffaf513          	andi	a0,s5,255
   109b6:	8a3ff0ef          	jal	ra,10258 <print_uart_byte>
   109ba:	00001517          	auipc	a0,0x1
   109be:	39650513          	addi	a0,a0,918 # 11d50 <_RODATA_START_+0xe50>
   109c2:	fb2ff0ef          	jal	ra,10174 <print_uart>
   109c6:	f8090493          	addi	s1,s2,-128
   109ca:	0004c503          	lbu	a0,0(s1)
   109ce:	0485                	addi	s1,s1,1
   109d0:	889ff0ef          	jal	ra,10258 <print_uart_byte>
   109d4:	ff449be3          	bne	s1,s4,109ca <gpt_find_boot_partition+0x156>
   109d8:	00001517          	auipc	a0,0x1
   109dc:	39850513          	addi	a0,a0,920 # 11d70 <_RODATA_START_+0xe70>
   109e0:	f94ff0ef          	jal	ra,10174 <print_uart>
   109e4:	84d2                	mv	s1,s4
   109e6:	0004c503          	lbu	a0,0(s1)
   109ea:	0485                	addi	s1,s1,1
   109ec:	86dff0ef          	jal	ra,10258 <print_uart_byte>
   109f0:	ff349be3          	bne	s1,s3,109e6 <gpt_find_boot_partition+0x172>
   109f4:	00001517          	auipc	a0,0x1
   109f8:	39c50513          	addi	a0,a0,924 # 11d90 <_RODATA_START_+0xe90>
   109fc:	f78ff0ef          	jal	ra,10174 <print_uart>
   10a00:	0009b503          	ld	a0,0(s3)
   10a04:	fb890493          	addi	s1,s2,-72
   10a08:	801ff0ef          	jal	ra,10208 <print_uart_addr>
   10a0c:	00001517          	auipc	a0,0x1
   10a10:	39450513          	addi	a0,a0,916 # 11da0 <_RODATA_START_+0xea0>
   10a14:	f60ff0ef          	jal	ra,10174 <print_uart>
   10a18:	0089b503          	ld	a0,8(s3)
   10a1c:	fecff0ef          	jal	ra,10208 <print_uart_addr>
   10a20:	00001517          	auipc	a0,0x1
   10a24:	39050513          	addi	a0,a0,912 # 11db0 <_RODATA_START_+0xeb0>
   10a28:	f4cff0ef          	jal	ra,10174 <print_uart>
   10a2c:	0109b503          	ld	a0,16(s3)
   10a30:	fd8ff0ef          	jal	ra,10208 <print_uart_addr>
   10a34:	00001517          	auipc	a0,0x1
   10a38:	38c50513          	addi	a0,a0,908 # 11dc0 <_RODATA_START_+0xec0>
   10a3c:	f38ff0ef          	jal	ra,10174 <print_uart>
   10a40:	0004c503          	lbu	a0,0(s1)
   10a44:	0485                	addi	s1,s1,1
   10a46:	813ff0ef          	jal	ra,10258 <print_uart_byte>
   10a4a:	ff249be3          	bne	s1,s2,10a40 <gpt_find_boot_partition+0x1cc>
   10a4e:	00001517          	auipc	a0,0x1
   10a52:	0ea50513          	addi	a0,a0,234 # 11b38 <_RODATA_START_+0xc38>
   10a56:	2a85                	addiw	s5,s5,1
   10a58:	f1cff0ef          	jal	ra,10174 <print_uart>
   10a5c:	08048913          	addi	s2,s1,128
   10a60:	08098993          	addi	s3,s3,128
   10a64:	080a0a13          	addi	s4,s4,128
   10a68:	f36a9fe3          	bne	s5,s6,109a6 <gpt_find_boot_partition+0x132>
   10a6c:	00001517          	auipc	a0,0x1
   10a70:	36450513          	addi	a0,a0,868 # 11dd0 <_RODATA_START_+0xed0>
   10a74:	f00ff0ef          	jal	ra,10174 <print_uart>
   10a78:	028c3603          	ld	a2,40(s8)
   10a7c:	020c2583          	lw	a1,32(s8)
   10a80:	855e                	mv	a0,s7
   10a82:	2605                	addiw	a2,a2,1
   10a84:	9e0d                	subw	a2,a2,a1
   10a86:	c99ff0ef          	jal	ra,1071e <sd_copy>
   10a8a:	84aa                	mv	s1,a0
   10a8c:	ed15                	bnez	a0,10ac8 <gpt_find_boot_partition+0x254>
   10a8e:	00001517          	auipc	a0,0x1
   10a92:	35a50513          	addi	a0,a0,858 # 11de8 <_RODATA_START_+0xee8>
   10a96:	edeff0ef          	jal	ra,10174 <print_uart>
   10a9a:	fb040113          	addi	sp,s0,-80
   10a9e:	60a6                	ld	ra,72(sp)
   10aa0:	8526                	mv	a0,s1
   10aa2:	6406                	ld	s0,64(sp)
   10aa4:	74e2                	ld	s1,56(sp)
   10aa6:	7942                	ld	s2,48(sp)
   10aa8:	79a2                	ld	s3,40(sp)
   10aaa:	7a02                	ld	s4,32(sp)
   10aac:	6ae2                	ld	s5,24(sp)
   10aae:	6b42                	ld	s6,16(sp)
   10ab0:	6ba2                	ld	s7,8(sp)
   10ab2:	6c02                	ld	s8,0(sp)
   10ab4:	6161                	addi	sp,sp,80
   10ab6:	8082                	ret
   10ab8:	00001517          	auipc	a0,0x1
   10abc:	11850513          	addi	a0,a0,280 # 11bd0 <_RODATA_START_+0xcd0>
   10ac0:	eb4ff0ef          	jal	ra,10174 <print_uart>
   10ac4:	54fd                	li	s1,-1
   10ac6:	bfd1                	j	10a9a <gpt_find_boot_partition+0x226>
   10ac8:	00001517          	auipc	a0,0x1
   10acc:	14850513          	addi	a0,a0,328 # 11c10 <_RODATA_START_+0xd10>
   10ad0:	ea4ff0ef          	jal	ra,10174 <print_uart>
   10ad4:	00001517          	auipc	a0,0x1
   10ad8:	15450513          	addi	a0,a0,340 # 11c28 <_RODATA_START_+0xd28>
   10adc:	e98ff0ef          	jal	ra,10174 <print_uart>
   10ae0:	8526                	mv	a0,s1
   10ae2:	f26ff0ef          	jal	ra,10208 <print_uart_addr>
   10ae6:	00001517          	auipc	a0,0x1
   10aea:	05250513          	addi	a0,a0,82 # 11b38 <_RODATA_START_+0xc38>
   10aee:	e86ff0ef          	jal	ra,10174 <print_uart>
   10af2:	54f9                	li	s1,-2
   10af4:	b75d                	j	10a9a <gpt_find_boot_partition+0x226>
   10af6:	00001517          	auipc	a0,0x1
   10afa:	11a50513          	addi	a0,a0,282 # 11c10 <_RODATA_START_+0xd10>
   10afe:	e76ff0ef          	jal	ra,10174 <print_uart>
   10b02:	00001517          	auipc	a0,0x1
   10b06:	12650513          	addi	a0,a0,294 # 11c28 <_RODATA_START_+0xd28>
   10b0a:	e6aff0ef          	jal	ra,10174 <print_uart>
   10b0e:	8556                	mv	a0,s5
   10b10:	ef8ff0ef          	jal	ra,10208 <print_uart_addr>
   10b14:	00001517          	auipc	a0,0x1
   10b18:	02450513          	addi	a0,a0,36 # 11b38 <_RODATA_START_+0xc38>
   10b1c:	e58ff0ef          	jal	ra,10174 <print_uart>
   10b20:	54f9                	li	s1,-2
   10b22:	bfa5                	j	10a9a <gpt_find_boot_partition+0x226>
   10b24:	00001517          	auipc	a0,0x1
   10b28:	0ec50513          	addi	a0,a0,236 # 11c10 <_RODATA_START_+0xd10>
   10b2c:	e48ff0ef          	jal	ra,10174 <print_uart>
   10b30:	00001517          	auipc	a0,0x1
   10b34:	0f850513          	addi	a0,a0,248 # 11c28 <_RODATA_START_+0xd28>
   10b38:	e3cff0ef          	jal	ra,10174 <print_uart>
   10b3c:	8526                	mv	a0,s1
   10b3e:	ecaff0ef          	jal	ra,10208 <print_uart_addr>
   10b42:	00001517          	auipc	a0,0x1
   10b46:	ff650513          	addi	a0,a0,-10 # 11b38 <_RODATA_START_+0xc38>
   10b4a:	e2aff0ef          	jal	ra,10174 <print_uart>
   10b4e:	54f9                	li	s1,-2
   10b50:	b7a9                	j	10a9a <gpt_find_boot_partition+0x226>

0000000000010b52 <write_gpio>:
   10b52:	00b50023          	sb	a1,0(a0)
   10b56:	8082                	ret

0000000000010b58 <read_gpio>:
   10b58:	00054503          	lbu	a0,0(a0)
   10b5c:	8082                	ret

0000000000010b5e <init_gpio>:
   10b5e:	400007b7          	lui	a5,0x40000
   10b62:	00078223          	sb	zero,4(a5) # 40000004 <_RODATA_END_+0x3ffee20c>
   10b66:	477d                	li	a4,31
   10b68:	00e78623          	sb	a4,12(a5)
   10b6c:	8082                	ret

Disassembly of section .text.startup:

0000000000010b6e <main>:
   10b6e:	1141                	addi	sp,sp,-16
   10b70:	e022                	sd	s0,0(sp)
   10b72:	65f1                	lui	a1,0x1c
   10b74:	02faf437          	lui	s0,0x2faf
   10b78:	08040513          	addi	a0,s0,128 # 2faf080 <_RODATA_END_+0x2f9d288>
   10b7c:	20058593          	addi	a1,a1,512 # 1c200 <_RODATA_END_+0xa408>
   10b80:	e406                	sd	ra,8(sp)
   10b82:	daeff0ef          	jal	ra,10130 <init_uart>
   10b86:	00001517          	auipc	a0,0x1
   10b8a:	f7250513          	addi	a0,a0,-142 # 11af8 <_RODATA_START_+0xbf8>
   10b8e:	de6ff0ef          	jal	ra,10174 <print_uart>
   10b92:	08040413          	addi	s0,s0,128
   10b96:	fc9ff0ef          	jal	ra,10b5e <init_gpio>
   10b9a:	0aa00593          	li	a1,170
   10b9e:	40000537          	lui	a0,0x40000
   10ba2:	fb1ff0ef          	jal	ra,10b52 <write_gpio>
   10ba6:	00000797          	auipc	a5,0x0
   10baa:	2487ad23          	sw	s0,602(a5) # 10e00 <i>
   10bae:	00000797          	auipc	a5,0x0
   10bb2:	2527a783          	lw	a5,594(a5) # 10e00 <i>
   10bb6:	2781                	sext.w	a5,a5
   10bb8:	02f05263          	blez	a5,10bdc <main+0x6e>
   10bbc:	00000797          	auipc	a5,0x0
   10bc0:	2447a783          	lw	a5,580(a5) # 10e00 <i>
   10bc4:	00000717          	auipc	a4,0x0
   10bc8:	37fd                	addiw	a5,a5,-1
   10bca:	22f72e23          	sw	a5,572(a4) # 10e00 <i>
   10bce:	00000797          	auipc	a5,0x0
   10bd2:	2327a783          	lw	a5,562(a5) # 10e00 <i>
   10bd6:	2781                	sext.w	a5,a5
   10bd8:	fef042e3          	bgtz	a5,10bbc <main+0x4e>
   10bdc:	4581                	li	a1,0
   10bde:	40000537          	lui	a0,0x40000
   10be2:	f71ff0ef          	jal	ra,10b52 <write_gpio>
   10be6:	00000797          	auipc	a5,0x0
   10bea:	2087ad23          	sw	s0,538(a5) # 10e00 <i>
   10bee:	00000797          	auipc	a5,0x0
   10bf2:	2127a783          	lw	a5,530(a5) # 10e00 <i>
   10bf6:	2781                	sext.w	a5,a5
   10bf8:	02f05263          	blez	a5,10c1c <main+0xae>
   10bfc:	00000797          	auipc	a5,0x0
   10c00:	2047a783          	lw	a5,516(a5) # 10e00 <i>
   10c04:	00000717          	auipc	a4,0x0
   10c08:	37fd                	addiw	a5,a5,-1
   10c0a:	1ef72e23          	sw	a5,508(a4) # 10e00 <i>
   10c0e:	00000797          	auipc	a5,0x0
   10c12:	1f27a783          	lw	a5,498(a5) # 10e00 <i>
   10c16:	2781                	sext.w	a5,a5
   10c18:	fef042e3          	bgtz	a5,10bfc <main+0x8e>
   10c1c:	4485                	li	s1,1
   10c1e:	4909                	li	s2,2
   10c20:	012489ab          	0x12489ab
   10c24:	bf9d                	j	10b9a <main+0x2c>
