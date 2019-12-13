slidenumbers: true
slidecount: true
slide-dividers: #, ##
theme: Libre, 1

# Intro to ActionText

![inline](action_text_images/01.png)

# Agenda

1. Introduction
2. Installation/Setup
3. Creating our Rich-Textified Model
4. Taking in the View
5. Tying it Together

# Introduction

[`ActionText`](https://edgeguides.rubyonrails.org/action_text_overview.html) is a rich text editor packaged by default with Rails 6+. It was invented by/for Basecamp and uses the [Trix editor](https://trix-editor.org/).

1. Rails 6.0+
2. Webpack or other JS package compiler
3. Medium amounts of gumption

# Creating our Rich-Textified Model

1. Run `$ rails action_text:install`
2. Create our model: `$ rails g model essay title:string`
3. Scaffold our views: `$ rails g controller essays index new show edit`
4. Add our routes: `resources :essays`
5. Migrate: `$ rails db:migrate`

## Rich Text

Rich Text lives in a table called `action_text_rich_texts`, and has a polymorphic belongs-to (in essence) relationship with some other record.

There is no model here. Instead we join. A given model can have at most a single rich-text record associated with it.

## Our `Essay` Model

```ruby
class Essay < ApplicationRecord
  has_rich_text :essay_body
end
```

# Taking in the View

# Tying it Together
