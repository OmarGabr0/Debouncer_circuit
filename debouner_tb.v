
`timescale 1ns/1ps

module debouncer_tb ();

/////////////////////////////////////////////////////////
///////////////////// Parameters ////////////////////////
/////////////////////////////////////////////////////////

parameter clockperiod = 10;
parameter num_stages = 2;
parameter counter_final_value = 99 ;
/////////////////////////////////////////////////////////
//////////////////// DUT Signals ////////////////////////
/////////////////////////////////////////////////////////
reg noisy_in;
reg rst_n;
reg clk;

wire debouncer_out;

////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////

initial
 begin

 // Initialization
 initialize() ;

 // Reset
 reset() ; 
////////////////////////////////////////////////////
// case 1: testing noise then  high input 
 $display("==================================");
 $display("========= TEST CASE 1 ============");
 $display("testing noisy input that settle at high state");
noisy_in='b0;
noise_in('b1);
settle_at('b1);


if (debouncer_out==1'b1)
    begin 
        $display ("TEST CASE 1 --> PASSED ");
        $display ("debouncer_out settled at %0d as should be",debouncer_out);
    end
else 
    begin 
        $display ("TEST CASE 1 --> FIALED ");
        $display ("debouncer_out settled at %0d ",debouncer_out);
    end
settle_at('b1);   // to be visible 
$display("==================================");
////////////////////////////////////////////////////
// case 2 : testing glitch input  while being in high state
noisy_in='b0;

noise_in('b1);
noisy_in = 'b1;

repeat(100) @(posedge clk);
 $display("==================================");
 $display("========= TEST CASE 2 ============");
 $display("testing glitch ");

 
if (debouncer_out==1'b1)
    begin 
        $display ("TEST CASE 2 --> PASSED ");
        $display ("debouncer_out settled at %0d as should be",debouncer_out);
    end
else 
    begin 
        $display ("TEST CASE 2 --> FAILED ");
        $display ("debouncer_out settled at %0d ",debouncer_out);
    end
settle_at('b1);   // to be visible 
$display("==================================");
////////////////////////////////////////////////////
// case 3: testing noise then  low input 
 $display("==================================");
 $display("========= TEST CASE 3 ============");
 $display("testing noisy input that settle at high state");
noisy_in='b0;
noise_in('b1);
settle_at('b0);


if (debouncer_out==1'b0)
    begin 
        $display ("TEST CASE 3 --> PASSED ");
        $display ("debouncer_out settled at %0d as should be",debouncer_out);
    end
else 
    begin 
        $display ("TEST CASE 3 --> FAILED ");
        $display ("debouncer_out settled at %0d ",debouncer_out);
    end
settle_at('b0);   // to be visible 
$display("==================================");
////////////////////////////////////////////////////
// case 4 : testing glitch input  while being in low state
noisy_in='b0;

noise_in('b1);
noisy_in = 'b0;

repeat(100) @(posedge clk);
 $display("==================================");
 $display("========= TEST CASE 4 ============");
 $display("testing glitch ");

 
if (debouncer_out==1'b0)
    begin 
        $display ("TEST CASE 4 --> PASSED ");
        $display ("debouncer_out settled at %0d as should be",debouncer_out);
    end
else 
    begin 
        $display ("TEST CASE 4 --> FILED");
        $display ("debouncer_out settled at %0d ",debouncer_out);
    end
settle_at('b0);   // to be visible 
$display("==================================");
$display("==================================");
$display("\n ============ END TEST=============");
$display("==================================");
$display("==================================");
 $stop;
 end

 ////////////////////////////////////////////////////////
 ////////////////// tasks //////////////////////////////
 //////////////////////////////////////////////////////

////////////////// initialization ///////////////////////
task initialize;
begin 

rst_n ='b1;
clk ='b0;
noisy_in ='b0;

end
endtask
//////////////////// reset //////////////////////
task reset;
begin 
rst_n='b1;
#(clockperiod );
rst_n='b0;
#(clockperiod );
rst_n='b1;
#(clockperiod );
end
endtask 
////////////////////// noise_in   //////////////////////
// task to generate noise 
task noise_in;
input start_value;
integer i,n;
begin 
/// to generate noise
 n = start_value;
    for (i=0;i<20 ; i=i+1)
    begin 
        if(i <= 10) 
        begin 
        noisy_in= n;
        n=!n;
        #(0.16*clockperiod);
        end
        else if (i <=15 )
        begin 
        noisy_in= n;
        n=!n;
        #(0.5* clockperiod);   
        end
        else
        begin 
        noisy_in= n;
        n=!n;
        #(1* clockperiod);
        end
    end 
end

endtask

////////////////////// settle ////////////////////
// task to settle at final value 

task settle_at ;
input settle;
integer y;
begin 
    @(posedge clk)
  for (y=0; y<100 ; y=y+1)
    begin 
    noisy_in = settle ;
    #(clockperiod);    
    end
end
endtask 

///////////////////// Clock Generator //////////////////

always #(clockperiod/2) clk = ~clk ;
///////////////// Design Instaniation //////////////////
top DUT (
    .noisy_in(noisy_in),
    .clk(clk),
    .rst_n(rst_n),

    .debouncer_out(debouncer_out)
);
endmodule