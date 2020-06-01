/*
 * File:    mcf5282_gpio.h
 * Purpose: Register and bit definitions
 */

#ifndef __MCF5282_GPIO_H__
#define __MCF5282_GPIO_H__

/*********************************************************************
*
* General Purpose I/O (GPIO) Module
*
*********************************************************************/

/* Read/Write access macros for general use */
#define MCF5282_GPIO_PORTA		(*(vuint8  *)(void *)(&__IPSBAR[0x100000]))
#define MCF5282_GPIO_PORTB		(*(vuint8  *)(void *)(&__IPSBAR[0x100001]))
#define MCF5282_GPIO_PORTC		(*(vuint8  *)(void *)(&__IPSBAR[0x100002]))
#define MCF5282_GPIO_PORTD		(*(vuint8  *)(void *)(&__IPSBAR[0x100003]))
#define MCF5282_GPIO_PORTE		(*(vuint8  *)(void *)(&__IPSBAR[0x100004]))
#define MCF5282_GPIO_PORTF		(*(vuint8  *)(void *)(&__IPSBAR[0x100005]))
#define MCF5282_GPIO_PORTG		(*(vuint8  *)(void *)(&__IPSBAR[0x100006]))
#define MCF5282_GPIO_PORTH		(*(vuint8  *)(void *)(&__IPSBAR[0x100007]))
#define MCF5282_GPIO_PORTJ		(*(vuint8  *)(void *)(&__IPSBAR[0x100008]))
#define MCF5282_GPIO_PORTDD		(*(vuint8  *)(void *)(&__IPSBAR[0x100009]))
#define MCF5282_GPIO_PORTEH		(*(vuint8  *)(void *)(&__IPSBAR[0x10000A]))
#define MCF5282_GPIO_PORTEL		(*(vuint8  *)(void *)(&__IPSBAR[0x10000B]))
#define MCF5282_GPIO_PORTAS		(*(vuint8  *)(void *)(&__IPSBAR[0x10000C]))
#define MCF5282_GPIO_PORTQS		(*(vuint8  *)(void *)(&__IPSBAR[0x10000D]))
#define MCF5282_GPIO_PORTSD		(*(vuint8  *)(void *)(&__IPSBAR[0x10000E]))
#define MCF5282_GPIO_PORTTC		(*(vuint8  *)(void *)(&__IPSBAR[0x10000F]))
#define MCF5282_GPIO_PORTTD		(*(vuint8  *)(void *)(&__IPSBAR[0x100010]))
#define MCF5282_GPIO_PORTUA		(*(vuint8  *)(void *)(&__IPSBAR[0x100011]))

#define MCF5282_GPIO_DDRA		(*(vuint8  *)(void *)(&__IPSBAR[0x100014]))
#define MCF5282_GPIO_DDRB		(*(vuint8  *)(void *)(&__IPSBAR[0x100015]))
#define MCF5282_GPIO_DDRC		(*(vuint8  *)(void *)(&__IPSBAR[0x100016]))
#define MCF5282_GPIO_DDRD		(*(vuint8  *)(void *)(&__IPSBAR[0x100017]))
#define MCF5282_GPIO_DDRE		(*(vuint8  *)(void *)(&__IPSBAR[0x100018]))
#define MCF5282_GPIO_DDRF		(*(vuint8  *)(void *)(&__IPSBAR[0x100019]))
#define MCF5282_GPIO_DDRG		(*(vuint8  *)(void *)(&__IPSBAR[0x10001A]))
#define MCF5282_GPIO_DDRH		(*(vuint8  *)(void *)(&__IPSBAR[0x10001B]))
#define MCF5282_GPIO_DDRJ		(*(vuint8  *)(void *)(&__IPSBAR[0x10001C]))
#define MCF5282_GPIO_DDRDD		(*(vuint8  *)(void *)(&__IPSBAR[0x10001D]))
#define MCF5282_GPIO_DDREH		(*(vuint8  *)(void *)(&__IPSBAR[0x10001E]))
#define MCF5282_GPIO_DDREL		(*(vuint8  *)(void *)(&__IPSBAR[0x10001F]))
#define MCF5282_GPIO_DDRAS		(*(vuint8  *)(void *)(&__IPSBAR[0x100020]))
#define MCF5282_GPIO_DDRQS		(*(vuint8  *)(void *)(&__IPSBAR[0x100021]))
#define MCF5282_GPIO_DDRSD		(*(vuint8  *)(void *)(&__IPSBAR[0x100022]))
#define MCF5282_GPIO_DDRTC		(*(vuint8  *)(void *)(&__IPSBAR[0x100023]))
#define MCF5282_GPIO_DDRTD		(*(vuint8  *)(void *)(&__IPSBAR[0x100024]))
#define MCF5282_GPIO_DDRUA		(*(vuint8  *)(void *)(&__IPSBAR[0x100025]))

