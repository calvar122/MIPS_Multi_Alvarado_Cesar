onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /TB_DP/TB_clk
add wave -noupdate /TB_DP/TB_reset
add wave -noupdate /TB_DP/TB_PCEn_i
add wave -noupdate /TB_DP/TB_IorD_i
add wave -noupdate /TB_DP/TB_MemWrite_i
add wave -noupdate /TB_DP/TB_IRWrite_i
add wave -noupdate /TB_DP/TB_RegDst_i
add wave -noupdate /TB_DP/TB_MemtoReg_i
add wave -noupdate -color Cyan /TB_DP/TB_RegWrite_i
add wave -noupdate /TB_DP/TB_ALUSrcA_i
add wave -noupdate /TB_DP/TB_ALUSrcB_i
add wave -noupdate /TB_DP/TB_ALUControl_i
add wave -noupdate /TB_DP/TB_PCSrc_i
add wave -noupdate -radix hexadecimal /TB_DP/Scope_PC
add wave -noupdate -radix hexadecimal /TB_DP/Scope_instr
add wave -noupdate /TB_DP/TB_OP_o
add wave -noupdate /TB_DP/TB_Funct_o
add wave -noupdate -radix hexadecimal /TB_DP/Scope_srca
add wave -noupdate -radix hexadecimal /TB_DP/Scope_srcb
add wave -noupdate -color Yellow -radix hexadecimal /TB_DP/TB_ALU_OUT_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {65 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {10 ps}
