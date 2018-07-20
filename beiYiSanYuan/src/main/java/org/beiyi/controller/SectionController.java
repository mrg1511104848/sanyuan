package org.beiyi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.beiyi.entity.db.PrescriptionVerifyRecord;
import org.beiyi.entity.db.Section;
import org.beiyi.service.db.itr.ISectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

@Controller
@RequestMapping("/section")
public class SectionController {
	@Autowired
	ISectionService sectionService;
	@RequestMapping("/toSectionList.htm")
	public ModelAndView toSectionList(String prescriptionVerifyRecordId) {
		ModelAndView modelAndView = new ModelAndView("html/ajax/section-list");
		return modelAndView;
	}
	
	@RequestMapping("/sectionList.htm")
	public ModelAndView sectionList(String prescriptionVerifyRecordId) {
		ModelAndView modelAndView = new ModelAndView("html/ajax/section-list");
		return modelAndView;
	}
	
	@RequestMapping("/toSectionDialog.htm")
	public ModelAndView toSectionDialog() {
		ModelAndView modelAndView = new ModelAndView("html/ajax/section-list");
		return modelAndView;
	}
	@RequestMapping(value="/getSectionPageList.htm")
	@ResponseBody
    public Map<Object, Object> getSectionPageList(HttpServletResponse response, HttpServletRequest request,@RequestParam Map<String, Object> params){
        try {
//            User currentUser = (User)request.getSession().getAttribute("currentUser");''
//            if(currentUser.getIsAdmin()==null||currentUser.getIsAdmin()!=1){
//                params.put("eq_userId", currentUser.getId());
//            }
        	int length = Integer.parseInt(params.get("iDisplayLength").toString());
        	int start = Integer.parseInt(params.get("iDisplayStart").toString())/length+1;
        	Page page = PageHelper.startPage(start, length, true);
        	List<Section> list = sectionService.getPagedList(params);
        	Map<Object, Object> object = new HashMap<Object, Object>();
            object.put("iTotalRecords", page.getTotal());
            object.put("iTotalDisplayRecords", page.getTotal());
            object.put("aaData", list);
            return object;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
	@RequestMapping(value="/save.htm")
	@ResponseBody
    public Map<Object, Object> save(HttpServletResponse response, HttpServletRequest request,Section section){
		boolean success = true;
    	try {
			sectionService.save(section);
		} catch (Exception e) {
			e.printStackTrace();
			success = false;
		}
    	Map<Object, Object> object = new HashMap<Object, Object>();
        object.put("success", success);
        return object;
    }
}
