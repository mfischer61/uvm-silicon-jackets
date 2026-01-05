/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_env.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Declare the gcd_agent, rst_agent, virtual sequencer, and scoreboard
*   3. Define the basic UVM Constructor
*   4. Instantiate the gcd_agent, rst_agent, virtual sequencer, and scoreboard (build_phase)
*   5. Connect your monitor analysis port to the scoreboard analysis import (connect_phase)
*   6. Connect virtual sequencer to gcd sequencer and reset sequencer (connect_phase)
-------------------------------------------------------------------------------------------------*/

class gcd_env extends uvm_env;

    function void build_phase(uvm_phase phase);

    endfunction : build_phase

    function void connect_phase(uvm_phase phase);
        
    endfunction : connect_phase

endclass : gcd_env