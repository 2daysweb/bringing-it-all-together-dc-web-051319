require 'pry'
class Dog 
  
  attr_accessor :name, :breed 
  attr_reader :id 
  
    def initialize(id: nil, name: name, breed: breed)
      @id = id
      @name = name 
      @breed = breed 
    end 
  def self.create_table
   
    sql =  <<-SQL 
      CREATE TABLE IF NOT EXISTS dogs (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
        SQL
    DB[:conn].execute(sql) 
  end
  
  def self.drop_table
  sql = <<-SQL
    DROP TABLE IF EXISTS dogs 
           SQL
    DB[:conn].execute(sql)
  end 
  
  def save
    sql = <<-SQL
      INSERT INTO dogs(name, breed) VALUES (?, ?)
    SQL
    DB[:conn].execute(sql, self.name, self.breed)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    self
  end
  
  def self.create(name:, breed:)
    dog1 = Dog.new
    dog1.name = name 
    dog1.breed = breed 
    dog1.save 
    dog1 
  end 
  
end 