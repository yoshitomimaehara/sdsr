package model;

import dao.LoginDao;
import dao.MensajeDao;
import interfaces.IAlumnoDao;
import interfaces.ILoginDao;
import entity.Usuario;

public class LoginModel {
	public Usuario validar(String user, String pass) {
		Usuario usu;
		ILoginDao dao = new LoginDao();
		usu = dao.validarlogin(user);
		MensajeDao men = new MensajeDao();
		if(usu == null){
			throw new RuntimeException(men.getMensaje("000001"));
		}
		if(!usu.getContrasenia().equals(pass)){
			throw new RuntimeException(men.getMensaje("000002"));
		}
		return usu;
	}
	
	
}
