package net.java_school.commons;

public class PagingHelper {
    private int totalPage; // 총 페이지 수(마지막 페이지 번호)	
    private int firstPage; // 현재 블록의 첫 번째 페이지 번호
    private int lastPage; // 현재 블록의 마지막 페이지 번호
    private int prevPage; // [이전] 링크 페이지 번호
    private int nextPage; // [다음] 링크 페이지 번호
    private int listItemNo; // 목록 아이템 앞에 붙는, 프로그램적으로 계산된 번호
    private int startRecord; // 현재 페이지의 목록 쿼리에서 사용할 오라클 시작 ROWNUM
    private int endRecord; // 현재 페이지의 목록 쿼리에서 사용할 오라클 마지막 ROWNUM
    
    public PagingHelper(int totalRecord, int curPage, int numPerPage, int pagePerBlock) {
        //총 페이지 수
        this.totalPage = totalRecord / numPerPage;
        if (totalRecord % numPerPage != 0) this.totalPage++;
        
        //총 블록 수
        int totalBlock = totalPage / pagePerBlock;
        if (totalPage % pagePerBlock != 0) totalBlock++;
        
        //현재 블록
        int block = curPage / pagePerBlock;
        if (curPage % pagePerBlock != 0) block++;
        
        //현재 블록에 속한 첫 번째 페이지 번호와 마지막 페이지 번호
        firstPage = (block - 1) * pagePerBlock + 1;
        lastPage = block * pagePerBlock;
        
        //현재 블록이 1보다 크다면 [이전] 링크를 위한 페이지 번호 계산
        if (block > 1) {
            prevPage = firstPage - 1;
        }
        
        //현재 블록이 총 블록 수(마지막 블록 번호)보다 작다면 [다음] 링크를 위한 페이지 번호 계산 
        if (block < totalBlock) {
            nextPage = lastPage + 1;
        }
        
        //현재 블록이 마지막 블록이라면 현재 블록의 마지막 페이지 번호를 총 페이지 수로 변경
        if (block >= totalBlock) {
            lastPage = totalPage;
        }
        
        //현재 페이지의 목록 아이템 앞에 붙일 번호 계산
        listItemNo = totalRecord - (curPage - 1) * numPerPage;
        
        //현재 페이지의 목록을 위한 첫 번째 레코드 번호와 마지막 레코드 번호 계산
        startRecord = (curPage - 1) * numPerPage + 1;
        endRecord = curPage * numPerPage;
    }
    
    public int getTotalPage() {
        return totalPage;
    }

    public int getFirstPage() {
        return firstPage;
    }

    public int getLastPage() {
        return lastPage;
    }

    public int getPrevPage() {
        return prevPage;
    }

    public int getNextPage() {
        return nextPage;
    }

    public int getListItemNo() {
        return listItemNo;
    }

    public int getStartRecord() {
        return startRecord;
    }

    public int getEndRecord() {
        return endRecord;
    }

}
