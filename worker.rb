require 'sidekiq'

class HardWorker
  include Sidekiq::Worker

  def perform(name, count)
    #do something useful
    count.times { |num| puts num }
    puts "background job processed by #{name}"
  end
end
