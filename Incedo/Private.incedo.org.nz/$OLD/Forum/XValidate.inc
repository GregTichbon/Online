<script LANGUAGE="JAVASCRIPT">
function Validate() {
	if(document.InputForm.Topic.value == '') {
		alert("Name is a required field");
		return false;
	}
	if(document.InputForm.MESSAGE.value == '') {
		alert("Message is a required field");
		return false;
	}
}
</script>