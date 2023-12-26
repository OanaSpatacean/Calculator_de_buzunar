from instr import Instruction


class NoArgument(Instruction):
    op_codes = {
        "NOP": "100000"
    }

    def __init__(self, arg_list):
        super().__init__(arg_list[0])

    def assemble(self):
        result = NoArgument.op_codes[self.instruction]
        result += f'{0:010b}'
        return result

