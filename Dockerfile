FROM creatior3/ruby-tests

WORKDIR /app

COPY src/ ./src/
COPY get_path.py ./scripts/get_path.py

ENTRYPOINT ["ruby"]
CMD ["./tests/test.rb"]