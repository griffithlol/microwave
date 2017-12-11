LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY STATES IS 
	PORT(check,door,start,clears,count_end : IN std_logic;
		run_allow,tone,set_val,clr : OUT std_logic);
END STATES;

ARCHITECTURE arc of STATES IS
	TYPE state_type IS (RUN,SET,PAUSE,CLEAR);
		SIGNAL state: state_type;
		SIGNAL checkState:std_logic;
BEGIN 
	PROCESS
	Begin
	CASE state IS 
		WHEN CLEAR=>
			run_allow<='0';
			if start='1' AND door='0' then 
				state<=set;
			END IF;
		WHEN SET=>
			set_val<='1';
			if start='1' AND door='0' then
				set_val<='0';
				state<=RUN;
			END IF;
		WHEN RUN=>
			if door='1' then 
				run_allow<='0';
				state<=PAUSE;
			ELSIF count_end='1' then
				tone<='1';
				run_allow<='0'
				state<=CLEAR;
			Else
				tone<='0';
				run_allow<='1';
			END IF;
		WHEN PAUSE=>
			run_allow<='0';
			if door='0' AND start='1' then 
				run_allow<='1';
				state<=RUN;
			END IF;
		WHEN OTHERS=>
			state<=CLEAR;
	END CASE;
	IF check /= '1' then
		checkState <= '1';
	ELSIF check = '1' then
		checkState <= '0';
	END IF;
	WAIT until check = checkState;
	END PROCESS;
	END arc;
			