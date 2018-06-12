package org.beiyi.service.verify;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.FileUtils;

public class WechatSentencePatternUtil {
	private static final String IMGURL_REG = "(?i)<img\\s*src=\"(.*?)\"[^<]>";
	private static final String SENTENCE_INOUT_TAG_REG = "<[^>]+>";
	public static void main(String[] args) {
		try {
			String testSentence = FileUtils.readFileToString(new File(
					"D://test.txt"), Charset.forName("utf-8"));
			List<String> filterImgs = getImg(testSentence);
			for (String matchSenctence : filterImgs) {
				System.out.println(matchSenctence);
			}
			for (String matchSenctence : filterImgs) {
				testSentence = testSentence.replaceFirst(IMGURL_REG, matchSenctence);
			}
			String filterSentences = getSentenceInOrOutTheTag(testSentence);
			System.out.println(filterSentences);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/***
	 * 获取标签外or标签内的文字
	 * 
	 * @param HTML
	 * @return
	 */
	public static String getSentenceInOrOutTheTag(String html)  {
		 Pattern ptn = Pattern.compile(SENTENCE_INOUT_TAG_REG);
		 Matcher m_html = ptn.matcher(html);
		 String resultHtml = m_html.replaceAll("");
		 return resultHtml;
	}
	
	/***
	 * 获取ImageUrl地址
	 * 
	 * @param HTML
	 * @return
	 */
	public static List<String> getImg(String html)    
    {    
       List<String> list = new ArrayList<String>();    
       Pattern pa = Pattern.compile(IMGURL_REG);    
       Matcher ma = pa.matcher(html);    
       while (ma.find())    
       {  
        list.add(ma.group(1)); 
       }    
       return list;    
    }
}
