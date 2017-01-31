defmodule Circlex.CLI do
  use ExCLI.DSL, escript: true

  name "circlex"
  description "My CLI"
  long_description ~s"""
  This is my long description
  """

  option :verbose, count: true, aliases: [:v]

  command :hello do
    description "Greets the user"
    long_description """
    Gives a nice a warm greeting to whoever would listen
    """

    argument :name
    option :from, help: "the sender of hello"

    run context do
      if context.verbose > 0 do
        IO.puts("Running hello command")
      end
      if from = context[:from] do
        IO.write("#{from} says: ")
      end
      IO.puts("Hello #{context.name}!")
    end
  end
end
