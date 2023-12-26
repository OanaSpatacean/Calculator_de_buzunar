from tkinter import *
import re
from tkinter import filedialog, Tk
from stackInstruction import StackInstruction
from oneArgument import OneArgument




Tk().withdraw()
frame = Toplevel()

scrollbar = Scrollbar(frame)
scrollbar.pack(side=RIGHT, fill=Y)
frame.title("myCPU Assembler ")
textArea = Text(frame, height=30, width=100, padx=3, pady=3, yscrollcommand=scrollbar.set)
textArea.pack(side=RIGHT)
scrollbar.config(command=textArea.yview)



frame.minsize(750, 450)
frame.maxsize(750, 450)
frame.mainloop()