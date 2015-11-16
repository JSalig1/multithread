require './worker'

class Main
  def call_async
    HardWorker.perform_async('bob', 5)
  end
end
