package com.hanul.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.hanul.board.BoardDAO;
import com.hanul.board.BoardDTO;
import com.hanul.page.RowNumber;
import com.hanul.util.DBConnector;

public class NoticeDAO implements BoardDAO {

	@Override
	public BoardDTO selectOne(int num) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<BoardDTO> selectList(RowNumber rowNumber) throws Exception {
		Connection con = DBConnector.getConnect();
		String sql = "SELECT * FROM "
				+ "(select rownum R, N.* from "
				+ "(select no, subject, writer, reg_date, hit from notice "
				+ "where "+rowNumber.getSearch().getKind()+" like ? "
				+ "order by no desc) N) "
				+ "where R between ? and ?";
		PreparedStatement st = con.prepareStatement(sql);
		
		st.setString(1, "%"+rowNumber.getSearch().getSearch()+"%");
		st.setInt(2, rowNumber.getStartRow());
		st.setInt(3, rowNumber.getLastRow());
		
		ResultSet rs = st.executeQuery();
		BoardDTO nDto = null;
		ArrayList<BoardDTO> ar = new ArrayList<>();
		while(rs.next()) {
			nDto = new NoticeDTO();
			nDto.setNum(rs.getInt("no"));
			nDto.setTitle(rs.getString("subject"));
			nDto.setWriter(rs.getString("writer"));
			nDto.setReg_date(rs.getDate("reg_date"));
			nDto.setHit(rs.getInt("hit"));
			ar.add(nDto);
		}
		DBConnector.disConnect(rs, st, con);
		return ar;
	}

	@Override
	public int insert(BoardDTO boardDTO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(BoardDTO boardDTO) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(int num) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int getCount(String kind, String search) throws Exception {
		Connection con = DBConnector.getConnect();
		String sql="select count(no) from notice "
				+ "where "+kind+" like ?";
		
		PreparedStatement st = con.prepareStatement(sql);
		st.setString(1, "%"+search+"%");
		
		ResultSet rs = st.executeQuery();
		rs.next();
		int result=rs.getInt(1);
		
		DBConnector.disConnect(rs, st, con);
		
		return result;
	}
	
	
	
}
