## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| family_name        | string | DEFAULT|
| first_name         | string | DEFAULT|
| ruby               | string | DEFAULT|
| nickname           | string | null: false |
| email              | string |null: false unique|
| encrypted_password | string | null: false |
| birthday           | date   | null: false |


## items テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| seller| string | null: false |
| category |references|null: false,foreign_key|
| condition | string |null: false,foreign_key|
| shipping_charge | text | null: false |　
| prefecture | text | null: false |都道府県
| shipping_date | text | null: false |


## records テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| users | references| null: false,foreign_key: true    |
| items  | references | null: false,foreign_key: true    　　　           |
| items_name | string | null: false          　　　      |
| value | integer | null: false                   　　　 |
| category | string | null: false                  　  |
| buyer | string | null: false                   　　　 |

## shipping_informations テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| buyer | string    | null: false,        |
| payment_method | string     | null: false                |
| post_code | string | null: false               |
| prefectures | string | null: false               |
| city | string | null: false               |
| block_number | string | null: false               |
| telephone_number| string | null: false               |