from instr import Instruction


def twos_complement(val, nbits):
    """Compute the 2's complement of int value val"""
    if val < 0:
        val = (1 << nbits) + val
    else:
        if (val & (1 << (nbits - 1))) != 0:
            # If sign bit is set.
            # compute negative value.
            val = val - (1 << nbits)
    return val


class TwoArguments(Instruction):
    op_codes = {
        "LD": "011010",
        "ST": "000011",
        "ADD": "000111",
        "SUB": "001000",
        "LSR": "001001",
        "LSL": "001010",
        "MUL": "001101",
        "DIV": "001110",
        "MOD": "001111",
        "CMP": "010100",
        "INC": "010110",
        "DEC": "010111",
        "MOV": "011001",
        "AND": "010001",
        "OR": "010000",
        "XOR": "010010",
        "NOT": "010011",
        "RSR": "001011",
        "RSL": "001100",
        "FACT": "011000"
    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])
        self.arg1 = arg_list[1]
        if int(arg_list[2]) > 255 or int(arg_list[2]) < -256:
            raise Exception("Arguments must be [-256, 255]")
        self.arg2 = twos_complement(int(arg_list[2]), 9)

    def assemble(self):
        result = TwoArguments.op_codes[self.instruction]
        result = result + Instruction.registers[self.arg1]
        result = result + '{0:09b}'.format(self.arg2)
        return result