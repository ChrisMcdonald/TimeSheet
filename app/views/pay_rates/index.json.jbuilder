# frozen_string_literal: true

json.array! @pay_rates, partial: 'pay_rates/pay_rate', as: :pay_rate
