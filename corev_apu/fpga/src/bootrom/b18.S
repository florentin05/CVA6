
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
   1001c:	295000ef          	jal	ra,10ab0 <_TEXT_END_>
   10020:	020004b7          	lui	s1,0x2000
   10024:	00100913          	li	s2,1
   10028:	0124a023          	sw	s2,0(s1) # 2000000 <_RODATA_END_+0x1fee408>
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
   1005c:	00092023          	sw	zero,0(s2) # 2000000 <_RODATA_END_+0x1fee408>
   10060:	0004a903          	lw	s2,0(s1) # 2000000 <_RODATA_END_+0x1fee408>
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
   10112:	0147c503          	lbu	a0,20(a5) # 10000014 <_RODATA_END_+0xffee41c>
   10116:	02057513          	andi	a0,a0,32
   1011a:	8082                	ret

000000000001011c <write_serial>:
   1011c:	10000737          	lui	a4,0x10000
   10120:	01474783          	lbu	a5,20(a4) # 10000014 <_RODATA_END_+0xffee41c>
   10124:	0207f793          	andi	a5,a5,32
   10128:	dfe5                	beqz	a5,10120 <write_serial+0x4>
   1012a:	00a70023          	sb	a0,0(a4)
   1012e:	8082                	ret

0000000000010130 <init_uart>:
   10130:	0045959b          	slliw	a1,a1,0x4
   10134:	02b5553b          	divuw	a0,a0,a1
   10138:	100007b7          	lui	a5,0x10000
   1013c:	00078223          	sb	zero,4(a5) # 10000004 <_RODATA_END_+0xffee40c>
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
   10174:	1141                	addi	sp,sp,-16
   10176:	e022                	sd	s0,0(sp)
   10178:	e406                	sd	ra,8(sp)
   1017a:	842a                	mv	s0,a0
   1017c:	00044503          	lbu	a0,0(s0)
   10180:	e509                	bnez	a0,1018a <print_uart+0x16>
   10182:	60a2                	ld	ra,8(sp)
   10184:	6402                	ld	s0,0(sp)
   10186:	0141                	addi	sp,sp,16
   10188:	8082                	ret
   1018a:	f93ff0ef          	jal	ra,1011c <write_serial>
   1018e:	0405                	addi	s0,s0,1
   10190:	b7f5                	j	1017c <print_uart+0x8>

0000000000010192 <bin_to_hex>:
   10192:	00001797          	auipc	a5,0x1
   10196:	a6e78793          	addi	a5,a5,-1426 # 10c00 <bin_to_hex_table>
   1019a:	00f57713          	andi	a4,a0,15
   1019e:	973e                	add	a4,a4,a5
   101a0:	00074703          	lbu	a4,0(a4)
   101a4:	8111                	srli	a0,a0,0x4
   101a6:	97aa                	add	a5,a5,a0
   101a8:	00e580a3          	sb	a4,1(a1)
   101ac:	0007c783          	lbu	a5,0(a5)
   101b0:	00f58023          	sb	a5,0(a1)
   101b4:	8082                	ret

00000000000101b6 <print_uart_int>:
   101b6:	7179                	addi	sp,sp,-48
   101b8:	f022                	sd	s0,32(sp)
   101ba:	ec26                	sd	s1,24(sp)
   101bc:	e84a                	sd	s2,16(sp)
   101be:	f406                	sd	ra,40(sp)
   101c0:	892a                	mv	s2,a0
   101c2:	4461                	li	s0,24
   101c4:	54e1                	li	s1,-8
   101c6:	0089553b          	srlw	a0,s2,s0
   101ca:	002c                	addi	a1,sp,8
   101cc:	0ff57513          	andi	a0,a0,255
   101d0:	fc3ff0ef          	jal	ra,10192 <bin_to_hex>
   101d4:	00814503          	lbu	a0,8(sp)
   101d8:	3461                	addiw	s0,s0,-8
   101da:	f43ff0ef          	jal	ra,1011c <write_serial>
   101de:	00914503          	lbu	a0,9(sp)
   101e2:	f3bff0ef          	jal	ra,1011c <write_serial>
   101e6:	fe9410e3          	bne	s0,s1,101c6 <print_uart_int+0x10>
   101ea:	70a2                	ld	ra,40(sp)
   101ec:	7402                	ld	s0,32(sp)
   101ee:	64e2                	ld	s1,24(sp)
   101f0:	6942                	ld	s2,16(sp)
   101f2:	6145                	addi	sp,sp,48
   101f4:	8082                	ret

00000000000101f6 <print_uart_addr>:
   101f6:	7179                	addi	sp,sp,-48
   101f8:	f022                	sd	s0,32(sp)
   101fa:	ec26                	sd	s1,24(sp)
   101fc:	e84a                	sd	s2,16(sp)
   101fe:	f406                	sd	ra,40(sp)
   10200:	892a                	mv	s2,a0
   10202:	03800413          	li	s0,56
   10206:	54e1                	li	s1,-8
   10208:	00895533          	srl	a0,s2,s0
   1020c:	002c                	addi	a1,sp,8
   1020e:	0ff57513          	andi	a0,a0,255
   10212:	f81ff0ef          	jal	ra,10192 <bin_to_hex>
   10216:	00814503          	lbu	a0,8(sp)
   1021a:	3461                	addiw	s0,s0,-8
   1021c:	f01ff0ef          	jal	ra,1011c <write_serial>
   10220:	00914503          	lbu	a0,9(sp)
   10224:	ef9ff0ef          	jal	ra,1011c <write_serial>
   10228:	fe9410e3          	bne	s0,s1,10208 <print_uart_addr+0x12>
   1022c:	70a2                	ld	ra,40(sp)
   1022e:	7402                	ld	s0,32(sp)
   10230:	64e2                	ld	s1,24(sp)
   10232:	6942                	ld	s2,16(sp)
   10234:	6145                	addi	sp,sp,48
   10236:	8082                	ret

0000000000010238 <print_uart_byte>:
   10238:	1101                	addi	sp,sp,-32
   1023a:	002c                	addi	a1,sp,8
   1023c:	ec06                	sd	ra,24(sp)
   1023e:	f55ff0ef          	jal	ra,10192 <bin_to_hex>
   10242:	00814503          	lbu	a0,8(sp)
   10246:	ed7ff0ef          	jal	ra,1011c <write_serial>
   1024a:	00914503          	lbu	a0,9(sp)
   1024e:	ecfff0ef          	jal	ra,1011c <write_serial>
   10252:	60e2                	ld	ra,24(sp)
   10254:	6105                	addi	sp,sp,32
   10256:	8082                	ret

0000000000010258 <write_reg>:
   10258:	c10c                	sw	a1,0(a0)
   1025a:	8082                	ret

000000000001025c <read_reg>:
   1025c:	4108                	lw	a0,0(a0)
   1025e:	2501                	sext.w	a0,a0
   10260:	8082                	ret

