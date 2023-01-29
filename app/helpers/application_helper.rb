# frozen_string_literal: true

module ApplicationHelper
  def render_turbo_stream_flash_messages
    # Este helper es útil para evitar repetir esta línea de código:

    # <%= turbo_stream.prepend 'flash', partial: 'layouts/flash' %>

    # en todos los lugares donde queramos mostrar un mensaje nuevo,
    # como en los create.turbo_stream.erb, update.turbo_stream.erb y destroy.turbo_stream.erb
    # ubicados en "views/quotes"

    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end
end
