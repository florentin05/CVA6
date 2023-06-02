#set partNumber xcku5p-ffvb676-2-e
#set boardName  xilinx.com:kcu116:part0:1.5
#set boardNameShort kcu116 
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)
set boardNameShort $::env(BOARD)

set ipName xlnx_axi_dwidth_converter_256_64

create_project $ipName . -force -part $partNumber
set_property board_part $boardName [current_project]

create_ip -name axi_dwidth_converter -vendor xilinx.com -library ip -module_name $ipName

set_property -dict [list \
  CONFIG.ADDR_WIDTH {30} \
  CONFIG.MI_DATA_WIDTH {256} \
  CONFIG.SI_DATA_WIDTH {64} \
  CONFIG.SI_ID_WIDTH {5} \
] [get_ips $ipName]


generate_target {instantiation_template} [get_files ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 8 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1