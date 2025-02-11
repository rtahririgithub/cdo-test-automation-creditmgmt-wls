package com.telus.api.test.utils;

import java.util.Random;

public 	class GenerateRandom_Number {
		
		
	
		public static String getRandom15digitNumber() {
			Random random = new Random();

			int num1, num2,num5;

			num1 = random.nextInt(900) + 100;
			num2 = random.nextInt(643) + 100;
			//num3 = random.nextInt(9000) + 100;
			//num4 = random.nextInt(900) + 100;
			num5 = random.nextInt(10) + 10;

			String serialNumber = ""+num1 + num2 +num5 ;
		
			return serialNumber;
		}


		
		public static int getRandom4digitNumber() {
			Random random = new Random();

			int  num1,num2;
            num1 = random.nextInt(3)+10;
			num2 = random.nextInt(1) + 10;

			String serialNumber = "" + num1 +num2 ;
			
		int getRandom4digitNumber = Integer.parseInt(serialNumber);
			return getRandom4digitNumber;
		}

		public static int getRandom6digitNumber() {
			Random random = new Random();

			int num1, num2;
             num1 = random.nextInt(30) + 100;
			num2 = random.nextInt(10) + 100;

			String serialNumber = ""+ + num1 +num2 ;
			int getRandom6digitNumber = Integer.parseInt(serialNumber);
			return getRandom6digitNumber;
			
		}
		
		public static int getRandom8digitNumber() {
			Random random = new Random();

			int num1, num2;
             num1 = random.nextInt(300) + 1000;
			num2 = random.nextInt(100) + 1000;

			String serialNumber = ""+ + num1 +num2 ;
			int getRandom8digitNumber = Integer.parseInt(serialNumber);
			return getRandom8digitNumber;
			
			
		}
		public static int getRandom9digitNumber() {
			Random random = new Random();

			int num1, num2, num3;
             num1 = random.nextInt(300) + 100;
			num2 = random.nextInt(100) + 1000;
			num3= random.nextInt(10) + 10;

			String serialNumber = ""+ + num1 +num2+num3 ;
			int getRandom8digitNumber = Integer.parseInt(serialNumber);
			return getRandom8digitNumber;
			
			
		}
		public static int getRandom10digitNumber() {
			Random random = new Random();

			int num1, num2, num3;
             num1 = random.nextInt(300) + 1000;
			num2 = random.nextInt(100) + 1000;
			num3= random.nextInt(10) + 10;

			String serialNumber = ""+ + num1 +num2+num3 ;
			int getRandom8digitNumber = Integer.parseInt(serialNumber);
			return getRandom8digitNumber;
			
			
		}
		
	
		
}