ASM      = nasm
LINKER   = ld

SRC_DIR   = src
BUILD_DIR = build

ASMFLAGS = -f elf -g -F dwarf
LDFLAGS  = -m elf_i386

TARGET   = $(BUILD_DIR)/main
SRCS     = $(wildcard $(SRC_DIR)/*.asm)
OBJS     = $(patsubst $(SRC_DIR)/%.asm, $(BUILD_DIR)/%.o, $(SRCS))

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LINKER) $(LDFLAGS) $^ -o $@

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.asm | $(BUILD_DIR)
	$(ASM) $(ASMFLAGS) $< -o $@

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

run: $(TARGET)
	./$(TARGET); echo "Exit code: $$?"

debug: $(TARGET)
	gdb -q $(TARGET)

clean:
	rm -rf $(BUILD_DIR)