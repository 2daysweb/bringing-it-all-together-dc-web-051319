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
  
  def id=(id)
    @id = id 
    return id 
  end 
  
  
  def self.new_from_db(row)
    new_dog = self.new(row[0], row[1], row[2]) 
    new_dog
  end 
  
    
  
  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    result = DB[:conn].execute(sql, id)[0][0]
    return result
  end 
end 