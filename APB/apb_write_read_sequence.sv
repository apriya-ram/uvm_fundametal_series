//Creates write and mix of random sequences 

class apb_write_read_sequence extends uvm_sequence #(apb_transaction);
    `uvm_object_utils(apb_mixed_sequence)

    // Constructor
    function new(string name = "apb_mixed_sequence");
        super.new(name);
    endfunction

    // Body task
    virtual task body();
        apb_transaction tr;
        bit [31:0] base_addr = 32'h0000_2000;

        // Generate and send 10 transactions (alternating read/write)
        for (int i = 0; i < 10; i++) begin
            tr = apb_transaction::type_id::create("tr");
            tr.addr = base_addr + (i * 4);  // Increment address by 4 for each transaction
            tr.pwrite = (i % 2 == 0);       // Alternate between read and write
            if (tr.pwrite)
                tr.data = $random;          // Randomize data for write transactions
            assert(tr.randomize());         // Apply randomization
            start_item(tr);                 // Start the transaction
            finish_item(tr);                // Finish the transaction
            tr.display();                   // Display the transaction
        end
    endtask
endclass
