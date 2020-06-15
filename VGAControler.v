module VGAController (input clk25, output reg hsync ,output reg vsync, output reg [9:0]addrH, output reg [9:0]addrV);
    
    parameter MAX_CYCLE_X = 10'd800;
    parameter MAX_CYCLE_Y = 10'd525;
    parameter FIRST_CYCLE_DISPLAY_X = 10'd140;
    parameter FIRST_CYCLE_DISPLAY_Y = 10'd34;
    parameter LAST_CYCLE_DISPLAY_X = 10'd780;
    parameter LAST_CYCLE_DISPLAY_Y = 10'd514;
    parameter CYCLE_SYNC_X = 10'd95;
    parameter CYCLE_SYNC_Y = 10'd2;


    reg [9:0] CounterX;
    reg [9:0] CounterY;

    // Counters generator
    always @(posedge(clk25)) begin
    if (CounterX == MAX_CYCLE_X) begin
    	CounterX <= 10'd0;
    	if(CounterY == MAX_CYCLE_Y) begin
    		CounterY <= 10'd0;
    	end
    	else begin	
    		CounterY <=  CounterY + 10'd1;
    
    		if((CounterY > FIRST_CYCLE_DISPLAY_Y) & (CounterY <= LAST_CYCLE_DISPLAY_Y))
    		addrV <= addrV + 1'h1;
    		else
    		addrV <= 10'd0;		
    
    	end
    	end
    else begin
    	CounterX <= CounterX + 10'd1;
    	if((CounterX > FIRST_CYCLE_DISPLAY_X) & (CounterX <= LAST_CYCLE_DISPLAY_X))
    		addrH <= addrH + 1'h1;
    	else
    		addrH <= 10'd0;
    
    end
    end

    // Syncronization signals
    always @(posedge(clk25)) begin
    if (CounterX < CYCLE_SYNC_X)
    	hsync <= 1'h0;
    else 
    	hsync <= 1'h1;	
    end
    
    
    always @(posedge(clk25)) begin
    if (CounterY < CYCLE_SYNC_Y)
    	vsync <= 1'h0;
    else 
    	vsync <= 1'h1;	
    end


    assign VGA_HS = hsync;
    assign VGA_VS = vsync;



endmodule