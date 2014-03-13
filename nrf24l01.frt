\ nRF24L01* family of radios: A WIP library for amforth.
\ GPLv2
\ TODO eliminate .reg from names

rf24-empty
marker rf24-empty

$11 constant nRF24.RX_PW_P0
$12 constant nRF24.RX_PW_P1
$13 constant nRF24.RX_PW_P2
$14 constant nRF24.RX_PW_P3
$15 constant nRF24.RX_PW_P4
$16 constant nRF24.RX_PW_P5
$17 constant nRF24.FIFO_STATUS
$1C constant nRF24.DYNPD
$1D constant nRF24.FEATURE


$00 constant nRF24.CONFIG
nRF24.CONFIG 6 portpin: nRF24.CONFIG.MASK_RX_DR
nRF24.CONFIG 5 portpin: nRF24.CONFIG.MASK_TX_DS
nRF24.CONFIG 4 portpin: nRF24.CONFIG.MASK_MAX_RT
nRF24.CONFIG 3 portpin: nRF24.CONFIG.EN_CRC
nRF24.CONFIG 2 portpin: nRF24.CONFIG.CRCO
nRF24.CONFIG 1 portpin: nRF24.CONFIG.PWR_UP
nRF24.CONFIG 0 portpin: nRF24.CONFIG.PRIM_RX

$01 constant nRF24.EN_AA
nRF24.EN_AA 5 portpin: nRF24.EN_AA.P5
nRF24.EN_AA 4 portpin: nRF24.EN_AA.P4
nRF24.EN_AA 3 portpin: nRF24.EN_AA.P3
nRF24.EN_AA 2 portpin: nRF24.EN_AA.P2
nRF24.EN_AA 1 portpin: nRF24.EN_AA.P1
nRF24.EN_AA 0 portpin: nRF24.EN_AA.P0

$02 constant nRF24.EN_RXADDR
nRF24.EN_RXADDR 5 portpin: nRF24.E_RXADDR.P5
nRF24.EN_RXADDR 4 portpin: nRF24.E_RXADDR.P4
nRF24.EN_RXADDR 3 portpin: nRF24.E_RXADDR.P3
nRF24.EN_RXADDR 2 portpin: nRF24.E_RXADDR.P2
nRF24.EN_RXADDR 1 portpin: nRF24.E_RXADDR.P1
nRF24.EN_RXADDR 0 portpin: nRF24.E_RXADDR.P0

$03 constant nRF24.SETUP_AW
nRF24.SETUP_AW $3 bitmask: nRF24.AW

$04 constant nRF24.SETUP_RETR
nRF24.SETUP_RETR $F0 bitmask: nRF24.SETUP_RETR.ARD
nRF24.SETUP_RETR $0F bitmask: nRF24.SETUP_RETR.ARC

$05 constant nRF24.RF_CH

$06 constant nRF24.RF_SETUP
nRF24.RF_SETUP 4 portpin: nRF24.RF_SETUP.PLL_LOCK
nRF24.RF_SETUP 3 portpin: nRF24.RF_SETUP.RF_DR
nRF24.RF_SETUP 6 bitmask: nRF24.RF_SETUP.RF_PWR
nRF24.RF_SETUP 0 portpin: nRF24.RF_SETUP.LNA_HCURR \ Not in *-P

$07 constant nRF24.STATUS
nRF24.STATUS 6 portpin: nRF24.STATUS.RX_DR
nRF24.STATUS 5 portpin: nRF24.STATUS.TX_DS
nRF24.STATUS 4 portpin: nRF24.STATUS.MAX_RT
nRF24.STATUS $C bitmask: nRF24.STATUS.RX_P_NO
nRF24.STATUS 0 portpin: nRF24.STATUS.TX_FULL

$08 constant nRF24.OBSERVE_TX
nRF24.OBSERVE_TX $F0 bitmask: nRF24.PLOS_CNT
nRF24.OBSERVE_TX $0F bitmask: nRF24.ARC_CNT

$09 constant nRF24.CD

$0A constant nRF24.RX_ADDR_P0
$0B constant nRF24.RX_ADDR_P1
$0C constant nRF24.RX_ADDR_P2
$0D constant nRF24.RX_ADDR_P3
$0E constant nRF24.RX_ADDR_P4
$0F constant nRF24.RX_ADDR_P5
$10 constant nRF24.TX_ADDR

\ TODO finish these:
\ 6 portpin: nRF24.TX_REUSE
\ 5 portpin: nRF24.FIFO_FULL
\ 4 portpin: nRF24.TX_EMPTY
\ 1 portpin: nRF24.RX_FULL
\ 0 portpin: nRF24.RX_EMPTY
\ 5 portpin: nRF24.DPL_P5
\ 4 portpin: nRF24.DPL_P4
\ 3 portpin: nRF24.DPL_P3
\ 2 portpin: nRF24.DPL_P2
\ 1 portpin: nRF24.DPL_P1
\ 0 portpin: nRF24.DPL_P0
\ 2 portpin: nRF24.EN_DPL
\ 1 portpin: nRF24.EN_ACK_PAY
\ 0 portpin: nRF24.EN_DYN_ACK