#define MCF5282_GPIO_PORTAP		(*(vuint8  *)(void *)(&__IPSBAR[0x100028]))
#define MCF5282_GPIO_PORTBP		(*(vuint8  *)(void *)(&__IPSBAR[0x100029]))
#define MCF5282_GPIO_PORTCP		(*(vuint8  *)(void *)(&__IPSBAR[0x10002A]))
#define MCF5282_GPIO_PORTDP		(*(vuint8  *)(void *)(&__IPSBAR[0x10002B]))
#define MCF5282_GPIO_PORTEP		(*(vuint8  *)(void *)(&__IPSBAR[0x10002C]))
#define MCF5282_GPIO_PORTFP		(*(vuint8  *)(void *)(&__IPSBAR[0x10002D]))
#define MCF5282_GPIO_PORTGP		(*(vuint8  *)(void *)(&__IPSBAR[0x10002E]))
#define MCF5282_GPIO_PORTHP		(*(vuint8  *)(void *)(&__IPSBAR[0x10002F]))
#define MCF5282_GPIO_PORTJP		(*(vuint8  *)(void *)(&__IPSBAR[0x100030]))
#define MCF5282_GPIO_PORTDDP	(*(vuint8  *)(void *)(&__IPSBAR[0x100031]))
#define MCF5282_GPIO_PORTEHP	(*(vuint8  *)(void *)(&__IPSBAR[0x100032]))
#define MCF5282_GPIO_PORTELP	(*(vuint8  *)(void *)(&__IPSBAR[0x100033]))
#define MCF5282_GPIO_PORTASP	(*(vuint8  *)(void *)(&__IPSBAR[0x100034]))
#define MCF5282_GPIO_PORTQSP	(*(vuint8  *)(void *)(&__IPSBAR[0x100035]))
#define MCF5282_GPIO_PORTSDP	(*(vuint8  *)(void *)(&__IPSBAR[0x100036]))
#define MCF5282_GPIO_PORTTCP	(*(vuint8  *)(void *)(&__IPSBAR[0x100037]))
#define MCF5282_GPIO_PORTTDP	(*(vuint8  *)(void *)(&__IPSBAR[0x100038]))
#define MCF5282_GPIO_PORTUAP	(*(vuint8  *)(void *)(&__IPSBAR[0x100039]))

