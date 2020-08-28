# frozen_string_literal: true

# used by shrine's backgrounding plugin
class DestroyJob
  include Sidekiq::Worker

  def perform(attacher_class, data)
    attacher_class = Object.const_get(attacher_class)

    attacher = attacher_class.from_data(data)
    attacher.destroy
  end
end
