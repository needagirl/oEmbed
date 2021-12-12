package purpleworks.oEmbed.codingTest;

import java.io.IOException;
import java.net.URI;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import ac.simons.oembed.OembedEndpoint;
import ac.simons.oembed.OembedResponse;
import ac.simons.oembed.OembedResponse.Format;
import ac.simons.oembed.OembedService;

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
	
	@RequestMapping(value="/checkUrl")
	@ResponseBody
	public String checkUrl(String url) {
//		String url = "https://www.youtube.com/watch?v=dBD54EZIrZo";
//		String url = "https://www.instagram.com/p/BUawPlPF_Rx/";
//		String url = "https://twitter.com/hellopolicy/status/867177144815804416";
//		String url = "https://vimeo.com/20097015";
		OembedConfig oConfig = new OembedConfig();
		String data = "";
		try {
			URI requestUrl = oConfig.OembedConfig(url);
			System.out.println(requestUrl);
			OembedRequest oRequest = new OembedRequest();
			data = oRequest.OembedRequest(new DefaultHttpClient(), requestUrl);
			System.out.println(data);
		} catch (IOException e) {
			e.printStackTrace();
		}

		return data;
	}
	
}
