import os.path
import time

def name_process(port_name_str: str):
    port_name = list()
    if ':' in port_name_str:
        name = port_name_str.split('(')
        signal_name = name[0]
        start_end = name[1].strip(')').split(':')
        for i in range(int(start_end[0]), int(start_end[1]) + 1):
            port_name.append(signal_name + str(i))
    else:
        port_name.append(port_name_str)
    return port_name


def read_info(param_file):
    module_name = str()
    comment_info = dict()
    input_ports = list()
    inout_ports = list()
    output_ports = list()
    output_regs = list()
    signals = list()

    read_ports = False
    read_signals = False
    
    param = open(param_file, 'r')
    for line in param.readlines():
        strs = line.split()
        if len(strs) == 0:      # blank line
            continue
        elif '#' in strs[0]:    # comment
            continue
        elif strs[0] == 'Module_name:':
            module_name = strs[1]
        elif strs[0] == 'Affiliation:':
            comment_info['Affiliation'] = line.strip('Affiliation:').lstrip().strip('\n')
        elif strs[0] == 'Author:':
            comment_info['Author'] = line.strip('Author:').lstrip().strip('\n')
        elif strs[0] == 'Description:':
            comment_info['Description'] = line.strip('Description:').lstrip().strip('\n')
        elif strs[0] == 'Additional_Comments:':
            comment_info['Additional_Comments'] = line.strip('Additional_Comments:').lstrip().strip('\n')
        elif strs[0] == 'Ports:':
            read_ports = True
            read_signals = False
        elif strs[0] == 'Signals:':
            read_signals = True
            read_ports = False
        
        elif read_ports:
            port_name = name_process(strs[0])
            if strs[2] == 'i':
                if strs[1] == '1':
                    port_str_pri = 'input' + '\t' + 'wire\t\t\t\t'
                else:
                    port_str_pri = 'input' + '\t' + 'wire\t' + '[%d: 0]\t\t' % (int(strs[1]) - 1)
                for i in range(len(port_name)):
                    str_to_write = port_str_pri + port_name[i] + ','
                    input_ports.append(str_to_write)
            elif strs[2] == 'io':
                if strs[1] == '1':
                    port_str_pri = 'inout' + '\t' + 'wire\t\t\t\t'
                else:
                    port_str_pri = 'inout' + '\t' + 'wire\t' + '[%d: 0]\t\t' % (int(strs[1]) - 1)
                for i in range(len(port_name)):
                    str_to_write = port_str_pri + port_name[i] + ','
                    inout_ports.append(str_to_write)
            elif strs[2] == 'o':
                if strs[1] == '1':
                    port_str_pri = 'output' + '\t' + 'wire\t\t\t\t'
                    reg_str_pri = 'reg' + '\t\t' + '\t\t\t'
                else:
                    port_str_pri = 'output' + '\t' + 'wire\t' + '[%d: 0]\t\t' % (int(strs[1]) - 1)
                    reg_str_pri = 'reg' + '\t\t' + '[%d: 0]\t\t' % (int(strs[1]) - 1)
                for i in range(len(port_name)):
                    str_to_write = port_str_pri + port_name[i] + ','
                    reg_str = reg_str_pri + port_name[i] + '_reg;'
                    output_ports.append(str_to_write)
                    output_regs.append(reg_str)
            else:
                print("ERROR!!! Wrong Port Direction")
                return
            
        elif read_signals:
            signal_name = name_process(strs[0])
            if strs[2] == 'r':
                signal_type = 'reg\t\t'
            elif strs[2] == 'w':
                signal_type = 'wire\t'
            elif strs[2] == 'l':
                signal_type = 'logic\t'
            else:
                print("ERROR!!! Wrong Signal Type")
                return
            for i in range(len(signal_name)):
                if strs[1] == '1':
                    str_to_write = signal_type + '\t\t\t' + signal_name[i] + ';'
                else:
                    str_to_write = signal_type + '[%d: 0]\t\t' % (int(strs[1]) - 1) + signal_name[i] + ';'
                signals.append(str_to_write)
        else:
            print("ERROR!!! Illegal sentence")
            return

    if len(inout_ports) + len(output_ports) == 0:
        if len(input_ports) != 0:
            input_ports[-1] = input_ports[-1].strip(',')
    elif len(output_ports) == 0:
        inout_ports[-1] = inout_ports[-1].strip(',')
    else:
        output_ports[-1] = output_ports[-1].strip(',')
    
    return [module_name, comment_info, input_ports, inout_ports, output_ports, output_regs, signals]


