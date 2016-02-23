defmodule MonitChromeTest do
  use ExUnit.Case, async: true
  doctest MonitChromeTest

  test "chrome process monitor" do
    {:ok, chrome} = GenServer.start_link MonitChrome, :ok, []
    # Chrome needs to be open for the test to pass
    assert GenServer.call chrome, {:chrome_info, 5000} != nil
    # Kill chrome process
    GenServer.call chrome, {:kill_chrome}
    # empty string when there is no chrome process present
    assert GenServer.call chrome, {:chrome_info, 5000} == ""
  end
end