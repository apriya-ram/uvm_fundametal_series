//test to create combination of sequences
class apb_test extends uvm_test;
    `uvm_component_utils(apb_test)

    apb_env env;

    // Constructor
    function new(string name = "apb_test");
        super.new(name);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        env = apb_env::type_id::create("env", this);
    endfunction

    // Run phase
    task run_phase(uvm_phase phase);
        apb_basic_sequence basic_seq;
        apb_write_burst_sequence write_burst_seq;
        apb_write_read_sequence write_read_seq;
        

        // Run the burst write sequence
        write_burst_seq = apb_write_burst_sequence::type_id::create("write_burst_seq");
        write_burst_seq.start(env.agt.seqr);

        // Run the mixed sequence
        write_read_seq = apb_write_read_sequence::type_id::create("write_read_seq");
        write_read_seq.start(env.agt.seqr);

        // Run the basic sequence
        basic_seq = apb_basic_sequence::type_id::create("basic_seq");
        basic_seq.start(env.agt.seqr);
    endtask
endclass