0000000000010262 <spi_init>:
   10262:	00001517          	auipc	a0,0x1
   10266:	1101                	addi	sp,sp,-32
   10268:	6a650513          	addi	a0,a0,1702 # 11908 <_BSS_END_+0xc08>
   1026c:	ec06                	sd	ra,24(sp)
   1026e:	e822                	sd	s0,16(sp)
   10270:	e426                	sd	s1,8(sp)
   10272:	f03ff0ef          	jal	ra,10174 <print_uart>
   10276:	200007b7          	lui	a5,0x20000
   1027a:	4729                	li	a4,10
   1027c:	c3b8                	sw	a4,64(a5)
   1027e:	47a9                	li	a5,10
   10280:	0001                	nop
   10282:	37fd                	addiw	a5,a5,-1
   10284:	fff5                	bnez	a5,10280 <spi_init+0x1e>
   10286:	20000437          	lui	s0,0x20000
   1028a:	10400793          	li	a5,260
   1028e:	d03c                	sw	a5,96(s0)
   10290:	5064                	lw	s1,100(s0)
   10292:	00001517          	auipc	a0,0x1
   10296:	68650513          	addi	a0,a0,1670 # 11918 <_BSS_END_+0xc18>
   1029a:	edbff0ef          	jal	ra,10174 <print_uart>
   1029e:	2481                	sext.w	s1,s1
   102a0:	02049513          	slli	a0,s1,0x20
   102a4:	9101                	srli	a0,a0,0x20
   102a6:	f51ff0ef          	jal	ra,101f6 <print_uart_addr>
   102aa:	00001517          	auipc	a0,0x1
   102ae:	68e50513          	addi	a0,a0,1678 # 11938 <_BSS_END_+0xc38>
   102b2:	ec3ff0ef          	jal	ra,10174 <print_uart>
   102b6:	16600793          	li	a5,358
   102ba:	d03c                	sw	a5,96(s0)
   102bc:	5064                	lw	s1,100(s0)
   102be:	00001517          	auipc	a0,0x1
   102c2:	65a50513          	addi	a0,a0,1626 # 11918 <_BSS_END_+0xc18>
   102c6:	eafff0ef          	jal	ra,10174 <print_uart>
   102ca:	2481                	sext.w	s1,s1
   102cc:	02049513          	slli	a0,s1,0x20
   102d0:	9101                	srli	a0,a0,0x20
   102d2:	f25ff0ef          	jal	ra,101f6 <print_uart_addr>
   102d6:	00001517          	auipc	a0,0x1
   102da:	66250513          	addi	a0,a0,1634 # 11938 <_BSS_END_+0xc38>
   102de:	e97ff0ef          	jal	ra,10174 <print_uart>
   102e2:	4799                	li	a5,6
   102e4:	d03c                	sw	a5,96(s0)
   102e6:	6442                	ld	s0,16(sp)
   102e8:	60e2                	ld	ra,24(sp)
   102ea:	64a2                	ld	s1,8(sp)
   102ec:	00001517          	auipc	a0,0x1
   102f0:	63c50513          	addi	a0,a0,1596 # 11928 <_BSS_END_+0xc28>
   102f4:	6105                	addi	sp,sp,32
   102f6:	bdbd                	j	10174 <print_uart>

00000000000102f8 <spi_txrx>:
   102f8:	1101                	addi	sp,sp,-32
   102fa:	200007b7          	lui	a5,0x20000
   102fe:	ec06                	sd	ra,24(sp)
   10300:	e822                	sd	s0,16(sp)
   10302:	e426                	sd	s1,8(sp)
   10304:	5779                	li	a4,-2
   10306:	dbb8                	sw	a4,112(a5)
   10308:	d7a8                	sw	a0,104(a5)
   1030a:	06400793          	li	a5,100
   1030e:	0001                	nop
   10310:	37fd                	addiw	a5,a5,-1
   10312:	fff5                	bnez	a5,1030e <spi_txrx+0x16>
   10314:	200007b7          	lui	a5,0x20000
   10318:	10600713          	li	a4,262
   1031c:	d3b8                	sw	a4,96(a5)
   1031e:	53f8                	lw	a4,100(a5)
   10320:	06478493          	addi	s1,a5,100 # 20000064 <_RODATA_END_+0x1ffee46c>
   10324:	8b05                	andi	a4,a4,1
   10326:	ff65                	bnez	a4,1031e <spi_txrx+0x26>
   10328:	57e0                	lw	s0,108(a5)
   1032a:	53fc                	lw	a5,100(a5)
   1032c:	2401                	sext.w	s0,s0
   1032e:	8b85                	andi	a5,a5,1
   10330:	e395                	bnez	a5,10354 <spi_txrx+0x5c>
   10332:	00001517          	auipc	a0,0x1
   10336:	60e50513          	addi	a0,a0,1550 # 11940 <_BSS_END_+0xc40>
   1033a:	e3bff0ef          	jal	ra,10174 <print_uart>
   1033e:	4088                	lw	a0,0(s1)
   10340:	1502                	slli	a0,a0,0x20
   10342:	9101                	srli	a0,a0,0x20
   10344:	eb3ff0ef          	jal	ra,101f6 <print_uart_addr>
   10348:	00001517          	auipc	a0,0x1
   1034c:	5f050513          	addi	a0,a0,1520 # 11938 <_BSS_END_+0xc38>
   10350:	e25ff0ef          	jal	ra,10174 <print_uart>
   10354:	200007b7          	lui	a5,0x20000
   10358:	577d                	li	a4,-1
   1035a:	0ff47513          	andi	a0,s0,255
   1035e:	60e2                	ld	ra,24(sp)
   10360:	6442                	ld	s0,16(sp)
   10362:	dbb8                	sw	a4,112(a5)
   10364:	4719                	li	a4,6
   10366:	d3b8                	sw	a4,96(a5)
   10368:	64a2                	ld	s1,8(sp)
   1036a:	6105                	addi	sp,sp,32
   1036c:	8082                	ret

