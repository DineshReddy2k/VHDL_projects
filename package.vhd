library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package seven_segment is 
    function seven_seg_from_integer(digit: integer) return std_logic_vector;
end;

package body seven_segment is
 function seven_seg_from_integer(digit: integer)
 return std_logic_vector is
 begin
 case digit is
 when 0 => return "0111111";
 when 1 => return "0000110";
 when 2 => return "1011011";
 when 3 => return "1001111";
 when 4 => return "1100110";
 when 5 => return "1101101";
 when 6 => return "1111101";
 when 7 => return "0000111";
 when 8 => return "1111111";
 when 9 => return "1101111";
 when others => return "0000000";
 end case;
 end;
 end;
