package net.java_school.bank;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ShinhanBankDao implements BankDao {
    Logger logger = LoggerFactory.getLogger(ShinhanBankDao.class);
    
    static final String URL = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
    static final String USER = "scott";
    static final String PASSWORD = "tiger";

    //생성자에서 JDBC 드라이버 로딩
    public ShinhanBankDao() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }
    
    //커넥션 얻기
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
    
    //자원 반환
    private void close(ResultSet rs, PreparedStatement pstmt, Connection con) {
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
            
        if (pstmt != null) {
            try {
                pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    @Override
    public void insertAccount(String accountNo, String name, String kind) {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        String sql = "INSERT INTO bankaccount VALUES (?, ?, 0, ?)";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, accountNo);
            pstmt.setString(2, name);
            pstmt.setString(3, kind);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(null, pstmt, con);
        }
        
    }

    @Override
    public Account selectOneAccount(String accountNo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        Account account = null;
        
        String sql = "SELECT accountNo,owner,balance,kind " +
                "FROM bankaccount " +
                "WHERE accountNo = ?";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, accountNo);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                account = new Account();
                account.setAccountNo(rs.getString("accountNo"));
                account.setName(rs.getString("owner"));
                account.setBalance(rs.getLong("balance"));
                account.setKind(rs.getString("kind"));
                
                return account;
                
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, pstmt, con);
        }
        return null;
    }

    @Override
    public List<Account> selectAccountsByName(String name) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        List<Account> matched = new ArrayList<Account>();
        Account account = null;
        
        String sql = "SELECT accountNo,owner,balance,kind " +
                "FROM bankaccount " +
                "WHERE owner = ? " +
                "ORDER By accountNo DESC";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, name);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                account = new Account();
                account.setAccountNo(rs.getString("accountNo"));
                account.setName(rs.getString("owner"));
                account.setBalance(rs.getLong("balance"));
                account.setKind(rs.getString("kind"));
                matched.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, pstmt, con);
        }

        return matched;
    }

    @Override
    public List<Account> selectAllAccounts() {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        List<Account> all = new ArrayList<Account>();
        Account account = null;
        
        String sql = "SELECT accountNo,owner,balance,kind " +
                "FROM bankaccount " +
                "ORDER By accountNo DESC";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                account = new Account();
                account.setAccountNo(rs.getString("accountNo"));
                account.setName(rs.getString("owner"));
                account.setBalance(rs.getLong("balance"));
                account.setKind(rs.getString("kind"));
                all.add(account);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, pstmt, con);
        }

        return all;

    }

    @Override
    public void deposit(String accountNo, long amount) {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        String sql = "UPDATE bankaccount " +
                "SET balance = balance + ? " +
                "WHERE accountNo = ?";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, amount);
            pstmt.setString(2, accountNo);
            pstmt.executeUpdate();
            
            logger.debug("AccountNo:{} Amount:{} DEPOSIT/WITHDRAW:{}", 
                    accountNo, amount, Account.DEPOSIT);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(null, pstmt, con);
        }
        
    }

    @Override
    public void withdraw(String accountNo, long amount) {
        Connection con = null;
        PreparedStatement pstmt = null;
        
        String sql = "UPDATE bankaccount " +
                "SET balance = balance - ? " +
                "WHERE accountNo = ?";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setLong(1, amount);
            pstmt.setString(2, accountNo);
            pstmt.executeUpdate();
            
            logger.debug("AccountNo:{} Amount:{} DEPOSIT/WITHDRAW:{}", 
                    accountNo, amount, Account.DEPOSIT);

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(null, pstmt, con);
        }
        
    }

    @Override
    public List<Transaction> selectAllTransactions(String accountNo) {
        Connection con = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        List<Transaction> all = new ArrayList<Transaction>();
        Transaction transaction = null;
        
        String sql = "SELECT transactionDate,kind,amount,balance " +
                "FROM transaction " +
                "WHERE accountNo = ? " +
                "ORDER By transactionDate ASC";
        
        try {
            con = getConnection();
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, accountNo);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                transaction = new Transaction();
                String date = Account.DATE_FORMAT.format(rs.getTimestamp("transactionDate"));
                String time = Account.TIME_FORMAT.format(rs.getTimestamp("transactionDate"));
                transaction.setTransactionDate(date);
                transaction.setTransactionTime(time);
                transaction.setKind(rs.getString("kind"));
                transaction.setAmount(rs.getLong("amount"));
                transaction.setBalance(rs.getLong("balance"));
                all.add(transaction);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs, pstmt, con);
        }

        return all;

    }

}