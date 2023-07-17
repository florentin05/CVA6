
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
   1001c:	293000ef          	jal	ra,10aae <_TEXT_END_>
   10020:	020004b7          	lui	s1,0x2000
   10024:	00100913          	li	s2,1
   10028:	0124a023          	sw	s2,0(s1) # 2000000 <_RODATA_END_+0x1fee368>
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
   1005c:	00092023          	sw	zero,0(s2) # 2000000 <_RODATA_END_+0x1fee368>
   10060:	0004a903          	lw	s2,0(s1) # 2000000 <_RODATA_END_+0x1fee368>
   10064:	fe091ee3          	bnez	s2,10060 <_prog_start+0x60>
   10068:	00448493          	addi	s1,s1,4
   1006c:	02000937          	lui	s2,0x2000
   10070:	4009091b          	addiw	s2,s2,1024
   10074:	ff24c6e3          	blt	s1,s2,10060 <_prog_start+0x60>
   10078:	f1402573          	csrr	a0,mhartid
   1007c:	00001597          	auipc	a1,0x1
   10080:	c8458593          	addi	a1,a1,-892 # 10d00 <_BSS_END_>
   10084:	0010049b          	addiw	s1,zero,1
   10088:	01f49493          	slli	s1,s1,0x1f
   1008c:	00048067          	jr	s1

Disassembly of section .text:

0000000000010100 <write_reg_u8>:
   10100:	00b50023          	sb	a1,0(a0)
   10104:	8082                	ret

0000000000010106 <read_reg_u8>:
   10106:	00054503          	lbu	a0,0(a0)
   1010a:	8082                	ret

000000000001010c <is_transmit_empty>:
   1010c:	100007b7          	lui	a5,0x10000
   10110:	0147c503          	lbu	a0,20(a5) # 10000014 <_RODATA_END_+0xffee37c>
   10114:	02057513          	andi	a0,a0,32
   10118:	8082                	ret

000000000001011a <write_serial>:
   1011a:	10000737          	lui	a4,0x10000
   1011e:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee37c>
   10122:	0207f793          	andi	a5,a5,32
   10126:	dfe5                	beqz	a5,1011e <write_serial+0x4>
   10128:	00a70023          	sb	a0,0(a4)
   1012c:	8082                	ret

000000000001012e <init_uart>:
   1012e:	0045959b          	slliw	a1,a1,0x4
   10132:	02b5553b          	divuw	a0,a0,a1
   10136:	100007b7          	lui	a5,0x10000
   1013a:	00078223          	sb	zero,4(a5) # 10000004 <_RODATA_END_+0xffee36c>
   1013e:	f8000713          	li	a4,-128
   10142:	00e78623          	sb	a4,12(a5)
   10146:	0ff57713          	andi	a4,a0,255
   1014a:	0085551b          	srliw	a0,a0,0x8
   1014e:	00e78023          	sb	a4,0(a5)
   10152:	0ff57513          	andi	a0,a0,255
   10156:	00a78223          	sb	a0,4(a5)
   1015a:	470d                	li	a4,3
   1015c:	00e78623          	sb	a4,12(a5)
   10160:	fc700713          	li	a4,-57
   10164:	00e78423          	sb	a4,8(a5)
   10168:	02000713          	li	a4,32
   1016c:	00e78823          	sb	a4,16(a5)
   10170:	8082                	ret

0000000000010172 <print_uart>:
   10172:	1141                	addi	sp,sp,-16
   10174:	e022                	sd	s0,0(sp)
   10176:	e406                	sd	ra,8(sp)
   10178:	842a                	mv	s0,a0
   1017a:	00044503          	lbu	a0,0(s0)
   1017e:	e509                	bnez	a0,10188 <print_uart+0x16>
   10180:	60a2                	ld	ra,8(sp)
   10182:	6402                	ld	s0,0(sp)
   10184:	0141                	addi	sp,sp,16
   10186:	8082                	ret
   10188:	f93ff0ef          	jal	ra,1011a <write_serial>
   1018c:	0405                	addi	s0,s0,1
   1018e:	b7f5                	j	1017a <print_uart+0x8>

0000000000010190 <bin_to_hex>:
   10190:	00001797          	auipc	a5,0x1
   10194:	a7078793          	addi	a5,a5,-1424 # 10c00 <bin_to_hex_table>
   10198:	00f57713          	andi	a4,a0,15
   1019c:	973e                	add	a4,a4,a5
   1019e:	00074703          	lbu	a4,0(a4)
   101a2:	8111                	srli	a0,a0,0x4
   101a4:	97aa                	add	a5,a5,a0
   101a6:	00e580a3          	sb	a4,1(a1)
   101aa:	0007c783          	lbu	a5,0(a5)
   101ae:	00f58023          	sb	a5,0(a1)
   101b2:	8082                	ret

00000000000101b4 <print_uart_int>:
   101b4:	7179                	addi	sp,sp,-48
   101b6:	f022                	sd	s0,32(sp)
   101b8:	ec26                	sd	s1,24(sp)
   101ba:	e84a                	sd	s2,16(sp)
   101bc:	f406                	sd	ra,40(sp)
   101be:	892a                	mv	s2,a0
   101c0:	4461                	li	s0,24
   101c2:	54e1                	li	s1,-8
   101c4:	0089553b          	srlw	a0,s2,s0
   101c8:	002c                	addi	a1,sp,8
   101ca:	0ff57513          	andi	a0,a0,255
   101ce:	fc3ff0ef          	jal	ra,10190 <bin_to_hex>
   101d2:	00814503          	lbu	a0,8(sp)
   101d6:	3461                	addiw	s0,s0,-8
   101d8:	f43ff0ef          	jal	ra,1011a <write_serial>
   101dc:	00914503          	lbu	a0,9(sp)
   101e0:	f3bff0ef          	jal	ra,1011a <write_serial>
   101e4:	fe9410e3          	bne	s0,s1,101c4 <print_uart_int+0x10>
   101e8:	70a2                	ld	ra,40(sp)
   101ea:	7402                	ld	s0,32(sp)
   101ec:	64e2                	ld	s1,24(sp)
   101ee:	6942                	ld	s2,16(sp)
   101f0:	6145                	addi	sp,sp,48
   101f2:	8082                	ret

00000000000101f4 <print_uart_addr>:
   101f4:	7179                	addi	sp,sp,-48
   101f6:	f022                	sd	s0,32(sp)
   101f8:	ec26                	sd	s1,24(sp)
   101fa:	e84a                	sd	s2,16(sp)
   101fc:	f406                	sd	ra,40(sp)
   101fe:	892a                	mv	s2,a0
   10200:	03800413          	li	s0,56
   10204:	54e1                	li	s1,-8
   10206:	00895533          	srl	a0,s2,s0
   1020a:	002c                	addi	a1,sp,8
   1020c:	0ff57513          	andi	a0,a0,255
   10210:	f81ff0ef          	jal	ra,10190 <bin_to_hex>
   10214:	00814503          	lbu	a0,8(sp)
   10218:	3461                	addiw	s0,s0,-8
   1021a:	f01ff0ef          	jal	ra,1011a <write_serial>
   1021e:	00914503          	lbu	a0,9(sp)
   10222:	ef9ff0ef          	jal	ra,1011a <write_serial>
   10226:	fe9410e3          	bne	s0,s1,10206 <print_uart_addr+0x12>
   1022a:	70a2                	ld	ra,40(sp)
   1022c:	7402                	ld	s0,32(sp)
   1022e:	64e2                	ld	s1,24(sp)
   10230:	6942                	ld	s2,16(sp)
   10232:	6145                	addi	sp,sp,48
   10234:	8082                	ret

