#set_property PACKAGE_PIN Y11 [get_ports {ssd[6]}];
#set_property PACKAGE_PIN AA11 [get_ports {ssd[5]}];
#set_property PACKAGE_PIN Y10 [get_ports {ssd[4]}];
#set_property PACKAGE_PIN AA9 [get_ports {ssd[3]}];
#set_property PACKAGE_PIN W12 [get_ports {ssd[2]}];
#set_property PACKAGE_PIN W11 [get_ports {ssd[1]}];
#set_property PACKAGE_PIN V10 [get_ports {ssd[0]}];
#set_property IOSTANDARD LVCMOS33 [get_ports ssd];

set_property PACKAGE_PIN F22 [get_ports {sw0}];
set_property IOSTANDARD LVCMOS25 [get_ports sw0];

set_property PACKAGE_PIN G22 [get_ports {sw1}];
set_property IOSTANDARD LVCMOS25 [get_ports sw1];

set_property PACKAGE_PIN H22 [get_ports {sw2}];
set_property IOSTANDARD LVCMOS25 [get_ports sw2];

set_property PACKAGE_PIN F21 [get_ports {sw3}];
set_property IOSTANDARD LVCMOS25 [get_ports sw3];

set_property PACKAGE_PIN H19 [get_ports {sw4}];
set_property IOSTANDARD LVCMOS25 [get_ports sw4];

set_property PACKAGE_PIN H18 [get_ports {sw5}];
set_property IOSTANDARD LVCMOS25 [get_ports sw5];

set_property PACKAGE_PIN H17 [get_ports {sw6}];
set_property IOSTANDARD LVCMOS25 [get_ports sw6];

set_property PACKAGE_PIN M15 [get_ports {sw7}];
set_property IOSTANDARD LVCMOS25 [get_ports sw7];

set_property PACKAGE_PIN P16 [get_ports {btnC}];
set_property IOSTANDARD LVCMOS25 [get_ports btnC];
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets btnC_IBUF]

set_property PACKAGE_PIN T22 [get_ports {ld0}];
set_property IOSTANDARD LVCMOS33 [get_ports ld0];

set_property PACKAGE_PIN T21 [get_ports {ld1}];
set_property IOSTANDARD LVCMOS33 [get_ports ld1];

set_property PACKAGE_PIN U22 [get_ports {ld2}];
set_property IOSTANDARD LVCMOS33 [get_ports ld2];

set_property PACKAGE_PIN U21 [get_ports {ld3}];
set_property IOSTANDARD LVCMOS33 [get_ports ld3];

set_property PACKAGE_PIN V22 [get_ports {ld4}];
set_property IOSTANDARD LVCMOS33 [get_ports ld4];

set_property PACKAGE_PIN W22 [get_ports {ld5}];
set_property IOSTANDARD LVCMOS33 [get_ports ld5];

set_property PACKAGE_PIN U19 [get_ports {ld6}];
set_property IOSTANDARD LVCMOS33 [get_ports ld6];

set_property PACKAGE_PIN U14 [get_ports {ld7}];
set_property IOSTANDARD LVCMOS33 [get_ports ld7];

#set_property PACKAGE_PIN W8 [get_ports sel];



set_property PACKAGE_PIN V4 [get_ports go_ahead_1];
set_property IOSTANDARD LVCMOS33 [get_ports go_ahead_1];
set_property PACKAGE_PIN V5 [get_ports go_ahead_2];
set_property IOSTANDARD LVCMOS33 [get_ports go_ahead_2];


#set_property IOSTANDARD LVCMOS33 [get_ports sel];

set_property PACKAGE_PIN Y9 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10 [get_ports clk]

set_property PACKAGE_PIN AB6 [get_ports {echo}];
set_property IOSTANDARD LVCMOS33 [get_ports echo];

set_property PACKAGE_PIN AB7 [get_ports {trig}];
set_property IOSTANDARD LVCMOS33 [get_ports trig];

set_property PACKAGE_PIN Y11 [get_ports {ssd[6]}];
set_property PACKAGE_PIN AA11 [get_ports {ssd[5]}];
set_property PACKAGE_PIN Y10 [get_ports {ssd[4]}];
set_property PACKAGE_PIN AA9 [get_ports {ssd[3]}];
set_property PACKAGE_PIN W12 [get_ports {ssd[2]}];
set_property PACKAGE_PIN W11 [get_ports {ssd[1]}];
set_property PACKAGE_PIN V10 [get_ports {ssd[0]}];
set_property PACKAGE_PIN W8 [get_ports sel];
set_property IOSTANDARD LVCMOS33 [get_ports ssd];
set_property IOSTANDARD LVCMOS33 [get_ports sel];
