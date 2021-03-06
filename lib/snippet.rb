require './lib/mongodb'
require 'uv'

class Snippet
  class << self

    def all
      DB["snippets"].find.to_a
    end

    def find(id)
      DB["snippets"].find_one("_id" => BSON::ObjectId.from_string(id))
    end

    def create(params)
      language = params[:language] ||= "ruby"
      theme = params[:theme] ||= "twilight"
      snippet = { title: params[:title],
                  code: Uv.parse(params[:code], "xhtml", language , true, theme),
                  language: language,
                  theme: theme }
      DB["snippets"].insert(snippet).to_s
    end
    def delete(id)
      DB["snippets"].remove(:_id => BSON::ObjectId.from_string(id))
    end
  end # end of class methods
end