# Data architecture documentation

We have decided to use 5 tables: `users`, `posts`, `comments`, `reactions`, `friendships`

for a more interactive look check [this link](https://dbdiagram.io/d/5d4c841aced98361d6dd7015)

***
## Users

Contains:
- id  `int`,`pk`
- name `varchar`
- email `varchar`
- password `varchar`
- birth_day `date`
- bio `varchar`

Relationships:
- has_many `:authored_posts`, foreign_key: `:author_id`
- has_many `:authored_comments`, foreign_key: `:author_id`
- has_many `:friendships`, foreign_key: `:user_1`
- has_many `:friendships`, foreign_key: `:user_2`
- has_many `:reactions`, foreign_key: `:author_id`

***

## Posts

Contains:
- id  `int`,`pk`
- author_id `int`
- content `varchar`

Relationships:
- owned_by `:author`, foreign_key: `:author_id`
- has_many `:post_comments`, foreign_key: `:post_id`
- has_many `:post_reactions`, foreign_key: `:post_id`

***

## Reactions

Contains:
- id  `int`,`pk`
- author_id `int`
- post_id `int`

Relationships:

- owned_by `:author`, foreign_key: `:author_id`
- owned_by `:post`, foreign_key: `:post_id`

***

## Frienships

Contains:
- id  `int`,`pk`
- accepted `boolean`
- user_1 `int`
- user_2 `int`

Relationships:

- has_many `:users`
- has_many `:users`

