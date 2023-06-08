package web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;

import org.apache.tomcat.util.http.fileupload.IOUtils;

import dao.BoardDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vo.Board;
import vo.Customer;
/*
 * @MultipartConfig
 * 	- 서블릿이 enctype="multipart/form-data" 요청을 처리하도록 지원한다.
 * 	- 주요속성값 
 * 		fileSizeThreshold : 파일 업로드 시에 메모리에 저장되는 임시 파일 크기 지정
 * 		maxFileSize : 업로드할 파일의 최대 크기 지정
 * 		maxRequestSize : 요청시의 최대 크기 지정
 * 		location - 파일 업로드시에 임시저장 디렉토리 지정 
 */
@MultipartConfig(fileSizeThreshold =1024*1024*10, maxFileSize =1024*1024*50,maxRequestSize =1024*1024*100)
@WebServlet(urlPatterns = "/board/insert")
public class BoardInsertServlet extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 세션에서 로그인된 고객아이디 조회
		HttpSession session = req.getSession(false);
		String loginId = (String) session.getAttribute("loginId");
		if(loginId ==null) {
			resp.sendRedirect("../loginform.jsp?err=req&job=" + URLEncoder.encode("게시글등록","utf-8"));
			return;
		}
		// getSession(true)일 때 
			// 요청객체에 세션아이디가 있으면 세션아이디와 일치하는 세션객체가 존재하면 그 세션객체를 찾아서 반환한다.
		    // 세션아이디와 일치하는 세션객체가 존재하지 않으면 새로운 세션객체를 새로 생성해서 반환한다.
			// 디폴트 값은 true이다. 
		// getSession(false)일 때
			// 요청 객체에 세션아이디가 없으면 null을 반환한다.
			// 요청객체에 세션아이디가 있으면 세션아이디와 일치하는 세션객체가 존재하면 그 세션객체를 찾아서 반환한다.
			// 세션아이디와 일치하는 세션객체가 존재하지 않으면 null을 반환한다.
		
		// 요청 파라미터 조회
		
		// 일반 입력필드의 값 조회 
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		// 첨부파일 입력필드의 처리 
		Part upfilePart = req.getPart("upfile");
		String filename= null;
		if(!upfilePart.getSubmittedFileName().isEmpty()) {
			filename = System.currentTimeMillis()+ upfilePart.getSubmittedFileName();
		
		// 업로드된 첨부파일을 지정된 폴더에 저장 
		InputStream in = upfilePart.getInputStream();
		OutputStream out = new FileOutputStream(new File("/Users/howlpang/java-workspace/files", filename));
		IOUtils.copy(in,out);
		}
		//String contentType = upfilePart.getContentType();
		//long size = upfilePart.getSize();
		
		
		System.out.println("첨부파일명 : "+filename);
		//System.out.println("첨부파일타입 :"+contentType);
		//System.out.println("첨부파일크기: "+size);
		
		System.out.println("제목 :" + title);
		System.out.println("내용 :" + content);
		//업무로직 수행
		Board board = new Board();
		board.setTitle(title);
		board.setContent(content);
		board.setCustomer(new Customer(loginId));
		board.setFilename(filename);
		
		BoardDao boardDao = new BoardDao();
		boardDao.insertBoard(board);
		
		//재요청 URL 응답
		resp.sendRedirect("list.jsp");
	}
	
}
