package cn.edu.pdsu.bean;

/**
 * 开始结束也封装
 * 
 * @author 作者：user
 * @version 创建时间：2011-7-19 上午03:08:25
 */
public class PageIndex {
	/**
	 * 开始页
	 */
	private long startIndex;
	/**
	 * 结束页
	 */
	private long endIndex;

	public PageIndex(long startIndex, long endIndex) {
		this.startIndex = startIndex;
		this.endIndex = endIndex;
	}

	public long getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(long startIndex) {
		this.startIndex = startIndex;
	}

	public long getEndIndex() {
		return endIndex;
	}

	public void setEndIndex(long endIndex) {
		this.endIndex = endIndex;
	}

	/**
	 * 计算开始页和结束页
	 * 
	 * @param viewpagecount
	 *            页面中要显示的页面数
	 * @param currentPage
	 *            当前第几页
	 * @param totalpage
	 *            总的页数
	 * @return PageIndex 记录开始页（startindex）和结束页（endindex）
	 */
	public static PageIndex getPageIndex(long viewpagecount, int currentPage,
			long totalpage) {
		long startpage = currentPage
				- (viewpagecount % 2 == 0 ? viewpagecount / 2 - 1
						: viewpagecount / 2);
		long endpage = currentPage + viewpagecount / 2;
		if (startpage < 1) {
			startpage = 1;
			if (totalpage >= viewpagecount)
				endpage = viewpagecount;
			else
				endpage = totalpage;
		}
		if (endpage > totalpage) {
			endpage = totalpage;
			if ((endpage - viewpagecount) > 0)
				startpage = endpage - viewpagecount + 1;
			else
				startpage = 1;
		}
		return new PageIndex(startpage, endpage);
	}
}
