/*-----------------------------------------------------------------------------------------------
* File Name     :   virtual_seq_lib.sv
* Author        :   Matthew Nichols
* Date          :   1/2/2026
*
* simple_gcd_with_reset_vseq: Sequence that runs a reset sequence BEFORE and AFTER GCD sequences.
* reset_during_gcd_vseq: Sequence that runs a reset sequence DURING a GCD sequence
-------------------------------------------------------------------------------------------------*/
class simple_gcd_with_reset_vseq extends base_virtual_seq;

    `uvm_object_utils(simple_gcd_with_reset_vseq)

    function new(string name = "simple_gcd_with_reset_vseq");
        super.new(name);
    endfunction

    virtual task body();
        simple_reset_seq reset_seq;
        // Add your GCD sequences here
        simple_gcd_seq   gcd_seq;

        reset_seq = simple_reset_seq::type_id::create("reset_seq");
        gcd_seq   = simple_gcd_seq::type_id::create("gcd_seq");

        `uvm_info(get_type_name(), "Starting reset", UVM_LOW)
        reset_seq.start(p_sequencer.rst_seqr);

        `uvm_info(get_type_name(), "Starting GCD traffic", UVM_LOW)
        gcd_seq.start(p_sequencer.gcd_seqr);
        
        `uvm_info(get_type_name(), "Starting second reset", UVM_LOW)
        reset_seq.start(p_sequencer.rst_seqr);
    endtask

endclass

// Causes a reset to occur in the middle of GCD traffic
class reset_during_gcd_vseq extends base_virtual_seq;
  `uvm_object_utils(reset_during_gcd_vseq)

  function new(string name = "reset_during_gcd_vseq");
    super.new(name);
  endfunction

  virtual task body();
    simple_gcd_seq   gcd_seq;
    simple_reset_seq rst_seq;

    fork
      // GCD traffic
      begin
        repeat (10) begin
          gcd_seq = simple_gcd_seq::type_id::create("gcd_seq");
          gcd_seq.start(p_sequencer.gcd_seqr);
        end
      end
      // Reset in the middle of traffic
      begin
        #500ns;
        rst_seq = simple_reset_seq::type_id::create("rst_seq");
        rst_seq.start(p_sequencer.rst_seqr);
      end
    join
  endtask

endclass : reset_during_gcd_vseq