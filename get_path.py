#!/usr/bin/env python3
import re
import sys

def parse_test_path(input_str):
    pattern = r'L(\d+)\s+T(\d+(?:\.\d+(?:\.[a-z])?)?)(?:\s+V(\d+))?'
    match = re.search(pattern, input_str)
    
    if not match:
        raise ValueError("Неверный формат. Ожидается: L<num> T<num>[.<num>[.<a-z>]] [V<num>] [comment]")
    
    lab_num = match.group(1)
    task_full = match.group(2)
    variant_num = match.group(3)
    
    parts = task_full.split('.')
    main_task = parts[0]
    
    # Базовый путь всегда включает lab и task
    path = f"tests/lab{lab_num}/task{main_task}"
    
    # Обработка подпунктов
    if len(parts) > 1:
        path += f"/p{parts[1]}"
        if len(parts) > 2:  # Буквенный подпункт
            path += f"/{parts[2]}"
    
    # Обработка варианта
    if variant_num:
        path += f"/opt{variant_num}"
    
    # Добавляем расширение файла
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