#define MCF5282_GPIO_SETA		(*(vuint8  *)(void *)(&__IPSBAR[0x100028]))
#define MCF5282_GPIO_SETB		(*(vuint8  *)(void *)(&__IPSBAR[0x100029]))
#define MCF5282_GPIO_SETC		(*(vuint8  *)(void *)(&__IPSBAR[0x10002A]))
#define MCF5282_GPIO_SETD		(*(vuint8  *)(void *)(&__IPSBAR[0x10002B]))
#define MCF5282_GPIO_SETE		(*(vuint8  *)(void *)(&__IPSBAR[0x10002C]))
#define MCF5282_GPIO_SETF		(*(vuint8  *)(void *)(&__IPSBAR[0x10002D]))
#define MCF5282_GPIO_SETG   	(*(vuint8  *)(void *)(&__IPSBAR[0x10002E]))
#define MCF5282_GPIO_SETH   	(*(vuint8  *)(void *)(&__IPSBAR[0x10002F]))
#define MCF5282_GPIO_SETJ   	(*(vuint8  *)(void *)(&__IPSBAR[0x100030]))
#define MCF5282_GPIO_SETDD  	(*(vuint8  *)(void *)(&__IPSBAR[0x100031]))
#define MCF5282_GPIO_SETEH  	(*(vuint8  *)(void *)(&__IPSBAR[0x100032]))
#define MCF5282_GPIO_SETEL  	(*(vuint8  *)(void *)(&__IPSBAR[0x100033]))
#define MCF5282_GPIO_SETAS  	(*(vuint8  *)(void *)(&__IPSBAR[0x100034]))
#define MCF5282_GPIO_SETQS  	(*(vuint8  *)(void *)(&__IPSBAR[0x100035]))
#define MCF5282_GPIO_SETSD  	(*(vuint8  *)(void *)(&__IPSBAR[0x100036]))
#define MCF5282_GPIO_SETTC  	(*(vuint8  *)(void *)(&__IPSBAR[0x100037]))
#define MCF5282_GPIO_SETTD  	(*(vuint8  *)(void *)(&__IPSBAR[0x100038]))
#define MCF5282_GPIO_SETUA  	(*(vuint8  *)(void *)(&__IPSBAR[0x100039]))

#define MCF5282_GPIO_CLRA  		(*(vuint8  *)(void *)(&__IPSBAR[0x10003C]))
#define MCF5282_GPIO_CLRB  		(*(vuint8  *)(void *)(&__IPSBAR[0x10003D]))
#define MCF5282_GPIO_CLRC  		(*(vuint8  *)(void *)(&__IPSBAR[0x10003E]))
#define MCF5282_GPIO_CLRD  		(*(vuint8  *)(void *)(&__IPSBAR[0x10003F]))
#define MCF5282_GPIO_CLRE  		(*(vuint8  *)(void *)(&__IPSBAR[0x100040]))
#define MCF5282_GPIO_CLRF  		(*(vuint8  *)(void *)(&__IPSBAR[0x100041]))
#define MCF5282_GPIO_CLRG  		(*(vuint8  *)(void *)(&__IPSBAR[0x100042]))
#define MCF5282_GPIO_CLRH  		(*(vuint8  *)(void *)(&__IPSBAR[0x100043]))
#define MCF5282_GPIO_CLRJ  		(*(vuint8  *)(void *)(&__IPSBAR[0x100044]))
#define MCF5282_GPIO_CLRDD  	(*(vuint8  *)(void *)(&__IPSBAR[0x100045]))
#define MCF5282_GPIO_CLREH  	(*(vuint8  *)(void *)(&__IPSBAR[0x100046]))
#define MCF5282_GPIO_CLREL  	(*(vuint8  *)(void *)(&__IPSBAR[0x100047]))
#define MCF5282_GPIO_CLRAS  	(*(vuint8  *)(void *)(&__IPSBAR[0x100048]))
#define MCF5282_GPIO_CLRQS  	(*(vuint8  *)(void *)(&__IPSBAR[0x100049]))
#define MCF5282_GPIO_CLRSD  	(*(vuint8  *)(void *)(&__IPSBAR[0x10004A]))
#define MCF5282_GPIO_CLRTC  	(*(vuint8  *)(void *)(&__IPSBAR[0x10004B]))
#define MCF5282_GPIO_CLRTD  	(*(vuint8  *)(void *)(&__IPSBAR[0x10004C]))
#define MCF5282_GPIO_CLRUA  	(*(vuint8  *)(void *)(&__IPSBAR[0x10004D]))