0000000000010236 <print_uart_byte>:
   10236:	1101                	addi	sp,sp,-32
   10238:	002c                	addi	a1,sp,8
   1023a:	ec06                	sd	ra,24(sp)
   1023c:	f55ff0ef          	jal	ra,10190 <bin_to_hex>
   10240:	00814503          	lbu	a0,8(sp)
   10244:	ed7ff0ef          	jal	ra,1011a <write_serial>
   10248:	00914503          	lbu	a0,9(sp)
   1024c:	ecfff0ef          	jal	ra,1011a <write_serial>
   10250:	60e2                	ld	ra,24(sp)
   10252:	6105                	addi	sp,sp,32
   10254:	8082                	ret

0000000000010256 <write_reg>:
   10256:	c10c                	sw	a1,0(a0)
   10258:	8082                	ret

000000000001025a <read_reg>:
   1025a:	4108                	lw	a0,0(a0)
   1025c:	2501                	sext.w	a0,a0
   1025e:	8082                	ret

0000000000010260 <spi_init>:
   10260:	00001517          	auipc	a0,0x1
   10264:	1101                	addi	sp,sp,-32
   10266:	74850513          	addi	a0,a0,1864 # 119a8 <_BSS_END_+0xca8>
   1026a:	ec06                	sd	ra,24(sp)
   1026c:	e822                	sd	s0,16(sp)
   1026e:	e426                	sd	s1,8(sp)
   10270:	f03ff0ef          	jal	ra,10172 <print_uart>
   10274:	200007b7          	lui	a5,0x20000
   10278:	4729                	li	a4,10
   1027a:	c3b8                	sw	a4,64(a5)
   1027c:	47a9                	li	a5,10
   1027e:	0001                	nop
   10280:	37fd                	addiw	a5,a5,-1
   10282:	fff5                	bnez	a5,1027e <spi_init+0x1e>
   10284:	20000437          	lui	s0,0x20000
   10288:	10400793          	li	a5,260
   1028c:	d03c                	sw	a5,96(s0)
   1028e:	5064                	lw	s1,100(s0)
   10290:	00001517          	auipc	a0,0x1
   10294:	72850513          	addi	a0,a0,1832 # 119b8 <_BSS_END_+0xcb8>
   10298:	edbff0ef          	jal	ra,10172 <print_uart>
   1029c:	2481                	sext.w	s1,s1
   1029e:	02049513          	slli	a0,s1,0x20
   102a2:	9101                	srli	a0,a0,0x20
   102a4:	f51ff0ef          	jal	ra,101f4 <print_uart_addr>
   102a8:	00001517          	auipc	a0,0x1
   102ac:	73050513          	addi	a0,a0,1840 # 119d8 <_BSS_END_+0xcd8>
   102b0:	ec3ff0ef          	jal	ra,10172 <print_uart>
   102b4:	16600793          	li	a5,358
   102b8:	d03c                	sw	a5,96(s0)
   102ba:	5064                	lw	s1,100(s0)
   102bc:	00001517          	auipc	a0,0x1
   102c0:	6fc50513          	addi	a0,a0,1788 # 119b8 <_BSS_END_+0xcb8>
   102c4:	eafff0ef          	jal	ra,10172 <print_uart>
   102c8:	2481                	sext.w	s1,s1
   102ca:	02049513          	slli	a0,s1,0x20
   102ce:	9101                	srli	a0,a0,0x20
   102d0:	f25ff0ef          	jal	ra,101f4 <print_uart_addr>
   102d4:	00001517          	auipc	a0,0x1
   102d8:	70450513          	addi	a0,a0,1796 # 119d8 <_BSS_END_+0xcd8>
   102dc:	e97ff0ef          	jal	ra,10172 <print_uart>
   102e0:	4799                	li	a5,6
   102e2:	d03c                	sw	a5,96(s0)
   102e4:	6442                	ld	s0,16(sp)
   102e6:	60e2                	ld	ra,24(sp)
   102e8:	64a2                	ld	s1,8(sp)
   102ea:	00001517          	auipc	a0,0x1
   102ee:	6de50513          	addi	a0,a0,1758 # 119c8 <_BSS_END_+0xcc8>
   102f2:	6105                	addi	sp,sp,32
   102f4:	bdbd                	j	10172 <print_uart>

00000000000102f6 <spi_txrx>:
   102f6:	1101                	addi	sp,sp,-32
   102f8:	200007b7          	lui	a5,0x20000
   102fc:	ec06                	sd	ra,24(sp)
   102fe:	e822                	sd	s0,16(sp)
   10300:	e426                	sd	s1,8(sp)
   10302:	5779                	li	a4,-2
   10304:	dbb8                	sw	a4,112(a5)
   10306:	d7a8                	sw	a0,104(a5)
   10308:	06400793          	li	a5,100
   1030c:	0001                	nop
   1030e:	37fd                	addiw	a5,a5,-1
   10310:	fff5                	bnez	a5,1030c <spi_txrx+0x16>
   10312:	200007b7          	lui	a5,0x20000
   10316:	10600713          	li	a4,262
   1031a:	d3b8                	sw	a4,96(a5)
   1031c:	53f8                	lw	a4,100(a5)
   1031e:	06478493          	addi	s1,a5,100 # 20000064 <_RODATA_END_+0x1ffee3cc>
   10322:	8b05                	andi	a4,a4,1
   10324:	ff65                	bnez	a4,1031c <spi_txrx+0x26>
   10326:	57e0                	lw	s0,108(a5)
   10328:	53fc                	lw	a5,100(a5)
   1032a:	2401                	sext.w	s0,s0
   1032c:	8b85                	andi	a5,a5,1
   1032e:	e395                	bnez	a5,10352 <spi_txrx+0x5c>
   10330:	00001517          	auipc	a0,0x1
   10334:	6b050513          	addi	a0,a0,1712 # 119e0 <_BSS_END_+0xce0>
   10338:	e3bff0ef          	jal	ra,10172 <print_uart>
   1033c:	4088                	lw	a0,0(s1)
   1033e:	1502                	slli	a0,a0,0x20
   10340:	9101                	srli	a0,a0,0x20
   10342:	eb3ff0ef          	jal	ra,101f4 <print_uart_addr>
   10346:	00001517          	auipc	a0,0x1
   1034a:	69250513          	addi	a0,a0,1682 # 119d8 <_BSS_END_+0xcd8>
   1034e:	e25ff0ef          	jal	ra,10172 <print_uart>
   10352:	200007b7          	lui	a5,0x20000
   10356:	577d                	li	a4,-1
   10358:	0ff47513          	andi	a0,s0,255
   1035c:	60e2                	ld	ra,24(sp)
   1035e:	6442                	ld	s0,16(sp)
   10360:	dbb8                	sw	a4,112(a5)
   10362:	4719                	li	a4,6
   10364:	d3b8                	sw	a4,96(a5)
   10366:	64a2                	ld	s1,8(sp)
   10368:	6105                	addi	sp,sp,32
   1036a:	8082                	ret

