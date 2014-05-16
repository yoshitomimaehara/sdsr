package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entity.Usuario;
import model.LoginModel;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginIngreso")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String paginaDestino = "panel.jsp";
		try {
			// Datos
			String user1 = request.getParameter("user");
			String pass1 = request.getParameter("pass");
			// Proceso
			LoginModel model = new LoginModel();
			Usuario usu1 = model.validar(user1, pass1);
			// Guardar dato en sesión
			HttpSession session = request.getSession(true);
			session.setAttribute("usuario", usu1);
		} catch (Exception e) {
			request.setAttribute("error", e.getMessage());
			paginaDestino = "index.jsp";
		}
		RequestDispatcher rd = request.getRequestDispatcher(paginaDestino);
		rd.forward(request, response);
	}

}
