module iiitb_piso (clk, load, data_in, data_out);
  
  input clk, load;
  input [3:0]data_in;
  output data_out;

  // PISO register array to load and shift data
  reg [3:0]q= 0;
  
  always @ (posedge clk) 
  begin
    if (~load)
      q <= data_in;// Load the data to the PISO register array 
    else
    begin // Shift the loaded data 1 bit right; into the serial data out register
      q[0]=q[1];
      q[1]=q[2];
      q[2]=q[3];
      q[3]=1'bx;
    end
  end
  assign data_out= q[0]; //Serial Output
endmodule