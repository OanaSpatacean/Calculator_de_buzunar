from instr import Instruction


class OneArgument(Instruction):
    op_codes = {
        "BRZ": "000000",
        "BRN": "000001",
        "BRC": "000010",
        "BRO": "000011",
        "BRA": "000100"
    }

    labels = {

    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])
        self.arg1 = arg_list[1]

    def assemble(self):
        result = OneArgument.op_codes[self.instruction]
        result += f'{int(OneArgument.labels[self.arg1]):010b}'

        return result