module pipeline_reg(clk,rst_n,in_valid,out_valid,in_ready,out_ready,wdata,rdata);

parameter int WIDTH = 32;
input clk,rst_n,in_valid,out_ready;
input [WIDTH-1:0]wdata;
output reg [WIDTH-1:0]rdata;
output reg out_valid;
output in_ready;

    
    assign in_ready = ~out_valid || (out_ready && out_valid);

    
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_valid <= 1'b0;
            rdata     <= '0;
        end
        else begin
            if (in_valid && in_ready) begin
                rdata     <= wdata;
                out_valid <= 1'b1;
            end
            else if (out_ready && out_valid) begin
                out_valid <= 1'b0;
            end
        end
    end

endmodule
