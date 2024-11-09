
class cuboid extends uvm_sequence_item;
  
   //1. adding constructor
  function new(string name = "cuboid");
    super.new(name);
    endfunction 
  
  ///transaction fields

rand bit [15:0] length;
rand bit [15:0] width;
rand bit [15:0] height;
rand bit [31:0] area;
  rand bit [31:0] volume;
int in_valid;
int out_valid;
  
  //automation macro
  
  
  `uvm_object_utils_begin (cuboid)
  
  
    `uvm_field_int(length,UVM_ALL_ON)
    `uvm_field_int(height,UVM_ALL_ON)
    `uvm_field_int(area,UVM_ALL_ON)
  `uvm_field_int(volume,UVM_ALL_ON)
    `uvm_field_int(width,UVM_ALL_ON)
  
  `uvm_object_utils_end
  

//constarints for following 
constraint c_length {length >=1 ; length <30;}
constraint c_width {width >=1 ; width <56;}
constraint c_height {height >=1 ; height <80;}
  constraint c_area {area >=24 ; area <90;}
  constraint c_volume{volume >=4 ; volume <30;}
  
//custom print function
  
  function void print();
    `uvm_info(get_type_name(), $sformatf("Length: %0d,\n Width: %0d,\n Height: %0d,\n Area: %0d,\n Volume: %0d", 
                                         length, width, height, area, volume), UVM_LOW)
    endfunction
  
  
  
  
  
endclass: cuboid
  