def verilog_gen(output_file_path, verilog_info):
    # Extracting information
    module = verilog_info[0]
    comment = verilog_info[1]
    i_ports = verilog_info[2]
    io_ports = verilog_info[3]
    o_ports = verilog_info[4]
    o_regs = verilog_info[5]
    sig = verilog_info[6]
    
    # Save generated Verilog file in the specified path
    f_o = open(output_file_path + module + '.v', 'w')
    
    # File header comment block
    f_o.write('// ======================================================================' + '\n')
    f_o.write('// Affiliation:\t\t\t' + comment['Affiliation'] + '\n')
    f_o.write('// Author:\t\t\t\t' + comment['Author'] + '\n')
    f_o.write('// Create Date:\t\t\t' + time.strftime('%b %d, %Y', time.localtime(time.time())) + '\n')
    f_o.write('// Module Name:\t\t\t' + module + '\n')
    f_o.write('// Description:\t\t\t' + comment['Description'] + '\n')
    f_o.write('// Additional Comments:\t' + comment['Additional_Comments'] + '\n')
    f_o.write('// ======================================================================' + '\n\n')
    f_o.write('`timescale 1ns/1ns' + '\n\n')
    
    # Module ports
    f_o.write('module ' + module + ' (\n')
    for n in range(len(i_ports)):
        f_o.write('\t' + i_ports[n] + '\n')
    for n in range(len(io_ports)):
        f_o.write('\t' + io_ports[n] + '\n')
    for n in range(len(o_ports)):
        f_o.write('\t' + o_ports[n] + '\n')
    f_o.write(');\n\n')
    
    # Output ports use registers to drive
    for n in range(len(o_regs)):
        f_o.write(o_regs[n] + '\n')
    f_o.write('\n')
    
    # Module signals
    for n in range(len(sig)):
        f_o.write(sig[n] + '\n')
    f_o.write('\n')

    # Use 'assign' statement to connect output ports to their drivers
    len_max = 0
    for n in range(len(o_ports)):
        o_port_name = o_ports[n].split()[-1].strip(',')
        # Find the max length of output port name for aligning
        if len(o_port_name) > len_max:
            len_max = len(o_port_name)
    # Assign output ports
    for n in range(len(o_ports)):
        o_port_name = o_ports[n].split()[-1].strip(',')
        f_o.write('assign\t' + o_port_name.ljust(len_max + 2) + '=  ' + o_port_name + '_reg;\n')

    # This is end
    f_o.write('\n\n\nendmodule\n\n')
    f_o.close()


def tb_sv_gen(output_file_path, verilog_info):
    # Extracting information
    module = verilog_info[0]
    comment = verilog_info[1]
    i_ports = verilog_info[2]
    io_ports = verilog_info[3]
    o_ports = verilog_info[4]

    # Save generated testbench SystemVerilog file in the specified path
    f_o = open(output_file_path + 'tb_' + module + '.sv', 'w')

    # File header comment block
    f_o.write('// ======================================================================' + '\n')
    f_o.write('// Affiliation:\t\t\t' + comment['Affiliation'] + '\n')
    f_o.write('// Author:\t\t\t\t' + comment['Author'] + '\n')
    f_o.write('// Create Date:\t\t\t' + time.strftime('%b %d, %Y', time.localtime(time.time())) + '\n')
    f_o.write('// Module Name:\t\t\t' + 'tb_' + module + '\n')
    f_o.write('// Description:\t\t\t' + 'testbench for ' + comment['Description'] + '\n')
    f_o.write('// Additional Comments:\t' + comment['Additional_Comments'] + '\n')
    f_o.write('// ======================================================================' + '\n\n')
    f_o.write('`timescale 1ns/1ns' + '\n\n')

    # Testbench Module
    f_o.write('module ' + 'tb_' + module + ' ();\n\n')
    for n in range(len(i_ports)):
        f_o.write(i_ports[n].replace('input\twire', 'logic').strip(',') + ';\n')
    for n in range(len(io_ports)):
        f_o.write(io_ports[n].replace('inout\twire', 'logic').strip(',') + ';\n')
    for n in range(len(o_ports)):
        f_o.write(o_ports[n].replace('output\twire', 'logic').strip(',') + ';\n')
    f_o.write('\n')

    f_o.write('initial begin\n\t\nend\n\n')
    
    # Module instance
    f_o.write(module + ' u_' + module + ' (\n')
    # Find the max port name length
    len_max = 0
    for n in range(len(i_ports)):
        s_name = i_ports[n].split()[-1].strip(',')
        # Find the max length of output port name for aligning
        if len(s_name) > len_max:
            len_max = len(s_name)
    for n in range(len(io_ports)):
        s_name = io_ports[n].split()[-1].strip(',')
        # Find the max length of output port name for aligning
        if len(s_name) > len_max:
            len_max = len(s_name)
    for n in range(len(o_ports)):
        s_name = o_ports[n].split()[-1].strip(',')
        # Find the max length of output port name for aligning
        if len(s_name) > len_max:
            len_max = len(s_name)

    for n in range(len(i_ports)):
        s_name = i_ports[n].split()[-1].strip(',')
        if ',' in i_ports[n]:
            f_o.write('\t.' + s_name.ljust(len_max + 4) + '( ' + s_name.ljust(len_max + 1) + '),\n')
        else:
            f_o.write('\t.' + s_name.ljust(len_max + 4) + '( ' + s_name.ljust(len_max + 1) + ')\n')
    for n in range(len(io_ports)):
        s_name = io_ports[n].split()[-1].strip(',')
        if ',' in io_ports[n]:
            f_o.write('\t.' + s_name.ljust(len_max + 4) + '( ' + s_name.ljust(len_max + 1) + '),\n')
        else:
            f_o.write('\t.' + s_name.ljust(len_max + 4) + '( ' + s_name.ljust(len_max + 1) + ')\n')
    for n in range(len(o_ports)):
        s_name = o_ports[n].split()[-1].strip(',')
        if ',' in o_ports[n]:
            f_o.write('\t.' + s_name.ljust(len_max + 4) + '( ' + s_name.ljust(len_max + 1) + '),\n')
        else:
            f_o.write('\t.' + s_name.ljust(len_max + 4) + '( ' + s_name.ljust(len_max + 1) + ')\n')
    f_o.write(');\n')
    # This is end
    f_o.write('\nendmodule\n\n')
    f_o.close()
    
    
if __name__ == '__main__':
    input_file_path = r"D:/Github/Nowcoder_Verilog/Verilog_gen/parameters.txt"
    o_file_path = r"D:/Github/Nowcoder_Verilog/VL3/"
    
    if not os.path.exists(o_file_path):
        os.makedirs(o_file_path)
    info = read_info(input_file_path)
    verilog_gen(o_file_path, info)
    tb_sv_gen(o_file_path, info)
    
