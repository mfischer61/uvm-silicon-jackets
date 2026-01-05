/*-----------------------------------------------------------------------------------------------
* File Name     :   rst_driver.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026

Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Define the virtual reset interface
*   3. Define the basic UVM Constructor (new)
*   4. Use uvm_config_db#()::get to find the virtual reset interface (build_phase)
*   5. Define the logic to drive transaction signals onto the DUT (run_phase)
-------------------------------------------------------------------------------------------------*/

class rst_driver extends uvm_driver #(rst_seq_item);

    function void build_phase(uvm_phase phase);

    endfunction : build_phase

    task run_phase(uvm_phase phase);

    endtask : run_phase

endclass : rst_driver