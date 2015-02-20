require 'sinatra'
require 'pry'
require 'csv'

# def get_articles
#   articles = []
#   CSV.foreach('articles.csv', headers: true, header_converters: :symbol) do |row|
#     articles << row.to_hash
#   end
#   articles
#   binding.pry
# end

def duplicate?(url_param)
  CSV.foreach('articles.csv', headers: true, header_converters: :symbol) do |row|
    if row.include?(url_param)
      return true
    end
  end
  false
end

binding.pry

duplicate?('google.com')

get '/articles' do
  rows = []
  news = CSV.read("./articles.csv")
  news.each do |row|
    rows << row
  end
  erb :index, locals: { rows: rows }
end

get '/articles/new' do
  erb :new
end

post '/articles' do

  title = params["title"]
  url = params["url"]
  description = params["description"]

  if duplicate?(url) == true
    puts "dupe"
  else
    CSV.open('./articles.csv','a') do |csv|
      csv << [title,url,description]
    end
  break
  end
  redirect '/articles'
end
