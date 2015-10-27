module Towable
  def can_tow(pounds)
    pounds < 2000 ? true : false
  end
end

class Vehicle
  @@number_of_vehicles = 0

  attr_accessor :color
  attr_reader :year
  attr_reader :model

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} mph."
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} mph."
  end

  def current_speed
    puts "You are now going #{@current_speed} mph."
  end

  def shut_down
    @current_speed = 0
    puts "Let's park this bad boy!"
  end

  def self.gas_mileage(gallons,miles)
    puts "#{miles / gallons} miles per gallon of gas"
  end

  def spray_paint(c)
    self.color = c
    puts "car colour is now #{self.color}"
  end

  def view_color
    puts "Your current car colour is #{@color}"
  end

  def change_color(c)
    self.color = c
    puts "car colour is now #{self.color}"
  end

  def view_year
    puts "Car year is #{@year}"
  end

  def age
    "Your #{self.model} is #{years_old} years old"
  end

  private

  def years_old
    Time.now.year - self.year.to_i
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
  def to_s
    "My car is a #{self.color}, #{self.year}, #{@model}"
  end
end

class MyTruck < Vehicle
  include Towable
  NUMBER_OF_DOORS = 2
  def to_s
    "My truck is a #{self.color}, #{self.year}, #{@model}"
  end
end

lumina = MyCar.new(1997, 'chevy lumina', 'white')

lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.shut_down
lumina.current_speed
lumina.color = 'red'
puts lumina.color
puts lumina.year
lumina.spray_paint("black")
puts lumina.color

MyCar.gas_mileage(13,351)

ford = MyTruck.new(2002, 'ford tundra','orange')
MyTruck.gas_mileage(15,231)

puts lumina
puts ford
puts Vehicle.number_of_vehicles

puts ford.can_tow(400)

puts lumina.age