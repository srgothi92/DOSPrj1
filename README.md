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
## Documentation

To generate the documentation, run the following command in your terminal:

```elixir
$ mix docs
```
This will generate a doc/ directory with a documentation in HTML. 
To view the documentation, open the index.html file in the generated directory.


