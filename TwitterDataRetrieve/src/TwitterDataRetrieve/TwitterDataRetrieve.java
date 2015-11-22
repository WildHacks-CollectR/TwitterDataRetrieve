package TwitterDataRetrieve;

import java.util.List;

import twitter4j.Status;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.conf.ConfigurationBuilder;

public class TwitterDataRetrieve{
	
	public static void main(String[] args) throws TwitterException{
		ConfigurationBuilder config = new ConfigurationBuilder();
		
		config.setDebugEnabled(true).setOAuthConsumerKey("BUd15ex2Prked85kXw3k0wiAv")
								.setOAuthConsumerSecret("EmNFDMVFFYgqWjPLv9sFLnhM5KMukHRprFWncBhwCQC1C1ORFx")
								.setOAuthAccessToken("3170149175-tYTUFFDw4vSAIdtnYXGxUHFFHLMAXyXDA3wfnnR") 
								.setOAuthAccessTokenSecret("jtN6a2KGMQXA13LXOjP5fN7ePP89jTFK2Ex3sMhilCvBQ"); 
	
		TwitterFactory twitterfactory = new TwitterFactory(config.build()); 
		twitter4j.Twitter twitter = twitterfactory.getInstance(); 
		
		List<Status> status = twitter.getHomeTimeline(); 
		for(Status st : status)
		{
			
			System.out.println(st.getUser().getLocation() + " " + st.getUser().getName()+ "  " + st.getText()); 
		} 
		
	
	}	
}