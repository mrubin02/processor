// `include "mux_4.v"
// `include "mux_8.v"

module mux_32_1bit(out, select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31);
    input [4:0] select;
    input in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, in16, in17, in18, in19, in20, in21, in22, in23, in24, in25, in26, in27, in28, in29, in30, in31;
    output out;
    wire w1, w2, w3, w4;
    mux_8_1bit first_top(w1, select[2:0], in0, in1, in2, in3, in4, in5, in6, in7);
    mux_8_1bit first_mid_top(w2, select[2:0], in8, in9, in10, in11, in12, in13, in14, in15);
    mux_8_1bit first_mid_bottom(w3, select[2:0],in16, in17, in18, in19, in20, in21, in22, in23);
    mux_8_1bit first_bottom(w4, select[2:0], in24, in25, in26, in27, in28, in29, in30, in31);
    mux_4_1bit second(out, select[4:3], w1, w2, w3, w4);
endmodule