from instr import Instruction


class StackInstruction(Instruction):
    op_codes = {
        "PSH": " 011110",
        "POP": " 011111"
    }

    registers = {
        "X": "00",
        "Y": "01",
        "ACC": "10",
        "PC": "11"
    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])
        self.arg1 = arg_list[1]

    def assemble(self):
        result = StackInstruction.op_codes[self.instruction]
        result = result + StackInstruction.registers[self.arg1]
        result += f'{0:08b}'
        return result

    