000000000001036e <spi_write_bytes>:
   1036e:	10000793          	li	a5,256
   10372:	06b7ee63          	bltu	a5,a1,103ee <spi_write_bytes+0x80>
   10376:	200007b7          	lui	a5,0x20000
   1037a:	5779                	li	a4,-2
   1037c:	dbb8                	sw	a4,112(a5)
   1037e:	200006b7          	lui	a3,0x20000
   10382:	4781                	li	a5,0
   10384:	0007871b          	sext.w	a4,a5
   10388:	04b76163          	bltu	a4,a1,103ca <spi_write_bytes+0x5c>
   1038c:	03200793          	li	a5,50
   10390:	0001                	nop
   10392:	37fd                	addiw	a5,a5,-1
   10394:	fff5                	bnez	a5,10390 <spi_write_bytes+0x22>
   10396:	10600713          	li	a4,262
   1039a:	200007b7          	lui	a5,0x20000
   1039e:	d3b8                	sw	a4,96(a5)
   103a0:	20000737          	lui	a4,0x20000
   103a4:	537c                	lw	a5,100(a4)
   103a6:	8b85                	andi	a5,a5,1
   103a8:	fff5                	bnez	a5,103a4 <spi_write_bytes+0x36>
   103aa:	20000537          	lui	a0,0x20000
   103ae:	20000837          	lui	a6,0x20000
   103b2:	0007869b          	sext.w	a3,a5
   103b6:	02b6e163          	bltu	a3,a1,103d8 <spi_write_bytes+0x6a>
   103ba:	200007b7          	lui	a5,0x20000
   103be:	577d                	li	a4,-1
   103c0:	dbb8                	sw	a4,112(a5)
   103c2:	4719                	li	a4,6
   103c4:	d3b8                	sw	a4,96(a5)
   103c6:	4501                	li	a0,0
   103c8:	8082                	ret
   103ca:	00f50733          	add	a4,a0,a5
   103ce:	00074703          	lbu	a4,0(a4) # 20000000 <_RODATA_END_+0x1ffee408>
   103d2:	0785                	addi	a5,a5,1
   103d4:	d6b8                	sw	a4,104(a3)
   103d6:	b77d                	j	10384 <spi_write_bytes+0x16>
   103d8:	5178                	lw	a4,100(a0)
   103da:	8b05                	andi	a4,a4,1
   103dc:	ff69                	bnez	a4,103b6 <spi_write_bytes+0x48>
   103de:	06c82683          	lw	a3,108(a6) # 2000006c <_RODATA_END_+0x1ffee474>
   103e2:	00f60733          	add	a4,a2,a5
   103e6:	0785                	addi	a5,a5,1
   103e8:	00d70023          	sb	a3,0(a4)
   103ec:	b7d9                	j	103b2 <spi_write_bytes+0x44>
   103ee:	557d                	li	a0,-1
   103f0:	8082                	ret

00000000000103f2 <sd_dummy>:
   103f2:	0ff00513          	li	a0,255
   103f6:	b709                	j	102f8 <spi_txrx>

00000000000103f8 <sd_cmd>:
   103f8:	7179                	addi	sp,sp,-48
   103fa:	f406                	sd	ra,40(sp)
   103fc:	e432                	sd	a2,8(sp)
   103fe:	f022                	sd	s0,32(sp)
   10400:	ec26                	sd	s1,24(sp)
   10402:	842e                	mv	s0,a1
   10404:	84aa                	mv	s1,a0
   10406:	fedff0ef          	jal	ra,103f2 <sd_dummy>
   1040a:	0404e513          	ori	a0,s1,64
   1040e:	eebff0ef          	jal	ra,102f8 <spi_txrx>
   10412:	0184551b          	srliw	a0,s0,0x18
   10416:	ee3ff0ef          	jal	ra,102f8 <spi_txrx>
   1041a:	0104551b          	srliw	a0,s0,0x10
   1041e:	0ff57513          	andi	a0,a0,255
   10422:	ed7ff0ef          	jal	ra,102f8 <spi_txrx>
   10426:	0084551b          	srliw	a0,s0,0x8
   1042a:	0ff57513          	andi	a0,a0,255
   1042e:	ecbff0ef          	jal	ra,102f8 <spi_txrx>
   10432:	0ff47513          	andi	a0,s0,255
   10436:	ec3ff0ef          	jal	ra,102f8 <spi_txrx>
   1043a:	6622                	ld	a2,8(sp)
   1043c:	06400413          	li	s0,100
   10440:	8532                	mv	a0,a2
   10442:	eb7ff0ef          	jal	ra,102f8 <spi_txrx>
   10446:	fadff0ef          	jal	ra,103f2 <sd_dummy>
   1044a:	0185179b          	slliw	a5,a0,0x18
   1044e:	4187d79b          	sraiw	a5,a5,0x18
   10452:	0007d463          	bgez	a5,1045a <sd_cmd+0x62>
   10456:	147d                	addi	s0,s0,-1
   10458:	f47d                	bnez	s0,10446 <sd_cmd+0x4e>
   1045a:	70a2                	ld	ra,40(sp)
   1045c:	7402                	ld	s0,32(sp)
   1045e:	64e2                	ld	s1,24(sp)
   10460:	6145                	addi	sp,sp,48
   10462:	8082                	ret

0000000000010464 <print_status>:
   10464:	1101                	addi	sp,sp,-32
   10466:	e822                	sd	s0,16(sp)
   10468:	842a                	mv	s0,a0
   1046a:	00001517          	auipc	a0,0x1
   1046e:	4ee50513          	addi	a0,a0,1262 # 11958 <_BSS_END_+0xc58>
   10472:	ec06                	sd	ra,24(sp)
   10474:	e42e                	sd	a1,8(sp)
   10476:	cffff0ef          	jal	ra,10174 <print_uart>
   1047a:	8522                	mv	a0,s0
   1047c:	cf9ff0ef          	jal	ra,10174 <print_uart>
   10480:	00001517          	auipc	a0,0x1
   10484:	4e850513          	addi	a0,a0,1256 # 11968 <_BSS_END_+0xc68>
   10488:	cedff0ef          	jal	ra,10174 <print_uart>
   1048c:	65a2                	ld	a1,8(sp)
   1048e:	852e                	mv	a0,a1
   10490:	da9ff0ef          	jal	ra,10238 <print_uart_byte>
   10494:	6442                	ld	s0,16(sp)
   10496:	60e2                	ld	ra,24(sp)
   10498:	00001517          	auipc	a0,0x1
   1049c:	4a050513          	addi	a0,a0,1184 # 11938 <_BSS_END_+0xc38>
   104a0:	6105                	addi	sp,sp,32
   104a2:	b9c9                	j	10174 <print_uart>

00000000000104a4 <sd_cmd0>:
   104a4:	1101                	addi	sp,sp,-32
   104a6:	e822                	sd	s0,16(sp)
   104a8:	6409                	lui	s0,0x2
   104aa:	e426                	sd	s1,8(sp)
   104ac:	ec06                	sd	ra,24(sp)
   104ae:	e04a                	sd	s2,0(sp)
   104b0:	71040413          	addi	s0,s0,1808 # 2710 <ROM_BASE-0xd8f0>
   104b4:	4485                	li	s1,1
   104b6:	09500613          	li	a2,149
   104ba:	4581                	li	a1,0
   104bc:	4501                	li	a0,0
   104be:	f3bff0ef          	jal	ra,103f8 <sd_cmd>
   104c2:	347d                	addiw	s0,s0,-1
   104c4:	892a                	mv	s2,a0
   104c6:	f2dff0ef          	jal	ra,103f2 <sd_dummy>
   104ca:	c00d                	beqz	s0,104ec <sd_cmd0+0x48>
   104cc:	fe9915e3          	bne	s2,s1,104b6 <sd_cmd0+0x12>
   104d0:	00001517          	auipc	a0,0x1
   104d4:	4a850513          	addi	a0,a0,1192 # 11978 <_BSS_END_+0xc78>
   104d8:	4585                	li	a1,1
   104da:	f8bff0ef          	jal	ra,10464 <print_status>
   104de:	4505                	li	a0,1
   104e0:	60e2                	ld	ra,24(sp)
   104e2:	6442                	ld	s0,16(sp)
   104e4:	64a2                	ld	s1,8(sp)
   104e6:	6902                	ld	s2,0(sp)
   104e8:	6105                	addi	sp,sp,32
   104ea:	8082                	ret
   104ec:	4501                	li	a0,0
   104ee:	bfcd                	j	104e0 <sd_cmd0+0x3c>

