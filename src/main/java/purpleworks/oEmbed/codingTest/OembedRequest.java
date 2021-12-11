package purpleworks.oEmbed.codingTest;

import java.io.IOException;
import java.net.URI;

import org.apache.http.HttpResponse;
import org.apache.http.ParseException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.util.EntityUtils;

public class OembedRequest {
	private HttpClient httpClient;
	public String OembedRequest(final HttpClient httpClient, final URI url) {
		this.httpClient = httpClient;
		String result = "";
		try {
		final HttpResponse httpResponse = this.httpClient.execute(new HttpGet(url));
		result = EntityUtils.toString(httpResponse.getEntity(), "UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
