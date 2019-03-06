function IsEmail(argEmail) {
	var lat=argEmail.indexOf('@')
	var lstr=argEmail.length
	var ldot=argEmail.indexOf('.')
	if (argEmail.indexOf('@')==-1) {
		return false
	}
	if (argEmail.indexOf('@')==-1 || argEmail.indexOf('@')==0 || argEmail.indexOf('@')==lstr) {
		return false
	}
	if (argEmail.indexOf('.')==-1 || argEmail.indexOf('.')==0 || argEmail.indexOf('.')==lstr) {
		return false
	}
	if (argEmail.indexOf('@',(lat+1))!=-1) {
		return false
	}
	if (argEmail.substring(lat-1,lat)=='.' || argEmail.substring(lat+1,lat+2)=='.') {
		return false
	}
	if (argEmail.indexOf('.',(lat+2))==-1) {
		return false
	}
	if (argEmail.indexOf(" ")!=-1) {
		return false
	}
	return true;
}
