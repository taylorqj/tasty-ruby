# tasty

[![Build Status](https://travis-ci.org/taylorqj/tasty.svg?branch=master)](https://travis-ci.org/taylorqj/tasty)

Ruby on Grape API

## Getting started

Set your environments MongoDB settings here.

create `config/application.yml`
```ruby
mongo_host: localhost
mongo_db: tasty_development
test_key: 12AJSGDHASD6ASD5FA7842KDSK

test:
  mongo_host: localhost:27017
  mongo_db: tasty_test
  test_key: 12AJSGDHASD6ASD5FA7842KDSK

development:
  mongo_host: localhost:27017
  mongo_db: tasty_development
  test_key: 12AJSGDHASD6ASD5FA7842KDSK

```
`$ rackup config.ru -E whatever-environment`
