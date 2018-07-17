package org.beiyi.controller.base;

import java.util.List;

public class Pagination<T> {
	/** 每页显示条数 */  
    private Integer pageSize = 10;  
  
    /** 当前页 */  
    private Integer currentPage = 1;  
  
    /** 总页数 */  
    private Integer totalPage = 1;  
  
    /** 查询到的总数据量 */  
    private Integer totalNumber = 0;  
  
    /** 数据集 */  
    private List items;  
  
    
    /** 
     * 处理查询后的结果数据 
     *  
     * @param items 
     *            查询结果集 
     * @param count 
     *            总数 
     */  
    public void build(List items) {  
        this.setItems(items);  
        int count =  this.getTotalNumber();  
        int divisor = count / this.getPageSize();  
        int remainder = count % this.getPageSize();  
        this.setTotalPage(remainder == 0 ? divisor == 0 ? 1 : divisor : divisor + 1);  
    }

    

	public Integer getCurrentPage() {
		return currentPage;
	}


	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}


	public Integer getTotalPage() {
		return totalPage;
	}


	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}


	public Integer getTotalNumber() {
		return totalNumber;
	}


	public void setTotalNumber(Integer totalNumber) {
		this.totalNumber = totalNumber;
	}


	public List getItems() {
		return items;
	}


	public void setItems(List items) {
		this.items = items;
	}

	public Integer getPageSize() {  
		  
        return pageSize;  
    }

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}  
    
}