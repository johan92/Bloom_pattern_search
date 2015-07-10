/////////////////////////////////////////////////
//  Generated function for calculating CRC 32  //
/////////////////////////////////////////////////
//                                             //
//  Polynom: 04C11DB7                          //
//                                             //
//  Function was generated here:               //
//    http://www.easics.com/webtools/crctool   //                                //
//                                             //
//  Combinational logic was added after it.    //                                             //
//                                             //
/////////////////////////////////////////////////

module crc32_POL_1
#(
  parameter BYTES_CNT = 15 
)
(
  
  input        [BYTES_CNT-1:0][7:0] string_i,
  output logic [31:0]               crc32_res_o

);

logic [BYTES_CNT-1:0][7:0] data_to_crc;
logic [31:0]               crc32;

function [31:0] nextCRC32_D8;

  input [7:0] Data;
  input [31:0] crc;
  reg [7:0] d;
  reg [31:0] c;
  reg [31:0] newcrc;
begin
  d = Data;
  c = crc;

  newcrc[0] = d[6] ^ d[0] ^ c[24] ^ c[30];
  newcrc[1] = d[7] ^ d[6] ^ d[1] ^ d[0] ^ c[24] ^ c[25] ^ c[30] ^ c[31];
  newcrc[2] = d[7] ^ d[6] ^ d[2] ^ d[1] ^ d[0] ^ c[24] ^ c[25] ^ c[26] ^ c[30] ^ c[31];
  newcrc[3] = d[7] ^ d[3] ^ d[2] ^ d[1] ^ c[25] ^ c[26] ^ c[27] ^ c[31];
  newcrc[4] = d[6] ^ d[4] ^ d[3] ^ d[2] ^ d[0] ^ c[24] ^ c[26] ^ c[27] ^ c[28] ^ c[30];
  newcrc[5] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[3] ^ d[1] ^ d[0] ^ c[24] ^ c[25] ^ c[27] ^ c[28] ^ c[29] ^ c[30] ^ c[31];
  newcrc[6] = d[7] ^ d[6] ^ d[5] ^ d[4] ^ d[2] ^ d[1] ^ c[25] ^ c[26] ^ c[28] ^ c[29] ^ c[30] ^ c[31];
  newcrc[7] = d[7] ^ d[5] ^ d[3] ^ d[2] ^ d[0] ^ c[24] ^ c[26] ^ c[27] ^ c[29] ^ c[31];
  newcrc[8] = d[4] ^ d[3] ^ d[1] ^ d[0] ^ c[0] ^ c[24] ^ c[25] ^ c[27] ^ c[28];
  newcrc[9] = d[5] ^ d[4] ^ d[2] ^ d[1] ^ c[1] ^ c[25] ^ c[26] ^ c[28] ^ c[29];
  newcrc[10] = d[5] ^ d[3] ^ d[2] ^ d[0] ^ c[2] ^ c[24] ^ c[26] ^ c[27] ^ c[29];
  newcrc[11] = d[4] ^ d[3] ^ d[1] ^ d[0] ^ c[3] ^ c[24] ^ c[25] ^ c[27] ^ c[28];
  newcrc[12] = d[6] ^ d[5] ^ d[4] ^ d[2] ^ d[1] ^ d[0] ^ c[4] ^ c[24] ^ c[25] ^ c[26] ^ c[28] ^ c[29] ^ c[30];
  newcrc[13] = d[7] ^ d[6] ^ d[5] ^ d[3] ^ d[2] ^ d[1] ^ c[5] ^ c[25] ^ c[26] ^ c[27] ^ c[29] ^ c[30] ^ c[31];
  newcrc[14] = d[7] ^ d[6] ^ d[4] ^ d[3] ^ d[2] ^ c[6] ^ c[26] ^ c[27] ^ c[28] ^ c[30] ^ c[31];
  newcrc[15] = d[7] ^ d[5] ^ d[4] ^ d[3] ^ c[7] ^ c[27] ^ c[28] ^ c[29] ^ c[31];
  newcrc[16] = d[5] ^ d[4] ^ d[0] ^ c[8] ^ c[24] ^ c[28] ^ c[29];
  newcrc[17] = d[6] ^ d[5] ^ d[1] ^ c[9] ^ c[25] ^ c[29] ^ c[30];
  newcrc[18] = d[7] ^ d[6] ^ d[2] ^ c[10] ^ c[26] ^ c[30] ^ c[31];
  newcrc[19] = d[7] ^ d[3] ^ c[11] ^ c[27] ^ c[31];
  newcrc[20] = d[4] ^ c[12] ^ c[28];
  newcrc[21] = d[5] ^ c[13] ^ c[29];
  newcrc[22] = d[0] ^ c[14] ^ c[24];
  newcrc[23] = d[6] ^ d[1] ^ d[0] ^ c[15] ^ c[24] ^ c[25] ^ c[30];
  newcrc[24] = d[7] ^ d[2] ^ d[1] ^ c[16] ^ c[25] ^ c[26] ^ c[31];
  newcrc[25] = d[3] ^ d[2] ^ c[17] ^ c[26] ^ c[27];
  newcrc[26] = d[6] ^ d[4] ^ d[3] ^ d[0] ^ c[18] ^ c[24] ^ c[27] ^ c[28] ^ c[30];
  newcrc[27] = d[7] ^ d[5] ^ d[4] ^ d[1] ^ c[19] ^ c[25] ^ c[28] ^ c[29] ^ c[31];
  newcrc[28] = d[6] ^ d[5] ^ d[2] ^ c[20] ^ c[26] ^ c[29] ^ c[30];
  newcrc[29] = d[7] ^ d[6] ^ d[3] ^ c[21] ^ c[27] ^ c[30] ^ c[31];
  newcrc[30] = d[7] ^ d[4] ^ c[22] ^ c[28] ^ c[31];
  newcrc[31] = d[5] ^ c[23] ^ c[29];
  nextCRC32_D8 = newcrc;
end
endfunction

always_comb
  begin
    crc32 = '1;
    for( int i = 0; i < BYTES_CNT; i++ )
      begin
        crc32 = nextCRC32_D8( string_i[ i ], crc32 );
      end
  end

assign crc32_res_o = crc32;

endmodule
