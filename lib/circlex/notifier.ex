defmodule Circlex.Notifier do
  @callback idle() :: any
  @callback status_change(String.t, String.t, String.t, String.t) :: any
end
