FROM creatior3/ruby-tests

WORKDIR /app

COPY src/ ./src/

ENTRYPOINT []
CMD ["ruby", "./tests/test.rb"]