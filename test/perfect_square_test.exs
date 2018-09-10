defmodule DOSPRJ.TaskManagerTest do
    use ExUnit.Case, async: true
  
    setup do
        {:ok, pid} = DOSPRJ.TaskManager.start_link([])
        {:ok, pid: pid}
    end
  
    # test "the sum of squares of list element" do
    #     assert DOSPRJ.TaskManager.calculateSquare([3,4]) == 25
    # end

    test "execute" do
        assert DOSPRJ.TaskManager.execute(DOSPRJ.TaskManager,["3","2"]) == [[3,4]]
    end

    test "read with count" do
        {:ok, file} = File.open(Path.expand('fixtures/file.txt', __DIR__), [:charlist])
        assert 'FOO' == IO.read(file, 3)
        assert File.close(file) == :ok
    end
    

  end
  