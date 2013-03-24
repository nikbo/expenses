require 'active_record'
require './lib/expense'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations["development"]
ActiveRecord::Base.establish_connection(development_configuration)


puts 'Hello!'

def prompt text
  puts text
  gets.chomp
end


def menu
  choice = nil
  until choice == 'e'
    puts "Press 'add' to add expense, press 'list' to list all expenses for all time
          press 'month' to list expenses for last month,
          press 'tag' to list all expenses of tag"
    choice = gets.chomp
    case choice
      when 'list'
        list_all
      when 'add'
        add
      when 'month'
        list_month
      when 'tag'
        list_tag
      when 'exit'
        exit
      else
        invalid
    end
  end
end

def add
  name = prompt 'Enter the name of your expense'
  cost = prompt 'Enter cost of this expense'
  tag =  prompt 'Enter tag of this expense'
  expense = Expense.new(:name => name, :cost => cost, :tag => tag)
  if expense.save
    puts "#{expense.name} has been saved!"
  else
    puts 'something went wrong'
  end
end


def list_all
  Expense.all.each do |expense|
    puts "#{expense.id.to_s}. #{expense.name.to_s} #{expense.cost.to_s}         #{expense.created_at.to_s}"
  end
end

def list_tag
  tag = prompt 'Enter the name of tag'
  tag_choice = Expense.where(:tag => tag)
  tag_choice.all.each do |expense|
    puts "#{expense.id.to_s}. #{expense.name.to_s} #{expense.cost.to_s}         #{expense.created_at.to_s}"
    end
end

def list_month
  m = prompt 'How many months back?'
  m=m.to_i
  month_choice = Expense.where("created_at < ?", m.month.ago)
  month_choice.all.each do |expense|
  puts "#{expense.id.to_s}. #{expense.name.to_s} #{expense.cost.to_s}         #{expense.created_at.to_s}"

  end
end

def invalid
  puts "Invalid value!"
end

menu