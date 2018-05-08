function IsDate(argDate) {
	date_split = argDate.split('/');
	//check for date parts
	if(date_split.length != 3) 
		return(false);
		
	//check for zero values
	for(i=0;i<date_split.length;i++) {
		if(parseInt(date_split[i],10) == 0) 
			return(false);
	}
	
	//check for 4-digit year
	if(date_split[2].length != 4) 
		return(false);

	//check for valid date, e.g. 29/02/1997
	tday = parseInt(date_split[0],10);
	tmonth = parseInt(date_split[1],10);
	tyear = parseInt(date_split[2]);
	var date = new Date(parseInt(date_split[2]),parseInt(date_split[1]-1),parseInt(date_split[0]));
	if(date.getDate() != tday) 
		return(false);

	if(date.getMonth() != (tmonth-1)) 
		return(false);
	
	if(date.getFullYear() != tyear) 
		return(false);
		
	//calculateage(tday,tmonth,tyear);
	return(true);
}
