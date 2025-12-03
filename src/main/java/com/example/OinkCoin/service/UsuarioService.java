package com.example.OinkCoin.service;

import java.util.Optional;

import com.example.OinkCoin.model.Usuario;

public interface UsuarioService {

    //Metodo para autenticar
    Optional<Usuario> autenticar(String email, String password);

    //Metodos auxiliares
    boolean existeEmail(String email);
    Usuario guardar(Usuario usuario);
    Optional<Usuario> findByEmail(String email);
    Optional<Usuario> findById(Integer idUsuario);
    void eliminarUsuario(Integer idUsuario);
}