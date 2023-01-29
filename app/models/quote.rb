# frozen_string_literal: true

class Quote < ApplicationRecord
  validates :name, presence: true

  scope :ordered, -> { order(created_at: :desc) }

  after_create_commit lambda {
                        broadcast_prepend_later_to 'quotes',
                                                   partial: 'quotes/quote',
                                                   locals: { quote: self },
                                                   target: 'quotes'
                      }

  # Explicacion de linea 8:
  # after_create_commit: le dice a Rails que la expresión del lambda
  # debe ejecutarse cada vez que se inserta un nuevo Quote en la BD.

  # Todo el resto de la expresión le dice a Rails que el HTML del Quote creado
  # debe transmitirse a todos los usuarios suscritos al stream "quotes"
  # y prependear ese HTML recibido al elemento del DOM que tenga el id "quotes"

  # Esto requiere Redis instalado en tu computadora, para instalarlo visitar:
  # https://redis.io/docs/getting-started/installation/install-redis-on-linux/

  # Por convenciones de Rails, este lamba de broadcast es equivalente al siguiente:
  # after_create_commit -> { broadcast_prepend_to :quotes }

  # La siguiente línea provee la misma funcionalidad pero para la actualización de Quotes:
  after_update_commit -> { broadcast_replace_later_to :quotes }

  # Por último, la siguiente línea provee la funcionalidad para la eliminación de Quotes:
  after_destroy_commit -> { broadcast_remove_to :quotes }

  # Nota importante:
  # A los métodos 'broadcast_prepend_to' y 'broadcast_replace_to' se les agregó
  # la palabra 'later', de esta manera utilizamos sus equivalentes asincrónicos,
  # los cuales utilizan ActiveJob para ejecutarse en segundo plano y no afectar la performance de nuestra app.
  # 'broadcast_remove_to' no tiene un equivalente asincrónico porque al eliminar un elemento de la BD,
  # el proceso en segundo plano no podría obtener ese elemento de la BD más tarde para realizar la tarea.

  # Finalmente, gracias a las convenciones de Rails, los 3 callbacks descritos anteriormente se pueden resumir así:
  # broadcasts_to ->(_) { :quotes }, inserts_by: :prepend
end
