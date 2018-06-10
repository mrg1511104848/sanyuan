package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.atomic.AtomicInteger;

import org.apache.commons.collections4.ListUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.mongo.MongoUtil;
import org.skynet.frame.util.translate.ITranslate;
import org.skynet.frame.util.translate.impl.SougouTranslate;

import com.gargoylesoftware.htmlunit.javascript.host.dom.Node;
import com.mongodb.client.MongoCursor;

/**
 * micromedex 数据处理
 * 
 * @author 2bu
 *
 */
public class MicromedexDataDeal {
	private static org.apache.log4j.Logger logger = org.apache.log4j.Logger.getLogger(MicromedexDataDeal.class);
	static final String TRANSLATE_PATH = "D://爱客服/北医三院/数据/micromedex药品完整文档V4/";
	public static void main(String[] args) {
//		drugFullInfoDealV4();
		dealDrugFullDocFilenameByDbKeyVal();
//		writeToHtml();
//		test();
	}
	static final List<String> childCells = new ArrayList<String>();
	static final List<String> cells = new ArrayList<String>();
	static List<List<String>> allValues = new ArrayList<List<String>>();
	static{
		cells.add("药品英文名");
		cells.add("药品英文名(翻译)");
		cells.add("大类别");
		cells.add("大类别(翻译)");
		cells.add("FDA类型");
		cells.add("FDA类型(翻译)");
		cells.add("子标题");
		cells.add("子标题(翻译)");
		childCells.add("FDA Approval");
		childCells.add("FDA Approval(翻译)");
		childCells.add("Efficacy");
		childCells.add("Efficacy(翻译)");
		childCells.add("Recommendation");
		childCells.add("Recommendation(翻译)");
		childCells.add("Strength of Evidence");
		childCells.add("Strength of Evidence(翻译)");
		childCells.add("See Drug Consult reference");
		childCells.add("See Drug Consult reference(翻译)");
		cells.addAll(childCells);
	}
	static ExecutorService taskExecutors = Executors.newFixedThreadPool(10);
	private static void test(){
		File folder = new File("D://爱客服/北医三院/数据/micromedex药品完整文档V2");
		String[] folders= folder.list();
		List<String> folderDrugTitleList = new ArrayList<String>();
		for (int i = 0; i < folders.length; i++) {
			folderDrugTitleList.add(folders[i]);
		}
		List<String> mongoDrugTitleList = new ArrayList<String>();
		Map<String, Object> projection = new HashMap<String, Object>();
		projection.put("title", 1);
		MongoCursor<org.bson.Document> cursor = MongoUtil.iterator("micromedex_dreg_detail_contains_overrite",projection);
		while (cursor.hasNext()) {
			org.bson.Document doc = cursor.next();
			String title = doc.getString("title");
			String titleDeal = title.replaceAll("[\\s\\\\/:\\*\\?\\\"<>\\|]", " ")+".html";
			mongoDrugTitleList.add(titleDeal);
		}
		List<String> list = ListUtils.subtract(mongoDrugTitleList, folderDrugTitleList);
		for (String l : list) {
			System.out.println(l);
		}
	}
	private static void writeToHtml(){
//		final AtomicInteger validHtmlCount = new AtomicInteger(0); 
		Map<Integer, String> numFileNameMap = new HashMap<Integer, String>();
		int validHtmlCount = 0; 
		try {
			int i = 0;
			Map<String, Object> filterMap = new HashMap<String, Object>();
			filterMap.put("title", "CLONIDINE");
			
//			MongoCursor<org.bson.Document> micromedex_dreg_detail_itr = MongoUtil.iterator("micromedex_dreg_detail",filterMap,1,false);
			MongoCursor<org.bson.Document> micromedex_dreg_detail_itr = MongoUtil.iterator("micromedex_dreg_detail");
			
			while (micromedex_dreg_detail_itr.hasNext()) {
				System.out.println(i++);
				final org.bson.Document doc = micromedex_dreg_detail_itr.next();
//				taskExecutors.execute(new Runnable() {
//					@Override
//					public void run() {
						String fullDetailHtml = MongoUtil.getStringParsedValue(doc, "html");
						String title = doc.getString("title");
						
						if(Jsoup.parse(fullDetailHtml).select("strong").text().contains("This application has encountered an unexpected error. Please close your browser and restart")){
							System.out.println("INVALID - "+title);
						}
						if (StringUtils.isNotBlank(fullDetailHtml) &&!Jsoup.parse(fullDetailHtml).select("strong").text().contains("This application has encountered an unexpected error. Please close your browser and restart")) {
//							validHtmlCount.incrementAndGet();
							validHtmlCount++;
							try {
								String titleDeal = doc.getString("title").replaceAll("[\\s\\\\/:\\*\\?\\\"<>\\|]", " ");
								numFileNameMap.put(i, titleDeal);
								Map<String, Object> micromedex_dreg_detail_contains_overrite = new HashMap<String, Object>();
								micromedex_dreg_detail_contains_overrite.put("title", titleDeal);
								micromedex_dreg_detail_contains_overrite.put("html", fullDetailHtml);
								MongoUtil.saveDoc("micromedex_dreg_detail_contains_overrite",micromedex_dreg_detail_contains_overrite);
								FileUtils.writeStringToFile(new File("D://爱客服/北医三院/数据/micromedex药品完整文档V4/"+i+".html"), fullDetailHtml,Charset.forName("utf-8"));
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
//					}
//				});
			}
			Iterator<Entry<Integer, String>> itr = numFileNameMap.entrySet().iterator();
			while (itr.hasNext()) {
				Entry<Integer, String> entry = itr.next();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("key", entry.getKey());
				map.put("val", entry.getValue());
				MongoUtil.saveDoc("micromedex_dreg_detail_contains_overrite_key_val", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
//			taskExecutors.shutdown();
		}
		/*try {  
	      // 等待全部子线程执行完毕  
	      TimeUnit.SECONDS.sleep(5);  
	    } catch (InterruptedException e) {  
	      e.printStackTrace();  
	    }  */
		System.out.println("validCount : "+validHtmlCount);
	}
	
	private static void writeToHtmlByThreadPool(){
//		final AtomicInteger validHtmlCount = new AtomicInteger(0); 
		Map<Integer, String> numFileNameMap = new HashMap<Integer, String>();
		int validHtmlCount = 0; 
		try {
			int i = 0;
			Map<String, Object> filterMap = new HashMap<String, Object>();
			filterMap.put("title", "CLONIDINE");
			
			MongoCursor<org.bson.Document> micromedex_dreg_detail_itr = MongoUtil.iterator("micromedex_dreg_detail");
			final List<String> allTitles = new ArrayList<String>();
			
			while (micromedex_dreg_detail_itr.hasNext()) {
				System.out.println(i++);
				final org.bson.Document doc = micromedex_dreg_detail_itr.next();
//				taskExecutors.execute(new Runnable() {
//					@Override
//					public void run() {
						String fullDetailHtml = MongoUtil.getStringParsedValue(doc, "html");
						String title = doc.getString("title");
						
						if(Jsoup.parse(fullDetailHtml).select("strong").text().contains("This application has encountered an unexpected error. Please close your browser and restart")){
							System.out.println("INVALID - "+title);
						}
						if (StringUtils.isNotBlank(fullDetailHtml) &&!Jsoup.parse(fullDetailHtml).select("strong").text().contains("This application has encountered an unexpected error. Please close your browser and restart")) {
//							validHtmlCount.incrementAndGet();
							validHtmlCount++;
							try {
								String titleDeal = doc.getString("title").replaceAll("[\\s\\\\/:\\*\\?\\\"<>\\|]", " ");
								/*if(allTitles.contains(titleDeal)){
									titleDeal = titleDeal+"___exists";
									allTitles.add(titleDeal);
								}*/
								numFileNameMap.put(i, titleDeal);
								Map<String, Object> micromedex_dreg_detail_contains_overrite = new HashMap<String, Object>();
								micromedex_dreg_detail_contains_overrite.put("title", titleDeal);
								micromedex_dreg_detail_contains_overrite.put("html", fullDetailHtml);
								MongoUtil.saveDoc("micromedex_dreg_detail_contains_overrite",micromedex_dreg_detail_contains_overrite);
								FileUtils.writeStringToFile(new File("D://爱客服/北医三院/数据/micromedex药品完整文档V4/"+i+".html"), fullDetailHtml,Charset.forName("utf-8"));
							} catch (IOException e) {
								e.printStackTrace();
							}
						}
//					}
//				});
			}
			Iterator<Entry<Integer, String>> itr = numFileNameMap.entrySet().iterator();
			while (itr.hasNext()) {
				Entry<Integer, String> entry = itr.next();
				if(entry.getValue().equals("CLONIDINE")){
					System.out.println("HAS CLONIDINE!!!");
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
//			taskExecutors.shutdown();
		}
		/*try {  
	      // 等待全部子线程执行完毕  
	      TimeUnit.SECONDS.sleep(5);  
	    } catch (InterruptedException e) {  
	      e.printStackTrace();  
	    }  */
		System.out.println("validCount : "+validHtmlCount);
	}
	/**
	 * 药品完整文档处理
	 */
	private static void drugFullInfoDealV4() {
		Collection<File> files = FileUtils.listFiles(new File(
				TRANSLATE_PATH), null, false);
		int curr = 1;
		int total = files.size();
		for (File file : files) {
			/*if(!file.getName().equals("164.html")){
				continue;
			}*/
			System.out.println(curr+++"/\t"+total);
			try {
				String fileContent = FileUtils.readFileToString(file, "utf-8");
				Document doc = Jsoup.parse(fileContent);
				getFdaOrNonFdaUseSectionTextFlats(file.getName(), doc, "h4:matches(FDA Uses)~.sectionTextFlat");
			} catch (Exception e) {
				e.printStackTrace();
			}
//			break;
		}
		exportDrugFullInfoToXls();
	}
	/**
	 * 处理micro完整文档的文件名称by数据库存好的micromedex_dreg_detail_contains_overrite_key_val 的 key val
	 */
	private static void dealDrugFullDocFilenameByDbKeyVal(){
		Collection<File> files = FileUtils.listFiles(new File(
				TRANSLATE_PATH), null, false);
		for (File file : files) {
			String filename = file.getName().replace(".html", "");
			org.bson.Document drugFullDocNameDocument = MongoUtil.findOne("micromedex_dreg_detail_contains_overrite_key_val", "key", Integer.parseInt(filename));
			String standardDrugName = drugFullDocNameDocument.getString("val");
			try {
				String fileContent = FileUtils.readFileToString(file,Charset.forName("utf-8"));
				FileUtils.writeStringToFile(new File("D://爱客服/北医三院/数据/micromedex药品完整文档V4_标准名称版/"+filename+"_"+standardDrugName+".html"), fileContent,Charset.forName("utf-8"));
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	private static void getFdaOrNonFdaUseSectionTextFlats(String filename,Document doc ,String sectionSelector) {
		Elements sectionTextFlats = doc.select(sectionSelector);
		int limitLoop = 100;
		Map<String, List<String>> translateMap = new LinkedHashMap<String, List<String>>();
		for (Element fdaUseSectionTextFlat : sectionTextFlats) {
			int startLoop = 0;
			String fdaType = null;
			Element previousElementSibling = fdaUseSectionTextFlat.previousElementSibling();
			while (startLoop++<limitLoop) {
				Elements fdaOrNonFdaUseElements = previousElementSibling.select(".sectionTitleFlatModified");
				if(fdaOrNonFdaUseElements!=null && fdaOrNonFdaUseElements.size() > 0){
					fdaType = previousElementSibling.select(".sectionTitleFlatModified").text();
					break;
				}
				previousElementSibling = previousElementSibling.previousElementSibling();
			}
			if(fdaType == null) continue;
			String bigTypeName = fdaUseSectionTextFlat.select(">div>strong").text();
			String drugName = getDrugNameByFileName(filename);
			/*if(!medicineTitle.equalsIgnoreCase(drugName)){
				continue;
			}*/
			/*if(bigTypeName.equals("Animal bite")){ //TODO 这里有点问题，抓取不到
				System.out.println();
			}*/
			if(!fdaType.contains("FDA Uses")){
				continue;
			}
			Elements itemList = fdaUseSectionTextFlat.select(">.item_list>strong:contains(1\\))");//,>.para-list
			Elements paraList = fdaUseSectionTextFlat.select(">.para-list>strong:contains(1\\))");//
			
			boolean containsDrugConsultReference = fdaUseSectionTextFlat.select(".para-list").first()!=null&&fdaUseSectionTextFlat.select(".para-list").text().startsWith("See Drug Consult reference");
			if(containsDrugConsultReference){
				translateMap.put(bigTypeName+"@@"+fdaType+"@@"+bigTypeName, new ArrayList<String>(0));
			}else if(itemList.size()>0 || paraList.size()>0){
				findTranslateNodeV2(translateMap, bigTypeName, fdaType, bigTypeName, itemList.size()>0 ? itemList.first().parent() : paraList.first().parent());
			}else{
				Elements paraListElements = fdaUseSectionTextFlat.select(".para-list>strong");
				for (Element paraListEle : paraListElements) {
					String title = paraListEle.text();
					
//					System.out.println(fdaType+" title : "+title);
					Element paraListEleNextEleSibling = paraListEle.nextElementSibling();
					if(paraListEleNextEleSibling == null){
						continue;
					}
					startLoop = 0;
					while (startLoop++<limitLoop) {
						itemList = paraListEleNextEleSibling.select(".item_list,.para-list");
						if(itemList != null && itemList.size() > 0){
							findTranslateNodeV2(translateMap,bigTypeName,fdaType,title, itemList.first());
							break;
						}
						paraListEleNextEleSibling = paraListEleNextEleSibling.nextElementSibling();
						if(paraListEleNextEleSibling == null){
							break;
						}
					}
				}
			}
		}
		startTranslate(filename,translateMap);
	}
	private static void exportDrugFullInfoToXls() {
		ExcelUtil.export("D://爱客服/北医三院/数据/数据处理/micromedex药品完整文档翻译.xls", cells,allValues);
	}
	private static String getDrugNameByFileName(String filename){
		filename = filename.replace(".html", "");
		Map<String, Object> queryMap = new HashMap<String, Object>();
		queryMap.put("key", Integer.parseInt(filename.trim()));
		return MongoUtil.findOne("micromedex_dreg_detail_contains_overrite_key_val", queryMap).getString("val");
	}
	private static void startTranslate(String drugName,Map<String, List<String>> translateMap) {
		drugName = getDrugNameByFileName(drugName);
		if(translateMap.size()==0){
			logger.error(String.format("[drugName] %s's translateMap is blank", drugName));
			return;
		}
		ITranslate translate = new SougouTranslate();
		Iterator<Entry<String, List<String>>> translateMapItr = translateMap.entrySet().iterator();
		outter:
		while (translateMapItr.hasNext()) {
			List<String> values = new ArrayList<String>();
			Entry<String, List<String>> translateEntry = translateMapItr.next();
			String childFdaTypeAndTitle = translateEntry.getKey();
			String[] fdaTypeAndTitleArr = childFdaTypeAndTitle.split("@@");
			values.add(drugName);
			values.add(translate.translate(drugName,"sougou_translate"));
			values.add(fdaTypeAndTitleArr[0]);
			values.add(translate.translate(fdaTypeAndTitleArr[0],"sougou_translate"));
			values.add(fdaTypeAndTitleArr[1]);
			values.add(translate.translate(fdaTypeAndTitleArr[1],"sougou_translate"));
			values.add(fdaTypeAndTitleArr[2]);
			values.add(translate.translate(fdaTypeAndTitleArr[2],"sougou_translate"));
			List<String> needTranslateList = translateEntry.getValue();
			if(needTranslateList.size() > 0){
				for (int i = 0; i < childCells.size()/2; i++) {
					try {
						final String title = childCells.get(i*2);
						final String translateStr = needTranslateList.get(i).replace(title+":", "").trim();
						final String translateResult = translate.startTranslate(translateStr);
						values.add(translateStr);
						values.add(translateResult);
					} catch (Exception e) {
						logger.error("Error while translate the [drugName] "+drugName,e);
						return;
					}
				}
			}
			allValues.add(values);
		}
		
	}

	private static void findTranslateNodeV2(Map<String, List<String>> translateMap,String bigTypeName,String fdaType,String title, Element itmNode) {
		int loopLimit = 100;
		int loopStart = 0;
//		Elements listItems = itmNode.select("strong~.listitems");
		/*if(title.equals("Alzheimer's disease; Treatment and Prophylaxis")){
			System.out.println();
		}*/
		Element strongElement = itmNode.select("strong").first();
		List<String> translateStrList = new ArrayList<String>();
		if(strongElement!=null){
			Element strongNextSibling = strongElement.nextElementSibling();
			while (loopStart++<loopLimit) {
				if(strongNextSibling == null || strongNextSibling.tagName().equals("strong")){
					break;
				}
				if(strongNextSibling.attr("class").equals("listitems")){
					translateStrList.add(strongNextSibling.text());
				}
				strongNextSibling = strongNextSibling.nextElementSibling();
			}
		}
		translateMap.put(bigTypeName+"@@"+fdaType+"@@"+title, translateStrList);
	}
}
