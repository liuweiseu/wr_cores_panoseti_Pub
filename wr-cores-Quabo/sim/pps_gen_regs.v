`define ADDR_PPSG_CR                   5'h0
`define PPSG_CR_CNT_RST_OFFSET 0
`define PPSG_CR_CNT_RST 32'h00000001
`define PPSG_CR_CNT_EN_OFFSET 1
`define PPSG_CR_CNT_EN 32'h00000002
`define PPSG_CR_CNT_ADJ_OFFSET 2
`define PPSG_CR_CNT_ADJ 32'h00000004
`define PPSG_CR_CNT_SET_OFFSET 3
`define PPSG_CR_CNT_SET 32'h00000008
`define PPSG_CR_PWIDTH_OFFSET 4
`define PPSG_CR_PWIDTH 32'hfffffff0
`define ADDR_PPSG_CNTR_NSEC            5'h4
`define ADDR_PPSG_CNTR_UTCLO           5'h8
`define ADDR_PPSG_CNTR_UTCHI           5'hc
`define ADDR_PPSG_ADJ_NSEC             5'h10
`define ADDR_PPSG_ADJ_UTCLO            5'h14
`define ADDR_PPSG_ADJ_UTCHI            5'h18
`define ADDR_PPSG_ESCR                 5'h1c
`define PPSG_ESCR_SYNC_OFFSET 0
`define PPSG_ESCR_SYNC 32'h00000001
`define PPSG_ESCR_PPS_UNMASK_OFFSET 1
`define PPSG_ESCR_PPS_UNMASK 32'h00000002
`define PPSG_ESCR_PPS_VALID_OFFSET 2
`define PPSG_ESCR_PPS_VALID 32'h00000004
`define PPSG_ESCR_TM_VALID_OFFSET 3
`define PPSG_ESCR_TM_VALID 32'h00000008
`define PPSG_ESCR_SEC_SET_OFFSET 4
`define PPSG_ESCR_SEC_SET 32'h00000010
`define PPSG_ESCR_NSEC_SET_OFFSET 5
`define PPSG_ESCR_NSEC_SET 32'h00000020
