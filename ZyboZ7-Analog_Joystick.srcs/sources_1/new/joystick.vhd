----------------------------------------------------------------------------------
-- Company: University at Buffalo
-- Engineer: Eugenia H.V.
--           Ben Flora
-- Create Date: 12/07/2025 07:19:10 PM
-- Module Name: joystick - Behavioral
-- Project Name: ZyboZ7-Analog_Joystick
-- Target Devices: ZyboZ7, Parallax 2-axis joystick, Adafruit Analog 2-axis thumb joystick
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity joystick is
    Port ( 
           clk    : in STD_LOGIC;
           resetn : in STD_LOGIC;
           vp_x   : in STD_LOGIC;
           vn_x   : in STD_LOGIC;
           vp_y   : in STD_LOGIC;
           vn_y   : in STD_LOGIC;
           leds   : out std_logic_vector(3 downto 0));
end joystick;

architecture Behavioral of joystick is

    signal adc_do     : std_logic_vector(15 downto 0);
    signal adc_drdy   : std_logic;
    signal adc_channel: std_logic_vector(4 downto 0);

    signal sample_x   : unsigned(11 downto 0) := (others => '0');
    signal sample_y   : unsigned(11 downto 0) := (others => '0');
    
    signal reset_inv  : std_logic; -- Inverts active low reset port to active high
    signal xadc_addr  : std_logic_vector(6 downto 0) := 7x"10"; -- Stores current XADC address for reading channel data, initialized to VAUXP[0]/VAUXN[0]

    signal enable_sig : std_logic := '1';
begin

    reset_inv <= not resetn;
    
    xadc_inst : entity work.xadc_wiz_0
    port map (
        dclk_in       => clk,
        reset_in      => reset_inv,
        daddr_in      => xadc_addr,
        den_in        => enable_sig,
        di_in         => (others => '0'),
        dwe_in        => '0',
        vp_in         => '0',
        vn_in         => '0',
        vauxp6        => vp_x,  -- X axis
        vauxn6        => vn_x,
        vauxp7        => vp_y,  -- Y axis
        vauxn7        => vn_y,
        do_out        => adc_do,
        drdy_out      => adc_drdy,
        channel_out   => adc_channel
    );

    -- Capture samples for each axis, XADC
    process(clk)
    begin
        if rising_edge(clk) then
            if adc_drdy = '1' then
                case adc_channel is
                    when "00110" => sample_x <= unsigned(adc_do(15 downto 4));
                    when "00111" => sample_y <= unsigned(adc_do(15 downto 4));
                    when others  => null;
                end case;
                
                case xadc_addr is
                    when 7x"16" => -- When VAUXP[6]/VAUXN[6] channel, update to VAUXP[7]/VAUXN[7] channel
                        xadc_addr <= 7x"17";
                    when 7x"17" => -- Reset back to channel 6 after reading channel 7 data
                        xadc_addr <= 7x"16";
                    when others => null;
                end case;
            end if;
        end if;
    end process;

    -- LED bar moves left ot right based on X-axis position
    leds <= "0001" when sample_x < 1024 else
            "0011" when sample_x < 2048 else
            "0111" when sample_x < 3072 else
            "1111";

end Behavioral;