000000000001036c <spi_write_bytes>:
   1036c:	10000793          	li	a5,256
   10370:	06b7ee63          	bltu	a5,a1,103ec <spi_write_bytes+0x80>
   10374:	200007b7          	lui	a5,0x20000
   10378:	5779                	li	a4,-2
   1037a:	dbb8                	sw	a4,112(a5)
   1037c:	200006b7          	lui	a3,0x20000
   10380:	4781                	li	a5,0
   10382:	0007871b          	sext.w	a4,a5
   10386:	04b76163          	bltu	a4,a1,103c8 <spi_write_bytes+0x5c>
   1038a:	03200793          	li	a5,50
   1038e:	0001                	nop
   10390:	37fd                	addiw	a5,a5,-1
   10392:	fff5                	bnez	a5,1038e <spi_write_bytes+0x22>
   10394:	10600713          	li	a4,262
   10398:	200007b7          	lui	a5,0x20000
   1039c:	d3b8                	sw	a4,96(a5)
   1039e:	20000737          	lui	a4,0x20000
   103a2:	537c                	lw	a5,100(a4)
   103a4:	8b85                	andi	a5,a5,1
   103a6:	fff5                	bnez	a5,103a2 <spi_write_bytes+0x36>
   103a8:	20000537          	lui	a0,0x20000
   103ac:	20000837          	lui	a6,0x20000
   103b0:	0007869b          	sext.w	a3,a5
   103b4:	02b6e163          	bltu	a3,a1,103d6 <spi_write_bytes+0x6a>
   103b8:	200007b7          	lui	a5,0x20000
   103bc:	577d                	li	a4,-1
   103be:	dbb8                	sw	a4,112(a5)
   103c0:	4719                	li	a4,6
   103c2:	d3b8                	sw	a4,96(a5)
   103c4:	4501                	li	a0,0
   103c6:	8082                	ret
   103c8:	00f50733          	add	a4,a0,a5
   103cc:	00074703          	lbu	a4,0(a4) # 20000000 <_RODATA_END_+0x1ffee368>
   103d0:	0785                	addi	a5,a5,1
   103d2:	d6b8                	sw	a4,104(a3)
   103d4:	b77d                	j	10382 <spi_write_bytes+0x16>
   103d6:	5178                	lw	a4,100(a0)
   103d8:	8b05                	andi	a4,a4,1
   103da:	ff69                	bnez	a4,103b4 <spi_write_bytes+0x48>
   103dc:	06c82683          	lw	a3,108(a6) # 2000006c <_RODATA_END_+0x1ffee3d4>
   103e0:	00f60733          	add	a4,a2,a5
   103e4:	0785                	addi	a5,a5,1
   103e6:	00d70023          	sb	a3,0(a4)
   103ea:	b7d9                	j	103b0 <spi_write_bytes+0x44>
   103ec:	557d                	li	a0,-1
   103ee:	8082                	ret

00000000000103f0 <sd_dummy>:
   103f0:	0ff00513          	li	a0,255
   103f4:	b709                	j	102f6 <spi_txrx>

00000000000103f6 <sd_cmd>:
   103f6:	7179                	addi	sp,sp,-48
   103f8:	f406                	sd	ra,40(sp)
   103fa:	e432                	sd	a2,8(sp)
   103fc:	f022                	sd	s0,32(sp)
   103fe:	ec26                	sd	s1,24(sp)
   10400:	842e                	mv	s0,a1
   10402:	84aa                	mv	s1,a0
   10404:	fedff0ef          	jal	ra,103f0 <sd_dummy>
   10408:	0404e513          	ori	a0,s1,64
   1040c:	eebff0ef          	jal	ra,102f6 <spi_txrx>
   10410:	0184551b          	srliw	a0,s0,0x18
   10414:	ee3ff0ef          	jal	ra,102f6 <spi_txrx>
   10418:	0104551b          	srliw	a0,s0,0x10
   1041c:	0ff57513          	andi	a0,a0,255
   10420:	ed7ff0ef          	jal	ra,102f6 <spi_txrx>
   10424:	0084551b          	srliw	a0,s0,0x8
   10428:	0ff57513          	andi	a0,a0,255
   1042c:	ecbff0ef          	jal	ra,102f6 <spi_txrx>
   10430:	0ff47513          	andi	a0,s0,255
   10434:	ec3ff0ef          	jal	ra,102f6 <spi_txrx>
   10438:	6622                	ld	a2,8(sp)
   1043a:	06400413          	li	s0,100
   1043e:	8532                	mv	a0,a2
   10440:	eb7ff0ef          	jal	ra,102f6 <spi_txrx>
   10444:	fadff0ef          	jal	ra,103f0 <sd_dummy>
   10448:	0185179b          	slliw	a5,a0,0x18
   1044c:	4187d79b          	sraiw	a5,a5,0x18
   10450:	0007d463          	bgez	a5,10458 <sd_cmd+0x62>
   10454:	147d                	addi	s0,s0,-1
   10456:	f47d                	bnez	s0,10444 <sd_cmd+0x4e>
   10458:	70a2                	ld	ra,40(sp)
   1045a:	7402                	ld	s0,32(sp)
   1045c:	64e2                	ld	s1,24(sp)
   1045e:	6145                	addi	sp,sp,48
   10460:	8082                	ret

0000000000010462 <print_status>:
   10462:	1101                	addi	sp,sp,-32
   10464:	e822                	sd	s0,16(sp)
   10466:	842a                	mv	s0,a0
   10468:	00001517          	auipc	a0,0x1
   1046c:	59050513          	addi	a0,a0,1424 # 119f8 <_BSS_END_+0xcf8>
   10470:	ec06                	sd	ra,24(sp)
   10472:	e42e                	sd	a1,8(sp)
   10474:	cffff0ef          	jal	ra,10172 <print_uart>
   10478:	8522                	mv	a0,s0
   1047a:	cf9ff0ef          	jal	ra,10172 <print_uart>
   1047e:	00001517          	auipc	a0,0x1
   10482:	58a50513          	addi	a0,a0,1418 # 11a08 <_BSS_END_+0xd08>
   10486:	cedff0ef          	jal	ra,10172 <print_uart>
   1048a:	65a2                	ld	a1,8(sp)
   1048c:	852e                	mv	a0,a1
   1048e:	da9ff0ef          	jal	ra,10236 <print_uart_byte>
   10492:	6442                	ld	s0,16(sp)
   10494:	60e2                	ld	ra,24(sp)
   10496:	00001517          	auipc	a0,0x1
   1049a:	54250513          	addi	a0,a0,1346 # 119d8 <_BSS_END_+0xcd8>
   1049e:	6105                	addi	sp,sp,32
   104a0:	b9c9                	j	10172 <print_uart>

00000000000104a2 <sd_cmd0>:
   104a2:	1101                	addi	sp,sp,-32
   104a4:	e822                	sd	s0,16(sp)
   104a6:	6409                	lui	s0,0x2
   104a8:	e426                	sd	s1,8(sp)
   104aa:	ec06                	sd	ra,24(sp)
   104ac:	e04a                	sd	s2,0(sp)
   104ae:	71040413          	addi	s0,s0,1808 # 2710 <ROM_BASE-0xd8f0>
   104b2:	4485                	li	s1,1
   104b4:	09500613          	li	a2,149
   104b8:	4581                	li	a1,0
   104ba:	4501                	li	a0,0
   104bc:	f3bff0ef          	jal	ra,103f6 <sd_cmd>
   104c0:	347d                	addiw	s0,s0,-1
   104c2:	892a                	mv	s2,a0
   104c4:	f2dff0ef          	jal	ra,103f0 <sd_dummy>
   104c8:	c00d                	beqz	s0,104ea <sd_cmd0+0x48>
   104ca:	fe9915e3          	bne	s2,s1,104b4 <sd_cmd0+0x12>
   104ce:	00001517          	auipc	a0,0x1
   104d2:	54a50513          	addi	a0,a0,1354 # 11a18 <_BSS_END_+0xd18>
   104d6:	4585                	li	a1,1
   104d8:	f8bff0ef          	jal	ra,10462 <print_status>
   104dc:	4505                	li	a0,1
   104de:	60e2                	ld	ra,24(sp)
   104e0:	6442                	ld	s0,16(sp)
   104e2:	64a2                	ld	s1,8(sp)
   104e4:	6902                	ld	s2,0(sp)
   104e6:	6105                	addi	sp,sp,32
   104e8:	8082                	ret
   104ea:	4501                	li	a0,0
   104ec:	bfcd                	j	104de <sd_cmd0+0x3c>

