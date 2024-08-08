module timer #(parameter counter_final_value =99) (
    input wire clk,
    input wire rst_n,
    input wire timer_en,

    output reg timer_done
);

/// 
reg [6:0] counter;
parameter [6:0] counter_final_=counter_final_value;

////////////////////

assign timer_done = (counter == counter_final_)?  1'b1: 1'b0;
//////////////

always @ (posedge clk or negedge rst_n)
begin
    
    if(!rst_n) 
        begin 
            counter <=0;
        end
    else if(timer_en && !timer_done)
        begin 
        counter <= counter + 'b1;
        end
    else 
        begin 
        counter <= 0;
        end
end
endmodule