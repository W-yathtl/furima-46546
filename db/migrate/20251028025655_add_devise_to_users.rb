# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :nickname,           null: false
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## User personal information
      t.string :last_name,          null: false
      t.string :first_name,         null: false
      t.string :last_name_kana,     null: false
      t.string :first_name_kana,    null: false
      t.date   :birthday,           null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      t.timestamps null: false
    end

    # Indexes（検索・一意性制約）
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
  end
end