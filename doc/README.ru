BLOOM-FILTER PATTERN SEARCH ON FPGA

���� ������ ����������� ����� ���������� ��������� 
������ ����� � ������� ������� ����� �� ����� SystemVerilog.

������ ���� ������ ����������� �� ��������� Linux ��������� ���������
���������:

  - Python 2.7.8

  - ModelSim SE-64 10.0c

  - Quartus II 64-bit 14.0.0

��������� ���������� �� ���� Arria II GX EP2AGX125DF25C6:

+---------------------------------------------------------------------------------+
; Fitter Summary                                                                  ;
+-----------------------------------+---------------------------------------------+
; Fitter Status                     ; Successful - Wed May 27 18:08:54 2015       ;
; Quartus II 64-Bit Version         ; 14.0.0 Build 200 06/17/2014 SJ Full Version ;
; Revision Name                     ; top_bloom                                   ;
; Top-level Entity Name             ; tap_bloom                                   ;
; Family                            ; Arria II GX                                 ;
; Device                            ; EP2AGX125DF25C6                             ;
; Timing Models                     ; Final                                       ;
; Logic utilization                 ; 12 %                                        ;
;     Combinational ALUTs           ; 8,391 / 99,280 ( 8 % )                      ;
;     Memory ALUTs                  ; 0 / 49,640 ( 0 % )                          ;
;     Dedicated logic registers     ; 8,017 / 99,280 ( 8 % )                      ;
; Total registers                   ; 8017                                        ;
; Total pins                        ; 154 / 300 ( 51 % )                          ;
; Total virtual pins                ; 0                                           ;
; Total block memory bits           ; 266,240 / 6,727,680 ( 4 % )                 ;
; DSP block 18-bit elements         ; 0 / 576 ( 0 % )                             ;
; Total GXB Receiver Channel PCS    ; 0 / 8 ( 0 % )                               ;
; Total GXB Receiver Channel PMA    ; 0 / 8 ( 0 % )                               ;
; Total GXB Transmitter Channel PCS ; 0 / 8 ( 0 % )                               ;
; Total GXB Transmitter Channel PMA ; 0 / 8 ( 0 % )                               ;
; Total PLLs                        ; 0 / 6 ( 0 % )                               ;
; Total DLLs                        ; 0 / 2 ( 0 % )                               ;
+-----------------------------------+---------------------------------------------+

+---------------------------------------------------------------------------------+
; Fmax Summary                                                                    ;
+-----------------------------------+---------------------------------------------+
; clk_i                             ; 153.87 MHz                                  ;
+-----------------------------------+---------------------------------------------+

������ �������� � ����:

  - �������, �� ����� python ��� ��������� ������ � ��������
    ���������.

  - ������, �� ����� SystemVerilog, ����������� ����� ����� � �������
    ������.

  - ����� ������ ��� ��������� ������ ������.

������ ������ �� 3 �����:

  - py_utils - ����� ������ python-������� ��� ���������/��������
    ���������. ���� READMEru � ����������� �����������.

  - rtl - ����� �� ����� ������� ������ ��� FPGA. � READMEru ������� ���
    �������� ������� � ��������� �������.

  - testbench - ���������� ����� �������. ����� ���� README �
    ��������� ���������.


�������� ��������� �������:

  � ������ �� ������ ������� �������� ������������� �������� ���������
  �������, � ������:

    MIN_S       - ����������� ����� �������, ������� ����� �������� �
                  ������ �������.

    MAX_S       - ������������ ����� �������, ������� ����� �������� �
                  ������ �������.

    HASH_CNT    - ���������� ���-�������.

    HASH_WIDTH  - ���-�� ��� ��� ����� ���-�������.

  �����:

    MIN_S � MAX_S - ���������, ������� ����� ������, �� ����������
    ������, ���� MIN_S ����� ������ ��� MAX_S.

    HASH_CNT � HASH_WIDTH - ���������, ��� ���������� �������
    ��������� ���������� ������. �� ����� �������� ������ �����
    ������������ ��������� � ������.

���������� �������:

  ������ ������ � ������� �����.
  �������� ���:

    - ��������� ��������� ���������� ��� FPGA;
    - �������� ������ ��������� ����� ��� ������ �����;
    - ������� ���-�� ������������������ ������������ � �������� �����;
    - ������������ ������ ����� ������ ����� � ��������� ������.
