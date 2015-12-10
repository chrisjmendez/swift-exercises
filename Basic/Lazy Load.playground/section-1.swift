import UIKit

class DatabaseConnection{
    init(){
        println("New DB is up and running")
    }
    func execute(message:String){
        println("Execute: \(message)")
    }
}

//Encapsulate abstract access to persistent data
//Datastore will contain a DB connection but we only want to do 
//   that when absolutely necessary, otherwise it's expensive
class DataStore{
    lazy var connection = DatabaseConnection()
}

let ds = DataStore()
//The DB connection won't kick in until you absolutely need it.
ds.connection.execute("SELECT * FROM USERS")