00000000000104f0 <sd_cmd8>:
   104f0:	1101                	addi	sp,sp,-32
   104f2:	08700613          	li	a2,135
   104f6:	1aa00593          	li	a1,426
   104fa:	4521                	li	a0,8
   104fc:	ec06                	sd	ra,24(sp)
   104fe:	e822                	sd	s0,16(sp)
   10500:	e426                	sd	s1,8(sp)
   10502:	e04a                	sd	s2,0(sp)
   10504:	ef5ff0ef          	jal	ra,103f8 <sd_cmd>
   10508:	892a                	mv	s2,a0
   1050a:	ee9ff0ef          	jal	ra,103f2 <sd_dummy>
   1050e:	ee5ff0ef          	jal	ra,103f2 <sd_dummy>
   10512:	ee1ff0ef          	jal	ra,103f2 <sd_dummy>
   10516:	84aa                	mv	s1,a0
   10518:	edbff0ef          	jal	ra,103f2 <sd_dummy>
   1051c:	842a                	mv	s0,a0
   1051e:	ed5ff0ef          	jal	ra,103f2 <sd_dummy>
   10522:	ed1ff0ef          	jal	ra,103f2 <sd_dummy>
   10526:	4785                	li	a5,1
   10528:	4501                	li	a0,0
   1052a:	00f91b63          	bne	s2,a5,10540 <sd_cmd8+0x50>
   1052e:	88bd                	andi	s1,s1,15
   10530:	01249863          	bne	s1,s2,10540 <sd_cmd8+0x50>
   10534:	0004051b          	sext.w	a0,s0
   10538:	f5650513          	addi	a0,a0,-170
   1053c:	00153513          	seqz	a0,a0
   10540:	60e2                	ld	ra,24(sp)
   10542:	6442                	ld	s0,16(sp)
   10544:	64a2                	ld	s1,8(sp)
   10546:	6902                	ld	s2,0(sp)
   10548:	6105                	addi	sp,sp,32
   1054a:	8082                	ret

000000000001054c <sd_cmd55>:
   1054c:	1141                	addi	sp,sp,-16
   1054e:	06500613          	li	a2,101
   10552:	4581                	li	a1,0
   10554:	03700513          	li	a0,55
   10558:	e406                	sd	ra,8(sp)
   1055a:	e022                	sd	s0,0(sp)
   1055c:	e9dff0ef          	jal	ra,103f8 <sd_cmd>
   10560:	842a                	mv	s0,a0
   10562:	e91ff0ef          	jal	ra,103f2 <sd_dummy>
   10566:	00001517          	auipc	a0,0x1
   1056a:	85a2                	mv	a1,s0
   1056c:	41a50513          	addi	a0,a0,1050 # 11980 <_BSS_END_+0xc80>
   10570:	ef5ff0ef          	jal	ra,10464 <print_status>
   10574:	0004051b          	sext.w	a0,s0
   10578:	60a2                	ld	ra,8(sp)
   1057a:	6402                	ld	s0,0(sp)
   1057c:	157d                	addi	a0,a0,-1
   1057e:	00153513          	seqz	a0,a0
   10582:	0141                	addi	sp,sp,16
   10584:	8082                	ret

0000000000010586 <sd_acmd41>:
   10586:	1101                	addi	sp,sp,-32
   10588:	e426                	sd	s1,8(sp)
   1058a:	ec06                	sd	ra,24(sp)
   1058c:	e822                	sd	s0,16(sp)
   1058e:	4485                	li	s1,1
   10590:	fbdff0ef          	jal	ra,1054c <sd_cmd55>
   10594:	07700613          	li	a2,119
   10598:	400005b7          	lui	a1,0x40000
   1059c:	02900513          	li	a0,41
   105a0:	e59ff0ef          	jal	ra,103f8 <sd_cmd>
   105a4:	842a                	mv	s0,a0
   105a6:	85aa                	mv	a1,a0
   105a8:	00001517          	auipc	a0,0x1
   105ac:	3e050513          	addi	a0,a0,992 # 11988 <_BSS_END_+0xc88>
   105b0:	eb5ff0ef          	jal	ra,10464 <print_status>
   105b4:	e3fff0ef          	jal	ra,103f2 <sd_dummy>
   105b8:	fc940ce3          	beq	s0,s1,10590 <sd_acmd41+0xa>
   105bc:	0004051b          	sext.w	a0,s0
   105c0:	60e2                	ld	ra,24(sp)
   105c2:	6442                	ld	s0,16(sp)
   105c4:	64a2                	ld	s1,8(sp)
   105c6:	00153513          	seqz	a0,a0
   105ca:	6105                	addi	sp,sp,32
   105cc:	8082                	ret

00000000000105ce <init_sd>:
   105ce:	1141                	addi	sp,sp,-16
   105d0:	e406                	sd	ra,8(sp)
   105d2:	e022                	sd	s0,0(sp)
   105d4:	c8fff0ef          	jal	ra,10262 <spi_init>
   105d8:	00001517          	auipc	a0,0x1
   105dc:	3b850513          	addi	a0,a0,952 # 11990 <_BSS_END_+0xc90>
   105e0:	b95ff0ef          	jal	ra,10174 <print_uart>
   105e4:	4429                	li	s0,10
   105e6:	347d                	addiw	s0,s0,-1
   105e8:	e0bff0ef          	jal	ra,103f2 <sd_dummy>
   105ec:	fc6d                	bnez	s0,105e6 <init_sd+0x18>
   105ee:	eb7ff0ef          	jal	ra,104a4 <sd_cmd0>
   105f2:	57fd                	li	a5,-1
   105f4:	c911                	beqz	a0,10608 <init_sd+0x3a>
   105f6:	efbff0ef          	jal	ra,104f0 <sd_cmd8>
   105fa:	57f9                	li	a5,-2
   105fc:	c511                	beqz	a0,10608 <init_sd+0x3a>
   105fe:	f89ff0ef          	jal	ra,10586 <sd_acmd41>
   10602:	4781                	li	a5,0
   10604:	e111                	bnez	a0,10608 <init_sd+0x3a>
   10606:	57f5                	li	a5,-3
   10608:	60a2                	ld	ra,8(sp)
   1060a:	6402                	ld	s0,0(sp)
   1060c:	853e                	mv	a0,a5
   1060e:	0141                	addi	sp,sp,16
   10610:	8082                	ret

0000000000010612 <crc7>:
   10612:	8de9                	and	a1,a1,a0
   10614:	0075d79b          	srliw	a5,a1,0x7
   10618:	0045d51b          	srliw	a0,a1,0x4
   1061c:	8d3d                	xor	a0,a0,a5
   1061e:	8d2d                	xor	a0,a0,a1
   10620:	00451593          	slli	a1,a0,0x4
   10624:	8d2d                	xor	a0,a0,a1
   10626:	07f57513          	andi	a0,a0,127
   1062a:	8082                	ret

