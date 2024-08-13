//This sample file is for the basic understanding of the uvm_sequence

class apb_sequence extends uvm_sequence #(apb_transaction);
    `uvm_object_utils(apb_sequence)

    // Constructor
    function new(string name = "apb_sequence");
        super.new(name);
    endfunction

    // Body task
    virtual task body();
        apb_transaction tr;
        
        // Generate and send 10 transactions
        repeat (10) begin
            tr = apb_transaction::type_id::create("tr");
            assert(tr.randomize()); // Randomize the transaction
            start_item(tr);         // Start the transaction item
            finish_item(tr);        // Finish the transaction item
            tr.display();           // Display the transaction details
        end
    endtask
endclass
