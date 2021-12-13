package purpleworks.oEmbed.codingTest;

import java.io.IOException;
import java.net.URI;

import org.apache.http.impl.client.DefaultHttpClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	
	@RequestMapping(value = "/")
	public String home() {
		return "home";
	}
	
	@RequestMapping(value="/checkUrl",produces ="application/text; charset=utf8")
	@ResponseBody
	public String checkUrl(String url) {
		OembedConfig oConfig = new OembedConfig();
		String data = "";
		try {
			URI requestUrl = oConfig.OembedConfig(url);
			OembedRequest oRequest = new OembedRequest();
			data = oRequest.OembedRequest(new DefaultHttpClient(), requestUrl);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return data;
	}
	
}