000000000001062c <crc16>:
   1062c:	0085579b          	srliw	a5,a0,0x8
   10630:	0522                	slli	a0,a0,0x8
   10632:	8d5d                	or	a0,a0,a5
   10634:	1542                	slli	a0,a0,0x30
   10636:	9141                	srli	a0,a0,0x30
   10638:	8da9                	xor	a1,a1,a0
   1063a:	0045d51b          	srliw	a0,a1,0x4
   1063e:	893d                	andi	a0,a0,15
   10640:	8da9                	xor	a1,a1,a0
   10642:	00c59513          	slli	a0,a1,0xc
   10646:	8d2d                	xor	a0,a0,a1
   10648:	0105151b          	slliw	a0,a0,0x10
   1064c:	4105551b          	sraiw	a0,a0,0x10
   10650:	0105179b          	slliw	a5,a0,0x10
   10654:	0107d79b          	srliw	a5,a5,0x10
   10658:	6709                	lui	a4,0x2
   1065a:	1701                	addi	a4,a4,-32
   1065c:	0057979b          	slliw	a5,a5,0x5
   10660:	8ff9                	and	a5,a5,a4
   10662:	8d3d                	xor	a0,a0,a5
   10664:	1542                	slli	a0,a0,0x30
   10666:	9141                	srli	a0,a0,0x30
   10668:	8082                	ret

000000000001066a <sd_copy>:
   1066a:	7155                	addi	sp,sp,-208
   1066c:	f54e                	sd	s3,168(sp)
   1066e:	02061993          	slli	s3,a2,0x20
   10672:	e1a2                	sd	s0,192(sp)
   10674:	fd26                	sd	s1,184(sp)
   10676:	e586                	sd	ra,200(sp)
   10678:	f94a                	sd	s2,176(sp)
   1067a:	f152                	sd	s4,160(sp)
   1067c:	ed56                	sd	s5,152(sp)
   1067e:	e95a                	sd	s6,144(sp)
   10680:	e55e                	sd	s7,136(sp)
   10682:	84aa                	mv	s1,a0
   10684:	842e                	mv	s0,a1
   10686:	0209d993          	srli	s3,s3,0x20
   1068a:	4781                	li	a5,0
   1068c:	567d                	li	a2,-1
   1068e:	08000713          	li	a4,128
   10692:	00f106b3          	add	a3,sp,a5
   10696:	00c68023          	sb	a2,0(a3) # 20000000 <_RODATA_END_+0x1ffee408>
   1069a:	0785                	addi	a5,a5,1
   1069c:	fee79be3          	bne	a5,a4,10692 <sd_copy+0x28>
   106a0:	0184559b          	srliw	a1,s0,0x18
   106a4:	4501                	li	a0,0
   106a6:	f6dff0ef          	jal	ra,10612 <crc7>
   106aa:	0104559b          	srliw	a1,s0,0x10
   106ae:	0ff5f593          	andi	a1,a1,255
   106b2:	f61ff0ef          	jal	ra,10612 <crc7>
   106b6:	0084559b          	srliw	a1,s0,0x8
   106ba:	0ff5f593          	andi	a1,a1,255
   106be:	f55ff0ef          	jal	ra,10612 <crc7>
   106c2:	0ff47593          	andi	a1,s0,255
   106c6:	f4dff0ef          	jal	ra,10612 <crc7>
   106ca:	0015161b          	slliw	a2,a0,0x1
   106ce:	00166613          	ori	a2,a2,1
   106d2:	0ff67613          	andi	a2,a2,255
   106d6:	85a2                	mv	a1,s0
   106d8:	4549                	li	a0,18
   106da:	d1fff0ef          	jal	ra,103f8 <sd_cmd>
   106de:	20048493          	addi	s1,s1,512
   106e2:	e951                	bnez	a0,10776 <sd_copy+0x10c>
   106e4:	0fe00a93          	li	s5,254
   106e8:	3e800b13          	li	s6,1000
   106ec:	e0048413          	addi	s0,s1,-512
   106f0:	d03ff0ef          	jal	ra,103f2 <sd_dummy>
   106f4:	ff551ee3          	bne	a0,s5,106f0 <sd_copy+0x86>
   106f8:	4901                	li	s2,0
   106fa:	8622                	mv	a2,s0
   106fc:	04000593          	li	a1,64
   10700:	850a                	mv	a0,sp
   10702:	c6dff0ef          	jal	ra,1036e <spi_write_bytes>
   10706:	4a01                	li	s4,0
   10708:	04000b93          	li	s7,64
   1070c:	014407b3          	add	a5,s0,s4
   10710:	0007c583          	lbu	a1,0(a5) # 20000000 <_RODATA_END_+0x1ffee408>
   10714:	854a                	mv	a0,s2
   10716:	0a05                	addi	s4,s4,1
   10718:	f15ff0ef          	jal	ra,1062c <crc16>
   1071c:	892a                	mv	s2,a0
   1071e:	ff7a17e3          	bne	s4,s7,1070c <sd_copy+0xa2>
   10722:	04040413          	addi	s0,s0,64
   10726:	fc941ae3          	bne	s0,s1,106fa <sd_copy+0x90>
   1072a:	cc9ff0ef          	jal	ra,103f2 <sd_dummy>
   1072e:	0085151b          	slliw	a0,a0,0x8
   10732:	03051413          	slli	s0,a0,0x30
   10736:	9041                	srli	s0,s0,0x30
   10738:	cbbff0ef          	jal	ra,103f2 <sd_dummy>
   1073c:	8c49                	or	s0,s0,a0
   1073e:	1442                	slli	s0,s0,0x30
   10740:	2901                	sext.w	s2,s2
   10742:	9041                	srli	s0,s0,0x30
   10744:	06891c63          	bne	s2,s0,107bc <sd_copy+0x152>
   10748:	0369e7b3          	rem	a5,s3,s6
   1074c:	e799                	bnez	a5,1075a <sd_copy+0xf0>
   1074e:	00001517          	auipc	a0,0x1
   10752:	27a50513          	addi	a0,a0,634 # 119c8 <_BSS_END_+0xcc8>
   10756:	a1fff0ef          	jal	ra,10174 <print_uart>
   1075a:	19fd                	addi	s3,s3,-1
   1075c:	20048493          	addi	s1,s1,512
   10760:	f93046e3          	bgtz	s3,106ec <sd_copy+0x82>
   10764:	4401                	li	s0,0
   10766:	4605                	li	a2,1
   10768:	4581                	li	a1,0
   1076a:	4531                	li	a0,12
   1076c:	c8dff0ef          	jal	ra,103f8 <sd_cmd>
   10770:	c83ff0ef          	jal	ra,103f2 <sd_dummy>
   10774:	a805                	j	107a4 <sd_copy+0x13a>
   10776:	c7dff0ef          	jal	ra,103f2 <sd_dummy>
   1077a:	c79ff0ef          	jal	ra,103f2 <sd_dummy>
   1077e:	c75ff0ef          	jal	ra,103f2 <sd_dummy>
   10782:	c71ff0ef          	jal	ra,103f2 <sd_dummy>
   10786:	c6dff0ef          	jal	ra,103f2 <sd_dummy>
   1078a:	c69ff0ef          	jal	ra,103f2 <sd_dummy>
   1078e:	c65ff0ef          	jal	ra,103f2 <sd_dummy>
   10792:	c61ff0ef          	jal	ra,103f2 <sd_dummy>
   10796:	00001517          	auipc	a0,0x1
   1079a:	21250513          	addi	a0,a0,530 # 119a8 <_BSS_END_+0xca8>
   1079e:	9d7ff0ef          	jal	ra,10174 <print_uart>
   107a2:	547d                	li	s0,-1
   107a4:	8522                	mv	a0,s0
   107a6:	60ae                	ld	ra,200(sp)
   107a8:	640e                	ld	s0,192(sp)
   107aa:	74ea                	ld	s1,184(sp)
   107ac:	794a                	ld	s2,176(sp)
   107ae:	79aa                	ld	s3,168(sp)
   107b0:	7a0a                	ld	s4,160(sp)
   107b2:	6aea                	ld	s5,152(sp)
   107b4:	6b4a                	ld	s6,144(sp)
   107b6:	6baa                	ld	s7,136(sp)
   107b8:	6169                	addi	sp,sp,208
   107ba:	8082                	ret
   107bc:	5479                	li	s0,-2
   107be:	b765                	j	10766 <sd_copy+0xfc>

