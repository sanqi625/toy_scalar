 /*                                                                      
 Copyright 2018 Nuclei System Technology, Inc.                
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
  Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */                                                                      
                                                                         
                                                                         
                                                                         
//=====================================================================
//
// Designer   : Bob Hu
//
// Description:
//  The module for debug RAM program
//
// ====================================================================

module debug_ram #(
        parameter SRAM_DEPTH = 16,
        parameter SRAM_DEPTH_LOG = $clog2(SRAM_DEPTH)
)(
  input  logic clk,
  input  logic rst_n,
  input  logic ram_cs,
  input  logic ram_wr_en,
  input  logic [SRAM_DEPTH_LOG-1:0]  ram_addr, 
  input  logic [32-1:0]              ram_wdat,  
  output logic [32-1:0]              ram_dout  
  );
        
  reg [31:0] debug_ram_r [0:SRAM_DEPTH-1]; 

  wire [SRAM_DEPTH-1:0] ram_wen;

  genvar i;
  generate
  
      for (i=0; i<SRAM_DEPTH; i=i+1) begin:debug_ram_gen
  
            assign ram_wen[i] = ram_cs & (ram_wr_en) & (ram_addr == i) ;
            
            always_ff @( posedge clk or negedge rst_n ) begin
                if(!rst_n)
                    debug_ram_r[i] <= 32'b0;
                else if(ram_wen[i])
                    debug_ram_r[i] <= ram_wdat[31:0];
            end
        end

  endgenerate

  always_ff @( posedge clk or negedge rst_n ) begin
    if(!rst_n)
        ram_dout[31:0] <= 'b0;
    else if(ram_cs && ~ram_wen)
        ram_dout[31:0] <= debug_ram_r[ram_addr];
  end

endmodule

