function(dbName) {
	
	var dbAuth = karate.read('classpath:dbAuth.json');
			
	switch(dbName.toLowerCase()){	
		case 'it01':
			return dbAuth.IT01; 
			break;
		case 'it02':
			return dbAuth.IT02; 
			break;
		case 'it03':
			return dbAuth.IT03;
		case 'it04':
			return dbAuth.IT04;
		case 'dv':
			return dbAuth.DV;
			break;
		default: return "Invalid DB Name: " + dbName;	 
		
	}	

}