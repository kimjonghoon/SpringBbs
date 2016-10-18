package net.java_school.commons;

public class Paginator {

	public NumbersForPagingProcess getNumbersForPaging(int totalRecord, int curPage, int numPerPage, int pagePerBlock) {
		int totalPage = totalRecord / numPerPage;
		if (totalRecord % numPerPage != 0) totalPage++;
		int totalBlock = totalPage / pagePerBlock;
		if (totalPage % pagePerBlock != 0) totalBlock++;
		int block = curPage / pagePerBlock;
		if (curPage % pagePerBlock != 0) block++;
		int firstPage = (block - 1) * pagePerBlock + 1;
		int lastPage = block * pagePerBlock;
		int prevPage = 0;
		if (block > 1) {
			prevPage = firstPage - 1;
		}
		int nextPage = 0;
		if (block < totalBlock) {
			nextPage = lastPage + 1;
		}
		if (block >= totalBlock) {
			lastPage = totalPage;
		}
		int listItemNo = totalRecord - (curPage - 1) * numPerPage;
		int startRecord = (curPage - 1) * numPerPage + 1;
		int endRecord = curPage * numPerPage;
		
		NumbersForPagingProcess numbers = new NumbersForPagingProcess();
		
		numbers.setTotalPage(totalPage);
		numbers.setFirstPage(firstPage);
		numbers.setLastPage(lastPage);
		numbers.setPrevBlock(prevPage);
		numbers.setNextBlock(nextPage);
		numbers.setListItemNo(listItemNo);
		numbers.setStartRecord(startRecord);
		numbers.setEndRecord(endRecord);
		
		return numbers;
	}

}
