require "../spec_helper"

# https://github.com/elbywan/cryomongo
describe "Cryomongo" do
  it "=> initialize mongo client", tags: "mongo_client" do
    # Create a Mongo client.
    # uri : String = ENV["MONGODB_URI"]? || "mongodb://localhost:27017"
    client : Mongo::Client = Crymon::Globals.cache_mongo_client

    # Get database and collection.
    database_name = "test_database_name"
    database = client[database_name]
    collection_name = "test_collection_name"
    collection = database[collection_name]

    # Perform crud operations.
    collection.insert_one({one: 1})
    collection.replace_one({one: 1}, {two: 2})
    bson = collection.find_one({two: 2})
    bson.not_nil!.["two"].should eq(2)
    collection.count_documents.should eq(1)
    collection.delete_one({two: 2})
    collection.count_documents.should eq(0)
    # Delete database after test.
    Crymon::TestingTools.delete_test_db(database_name)

    # The overwhelming majority of programs should use a single client and should not bother with closing clients.
    # Otherwise, to free the underlying resources a client must be manually closed.
    client.close
  end
end
