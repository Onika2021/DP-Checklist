<?php
// required headers
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: access");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Credentials: true");
header('Content-Type: application/json');
  
// include database and object files
include_once '../config/database.php';
include_once '../objects/question.php';
  
// get database connection
$database = new Database();
$db = $database->getConnection();
  
// prepare product object
$question = new Question($db);
  
// set ID property of record to read
$question->id = isset($_GET['id']) ? $_GET['id'] : die();
  
// read the details of product to be edited
$question->readOne();
  
if($question->variable_name != null){
    // create array
    $question_arr = array(
        "id" =>  $question->id,
        "variable_name" => $question->variable_name,
        "question_text" => $question->question_text,
        "category_id" => $question->category_id,
        "category_name" => $question->category_name
  
    );
  
    // set response code - 200 OK
    http_response_code(200);
  
    // make it json format
    echo json_encode($question_arr);
}
  
else{
    // set response code - 404 Not found
    http_response_code(404);
  
    // tell the user product does not exist
    echo json_encode(array("message" => "Question does not exist."));
}
?>
