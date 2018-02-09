# frozen_string_literal: true

json.array! @travels, partial: 'travels/travel', as: :travel
