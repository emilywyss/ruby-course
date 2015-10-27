class Student
  attr_accessor :name
  attr_accessor :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(who)
    if grade > who.grade
      puts "well done"
    else
      puts "sorry"
    end
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new('Joe',81)

bob = Student.new('Bob', 82)

joe.better_grade_than?(bob)