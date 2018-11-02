package net.java_school.commons;

public class NumbersForPaging {

    private int totalPage;
    private int firstPage;
    private int lastPage;
    private int prevBlock;
    private int nextBlock;
    private int listItemNo;

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getFirstPage() {
        return firstPage;
    }

    public void setFirstPage(int firstPage) {
        this.firstPage = firstPage;
    }

    public int getLastPage() {
        return lastPage;
    }

    public void setLastPage(int lastPage) {
        this.lastPage = lastPage;
    }

    public int getPrevBlock() {
        return prevBlock;
    }

    public void setPrevBlock(int prevBlock) {
        this.prevBlock = prevBlock;
    }

    public int getNextBlock() {
        return nextBlock;
    }

    public void setNextBlock(int nextBlock) {
        this.nextBlock = nextBlock;
    }

    public int getListItemNo() {
        return listItemNo;
    }

    public void setListItemNo(int listItemNo) {
        this.listItemNo = listItemNo;
    }

}
