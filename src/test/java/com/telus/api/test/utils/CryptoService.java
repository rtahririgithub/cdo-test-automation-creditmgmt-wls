package com.telus.api.test.utils;

import java.nio.charset.StandardCharsets;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Assert;

import com.telus.framework.crypto.Crypto;
import com.telus.framework.crypto.EncryptionUtil;
import com.telus.framework.crypto.impl.jce.IvParamSpecGenerator;
import com.telus.framework.crypto.impl.jce.JceCryptoImpl;
import com.telus.framework.crypto.impl.pilot.PilotCryptoImpl;


public class CryptoService {
	
	private static final Logger logger = LoggerFactory.getLogger(CryptoService.class);
	 public static  Crypto pilotCrypto() {

		    PilotCryptoImpl pilotCrypto = new PilotCryptoImpl();
		    pilotCrypto.setKey1("EbT5a8Fuq");
		    pilotCrypto.setKey2("aYt2gv6R");
		    pilotCrypto.setKey3("9bFp3Gz4k");
		    pilotCrypto.init();
		    return pilotCrypto;
		  }
	 
	public static  JceCryptoImpl  test_EncrypDecryp() throws Exception{

           EncryptionUtil.setCrypto(pilotCrypto());
        	      
        	    String userDirectory = System.getProperty("user.dir");
       		   String filepath=userDirectory+"\\src\\test\\resources\\CDA_KEYSTORE_NonProd.jks";
       		   
       		   
                        JceCryptoImpl bean = new JceCryptoImpl();                        

                        bean.setAlgorithmParamSpecGenerator(new IvParamSpecGenerator(Boolean.TRUE));

                        bean.setEncodeBase64(Boolean.TRUE);

                        bean.setKeyAlias(EncryptionUtil.decryptHex("262372"));                                                  

                        bean.setKeyPassword(EncryptionUtil.decryptHex("20582e2645666529"));

                        bean.setKeystoreURL("file:///"+filepath);
                        
                        bean.init();                   
                        return bean;
                       


}
	


		  
			  public  String decrypt(String data) throws Exception  {
					
				  
				  CryptoService.test_EncrypDecryp();
				  byte[] decCrryptedData = CryptoService.test_EncrypDecryp().decrypt(data.getBytes()); 
	             Assert.isTrue(StringUtils.isNotBlank(data), "Invalid input data=" + data);
	             logger.info("Decrypted word : " + new String(decCrryptedData));
	             System.out.println(new String(decCrryptedData));
	             return new String(decCrryptedData);
			  }
			  
		  
		  
		  
		  public  String encrypt(String data) throws Exception {
			    CryptoService.test_EncrypDecryp();
			    
			    byte[] ecnryptedData = CryptoService.test_EncrypDecryp().encrypt(data.getBytes(StandardCharsets.UTF_8));
			    Assert.isTrue(StringUtils.isNotBlank(data), "Invalid input data=" + data);
			    logger.info("ecnryptedData : " + new String(ecnryptedData));
			    return new String(ecnryptedData);
			  }
		 


}
