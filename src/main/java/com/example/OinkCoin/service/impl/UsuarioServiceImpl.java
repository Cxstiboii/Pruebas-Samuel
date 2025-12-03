package com.example.OinkCoin.service.impl;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.OinkCoin.model.Usuario;
import com.example.OinkCoin.repository.UsuarioRepository;
import com.example.OinkCoin.service.UsuarioService;

@Service
@Transactional
public class UsuarioServiceImpl implements UsuarioService {

    @Autowired
    private UsuarioRepository usuarioRepository;

    @Override
    public Optional<Usuario> autenticar(String email, String password) {
        // 1. Buscar usuario por email
        Usuario usuario = usuarioRepository.findByEmailUsuario(email);
        
        // 2. Verificar si existe y si la contraseña coincide
        if (usuario != null && usuario.getPasswordUsuario().equals(password)) {
            return Optional.of(usuario);
        }
        
        return Optional.empty();
    }

    @Override
    public boolean existeEmail(String email) {
        return usuarioRepository.findByEmailUsuario(email) != null;
    }

    @Override
    public Usuario guardar(Usuario usuario) {
        return usuarioRepository.save(usuario);
    }

    @Override
    public Optional<Usuario> findByEmail(String email) {
        return Optional.ofNullable(usuarioRepository.findByEmailUsuario(email));
    }

    @Override
    public Optional<Usuario> findById(Integer idUsuario) {
        return usuarioRepository.findById(idUsuario);
    }

    @Override
    public void eliminarUsuario(Integer idUsuario) {
        if (usuarioRepository.existsById(idUsuario)) {
            usuarioRepository.deleteById(idUsuario);
        } else {
            throw new RuntimeException("Usuario no encontrado");
        }
    }
}