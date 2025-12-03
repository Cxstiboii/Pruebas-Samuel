package com.example.OinkCoin.controller;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.OinkCoin.model.Usuario;
import com.example.OinkCoin.service.PasswordResetService;
import com.example.OinkCoin.service.UsuarioService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private PasswordResetService passwordResetService;
    
    @Autowired
    private UsuarioService usuarioService;

    // ============== RUTAS PRINCIPALES ==============
    
    @GetMapping("/")
    public String inicio() {
        return "redirect:/index";
    }

    @GetMapping("/index")
    public String mostrarLandingPage() {
        return "index";
    }

    // ============== LOGIN ==============
    
    @GetMapping("/login")
    public String mostrarLogin(HttpSession session) {
        // Si ya hay una sesión activa, redirigir al dashboard
        if (session.getAttribute("usuarioLogueado") != null) {
            return "redirect:/dashboardPrincipal";
        }
        return "login";
    }

    @PostMapping("/login")
    public String procesarLogin(
        @RequestParam("email") String email,
        @RequestParam("password") String password,
        HttpSession session,
        RedirectAttributes redirectAttributes) {
        
        try {
            Optional<Usuario> usuarioOpt = usuarioService.autenticar(email, password);

            if (usuarioOpt.isPresent()) {
                Usuario usuario = usuarioOpt.get();
                
                // Guardar todos los datos del usuario en la sesión
                session.setAttribute("usuarioLogueado", usuario);
                session.setAttribute("idUsuario", usuario.getIdUsuario());
                session.setAttribute("nombreUsuario", usuario.getNombreUsuario());
                session.setAttribute("emailUsuario", usuario.getEmailUsuario());
                session.setAttribute("fotoPerfil", usuario.getFotoPerfil());

                redirectAttributes.addFlashAttribute("mensaje", "¡Bienvenido " + usuario.getNombreUsuario() + "!");
                redirectAttributes.addFlashAttribute("tipoMensaje", "success");

                return "redirect:/dashboardPrincipal";
            } else {
                redirectAttributes.addFlashAttribute("error", "Email o contraseña incorrectos");
                return "redirect:/login";
            }
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Error al iniciar sesión: " + e.getMessage());
            return "redirect:/login";
        }
    }

    // ============== RECUPERAR CONTRASEÑA ==============
    
    @GetMapping("/login/olvidarContraseña")
    public String mostrarOlvidarContraseña() {
        return "olvidarContraseña";
    }

    @PostMapping("/login/olvidarContraseña")
    public String procesarOlvideContraseña(
        @RequestParam("email") String email,
        RedirectAttributes redirectAttributes) {
            
        try {
            passwordResetService.crearTokenRecuperacion(email);
            
            redirectAttributes.addFlashAttribute("mensaje", 
                " Si el correo existe en nuestro sistema, recibirás un enlace para restablecer tu contraseña");
            redirectAttributes.addFlashAttribute("tipoMensaje", "success");
            
            return "redirect:/login";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("mensaje", 
                " Si el correo existe en nuestro sistema, recibirás un enlace para restablecer tu contraseña");
            redirectAttributes.addFlashAttribute("tipoMensaje", "success");
            
            return "redirect:/login";
        }
    }

    // ============== RESTABLECER CONTRASEÑA (CON TOKEN) ==============
    
    @GetMapping("/login/reset-password")
    public String mostrarFormularioResetContraseña(
        @RequestParam("token") String token,
        Model model,
        RedirectAttributes redirectAttributes) {
        
        if (!passwordResetService.validarToken(token)) {
            redirectAttributes.addFlashAttribute("error", 
                " El enlace es inválido o ha expirado. Solicita uno nuevo.");
            redirectAttributes.addFlashAttribute("tipoMensaje", "error");
            return "redirect:/login/olvidarContraseña";
        }
        
        model.addAttribute("token", token);
        return "resetPassword";
    }

    @PostMapping("/login/reset-password")
    public String procesarResetContraseña(
        @RequestParam("token") String token,
        @RequestParam("password") String password,
        @RequestParam("confirmPassword") String confirmPassword,
        RedirectAttributes redirectAttributes) {
        
        if (!password.equals(confirmPassword)) {
            redirectAttributes.addFlashAttribute("error", 
                " Las contraseñas no coinciden");
            redirectAttributes.addFlashAttribute("tipoMensaje", "error");
            return "redirect:/login/reset-password?token=" + token;
        }
        
        if (password.length() < 8) {
            redirectAttributes.addFlashAttribute("error", 
                " La contraseña debe tener al menos 8 caracteres");
            redirectAttributes.addFlashAttribute("tipoMensaje", "error");
            return "redirect:/login/reset-password?token=" + token;
        }
        
        try {
            passwordResetService.cambiarPassword(token, password);
            
            redirectAttributes.addFlashAttribute("mensaje", 
                " Contraseña actualizada exitosamente. Ahora puedes iniciar sesión");
            redirectAttributes.addFlashAttribute("tipoMensaje", "success");
            
            return "redirect:/login";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                " Error: " + e.getMessage());
            redirectAttributes.addFlashAttribute("tipoMensaje", "error");
            return "redirect:/login/reset-password?token=" + token;
        }
    }

    // ============== LOGOUT MEJORADO ==============
    
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        // Verificar si hay una sesión activa
        if (session.getAttribute("usuarioLogueado") != null) {
            String nombreUsuario = (String) session.getAttribute("nombreUsuario");
            
            // Invalidar completamente la sesión
            session.invalidate();
            
            // Mensaje de despedida
            redirectAttributes.addFlashAttribute("mensaje", 
                "👋 Hasta pronto, " + nombreUsuario + ". Sesión cerrada correctamente");
            redirectAttributes.addFlashAttribute("tipoMensaje", "success");
        }
        
        return "redirect:/login";
    }
    
    @PostMapping("/logout")
    public String logoutPost(HttpSession session, RedirectAttributes redirectAttributes) {
        return logout(session, redirectAttributes);
    }
}