00000000000107c0 <gpt_find_boot_partition>:
   107c0:	711d                	addi	sp,sp,-96
   107c2:	e8a2                	sd	s0,80(sp)
   107c4:	f05a                	sd	s6,32(sp)
   107c6:	ec86                	sd	ra,88(sp)
   107c8:	e4a6                	sd	s1,72(sp)
   107ca:	e0ca                	sd	s2,64(sp)
   107cc:	fc4e                	sd	s3,56(sp)
   107ce:	f852                	sd	s4,48(sp)
   107d0:	f456                	sd	s5,40(sp)
   107d2:	ec5e                	sd	s7,24(sp)
   107d4:	e862                	sd	s8,16(sp)
   107d6:	e466                	sd	s9,8(sp)
   107d8:	1080                	addi	s0,sp,96
   107da:	8b2a                	mv	s6,a0
   107dc:	df3ff0ef          	jal	ra,105ce <init_sd>
   107e0:	c905                	beqz	a0,10810 <gpt_find_boot_partition+0x50>
   107e2:	00001517          	auipc	a0,0x1
   107e6:	1ee50513          	addi	a0,a0,494 # 119d0 <_BSS_END_+0xcd0>
   107ea:	98bff0ef          	jal	ra,10174 <print_uart>
   107ee:	54fd                	li	s1,-1
   107f0:	fa040113          	addi	sp,s0,-96
   107f4:	60e6                	ld	ra,88(sp)
   107f6:	8526                	mv	a0,s1
   107f8:	6446                	ld	s0,80(sp)
   107fa:	64a6                	ld	s1,72(sp)
   107fc:	6906                	ld	s2,64(sp)
   107fe:	79e2                	ld	s3,56(sp)
   10800:	7a42                	ld	s4,48(sp)
   10802:	7aa2                	ld	s5,40(sp)
   10804:	7b02                	ld	s6,32(sp)
   10806:	6be2                	ld	s7,24(sp)
   10808:	6c42                	ld	s8,16(sp)
   1080a:	6ca2                	ld	s9,8(sp)
   1080c:	6125                	addi	sp,sp,96
   1080e:	8082                	ret
   10810:	00001517          	auipc	a0,0x1
   10814:	1e850513          	addi	a0,a0,488 # 119f8 <_BSS_END_+0xcf8>
   10818:	95dff0ef          	jal	ra,10174 <print_uart>
   1081c:	7101                	addi	sp,sp,-512
   1081e:	4605                	li	a2,1
   10820:	4585                	li	a1,1
   10822:	850a                	mv	a0,sp
   10824:	e47ff0ef          	jal	ra,1066a <sd_copy>
   10828:	890a                	mv	s2,sp
   1082a:	84aa                	mv	s1,a0
   1082c:	c905                	beqz	a0,1085c <gpt_find_boot_partition+0x9c>
   1082e:	00001517          	auipc	a0,0x1
   10832:	1e250513          	addi	a0,a0,482 # 11a10 <_BSS_END_+0xd10>
   10836:	93fff0ef          	jal	ra,10174 <print_uart>
   1083a:	00001517          	auipc	a0,0x1
   1083e:	1ee50513          	addi	a0,a0,494 # 11a28 <_BSS_END_+0xd28>
   10842:	933ff0ef          	jal	ra,10174 <print_uart>
   10846:	8526                	mv	a0,s1
   10848:	9afff0ef          	jal	ra,101f6 <print_uart_addr>
   1084c:	00001517          	auipc	a0,0x1
   10850:	0ec50513          	addi	a0,a0,236 # 11938 <_BSS_END_+0xc38>
   10854:	921ff0ef          	jal	ra,10174 <print_uart>
   10858:	54f9                	li	s1,-2
   1085a:	bf59                	j	107f0 <gpt_find_boot_partition+0x30>
   1085c:	00001517          	auipc	a0,0x1
   10860:	1e450513          	addi	a0,a0,484 # 11a40 <_BSS_END_+0xd40>
   10864:	911ff0ef          	jal	ra,10174 <print_uart>
   10868:	00001517          	auipc	a0,0x1
   1086c:	1f850513          	addi	a0,a0,504 # 11a60 <_BSS_END_+0xd60>
   10870:	905ff0ef          	jal	ra,10174 <print_uart>
   10874:	6502                	ld	a0,0(sp)
   10876:	981ff0ef          	jal	ra,101f6 <print_uart_addr>
   1087a:	00001517          	auipc	a0,0x1
   1087e:	1f650513          	addi	a0,a0,502 # 11a70 <_BSS_END_+0xd70>
   10882:	8f3ff0ef          	jal	ra,10174 <print_uart>
   10886:	4522                	lw	a0,8(sp)
   10888:	92fff0ef          	jal	ra,101b6 <print_uart_int>
   1088c:	00001517          	auipc	a0,0x1
   10890:	1f450513          	addi	a0,a0,500 # 11a80 <_BSS_END_+0xd80>
   10894:	8e1ff0ef          	jal	ra,10174 <print_uart>
   10898:	4532                	lw	a0,12(sp)
   1089a:	91dff0ef          	jal	ra,101b6 <print_uart_int>
   1089e:	00001517          	auipc	a0,0x1
   108a2:	1f250513          	addi	a0,a0,498 # 11a90 <_BSS_END_+0xd90>
   108a6:	8cfff0ef          	jal	ra,10174 <print_uart>
   108aa:	4542                	lw	a0,16(sp)
   108ac:	90bff0ef          	jal	ra,101b6 <print_uart_int>
   108b0:	00001517          	auipc	a0,0x1
   108b4:	1f050513          	addi	a0,a0,496 # 11aa0 <_BSS_END_+0xda0>
   108b8:	8bdff0ef          	jal	ra,10174 <print_uart>
   108bc:	4552                	lw	a0,20(sp)
   108be:	8f9ff0ef          	jal	ra,101b6 <print_uart_int>
   108c2:	00001517          	auipc	a0,0x1
   108c6:	1ee50513          	addi	a0,a0,494 # 11ab0 <_BSS_END_+0xdb0>
   108ca:	8abff0ef          	jal	ra,10174 <print_uart>
   108ce:	6562                	ld	a0,24(sp)
   108d0:	927ff0ef          	jal	ra,101f6 <print_uart_addr>
   108d4:	00001517          	auipc	a0,0x1
   108d8:	1f450513          	addi	a0,a0,500 # 11ac8 <_BSS_END_+0xdc8>
   108dc:	899ff0ef          	jal	ra,10174 <print_uart>
   108e0:	7502                	ld	a0,32(sp)
   108e2:	915ff0ef          	jal	ra,101f6 <print_uart_addr>
   108e6:	00001517          	auipc	a0,0x1
   108ea:	1f250513          	addi	a0,a0,498 # 11ad8 <_BSS_END_+0xdd8>
   108ee:	887ff0ef          	jal	ra,10174 <print_uart>
   108f2:	6526                	ld	a0,72(sp)
   108f4:	903ff0ef          	jal	ra,101f6 <print_uart_addr>
   108f8:	00001517          	auipc	a0,0x1
   108fc:	20050513          	addi	a0,a0,512 # 11af8 <_BSS_END_+0xdf8>
   10900:	875ff0ef          	jal	ra,10174 <print_uart>
   10904:	4546                	lw	a0,80(sp)
   10906:	8b1ff0ef          	jal	ra,101b6 <print_uart_int>
   1090a:	00001517          	auipc	a0,0x1
   1090e:	20e50513          	addi	a0,a0,526 # 11b18 <_BSS_END_+0xe18>
   10912:	863ff0ef          	jal	ra,10174 <print_uart>
   10916:	4556                	lw	a0,84(sp)
   10918:	89fff0ef          	jal	ra,101b6 <print_uart_int>
   1091c:	00001517          	auipc	a0,0x1
   10920:	01c50513          	addi	a0,a0,28 # 11938 <_BSS_END_+0xc38>
   10924:	851ff0ef          	jal	ra,10174 <print_uart>
   10928:	04892583          	lw	a1,72(s2) # 2000048 <_RODATA_END_+0x1fee450>
   1092c:	7101                	addi	sp,sp,-512
   1092e:	4605                	li	a2,1
   10930:	850a                	mv	a0,sp
   10932:	d39ff0ef          	jal	ra,1066a <sd_copy>
   10936:	8a8a                	mv	s5,sp
   10938:	84aa                	mv	s1,a0
   1093a:	08010993          	addi	s3,sp,128
   1093e:	02010913          	addi	s2,sp,32
   10942:	10051e63          	bnez	a0,10a5e <gpt_find_boot_partition+0x29e>
   10946:	4c41                	li	s8,16
   10948:	4b91                	li	s7,4
   1094a:	00001517          	auipc	a0,0x1
   1094e:	1ee50513          	addi	a0,a0,494 # 11b38 <_BSS_END_+0xe38>
   10952:	823ff0ef          	jal	ra,10174 <print_uart>
   10956:	0ff4f513          	andi	a0,s1,255
   1095a:	8dfff0ef          	jal	ra,10238 <print_uart_byte>
   1095e:	00001517          	auipc	a0,0x1
   10962:	1f250513          	addi	a0,a0,498 # 11b50 <_BSS_END_+0xe50>
   10966:	f8098c93          	addi	s9,s3,-128
   1096a:	80bff0ef          	jal	ra,10174 <print_uart>
   1096e:	4a01                	li	s4,0
   10970:	014c87b3          	add	a5,s9,s4
   10974:	0007c503          	lbu	a0,0(a5)
   10978:	0a05                	addi	s4,s4,1
   1097a:	8bfff0ef          	jal	ra,10238 <print_uart_byte>
   1097e:	ff8a19e3          	bne	s4,s8,10970 <gpt_find_boot_partition+0x1b0>
   10982:	00001517          	auipc	a0,0x1
   10986:	1ee50513          	addi	a0,a0,494 # 11b70 <_BSS_END_+0xe70>
   1098a:	feaff0ef          	jal	ra,10174 <print_uart>
   1098e:	f9098a13          	addi	s4,s3,-112
   10992:	000a4503          	lbu	a0,0(s4)
   10996:	0a05                	addi	s4,s4,1
   10998:	8a1ff0ef          	jal	ra,10238 <print_uart_byte>
   1099c:	ff2a1be3          	bne	s4,s2,10992 <gpt_find_boot_partition+0x1d2>
   109a0:	00001517          	auipc	a0,0x1
   109a4:	1f050513          	addi	a0,a0,496 # 11b90 <_BSS_END_+0xe90>
   109a8:	fccff0ef          	jal	ra,10174 <print_uart>
   109ac:	00093503          	ld	a0,0(s2)
   109b0:	fb898a13          	addi	s4,s3,-72
   109b4:	843ff0ef          	jal	ra,101f6 <print_uart_addr>
   109b8:	00001517          	auipc	a0,0x1
   109bc:	1e850513          	addi	a0,a0,488 # 11ba0 <_BSS_END_+0xea0>
   109c0:	fb4ff0ef          	jal	ra,10174 <print_uart>
   109c4:	00893503          	ld	a0,8(s2)
   109c8:	82fff0ef          	jal	ra,101f6 <print_uart_addr>
   109cc:	00001517          	auipc	a0,0x1
   109d0:	1e450513          	addi	a0,a0,484 # 11bb0 <_BSS_END_+0xeb0>
   109d4:	fa0ff0ef          	jal	ra,10174 <print_uart>
   109d8:	01093503          	ld	a0,16(s2)
   109dc:	81bff0ef          	jal	ra,101f6 <print_uart_addr>
   109e0:	00001517          	auipc	a0,0x1
   109e4:	1e050513          	addi	a0,a0,480 # 11bc0 <_BSS_END_+0xec0>
   109e8:	f8cff0ef          	jal	ra,10174 <print_uart>
   109ec:	000a4503          	lbu	a0,0(s4)
   109f0:	0a05                	addi	s4,s4,1
   109f2:	847ff0ef          	jal	ra,10238 <print_uart_byte>
   109f6:	ff499be3          	bne	s3,s4,109ec <gpt_find_boot_partition+0x22c>
   109fa:	00001517          	auipc	a0,0x1
   109fe:	f3e50513          	addi	a0,a0,-194 # 11938 <_BSS_END_+0xc38>
   10a02:	2485                	addiw	s1,s1,1
   10a04:	f70ff0ef          	jal	ra,10174 <print_uart>
   10a08:	08098993          	addi	s3,s3,128
   10a0c:	08090913          	addi	s2,s2,128
   10a10:	f3749de3          	bne	s1,s7,1094a <gpt_find_boot_partition+0x18a>
   10a14:	00001517          	auipc	a0,0x1
   10a18:	1bc50513          	addi	a0,a0,444 # 11bd0 <_BSS_END_+0xed0>
   10a1c:	f58ff0ef          	jal	ra,10174 <print_uart>
   10a20:	028ab603          	ld	a2,40(s5)
   10a24:	020aa583          	lw	a1,32(s5)
   10a28:	855a                	mv	a0,s6
   10a2a:	2605                	addiw	a2,a2,1
   10a2c:	9e0d                	subw	a2,a2,a1
   10a2e:	c3dff0ef          	jal	ra,1066a <sd_copy>
   10a32:	84aa                	mv	s1,a0
   10a34:	c929                	beqz	a0,10a86 <gpt_find_boot_partition+0x2c6>
   10a36:	00001517          	auipc	a0,0x1
   10a3a:	fda50513          	addi	a0,a0,-38 # 11a10 <_BSS_END_+0xd10>
   10a3e:	f36ff0ef          	jal	ra,10174 <print_uart>
   10a42:	00001517          	auipc	a0,0x1
   10a46:	fe650513          	addi	a0,a0,-26 # 11a28 <_BSS_END_+0xd28>
   10a4a:	f2aff0ef          	jal	ra,10174 <print_uart>
   10a4e:	8526                	mv	a0,s1
   10a50:	fa6ff0ef          	jal	ra,101f6 <print_uart_addr>
   10a54:	00001517          	auipc	a0,0x1
   10a58:	ee450513          	addi	a0,a0,-284 # 11938 <_BSS_END_+0xc38>
   10a5c:	bbe5                	j	10854 <gpt_find_boot_partition+0x94>
   10a5e:	00001517          	auipc	a0,0x1
   10a62:	fb250513          	addi	a0,a0,-78 # 11a10 <_BSS_END_+0xd10>
   10a66:	f0eff0ef          	jal	ra,10174 <print_uart>
   10a6a:	00001517          	auipc	a0,0x1
   10a6e:	fbe50513          	addi	a0,a0,-66 # 11a28 <_BSS_END_+0xd28>
   10a72:	f02ff0ef          	jal	ra,10174 <print_uart>
   10a76:	8526                	mv	a0,s1
   10a78:	f7eff0ef          	jal	ra,101f6 <print_uart_addr>
   10a7c:	00001517          	auipc	a0,0x1
   10a80:	ebc50513          	addi	a0,a0,-324 # 11938 <_BSS_END_+0xc38>
   10a84:	bbc1                	j	10854 <gpt_find_boot_partition+0x94>
   10a86:	00001517          	auipc	a0,0x1
   10a8a:	16250513          	addi	a0,a0,354 # 11be8 <_BSS_END_+0xee8>
   10a8e:	ee6ff0ef          	jal	ra,10174 <print_uart>
   10a92:	bbb9                	j	107f0 <gpt_find_boot_partition+0x30>

