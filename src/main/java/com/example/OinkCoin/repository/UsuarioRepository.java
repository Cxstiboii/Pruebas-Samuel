package com.example.OinkCoin.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.OinkCoin.model.Usuario;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Integer> {
    
    
    // Buscar usuario por email
    Usuario findByEmailUsuario(String emailUsuario);
    
    // Verificar si existe un email
    boolean existsByEmailUsuario(String emailUsuario);

}