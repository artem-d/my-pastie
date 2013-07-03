require 'bundler/setup'
require 'sinatra'
require './lib/snippet'

get "/" do
  erb :index, locals: {snippets: Snippet.all}
end

post "/" do
  snippet = Snippet.find(Snippet.create(params))
  erb :show, locals: {snippet: snippet}
end

get "/new" do
  erb :new
end

get "/:id" do
  erb :show, locals: {snippet: Snippet.find(params[:id])} unless params[:id] == "favicon.ico"
end

