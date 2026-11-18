version 1.0

workflow hello_world {
  input {
    String name = "World"
  }

  call say_hello {
    input:
      name = name
  }

  output {
    String greeting = say_hello.greeting
    File output_file = say_hello.out_file
  }
}

task say_hello {
  input {
    String name
  }

  command <<<
    echo "Hello, ~{name}!" | tee hello.txt
  >>>

  output {
    String greeting = read_string(stdout())
    File out_file = "hello.txt"
  }

  runtime {
    docker: "ubuntu:22.04"
  }
}
