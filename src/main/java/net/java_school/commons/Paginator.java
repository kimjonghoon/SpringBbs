package net.java_school.commons;

public class Paginator {

    public NumbersForPaging getNumbersForPaging(int totalRecord, int page, int numPerPage, int pagePerBlock) {
        int totalPage = totalRecord / numPerPage;
        if (totalRecord % numPerPage != 0) {
            totalPage++;
        }

        int totalBlock = totalPage / pagePerBlock;
        if (totalPage % pagePerBlock != 0) {
            totalBlock++;
        }

        int block = page / pagePerBlock;
        if (page % pagePerBlock != 0) {
            block++;
        }

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

        int listItemNo = totalRecord - (page - 1) * numPerPage;

        NumbersForPaging numbers = new NumbersForPaging();

        numbers.setTotalPage(totalPage);
        numbers.setFirstPage(firstPage);
        numbers.setLastPage(lastPage);
        numbers.setPrevBlock(prevPage);
        numbers.setNextBlock(nextPage);
        numbers.setListItemNo(listItemNo);
        numbers.setTotalPage(totalPage);

        return numbers;
    }

}
