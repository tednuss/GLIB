library ieee;
use ieee.std_logic_1164.all;

library work;
use work.ipbus.all;
use work.system_package.all;
use work.user_package.all;

entity link_trigger is
port(

    gtx_clk_i       : in std_logic;
    ipb_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    rx_error_i      : in std_logic;
    rx_kchar_i      : in std_logic_vector(1 downto 0);
    rx_data_i       : in std_logic_vector(15 downto 0);
    
    tx_kchar_o      : out std_logic_vector(1 downto 0);
    tx_data_o       : out std_logic_vector(15 downto 0);
    
    ext_sbit_o      : out std_logic;

	ipb_trigger_i   : in ipb_wbus;
	ipb_trigger_o   : out ipb_rbus
    
);
end link_trigger;

architecture Behavioral of link_trigger is

    signal trigger_rx_en    : std_logic := '0';
    signal trigger_rx_data  : std_logic_vector(47 downto 0) := (others => '0');
    
begin

    ext_sbit_o <= trigger_rx_data(0);

    trigger_data_decoder_inst : entity work.trigger_data_decoder
    port map(
        gtx_clk_i       => gtx_clk_i,
        reset_i         => reset_i,
        trigger_en_o    => trigger_rx_en,
        trigger_data_o  => trigger_rx_data,
        rx_kchar_i      => rx_kchar_i,
        rx_data_i       => rx_data_i
    );

    ipb_trigger_inst : entity work.ipb_trigger
    port map(
        ipb_clk_i   => ipb_clk_i,
        gtx_clk_i   => gtx_clk_i,
        reset_i     => reset_i,
        ipb_mosi_i  => ipb_trigger_i,
        ipb_miso_o  => ipb_trigger_o,
        rx_en_i     => trigger_rx_en,
        rx_data_i   => trigger_rx_data
    );
    
end Behavioral;