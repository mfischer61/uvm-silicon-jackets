/*-----------------------------------------------------------------------------------------------
* File Name     :   gcd_driver.sv
* Author        :   Andrew Chen
* Date          :   9/7/2025
*
* Tasks to complete here:
*   1. Call the UVM component macro to register with the factory
*   2. Declare the gcd virtual interface andd reset virtual interface
*   2. Define the basic UVM Constructor (new)
*   3. Use uvm_config_db#()::get to connect the gcd virtual interface and reset interface (connect_phase)
*   4. Define the logic to drive transaction signals onto the DUT (run_phase)
        |-> *Needs to be reset sensitive to the reset virtual interface
-------------------------------------------------------------------------------------------------*/

class gcd_driver extends uvm_driver #(gcd_seq_item);
    `uvm_component_utils(gcd_driver)

    virtual gcd_if vif;
    virtual rst_if rst_vif;

    function new(string name = "gcd_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction : new

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (!gcd_vif_config::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "gcd_if is not found in the config_db under key 'vif'")
        if (!uvm_config_db#(virtual rst_if)::get(this, "", "rst_vif", rst_vif))
            `uvm_fatal("NOVIF", "rst_if is not found in the config_db under key 'rst_vif'")
    endfunction : connect_phase

    virtual task run_phase(uvm_phase phase);
       // known value at the time 0 so the DUT never sees an X on the inputs
       vif.valid_i <= 1'b0;
       vif.a_i <= '0;
       vif.b_i <= '0;

       forever begin
            seq_item_port.get_next_item(req);

            // don't start a transaction while the reset is asserted
            wait (rst_vif.rst_i === 1'b0);

            // race the transaction against a reset
            fork
                drive_item(req);
                @(posedge rst_vif.rst_i);
            join_any
            disable fork;

            // if reset won then clear the inputs
            if (rst_vif.rst_i === 1'b1) begin
                `uvm_info(get_type_name(), "there was a reset during the transaction so dropping it", UVM_MEDIUM)
                vif.valid_i <= 1'b0;
                vif.a_i <= '0;
                vif.b_i <= '0;
            end

            seq_item_port.item_done();
       end

    endtask : run_phase

    // pin level protocol for one GCD operation
    task drive_item(gcd_seq_item item);
        @(posedge vif.clk_i);
        vif.a_i <= item.data_a;
        vif.b_i <= item.data_b;
        vif.valid_i <= 1'b1;
        @(posedge vif.clk_i);
        vif.valid_i <= 1'b0;

        //wait for the DUT to finish before accepting the next item
        @(posedge vif.clk_i iff vif.valid_o === 1'b1);

    endtask : drive_item
endclass : gcd_driver