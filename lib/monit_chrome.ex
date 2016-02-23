defmodule MonitChrome do
  alias Porcelain.Result
  use GenServer

  def init(:ok) do
    chrome_pid = nil
    {:ok, chrome_pid}
  end

  ## Server callbacks
  def handle_call({:chrome_info, 5000}, _from, chrome_pid) do
    # Get pid for chrome process
    # System.cmd "executable_name", [ array, "—of", args ], env: [ {  "ENV", export_tuples } ]
    %Result{out: output,status: _} = Porcelain.shell("ps hf -opid -C chrome | awk '{ print $1; exit }'")
    chrome_pid = String.rstrip(output, ?\n)
    {:reply, chrome_pid, chrome_pid}
  end

  def handle_call({:kill_chrome}, _from, chrome_pid) do
    Porcelain.shell("kill -9 $(ps hf -opid -C chrome | awk '{ print $1; exit }');")
    {:reply, :ok, chrome_pid}
  end
end