\ Instruction Mnemonics
$00 constant nRF24.R_REGISTER
$20 constant nRF24.W_REGISTER
$1F constant nRF24.REGISTER_MASK
$50 constant nRF24.ACTIVATE
$60 constant nRF24.R_RX_PL_WID
$61 constant nRF24.R_RX_PAYLOAD
$A0 constant nRF24.W_TX_PAYLOAD
$A8 constant nRF24.W_ACK_PAYLOAD
$E1 constant nRF24.FLUSH_TX
$E2 constant nRF24.FLUSH_RX
$E3 constant nRF24.REUSE_TX_PL
$FF constant nRF24.NOP

\ P model memory Map
$09 constant RPD

\ P model bit Mnemonics
5 constant nRF24.RF_DR_LOW
3 constant nRF24.RF_DR_HIGH
1 constant nRF24.RF_PWR_LOW
2 constant nRF24.RF_PWR_HIGH

PORTD 2 portpin: _irq    \ input
PORTB 1 portpin: _ce    \ output
PORTB 2 portpin: _csn    \ output
PORTB 3 portpin: _mosi  \ output
PORTB 4 portpin: _miso  \ input
PORTB 5 portpin: _clk   \ output

: nrf24_c! ( value portaddr -- status )
    _csn low
    nRF24.REGISTER_MASK and ( value reg mask -- value n )
    nRF24.W_REGISTER or ( value n W_REGISTER )
    c!@spi swap ( value cmd -- value resp )
    c!spi ( resp value -- resp resp2 )
    _csn high
;

: nrf24_c@ ( portaddr -- b )
    _csn low
    nRF24.REGISTER_MASK and ( value reg mask -- value n )
    nRF24.R_REGISTER or ( value n W_REGISTER )
    c!@spi drop ( value cmd -- value resp )
    nRF24.NOP c!@spi ( resp value -- resp resp2 )
    _csn high
;

: 1#lshift
    1 swap lshift
;

\ Set bit# in port.
: nrf24_or! ( bit# port -- )
    dup ( bit# port -- bit# port port )
    nrf24_c@ ( bit# port port -- bit# port bitfield )
    rot ( bit# port bitfield -- port bitfield bit# )
    or ( -- )
    swap \ nrf24_c!
;

\ Clear bit# in port.
: nrf24_and! ( bit# port -- )
    dup nrf24_c@ rot and swap \ nrf24_c!
;


: nrf24_data_rate@
;

: nrf24_250Kbps!data_rate
    nRF24.RF_SETUP nrf24_c@
    nRF24.RF_DR_LOW 1#lshift nRF24.RF_DR_HIGH 1#lshift or invert 
    and dup \ FIXME
    nRF24.RF_SETUP nrf24_c!

    nRF24.RF_SETUP nrf24_c@ = ( setup -- false=0|true=1 ) \ Do we get back what we stored.
;

: nrf24_P?
    nRF24.RF_SETUP nrf24_c@
    \ Try setting radio to 250KBPS keep return value
    \ from nrf24_data_rate! as our answer.
    nrf24_250Kbps!data_rate
    swap nRF24.RF_SETUP nrf24_c!
;

\ : nrf24_CRC#!  ;
\ 0 constant nRF24.RF24_CRC_DISABLED \ nRF24.CONFIG.EN_CRC
: nrf24_crc_disable 
    nRF24.CONFIG.EN_CRC invert and
    nRF24.CONFIG nrf24_c!
;

\ 1 constant nRF24.RF24_CRC_8
: nrf24_crc_8
    nrf24_crc_disable
    nRF24.CONFIG.EN_CRC nrf24_c@ swap 1 swap lshift swap dup or nrf24_c!
;

\ 2 constant nRF24.RF24_CRC_16
: nrf24_crc_16
    nrf24_crc_disable
    nRF24.CONFIG.EN_CRC 1 rot lshift
    over nrf24_c@ ( CONFIG mask --  )
    or nrf24_c!
;

: nrf24_channel! ( channel -- )
    127 min nRF24.RF_CH nrf24_c!
;

: nrf24_flush_rx
    _csn low
    nRF24.FLUSH_TX c!@spi
    _csn high
;

: nrf24_flush_tx
    _csn low
    nRF24.FLUSH_RX c!@spi
    _csn high
;

\ enable spi for nRF24 set I/O
: nrf24_+spi ( -- )
    _irq pin_input
    _ce pin_output
    _csn pin_output
    _mosi pin_output
    _miso pin_input
    _clk pin_output

    -spi2x
    spi.SPE spi.MSTR or
    spi.f/4 or
    spi.mode0 or SPCR c!


    _ce low
    _csn high

    5 ms \ Necessary for config to stick
;

\ Final words.

: +nrf24
    \ Intialize spi for nrf24
    nrf24_+spi

    \ Set timeout.
    $4F nRF24.SETUP_RETR nrf24_c! \ ARD = b0100, ARC = b1111

    \ Set PA (Power Amplification level)
    $6 dup invert nRF24.RF_SETUP nrf24_c@ and or nrf24_c! \ PA_MAX

    \ Is this a *-P radio.
    nrf24_P? if ." *-P radio detected" then

    \ Set data-rate to 1MBPS.


    \ Set CRC length to 16.
\    nrf24_crc_16

    \ Disable dynamic payloads.
\    0 nRF24.DYNPD nrf24_c!

    \ Reset the status.
    nRF24.STATUS.RX_DR 1#lshift nRF24.STATUS.TX_DS 1#lshift or nRF24.STATUS.MAX_RT 1#lshift or nRF24.STATUS nrf24_c!

    \ 76 is safe and legal in the USA.
    76 nrf24_channel! drop

    \ flush the buffers
    nrf24_flush_rx drop
    nrf24_flush_tx drop
;

