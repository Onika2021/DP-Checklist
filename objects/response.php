<?php
class Response{
  
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
}
?>
  