#define MCF5282_GPIO_PBCDPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x100050]))
#define MCF5282_GPIO_PFPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x100051]))
#define MCF5282_GPIO_PEPAR  	(*(vuint16 *)(void *)(&__IPSBAR[0x100052]))
#define MCF5282_GPIO_PJPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x100054]))
#define MCF5282_GPIO_PSDPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x100055]))
#define MCF5282_GPIO_PASPAR  	(*(vuint16 *)(void *)(&__IPSBAR[0x100056]))
#define MCF5282_GPIO_PEHLPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x100058]))
#define MCF5282_GPIO_PQSPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x100059]))
#define MCF5282_GPIO_PTCPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x10005A]))
#define MCF5282_GPIO_PTDPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x10005B]))
#define MCF5282_GPIO_PUAPAR  	(*(vuint8  *)(void *)(&__IPSBAR[0x10005C]))

/* Bit level definitions and macros */
#define MCF5282_GPIO_PORTx7					(0x80)
#define MCF5282_GPIO_PORTx6					(0x40)
#define MCF5282_GPIO_PORTx5					(0x20)
#define MCF5282_GPIO_PORTx4					(0x10)
#define MCF5282_GPIO_PORTx3					(0x08)
#define MCF5282_GPIO_PORTx2					(0x04)
#define MCF5282_GPIO_PORTx1					(0x02)
#define MCF5282_GPIO_PORTx0					(0x01)
#define MCF5282_GPIO_PORTx(x)				(0x01<<x)

#define MCF5282_GPIO_DDRx7					(0x80)
#define MCF5282_GPIO_DDRx6					(0x40)
#define MCF5282_GPIO_DDRx5					(0x20)
#define MCF5282_GPIO_DDRx4					(0x10)
#define MCF5282_GPIO_DDRx3					(0x08)
#define MCF5282_GPIO_DDRx2					(0x04)
#define MCF5282_GPIO_DDRx1					(0x02)
#define MCF5282_GPIO_DDRx0					(0x01)
#define MCF5282_GPIO_DDRx(x)				(0x01<<x)

#define MCF5282_GPIO_PORTxP7				(0x80)
#define MCF5282_GPIO_PORTxP6				(0x40)
#define MCF5282_GPIO_PORTxP5				(0x20)
#define MCF5282_GPIO_PORTxP4				(0x10)
#define MCF5282_GPIO_PORTxP3				(0x08)
#define MCF5282_GPIO_PORTxP2				(0x04)
#define MCF5282_GPIO_PORTxP1				(0x02)
#define MCF5282_GPIO_PORTxP0				(0x01)
#define MCF5282_GPIO_PORTxP(x)				(0x01<<x)

#define MCF5282_GPIO_SETx7					(0x80)
#define MCF5282_GPIO_SETx6					(0x40)
#define MCF5282_GPIO_SETx5					(0x20)
#define MCF5282_GPIO_SETx4					(0x10)
#define MCF5282_GPIO_SETx3					(0x08)
#define MCF5282_GPIO_SETx2					(0x04)
#define MCF5282_GPIO_SETx1					(0x02)
#define MCF5282_GPIO_SETx0					(0x01)
#define MCF5282_GPIO_SETx(x)				(0x01<<x)

#define MCF5282_GPIO_CLRx7					(0x80)
#define MCF5282_GPIO_CLRx6					(0x40)
#define MCF5282_GPIO_CLRx5					(0x20)
#define MCF5282_GPIO_CLRx4					(0x10)
#define MCF5282_GPIO_CLRx3					(0x08)
#define MCF5282_GPIO_CLRx2					(0x04)
#define MCF5282_GPIO_CLRx1					(0x02)
#define MCF5282_GPIO_CLRx0					(0x01)
#define MCF5282_GPIO_CLRx(x)				(0x01<<x)

#define MCF5282_GPIO_PBCDPAR_PBPA			(0x80)
#define MCF5282_GPIO_PBCDPAR_PCDPA			(0x40)

#define MCF5282_GPIO_PEPAR_PEPA7			(0x4000)
#define MCF5282_GPIO_PEPAR_PEPA6			(0x1000)
#define MCF5282_GPIO_PEPAR_PEPA5			(0x0400)
#define MCF5282_GPIO_PEPAR_PEPA4			(0x0100)
#define MCF5282_GPIO_PEPAR_PEPA3			(0x0040)
#define MCF5282_GPIO_PEPAR_PEPA2			(0x0010)
#define MCF5282_GPIO_PEPAR_PEPA1(x)			(((x)&0x3)<<2)
#define MCF5282_GPIO_PEPAR_PEPA0(x)			(((x)&0x3))

