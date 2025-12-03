package com.example.OinkCoin.config;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class SessionInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        String requestURI = request.getRequestURI();
        
        // Rutas públicas que no requieren autenticación
        String[] publicRoutes = {
            "/", 
            "/index", 
            "/login", 
            "/registro",
            "/login/olvidarContraseña",
            "/login/reset-password",
            "/css/",
            "/js/",
            "/images/",
            "/error"
        };
        
        // Verificar si la ruta es pública
        for (String publicRoute : publicRoutes) {
            if (requestURI.startsWith(publicRoute)) {
                return true;
            }
        }
        
        // Verificar si hay sesión activa
        if (session == null || session.getAttribute("usuarioLogueado") == null) {
            // Crear una nueva sesión temporal solo para el mensaje
            HttpSession newSession = request.getSession(true);
            newSession.setAttribute("error", "⚠️ Debes iniciar sesión para acceder a esta página");
            
            // No hay sesión, redirigir al login
            response.sendRedirect("/login");
            return false;
        }
        
        // Hay sesión activa, permitir acceso
        return true;
    }
}