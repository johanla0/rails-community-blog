# frozen_string_literal: true

module ViewHelper
  private

  FLASH_CLASSES = {
    error: 'bg-danger-subtle',
    alert: 'bg-danger-subtle',
    success: 'bg-success-subtle',
    notice: 'bg-white'
  }.freeze

  def flash_class(flash_name)
    FLASH_CLASSES[flash_name.to_sym]
  end
end
