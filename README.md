# アプリケーション名

## 概要
ユーザーが商品を出品・購入できるフリマアプリです。  
ユーザー登録、出品、購入、コメント機能を備えています。

---

## テーブル設計

### users テーブル

| カラム名 | 型 | 制約 |
|-----------|------|------------|
| nickname | string | null: false |
| email | string | null: false, unique: true |
| encrypted_password | string | null: false |
| last_name | string | null: false |
| first_name | string | null: false |
| last_name_kana | string | null: false |
| first_name_kana | string | null: false |
| birthday | date | null: false |

**Association**
- has_many :items  
- has_many :purchase_managements  

---

### items テーブル

| カラム名 | 型 | 制約 |
|-----------|------|------------|
| name | string | null: false |
| description | text | null: false |
| price | integer | null: false |
| category_id | integer | null: false |
| condition_id | integer | null: false |
| shipping_fee_id | integer | null: false |
| prefecture_id | integer | null: false |
| shipping_day_id | integer | null: false |
| user | references | null: false, foreign_key: true |

**Association**
- belongs_to :user  
- has_one :purchase_management  

**ActiveHash**
- belongs_to :category  
- belongs_to :condition  
- belongs_to :shipping_fee  
- belongs_to :prefecture  
- belongs_to :shipping_days  

**ActiveStorage**
- has_one_attached :image  

---

### orders テーブル

| カラム名 | 型 | 制約 |
|-----------|------|------------|
| postal_code | string | null: false |
| prefecture_id | integer | null: false |
| city | string | null: false |
| address | string | null: false |
| detail_address | string |  |
| phone | string | null: false |
| purchase_management | references | null: false, foreign_key: true |

**Association**
- belongs_to :purchase_management  

---


### purchase_managements テーブル

| カラム名 | 型 | 制約 |
|-----------|------|------------|
| user | references | null: false, foreign_key: true |
| item | references | null: false, foreign_key: true |

**Association**
- belongs_to :user  
- belongs_to :item  
- has_one :order  

---
