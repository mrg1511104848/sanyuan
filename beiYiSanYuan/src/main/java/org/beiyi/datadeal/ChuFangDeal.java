package org.beiyi.datadeal;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.lang3.StringUtils;
import org.beiyi.util.PrescriptionReadUtil;
import org.skynet.frame.util.ListUtil;
import org.skynet.frame.util.excel.ExcelUtil;
import org.skynet.frame.util.map.MapUtil;


public class ChuFangDeal {
	
	public static void main(String[] args) {
		dealChuFangPart1();
	}
	/**
	 * 将1对1与1处方分开导出为易读的格式，并统计对应频率
	 */
	public static void dealChuFangPart1(){
		List<String> cells = new ArrayList<String>();
		cells.add("药品名称");
		cells.add("处方频率");
		List<List<String>> values = new ArrayList<List<String>>();
		Map<String, Map<String, Integer>> drugAndShiYingZheng = new HashMap<String, Map<String,Integer>>();
		List<List<String>> chufangRecords = PrescriptionReadUtil.getRecords();
		for (int i = 1; i < chufangRecords.size(); i++) {
			List<String> rI = chufangRecords.get(i);
			String shiYingZhengI = rI.get(16);
			String drugI = rI.get(21);
			String[] shiYingZhengArr = shiYingZhengI.split(";|,|，|、|  ");
			int shiYingZhengValidCount = 0;
			for (String syz : shiYingZhengArr) {
				if(StringUtils.isNotBlank(syz)){
					shiYingZhengValidCount++;
				}
			}
			shiYingZhengI = shiYingZhengI.replace(";", "").trim();
			if(StringUtils.isNotBlank(shiYingZhengI) && shiYingZhengValidCount == 1){
				System.out.println(String.format("[row] %s [shiyingzheng] %s [drug] %s", i,shiYingZhengI,drugI));
				Map<String, Integer> shiYingZhengMap = drugAndShiYingZheng.get(drugI);
				if(shiYingZhengMap == null){
					shiYingZhengMap = new HashMap<String, Integer>();
					shiYingZhengMap.put(shiYingZhengI, 1);
				}else{
					Integer shiYingZhengCount = shiYingZhengMap.get(shiYingZhengI);
					if(shiYingZhengCount == null){
						shiYingZhengCount = 0;
					}
					shiYingZhengMap.put(shiYingZhengI, shiYingZhengCount+1);
				}
				drugAndShiYingZheng.put(drugI, shiYingZhengMap);
			}
		}
		Iterator<Entry<String, Map<String, Integer>>> itr = drugAndShiYingZheng.entrySet().iterator();
		while (itr.hasNext()) {
			List<String> subValues = new ArrayList<String>();
			Entry<String, Map<String, Integer>> entry = itr.next();
			String drugName = entry.getKey();
//			subValues.add(drugName);
			Map<String, Integer> shiYingZheng = entry.getValue();
			shiYingZheng = MapUtil.sortMapByValue(shiYingZheng,false);
			Iterator<Entry<String, Integer>> shiyingzhengItr  = shiYingZheng.entrySet().iterator();
			while (shiyingzhengItr.hasNext()) {
				Entry<String, Integer> shiyingzhengEntry = shiyingzhengItr.next();
				String shiYingZhengName = shiyingzhengEntry.getKey();
				Integer shiYingZhengCount = shiyingzhengEntry.getValue();
//				subValueSB.append(shiYingZhengName+" : "+shiYingZhengCount + " | ");
				subValues.add(shiYingZhengName);
				subValues.add(shiYingZhengCount==null? "0" : shiYingZhengCount.toString());
			}
			List<List<String>> subValuesSplit = ListUtil.splitSimpleList(subValues, 16);
			for (List<String> subValuesEach : subValuesSplit) {
				subValuesEach.add(0, drugName);
				values.add(subValuesEach);
			}
			
			/*subValues.add(subValueSB.toString());
			if(subValues.size()>20){
				System.out.println();
			}
			*/
		}
		ExcelUtil.export("D://爱客服/北医三院/数据/数据处理/1对1处方对应频率.xls", cells, values);
//		System.out.println(drugAndShiYingZheng);
	}
}
