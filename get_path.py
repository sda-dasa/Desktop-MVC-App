#!/usr/bin/env python3
import re
import sys

def parse_test_path(input_str):
    """
    Парсит строку вида "L<num> T<num>[.<num>[.<a-z>]] [V<num>] [comment]" и возвращает путь к тесту.
    
    Примеры:
    >>> parse_test_path("L1 T1 V1")
    'tests/lab1/task1/opt1_test.rb'
    >>> parse_test_path("L1 T4.4.a commit changes")
    'tests/lab1/task4/p4/a_test.rb'
    """
    pattern = r'L(\d+)\s+T(\d+(?:\.\d+(?:\.[a-z])?)?)(?:\s+V(\d+))?'
    match = re.search(pattern, input_str)
    
    if not match:
        raise ValueError("Неверный формат. Ожидается: L<num> T<num>[.<num>[.<a-z>]] [V<num>] [comment]")
    
    lab_num = match.group(1)
    task_full = match.group(2)
    variant_num = match.group(3)
    
    parts = task_full.split('.')
    main_task = parts[0]

    path = f"tests/lab{lab_num}/task{main_task}"
    
    if len(parts) > 1:
        path += f"/p{parts[1]}"
        if len(parts) > 2:
            path += f"/{parts[2]}"
    
    if variant_num:
        if len(parts) > 1: 
            path += f"_opt{variant_num}"
        else:
            path += f"/opt{variant_num}"
    
    path += "_test.rb"
    
    return path

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Использование: ./test_path.py 'L1 T1 [V1] [comment]'")
        sys.exit(1)
    
    try:
        test_path = parse_test_path(sys.argv[1])
        print(test_path)
    except ValueError as e:
        print(f"Ошибка: {e}")
        sys.exit(1)