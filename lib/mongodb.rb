if ENV['RACK_ENV'] == 'production'
  db = URI.parse(ENV['MONGOHQ_URI'])
  db_name = db.path.gsub(/^\//,'')
  MONGO = Mongo::Connection.new(db.host, db.port).db(db_name)
  MONGO.authenticate(db.user, db.password) unless (db.user.nil? || db.user.nil?)
else
  MONGO = Mongo::Connection.new('localhost', 27017).
               db('my_pastie')
end