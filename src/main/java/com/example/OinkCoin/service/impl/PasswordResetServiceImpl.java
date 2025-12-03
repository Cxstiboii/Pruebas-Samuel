package com.example.OinkCoin.service.impl;

import java.time.LocalDateTime;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.OinkCoin.model.PasswordResetToken;
import com.example.OinkCoin.model.Usuario;
import com.example.OinkCoin.repository.PasswordResetTokenRepository;
import com.example.OinkCoin.repository.UsuarioRepository;
import com.example.OinkCoin.service.EmailService;
import com.example.OinkCoin.service.PasswordResetService;

import jakarta.transaction.Transactional;

@Service
public class PasswordResetServiceImpl implements PasswordResetService {
    
    @Autowired
    private UsuarioRepository usuarioRepository;

    @Autowired
    private PasswordResetTokenRepository tokenRepository;

    @Autowired
    private EmailService emailService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    @Transactional
    public void crearTokenRecuperacion(String email){
        Usuario usuario = usuarioRepository.findByEmailUsuario(email);
        if (usuario == null) {
            throw new RuntimeException("Usuario no encontrado");
        }

        tokenRepository.deleteTokensByUsuario(usuario);

        String token = UUID.randomUUID().toString();

        PasswordResetToken resetToken = new PasswordResetToken();
        resetToken.setToken(token);
        resetToken.setUsuario(usuario);
        resetToken.setFechaExpiracion(LocalDateTime.now().plusMinutes(10));
        resetToken.setUsado(false);

        tokenRepository.save(resetToken);
        emailService.enviarEmailRecuperacion(email, token);
    }

    @Override
    public boolean validarToken(String token) {
        return tokenRepository.findByToken(token)
            .map(t -> !t.isExpired() && !t.getUsado())
            .orElse(false);
    }

    @Override
    @Transactional
    public void cambiarPassword(String token, String nuevaContraseña){
        PasswordResetToken resetToken = tokenRepository.findByToken(token)
            .orElseThrow(() -> new RuntimeException("Token inválido"));

        if(resetToken.isExpired()){
            throw new RuntimeException("Token expirado");
        }
        if(resetToken.getUsado()){
            throw new RuntimeException("Token ya usado");
        }

        Usuario usuario = resetToken.getUsuario();
        usuario.setPasswordUsuario(passwordEncoder.encode(nuevaContraseña));
        usuarioRepository.save(usuario);

        resetToken.setUsado(true);
        tokenRepository.save(resetToken);
    }
} 
