module fsm (
    input wire sync_sig ,
    input wire clk,rst_n,
    input wire timer_done,

    output reg timer_en,
    output reg debouncer_out

);

reg [2:0] next_state,current_state ;

localparam [2:0] idle = 'b000 ,
                 check_high ='b001,
                 high_state ='b011,
                 check_low = 'b010;
                 

// state_transition  
always @ (posedge clk or negedge rst_n )
begin 
  if(!rst_n)
  begin 
    current_state = idle;
  end
  else
  begin 
     current_state = next_state;
  end
end


// next_state logic

always @ (*) 
begin 
 
 case (current_state )
 
 idle: begin 
    if(sync_sig)
    begin 
        next_state = check_high ;
    end
    else 
    begin 
        next_state = idle;
    end
 end

check_high : begin 
    if(!timer_done)
    begin 
        next_state= check_high;
    end
    else if (sync_sig)
    begin
        next_state = high_state;
    end
    else
    begin
       next_state = idle;
    end

end

high_state : begin 
    if(!sync_sig)
    begin 
        next_state = check_low;
    end
    else 
    begin
        next_state = high_state;
    end
end
check_low :begin 
    if(!timer_done)
    begin 
        next_state = check_low;
    end
    else if (!sync_sig)
    begin 
         next_state = idle;
    end
    else 
    begin 
        next_state=high_state;
    end
end
endcase
end

// output logic

always @ (*) 
begin 
case (current_state )

idle  :begin 
timer_en=0;
debouncer_out=0;
end

check_high : begin 
    timer_en = 'b1; 
    debouncer_out= 'b0;
end

high_state :begin 
    timer_en = 'b0;
    debouncer_out='b1;
end

check_low : begin 
       timer_en = 'b1;
    debouncer_out='b1;
end
default : begin 
    timer_en=0;
debouncer_out=0;
end
endcase
end

endmodule