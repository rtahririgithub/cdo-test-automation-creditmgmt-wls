package com.telus.api.test.utils;

import java.util.Random;

import org.codehaus.groovy.ast.expr.ArgumentListExpression;

	
	import java.util.Arrays;
	import java.util.Random;
	import java.util.stream.Collectors;

	/**
	 * Helper class to create SINs
	 * @author Peter Newhook
	 *
	 */
	public class SinGenerator {
	    // generate a SIN following the Luhn Algorithm
	    public static String generateSin() {
	    	int[] originalDigits = new int[9];

	    	Random r = new Random();
	    	// fill initializing values, skipping the last value because that'll be the check
	    	for (int i = 0; i < originalDigits.length - 1; i++) {
	    		// don't allow the first digit to be 9 because that's a temp sin
	    		if (i == 0) {
					originalDigits[i] = r.nextInt(9);
				}else {
					originalDigits[i] = r.nextInt(10);
				}
			}
	    	int[] doubledDigits = originalDigits.clone();
	    	
	    	// double every other digit
	    	for (int i = 1; i < originalDigits.length; i+=2) {
				int currentValue = originalDigits[i];
				int doubled = currentValue * 2;
				
				doubledDigits[i] = doubled > 9 ? doubled - 9 : doubled;
			}
	    	
	    	int sum = Arrays.stream(doubledDigits).sum();
	    	
	    	int checkDigit = ((sum * 9) % 10);
	    	originalDigits[8] = checkDigit;
	    	return Arrays.stream(originalDigits).mapToObj(String::valueOf).collect(Collectors.joining());
	    }
	
	
		
	

}
