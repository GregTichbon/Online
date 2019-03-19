<?php

$errors = array();
$data = "";
$success = "false";

function return_result($success,$errors,$data) {
    	echo $success;
}

function echo_errors($errors) {

	for($i=0;$i<count($errors);$i++) {
		?>
		<error><?=$errors[$i];?></error>
		<?
	}
}


switch($_REQUEST['action']) {

    case "uploaded":

    $file_temp = $_FILES['file']['tmp_name'];
    $file_name = $_FILES['file']['name'];

    $file_path = "uploaded";

    //checks for duplicate files
    //if(!file_exists($file_path."/".$file_name)) 
    if(true)
    {	
		
         //complete upload
         $filestatus = move_uploaded_file($file_temp,$file_path."/".$file_name);
	 $success = "true";	
         if (!$filestatus) { 
         $success = "false";
         array_push($errors,"Upload failed. Please try again.");
         }

    }
    else {
    $success = "false";
    array_push($errors,"File already exists on server.");
    }

    break;

    default:
    $success = "false";
    array_push($errors,"No action was requested.");

}

return_result($success,$errors,$data);

?>