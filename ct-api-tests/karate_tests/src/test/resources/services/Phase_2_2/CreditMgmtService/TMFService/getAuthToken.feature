@ignore @getAuthToken
Feature: get auth token using
	https://apigw-st.telus.com

Background:Configuration - Setup the authentication, Headers and params
		#Configure authentication
	* def credentials = read(PATH_CONFIG+'Auth_credit.json');
	* header Authorization = call read('classpath:files/basic-auth-encoding-fn.js') credentials.creditMgmt[1]
  
  
Scenario: get auth token
#Set endpoint url and print the same
  Given url ENDPOINT_CLIENT_CREDENTIAL
	* path '/st/token'
	* form field grant_type = 'client_credentials'
	* form field scope = '952'
	* method post
	* status 200	
	* def accessToken = response.access_token
	* def tokenType = response.token_type
	* print tokenType
	* def accessToken = response.access_token
	* print accessToken
	* def authToken = tokenType + ' ' + accessToken 
	 * def sleep = read('classpath:utils/Wait.js')
   * call sleep 3
    
	