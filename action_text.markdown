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
  has_rich_text :body
end
```

# Taking in the View

What's the fun of ActionText if we can't interact with it. We'll start with our `new`, `create`, `index`, and `show` actions.

## Index View

```ruby
def index
  @essays = Essay.all
end
```

```erb
<h1>Essays</h1>
<p><%= link_to "New Essay", new_essay_path %></p>
<ul>
  <% @essays.each do |essay| %>
    <li><%= link_to essay.title, essay_path(essay) %></li>
  <% end %>
</ul>
```

## New View

```ruby
def new
  @essay = Essay.new
end
```

```erb
<h1>New Essay</h1>
<%= form_with model: @essay do |f| %>
  <%= f.text_field :title %>
  <%= f.rich_text_area :body %>
  <%= f.submit %>
<% end %>
```

## New View

![inline](action_text_images/02.png)

## New View

![inline](action_text_images/03.png)

## Create Action

```ruby
  def create
    @essay = Essay.new(essay_params)
    if @essay.save
      redirect_to essays_path
    else
      render "new"
    end
  end

  private

  def essay_params
    params.require(:essay).permit(:title, :body)
  end
```

## Show Action

```ruby
def show
  @essay = Essay.find(params[:id])
end
```

```erb
<h1><%= @essay.title %></h1>

<%= @essay.body %>
```

## Show Action

![inline](action_text_images/04.png)

## Show Action

![inline](action_text_images/05.png)

# Tying it Together

When we create an Essay record through our form, our form body is submitted as an HTML string.

This creates a record in our rich-texts table, which in turn has as foreign key pointing out our Essay record.

# Tying it Together

When we fetch our Essay record and call `#body` on it, we fetch the associated rich text record. This in turn has a `body` attribute (no connection) which stores the serialized HTML.

# Extensions

1. Style the resulting HTML so it is more presentable
2. Style the input form as needed
3. Use `ActiveStorage` to allow for image/media uploads
4. Examine other rich text editors (e.g. Slate) and compare/contrast
