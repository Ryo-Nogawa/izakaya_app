# テーブル設計


## usersテーブル

| Column       | Type    | Options     |
|--------------|---------|-------------|
| nickname     | string  | null: false |
| name         | string  | null: false |
| name_kana    | string  | null: false |
| age          | integer | null: false |
| password     | string  | null: false |
| phone_number | string  | null: false |
| email        | string  | null: false |

### Association
- has_many :reserves
- has_many :visuals
- has_many :blogs
- has_many :blog_comments
- has_many :chats
- has_many :drinks
- has_many :drink_comments
- has_many :foods
- has_many :food_comments


## blogテーブル

| Column | Type       | Options           |
|--------|------------|-------------------|
| user   | references | foreign_key: true |
| title  | string     | null: false       |
| text   | text       | null: false       |

### Association
- belongs_to :user
- has_many :blog_comments


## blog_commentsテーブル

| Column  | Type       | Options           |
|---------|------------|-------------------|
| user    | references | foreign_key: true |
| blog    | references | foreign_key: true |
| comment | string     | null: false       |

### Association
- belongs_to :user
- belongs_to :blog


### visualテーブル

| Column | Type       | Options           |
|--------|------------|-------------------|
| user   | references | foreign_key: true |

### Association
- belongs_to :user


## chatテーブル

| Column | Type       | Options           |
|--------|------------|-------------------|
| user   | references | foreign_key: true |
| text   | string     | null: false       |

### Association
- belongs_to :user


## reserveテーブル

| Column              | Type       | Options           |
|---------------------|------------|-------------------|
| user                | references | foregin_key: true |
| reserve_date        | date       | null: false       |
| reserve_time        | time       | null: false       |
| number_reserve      | integer    | null: false       |
| reserve_categoty_id | integer    | null: false       |

### Association
- belongs_to :user


## drinkテーブル

| Column            | Type       | Options           |
|-------------------|------------|-------------------|
| user              | references | foregin_key: true |
| title             | string     | null: false       |
| detail            | string     | null: false       |
| price             | integer    | null: false       |
| drink_category_id | integer    |                   |

- belongs_to :user
- has_many drink_comments


## drink_commentテーブル

| Column  | Type       | Options           |
|---------|------------|-------------------|
| user    | references | foregin_key: true |
| drink   | references | foregin_key: true |
| comment | string     | null: false       |

### Association
- belongs_to :user
- belongs_to :drink


## foodテーブル

| Column            | Type       | Options           |
|-------------------|------------|-------------------|
| user              | references | foregin_key: true |
| title             | string     | null: false       |
| detail            | string     | null: false       |
| price             | integer    | null: false       |
| food_category_id  | integer    |                   |

### Association
- belongs_to :user
- has_many :food_comments


## food_commentsテーブル

| Column  | Type       | Options           |
|---------|------------|-------------------|
| user    | references | foregin_key: true |
| food    | references | foregin_key: true |
| comment | string     | null: false       |

### Association
- belongs_to :user
- belongs_to :food
