# Nowcoder_Verilog
Verilog coding practice on https://www.nowcoder.com

## Branch verilog_gen_script
This is a branch I used to save a python script for generating initial verilog files.
The process of using this script is as follows:
### 1. Modify the parameters.txt file
This file is used to write some informations about the new verilog files which you want to generate.

`(Note: if first char is '#', that means it's a comment sentence.)`

`Important Note: DO NOT modify any key words such as below!`

```make
Module_name:
Affiliation:
Author:
Description:
Additional_Comments:
Ports:
Signals:
```

Set module name
```make
####################################################
Module_name:			data_cal
####################################################
```

Set file header comment information
```make
####################################################
Affiliation:			Tsinghua Univ
Author:					Yongxiang Guo
Description:			see Verilog VL5 practice on nowcoder.com
Additional_Comments:	VL5 on nowcoder
####################################################
```

Set module ports
```make
Ports:
# d(0:3) means d0 d1 d2 d3, 4 signals
# Width x mean [x-1: 0]
# Direction: i-input, o-output, io-inout
# Name				Width		Direction
####################################################
clk					1			i
rst					1			i
d(0:3)				16			i
sel					2			i
out					5			o
validout			1			o
####################################################
```

Set module signals (if you already know what signal you want to create)
```make
Signals:
# Type: r-reg, w-wire, l-logic(only used in testbench)
# Name				Width		Type
####################################################
d_reg				16			r
####################################################
```

This is some rules I designed
```make
# Other rules

# 1. All ports will be assigned as wire type
# 2. Output signals will stage in registers, use xxx_reg signal to diver
#    assign block will be auto generated for output signals
```

### 2. Modify the file path in Verilog_template_gen.py
You need to set the path of `parameters.txt` and the path of where to store the new verilog file (and it's testbench) in the end of `Verilog_template_gen.py`.

```python
if __name__ == '__main__':
    input_file_path = r"D:/Github/Nowcoder_Verilog/Verilog_gen/parameters.txt"
    o_file_path = r"D:/Github/Nowcoder_Verilog/VL5/"
```

### 3. Run the python script to generate Verilog files
The python script will generate two files: RTL source file `<module>.v` and testbench `tb_<module>.sv`.