00000000000104ee <sd_cmd8>:
   104ee:	1101                	addi	sp,sp,-32
   104f0:	08700613          	li	a2,135
   104f4:	1aa00593          	li	a1,426
   104f8:	4521                	li	a0,8
   104fa:	ec06                	sd	ra,24(sp)
   104fc:	e822                	sd	s0,16(sp)
   104fe:	e426                	sd	s1,8(sp)
   10500:	e04a                	sd	s2,0(sp)
   10502:	ef5ff0ef          	jal	ra,103f6 <sd_cmd>
   10506:	892a                	mv	s2,a0
   10508:	ee9ff0ef          	jal	ra,103f0 <sd_dummy>
   1050c:	ee5ff0ef          	jal	ra,103f0 <sd_dummy>
   10510:	ee1ff0ef          	jal	ra,103f0 <sd_dummy>
   10514:	84aa                	mv	s1,a0
   10516:	edbff0ef          	jal	ra,103f0 <sd_dummy>
   1051a:	842a                	mv	s0,a0
   1051c:	ed5ff0ef          	jal	ra,103f0 <sd_dummy>
   10520:	ed1ff0ef          	jal	ra,103f0 <sd_dummy>
   10524:	4785                	li	a5,1
   10526:	4501                	li	a0,0
   10528:	00f91b63          	bne	s2,a5,1053e <sd_cmd8+0x50>
   1052c:	88bd                	andi	s1,s1,15
   1052e:	01249863          	bne	s1,s2,1053e <sd_cmd8+0x50>
   10532:	0004051b          	sext.w	a0,s0
   10536:	f5650513          	addi	a0,a0,-170
   1053a:	00153513          	seqz	a0,a0
   1053e:	60e2                	ld	ra,24(sp)
   10540:	6442                	ld	s0,16(sp)
   10542:	64a2                	ld	s1,8(sp)
   10544:	6902                	ld	s2,0(sp)
   10546:	6105                	addi	sp,sp,32
   10548:	8082                	ret

000000000001054a <sd_cmd55>:
   1054a:	1141                	addi	sp,sp,-16
   1054c:	06500613          	li	a2,101
   10550:	4581                	li	a1,0
   10552:	03700513          	li	a0,55
   10556:	e406                	sd	ra,8(sp)
   10558:	e022                	sd	s0,0(sp)
   1055a:	e9dff0ef          	jal	ra,103f6 <sd_cmd>
   1055e:	842a                	mv	s0,a0
   10560:	e91ff0ef          	jal	ra,103f0 <sd_dummy>
   10564:	00001517          	auipc	a0,0x1
   10568:	85a2                	mv	a1,s0
   1056a:	4bc50513          	addi	a0,a0,1212 # 11a20 <_BSS_END_+0xd20>
   1056e:	ef5ff0ef          	jal	ra,10462 <print_status>
   10572:	0004051b          	sext.w	a0,s0
   10576:	60a2                	ld	ra,8(sp)
   10578:	6402                	ld	s0,0(sp)
   1057a:	157d                	addi	a0,a0,-1
   1057c:	00153513          	seqz	a0,a0
   10580:	0141                	addi	sp,sp,16
   10582:	8082                	ret

0000000000010584 <sd_acmd41>:
   10584:	1101                	addi	sp,sp,-32
   10586:	e426                	sd	s1,8(sp)
   10588:	ec06                	sd	ra,24(sp)
   1058a:	e822                	sd	s0,16(sp)
   1058c:	4485                	li	s1,1
   1058e:	fbdff0ef          	jal	ra,1054a <sd_cmd55>
   10592:	07700613          	li	a2,119
   10596:	400005b7          	lui	a1,0x40000
   1059a:	02900513          	li	a0,41
   1059e:	e59ff0ef          	jal	ra,103f6 <sd_cmd>
   105a2:	842a                	mv	s0,a0
   105a4:	85aa                	mv	a1,a0
   105a6:	00001517          	auipc	a0,0x1
   105aa:	48250513          	addi	a0,a0,1154 # 11a28 <_BSS_END_+0xd28>
   105ae:	eb5ff0ef          	jal	ra,10462 <print_status>
   105b2:	e3fff0ef          	jal	ra,103f0 <sd_dummy>
   105b6:	fc940ce3          	beq	s0,s1,1058e <sd_acmd41+0xa>
   105ba:	0004051b          	sext.w	a0,s0
   105be:	60e2                	ld	ra,24(sp)
   105c0:	6442                	ld	s0,16(sp)
   105c2:	64a2                	ld	s1,8(sp)
   105c4:	00153513          	seqz	a0,a0
   105c8:	6105                	addi	sp,sp,32
   105ca:	8082                	ret

00000000000105cc <init_sd>:
   105cc:	1141                	addi	sp,sp,-16
   105ce:	e406                	sd	ra,8(sp)
   105d0:	e022                	sd	s0,0(sp)
   105d2:	c8fff0ef          	jal	ra,10260 <spi_init>
   105d6:	00001517          	auipc	a0,0x1
   105da:	45a50513          	addi	a0,a0,1114 # 11a30 <_BSS_END_+0xd30>
   105de:	b95ff0ef          	jal	ra,10172 <print_uart>
   105e2:	4429                	li	s0,10
   105e4:	347d                	addiw	s0,s0,-1
   105e6:	e0bff0ef          	jal	ra,103f0 <sd_dummy>
   105ea:	fc6d                	bnez	s0,105e4 <init_sd+0x18>
   105ec:	eb7ff0ef          	jal	ra,104a2 <sd_cmd0>
   105f0:	57fd                	li	a5,-1
   105f2:	c911                	beqz	a0,10606 <init_sd+0x3a>
   105f4:	efbff0ef          	jal	ra,104ee <sd_cmd8>
   105f8:	57f9                	li	a5,-2
   105fa:	c511                	beqz	a0,10606 <init_sd+0x3a>
   105fc:	f89ff0ef          	jal	ra,10584 <sd_acmd41>
   10600:	4781                	li	a5,0
   10602:	e111                	bnez	a0,10606 <init_sd+0x3a>
   10604:	57f5                	li	a5,-3
   10606:	60a2                	ld	ra,8(sp)
   10608:	6402                	ld	s0,0(sp)
   1060a:	853e                	mv	a0,a5
   1060c:	0141                	addi	sp,sp,16
   1060e:	8082                	ret

0000000000010610 <crc7>:
   10610:	8de9                	and	a1,a1,a0
   10612:	0075d79b          	srliw	a5,a1,0x7
   10616:	0045d51b          	srliw	a0,a1,0x4
   1061a:	8d3d                	xor	a0,a0,a5
   1061c:	8d2d                	xor	a0,a0,a1
   1061e:	00451593          	slli	a1,a0,0x4
   10622:	8d2d                	xor	a0,a0,a1
   10624:	07f57513          	andi	a0,a0,127
   10628:	8082                	ret

