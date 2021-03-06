library ieee;
use ieee.std_logic_1164.all;
 
package 			user_package is

	--=== wishbone slaves ========--
	constant number_of_wb_slaves		: positive:= 2 ;
	
	constant user_wb_regs				: integer := 0 ;
	constant user_wb_timer				: integer := 1 ;
	
	
	--=== ipb slaves =============--
	constant number_of_ipb_slaves		: positive:= 1 ;
	constant user_ipb_regs				: integer := 0 ;
	--constant user_ipb_timer			: integer := 1 ;
	
end 				user_package;
   
package body 	user_package is
end 				user_package;