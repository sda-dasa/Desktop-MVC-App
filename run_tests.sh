#!/bin/bash

DOCKER_IMAGE=$1
REPORT_PATH=$2
TEST_PATH=$3
CI_COMMIT_TITLE=$4

# Запускаем тесты и перехватываем ошибки
set +e
TEST_OUTPUT=$(docker run --rm -v $(pwd)/$REPORT_PATH:/app/report $DOCKER_IMAGE ./$TEST_PATH 2>&1)
TEST_EXIT_CODE=$?
set -e

# Создаем HTML отчет в любом случае
if [ $TEST_EXIT_CODE -ne 0 ]; then
  ERROR_REPORT="$REPORT_PATH/error.html"
  cat > "$ERROR_REPORT" <<HTML
<!DOCTYPE html>
<html>
<head>
    <title>Test Error Report</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        pre { background-color: #f5f5f5; padding: 10px; border-radius: 5px; }
        .error { color: #d9534f; }
    </style>
</head>
<body>
    <h1 class="error">Test Execution Failed</h1>
    <p>Error occurred while running tests for: $TEST_PATH</p>
    <h2>Error Details:</h2>
    <pre>${TEST_OUTPUT}</pre>
</body>
</html>
HTML
  mv "$ERROR_REPORT" "$REPORT_PATH/index.html"
  PASSED=0
else
  PASSED=$(grep -q '100% passed' $REPORT_PATH/index.html && echo "1" || echo "0")
fi

# Формируем имя отчета
TAG=$(echo "$CI_COMMIT_TITLE" | grep -oE "L[0-9]+ T[0-9]+(\.[0-9]+)?" || true)
[ -z "$TAG" ] && TAG="UNKNOWN"
TAG_UNDERSCORED=${TAG// /_}

set +e
COUNT=$(ls $REPORT_PATH/report_*_${TAG_UNDERSCORED}*.html 2>/dev/null | wc -l)
set -e
INDEX=$((COUNT + 1))

REPORT_NAME="report_${INDEX}_${TAG_UNDERSCORED}"
[ "$PASSED" -eq 1 ] && REPORT_NAME="${REPORT_NAME}_PASSED" || REPORT_NAME="${REPORT_NAME}_FAILED"
REPORT_NAME="${REPORT_NAME}.html"

mv $REPORT_PATH/index.html $REPORT_PATH/$REPORT_NAME
echo $REPORT_NAME > $REPORT_PATH/report_name.txt
