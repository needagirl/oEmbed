package purpleworks.oEmbed.codingTest;
import ac.simons.oembed.OembedEndpoint;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.util.List;


import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.core.io.ClassPathResource;

/**
 * 입력받은 url을 가지고 oEmbed에서 사용하는 url주소로 변경하기
 */
public class OembedConfig {
	private static String requestUrl;
	public URI OembedConfig(String url) throws IOException {
    	final OembedEndpoint endpoint = new OembedEndpoint();
    	SearchEndpoint(url);
    	setFormat();
		endpoint.setEndpoint(requestUrl);
		URI apiUrl = endpoint.toApiUrl(url);
		return apiUrl;
    }
    // poviders.json 파일에서 url 가져오기 
    final void SearchEndpoint(String url) throws IOException {
    	URL fullUrl = new URL(url);
    	String host = fullUrl.getHost();
    	List<String> urlList;
    	
    	JSONParser jsonParser = new JSONParser();
        ClassPathResource classPathResource = new ClassPathResource("providers.json");
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(classPathResource.getInputStream()));
       
        try {
            Object obj = jsonParser.parse(bufferedReader);
            JSONArray jArray = (JSONArray) obj;

            for (int i = 0; i < jArray.size(); i++) {
                JSONObject providers = (JSONObject) jArray.get(i);
                String endpoints = providers.get("endpoints").toString();

                Object endpoint = jsonParser.parse(endpoints);
                JSONArray jsonArray = (JSONArray) endpoint;
                JSONObject urlData = (JSONObject) jsonArray.get(0);

                String requestUrls = (String)urlData.get("url");
                if(urlData.get("schemes")!=null) {
	                String requestSchemes = urlData.get("schemes").toString();
                	if(requestSchemes.contains(host)) {
                		requestUrl = requestUrls;
                	}
                }
            	if(requestUrls.contains(host)) {
            		requestUrl = requestUrls;
            	}
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // format 형식 지정해주기
    final void setFormat()  {
    	if (requestUrl.contains("{format}")) {
    		requestUrl = requestUrl.replace("{format}", "json");
        }
    }
}