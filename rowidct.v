module idctrowg(
    input clk,
    input [31:0] raddr, waddr,
    input valid_write,
    input signed [16:0] wdata,
    output reg signed [16:0] rdata,
    output reg rrdy
);
    integer W1 = 2841;
    integer W2 = 2676;
    integer W3 = 2408;
    integer W5 = 1609;
    integer W6 = 1108;
    integer W7 = 565;
    
    reg signed [31:0] x [0:8];
    reg signed [31:0] y [0:8];
    // This implements the ROW IDCT from nanojpeg
    
    integer i;
    initial begin       // Initail values in registers
        for(i=0; i<9; i=i+1) begin
            x[i] = 16'b0;
    end
    end
    
    reg rdy;
    always @(posedge clk) begin
        if(valid_write) begin
            case(waddr[2:0])
                3'b000,
                3'b001,
                3'b010,
                3'b011,
                3'b100,
                3'b101,
                3'b110 : begin
                    x[waddr[2:0]] <= {{16{wdata[15]}}, wdata};
                    rdy <= 1'b0;
                end
                3'b111 : begin 
                    x[waddr[2:0]] <= {{16{wdata[15]}}, wdata};
                end
            endcase
        end
    end
    
    always @(*) begin
        y[1] = x[4] << 11;
        y[2] = x[6];
        y[3] = x[2];
        y[4] = x[1];
        y[5] = x[7];
        y[6] = x[5];
        y[7] = x[3];
        if((y[1]|y[2]|y[3]|y[4]|y[5]|y[6]|y[7]) == 0) begin
            rdata = x[0] << 3;
            rrdy = 1'b1;
        end else begin
            y[0] = (x[0] << 11) + 128;
            y[8] = W7 * (y[4] + y[5]);
            y[4] = y[8] + (W1 - W7) * y[4];
            y[5] = y[8] - (W1 + W7) * y[5];
            y[8] = W3 * (y[6] + y[7]);
            y[6] = y[8] - (W3 - W5) * y[6];
            y[7] = y[8] - (W3 + W5) * y[7];
            y[8] = y[0] + y[1];
            y[0] = y[0] - y[1];
            y[1] = W6 * (y[3] + y[2]);
            y[2] = y[1] - (W2 + W6) * y[2];
            y[3] = y[1] + (W2 - W6) * y[3];
            y[1] = y[4] + y[6];
            y[4] = y[4] - y[6];
            y[6] = y[5] + y[7];
            y[5] = y[5] - y[7];
            y[7] = y[8] + y[3];
            y[8] = y[8] - y[3];
            y[3] = y[0] + y[2];
            y[0] = y[0] - y[2];
            y[2] = (181 * (y[4] + y[5]) + 128) >> 8;
            y[4] = (181 * (y[4] - y[5]) + 128) >> 8;
            case(raddr[2:0]) 
                3'b000 : rdata = (y[7] + y[1]) >> 8;
                3'b001 : rdata = (y[3] + y[2]) >> 8;
                3'b010 : rdata = (y[0] + y[4]) >> 8;
                3'b011 : rdata = (y[8] + y[6]) >> 8;
                3'b100 : rdata = (y[8] - y[6]) >> 8;
                3'b101 : rdata = (y[0] - y[4]) >> 8;
                3'b110 : rdata = (y[3] - y[2]) >> 8;
                3'b111 : rdata = (y[7] - y[1]) >> 8;
            endcase
            rrdy = 1'b1;
        end 
    end
endmodule

                
                