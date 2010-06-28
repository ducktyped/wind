class Post < Sequel::Model
  
  set_schema do
    primary_key :id
    varchar :title
    varchar :text
    datetime :date
    varchar :link
  end
  
  unless table_exists?
    create_table
    create(
      :title => 'Welcome!',
      :text => File.open('README.textile', 'r') { |file| file.read },
      :date => Time.now,
      :link => 'welcome'
    )
  end
  
  def self.ordered
    filter.order(:date.desc)
  end
  
  def self.search(q)
    value = "%#{q}%"
    filter(:title.like(value) | :text.like(value)).order(:date.desc)
  end
  
  def self.with_link(value)
    filter(:link => value).order(:date.desc)
  end
  
end