000000000001062a <crc16>:
   1062a:	0085579b          	srliw	a5,a0,0x8
   1062e:	0522                	slli	a0,a0,0x8
   10630:	8d5d                	or	a0,a0,a5
   10632:	1542                	slli	a0,a0,0x30
   10634:	9141                	srli	a0,a0,0x30
   10636:	8da9                	xor	a1,a1,a0
   10638:	0045d51b          	srliw	a0,a1,0x4
   1063c:	893d                	andi	a0,a0,15
   1063e:	8da9                	xor	a1,a1,a0
   10640:	00c59513          	slli	a0,a1,0xc
   10644:	8d2d                	xor	a0,a0,a1
   10646:	0105151b          	slliw	a0,a0,0x10
   1064a:	4105551b          	sraiw	a0,a0,0x10
   1064e:	0105179b          	slliw	a5,a0,0x10
   10652:	0107d79b          	srliw	a5,a5,0x10
   10656:	6709                	lui	a4,0x2
   10658:	1701                	addi	a4,a4,-32
   1065a:	0057979b          	slliw	a5,a5,0x5
   1065e:	8ff9                	and	a5,a5,a4
   10660:	8d3d                	xor	a0,a0,a5
   10662:	1542                	slli	a0,a0,0x30
   10664:	9141                	srli	a0,a0,0x30
   10666:	8082                	ret

0000000000010668 <sd_copy>:
   10668:	7155                	addi	sp,sp,-208
   1066a:	f54e                	sd	s3,168(sp)
   1066c:	02061993          	slli	s3,a2,0x20
   10670:	e1a2                	sd	s0,192(sp)
   10672:	fd26                	sd	s1,184(sp)
   10674:	e586                	sd	ra,200(sp)
   10676:	f94a                	sd	s2,176(sp)
   10678:	f152                	sd	s4,160(sp)
   1067a:	ed56                	sd	s5,152(sp)
   1067c:	e95a                	sd	s6,144(sp)
   1067e:	e55e                	sd	s7,136(sp)
   10680:	84aa                	mv	s1,a0
   10682:	842e                	mv	s0,a1
   10684:	0209d993          	srli	s3,s3,0x20
   10688:	4781                	li	a5,0
   1068a:	567d                	li	a2,-1
   1068c:	08000713          	li	a4,128
   10690:	00f106b3          	add	a3,sp,a5
   10694:	00c68023          	sb	a2,0(a3) # 20000000 <_RODATA_END_+0x1ffee368>
   10698:	0785                	addi	a5,a5,1
   1069a:	fee79be3          	bne	a5,a4,10690 <sd_copy+0x28>
   1069e:	0184559b          	srliw	a1,s0,0x18
   106a2:	4501                	li	a0,0
   106a4:	f6dff0ef          	jal	ra,10610 <crc7>
   106a8:	0104559b          	srliw	a1,s0,0x10
   106ac:	0ff5f593          	andi	a1,a1,255
   106b0:	f61ff0ef          	jal	ra,10610 <crc7>
   106b4:	0084559b          	srliw	a1,s0,0x8
   106b8:	0ff5f593          	andi	a1,a1,255
   106bc:	f55ff0ef          	jal	ra,10610 <crc7>
   106c0:	0ff47593          	andi	a1,s0,255
   106c4:	f4dff0ef          	jal	ra,10610 <crc7>
   106c8:	0015161b          	slliw	a2,a0,0x1
   106cc:	00166613          	ori	a2,a2,1
   106d0:	0ff67613          	andi	a2,a2,255
   106d4:	85a2                	mv	a1,s0
   106d6:	4549                	li	a0,18
   106d8:	d1fff0ef          	jal	ra,103f6 <sd_cmd>
   106dc:	20048493          	addi	s1,s1,512
   106e0:	e951                	bnez	a0,10774 <sd_copy+0x10c>
   106e2:	0fe00a93          	li	s5,254
   106e6:	3e800b13          	li	s6,1000
   106ea:	e0048413          	addi	s0,s1,-512
   106ee:	d03ff0ef          	jal	ra,103f0 <sd_dummy>
   106f2:	ff551ee3          	bne	a0,s5,106ee <sd_copy+0x86>
   106f6:	4901                	li	s2,0
   106f8:	8622                	mv	a2,s0
   106fa:	04000593          	li	a1,64
   106fe:	850a                	mv	a0,sp
   10700:	c6dff0ef          	jal	ra,1036c <spi_write_bytes>
   10704:	4a01                	li	s4,0
   10706:	04000b93          	li	s7,64
   1070a:	014407b3          	add	a5,s0,s4
   1070e:	0007c583          	lbu	a1,0(a5) # 20000000 <_RODATA_END_+0x1ffee368>
   10712:	854a                	mv	a0,s2
   10714:	0a05                	addi	s4,s4,1
   10716:	f15ff0ef          	jal	ra,1062a <crc16>
   1071a:	892a                	mv	s2,a0
   1071c:	ff7a17e3          	bne	s4,s7,1070a <sd_copy+0xa2>
   10720:	04040413          	addi	s0,s0,64
   10724:	fc941ae3          	bne	s0,s1,106f8 <sd_copy+0x90>
   10728:	cc9ff0ef          	jal	ra,103f0 <sd_dummy>
   1072c:	0085151b          	slliw	a0,a0,0x8
   10730:	03051413          	slli	s0,a0,0x30
   10734:	9041                	srli	s0,s0,0x30
   10736:	cbbff0ef          	jal	ra,103f0 <sd_dummy>
   1073a:	8c49                	or	s0,s0,a0
   1073c:	1442                	slli	s0,s0,0x30
   1073e:	2901                	sext.w	s2,s2
   10740:	9041                	srli	s0,s0,0x30
   10742:	06891c63          	bne	s2,s0,107ba <sd_copy+0x152>
   10746:	0369e7b3          	rem	a5,s3,s6
   1074a:	e799                	bnez	a5,10758 <sd_copy+0xf0>
   1074c:	00001517          	auipc	a0,0x1
   10750:	31c50513          	addi	a0,a0,796 # 11a68 <_BSS_END_+0xd68>
   10754:	a1fff0ef          	jal	ra,10172 <print_uart>
   10758:	19fd                	addi	s3,s3,-1
   1075a:	20048493          	addi	s1,s1,512
   1075e:	f93046e3          	bgtz	s3,106ea <sd_copy+0x82>
   10762:	4401                	li	s0,0
   10764:	4605                	li	a2,1
   10766:	4581                	li	a1,0
   10768:	4531                	li	a0,12
   1076a:	c8dff0ef          	jal	ra,103f6 <sd_cmd>
   1076e:	c83ff0ef          	jal	ra,103f0 <sd_dummy>
   10772:	a805                	j	107a2 <sd_copy+0x13a>
   10774:	c7dff0ef          	jal	ra,103f0 <sd_dummy>
   10778:	c79ff0ef          	jal	ra,103f0 <sd_dummy>
   1077c:	c75ff0ef          	jal	ra,103f0 <sd_dummy>
   10780:	c71ff0ef          	jal	ra,103f0 <sd_dummy>
   10784:	c6dff0ef          	jal	ra,103f0 <sd_dummy>
   10788:	c69ff0ef          	jal	ra,103f0 <sd_dummy>
   1078c:	c65ff0ef          	jal	ra,103f0 <sd_dummy>
   10790:	c61ff0ef          	jal	ra,103f0 <sd_dummy>
   10794:	00001517          	auipc	a0,0x1
   10798:	2b450513          	addi	a0,a0,692 # 11a48 <_BSS_END_+0xd48>
   1079c:	9d7ff0ef          	jal	ra,10172 <print_uart>
   107a0:	547d                	li	s0,-1
   107a2:	8522                	mv	a0,s0
   107a4:	60ae                	ld	ra,200(sp)
   107a6:	640e                	ld	s0,192(sp)
   107a8:	74ea                	ld	s1,184(sp)
   107aa:	794a                	ld	s2,176(sp)
   107ac:	79aa                	ld	s3,168(sp)
   107ae:	7a0a                	ld	s4,160(sp)
   107b0:	6aea                	ld	s5,152(sp)
   107b2:	6b4a                	ld	s6,144(sp)
   107b4:	6baa                	ld	s7,136(sp)
   107b6:	6169                	addi	sp,sp,208
   107b8:	8082                	ret
   107ba:	5479                	li	s0,-2
   107bc:	b765                	j	10764 <sd_copy+0xfc>

