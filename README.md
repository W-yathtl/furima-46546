# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## 概要
このREADMEは、フリマアプリ（例：https://furima2020.herokuapp.com/）を模倣したデータベース設計を示しています。  
ユーザー登録、商品出品、コメント投稿、購入機能を想定しています。

---

## ER 図 概要
- **User（ユーザー）**: 出品・購入・コメントを行う
- **Item（商品）**: 出品された商品情報
- **Comment（コメント）**: 商品へのコメント
- **Order（購入情報）**: 購入時の支払・配送情報

---

## テーブル設計

### users テーブル
| カラム名 | 型 | 制約 |
|-----------|----|------|
| nickname | string | null: false |
| email | string | null: false, unique: true |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name _kana| string | null: false |
| first_name_kana| string | null: false |
| birthday | date | null: false |
| created_at / updated_at | datetime |  |  |

**Association**
- has_many :orders
- has_many :items
- has_many :comments

---

### items テーブル
| カラム名 | 型 | 制約 |
|-----------|----|------|
| name | string | null: false |
| description | text | null: false |
| price | integer | null: false |
| user | references | foreign_key: true |
| created_at / updated_at | datetime |
| category_id      | integer | null: false |
| condition_id     | integer | null: false |
| shipping_fee_id  | integer | null: false |
| prefecture_id    | integer | null: false |
| shipping_days_id | integer | null: false |  |  |

**Association**
- belongs_to :user
- has_many :comments
- has_one :order
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_days
  has_one_attached :image,

---

### comments テーブル
| カラム名 | 型 | 制約 |
|-----------|----|------|
| text | text | null: false |
| user_id | references | foreign_key: true |
| item_id | references | foreign_key: true |
| created_at / updated_at | datetime |  |  |

**Association**
- belongs_to :user
- belongs_to :item

---

### orders テーブル
| カラム名 | 型 | 制約 |
|-----------|----|------|
| postal_code | string | null: false |
| city | string | null: false |
| address | string | null: false |
| detail_address | string |  |
| phone | string | null: false |
| user_id | references | foreign_key: true |
| item_id | references | foreign_key: true |
| created_at / updated_at | datetime |  |  |

**Association**
- belongs_to :item
- belongs_to :user

---

## リレーション概要
```
User has_many Items
User has_many Orders
User has_many Comments

Item belongs_to User
Item has_many Comments
Item has_one Order

Comment belongs_to User
Comment belongs_to Item

Order belongs_to User
Order belongs_to Item
```

---

## 注意事項
- `orders` テーブルのカード情報は実際の運用ではDB保存禁止（トークン化対応推奨）。
- `sold_out` カラムは購入済み判定フラグ。
- 外部キー制約は `foreign_key: true` を付与。
- `price` には数値制限（例: ¥300〜¥9,999,999）を設定。

---

## 今後の拡張例
- カテゴリテーブル（`categories`）の追加
- 配送情報テーブル（`shipping_addresses`）の追加
- トークン決済（Stripe対応）



