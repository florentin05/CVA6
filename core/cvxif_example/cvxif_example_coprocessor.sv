// Copyright 2021 Thales DIS design services SAS
//
// Licensed under the Solderpad Hardware Licence, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// SPDX-License-Identifier: Apache-2.0 WITH SHL-2.0
// You may obtain a copy of the License at https://solderpad.org/licenses/
//
// Original Author: Guillaume Chauvon (guillaume.chauvon@thalesgroup.com)
// Modified by Ilie Florentin
//Coprocessor implements 3 algorithms in order to highlight the increased system performance due to the integration of the hardware accelerator

module cvxif_example_coprocessor import cvxif_pkg::*;
                                 import cvxif_instr_pkg::*;(
    input   logic                   clk_i,                      // Clock
    input   logic                   rst_ni,                     // Asynchronous reset active low
    input   cvxif_req_t             cvxif_req_i,
    output  cvxif_resp_t            cvxif_resp_o
);

  //Compressed interface
  logic                   x_compressed_valid_i;
  logic                   x_compressed_ready_o;
  x_compressed_req_t      x_compressed_req_i;
  x_compressed_resp_t     x_compressed_resp_o;
  //Issue interface
  logic                   x_issue_valid_i;
  logic                   x_issue_ready_o;
  x_issue_req_t           x_issue_req_i;
  x_issue_resp_t          x_issue_resp_o;
  //Commit interface
  logic                   x_commit_valid_i;
  x_commit_t              x_commit_i;
  //Memory interface
  logic                   x_mem_valid_o;
  logic                   x_mem_ready_i;
  x_mem_req_t             x_mem_req_o;
  x_mem_resp_t            x_mem_resp_i;
  //Memory result interface
  logic                   x_mem_result_valid_i;
  x_mem_result_t          x_mem_result_i;
  //Result interface
  logic                   x_result_valid_o;
  logic                   x_result_ready_i;
  x_result_t              x_result_o;

  assign x_compressed_valid_i = cvxif_req_i.x_compressed_valid;
  assign x_compressed_req_i   = cvxif_req_i.x_compressed_req;
  assign x_issue_valid_i      = cvxif_req_i.x_issue_valid;
  assign x_issue_req_i        = cvxif_req_i.x_issue_req;
  assign x_commit_valid_i     = cvxif_req_i.x_commit_valid;
  assign x_commit_i           = cvxif_req_i.x_commit;
  assign x_mem_ready_i        = cvxif_req_i.x_mem_ready;
  assign x_mem_resp_i         = cvxif_req_i.x_mem_resp;
  assign x_mem_result_valid_i = cvxif_req_i.x_mem_result_valid;
  assign x_mem_result_i       = cvxif_req_i.x_mem_result;
  assign x_result_ready_i     = cvxif_req_i.x_result_ready;

  assign cvxif_resp_o.x_compressed_ready = x_compressed_ready_o;
  assign cvxif_resp_o.x_compressed_resp  = x_compressed_resp_o;
  assign cvxif_resp_o.x_issue_ready      = x_issue_ready_o;
  assign cvxif_resp_o.x_issue_resp       = x_issue_resp_o;
  assign cvxif_resp_o.x_mem_valid        = x_mem_valid_o;
  assign cvxif_resp_o.x_mem_req          = x_mem_req_o;
  assign cvxif_resp_o.x_result_valid     = x_result_valid_o;
  assign cvxif_resp_o.x_result           = x_result_o;

  //Compressed interface
  assign x_compressed_ready_o       = '0;
  assign x_compressed_resp_o.instr  = '0;
  assign x_compressed_resp_o.accept = '0;

  instr_decoder #(
    .NbInstr          ( cvxif_instr_pkg::NbInstr    ),
    .CoproInstr       ( cvxif_instr_pkg::CoproInstr )
  ) instr_decoder_i (
    .clk_i            ( clk_i                       ),
    .x_issue_req_i    ( x_issue_req_i               ),
    .x_issue_resp_o   ( x_issue_resp_o              )
  );

  typedef struct packed {
    x_issue_req_t  req;
    x_issue_resp_t resp;
  } x_issue_t;

  logic fifo_full, fifo_empty;
  logic x_issue_ready_q;
  logic instr_push, instr_pop;
  x_issue_t  req_i;
  x_issue_t  req_o;



  assign instr_push = x_issue_resp_o.accept ? 1 : 0 ;
  assign instr_pop = (x_commit_i.x_commit_kill && x_commit_valid_i) || x_result_valid_o;
  assign x_issue_ready_q = ~fifo_full; // if something is in the fifo, the instruction is being processed
                                        // so we can't receive anything else
  assign req_i.req = x_issue_req_i;
  assign req_i.resp = x_issue_resp_o;

  always_ff @(posedge clk_i or negedge rst_ni) begin : regs
    if(!rst_ni) begin
      x_issue_ready_o <= 1;
    end else begin
      x_issue_ready_o <= x_issue_ready_q;
    end
  end

  fifo_v3 #(
    .FALL_THROUGH ( 1         ), //data_o ready and pop in the same cycle
    .DATA_WIDTH   ( 64        ),
    .DEPTH        ( 8         ),
    .dtype        ( x_issue_t )
    ) fifo_commit_i (
    .clk_i        ( clk_i      ),
    .rst_ni       ( rst_ni     ),
    .flush_i      ( 1'b0       ),
    .testmode_i   ( 1'b0       ),
    .full_o       ( fifo_full  ),
    .empty_o      ( fifo_empty ),
    .usage_o      (            ),
    .data_i       ( req_i      ),
    .push_i       ( instr_push ),
    .data_o       ( req_o      ),
    .pop_i        ( instr_pop  )
  );

  logic [3:0] c;
  counter #(
    .WIDTH(4)
  ) counter_i(
    .clk_i      ( clk_i),
    .rst_ni     ( rst_ni),
    .clear_i    ( ~x_commit_i.x_commit_kill && x_commit_valid_i ),
    .en_i       ( 1'b1 ),
    .load_i     (      ),
    .down_i     (      ),
    .d_i        (      ),
    .q_o        ( c    ),
    .overflow_o (      )
  );

  /*always_comb begin
    x_result_valid_o    = (c == x_result_o.data[3:0]) && ~fifo_empty ? 1 : 0;
    x_result_o.id       = req_o.req.id;
    x_result_o.data     = req_o.req.rs[0] + req_o.req.rs[1] + ( X_NUM_RS == 3 ? req_o.req.rs[2] : 0);
    x_result_o.rd       = req_o.req.instr[11:7];
    x_result_o.we       = req_o.resp.writeback & x_result_valid_o;
    x_result_o.exc      = 0;
    x_result_o.exccode  = 0;
  end*/
  
  
  logic [1:0] sum2_0,sum2_1,sum2_2,sum2_3,sum2_4,sum2_5,sum2_6,sum2_7,sum2_8,sum2_9,sum2_10,sum2_11,sum2_12,sum2_13,sum2_14,sum2_15;
  logic [1:0] sum2_16,sum2_17,sum2_18,sum2_19,sum2_20,sum2_21,sum2_22,sum2_23,sum2_24,sum2_25,sum2_26,sum2_27,sum2_28,sum2_29,sum2_30,sum2_31;
  logic [3:0] sum4_0,sum4_1,sum4_2,sum4_3,sum4_4,sum4_5,sum4_6,sum4_7,sum4_8,sum4_9,sum4_10,sum4_11,sum4_12,sum4_13,sum4_14,sum4_15;
  logic [7:0] sum8_0,sum8_1,sum8_2,sum8_3,sum8_4,sum8_5,sum8_6,sum8_7;
  logic [15:0] sum16_0,sum16_1,sum16_2,sum16_3;
  logic [31:0] sum32_0,sum32_1;
  
  logic [7:0] pos1,pos2;
  
  logic [7:0] max_8b;
  logic [15:0] max_16b;
  logic [31:0] max_32b;
  
  always_comb begin
    x_result_valid_o    = (c == x_result_o.data[3:0]) && ~fifo_empty ? 1 : 0;
    x_result_o.id       = req_o.req.id;
    x_result_o.rd       = req_o.req.instr[11:7];
    x_result_o.we       = req_o.resp.writeback & x_result_valid_o;
    x_result_o.exc      = 0;
    x_result_o.exccode  = 0;
    if(req_o.req.instr[6:0] == 7'b1011011) begin
    
    	sum2_0 = req_o.req.rs[0][0] + req_o.req.rs[0][1];
        sum2_1 = req_o.req.rs[0][2] + req_o.req.rs[0][3];
        sum2_2 = req_o.req.rs[0][4] + req_o.req.rs[0][5];
        sum2_3 = req_o.req.rs[0][6] + req_o.req.rs[0][7];
        sum2_4 = req_o.req.rs[0][8] + req_o.req.rs[0][9];
        sum2_5 = req_o.req.rs[0][10] + req_o.req.rs[0][11];
        sum2_6 = req_o.req.rs[0][12] + req_o.req.rs[0][13];
        sum2_7 = req_o.req.rs[0][14] + req_o.req.rs[0][15];
        sum2_8 = req_o.req.rs[0][16] + req_o.req.rs[0][17];
        sum2_9 = req_o.req.rs[0][18] + req_o.req.rs[0][19];
        sum2_10 = req_o.req.rs[0][20] + req_o.req.rs[0][21];
        sum2_11 = req_o.req.rs[0][22] + req_o.req.rs[0][23];
        sum2_12 = req_o.req.rs[0][24] + req_o.req.rs[0][25];
        sum2_13 = req_o.req.rs[0][26] + req_o.req.rs[0][27];
        sum2_14 = req_o.req.rs[0][28] + req_o.req.rs[0][29];
        sum2_15 = req_o.req.rs[0][30] + req_o.req.rs[0][31];
        sum2_16 = req_o.req.rs[0][32] + req_o.req.rs[0][33];
        sum2_17 = req_o.req.rs[0][34] + req_o.req.rs[0][35];
        sum2_18 = req_o.req.rs[0][36] + req_o.req.rs[0][37];
        sum2_19 = req_o.req.rs[0][38] + req_o.req.rs[0][39];
        sum2_20 = req_o.req.rs[0][40] + req_o.req.rs[0][41];
        sum2_21 = req_o.req.rs[0][42] + req_o.req.rs[0][43];
        sum2_22 = req_o.req.rs[0][44] + req_o.req.rs[0][45];
        sum2_23 = req_o.req.rs[0][46] + req_o.req.rs[0][47];
        sum2_24 = req_o.req.rs[0][48] + req_o.req.rs[0][49];
        sum2_25 = req_o.req.rs[0][50] + req_o.req.rs[0][51];
        sum2_26 = req_o.req.rs[0][52] + req_o.req.rs[0][53];
        sum2_27 = req_o.req.rs[0][54] + req_o.req.rs[0][55];
        sum2_28 = req_o.req.rs[0][56] + req_o.req.rs[0][57];
        sum2_29 = req_o.req.rs[0][58] + req_o.req.rs[0][59];
        sum2_30 = req_o.req.rs[0][60] + req_o.req.rs[0][61];
        sum2_31 = req_o.req.rs[0][62] + req_o.req.rs[0][63];
            
        sum4_0 = sum2_0 + sum2_1;
        sum4_1 = sum2_2 + sum2_3;
        sum4_2 = sum2_4 + sum2_5;
        sum4_3 = sum2_6 + sum2_7;
        sum4_4 = sum2_8 + sum2_9;
        sum4_5 = sum2_10 + sum2_11;
        sum4_6 = sum2_12 + sum2_13;
        sum4_7 = sum2_14 + sum2_15;
        sum4_8 = sum2_16 + sum2_17;
        sum4_9 = sum2_18 + sum2_19;
        sum4_10 = sum2_20 + sum2_21;
        sum4_11 = sum2_22 + sum2_23;
        sum4_12 = sum2_24 + sum2_25;
        sum4_13 = sum2_26 + sum2_27;
        sum4_14 = sum2_28 + sum2_29;
        sum4_15 = sum2_30 + sum2_31;
            
        sum8_0 = sum4_0 + sum4_1;
        sum8_1 = sum4_2 + sum4_3;
        sum8_2 = sum4_4 + sum4_5;
        sum8_3 = sum4_6 + sum4_7;
        sum8_4 = sum4_8 + sum4_9;
        sum8_5 = sum4_10 + sum4_11;
        sum8_6 = sum4_12 + sum4_13;
        sum8_7 = sum4_14 + sum4_15;
            
        sum16_0 = sum8_0 + sum8_1;
        sum16_1 = sum8_2 + sum8_3;
        sum16_2 = sum8_4 + sum8_5;
        sum16_3 = sum8_6 + sum8_7;
             
        sum32_0 = sum16_0+sum16_1;
        sum32_1 = sum16_2+sum16_3;
            
        x_result_o.data=sum32_0+sum32_1;
    end else if (req_o.req.instr[6:0] == 7'b0101011) begin
    	casex (req_o.req.rs[0][63:32])
                32'b1xxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h3F;
                32'bx1xxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h3E;
                32'bxx1xxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h3D;
                32'bxxx1xxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h3C;
                
                32'bxxxx1xxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h3B;
                32'bxxxxx1xx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h3A;
                32'bxxxxxx1x_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h39;
                32'bxxxxxxx1_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h38;
                
                32'bxxxxxxxx_1xxxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h37;
                32'bxxxxxxxx_x1xxxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h36;
                32'bxxxxxxxx_xx1xxxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h35;
                32'bxxxxxxxx_xxx1xxxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h34;
                
                32'bxxxxxxxx_xxxx1xxx_xxxxxxxx_xxxxxxxx : pos1 = 8'h33;
                32'bxxxxxxxx_xxxxx1xx_xxxxxxxx_xxxxxxxx : pos1 = 8'h32;
                32'bxxxxxxxx_xxxxxx1x_xxxxxxxx_xxxxxxxx : pos1 = 8'h31;
                32'bxxxxxxxx_xxxxxxx1_xxxxxxxx_xxxxxxxx : pos1 = 8'h30;
                
                32'bxxxxxxxx_xxxxxxxx_1xxxxxxx_xxxxxxxx : pos1 = 8'h2F;
                32'bxxxxxxxx_xxxxxxxx_x1xxxxxx_xxxxxxxx : pos1 = 8'h2E;
                32'bxxxxxxxx_xxxxxxxx_xx1xxxxx_xxxxxxxx : pos1 = 8'h2D;
                32'bxxxxxxxx_xxxxxxxx_xxx1xxxx_xxxxxxxx : pos1 = 8'h2C;
               
                32'bxxxxxxxx_xxxxxxxx_xxxx1xxx_xxxxxxxx : pos1 = 8'h2B;
                32'bxxxxxxxx_xxxxxxxx_xxxxx1xx_xxxxxxxx : pos1 = 8'h2A;
                32'bxxxxxxxx_xxxxxxxx_xxxxxx1x_xxxxxxxx : pos1 = 8'h29;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxx1_xxxxxxxx : pos1 = 8'h28;
               
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_1xxxxxxx : pos1 = 8'h27;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_x1xxxxxx : pos1 = 8'h26;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xx1xxxxx : pos1 = 8'h25;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxx1xxxx : pos1 = 8'h24;
                
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxx1xxx  : pos1 = 8'h23;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxx1xx  : pos1 = 8'h22;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxx1x  : pos1 = 8'h21;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxx1  : pos1 = 8'h20;
                default: pos1 = 8'h00;
                
        endcase
             
        casex(req_o.req.rs[0][31:0])
                32'b1xxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h1F;
                32'bx1xxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h1E;
                32'bxx1xxxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h1D;
                32'bxxx1xxxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h1C;
                
                32'bxxxx1xxx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h1B;
                32'bxxxxx1xx_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h1A;
                32'bxxxxxx1x_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h19;
                32'bxxxxxxx1_xxxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h18;
                
                32'bxxxxxxxx_1xxxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h17;
                32'bxxxxxxxx_x1xxxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h16;
                32'bxxxxxxxx_xx1xxxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h15;
                32'bxxxxxxxx_xxx1xxxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h14;
                
                32'bxxxxxxxx_xxxx1xxx_xxxxxxxx_xxxxxxxx : pos2 = 8'h13;
                32'bxxxxxxxx_xxxxx1xx_xxxxxxxx_xxxxxxxx : pos2 = 8'h12;
                32'bxxxxxxxx_xxxxxx1x_xxxxxxxx_xxxxxxxx : pos2 = 8'h11;
                32'bxxxxxxxx_xxxxxxx1_xxxxxxxx_xxxxxxxx : pos2 = 8'h10;
                
                32'bxxxxxxxx_xxxxxxxx_1xxxxxxx_xxxxxxxx : pos2 = 8'h0F;
                32'bxxxxxxxx_xxxxxxxx_x1xxxxxx_xxxxxxxx : pos2 = 8'h0E;
                32'bxxxxxxxx_xxxxxxxx_xx1xxxxx_xxxxxxxx : pos2 = 8'h0D;
                32'bxxxxxxxx_xxxxxxxx_xxx1xxxx_xxxxxxxx : pos2 = 8'h0C;
                
                32'bxxxxxxxx_xxxxxxxx_xxxx1xxx_xxxxxxxx : pos2 = 8'h0B;
                32'bxxxxxxxx_xxxxxxxx_xxxxx1xx_xxxxxxxx : pos2 = 8'h0A;
                32'bxxxxxxxx_xxxxxxxx_xxxxxx1x_xxxxxxxx : pos2 = 8'h09;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxx1_xxxxxxxx : pos2 = 8'h08;
                
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_1xxxxxxx : pos2 = 8'h07;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_x1xxxxxx : pos2 = 8'h06;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xx1xxxxx : pos2 = 8'h05;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxx1xxxx : pos2 = 8'h04;
                
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxx1xxx : pos2 = 8'h03;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxx1xx : pos2 = 8'h02;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxx1x : pos2 = 8'h01;
                32'bxxxxxxxx_xxxxxxxx_xxxxxxxx_xxxxxxx1 : pos2 = 8'h00;
                
                default: pos2 = 8'h00;                     
        endcase
             
        x_result_o.data = (pos1 == 8'h00 ? {56'h00000000000000,pos2}:{56'h00000000000000,pos1}) ;
    	
    end else if (req_o.req.instr[6:0] == 7'b0001011) begin
    	case (req_o.req.rs[1][1:0])
              
              2'b00: begin 
                     max_8b = req_o.req.rs[0][63:56];
                     max_8b = req_o.req.rs[0][55:48] > max_8b ? req_o.req.rs[0][55:48] : max_8b;
                     max_8b = req_o.req.rs[0][47:40] > max_8b ? req_o.req.rs[0][47:40] : max_8b;
                     max_8b = req_o.req.rs[0][39:32] > max_8b ? req_o.req.rs[0][39:32] : max_8b;
                     max_8b = req_o.req.rs[0][31:24] > max_8b ? req_o.req.rs[0][41:24] : max_8b;
                     max_8b = req_o.req.rs[0][23:16] > max_8b ? req_o.req.rs[0][23:16] : max_8b;
                     max_8b = req_o.req.rs[0][15:8] > max_8b ? req_o.req.rs[0][15:8] : max_8b;
                     max_8b = req_o.req.rs[0][7:0] > max_8b ? req_o.req.rs[0][7:0] : max_8b;
                     
                     x_result_o.data={56'h00000000000000,max_8b};
              end
              2'b01: begin
                    
                    max_16b = req_o.req.rs[0][63:48];
                    max_16b = req_o.req.rs[0][47:32] > max_16b ? req_o.req.rs[0][47:32] : max_16b;
                    max_16b = req_o.req.rs[0][31:16] > max_16b ? req_o.req.rs[0][31:16] : max_16b;
                    max_16b = req_o.req.rs[0][15:0] > max_16b ? req_o.req.rs[0][15:0] : max_16b;
                    
                    x_result_o.data={48'h000000000000,max_16b};
              end
              
              2'b10: begin
              
                    max_32b = req_o.req.rs[0][63:32];
                    max_32b = req_o.req.rs[0][31:0] > max_32b? req_o.req.rs[0][31:0] : max_32b;
                    
                    x_result_o.data={32'h00000000,max_32b};
              end 
        endcase
    end
  end

  endmodule
