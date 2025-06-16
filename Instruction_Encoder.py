# R-Type instructions
def encode_add(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b000
    funct7 = 0b0000000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_sub(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b000
    funct7 = 0b0100000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_xor(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b100
    funct7 = 0b0000000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_or(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b110
    funct7 = 0b0000000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_and(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b111
    funct7 = 0b0000000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_sll(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b001
    funct7 = 0b0000000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_srl(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b101
    funct7 = 0b0000000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_sra(rd, rs1, rs2):
    opcode = 0b0110011
    funct3 = 0b101
    funct7 = 0b0100000
    instr = (funct7 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr


# I-Type instructions
def encode_addi(rd, rs1, imm):
    opcode = 0b0010011
    funct3 = 0b000
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_xori(rd, rs1, imm):
    opcode = 0b0010011
    funct3 = 0b100
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_ori(rd, rs1, imm):
    opcode = 0b0010011
    funct3 = 0b110
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_andi(rd, rs1, imm):
    opcode = 0b0010011
    funct3 = 0b111
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_slli(rd, rs1, shamt):
    opcode = 0b0010011
    funct3 = 0b001
    funct7 = 0b0000000
    imm = (funct7 << 5) | (shamt & 0x1F)
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_srli(rd, rs1, shamt):
    opcode = 0b0010011
    funct3 = 0b101
    funct7 = 0b0000000
    imm = (funct7 << 5) | (shamt & 0x1F)
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr

def encode_srai(rd, rs1, shamt):
    opcode = 0b0010011
    funct3 = 0b101
    funct7 = 0b0100000
    imm = (funct7 << 5) | (shamt & 0x1F)
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr


# load instruction
def encode_lw(rd, rs1, imm):
    opcode = 0b0000011
    funct3 = 0b000
    instr = (imm << 20) | (rs1 << 15) | (funct3 << 12) | (rd << 7) | opcode
    return instr


# store instruction
def encode_sw(rs1, rs2, imm):
    opcode = 0b0100011
    funct3 = 0b000
    imm11_5 = (imm >> 5) & 0x7F
    imm4_0 = imm & 0x1F
    instr = (imm11_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm4_0 << 7) | opcode
    return instr

# branch instructions
def encode_beq(rs1, rs2, imm):
    opcode = 0b1100011
    funct3 = 0b000
    imm = imm >> 1
    imm12 = (imm >> 11) & 0x1
    imm10_5 = (imm >> 5) & 0x3F
    imm4_1 = (imm >> 1) & 0xF
    imm11 = (imm >> 10) & 0x1
    instr = (imm12 << 31) | (imm10_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm4_1 << 8) | (imm11 << 7) | opcode
    return instr

def encode_bne(rs1, rs2, imm):
    opcode = 0b1100011
    funct3 = 0b001
    imm = imm >> 1
    imm12 = (imm >> 11) & 0x1
    imm10_5 = (imm >> 5) & 0x3F
    imm4_1 = (imm >> 1) & 0xF
    imm11 = (imm >> 10) & 0x1
    instr = (imm12 << 31) | (imm10_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm4_1 << 8) | (imm11 << 7) | opcode
    return instr

def encode_blt(rs1, rs2, imm):
    opcode = 0b1100011
    funct3 = 0b100
    imm = imm >> 1
    imm12 = (imm >> 11) & 0x1
    imm10_5 = (imm >> 5) & 0x3F
    imm4_1 = (imm >> 1) & 0xF
    imm11 = (imm >> 10) & 0x1
    instr = (imm12 << 31) | (imm10_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm4_1 << 8) | (imm11 << 7) | opcode
    return instr

def encode_bge(rs1, rs2, imm):
    opcode = 0b1100011
    funct3 = 0b101
    imm = imm >> 1
    imm12 = (imm >> 11) & 0x1
    imm10_5 = (imm >> 5) & 0x3F
    imm4_1 = (imm >> 1) & 0xF
    imm11 = (imm >> 10) & 0x1
    instr = (imm12 << 31) | (imm10_5 << 25) | (rs2 << 20) | (rs1 << 15) | (funct3 << 12) | (imm4_1 << 8) | (imm11 << 7) | opcode
    return instr

# jump and link instruction
def encode_jal(rd, imm):
    opcode = 0b1101111
    imm20    = (imm >> 19) & 0x1
    imm10_1  = (imm >> 9)  & 0x3FF
    imm11    = (imm >> 8)  & 0x1
    imm19_12 = imm & 0xFF
    instr = (imm20 << 31) | (imm19_12 << 12) | (imm11 << 20) | (imm10_1 << 21) | (rd << 7) | opcode
    return instr

# converting instruction to hex
def to_hex(instr):
    return f"{instr:08X}"

# Parsing assembly instruction and encoding to hex
def parse_and_encode(instr_str):
    parts = instr_str.replace(',', '').split()
    if len(parts) == 0:
        return None

    inst = parts[0]
    try:
        if inst == "add":
            return to_hex(encode_add(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "sub":
            return to_hex(encode_sub(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "xor":
            return to_hex(encode_xor(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "or":
            return to_hex(encode_or(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "and":
            return to_hex(encode_and(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "sll":
            return to_hex(encode_sll(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "srl":
            return to_hex(encode_srl(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "sra":
            return to_hex(encode_sra(int(parts[1][1:]), int(parts[2][1:]), int(parts[3][1:])))
        elif inst == "addi":
            return to_hex(encode_addi(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "xori":
            return to_hex(encode_xori(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "ori":
            return to_hex(encode_ori(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "andi":
            return to_hex(encode_andi(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "slli":
            return to_hex(encode_slli(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "srli":
            return to_hex(encode_srli(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "srai":
            return to_hex(encode_srai(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "lw":
            rd = int(parts[1][1:])
            imm_str, rs1_str = parts[2].split('(')
            imm = int(imm_str)
            rs1 = int(rs1_str[:-1][1:])
            return to_hex(encode_lw(rd, rs1, imm))
        elif inst == "sw":
            rs2 = int(parts[1][1:])  
            imm_str, rs1_str = parts[2].split('(') 
            imm = int(imm_str)
            rs1 = int(rs1_str[:-1][1:]) 
            return to_hex(encode_sw(rs1, rs2, imm))
        elif inst == "beq":
            return to_hex(encode_beq(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "bne":
            return to_hex(encode_bne(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "blt":
            return to_hex(encode_blt(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "bge":
            return to_hex(encode_bge(int(parts[1][1:]), int(parts[2][1:]), int(parts[3])))
        elif inst == "jal":
            return to_hex(encode_jal(int(parts[1][1:]), int(parts[2])))
        else:
            return f"Unsupported instruction: {inst}"
    except Exception as e:
        return f"Error: {e}"

# interactive shell to use encoder
def main():
    print("Enter RISC-V instruction: (type exit to exit program)\n")
    while True:
        line = input("> ")
        if line.strip().lower() in ["exit"]:
            break
        result = parse_and_encode(line)
        print(result)

if __name__ == "__main__":
    main()