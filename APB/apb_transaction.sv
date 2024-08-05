// This is an example file for the understanding of an UVM_object .
//Created by Priya Ananthakrishnan

class apb_transaction extends uvm_sequence_item;
  `uvm_object_utils(apb_transaction)

  rand bit [31:0] addr;        // APB address
  rand bit [31:0] data;        // APB data
  rand bit        pwrite;      // Write enable: 1 for write, 0 for read
  rand bit        penable;     // Enable signal
  rand bit        psel;        // Select signal
  bit             prdata;      // Read data (output from slave)

  // Constructor
  function new(string name = "apb_transaction");
    super.new(name);
  endfunction

  // Constraints
  constraint addr_constraint {
    addr inside {32'h0000_0000, 32'hFFFF_FFFF};  // Example address range
  }

  constraint data_constraint {
    data inside {32'h0000_0000, 32'hFFFF_FFFF};  // Example data range
  }

  constraint control_constraint {
    penable == 1;  // penable should always be 1 during a transaction
    psel == 1;     // psel should always be 1 during a transaction
  }

  // Copy method
  function void do_copy(uvm_object rhs);
    apb_transaction rhs_tx;
    if (!$cast(rhs_tx, rhs)) begin
      `uvm_fatal("COPY", "Object type mismatch")
      return;
    end
    this.addr = rhs_tx.addr;
    this.data = rhs_tx.data;
    this.pwrite = rhs_tx.pwrite;
    this.penable = rhs_tx.penable;
    this.psel = rhs_tx.psel;
    this.prdata = rhs_tx.prdata;
  endfunction

  // Comparison method
  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    apb_transaction rhs_tx;
    if (!$cast(rhs_tx, rhs)) return 0;
    if (this.addr !== rhs_tx.addr) return 0;
    if (this.data !== rhs_tx.data) return 0;
    if (this.pwrite !== rhs_tx.pwrite) return 0;
    if (this.penable !== rhs_tx.penable) return 0;
    if (this.psel !== rhs_tx.psel) return 0;
    return 1;
  endfunction

  // Print method
  function void do_print(uvm_printer printer);
    super.do_print(printer);
    printer.print_field_int("addr", addr, 32);
    printer.print_field_int("data", data, 32);
    printer.print_field_int("pwrite", pwrite, 1);
    printer.print_field_int("penable", penable, 1);
    printer.print_field_int("psel", psel, 1);
    printer.print_field_int("prdata", prdata, 32);
  endfunction
endclass
