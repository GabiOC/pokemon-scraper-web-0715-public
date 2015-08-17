class Pokemon
  attr_accessor :id, :name, :type, :hp

  def initialize(id, name, type, hp, db)
    @id = id
    @name = name
    @type = type
    @hp = hp
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?
    SQL
    row = db.execute(sql,id)

    p = Pokemon.new(*row.first, db)
  end

  def alter_hp(new_hp)
    sql = <<-SQL
      UPDATE pokemon
      SET hp = ?
      WHERE id = ?
    SQL

    @db.execute(sql, new_hp, self.id)
  end
end
