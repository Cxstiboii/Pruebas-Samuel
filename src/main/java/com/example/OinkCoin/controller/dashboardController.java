package com.example.OinkCoin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.example.OinkCoin.model.Usuario;

import jakarta.servlet.http.HttpSession;

@Controller
public class dashboardController {

    @GetMapping("/dashboardPrincipal")
    public String mostrarDashboard(HttpSession session, Model model) {
        
        // Verificar si hay una sesión válida
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        
        // Si no hay usuario, redirigir al login
        if (usuario == null) {
            return "redirect:/login";
        }
        
        // Pasar todos los datos del usuario al modelo
        model.addAttribute("usuario", usuario);
        model.addAttribute("nombreUsuario", session.getAttribute("nombreUsuario"));
        model.addAttribute("emailUsuario", session.getAttribute("emailUsuario"));
        model.addAttribute("fotoPerfil", session.getAttribute("fotoPerfil"));
        model.addAttribute("idUsuario", session.getAttribute("idUsuario"));
        
        return "dashboardPrincipal";
    }
}