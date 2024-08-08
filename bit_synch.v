module bitsync #(parameter num_stages = 2)
(
    input wire noisy_in,
    input wire rst_n,
    input wire clk ,

    output reg sync_sig 

);


reg [num_stages-1:0] Q;
integer i;

always @ (posedge clk or negedge rst_n)
  begin 
    if (!rst_n)
      begin 
        Q <= 'b0;
        sync_sig<=0;
      end
    else 
      begin 
        Q[0] <= noisy_in;
        for (i=1; i<=num_stages -1 ; i=i+1)
          begin 
           Q[i]<=Q[i-1];
          end
        sync_sig <= Q[num_stages-1];

      end

  end


endmodule 