0000000000010a94 <write_gpio>:
   10a94:	00b50023          	sb	a1,0(a0)
   10a98:	8082                	ret

0000000000010a9a <read_gpio>:
   10a9a:	00054503          	lbu	a0,0(a0)
   10a9e:	8082                	ret

0000000000010aa0 <init_gpio>:
   10aa0:	400007b7          	lui	a5,0x40000
   10aa4:	00078223          	sb	zero,4(a5) # 40000004 <_RODATA_END_+0x3ffee40c>
   10aa8:	477d                	li	a4,31
   10aaa:	00e78623          	sb	a4,12(a5)
   10aae:	8082                	ret

Disassembly of section .text.startup:

0000000000010ab0 <main>:
   10ab0:	65f1                	lui	a1,0x1c
   10ab2:	02faf537          	lui	a0,0x2faf
   10ab6:	1101                	addi	sp,sp,-32
   10ab8:	0aa00793          	li	a5,170
   10abc:	20058593          	addi	a1,a1,512 # 1c200 <_RODATA_END_+0xa608>
   10ac0:	08050513          	addi	a0,a0,128 # 2faf080 <_RODATA_END_+0x2f9d488>
   10ac4:	ec06                	sd	ra,24(sp)
   10ac6:	c63e                	sw	a5,12(sp)
   10ac8:	e822                	sd	s0,16(sp)
   10aca:	e66ff0ef          	jal	ra,10130 <init_uart>
   10ace:	00001517          	auipc	a0,0x1
   10ad2:	e2a50513          	addi	a0,a0,-470 # 118f8 <_BSS_END_+0xbf8>
   10ad6:	004c5437          	lui	s0,0x4c5
   10ada:	e9aff0ef          	jal	ra,10174 <print_uart>
   10ade:	b4040413          	addi	s0,s0,-1216 # 4c4b40 <_RODATA_END_+0x4b2f48>
   10ae2:	fbfff0ef          	jal	ra,10aa0 <init_gpio>
   10ae6:	00c14583          	lbu	a1,12(sp)
   10aea:	40000537          	lui	a0,0x40000
   10aee:	fa7ff0ef          	jal	ra,10a94 <write_gpio>
   10af2:	c422                	sw	s0,8(sp)
   10af4:	47a2                	lw	a5,8(sp)
   10af6:	2781                	sext.w	a5,a5
   10af8:	06f04263          	bgtz	a5,10b5c <main+0xac>
   10afc:	4581                	li	a1,0
   10afe:	40000537          	lui	a0,0x40000
   10b02:	f93ff0ef          	jal	ra,10a94 <write_gpio>
   10b06:	c422                	sw	s0,8(sp)
   10b08:	47a2                	lw	a5,8(sp)
   10b0a:	2781                	sext.w	a5,a5
   10b0c:	04f04c63          	bgtz	a5,10b64 <main+0xb4>
   10b10:	b0003a73          	csrrc	s4,mcycle,zero
   10b14:	04000793          	li	a5,64
   10b18:	37fd                	addiw	a5,a5,-1
   10b1a:	fffd                	bnez	a5,10b18 <main+0x68>
   10b1c:	b0003af3          	csrrc	s5,mcycle,zero
   10b20:	414a8a33          	sub	s4,s5,s4
   10b24:	fffd04b7          	lui	s1,0xfffd0
   10b28:	5054849b          	addiw	s1,s1,1285
   10b2c:	01049493          	slli	s1,s1,0x10
   10b30:	50548493          	addi	s1,s1,1285 # fffffffffffd0505 <_RODATA_END_+0xfffffffffffbe90d>
   10b34:	01049493          	slli	s1,s1,0x10
   10b38:	50548493          	addi	s1,s1,1285
   10b3c:	00d49493          	slli	s1,s1,0xd
   10b40:	0a048493          	addi	s1,s1,160
   10b44:	b0003b73          	csrrc	s6,mcycle,zero
   10b48:	012489db          	0x12489db
   10b4c:	b0003bf3          	csrrc	s7,mcycle,zero
   10b50:	416b8b33          	sub	s6,s7,s6
   10b54:	036a59b3          	divu	s3,s4,s6
   10b58:	c64e                	sw	s3,12(sp)
   10b5a:	b771                	j	10ae6 <main+0x36>
   10b5c:	47a2                	lw	a5,8(sp)
   10b5e:	37fd                	addiw	a5,a5,-1
   10b60:	c43e                	sw	a5,8(sp)
   10b62:	bf49                	j	10af4 <main+0x44>
   10b64:	47a2                	lw	a5,8(sp)
   10b66:	37fd                	addiw	a5,a5,-1
   10b68:	c43e                	sw	a5,8(sp)
   10b6a:	bf79                	j	10b08 <main+0x58>