00000000000107be <gpt_find_boot_partition>:
   107be:	711d                	addi	sp,sp,-96
   107c0:	e8a2                	sd	s0,80(sp)
   107c2:	f05a                	sd	s6,32(sp)
   107c4:	ec86                	sd	ra,88(sp)
   107c6:	e4a6                	sd	s1,72(sp)
   107c8:	e0ca                	sd	s2,64(sp)
   107ca:	fc4e                	sd	s3,56(sp)
   107cc:	f852                	sd	s4,48(sp)
   107ce:	f456                	sd	s5,40(sp)
   107d0:	ec5e                	sd	s7,24(sp)
   107d2:	e862                	sd	s8,16(sp)
   107d4:	e466                	sd	s9,8(sp)
   107d6:	1080                	addi	s0,sp,96
   107d8:	8b2a                	mv	s6,a0
   107da:	df3ff0ef          	jal	ra,105cc <init_sd>
   107de:	c905                	beqz	a0,1080e <gpt_find_boot_partition+0x50>
   107e0:	00001517          	auipc	a0,0x1
   107e4:	29050513          	addi	a0,a0,656 # 11a70 <_BSS_END_+0xd70>
   107e8:	98bff0ef          	jal	ra,10172 <print_uart>
   107ec:	54fd                	li	s1,-1
   107ee:	fa040113          	addi	sp,s0,-96
   107f2:	60e6                	ld	ra,88(sp)
   107f4:	8526                	mv	a0,s1
   107f6:	6446                	ld	s0,80(sp)
   107f8:	64a6                	ld	s1,72(sp)
   107fa:	6906                	ld	s2,64(sp)
   107fc:	79e2                	ld	s3,56(sp)
   107fe:	7a42                	ld	s4,48(sp)
   10800:	7aa2                	ld	s5,40(sp)
   10802:	7b02                	ld	s6,32(sp)
   10804:	6be2                	ld	s7,24(sp)
   10806:	6c42                	ld	s8,16(sp)
   10808:	6ca2                	ld	s9,8(sp)
   1080a:	6125                	addi	sp,sp,96
   1080c:	8082                	ret
   1080e:	00001517          	auipc	a0,0x1
   10812:	28a50513          	addi	a0,a0,650 # 11a98 <_BSS_END_+0xd98>
   10816:	95dff0ef          	jal	ra,10172 <print_uart>
   1081a:	7101                	addi	sp,sp,-512
   1081c:	4605                	li	a2,1
   1081e:	4585                	li	a1,1
   10820:	850a                	mv	a0,sp
   10822:	e47ff0ef          	jal	ra,10668 <sd_copy>
   10826:	890a                	mv	s2,sp
   10828:	84aa                	mv	s1,a0
   1082a:	c905                	beqz	a0,1085a <gpt_find_boot_partition+0x9c>
   1082c:	00001517          	auipc	a0,0x1
   10830:	28450513          	addi	a0,a0,644 # 11ab0 <_BSS_END_+0xdb0>
   10834:	93fff0ef          	jal	ra,10172 <print_uart>
   10838:	00001517          	auipc	a0,0x1
   1083c:	29050513          	addi	a0,a0,656 # 11ac8 <_BSS_END_+0xdc8>
   10840:	933ff0ef          	jal	ra,10172 <print_uart>
   10844:	8526                	mv	a0,s1
   10846:	9afff0ef          	jal	ra,101f4 <print_uart_addr>
   1084a:	00001517          	auipc	a0,0x1
   1084e:	18e50513          	addi	a0,a0,398 # 119d8 <_BSS_END_+0xcd8>
   10852:	921ff0ef          	jal	ra,10172 <print_uart>
   10856:	54f9                	li	s1,-2
   10858:	bf59                	j	107ee <gpt_find_boot_partition+0x30>
   1085a:	00001517          	auipc	a0,0x1
   1085e:	28650513          	addi	a0,a0,646 # 11ae0 <_BSS_END_+0xde0>
   10862:	911ff0ef          	jal	ra,10172 <print_uart>
   10866:	00001517          	auipc	a0,0x1
   1086a:	29a50513          	addi	a0,a0,666 # 11b00 <_BSS_END_+0xe00>
   1086e:	905ff0ef          	jal	ra,10172 <print_uart>
   10872:	6502                	ld	a0,0(sp)
   10874:	981ff0ef          	jal	ra,101f4 <print_uart_addr>
   10878:	00001517          	auipc	a0,0x1
   1087c:	29850513          	addi	a0,a0,664 # 11b10 <_BSS_END_+0xe10>
   10880:	8f3ff0ef          	jal	ra,10172 <print_uart>
   10884:	4522                	lw	a0,8(sp)
   10886:	92fff0ef          	jal	ra,101b4 <print_uart_int>
   1088a:	00001517          	auipc	a0,0x1
   1088e:	29650513          	addi	a0,a0,662 # 11b20 <_BSS_END_+0xe20>
   10892:	8e1ff0ef          	jal	ra,10172 <print_uart>
   10896:	4532                	lw	a0,12(sp)
   10898:	91dff0ef          	jal	ra,101b4 <print_uart_int>
   1089c:	00001517          	auipc	a0,0x1
   108a0:	29450513          	addi	a0,a0,660 # 11b30 <_BSS_END_+0xe30>
   108a4:	8cfff0ef          	jal	ra,10172 <print_uart>
   108a8:	4542                	lw	a0,16(sp)
   108aa:	90bff0ef          	jal	ra,101b4 <print_uart_int>
   108ae:	00001517          	auipc	a0,0x1
   108b2:	29250513          	addi	a0,a0,658 # 11b40 <_BSS_END_+0xe40>
   108b6:	8bdff0ef          	jal	ra,10172 <print_uart>
   108ba:	4552                	lw	a0,20(sp)
   108bc:	8f9ff0ef          	jal	ra,101b4 <print_uart_int>
   108c0:	00001517          	auipc	a0,0x1
   108c4:	29050513          	addi	a0,a0,656 # 11b50 <_BSS_END_+0xe50>
   108c8:	8abff0ef          	jal	ra,10172 <print_uart>
   108cc:	6562                	ld	a0,24(sp)
   108ce:	927ff0ef          	jal	ra,101f4 <print_uart_addr>
   108d2:	00001517          	auipc	a0,0x1
   108d6:	29650513          	addi	a0,a0,662 # 11b68 <_BSS_END_+0xe68>
   108da:	899ff0ef          	jal	ra,10172 <print_uart>
   108de:	7502                	ld	a0,32(sp)
   108e0:	915ff0ef          	jal	ra,101f4 <print_uart_addr>
   108e4:	00001517          	auipc	a0,0x1
   108e8:	29450513          	addi	a0,a0,660 # 11b78 <_BSS_END_+0xe78>
   108ec:	887ff0ef          	jal	ra,10172 <print_uart>
   108f0:	6526                	ld	a0,72(sp)
   108f2:	903ff0ef          	jal	ra,101f4 <print_uart_addr>
   108f6:	00001517          	auipc	a0,0x1
   108fa:	2a250513          	addi	a0,a0,674 # 11b98 <_BSS_END_+0xe98>
   108fe:	875ff0ef          	jal	ra,10172 <print_uart>
   10902:	4546                	lw	a0,80(sp)
   10904:	8b1ff0ef          	jal	ra,101b4 <print_uart_int>
   10908:	00001517          	auipc	a0,0x1
   1090c:	2b050513          	addi	a0,a0,688 # 11bb8 <_BSS_END_+0xeb8>
   10910:	863ff0ef          	jal	ra,10172 <print_uart>
   10914:	4556                	lw	a0,84(sp)
   10916:	89fff0ef          	jal	ra,101b4 <print_uart_int>
   1091a:	00001517          	auipc	a0,0x1
   1091e:	0be50513          	addi	a0,a0,190 # 119d8 <_BSS_END_+0xcd8>
   10922:	851ff0ef          	jal	ra,10172 <print_uart>
   10926:	04892583          	lw	a1,72(s2) # 2000048 <_RODATA_END_+0x1fee3b0>
   1092a:	7101                	addi	sp,sp,-512
   1092c:	4605                	li	a2,1
   1092e:	850a                	mv	a0,sp
   10930:	d39ff0ef          	jal	ra,10668 <sd_copy>
   10934:	8a8a                	mv	s5,sp
   10936:	84aa                	mv	s1,a0
   10938:	08010993          	addi	s3,sp,128
   1093c:	02010913          	addi	s2,sp,32
   10940:	10051e63          	bnez	a0,10a5c <gpt_find_boot_partition+0x29e>
   10944:	4c41                	li	s8,16
   10946:	4b91                	li	s7,4
   10948:	00001517          	auipc	a0,0x1
   1094c:	29050513          	addi	a0,a0,656 # 11bd8 <_BSS_END_+0xed8>
   10950:	823ff0ef          	jal	ra,10172 <print_uart>
   10954:	0ff4f513          	andi	a0,s1,255
   10958:	8dfff0ef          	jal	ra,10236 <print_uart_byte>
   1095c:	00001517          	auipc	a0,0x1
   10960:	29450513          	addi	a0,a0,660 # 11bf0 <_BSS_END_+0xef0>
   10964:	f8098c93          	addi	s9,s3,-128
   10968:	80bff0ef          	jal	ra,10172 <print_uart>
   1096c:	4a01                	li	s4,0
   1096e:	014c87b3          	add	a5,s9,s4
   10972:	0007c503          	lbu	a0,0(a5)
   10976:	0a05                	addi	s4,s4,1
   10978:	8bfff0ef          	jal	ra,10236 <print_uart_byte>
   1097c:	ff8a19e3          	bne	s4,s8,1096e <gpt_find_boot_partition+0x1b0>
   10980:	00001517          	auipc	a0,0x1
   10984:	29050513          	addi	a0,a0,656 # 11c10 <_BSS_END_+0xf10>
   10988:	feaff0ef          	jal	ra,10172 <print_uart>
   1098c:	f9098a13          	addi	s4,s3,-112
   10990:	000a4503          	lbu	a0,0(s4)
   10994:	0a05                	addi	s4,s4,1
   10996:	8a1ff0ef          	jal	ra,10236 <print_uart_byte>
   1099a:	ff2a1be3          	bne	s4,s2,10990 <gpt_find_boot_partition+0x1d2>
   1099e:	00001517          	auipc	a0,0x1
   109a2:	29250513          	addi	a0,a0,658 # 11c30 <_BSS_END_+0xf30>
   109a6:	fccff0ef          	jal	ra,10172 <print_uart>
   109aa:	00093503          	ld	a0,0(s2)
   109ae:	fb898a13          	addi	s4,s3,-72
   109b2:	843ff0ef          	jal	ra,101f4 <print_uart_addr>
   109b6:	00001517          	auipc	a0,0x1
   109ba:	28a50513          	addi	a0,a0,650 # 11c40 <_BSS_END_+0xf40>
   109be:	fb4ff0ef          	jal	ra,10172 <print_uart>
   109c2:	00893503          	ld	a0,8(s2)
   109c6:	82fff0ef          	jal	ra,101f4 <print_uart_addr>
   109ca:	00001517          	auipc	a0,0x1
   109ce:	28650513          	addi	a0,a0,646 # 11c50 <_BSS_END_+0xf50>
   109d2:	fa0ff0ef          	jal	ra,10172 <print_uart>
   109d6:	01093503          	ld	a0,16(s2)
   109da:	81bff0ef          	jal	ra,101f4 <print_uart_addr>
   109de:	00001517          	auipc	a0,0x1
   109e2:	28250513          	addi	a0,a0,642 # 11c60 <_BSS_END_+0xf60>
   109e6:	f8cff0ef          	jal	ra,10172 <print_uart>
   109ea:	000a4503          	lbu	a0,0(s4)
   109ee:	0a05                	addi	s4,s4,1
   109f0:	847ff0ef          	jal	ra,10236 <print_uart_byte>
   109f4:	ff499be3          	bne	s3,s4,109ea <gpt_find_boot_partition+0x22c>
   109f8:	00001517          	auipc	a0,0x1
   109fc:	fe050513          	addi	a0,a0,-32 # 119d8 <_BSS_END_+0xcd8>
   10a00:	2485                	addiw	s1,s1,1
   10a02:	f70ff0ef          	jal	ra,10172 <print_uart>
   10a06:	08098993          	addi	s3,s3,128
   10a0a:	08090913          	addi	s2,s2,128
   10a0e:	f3749de3          	bne	s1,s7,10948 <gpt_find_boot_partition+0x18a>
   10a12:	00001517          	auipc	a0,0x1
   10a16:	25e50513          	addi	a0,a0,606 # 11c70 <_BSS_END_+0xf70>
   10a1a:	f58ff0ef          	jal	ra,10172 <print_uart>
   10a1e:	028ab603          	ld	a2,40(s5)
   10a22:	020aa583          	lw	a1,32(s5)
   10a26:	855a                	mv	a0,s6
   10a28:	2605                	addiw	a2,a2,1
   10a2a:	9e0d                	subw	a2,a2,a1
   10a2c:	c3dff0ef          	jal	ra,10668 <sd_copy>
   10a30:	84aa                	mv	s1,a0
   10a32:	c929                	beqz	a0,10a84 <gpt_find_boot_partition+0x2c6>
   10a34:	00001517          	auipc	a0,0x1
   10a38:	07c50513          	addi	a0,a0,124 # 11ab0 <_BSS_END_+0xdb0>
   10a3c:	f36ff0ef          	jal	ra,10172 <print_uart>
   10a40:	00001517          	auipc	a0,0x1
   10a44:	08850513          	addi	a0,a0,136 # 11ac8 <_BSS_END_+0xdc8>
   10a48:	f2aff0ef          	jal	ra,10172 <print_uart>
   10a4c:	8526                	mv	a0,s1
   10a4e:	fa6ff0ef          	jal	ra,101f4 <print_uart_addr>
   10a52:	00001517          	auipc	a0,0x1
   10a56:	f8650513          	addi	a0,a0,-122 # 119d8 <_BSS_END_+0xcd8>
   10a5a:	bbe5                	j	10852 <gpt_find_boot_partition+0x94>
   10a5c:	00001517          	auipc	a0,0x1
   10a60:	05450513          	addi	a0,a0,84 # 11ab0 <_BSS_END_+0xdb0>
   10a64:	f0eff0ef          	jal	ra,10172 <print_uart>
   10a68:	00001517          	auipc	a0,0x1
   10a6c:	06050513          	addi	a0,a0,96 # 11ac8 <_BSS_END_+0xdc8>
   10a70:	f02ff0ef          	jal	ra,10172 <print_uart>
   10a74:	8526                	mv	a0,s1
   10a76:	f7eff0ef          	jal	ra,101f4 <print_uart_addr>
   10a7a:	00001517          	auipc	a0,0x1
   10a7e:	f5e50513          	addi	a0,a0,-162 # 119d8 <_BSS_END_+0xcd8>
   10a82:	bbc1                	j	10852 <gpt_find_boot_partition+0x94>
   10a84:	00001517          	auipc	a0,0x1
   10a88:	20450513          	addi	a0,a0,516 # 11c88 <_BSS_END_+0xf88>
   10a8c:	ee6ff0ef          	jal	ra,10172 <print_uart>
   10a90:	bbb9                	j	107ee <gpt_find_boot_partition+0x30>