#define MCF5282_GPIO_PFPAR_PFPA7			(0x80)			
#define MCF5282_GPIO_PFPAR_PFPA6			(0x40)
#define MCF5282_GPIO_PFPAR_PFPA5			(0x20)

#define MCF5282_GPIO_PJPAR_PJPA7			(0x80)
#define MCF5282_GPIO_PJPAR_PJPA6			(0x40)
#define MCF5282_GPIO_PJPAR_PJPA5			(0x20)
#define MCF5282_GPIO_PJPAR_PJPA4			(0x10)
#define MCF5282_GPIO_PJPAR_PJPA3			(0x08)
#define MCF5282_GPIO_PJPAR_PJPA2			(0x04)
#define MCF5282_GPIO_PJPAR_PJPA1			(0x02)
#define MCF5282_GPIO_PJPAR_PJPA0			(0x01)
#define MCF5282_GPIO_PJPAR_PJPA(x)			(0x01<<x)

#define MCF5282_GPIO_PSDPAR_PSDPA			(0x80)

#define MCF5282_GPIO_PASPAR_PASPA5(x)		(((x)&0x3)<<10)
#define MCF5282_GPIO_PASPAR_PASPA4(x)		(((x)&0x3)<<8)
#define MCF5282_GPIO_PASPAR_PASPA3(x)		(((x)&0x3)<<6)
#define MCF5282_GPIO_PASPAR_PASPA2(x)		(((x)&0x3)<<4)
#define MCF5282_GPIO_PASPAR_PASPA1(x)		(((x)&0x3)<<2)
#define MCF5282_GPIO_PASPAR_PASPA0(x)		(((x)&0x3))

#define MCF5282_GPIO_PEHLPAR_PEHPA			(0x80)
#define MCF5282_GPIO_PEHLPAR_PELPA			(0x40)

#define MCF5282_GPIO_PQSPAR_PQSPA6			(0x40)
#define MCF5282_GPIO_PQSPAR_PQSPA5			(0x20)
#define MCF5282_GPIO_PQSPAR_PQSPA4			(0x10)
#define MCF5282_GPIO_PQSPAR_PQSPA3			(0x08)
#define MCF5282_GPIO_PQSPAR_PQSPA2			(0x04)
#define MCF5282_GPIO_PQSPAR_PQSPA1			(0x02)
#define MCF5282_GPIO_PQSPAR_PQSPA0			(0x01)
#define MCF5282_GPIO_PQSPAR_PQSPA(x)		(0x01<<x)

#define MCF5282_GPIO_PTCPAR_PTCPA3(x)		(((x)&0x3)<<6)
#define MCF5282_GPIO_PTCPAR_PTCPA2(x)		(((x)&0x3)<<4)
#define MCF5282_GPIO_PTCPAR_PTCPA1(x)		(((x)&0x3)<<2)
#define MCF5282_GPIO_PTCPAR_PTCPA0(x)		(((x)&0x3))

#define MCF5282_GPIO_PTDPAR_PTDPA3(x)		(((x)&0x3)<<6)
#define MCF5282_GPIO_PTDPAR_PTDPA2(x)		(((x)&0x3)<<4)
#define MCF5282_GPIO_PTDPAR_PTDPA1(x)		(((x)&0x3)<<2)
#define MCF5282_GPIO_PTDPAR_PTDPA0(x)		(((x)&0x3))

#define MCF5282_GPIO_PUAPAR_PUAPA3			(0x08)
#define MCF5282_GPIO_PUAPAR_PUAPA2			(0x04)
#define MCF5282_GPIO_PUAPAR_PUAPA1			(0x02)
#define MCF5282_GPIO_PUAPAR_PUAPA0			(0x01)

/********************************************************************/

#endif /* __MCF5282_GPIO_H__ */
