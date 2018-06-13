package org.beiyi.datadeal;

import java.io.File;
import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import org.apache.commons.collections4.ListUtils;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.skynet.frame.util.RegexUtils;

public class SFDADrugSupplement {
	private static Logger log = Logger.getLogger(SFDADrugSupplement.class);
	public static void main(String[] args) throws IOException {
		List<String> allList = FileUtils.readLines(new File("C://公司/北医三院/sfda校验集.txt"),Charset.forName("utf-8"));
		
		List<String> drugfutureDeal = FileUtils.readLines(new File("C://公司/北医三院/drugfutureDeal.json"),Charset.forName("utf-8"));
		List<String> aList = new ArrayList<String>();
		List<SFDADrug>  drugs = new ArrayList<SFDADrugSupplement.SFDADrug>();
		for (String drugEach : allList) {
			String drugEachMainInfo = RegexUtils.getByGroup("[\\(（](.+)[\\)）]", drugEach,1).get(0);
			String[] mainInfoArr = drugEachMainInfo.split(" ");
			SFDADrug drug = new SFDADrug();
			String benWeiMaIds = mainInfoArr[0];
			String[] benWeiMaArr = benWeiMaIds.split("；|;");/**/
			
			for (String benWeiMa : benWeiMaArr) {
				if(StringUtils.isNotBlank(benWeiMa))
					drug.getBenWeiMaIds().add(benWeiMa);
			}
			if(drug.getBenWeiMaIds().size()==0){
				log.warn(String.format("[drug] %s benWeiMaArr.length==0", drugEach));
			}
			/*if(mainInfoArr.length<=2){
				log.warn(String.format("[drug] %s mainInfoArr.length<=2", drugEach));
			}else{
				drug.setGyzz(mainInfoArr[2]);
			}*/
			int lastIdx = drugEach.lastIndexOf("国药");
			String gy = StringUtils.substring(drugEach, lastIdx, drugEach.length()-1);
			if(StringUtils.isBlank(gy)){
				log.warn(String.format("[drug] %s StringUtils.isBlank(gy)", drugEach));
				continue;
			}
			drug.setGyzz(gy);
			aList.add(gy);
			drugs.add(drug);
		}
		System.out.println(aList.size());
		System.out.println(drugs.size());
		System.out.println();
		
		List<String> bList = new ArrayList<String>();
		for (String drugfutureJson : drugfutureDeal) {
			JSONObject drugfutureJsonObj = JSONObject.fromObject(drugfutureJson);
			String benWeiMa = drugfutureJsonObj.getString("benWeiMa");
			String piZhunWenHao = drugfutureJsonObj.getString("piZhunWenHao");
			List<String> benWeiMaIds = new ArrayList<String>();
			benWeiMaIds.add(benWeiMa);
			
			/*if(!gyzzList.contains(piZhunWenHao)){
				log.error(String.format("[drug] %s not exists", drug));
			}*/
			bList.add(piZhunWenHao);
		}
		List<String> guoYaoSubList = ListUtils.subtract(aList, bList);
		System.out.println("guoYaoSubList.size()"+guoYaoSubList.size());
		FileUtils.writeLines(new File("C://guoYaoSubList.txt"), guoYaoSubList);
	}
	public static List<String> getIntersection(List<String> list1,
            List<String> list2) {
        List<String> result = new ArrayList<String>();
        for (String l2 : list2) {//遍历list1
            if (list1.contains(l2)) {//如果存在这个数
                result.add(l2);//放进一个list里面，这个list就是交集
            }
        }
        return result;
    }
	static class SFDADrug{
		private List<String> benWeiMaIds = new ArrayList<String>();
		private String gyzz;
		
		public SFDADrug() {
			super();
		}

		public String getGyzz() {
			return gyzz;
		}

		public void setGyzz(String gyzz) {
			this.gyzz = gyzz;
		}

		public List<String> getBenWeiMaIds() {
			return benWeiMaIds;
		}

		public void setBenWeiMaIds(List<String> benWeiMaIds) {
			this.benWeiMaIds = benWeiMaIds;
		}
		
	}
}
