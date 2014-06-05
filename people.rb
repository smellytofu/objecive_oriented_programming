class Person
	attr_accessor :name

	def initialize=(str)
		@name = str
	end

	def greeting
		puts "Hi, my name is #{name}"
	end
end

class Student < Person
	def learn
		puts "I get it!"
	end
end

class Instructor < Person
	def teach
		puts "Everything in Ruby is an Object"
	end
end

chris = Instructor.new
chris.name = "Chris"
christina = Student.new
christina.name = "Christina"
chris.greeting
christina.greeting
chris.teach
christina.learn

# cannot call teach methon on Student nor learn method on Instructor because the methods are not contined in their classes