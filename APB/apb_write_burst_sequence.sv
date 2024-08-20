//This sequence generates a burst of write transactions to a series of addresses.

class apb_write_burst_sequence extends uvm_sequence #(apb_transaction);
    `uvm_object_utils(apb_write_burst_sequence)

    // Constructor
    function new(string name = "apb_write_burst_sequence");
        super.new(name);
    endfunction

    // Body task
    virtual task body();
        apb_transaction tr;
        bit [31:0] base_addr = 32'h0000_1000;

        // Generate and send 10 consecutive write transactions
        for (int i = 0; i < 10; i++) begin
            tr = apb_transaction::type_id::create("tr");
            tr.addr = base_addr + (i * 4);  // Increment address by 4 for each transaction
            tr.pwrite = 1'b1;               // Set write enable
            tr.data = $random;              // Randomize data
            assert(tr.randomize());         // Apply randomization
            start_item(tr);                 // Start the transaction
            finish_item(tr);                // Finish the transaction
            tr.display();                   // Display the transaction
        end
    endtask
endclass
