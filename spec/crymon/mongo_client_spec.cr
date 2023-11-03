require "../spec_helper"

describe "Cryomongo" do
  it "=> initialize mongodb client" do
    # Create a Mongo client, using a standard mongodb connection string.
    client : Mongo::Client = Mongo::Client.new # defaults to: "mongodb://localhost:27017"

    # Get database and collection.
    database = client["database_name"]
    collection = database["collection_name"]

    # Perform crud operations.
    collection.insert_one({one: 1})
    collection.replace_one({one: 1}, {two: 2})
    bson = collection.find_one({two: 2})
    bson.not_nil!.["two"].should eq(2)
    collection.delete_one({two: 2})
    collection.count_documents.should eq(0)

    #
    # The overwhelming majority of programs should use a single client and should not bother with closing clients.
    # Otherwise, to free the underlying resources a client must be manually closed.
    client.close
  end
end