0000000000010a92 <write_gpio>:
   10a92:	00b50023          	sb	a1,0(a0)
   10a96:	8082                	ret

0000000000010a98 <read_gpio>:
   10a98:	00054503          	lbu	a0,0(a0)
   10a9c:	8082                	ret

0000000000010a9e <init_gpio>:
   10a9e:	400007b7          	lui	a5,0x40000
   10aa2:	00078223          	sb	zero,4(a5) # 40000004 <_RODATA_END_+0x3ffee36c>
   10aa6:	477d                	li	a4,31
   10aa8:	00e78623          	sb	a4,12(a5)
   10aac:	8082                	ret

Disassembly of section .text.startup:

0000000000010aae <main>:
   10aae:	65f1                	lui	a1,0x1c
   10ab0:	02faf537          	lui	a0,0x2faf
   10ab4:	711d                	addi	sp,sp,-96
   10ab6:	20058593          	addi	a1,a1,512 # 1c200 <_RODATA_END_+0xa568>
   10aba:	08050513          	addi	a0,a0,128 # 2faf080 <_RODATA_END_+0x2f9d3e8>
   10abe:	ec86                	sd	ra,88(sp)
   10ac0:	e8a2                	sd	s0,80(sp)
   10ac2:	e4a6                	sd	s1,72(sp)
   10ac4:	e0ca                	sd	s2,64(sp)
   10ac6:	e68ff0ef          	jal	ra,1012e <init_uart>
   10aca:	00001517          	auipc	a0,0x1
   10ace:	e2e50513          	addi	a0,a0,-466 # 118f8 <_BSS_END_+0xbf8>
   10ad2:	547d                	li	s0,-1
   10ad4:	e9eff0ef          	jal	ra,10172 <print_uart>
   10ad8:	03f00913          	li	s2,63
   10adc:	fc3ff0ef          	jal	ra,10a9e <init_gpio>
   10ae0:	147e                	slli	s0,s0,0x3f
   10ae2:	4485                	li	s1,1
   10ae4:	01210723          	sb	s2,14(sp)
   10ae8:	000107a3          	sb	zero,15(sp)
   10aec:	fc22                	sd	s0,56(sp)
   10aee:	f826                	sd	s1,48(sp)
   10af0:	b0003a73          	csrrc	s4,mcycle,zero
   10af4:	00f14783          	lbu	a5,15(sp)
   10af8:	0ff7f793          	andi	a5,a5,255
   10afc:	e399                	bnez	a5,10b02 <main+0x54>
   10afe:	77e2                	ld	a5,56(sp)
   10b00:	ebd9                	bnez	a5,10b96 <main+0xe8>
   10b02:	b0003af3          	csrrc	s5,mcycle,zero
   10b06:	414a8a33          	sub	s4,s5,s4
   10b0a:	e852                	sd	s4,16(sp)
   10b0c:	4485                	li	s1,1
   10b0e:	b0003b73          	csrrc	s6,mcycle,zero
   10b12:	012489ab          	0x12489ab
   10b16:	b0003bf3          	csrrc	s7,mcycle,zero
   10b1a:	416b8b33          	sub	s6,s7,s6
   10b1e:	036a5c33          	divu	s8,s4,s6
   10b22:	ec5a                	sd	s6,24(sp)
   10b24:	f062                	sd	s8,32(sp)
   10b26:	f44e                	sd	s3,40(sp)
   10b28:	00001517          	auipc	a0,0x1
   10b2c:	de050513          	addi	a0,a0,-544 # 11908 <_BSS_END_+0xc08>
   10b30:	e42ff0ef          	jal	ra,10172 <print_uart>
   10b34:	00001517          	auipc	a0,0x1
   10b38:	df450513          	addi	a0,a0,-524 # 11928 <_BSS_END_+0xc28>
   10b3c:	e36ff0ef          	jal	ra,10172 <print_uart>
   10b40:	00e14503          	lbu	a0,14(sp)
   10b44:	ef2ff0ef          	jal	ra,10236 <print_uart_byte>
   10b48:	00001517          	auipc	a0,0x1
   10b4c:	df050513          	addi	a0,a0,-528 # 11938 <_BSS_END_+0xc38>
   10b50:	e22ff0ef          	jal	ra,10172 <print_uart>
   10b54:	7522                	ld	a0,40(sp)
   10b56:	0ff57513          	andi	a0,a0,255
   10b5a:	edcff0ef          	jal	ra,10236 <print_uart_byte>
   10b5e:	00001517          	auipc	a0,0x1
   10b62:	dfa50513          	addi	a0,a0,-518 # 11958 <_BSS_END_+0xc58>
   10b66:	e0cff0ef          	jal	ra,10172 <print_uart>
   10b6a:	6542                	ld	a0,16(sp)
   10b6c:	e88ff0ef          	jal	ra,101f4 <print_uart_addr>
   10b70:	00001517          	auipc	a0,0x1
   10b74:	e0050513          	addi	a0,a0,-512 # 11970 <_BSS_END_+0xc70>
   10b78:	dfaff0ef          	jal	ra,10172 <print_uart>
   10b7c:	6562                	ld	a0,24(sp)
   10b7e:	e76ff0ef          	jal	ra,101f4 <print_uart_addr>
   10b82:	00001517          	auipc	a0,0x1
   10b86:	e0e50513          	addi	a0,a0,-498 # 11990 <_BSS_END_+0xc90>
   10b8a:	de8ff0ef          	jal	ra,10172 <print_uart>
   10b8e:	7502                	ld	a0,32(sp)
   10b90:	e64ff0ef          	jal	ra,101f4 <print_uart_addr>
   10b94:	bf81                	j	10ae4 <main+0x36>
   10b96:	77e2                	ld	a5,56(sp)
   10b98:	7742                	ld	a4,48(sp)
   10b9a:	8ff9                	and	a5,a5,a4
   10b9c:	00979563          	bne	a5,s1,10ba6 <main+0xf8>
   10ba0:	009107a3          	sb	s1,15(sp)
   10ba4:	bf81                	j	10af4 <main+0x46>
   10ba6:	77e2                	ld	a5,56(sp)
   10ba8:	8385                	srli	a5,a5,0x1
   10baa:	fc3e                	sd	a5,56(sp)
   10bac:	00e14783          	lbu	a5,14(sp)
   10bb0:	37fd                	addiw	a5,a5,-1
   10bb2:	0ff7f793          	andi	a5,a5,255
   10bb6:	00f10723          	sb	a5,14(sp)
   10bba:	bf2d                	j	10af4 <main+0x46>
