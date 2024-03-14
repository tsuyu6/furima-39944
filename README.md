## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| family_name        | string | null: false|
| first_name         | string | null: false|
| first_name_kana   | string | null: false|
| family_name_kana | string | null: false|
| nickname           | string | null: false |
| email              | string |null: false,unique: true|
| encrypted_password | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :records


## items テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| user | references | null: false,foreign_key: true |
| category_id |integer|null: false|
| condition_id | integer |null: false|
| shipping_charge_id | integer | null: false |　
| prefecture_id | integer | null: false |都道府県
| item_name | string | null: false |
| price | integer | null: false |
| information | text | null: false |
| delively_day_id | integer | null: false |　

### Association

- belongs_to :user
- has_one:record


## records テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user | references| null: false,foreign_key: true    |
| item  | references | null: false,foreign_key: true    　　　           |

- belongs_to :user
- belongs_to :item
- has_one:shipping_information

## shipping_informations テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| record |references | null: false,foreign_key: true         |購入記録テーブルの外部キー
| post_code | string | null: false               |郵便番号
｜prefecture_id | integer | null: false |都道府県
| city | string | null: false               |市区町村
| block_number | string | null: false           |番地
| building_name | string |            |建物名
| telephone_number| string | null: false               |電話番号

### Association

- belongs_to : record