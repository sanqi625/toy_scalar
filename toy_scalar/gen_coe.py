import argparse

def process_file(input_file, output_file):
    insert_lines = ["memory_initialization_radix=16;", "memory_initialization_vector="]

    with open(input_file, 'r') as f:
        lines = f.readlines()

    # 删除首行
    lines = lines[1:]

    with open(output_file, 'w') as f:
        # 插入默认的两行字符串
        for line in insert_lines:
            f.write(line + '\n')
        
        # 处理剩余行
        for i, line in enumerate(lines):
            words = line.split()
            for word in words:
                if i == len(lines) - 1 and word == words[-1]:
                    f.write(word + ';\n')  # 最后一行的最后一个单词以分号结尾
                else:
                    f.write(word + ',\n')

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Process a text file by deleting the first line, splitting each line by spaces, appending a comma to each word, inserting two default new lines at the beginning, and ending the last line with a semicolon.")
    parser.add_argument("input_file", help="The input file to process.")
    parser.add_argument("output_file", help="The output file to write the processed content to.")
    
    args = parser.parse_args()
    
    process_file(args.input_file, args.output_file)
