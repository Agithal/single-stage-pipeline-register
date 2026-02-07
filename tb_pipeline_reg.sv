`timescale 1ns/1ps

module tb_pipeline_reg;

  parameter WIDTH = 32;

  reg clk;
  reg rst_n;
  reg in_valid;
  reg out_ready;
  reg [WIDTH-1:0]wdata;

  wire in_ready;
  wire out_valid;
  wire [WIDTH-1:0]rdata;

  pipeline_reg dut (
    .clk       (clk),
    .rst_n     (rst_n),
    .in_valid  (in_valid),
    .out_valid (out_valid),
    .in_ready  (in_ready),
    .out_ready (out_ready),
    .wdata     (wdata),
    .rdata     (rdata)
  );

  always #5 clk = ~clk;

  initial begin
    clk       = 0;
    rst_n     = 0;
    in_valid  = 0;
    out_ready = 0;
    wdata     = 0;

    #15;
    rst_n = 1;

    @(posedge clk);
    out_ready = 1;
    in_valid  = 1;
    wdata     = 32'hA5A5_1234;

    @(posedge clk);
    in_valid = 0;

    @(posedge clk);
    out_ready = 0;      
    in_valid  = 1;
    wdata     = 32'hDEAD_BEEF;

    @(posedge clk);
    in_valid = 0;
    repeat (2) @(posedge clk);
    out_ready = 1;

    #20;
    $finish;
  end

endmodule

