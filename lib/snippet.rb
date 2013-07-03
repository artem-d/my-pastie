require 'uv'
require 'mongo'

MONGO = Mongo::Connection.new('localhost', 27017).
               db('my_pastie')
               
class Snippet
  class << self

    def all
      MONGO["snippets"].find.to_a
    end

    def find(id)
      MONGO["snippets"].find_one("_id" => BSON::ObjectId.from_string(id))
    end

    def create(params)
      language = params[:language] ||= "ruby"
      theme = params[:theme] ||= "twilight"
      snippet = { title: params[:title],
                  code: Uv.parse(params[:code], "xhtml", language , true, theme),
                  language: language,
                  theme: theme }
      MONGO["snippets"].insert(snippet).to_s
    end
  end # end of class methods

end
