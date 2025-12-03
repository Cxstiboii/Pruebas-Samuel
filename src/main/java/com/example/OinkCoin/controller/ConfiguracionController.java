package com.example.OinkCoin.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.OinkCoin.model.Usuario;
import com.example.OinkCoin.service.UsuarioService;

import jakarta.servlet.http.HttpSession;

@Controller

public class ConfiguracionController {

    @Autowired
    private UsuarioService usuarioService;

    @GetMapping("/configuracion")
    public String mostrarConfiguracion(HttpSession session, Model model) {
        Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
        
        if (usuario == null) {
            return "redirect:/login";
        }
        
        model.addAttribute("usuario", usuario);
        model.addAttribute("nombreUsuario", usuario.getNombreUsuario());
        model.addAttribute("emailUsuario", usuario.getEmailUsuario());
        model.addAttribute("fotoPerfil", usuario.getFotoPerfil());
        model.addAttribute("idUsuario", usuario.getIdUsuario());
        model.addAttribute("fechaRegistro", usuario.getFechaRegistro());
        
        return "configuracionPrincipal";
    }

    @PostMapping("/actualizar")
    public String actualizarPerfil(
            @RequestParam("nombreUsuario") String nombreUsuario,
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
            
            if (usuario == null) {
                return "redirect:/login";
            }
            
            usuario.setNombreUsuario(nombreUsuario);
            usuarioService.guardar(usuario);
            
            session.setAttribute("usuarioLogueado", usuario);
            session.setAttribute("nombreUsuario", nombreUsuario);
            
            redirectAttributes.addFlashAttribute("mensaje", 
                "✅ Perfil actualizado correctamente");
            redirectAttributes.addFlashAttribute("tipoMensaje", "success");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "❌ Error al actualizar el perfil: " + e.getMessage());
        }
        
        return "redirect:/configuracion"; // ✅ CAMBIADO
    }

    @PostMapping("/eliminar-cuenta")
    public String eliminarCuenta(
            HttpSession session,
            RedirectAttributes redirectAttributes) {
        
        try {
            Usuario usuario = (Usuario) session.getAttribute("usuarioLogueado");
            
            if (usuario == null) {
                return "redirect:/login";
            }
            
            String nombreUsuario = usuario.getNombreUsuario();
            Integer idUsuario = usuario.getIdUsuario();
            
            usuarioService.eliminarUsuario(idUsuario);
            session.invalidate();
            
            redirectAttributes.addFlashAttribute("mensaje", 
                "👋 Tu cuenta ha sido eliminada exitosamente, " + nombreUsuario + ". ¡Esperamos verte pronto!");
            redirectAttributes.addFlashAttribute("tipoMensaje", "success");
            
            return "redirect:/login";
            
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", 
                "❌ Error al eliminar la cuenta: " + e.getMessage());
            return "redirect:/configuracion"; // ✅ CAMBIADO
        }
    }
}