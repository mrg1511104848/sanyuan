package org.beiyi.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.beiyi.entity.db.Section;
import org.beiyi.service.db.itr.ISectionService;
import org.beiyi.service.db.itr.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;

@Controller
@RequestMapping("/apothecary")
public class ApothecaryController {
	@Autowired
	IUserService userService;
	@Autowired
	ISectionService sectionService;
	
	@RequestMapping("/toApothecaryList.htm")
	public ModelAndView toApothecaryList() {
		ModelAndView modelAndView = new ModelAndView("html/ajax/apothecary-list");
		return modelAndView;
	}
	@RequestMapping(value="/getApothecaryPageList.htm")
	@ResponseBody
    public Map<Object, Object> getApothecaryPageList(HttpServletResponse response, HttpServletRequest request,@RequestParam Map<String, Object> params){
        try {
//            User currentUser = (User)request.getSession().getAttribute("currentUser");''
//            if(currentUser.getIsAdmin()==null||currentUser.getIsAdmin()!=1){
//                params.put("eq_userId", currentUser.getId());
//            }
        	int length = Integer.parseInt(params.get("iDisplayLength").toString());
        	int start = Integer.parseInt(params.get("iDisplayStart").toString())/length+1;
        	Page page = PageHelper.startPage(start, length, true);
        	List<org.beiyi.entity.db.pageBean.UserSection> list = userService.getPagedList(params);
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
	
	
	@RequestMapping("/edit.htm")
	public ModelAndView edit(String id) {
		ModelAndView modelAndView = new ModelAndView("html/ajax/modal-content/apothecary-edit");
		
		org.beiyi.entity.db.pageBean.UserSection userSection = userService.getUserSection(id);
		modelAndView.addObject("userSection", userSection);
		
		List<Section> sectionList = sectionService.getPagedList(null);
		modelAndView.addObject("sectionList", sectionList);
		return modelAndView;
	}
	@RequestMapping(value="/saveUserSection.htm")
	@ResponseBody
    public Map<Object, Object> saveUserSection(HttpServletResponse response, HttpServletRequest request,org.beiyi.entity.db.pageBean.UserSection userSection){
		boolean success = true;
    	try {
    		userService.save(userSection);
		} catch (Exception e) {
			e.printStackTrace();
			success = false;
		}
    	Map<Object, Object> object = new HashMap<Object, Object>();
        object.put("success", success);
        return object;
    }
	@RequestMapping(value="/save.htm")
	@ResponseBody
    public Map<Object, Object> save(HttpServletResponse response, HttpServletRequest request,org.beiyi.entity.db.pageBean.UserSection userSection){
		boolean success = true;
    	try {
    		userService.save(userSection);
		} catch (Exception e) {
			e.printStackTrace();
			success = false;
		}
    	Map<Object, Object> object = new HashMap<Object, Object>();
        object.put("success", success);
        return object;
    }
	@RequestMapping(value="/toDelete.htm")
	public ModelAndView toDelete(HttpServletRequest request,@RequestParam Map<String, Object> params){
		String id = params.get("id").toString();
		ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("id", id);
        modelAndView.setViewName("html/ajax/modal-content/apothecary-delete-confirm");
		return modelAndView;
	}
	@RequestMapping(value="/delete.htm")
	@ResponseBody
    public Map<Object, Object> delete(HttpServletResponse response, HttpServletRequest request,String id){
		boolean success = true;
    	try {
    		userService.deleteUserSection(id);
		} catch (Exception e) {
			e.printStackTrace();
			success = false;
		}
    	Map<Object, Object> object = new HashMap<Object, Object>();
        object.put("success", success);
        return object;
    }
}
