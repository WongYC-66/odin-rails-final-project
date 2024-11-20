namespace :db do
  desc "Reset the schema without dropping the database"
  task reset_schema: :environment do
    ActiveRecord::Base.connection.execute("DROP SCHEMA public CASCADE;")
    ActiveRecord::Base.connection.execute("CREATE SCHEMA public;")
    Rake::Task["db:migrate"].invoke
  end
end
