<?php
class Question{
  
    // database connection and table name
    private $conn;
    private $table_name = "Questions";
  
    // object properties
    public $id;
    public $variable_name;
    public $question_text;
    public $category_id;
    public $category_name;
    public $created;
  
    // constructor with $db as database connection
    public function __construct($db){
        $this->conn = $db;
    }

    // read questions
public function read(){
  
    // select all query
    $query = "SELECT
                cat.name as category_name, 
                quest.id,
                quest.variable_name,
                quest.question_text, 
                quest.category_id,
                quest.category_name,
                quest.created
            FROM
                " . $this->table_name . " quest
                LEFT JOIN
                    Categories cat
                        ON quest.category_id = cat.id
                ORDER BY
                    quest.created DESC";
  
    // prepare query statement
    $stmt = $this->conn->prepare($query);
  
    // execute query
    $stmt->execute();
  
    return $stmt;
}
 
// create question
public function create(){
  
    // query to insert record
    $query = "INSERT INTO
                " . $this->table_name . "
            SET
                variable_name =:variable_name, question_text=:question_text, category_id=:category_id, created=:created";
  
    // prepare query
    $stmt = $this->conn->prepare($query);
  
    // sanitize
    $this->variable_name=htmlspecialchars(strip_tags($this->variable_name));
    $this->question_text=htmlspecialchars(strip_tags($this->question_text));
    $this->category_id=htmlspecialchars(strip_tags($this->category_id));
    $this->created=htmlspecialchars(strip_tags($this->created));
  
    // bind values
    $stmt->bindParam(":variable_name", $this->variable_name);
    $stmt->bindParam(":question_text", $this->question_text);
    $stmt->bindParam(":category_id", $this->category_id);
    $stmt->bindParam(":created", $this->created);
  
    // execute query
    if($stmt->execute()){
        return true;
    }
  
    return false;
      
}
// used when filling up the update question form
function readOne(){
  
    // query to read single record
    $query = "SELECT
                cat.name as category_name, quest.id, quest.variable_name, quest.question_text, quest.category_id, quest.created
            FROM
                " . $this->table_name . " quest
                LEFT JOIN
                    categories cat
                        ON quest.category_id = cat.id
            WHERE
                quest.id = ?
            LIMIT
                0,1";
  
    // prepare query statement
    $stmt = $this->conn->prepare( $query );
  
    // bind id of product to be updated
    $stmt->bindParam(1, $this->id);
  
    // execute query
    $stmt->execute();
  
    // get retrieved row
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
  
    // set values to object properties
    $this->variable_name = $row['variable_name'];
    $this->question_text = $row['question_text'];
    $this->category_id = $row['category_id'];
    $this->category_name = $row['category_name'];
}
// update the question
public function update(){
  
    // update query
    $query = "UPDATE
                " . $this->table_name . "
            SET
                variable_name = :variable_name,
                question_text = :question_text,
                category_id = :category_id
            WHERE
                id = :id";
  
    // prepare query statement
    $stmt = $this->conn->prepare($query);
  
    // sanitize
    $this->variable_name=htmlspecialchars(strip_tags($this->variable_name));
    $this->question_text=htmlspecialchars(strip_tags($this->question_text));
    $this->category_id=htmlspecialchars(strip_tags($this->category_id));
    $this->id=htmlspecialchars(strip_tags($this->id));
  
    // bind new values
    $stmt->bindParam(':variable_name', $this->variable_name);
    $stmt->bindParam(':question_text', $this->question_text);
    $stmt->bindParam(':category_id', $this->category_id);
    $stmt->bindParam(':id', $this->id);
  
    // execute the query
    if($stmt->execute()){
        return true;
    }
  
    return false;
}

// delete the question
public function delete(){
  
    // delete query
    $query = "DELETE FROM " . $this->table_name . " WHERE id = ?";
  
    // prepare query
    $stmt = $this->conn->prepare($query);
  
    // sanitize
    $this->id=htmlspecialchars(strip_tags($this->id));
  
    // bind id of record to delete
    $stmt->bindParam(1, $this->id);
  
    // execute query
    if($stmt->execute()){
        return true;
    }
  
    return false;
}
// search questions
public function search($keywords){
  
    // select all query
    $query = "SELECT
                cat.name as category_name, quest.id, quest.variable_name, quest.question_text, quest.category_id, quest.created
            FROM
                " . $this->table_name . " quest
                LEFT JOIN
                    categories cat
                        ON quest.category_id = cat.id
            WHERE
                quest.variable_name LIKE ? OR p.question_text LIKE ? OR cat.name LIKE ?
            ORDER BY
                quest.created DESC";
  
    // prepare query statement
    $stmt = $this->conn->prepare($query);
  
    // sanitize
    $keywords=htmlspecialchars(strip_tags($keywords));
    $keywords = "%{$keywords}%";
  
    // bind
    $stmt->bindParam(1, $keywords);
    $stmt->bindParam(2, $keywords);
    $stmt->bindParam(3, $keywords);
  
    // execute query
    $stmt->execute();
  
    return $stmt;
}
// read products with pagination
public function readPaging($from_record_num, $records_per_page){
  
    // select query
    $query = "SELECT
                cat.name as category_name, quest.id, quest.variable_name, quest.question_text quest.category_id, quest.created
            FROM
                " . $this->table_name . " quest
                LEFT JOIN
                    categories cat
                        ON quest.category_id = cat.id
            ORDER BY quest.created DESC
            LIMIT ?, ?";
  
    // prepare query statement
    $stmt = $this->conn->prepare( $query );
  
    // bind variable values
    $stmt->bindParam(1, $from_record_num, PDO::PARAM_INT);
    $stmt->bindParam(2, $records_per_page, PDO::PARAM_INT);
  
    // execute query
    $stmt->execute();
  
    // return values from database
    return $stmt;
}
// used for paging products
public function count(){
    $query = "SELECT COUNT(*) as total_rows FROM " . $this->table_name . "";
  
    $stmt = $this->conn->prepare( $query );
    $stmt->execute();
    $row = $stmt->fetch(PDO::FETCH_ASSOC);
  
    return $row['total_rows'];
}
}
?>