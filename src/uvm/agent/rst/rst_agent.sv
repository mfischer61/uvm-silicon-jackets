/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_agent.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the reset driver and reset sequencer
*   3. Define the basic UVM Constructor (new)
*   4. Use type_id::create to make the reset driver and reset sequencer (build_phase)
*   5. Instantiate and connect the reset driver seq_item_port to the reset sequencer seq_item_export (connect_phase)
-------------------------------------------------------------------------------------------------*/

class rst_agent extends uvm_agent;

    function void build_phase(uvm_phase phase);

    endfunction : build_phase

    function void connect_phase(uvm_phase phase);

    endfunction : connect_phase

endclass : rst_agent