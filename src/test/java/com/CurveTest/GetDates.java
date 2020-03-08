package com.CurveTest;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;


public class GetDates {
	static String todaysDate;
	static String sevenDaysAgo;
	
	public static void getDate() {
		DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
	    todaysDate = (dateFormat.format(date));
		long t = date.getTime(  ); 
	    t -= 6000*24*60*60; 
	    Date then = new Date(t); 
	    sevenDaysAgo = (dateFormat.format(then));
	}
	
	public static void initialSetup() {
		getDate();
	}
	public static String getTodaysDate() {
		return todaysDate;
	}

	public static String get7DaysAgoDate() {
		return sevenDaysAgo;
	}
}
