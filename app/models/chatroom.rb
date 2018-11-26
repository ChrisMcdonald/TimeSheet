# frozen_string_literal: true

class Chatroom < ApplicationRecord
  belongs_to :user , dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :chatroom_users, dependent: :destroy
  has_many :users, through: :chatroom_users , dependent: :destroy
end
