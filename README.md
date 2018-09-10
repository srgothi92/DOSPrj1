# PerfectSquare

**The program is to find the consecutive sequence of integers whose sum of squares is a perfect square. 
It takes the input in the form of n,k where the perfect square sequence will be of length k between 1 and n.
The list of 1 to n integers is distributed in seperate windows of size k and the aggregate of the perfect squares 
is computed in seperate process.It is then verified if the aggregate is a perfect square.**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `kv` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:kv, "~> 0.1.0"}
  ]
end
```
## Run the program

To run the code for this project, simply run in your terminal:

```elixir
$ mix PerfectSquare 3 4
```

## Tests

To run the tests for this project, simply run in your terminal:

```elixir
$ mix test
```

## Benchmark

Measuring times for different inputs on Single machine with 2 cores.




## Distributed Execution

To run program on multiple machines:
Start nodes, run on every machines:

```elixir
iex --name <node name>@<IPV4 address> --cookie <Cookie String> -S mix
``` 
where `<node name>` can be any user defined name of node
`<Cookie String>` is any user defined cookie, but it should be same across all the machine to make connection.
`<IPV4 address>` is the system IP address found by running `ipconfig/ifconfig`
Edit ./config/config.exs to list down names of all node. Naming format `:"<node name>@<IPV4address>"`
For example:

```
 config :DOSPRJ, :routing_table, {:"one@192.168.0.5", :"two@192.168.0.9",...}
 ```

Select Any Node as the central node to distribute task and run below commands on that node.

To make connections to differnet nodes:

```elixir
iex>Node.connect <node name>@<IPV4address> to make connection.
```

To check all connected nodes:

```elixir
iex> Node.list()
```
To Run the program on central node:

```elixir
iex> "DOSPRJ.TaskManager.execute(DOSPRJ.TaskManager, ["<ns>", "<k>"])"
```

 ## Documentation

To generate the documentation, run the following command in your terminal:

```elixir
$ mix docs
```
This will generate a doc/ directory with a documentation in HTML. 
To view the documentation, open the index.html file in the generated directory.

